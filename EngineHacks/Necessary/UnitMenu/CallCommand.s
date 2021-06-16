.thumb
.align 


.global CallCommandUsability
.type CallCommandUsability, %function


.global CallCommandEffect
.type CallCommandEffect, %function

.equ CheckEventId,0x8083da8
.equ MemorySlot,0x30004B8
.equ CurrentUnit, 0x3004E50

.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

CallCommandUsability:
push {lr}


mov r0, #1 @ Flag that prevents call 
blh CheckEventId
cmp r0, #0 
bne Usability_False


blh Get2ndFreeUnit
cmp r0, #0 
beq Usability_False 
mov r0, #1 
b Exit 

Usability_False:
mov r0, #3 @ False is 3 for some reason  


Exit: 
pop {r1} 
bx r1 


CallCommandEffect:
push {lr} 
ldr r3, =CurrentUnit @ Pointer to current unit ram 
ldr r3, [r3] @ Individual Unit ram pointer 



ldr	r0, =CallCommandEvent	@ places units that haven't moved beside you 
mov	r1, #0x01		@0x01 = wait for events
ldr r3, ExecuteEvent
bl goto_r3


ldr r1, CurrentUnitFateData	@these four lines copied from wait routine
mov r0, #0x1
strb r0, [r1,#0x11]
mov r0, #0x17	@makes the unit wait?? makes the menu disappear after command is selected??
@mov r0,#0x94		@play beep sound & end menu on next frame & clear menu graphics

pop {r3}
goto_r3:
bx r3

.ltorg
.align 

ExecuteEvent:
	.long 0x800D07D @AF5D
CurrentUnitFateData:
	.long 0x203A958
