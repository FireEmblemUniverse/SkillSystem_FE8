.thumb
.equ BellePersonalID, SkillTester+4

push {r4-r7, lr}
mov r4, r0 @atkr
mov r5, r1 @dfdr

ldr r0,[r5,#0x4]
mov r1,#80
ldrb r0,[r0,r1]
mov r1,#0x10
and r0,r1
cmp r0,r1
bne End


@Is Belle
ldr r0, SkillTester
mov lr, r0
mov r0, r4 @defender data
ldr r1, BellePersonalID
.short 0xf800
cmp r0, #0
beq End


mov r1, #0x5a
ldrh r0, [r4, r1] @Attack
add r0, #2
strh r0, [r4,r1]

mov r1, #0x66
ldrh r0, [r4, r1] @Crit
add r0, #10
strh r0, [r4,r1]

End:
pop {r4-r7, r15}
.align
.ltorg
SkillTester:
@Poin SkillTester
@WORD BellePersonalID
