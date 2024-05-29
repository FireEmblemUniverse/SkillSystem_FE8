.thumb
.equ PursuerID, SkillTester+4
.equ gBattleData, 0x203A4D4

push {r4-r7, lr}
mov r4, r0 @atkr
mov r5, r1 @dfdr

@has Lunatic
ldr r0, SkillTester
mov lr, r0
mov r0, r4 @attacker data
ldr r1, PursuerID
.short 0xf800
cmp r0, #0
beq End

@in combat

ldr r1, [r5,#4] @class data ptr
cmp r1, #0 @if 0, this is stat screen
beq End
ldrb r3, =gBattleData
ldrb r3, [r3]
cmp r3, #4
beq End

ldr r0,=#0x203A4EC @attacker struct
cmp r0,r4
bne End @skip if enemy phase

@add 5 AS
mov r1, #0x5E
ldrh r0, [r4, r1] @spd
add r0, #5
strh r0, [r4,r1]

@add spd/4 attack
mov  r1, #0x5A
ldrh r0, [r4, r1] @attack
ldrb r2, [r4, #0x12] @max hp
lsr  r2, #2 @divide this by 4
add  r0, r2
strh r0, [r4,r1]

End:
pop {r4-r7, r15}
.align
.ltorg
SkillTester:
@Poin SkillTester
@WORD PursuerID
