@ Hook at 08027564. Adds an extra check, checking whether
@ FOW is active, and if not, prevent fog hiding tiledisplaymarker
.thumb

.equ ChapterData,			0x0202BCF0
.equ Fog,					0x0202E4E8

@ Check for FOW.
ldr		r0, =ChapterData
ldrb	r0, [r0,#0xD]
cmp		r0,	#0x0
beq		NoFOW

ldr		r0, =Fog
ldr		r0, [r0]
lsl		r1, r4, #0x2
add		r0, r1, r0
ldr		r0, [r0]
add		r0, r0, r5
ldrb	r0, [r0]
b		Return

NoFOW:
mov		r0,	r14
add		r0, #0xC
mov		r14, r0

Return:
bx		r14
