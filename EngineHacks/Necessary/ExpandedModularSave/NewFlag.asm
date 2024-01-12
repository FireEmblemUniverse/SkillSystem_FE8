	
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

.global CheckNewFlag_ASMC
.type CheckNewFlag_ASMC, %function 
CheckNewFlag_ASMC: 
push {lr} 
ldr r2, =MemorySlot 
ldr r0, [r2, #4] @ s1 
mov r2, #2 @ check and store to sC 
b Start
.ltorg 

.global UnsetNewFlag_ASMC
.type UnsetNewFlag_ASMC, %function 
UnsetNewFlag_ASMC: 
push {lr} 
ldr r2, =MemorySlot 
ldr r0, [r2, #4] @ s1 
mov r2, #1 @ check and store to sC 
b Start
.ltorg 
.global SetNewFlag_ASMC
.type SetNewFlag_ASMC, %function 
SetNewFlag_ASMC: 
push {lr} 
ldr r2, =MemorySlot 
ldr r0, [r2, #4] @ s1 
mov r2, #0 @ check and store to sC 
b Start


	.global SetNewFlag
	.type   SetNewFlag, function
SetNewFlag:	
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

	.global SetNewFlag_No_sC
	.type   SetNewFlag_No_sC, function
SetNewFlag_No_sC:	
	push {lr}
	mov r2, #3 @Set
	b Start
	
	.global UnsetNewFlag_No_sC
	.type   UnsetNewFlag_No_sC, function
UnsetNewFlag_No_sC:	@turn OFF
	push {lr}	
	mov r2, #4 @Unset
	b Start
	
	.global CheckNewFlag_No_sC
	.type   CheckNewFlag_No_sC, function
CheckNewFlag_No_sC:	@Check whether ON or OFF 
	push 	{lr}	
	mov 	r2, #5 @Check
	b 		Start

Start:
cmp r2, #2 @ store zero to sC if we were given 0 as the flag to check  
bne Continue 
cmp r0, #0 
beq StoreZero 

Continue: 
cmp r0, #0 
beq Exit @ if no flag, just return false 
	ldr 	r3, =NewFlagsRam
	
	lsl 	r0, #16 @ shorts only 
	lsr 	r0, #16
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
	cmp 	r2, #4 
	beq 	Off 
	
	cmp 	r2, #2 
	beq 	Check
	cmp 	r2, #5 
	beq 	Check 
	
	cmp 	r2, #3 
	beq 	On 
	cmp 	r2, #0
	beq 	On 
	
	On:
	orr r0, r1 @any bits that were loaded before or added now should be set 
	strb r0, [r3] @store back into ram 

	
	b Exit

	Off:
	bic r1, r0 @any bits in common should now should be unset 
	strb r1, [r3] @store back into ram 

	
	b Exit 
	
	Check:
	and 	r0, r1 @ bits in common to be set in r0 
	cmp 	r0, #0
	beq 	StoreZero
	mov 	r0, #1 @flag was set 
	ldr r3, =MemorySlot 
	add r3, #4*0x0C
	cmp r2, #3 
	bge Exit 
	mov r1, #1 @True
	str r1, [r3]
	b 		Exit 
	
	StoreZero:
	mov r0, #0 
	
	ldr r3, =MemorySlot 
	add r3, #4*0x0C
	cmp r2, #3 
	bge Exit 
	mov r1, #0 @False
	str r1, [r3]
	@b Exit 

	Exit:	
	pop {r1}
	bx r1 
	
	
	
	
