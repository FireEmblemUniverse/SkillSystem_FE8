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


.global TurnLoopMaster
.type TurnLoopMaster, %function 
TurnLoopMaster:
push {r4-r7, lr} 
mov r4, r0 @ proc to possibly block (MapMain) 
mov r5, #0 @ deployment byte starts at 0+1 
mov r8, r5 @ proc label starts at 0 
mov r6, #0 @ function counter 
sub r6, #1 @ add 1 in the start of the loop 
mov r7, #0 
@ r5 = unit deployment byte 
@ r6 = function counter 
@ r7 = SkillBuffer 
@ r8 = proc label 
@ r9 = # of units in this phase - possibly skip the phase's start of turn loop 
@ r10 = deployment byte to stop at for the current loop (eg. current phase 0, 0x40, 0x80 + 0x40) 
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


CheckIfPhaseExists: @ r0 as ChData+0xF 
mov r1, r0 
add r1, #0x40 
mov r10, r1 @ deployment byte to stop at 
blh GetPhaseAbleUnitCount 
cmp r0, #0 
beq SkipEndOfTurn 


@ end of turn calc loop goes here 
@ loop through each unit 
@ create a buffer of skill IDs 
@ then call the indexed function for that skill 

mov lr, r2 
mov r0, r5 @ deployment byte 
mov r1, r10 @ where to stop 
.short 0xf800 







@ 

cmp r0, #0 
beq SkipEndOfTurn 
mov r5, r0 @ pUnit 
b StartBlockingProc 


SkipEndOfTurn: 

mov r0, r9 @ should we skip this phase? 
cmp r0, #0 
beq Master_DoNotBlock

mov r0, #1 @ if we start the proc, start at the silent functions 
mov r8, r0 



bl StartOfTurnCalcLoop_SilentFunctions

mov r6, #0 
sub r6, #2
mov r0, #2 @ if we start the proc, start from the Start of Turn functions 
mov r8, r0 
ldr r0, =ChapterData 
ldrb r0, [r0, #0xF] 
add r0, #0x40 
mov r10, r0 @ deployment byte to stop at 

@ start of turn calc loop goes here 

mov lr, r2 
mov r0, r5 @ deployment byte 
mov r1, r10 @ where to stop 
.short 0xf800 







@ 

cmp r0, #0 
beq SkipStartOfTurn 
mov r5, r0 @ pUnit 
b StartBlockingProc 


StartBlockingProc: 
ldr r0, =TurnCalcLoop_Proc
mov r1, r4 @ parent 
blh ProcStartBlocking 
mov r4, r0 @ new proc 


@ r0 = proc that started 
mov r1, r5 @ pUnit 

sub sp, #8 
mov r3, sp 
mov r2, r9 @ TryPhaseBool (for Start of Turn) 
strb r2, [r3] 
mov r2, r10 @ deployment byte to stop at 
strb r2, [r3, #1] 
str r7, [r3, #4] @ SkillBuffer 
mov r2, r6 @ function counter we're on 
@ Init / save the variables to the proc 
bl TurnCalcLoop_Init 

add sp, #8

mov r0, r4 @ new proc 
mov r1, r8 @ proc label (0 = silent, 1 = EndOfTurn, 2 = StartOfTurn) 
blh ProcGoto @ skip part of the proc if we went through and found nothing 




Master_Block:
mov r0, #0 @ yield 
b Master_Exit 
Master_DoNotBlock: 
mov r0, #1 @ do not yield 

Master_Exit: 
pop {r4-r7} 
pop {r1} 
bx r1 
.ltorg 

.global TurnLoop_Idle
.type TurnLoop_Idle, %function 
TurnLoop_Idle: 
bx lr 
.ltorg 



@ +0x2C = deployment byte 
@ +0x2d = function counter 
@ +0x2e = destructor 
@ +0x2f = if 0 (no units), skip the StartOfTurn loop for this phase 

@ +0x30 = buffer pointer 
@ +0x34 = unit pointer 
.equ DeployByte, 0 
.equ FuncCoun, 1 
.equ Destructor, 2 
.equ TryPhaseBool, 3 
.equ SkillBuffer, 4 
.equ pUnit, 8 
.equ EndOfDeployByte, 12 @ where to stop searching 


.global TurnCalcLoop_Init 
.type TurnCalcLoop_Init, %function 
TurnCalcLoop_Init: 
push {r4, lr} 
mov r4, r0 @ proc 
add r4, #0x2C @ where variables are 

str r1, [r4, #pUnit] 
ldrb r1, [r1, #0x0B] @ deployment byte 
strb r1, [r4, #DeployByte] 
strb r2, [r4, #FuncCoun] 
mov r0, #0 
strb r0, [r4, #Destructor] @ false 
ldrb r0, [r3] 
strb r0, [r4, #TryPhaseBool] 
ldrb r0, [r3, #1] 
strb r0, [r4, #EndOfDeployByte] 

ldr r0, [r3, #4] 
str r0, [r4, #SkillBuffer] 


ExitThisProc: 
pop {r4} 
pop {r0} 
bx r0 
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
ldr r2, [r4, #Destructor] @ destructor if phase is to be skipped over 
cmp r2, #0 
bne GotoBreakProcLoop 

EndCalcLoop_SkippedFunc: 
mov r2, #FuncCoun 
ldsb r1, [r4, r2] 

add r1, #2 
strb r1, [r4, r2] 
ldr r3, =EndOfTurnCalcLoop 
lsl r1, #2 @ 4 bytes per entry 
add r1, #4 @ effect 
ldr r5, [r3, r1] 
cmp r5, #0 
beq GotoBreakEndProcLoop 
sub r1, #4 @ usability 
ldr r0, [r3, r1] 
mov lr, r0 
ldrb r1, [r4, #EndOfDeployByte] 
.short 0xf800 
cmp r0, #0 
beq EndCalcLoop_SkippedFunc
@ returns pUnit in r0 
b RunEndFunc 

GotoBreakEndProcLoop: 
mov r0, r4 
sub r0, #0x2C 
blh ProcBreakLoop 
mov r0, #0 
sub r0, #2 
strb r0, [r4, #FuncCoun] @ start at 0 for the StartOfTurn loop  

ldr r0, =ChapterData 
ldrb r0, [r0, #0xF] 
add r0, #0x40 
strb r0, [r4, #EndOfDeployByte] 

b ExitEndLoop 

RunEndFunc: 
mov r1, r0 @ pUnit 
mov lr, r5 @ function to run 
mov r0, r4 @ proc to block 
sub r0, #0x2C @ actual proc address instead of +0x2C offset 
.short 0xf800 

ExitEndLoop: 

pop {r4-r7} 
pop {r0} 
bx r0 
.ltorg 


.global StartOfTurnCalcLoop_Main
.type StartOfTurnCalcLoop_Main, %function 
StartOfTurnCalcLoop_Main: 
push {r4-r7, lr} 
mov r4, r0 @ parent proc 
add r4, #0x2C @ counter 
ldrb r2, [r4, #Destructor] @ destructor if phase is to be skipped over 
cmp r2, #0 
bne GotoBreakProcLoop 

ldr r0, [r4, #TryPhaseBool] @ skip start of this phase? 
cmp r0, #0 
beq GotoBreakProcLoop 

MainCalcLoop_SkippedFunc: 
mov r2, #FuncCoun 
ldsb r1, [r4, r2] 

add r1, #2 
strb r1, [r4, r2] 
ldr r3, =StartOfTurnCalcLoop 
lsl r1, #2 @ 4 bytes per entry 
add r1, #4 @ effect 
ldr r5, [r3, r1] 
cmp r5, #0 
beq GotoBreakProcLoop 
sub r1, #4 @ usability 
ldr r0, [r3, r1] 
mov lr, r0 
ldrb r1, [r4, #EndOfDeployByte] 
.short 0xf800 
cmp r0, #0 
beq MainCalcLoop_SkippedFunc
b RunFunc 

GotoBreakProcLoop: 
mov r0, r4 
blh ProcBreakLoop 
b ExitLoop 

RunFunc: 
mov r1, r0 @ pUnit 
mov lr, r5 @ function to run 
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
ldr r1, [r4, #0x34] @ phase 
add r0, #0x40 
str r1, [r0] @ phase ending   

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
ldr r0, [r4, #0x30] 
cmp r0, #0 
bne DestructBuffAnimation 
bl FindMapAuraProc
cmp r0, #0 
bne ContinueIdleBuffAnimation 
mov r0, r4 @ proc 
mov r1, #0 @ wait for rally anim 
blh ProcGoto 
@ProcGoto((Proc*)proc,1);
b ContinueIdleBuffAnimation 
DestructBuffAnimation: 
mov r0, r4 @ proc 
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
mov r1, #0 
str r1, [r0, #0x2C] @ unit deployment byte & mid-loop counter 
ldr r3, =ChapterData 
ldrb r3, [r3, #0x0F] 
cmp r3, #0x0 
beq NoSub 
sub r3, #1 @ to start at 0x40/0x80 instead of 0x41/0x81 (since players start at 0x01, not 0x00) 
NoSub: 
mov r2, #0x2C 
add r2, r0 
strb r3, [r2] @ phase as deployment byte to start at 
add r3, #0x40 @ end point 
strb r3, [r2, #2] @ ending place 

str r1, [r0, #0x30] @ destructor = false 
str r1, [r0, #0x34] @ skill buffer 
str r1, [r0, #0x38] @ function to run 
str r1, [r0, #0x3C] @ unit 
@ +0x40 is phase ending 
bx lr 
.ltorg 

.type Buff_EnsureCamera, %function 
.global Buff_EnsureCamera 
Buff_EnsureCamera: 
push {r4, lr} 
mov r4, r0 @ proc 
ldr r0, [r4, #0x3C] 
ldrb r1, [r0, #0x10] @ xx 
ldrb r2, [r0, #0x11] @ yy 
mov r0, #0 
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
ldrb r7, [r4, #1] @ buffer ? 
cmp r7, #0 
beq UnitLoop 
ldr r6, [r4, #8] @ buffer itself 
ldrb r0, [r4] 
blh GetUnit 
mov r5, r0 @ unit 
b BufferLoop @ we just came out of pausing for some animation 
@ loop through units 
@ check for relevant skill(s) 
@ run a function for the skill 
UnitLoop: 
ldrb r0, [r4] 
add r0, #1 
ldrb r1, [r4, #2] 
cmp r0, r1 
bge BreakLoop 
strb r0, [r4] @ deployment id 
blh GetUnit 
mov r5, r0 @ unit 
bl IsUnitOnField @(Unit* unit)
cmp r0, #0 
beq UnitLoop 

mov r0, r5 @ unit 
ldr r1, =gAttackerSkillBuffer
bl MakeSkillBuffer @(Unit* unit, SkillBuffer* buffer)
mov r6, r0 @ skill buffer 
str r6, [r4, #8] @ buffer 
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
ldr r3, =StartOfTurn_SkillTable
lsl r0, #2 @ 4 bytes per POIN 
add r3, r0 
ldr r0, [r3] @ specific entry 
cmp r0, #0 
beq BufferLoop @ do nothing if not a function 
strb r7, [r4, #1] @ we're in the buffer loop atm 

str r0, [r4, #12] @ function to run 
str r5, [r4, #16] @ unit 
@mov lr, r0 
@mov r0, r5 @ unit 
@.short 0xF800 @ execute the function 
mov r0, r4 
sub r0, #0x2C 
mov r1, #2 @ label to go to 
blh ProcGoto 

@ need to pause here and resume after animation 
b ExitAnimationSkillLoop 

GotoUnitLoop: 
mov r7, #0 
strb r7, [r4, #1] @ not in buffer loop atm 
b UnitLoop 


BreakLoop: 
mov r0, #1 @ break loop 
str r0, [r4, #4] @ +0x30 as destructor 

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
ldr r1, [r4, #0x38] @ function to run 
cmp r1, #0 
beq ExitExecuteFunc 
ldr r0, [r4, #0x3C] @ unit 
mov lr, r1 
.short 0xf800 
ExitExecuteFunc: 

pop {r4} 
pop {r0} 
bx r0 
.ltorg 









