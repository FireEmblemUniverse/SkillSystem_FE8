.align 4
.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm


.equ CheckEventId,0x8083da8
.equ MemorySlot,0x30004B8
.equ CurrentUnit, 0x3004E50

	.equ GetUnitByEventParameter, 0x0800BC51
	.equ GetUnit, 0x8019430
	
	.global CallCommandEffect
	.type   CallCommandEffect, function

CallCommandEffect:
	push	{r4-r7,lr}
	
mov r6, #0 
ldr r0, =MemorySlot
str r0, [r0, #4*0x08] @ [0x30004D8]!!

mov r4,#1 @ current deployment id
mov r5,#0 @ counter
LoopThroughFirst5Units:
add r6, #1 
cmp r6, #6 
bge End @ We have found all the units we need to act upon 
	



LoopThroughUnits:
mov r0,r4
blh GetUnit @ 19430
cmp r0,#0
beq NextUnit
ldr r3,[r0]
cmp r3,#0
beq NextUnit
ldr r3,[r0,#0xC] @ condition word
@ if you add +1 to include Hide (eg 0x4F), it'll ignore the active unit, which may be useful 
mov r2,#0x4F @ moved/dead/undeployed/cantoing 
tst r3,r2
bne NextUnit
@ if you got here, unit exists and is not dead or undeployed, so go ham
@r0 is Ram Unit Struct 
add r5,#1 @ Nth unit that we want 
cmp r5,r6 @ BNE we don't want them 
bne LoopThroughFirst5Units
	@ Can unit cross terrain 

	@ Is unit not active 
ldr r1, [r0, #0x08] @ Level 
mov r1, #12 
strb r1, [r0, #0x08] 
b LoopThroughFirst5Units
	
	@ 
NextUnit:
add r4,#1
cmp r4,#0x3F
ble LoopThroughUnits
@ If we've gone through all units and not found 5 free, we can end 
mov r0, #0
	
End:

ldr r1, CurrentUnitFateData	@these four lines copied from wait routine
mov r0, #0x1
strb r0, [r1,#0x11]
mov r0, #0x17	@makes the unit wait?? makes the menu disappear after command is selected??
@mov r0,#0x94		@play beep sound & end menu on next frame & clear menu graphics

	pop {r4-r7}
	pop {r1}
	bx r1 
	
@ldr	r0, =CallCommandEvent	@ places units that haven't moved beside you 
@mov	r1, #0x01		@0x01 = wait for events
@ldr r3, ExecuteEvent
@bl goto_r3
	
.ltorg
.align 

ExecuteEvent:
	.long 0x800D07D @AF5D
CurrentUnitFateData:
	.long 0x203A958
	
	
	.global CallCommandUsability
.type CallCommandUsability, %function

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
