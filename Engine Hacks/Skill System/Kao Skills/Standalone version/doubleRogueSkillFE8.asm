.thumb

.equ LockTouchID, SkillTester+4

@Check for TouchLock Skill 


push {r3, r4}
mov r3, #0x00
Loop:
ldr r4, ClassList
ldrb r4, [r4, r3]
cmp r4, #0x00
beq NoPickSkill
cmp r4, r0
bne NextIteration
b PickSkill

NoPickSkill:
pop {r3, r4}
ldr r3, NoPickSkillBranch
bx r3
PickSkill:
pop {r3, r4}
ldr r3, PickSkillBranch
bx r3
NextIteration:
add r3, #0x01
b Loop

.align
PickSkillBranch:
.long 0x8023E9D
NoPickSkillBranch:
.long 0x8023E95
.ltorg
ClassList:
@list of the classes you give access to PickSkill
