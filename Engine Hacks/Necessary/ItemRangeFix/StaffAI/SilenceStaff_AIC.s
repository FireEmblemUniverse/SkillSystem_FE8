.thumb
.include "_ItemAIDefinitions.s"
@parameters: 
	@r0 = stack pocket pointer
	@r1= active unit
	@r2= target unit
	
.set MinHitRate, 0x0 @minimum accuracy against unit to target them
.equ AI_IfAlly, OffsetList + 0x0

	push 	{r4-r7, lr}
	mov 	r4, r0
	mov 	r5, r1
	mov 	r6, r2
	
	cmp 	r5, r6
	beq CantHit 	@stop unit from targeting itself
	
	mov 	r0, r6
	ldr 	r3, AI_IfAlly
	_blr 	r3
	@_blh 	AIAllegianceCheck
	cmp 	r0, #0x0
	beq CantHit
	
	mov 	r0, r6
	mov 	r1, #0x30
	ldrb 	r1,[r0,r1]
	mov 	r0, #0xF
	and 	r0, r1
	cmp 	r0, #0x0	@check if target already has a status effect
	bne 	CantHit
	
	mov 	r0, r6
	_blh Unit_HasUsableStaff
	cmp r0, #0x0
	beq CantHit
	
	mov 	r0, r5
	mov 	r1, r6
	_blh StaffHitRate
	cmp 	r0, #MinHitRate		@make sure hitrate is above minimum
	ble 	CantHit
	
	Usable:
	mov 	r0, #0x1
	b End
	
	CantHit:
	mov 	r0, #0x0
	End:
	pop 	{r4-r7}
	pop 	{r1}
	bx 	r1
.ltorg
.align
OffsetList:
