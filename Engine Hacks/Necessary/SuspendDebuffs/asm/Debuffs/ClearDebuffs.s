
	.thumb

	lDebuffTable     = EALiterals+0x00
	lDebuffTableSize = EALiterals+0x04

	CpuSet           = 0x080D1678|1

ClearDebuffs:
	mov r0, #0

	push {r0, lr}

	mov r0, sp
	ldr r1, lDebuffTable

	mov r3, #1
	lsl r3, #24

	ldr r2, lDebuffTableSize
	lsr r2, #1
	orr r2, r3

	ldr r3, =CpuSet

	bl BXR3

	pop {r0, r3}

BXR3:
	bx r3

	.pool
	.align

EALiterals:
	@ WORD DebuffTable
