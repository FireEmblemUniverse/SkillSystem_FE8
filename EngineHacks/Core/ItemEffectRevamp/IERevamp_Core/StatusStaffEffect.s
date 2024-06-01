.thumb
.include "_ItemEffectDefinitions.s"

@.global IE_StatusStaffEffect
@.type IE_StatusStaffEffect, %function

IE_StatusStaffEffect:
push 	{r4-r6,r14}
mov 	r6, r0
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
mov 	r5, r0
ldrb 	r0, [r4,#0xD]
bl 	RamUnitByID
mov 	r1, r0
mov 	r0, r5
bl 	GetStatusStaffHitRate
ldr 	r4, =BattleActingUnit
mov 	r1, r4
add 	r1, #0x64
strh 	r0, [r1]
bl RNCheck_Single
lsl 	r0, r0, #0x18
cmp 	r0, #0x0
bne StatusStaffHit
StatusStaffMiss:
ldr 	r0, =ppBattleCurrentRound
ldr 	r3, [r0]
ldr 	r2, [r3]
lsl 	r1, r2, #0xD
lsr 	r1, r1, #0xD
mov 	r0, #0x2
orr 	r1, r0
ldr 	r0, =#0xFFF80000
and 	r0, r2
orr 	r0, r1
str 	r0, [r3]
b 	Skip

StatusStaffHit:
mov 	r0, r4
add 	r0, #0x4A
ldrh 	r0, [r0]
@removed the stuff for Stone since it doesn't seem to be used

@bl Item_GetID
@cmp 	r0, 0xB5	@check if item is Stone
@bne StatusStaves
@idk if this is even used but i'm keeping it just in case
@StoneStuff:
@ldr 	r0, =ChapterDataStruct
@ldrb 	r0,[r0,#0xF]
@cmp 	r0, #0x80
@beq
@cmp 	r0, #0x40
@beq
@cmp 	r0, #0x00
@beq
@b

bl 	Item_GetStat_EPV_Jump	@get effect value byte
@mov 	r1, #0xF
@and 	r1,r0	@get status effect
ldr 	r1, =#BattleTargetUnit
add 	r1, #0x6F
strb 	r0,[r1]
Skip:
mov 	r0,r6
bl 	FinishItemBattleRound
bl 	StartItemGraphics
pop 	{r4-r6}
pop 	{r0}
bx	r0
.align
.ltorg
