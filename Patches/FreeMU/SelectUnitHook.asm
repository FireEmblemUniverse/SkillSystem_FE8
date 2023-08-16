@ 0x1ca9c 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

@ https://github.com/FireEmblemUniverse/fireemblem8u/blob/1fe93f07433683fe30cbc34b2488e2fe9937d656/src/bm.c#L459
@ BmMain_ChangePhase 
@ 0x8083Eb8 RunPhaseSwitchEvents 

.thumb 
.equ gActiveUnit, 0x3004E50
	.equ EventEngine, 0x800D07C
.global SelectUnitHook
.type SelectUnitHook, %function 
SelectUnitHook: 
push {lr} 

ldr r0, [r4] @ unit pointer 
ldrb r0, [r0, #4] @ unit ID  
ldr r1, =ProtagID 
lsl r1, #24 
lsr r1, #24 
cmp r0, r1 
beq StartFMUIfPeaceful 
mov r0, r4 
blh 0x801865C @ SetupActiveUnit 
ldr r0, [r4] 
ldrb r0, [r0, #4] 
blh 0x80A474C @ BWL_IncrementMoveValue 
mov r0, r6 
blh 0x8002E94 @ BreakProcLoop 
b Exit 
StartFMUIfPeaceful:

bl AreAllPlayersSafe
cmp r0, #0 
beq NotSafeToFlee 

mov r0, r6 
@blh 0x8002E94 @ BreakProcLoop 

ldr r3, =gActiveUnit 
str r4, [r3] 
@blh 0x801865C @ SetupActiveUnit 

ldr r0, [r4, #0x0C] 
mov r1, #1 
bic r0, r1 
str r0, [r4, #0x0C] @ remove hide bitflag 

blh 0x80271A0 @ SMS_UpdateFromGameData


ldr r0, [r6, #0x14] @ proc parent 
mov r1, #5 @ label 5 (start phase) 
blh 0x8002F24 @ ProcGoto (bmmapmain) 

mov r0, r6 
blh 0x8002D6C @ proc end (player phase) 





ldr r3, =FreeMoveRam
ldr r3, [r3] 
ldrb r0, [r3] 
ldr r1, =FreeMove_Silent
ldrb r1, [r1] 
orr r0, r1 
strb r0, [r3] 
bl EnableFreeMovementASMC

@ https://github.com/FireEmblemUniverse/fireemblem8u/blob/1fe93f07433683fe30cbc34b2488e2fe9937d656/src/bm.c#L109
@blh 0x80225F8 @ Commnd_EndEffect

b Exit 

NotSafeToFlee: 
ldr r0, =NotSafeToFleeEvent 
mov r1, #1 
blh EventEngine 

Exit: 
pop {r0} 
bx r0 
.ltorg 


.global ShouldRunTurnEventHook
.type ShouldRunTurnEventHook, %function 
ShouldRunTurnEventHook: 
mov r3, r1 
ldrb r0, [r5, #0xF] 
cmp r0, r6 
bne False 

ldr r0, =FreeMoveRam 
ldr r0, [r0] 
ldrb r0, [r0] 
ldr r1, =FreeMove_Running
ldrb r1, [r1] 
tst r0, r1 
beq True @ FMU is not active, so run event 
b False 

True: 
ldr r0, [r2, #4] 
str r0, [r3, #4] 
ldrh r0, [r2, #2] 
str r0, [r3, #8] 
mov r0, #1 
b End 

False: 
mov r0, #0

End: 
bx lr 
.ltorg 


