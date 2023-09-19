.thumb
.align

.global ObtainItemInitialization
.type ObtainItemInitialization, %function

.global ObtainItemUsability0x10
.type ObtainItemUsability0x10, %function
.global ObtainItemUsability0x11
.type ObtainItemUsability0x11, %function
.global ObtainItemUsability0x12
.type ObtainItemUsability0x12, %function
.global ObtainItemUsability0x13
.type ObtainItemUsability0x13, %function
.global ObtainItemUsability0x14
.type ObtainItemUsability0x14, %function





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
.equ MemorySlot0,0x30004B8
.equ MemorySlot3,0x30004C4	@item ID to give @[0x30004C4]!
.equ GetTrapAt,0x802e1f0


.equ CheckEventId,0x8083da8

.equ SetFlag, 0x8083D80

.equ SpawnTrap,0x802E2B8 @r0 = x coord, r1 = y coord, r2 = trap ID
.equ Init_ReturnPoint,0x8037901
@.equ GiveItemEvent, ObtainItemID+4

ObtainItemInitialization:
mov r0, #0
ldrb r0, [r5, #4]     @Completion flag
ldrb r1, =ObtainItemFlagOffset 
lsl r1, #3 @8 flags per byte 
add r0, r1 

blh CheckNewFlag
cmp r0, #1 
beq ReturnPoint @if completion flag is true, then we do not spawn this trap :-) 

@r5 = pointer to trap data in events
ldrb r0,[r5,#1] @x coord
ldrb r1,[r5,#2] @y coord
ldrb r2,[r5] @trap ID
blh SpawnTrap @returns pointer to trap data in RAM

@give it our data
ldrb r1,[r5,#3] @save byte 0x3
strb r1,[r0,#3] 
ldrb r1,[r5,#4] @save byte 0x4
strb r1,[r0,#4]
ldrb r1,[r5,#5] @save byte 0x5
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

mov r2, #0x10
cmp r1, r2
bge CheckA 
b ReturnA
CheckA:
mov r2, #0x19
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

mov r2, #0x10
cmp r1, r2
bge CheckB 
b ReturnB
CheckB:
mov r2, #0x19
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

mov r2, #0x10
cmp r1, r2
bge CheckC 
b ReturnC
CheckC:
mov r2, #0x19
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

mov r2, #0x10
cmp r1, r2
bge CheckD 
b ReturnD
CheckD:
mov r2, #0x19
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

.ltorg
.align

ObtainItemUsability0x10:
push {r4,r7,r14}
mov r7, #0x10
b ObtainItemUsability
ObtainItemUsability0x11:
push {r4,r7,r14}
mov r7, #0x11
b ObtainItemUsability
ObtainItemUsability0x12:
push {r4,r7,r14}
mov r7, #0x12
b ObtainItemUsability
ObtainItemUsability0x13:
push {r4,r7,r14}
mov r7, #0x13
b ObtainItemUsability
ObtainItemUsability0x14:
push {r4,r7,r14}
mov r7, #0x14
b ObtainItemUsability




	.equ NewFlagsRam, 0x203F548
	
ObtainItemUsability:
ldr r4,=#0x3004E50
ldr r0,[r4]
bl GetAdjacentTrapIndividual
mov r4, r0  @&The DV

cmp r0,#0
beq Usability_RetFalse


	ldr 	r3, =NewFlagsRam
		ldrb	r1, [r3] @[0x203F548..0x203F648]!!?
	strb 	r1, [r3] @ [0x203F548]!! 



mov r0, #0
ldrb r0, [r4, #4]     @Completion flag
ldrb r1, =ObtainItemFlagOffset 
lsl r1, #3 @8 flags per byte 
add r0, r1 

blh CheckNewFlag
cmp r0, #0
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
pop {r4,r7}
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

@turn on completion flag 
mov r0, #0
ldrb r0, [r4, #4]     @Completion flag
cmp r0, #0
beq ItemToGive
ldrb r1, =ObtainItemFlagOffset 
lsl r1, #3 @8 flags per byte 
add r0, r1 
blh SetNewFlag

ItemToGive:
mov r2, #0			@empty it first 
ldr r1,=MemorySlot3
str r2,[r1]		@overwrite s3 with 0

ldrb r2, [r4, #0x3]     @item id
cmp r2, #0
beq DeleteTrap


ldr r1,=MemorySlot3
strb r2,[r1]		@overwrite s3 

ldr	r0, =GiveItemEvent	@this event gives item found in byte 0x4 of the trap
mov	r1, #0x01		@0x01 = wait for events
ldr r3, ExecuteEvent
bl goto_r3

b DeleteTrap

EventTime:
mov r1, #0
ldrb r1, [r4, #0x5]     @effect id
lsl r1, #0x2	@4 bytes per table extry, so effectID * 4 = entry 
ldr r0, ObtainEffectTableOffset
ldr r0, [r0, r1]

cmp r1, #0	@no table entry 
beq DeleteTrap

cmp r0, #0	@no event
beq DeleteTrap

cmp r0, #1	@dummy event
beq DeleteTrap

@At this point, r0 should be the pointer to the event to execute.

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
ObtainEffectTableOffset:
    @.long 0xDEADBEEF @Should be defined in the install file

