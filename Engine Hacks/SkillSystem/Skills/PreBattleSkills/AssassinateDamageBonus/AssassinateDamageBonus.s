.thumb
@assassinate: When initiating battle at 1 range: +2 Damage, Double attacks occur before counter
.equ AssassinateID, SkillTester+4

push {r4-r7, lr}
mov r4, r0 @atkr
mov r5, r1 @dfdr

@check range
ldr r0,=#0x203A4D4 @battle stats
ldrb r0,[r0,#2] @range
cmp r0,#1
bne End

@make sure we are in combat (or combat prep)
ldrb	r3, =gBattleData
ldrb	r3, [r3]
cmp		r3, #4
beq		End

@has Assassinate
ldr r0, SkillTester
mov lr, r0
mov r0, r4 @Attacker data
ldr r1, AssassinateID
.short 0xf800
cmp r0, #0
beq End

@add 2 damage
mov r1, #0x5a
ldrh r0, [r4, r1] @atk
add r0, #2
strh r0, [r4,r1]

End:
pop {r4-r7}
pop {r0}
bx r0

.ltorg
SkillTester:
@poin SkillTester
@word AssassinateID
