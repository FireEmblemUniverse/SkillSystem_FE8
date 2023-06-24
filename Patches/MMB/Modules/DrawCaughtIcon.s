	@ Inputs:
	@ r0: pointer to proc state
	@ r1: pointer to unit in RAM
.include "../CommonDefinitions.inc"
.thumb 
.equ RegisterIconOBJ, 0x800372C


MMBRenderCaughtIcon:

	.global	MMBRenderCaughtIcon
	.type	MMBRenderCaughtIcon, %function

	.set MMBCaughtTileIndex,	EALiterals + 0
	.set MMBCaughtX,		EALiterals + 2
	.set MMBCaughtY,		EALiterals + 3

	@ Inputs:
	@ r0: pointer to proc state
	@ r1: pointer to unit in RAM

	push	{r4, lr}

	mov		r4, r0

	@@ Otherwise r0 contains the slot,
	@@ use to get the proper icon tile
	@add		r0, #InventoryIconCount
	@ldrb	r0, [r0]
	mov r0, #0 
	
	@mov		r6, #SkillIconCount
	@ldrb	r6, [r7, r6]

	ldr 	r3, MMBCaughtTileIndex
	lsl r2, r3, #16 
	lsr r2, #16 @ 
	lsl		r0, #1
	add		r2, r0

	lsl r0, r3, #8 
	lsr r0, #24 
	lsr r1, r3, #24 
	@ldrb	r0, MMBCaughtTileIndex+2
	@ldrb	r1, MMBCaughtTileIndex+3

	ldr		r3, =MMBRenderIconObj
	mov		lr, r3

	mov		r3, r4

	bllr

End2:

	pop		{r4}
	pop		{r0}
	bx		r0

.ltorg
	

MMBDrawCaughtIcon:

	.global	MMBDrawCaughtIcon
	.type	MMBDrawCaughtIcon, %function

	.set MMBCaughtTileIndex,	EALiterals + 0

	push	{r4-r5, lr}

	mov		r4, r0
	mov		r5, r1

cmp r1, #0 
beq End 
	@ Check if caught
	ldr r0, [r5, #4] 
	ldrb r0, [r0, #4] @ class id 
	bl CheckIfCaught
	@ if not, end
	mov r1, #0xAA 
	add r0, r1 @ 0xAA if not caught, 0xAB if caught 

	@add		r4, #InventoryIconCount
	@ldrb	r2, [r4]
	@add		r3, r2, #0x01
	@strb	r3, [r4] @ increment icon count
	@lsl		r2, r2, #0x01
	ldr		r1, MMBCaughtTileIndex
	lsl r1, #16 
	lsr r1, #16 
	@add		r1, r1, r2

	ldr		r2, =RegisterIconOBJ @ LoadIconObjectGraphics(int iconId, int rootTile);
	mov		lr, r2
	.short 0xf800 
 

End:

	pop		{r4-r5}
	pop		{r0}
	bx		r0

.ltorg
.align 4 
EALiterals:
	@ MMBCaughtTileIndex




