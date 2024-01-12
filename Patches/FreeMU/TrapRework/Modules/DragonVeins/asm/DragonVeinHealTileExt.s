
.macro blh to, reg
    ldr \reg, =\to
    mov lr, \reg
    .short 0xF800
.endm

.thumb
.global DrawingOffset_External
.type DrawingOffset_External, %function

DrawingOffset_External:
cmp r0, #0x0D
beq Label1
ldr r1, =DVTrapIDLink
ldrb r1, [ r1 ]
cmp r0, r1
beq Label2
ldr r1, =HealTileTrapIDLink
ldrb r1, [ r1 ]
cmp r0, r1
beq HealTileStuff
b End

Label1:
mov r0, #0x66
ldr r1, =#0xFFFFB080
b Label3

Label2:
ldr r0, =DVMapSpriteIDLink
ldrb r0, [ r0 ]
ldr r1, =#0xFFFFC080
b Label3

HealTileStuff:
@ Now to check if the event ID is set. r4 has the current trap struct pointer. +0x7 has the event ID.
ldrb r0, [ r4, #0x07 ]
blh #0x08083DA8, r1
cmp r0, #0x00
bne End @ If the event ID isn't 0 (unset), exit.
ldr r0, =HealTileMapSpriteIDLink
ldrb r0, [ r0 ]
ldr r1, =#0xFFFFD080
@ b Label3

Label3:
push { r1 }
push { r0 }
ldr r1, =#0x08027321
ldrb r0, [ r4, #0x01 ]
lsl r0, r0, #0x04
b End2

End:
ldr r1, =#0x08027345
End2:
bx r1
