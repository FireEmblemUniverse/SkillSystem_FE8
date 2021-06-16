.thumb
.align 

.global TeleportSignInitialization
.type TeleportSignInitialization, %function

.global TeleportSignAUsability0x60
.type TeleportSignAUsability0x60, %function

.global TeleportSignBUsability0x61
.type TeleportSignBUsability0x61, %function


.global TeleportSignAEffect
.type TeleportSignAEffect, %function

.global TeleportSignBEffect
.type TeleportSignBEffect, %function

.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm


.ltorg
.align
.equ MemorySlot0,0x30004B8
.equ MemorySlot2,0x30004C0	@textID to show @[0x30004C0]!
.equ GetTrapAt,0x802e1f0
.equ gTrapArray,0x203a614 	@location of traps in memory

.equ CheckEventId,0x8083da8

.equ SetFlag, 0x8083D80

.equ SpawnTrap,0x802E2B8 @r0 = x coord, r1 = y coord, r2 = trap ID
.equ Init_ReturnPoint,0x8037901
@.equ GiveCoinsEvent, TeleportSignAID+4

TeleportSignInitialization:
TeleportSignInitialization:
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

@ldr r4,=#0x3004E50
@ldr r4,[r4]



ldrb r5,[r4,#0x10] @x coord
ldrb r6,[r4,#0x11] @y coord


mov r0,r5
sub r0,#1
mov r1,r6
blh GetTrapAt

mov r1, #0
ldrb r1,[r0,#2]

mov r2, #0x60
cmp r1, r2
bge CheckA 
b ReturnA
CheckA:
mov r2, #0x62
cmp r1, r2
blt RetTrap

ReturnA:

mov r0,r5
mov r1,r6
sub r1,#1
blh GetTrapAt

mov r1, #0
ldrb r1,[r0,#2]

mov r2, #0x60
cmp r1, r2
bge CheckB 
b ReturnB
CheckB:
mov r2, #0x62
cmp r1, r2
blt RetTrap

ReturnB:

mov r0,r5
add r0,#1
mov r1,r6
blh GetTrapAt

mov r1, #0
ldrb r1,[r0,#2]

mov r2, #0x60
cmp r1, r2
bge CheckC 
b ReturnC
CheckC:
mov r2, #0x62
cmp r1, r2
blt RetTrap
ReturnC:

mov r0,r5
mov r1,r6
add r1,#1
blh GetTrapAt

mov r1, #0
ldrb r1,[r0,#2]

mov r2, #0x60
cmp r1, r2
bge CheckD 
b ReturnD
CheckD:
mov r2, #0x62
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
mov r7, r1 
@ldr r4,=#0x3004E50
@ldr r4,[r4]


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

.ltorg
.align


TeleportSignAUsability0x60:
push {r4,r7,r14}
mov r7, #0x60
b TeleportSignUsability
TeleportSignBUsability0x61:
push {r4,r7,r14}
mov r7, #0x61
b TeleportSignUsability


TeleportSignUsability:
ldr r4,=#0x3004E50
ldr r0,[r4]
mov r1, r7 
bl GetAdjacentTrapIndividual
mov r4, r0  @&The DV

cmp r0,#0
beq Usability_RetFalse

b Usability_RetTrue

mov r0, #0x3 
ldrb r0, [r4, r0]     @Completion flag
blh CheckNewFlag
cmp r0, #0
bne Usability_RetFalse


b Usability_RetTrue


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

TeleportSignBEffect: 
push {r4, lr}
ldr r0, CurrentUnitPointer
ldr r0, [r0]
bl GetAdjacentTrap

mov r4, r0  @&The DV

@turn on completion flag 
mov r0, #0x03			
ldrb r0, [r4, r0]     @Completion flag
cmp r0, #0
beq TextToShow
blh SetNewFlag

b TeleportSignEffect

TeleportSignAEffect:
push {r4, lr}
ldr r0, CurrentUnitPointer
ldr r0, [r0]
bl GetAdjacentTrap

mov r4, r0  @&The DV

b TeleportSignEffect 


TeleportSignEffect:
@Basically the execute event routine.

@But first, we need to find the event associated with this location.


b TextToShow


TextToShow:
mov r2, #0			@empty it first 
ldr r1,=MemorySlot2
str r2,[r1]		@overwrite s2 with 0

mov r1, #0x4 
ldrh r2, [r4, r1]     @gold amount 
cmp r2, #0
beq SkipFirstMsg 
ldr r1,=MemorySlot2
str r2,[r1]		@overwrite s2

ldr	r0, =TutTextEvent	@this event gives item found in byte 0x4 of the trap
mov	r1, #0x01		@0x01 = wait for events
ldr r3, ExecuteEvent
bl goto_r3

SkipFirstMsg:


ldrb r0, [r4, #0x3]     @Completion flag
blh CheckNewFlag
cmp r0, #0 
beq Continue 

@ Flag is ON, so display msg and teleport player 

ldr r0, =MemorySlot0 
str r0, [r0, #4*0x5] @[0x30004CC]!


@ find trapID that matches 
ldrb r0, [r4, #2] @trap ID @203A67C


ldr r1, =TeleportSignAID
lsl r1, #24 
lsr r1, #24 
cmp r0, r1 
bne PrepLoop 
ldrb r1, =TeleportSignBID 
lsl r1, #24 
lsr r1, #24 

PrepLoop: 
ldr r2,=gTrapArray
ldrb r0,[r2,#2]
cmp r0,#0
beq Continue

SearchForMatchingTrap_LoopStart:
ldrb r0,[r2,#2]
cmp r0, r1 
beq BreakLoop


SearchForMatchingTrap_LoopRestart:
add r2,#8
ldrb r0,[r2,#2]
cmp r0,#0
bne SearchForMatchingTrap_LoopStart


BreakLoop: 
ldrb r1, [r2] @xx
ldrb r0, [r2, #1] @yy
lsl r0, #16 
add r0, r1 
 
ldr r3, =MemorySlot0 
str r0, [r3, #4*0x3] @Destination coord in s3 

b NowFastTravelEvent





NowFastTravelEvent: 
ldr	r0, =FastTravelEvent	@this event gives item found in byte 0x4 of the trap
mov	r1, #0x01		@0x01 = wait for events
ldr r3, ExecuteEvent
bl goto_r3


b Continue 

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

