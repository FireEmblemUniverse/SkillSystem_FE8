.thumb

.macro blh to, reg=r3
	ldr \reg, =\to
	mov lr, \reg
	.short 0xF800
.endm

AddUnitBarrierModifier:
	mov r2, #0x31
	ldrb r1, [r1, r2]
	
	lsr r1, #4
	add r0, r1
	
	bx lr

.ltorg
.align

EALiterals:
	@ none
