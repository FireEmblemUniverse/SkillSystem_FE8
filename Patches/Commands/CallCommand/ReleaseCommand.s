.align 4
.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm


	.equ EventEngine, 0x800D07C

	
.global ReleaseCommandEffect
	.type   ReleaseCommandEffect, function

ReleaseCommandEffect:
	push	{lr}
	
ldr r0, =ReleasePokemonEvent 
mov r1, #1 
blh EventEngine 

mov r0, #0x17 

pop {r1}
bx r1 
	
	
	
	
	
	
	
	
	