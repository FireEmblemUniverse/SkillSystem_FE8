@ Called at 0801B86C. Adds an extra check to this loop, checking the DR-bit,
@ to determine whether or not to display this unit's Danger Radius.
.thumb

.equ ChapterData,			0x0202BCF0

@ Check for FOW.
ldr		r0, =ChapterData
ldrb	r0, [r0,#0xD]
cmp		r0,	#0x0
bne		NoDR

mov		r0,	r14
add		r0, #0x1A
mov		r14, r0

mov		r0, #0x32
ldrb	r0, [r4, r0]	@ Replace with a different bit...
mov		r2,	#0x40		@ ...in unit struct, if in use.
tst		r0, r2
b		Return

NoDR:
mov		r1, #0x11
ldsb	r1, [r4, r1]

Return:
bx		r14
