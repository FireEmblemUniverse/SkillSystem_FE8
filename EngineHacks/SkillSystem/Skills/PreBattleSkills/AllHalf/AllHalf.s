.thumb
@AllHalf: Halves all damage
.equ AllHalfID, SkillTester+4
.equ gBattleData, 0x203A4D4

push {r4-r7, lr}
mov r4, r0 @atkr
mov r5, r1 @dfdr

@has AllHalf
ldr r0, SkillTester
mov lr, r0
mov r0, r4 @Attacker data
ldr r1, AllHalfID
.short 0xf800
cmp r0, #0
beq End

@make sure in battle
ldr  r3, =gBattleData
ldrb r3, [r3]
mov  r0, #0x3
tst  r0, r3
beq  End

@halves attacker's attack
mov r1, #0x5a
ldrh r0, [r4, r1] @atk
lsr	r0, r0, #0x01
strh r0, [r4,r1]

@halves defender's defense
mov r1, #0x5c
ldrh r0, [r4, r1] @def
lsr	r0, r0, #0x01
strh r0, [r4,r1]

End:
pop {r4-r7}
pop {r0}
bx r0


.ltorg
.align 4
SkillTester:
@poin SkillTester
@word AllHalfID
