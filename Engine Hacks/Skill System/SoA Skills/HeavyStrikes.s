.thumb
.equ ItemTable, SkillTester+4
.equ AnalyticID, ItemTable+4

push {r4-r7, lr}
mov r4, r0 @atkr
mov r5, r1 @dfdr


@has Analytic
ldr r0, SkillTester
mov lr, r0
mov r0, r4 @Attacker data
ldr r1, AnalyticID
.short 0xf800
cmp r0, #0
beq End

mov r3,#0x4a
ldrb r2,[r4,r3]
mov r3,#36
mul r2,r3
ldr r3,ItemTable
add r2,r3
mov r3,#23
ldrb r2,[r2,r3]

mov r1, #0x66
ldrh r0, [r4, r1]
add r0, r2
strh r0, [r4,r1]


End:
pop {r4-r7, r15}

.align
.ltorg
SkillTester:
@Poin SkillTester
@WORD AnalyticID
