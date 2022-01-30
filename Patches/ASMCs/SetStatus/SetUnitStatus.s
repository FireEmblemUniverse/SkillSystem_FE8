

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
	
	.global SetUnitStatus
	.type   SetUnitStatus, function

SetUnitStatus:
	push	{r4-r7,lr}



	ldr		r7, =MemorySlot 
	ldr 	r4, [r7, #4*0x03]	@What status do we set?
	ldr 	r0, [r7, #4*0x01]	@What unit are we examining?
	blh 	GetUnitByEventParameter
	mov 	r5, r0 				@Copy unit pointer to r5 
	@mov r11, r11
	cmp 	r5, #0x0
	beq 	Error
	
	ldr 	r3, [r7, #4*0x05]	@What value are we storing? 
		
	
								@How much data do we store? 
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
	mov 	r2, r3 
	mov 	r1, #0xF0 
	bic 	r2, r2, r1
	ldrb 	r0, [r5, r4] 
	mov 	r1, #0x0F 
	bic 	r0, r0, r1

	add 	r0, r2
	strb 	r0, [r5, r4] 
	b 		Return 	
	
	UpperNibble:
	ldrb 	r0, [r5,r4]    @  
	mov  	r1,#0x0F
	and  	r1,r0
	mov 	r0, #0xF0
	and 	r0, r3 
	orr  	r0,r1
	strb 	r0, [r5,r4]
	b 		Return

	Byte:
	strb 	r3, [r5, r4] 
	b 		Return	
	
	Short: 
	strh 	r3, [r5, r4] 
	b 		Return	
	
	Word: 
	str 	r3, [r5, r4] 
	b 		Return	



Error:
	mov r0, #0
	str	r0, [r7, #4*0x0C]

Return:
ldr r0, =0x202E4D8 @ Unit map	{U}
ldr r0, [r0] 
mov r1, #0
blh 0x080197E4 @ FillMap 
blh 0x08019FA0   //UpdateUnitMapAndVision
blh 0x0801A1A0   //UpdateTrapHiddenStates
	blh  0x080271a0   @SMS_UpdateFromGameData
	blh  0x08019c3c   @UpdateGameTilesGraphics
Term:
	pop {r4-r7}
	pop	{r1}
	bx r1 
