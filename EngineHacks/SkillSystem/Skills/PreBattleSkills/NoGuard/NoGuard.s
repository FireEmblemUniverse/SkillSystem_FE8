.thumb
.equ NoGuardID, SkillTester+4

push {r4-r7, lr}
mov r4, r0 @atkr
mov r5, r1 @dfdr

@has NoGuard
ldr r0, SkillTester
mov lr, r0
mov r0, r4 @attacker data
ldr r1, NoGuardID
.short 0xf800
cmp r0, #0
beq End

@set battle hit to 100% on both sides
mov r1, #0x60 
ldrsh r0, [r4, r1] @hit
mov r0, #255
strh r0, [r4,r1]
mov r1, #0x62
ldrsh r0, [r4, r1] @avoid
sub r0, #255
strh r0, [r4,r1]

End:
pop {r4-r7, r15}
.align
.ltorg
SkillTester:
@Poin SkillTester
@WORD NoGuardID
