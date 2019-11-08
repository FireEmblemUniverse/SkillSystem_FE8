.thumb
.align

.equ TowerShieldPlusID,SkillTester+4

push {r4-r7,lr}
@goes in the battle loop.
@r0 is the attacker
@r1 is the defender
mov r4, r0
mov r5, r1

@check range
ldr r0,=#0x203A4D4 @battle stats
ldrb r0,[r0,#2] @range
cmp r0,#1
ble GoBack

@check for skill
ldr r0, SkillTester
mov lr, r0
mov r0, r4
ldr r1, TowerShieldPlusID
.short 0xf800
cmp r0, #0
beq GoBack

@set defender attack to 0
mov r0, r5
add r0,#0x5A
mov r3,#0
strh r3,[r0]

GoBack:
pop {r4-r7}
pop {r0}
bx r0

.ltorg
.align

SkillTester:
@POIN SkillTester
@WORD TowerShieldPlusID
