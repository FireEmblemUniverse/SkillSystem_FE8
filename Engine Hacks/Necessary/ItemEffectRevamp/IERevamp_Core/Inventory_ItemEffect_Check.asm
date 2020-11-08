.thumb
@place routine at 0x18A9C in FE8
@bl commands have placeholder offsets, fixed in .dmp of asm
.org 0x0

	push 	{r4-r6,r14}
	mov 	r3, #0x0
	mov 	r4, r0
	mov 	r5, r1
	ldr 	r6, EIDGetter
	add 	r4, #0x1E
	LoopStart:
	ldrh 	r0, [r4]
	cmp 	r0, #0x0
	beq 	Reloop		@skip check if no item in slot
	mov 	r14, r6
	.short 0xF800
	cmp 	r0, r5
	bne 	Reloop
	mov r0, r3
	b	Return
	Reloop:
	add 	r4, #0x2
	add 	r3, #0x1
	cmp 	r3, #0x4
	ble LoopStart
	LoopFail:
	mov 	r0, #0x1
	neg 	r0, r0
	Return:
	pop 	{r4-r6}
	pop 	{r1}
	bx	r1

.align
EIDGetter:
