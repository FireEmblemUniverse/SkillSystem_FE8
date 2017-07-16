.thumb

.macro blh to, reg=r3
	ldr \reg, =\to
	mov lr, \reg
	.short 0xF800
.endm

AddUnitStr:
	ldrb r1, [r1, #0x14] @ loading unit str
	add r0, r1 @ adding to result
	
	bx lr

.ltorg
.align

EALiterals:
	@ none
