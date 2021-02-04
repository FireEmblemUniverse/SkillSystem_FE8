
	.thumb

	@ restored from decompiling dump, and adjusted to be aware of the outside

	lExtraDataAddr = EALiterals + 0x00
	lExtraDataSize = EALiterals + 0x04

	push {lr}

	ldr  r3, [r4] @ ReadSramFast

	ldr  r0, =0x1F74
	add  r0, r6

	mov  r1, r8

	mov  r2, #4

	bl   BXR3

	ldr  r3, [r4] @ ReadSramFast

	ldr  r0, =0x1F78
	add  r0, r6

	ldr  r1, lExtraDataAddr
	ldr  r2, lExtraDataSize

	bl   BXR3

	pop  {r3}
BXR3:
	bx   r3

	.pool
	.align

EALiterals:
	@ .word ExtraDataAddr
	@ .word ExtraDataSize
