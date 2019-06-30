@ SkillTester - given ram data in r0 and skill number in r1, returns 1 for true or 0 for false
@ calls skill getter and checks if skill is in the list
@ skill 0 is always true, skill FF is always false.

@TODO: also check inventory for skill items?

.thumb

push {r4,lr}
@r0 has unit data
cmp r1, #0
beq True
cmp r1, #0xFF
beq False

mov r4, r1 @skill to test
ldr r1, SkillGetter
mov lr, r1
.short 0xf800
@now r0 is the buffer to loop through
Loop:
ldrb r1, [r0]
cmp r1, #0
beq False
cmp r1, r4
beq True
add r0, #1
b Loop

True:
mov r0, #1
pop {r4,pc}

False:
mov r0, #0
pop {r4,pc}

SkillGetter:
@POIN SkillGetter
