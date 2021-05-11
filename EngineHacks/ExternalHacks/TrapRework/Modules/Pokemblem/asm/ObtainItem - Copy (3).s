.thumb
.align

.global ObtainItemInitialization
.type ObtainItemInitialization, %function

.global ObtainItemUsability
.type ObtainItemUsability, %function

.global ObtainItemEffect
.type ObtainItemEffect, %function

.global ObtainItemSpriteFunc
.type ObtainItemSpriteFunc, %function


.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm


.ltorg
.align

.equ MemorySlot3,0x30004C4	@item ID to give 
.equ GetTrapAt,0x802e1f0
.equ CheckEventId,0x8083da8
.equ SetFlag, 0x8083D80
.equ SpawnTrap,0x802E2B8 @r0 = x coord, r1 = y coord, r2 = trap ID
.equ Init_ReturnPoint,0x8037901
@.equ GiveItemEvent, ObtainItemID+4

ObtainItemInitialization:

@r5 = pointer to trap data in events
ldrb r0,[r5,#1] @x coord
ldrb r1,[r5,#2] @y coord

@add CompletionFlag check here to prevent it from spawning would be nice
mov r0, #0xB0
blh CheckEventId
cmp r0, #0
bne ReturnPoint
@does not seem to work tho not sure why


ldrb r0,[r5,#1] @x coord
ldrb r1,[r5,#2] @y coord
ldrb r2,[r5] @trap ID
blh SpawnTrap @returns pointer to trap data in RAM

@give it our vision range data 
ldrb r1,[r5,#3] @initial vision range
strb r1,[r0,#3] 
ldrb r1,[r5,#4] @set vision range
strb r1,[r0,#4]
ldrb r1,[r5,#5] @set vision range
strb r1,[r0,#5]

ReturnPoint:
ldr r3,=Init_ReturnPoint
bx r3



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

mov r2, #0x2A
@ldr r2,=RedPokeballItemID
@ldrb r2,[r2]
cmp r1,r2
beq RetTrap

mov r2, #0x2B
@ldr r2,=GoldPokeballItemID
@ldrb r2,[r2]
cmp r1,r2
beq RetTrap

mov r2, #0x2C
@ldr r2,=HiddenPokeballItemID
@ldrb r2,[r2]
cmp r1,r2
beq RetTrap

mov r0,r5
mov r1,r6
sub r1,#1
blh GetTrapAt

ldrb r1,[r0,#2]

mov r2, #0x2A
@ldr r2,=RedPokeballItemID
@ldrb r2,[r2]
cmp r1,r2
beq RetTrap

mov r2, #0x2B
@ldr r2,=GoldPokeballItemID
@ldrb r2,[r2]
cmp r1,r2
beq RetTrap

mov r2, #0x2C
@ldr r2,=HiddenPokeballItemID
@ldrb r2,[r2]
cmp r1,r2
beq RetTrap

mov r0,r5
add r0,#1
mov r1,r6
blh GetTrapAt

ldrb r1,[r0,#2]

mov r2, #0x2A
@ldr r2,=RedPokeballItemID
@ldrb r2,[r2]
cmp r1,r2
beq RetTrap

mov r2, #0x2B
@ldr r2,=GoldPokeballItemID
@ldrb r2,[r2]
cmp r1,r2
beq RetTrap

mov r2, #0x2C
@ldr r2,=HiddenPokeballItemID
@ldrb r2,[r2]
cmp r1,r2
beq RetTrap

mov r0,r5
mov r1,r6
add r1,#1
blh GetTrapAt

ldrb r1,[r0,#2]

mov r2, #0x2A
@ldr r2,=RedPokeballItemID
@ldrb r2,[r2]
cmp r1,r2
beq RetTrap

mov r2, #0x2B
@ldr r2,=GoldPokeballItemID
@ldrb r2,[r2]
cmp r1,r2
beq RetTrap

mov r2, #0x2C
@ldr r2,=HiddenPokeballItemID
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


ObtainItemUsability:
push {r4,r14}
ldr r4,=#0x3004E50
ldr r0,[r4]
bl GetAdjacentTrap
cmp r0,#0
beq Usability_RetFalse


ldrb r0, [r4, #0x3]     @Completion flag
blh CheckEventId
cmp r0, #1
bne Usability_RetFalse





ldr r4,=#0x3004E50
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



ObtainItemEffect:
push {r4, lr}
@Basically the execute event routine.

@But first, we need to find the event associated with this location.
ldr r0, CurrentUnitPointer
ldr r0, [r0]

bl GetAdjacentTrap
mov r4, r0  @&The DV


ldrb r2, [r4, #0x4]     @item id
cmp r2, #0
beq EventTime


ldr r1,=MemorySlot3
ldr r0,[r1]
ldr r0,[r0]

str r2,[r1]		@overwrite s3 


ldr	r0, =GiveItemEvent	@this event is just "give gem"
mov	r1, #0x01		@0x01 = wait for events
ldr r3, ExecuteEvent
bl goto_r3

EventTime:
ldrb r1, [r4, #0x5]     @effect id
lsl r1, #0x2
ldr r0, TrapEffectTableOffset
ldr r0, [r0, r1]

@ldr r0, =#0x8BD6B70	
cmp r1, #0
beq DeleteTrap
cmp r1, #1
beq DeleteTrap

cmp r0, #0
beq DeleteTrap

@At this point, r0 should be the pointer to the event to execute.

ldr r3, ExecuteEvent
bl goto_r3

    @check if DV should be removed.
    @ldrb r0, [r4, #6] @nope, can only have 6 bytes per trap data
    @cmp r0, #1
    @bgt ReduceUses

DeleteTrap:
@Remove the DV trap from the map.


@turn on completion flag 
ldrb r0, [r4, #0x3]     @Completion flag
blh SetFlag




@ldr r3, RemoveTrap
@bl goto_r3



Continue:
ldr r1, CurrentUnitFateData	@these four lines copied from wait routine
mov r0, #0x1
strb r0, [r1,#0x11]
@mov r0, #0x17	@makes the unit wait?? makes the menu disappear after command is selected??


mov r0,#0x94		@play beep sound & end menu on next frame & clear menu graphics

pop {r4}
pop {r3}
goto_r3:
bx r3




ObtainItemSpriteFunc:
push {r4,r14}
mov r4,r0 @r4 = trap data ptr

ldrb r0,[r4,#3]	@completion flag
blh CheckEventId
cmp r0, #0
bne HiddenSprite	@break if no sprite to display
mov r0, #0x6A
b MapSpriteFunc_GoBack

HiddenSprite:
blh TrapRework_NewUpdateAllLightRunes
ldr r0,=HiddenMapSpriteID
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
    @.long 0xDEADBEEF @Should be defined in the install file

