
.thumb

.include "../CommonDefinitions.inc"

MMBUpdateInfo:

	.global	MMBUpdateInfo
	.type	MMBUpdateInfo, %function

	@ Inputs:
	@ r0: Pointer to Proc state

	push	{r4, r5, lr}	@	push	{r4, lr}
	
	mov		r4, r0		@r4 is proc state now

	ldr		r0, =MMBGetUnitAtCursor
	mov		lr, r0
	bllr

	ldr		r1, =GetDeploymentSlot
	mov		lr, r1
	bllr

	ldr		r2, =#0x88068F0
	ldr		r5,[r0,#0]
	cmp		r5, r2  	@unit pointer 8803d30 + 30c0 = 8806DF0
	bge		PreNoUnit 	@unit 0 + 0xF0 times 0x32 bytes = 8806df0
	b		Saveunit	@so units of id 0xF0 or greater ignored

Saveunit:
	@ Move unit pointer into r1
	@ to pass into BuildUI1Window
	mov		r1, r0
	cmp		r1, #0x00	
	bne		Unit		@unit pointer of 0 also ignored
	b		NoUnit

PreNoUnit:
	mov		r0, #0
	b		NoUnit

NoUnit:
	@ If no unit at space we're moving to
	mov		r1, r0

	mov		r0, r4		@proc state back to r0

	@ Jump to retract box

	mov		r1, #0x03
	ldr		r2, =GotoProcLabel
	mov		lr, r2
	bllr

	b		End

	.ltorg


Unit:

	@ Otherwise rebuild stuff on box

	mov		r0, r4
	ldr		r2, =MMBBuildWindow
	mov		lr, r2
	bllr

	mov		r0, r4
	ldr		r1, =MMBRedrawTilemap
	mov		lr, r1
	bllr

End:
	pop		{r4, r5}
	pop		{r0}
	bx		r0

.ltorg
