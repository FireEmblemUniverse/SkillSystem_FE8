
	.thumb

	.include "Definitions.inc"

PromotionInit:
	ldr  r1, [r0, #0x14] @ r1 = parent
	ldr  r1, [r1, #0x14] @ r1 = parent's parent

	mov  r2, #0x31
	ldrb r1, [r1, r2] @ r1 = promotion context id

	ldr r3, =0x08002F24|1
	bx  r3

	.pool
	.align

EALiterals:
	@ nothing
