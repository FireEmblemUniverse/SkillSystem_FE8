.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.equ HandlePlayerCursorMovement, 0x801C8AC 
.equ CurrentUnit, 0x3004E50
.equ ProcStartBlockingChild, 0x80031c4 
.equ ProcStartBlocking, 0x8002CE0	
.global initializeMinesProc 
.type initializeMinesProc, %function 
initializeMinesProc:
push {r6, lr} 
mov r6, r0 
mov r1, r0 
ldr r0, =CreateMinesProc 
@mov r1, #3 @  if creating a new proc instead 
blh ProcStartBlocking @ proc, one to block 


ldrb r1, [r5, #4] @ Copied vanilla code 
mov r0, #2 
orr r0, r1 
strb r0, [r5, #4] 
ldr r4, =CurrentUnit 
ldr r0, [r4] @ Copied vanilla code
pop {r6} 
pop {r3} 
bx r3 
.ltorg 

.equ RunWaitEvents, 0x80843C0 
.global clearMinesHookNew
.type clearMinesHookNew, %function 
clearMinesHookNew:
push {lr} 

push {r0} 
bl ClearMines 
pop {r0} 
cmp r0, #0 
bne DoStuff
mov r0, #1 
b End 
DoStuff:
blh RunWaitEvents 
mov r0, #0 
End: 
pop {r1} 
pop {r1}
bx r1 
.ltorg 


.equ UpdateTrapHiddenStates, 0x801A1A0 

.global CallMinesFunc
.type CallMinesFunc, %function 
CallMinesFunc:
push {r4-r5, lr} 
mov r5, r0 
mov r4, #0 
Loop:
add r4, #1 
bl RandomlyPlaceMines 

blh UpdateTrapHiddenStates

cmp r4, #0xFF 
@ble Loop 
mov r0, r5 
blh Break6CLoop 

pop {r4-r5} 
pop {r0} 
bx r0
.ltorg 


.global initializeMines2 
.type initializeMines2, %function 
initializeMines2: 
push {lr} 
bl RandomlyPlaceMines 
ldr r4, =0x858791C 
ldr r0, [r4] 
ldrh r1, [r0, #8] 
mov r0, #0x80 
lsl r0, #2 
and r0, r1 
pop {r3} 
bx r3 
.ltorg 

.global initializeMines 
.type initializeMines, %function 
initializeMines: 
push {lr} 
bl RandomlyPlaceMines 
ldr r4, [r4] 
mov r1, #0x10 
ldsb r1, [r4, r1] 
mov r2, #0x14 
ldsh r0, [r5, r2] 
cmp r1, r0 
pop {r3} 
bx r3 
.ltorg 








.global hookForMines @ 1CD20  
.type hookForMines, %function 
hookForMines: 
push {lr} 
mov r4, #0xFF 
blh HandlePlayerCursorMovement 
bl RandomlyPlaceMines

ldr r0, =0x858791C  
ldr r0, [r0] 
ldrh r1, [r0, #8] 
pop {r3} 
bx r3 
.ltorg 

.equ EnsureCameraOntoPosition, 0x8015E0C 
.equ HideMoveRangeGraphics, 0x801DACC 
.equ Break6CLoop, 0x8002E94 
.equ Goto6CLabel, 0x8002F24
.equ EventEngine, 0x800D07C
	
.global hookForMines2
.type hookForMines2, %function 
hookForMines2: 
push {lr} 
push {r0-r2} 
ldr r0, =PlaceMinesEvent 
mov r1, #1 
@blh EventEngine 
bl  RandomlyPlaceMines
pop {r0-r2} 
blh EnsureCameraOntoPosition
blh HideMoveRangeGraphics
mov r0, r5 
blh Break6CLoop



pop {r3} 
bx r3 
.ltorg 
.equ CanMoveActiveUnitTo, 0x801D5A8
.global hookForMines3
.type hookForMines3, %function 
hookForMines3: 
push {lr} 
bl RandomlyPlaceMines 
ldr r1, =0x202BCB0 
mov r2, #0x14 
ldsh r0, [r1, r2] 
mov r3, #0x16 
ldsh r1, [r1, r3] 
blh CanMoveActiveUnitTo
lsl r0, #0x18 
pop {r3}
bx r3 
.ltorg 


.global clearMinesHook
.type clearMinesHook, %function 
clearMinesHook: 
push {lr} 
mov r0, r5
mov r1, #9 
blh Goto6CLabel  
bl ClearMines 
pop {r3} 
ldr r3, =0x801CEC1 
bx r3 
.ltorg 

.equ Find6C, 0x8002E9C
.global removeMinesHook
.type removeMinesHook, %function 
removeMinesHook: 
push {lr} 
ldr r0, =0x859ADC8 
blh Find6C 
cmp r0, #0 
beq Exit 
bl ClearMines 
mov r0, #1 
Exit: 

pop {r3} 
bx r3 
.ltorg 






