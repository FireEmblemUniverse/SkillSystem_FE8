.thumb

.macro _blr reg
	mov lr, \reg
	.short 0xF800
.endm
@arguments:
	@r0 = unit pointer
	@r1 = item id
PromoItemLevelCheck:
push 	{r4,lr}
mov 	r4, r0
mov 	r0, r1
ldr 	r3, GetItemVar 	@think of better name for it later
_blr 	r3
mov 	r2, #0x0
mov 	r1, #0x8
ldsb 	r1, [r4, r1]
cmp 	r1, r0
blt End
mov 	r2, #0x1
End:
mov 	r0, r2
pop 	{r4}
pop 	{r3}
bx 	r3
.ltorg
.align
GetItemVar:
