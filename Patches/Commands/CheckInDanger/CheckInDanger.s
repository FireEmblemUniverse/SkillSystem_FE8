
	.thumb

	gEventSlot = 0x030004B8

	gMapMovement = 0x0202E4E0
	gMapRange = 0x0202E4E4

@.equ MemorySlot3,0x30004C4    @item ID to give @[0x30004C4]!!?
@RefreshFogAndUnitMaps, 0x0801A1F5 

	BmMapFill = 0x080197E4+1
	FillRangeMapForDangerZone = 0x0801B810+1

	.global CheckUnitIsInDanger
	.type   CheckUnitIsInDanger, function

CheckUnitIsInDanger:
	push {lr}
	@mov r11, r11
	@mov r0, #1 @ True 
	@b AlwaysTrue
	@b Test2
	@b Test
	ldr r1, =0x30017bb
	mov r0, #1 
	strb r0, [r1] @ Do not do DR stuff 
	
	ldr r3, =FillRangeMapForDangerZone
	mov r0, #0 @ arg r0 = staff range?
	bl bxr3
	@b Test2

	Test:
	ldr r3, =BmMapFill 
	ldr r0, =gMapMovement @ arg r0 = gMapMovement
	ldr r0, [r0]
	mov r1, #1
	neg r1, r1            @ arg r1 = -1
	bl bxr3

	Test2:
	ldr r3, =gEventSlot
	ldr r2, [r3, #4*0x0B]
	@mov r11, r11

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

	AlwaysTrue:
	str r0, [r3, #4*0x0C]
	
	ldr r1, =0x30017bb
	mov r0, #0 
	strb r0, [r1] @ Do DR stuff again 

	pop {r3}
bxr3:	bx r3
