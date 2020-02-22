.thumb
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

.global ResetItemSkills
.type ResetItemSkills, %function
ResetItemSkills:
@arguments:
	@r0 = unit pointer
@Set item skill buffer to be rebuilt on next GetItemSkillList
push 	{lr}
bl GetItemSkillBuffer
mov 	r1, #0x0
str 	r1, [r0,#ISB_UnitPoin]
pop 	{r3}
bx r3
.ltorg
.align

.global ResetEquipItemSkill
.type ResetEquipItemSkill, %function

.equ RefreshEquip, 0xFF

ResetEquipItemSkill:
@arguments:
	@r0 = unit pointer
@Set equip item skill to be rebuilt 
@on next GetEquipItemSkill
push 	{lr}
bl GetItemSkillBuffer
mov 	r1, #RefreshEquip	@change to ldr #0xFFFF if we ever do halfword skills
strb 	r1, [r0,#ISB_WeaponSkill]
pop 	{r3}
bx r3
.ltorg
.align

.global GetItemSkillBuffer
.type GetItemSkillBuffer, %function
GetItemSkillBuffer:
@arguments:
	@r0 = unit pointer
@returns:
	@r0 = itemskillbuffer

@putting this in a seperate routine
@just in case we ever do multiple buffers
ldr r0, ItemSkillBuffer
bx lr
.align
.ltorg
ItemSkillBuffer:
