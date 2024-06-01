.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.equ BufferSize, 12 
.equ EnsureCameraOntoPosition, 0x08015e0c
.equ ProcFind, 0x8002E9C
.equ ProcGoto, 0x8002F24 
.equ gAttackerSkillBuffer, 0x02026BB0
.equ gDefenderSkillBuffer, 0x02026C00
.equ gTemSkillBuffer, 0x02026B90
.equ gAuraSkillBuffer, 0x02027200
.equ gUnitRangeBuffer, 0x0202764C
.equ GetUnit, 0x8019430
.equ ChapterData, 0x202BCF0 
.equ Delete6C, 0x8002D6C 
.equ AiData, 0x203AA04
.equ ProcStartBlocking, 0x8002CE0 
.equ ProcStart, 0x8002C7C
.equ ProcBreakLoop, 0x8002E94 
.equ GetPhaseAbleUnitCount, 0x8024CEC 
.equ gCameraProc, 0x859A548 
.equ ShouldMoveCamPos, 0x8015E9C 
.equ ConvoyPointer, 0x80315b4 

.equ DeployByte, 			0  @ 0x2c 
.equ FuncCoun, 				1  @ 0x2d 
.equ Destructor, 			2  @ 0x2e 
.equ TryPhaseBool, 			3  @ 0x2f 
.equ EndOfDeployByte, 		4  @ 0x30 
.equ SkillBufferCounter, 	5  @ 0x31 
.equ healAmount, 			6  @ 0x32 used by EndOfTurnCalcLoop 
.equ MidUnitLoopBool, 		7  @ 0x33 used by Buff Anim loop 
.equ SkillBuffer, 			8  @ 0x34 
.equ pUnit, 				12 @ 0x38 
.equ FirstFunc, 			16 @ 0x3c function that starts a blocking proc 

.global SethLowHp 
.type SethLowHp, %function 
SethLowHp:
push {lr} 
@ this function is for testing purposes and is not normally called 
mov r0, #3
blh GetUnit
mov r1, #5
strb r1, [r0, #0x13] @ seth hp 

mov r1, #21
strb r1, [r0, #9] @ exp 

ldr r3, =ConvoyPointer 
ldr r3, [r3] 
mov r1, #0x6C 
mov r2, #0x1 
lsl r2, #8 
orr r1, r2 @ vuln 
strh r1, [r3] 

pop {r0} 
bx r0 
.ltorg 

.global TurnLoopMaster
.type TurnLoopMaster, %function 
TurnLoopMaster:
@mov r11, r11 
push {r4-r7, lr} 
mov r4, r8 
mov r5, r9 
mov r6, r10 
mov r7, r11
push {r4-r7}  

mov r4, r0 @ proc to possibly block (MapMain) 



mov r5, #0 @ deployment byte starts at 0+1 
mov r8, r5 @ proc label starts at 0 
mov r11, r5 @ skill buffer starts at 0+1 
mov r6, #0 @ function counter 
sub r6, #2 @ add 1 in the start of the loop 
ldr r7, =gAttackerSkillBuffer
@ r5 = unit deployment byte 
@ r6 = function counter 
@ r7 = pUnit 
@ r8 = proc label 
@ r9 = # of units in this phase: possibly skip the phase's start of turn loop 
@ r10 = deployment byte to stop at for the current loop (eg. current phase 0, 0x40, 0x80 + 0x40) 
@ r11 = skill buffer counter 
@ if no units of that allegiance 


@ iterate through each function 
@ if the function returns a unit, then block MapMain 

@ 
@ each effect needs a usability function and an effect function 
@ the effect function loops through as part of a proc 

ldr r0, =ChapterData 
ldrb r0, [r0, #0xF] 
blh GetPhaseAbleUnitCount 
mov r9, r0 @ possibly skip this phase start of turn loop if no units of that allegiance 


ldr r0, =ChapterData 
ldrb r0, [r0, #0xF] 
cmp r0, #0 
beq EndOfNPC 
cmp r0, #0x40 
beq EndOfEnemy 
cmp r0, #0x80 
beq EndOfPlayer 

EndOfNPC: 
mov r0, #0x40 @ npc 
b CheckIfPhaseExists 
EndOfEnemy: 
mov r0, #0x80 @ enemy 
b CheckIfPhaseExists 
EndOfPlayer: 
mov r0, #0x0 @ player  
b CheckIfPhaseExists 


CheckIfPhaseExists: 
mov r5, r0 
cmp r5, #0 
bne DontAddOne 
add r5, #1 @ players start at 0x01, not 0x00 like NPCs/Enemies do 
DontAddOne: 
mov r1, r0 
add r1, #0x40 
mov r10, r1 @ deployment byte to stop at 
blh GetPhaseAbleUnitCount 
cmp r0, #0 
beq SkipEndOfTurn 


@ for each animation loop, loop through each unit 
@ create a buffer of skill IDs 
@ then call the indexed function for that skill 

NextEndOfTurnFunction: 
add r6, #2 
lsl r2, r6, #2 @ 4 bytes per 
ldr r3, =EndOfTurnCalcLoop 
add r3, r2 
ldr r0, [r3] 
cmp r0, #0 
beq SkipEndOfTurn 

EndOfTurnUnitLoop: @ no proc started 
mov r0, r5 @ deployment byte 
mov r3, r10 
cmp r5, r3 
bge NextEndOfTurnFunction 
add r5, #1 @ for next time 
blh GetUnit 
mov r7, r0 @ unit 
bl IsUnitOnField 
cmp r0, #0 
beq EndOfTurnUnitLoop

mov r2, #0 
mov r11, r2 @ reset buffer counter I guess 

mov r0, r7 @ unit 
ldr r1, =gAttackerSkillBuffer
bl MakeSkillBuffer 

EndOfTurn_SkillBufferLoop: 
mov r1, r11 @ buffer counter 
add r1, #1 
mov r11, r1 
ldr r3, =gAttackerSkillBuffer 
ldrb r1, [r3, r1] @ skill we have 
cmp r1, #0 
beq EndOfTurnUnitLoop

ldr r3, =EndOfTurnCalcLoop 
mov r2, r6 @ function we're on 
lsl r2, #2 @ 4 bytes per 
add r3, r2 
ldr r3, [r3] @ table of skills relevant to the current animation loop 
lsl r1, #3 @ 8 bytes per entry 
ldr r2, [r3, r1] @ usability 
cmp r2, #0 
beq EndOfTurn_SkillBufferLoop
mov r0, r7 @ unit 
mov lr, r2 
.short 0xF800  
cmp r0, #0 
beq EndOfTurn_SkillBufferLoop
ldr r3, =EndOfTurnCalcLoop 
mov r2, r6 @ function we're on 
lsl r2, #2 @ 4 bytes per 
add r3, r2 
ldr r3, [r3, #4] @ function that starts a child proc 

@ true, so we start the proc which will execute whatever's in r3 then continue the loop within its proc 
b StartBlockingProc 

SkipEndOfTurn: 

mov r0, r9 @ should we skip this phase? 
cmp r0, #0 
beq Master_DoNotBlock

mov r0, #1 @ if we start the proc, start at the silent functions 
mov r8, r0 

bl StartOfTurnCalcLoop_SilentFunctions


@ Start of Turn part 
mov r6, #0 
sub r6, #2
mov r0, #2 @ if we start the proc, start from the Start of Turn functions label 
mov r8, r0 
ldr r0, =ChapterData 
ldrb r0, [r0, #0xF] 
mov r5, r0 @ deployment byte to start at 
cmp r5, #0 
bne NoIssue
add r5, #1 
NoIssue: 
add r0, #0x40 
mov r10, r0 @ deployment byte to stop at 

@ start of turn calc loop goes here 


@ for each animation loop, loop through each unit 
@ create a buffer of skill IDs 
@ then call the indexed function for that skill 

NextStartOfTurnFunction: 
add r6, #2 
lsl r2, r6, #2 @ 4 bytes per 
ldr r3, =StartOfTurnCalcLoop 
add r3, r2 
ldr r0, [r3] 
cmp r0, #0 
beq SkipStartOfTurn 

StartOfTurnUnitLoop: @ no proc started 
mov r0, r5 @ deployment byte 
mov r3, r10 
cmp r5, r3 
bge NextStartOfTurnFunction 
add r5, #1 @ for next time 
blh GetUnit 
mov r7, r0 @ unit 
bl IsUnitOnField 
cmp r0, #0 
beq StartOfTurnUnitLoop

mov r2, #0 
mov r11, r2 @ reset buffer counter I guess 

mov r0, r7 @ unit 
ldr r1, =gAttackerSkillBuffer
bl MakeSkillBuffer 

StartOfTurn_SkillBufferLoop: 
mov r1, r11 @ buffer counter 
add r1, #1 
mov r11, r1 
ldr r3, =gAttackerSkillBuffer 
ldrb r1, [r3, r1] @ skill we have 
cmp r1, #0 
beq StartOfTurnUnitLoop

ldr r3, =StartOfTurnCalcLoop 
mov r2, r6 @ function we're on 
lsl r2, #2 @ 4 bytes per 
add r3, r2 
ldr r3, [r3] @ table of skills relevant to the current animation loop 
lsl r1, #3 @ 8 bytes per entry 
ldr r2, [r3, r1] @ usability 
cmp r2, #0 
beq StartOfTurn_SkillBufferLoop
mov r0, r7 @ unit 
mov lr, r2 
.short 0xF800 
cmp r0, #0 
beq StartOfTurn_SkillBufferLoop

ldr r3, =StartOfTurnCalcLoop 
mov r2, r6 @ function we're on 
lsl r2, #2 @ 4 bytes per 
add r3, r2 
ldr r3, [r3, #4] @ function that starts a child proc 

@ true, so we start the proc which will execute whatever's in r3 then continue the loop within its proc 
b StartBlockingProc 

SkipStartOfTurn: 
b Master_DoNotBlock @ if we reached here, do nothing and exit 


StartBlockingProc: 
push {r3} @ function to execute 

ldr r0, =TurnCalcLoop_Proc
mov r1, r4 @ parent 
blh ProcStartBlocking 
mov r4, r0 @ new proc 
add r4, #0x2C 


@ initialize the proc 
sub r5, #1 @ we already added 1 for next time, but we need the current unit for the effect 
strb r5, [r4, #DeployByte]  
strb r6, [r4, #FuncCoun] 
mov r2, #0 
strb r2, [r4, #Destructor] 
mov r2, r9 
strb r2, [r4, #TryPhaseBool] 
mov r2, r10 
strb r2, [r4, #EndOfDeployByte] 
mov r2, r11 
sub r2, #1 
strb r2, [r4, #SkillBufferCounter] 
ldr r2, =gAttackerSkillBuffer
str r2, [r4, #SkillBuffer] @ SkillBuffer
str r7, [r4, #pUnit]
pop {r3} 
str r3, [r4, #FirstFunc] @ starts a blocking proc 



mov r0, r4 @ new proc 
sub r0, #0x2c 
mov r1, r8 @ proc label (0 = EndOfTurn, 1 = silent, 2 = StartOfTurn) 
blh ProcGoto @ skip part of the proc if we went through and found nothing 




Master_Block:
mov r0, #0 @ yield 
b Master_Exit 
Master_DoNotBlock: 
mov r0, #1 @ do not yield 

Master_Exit: 
@mov r11, r11 
pop {r4-r7} 
mov r8, r4 
mov r9, r5 
mov r10, r6 
mov r11, r7 
pop {r4-r7} 
pop {r1} 
bx r1 
.ltorg 

.global TurnLoop_Idle
.type TurnLoop_Idle, %function 
TurnLoop_Idle: @ ensure we yield until ProcGoto 
bx lr 
.ltorg 






.global StartOfTurnCalcLoop_SilentFunctions
.type StartOfTurnCalcLoop_SilentFunctions, %function 
StartOfTurnCalcLoop_SilentFunctions: 
push {r4, lr} 
ldr r4, =TurnCalcLoop_Silent
sub r4, #4 
SilentLoop: 
add r4, #4 
ldr r0, [r4] 
cmp r0, #0 
beq BreakSilent 
mov lr, r0 
.short 0xf800 
b SilentLoop 
BreakSilent: 


pop {r4} 
pop {r0} 
bx r0 
.ltorg 



.global EndOfTurnCalcLoop_Main
.type EndOfTurnCalcLoop_Main, %function 
EndOfTurnCalcLoop_Main: 
push {r4-r7, lr} 
mov r4, r0 @ parent proc 
add r4, #0x2C @ counter 
ldrb r2, [r4, #Destructor] @ destructor if phase is to be skipped over 
cmp r2, #0 
bne GotoBreakEndProcLoop 

NextEndOfTurnProcFunction: 
mov r2, #FuncCoun 
ldsb r1, [r4, r2] 
add r1, #2 
strb r1, [r4, r2] 
sub r1, #2 
ldr r3, =EndOfTurnCalcLoop 
lsl r1, #2 @ 4 bytes per entry 
ldr r0, [r3, r1] 
cmp r0, #0 
beq GotoBreakEndProcLoop 


EndOfTurnProcUnitLoop: 
ldrb r0, [r4, #DeployByte] 
ldrb r1, [r4, #EndOfDeployByte] 
cmp r0, r1 
bge NextEndOfTurnProcFunction 
mov r1, #1 
add r1, r0 
strb r1, [r4, #DeployByte] 
blh GetUnit 
str r0, [r4, #pUnit] 
bl IsUnitOnField 
cmp r0, #0 
beq EndOfTurnProcUnitLoop

mov r2, #0 
strb r2, [r4, #SkillBufferCounter] 

ldr r0, [r4, #pUnit] 
ldr r1, [r4, #SkillBuffer] 
bl MakeSkillBuffer 

EndOfTurnProc_SkillBufferLoop: 
ldrb r1, [r4, #SkillBufferCounter] 
add r1, #1 
strb r1, [r4, #SkillBufferCounter] 
ldr r3, [r4, #SkillBuffer] 
ldrb r1, [r3, r1] @ skill we have 
cmp r1, #0 
beq EndOfTurnProcUnitLoop

ldr r3, =EndOfTurnCalcLoop 
mov r2, #FuncCoun 
ldsb r2, [r4, r2] 
sub r2, #2 
lsl r2, #2 @ 4 bytes per 
add r3, r2 
ldr r3, [r3] @ table of skills relevant to the current animation loop 
lsl r1, #3 @ 8 bytes per entry 
ldr r2, [r3, r1] @ usability 
cmp r2, #0 
beq EndOfTurnProc_SkillBufferLoop

ldr r0, [r4, #pUnit] 
mov lr, r2 @ function of usability 
.short 0xf800 
cmp r0, #0 
beq EndOfTurnProc_SkillBufferLoop
@ returns pUnit in r0 
b RunEndFunc 

GotoBreakEndProcLoop: 
mov r0, r4 
sub r0, #0x2C 
blh ProcBreakLoop 


@ initialize stuff for StartOfTurnLoop 
mov r0, #0 
sub r0, #2 
strb r0, [r4, #FuncCoun] @ start at 0 for the StartOfTurn loop  
ldr r0, =ChapterData 
ldrb r0, [r0, #0xF] 
add r0, #0x40 
strb r0, [r4, #EndOfDeployByte] 

b ExitEndLoop 

RunEndFunc: 

ldr r3, =EndOfTurnCalcLoop 
ldrb r2, [r4, #FuncCoun] 
sub r2, #2 @ one we're currently on 
lsl r2, #2 @ 4 bytes per 
add r3, r2 
ldr r3, [r3, #4] @ function that starts a child proc 
mov lr, r3 
mov r0, r4 @ proc to block 
sub r0, #0x2C @ actual proc address instead of +0x2C offset 
.short 0xf800 

ExitEndLoop: 

pop {r4-r7} 
pop {r0} 
bx r0 
.ltorg 

.global ExecuteFirstFunc
.type ExecuteFirstFunc, %function 
ExecuteFirstFunc: 
push {r4, lr} 
mov r4, r0 
add r4, #0x2c 
ldrb r0, [r4, #FuncCoun] 

ldr r0, [r4, #FirstFunc] 
cmp r0, #0 
beq DontExecuteFirstFunc
mov lr, r0 
ldr r1, [r4, #pUnit] 
mov r0, r4 
sub r0, #0x2c 
.short 0xf800 @ execute this function with r0 = proc, r1 = pUnit 

mov r0, #0 @ yield if a function was ran 
str r0, [r4, #FirstFunc] @ don't execute this again 
b Exit_ExecuteFirstFunc 
DontExecuteFirstFunc:
mov r0, #1 
Exit_ExecuteFirstFunc:
pop {r4} 
pop {r1} 
bx r1 
.ltorg 


.global StartOfTurnCalcLoop_Main
.type StartOfTurnCalcLoop_Main, %function 
StartOfTurnCalcLoop_Main: 
push {r4-r7, lr} 
mov r4, r0 @ parent proc 
add r4, #0x2C @ counter 
ldrb r2, [r4, #Destructor] @ destructor if phase is to be skipped over 
cmp r2, #0 
bne GotoBreakStartProcLoop 

ldrb r0, [r4, #TryPhaseBool] @ skip start of this phase? 
cmp r0, #0 
beq GotoBreakStartProcLoop 

NextStartOfTurnProcFunction: 
mov r2, #FuncCoun 
ldsb r1, [r4, r2] 
add r1, #2 
strb r1, [r4, r2] 
sub r1, #2 
ldr r3, =StartOfTurnCalcLoop 
lsl r1, #2 @ 4 bytes per entry 
ldr r0, [r3, r1] 
cmp r0, #0 
beq GotoBreakStartProcLoop 


StartOfTurnProcUnitLoop: 
ldrb r0, [r4, #DeployByte] 
ldrb r1, [r4, #EndOfDeployByte] 
cmp r0, r1 
bge NextStartOfTurnProcFunction 
mov r1, #1 
add r1, r0 
strb r1, [r4, #DeployByte] 
blh GetUnit 
str r0, [r4, #pUnit] 
bl IsUnitOnField 
cmp r0, #0 
beq StartOfTurnProcUnitLoop

mov r2, #0 
strb r2, [r4, #SkillBufferCounter] 

ldr r0, [r4, #pUnit] 
ldr r1, [r4, #SkillBuffer] 
bl MakeSkillBuffer 

StartOfTurnProc_SkillBufferLoop: 
ldrb r1, [r4, #SkillBufferCounter] 
add r1, #1 
strb r1, [r4, #SkillBufferCounter] 
ldr r3, [r4, #SkillBuffer] 
ldrb r1, [r3, r1] @ skill we have 
cmp r1, #0 
beq StartOfTurnProcUnitLoop

ldr r3, =StartOfTurnCalcLoop 
mov r2, #FuncCoun 
ldsb r2, [r4, r2] 
sub r2, #2 
lsl r2, #2 @ 4 bytes per 
add r3, r2 
ldr r3, [r3] @ table of skills relevant to the current animation loop 
lsl r1, #3 @ 8 bytes per entry 
ldr r2, [r3, r1] @ usability 
cmp r2, #0 
beq StartOfTurnProc_SkillBufferLoop

ldr r0, [r4, #pUnit] 
mov lr, r2 @ function of usability 
.short 0xf800 
cmp r0, #0 
beq StartOfTurnProc_SkillBufferLoop
@ returns pUnit in r0 
b RunStartFunc 

GotoBreakStartProcLoop: 
mov r0, r4 
sub r0, #0x2c 
blh ProcBreakLoop 
b ExitLoop 

RunStartFunc: 
ldr r3, =StartOfTurnCalcLoop 
ldrb r2, [r4, #FuncCoun] 
sub r2, #2 @ one we're currently on 
lsl r2, #2 @ 4 bytes per 
add r3, r2 
ldr r3, [r3, #4] @ function that starts a child proc 
mov lr, r3 
mov r0, r4 @ proc to block 
sub r0, #0x2C @ actual proc address instead of +0x2C offset 
.short 0xf800 

ExitLoop: 

pop {r4-r7} 
pop {r0} 
bx r0 
.ltorg 

.global BreakHere 
.type BreakHere, %function 
BreakHere:
mov r11, r11 
bx lr 
.ltorg 

.global IsTrue 
.type IsTrue, %function 
IsTrue: 
mov r0, #1 
bx lr 

.global IsFalse
.type IsFalse, %function 
IsFalse: 
mov r0, #0 
bx lr 

.type CallBuffAnimationSkillLoop, %function 
.global CallBuffAnimationSkillLoop
CallBuffAnimationSkillLoop: 
push {r4, lr} 
mov r4, r0 @ proc 
mov r1, r0 @ to block 
ldr r0, =BuffAnimationSkillProc
blh ProcStartBlocking 
add r4, #0x2c 
add r0, #0x2c 

ldrb r1, [r4, #DeployByte] 
strb r1, [r0, #DeployByte] 
ldrb r1, [r4, #FuncCoun] 
strb r1, [r0, #FuncCoun] 
ldrb r1, [r4, #Destructor] 
strb r1, [r0, #Destructor] 
ldrb r1, [r4, #TryPhaseBool] 
strb r1, [r0, #TryPhaseBool] 
ldrb r1, [r4, #EndOfDeployByte] 
strb r1, [r0, #EndOfDeployByte] 
@ldrb r1, [r4, #SkillBufferCounter] 
mov r1, #0 @ always start the proc at the start of the buffer because it's easier and solves a bug 
strb r1, [r0, #SkillBufferCounter] 
ldr r1, [r4, #SkillBuffer] 
str r1, [r0, #SkillBuffer] 
ldr r1, [r4, #pUnit] 
str r1, [r0, #pUnit] 
ldr r1, [r4, #FirstFunc] 
str r1, [r0, #FirstFunc] 

mov r1, #0 
strb r1, [r0, #MidUnitLoopBool] 

mov r0, #1 @ has blocking proc 
pop {r4} 
pop {r1} 
bx r1 
.ltorg 


.global BuffAnimationIdle
.type BuffAnimationIdle, %function 
BuffAnimationIdle: 
push {r4, lr} 
mov r4, r0 @ parent proc 
add r4, #0x2c 
ldrb r0, [r4, #Destructor] 
cmp r0, #0 
bne DestructBuffAnimation 
bl FindMapAuraProc
cmp r0, #0 
bne ContinueIdleBuffAnimation 
mov r0, r4 @ proc 
sub r0, #0x2c 
mov r1, #0 @ wait for rally anim 
blh ProcGoto 
@ProcGoto((Proc*)proc,1);
b ContinueIdleBuffAnimation 
DestructBuffAnimation: 
mov r0, r4 @ proc 
sub r0, #0x2c 
mov r1, #1 @ label 
blh ProcGoto 

ContinueIdleBuffAnimation:
pop {r4}  
pop {r0} 
bx r0 
.ltorg 

.global BuffWaitForCamera
.type BuffWaitForCamera, %function 
BuffWaitForCamera: 
push {r4, lr} 
mov r4, r0 @ parent proc 

ldr r0, =gCameraProc 
blh ProcFind 
cmp r0, #0 
bne DontBreakCameraLoop 
@ldr r3, [r4, #0x3C] @ unit 
@ldrb r0, [r3, #0x10] @ xx 
@ldrb r1, [r3, #0x11] @ yy 
@blh ShouldMoveCamPos @ failsafe? 
@cmp r0, #0 
@bne DontBreakCameraLoop 

mov r0, r4 @ proc 
@mov r1, #3 @ label 
@blh ProcGoto 
blh ProcBreakLoop 

DontBreakCameraLoop:
pop {r4}  
pop {r0} 
bx r0 
.ltorg 

.global BuffAnimationSkillInit
.type BuffAnimationSkillInit, %function 
BuffAnimationSkillInit: 
bx lr 
.ltorg 

.type Buff_EnsureCamera, %function 
.global Buff_EnsureCamera 
Buff_EnsureCamera: 
push {r4, lr} 
mov r4, r0 @ proc 
add r0, #0x2c 
ldr r0, [r0, #pUnit] 
ldrb r1, [r0, #0x10] @ xx 
ldrb r2, [r0, #0x11] @ yy 
mov r0, r4 @ proc 
blh EnsureCameraOntoPosition 
mov r0, #0 
pop {r4} 
pop {r1} 
bx r1 
.ltorg 

.type BuffAnimationSkillLoop, %function 
.global BuffAnimationSkillLoop
BuffAnimationSkillLoop: 
push {r4-r7, lr} 
mov r4, r0 @ proc 
add r4, #0x2C 
ldrb r7, [r4, #SkillBufferCounter] @ buffer ? 
cmp r7, #0 
beq UnitLoop 
ldr r6, [r4, #SkillBuffer] @ buffer itself 
ldrb r0, [r4, #DeployByte] 
blh GetUnit 
mov r5, r0 @ unit 
b BufferLoop @ we just came out of pausing for some animation 
@ loop through units 
@ check for relevant skill(s) 
@ run a function for the skill 
UnitLoop: 
ldrb r0, [r4, #DeployByte] 
ldrb r1, [r4, #EndOfDeployByte] 
cmp r0, r1 
bge BreakLoop 
blh GetUnit 
mov r5, r0 @ unit 
bl IsUnitOnField @(Unit* unit)
cmp r0, #0 
beq GotoUnitLoop 

mov r0, r5 @ unit 
ldr r1, =gAttackerSkillBuffer
bl MakeSkillBuffer @(Unit* unit, SkillBuffer* buffer)
mov r6, r0 @ skill buffer 
str r6, [r4, #SkillBuffer] @ buffer 
@ possibly need to remove duplicate skills here 
@ /*00*/  u8 lastUnitChecked;
@ /*01*/  u8 skills[11];
BufferLoop: 
add r7, #1 
cmp r7, #BufferSize @ max size 
bgt GotoUnitLoop 
ldrb r0, [r6, r7] 
cmp r0, #0 @ should not have any gaps 
beq GotoUnitLoop 
ldr r3, =StartOfTurn_BuffSkillTable
lsl r0, #3 @ 8 bytes per entry
add r3, r0 
ldr r0, [r3] @ specific entry usability 
cmp r0, #0 
beq BufferLoop @ do nothing if not a function 
push {r3} 
mov lr, r0 
mov r0, r5 @ unit 
.short 0xf800 
pop {r3} 
cmp r0, #0 
beq BufferLoop 
ldr r0, [r3, #4] 
strb r7, [r4, #SkillBufferCounter] @ we're in the buffer loop atm 
str r5, [r4, #pUnit] @ unit 

str r0, [r4, #FirstFunc] 

mov r0, r4 
sub r0, #0x2C 
mov r1, #2 @ label to go to 
blh ProcGoto 

@ need to pause here and resume after animation 
b ExitAnimationSkillLoop 

GotoUnitLoop: 
ldrb r0, [r4, #DeployByte] 
add r0, #1 
strb r0, [r4, #DeployByte] @ deployment id 
mov r7, #0 
strb r7, [r4, #SkillBufferCounter] @ not in buffer loop atm 
b UnitLoop 


BreakLoop: 
mov r0, #1 @ break loop 
strb r0, [r4, #Destructor] 

ExitAnimationSkillLoop:
pop {r4-r7} 
pop {r0} 
bx r0 
.ltorg 

.type BuffExecuteFunc, %function 
.global BuffExecuteFunc
BuffExecuteFunc: 
push {r4, lr} 
mov r4, r0 @ proc 
add r4, #0x2c 
ldr r1, [r4, #FirstFunc] @ function to run 
cmp r1, #0 
beq ExitExecuteFunc 
ldr r0, [r4, #pUnit] @ unit 
mov lr, r1 
.short 0xf800 
ExitExecuteFunc: 

pop {r4} 
pop {r0} 
bx r0 
.ltorg 









