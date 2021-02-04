.thumb
.equ ItemTable, SkillTester+4
.equ HolyAuraID, ItemTable+4

push {r4-r7, lr}
mov r4, r0 @atkr
mov r5, r1 @dfdr

mov r0,#0x1e
ldrb r0,[r4,r0] @ItemID
ldr r1,ItemTable
mov r2,#36
mul r2,r0
add r1,r2
ldrb r1,[r1,#0x7]
cmp r1,#0x6
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
