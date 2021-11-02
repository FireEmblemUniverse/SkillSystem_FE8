.align 4
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.thumb

	.equ CurrentUnitFateData, 0x203A958
	.equ MemorySlot, 0x30004B8 
	.equ GetUnitByEventParameter, 0x0800BC51
	.equ RemoveUnitBlankItems,0x8017984
	.equ EventEngine, 0x800D07C
	.equ ReturnTMRam,			0x30017ba

.global DebugCommandEffect
.type DebugCommandEffect, function 

DebugCommandEffect: 
	push {r4-r7, lr}


ldr r0, =DebugCommandEvent 
mov	r1, #0x01		@0x01 = wait for events
blh EventEngine 




ldr r1, =CurrentUnitFateData	@these four lines copied from wait routine
mov r0, #0x1
strb r0, [r1,#0x11]



mov r0, #0xb7 





	pop {r4-r7}

	pop {r1}
	bx r1










