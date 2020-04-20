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

@.equ ItemSkillBuffer, address

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

.equ GetItemSkillBuffer, OffsetList + 0x0
.equ GetItemPassiveSkill, OffsetList + 0x4
.equ ResetEquipItemSkill, OffsetList + 0x8

@arguments:
	@r0 = unit pointer
@returns:
	@r0 = itemskillbuffer

GetItemSkillList:
push 	{r4-r7,lr}
mov 	r4, r0

@get the offset of the buffer
ldr r3, GetItemSkillBuffer
_blr r3
@bl GetItemSkillBuffer

@ldr 	r0, ItemSkillBuffer
mov 	r5,r0
@
ldr 	r1, [r5,#ISB_UnitPoin]
cmp 	r1, r4
beq end

build_buffer:
@loop through unit's inventory for passive skill items
mov 	r6, #0x0
mov 	r7, #0x0
skill_item_loop:
mov r0, #0x1E
add 	r0,r0,r6
ldrh 	r0, [r4,r0]
cmp 	r0,#0x0 	@check if unit has any more items
beq skill_item_loop_end
ldr r3, GetItemPassiveSkill
_blr r3
@bl GetItemPassiveSkill
cmp 	r0,#0x0
beq reloop
add 	r1,r5,r7
strb 	r0, [r1]
add 	r7, #0x1
reloop:
add 	r6, #0x2
cmp 	r6, #0x8
bls skill_item_loop
skill_item_loop_end:
mov 	r0, #0x0
add 	r1,r5,r7
strb 	r0, [r1]

mov 	r0,r7
strb 	r0,[r5,#ISB_SkillCount]
str 	r4, [r5,#ISB_UnitPoin]

@set weapon skill to be refreshed
mov 	r0, r4
ldr 	r3, ResetEquipItemSkill
_blr r3
@mov 	r1, #0xFF
@strb 	r1, [r5,#ISB_WeaponSkill]

end:
mov 	r0,r5
ldrb 	r1, [r0,#ISB_SkillCount]
pop 	{r4-r7}
pop 	{r3}
bx r3
.align
.ltorg
OffsetList:
@GetItemSkillBuffer
@GetItemPassiveSkill
@ResetEquipItemSkill

