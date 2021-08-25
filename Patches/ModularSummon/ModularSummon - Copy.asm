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
	.equ LoadUnit, 0x8017ac4 
	.equ ClearUnit, 0x080177f4 
	.equ GetUnitByEventParameter, 0x0800BC51
	.equ GetUnitDropLocation, 0x80184E1
	.equ pr6C_NewBlocking,           0x08002CE0 
	.equ pr6C_New,                   0x08002C7C
	.equ Proc_CreateBlockingChild, 0x80031c5 @ProcInst06_AddBlockingChild
	.equ NewBlockingProc, 0x8002CE1
	.equ TerrainMap, 0x202E4DC
	.equ RefreshTerrainMap, 0x08019a64 
	.equ CanUnitCrossTerrain, 0x801949c 
	.equ New6C_SummonGfx_FromActionStructCoords, 0x807AD09
	.equ FindSafestTileAI, 0x803B809  
	.equ AIScript12_Move_Towards_Enemy, 0x803ce18 
	.equ AiSetDecision, 0x8039C21 
	.equ IncreaseUnitStatsByLevelCount, 0x8017FC4
	.equ EnsureNoUnitStatCapOverflow, 0x80181c8
	.equ ProcStartBlocking, 0x08002CE0
	.equ BreakProcLoop, 0x08002E94
	.equ ProcFind, 0x08002E9C
	.equ EnsureCameraOntoPosition,0x08015e0d
	.equ CenterCameraOntoPosition,0x8015D85
	
	.global ModularSummonEffect
	.type   ModularSummonEffect, function

ModularSummonEffect:
push {r4, lr}
mov r4, r0 @ Parent ? 
ldr r0, =ClearMemorySlotQueueEvent
mov r1, #1 
blh EventEngine 
ldr r0, =CallModularSummonASMC_Event
mov r1, #1 
blh EventEngine 

mov r0, #0x17 
pop {r4} 
pop {r1} 
bx r1

	.global ModularSummonEffect2
	.type   ModularSummonEffect2, function

ModularSummonEffect2:
	push	{r4-r7,lr}
mov r7, r8  
push {r7} @ Save r8 to restore at the end 
mov r8, r0 @ Parent proc 
mov r6, r9 
push {r6} 

ldr r3, =CurrentUnit 
ldr r3, [r3] @ unit struct ram pointer 
cmp r3, #0 
beq GotoEnd
ldr r2, [r3] 
cmp r2, #0 
bne SetupStuff 



SetupStuff:
mov r7, r3 


ldr r4, =ModularSummonTable
sub r4, #12 
@ find matching entry or terminate 
TableLoopStart:
add r4, #12
ldr r2, [r4, #8] @ If unit group is empty, then terminate 
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
ldrb r1, [r1, #4] @ class id 
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
ldrb r0, [r4, #3] 
cmp r0, r1 
bne TableLoopStart
ValidFlagException:

@ We have found a valid case to summon 
mov r9, r4 @ Save table so we know user input 

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
ldr r5, [r4, #8] @ Poin to unit group 
sub r5, #20 @ 20 bytes per unit group 
LoadEachSummonLoop:
add r5, #20 @ Next specific unit to load 
ldr r0, [r5] 
cmp r0, #0 
beq GotoRestoreTerrain @ We went through all units, so end 


ldrb r0, [r5] @ unit id 

ldr r2, [r7] 
ldrb r2, [r2, #4] 
cmp r0, r2 
beq LoadEachSummonLoop @ You cannot summon yourself, as this breaks the terrain. 

mov r7, #0 @ Do not autolevel unit unless they were cleared 
blh GetUnitByEventParameter
cmp r0, #0 
beq LoadUnitTime @ Unit is cleared, so summon 

	ldr r1, [r0, #0x0C] @ State 

	mov r3, #0x08 @ Undeployed 
	and r3, r1 @ If unit is deployed already, ignore them 
	cmp r3, #0 
	bne LoadEachSummonLoop 

	mov r2, #0x04 @ Dead 
	and r2, r1 
	cmp r2, #0 
	beq LoadEachSummonLoop @ Unit is alive, so try next one 
	@ unit to summon is dead but needs to be cleared 

	@ they are undeployed but alive 
	@ remove dead/undeployed bitflag 
	mov r2, #0x0C
	mvn r2, r2 
	and r1, r2 
	str r1, [r0, #0x0C] @ Remove 'dead', 'undeployed' bitflag from the unit 
	mov r3, r9 
	ldrb r1, [r3, #6] @ Reset Stats? T/F 
	cmp r1, #1 
	bne LoadUnitTime 
	@ We reset their stats by clearing the unit 
	
	@ or just clear the unit 
	@ r0 is unit def to load  
	blh ClearUnit @ 0x080177f4
	mov r7, #1 
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
@ uDef is the rom unit in the unit group table 
@ therefore, it shouldn't be used here I don't think 
@ 0803bde0 FindUnitClosestValidPosition
@blh  0x803BDE1, r7 @ FindUnitClosestValidPosition




@place most recently loaded unit to valid coord 
PlaceSummonedUnit:

cmp r7, #1 
bne DoNotMatchSummonsLevel @ Unit wasn't cleared, so don't autolevel lol 
mov r3, r9 @ should we match summon's level to the summoner? 
ldrb r0, [r3, #5] @ bool yes/no 
cmp r0, #1 
bne DoNotMatchSummonsLevel 
ldr r2, =CurrentUnit 
ldr r2, [r2]
ldrb r0, [r2, #8] @ Summoner's level 
ldrb r1, [r6, #8] @ Summon's level 
cmp r1, r0 
bge DoNotMatchSummonsLevel 
strb r0, [r6, #8] @ Summon as same lvl as summoner 

sub r2, r0, r1 @ Number of levels to increase by 
ldr r1, [r6, #4]
ldrb r1, [r1, #4] @ class id of summon 
mov r0, r6 @ Summon unit pointer 
blh IncreaseUnitStatsByLevelCount @ // str/mag split compatible
mov r0, r6
blh EnsureNoUnitStatCapOverflow
ldrb r0, [r6, #0x12] 
strb r0, [r6, #0x13] @ Set to max hp 




DoNotMatchSummonsLevel: 

ldr r3, =CurrentUnit
ldr r3, [r3] 

@ need to manually update so hidden units aren't removed @blh  0x0801a1f4   @RefreshFogAndUnitMaps @RefreshEntityMaps 
ldrb r0, [r3, #0x10] 
ldrb r1, [r3, #0x11] 
ldrb r2, [r3, #0x0B] @ Acting unit's deployment byte 

bl WriteDeploymentByteToGivenCoordsUnitMap


ldr r3, =CurrentUnit
ldr r3, [r3] 
ldrh r0, [r3, #0x10] 
push {r0} @ Save current units coords to the stack. Restore after restoring terrain 






@ To find the closest / best position, we're going to mimic the parameters and use this vanilla function 
@ void UnitGetDeathDropLocation(struct Unit* unit, int* xOut, int* yOut)
@ Newly loaded unit in r6 


@ check if using relative coords 
mov r3, r9 
ldrb r0, [r3, #4] 
cmp r0, #1 
beq UsingRelativeCoords
cmp r0, #2 
bne NotUsingRelativeCoords

@ Using Fixed Coords 
ldrh r0, [r5, #4] 
mov r1, #0xF 
lsl r1, #8 
add r1, #0xFF 
@ r1 is 0xFFF. Top 4 bits used for stuff like Monster, Drop Item, etc. 
and r0, r1 
@ r0 is now coords only, 6 bits each  
@ 3F is X, 0x40 - 0xFFF is y 
mov r1, #0x3F
mvn r1, r1 
and r1, r0  
lsr r1, #6 @ YY 
mov r2, #0x3F
and r0, r2 @ XX 

ldr		r3, =0x202E4D4 	@ Map Size  
ldrh 	r2, [r3] @ XX 
sub r2, #1 @ 1 aligned instead of 0 aligned 
ldrh 	r3, [r3, #2] @ YY 
sub r3, #1 @ 1 aligned instead of 0 aligned 
cmp r0, r2 
bgt NotUsingRelativeCoords @ Outside border of map 
cmp r1, r3 
bgt NotUsingRelativeCoords @ Outside border of map 
@r0 still XX, r1 still yy 
bl IsTileFreeFromUnits @ Returns r0 T/F, r1 YY, r2 XX 
cmp r0, #1 
bne Fixed_C_DontAddOneToYCoord @ Target tile is not free, but if we summon from there it should find a valid tile

mov r0, r2 @ XX 
@ r1 is already yy 
mov r2, r6 
bl Call_CanUnitCrossTerrain
cmp r0, #1 
bne NotUsingRelativeCoords @ Fixed coords will bug if it can't place units to the tile, potentially 
@bne Fixed_C_DontAddOneToYCoord 
mov r0, r2
b ValidCoordSkip
@add r1, #1 @ pretend we're 1 tile below where we want to spawn stuff 
Fixed_C_DontAddOneToYCoord:
mov r0, r2 

ldr r3, =CurrentUnit 
ldr r3, [r3] 
strb r0, [r3, #0x10] @ XX coord 
strb r1, [r3, #0x11] @ YY coord 
b NotUsingRelativeCoords @ We used fixed coords already


UsingRelativeCoords: 
@ check that current unit can reach destination 
@ if so, put the current unit to those coords 
ldrh r0, [r5, #4] 
mov r1, #0xF 
lsl r1, #8 
add r1, #0xFF 
@ r1 is 0xFFF. Top 4 bits used for stuff like Monster, Drop Item, etc. 
and r0, r1 
@ r0 is now coords only, 6 bits each  
@ 3F is X, 0x40 - 0xFFF is y 
mov r1, #0x3F
mvn r1, r1 
and r1, r0  
lsr r1, #6 @ YY 

mov r2, #0x3F
and r0, r2 @ XX 

@ r0 = XX, r1 = YY 

mov r2, #10 
sub r0, r0, r2 @ XX - 10 
sub r1, r1, r2 @ YY - 10


ldr r3, =CurrentUnit 
ldr r3, [r3] @ Current unit ram struct pointer 
ldrb r2, [r3, #0x10] @ X 
ldrb r3, [r3, #0x11] @ Y 


add r0, r2 



@ Check that we wouldn't be summoning outside the border of the map? 
@ this probably is wrong for right/down borders 
cmp r0, #0 
bge NoCapXXLeft
mov r0, #0 @ 
NoCapXXLeft: 
ldr		r3, =0x202E4D4 	@ Map Size  
ldrh 	r2, [r3] @ XX 
sub r2, #1 @ 1 aligned instead of 0 aligned 
cmp r0, r2 
blt NoCapXXRight
mov r0, r2 @ edge of map 
NoCapXXRight:

ldr r3, =CurrentUnit 
ldr r3, [r3] @ Current unit ram struct pointer 

ldrb r2, [r3, #0x11] @ Y 
 
add r1, r2 
cmp r1, #0 
bge NoCapYYUp
mov r1, #0 @ 
NoCapYYUp: 
ldr		r3, =0x202E4D4 	@ Map Size  
ldrh 	r3, [r3, #2] @ YY 
sub r3, #1 @ 1 aligned instead of 0 aligned 
cmp r1, r3 
blt NoCapYYDown
mov r1, r3 @ edge of map 
NoCapYYDown:



bl IsTileFreeFromUnits @ Returns r0 T/F, r1 YY, r2 XX 
cmp r0, #1 
bne DontAddOneToYCoord 
mov r0, r2 
bl CanWeReachOnMovementMap 
cmp r0, #1 
bne DontAddOneToYCoord 

@ We ruined the terrain earlier, so whatever 
@mov r0, r2 
@mov r2, r6 
@bl Call_CanUnitCrossTerrain
@cmp r0, #1 
@bne DontAddOneToYCoord
@ If we move this check earlier, we can potentially figure out if we are completely surrounded by walls 
@ because stuff will break in that specific case 

mov r0, r2
b ValidCoordSkip
DontAddOneToYCoord:
mov r0, r2 @ XX 
@ if this is false, then we cannot reach the destination, so we'll not use relative coords 
@ however, we'll write to adjacent tiles in the UnitMap so that summons avoid being adjacent 
@ (just for cool factor, I guess) 

bl CanWeReachOnMovementMap
@ returns T/F r0, yy r1, xx r2 
cmp r0, #0x1 
bne NotUsingRelativeCoords

ldr r3, =CurrentUnit
ldr r3, [r3] 
mov r0, r2 
@ r1 is already y 
strb r0, [r3, #0x10] 
strb r1, [r3, #0x11] 




NotUsingRelativeCoords:

@ If the summoner is stuck surrounded by walls for some reason, stuff below would fail 


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




sub sp, #0x38 
mov r0, sp 
b Continue 

ldr r0, =0x859da94 @ Procs SMSJumpAnimation 
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
mov r11,r11 

add sp, #0x38 

strb r1, [r6, #0x10] @ X
strb r2, [r6, #0x11] @ Y



@blh  0x8019FA0 @ UpdateUnitMapAndVision RefreshUnitMapAndVision
@ need to manually update so hidden units aren't removed @blh  0x0801a1f4   @RefreshFogAndUnitMaps @RefreshEntityMaps 
@blh   0x0801a1f4   @RefreshFogAndUnitMaps

ldrb r0, [r6, #0x10] @ XX 
ldrb r1, [r6, #0x11] @ YY 
ldrb r2, [r6, #0x0B] @ Deployment byte 

bl WriteDeploymentByteToGivenCoordsUnitMap

ldr r0, [r6, #0x0C] @ New unit's state 
mov r1, #1  @ 0x1 - Hide 
orr r0, r1 
str r0, [r6, #0x0C] 

mov r0, r6 
bl SendToQueueASMC @ Store unit pointer in queue 

@blh  0x080271a0   @SMS_UpdateFromGameData
@
ldr r0, =WarpAnimationEvent
mov r1, #1 
blh EventEngine 


@ this causes the animations to all to occur at once 
@ needs parent proc in r0 ? 
@mov r0, r8 @ Parent proc (event engine) 
@blh  0x807AD09 @ New6C_SummonGfx_FromActionStructCoords 


strb r4, [r6, #0x1B] @ rescued Deployment byte 

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

@ Restore current unit's coords here, too 
pop {r0}
ldr r3, =CurrentUnit
ldr r3, [r3] 

strh r0, [r3, #0x10] 



b LoadEachSummonLoop 

ValidCoordSkip:
mov r11, r11 
strb r0, [r6, #0x10]
strb r1, [r6, #0x11]

@ldr		r3, =0x202E4D4 	@ Map Size  
@ldrh 	r2, [r3] @ XX 
@sub r2, #1
@ldrh 	r3, [r3, #2] @ YY 
@sub r3, #1


@ unnecessary? 
@ldr r3, =CurrentUnit 
@ldr r3, [r3] 
@strb r0, [r3, #0x10] 
@strb r1, [r3, #0x11] 

@ldr r3, =0x203A958 
@strb r0, [r3, #0x13] 
@strb r1, [r3, #0x14] 
@
ldrb r0, [r6, #0x10] @ XX 
ldrb r1, [r6, #0x11] @ YY 
ldrb r2, [r6, #0x0B] @ Deployment byte 

bl WriteDeploymentByteToGivenCoordsUnitMap

ldr r0, [r6, #0x0C] @ New unit's state 
mov r1, #1  @ 0x1 - hide
orr r0, r1 
str r0, [r6, #0x0C] 

mov r0, r6 
bl SendToQueueASMC @ Store unit pointer in queue 

@blh  0x080271a0   @SMS_UpdateFromGameData
@
ldr r0, =WarpAnimationEvent
mov r1, #1 
blh EventEngine 





@ Restore current unit's coords here, too 
pop {r0}
strh r0, [r3, #0x10] 
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


@ Restore camera 
ldr r0, =ModularSummon_RestoreCameraEvent 
mov r1, #1 
blh EventEngine 



End:

	
	@blh  0x080271a0   @SMS_UpdateFromGameData
	blh  0x08019c3c   @UpdateGameTilesGraphics

ldr r1, CurrentUnitFateData	@these four lines copied from wait routine
mov r0, #0x1
strb r0, [r1,#0x11]
mov r0, #0x17	@makes the unit wait?? makes the menu disappear after command is selected??
@mov r0,#0x94		@play beep sound & end menu on next frame & clear menu graphics
 
@ SET_ABS_FUNC AiSetDecision, 0x8039C21
@ void AiSetDecision(int xPos, int yPos, int actionId, int targetId, int itemSlot, int xPos2, int yPos2);
@ SetAiActionParameters(XX, YY, 5, 0, 0, 0, 0) 


	pop {r6}
	mov r9, r6 

	pop {r7}
	mov r8, r7 @ Restore r8 
	pop {r4-r7}
	pop {r1}
	bx r1 
	
	
.ltorg
.align 

ExecuteEvent:
	.long 0x800D07D @AF5D
CurrentUnitFateData:
	.long 0x203A958
	.thumb 
	
.global ModularSummon_RestoreCameraASMC
.type ModularSummon_RestoreCameraASMC, %function 
ModularSummon_RestoreCameraASMC:
push {lr}
@mov r0,#1
@ r0 = 0 , r1 X, r2 Y 
ldr r3, =CurrentUnit
ldr r3, [r3] 
ldrb r1, [r3, #0x10] @ X coord 
ldrb r2, [r3, #0x11] @ Y coord 
@blh EnsureCameraOntoPosition
@ r0 = parent proc, r1 x, r2 y
blh CenterCameraOntoPosition
pop {r0} 
bx r0 
	
.type IsTileFreeFromUnits, %function 
IsTileFreeFromUnits:
push {lr}
@ Given r0 = x, r1 = y 
mov r2, r0 
lsl r2, #8 
add r2, r1 

ldr		r3,=0x202E4D8	@Unit map 	@Load the location in the table of tables of the map you want
ldr		r3,[r3]			@Offset of map's table of row pointers
lsl		r1,#0x2			@multiply y coordinate by 4
add		r3,r1			@so that we can get the correct row pointer
ldr		r3,[r3]			@Now we're at the beginning of the row data
add		r3,r0			@add x coordinate
ldrb	r0,[r3]			@load datum at those coordinates

cmp r0, #0 
bne TileIsNotFree
mov r0, #1 
b EndTileFreeFromUnits 

TileIsNotFree: 
mov r0, #0 @ Tile is not free 
EndTileFreeFromUnits: 
lsl r1, r2, #24 
lsr r1, #24 
lsr r2, #8 
@ return r0 true/false, r1 yy, r2 xx 

pop {r3} 
bx r3 

.type ClearTheMemorySlotQueue_ASMC, %function 
ClearTheMemorySlotQueue_ASMC:







.type Call_CanUnitCrossTerrain, %function 
Call_CanUnitCrossTerrain:
push {r4, lr}
@ Given r0 = x, r1 = y, r2 = unit struct
mov r4, r0 
lsl r4, #8 
add r4, r1 

ldr		r3, =0x202E4DC @ Terrain map	@Load the location in the table of tables of the map you want
ldr		r3,[r3]			@Offset of map's table of row pointers
lsl		r1,#0x2			@multiply y coordinate by 4
add		r3,r1			@so that we can get the correct row pointer
ldr		r3,[r3]			@Now we're at the beginning of the row data
add		r3,r0			@add x coordinate
ldrb	r1,[r3]			@load datum at those coordinates
mov r0, r2 @ unit struct 
blh CanUnitCrossTerrain @0x801949c 
lsl r1, r4, #24 
lsr r1, #24 
lsr r2, r4, #8 
@ return r0 true/false, r1 yy, r2 xx 
pop {r4}
pop {r3} 
bx r3 


.type CanWeReachOnMovementMap, %function 
CanWeReachOnMovementMap:
push {lr}
@ Given r0 = x, r1 = y 


ldr r3, =0x202BCF0 @ gChapterData
ldrb r3, [r3, #0xF] @ Phase 
mov r2, #0xC0 
and r3, r2

mov r2, r0 
lsl r2, #8 
add r2, r1 

cmp r3, #0 
bne EnemyPhase

ldr		r3,	=0x202E4E0	@player =0x202E4E0	@Movement map 	@Load the location in the table of tables of the map you want
ldr		r3,[r3]			@Offset of map's table of row pointers
lsl		r1,#0x2			@multiply y coordinate by 4
add		r3,r1			@so that we can get the correct row pointer
ldr		r3,[r3]			@Now we're at the beginning of the row data
add		r3,r0			@add x coordinate
ldrb	r0,[r3]			@load datum at those coordinates
cmp r0, #0xFF 
beq WeCannotReachOnMovementMap 
mov r0, #1 
b EndCanWeReachOnMovementMap

EnemyPhase:
ldr		r3,	=0x202E4F0	@enemy =0x202E4E0	@Movement map 	@Load the location in the table of tables of the map you want
ldr		r3,[r3]			@Offset of map's table of row pointers
lsl		r1,#0x2			@multiply y coordinate by 4
add		r3,r1			@so that we can get the correct row pointer
ldr		r3,[r3]			@Now we're at the beginning of the row data
add		r3,r0			@add x coordinate
ldrb	r0,[r3]			@load datum at those coordinates
cmp r0, #0xFF 
beq WeCannotReachOnMovementMap 
mov r0, #1 
b EndCanWeReachOnMovementMap

WeCannotReachOnMovementMap: 
mov r0, #0 @ Tile is not free 
EndCanWeReachOnMovementMap: 
lsl r1, r2, #24 
lsr r1, #24 
lsr r2, #8 
@ return r0 true/false, r1 yy, r2 xx 
pop {r3} 
bx r3 




@.global WriteDeploymentByteToGivenCoordsUnitMap
.type WriteDeploymentByteToGivenCoordsUnitMap, %function 	
WriteDeploymentByteToGivenCoordsUnitMap:
push {lr} 
@ Given r0 = X coord, r1 = Y coord, and r2 = deployment byte, 
@ store deployment byte to the unit map at those coords 

ldr		r3,=0x202E4D8 @ UnitMap 	@Load the location in the table of tables of the map you want
ldr		r3,[r3]			@Offset of map's table of row pointers
lsl		r1,#0x2			@multiply y coordinate by 4
add		r3,r1			@so that we can get the correct row pointer
ldr		r3,[r3]			@Now we're at the beginning of the row data
add		r3,r0			@add x coordinate
@ldrb	r0,[r3]			@load datum at those coordinates
strb 	r2, [r3] @ Store deployment byte to Unit Map given coords 
pop {r0}
bx r0 






@ Queue starts at 030004F0 
@ Queue size from mem slot D 
@ find entry 
@ save and load from there 
.global SendToQueueASMC
.type SendToQueueASMC, %function 
SendToQueueASMC:
push {lr} 
@mov r0, #0x3F 
@ Store r0 to queue ? 
ldr r3, =0x30004F0 
ldr r2, =0x30004B8 
ldr r1, [r2, #0x34] 
lsl r1, #2 
add r1, r3 
str r0, [r1] 
ldr r0, [r2, #0x34] 
add r0, #1 
str r0, [r2, #0x34] 

pop {r1} 
bx r1 


.global ModularSummon_GetSummonedUnitCoords
.type ModularSummon_GetSummonedUnitCoords, %function 
	
ModularSummon_GetSummonedUnitCoords:
push {lr} 
ldr r3, =MemorySlot 
ldr r2, [r3, #4*0x01] @ Unit pointer 
ldrb r0, [r2, #0x10] @ XX 
ldrb r1, [r2, #0x11] @ YY 
lsl r1, #16 
add r0, r1 
str r0, [r3, #4*0x0B] @ SlotB 
pop {r0} 
bx r0 


.global WarpAnimationQueue 
.type WarpAnimationQueue, %function 
	
WarpAnimationQueue:
push {r4-r5, lr} 
mov r4, r0 @ Parent event engine 
ldr r3, =MemorySlot 
ldr r5, [r3, #4*0x01] @ Unit pointer 
ldr r0, [r5, #0x0C] @ New unit's state 

mov r1, #1 
mvn r1, r1 
and r0, r1 @ remove 0x1 - Hidden 

str r0, [r5, #0x0C] 

ldr r3, =0x203A958 @ ActionStruct 
ldrb r1, [r5, #0x10]
strb r1, [r3, #0x13] @ X 
ldrb r2, [r5, #0x11] 
strb r2, [r3, #0x14] @ Y 




mov r0, r4 @ Parent proc (event engine) 
blh New6C_SummonGfx_FromActionStructCoords @0x807AD09  


@blh  0x080271a0   @SMS_UpdateFromGameData

pop {r4-r5} 
pop {r1} 
bx r1 
	

	
	


.global PauseEventEngineWhileUnitsAreMoving
.type PauseEventEngineWhileUnitsAreMoving, %function
PauseEventEngineWhileUnitsAreMoving: @ r0 = parent proc (the event engine). This is presumably ASMCed. 
push { lr }
mov r1, r0
ldr r0, =PauseEventEngineUnitsMovingProc
blh ProcStartBlocking, r2
pop { r0 }
bx r0
	

.global IfProcStateWrongThenCallEventEndB 
.type IfProcStateWrongThenCallEventEndB, %function
IfProcStateWrongThenCallEventEndB:
push {r4, lr} 
mov r4, r0 @ Parent? 
ldr r0, =0x85a8024 @gProc_CpPerform
blh ProcFind, r1 
ldr r3, =MemorySlot 

cmp r0, #0 
beq ProcStateError 
ldr r1, [r0, #4] @ Code Cursor 
ldr r2, =0x85A804C

cmp r1, r2 
beq ReturnProcStateRight 

ProcStateError:
ldr r0, =ASMCModularSummonEvent
mov r1, #1 
blh EventEngine 

mov r0, #0 
str r0, [r3, #4*0x0C] 
b EndIfProcStateWrongThenCallEventEndB

ReturnProcStateRight:
mov r0, #1 
str r0, [r3, #4*0x0C] 

EndIfProcStateWrongThenCallEventEndB:
pop {r4}
pop {r1}
bx r1 


.global IfActiveAIFinishedMovingThenStopPausingEventEngine
.type IfActiveAIFinishedMovingThenStopPausingEventEngine, %function
IfActiveAIFinishedMovingThenStopPausingEventEngine:
push {r4, lr} 
mov r4, r0 @ Parent? 
mov r11, r11 
b ContinuePausingEventEngine
@b BreakProcLoopNow
@ MU_IsAnyActive
@ wait until proc CpPerform begins 0x85A8024 
ldr r0, =0x85a8024 @gProc_CpPerform
blh ProcFind, r1
@mov r11, r11 
cmp r0, #0 
beq ContinuePausingEventEngine 
ldr r1, [r0, #4] @ Code Cursor 
ldr r2, =0x85A804C
cmp r1, r2 
bne ContinuePausingEventEngine
b BreakProcLoopNow

@

ldr r0, =0x85A8024
blh ProcFind, r1 
cmp r0, #0 
beq BreakProcLoopNow
mov r2, #0x28 @ block counter  
ldrb r1, [r0, r2] 
mov r11, r11
cmp r1, #0 
bne ContinuePausingEventEngine 
b BreakProcLoopNow

ldr r0, =0x859a548 @gProc_CameraMovement
@blh ProcFind, r1 
@cmp r0, #0 
@bne ContinuePausingEventEngine

@ wait until movement begins 

ldr r0, =0x89a2c48 @gProc_MoveUnit
blh ProcFind, r1 
mov r11, r11 
cmp r0, #0 
beq ContinuePausingEventEngine 
@@
@
@mov r11, r11 
@blh 0x8078739 @ MU_IsAnyActive
mov r11, r11 
@cmp r0, #0 
@beq ContinuePausingEventEngine 
b BreakProcLoopNow
@ 
// #5 is staffwait, we want #0x12 ? @ 803a204 CpPerform_StaffWait

cmp r0, #0x01
beq BreakProcLoopNow
b ContinuePausingEventEngine
	@mov r1, #0x3F 
	@ldrb r0, [ r0, r1 ] 
	@cmp r0, #1 
	@bne ContinuePausingEventEngine 
BreakProcLoopNow: 
mov r0, r4 @ parent to break from 
blh BreakProcLoop
ContinuePausingEventEngine: 
pop {r4}
pop {r0} 
bx r0 
	

.align 4
.global UpdateActiveUnitCoords
.type UpdateActiveUnitCoords, %function 
UpdateActiveUnitCoords: 
push {lr} 

ldr r3, =CurrentUnit 
ldr r3, [r3] 
ldr r2, =MemorySlot 
mov r1, #4*0x0B 
ldr r2, [r2, r1] 
lsl r0, r2, #24 
lsr r0, #24 
lsr r1, r2, #16 
strb r0, [r3, #0x10] 
strb r1, [r3, #0x11] 
	
pop {r0} 
bx r0 




.align 4 



.align 4 
@ Based on 803CDD4 
@ 803B808 FindSafestTileAI from 803CDE7
@.global CopyAIScript11
.type CopyAIScript11_Move_Towards_Safety, %function 
CopyAIScript11_Move_Towards_Safety: 
push {r4-r5, lr}
sub sp, #0x10 @ allocate space 
mov r5, r0 @ dunno - 203CFFF ? not needed for my purposes i think 
ldr r0, =CurrentUnit 
ldr r0, [r0] 
add r4, sp, #0x0C @ stack address to save something to  ? 
mov r1, r4 
blh FindSafestTileAI @0x803B809  


@ returns true or false 
@ if false, don't do AiSetDecision 
@ at a glance, it always returned true 
@ so I don't know what criteria it returns false for 
@ maybe if it failed in some way... ? 
lsl r0, #24 
lsr r0, #24 @ bool is a byte 
@add r0, sp, #0x0C @ stack address to save something to
mov r2, #0 
ldsh r0, [r4, r2] 
mov r2, #2
ldsh r1, [r4, r2] 
@ then it stores stuff into the sp and runs AiSetDecision 
add sp, #0x10 
pop {r4-r5}
pop {r2} 
bx r2 

.align 4
.global RunAwayModularSummon
.type RunAwayModularSummon, %function 
RunAwayModularSummon:
push {r4-r5, lr} 

@ if I do this, they instead will attack things so I commented these 5 lines out 
@ ModularSummonEffect handles the case of it not actually being usable anyway 
@ So it just has no effect 

@bl ModularSummonUsability 
@cmp r0, #1 
@beq ContinueRunAway
@b TryOtherAIOptionsInstead  
@ContinueRunAway:
mov r5, #0 @ Don't take offensive action 
bl CopyAIScript11_Move_Towards_Safety @ based on current unit, should return r0 XX r1 YY coords 
bl SetAIToWaitAtCoords
b ReturnTrue

.align 4
.global ApproachEnemyModularSummon
.type ApproachEnemyModularSummon, %function 
ApproachEnemyModularSummon:
push {r4-r5, lr} 
mov r5, #1 @ Do take offensive action 
ldr r3, =CurrentUnit 
ldr r0, [r3] 
add r0, #0x45 
@ 0x803ce18 @ AIScript12_Move_Towards_Enemy 
@ r0 is 202D001, d049, d091 
@ this is ActiveUnit ram address + 0x45 (AI2 count) 
blh AIScript12_Move_Towards_Enemy @0x803ce18 

ldr r3, =0x203AA96 @ AI decision +0x92 (XX) 
ldrb r0, [r3, #0x0] @ XX 
ldrb r1, [r3, #0x1] @ YY 

bl ModularSummonUsability 
cmp r1, #1 
bne TryOtherAIOptionsInstead 
ldr r3, =0x203AA96 @ AI decision +0x92 (XX) 
ldrb r0, [r3, #0x0] @ XX 
ldrb r1, [r3, #0x1] @ YY 

ldr r3, =MemorySlot
add r3, #4*0x0B @ Slot B 
strh r0, [r3, #0] 
strh r1, [r3, #2] 
bl SetAIToWaitAtCoords 
b EnqueueModularSummon


.type SetAIToWaitAtCoords, %function 
SetAIToWaitAtCoords:
@ given r0 = XX and r1 = YY, wait at coords. 
push {lr}
sub sp, #0xC 

ldr r3, =CurrentUnit 
ldr r3, [r3] 
ldr r2, [r3] @ char table unit 
ldrb r2, [r2, #4] @ Unit ID 
ldr r3, =MemorySlot @ r3 is no longer unit 
str r2, [r3, #0x02*4] @ ------ID in s2 
lsl r2, r1, #16 
add r2, r0 
str r2, [r3, #0x0B*4] @ ----YY--XX coord in sB 


@mov r2, #0 @ Action: noop @ when they move to a coord, it had 0 here (but runs the range event in some other way I guess) 
@mov r11, r11 
@ #0x00 - noop (does not trigger range events) 
@ #0x01 - attacks target? but since I have no target it just crashes the game 
@ #0x02 - moved two tiles to the left 
@ #0x03 - gold was stolen 
@ #0x04 - the village was destroyed 
@ #0x05 - wait, I guess? it ran the range event, which is good enough for me
@ #0x07 - targets something but no crash 
@ #0x08 - targets something but no crash 
@ #0x09 - wait ? 
@ #0xFF - targets & crashes 

mov r2, #0x5 
mov r3, #0 @ store into item slot / X / Y coord 
str r3, [sp, #0] @ Item slot 
str r3, [sp, #4] @ X Coord2 (0 is fine) 
str r3, [sp, #8] @ Y Coord2 (0 is fine)
mov r3, #0 @ Target 
blh AiSetDecision, r4 @0x8039C21 
add sp, #0xC 
@ breaks once per enemy with this AI, so perfect 
@ but doesn't actually 'wait' at the spot, so it doesn't trigger range events.. 
@ so we manually trigger them now 
@ but first, let's put the active unit's coord into sB and their unit id in s2 
pop {r1}
bx r1 



@ Tried invoking the EventEngine and it didn't work
@ so it's running this 3x then running the event 3x 
@ when it runs the event 3x, the current unit is the same for all 3 hmm 
@ldrb r0, [r3, #0x10] @ X 
@ldrb r1, [r3, #0x11] @ Y 
@bl RunMiscBasedEvents - this was from Sme's FreeMovement hack. 
@ Since it didn't work correctly in this context, it is no longer included below 

EnqueueModularSummon: 

bl ModularSummonUsability 
cmp r1, #1 
bne NotWorthTryingToSummon

ldr r0, =ASMCModularSummonEvent 
mov r1, #1 
blh EventEngine 
b ReturnTrue 

NotWorthTryingToSummon:
cmp r5, #0 
bne TryOtherAIOptionsInstead 
b ReturnTrue 


@ If this is false, it tries to do other stuff like attack I guess 
@ I really don't know how it works 
TryOtherAIOptionsInstead:
ldr r3, =CurrentUnit
ldr r3, [r3] 
mov r2, #0x41 @ AI4 
mov r1, #0x20 @ BossAI
ldrb r2, [r3, r2] 
and r1, r2 
cmp r1, #0 
beq ReturnFalse
@ do wait AI here instead 
ldrb r0, [r3, #0x10] 
ldrb r1, [r3, #0x11] 
bl SetAIToWaitAtCoords
b ReturnTrue 

ReturnFalse: 
mov r0, #0 @ False 
b ExitModularSummonAI 

ReturnTrue: 
mov r0, #1 @ True that we made an AI decision 

ExitModularSummonAI:
pop {r4-r5}
pop {r1} 
bx r1 

.align 4
.ltorg

	
.global ModularSummonUsability
.type ModularSummonUsability, %function

ModularSummonUsability:
push {r4-r7, lr}
mov r7, r8 
push {r7}
mov r1, #0
mov r8, r1 @ how many we can summon 
ldr r3, =CurrentUnit 
ldr r3, [r3] @ unit struct ram pointer 
mov r7, r3 

ldr r4, =ModularSummonTable
sub r4, #12
@ find matching entry or terminate 
TableLoopStart2:
add r4, #12
ldr r2, [r4, #8] @ If unit group is empty, then terminate 
cmp r2, #0 
beq Usability_False @ DetermineUsability @ ? 


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
ldrb r1, [r1, #4] @ class id 
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
ldrb r0, [r4, #3] 
cmp r0, r1 
bne TableLoopStart2

ValidFlagException2:
@ check if unit exists now 
ldr r5, [r4, #8] 
@ loop 
sub r5, #20 
CheckIfAnySummonedUnitDoesNotExistLoop:  
add r5, #20 
ldr r0, [r5]
cmp r0, #0 
beq DetermineUsability @ We iterated through all units in the group, so return usability now 

mov r1, #1
add r8, r1 @ 1 unit found 

ldrb r0, [r5] @ unit id 

ldr r2, [r7] @ You cannot summon yourself, as this breaks the terrain. 
ldrb r2, [r2, #4] 
cmp r0, r2 
beq CheckIfAnySummonedUnitDoesNotExistLoop @ You cannot summon yourself, as this breaks the terrain. 


blh GetUnitByEventParameter
cmp r0, #0 
beq AddToCounter
ldr r1, [r0, #0x0C] @ State 
mov r2, #0x04 @ Dead 
and r2, r1 
cmp r2, #0 
bne AddToCounter @ Unit is dead, so return True 
b CheckIfAnySummonedUnitDoesNotExistLoop 

AddToCounter:
mov r0, #1 
lsl r0, #8 
add r8, r0 @ ----AABB // AA is number of valid summons. BB is total potential number of summons 
@ they were cleared or dead, so true 
b CheckIfAnySummonedUnitDoesNotExistLoop 






DetermineUsability:
@ Total summonable   
mov r3, r8
lsr r0, r3, #8 
 

@ Total potential summonable 
lsl r1, r3, #24 
lsr r1, #24 

lsr r2, r1, #1 @ half 
cmp r0, r2 
bgt SummoningHalfOrMore 
mov r1, #0 
cmp r0, #0 
beq Usability_False @ Count of 0 units, so false 

UsabilityTrue:
mov r0, #1 
b Exit

SummoningHalfOrMore: 
mov r1, #1 
b UsabilityTrue

Usability_False:
mov r0, #3 @ False is 3 for some reason  
mov r1, #0 @ don't try to summon 

Exit: 
pop {r7}
mov r8, r7 
pop {r4-r7}
pop {r2} 
bx r2 

