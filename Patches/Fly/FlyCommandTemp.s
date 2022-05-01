.align 4
.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
	.equ EventEngine, 0x800D07C
.global FlyCommandEffect
.type FlyCommandEffect, function 

FlyCommandEffect: 
push {lr} 
ldr r0, =FlyCommandEvent 
mov	r1, #0x01		@0x01 = wait for events
blh EventEngine 


mov r0, #0xb7 


pop {r1}
bx r1

	.equ CheckEventId,0x8083da8
	
.global FlyCommandUsability
.type FlyCommandUsability, function 

FlyCommandUsability: 
	push {lr}


ldr r0, =FlyFlag
lsl r0, #16
lsr r0, #16 @ Flags are shorts 
blh CheckEventId
cmp r0, #1 
beq Exit
mov r0, #3 
Exit:

pop {r1}
bx r1

.ltorg 
.align 
