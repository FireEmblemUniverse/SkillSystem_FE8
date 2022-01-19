.align 4
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
	.thumb

	.equ MemorySlot, 0x30004B8 
	.equ RamUnitTable, 0x859A5D0 @0th entry
	.equ GetUnitByEventParameter, 0x0800BC50

	.equ MemorySlot3,0x30004C4    @item ID to give @[0x30004C4]!!?


	.global GetNthUnit
	.type   GetNthUnit, function

GetNthUnit:
	push {r4-r7, lr}	
	ldr r3, =MemorySlot
	ldr r2, [r3, #4*0x01]
	lsl r1, r2, #2 @multiply by 4 because 4 bytes each pointer  
	
	ldr r0, =RamUnitTable 
	
	ldr r0, [r0, r1] @Nth entry into RamUnitTable 
	
	ldr r0, [r0, #0] @0th entry into Specific Char (WORD Unit Pointer) 
	
	

	ldr r3, =MemorySlot
	str r0, [r3, #4*0x0C]

	pop {r4-r7}
	pop {r0}
	bx r0

