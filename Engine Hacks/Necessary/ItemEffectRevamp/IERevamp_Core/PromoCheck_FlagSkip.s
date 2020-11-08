.thumb

.macro _blr reg
	mov lr, \reg
	.short 0xF800
.endm

@arguments:
	@r0 = unit pointer
	@r1 = item id
	@r2 = pointer to promo table entry
	
push 	{r4-r5,lr}
@mov 	r4,r2
@mov 	r5,r1
mov 	r5,r0
mov 	r4, #0x1
ldr 	r0,[r5]
ldr 	r1,[r5,#0x4]
mov 	r2, #0x28
ldr 	r0, [r0,r2]
ldr 	r1, [r1,r2]
orr 	r0,r1
ldr 	r2, AbilityFlags
and 	r0,r2
cmp 	r0, #0x0
beq End
mov 	r4, #0x3
End:
mov 	r0, r4
pop 	{r4-r5}
pop 	{r3}
bx 	r3
.ltorg
.align
AbilityFlags:
