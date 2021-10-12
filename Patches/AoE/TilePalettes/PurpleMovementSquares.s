@ org 0x801DAB8 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.thumb 
	.equ ProcFind, 0x08002E9C
.equ ProcStart, 0x08002c7c

mov r0, r4 
mov r1, #4 
blh ProcStart 
add r0, #0x4A 
mov r4, r0 

push {lr}
ldr r0, =p6C_FreeSelect @gProc_TargetSelection
mov r1, #1 
orr r0, r1 
blh ProcFind, r1 

cmp r0, #0 
beq ProcStateError 
mov r5, #0x20 @ purple squares 
ProcStateError:

pop {r3} 




strh r5, [r4] 
ldr r3, =0x801DAC5 
bx r3 




.align 4
.ltorg 




