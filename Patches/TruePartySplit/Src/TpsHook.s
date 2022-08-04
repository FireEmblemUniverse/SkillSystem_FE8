
	.thumb

	.global TpsHook_EvtHideUnit
	.type   TpsHook_EvtHideUnit, function

TpsHook_EvtHideUnit:
	ldr   r3, =TpsSetDisabledByPid

	ldr   r0, [r5]     @ r0 = unit->pinfo
	ldrb  r0, [r0, #4] @ r0 = unit->pinfo->id

	mov   r1, #1

	bl    bxr3

	ldr   r3, =TpsRefreshUnitAwayBits
	bl    bxr3

	@ go back
	ldr   r3, =0x0801049A+1
	bx    r3

	.global TpsHook_EvtShowUnit
	.type   TpsHook_EvtShowUnit, function

TpsHook_EvtShowUnit:
	ldr   r3, =TpsSetDisabledByPid

	ldr   r0, [r5]     @ r0 = unit->pinfo
	ldrb  r0, [r0, #4] @ r0 = unit->pinfo->id

	mov   r1, #0

	bl    bxr3

	ldr   r3, =TpsRefreshUnitAwayBits
	bl    bxr3

	@ go back
	ldr   r3, =0x0801049A+1
	bx    r3

	.global TpsHook_PostClearUnits
	.type   TpsHook_PostClearUnits, function

TpsHook_PostClearUnits:
	ldr   r3, =Asmc_Tps_ResetParties
	bl    bxr3

	@ replaced
	pop   {r4-r7}
	pop   {r3}

bxr3:
	bx    r3
