.thumb
.include "_ItemEffectDefinitions.s"

@.global IE_InflictStatusEffect
@.type IE_InflictStatusEffect, %function

IE_DancerRingEffect:
push 	{r4-r6,r14}
mov 	r6, r0
@mov 	r5, #0x0
ldr 	r4, =ActionStruct
ldrb 	r0, [r4,#0xC]
bl 	RamUnitByID
ldrb 	r1, [r4,#0x12]
bl 	BActingUnitUpdate
ldrb 	r0, [r4,#0xD]
bl 	RamUnitByID
bl 	BTargetUnitUpdate
ldrb 	r0, [r4,#0xC]
bl 	RamUnitByID
ldrb 	r1, [r4,#0x12]
lsl 	r1, r1, #0x1
add 	r0, #0x1E
add 	r0, r0, r1
ldrh 	r0,[r0]
bl 	Item_GetStat_EPV_Jump	@get effect value byte
mov 	r5, r0
@ldr 	r0, =ActionStruct
ldrb 	r0, [r4,#0xD]
bl 	RamUnitByID

mov r1, #0xF
and r1,r5	@get status effect
lsr r2,r5,#0x4	@get status duration
bl 	InflictStatusOnUnit


@also dance
@sub r0,#0x30
@ldr	r1,[r0,#0xC]
@ldr	r2,=#0x80323A0
@ldr	r2,[r2]
@and	r1,r2
@str	r1,[r0,#0xC]


ldr 	r1, =#0x203A4D4
mov 	r0, #0x80
lsl 	r0, r0, #0x2
strh 	r0,[r1]
mov 	r0,r6
bl 	FinishItemBattleRound
bl 	StartItemGraphics
pop 	{r4-r6}
pop 	{r0}
bx 	r0
.align
.ltorg
