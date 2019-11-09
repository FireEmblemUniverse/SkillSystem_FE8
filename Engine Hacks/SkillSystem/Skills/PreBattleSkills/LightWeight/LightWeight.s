.thumb
.equ LightWeightID, SkillTester+4

push {r4-r7, lr}
mov r4, r0 @atkr
mov r5, r1 @dfdr

@Only has 3 or less items
mov r1, #0x24
ldrb r0, [r4, r1] @fourth item in inventory
cmp r0, #0x0 		 @This item is empty
bne End @skip if holding 4 items

@has LightWieghtID
ldr r0, SkillTester
mov lr, r0
mov r0, r4 @attacker data
ldr r1, LightWeightID
.short 0xf800
cmp r0, #0
beq End

@add 3 AS
mov r1, #0x5E
ldrh r0, [r4, r1] @AS
add r0, #3
strh r0, [r4,r1]

End:
pop {r4-r7, r15}
.align
.ltorg
SkillTester:
@Poin SkillTester
@WORD LightWeightID
