.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.equ CallMapEventEngine, 0x800D07C
.equ ProcStartBlocking, 0x8002CE0 
.equ ProcFind, 0x8002E9C
.equ BreakProcLoop, 0x08002E94
.equ gProc_Menu, 0x85B64D0
.equ gProc_Popup, 0x85921C8

.global CallWaitForMenusEvent
.type CallWaitForMenusEvent, %function 
CallWaitForMenusEvent: 
push {lr} 
ldr r0, =WaitForMenusEvent 
mov r1, #1 
blh CallMapEventEngine 
pop {r0} 
bx r0 
.ltorg 


.global CallWaitForMenusASMC 
.type CallWaitForMenusASMC, %function 
CallWaitForMenusASMC: 
push {lr} 
mov r1, r0 @ event proc 
ldr r0, =WaitForMenusProc 
blh ProcStartBlocking 
pop {r0} 
bx r0 
.ltorg 



.global WaitForMenusASM
.type WaitForMenusASM, %function 
WaitForMenusASM:
push {r4, lr} 
mov r4, r0 
ldr r0, =gProc_Menu 
blh ProcFind 
cmp r0, #0 
beq CheckPopups 

add r0, #0x63 
ldrb r1, [r0] 
mov r2, #0x40 
bic r1, r2 
strb r1, [r0] @ don't pause menu if event is active? MENU_STATE_FROZEN = (1 << 6),
b ContinueIdling 


CheckPopups: 
@ldr r0, =gProc_Popup 
@blh ProcFind 
@cmp r0, #0 
@bne ContinueIdling 
mov r0, r4 
blh BreakProcLoop 
ContinueIdling: 
pop {r4} 
pop {r0} 
bx r0 
.ltorg 



