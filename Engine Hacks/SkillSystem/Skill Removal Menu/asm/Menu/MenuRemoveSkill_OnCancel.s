
	.thumb

OnCancel:
 	@ Return (0x10 = Clear Gfx | 0x08 = Boop | 0x02 = Kill Menu)
	mov r0, #(0x10 | 0x08 | 0x02)
	bx lr
