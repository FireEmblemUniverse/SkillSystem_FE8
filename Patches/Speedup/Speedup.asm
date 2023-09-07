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

bl AdjustSleepTime_AB_Press 
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


.global AdjustSleepTime_A_Press
.type AdjustSleepTime_A_Press, %function 
AdjustSleepTime_A_Press: 
mov r1, #1 @ KEY_BUTTON_A
b AdjustSleepTime 

.global AdjustSleepTime_B_Press
.type AdjustSleepTime_B_Press, %function 
AdjustSleepTime_B_Press: 
mov r1, #2 @ KEY_BUTTON_B
b AdjustSleepTime 

.global AdjustSleepTime_AB_Press
.type AdjustSleepTime_AB_Press, %function 
AdjustSleepTime_AB_Press: 
mov r1, #3 @ KEY_BUTTON_A|KEY_BUTTON_B
b AdjustSleepTime 



.global AdjustSleepTime_AnyInput
.type AdjustSleepTime_AnyInput, %function 
AdjustSleepTime_AnyInput: 
mov r1, #0xFF 
lsl r1, #2 
mov r2, #3 
orr r1, r2 
b AdjustSleepTime @ 0x3FF 



AdjustSleepTime: 
push {r4-r6, lr} 
@ given r0 = frames to wait, adjust based on flag / buttons being held down 
@ r1 = accepted input to halve sleep time 
mov r6, r1 

mov r4, #0xFF 
lsr r5, r0, #8 @ minimum frames  
and r4, r0 @ never sleep > 255 frames 


ldr r0, =SpeedupFlag_Link
ldr r0, [r0] 
blh CheckEventId 
cmp r0, #0 
beq NoSpeedupFlag
mov r4, #0 @ sleep 0 frames 
NoSpeedupFlag:
ldr r3, =gKeyState 
ldrh r0, [r3, #4] @ held keys 

tst r0, r1 
beq NoSpeedupButtonHeld 
lsr r4, #1 @ half the frames if A is held 
NoSpeedupButtonHeld: 
cmp r4, r5 
bge ExitAdjustSleepTime 
mov r4, r5 @ minimum frames 
ExitAdjustSleepTime:
mov r0, r4 
pop {r4-r6} 
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

.global PoisonHPBarHook
.type PoisonHPBarHook, %function 
PoisonHPBarHook:
push {lr} 
blh 0x807CC78 @ NewMapPoisonEffect 
ldr r0, =PoisonHpBarSpeed_Link 
ldr r0, [r0] 

bl AdjustSleepTime_AB_Press
mov r1, r0 
mov r0, r4 @ vanilla 
blh 0x8014238 @ NewBlockingTimer 
pop {r3} 
bx r3 
.ltorg 




.global LevelUpSpeedHook_1
.type LevelUpSpeedHook_1, %function 
LevelUpSpeedHook_1: 
push {lr} 
mov r1, r8 
strb r0, [r1] 

ldr r0, =LevelUpSpeed_Link 
ldr r0, [r0] 

bl AdjustSleepTime_AB_Press
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

mov r1, #1 @ this one needs to be min 1 
lsl r1, #8 
ldr r0, =LevelUpSpeed_Link 
ldr r0, [r0] 
cmp r0, #0xFF 
bge NoMinLvlUpSpd
orr r0, r1  
NoMinLvlUpSpd: 
bl AdjustSleepTime_AB_Press

ldrh r1, [r5, #0x2c] 
add r1, #1 
strh r1, [r5, #0x2c] 
lsl r1, #0x10 
asr r1, #0x10 

cmp r1, r0 


pop {r3} 
bx r3 
.ltorg 

#ifdef POKEMBLEM_VERSION 
.global LightRuneAnimHook_3 
.type LightRuneAnimHook_3, %function 
LightRuneAnimHook_3:
push {lr} 
ldrh r0, [r1] 
add r0, #1 
strh r0, [r1] 
mov r2, #0 
ldsh r0, [r1, r2] 
push {r0} 
mov r0, #1 
lsl r0, #8 
mov r1, #4 
orr r0, r1 @ 4(1<<8): 4 frames default 
bl AdjustSleepTime_AB_Press @ will return 1, 2, or 4 
mov r1, r0 
pop {r0} 

cmp r1, #1 
beq SkipVanillaSet 

cmp r0, #1 
bne CheckRamInstead 
cmp r1, #2 
bne ZeroThenVanillaSet 
@mov r0, #1 
ldr r3, =SpeedupRam_Link 
ldr r3, [r3] 
cmp r3, #0 
beq VanillaSet 
ldrb r2, [r3] 
mov r1, #1 
orr r2, r1 
strb r2, [r3] 
mov r1, #2 
b SkipVanillaSet 

ZeroThenVanillaSet: 
ldr r3, =SpeedupRam_Link 
ldr r3, [r3] 
cmp r3, #0 
beq VanillaSet 
ldrb r2, [r3] 
mov r1, #1 
bic r2, r3 
strb r2, [r3] @ remove the speedup light runes bitflag 
b SkipVanillaSet 

CheckRamInstead: 
ldr r3, =SpeedupRam_Link 
ldr r3, [r3] 
cmp r3, #0 
beq VanillaSet 
ldrb r2, [r3] 
mov r1, #1 
tst r1, r2 
beq VanillaSet 
mov r1, #2 @ a bit faster 
b SkipVanillaSet 


VanillaSet: 
mov r1, #3 @ 3 unless flag is on 
SkipVanillaSet: 
pop {r3} 
bx r3 
.ltorg 
#endif 

.global MapAnimLevelUp_SoundHook
.type MapAnimLevelUp_SoundHook, %function 
MapAnimLevelUp_SoundHook: 
push {r4, lr} 
mov r4, r0 @ proc 
mov r0, #2 
bl AdjustSleepTime_AB_Press 
cmp r0, #2 
beq BlockingSound 
mov r4, #0 @ so no parent proc 
BlockingSound: 
mov r3, r4 @ parent proc or 0 
mov r0, #0x80 
lsl r0, #1 
mov r1, #0x80 
mov r2, #0x10 
blh 0x8002730 @ SongVolumeTransitionB
pop {r4} 
pop {r3} 
bx r3 
.ltorg 


.global SummonSpeedHook_1
.type SummonSpeedHook_1, %function 
SummonSpeedHook_1:
push {lr} 

mov r0, #2 
bl AdjustSleepTime_AB_Press 
cmp r0, #2 
bne Faster 
mov r3, #1 @ default speed 
b StoreSummonSpeed 
Faster: 
mov r3, #2 @ twice as fast 
StoreSummonSpeed: 
ldrh r0, [r5] @ vanilla (3rd hook doesn't need this line, but is fine to have it) 
add r0, r3 
strh r0, [r5] 
mov r1, r4 
add r1, #0x42 
mov r0, #4 
strh r0, [r1] @ 3rd hook needs this 
pop {r3} 
bx r3 
.ltorg 

.global GotItemPopupSpeed_Hook_1
.type GotItemPopupSpeed_Hook_1, %function 
GotItemPopupSpeed_Hook_1: 
push {r4, lr} 
ldr r4, =0x8011508 
b GotItemPopupSpeed_Hook_Start 

.global GotItemPopupSpeed_Hook_2
.type GotItemPopupSpeed_Hook_2, %function 
GotItemPopupSpeed_Hook_2: 
push {r4, lr} 
ldr r4, =0x8011520
b GotItemPopupSpeed_Hook_Start 

GotItemPopupSpeed_Hook_Start: 
ldr r0, =GotItemPopupSpeed_Link 
ldr r0, [r0] 
bl AdjustSleepTime_B_Press // no A press because you pressed A to get an item probably 
mov r1, r0 @ minimum frames 

ldr r0, [r4] @ 8011508 -> 08592230 (Data for pop-up 01 )
mov r2, #0 
mov r3, r5 @ vanilla 
blh 0x8011474, r4 
pop {r4} 
pop {r3} 
bx r3 
.ltorg 

.global GotItemPopupSpeed_Hook_3
.type GotItemPopupSpeed_Hook_3, %function 
GotItemPopupSpeed_Hook_3: 
push {r4, lr} 
mov r4, r0 
ldr r0, =GotItemPopupSpeed_Link 
ldr r0, [r0] 
bl AdjustSleepTime_B_Press
mov r1, r0 @ minimum frames 
mov r0, r4 @ gPopup_GotGold 
mov r2, #0 
mov r3, r6 @ vanilla 
blh 0x8011474, r4 
pop {r4} 
pop {r3} 
ldr r3, =0x8011689 @ return address 
bx r3 
.ltorg 

.global GotItemPopupSpeed_Hook_4
.type GotItemPopupSpeed_Hook_4, %function 
GotItemPopupSpeed_Hook_4: 
push {r4, lr} 
ldr r4, =0x8011690
ldr r0, =GotItemPopupSpeed_Link 
ldr r0, [r0] 
bl AdjustSleepTime_B_Press 
mov r1, r0 @ minimum frames 

ldr r0, [r4] @ 8011508 -> 08592230 (Data for pop-up 01 )
mov r2, #0 
mov r3, r6 @ vanilla 
blh 0x8011474, r4 
pop {r4} 
pop {r3} 
bx r3 
.ltorg 

.global VulneraryAnimationSpeed_Hook
.type VulneraryAnimationSpeed_Hook, %function 
VulneraryAnimationSpeed_Hook:
push {r5, lr} 
cmp r4, r1 
bge ExitVulnerarySpeed @ there is a bge as soon as we get back 
ldr r5, =VulneraryAnimationSpeed_Link
ldr r5, [r5] @ speed 
mov r0, #16 
bl AdjustSleepTime_AB_Press
cmp r0, #8 
beq DoubleVulnerarySpeed 
cmp r0, #16 
beq DefaultVulnerarySpeed 
b FastestVulnerarySpeed 

DoubleVulnerarySpeed: 
mov r0, #8 
b DoneAdjustSpeedVuln 
DefaultVulnerarySpeed: 
mov r0, #0xFF 
and r0, r5 
lsl r0, #2 @ so 1x becomes the number 4 as vanilla has 
b DoneAdjustSpeedVuln 

FastestVulnerarySpeed: 
mov r0, #4 
mov r1, #0xFF 
lsr r5, #8 
and r1, r5 
mul r0, r1 
@ fastest speed 
b DoneAdjustSpeedVuln 

DoneAdjustSpeedVuln: 
add r0, r4 
lsl r0, #0x10 
lsr r4, r0, #0x10 




ExitVulnerarySpeed: 
pop {r5} 
pop {r3} 
bx r3 
.ltorg 

.global ShouldAiDisplayTargetCursor_Hook
.type ShouldAiDisplayTargetCursor_Hook, %function 
ShouldAiDisplayTargetCursor_Hook: 
push {lr} 
ldr r0, =SpeedupFlag_Link 
ldr r0, [r0] 
blh CheckEventId 
cmp r0, #1 
beq DoNotDisplayCursorForAiTarget
ldr r0, [r4, #0x2c] 
ldr r1, [r4, #0x30] 
ldr r2, [r4, #0x58] 
blh 0x8015A98 @ DisplayCursor 
DoNotDisplayCursorForAiTarget: 
ldr r0, =0x8039EC8
ldr r0, [r0] 
pop {r3} 
bx r3 
.ltorg 

.global HowManyFramesShouldAiDisplayTargetCursor_Hook
.type HowManyFramesShouldAiDisplayTargetCursor_Hook, %function 
HowManyFramesShouldAiDisplayTargetCursor_Hook: // vanilla actually does like 1 frame if you hold down a button anyway 
push {lr} 
ldr r0, =AiTargetCursor_Link
ldr r0, [r0] 
bl AdjustSleepTime 
mov r3, r0 @ result 
mov r0, r4 
add r0, #0x64 
mov r2, #0 
ldsh r1, [r0, r2] 
mov r2, r0 
cmp r1, r3 
pop {r3} 
bx r3 
.ltorg 

.global SpeedupMovementHook
.type SpeedupMovementHook, %function 
SpeedupMovementHook: 
push {lr} 
ldr r0, =SpeedupFlag_Link 
ldr r0, [r0] 
blh CheckEventId 
cmp r0, #1 
bne SpeedUpMovementIfAIsHeld 
mov r0, #1
b Exit_SpeedupMovementHook 
SpeedUpMovementIfAIsHeld: 
ldr r0, =0x8079504
ldr r0, [r0] 
ldr r0, [r0] @ KeyStatusBuffer
ldr r1, [r0, #4] 
mov r0, #1 
and r0, r1 

Exit_SpeedupMovementHook: 
cmp r0, #0 
pop {r3} 
bx r3 
.ltorg 


