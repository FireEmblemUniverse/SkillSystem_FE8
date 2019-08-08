.thumb
.equ ItemTable, SkillTester+4
.equ ThunderstormID, ItemTable+4

.equ gBattleData, 0x203A4D4

push {r4-r7, lr}
mov r4, r0 @atkr
mov r5, r1 @dfdr

@has Thunderstorm
ldr r0, SkillTester
mov lr, r0
mov r0, r4 @Attacker data
ldr r1, ThunderstormID
.short 0xf800
cmp r0, #0
beq End

@make sure we're in combat (or combat prep)
ldrb r3, =gBattleData
ldrb r3, [r3]
cmp r3, #4
beq End

@store attacker weight in r6
mov r3,#0x4a
ldrb r2,[r4,r3]
mov r3,#36
mul r2,r3
ldr r3,ItemTable
add r2,r3
mov r3,#23
ldrb r6,[r2,r3]

@store defender weight in r7
mov r3,#0x4a
ldrb r2,[r5,r3]
mov r3,#36
mul r2,r3
ldr r3,ItemTable
add r2,r3
mov r3,#23
ldrb r7,[r2,r3]

cmp r6, r7
ble End

@Add stuff
mov r1, #0x5A
ldrh r0, [r4, r1]
add r0, #0x2
strh r0, [r4,r1]

mov r1, #0x60
ldrh r0, [r4, r1]
add r0, #15
strh r0, [r4,r1]

mov r1, #0x66
ldrh r0, [r4, r1]
add r0, #0x5
strh r0, [r4,r1]

End:
pop {r4-r7, r15}
.align
.ltorg
SkillTester:
@Poin SkillTester
@POIN ItemTable
@WORD ThunderstormID
