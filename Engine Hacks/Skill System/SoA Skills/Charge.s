.thumb
.equ DominateID, SkillTester+4

push {r4-r7, lr}
ldr     r5,=0x203a4ec @attacker
cmp     r0,r5
bne     End
mov r4, r0 @atkr
mov r5, r1 @dfdr


@has Charge
ldr r0, SkillTester
mov lr, r0
mov r0, r4 @Attacker data
ldr r1, DominateID
.short 0xf800
cmp r0, #0
beq End

@Add damage

ldr r3,=0x203a968 @Spaces Moved
ldrb r2,[r3]
lsr r2,#0x1
mov r1, #0x5A
ldrh r0, [r4, r1]
add r0, r2
strh r0, [r4,r1]

End:
pop {r4-r7, r15}
.align
.ltorg
SkillTester:
@Poin SkillTester
@WORD DominateID
