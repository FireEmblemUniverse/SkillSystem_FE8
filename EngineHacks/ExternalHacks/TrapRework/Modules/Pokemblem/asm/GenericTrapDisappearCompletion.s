.thumb
.align

.global GenericTrapDisappearCompletionInitialization
.type GenericTrapDisappearCompletionInitialization, %function

.global GenericTrapDisappearCompletionUsability0x29
.type GenericTrapDisappearCompletionUsability0x29, %function
.global GenericTrapDisappearCompletionUsability0x2A
.type GenericTrapDisappearCompletionUsability0x2A, %function
.global GenericTrapDisappearCompletionUsability0x2B
.type GenericTrapDisappearCompletionUsability0x2B, %function

.global GenericTrapDisappearCompletionEffect
.type GenericTrapDisappearCompletionEffect, %function

.global GenericTrapDisappearCompletionSpriteFunc
.type GenericTrapDisappearCompletionSpriteFunc, %function


.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm


.ltorg
.align
.equ MemorySlot0,0x30004B8
.equ MemorySlot3,0x30004C4	@item ID to give @[0x30004C4]!
.equ GetTrapAt,0x802e1f0
.equ CheckEventId,0x8083da8
.equ SetFlag, 0x8083D80
.equ SpawnTrap,0x802E2B8 @r0 = x coord, r1 = y coord, r2 = trap ID
.equ Init_ReturnPoint,0x8037901
.equ UpdateGameTilesGraphics, 0x8019C3C 

@.equ GiveItemEvent, ObtainItemID+4

GenericTrapDisappearCompletionInitialization:
ldrb r0, [r5, #3] @ trap completion flag 
cmp r0, #0 
beq Skip 
blh CheckEventId 
cmp r0, #1 
beq ReturnPoint 
Skip: 
@r5 = pointer to trap data in events
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

ldr r4,=#0x3004E50
ldr r0,[r4]

mov r4, r0

ldrb r5,[r4,#0x10] @x coord
ldrb r6,[r4,#0x11] @y coord


mov r0,r5
sub r0,#1
mov r1,r6
blh GetTrapAt
cmp r0, #0 
beq CheckA 
mov r1, #0
ldrb r1,[r0,#2]

mov r2, #0x29
cmp r1, r2
bge CheckA 
b ReturnA
CheckA:
mov r2, #0x2B
cmp r1, r2
ble RetTrap

ReturnA:

mov r0,r5
mov r1,r6
sub r1,#1
blh GetTrapAt
cmp r0, #0 
beq CheckB 

mov r1, #0
ldrb r1,[r0,#2]

mov r2, #0x29
cmp r1, r2
bge CheckB 
b ReturnB
CheckB:
mov r2, #0x2B
cmp r1, r2
ble RetTrap

ReturnB:

mov r0,r5
add r0,#1
mov r1,r6
blh GetTrapAt
cmp r0, #0 
beq CheckC 

mov r1, #0
ldrb r1,[r0,#2]

mov r2, #0x29
cmp r1, r2
bge CheckC 
b ReturnC
CheckC:
mov r2, #0x2B
cmp r1, r2
ble RetTrap
ReturnC:

mov r0,r5
mov r1,r6
add r1,#1
blh GetTrapAt
cmp r0, #0 
beq ReturnD 

mov r1, #0
ldrb r1,[r0,#2]

mov r2, #0x29
cmp r1, r2
bge CheckD 
b ReturnD
CheckD:
mov r2, #0x2B
cmp r1, r2
ble RetTrap

ReturnD:
mov r0,#0	@no trap so return 0


RetTrap:
pop {r4-r6}
pop {r1}
bx r1

.ltorg
.align

GetAdjacentTrapIndividual: @r0 = unit we're checking for adjacency to
push {r4-r7,r14}
@r7 trap type to check against 
mov r4,r0

ldr r4,=#0x3004E50
ldr r0,[r4]

mov r4, r0

ldrb r5,[r4,#0x10] @x coord
ldrb r6,[r4,#0x11] @y coord


mov r0,r5
sub r0,#1
mov r1,r6
blh GetTrapAt
cmp r0, #0 
beq aCheckA 

mov r1, #0
ldrb r1,[r0,#2]

mov r2, r7
cmp r1, r2
beq RetTrapIndividual

aCheckA: 
mov r0,r5
mov r1,r6
sub r1,#1
blh GetTrapAt
cmp r0, #0 
beq aCheckB 
mov r1, #0
ldrb r1,[r0,#2]

mov r2, r7
cmp r1, r2
beq RetTrapIndividual
aCheckB: 

mov r0,r5
add r0,#1
mov r1,r6
blh GetTrapAt
cmp r0, #0 
beq aCheckC 
mov r1, #0
ldrb r1,[r0,#2]

mov r2, r7
cmp r1, r2
beq RetTrapIndividual

aCheckC: 
mov r0,r5
mov r1,r6
add r1,#1
blh GetTrapAt
cmp r0, #0 
beq aReturnD 
mov r1, #0
ldrb r1,[r0,#2]

mov r2, r7
cmp r1, r2
beq RetTrapIndividual
aReturnD: 
mov r0,#0	@no trap so return 0


RetTrapIndividual:
pop {r4-r7}
pop {r1}
bx r1



GenericTrapDisappearCompletionUsability0x29:
push {r4,r7,r14}
mov r7, #0x29
b GenericTrapDisappearCompletionUsability
GenericTrapDisappearCompletionUsability0x2A:
push {r4,r7,r14}
mov r7, #0x2A
b GenericTrapDisappearCompletionUsability
GenericTrapDisappearCompletionUsability0x2B:
push {r4,r7,r14}
mov r7, #0x2B
b GenericTrapDisappearCompletionUsability


GenericTrapDisappearCompletionUsability:
ldr r4,=#0x3004E50
ldr r0,[r4]
bl GetAdjacentTrapIndividual
mov r4, r0  @&The DV
cmp r0,#0
beq Usability_RetFalse


ldrb r0, [r4, #0x3]     @Completion flag

cmp r0, #0
beq CantoCheck

blh CheckEventId
cmp r0, #0
bne Usability_RetFalse

CantoCheck:
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
pop {r4, r7}
pop {r1}
bx r1

.ltorg
.align


GenericTrapDisappearCompletionEffect:
push {r4, lr}
@Basically the execute event routine.

@But first, we need to find the event associated with this location.
ldr r0, CurrentUnitPointer
ldr r0, [r0]

bl GetAdjacentTrap

mov r4, r0  @&The DV

ldrb r0, [r4, #3] @ flag 
blh SetFlag  @ this must occur before the event is executed, as when it is, the trap could be shifted around 

EventTime:

@ldr r1, =MemorySlot3	@[0x30004C4]!!
@mov r2, #0
@str r2,[r1]		@overwrite s3 with 0


mov r1, #0
ldrb r1, [r4, #0x5]     @effect id

push {r1}
@Remove the DV trap from the map.
mov r0, r4
ldr r3, RemoveTrap
bl goto_r3
pop {r1} 

lsl r1, #0x2	@4 bytes per table extry, so effectID * 4 = entry 
ldr r0, GTDTable
ldr r0, [r0, r1]


cmp r1, #0	@no table entry 
beq DeleteTrap

cmp r0, #0	@no event
beq DeleteTrap

cmp r0, #1	@dummy event
beq DeleteTrap


@At this point, r0 should be the pointer to the event to execute.
AlwaysEvent:
mov r1, #1 @ wait for event 
ldr r3, ExecuteEvent
bl goto_r3

@blh 0x801A1F4 @RefreshFogAndUnitMaps
@blh UpdateGameTilesGraphics 

DeleteTrap:




@ update unit map to have active unit at coord 
@ this is needed for events that load units with REDAs 
ldr r0, CurrentUnitPointer
ldr r0, [r0]
ldrb r3, [r0, #0x0B] @ deployment 
ldrb r1, [r0, #0x11] @ yy 
ldrb r0, [r0, #0x10] @ xx 
ldr r2, =0x202E4D8 @ unit map 
ldr		r2,[r2]			@Offset of map's table of row pointers
lsl		r1,#0x2			@multiply y coordinate by 4
add		r2,r1			@so that we can get the correct row pointer
ldr		r2,[r2]			@Now we're at the beginning of the row data
add		r2,r0			@add x coordinate
@ldrb	r0,[r2]			@load datum at those coordinates
strb r3, [r2] 

Continue:
ldr r1, CurrentUnitFateData	@these four lines copied from wait routine
mov r0, #0x1
strb r0, [r1,#0x11]
@mov r0, #0x17	@makes the unit wait?? makes the menu DisappearCompletion after command is selected??
mov r0,#0x94		@play beep sound & end menu on next frame & clear menu graphics

pop {r4}
pop {r3}
goto_r3:
bx r3

.ltorg 
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
.ltorg
.align
GTDTable:
    @.long 0xDEADBEEF @Should be defined in the install file

