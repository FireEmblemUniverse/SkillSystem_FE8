.thumb
.include "_Definitions.h.s"

.set PurgeVRAM, 0x8003D20

push {r4,r14}
mov 	r4, r0

ldr r0, =ppRangeMapRows
ldr r0, [r0]
mov r1, #0x0

_blh prMap_Fill

_blh prMoveRange_HideGfx
_blh prBottomHelpDisplay_EndAll
_blh PurgeVRAM
pop 	{r4}
pop 	{r3}
bx	r3
.ltorg
.align
