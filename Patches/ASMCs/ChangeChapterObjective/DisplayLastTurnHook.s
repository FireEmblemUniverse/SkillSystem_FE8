.thumb
@ORG 0x8D3C0

.equ returnPoint,			0x808D3C9

ldr 	r3, =GetChapterTurnLimit @gives us chapter turn limit in r0
bl		BXR3

ldr		r3, =returnPoint
bx		r3

BXR3:
bx		r3
