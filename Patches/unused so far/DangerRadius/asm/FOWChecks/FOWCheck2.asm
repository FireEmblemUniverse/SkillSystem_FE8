@ If no FOW: Invert fog tile marks: 0: nofog, 1: fog.
@ Hooks at 0x08019B40.
.thumb

.equ ChapterData,				0x0202BCF0
.equ m4aSongNumStart,			0x080D01FD
.equ UpdateGameTilesGraphics,	0x08019C3D

@ Previously overwritten.
ldr		r0, [r4]
add		r0, r0, r3
ldrb	r0, [r0]
mov		r3, #0xB0
lsl		r3, r3, #0x8

@ Check for FOW.
ldr		r1, =ChapterData
ldrb	r1, [r1,#0xD]
cmp		r1,	#0x0
bne		Original

@ Invert.
cmp		r0, #0x0
bne		Jump
b		Return

Original:
cmp		r0, #0x0
bne		Return

Jump:
mov		r1, r14
add		r1, #0xC
mov		r14, r1

Return:
bx		r14
