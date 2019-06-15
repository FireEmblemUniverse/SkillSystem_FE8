.thumb
.equ NaturalCoverID, SkillTester+4

push {r4-r7, lr}
mov r4, r0 @atkr
mov r5, r1 @dfdr

@tile has no bonuses
mov r1, #0x56
ldrb r0, [r4,r1] @terrain def
cmp r0, #0
bne CheckSkill
add r1, #1
ldrb r0, [r4,r1] @terrain avo
cmp r0, #0
bne CheckSkill
add r1, #1
ldrb r0, [r4,r1] @terrain res
cmp r0, #0
beq End

CheckSkill:
@has NaturalCover
ldr r0, SkillTester
mov lr, r0
mov r0, r4 @defender data
ldr r1, NaturalCoverID
.short 0xf800
cmp r0, #0
beq End

@sub 3 damage
@ mov r1, #0x5a
@ ldrh r0, [r5, r1] @atk
@ sub r0, #3
@ cmp r0, #0
@ bge NotMin
@ mov r0, #0 @in case negative?
@ NotMin:
@ strh r0, [r5,r1]

mov r1, #0x5c
ldrsh r0, [r4, r1] @atk
add r0, #3
strh r0, [r4,r1]

End:
pop {r4-r7, r15}
.align
.ltorg
SkillTester:
@Poin SkillTester
@WORD NaturalCoverID
