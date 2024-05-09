.thumb
.equ UnitRangeCheck, SkillTester+4
.equ LoyaltyID, UnitRangeCheck+4

push {r4-r7, lr}
mov r4, r0 @atkr
mov r5, r1 @dfdr

@has Loyalty
ldr r0, SkillTester
mov lr, r0
mov r0, r4 @Attacker data
ldr r1, LoyaltyID
.short 0xf800
cmp r0, #0
beq End

@now check for the skill
ldr r0, UnitRangeCheck
mov lr, r0
mov r0, r4 @attacker
mov r1, #0 @are allies
mov r2, #2 @range
.short 0xf800
cmp r0, #0
beq End

Loop:
ldrb r2,[r0]
cmp r2,#0x0
beq End
add r0,#0x1

@	Make Loyalty check for Lord bit instead of ClassID
mov r3,#0x48
ldr r5,CharData
sub r2,#0x1
mul r3,r2
add r5,r3
ldr r0, [r5] @char
ldr r0, [r0, #0x28] @char abilities
ldr r1, [r5,#4] @class
ldr r1, [r1,#0x28] @class abilities
orr r0, r1
mov r1, #0x20
lsl r1, #8
tst r0, r1
beq End

Final:
mov r1, #0x5C
ldrh r2, [r4, r1]
add r2, #0x3
strh r2, [r4,r1]

mov r1, #0x60
ldrh r2, [r4, r1]
add r2, #15
strh r2, [r4,r1]

End:
pop {r4-r7, r15}
.align
.ltorg
CharData:
.long 0x202be4c
MovementPoin:
.long 0x880bb96
SkillTester:
@Poin SkillTester
@WORD LoyaltyID