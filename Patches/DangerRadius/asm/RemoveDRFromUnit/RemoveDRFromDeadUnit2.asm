@ Remove DR from an enemy that died after map battle.
@ Hooks at 0x08018400, in Phantom_Check.
.thumb

.equ	DRCounter,						0x03000006 @ Free space used to count how many DR's are active.

@ If unit is not enemy, return
ldrb  r0, [r2, #0xB]
mov   r3, #0x80
tst   r3, r0
beq   Return1

@ Unit died. If DR-bit was set, decrement DRCounter.
@ Also, unset DR-bit.
mov		r0, #0x32
ldrb	r0,	[r2, r0]  @ r2 holds pointer to unit data.
mov		r3, #0x40		@ Replace with a different bit...
tst		r3, r0			@ ...in unit struct, if in use.
beq		Return1

@ Unset DR-bit and decrement DRCounter.
eor		r0, r3
mov		r3, #0x32
strb	r0, [r2, r3]	@ Unset DR-bit.

ldr		r0, =DRCounter
ldrb	r3, [r0]
sub		r3, #0x1		@ Decrement DRCounter.
strb	r3, [r0]

Return1:
@ We overwrote the hook to Capture's Should_Dead_Unit_Be_Cleared
@ So we repeat its contents here
@r2 = char data of dead unit
@return 1 in r1 if unit should be cleared, or 0 if they should not

ldrb	r1,[r2,#0xB]
mov		r0,#0xC0
and		r1,r0
cmp		r1,#0
beq		Return2		@player units don't get cleared
ldr		r0,[r2,#0xC]
mov		r3,#0x20	@being rescued
tst		r0,r3

bne		Return2		@ Figuring this out was such a pain.
mov		r0, r14
add		r0, #0x22	@ We wrote over a branch.
mov		r14, r0

Return2:
bx		r14
