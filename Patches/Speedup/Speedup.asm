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
push {r4-r5, lr} 
mov r5, r0 @ sleep time 
mov r4, r1 @ proc 
ldr r1, [r4, #4] 

bl AdjustPauseTime 
cmp r0, #0 
beq Skip 
@mov r5, r0 

strh r5, [r4, #0x24] @ proc_sleepTime 
ldr r0, =0x8003291 @ UpdateSleep 
str r0, [r4, #0xC] @ current function to run 
Skip: 


ldr r0, [r4, #4] 
add r0, #8 
str r0, [r4, #4] @proc->proc_scrCur++;


mov r0, #0 @ yield 
pop {r4-r5} 
pop {r1} 
bx r1 
.ltorg 


AdjustPauseTime: 
push {r4, lr} 
@ given r0 = frames to wait, adjust based on flag / A button being held down 
mov r4, r0 
ldr r0, =SpeedupFlag
lsl r0, #16 
lsr r0, #16 
blh CheckEventId 
mov r1, r7 
add r1, #0x31 
cmp r0, #0 
beq NoSpeedupFlag
mov r4, #0x0 @ 0 frames 
NoSpeedupFlag: 

ldr r3, =gKeyState 
ldrh r0, [r3, #4] @ held keys 
mov r1, #1 @ KEY_BUTTON_A
tst r0, r1 
beq NoSpeedupButtonHeld 
lsr r4, #1 @ half the frames if A is held 
NoSpeedupButtonHeld: 
mov r0, r4 
pop {r4} 
pop {r3} 
bx r3 
.ltorg 


.global LevelUpSpeedHook_1
.type LevelUpSpeedHook_1, %function 
LevelUpSpeedHook_1: 
push {lr} 
mov r1, r8 
strb r0, [r1] 

mov r0, #0xF @ 15 frames default 
bl AdjustPauseTime 
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
bl AdjustPauseTime 
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









