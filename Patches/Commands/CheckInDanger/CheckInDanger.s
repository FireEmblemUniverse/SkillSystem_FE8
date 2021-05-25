
	.thumb

	gEventSlot = 0x030004B8

	gMapMovement = 0x0202E4E0
	gMapRange = 0x0202E4E4

@.equ MemorySlot3,0x30004C4    @item ID to give @[0x30004C4]!!?

	BmMapFill = 0x080197E4+1
	FillRangeMapForDangerZone = 0x0801B810+1

	.global CheckUnitIsInDanger
	.type   CheckUnitIsInDanger, function

CheckUnitIsInDanger:
	push {lr}
	ldr r3, =FillRangeMapForDangerZone
	mov r0, #0 @ arg r0 = staff range?
	bl bxr3

	ldr r3, =BmMapFill 
	ldr r0, =gMapMovement @ arg r0 = gMapMovement
	ldr r0, [r0]
	mov r1, #1
	neg r1, r1            @ arg r1 = -1
	bl bxr3

	ldr r3, =gEventSlot
	str r0, [r3, #4*0x04] @[0x30004C8]!!?
	
	
	ldr r2, [r3, #4*0x0B]

	lsr r1, r2, #16 @ r1 = slotB.y
	lsl r0, r2, #24
	lsr r0, #24 @ r0 = slotB.x
	
ldr		r2,=gMapRange	@Load the location in the table of tables of the map you want
ldr		r2,[r2]			@Offset of map's table of row pointers
lsl		r1,#0x2			@multiply y coordinate by 4
add		r2,r1			@so that we can get the correct row pointer
ldr		r2,[r2]			@Now we're at the beginning of the row data
add		r2,r0			@add x coordinate
ldrb	r0,[r2]			@load datum at those coordinates


	@ldr r0, =gMapRange
	@ldr r0, [r0]
	@lsl r2, #2
	@add r0, r2 
	@ldr r0, [r0] 
	@add r0, r1 
	@ldrb r0, [r0]
	

	str r0, [r3, #4*0x0C]

	pop {r3}
bxr3:	bx r3
