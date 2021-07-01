.thumb
.align 4

.global BerryTreeInitialization
.type BerryTreeInitialization, %function

.global BerryTreeUsability
.type BerryTreeUsability, %function


.global BerryTreeHealEffect
.type BerryTreeHealEffect, %function

.global PickBerryTreeEffect
.type PickBerryTreeEffect, %function


.global HeldBerryEffect
.type HeldBerryEffect, %function



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

.equ RemoveUnitBlankItems,0x8017984
.equ CheckEventId,0x8083da8
.equ GetItemAfterUse, 0x08016AEC+1
.equ SetFlag, 0x8083D80

.equ SpawnTrap,0x802E2B8 @r0 = x coord, r1 = y coord, r2 = trap ID
.equ Init_ReturnPoint,0x8037901


BerryTreeInitialization:

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


BerryTreeHealEffect:
push {r4-r5,r14}
mov r4,r0 @r4 = unit
mov r5,r1 @r5 = heal %
bl GetAdjacentTrap 
mov r3, r0 


cmp r0, #0
beq NoHeal
 
ldrb r0, [r3, #0x3]     @ # of berries 
cmp r0, #0 
beq NoHeal 


mov r2, #0x12  
ldrb r0, [r4, r2]
mov r2, #0x13  
ldrb r1, [r4, r2]
cmp r1, r0 
bge NoHeal

ldrb r2, [r3, #0x3]     @ # of berries 
sub r2, #1 
strb r2, [r3, #0x3] @ take away a berry 
@ need percentage of health to heal 
@ r0 = mult 
@ r1 = div 
cmp r0, #11 
bgt CalculateAmount
mov r0, #100 
b AddTo_r5
CalculateAmount:
mov r1, r0 @ Max hp 
sub r1, #1 @ for bad rounding?
mov r0, #10 @ amount to heal 
mov r2, #100 
mul r0, r2 
blh #0x080D18FC @ Div routine 
add r0, #1 @ for beneficial rounding 
AddTo_r5:
add r5, r0 @approx 10 hp restoration from berry tree 

NoHeal:
mov r0, r5 
pop {r4-r5}
pop {r1}
bx r1 

.align 4
HeldBerryEffect:
push {r4-r6,r14}
mov r4,r0 @r4 = unit
mov r5,r1 @r5 = heal %




mov r2, #0x12  
ldrb r0, [r4, r2]
mov r2, #0x13  
ldrb r1, [r4, r2]
lsr r0, #1 @ half of max hp 
cmp r1, r0 
bge DontHeal

mov r3, #0x1C 
mov r2, #0x27
mov r1, #0x6C @ Berry item ID 
SearchHeldBerryLoop:
add r3, #2 @ Item index 
cmp r3, r2
bge DontHeal
ldrb r0, [r4, r3] 
cmp r0, r1 
bne SearchHeldBerryLoop
mov r6, r3 


PercentToHeal:
mov r2, #0x12  
ldrb r0, [r4, r2]
cmp r0, #11 
bgt CalculateAmountNow
mov r0, #100 
b AddTo_r5_now
CalculateAmountNow:
mov r1, r0 @ Max hp 
sub r1, #1 @ for bad rounding?
mov r0, #10 @ amount to heal 
mov r2, #100 
mul r0, r2 
blh #0x080D18FC @ Div routine 
add r0, #1 @ for beneficial rounding 
AddTo_r5_now:
add r5, r0 @approx 10 hp restoration from berry tree 

ldr r2, = #0x30017b9 @ BerryDurabilityToggleRam
ldrb r1, [r2]
cmp r1, #0 
beq SetBit


UnsetBit:
mov r0, #0 
b StoreBit

SetBit:
mov r0, #1 
b StoreBit



StoreBit:
strb r0, [r2] 
cmp r0, #0
bne DontHeal

mov r3, r6 
@ sub durabil 
ldrb r1, [r4, r3] 
add r3, #1
ldrb r0, [r4, r3] @ dur 
sub r0, #1
cmp r0, #0 
beq RemoveBlankItem


lsl r0, #8 
add r0, r1
sub r3, #1
strh r0, [r4, r3] 
b DontHeal

RemoveBlankItem:
sub r3, #1 
strh r0, [r4, r3] 
blh RemoveUnitBlankItems @move everything else up


DontHeal:
mov r0, r5 

pop {r4-r6}
pop {r1}
bx r1 

.align 4

GetAdjacentTrap: @r0 = unit we're checking for adjacency to
push {r4-r6,r14}
mov r4, r0

ldrb r5,[r4,#0x10] @x coord
ldrb r6,[r4,#0x11] @y coord


mov r0,r5
sub r0,#1
mov r1,r6
blh GetTrapAt

ldrb r1,[r0,#2]
mov r2, #0x70
cmp r1, r2
beq RetTrap

mov r0,r5
mov r1,r6
sub r1,#1
blh GetTrapAt

ldrb r1,[r0,#2]
mov r2, #0x70
cmp r1, r2
beq RetTrap

mov r0,r5
add r0,#1
mov r1,r6
blh GetTrapAt
ldrb r1,[r0,#2]

mov r2, #0x70
cmp r1, r2
beq RetTrap

mov r0,r5
mov r1,r6
add r1,#1
blh GetTrapAt
ldrb r1,[r0,#2]

mov r2, #0x70
cmp r1, r2
beq RetTrap

ReturnD:
mov r0,#0	@no trap so return 0


RetTrap:
pop {r4-r6}
pop {r1}
bx r1

.ltorg
.align




BerryTreeUsability:
push {r4,r14}
ldr r4,=#0x3004E50
ldr r0,[r4]
bl GetAdjacentTrap
mov r4, r0  @&The DV

cmp r0,#0
beq Usability_RetFalse


@ Always usable, but out of berries msg if empty 
@ldrb r0, [r4, #0x3]     @ # of berries 
@cmp r0, #0
@beq Usability_RetFalse @ No berries on it right now 


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
pop {r4}
pop {r1}
bx r1

.ltorg
.align




PickBerryTreeEffect:
push {r4-r5, lr}
@Basically the execute event routine.

@But first, we need to find the event associated with this location.
ldr r0, CurrentUnitPointer
ldr r0, [r0]
bl GetAdjacentTrap
mov r4, r0  @ The trap

@turn on completion flag 
ldrb r0, [r4, #0x3]     @ # of berries 
cmp r0, #0
beq NoBerriesMessage @ No berries on it right now 

sub r0, #1 
strb r0, [r4, #0x3] @ take away a berry 

ldr r0, =PickBerryEvent
b DoTheEvent


NoBerriesMessage:
ldr r0, =NoBerriesEvent
b DoTheEvent




DoTheEvent:
mov	r1, #0x01		@0x01 = wait for events
ldr r3, ExecuteEvent
bl goto_r3




Continue:
ldr r1, CurrentUnitFateData	@these four lines copied from wait routine
mov r0, #0x1
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

