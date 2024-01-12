.thumb
.equ HolyAuraID, SkillTester+4

push {r4-r7, lr}
mov r4, r0 @atkr
mov r5, r1 @dfdr

mov r0, #0x50
ldrb r0, [r4, r0] @r0 = Equipped weapon type
cmp r0, #0x6 @Light weapon type
bne End



@has HolyAura
ldr r0, SkillTester
mov lr, r0
mov r0, r4 @defender data
ldr r1, HolyAuraID
.short 0xf800
cmp r0, #0
beq End



mov r1, #0x5a
ldrh r0, [r4, r1]
add r0, #1
strh r0, [r4,r1]

mov r1, #0x60
ldrh r0, [r4, r1]
add r0, #5
strh r0, [r4,r1]

mov r1, #0x62
ldrh r0, [r4, r1]
add r0, #5
strh r0, [r4,r1]

mov r1, #0x66
ldrh r0, [r4, r1]
add r0, #5
strh r0, [r4,r1]

End:
pop {r4-r7, r15}
.align
.ltorg
SkillTester:
@Poin SkillTester
@WORD HolyAuraID
