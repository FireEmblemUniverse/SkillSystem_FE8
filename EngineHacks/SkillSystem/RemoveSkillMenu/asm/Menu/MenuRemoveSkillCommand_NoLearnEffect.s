
	.thumb

NoLearnEffect:
	@ Return (0x10 = Clear Gfx) | (0x8 = Boop) | (0x4 = Beep) | (0x2 = Kill Menu)
	mov r0, #(0x10 | 0x8 | 0x4 | 0x2)
	bx lr

	.pool
	.align

EALiterals:
	@ nothing

