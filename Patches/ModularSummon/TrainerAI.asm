.align 4
.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

	.equ MemorySlot, 0x30004B8
	.equ AIScript12_Move_Towards_Enemy, 0x803ce18 
	.equ AiSetDecision, 0x8039C21 
	.equ CurrentUnit, 0x3004E50
	.equ EventEngine, 0x800D07C
.equ RemoveUnitBlankItems,0x8017984
.global TrainerFleeSummonTeamAIFunc
.type TrainerFleeSummonTeamAIFunc, %function 
TrainerFleeSummonTeamAIFunc: 
push {r4-r6, lr} 
mov r4, #1 @ Yes we move 
mov r5, #0 @ Flee 

b TrainerSummonTeamStart

.global TrainerSummonTeamAIFunc
.type TrainerSummonTeamAIFunc, %function 

TrainerSummonTeamAIFunc:
push {r4-r6, lr} 
mov r4, #1 @ Yes we move 
mov r5, #1 @ Trainer to move towards opponents 

b TrainerSummonTeamStart 

.global StationaryTrainerSummonTeamAIFunc
.type StationaryTrainerSummonTeamAIFunc, %function 

StationaryTrainerSummonTeamAIFunc:
push {r4-r6, lr} 
mov r4, #0 @ Do not move 
mov r5, #1 @ Trainer to move towards opponents 
b TrainerSummonTeamStart


TrainerSummonTeamStart:

bl AnyTargetWithinRange
cmp r0, #0 
beq DontSummonStuff 


blh ShouldTrainerSummonTeam 
cmp r0, #0 
beq DontSummonStuff



b SummonStuff 

@ Don't summon anything 
DontSummonStuff:
ldr r3, =CurrentUnit
ldr r3, [r3] 
@ use a list of which AI2 we'll actually try to execute 
@ otherwise, AI1 of trainer AI handles it all 

mov r2, #0x44 @ AI2 
ldrb r0, [r3, r2] 
ldr r2, =TrainerAIListToDoAI2
sub r2, #1
TrainerAIListLoop: 
add r2, #1
ldrb r1, [r2] 
cmp r0, r1 
beq GotoAI2
cmp r1, #0 
beq ExitTrainerAIListLoop 
b TrainerAIListLoop
GotoAI2:
ldr r1, =0x30017CC
mov r0, #1 
str r0, [r1] 
b ExitTrainerSummonAI
ExitTrainerAIListLoop:


ldrb r0, [r3, #0x10] 
ldrb r1, [r3, #0x11] 
mov r2, #0 @ Wait 
bl SetAIToWaitAtCoords 
b ReturnTrue 

SummonStuff: 
@ Clear weapon to get rid of attack range of trainer 
ldr r3, =CurrentUnit 
ldr r3, [r3] 


mov r0, #0
mov r1, r3 
add r1, #0x1E @ Weapon  
strh r0, [r1, #0]


ldr r2, [r3] 
ldrb r2, [r2, #4] 
cmp r2, #0xEE 
beq SkipThis 
cmp r2, #0xED 
beq SkipThis 
cmp r2, #0xE0 
blt SkipThis 
cmp r2, #0xF0 
bge SkipThis 

strh r0, [r1, #2]
strh r0, [r1, #4]
strh r0, [r1, #6]
strh r0, [r1, #8]
strh r0, [r1, #10] @ known moves 
strh r0, [r1, #12]
strb r0, [r1, #13]

SkipThis: 

mov r0, r3 
blh RemoveUnitBlankItems

ldr r3, =CurrentUnit 
ldr r3, [r3] 

cmp r4, #1
beq TryMoving 
@ Do not move 
ldrb r0, [r3, #0x10] 
ldrb r1, [r3, #0x11] 
b SetMovementDecision

TryMoving: 
cmp r5, #1 
beq MoveTowardsEnemyNow 

cmp r5, #0 
beq MoveAwayFromEnemiesNow
MoveAwayFromEnemiesNow: 
@ Do this to make them run away instead 
bl CopyAIScript11_Move_Towards_Safety @ based on current unit, should return r0 XX r1 YY coords 
ldr r3, =0x203AA96 @ AI decision +0x92 (XX) 
strb r0, [r3, #0x0] @ XX 
strb r1, [r3, #0x1] @ YY 


b SetMovementDecision 


MoveTowardsEnemyNow:
push {r3}
ldr r0, =TrainerMovementDebuffFlag
lsl r0, #16 
lsr r0, #16 
blh SetEventId
pop {r0} 

add r0, #0x45 

blh AIScript12_Move_Towards_Enemy @0x803ce18 

ldr r0, =TrainerMovementDebuffFlag
lsl r0, #16 
lsr r0, #16 
blh UnsetEventId


ldr r3, =0x203AA96 @ AI decision +0x92 (XX) 
ldrb r0, [r3, #0x0] @ XX 
ldrb r1, [r3, #0x1] @ YY 




SetMovementDecision:
mov r2, #5 @ Wait 
bl SetAIToWaitAtCoords 

SetupWaitUntilAIMovesProc:
ldr r3, =0x203AA96 @ AI decision +0x92 (XX) 
ldrb r0, [r3, #0x0] @ XX 
ldrb r1, [r3, #0x1] @ YY 
ldr r3, =MemorySlot
add r3, #4*0x0B @ Slot B 
strh r0, [r3, #0] 
strh r1, [r3, #2] 
bl CallWaitUntilAIMovesProc


ReturnTrue: 
mov r0, #1 @ True that we made an AI decision 

ExitTrainerSummonAI:
pop {r4-r6}
pop {r1} 
bx r1 

.ltorg 
.equ SetEventId, 0x8083D80
.equ UnsetEventId, 0x8083D94
@.equ CheckEventId, 0x8083DA8
	
.global DebuffIfRematch
.type DebuffIfRematch, %function 
DebuffIfRematch:
push {r4-r5, lr}
mov r4, r0 @ movement 
mov r5, r1 @ unit 

ldr r1, [r5] 
ldrb r1, [r1, #4] @ Unit ID we're interested in 
cmp r1, #0xE0 
blt NoDebuffRematch 
cmp r1, #0xF0 
bge NoDebuffRematch 
mov r0, r5 
bl CheckTrainerFlag @ given unit struct r0, check if their flag is set or not 
cmp r0, #0 
beq NoDebuffRematch 
@lsr r4, #1 @ half move for rematches 
mov r4, #1 @ 1 mov 
NoDebuffRematch: 
mov r0, r4 
pop {r4-r5} 
pop {r1} 
bx r1 
.ltorg 

.global UseRepelEffect 
.type UseRepelEffect, %function 
UseRepelEffect: 
ldr r3, =MemorySlot 
ldr r1, [r3, #4*1] @ s1 as number of steps to add 
mov r0, #0xFF 
lsl r0, #8 @ 0xFF00 
ldr r3, =RepelStepsRam_Link 
ldr r3, [r3] 
ldrh r2, [r3] 
add r2, r1 @ add to the steps 
cmp r2, r0 @ no more than 0xFF00 
blt NoCap 
mov r2, r0 @ max 
NoCap: 
strh r2, [r3] 
ldr r3, =MemorySlot 
str r2, [r3, #4*0x0C] 
bx lr 
.ltorg 

.global DebuffIfRepel
.type DebuffIfRepel, %function 
DebuffIfRepel: 
push {r4-r5, lr}
mov r4, r0 @ movement 
mov r5, r1 @ unit 
ldr r1, [r5] 
ldrb r1, [r1, #4] 
cmp r1, #0x50 
blt NoDebuffRepel 
cmp r1, #0xA0 
bge NoDebuffRepel 
ldr r3, =RepelStepsRam_Link 
ldr r3, [r3] 
ldrh r3, [r3] 
cmp r3, #0 
beq NoDebuffRepel 
lsr r4, #1 @ half movement if repelled 
cmp r4, #3 
blt NoDebuffRepel
mov r4, #2 @ up to 2 mvt while repelled 

NoDebuffRepel: 
mov r0, r4 
pop {r4-r5} 
pop {r1} 
bx r1 
.ltorg 

.global DepleteRepelByStep
.type DepleteRepelByStep, %function 
DepleteRepelByStep: 
ldr r3, =RepelStepsRam_Link 
ldr r3, [r3] 
ldrh r1, [r3] @ steps left 
mov r0, #1 
sub r1, r0 
cmp r1, #0 
bge StoreRepelStepsLeft2 
mov r1, #0 
StoreRepelStepsLeft2: 
strh r1, [r3] 
bx lr 
.ltorg 

.global DepleteRepel
.type DepleteRepel, %function 
DepleteRepel: 
@push {lr} 
ldr r3, =CurrentUnit 
ldr r3, [r3] 
ldrb r0, [r3, #0x0B] @ actor deployment byte 
cmp r0, #0x40 
bge ExitDepleteRepel
ldr r3, =RepelStepsRam_Link 
ldr r3, [r3] 
ldrh r1, [r3] @ steps left 
ldr r2, =0x203A958 @gActionData 
ldrb r0, [r2, #0x10] @ steps taken 
lsr r0, #1 @ half of steps taken to be generous 
sub r1, r0 
cmp r1, #0 
bge StoreRepelStepsLeft 
mov r1, #0 
StoreRepelStepsLeft: 
strh r1, [r3] 
ExitDepleteRepel:
bx lr 
.ltorg 

.global TrainerMovementBane
.type TrainerMovementBane, %function 
TrainerMovementBane:
push {r4-r5, lr}
@ r0 = movement 
@ r1 = unit 

mov r4, r0 
mov r5, r1 
ldr r0, [r5] @ char 
ldrb r0, [r0, #4] @ unit ID 
ldr r1, =TrainerLowerRange
ldr r2, =TrainerUpperRange
lsl r1, #16 
lsr r1, #16 
lsl r2, #16 
lsr r2, #16 
cmp r0, r1 
blt Exit 
cmp r0, r2 
bgt Exit 
ldr r0, =TrainerMovementDebuffFlag 
lsl r0, #16 
lsr r0, #16 
blh CheckEventId
cmp r0, #1 
bne Exit 
add r4, #3 
lsr r4, #2 
add r4, #1 @ only move 1/4 range + 1 
@ eg. 3-4 tiles 

Exit:
mov r0, r4 

@ returns new movement 
pop {r4-r5}
pop {r1}
bx r1 
.ltorg 

.global EnemyMovementBane
.type EnemyMovementBane, %function 
EnemyMovementBane:
push {r4-r5, lr}
@ r0 = movement 
@ r1 = unit 

mov r4, r0 
mov r5, r1 
ldrb r0, [r5, #0x0B] 
lsr r0, #7 
cmp r0, #0 
beq Exit_EnemyMovementBane
ldr r0, [r5] @ unit pointer 
ldrb r0, [r0, #4] @ unit ID 
cmp r0, #0xD0 
bge Exit_EnemyMovementBane 

cmp r4, #0 
bgt Continue 
b Exit_EnemyMovementBane 
Continue: 
sub r4, #1 @ enemies get -1 movement 

Exit_EnemyMovementBane:
mov r0, r4 

@ returns new movement 
pop {r4-r5}
pop {r1}
bx r1 
.ltorg 


.global TrainerSpotsYouFunction
.type TrainerSpotsYouFunction, %function 

TrainerSpotsYouFunction:
push {r4-r7, lr}

ldr r3, =CurrentUnit
ldr r3, [r3] 
ldr r1, [r3] @ Char data 
ldrb r1, [r1, #4] @ Unit ID 
cmp r1, #0xE0 
blt ExitTrainerSpotsYou 
sub r1, #0xE0 @ we only have trainers from unit IDs 0xE0 - 0xEF 
lsl r1, #1 @ 2 bytes per text entry 


mov r2, #0x2D 
ldrb r0, [r3, r2] 
cmp r0, #50 
beq ExitTrainerSpotsYou 

mov r4, r1 

ldr r0, =CasualModeFlag 
lsl r0, #16  
lsr r0, #16
blh CheckEventId
cmp r0, #0
bne CasualModeOn
ldr r3, =0x202BCF0 @ gChapterData 
ldrb r0, [r3, #0xE] @ what chapter is it 
ldr r3, =TrainerQuotesNuzlockePoinTable
lsl r0, #2 @ 4 bytes per poin 
add r3, r0 
ldr r3, [r3] @ Specific chapter's table of quotes 
ldrh r0, [r3, r4] @ TextID we want 
cmp r0, #0 
bne GotTextID 
@ we failed to get a real text id, so take the one from casual mode 
CasualModeOn:
ldr r3, =0x202BCF0 @ gChapterData 
ldrb r0, [r3, #0xE] @ what chapter is it 
ldr r3, =TrainerQuotesPoinTable
lsl r0, #2 @ 4 bytes per poin 
add r3, r0 
ldr r3, [r3] @ Specific chapter's table of quotes 
ldrh r0, [r3, r4] @ TextID we want 
GotTextID:

ldr r3, =MemorySlot 
str r0, [r3, #4*0x02] @ Store to mem slot 2 

ldr r2, =CurrentUnit
ldr r2, [r2] 
ldrb r0, [r2, #0x10] @ X 
ldrb r1, [r2, #0x11] @ Y 

lsl r1, #16 
add r1, r0 
str r1, [r3, #4*0x0B] @ Coords 

ldr r0, =TrainerSpotsYouEvent 
mov r1, #1 
blh EventEngine 


ExitTrainerSpotsYou: 

pop {r4-r7}
pop {r1}
bx r1 

.global CallMU_DisplayAsSMS 
.type CallMU_DisplayAsSMS, %function 

CallMU_DisplayAsSMS:
push {lr} 


@ 80792f8 MU_DisplayAsSMS




pop {r0} 
bx r0 
	.equ CheckEventId,0x8083da8

.global MoveTowardsCommanderAIFunc
.type MoveTowardsCommanderAIFunc, %function 

MoveTowardsCommanderAIFunc:
push {lr} 

@bl MakeAIWait
ldr r3, =CurrentUnit 
ldr r3, [r3] 
mov r2, #0x38 @ Commander 
ldrb r0, [r3, r2] @ Commander 
cmp r0, #0 
beq DoNothingInstead 
blh GetUnitByEventParameter 
cmp r0, #0 
beq DoNothingInstead 
mov r3, r0 
ldrb r0, [r3, #0x10] @ XX coord of commander 
ldrb r1, [r3, #0x11] @ YY coord of commander 

bl MoveTowardsGivenCoord 
b ExitAiFunc 
DoNothingInstead: 

ExitAiFunc: 
mov r0, #1 

pop {r1}
bx r1 

@3CB88
@
@202D3F4 -
@202D439 - AI2 count in r0  
@
@ldr r2, =0x30017D4 @ gpCurrentAiFunctionCall 
@
@ldr r0, =0x30017D0 @ gpAiScriptCurrent 
@ldr r0, [r0] @ AI2 - my custom "MovePositionCoordinateXX" 
@ldr r1, [r0, #8] @ 803F9A9 - AI2 Move Towards Target CallASM 
@str r1, [r2] 
@
@ldr r0, [r0, #0xC] @ PositionTo Move to table eg. [,0] X, [,#1] Y, 
@					@ then 2 bytes of padding 
@
@@ then it BXs to 803F9A9 

@ 
.equ AiTryMoveTowards, 0x803ba08
.equ GetUnitByEventParameter, 0x0800BC51

MoveTowardsGivenCoord: 
push {r4, lr} 
@ Given r0 = XX 
@ r1 = yy 
@ moves towards that coordinate 

sub sp, #4 
mov r2, r0 @ XX 
@mov r1, r1 @ YY 

mov r0, #1 @ dunno 
str r0, [sp] 
mov r0, r2 @ XX 
mov r2, #0 @ Dunno 
mov r3, #0xFF @ Dunno - safety..? 
blh AiTryMoveTowards, r4 

mov r0, #1 @ True 
add sp, #4 
pop {r4}
pop {r1} 
bx r1 


