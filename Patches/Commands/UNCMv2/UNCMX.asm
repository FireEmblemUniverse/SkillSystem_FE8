	
.align 4
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
	.thumb

	.equ MemorySlot, 0x30004B8 
	.equ GetUnitByEventParameter, 0x0800BC51
	
	.global UNCMX
	.type   UNCMX, function

UNCMX:	@Make
	push {r4-r7, lr}	
	mov r6, #0 @UNCM 
	b Start
	
	.global UNCR
	.type   UNCR, function

UNCRX:	@Reverse
	push {r4-r7, lr}	
	mov r6, #1 @UNCR 
	b Start
	
	.global UNCF
	.type   UNCF, function
UNCFX:	@Flip
	push {r4-r7, lr}	
	mov r6, #2 @UNCF 
	b Start

Start:
	
	ldr		r7, =MemorySlot 
	ldr 	r0, [r7, #4*0x01]
	blh 	GetUnitByEventParameter
	cmp 	r0, #0x0
	beq 	Error
	
	mov 	r4, r0 @RamUnitStruct
	ldr		r0, [r4, #0x0C]
	ldr		r1, [r7, #4*0x03] @MemorySlot3
	
	cmp 	r6, #1
	beq 	Off 
	cmp 	r6, #2 
	beq 	Flip
	@cmp 	r6, #0
	@beq 	On 
	
	On:
	orr 	r0,r1
	str		r0, [r4, #0x0C] 	@Store status back in unit
	
	b Exit
	

	Off:
	ldr		r1, [r7, #4*0x03] @MemorySlot3
	
	@ldr 	r2,=0xFFFFFFFF
	@eor 	r2, r2,r1
	@(@eor 0xFFFFFFFF is same as `mvn`)
	@and 	r0,r2
	
	bic 	r0, r1				@Clear bits 
	str		r0, [r4, #0x0C] 	@Store status back in unit
	
	b Exit 
	
	Flip:
	ldr		r1, [r7, #4*0x03] @MemorySlot3
	eor 	r0,r1
	str		r0, [r4, #0x0C] 	@Store status back in unit
	
	b Exit 
	
	Error:
	

	Exit:

	
	pop {r4-r7}
	pop {r0}
	bx r0 
	
	
	
	