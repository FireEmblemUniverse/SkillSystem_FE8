
.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.equ GetUnit, 0x8019430
.equ MemorySlot,0x30004B8

GetTargetUnitID:
push {lr}
ldr r3, =0x203A958
ldrb r0, [r3, #0x0D] @ target 
blh GetUnit 
cmp r0, #0 
beq Error 
ldr r1, [r0] 
cmp r1, #0 
beq Error 
ldr r1, [r0, #0x0C] @ state 
ldr r2, =#0x1000C @ escaped, dead, undeployed 
tst r1, r2 
bne Error 
ldr r1, [r0] @ unit pointer 
ldrb r0, [r1, #4] @ unit ID 
b Store 

Error:
mov r0, #1
lsl r0, #8 @ 0x100 if error 
Store: 
ldr r3, =MemorySlot 
add r3, #4*0x0C 
str r0, [r3] 

pop {r0}
bx r0 
.ltorg 

