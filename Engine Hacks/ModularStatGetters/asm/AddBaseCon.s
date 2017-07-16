.thumb

.macro blh to, reg=r3
	ldr \reg, =\to
	mov lr, \reg
	.short 0xF800
.endm

AddBaseCon:
	ldr r2, [r1]
	ldrb r2, [r2, #0x13] @ loading unit con bonus
	
	add r0, r2
	
	ldr r2, [r1, #4]
	ldrb r2, [r2, #0x11] @ loading class con
	
	add r0, r2
	
	bx lr

.ltorg
.align

EALiterals:
	@ none
