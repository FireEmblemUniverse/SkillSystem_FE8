@ Disable DZ-jingle and call UpdateGameTilesGraphics if no FOW.
@ Hooks at 0x0801CCD4.
.thumb

.equ ChapterData,				0x0202BCF0
.equ m4aSongNumStart,			0x080D01FD
.equ UpdateGameTilesGraphics,	0x08019C3D

push	{r14}

@ Check for FOW.
ldr		r0, =ChapterData
ldrb	r1, [r0,#0xD]
cmp		r1,	#0x0
beq		DZ

@ Previously overwritten.
mov		r1, r0
add		r1, #0x41
ldrb	r1, [r1]
lsl		r1, r1, #0x1E
mov		r2, #0x1		@ Used as return value.
cmp		r1, #0x0
blt		Return

mov		r0, #0x68
ldr		r1,	=m4aSongNumStart
bl		GOTO_R1
mov		r2, #0x1		@ Used as return value.
b		Return

DZ:
ldr		r1, =UpdateGameTilesGraphics
bl		GOTO_R1
ldr		r0, =ChapterData
ldrb	r2, [r0,#0xD]	@ Used as return value.

Return:
mov		r0, r2
pop		{r1}
GOTO_R1:
bx		r1
