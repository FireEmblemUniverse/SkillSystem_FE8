.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.equ IsThereClosedChestAt, 0x080831AC 
.equ IsThereClosedDoorAt, 0x080831f0
.equ AddTarget, 0x0804F8BC
.equ gMapTerrain, 0x0202E4DC
.equ ChestTerrainType, 0x21
.equ DoorTerrainType, 0x1E
.equ BridgeTerrainType, 0x14

push {r4-r6, lr}
mov r4, r0
mov r5, r1
ldr r0, =gMapTerrain
ldr r1, [r0]
lsl r0, r5, #0x2
add r0, r0, r1
ldr r0, [r0]
add r0, r0, r4
ldrb r6, [r0]	@terrain type
lsl r0, r4, #0x18
asr r0, r0, #0x18
lsl r1, r5, #0x18
asr r1, r1, #0x18
cmp r6, #ChestTerrainType
beq CheckForChest
	
	cmp r6, #BridgeTerrainType
	beq CheckForDoor
	cmp r6, #DoorTerrainType
	beq CheckForDoor
	b EndFunc

	CheckForDoor:
		blh IsThereClosedDoorAt
		lsl r0, r0, #0x18
		cmp r0, #0x0
		beq EndFunc
		b AddToTargetList

CheckForChest:
	blh IsThereClosedChestAt
	lsl r0, r0, #0x18
	cmp r0, #0x0
	beq EndFunc
	b AddToTargetList
	
	AddToTargetList:
		mov r0, r4
		mov r1, r5
		mov r2, r6
		mov r3, #0x0
		blh AddTarget, r6

EndFunc:
	pop {r4-r6}
	pop {r0}
	bx r0

.align
.ltorg

