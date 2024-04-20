.thumb
.equ AnalyticID, SkillTester+4

push {r4-r7, lr}
mov r4, r0 @atkr
mov r5, r1 @dfdr

@has Analytic
ldr r0, SkillTester
mov lr, r0
mov r0, r4 @attacker data
ldr r1, AnalyticID
.short 0xf800
cmp r0, #0
beq End

@check speed
mov r0, #0x5E
ldrh r1,[r4,r0] @attack speed - skill holder
ldrh r0,[r5,r0] @attack speed - enemy
cmp r1,r0
blt CheckBoost
b   End

CheckBoost:
mov r6,#0x5A
ldrh r7,[r4,r6] @attack - skill holder
add r1,#4
cmp r1,r0
ble BiggerBoost
b   SmallerBoost

BiggerBoost:
add r7,#10
strh r7,[r4,r6]
b   End

SmallerBoost:
add r7,#5
strh r7,[r4,r6]
b   End

End:
pop {r4-r7, r15}
.align
.ltorg
SkillTester:
@Poin SkillTester
@WORD AnalyticID
