.align 4
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
	.thumb

	gEventSlot = 0x030004B8

	gMapMovement = 0x0202E4E0
	gMapRange = 0x0202E4E4

	BmMapFill = 0x080197E4+1
	FillRangeMapForDangerZone = 0x0801B810+1
	.equ GetUnit, 0x8019430
	.equ MemorySlot, 0x30004B8 
	
	.global CheckAnyoneInDanger
	.type   CheckAnyoneInDanger, function

CheckAnyoneInDanger:
	push {r4-r5, lr}	
	ldr r3, =FillRangeMapForDangerZone
	mov r0, #0 @ arg r0 = staff range?
	bl bxr3

	ldr r3, =BmMapFill 
	ldr r0, =gMapMovement @ arg r0 = gMapMovement
	ldr r0, [r0]
	mov r1, #1
	neg r1, r1            @ arg r1 = -1
	bl bxr3

mov r0, #0 @store false at the start 
ldr r2, =MemorySlot 
str r0, [r2, #4*0x0C]

mov r4,#1 @ deployment id
mov r5,#0 @ counter


LoopThroughUnits:
mov r0,r4
blh GetUnit @ 19430
cmp r0,#0
beq NextUnit
ldr r3,[r0]
cmp r3,#0
beq NextUnit
ldr r1,[r0,#0xC] @ condition word
ldr r2,=#0x1000C @ escaped/benched/dead
tst r1,r2
bne NextUnit
@ if you got here, unit exists and is not dead or undeployed, so go ham
mov r2, #0x11
ldrb r1, [r0, r2] @y coord 
ldrb r0, [r0, #0x10] @x coord 
	
ldr		r2,=gMapRange	@Load the location in the table of tables of the map you want
ldr		r2,[r2]			@Offset of map's table of row pointers
lsl		r1,#0x2			@multiply y coordinate by 4
add		r2,r1			@so that we can get the correct row pointer
ldr		r2,[r2]			@Now we're at the beginning of the row data
add		r2,r0			@add x coordinate
ldrb	r0,[r2]			@load datum at those coordinates
cmp 	r0, #0 
bne 	NextUnit

ldr r2, =MemorySlot 
mov r0, #1 @true
str r0, [r2, #4*0x0C]
b End_LoopThroughUnits

NextUnit:
add r5,#1
cmp r5,#6
bge End_LoopThroughUnits

add r4,#1
cmp r4,#0x3F
ble LoopThroughUnits
End_LoopThroughUnits:


pop {r4-r5}
	pop {r3}
bxr3:	bx r3
