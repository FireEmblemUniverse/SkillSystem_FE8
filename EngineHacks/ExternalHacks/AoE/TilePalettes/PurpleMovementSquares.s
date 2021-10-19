@ org 1DA98

.thumb 

.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.thumb 

	.equ ProcFind, 0x08002E9C

push {r4-r5, lr} @ will pop when returned to vanilla function 


mov r5, r0 


ldr r4, =0x859AD50 
mov r0, r4 
blh ProcFind
cmp r0, #0 
beq DisplayRangeSquares

add r0, #0x4a  @ range ? 
strh r5, [r0]


DisplayMoveSquares:
ldr r3, =0x801DAA9 
bx r3 


@ display range squares ig 
DisplayRangeSquares:
ldr r3, =0x801DAB9
bx r3 





.align 4 
.ltorg 
