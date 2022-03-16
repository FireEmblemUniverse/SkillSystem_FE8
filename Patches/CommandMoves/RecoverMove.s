.thumb
.align 4

.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

	.equ CurrentUnit, 0x3004E50
	.equ MemorySlot,0x30004B8
	.equ EventEngine, 0x800D07C
	
.global RecoverCommandUsability 
.type RecoverCommandUsability, %function 

RecoverCommandUsability:
push {lr} 

ldr r0, =CurrentUnit 
ldr r0, [r0] 
ldr r1, =RecoverMove 
lsl r1, #24 
lsr r1, #24 
bl MoveTester 
ldr r3, =CurrentUnit 
ldr r3, [r3] 
ldrb r2, [r3, #0x13] @ Curr HP 
ldrb r1, [r3, #0x12] @ Max HP 
cmp r2, r1 
bge RetFalse @ Full hp, so cannot heal self 
cmp r0, #1 
beq RetTrue 
RetFalse: 
mov r0, #3 @ Menu false usability is 3 

RetTrue: 

pop {r1} 
bx r1 

	.equ CurrentUnitFateData, 0x203A958
.global RecoverCommandEffect 
.type RecoverCommandEffect, %function 

RecoverCommandEffect:
push {r4-r7, lr} 

ldr r3, =CurrentUnit
ldr r4, [r3] 
ldrb r0, [r4, #0x12] @ Max HP 
add r0, #2 @ for some rounding 
lsr r0, #2 @ 1/4 max hp 
ldr r3, =MemorySlot 
str r0, [r3, #4*0x06] @ s6 as amount to heal 

ldr r0, =UseVulneraryEvent
mov r1, #1 @ Wait 

blh EventEngine 



ldr r1, =CurrentUnitFateData	@these four lines copied from wait routine
mov r0, #0x1
strb r0, [r1,#0x11]
mov r0, #0x17	@makes the unit wait?? makes the menu disappear after command is selected??
@mov r0,#0x94		@play beep sound & end menu on next frame & clear menu graphics







pop {r4-r7}
pop {r1} 
bx r1


.ltorg 
.align 









