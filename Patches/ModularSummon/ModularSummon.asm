.align 4
.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

	.equ CheckEventId,0x8083da8
	.equ SetEventId, 0x8083d80 
	.equ MemorySlot,0x30004B8
	.equ CurrentUnit, 0x3004E50
	.equ EventEngine, 0x800D07C
	.equ LoadUnit, 0x8017ac4 

	.equ GetUnitByEventParameter, 0x0800BC51
	.equ GetUnit, 0x8019430
	.equ GetUnitDropLocation, 0x80184E1
	.equ UpdateRescueData, 0x8018371
	.equ pr6C_NewBlocking,           0x08002CE0 
	.equ pr6C_New,                   0x08002C7C
	.equ TerrainMap, 0x202E4DC
	.equ RefreshTerrainMap, 0x08019a64 @RefreshTerrainMap
	
	.global ModularSummonEffect
	.type   ModularSummonEffect, function

ModularSummonEffect:
	push	{r4-r7,lr}

ldr r3, =CurrentUnit 
ldr r3, [r3] @ unit struct ram pointer 
mov r7, r3 


ldr r4, =ModularSummonTable
sub r4, #8 
@ find matching entry or terminate 
TableLoopStart:
add r4, #8
ldr r2, [r4, #4] @ If unit group is empty, then terminate 
cmp r2, #0 
beq GotoEnd


ldrb r0, [r4, #0] @ Unit ID 
cmp r0, #0x00 
beq ValidUnitException
ldr r1, [r7] @ Char 
ldrb r1, [r1, #4] @ unit id 
cmp r0, r1 
bne TableLoopStart

ValidUnitException:

ldrb r0, [r4, #1] @ class 
cmp r0, #0 
beq ValidClassException
ldr r1, [r7, #4] @ class 
ldrb r1, [r7, #4] @ class id 
cmp r0, r1 
bne TableLoopStart

ValidClassException:

@ check lvl 
ldrb r0, [r4, #2] 
cmp r0, #0 
beq ValidLevelException
ldrb r1, [r7, #8] @ level ? 
cmp r0, r1 
bgt TableLoopStart

ValidLevelException:
ldrb r0, [r4, #3]
cmp r0, #0 
beq ValidFlagException
blh CheckEventId
mov r1, r0 
ldrb r0, [r4, r3] 
cmp r0, r1 
bne TableLoopStart
ValidFlagException:

@ We have found a valid case to summon 


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

ldrb r1, [r3, #0x1B] @ Current unit's rescued Deployment byte 
lsl r0, #8 
add r0, r1 
push {r0} @ Save what the terrain & deployment byte should be at current unit's tile eg. ----TRDB (Terrain, Deployment Byte)
mov r0, #0x00 @ -- tile
strb r0, [r2] 




@ Load each unit loop 
ldr r5, [r4, #4] @ Poin to unit group 
sub r5, #20 @ 20 bytes per unit group 
LoadEachSummonLoop:
add r5, #20 @ Next specific unit to load 
ldr r0, [r5] 
cmp r0, #0 
beq GotoRestoreTerrain @ We went through all units, so restore terrain and end 


ldrb r0, [r5] @ unit id 

ldr r2, [r7] 
ldrb r2, [r2, #4] 
cmp r0, r2 
beq LoadEachSummonLoop @ You cannot summon yourself, as this breaks the terrain. 

blh GetUnitByEventParameter
mov r11, r11 
cmp r0, #0 
beq LoadUnitTime @ Unit is cleared, so summon 
ldr r1, [r0, #0x0C] @ State 
mov r2, #0x04 @ Dead 
and r2, r1 
cmp r2, #0 
beq LoadEachSummonLoop @ Unit is alive, so try next one 
@ unit to summon is dead but needs to be cleared 
@mov r2, #0x04 
@neg r2, r2 @ 
@and r1, r2 
@str r1, [r0, #0x0C] @ Remove 'dead' bitflag from the unit 





blh 0x080177f4 @ ClearUnit
mov r11, r11 
LoadUnitTime:

mov r0, r5 
blh LoadUnit 
mov r6, r0 @ Newly loaded unit 
b PlaceSummonedUnit 


GotoRestoreTerrain:
b RestoreTerrain 

GotoEnd: 
b End


@GetPreferredPositionForUNIT(uDef, &unit->xPos, &unit->yPos, FALSE);
// uDef is the rom unit in the unit group table 
// therefore, it shouldn't be used here I don't think 
@ 0803bde0 FindUnitClosestValidPosition
@blh 0x803BDE1, r7 @ FindUnitClosestValidPosition
@mov r11, r11 @ break 



@place most recently loaded unit to valid coord 
PlaceSummonedUnit:



@ To find the closest / best position, we're going to mimic the parameters and use this vanilla function 
@ void UnitGetDeathDropLocation(struct Unit* unit, int* xOut, int* yOut)
@ Newly loaded unit in r6 
ldr r2, =CurrentUnit 
ldr r2, [r2] @ Current unit ram struct pointer 
@ldrb r3, [r6, #0x0B] @ Deployment byte
@push {r3}
ldrb r0, [r6, #0x0B] @ Deployment byte 
strb r0, [r2, #0x1B]
mov r4, r0 @ Store whoever is being rescued lol 

ldrb r0, [r2, #0x0B] @ Deployment byte 
strb r0, [r6, #0x1B] @ 




ldrh r0, [r2, #0x10] 
strh r0, [r6, #0x10] @ So units have matching coords 
blh  0x0801a1f4   @RefreshFogAndUnitMaps @RefreshEntityMaps 
ldr r0, =0x859da95 @ Procs SMSJumpAnimation 



Do_pr6C_New:
mov r1, #3
blh pr6C_New @ Procs SMSJumpAnimation 
Continue: 

push {r0}


str r6, [r0, #0x2C] @ First arg: Rescuee's unit struct [202BE94]
mov r1, r0 
add r1, #0x30 
mov r2, r0
add r2, #0x34 

ldr r0, =CurrentUnit
ldr r0, [r0] @ Rescuer's ram unit struct pointer [202BE4C]

blh GetUnitDropLocation @ 184E0 
pop {r0}

ldr r1, [r0, #0x30] @ X
ldr r2, [r0, #0x34] @ Y 
strb r1, [r6, #0x10] @ X
strb r2, [r6, #0x11] @ Y


strb r4, [r6, #0x1B] @ Deployment byte 

b LoadEachSummonLoop 
	
	
RestoreTerrain:

@ 202E4DC	Terrain map (tile id)
@ We restore the terrain now 
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

lsr r1, r0, #8
strb r1, [r2] @ Terrain restored 
lsl r0, #24 
lsr r0, #24 
strb r0, [r3, #0x1B] @ Rescuer/ee restored 



End:

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
	
	
	.global ModularSummonUsability
.type ModularSummonUsability, %function

ModularSummonUsability:
push {r4-r7, lr}

ldr r3, =CurrentUnit 
ldr r3, [r3] @ unit struct ram pointer 
mov r7, r3 

ldr r4, =ModularSummonTable
sub r4, #8 
@ find matching entry or terminate 
TableLoopStart2:
add r4, #8
ldr r2, [r4, #4] @ If unit group is empty, then terminate 
cmp r2, #0 
beq Usability_False


ldrb r0, [r4, #0] @ Unit ID 
cmp r0, #0x00 
beq ValidUnitException2
ldr r1, [r7] @ Char 
ldrb r1, [r1, #4] @ unit id 
cmp r0, r1 
bne TableLoopStart2

ValidUnitException2:

ldrb r0, [r4, #1] @ class 
cmp r0, #0 
beq ValidClassException2
ldr r1, [r7, #4] @ class 
ldrb r1, [r7, #4] @ class id 
cmp r0, r1 
bne TableLoopStart2

ValidClassException2:

@ check lvl 
ldrb r0, [r4, #2] 
cmp r0, #0 
beq ValidLevelException2
ldrb r1, [r7, #8] @ level ? 
cmp r0, r1 
bgt TableLoopStart2

ValidLevelException2:
ldrb r0, [r4, #3]
cmp r0, #0 
beq ValidFlagException2
blh CheckEventId
mov r1, r0 
ldrb r0, [r4, r3] 
cmp r0, r1 
bne TableLoopStart2

ValidFlagException2:
@ check if unit exists now 
ldr r5, [r4, #4] 
@ loop 
sub r5, #20 
CheckIfAnySummonedUnitDoesNotExistLoop: 
add r5, #20 
ldr r0, [r5]
cmp r0, #0 
beq Usability_False
ldrb r0, [r5] @ unit id 

ldr r2, [r7] @ You cannot summon yourself, as this breaks the terrain. 
ldrb r2, [r2, #4] 
cmp r0, r2 
beq CheckIfAnySummonedUnitDoesNotExistLoop @ You cannot summon yourself, as this breaks the terrain. 


blh GetUnitByEventParameter
cmp r0, #0 
beq UsabilityTrue
ldr r1, [r0, #0x0C] @ State 
mov r2, #0x04 @ Dead 
and r2, r1 
cmp r2, #0 
bne UsabilityTrue @ Unit is dead, so return True 
b CheckIfAnySummonedUnitDoesNotExistLoop 

@ they were cleared or dead, so true 
UsabilityTrue:
mov r0, #1 
b Exit

mov r0, #8 @ Flag that prevents call 
blh CheckEventId
cmp r0, #0 
bne Usability_False


Usability_False:
mov r0, #3 @ False is 3 for some reason  



Exit: 
pop {r4-r7}
pop {r1} 
bx r1 
