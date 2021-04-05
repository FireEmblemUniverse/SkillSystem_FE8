
.thumb

.equ gMemorySlot, 0x030004B8
.equ GetUnitByEventParameter, 0x0800BC50

.macro blh to, reg
    ldr \reg, =\to
    mov lr, \reg
    .short 0xF800
.endm

.global SetUnitState
.type SetUnitState, %function
SetUnitState: @ Memory slot 0x1 = character ID, slot 0x2 = state bitfield to orr with.
push { r4, lr }
ldr r4, =gMemorySlot
mov r1, #0x04
ldsh r0, [ r4, r1 ] @ Character ID. Load signed in case 0xFFFF and co were passed in.
blh GetUnitByEventParameter, r1 @ r0 = character struct.
ldr r1, [ r0, #0x0C ]
ldr r2, [ r4, #0x08 ] @ Orr with this bitfield.
orr r1, r1, r2
str r2, [ r0, #0x0C ]
pop { r4 }
pop { r0 }
bx r0
