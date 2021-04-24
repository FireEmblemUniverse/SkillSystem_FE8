	
.align 4
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
	.thumb

	.equ MemorySlot, 0x30004B8 
	.equ GetUnitByEventParameter, 0x0800BC51
	
	.equ GetUnit, 0x8019430
	.equ MemorySlot3,0x30004C4    @item ID to give @[0x30004C4]!!?
	.equ DivisionRoutine, 0x080D18FC

	.global AsmcName
	.type   AsmcName, function

AsmcName:
	push {r4-r7, lr}	
	
	
	blh GetUnitByEventParameter, r1
	cmp r0, #0x0
	beq Error
	

	ldr r7, =MemorySlot 	@break point example 
	ldr r0, [r7, #4*0x03] @s3 [0x30004C4]!!?
	mov r0, #0
	str r0, [r7, #4*0x03] 		
	
	
	Error:
	mov r2, #0x0   @ Error

	Exit:
	str r2, [ r7, #0xC * 4 ] @ Memory slot 0xC.
	
	
	pop {r4-r7}
	pop {r0}
	bx r0 
	
	
	
	