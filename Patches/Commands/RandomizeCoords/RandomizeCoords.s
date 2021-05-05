.align 4
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
	.thumb

	.equ MemorySlot, 0x30004B8 
	.equ RamUnitTable, 0x859A5D0 @0th entry
	.equ UnitMap, 0x202E4D8 
	.equ GetUnit, 0x8019430
	.equ GetUnitByEventParameter, 0x0800BC50

	.equ RefreshFogAndUnitMaps, 0x0801a1f4  
	.equ SMS_UpdateFromGameData, 0x080271a0   
	.equ UpdateGameTilesGraphics, 0x08019c3c   


	.equ Rolld100, 0x8000c64
	.equ CharacterTable, 0x8803D30 @0th entry 
	.equ MemorySlot3,0x30004C4    @item ID to give @[0x30004C4]!!?
	.equ DivisionRoutine, 0x080D18FC

	.global RandomizeCoords
	.type   RandomizeCoords, function

RandomizeCoords:
	push {r4-r7, lr}	

mov r4,#0x80 @ deployment id / counter 

@ r5 as valid coordinates 
@ r6 as valid terrain types 

ldr r0, =MemorySlot 

ldr r5, [r0, #4*0x09] @r5 / s9 as valid coords to place into 
ldr r6, [r0, #4*0x01] @r6 / s1 as valid terrain type 

@ldr r5, =0x0A06150A @ 10,6 - 21,10 


LoopThroughUnits:
mov r0,r4
blh GetUnit @ 19430
cmp r0,#0
beq NextUnit
ldr r3,[r0]
cmp r3,#0
beq NextUnit
ldr r1,[r0,#0xC] @ condition word
mov r2,#0xC @ benched/dead
tst r1,r2
bne NextUnit


mov r7, r0 

ldr r3, =MemorySlot
ldr r3, [r3, #4*0x08] @r3 / s8 as valid coords to check for units 

lsl r2, r3, #0 
lsr r2, r2, #24 
ldrb r1, [r0,#0x10] 
cmp r1, r2 
blt NextUnit @X coord lower bound 
lsl r2, r3, #16 
lsr r2, r2, #24 
cmp r1, r2 
bgt NextUnit @X coord upper bound 

lsl r2, r3, #8 
lsr r2, r2, #24 
ldrb r1, [r0,#0x11] 
cmp r1, r2 
blt NextUnit @Y coord lower bound 
lsl r2, r3, #24 
lsr r2, r2, #24 
cmp r1, r2 
bgt NextUnit @Y coord upper bound 



@ if you got here, unit exists and is not dead or undeployed, so go ham

mov r6, #0 @counter + x + y 

XCoordInRange:
lsr r6, #16 
add r6, #1 
mov r0, r6 
lsl r6, r6, #16 

cmp r0, #0xFF 
bge End_LoopThroughUnits @we tried 255 times and found no valid result, so give up 

blh Rolld100 

@ldr r1, =MemorySlot @[0x30004C4]!!?
@str r0, [r1, #4*0x03]

lsl r2, r5, #0
lsr r2, r2, #24 @X lower bound 

lsl r1, r5, #16 
lsr r1, r1, #24 @X upper bound 

sub r1, r1, r2 
mul r0, r1 
mov r1, #0x64 @div 
blh DivisionRoutine

lsl r2, r5, #0
lsr r2, r2, #24 @X lower bound 
add r0, r2 
@lsl r1, r5, #16 
@lsr r1, r1, #24 @X upper bound 

ldr r1,[r7,#0x10] @X 
@strb r0,[r7,#0x10]
lsl r0, #8 
add r6, r0 @--CCXX-- in r6 




YCoordInRange:

blh Rolld100 

lsl r2, r5, #8
lsr r2, r2, #24 @Y lower bound 

lsl r1, r5, #24 
lsr r1, r1, #24 @Y upper bound 

sub r1, r1, r2 
mul r0, r1 
mov r1, #0x64 @div 
blh DivisionRoutine

lsl r2, r5, #8
lsr r2, r2, #24 @Y lower bound 
add r0, r2 

@lsl r1, r5, #24 
@lsr r1, r1, #24 @Y upper bound 


@ldr r1, =MemorySlot @[0x30004C4]!!?
@str r0, [r1, #4*0x03]

add r6, r6, r0 @----xxyy coord to move unit to 
@mov r6, r0 
@ Check if unit

@r0/r6 as y coord to move unit to 
ldr		r1, =UnitMap
ldr		r1, [r1]
lsl		r0 ,r0 ,#0x2
add		r0 ,r0, r1

@r1 as x coord now 
lsl 	r1, r6, #16 
lsr 	r1, r1, #24 

ldr		r0, [r0]
add		r0 ,r0, r1
ldrb	r0, [r0, #0x0]	@ Character index.

blh 	GetUnit 
cmp		r0, #0x0
bne		XCoordInRange		@ Coord occupied, so try again 


@could probably use CanUnitBeOnPosition hack instead, oh well 

@x coord to move to 
@r1 as x coord now 
lsl 	r1, r6, #16 
lsr 	r1, r1, #24 

@y coord to move to 
lsl 	r0, r6, #24 
lsr 	r0, r0, #24 
mov 	r2, r0 

GetTile:
ldr r3, =0x0202E4DC @gMapTerrainPointer	{U}
ldr r3, [r3]		@gMapTerrain

lsl r0 ,r2 ,#0x2 		@Y coord to check 
add r0 ,r0, r3
ldr r0, [r0, #0x0]

add r0 ,r1, r0 			@X coord to check 
ldrb r0, [r0, #0x0]   @TileID

ldr r3, =MemorySlot 
ldr r3, [r3, #4*0x04] @Valid terrain 

cmp r0, r3 
bne XCoordInRange

@x coord to move to 
@r1 as x coord now 
lsl 	r1, r6, #16 
lsr 	r1, r1, #24 
strb r1,[r7,#0x10]

@y coord to move to 
lsl 	r0, r6, #24 
lsr 	r0, r0, #24 
mov r1, #0x11 
strb r0,[r7,#0x11]

blh  RefreshFogAndUnitMaps
blh  SMS_UpdateFromGameData
blh  UpdateGameTilesGraphics

NextUnit:
add r4,#1
cmp r4,#0xAF
ble LoopThroughUnits
End_LoopThroughUnits:
pop {r4-r7}
pop {r0}
bx r0

.ltorg

	

