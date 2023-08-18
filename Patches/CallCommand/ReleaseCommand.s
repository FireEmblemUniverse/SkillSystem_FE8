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

	.equ CurrentUnit, 0x3004E50
	
.ltorg 
.global ReleaseCommandUsability
.type ReleaseCommandUsability, %function 
ReleaseCommandUsability: 
ldr r3, =CurrentUnit 
ldr r3, [r3] 
mov r0, #3 
cmp r3, #0 
beq ExitUsability 
ldr r0, [r3] @ unit pointer 
ldrb r0, [r0, #4] @ unit ID 
ldr r1, =ProtagID_Link 
ldr r1, [r1] 
cmp r0, r1 
bne UsabilityTrue 
mov r0, #3 @ false 
b ExitUsability 
UsabilityTrue: 
mov r0, #1 
ExitUsability: 
bx lr 
.ltorg 
	
	
	
	
	
	
	