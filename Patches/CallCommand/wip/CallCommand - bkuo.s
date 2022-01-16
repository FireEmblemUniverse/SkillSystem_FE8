.align 4
.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

	.equ CheckEventId,0x8083da8
	.equ MemorySlot,0x30004B8
	.equ CurrentUnit, 0x3004E50
	.equ EventEngine, 0x800D07C

	.equ GetUnitByEventParameter, 0x0800BC51
	.equ GetUnit, 0x8019430
	.equ GetUnitDropLocation, 0x80184E1
	.equ UpdateRescueData, 0x8018371
	.equ pr6C_NewBlocking,           0x08002CE0 
	.equ pr6C_New,                   0x08002C7C
	.equ TerrainMap, 0x202E4DC
	.equ RefreshTerrainMap, 0x08019a64 @RefreshTerrainMap
@ @ 32696
@ Seth [0202BE4C] @ [0202BE67]? yup 
	
	.global CallCommandEffect
	.type   CallCommandEffect, function

CallCommandEffect:
	push	{r4-r7,lr}
mov r7, r0 @ Parent Proc ? Idk I don't use this 

mov r4,#0 @ current deployment id
mov r5,#0 @ counter

@ 202E4DC	Terrain map (tile id)
@ We need to make our current tile terrain that cannot be crossed 
@ We restore it at the end 
ldr r3, =CurrentUnit
ldr r3, [r3] 
ldrb r0, [r3, #0x10] @ X coord 
ldrb r1, [r3, #0x11] @ Y coord 
ldr		r2,=TerrainMap	@Load the location in the table of tables of the map you want
ldr		r2,[r2]			@Offset of map's table of row pointers
lsl		r1,#0x2			@multiply y coordinate by 4
add		r2,r1			@so that we can get the correct row pointer
ldr		r2,[r2]			@Now we're at the beginning of the row data
add		r2,r0			@add x coordinate
ldrb	r0,[r2]			@load datum at those coordinates
push {r0}
mov r0, #0x00 @ -- tile
strb r0, [r2] 
@blh RefreshTerrainMap

LoopThroughFirst5Units:
add r4, #1  @ r4 also increases in NextUnit 
add r5, #1 
cmp r5, #6 
bge End @ We have found all the units we need to act upon 

LoopThroughUnits:
mov r0,r4
blh GetUnit @ 19430
@cmp r0,#0
@beq NextUnit
ldr r3,[r0]
cmp r3,#0
beq NextUnit
ldr r3,[r0,#0xC] @ condition word
@ if you add +1 to include Hide (eg 0x4F), it'll ignore the active unit, which may be useful 
mov r2,#0x4F @ moved/dead/undeployed/cantoing 
tst r3,r2
bne NextUnit
@ if you got here, unit exists and is not dead or undeployed, so go ham
@r0 is Ram Unit Struct 
mov r6, r0 


ldr r2, =CurrentUnit 
ldr r2, [r2] @ Current unit ram struct pointer 
@ldrb r0, [r2, #0x0B] @ Deployment byte 
@strb r0, [r6, #0x1B] @ 
@ldrb r0, [r6, #0x0B] @ Deployment byte 
@strb r0, [r2, #0x1B]
@
@
@mov r1, #0x1D @ Rescuing someone, dead 
@ldr r0, [r2, #0x0C] 
@and r0, r1 
@str r0, [r2, #0x0C] @ Active is rescuing 
@
@mov r1, #0x20 
@ldr r0, [r6, #0x0C] 
@and r0, r1 
@str r0, [r6, #0x0C] @ unit to move is rescued
@
@mov r0, #0 
@strb r0, [r2, #0x13] @ Current hp to dead 
@@ Drop rescued unit if dead 32674


ldrh r0, [r2, #0x10] 
strh r0, [r6, #0x10] @ So units have matching coords 
blh  0x0801a1f4   @RefreshFogAndUnitMaps @RefreshEntityMaps 
ldr r0, =0x859da95 @ Procs SMSJumpAnimation 


@ldr   r2, [r7, #0x14]
@cmp r2, #0
@b Do_pr6C_New

@beq Do_pr6C_New 
@mov r1, r7 @ Parent proc 
@blh pr6C_NewBlocking @ Procs SMSJumpAnimation 
@b Continue 

Do_pr6C_New:
mov r1, #3
blh pr6C_New @ Procs SMSJumpAnimation 
Continue: 


mov r7, r0 @ Proc pointer 

str r6, [r0, #0x2C] @ First arg: Rescuee's unit struct
mov r1, r0 
add r1, #0x30 
mov r2, r0
add r2, #0x34 

ldr r0, =CurrentUnit
ldr r0, [r0] @ Rescuer's ram unit struct pointer 

blh GetUnitDropLocation @ 184E0 
mov r0, r7
ldr r1, [r0, #0x30] @ X
ldr r2, [r0, #0x34] @ Y 
strb r1, [r6, #0x10] @ X
strb r2, [r6, #0x11] @ Y 
b LoopThroughFirst5Units
	
	@ 
NextUnit:
add r4,#1
cmp r4,#0x3F
ble LoopThroughUnits
@ If we've gone through all units and not found 5 free, we can end 
mov r0, #0
	
End:

@ 202E4DC	Terrain map (tile id)
@ We need to make our current tile terrain that cannot be crossed 
@ We restore it at the end 
ldr r3, =CurrentUnit
ldr r3, [r3] 
ldrb r0, [r3, #0x10] @ X coord 
ldrb r1, [r3, #0x11] @ Y coord 
ldr		r2,=TerrainMap	@Load the location in the table of tables of the map you want
ldr		r2,[r2]			@Offset of map's table of row pointers
lsl		r1,#0x2			@multiply y coordinate by 4
add		r2,r1			@so that we can get the correct row pointer
ldr		r2,[r2]			@Now we're at the beginning of the row data
add		r2,r0			@add x coordinate
ldrb	r0,[r2]			@load datum at those coordinates
pop {r0}
@mov r0, #0x00 @ Forest 
strb r0, [r2] 


	blh  0x0801a1f4   @RefreshFogAndUnitMaps
	blh  0x080271a0   @SMS_UpdateFromGameData
	blh  0x08019c3c   @UpdateGameTilesGraphics

ldr r1, CurrentUnitFateData	@these four lines copied from wait routine
mov r0, #0x1
strb r0, [r1,#0x11]
mov r0, #0x17	@makes the unit wait?? makes the menu disappear after command is selected??
@mov r0,#0x94		@play beep sound & end menu on next frame & clear menu graphics




	pop {r4-r7}
	pop {r1}
	bx r1 
	
	
.ltorg
.align 

ExecuteEvent:
	.long 0x800D07D @AF5D
CurrentUnitFateData:
	.long 0x203A958
	
	
	.global CallCommandUsability
.type CallCommandUsability, %function

CallCommandUsability:
push {lr}


mov r0, #1 @ Flag that prevents call 
blh CheckEventId
cmp r0, #0 
bne Usability_False


blh Get2ndFreeUnit
cmp r0, #0 
beq Usability_False 
mov r0, #1 
b Exit 

Usability_False:
mov r0, #3 @ False is 3 for some reason  


Exit: 
pop {r1} 
bx r1 
