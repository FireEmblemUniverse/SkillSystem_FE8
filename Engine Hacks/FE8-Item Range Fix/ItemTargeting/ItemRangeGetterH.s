.thumb

@get item modified range (after checking stuff like skills, mag/2, etc.)
@arguments:
	@r0 = unit pointer
	@r1 = item id
@returns
	@r0 = min max halfword
push	{lr}
ldr 	r3, GetRange
bl Jump
lsr 	r1, r0, #0x8
mov 	r2, #0xFF
and 	r0, r2
and 	r1, r2
orr 	r0, r1
pop 	{r3}
Jump:
bx	r3
.ltorg
.align
GetRange:
