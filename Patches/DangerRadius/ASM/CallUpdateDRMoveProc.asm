.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.equ ProcFind, 0x8002E9C 
.equ BreakProcLoop, 0x8002E94 
.equ ProcStart, 0x8002C7C 

.type CallUpdateDRMoveProc, %function 
.global CallUpdateDRMoveProc 
CallUpdateDRMoveProc: 
push {lr} 
strb r0, [r1, #0x10] 
ldr r1, [r4] 
ldrb r0, [r5, #0x0F] 
strb r0, [r1, #0x11] 
ldr r0, [r4] 
blh 0x801849C 


ldr r0, =UpdateDRProc 
mov r1, #3 
blh ProcStart 


ldr r0, [r4] 
pop {r3} 
bx r3 
.ltorg 

.global UpdateDRProc_WaitForMenu
.type UpdateDRProc_WaitForMenu, %function 
UpdateDRProc_WaitForMenu: 
push {r4, lr} 
mov r4, r0 
ldr r0, =0x85B64D0 @ menu proc 
blh ProcFind 
cmp r0, #0 
beq Exit 
mov r0, r4 
blh BreakProcLoop  
bl UpdateDRMove
Exit: 
pop {r4} 
pop {r0} 
bx r0 
.ltorg 



