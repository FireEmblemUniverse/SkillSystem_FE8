

@Author 7743, Vesly 
@
.align 4
.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
@
@
	.equ MemorySlot, 0x30004B8 
	.equ GetUnitByEventParameter, 0x0800BC51
	
	.global GetUnitStatus
	.type   GetUnitStatus, function

GetUnitStatus:
	push	{r4-r7,lr}



	ldr		r7, =MemorySlot 
	ldr 	r4, [r7, #4*0x03]	@What status do we get?
	
	ldr 	r0, [r7, #4*0x01]	@What unit are we examining?
	blh 	GetUnitByEventParameter
	mov 	r5, r0 				@Copy unit pointer to r5 
	cmp 	r5, #0x0
	beq 	Error
	

	ldr 	r6, [r7, #4*0x04]	@LowerNibble, UpperNibble, Byte, Short, or WORD ? 
	mov 	r1, #0x60
	cmp		r4, r1 
	bgt 	Error 
	mov 	r0, #0 
	
	cmp 	r6, #0x01 
	beq 	LowerNibble
	cmp 	r6, #0x02
	beq 	UpperNibble
	cmp 	r6, #0x03 
	beq 	Byte
	cmp 	r6, #0x04 
	beq 	Short
	cmp 	r6, #0x05 
	beq 	Word
	b 		Error 
	
	LowerNibble:
	ldrb 	r0, [r5, r4] 
	mov  r2,#0xf
	and  r0, r2
	b 		Return
	
	UpperNibble:
	ldrb 	r0, [r5, r4] 
	lsr  r0, #0x4      @ >>4
	b 		Return	

	Byte:
	ldrb 	r0, [r5, r4] 
	b 		Return	
	
	Short: 
	ldrh 	r0, [r5, r4] 
	b 		Return	
	
	Word: 
	ldr 	r0, [r5, r4] 
	b 		Return	



Error:
	mov r0, #0
	str	r0, [r7, #4*0x0C]
	b Term 

Return:
@	ldr	r2, =0x030004B0  @メモリスロット0
	str	r0, [r7, #4*0x0C]  @MemorySlotC
	
Term:
	pop {r4-r7}
	pop	{r1}
	bx r1
