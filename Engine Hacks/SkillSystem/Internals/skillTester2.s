@ SkillTester - given ram data in r0 and skill number in r1, returns 1 for true or 0 for false
@ calls skill getter and checks if skill is in the list
@ skill 0 is always true, skill FF is always false.

@ This version skips the check for equippable weapons to avoid causing an endless loop

.thumb

.set GetUnitEquippedItem, 0x8016B28
.set GetUnitEquippedItemSlot, 0x8016B58
@.set ItemTable, SkillGetter+0x04

.macro _blr reg
	mov lr, \reg
	.short 0xF800
.endm

.equ PItemSkills, SkillGetter + 0x4

@arguments:
	@r0 = unit data
	@r1 = skill id
@returns:
	@r0 = true/false

push {r4-r5,lr}
@r0 has unit data
mov r5, r0
cmp r1, #0
beq True
cmp r1, #0xFF
beq False

mov r4, r1 @skill to test
@bl Skill_Getter
ldr r1, SkillGetter
_blr r1
@mov lr, r1
@.short 0xf800

@now r0 is the buffer to loop through
Loop:
ldrb r1, [r0]
cmp r1, #0 @list is over, now test if the equipped item has a skill
beq TestPassiveItems
cmp r1, r4
beq True
add r0, #1
b Loop

TestPassiveItems:
mov r0,r5
ldr r3, PItemSkills
_blr r3
@now r0 is the buffer to loop through
ItemLoop:
ldrb r1, [r0]
cmp r1, #0 @list is over, now test if the equipped item has a skill
beq False
cmp r1, r4
beq True
add r0, #1
b ItemLoop

@We don't check for the equipped weapon here

False:
mov r0, #0
pop {r4-r5, pc}

True:
mov r0, #1
pop {r4-r5, pc}

.pool

SkillGetter:
@POIN SkillGetter
@POIN GetItemSkillList
