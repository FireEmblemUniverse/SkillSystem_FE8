.thumb

.macro blh to, reg=r3
	ldr \reg, =\to
	mov lr, \reg
	.short 0xF800
.endm

AddBaseMov:
	ldr r1, [r1, #4]
	ldrb r1, [r1, #0x12] @ loading class mov
	
	add r0, r1
	
	bx lr

.ltorg
.align

EALiterals:
	@ none
