.align 4
.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm


.ltorg
.global CallWaitUntilAIMovesProc
.type CallWaitUntilAIMovesProc, %function
CallWaitUntilAIMovesProc: 
push { lr }
mov r1, #3
ldr r0, =WaitUntilAIMovesProc
blh pr6C_New, r2
pop { r0 }
bx r0

.align 
.ltorg
.global WaitUntilAIMoves
.type WaitUntilAIMoves, %function
WaitUntilAIMoves:
push {r4-r5, lr} 
mov r4, r0 @ Parent? 
ldr r0, =0x85a8024 @gProc_CpPerform
blh ProcFind, r1 
cmp r0, #0 
beq ProcStateError 
ldr r1, [r0, #4] @ Code Cursor 
@ldr r2, =0x85A804C @ Moving unit 
@cmp r1, r2 
@bne SkipThis
@mov r3, #40 
@add r5, r0, r3 @ Idk 
@
@SkipThis:
ldr r2, =0x85A8064 @ wait 0x85a8024 + 0x40 @gProc_CpPerform
cmp r1, r2 
beq ReturnProcStateRight 

ProcStateError:
mov r0, #0 


b EndIfProcStateWrongThenYield

ReturnProcStateRight: 


mov r0, r4 @  @ parent to break from 
blh BreakProcLoop
mov r0, #1

EndIfProcStateWrongThenYield:
pop {r4-r5}
pop {r1}
bx r1 





.align 
.ltorg



.global QueueAIForUnitInMemSlot1
.type QueueAIForUnitInMemSlot1, %function 
QueueAIForUnitInMemSlot1: 
push {r4-r7, lr}

ldr r3, =MemorySlot 
ldr r6, [r3, #4] @ Slot 1 


mov r4, #0 
ldr r5, =0x203AA04 @ gAiData.aiUnits 


FindEndOfAIQueueLoop:
ldrb r0, [r5, r4] 
cmp r0, #0 
beq WeFoundEndOfAI 
add r4, #1 
cmp r4, #0x73 // #0x73 bytes of queued ai  
bgt Error 
b FindEndOfAIQueueLoop

WeFoundEndOfAI:
ldrb r0, [r6, #0x0B] @ Deployment byte 
strb r0, [r5, r4] @ Queue the unit 

@ Put 0 immediately afterwards 
add r4, #1 
mov r0, #0 
strb r0, [r5, r4] 




	@// Finding last index in the ai unit queue
	@unsigned lastIndex = 0;
	@for (; gAiData.aiUnits[lastIndex]; ++lastIndex) {}

	@// Queuing our refreshed unit
	@@gAiData.aiUnits[lastIndex]     = gAiData.decision.unitTargetIndex;
	@gAiData.aiUnits[lastIndex + 1] = 0;


Error: 


pop {r4-r7}
pop {r2} 
bx r2 



.align 4 
@ Based on 803CDD4 
@ 803B808 FindSafestTileAI from 803CDE7
.global CopyAIScript11_Move_Towards_Safety
.type CopyAIScript11_Move_Towards_Safety, %function 
CopyAIScript11_Move_Towards_Safety: 
push {r4-r6, lr}
sub sp, #0x10 @ allocate space 
mov r5, r0 @ this would normally be unit struct+ 0x45 (ai2 counter) (but we don't use this anyway) 
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
pop {r4-r6}
pop {r2} 
bx r2 

.align 
.ltorg
.align 4
.global RunAwayAndSummonFunc
.type RunAwayAndSummonFunc, %function 
RunAwayAndSummonFunc:
push {r4-r6, lr} 
mov r6, r0 @ Parent? (not using) 
mov r6, #1 @ Yes, try to summon  
@ Check for AI4 of 0x20 
@ if we have, wait at coords 
@ if we can summon, do so 
@ otherwise, we just wait 


mov r5, #0 @ Don't take offensive action 

ldr r3, =CurrentUnit
ldr r3, [r3] 
mov r2, #0x41 @ AI4 
mov r1, #0x20 @ BossAI
ldrb r2, [r3, r2] 
and r1, r2 
cmp r1, #0 
beq ContinueRunAwayModularSummon
ldr r3, =CurrentUnit
ldr r3, [r3] 
ldrb r0, [r3, #0x10] 
ldrb r1, [r3, #0x11] 
mov r2, #5 @ Wait 
bl SetAIToWaitAtCoords 

bl ModularSummonUsability 
cmp r0, #1 
bne GotoDontSummonAnything

b CallEnqueueModularSummon 


ContinueRunAwayModularSummon:
bl CopyAIScript11_Move_Towards_Safety @ based on current unit, should return r0 XX r1 YY coords 
mov r2, #5 @ Wait 
bl SetAIToWaitAtCoords

bl ModularSummonUsability 
cmp r0, #1 
bne GotoDontSummonAnything

b CallEnqueueModularSummon 

GotoDontSummonAnything:
b DontSummonAnything



	.equ CheckEventId,0x8083da8
	.equ MemorySlot, 0x30004B8
	.equ CurrentUnit, 0x3004E50
	.equ CurrentUnitFateData, 0x203A958 
	.equ EventEngine, 0x800D07C
	.equ LoadUnit, 0x8017ac4 
	.equ ClearUnit, 0x080177f4 
	.equ GetUnit, 0x8019430 
	.equ GetUnitByEventParameter, 0x0800BC50
	.equ GetUnitDropLocation, 0x80184E0
	.equ pr6C_NewBlocking,           0x08002CE0 
	.equ pr6C_New,                   0x08002C7C
	.equ Proc_CreateBlockingChild, 0x80031c5 
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
	.equ gMapMovement, 0x202E4E0 
	.equ FillRangeMapForDangerZone, 0x0801B810
	.equ BmMapFill, 0x080197E4

.align 
.ltorg

.align 4
.global SummonOrAttackInRangeFunc
.type SummonOrAttackInRangeFunc, %function 
SummonOrAttackInRangeFunc:
push {r4-r6, lr} 
mov r6, r0 @ Parent 
mov r5, #0 @ No, we don't move unless there's a target in range 
@ if nobody in range, do nothing 

bl AnyTargetWithinRange
cmp r0, #1
b JudgeInRangeBranch


@ I first tried letting the ai make its normal AttackInRange decision
@ and then see if it found someone to attack 
@ but this wasted about 800k-24,000k cycles or 4-85 frames (depending on your prebattle calc loop and the units fielded, etc.) 
@ my version takes about 100k cycles or <1 frame 

@ldr r4, =0x203AA94 @ AiDecision 
@ldrb r0, [r4] @ decisionType 
@ldrb r1, [r4, #6] @ unitTargetIndex 
@ldrb r2, [r4, #0xA] @ decisionTaken 
@ldrb r3, [r4, #0xB] @ decisionType 
@
@bl Call_AiScriptCmd_05_DoStandardAction
@@ takes 1 - 4 million cycles or about 3.8 frames 
@
@ldrb r0, [r4] @ decisionType @ 1 = attack 
@@ldrb r0, [r4, #6] @ unitTargetIndex 
@@ldrb r0, [r4, #0xA] @ decisionTaken 
@cmp r0, #1 
@b JudgeInRangeBranch
.ltorg 
.align 

.global AnyTargetWithinRange 
.type AnyTargetWithinRange, %function 

@ 0803d450 AiTryDoOffensiveAction
AnyTargetWithinRange:
@push {lr} 
@ldr r0, =0x803C865 @ IsUnitEnemyAndNotInTheAiInstList IsUnitEnemyAndNotInTheAiInstList
@blh 0x803d450 @AiTryDoOffensiveAction
@mov r11, r11 
@@ this doesn't work because AiTryDoOffensiveAction sets the ai action 
@pop {r1} 
@bx r1 
push {r4-r7, lr} 
mov r7, r8 
push {r7}  
mov r6, r9 
push {r6} 

mov r5, #0 @ We default to False 
ldr r6, =CurrentUnit 
ldr r6, [r6] 
mov r0, #0 
mov r8, r0 @ Searching players, NPCs, or enemies 

@ tried to optimize a little for speed 

@ Enemy will do PlayerRam - Start of EnemyRam 
@ NPC will do EnemyRam-End of EnemyRam 

NextAllegiance: 
mov r1, r8 
add r1, #1 
mov r8, r1 

cmp r1, #1 
beq SetupPlayerRamAddresses
cmp r1, #2 
beq SetupNPCRamAddresses
cmp r1, #3 
beq SetupEnemyRamAddresses
b BreakAnyoneWithinRangeLoop 

SetupPlayerRamAddresses:
mov r4, #0x0 
mov r0, #0x3F
mov r9, r0 
b AnyoneWithinRangeLoop

SetupNPCRamAddresses:
mov r4, #0x40 
mov r0, #0x7F
mov r9, r0 
b AnyoneWithinRangeLoop

SetupEnemyRamAddresses:
mov r4, #0x80 
mov r0, #0xBF
mov r9, r0 
b AnyoneWithinRangeLoop

AnyoneWithinRangeLoop:
add r4, #1 @ Unit we're checking 
cmp r4, r9 
bgt NextAllegiance
mov r0, r4 
blh GetUnit 
ldr r1, [r0] 
cmp r1, #0 
beq AnyoneWithinRangeLoop
ldrb r1, [r1, #4] @ unit ID 
cmp r1, #0xE0 
blt NotTrainer
cmp r1, #0xFE 
bge NotTrainer 
b AnyoneWithinRangeLoop
NotTrainer:
ldr r1, [r0, #0x0C] 
ldr r2, =0x1000C @ escaped, dead, undeployed 
and r1, r2 
cmp r1, #0 
bne AnyoneWithinRangeLoop


@ same as AreUnitsAllied at 24D8C 
ldrb r3, [r6, #0x0B] @ CurrentUnit Allegiance 
mov r2, #0x80 
ldrb r1, [r0, #0x0B] @ Target Allegiance 
and r1, r2 
and r2, r3  
cmp r2, r1 
beq NextAllegiance
mov r7, #0x1C @ Weapon index -2
ContinueAnyoneWithinRangeLoop:
add r7, #2 
cmp r7, #0x26 
bgt AnyoneWithinRangeLoop 
mov r1, r0 @ Target 
mov r0, r6 
ldrh r2, [r6, r7]
cmp r2, #0 @ 
beq AnyoneWithinRangeLoop @ No weapon, so move on to next unit 
@ r0 actor, r1 target, r2 weapon 
push {r1-r2} @ target, wep
blh 0x803AC3C @ CouldStationaryUnitBeInRangeHeuristic
pop {r1-r2} 

cmp r0, #1 
bne ContinueAnyoneWithinRangeLoop @ try next weapon 
push {r1}
@mov r0, r1 @ target doesn't make sense lol 
mov r0, r6 @ actor 
mov r1, r2 @ wep 
blh 0x803B558 @ FillMovementAndRangeMapForItem
pop {r1} 



ldrb r0, [r1, #0x10] @ X 
ldrb r1, [r1, #0x11] @ Y 


ldr r2, =0x202E4E4	@Range map
ldr		r2,[r2]			@Offset of map's table of row pointers
lsl		r1,#0x2			@multiply y coordinate by 4
add		r2,r1			@so that we can get the correct row pointer
ldr		r2,[r2]			@Now we're at the beginning of the row data
add		r2,r0			@add x coordinate
ldrb	r0,[r2]			@load datum at those coordinates
cmp r0, #0 
beq AnyoneWithinRangeLoop 


mov r5, #1 @ True 

BreakAnyoneWithinRangeLoop:
mov r0, r5 

pop {r6}
mov r9, r6 
pop {r7} 
mov r8, r7 
pop {r4-r7}
pop {r1}
bx r1 

.ltorg 
.align 



@ 803D880 AiFillUnitStandingRangeWithWeapon
@ target?, short wep 

.type IsActiveUnitInDanger, %function 
IsActiveUnitInDanger:
push {lr} 

@ If you want the AI to act differently when players/npcs can target you, use this. 
@ It is turn dependent, so on player phase it will get enemy range and vice versa 

@ 202E4E4 range map 
@ 202E4F0 @ ai danger map - 0203AA04 + 7A | byte | 1 if the second movement map is readable as the "danger" map (0 if not)
@ dunno what toggles that  but we aren't using it here so whatever 

@ldr r3, =0x203AA75 @ldr r2, =0x202E4F0 @ enemy danger map? 
@ldrb r0, [r3] 


mov r0, #0 @ arg r0 = staff range?
blh FillRangeMapForDangerZone 

ldr r0, =gMapMovement
ldr r0, [r0]
mov r1, #1
neg r1, r1            @ arg r1 = -1
blh BmMapFill @ Make movement impossible..? 

ldr r3, =CurrentUnit 
ldr r3, [r3] 
ldrb r0, [r3, #0x10] 
ldrb r1, [r3, #0x11] 

ldr r2, =0x202E4E4 @ Range map 
ldr		r2,[r2]			@Offset of map's table of row pointers
lsl		r1,#0x2			@multiply y coordinate by 4
add		r2,r1			@so that we can get the correct row pointer
ldr		r2,[r2]			@Now we're at the beginning of the row data
add		r2,r0			@add x coordinate
ldrb	r0,[r2]			@load datum at those coordinates

cmp r0, #0 
bne ActiveUnitIsInDanger 
mov r0, #0 
b EndIsActiveUnitInDanger

ActiveUnitIsInDanger:
mov r0, #1 
EndIsActiveUnitInDanger:

pop {r1} 
bx r1 


JudgeInRangeBranch:

beq ApproachEnemyModularSummonStart  
mov r6, #0 @ Do not try to summon if nothing in range 

ldr r3, =CurrentUnit
ldr r3, [r3] 
ldrb r0, [r3, #0x10] 
ldrb r1, [r3, #0x11] 
mov r2, #0 @ Noop 
bl SetAIToWaitAtCoords
b ReturnTrue 

b ApproachEnemyModularSummonStart  

.align 
.ltorg

.align 4
.global PursueAndSummonOrAttackFunc
.type PursueAndSummonOrAttackFunc, %function 
PursueAndSummonOrAttackFunc:
push {r4-r6, lr} 
mov r5, #1 @ Yes, we move 
ApproachEnemyModularSummonStart:
@ Check for AI4 of 0x20 
@ if we have, wait at coords 
@ if we don't have, blh to AIScript12_Move_Towards_Enemy 
@ either way, if we can only summon < half of total, go to offensive action 
@ if not, enqueue modular summon 

ldr r3, =CurrentUnit
ldr r3, [r3] 
mov r2, #0x41 @ AI4 
mov r1, #0x20 @ BossAI
ldrb r2, [r3, r2] 
and r1, r2 
cmp r1, #0 
beq ContinueApproachEnemyModularSummon 
mov r5, #0 @ no, don't move 
ContinueApproachEnemyModularSummon:
cmp r5, #0 
beq ApproachEnemyScript_DontMove



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
mov r2, #5 @ Wait 
bl SetAIToWaitAtCoords 
b DetermineSummonOrAttack


ApproachEnemyScript_DontMove:
ldr r3, =CurrentUnit
ldr r3, [r3] 
ldrb r0, [r3, #0x10] 
ldrb r1, [r3, #0x11] 
mov r2, #5 @ Wait 
bl SetAIToWaitAtCoords

DetermineSummonOrAttack:
bl AnyTargetWithinRange 
mov r6, r0 @ T/F 

bl ModularSummonUsability 
cmp r0, #1 
bne OffensiveActionBranch @ Can't summon, so try offensive action instead 
cmp r6, #1 
bne CallEnqueueModularSummon @ No target in range, but we can summon, so do so  
@ Target is in range AND we can summon below here 
cmp r1, #1 @ 
bne OffensiveActionBranch @ We could summon only < half of the unit group, so try offensive action instead 
b CallEnqueueModularSummon


CallEnqueueModularSummon: 
bl EnqueueModularSummon
DontSummonAnything:
mov r0, #1 
pop {r4-r6}
pop {r1}
bx r1 



OffensiveActionBranch: 
cmp r6, #0 
beq ReturnTrue 
bl Call_AiScriptCmd_05_DoStandardAction
b ReturnTrue 

.ltorg 
.align 
.type Call_AiScriptCmd_05_DoStandardAction, %function 
.global Call_AiScriptCmd_05_DoStandardAction

Call_AiScriptCmd_05_DoStandardAction:
push {lr}

@bl AnyTargetWithinRange
@cmp r0, #1 @ 
@bne DontTryStandardAction

@ Clear out the earlier decision to wait or whatever 
mov r0, #0 
ldr r3, =0x203AA94 @ AiDecision 
strb r0, [r3] @ decisionType 
strb r0, [r3, #6] @ unitTargetIndex 
strb r0, [r3, #0xA] @ decisionTaken 
strb r0, [r3, #0xB] @ decisionType 


ldr r3, =CurrentUnit 
ldr r0, [r3] 
add r0, #0x43 @ this is ActiveUnit ram address + 0x43 (AI1 count) 

ldr r3, =0x30017d0 @ 030017d0 gpAiScriptCurrent 
@ can't directly load into r2 in case they repointed aiscript1
@ldr r2, =0x85A8870 @ vanilla ai attack in range gAiScript_ActionInRange
ldr r2, =0x85a91e4 @ POIN gAiScript1 
ldr r2, [r2] @ POIN AiScript1FirstEntry 
ldr r2, [r2] @ 

str r2, [r3] @ we store 0x85A8870 here (unless they repointed) 
@ 30017d0 storing ActionInRange 


@blh 0x803c974
@blh 0x803cae4
blh 0x803ca0c @AiScriptCmd_05_DoStandardAction
DontTryStandardAction:

pop {r0}
bx r0 


.global SetAIToWaitAtCoords
.type SetAIToWaitAtCoords, %function 
SetAIToWaitAtCoords:
@ given r0 = XX and r1 = YY, and r2 = ActionType, wait at coords. 
push {r4, lr}
mov r4, r2 @ Action type 
sub sp, #0xC 
@ r0 = XX 
@ r1 = YY 

@ some of this is probably unnecessary 
@ it could be trimmed down 

@ sanity check that we aren't going to try and move to [0,0] if something is empty 
ldr r2, =0x203AA96 @ AI decision +0x92 (XX) 
ldrh r2, [r2, #0x0] @ XX,YY
ldr r3, =CurrentUnit 
ldr r3, [r3] 
cmp r2, #0 
bne ContinueSetAIToWaitAtCoords
mov r1, #0x10 
ldrh r0, [r3, r1] @ Current unit coords  
ldr r2, =0x203AA96 @ AI decision +0x92 (XX) 
strh r0, [r2, #0] @ 
ldr r2, =0x203A958 @ Action struct 
mov r1, #0x13
strh r0, [r2, r1] @ Action Struct @ 203A958

ldrb r0, [r3, #0x10] @ No decision made by move towards enemy 
ldrb r1, [r3, #0x11] @ so put in our current coords 
ContinueSetAIToWaitAtCoords:

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
@ is #5 is staffwait? @ 803a204 CpPerform_StaffWait
mov r2, r4 @ Usually #0x05 (Wait), but is given as parameter in r2 to this function now 
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
pop {r4} 
pop {r1}
bx r1 



@ Tried invoking the EventEngine and it didn't work
@ so it's running this 3x then running the event 3x 
@ when it runs the event 3x, the current unit is the same for all 3 hmm 
@ldrb r0, [r3, #0x10] @ X 
@ldrb r1, [r3, #0x11] @ Y 
@bl RunMiscBasedEvents - this was from Sme's FreeMovement hack. 
@ Since it didn't work correctly in this context, it is no longer included below 
.global EnqueueModularSummon 
.type EnqueueModularSummon, %function 

EnqueueModularSummon: 
push {r4-r6, lr} 

ldr r3, =0x203AA96 @ AI decision +0x92 (XX) 
ldrb r0, [r3, #0x0] @ XX 
ldrb r1, [r3, #0x1] @ YY 
ldr r3, =MemorySlot
add r3, #4*0x0B @ Slot B 
strh r0, [r3, #0] 
strh r1, [r3, #2] 

bl ModularSummonUsability 

cmp r0, #1 
bne ExitModularSummonAI 


bl CallWaitUntilAIMovesProc
b ReturnTrue 

@ If this is false, it might try to do other stuff like attack I guess 
@ I really don't know how it works 
@ Decide if we should try other ai options 
@DontSummonAnything:
@ I've decided to instead have it blh to the regular attack script, rather than return false here and 
@ let the AI do unknown stuff 
@ So we always return true that we made an ai decision. 
b ReturnTrue 

ReturnFalse: 
mov r0, #0 @ False 
b ExitModularSummonAI 

ReturnTrue: 
mov r0, #1 @ True that we made an AI decision 

ExitModularSummonAI:
pop {r4-r6}
pop {r1} 
bx r1 















