.thumb
.align
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

	.equ GetUnit, 0x8019430
	
	
.global IsPeaceful
.type IsPeaceful, %function 
IsPeaceful:
push {r4, lr}


@ check for if peaceful map 

@ check for at least one valid enemy eg. unit ID that is not 0xE0 - 0xEF 
mov r4,#0x7F @ current deployment id
@mov r11, r11 
LoopThroughUnits:
add r4, #1 
cmp r4, #0xC0 
bge RetTrue 
mov r0,r4
blh GetUnit @ 19430
cmp r0, #0
beq LoopThroughUnits
ldr r1, [r0]
cmp r1, #0 
beq LoopThroughUnits
ldr r1, [r0, #0x0C]
mov r2, #0x0C 
tst r1, r2 @ dead/undeployed 
bne LoopThroughUnits
ldr r1, [r0] @ char pointer 
ldrb r1, [r1, #4] @ char id 
cmp r1, #0xE0 
blt ValidEnemy
cmp r1, #0xEF 
bgt ValidEnemy
b LoopThroughUnits
ValidEnemy:

RetTrue:
mov r0, #1 
b Exit 

RetFalse:
mov r0, #0 

Exit:

pop {r4}
pop {r1}
bx r1

.ltorg 
.align 
















