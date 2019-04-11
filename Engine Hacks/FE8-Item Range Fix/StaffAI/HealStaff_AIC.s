.thumb
.include "_ItemAIDefinitions.s"
@parameters: 
	@r0 = stack pocket pointer
	@r1= active unit
	@r2= target unit
	
.set MaxPercent, 100	@target is healable if below this percent of hp
.equ AI_IfAlly, OffsetList + 0x0
.equ GetHpPercent, OffsetList + 0x4

push 	{r4-r7, lr}
mov 	r4, r2
mov 	r5, r1
mov 	r6, r0

cmp 	r5, r4		@stop unit from targeting itself
beq CantHit

ldrb 	r1, [r4,#0xA]
mov 	r0, #0x1
and 	r0, r1
cmp 	r0, #0x0	@check if target unit is in recovery mode
beq CantHit

mov 	r0, r4
ldr 	r3, AI_IfAlly
_blr 	r3
@_blh 	AIAllegianceCheck
cmp 	r0, #0x0
bne CantHit

mov 	r0, r4
ldr 	r3, GetHpPercent
_blr 	r3
@_blh GetHpPercent
mov 	r1, #MaxPercent
cmp 	r0, r1
bhs 	CantHit

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
