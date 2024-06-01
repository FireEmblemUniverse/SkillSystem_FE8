.thumb
.equ DecapitatorID, SkillTester+4
.equ gBattleData, 0x203A4D4

push {r4-r7, lr}
mov r4, r0 @atkr
mov r5, r1 @dfdr

@has skill?
ldr r0, SkillTester
mov lr, r0
mov r0, r4 @attacker data
ldr r1, DecapitatorID
.short 0xf800
cmp r0, #0
beq End

@ in combat
ldrb r3, =gBattleData
ldrb r3, [r3]
cmp r3, #4
beq End
@not at stat screen
ldr r1, [r5,#4] @class data ptr
cmp r1, #0 @if 0, this is stat screen
beq End

@add foes missing hp as damage
ldrb  r0,[r5,#0x12] @defender max hp
ldrb  r1,[r5,#0x13] @defender current hp
sub   r0,r1
mov   r2,#0x5A
ldrh  r1,[r4,r2]
add   r1,r0,r1
strh  r1,[r4,r2]

@foe under 50% hp?
ldrb r0, [r5, #0x12]
lsr r0, #1 @max hp/2
ldrb r1, [r5, #0x13] @currhp
cmp r1, r0
bgt End

@add hit
mov r1, #0x60
ldrh r0, [r4, r1] @hit
add r0, #80
strh r0, [r4,r1]

@add crit
mov r1, #0x66
ldrh r0, [r4, r1] @crit
add r0, #80
strh r0, [r4,r1]

End:
pop {r4-r7, r15}
.align
.ltorg
SkillTester:
@Poin SkillTester
@WORD DecapitatorID
