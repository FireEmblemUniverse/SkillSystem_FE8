.thumb
@ORG 0x8D2D8

.equ returnPoint,			0x808D2F3
.equ String_GetFromIndex,	0x800A241

mov		r0, #0x0 @short chapter objective
ldr 	r3, =GetChapterObjective @and this gives us the textid in r0
bl		BXR3

ldr		r3, =String_GetFromIndex
bl		BXR3
mov		r5,r0

ldr		r0, =returnPoint
bx		r0

BXR3:
bx		r3
