.thumb

.macro _blr reg
	mov lr, \reg
	.short 0xF800
.endm
@arguments:
	@r0 = unit pointer
	@r1 = item id
	@r2 = pointer promotable class list

push 	{r4,lr}
mov 	r4,r2
ldr 	r3, check
_blr r3
cmp 	r0, #0x0
bne End
mov 	r4, #0x0
End:
mov 	r0, r4
pop 	{r4}
pop 	{r3}
bx 	r3
.ltorg
.align
check:
