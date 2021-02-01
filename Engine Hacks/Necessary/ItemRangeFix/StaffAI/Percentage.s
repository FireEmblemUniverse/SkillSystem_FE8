.thumb
.include "_ItemAIDefinitions.s"

@arguments:
	@r0 = unit pointer
@returns:
	@r0 = hp percentage
	
push 	{r4-r5, lr}
mov 	r5, r0
_blh GetUnitCurrentHP
mov 	r1, #0x64
mov 	r4, r0
mul 	r4, r1
mov 	r0 ,r5
_blh GetUnitMaxHP
mov 	r1, r0
mov 	r0, r4
_blh Div
pop 	{r4-r5}
pop 	{r3}
bx 	r3
.ltorg
.align
