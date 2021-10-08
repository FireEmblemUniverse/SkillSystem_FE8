//r4 = unit RAM data
//r6 = unit action struct 203A958

.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.equ SetupBattleStructForStaffUser, 0x0802cb24
.equ FinishUpItemBattle, 0x0802cc54
.equ BeginBattleAnimations, 0x0802ca14
.equ UnlockDoor, 0x0808320c
.equ UnlockChest, 0x080831c8
.equ GetUnitStruct, 0x8019430
.equ gMapTerrain, 0x0202E4DC
.equ OpenChestTerrainType, 0x20
.equ ChestTerrainType, 0x21
.equ UnlockStaffID, 0x58

push	{lr}
ldrb 	r0, [r6,#0x11]	@action taken this turn
cmp	r0, #0x3 @used a staff
bne	EndFunc

ldrb 	r0, [r6,#0x0C]	@allegiance byte of the current character taking action
ldrb	r1, [r4,#0x0B]	@allegiance byte of the character we are checking
cmp	r0, r1		@check if same character
bne	EndFunc

@now check if Unlock was used
	ldrb r0, [r6, #0x6] //item id
	mov r1, #0xFF
	and r0, r1
	cmp r0, #UnlockStaffID
	bne EndFunc

@finally, check if valid chest at target location
mov r0, #0x13
ldsb r2, [r6, r0] @target x
mov r1, #0x14
ldsb r3, [r6, r1] @target y

ldr r0, =gMapTerrain
ldr r1, [r0]
lsl r0, r3, #0x2
add r0, r0, r1
ldr r0, [r0]
add r0, r0, r2
ldrb r0, [r0]	@terrain type
cmp r0, #ChestTerrainType
bne EndFunc
	
	mov r0, r2
	mov r1, r3
	blh UnlockChest
	//and probably play sound effect too i guess
	ldr r0, =0x0202bcf0
	add r0, #0x41
	ldrb r0, [r0]
	lsl r0, r0, #0x1e
	cmp r0, #0x0
	blt EndFunc
		mov r0, #0xB1
		blh 0x080d01fc //PlaySound

EndFunc:
pop	{r0}
bx	r0
.ltorg
.align

.align
.ltorg
