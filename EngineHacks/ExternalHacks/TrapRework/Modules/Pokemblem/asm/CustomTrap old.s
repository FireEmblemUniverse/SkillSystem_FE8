.thumb
.align

.global MyTrapInitialization
.type MyTrapInitialization, %function

.global MyTrapUsability
.type MyTrapUsability, %function

.global MyTrapEffect
.type MyTrapEffect, %function

.global MyTrapSpriteFunc
.type MyTrapSpriteFunc, %function


.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm





.equ SpawnTrap,0x802E2B8 @r0 = x coord, r1 = y coord, r2 = trap ID
.equ Init_ReturnPoint,0x8037901

MyTrapInitialization:

@r5 = pointer to trap data in events
ldrb r0,[r5,#1] @x coord
ldrb r1,[r5,#2] @y coord
ldrb r2,[r5] @trap ID
blh SpawnTrap @returns pointer to trap data in RAM

@give it our vision range data @make it hold our map sprite id to display
ldrb r1,[r5,#3] @initial vision range
strb r1,[r0,#3] 
ldrb r1,[r5,#4] @set vision range
strb r1,[r0,#4]

ldr r3,=Init_ReturnPoint
bx r3

.ltorg
.align


.equ GetTrapAt,0x802e1f0

GetAdjacentTrap: @r0 = unit we're checking for adjacency to
push {r4-r6,r14}
mov r4,r0

ldrb r5,[r4,#0x10] @x coord
ldrb r6,[r4,#0x11] @y coord

mov r0,r5
sub r0,#1
mov r1,r6
blh GetTrapAt

ldrb r1,[r0,#2]
mov r2, #0x2D
@ldr r2,=TelliusTorchTrapIDLink
@ldrb r2,[r2]
cmp r1,r2
beq RetTrap

mov r0,r5
mov r1,r6
sub r1,#1
blh GetTrapAt

ldrb r1,[r0,#2]
mov r2, #0x2D
@ldr r2,=TelliusTorchTrapIDLink
@ldrb r2,[r2]
cmp r1,r2
beq RetTrap

mov r0,r5
add r0,#1
mov r1,r6
blh GetTrapAt

ldrb r1,[r0,#2]
mov r2, #0x2D
@ldr r2,=TelliusTorchTrapIDLink
@ldrb r2,[r2]
cmp r1,r2
beq RetTrap

mov r0,r5
mov r1,r6
add r1,#1
blh GetTrapAt

ldrb r1,[r0,#2]
mov r2, #0x2D
@ldr r2,=TelliusTorchTrapIDLink
@ldrb r2,[r2]
cmp r1,r2
beq RetTrap

mov r0,#0

RetTrap:
pop {r4-r6}
pop {r1}
bx r1

.ltorg
.align



MyTrapUsability:
push {r4,r14}
ldr r4,=#0x3004E50
ldr r0,[r4]
bl GetAdjacentTrap
cmp r0,#0
beq Usability_RetFalse

@can't use if cantoing
ldr r0,[r4]
ldr r0,[r0,#0xC]
mov r1,#0x40
and r0,r1
cmp r0,#0
beq Usability_RetTrue

Usability_RetFalse:
mov r0,#3
b Usability_GoBack

Usability_RetTrue:
mov r0,#1

Usability_GoBack:
pop {r4}
pop {r1}
bx r1

.ltorg
.align



MyTrapEffect:
push {r4, lr}
@Basically the execute event routine.

@But first, we need to find the event associated with this location.
ldr r0, CurrentUnitPointer
ldr r0, [r0]

bl GetAdjacentTrap


mov r4, r0  @&The DV
ldrb r1, [r4, #0x3]     @effect id
lsl r1, #0x2
ldr r0, TrapEffectTableOffset
ldr r0, [r0, r1]

@ldr r0, =#0x8BD6B70	

cmp r0, #0
beq DeleteTrap


mov r1, #0x0            @Fade at the end?
@At this point, r0 should be the pointer to the event to execute.

ldr r3, ExecuteEvent
bl goto_r3

    @check if DV should be removed.
    @ldrb r0, [r4, #6] @nope, can only have 6 bytes per trap data
    @cmp r0, #1
    @bgt ReduceUses

DeleteTrap:
@Remove the DV trap from the map.
mov r0, r4

ldr r3, RemoveTrap
bl goto_r3

@b Continue
@ReduceUses: 
@cmp r0, #0xFF @0xff means infinite use
@beq Continue
@sub r0, #1

Continue:
ldr r1, CurrentUnitFateData	@these four lines copied from wait routine
mov r0, #0x10
strb r0, [r1,#0x11]
mov r0, #0x17	@makes the unit wait?? makes the menu disappear after command is selected??


@mov r0,#0x94		@play beep sound & end menu on next frame & clear menu graphics

pop {r4}
pop {r3}
goto_r3:
bx r3




MyTrapSpriteFunc:
push {r4,r14}
mov r4,r0 @r4 = trap data ptr

ldrb r1,[r4,#3]
cmp r1,#0
beq MapSpriteFunc_GoBack	@break if no sprite to display

@ replace 

blh TrapRework_NewUpdateAllLightRunes
ldrb r0,[r4,#3]
ldrb r0,[r0]

MapSpriteFunc_GoBack:
pop {r4}
pop {r1}
bx r1

.ltorg
.align

ExecuteEvent:
	.long 0x800D07D @AF5D
CurrentUnitFateData:
	.long 0x203A958
CurrentUnitPointer:
	.long 0x3004E50
GetTrap:
    .long 0x802E1F1
RemoveTrap:
    .long 0x802EA91
TrapEffectTableOffset:
@EventAddressTable:
    @.long 0xDEADBEEF @Should be defined in the install file
