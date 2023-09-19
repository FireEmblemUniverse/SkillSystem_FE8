.thumb
.align

.global GenericTrapDisappearInitialization
.type GenericTrapDisappearInitialization, %function

.global GenericTrapDisappearUsability0x20
.type GenericTrapDisappearUsability0x20, %function
.global GenericTrapDisappearUsability0x21
.type GenericTrapDisappearUsability0x21, %function
.global GenericTrapDisappearUsability0x22
.type GenericTrapDisappearUsability0x22, %function
.global GenericTrapDisappearUsability0x23
.type GenericTrapDisappearUsability0x23, %function
.global GenericTrapDisappearUsability0x24
.type GenericTrapDisappearUsability0x24, %function
.global GenericTrapDisappearUsability0x25
.type GenericTrapDisappearUsability0x25, %function
.global GenericTrapDisappearUsability0x26
.type GenericTrapDisappearUsability0x26, %function
.global GenericTrapDisappearUsability0x27
.type GenericTrapDisappearUsability0x27, %function
.global GenericTrapDisappearUsability0x28
.type GenericTrapDisappearUsability0x28, %function



.global GenericTrapDisappearEffect
.type GenericTrapDisappearEffect, %function

.global GenericTrapDisappearSpriteFunc
.type GenericTrapDisappearSpriteFunc, %function


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
@.equ GiveItemEvent, ObtainItemID+4

GenericTrapDisappearInitialization:

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

mov r2, #0x20
cmp r1, r2
bge CheckA 
b ReturnA
CheckA:
mov r2, #0x29
cmp r1, r2
blt RetTrap

ReturnA:

mov r0,r5
mov r1,r6
sub r1,#1
blh GetTrapAt
cmp r0, #0 
beq CheckB 

mov r1, #0
ldrb r1,[r0,#2]

mov r2, #0x20
cmp r1, r2
bge CheckB 
b ReturnB
CheckB:
mov r2, #0x29
cmp r1, r2
blt RetTrap

ReturnB:

mov r0,r5
add r0,#1
mov r1,r6
blh GetTrapAt
cmp r0, #0 
beq CheckC 

mov r1, #0
ldrb r1,[r0,#2]

mov r2, #0x20
cmp r1, r2
bge CheckC 
b ReturnC
CheckC:
mov r2, #0x29
cmp r1, r2
blt RetTrap
ReturnC:

mov r0,r5
mov r1,r6
add r1,#1
blh GetTrapAt
cmp r0, #0 
beq ReturnD 

mov r1, #0
ldrb r1,[r0,#2]

mov r2, #0x20
cmp r1, r2
bge CheckD 
b ReturnD
CheckD:
mov r2, #0x29
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



GenericTrapDisappearUsability0x20:
push {r4,r7,r14}
mov r7, #0x20
b GenericTrapDisappearUsability
GenericTrapDisappearUsability0x21:
push {r4,r7,r14}
mov r7, #0x21
b GenericTrapDisappearUsability
GenericTrapDisappearUsability0x22:
push {r4,r7,r14}
mov r7, #0x22
b GenericTrapDisappearUsability
GenericTrapDisappearUsability0x23:
push {r4,r7,r14}
mov r7, #0x23
b GenericTrapDisappearUsability
GenericTrapDisappearUsability0x24:
push {r4,r7,r14}
mov r7, #0x24
b GenericTrapDisappearUsability
GenericTrapDisappearUsability0x25:
push {r4,r7,r14}
mov r7, #0x25
b GenericTrapDisappearUsability
GenericTrapDisappearUsability0x26:
push {r4,r7,r14}
mov r7, #0x26
b GenericTrapDisappearUsability
GenericTrapDisappearUsability0x27:
push {r4,r7,r14}
mov r7, #0x27
b GenericTrapDisappearUsability
GenericTrapDisappearUsability0x28:
push {r4,r7,r14}
mov r7, #0x28
b GenericTrapDisappearUsability


GenericTrapDisappearUsability:
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
pop {r4, r7}
pop {r1}
bx r1

.ltorg
.align


GenericTrapDisappearEffect:
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
ldr r3, ExecuteEvent
bl goto_r3


DeleteTrap:
@Remove the DV trap from the map.
mov r0, r4
ldr r3, RemoveTrap
bl goto_r3



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
GTDTable:
    @.long 0xDEADBEEF @Should be defined in the install file

