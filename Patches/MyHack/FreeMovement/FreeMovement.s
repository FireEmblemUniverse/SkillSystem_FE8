.thumb
.align

.global EnableFreeMovementASMC
.type EnableFreeMovementASMC, %function

.global DisableFreeMovementASMC
.type DisableFreeMovementASMC, %function

.global NewPlayerPhaseEvaluationFunc
.type NewPlayerPhaseEvaluationFunc, %function

.global NewMakePhaseControllerFunc
.type NewMakePhaseControllerFunc, %function

.global FreeMovement_MainLoop
.type FreeMovement_MainLoop, %function

.global ChangeControlledUnitASMC
.type ChangeControlledUnitASMC, %function


.macro blh to,reg=r3
	push {\reg}
	ldr \reg,=\to
	mov r14,\reg
	pop {\reg}
	.short 0xF800
.endm

.equ NewBlockingProc, 0x8002CE1
.equ GotoProcLabel, 0x8002F25
.equ BreakProcLoop, 0x8002E95
.equ gUnitMoveBuffer,0x2033efc 


EnableFreeMovementASMC:
push {r4,r14}
mov r4,r0
ldr r0,=#0x203F2B0	@location of flag
ldrb r1,[r0]		@load a byte
mov r2,#0x1			@this is the mask for the flag
orr r1,r2			@set the flag if not already set
strb r1,[r0]		@store back the byte
@mov r0,r4
@bl NewPlayerPhaseEvaluationFunc @needed to make it actually immediately change mode
pop {r4}
pop {r0}
bx r0				@return

.ltorg
.align

DisableFreeMovementASMC:
push {r4,r14}
mov r4,r0
ldr r0,=#0x203F2B0	@location of flag
ldrb r1,[r0]		@load a byte
mov r2,#0x1			@this is the mask for the flag
neg r2,r2			@invert it since we want to disable this
and r1,r2			@this now gives everything that we loaded except for the flag
strb r1,[r0]		@store back the byte
@mov r0,r4
@bl NewPlayerPhaseEvaluationFunc @needed to make it actually immediately change mode
pop {r0}
bx r0				@return

.ltorg
.align

GetFreeMovementState:
ldr r0,=#0x203F2B0	@location of flag
ldrb r1,[r0]		@load a byte
mov r2,#0x1			@this is the mask for the flag
and r1,r2			@get only the flag from the loaded byte
mov r0,r1			@return the resulting value
bx r14				@return

.ltorg
.align

.equ GetUnitStructFromEventParameter,0x800BC51
.equ MemorySlot1,0x30004BC

ChangeControlledUnitASMC:
push {r14}
ldr r0,=MemorySlot1 @contains event unit parameter
ldr r0,[r0]
blh GetUnitStructFromEventParameter
mov r1,r0
ldr r0,=#0x203F2B4
str r1,[r0]
mov r0,#0
ldrb r2,[r1,#0x11]
ldrb r1,[r1,#0x10]
blh EnsureCameraOntoPosition
pop {r0}
bx r0

.ltorg
.align







NewPlayerPhaseEvaluationFunc:
push {r4,r14}
mov r4,r0 @r4 = parent proc

@check the state of the free movement flag
bl GetFreeMovementState
cmp r0,#1
bne PhaseEval_PlayerPhaseAsNormal

ldr r0,=FreeMovementControlProc
mov r1,r4
blh NewBlockingProc
b PhaseEval_CombinedBits

.ltorg
.align

PhaseEval_PlayerPhaseAsNormal:
ldr r0,=#0x859AAD8 @E_PLAYERPHASE proc
mov r1,r4 @r1 = parent proc
blh NewBlockingProc

PhaseEval_CombinedBits:
mov r1,#7 @7 = proc label
blh GotoProcLabel
mov r0,r4 @r0 = parent proc
blh BreakProcLoop
pop {r4}
pop {r0}
bx r0

.ltorg
.align


NewMakePhaseControllerFunc:
push {r4,r14}
mov r4,r0 @r4 = parent proc

@check the state of the free movement flag
bl GetFreeMovementState
cmp r0,#1
bne PhaseController_DoVanillaFunction

@start our free movement proc instead of the proc we would do otherwise
ldr r0,=FreeMovementControlProc
mov r1,r4
blh NewBlockingProc
b PhaseController_GoBack

.ltorg
.align

PhaseController_DoVanillaFunction:
ldr r0,=#0x202BCF0 @chapter data
ldrb r0,[r0,#0xF] @current phase
cmp r0,#0
beq PhaseController_IsPlayerPhase
b PhaseController_IsComputerPhase

.ltorg
.align

PhaseController_IsComputerPhase:
ldr r0,=#0x85A7F08 @computer phase proc
mov r1,r4
blh NewBlockingProc
b PhaseController_GoBack

.ltorg
.align

PhaseController_IsPlayerPhase:
ldr r0,=#0x859AAD8 @E_PLAYERPHASE proc
mov r1,r4
blh NewBlockingProc

PhaseController_GoBack:
mov r0,r4
blh BreakProcLoop
pop {r4}
pop {r0}
bx r0

.ltorg
.align





.equ MU_IsAnyActive,0x8078739
.equ MU_Exists,0x8078721





FreeMovement_MainLoop:
push {r4-r7,r14}

mov r7,r0 @r7 = parent proc

@if MU proc exists, skip normal unit movement and do the other thing
blh MU_Exists
cmp r0,#1
@beq SkipUnitMovement
beq MainLoop_GoBack

DoNormalThing:
@set active unit to first player unit //this has been made a separate function called on init, we should change how this works
@ldr r0,=#0x202BE4C
ldr r0,=#0x203F2B4
ldr r0,[r0]
ldr r1,=#0x3004E50
str r0,[r1]

mov r0,r7
bl HandleUnitMovement @in place of the cursor movement function, same general idea
b MainLoop_GoBack

SkipUnitMovement:
mov r0,r7
bl HandleContinuedMovement

MainLoop_GoBack:
pop {r4-r7}
pop {r0}
bx r0

.ltorg
.align


.equ gpKeyState,0x858791C
.equ gGameState,0x202BCB0
.equ MoveCameraByStepMaybe,0x8015838
.equ SomeFunc,0x801588C


.global HandleContinuedMovement
.type HandleContinuedMovement, %function

HandleContinuedMovement:
push {r4-r7,r14}
mov r7,r0 @r7 = parent proc
@check for button input
bl CheckDirectionalButtonPress
cmp r0,#0
beq ContinuedMovement_NoMore

@construct the second(?) thing in the move buffer to be a new movement in the returned direction
@the only problem is the directions used there and the directions we returned are different
@it wants left-right-up-down indexed 0-3, we have up-left-down-right indexed 1-4

cmp r0,#1
beq CorrectUpMovement
cmp r0,#2
beq CorrectLeftMovement
cmp r0,#3
beq CorrectDownMovement

CorrectRightMovement:
mov r0,#1
b PostMovementCorrection

CorrectUpMovement:


CorrectLeftMovement:

CorrectDownMovement:



PostMovementCorrection:
ldr r1,=gUnitMoveBuffer
strb r0,[r1,#4]




ContinuedMovement_NoMore:
@sleep another 5 frames
mov r0,r7
mov r1,#8
blh GotoProcLabel
b ContinuedMovement_GoBack


ContinuedMovement_GoBack:
pop {r4-r7}
pop {r0}
bx r0

.ltorg
.align


















CheckDirectionalButtonPress:
push {r14}
ldr r0,=gpKeyState
ldr r2,[r0]
ldr r2,[r2,#4]

CheckUp:
mov r0,#0x40 @up
and r0,r2
cmp r0,#0
beq CheckLeft
mov r0,#1
b RetDirectionPressed

CheckLeft:
mov r0,#0x20
and r0,r2
cmp r0,#0
beq CheckDown
mov r0,#2
b RetDirectionPressed

CheckDown:
mov r0,#0x80
and r0,r2
cmp r0,#0
beq CheckRight
mov r0,#3
b RetDirectionPressed

CheckRight:
mov r0,#0x10
and r0,r2
cmp r0,#0
beq RetNoPress
mov r0,#4
b RetDirectionPressed

RetNoPress:
mov r0,#0

RetDirectionPressed:
pop {r1}
bx r1

.ltorg
.align















.equ MoveUnit,0x807A015 @r0 = unit struct, r1 = x coord, r1 = y coord, r3 = some constant (always 1? is this speed?)
.equ GetSomeEventEngineMoveRelatedBitfield,0x800FCD9
.equ CenterCameraOntoPosition,0x8015D85
.equ TryPrepareEventUnitMovement,0x800FC91
.equ CanUnitCrossTerrain,0x801949D
.equ GetUnit,0x8019431
.equ MuCtr_CreateWithReda,0x800FEF5 @r0 = char struct, target x coord, target y coord
.equ EnsureCameraOntoPosition,0x08015e0d
.equ StartMenuAdjusted,0x804EB98


.global HandleUnitMovement
.type HandleUnitMovement, %function

HandleUnitMovement: @analogue of HandlePlayerCursorMovement
push {r4-r7,r14}

@let's see if we can just make this dumb
@to move units 

@order of operations here

@1. check for button press of any direction
@2. if true, check which direction
@3. once direction is found, if B is being pressed move the unit 2 steps in that direction
@otherwise, only move them 1 step

mov r7,r0


@check for directional button press
bl CheckDirectionalButtonPress
cmp r0,#0
beq CheckAPressLadder

@now we uhhh index a jump table ig

lsl r0,r0,#2
ldr r1,=jpt_UnitDirection
add r0,r1
ldr r0,[r0]

ldr r1,=#0x3004E50
ldr r1,[r1]
mov r4,r1
ldrb r6,[r4,#0x11]
ldrb r5,[r4,#0x10]

bx r0

.ltorg
.align

jpt_UnitDirection:
.word 0
.word MoveUp+0x8000001
.word MoveLeft+0x8000001
.word MoveDown+0x8000001
.word MoveRight+0x8000001

MoveUp:
mov r0,r4
mov r1,r5
mov r2,r6
cmp r2,#0
beq MoveReconvene
sub r2,#1
b MoveReconvene

MoveLeft:
mov r0,r4
mov r1,r5
mov r2,r6
cmp r1,#0
beq MoveReconvene
sub r1,#1
b MoveReconvene

MoveDown:
mov r0,r4
mov r1,r5
mov r2,r6
ldr r3,=#0x202E4D4
ldrh r3,[r3,#2]
sub r3,#1
cmp r2,r3
beq MoveReconvene
add r2,#1
b MoveReconvene

MoveRight:
mov r0,r4
mov r1,r5
mov r2,r6
ldr r3,=#0x202E4D4
ldrh r3,[r3]
sub r3,#1
cmp r1,r3
beq MoveReconvene
add r1,#1
b MoveReconvene

.ltorg
.align



CheckAPressLadder:
b CheckAPress

@this probably needs rewritten, look int MuCtr stuff to do so (structure a REDA in RAM and have it read that as the instruction?)

MoveReconvene:
mov r5,r1
mov r6,r2

@check if the tile we're trying to move to is impassable
@get terrain at that tile
ldr r2,=#0x202E4DC @terrain map
ldr r2,[r2]
lsl r1,r6,#2
add r2,r1
ldr r2,[r2]
add r2,r5
ldrb r1,[r2]
mov r0,r4
blh CanUnitCrossTerrain
cmp r0,#0
beq SkipMovingUnit


@check if a unit exists at the target location
ldr r2,=#0x202E4D8 @unit map
ldr r2,[r2]
lsl r1,r6,#2
add r2,r1
ldr r2,[r2]
add r2,r5
ldrb r1,[r2]
cmp r1,#0
bne SkipMovingUnit

@make the camera follow your movement
mov r0,#0
mov r1,r5
mov r2,r6
blh EnsureCameraOntoPosition

@run MiscBasedEvents
mov r0,r5
mov r1,r6
bl RunMiscBasedEvents

sub sp,#0x1C
mov r0,#0
str r0,[sp]
str r0,[sp,#0x4]
str r0,[sp,#0x8]
str r0,[sp,#0xC]
str r0,[sp,#0x10]
str r0,[sp,#0x14]
str r0,[sp,#0x18]
str r0,[sp,#0x1C]
mov r0,r4
mov r1,r5
mov r2,r6
mov r3,#0 @redundant some of the time but not always
blh MuCtr_CreateWithReda
add sp,#0x1C

@now proc_goto(8)
@mov r0,r7
@mov r1,#8
@blh GotoProcLabel


@do fancy graphical thing here for moving map sprites


SkipMovingUnit:





@make the camera follow your movement
mov r0,#0
mov r1,r5
mov r2,r6
blh EnsureCameraOntoPosition

b DoEventsAndStuff

@make suspend save

DoEventsAndStuff:



@pause for some number of frames defined in proc sleeps via goto
mov r0,r7


CheckAPress:

@check if A is pressed
ldr r0,=gpKeyState
ldr r0,[r0]
ldrh r0,[r0,#0x4]
mov r1,#0x1
and r0,r1
cmp r0,#0
beq NoAPress

@check for various map objects at current location
cmp r5,#0xFF
ble CallDoMapEvents
ldr r4,=#0x3004E50
ldr r4,[r4]
ldrb r0,[r4,#0x10]
ldrb r1,[r4,#0x11]
b DoMapEventsCall

.ltorg
.align

CallDoMapEvents:
mov r0,r5
mov r1,r6
mov r2,r7
DoMapEventsCall:
bl FreeMove_RunMapEvents

@check for talk events with unit at coords
ldr r2,=#0x202E4D8 @unit map
ldr r2,[r2]
lsl r1,r6,#2
add r2,r1
ldr r2,[r2]
add r2,r5
ldrb r0,[r2]
cmp r0,#0
beq NoAPress
blh GetUnit
@r0 = unit we're checking
mov r1,r7 @r1 = parent proc
bl FreeMove_RunTalkEvents

NoAPress:

@check if L button is pressed
ldr r0,=gpKeyState
ldr r0,[r0]
ldrh r0,[r0,#0x4]
mov r1,#0x2
lsl r1,r1,#8
and r0,r1
cmp r0,#0
beq NoLPress @if 0, key is not pressed

@open a menu
ldr r0,=FreeMovementLMenu
blh StartMenuAdjusted

NoLPress:

HandleUnitMovement_GoBack:
pop {r4-r7}
pop {r0}
bx r0

.ltorg
.align



.global FreeMovementMenuOnBPress
.type FreeMovementMenuOnBPress, %function

FreeMovementMenuOnBPress:
push {r4,r14}
@call the normal one
blh #0x804F455
mov r4,r0
@now clear graphics
blh #0x80311A9
mov r0,r4
pop {r4}
pop {r1}
bx r1

.ltorg
.align


.equ gChapterData,0x0202bcf0
.equ GetChapterEventDataPointer,0x080346b1
.equ CheckEventDefinition,0x08082ec5
.equ ClearActiveEventRegistry,0x080845a5
.equ CallEventDefinition,0x08082e81
.equ CheckNextEventDefinition,0x08082f29
.equ RunLocationEvents,0x080840C5

RunMiscBasedEvents:
push {r4-r5,r14}
sub sp,#0x1C
mov r4,r0
mov r5,r1
ldr r0,=gChapterData
ldrb r0,[r0,#0xE]
blh GetChapterEventDataPointer
ldr r0,[r0,#0xC]
str r0,[sp]
mov r1,sp
strb r4,[r1,#0x18]
strb r5,[r1,#0x19]
mov r0,r13
blh CheckEventDefinition
cmp r0,#0
beq ExitMiscBasedLoop
blh ClearActiveEventRegistry
EventCallLoop:
mov r0,r13
mov r1,#1
blh CallEventDefinition
mov r0,r13
blh CheckNextEventDefinition
cmp r0,#0
bne EventCallLoop

ExitMiscBasedLoop:
add sp,#0x1C

pop {r4-r5}
pop {r0}
bx r0

.ltorg
.align











.global FreeMove_RunMapEvents
.type FreeMove_RunMapEvents, %function


.equ CanUseLockpicks,0x8028EF9
.equ GetUnitItemSlot,0x8018AE5
.equ GetLocationEventCommandAt,0x8084079
.equ ActionStaffDoorChestUseItem,0x0802fc49
.equ ChestEvent,0x8591FA8


FreeMove_RunMapEvents:
push {r4-r7,r14}

mov r5,r0 @x coord
mov r6,r1 @y coord
mov r7,r2 @parent proc
ldr r4,=#0x3004E50
ldr r4,[r4]

@check for map events at current position
mov r0,r5
mov r1,r6
blh GetLocationEventCommandAt @returns identifier for thing, chest is 0x14

cmp r0,#0x14 
beq OpenChest
cmp r0,#0x12
beq OpenDoor
cmp r0,#0x10
beq DoVisit
cmp r0,#0x11
beq DoEndChapter
b MapEv_GoBack

.ltorg
.align

OpenChest:
@there is a chest at our current position, so let's open it
mov r0,r5
mov r1,r6
blh RunLocationEvents

b MapEv_GoBack

.ltorg
.align

OpenDoor:
mov r0,r5
mov r1,r6
blh RunLocationEvents

b MapEv_GoBack

.ltorg
.align

DoVisit:
mov r0,r5
mov r1,r6
blh RunLocationEvents

b MapEv_GoBack

.ltorg
.align

DoEndChapter:
mov r0,r5
mov r1,r6
blh RunLocationEvents

b MapEv_GoBack

.ltorg
.align

MapEv_GoBack:
pop {r4-r7}
pop {r0}
bx r0

.ltorg
.align




.equ CallMapEventEngine,0x800D07D
.equ StartMapEventEngine,0x0800d0b1

.global FreeMove_RunTalkEvents
.type FreeMove_RunTalkEvents, %function

FreeMove_RunTalkEvents:
push {r4-r7,r14}
mov r4,r0 @r4 = unit we're checking for
mov r5,r1 @r5 = parent proc

@get chapter events
ldr r0,=gChapterData
ldrb r0,[r0,#0xE]
blh GetChapterEventDataPointer

@get talk events
ldr r0,[r0,#4]

@get char ID of unit passed into function
ldr r1,[r4]
ldrb r1,[r1,#4]

@compare to the value at talk event +0x9; if that value is 0, end

Talk_LoopStart:
ldrb r2,[r0,#9]
cmp r2,#0
beq Talk_GoBack
cmp r2,r1
beq Talk_LoopEnd

Talk_LoopRestart:
add r0,#16
b Talk_LoopStart

.ltorg
.align

Talk_LoopEnd:
@r0 = the entry we're using
@event at +0x4
ldr r0,[r0,#4]
@run this event
mov r1,#1
blh CallMapEventEngine

Talk_GoBack:

pop {r4-r7}
pop {r0}
bx r0

.ltorg
.align



.equ TryPrepareEventUnitMovement,0x800FC90
@ r0 = parent proc (expects this to be the event engine I think)
@ can manipulate by storing 0x80 << 2 at +0x3C
@ r1 = x coord of target location
@ r2 = y coord of target location



.global FreeMovement_CorrectCameraPosition
.type FreeMovement_CorrectCameraPosition, %function

.global FreeMovement_InitActiveUnit
.type FreeMovement_InitActiveUnit, %function


FreeMovement_CorrectCameraPosition:
push {r14}
@set camera on active unit
mov r0,#0
ldr r2,=#0x3004E50
ldr r2,[r2]
ldrb r1,[r2,#0x10]
ldrb r2,[r2,#0x11]
blh EnsureCameraOntoPosition

pop {r0}
bx r0

.ltorg
.align


FreeMovement_InitActiveUnit:

ldr r1,=#0x203F2B4 @used to determine who the actively controlled unit is, written to active unit each frame during main loop
ldr r0,[r1]
cmp r0,#0
beq InitActiveUnit_AlsoInitControlledUnit
b InitActiveUnit_Cont

InitActiveUnit_AlsoInitControlledUnit:
ldr r0,=#0x202BE4C
str r0,[r1]

InitActiveUnit_Cont:
ldr r1,=#0x3004E50
str r0,[r1]
bx r14

.ltorg
.align

