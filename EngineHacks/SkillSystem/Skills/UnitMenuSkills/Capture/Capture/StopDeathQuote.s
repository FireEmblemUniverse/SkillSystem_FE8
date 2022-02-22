.thumb
@Hook 080846E4
@If it is a Capture, stop DeathQuote
@This routine is based on Aera's routine by 7743

	push	{r4, r5, r6, r7, lr}
	lsl	r0, r0, #16
	lsr	r6, r0, #16

@IsCapture?
	ldr		r0, =0x3004e50	@current char pointer
	ldr		r0, [r0]

	@Check Current Unit is Player Unit
	ldrb	r1, [r0,#0xB]
	cmp		r1, #0x40
	bge		GoBack

	@Is_Capture_Set?
	ldr		r1, Is_Capture_Set
	mov		r14, r1
	.short	0xF800
	cmp r0, #0x0
	beq		GoBack

	@stop deathquote
	mov	r0, #0
	pop	{r4, r5, r6, r7}
	pop	{r1}
	bx	r1
GoBack:
	ldr	r4, =0x0808472C	@DeathQuote Pointer
	ldr	r4, [r4]
	ldr	r0, =0x080846EC|1
	bx	r0

.ltorg
.align 4
Is_Capture_Set:
