.thumb
.equ LifeAndDeathID, SkillTester+4

push {r4-r7, lr}
mov r4, r0 @atkr
mov r5, r1 @dfdr

@has LifeAndDeath
ldr r0, SkillTester
mov lr, r0
mov r0, r4 @attacker data
ldr r1, LifeAndDeathID
.short 0xf800
cmp r0, #0
beq End

@add 10 damage each
mov r1, #0x5a
ldrsh r0, [r4, r1] @atk
add r0, #10
strh r0, [r4,r1]
mov r1, #0x5c
ldrsh r0, [r4, r1] @atk
sub r0, #10
strh r0, [r4,r1]

End:
pop {r4-r7, r15}
.align
.ltorg
SkillTester:
@Poin SkillTester
@WORD LifeAndDeathID
