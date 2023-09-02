.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.equ CheckEventId,0x8083da8
.equ gKeyState, 0x2024CC0

.global ProcVariableSleep
.type ProcVariableSleep, %function 
ProcVariableSleep: @ based on ProcCmd_SLEEP from decomp 
push {r4, lr} 
@r0 is sleep time 
mov r4, r1 @ proc 

bl AdjustSleepTime 
cmp r0, #0 
beq Skip 

strh r0, [r4, #0x24] @ proc_sleepTime 
ldr r0, =0x8003291 @ UpdateSleep 
str r0, [r4, #0xC] @ current function to run 
Skip: 

@ ProcCmd_CALL_ROUTINE_ARG does this part already: 
@proc->proc_scrCur++;


mov r0, #0 @ yield 
pop {r4} 
pop {r1} 
bx r1 
.ltorg 


.global AdjustSleepTime 
.type AdjustSleepTime, %function 
AdjustSleepTime: 
push {r4-r5, lr} 
@ given r0 = frames to wait, adjust based on flag / A button being held down 
mov r4, #0xFF 
lsr r5, r0, #8 @ minimum percentage 
and r4, r0 @ never sleep > 255 frames 


ldr r0, =SpeedupFlag_Link
ldr r0, [r0] 
blh CheckEventId 
mov r1, r7 
add r1, #0x31 
cmp r0, #0 
beq NoSpeedupFlag
cmp r5, #0 
bne MinimumDivisor
mov r4, #0x0 @ 0 frames 
b NoSpeedupFlag 
MinimumDivisor: 
mov r0, r4 
mul r0, r5 
mov r1, #100 
swi 6 
mov r4, r0 @ minimum percent of frames 

NoSpeedupFlag: 

ldr r3, =gKeyState 
ldrh r0, [r3, #4] @ held keys 
mov r1, #1 @ KEY_BUTTON_A
tst r0, r1 
beq NoSpeedupButtonHeld 
lsr r4, #1 @ half the frames if A is held 
NoSpeedupButtonHeld: 
mov r0, r4 
pop {r4-r5} 
pop {r3} 
bx r3 
.ltorg 


.global ShouldShowPoisonSplatHook
.type ShouldShowPoisonSplatHook, %function 
ShouldShowPoisonSplatHook: 
push {lr} 
push {r0-r2} 
ldr r0, =SpeedupFlag_Link
ldr r0, [r0] 
blh CheckEventId 
mov r3, r0
pop {r0-r2}  
cmp r3, #0 
bne SkipShowingPoisonAtAll 
add r0, r1 
lsl r0, #2 
add r0, r2 
ldr r0, [r0] 
blh 0x807CC78 @ NewMapPoisonEffect 
SkipShowingPoisonAtAll: 
pop {r0} 
bx r0 
.ltorg 



.global LevelUpSpeedHook_1
.type LevelUpSpeedHook_1, %function 
LevelUpSpeedHook_1: 
push {lr} 
mov r1, r8 
strb r0, [r1] 

mov r0, #0xF @ 15 frames default 
bl AdjustSleepTime 
mov r1, r7
add r1, #0x31 
@strb r0, [r1] 
pop {r3} 
ldr r3, =0x807F465 @ return address 
bx r3 
.ltorg 

.global LevelUpSpeedHook_2
.type LevelUpSpeedHook_2, %function 
LevelUpSpeedHook_2: 
push {lr} 
mov r5, r0 


mov r0, #0xF 
bl AdjustSleepTime 
@add r0, #1 @ this is what FEB does 

ldrh r1, [r5, #0x2c] 
add r1, #1 
strh r1, [r5, #0x2c] 
lsl r1, #0x10 
asr r1, #0x10 

cmp r1, r0 


pop {r3} 
bx r3 
.ltorg 









