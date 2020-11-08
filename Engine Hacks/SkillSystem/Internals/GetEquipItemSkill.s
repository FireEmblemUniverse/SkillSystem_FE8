.thumb

.macro _blh to, reg=r3
	ldr \reg, =\to
	mov lr, \reg
	.short 0xF800
.endm

.macro _blr reg
	mov lr, \reg
	.short 0xF800
.endm

.equ ISB_SkillList, 0x0
.equ ISB_SkillCount, 0x6
.equ ISB_WeaponSkill, 0x7
.equ ISB_UnitPoin, 0x8

@ItemSkillBuffer layout
@bytes	purpose
@0-5	item skill list
@6  	skill count
@7  	equipped weapon's skill
@8-11	unit pointer

.equ RefreshEquip, 0xFF

.set BattleActingUnit, 0x0203A4EC @attacker
.set BattleTargetUnit, 0x0203A56C @defender

.set GetEquippedItem, 0x08016B28

.equ GetItemSkillList, OffsetList + 0x0
.equ IsItemSkillPassive, OffsetList + 0x4
.equ GetItemSkill, OffsetList + 0x8

GetEquipItemSkill:
@arguments:
	@r0 = unit pointer
@returns:
	@r0 = equipped item skill id

push 	{r4-r6,lr}
mov 	r4,r0

ldr 	r3, GetItemSkillList
_blr r3
@bl GetItemSkillList
mov 	r6, r0

@check if equipped item's skill is already in the buffer
ldrb 	r0, [r6,#ISB_WeaponSkill]
mov 	r1, #RefreshEquip
cmp r0,r1
bne return

mov 	r0,r4
ldr 	r1, =BattleActingUnit
cmp 	r0,r1
beq battle_struct_unit
ldr 	r1, =BattleTargetUnit
cmp 	r0,r1
beq battle_struct_unit

_blh GetEquippedItem @get the equipped weapon
b equipped_item_skill

battle_struct_unit:
@the attacker and defender structs already have the
@ equipped weapon so we just take it from there
mov 	r0, #0x48
add 	r0, r0, r4
ldrh 	r0, [r0] @get the equipped weapon

equipped_item_skill:
mov 	r5, r0
cmp 	r0, #0x0
@return 0 if no equipped item is found
beq skip_skill

ldr 	r3, IsItemSkillPassive
_blr r3
@bl IsItemSkillPassive
mov 	r1, r0
mov 	r0, #0x0
cmp 	r1, #0x0
@return 0 if weapon has a passive skill
@because the skill should already be in the buffer
bne skip_skill
mov 	r0,r5
ldr r3, GetItemSkill
_blr r3
@bl GetItemSkill
skip_skill:
strb 	r0, [r6,#ISB_WeaponSkill]
return:
pop 	{r4-r6}
pop 	{r3}
bx r3
.align
.ltorg
OffsetList:
@POIN GetItemSkillList
@POIN IsItemSkillPassive
@POIN GetItemSkill
