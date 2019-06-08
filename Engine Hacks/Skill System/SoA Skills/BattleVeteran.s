.thumb
.equ BattleVeteranID, SkillTester+4

push {r4-r7, lr}
mov r4, r0 @atkr
mov r5, r1 @dfdr

ldr r0, SkillTester
mov lr, r0
mov r0, r4 @defender data
ldr r1, BattleVeteranID
.short 0xf800
cmp r0, #0
beq End

ldrb r0,[r4,#0x8] @Loads level
ldr r1,[r4,#0x4]
mov r2,#41
ldrb r1,[r1,r2] @loads Class Ability 2
mov r2,#0x1
and r1,r2
cmp r1,r2 @checks if it has the byte 0x1, IE promoted
bne Next
mov r1,#0x2 @If promoted, gain an extra 20 levels
mov r2,#10
b Loop

Next:
mov r1,#0x0 @If not promoted, start at 0
mov r2,#10

Loop:
cmp r0,r2
blt Eff
sub r0,r2
add r1,#0x1 @If > 10, add 1 to the level counter, and sub 10 from level
b Loop



Eff:

mov r0, #0x5A
ldrh r2, [r4, r0] @Damage
mov r3,#0x1
mul r3,r1 @1 Damage per level
add r2,r3
strh r2, [r4,r0]

mov r0, #0x60
ldrh r2, [r4, r0] @Hit
mov r3,#0x5
mul r3,r1 @5 hit per level
add r2,r3
strh r2, [r4,r0]


End:
pop {r4-r7, r15}
.align
.ltorg
SkillTester:
@Poin SkillTester
@WORD BattleVeteranID
