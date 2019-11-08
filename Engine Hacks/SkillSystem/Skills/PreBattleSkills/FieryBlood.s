.thumb
.equ FieryBloodID, SkillTester+4

push {r4-r7, lr}
mov r4, r0 @atkr
mov r5, r1 @dfdr

@hp not at full
ldrb r0, [r4, #0x12] @max hp
ldrb r1, [r4, #0x13] @curr hp
cmp r0, r1
ble End @skip if max hp <= curr hp

@has FieryBlood
ldr r0, SkillTester
mov lr, r0
mov r0, r4 @attacker data
ldr r1, FieryBloodID
.short 0xf800
cmp r0, #0
beq End

@add 4 damage
mov r1, #0x5a
ldrh r0, [r4, r1] @atk
add r0, #4
strh r0, [r4,r1]

End:
pop {r4-r7, r15}
.align
.ltorg
SkillTester:
@Poin SkillTester
@WORD FieryBloodID
