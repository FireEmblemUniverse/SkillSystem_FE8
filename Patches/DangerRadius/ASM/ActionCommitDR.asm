@ Recalc DR when committing to an action.
@ Hooked at 0x1D380
.thumb

.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
	.equ EventEngine, 0x800D07C

.equ CurrentUnit, 0x3004E50
push  {r4, r14}



ldrb  r1, [r1, #0xF]
ldr   r4, =MoveActiveUnit
bl    GOTO_R4




@ Recalc DR if it's active.
ldr   r0, =DRCountByte
lsl   r0, #0x5
lsr   r0, #0x5
ldrb  r0, [r0]
cmp   r0, #0x0
beq   L1

ldr r3, =CurrentUnit
ldr r3, [r3] 
ldrb r0, [r3, #0x10] @ XX 
ldrb r1, [r3, #0x11] @ YY 

ldr		r2,=0x202E4D8 @ Unit Map 	@Load the location in the table of tables of the map you want
ldr		r2,[r2]			@Offset of map's table of row pointers
lsl		r1,#0x2			@multiply y coordinate by 4
add		r2,r1			@so that we can get the correct row pointer
ldr		r2,[r2]			@Now we're at the beginning of the row data
add		r2,r0			@add x coordinate
ldrb r0, [r3, #0xB] @ Deployment byte 
strb	r0,[r2]			@store datum at those coordinates

bl SetNearbyDR
bl RefreshUnitASMC
b     Return

L1:

bl RefreshUnitWithoutFogASMC

ldr   r4, =UpdateGameTilesGraphics
bl    GOTO_R4




Return:

pop   {r4}
pop   {r0}
bx    r0
GOTO_R4:
bx    r4
