.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.equ UnlockChest, 0x080831c8
.equ GetItemIndex, 0x80174ED
.equ gMapTerrain, 0x0202E4DC
.equ gActionData, 0x0203A958
.equ gBattleActor, 0x0203A4EC
.equ ChestTerrainType, 0x21

.equ UsingSpellMenu, UnlockStaffID+4
.equ SelectedSpell, UsingSpellMenu+4

push	{r4, lr}
ldr 	r4, =gActionData
ldrb 	r0, [r4,#0x11]	@action taken this turn
cmp	r0, #0x3 @used a staff
bne	EndFunc

@ldrb 	r2, [r4,#0x0C]	@allegiance byte of the current character taking action
@ldrb	r1, [r4,#0x0D]	@allegiance byte of the character we are checking
@cmp	r2, r1		@check if same character
@bne	EndFunc

@now check if Unlock was used - Edit by Snek: This should be cleaner and play with Gaiden Magi nicer.
@	ldrb r0, [r4, #0x6] @item id
@	mov r1, #0xFF
@	and r0, r1
@	cmp r0, #UnlockStaffID
@	bne EndFunc

ldr r0, UsingSpellMenu
cmp r0, #0x00
beq NotUsingSpellMenu
ldrb r0, [r0]
cmp r0, #0x00
beq NotUsingSpellMenu
	@ We're using the spell menu. Reference SelectedSpell instead of unit->items[gActionData+0x12]
	ldr r0, SelectedSpell
	ldrb r0, [r0]
	b CheckForItemID
NotUsingSpellMenu:
	ldr r0, =gBattleActor
	mov r1, #0x4A
	ldrh r0, [r0, r1] @ r0 now has the item ID.
	blh GetItemIndex, r1
CheckForItemID:
ldr r1, UnlockStaffID
cmp r0, r1
bne EndFunc @ End if our selected spell isn't unlock.

@finally, check if valid chest at target location
mov r0, #0x13
ldsb r2, [r4, r0] @target x
mov r1, #0x14
ldsb r3, [r4, r1] @target y

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
	@and probably play sound effect too i guess
	ldr r0, =0x0202bcf0
	add r0, #0x41
	ldrb r0, [r0]
	lsl r0, r0, #0x1e
	cmp r0, #0x0
	blt EndFunc
		mov r0, #0xB1
		blh 0x080d01fc @PlaySound

EndFunc:
pop {r4}
pop	{r0}
bx	r0
.ltorg
.align

UnlockStaffID:
