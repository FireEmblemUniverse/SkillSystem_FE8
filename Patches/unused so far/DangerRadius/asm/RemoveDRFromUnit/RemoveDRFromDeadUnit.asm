@ Remove DR from an enemy that died after animated battle.
@ Hooks at 0x08032808, in BATTLE_ProbablyMakesTheDeadUnitDissapear (sic).
.thumb

.equ	TryRemoveUnitFromBallista,		0x08037a6d
.equ	DRCounter,						0x03000006 @ Free space used to count how many DR's are active.

push	{r14}

@ If unit is not enemy, return
ldrb  r1, [r0, #0xB]
mov   r2, #0x80
tst   r1, r2
beq   Return

@ Unit died. If DR-bit was set, decrement DRCounter.
@ Also, unset DR-bit.
ldr		r1, [r0, #0xC]
mov		r2, #0x32
ldrb	r2,	[r0, r2]
mov		r3, #0x40		@ Replace with a different bit...
tst		r3, r2			@ ...in unit struct, if in use.
beq		Return

@ Unset DR-bit and decrement DRCounter.
eor		r2, r3			@ Unset DR-bit.
mov		r3, #0x32
strb	r2, [r0, r3]
ldr		r2, =DRCounter
ldrb	r3, [r2]
sub		r3, #0x1		@ Decrement DRCounter.
strb	r3, [r2]

Return:
mov		r2,	#0x1
orr		r1, r2
str		r1, [r0, #0xC]
ldr		r0,	=TryRemoveUnitFromBallista
bl		GOTO_R0

pop		{r0}
GOTO_R0:
bx		r0
