	
.align 4
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
	.thumb

	.equ MemorySlot, 0x030004B8
	.thumb
	.equ NewFlagsRam, 0x203F548 @ [0x203F548..0x203F648]!!?

@ parameters: 
@ given r0 as Short of which flag, we will Set, Unset, or Check it. 
@ check returns boolean in r0 of 1 = true, 0 = false 


	.global SetNewFlag
	.type   SetNewFlag, function

SetNewFlag:	@Set to ON
	push {lr}

	mov r2, #0 @Set
	b Start
	
	.global UnsetNewFlag
	.type   UnsetNewFlag, function

UnsetNewFlag:	@turn OFF
	push {lr}	
	mov r2, #1 @Unset
	b Start
	
	.global CheckNewFlag
	.type   CheckNewFlag, function
CheckNewFlag:	@Check whether ON or OFF 
	push 	{lr}	
	mov 	r2, #2 @Check
	b 		Start

Start:
	@mov 	r0, #0x1F
	ldr 	r3, =MemorySlot
	str 	r0, [r3, #4*0x08] @ [0x030004D8]!!
	ldr 	r3, =NewFlagsRam
	
	lsl 	r0, #16 
	lsr 	r0, #16
	ldrb	r1, [r3] @[0x203F548..0x203F648]!!?
	strb 	r1, [r3] @ [0x203F548]!! 
	
	
	
	lsr 	r1, r0, #3 @divided by 8 
	add 	r3, r1 @offset of flag byte we want 
	lsl 	r1, #3 @original but with any bits cut off 
	sub 	r0, r1 @just the bit to act on
	mov 	r1, #1 
	lsl 	r1, r1, r0 @lsl #1 r0 times 
	mov 	r0, r1 
	ldrb	r1, [r3] @value at the flag byte we're checking 

	cmp 	r2, #1
	beq 	Off 
	cmp 	r2, #2 
	beq 	Check
	@cmp 	r2, #0
	@beq 	On 
	
	On:
	orr r0, r1 @any bits that were loaded before or added now should be set 
	strb r0, [r3] @store back into ram 

	
	b Exit

	Off:
	bic r1, r0 @any bits in common should now should be unset 
	strb r0, [r3] @store back into ram 

	
	b Exit 
	
	Check:
	and 	r0, r1 @ bits in common to be set in r0 
	cmp 	r0, #0
	beq 	StoreZero
	mov 	r0, #1 @flag was set 
	ldr r3, =MemorySlot 
	mov r1, #4*0x0C
	mov r2, #1 @True
	strb r2, [r3, r1]
	b 		Exit 
	
	StoreZero:
	mov r0, #0 
	
	ldr r3, =MemorySlot 
	mov r1, #4*0x0C
	mov r2, #0 @False
	strb r2, [r3, r1]
	@b Exit 

	Exit:	
	pop {r1}
	bx r1 
	
	
	
	