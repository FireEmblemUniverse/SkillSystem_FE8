.thumb
@.org 0x5C24
@This routine is passed Portrait Number

ldr r1, ShiftPortraitTable
@add ShiftPortraitTable to Portrait Number

@load the byte at that location
ldrb r0, [r1, r0]

bx r14

.align
ShiftPortraitTable:
