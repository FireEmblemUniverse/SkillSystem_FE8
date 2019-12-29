@ SkillTester - given ram data in r0 and skill number in r1, returns 1 for true or 0 for false
@ calls skill getter and checks if skill is in the list
@ skill 0 is always true, skill FF is always false.

@ This version skips the check for equippable weapons to avoid causing an endless loop

.thumb

.set GetUnitEquippedItem, 0x8016B28
.set GetUnitEquippedItemSlot, 0x8016B58
@.set ItemTable, SkillGetter+0x04

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
bl Skill_Getter
@ldr r1, SkillGetter
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
mov r1,r4
@mov r2,r6
mov r2, #0x1
neg r2, r2
bl SkillItemCounter
@return true if the skill was found at least once on a passive skill item
cmp r0, #0x0
bne True

False:
mov r0, #0
pop {r4-r5, pc}

True:
mov r0, #1
pop {r4-r5, pc}

.pool

