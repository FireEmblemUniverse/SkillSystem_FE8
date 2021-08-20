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
mov r7, r8  
push {r7} @ Save r8 to restore at the end 
mov r8, r0 @ Parent proc 

ldr r3, =CurrentUnit 
ldr r3, [r3] @ unit struct ram pointer 
cmp r3, #0 
beq GotoBreak
ldr r2, [r3] 
cmp r2, #0 
bne SetupStuff 
GotoBreak:
b Break  @ No unit so break 

SetupStuff:
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
@ break 



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

@ idk 
@ldr r3, =0x203A958 @ ActionStruct 
@strb r1, [r3, #0x13] @ XX 
@strb r2, [r3, #0x14] @ YY 




ldr r0, [r6, #0x0C] @ New unit's state 
mov r1, #1 
lsl r1, #16 
@add r1, #1 @ 0x10001 - Escaped,Hidden 
orr r0, r1 
@str r0, [r6, #0x0C] 

mov r0, r6 
mov r11, r11 
bl SendToQueueASMC @ Store unit pointer in queue 

@blh  0x080271a0   @SMS_UpdateFromGameData
@
ldr r0, =WarpAnimationEvent
mov r1, #1 
blh EventEngine 


@ this causes the animations to all to occur at once 
@ needs parent proc in r0 ? 
@mov r0, r8 @ Parent proc (event engine) 
@blh 0x807AD09 @ New6C_SummonGfx_FromActionStructCoords 


strb r4, [r6, #0x1B] @ rescued Deployment byte 



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

@ldr r0, =GlowingCrossEvent
@mov r1, #1 
@blh EventEngine 

End:

	blh  0x0801a1f4   @RefreshFogAndUnitMaps
	@blh  0x080271a0   @SMS_UpdateFromGameData
	blh  0x08019c3c   @UpdateGameTilesGraphics

ldr r1, CurrentUnitFateData	@these four lines copied from wait routine
mov r0, #0x1
strb r0, [r1,#0x11]
mov r0, #0x17	@makes the unit wait?? makes the menu disappear after command is selected??
@mov r0,#0x94		@play beep sound & end menu on next frame & clear menu graphics
 
@ SET_ABS_FUNC AiSetDecision, 0x8039C21
@ void AiSetDecision(int xPos, int yPos, int actionId, int targetId, int itemSlot, int xPos2, int yPos2);
@ 		SetAiActionParameters(
@ 			xMovement, yMovement,
@			AI_DECISION_DANCE,
@			targetIndex, 0, 0, 0); 

@ SetAiActionParameters(XX, YY, 1, 0, 0, 0, 0) 


@ XX cur pos 
@@ YY cur pos 
@ decision = 0x01	Wait 
@ target = 0 no target 
@ item = 0 
@ xPos2, yPos2 = 0 




Break:
mov r0, #1

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
	
@ I thought maybe I could queue asmc and events this way, but it didn't work either 
@.global RunMakeAIWaitEvent
@.type RunMakeAIWaitEvent, %function 	
@RunMakeAIWaitEvent:
@push {lr} 
@ldr r0, =MakeAIWaitEvent @1 and 2 seem to wait, 0,3,4,8,0xFF does not 
@mov r1, #0x02
@blh EventEngine 
@@ldr r0, =DoNothingEvent 
@@mov r1, #1 
@@blh EventEngine 
@mov r0, #1 
@pop {r1}
@bx r1  


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


@ldr r1, =0x800D529 
pop {r1} 
bx r1 


@[030004E4]!!
.global WarpAnimationQueue 
.type WarpAnimationQueue, %function 
	
WarpAnimationQueue:
push {r4-r5, lr} 
mov r4, r0 @ Parent event engine 
ldr r3, =MemorySlot 
ldr r5, [r3, #4*0x01] @ Unit pointer 
mov r11, r11 
ldr r0, [r5, #0x0C] @ New unit's state 

mov r1, #1 
lsl r1, #16 
neg r1, r1 
sub r1, #1 
and r0, r1 @ remove 0x10001 - Escaped,Hidden 
mov r0, #0

str r0, [r5, #0x0C] 

ldr r3, =0x203A958 @ ActionStruct 
ldrb r0, [r5, #0x10]
strb r0, [r3, #0x13] @ X 
ldrb r1, [r5, #0x11] 
strb r1, [r3, #0x14] @ Y 


mov r0, r4 @ Parent proc (event engine) 
blh 0x807AD09 @ New6C_SummonGfx_FromActionStructCoords 


@blh  0x080271a0   @SMS_UpdateFromGameData

pop {r4-r5} 
pop {r1} 
bx r1 
	
	
	
	
.equ ProcStartBlocking, 0x08002CE0
.equ BreakProcLoop, 0x08002E94
.global PauseEventEngineWhileUnitsAreMoving
.type PauseEventEngineWhileUnitsAreMoving, %function
PauseEventEngineWhileUnitsAreMoving: @ r0 = parent proc (the event engine). This is presumably ASMCed. 
push { lr }
mov r1, r0
ldr r0, =PauseEventEngineUnitsMovingProc
blh ProcStartBlocking, r2
pop { r0 }
bx r0
	
.equ ProcFind, 0x08002E9C

.global IfActiveAIFinishedMovingThenStopPausingEventEngine
.type IfActiveAIFinishedMovingThenStopPausingEventEngine, %function
IfActiveAIFinishedMovingThenStopPausingEventEngine:
push {r4, lr} 
mov r4, r0 @ Parent? 
ldr r0, =0x89a2c48 @gProc_MoveUnit
blh ProcFind, r1
cmp r0, #0x00
beq BreakProcLoopNow
	mov r1, #0x3F 
	ldrb r0, [ r0, r1 ] 
	cmp r0, #1 
	bne ContinuePausingEventEngine 
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
mov r11, r11
	
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
blh 0x803B809 @ FindSafestTileAI

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
b SetAIToWaitAtCoords

.align 4
.global ApproachEnemyModularSummon
.type ApproachEnemyModularSummon, %function 
ApproachEnemyModularSummon:
push {r4-r5, lr} 
mov r5, #1 @ Do take offensive action 
bl ModularSummonUsability 
cmp r1, #1 
beq ContinueApproachEnemy
b TryOtherAIOptionsInstead 
ContinueApproachEnemy:
ldr r3, =CurrentUnit 
ldr r0, [r3] 
add r0, #0x45 
@ 0x803ce18 @ AIScript12_Move_Towards_Enemy 
@ r0 is 202D001, d049, d091 
@ this is ActiveUnit ram address + 0x45 (AI2 count) 
blh 0x803ce18 @ AIScript12_Move_Towards_Enemy

ldr r3, =0x203AA96 @ AI decision +0x92 (XX) 
ldrb r1, [r3, #0x0] @ XX 
ldrb r2, [r3, #0x1] @ YY 

ldr r3, =MemorySlot
add r3, #4*0x0B @ Slot B 
strh r1, [r3, #0] 
strh r2, [r3, #2] 
b EnqueueModularSummon


@ given r0 = XX and r1 = YY, wait at coords. 
SetAIToWaitAtCoords:
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
blh 0x8039C21, r4 @ AiSetDecision
add sp, #0xC 
@ breaks once per enemy with this AI, so perfect 
@ but doesn't actually 'wait' at the spot, so it doesn't trigger range events.. 
@ so we manually trigger them now 
@ but first, let's put the active unit's coord into sB and their unit id in s2 



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
sub r4, #8 
@ find matching entry or terminate 
TableLoopStart2:
add r4, #8
ldr r2, [r4, #4] @ If unit group is empty, then terminate 
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


.global ModularSummon_HowManyCanWeSummonOutOfTotal 
.type ModularSummon_HowManyCanWeSummonOutOfTotal, %function

ModularSummon_HowManyCanWeSummonOutOfTotal:




pop {r4-r7}
pop {r1} 
bx r1 

