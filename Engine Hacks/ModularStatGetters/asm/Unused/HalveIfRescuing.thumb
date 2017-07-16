.thumb

.macro blh to, reg=r3
	ldr \reg, =\to
	mov lr, \reg
	.short 0xF800
.endm

HalveIfRescuing:
	ldr r1, [r1, #0xC] @ loading unit state flags
	mov r2, #0x10
	and r1, r2
	
	cmp r1, #0
	beq SkipHalving
	
	asr r0, #1
	
SkipHalving:
	bx lr

.ltorg
.align

EALiterals:
	@ none
