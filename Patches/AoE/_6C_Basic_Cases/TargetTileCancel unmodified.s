.thumb
.include "../_Definitions.h.s"

push {r4, r14}
mov r4, r0

_blh prMoveRange_HideGfx

ldr r3, =ppActiveUnit
ldr r3, [r3]
ldrb r0, [r3, #0x10]
ldrb r1, [r3, #0x11]

_blh prSetCursorMapPosition

ldr r0, =p6C_GBToUnitMenu
mov r1, #3

_blh pr6C_New

mov r0, #0x0A @ Ends selection & Plays boop sound
pop {r4}

pop {r1}
bx r1

.ltorg
.align
