
	.thumb

	@ restored from decompiling dump, and adjusted to be aware of the outside

	WriteAndVerifySramFast = 0x080D184C+1

	lExtraDataAddr = EALiterals + 0x00
	lExtraDataSize = EALiterals + 0x04

	push {r4, lr}

	ldr  r3, =WriteAndVerifySramFast

	ldr  r0, [sp, #0x3C]

	ldr  r1, =0x1F74
	add  r1, r7

	mov  r2, #4

	bl   BXR3

	ldr  r3, =WriteAndVerifySramFast

	ldr  r0, lExtraDataAddr

	ldr  r1, =0x1F78
	add  r1, r7

	ldr  r2, lExtraDataSize

	bl   BXR3

	pop  {r4}

	pop  {r3}
BXR3:
	bx   r3

	.pool
	.align

EALiterals:
	@ .word ExtraDataAddr
	@ .word ExtraDataSize
