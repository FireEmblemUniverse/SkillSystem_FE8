.thumb
.align

.equ DefiantAvoID,SkillTester+4

push {r4-r7,lr}
@goes in the battle loop.
@r0 is the attacker
@r1 is the defender
mov r4, r0
mov r5, r1

@check for current HP to be 25% or lower

ldrb r0,[r4,#0x12] @max hp
ldrb r1,[r4,#0x13] @cur hp
lsl r1,r1,#2 @cur hp x4
cmp r1,r0
bgt GoBack @if cur hp x4 is less than or equal to max HP, we are at 25% or less

ldr r0, SkillTester
mov lr, r0
mov r0, r4
ldr r1, DefiantAvoID
.short 0xf800
cmp r0, #0
beq GoBack

mov r0, r4

@avoid
add r0,#0x62
ldrh r3,[r0]
add r3,#30
strh r3,[r0]


GoBack:
pop {r4-r7}
pop {r0}
bx r0

.ltorg
.align

SkillTester:
@POIN SkillTester
@WORD DefiantAvoID
