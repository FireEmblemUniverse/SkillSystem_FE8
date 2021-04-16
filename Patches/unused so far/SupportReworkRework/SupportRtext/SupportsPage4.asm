//thanks Snek
.thumb
.macro blh to, reg
    ldr \reg, =\to
    mov lr, \reg
    .short 0xF800
.endm

.equ Text_InitFont, 0x08003C94
.equ _ResetIconGraphics, 0x08003578

.global SupportReworkPageSwitch
.type SupportReworkPageSwitch, %function
SupportReworkPageSwitch: 

@ Autohook to 0x08088690. r0 should equal the number of stat screen pages to have upon hitting the strb r0, [ r5, #0x01 ].
@ r5 = StatScreenStruct. Preserve no scratch registers!

ldr r0, [ r5, #0x0C ] @ r0 = character struct.
bl CountSupports @ r0 = number of supports.
mov r1, #0x04 @ 4 pages if there are supports to show.
cmp r0, #0x00
bne NoSupportsStatScreen
    mov r1, #0x03 @ 3 pages if there no are supports to show.
    @ We also need to ensure that the stat screen does not try to load page 4 (because the user left from page 4 on the last stat screen).
    ldrb r0, [ r5 ] @ Current stat screen page.
    cmp r0, #0x03
    bne NoSupportsStatScreen
        mov r0, #0x00
        strb r0, [ r5 ] @ Move to page 1 instead of 4.
NoSupportsStatScreen:
mov r0, r1
strb r0, [ r5, #0x01 ]
blh Text_InitFont, r1
blh _ResetIconGraphics, r1
blh #0x08086DF0, r1
ldr r0, =#0x080886A1
bx r0

.align
.ltorg

.type CountSupports, %function
CountSupports: @ r0 = character struct. Returns the number of supports.
mov r2, #0x00
ldrb r1, [ r0, #0x0B ] @ Allegiance byte.
lsr r1, r1, #0x6
cmp r1, #0x00
bne EndCountSupports @ This character is not an ally. They can't have any supports.
mov r1, #0x00 @ r1 is a counter.
add r0, r0, #0x32 @start of support data in ram
CountSupportsLoop:
cmp r1, #0x07
beq EndCountSupports
ldrb r3, [ r0, r1 ]
add r1, r1, #0x01
cmp r3, #0x50 //c threshold
ble CountSupportsLoop
add r2, r2, #0x01
b CountSupportsLoop
EndCountSupports:
mov r0, r2
bx lr

.align
.ltorg

