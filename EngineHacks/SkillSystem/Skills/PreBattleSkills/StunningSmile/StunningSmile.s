.equ StunningSmileID, SkillTester+4
.equ gBattleData, 0x203a4d4
.thumb
push {r4-r7,lr}
@goes in the battle loop.
@r0 is the attacker
@r1 is the defender
mov r4, r0
mov r5, r1

@make sure we're in combat (or battle forecast)
ldrb r3, =gBattleData
ldrb r3, [r3]
cmp r3, #4
beq End

@check for skill
ldr r0, SkillTester
mov lr, r0
mov r0, r4
ldr r1, StunningSmileID
.short 0xf800
cmp r0, #0
beq End

@is the defender male?
ldr r0, [r5] @char
ldr r0, [r0, #0x28] @char abilities
ldr r1, [r5,#4] @class
ldr r1, [r1,#0x28] @class abilities
orr r0, r1
mov r1, #0x40
lsl r1, #8 @0x4000 IsFemale
tst r0, r1
bne End @skip if female

@description says -20 avo to enemy but we're adding +20 hit
@since it's easier to do and is functionally the same outside niche edge cases
mov r0, r4
add r0,#0x60	@attacker hit
ldrh r3,[r0]
add r3,#20		@add +20 hit
strh r3,[r0]

End:
pop {r4-r7}
pop {r0}
bx r0

.ltorg
.align

SkillTester:
@POIN SkillTester
@WORD StunningSmileID
