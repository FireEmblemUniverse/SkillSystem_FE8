.thumb
.equ HeavyBladeID, SkillTester+4

push {r4-r7, lr}
mov r4, r0 @atkr
mov r5, r1 @dfdr

@has HeavyBlade
ldr r0, SkillTester
mov lr, r0
mov r0, r4 @attacker data
ldr r1, HeavyBladeID
.short 0xf800
cmp r0, #0
beq End

@make sure we're in combat (or combat prep)
ldrb r3, =gBattleData
ldrb r3, [r3]
cmp r3, #4
beq End

ldr r0, [r4, #0x0] 
ldrb r0, [r0, #0x13] @unit Con
ldr r1, [r4, #0x04]
ldrb r1, [r1, #0x11] @class Con
add r0, r1
ldrb r1, [r4, #0x1A] @Con bonus
add r0, r1 @r0 contains attacker con

ldr r1, [r5, #0x0]
ldrb r1, [r1, #0x13]
ldr r2, [r5, #0x04]
ldrb r2, [r2, #0x11]
add r1, r2
ldrb r2, [r5, #0x1A] @Con bonus
add r1, r2 @r1 contains defender con

cmp r0, r1
ble End @skip if con is less or equal

mov r1, #0x5A
ldrh r0, [r4, r1] @atk
add r0, #4
strh r0, [r4,r1]
mov r1, #0x5E
ldrh r0, [r4, r1] @AS
cmp r0, #0x02
ble ZeroAS
sub r0, #2
strh r0, [r4,r1]
b End

ZeroAS:
mov r0, #0x0
strh r0, [r4,r1]

End:
pop {r4-r7, r15}
.align
.ltorg
SkillTester:
@Poin SkillTester
@WORD HeavyBladeID

