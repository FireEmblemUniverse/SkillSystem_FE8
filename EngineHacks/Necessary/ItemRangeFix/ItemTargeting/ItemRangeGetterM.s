.thumb
.global GetItemRangeM
.type GetItemRangeM,%function
.global GetItemRangeMin
.type GetItemRangeMin,%function
.global GetItemRangeMax
.type GetItemRangeMax,%function

@get item modified range (after checking stuff like skills, mag/2, etc.)
@arguments:
	@r0 = unit pointer
	@r1 = item id
@returns
	@r0 = max range
	@r1 = min range
GetItemRangeM:
push	{lr}
bl 	ItemRangeGetter
lsr 	r1, r0, #0x10
mov 	r2, #0xFF
and 	r0, r2
and 	r1, r2
pop 	{r3}
bx	r3
.ltorg
.align

@arguments:
	@r0 = unit pointer
	@r1 = item id
@returns
	@r0 = min range (after skill checks,etc.)
GetItemRangeMin:
push	{lr}
bl 	ItemRangeGetter
lsl r0, r0, #0x08
lsr r0, r0, #0x18
pop 	{r1}
bx	r1
.ltorg
.align

@arguments:
	@r0 = unit pointer
	@r1 = item id
@returns
	@r0 = max range (after skill checks,etc.)
GetItemRangeMax:
push	{lr}
bl 	ItemRangeGetter
lsl r0,r0,#0x18
lsr r0,r0,#0x18
pop 	{r1}
bx	r1
.ltorg
.align
