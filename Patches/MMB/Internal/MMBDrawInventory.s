
.thumb

.include "../CommonDefinitions.inc"

MMBDrawInventory:

	.global	MMBDrawInventory
	.type	MMBDrawInventory, %function

	.set MMBInventoryTileIndex,				EALiterals + 0
	.set MMBInventoryObjectPaletteIndex,	EALiterals + 2
	.set MMBItemSheet,						EALiterals + 3

	@ Inputs:
	@ r0: pointer to proc state
	@ r1: pointer to unit in RAM

	push	{r4-r6, lr}

	mov		r4, r0
	mov		r5, r1

	ldr		r0, =ItemIconPalette
	ldr		r1, =MMBInventoryObjectPaletteIndex
	ldrb	r1, [r1]
	lsl		r1, r1, #0x05
	mov		r2, #0x20
	ldr		r3, =CopyToPaletteBuffer
	mov		lr, r3
	bllr

	@ loop counter

	mov		r6, #0x00

Loop:

	@ check if we're done

	cmp		r6, #0x05
	beq		End

	@ Get item

	mov		r0, r5
	lsl		r1, r6, #0x01
	add		r1, #UnitInventory
	ldrh 	r3, [r0, r1] 
	ldrb	r0, [r0, r1]
	cmp		r0, #0x00
	beq		End
	push {r3} 
	ldr		r1, =GetROMItemStructPtr
	mov		lr, r1
	bllr
	pop {r3} 
	@ get icon
	push {r0}
	@ r0 is item table entry we want 
	
@ r3 as item id with durability 
mov r0, r3 
mov r1,#0xFF
and r0,r1 @r0 as item ID 

ldr r2,=DurabilityBasedItemIconList_Accessory
Loop1Start_Accessory:
ldrb r1,[r2]
cmp r1,#0
beq NotAccessory1
cmp r0,r1
beq Loop1Exit_Accessory
add r2,#2
b Loop1Start_Accessory

NotAccessory1:
ldr r2,=DurabilityBasedItemIconList

Loop1Start:
ldrb r1,[r2]
cmp r1,#0
beq IsItemIcon
cmp r0,r1
beq Loop1Exit
add r2,#2
b Loop1Start

Loop1Exit_Accessory:

mov r0, #0x3F 
lsl r0, #8 
mov r1,r3
and r1, r0 
lsr r1, #8 @ ignore equipped bits 

ldrb r2,[r2,#1]
lsl r2,r2,#8 		@shifted 8 bits left
orr r1,r2
pop {r0} 
mov r0, r1 
b LoadedIconIdAndType


Loop1Exit:

@get icon based on durability of item; item halfword is in r3

mov r1,r3
lsr r1,r1,#8

ldrb r2,[r2,#1]
lsl r2,r2,#8 		@shifted 8 bits left
orr r1,r2
pop {r0} 
mov r0, r1 
b LoadedIconIdAndType



IsItemIcon: 
pop {r0}
ldrb	r0, [r0, #ItemDataIconID ]

	@ This is to comply with the icon rework
	@ if it is installed.

	ldr		r1, =MMBItemSheet
	ldrb	r1, [r1]
	lsl		r1, #8
	orr		r0, r1

LoadedIconIdAndType:

	@ get tile index

	ldr		r1, =MMBInventoryTileIndex
	ldrh	r1, [r1]
	lsl		r2, r6, #0x01
	add		r1, r1, r2

	@ draw

	ldr		r2, =RegisterIconOBJ
	mov		lr, r2
	bllr

	add		r6, r6, #0x01
	b		Loop

End:

	@ Store count

	add		r4, #InventoryIconCount
	strb	r6, [r4]

	pop		{r4-r6}
	pop		{r0}
	bx		r0

.ltorg

EALiterals:
	@ MMBInventoryTileIndex
	@ MMBInventoryObjectPaletteIndex
	@ MMBItemSheet
