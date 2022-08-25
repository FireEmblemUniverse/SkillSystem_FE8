.thumb
.align

.global GenericTrapInitialization
.type GenericTrapInitialization, %function



.global GenericTrapUsability0x30
.type GenericTrapUsability0x30, %function

.global GenericTrapUsability0x31
.type GenericTrapUsability0x31, %function

.global GenericTrapUsability0x32
.type GenericTrapUsability0x32, %function
.global GenericTrapUsability0x33
.type GenericTrapUsability0x33, %function
.global GenericTrapUsability0x34
.type GenericTrapUsability0x34, %function
.global GenericTrapUsability0x35
.type GenericTrapUsability0x35, %function
.global GenericTrapUsability0x36
.type GenericTrapUsability0x36, %function
.global GenericTrapUsability0x37
.type GenericTrapUsability0x37, %function
.global GenericTrapUsability0x38
.type GenericTrapUsability0x38, %function
.global GenericTrapUsability0x39
.type GenericTrapUsability0x39, %function
.global GenericTrapUsability0x3A
.type GenericTrapUsability0x3A, %function
.global GenericTrapUsability0x3B
.type GenericTrapUsability0x3B, %function
.global GenericTrapUsability0x3C
.type GenericTrapUsability0x3C, %function
.global GenericTrapUsability0x3D
.type GenericTrapUsability0x3D, %function






.global GenericTrapEffect
.type GenericTrapEffect, %function

.global GenericTrapSpriteFunc
.type GenericTrapSpriteFunc, %function


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
.equ UpdateImpassibleTrapTerrain, 0x802eb50 @   [0x802eb50]?
.equ UpdateAllLightRunes, 0x802E470 @  [0x802E470]?   

@.equ GiveItemEvent, ObtainItemID+4

GenericTrapInitialization:

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

ldr r1, =MemorySlot3
mov r2, #0
str r2, [r1]

@blh UpdateImpassibleTrapTerrain

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

mov r1, #0
ldrb r1,[r0,#2]

mov r2, #0x30
cmp r1, r2
bge CheckA 
b ReturnA
CheckA:
mov r2, #0x3D
cmp r1, r2
blt RetTrap

ReturnA:

mov r0,r5
mov r1,r6
sub r1,#1
blh GetTrapAt

mov r1, #0
ldrb r1,[r0,#2]

mov r2, #0x30
cmp r1, r2
bge CheckB 
b ReturnB
CheckB:
mov r2, #0x3D
cmp r1, r2
blt RetTrap

ReturnB:

mov r0,r5
add r0,#1
mov r1,r6
blh GetTrapAt

mov r1, #0
ldrb r1,[r0,#2]

mov r2, #0x30
cmp r1, r2
bge CheckC 
b ReturnC
CheckC:
mov r2, #0x3D
cmp r1, r2
blt RetTrap
ReturnC:

mov r0,r5
mov r1,r6
add r1,#1
blh GetTrapAt

mov r1, #0
ldrb r1,[r0,#2]

mov r2, #0x30
cmp r1, r2
bge CheckD 
b ReturnD
CheckD:
mov r2, #0x3D
cmp r1, r2
blt RetTrap

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

mov r1, #0
ldrb r1,[r0,#2]

mov r2, r7
cmp r1, r2
beq RetTrapIndividual


mov r0,r5
mov r1,r6
sub r1,#1
blh GetTrapAt

mov r1, #0
ldrb r1,[r0,#2]

mov r2, r7
cmp r1, r2
beq RetTrapIndividual


mov r0,r5
add r0,#1
mov r1,r6
blh GetTrapAt

mov r1, #0
ldrb r1,[r0,#2]

mov r2, r7
cmp r1, r2
beq RetTrapIndividual


mov r0,r5
mov r1,r6
add r1,#1
blh GetTrapAt

mov r1, #0
ldrb r1,[r0,#2]

mov r2, r7
cmp r1, r2
beq RetTrapIndividual

mov r0,#0	@no trap so return 0


RetTrapIndividual:
pop {r4-r7}
pop {r1}
bx r1


GenericTrapUsability0x30:
push {r4,r7,r14}
mov r7, #0x30
b GenericTrapUsability

GenericTrapUsability0x31:
push {r4,r7,r14}
mov r7, #0x31
b GenericTrapUsability

GenericTrapUsability0x32:
push {r4,r7,r14}
mov r7, #0x32
b GenericTrapUsability

GenericTrapUsability0x33: // CompletionObstacleID
push {r4,r7,r14}
mov r7, #0x33
ldr r4,=#0x3004E50
ldr r0,[r4]
bl GetAdjacentTrapIndividual
mov r4, r0  @&The DV
cmp r0,#0
beq Usability_RetFalse
b CantoCheck @ can use regardless of flag, though it should never spawn if flag was on 

b GenericTrapUsability

GenericTrapUsability0x34:
push {r4,r7,r14}
mov r7, #0x34
b GenericTrapUsability

GenericTrapUsability0x35:
push {r4,r7,r14}
mov r7, #0x35
b GenericTrapUsability

GenericTrapUsability0x36:
push {r4,r7,r14}
mov r7, #0x36
b GenericTrapUsability

GenericTrapUsability0x37:
push {r4,r7,r14}
mov r7, #0x37
b GenericTrapUsability

GenericTrapUsability0x38:
push {r4,r7,r14}
mov r7, #0x38
b GenericTrapUsability

GenericTrapUsability0x39:
push {r4,r7,r14}
mov r7, #0x39
b GenericTrapUsability

GenericTrapUsability0x3A:
push {r4,r7,r14}
mov r7, #0x3A
b GenericTrapUsability

GenericTrapUsability0x3B:
push {r4,r7,r14}
mov r7, #0x3B
b GenericTrapUsability

GenericTrapUsability0x3C:
push {r4,r7,r14}
mov r7, #0x3C
b GenericTrapUsability

GenericTrapUsability0x3D:
push {r4,r7,r14}
mov r7, #0x3D
b GenericTrapUsability



GenericTrapUsability:
ldr r4,=#0x3004E50
ldr r0,[r4]
bl GetAdjacentTrapIndividual
mov r4, r0  @&The DV
cmp r0,#0
beq Usability_RetFalse


ldrb r0, [r4, #0x3]     @Required Flag

cmp r0, #0
beq CantoCheck

blh CheckEventId
cmp r0, #1
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
pop {r4,r7}
pop {r1}
bx r1

.ltorg
.align


GenericTrapEffect:
push {r4, lr}
@Basically the execute event routine.

@But first, we need to find the event associated with this location.
ldr r0, CurrentUnitPointer
ldr r0, [r0]

bl GetAdjacentTrap

mov r4, r0  @&The DV

EventTime:

@ldr r1, =MemorySlot3	@[0x30004C4]!!
@mov r2, #0
@str r2,[r1]		@overwrite s3 with 0


mov r1, #0
ldrb r1, [r4, #0x5]     @effect id
lsl r1, #0x2	@4 bytes per table extry, so effectID * 4 = entry 
ldr r0, GTTable
ldr r0, [r0, r1]


cmp r1, #0	@no table entry 
beq DeleteTrap

cmp r0, #0	@no event
beq DeleteTrap

cmp r0, #1	@dummy event
beq DeleteTrap


@At this point, r0 should be the pointer to the event to execute.
AlwaysEvent:
mov r1, #1 
ldr r3, ExecuteEvent
bl goto_r3


DeleteTrap:
@Remove the DV trap from the map.
@ldr r3, RemoveTrap
@bl goto_r3



Continue:
ldr r1, CurrentUnitFateData	@these four lines copied from wait routine
mov r0, #0x10
strb r0, [r1,#0x11]
@mov r0, #0x17	@makes the unit wait?? makes the menu disappear after command is selected??
mov r0,#0x94		@play beep sound & end menu on next frame & clear menu graphics

pop {r4}
pop {r3}
goto_r3:
bx r3


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
GTTable:
    @.long 0xDEADBEEF @Should be defined in the install file

