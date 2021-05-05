@ Remove DR from a unit that's being cleared.
@ Hooks at 0x080177FC, in ClearUnitStruct.
.thumb

.equ	DRCounter,			0x03000006 @ Free space used to count how many DR's are active.
.equ	CPUSetmask,			0x01000024 @ Length/Mode used by CPUSet originally called by the function we hooked into.

@ Unit is going to be cleared. If DR-bit was set, decrement DRCounter.

ldrb	r1, [r4]		@ r4 holds pointer to unit data.
mov		r3, #0x0
cmp		r1, r3			@ Unit needs to exist
beq		Return

@ If unit is not enemy, return
ldrb  r1, [r4, #0xB]
mov   r3, #0x80
tst   r1, r3
beq   Return

mov		r1, #0x32
ldrb	r1, [r4, r1]	@ r4 holds pointer to unit data.
mov		r3, #0x40		@ Replace with a different bit..
tst		r3, r1			@ ...in unit struct, if in use.
beq		Return

ldr		r0, =DRCounter
ldrb	r3, [r0]
sub		r3, #0x1		@ Decrement DRCounter.
strb	r3, [r0]

Return:
mov		r1, r13
mov		r0, #0x0
strh	r0, [r1]
ldr		r2, =CPUSetmask
mov		r0, r13
mov		r1, r4

bx		r14
