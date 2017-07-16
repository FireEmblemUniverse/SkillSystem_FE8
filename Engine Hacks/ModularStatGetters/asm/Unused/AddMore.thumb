.thumb

.macro blh to, reg=r3
	ldr \reg, =\to
	mov lr, \reg
	.short 0xF800
.endm

AddMore:
	add r0, #10
	bx lr

.ltorg
.align

EALiterals:
	@ none
