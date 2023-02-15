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
.equ gTempSkillBuffer, 0x02026B90
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


.global StartOfTurnCalcLoop_Init 
.type StartOfTurnCalcLoop_Init, %function 
StartOfTurnCalcLoop_Init: 
push {r4, lr} 
mov r4, r0 
add r0, #0x2C @ counter 
mov r1, #0 
str r1, [r0]
add r0, #4 
str r1, [r0] @ exit 

ldr r0, =ChapterData 
ldrb r0, [r0, #0xF] 
@ next phase 
@ 0x80 was 0 
@ 0x40 was 0x80 
@ 0 was 0x40 
cmp r0, #0 
beq EndOfNPC 
cmp r0, #0x40 
beq EndOfEnemy 
cmp r0, #0x80 
beq EndOfPlayer 

EndOfNPC: 
mov r1, #0x40 @ npc 
str r1, [r4, #0x34] 
b CheckIfPhaseExists 
EndOfEnemy: 
mov r1, #0x80 @ enemy 
str r1, [r4, #0x34] 
b CheckIfPhaseExists 
EndOfPlayer: 
mov r1, #0x0 @ player  
str r1, [r4, #0x34] 
b CheckIfPhaseExists 


CheckIfPhaseExists: @ r0 as ChData+0xF 
ldr r0, =ChapterData 
ldrb r0, [r0, #0xF] 
blh GetPhaseAbleUnitCount 
str r0, [r4, #0x44] @ # of units for start of this phase 
ldr r0, [r4, #0x34] 
blh GetPhaseAbleUnitCount 
str r0, [r4, #0x40] @ # of units for end of this phase 


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
add r0, #0x2C @ counter 
ldr r2, [r0, #4] @ destructor if phase is to be skipped over 
cmp r2, #0 
bne GotoBreakProcLoop 

ldr r0, [r4, #0x40] @ skip end of this phase? 
cmp r0, #0 
beq GotoBreakEndProcLoop 

EndCalcLoop_SkippedFunc: 
ldr r1, [r4, #0x2c] 

add r1, #2 
str r1, [r4, #0x2c] 
sub r1, #2 @ current one to care about 
ldr r3, =EndOfTurnCalcLoop 
lsl r1, #2 @ 4 bytes per entry 
add r1, #4 @ effect 
ldr r5, [r3, r1] 
cmp r5, #0 
beq GotoBreakEndProcLoop 
sub r1, #4 @ usability heuristic 
ldr r0, [r3, r1] 
mov lr, r0 
.short 0xf800 
cmp r0, #0 
beq EndCalcLoop_SkippedFunc
b RunEndFunc 

GotoBreakEndProcLoop: 
mov r0, r4 
blh ProcBreakLoop 
b ExitEndLoop 

RunEndFunc: 
mov lr, r5 @ function to run 
mov r0, r4 @ proc to block 
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
add r0, #0x2C @ counter 
ldr r2, [r0, #4] @ destructor if phase is to be skipped over 
cmp r2, #0 
bne GotoBreakProcLoop 

ldr r0, [r4, #0x44] @ skip start of this phase? 
cmp r0, #0 
beq GotoBreakProcLoop 

MainCalcLoop_SkippedFunc: 
ldr r1, [r4, #0x2c] 

add r1, #2 
str r1, [r4, #0x2c] 
sub r1, #2 @ current one to care about 
ldr r3, =StartOfTurnCalcLoop 
lsl r1, #2 @ 4 bytes per entry 
add r1, #4 @ effect 
ldr r5, [r3, r1] 
cmp r5, #0 
beq GotoBreakProcLoop 
sub r1, #4 @ usability heuristic 
ldr r0, [r3, r1] 
mov lr, r0 
.short 0xf800 
cmp r0, #0 
beq MainCalcLoop_SkippedFunc
b RunFunc 

GotoBreakProcLoop: 
mov r0, r4 
blh ProcBreakLoop 
b ExitLoop 

RunFunc: 

mov lr, r5 @ function to run 
mov r0, r4 @ proc to block 
.short 0xf800 

@ldr r0, =StartOfTurnCalcLoop_SomeFunctionProc
@mov r1, r4 @ parent proc 
@blh ProcStartBlocking 
@add r0, #0x2C 
@str r5, [r0] 
@ldr r1, [r4, #0x34] @ end of which phase? 
@str r1, [r0, #8] @ end of which phase? 

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









