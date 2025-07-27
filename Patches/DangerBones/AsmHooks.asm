
.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm


.global Hook_PlayerPhase_InitUnitMovementSelect_FE6
.type Hook_PlayerPhase_InitUnitMovementSelect_FE6, %function 
Hook_PlayerPhase_InitUnitMovementSelect_FE6:
push {lr} 
bl FinishDangerBonesRange
blh MuExists 
cmp r0, #0 
bne Exit2_Hook_PlayerPhase_InitUnitMovementSelect_FE6

pop {r3} 
ldr r3, =0x801B409
bx r3 
.ltorg 
Exit2_Hook_PlayerPhase_InitUnitMovementSelect_FE6:
pop {r3} 
ldr r3, =0x801B439
bx r3 
.ltorg 

.global Hook_PlayerPhase_InitUnitMovementSelect_FE7
.type Hook_PlayerPhase_InitUnitMovementSelect_FE7, %function 
Hook_PlayerPhase_InitUnitMovementSelect_FE7:
push {lr} 
bl FinishDangerBonesRange
blh MuExists 
cmp r0, #0 
bne Exit2_Hook_PlayerPhase_InitUnitMovementSelect_FE7

pop {r3} 
ldr r3, =0x801C589
bx r3 
.ltorg 
Exit2_Hook_PlayerPhase_InitUnitMovementSelect_FE7:
pop {r3} 
ldr r3, =0x801C5B9
bx r3 
.ltorg 

.global Hook_PlayerPhase_Suspend_FE6
.type Hook_PlayerPhase_Suspend_FE6, %function 
Hook_PlayerPhase_Suspend_FE6:
push {lr} 
bl StartDangerBonesRange

ldr r1, =gActionData 
mov r0, #0
strb r0, [r1, #0x16]
mov r0, #3 
ldr r3, =0x801b03F  
bx r3 
.ltorg 


.global Hook_PlayerPhase_Suspend_FE7
.type Hook_PlayerPhase_Suspend_FE7, %function 
Hook_PlayerPhase_Suspend_FE7:
push {lr} 
bl StartDangerBonesRange
ldr r1, =gActionData 
mov r0, #0
strb r0, [r1, #0x16]
mov r0, #3 
ldr r3, =0x801548F  
bx r3 
.ltorg 


@ in 1CC1C
.global Hook_PlayerPhase_InitUnitMovementSelect
.type Hook_PlayerPhase_InitUnitMovementSelect, %function 
Hook_PlayerPhase_InitUnitMovementSelect:
push {lr} 
ldrb r1, [r5, #4] 
mov r0, #2 
orr r0, r1 
strb r0, [r5, #4] 

bl FinishDangerBonesRange

ldr r4, =gActiveUnit 
ldr r0, [r4] 
pop {r3} 
bx r3 
.ltorg 


.global Hook_PlayerPhase_Suspend
.type Hook_PlayerPhase_Suspend, %function 
Hook_PlayerPhase_Suspend:
push {lr} 
bl StartDangerBonesRange
ldr r1, =gActionData 
mov r0, #0
strb r0, [r1, #0x16]
mov r0, #3 
ldr r3, =0x801C89F 
bx r3 
.ltorg 


.global Hook_EnsureCameraOntoPosition
.type Hook_EnsureCameraOntoPosition, %function 
Hook_EnsureCameraOntoPosition: 
push {lr} 
lsl r0, #0x10 
lsr r6, r0, #0x10 
bl RemoveEnemyShaking
ldr r1, =gBmSt @ gGameState / gBmSt 
mov r2, #0xC 
ldsh r0, [r1, r2] 
cmp r7, r0 

pop {r3} 
bx r3 
.ltorg 
.equ POIN_SMS_Table, 0x8026C88 
.global Hook_RefreshUnitSprites
.type Hook_RefreshUnitSprites, %function 
Hook_RefreshUnitSprites: 
push {lr} 
mov r3, r2 @ SMS ID (pokemblem only) 
lsl r2, r0, #16 
lsr r2, #24 
cmp r2, #0xC0 
bge DoNothing 
mov r2, #0x10 
lsl r2, #8 
add r0, r2 
DoNothing: 
strh r0, [r5, #8] 
mov r2, r3 
ldr r3, =POIN_SMS_Table @ POIN SMS table 
ldr r3, [r3] 
lsl r2, #3 @ 8 bytes per entry 
add r2, r3 @ regular SMS table entry 
add r2, #2 @ sms entry + offset 0x02 Size 
@ default is 0x8AFBB2 as light rune trap SMS size for everything but ballistas, I think 
mov r9, r2 @ vanilla has the address of light rune +0x02 size

mov r2, r9 
ldrh r0, [r2] 
strb r0, [r5, #0xB] 
@add r4, #8 
@ldrb r0, [r4, #2] 
pop {r3} 
ldr r3, =0x8027345 
bx r3 
.ltorg 


.global Hook_PutUnitSpritesOam_FE7
.type Hook_PutUnitSpritesOam_FE7, %function 
Hook_PutUnitSpritesOam_FE7: 
push {lr} 
mov r3, #0 
cmp r0, #0 
beq Exit_PutUnitSpritesOam_FE7 
blh GetGameClock
mov r3, r0 
mov r0, #0x1
ldr r1, =ShakeSpeed_Link 
ldr r1, [r1] 
lsl r0, r1 

and r3, r0 
lsr r3, r1 
Exit_PutUnitSpritesOam_FE7: 

pop {r2} 
ldr r2, =0x802596F 
bx r2 
.ltorg 

.global Hook_PutUnitSpritesOam
.type Hook_PutUnitSpritesOam, %function 
Hook_PutUnitSpritesOam: 
push {lr} 
mov r3, #0 
cmp r0, #0 
beq Exit_PutUnitSpritesOam 
blh GetGameClock
mov r3, r0 
mov r0, #0x1
ldr r1, =ShakeSpeed_Link 
ldr r1, [r1] 
lsl r0, r1 

and r3, r0 
lsr r3, r1 
Exit_PutUnitSpritesOam: 

pop {r2} 
bx r2 
.ltorg 






