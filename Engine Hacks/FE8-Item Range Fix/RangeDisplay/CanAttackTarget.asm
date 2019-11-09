.thumb
.org 0x0
.set Total, 0xFF @value used to represent total range

@arguments:
	@r0= item id,
	@r1= distance between the units, 
	@r2 has char data

push	{r4,r5,r14}
mov		r4,r1
mov 	r1, r0
mov 	r0, r2
ldr 	r3, itemrange	@returns: r0 = max range; r1 = min range
bl 	jump_r3
cmp 	r5, #Total
bne NotTotal
mov 	r2, #0x1
b 	GoBack
NotTotal:
mov 	r2, #0x0
cmp 	r0, r4
blt 	GoBack
cmp 	r1, r4
bgt 	GoBack
mov 	r2, #0x1
GoBack:
mov		r0,r2
pop		{r4,r5}
pop		{r1}
bx		r1
jump_r3:
bx	r3
.ltorg
.align
itemrange:
