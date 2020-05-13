.thumb
.align

.global NewWrankIconGetter
.type NewWrankIconGetter, %function

.global AttackWrankDraw
.type AttackWrankDraw, %function

.global UnitAffinityDraw
.type UnitAffinityDraw, %function

.global UnitWrankDraw
.type UnitWrankDraw, %function

.global UnitSortWrankDraw
.type UnitSortWrankDraw, %function

.global RescueMountTypeDraw
.type RescueMountTypeDraw, %function

.global SupportAffinityDraw
.type SupportAffinityDraw, %function

.global SupportSSAffinityDraw
.type SupportSSAffinityDraw, %function


.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.equ ReturnPoint,0x80877B9


NewWrankIconGetter:
@we broke r3 so
@mov r3,r1
@and now we do the vanilla func verbatim until the point we need

ldr r0,=#0x2003BFC
ldr r0,[r0,#0xC]
add r0,#0x28
add r0,r0,r1
ldrb r5,[r0]
lsl r4,r2,#5
add r0,r4,r6
lsl r0,r0,#1
ldr r2,=#0x2003D2C
mov r8,r2
add r0,r8
mov r3,#4 @sheet ID
lsl r3,r3,#8 @shifted left 8 bits
orr r1,r3
mov r2,#0xA0
lsl r2,r2,#7

ldr r3,=ReturnPoint
bx r3

.ltorg
.align


.equ ReturnPoint2,0x801EA19

@8-byte r3 hook @ 1EA10
AttackWrankDraw:

mov r1,#4 @sheet ID
lsl r1,r1,#8 @shifted left 8 bits
orr r1,r0

ldr r0,[sp,#8]
lsl r2,r0,#0xC
mov r0,r4

ldr r3,=ReturnPoint2
bx r3

.ltorg
.align

.equ ReturnPoint3,0x8092795

UnitAffinityDraw:
mov r0,r5
add r0,#0x34

mov r2,#2 @sheet ID
lsl r2,r2,#8 @shifted 8 bits left
orr r1,r2

mov r2,#0xA0
lsl r2,r2,#7

ldr r3,=ReturnPoint3
bx r3

.ltorg
.align


.equ ReturnPoint4,0x8092205

UnitWrankDraw:
mov r2,#4 @sheet ID
lsl r2,r2,#8 @shifted 8 bits left
orr r1,r2

mov r0,r4
mov r2,#0xA0
lsl r2,r2,#7

ldr r3,=ReturnPoint4
bx r3

.ltorg
.align



.equ ReturnPoint5,0x80902BB

UnitSortWrankDraw: @hook at 902B0

mov r1,r6
mov r0,#4 @sheet ID
lsl r0,r0,#8 @shifted 8 bits left
orr r1,r0
mov r0,r10
add r0,#8
mov r2,#0xA0
lsl r2,r2,#7

ldr r3,=ReturnPoint5
bx r3

.ltorg
.align



.equ ReturnPoint6,0x8034B01

RescueMountTypeDraw: @hook at 34AF8

mov r1,r0
mov r2,#3 @icon sheet ID
lsl r2,r2,#8 @shifted 8 bits left
orr r1,r2

mov r2,#0xA0
lsl r2,r2,#7
mov r0,r4

ldr r3,=ReturnPoint6
bx r3

.ltorg
.align


.equ ReturnPoint7,0x80A1DA7

SupportAffinityDraw: @hook at A1D9C

ldrb r1,[r0,#9]
sub r1,#1
mov r2,#2 @icon sheet ID
lsl r2,r2,#8 @shifted 8 bits left
orr r1,r2

mov r2,#0xE0
lsl r2,r2,#8
mov r0,r4

ldr r3,=ReturnPoint7
bx r3

.ltorg
.align


.equ ReturnPoint8,0x8087711

SupportSSAffinityDraw: @hook at 87708

mov r1,r0
mov r2,#0x7A
sub r1,r2

mov r0,#2 @sheet ID
lsl r0,r0,#8 @shifted 8 bits left
orr r1,r0

mov r0,r5
mov r2,#0xA0
lsl r2,r2,#7

ldr r3,=ReturnPoint8
bx r3

.ltorg
.align

