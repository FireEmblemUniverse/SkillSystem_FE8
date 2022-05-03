.align 4
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
	.thumb
.equ SetEventId, 0x8083d80
.type CheckIfGameOver, %function 
.global CheckIfGameOver
CheckIfGameOver:
push {lr} 

bl Get1stUnit
cmp r0, #0 
bne Exit 

mov r0, #0x65 
blh SetEventId
blh 0x800D390 @ game over ASMC 

Exit:
pop {r0}
bx r0 
.ltorg 
.align 




