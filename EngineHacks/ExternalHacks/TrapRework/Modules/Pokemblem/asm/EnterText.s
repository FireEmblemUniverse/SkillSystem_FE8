.thumb
.align 

.global EnterTextInitialization
.type EnterTextInitialization, %function

.global EnterTextUsability0x5A
.type EnterTextUsability0x5A, %function

.global EnterTextUsability0x5B
.type EnterTextUsability0x5B, %function
.global EnterTextUsability0x5C
.type EnterTextUsability0x5C, %function

.global EnterTextUsability0x5D
.type EnterTextUsability0x5D, %function






.global EnterTextEffect0x5A
.type EnterTextEffect0x5A, %function
.global EnterTextEffect0x5B
.type EnterTextEffect0x5B, %function
.global EnterTextEffect0x5C
.type EnterTextEffect0x5C, %function
.global EnterTextEffect0x5D
.type EnterTextEffect0x5D, %function


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


.equ CheckEventId,0x8083da8

.equ SetFlag, 0x8083D80

.equ SpawnTrap,0x802E2B8 @r0 = x coord, r1 = y coord, r2 = trap ID
.equ Init_ReturnPoint,0x8037901
@.equ GiveCoinsEvent, EnterTextID+4

EnterTextInitialization:
mov r0, #0x3
ldrb r0, [r5, r0]     @Completion flag
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



GetTrap2: @r0 = unit we're checking for adjacency to
push {r4-r6,r14}
mov r4,r0
ldrb r5,[r4,#0x10] @x coord
ldrb r6,[r4,#0x11] @y coord



mov r0,r5
mov r1,r6
blh GetTrapAt
cmp r0, #0 
beq ReturnFalse3
mov r1, #0
ldrb r1,[r0,#2]

mov r2, #0x5A
cmp r1, r2
blt ReturnFalse3 

mov r2, #0x5F
cmp r1, r2
ble RetTrap3

ReturnFalse3:
mov r0,#0x0	@no trap so return 0x0


RetTrap3:
pop {r4-r6}
pop {r1}
bx r1

.ltorg
.align

GetTrapIndividual: @r0 = unit we're checking for adjacency to
push {r4-r7,r14}

mov r4,r0
mov r7, r1 
ldrb r5,[r4,#0x10] @x coord
ldrb r6,[r4,#0x11] @y coord


mov r0,r5
mov r1,r6
blh GetTrapAt
cmp r0, #0 
beq ReturnFalse2
ldrb r1,[r0,#2]

mov r2, r7
cmp r1, r2
beq RetTrapIndividual
ReturnFalse2:
mov r0,#0x0	@no trap so return 0x0

RetTrapIndividual:
pop {r4-r7}
pop {r1}
bx r1

.ltorg
.align


EnterTextUsability0x5A:
push {r4,r7,r14}
mov r7, #0x5A
b EnterTextUsability
EnterTextUsability0x5B:
push {r4,r7,r14}
mov r7, #0x5B
b EnterTextUsability
EnterTextUsability0x5C:
push {r4,r7,r14}
mov r7, #0x5C
b EnterTextUsability
EnterTextUsability0x5D:
push {r4,r7,r14}
mov r7, #0x5D
b EnterTextUsability





EnterTextUsability:
ldr r4,=#0x3004E50
ldr r0,[r4]
mov r1, r7 
bl GetTrapIndividual
mov r4, r0  @&The DV

cmp r0,#0
beq Usability_RetFalse


ldrb r0, [r4, #0x3]     @Completion flag
blh CheckNewFlag
cmp r0, #0
bne Usability_RetFalse


@b Usability_RetFalse


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



EnterTextEffect0x5A:
push {r4-r5, lr}
mov r5, #0x1
b EnterTextEffect

EnterTextEffect0x5B:
push {r4-r5, lr}
mov r5, #0x2
b EnterTextEffect

EnterTextEffect0x5C:
push {r4-r5, lr}
mov r5, #0x3
b EnterTextEffect

EnterTextEffect0x5D:
push {r4-r5, lr}
mov r5, #0x4
b EnterTextEffect

.global TalkTextEffect0x33 
.type TalkTextEffect0x33, %function 
TalkTextEffect0x33:
push {r4-r5, lr}
mov r5, #0x4
ldr r0, CurrentUnitPointer
ldr r0, [r0]
bl GetAdjacentTrap
b Skip


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

mov r2, #0x33
cmp r1, r2
bge CheckA 
b ReturnA
CheckA:
mov r2, #0x33
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

mov r2, #0x33
cmp r1, r2
bge CheckB 
b ReturnB
CheckB:
mov r2, #0x33
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

mov r2, #0x33
cmp r1, r2
bge CheckC 
b ReturnC
CheckC:
mov r2, #0x33
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

mov r2, #0x33
cmp r1, r2
bge CheckD 
b ReturnD
CheckD:
mov r2, #0x33
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

EnterTextEffect:
@Basically the execute event routine.

@But first, we need to find the event associated with this location.
ldr r0, CurrentUnitPointer
ldr r0, [r0]
bl GetTrap2
cmp r0, #0 
beq Continue 
Skip: 
mov r4, r0  @&The DV
mov r1, #0x4 
ldrh r2, [r4, r1]     @textID
cmp r2, #0
beq Continue 
ldr r1,=MemorySlot2
str r2,[r1]		@overwrite s2


cmp r5, #1 
beq CGText 
cmp r5, #2
beq RegText 
cmp r5, #3 
beq TutText 
cmp r5, #4 
beq WallText 
b Continue 

CGText:
ldr r0, =ShowTextEvent
b DoTheEvent

WallText:
ldr r0, =WallTextEvent
b DoTheEvent
RegText:
ldr r0, =TextEvent
b DoTheEvent
TutText:
ldr	r0, =TutTextEvent	

DoTheEvent:
mov	r1, #0x01		@0x01 = wait for events
ldr r3, ExecuteEvent
bl goto_r3
b Continue 

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

pop {r4-r5}
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

