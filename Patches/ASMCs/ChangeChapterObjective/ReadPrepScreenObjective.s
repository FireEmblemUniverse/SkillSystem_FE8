.thumb
@ORG 0x95A90

.equ returnPoint,			0x8095AB7
.equ String_GetFromIndex,	0x800A241

mov		r0, #0x1 @long chapter objective
ldr 	r3, =GetChapterObjective @and this gives us the textid in r0
bl		BXR3

ldr		r3, =String_GetFromIndex
bl		BXR3
mov		r4,r0

ldr		r0, =returnPoint
bx		r0

BXR3:
bx		r3
