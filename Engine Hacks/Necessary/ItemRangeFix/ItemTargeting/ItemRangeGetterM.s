.thumb
.global GetItemRangeM
.type GetItemRangeM,%function

@get item modified range (after checking stuff like skills, mag/2, etc.)
@arguments:
	@r0 = unit pointer
	@r1 = item id
@returns
	@r0 = max range
	@r1 = min range
GetItemRangeM:
push	{lr}
@ldr 	r3, FillRange
@bl Jump
bl 	ItemRangeGetter
lsr 	r1, r0, #0x10
mov 	r2, #0xFF
and 	r0, r2
and 	r1, r2
pop 	{r3}
Jump:
bx	r3
.ltorg
.align
FillRange:
