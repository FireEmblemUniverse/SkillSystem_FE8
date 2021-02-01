.thumb
.include "../_ItemAIDefinitions.h.s"
@parameters: 
	@r0 = stack pocket pointer
	@r1= active unit
	@r2= target unit
	
.equ AI_IfAlly, OffsetList + 0x0

	push 	{r4-r6, lr}
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
	bne CantHit
	
	mov 	r0, r6
	mov 	r1, #0x30
	ldrb 	r1,[r0,r1]
	mov 	r0, #0xF
	and 	r0, r1
	cmp 	r0, #0x0	@check if target already has a status effect
	beq 	CantHit
	
	Usable:
	mov 	r0, #0x1
	b End
	
	CantHit:
	mov 	r0, #0x0
	End:
	pop 	{r4-r6}
	pop 	{r1}
	bx 	r1
.ltorg
.align
OffsetList:
