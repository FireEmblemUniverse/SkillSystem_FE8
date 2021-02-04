.thumb
.align

.equ HawkeyeID,SkillTester+4

push {r4-r7,lr}
@goes in the battle loop.
@r0 is the attacker
@r1 is the defender
mov r4, r0
mov r5, r1

ldr r0,=#0x203A4EC @attacker struct
cmp r0,r4
bne GoBack @if not attacker, don't do

ldr r0, SkillTester
mov lr, r0
mov r0, r4
ldr r1, HawkeyeID
.short 0xf800
cmp r0, #0
beq GoBack

mov r0, r4
@hit
add r0,#0x60
ldrh r3,[r0]
lsl r3,#1 @double hit rate
strh r3,[r0]


GoBack:
pop {r4-r7}
pop {r0}
bx r0

.ltorg
.align

SkillTester:
@POIN SkillTester
@WORD HawkeyeID
