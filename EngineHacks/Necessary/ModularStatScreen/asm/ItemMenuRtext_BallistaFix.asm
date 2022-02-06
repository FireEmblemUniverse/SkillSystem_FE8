.thumb

.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.equ UpFunc, 0x08089354
.equ DownFunc, 0x08089384
.equ LeftFunc, 0x080893B4
.equ RightFunc, 0x080893E4
.equ StatScreenStruct, 0x2003BFC

.global ItemMenuRtextGetter
.global ItemMenuRtextLooper

ItemMenuRtextGetter:
	push  {r4-r6,lr}
	mov   r4, r0
	ldr   r0, =StatScreenStruct
	ldr   r6, [r0, #0xC] @unit
	ldr   r0, [r4, #0x2C]
	ldrh  r5, [r0, #0x12] @slot number
	
	ldr   r0, [r6, #0xC] 	@unit state
	mov   r1, #0x80        
	lsl   r1, r1, #0x4		@Check "in ballista" bit
	and   r0, r1
	cmp   r0, #0x0
	beq   NoBallistaEquipped
		
		@get a non-empty ballista at unit position
		mov   r0, #0x10
		mov   r1, #0x11
		ldsb  r0, [r6, r0]
		ldsb  r1, [r6, r1]
		blh   0x0803798C 		@GetBallistaItemAt
		cmp   r0, #0x0
		beq   NoBallistaEquipped
		cmp   r5, #0x0
		beq   GotAnItem 		@go directly to store it if valid
		sub   r5, #0x1			@otherwise just decrease slot by 1
	
	NoBallistaEquipped:
	lsl   r5, r5, #0x1
	add   r5, #0x1E
	add   r6, r6, r5
	ldrh  r5, [r6, #0x0]
	mov   r0, r5
	
	GotAnItem:
	mov   r1, r4
	add   r1, #0x4E
	strh  r0, [r1, #0x0]
	blh   0x08017518   @GetItemDescId
	add   r4, #0x4C
	strh  r0, [r4, #0x0]
	pop   {r4-r6}
	pop   {r0}
	bx    r0

.align
.ltorg



ItemMenuRtextLooper:
	push  {r4-r6,lr}
	mov   r4, r0
	ldr   r5, =StatScreenStruct
	ldr   r0, [r5, #0xC] @unit

	mov   r6, #0x0
	ldr   r0, [r0, #0xC] @unit state
	mov   r1, #0x80        
	lsl   r1, r1, #0x4		@Check "in ballista" bit
	and   r0, r1
	cmp   r0, #0x0
	beq   NotRidingBallista
		
		@get a non-empty ballista at unit position
		ldr   r6, [r5, #0xC] @unit
		mov   r0, #0x10
		mov   r1, #0x11
		ldsb  r0, [r6, r0]
		ldsb  r1, [r6, r1]
		blh   #0x803798C 		@GetBallistaItemAt
		mov   r6, r0
		cmp   r6, #0x0
		bne   DoNavigation

	NotRidingBallista:
	ldr   r0, [r5, #0xC] @unit
	ldrh  r0, [r0, #0x1E]
	cmp   r0, #0x0
	bne   DoNavigation
		mov   r0, r4
		blh   LeftFunc
	
DoNavigation:
	ldr   r1, [r5, #0xC] 
	ldr   r0, [r4, #0x2C]
	ldrh  r0, [r0, #0x12]
	cmp   r6, #0x0
	beq   GetItemAtSlot
		sub   r0, #0x1

GetItemAtSlot:
	lsl   r0, r0, #0x1
	add   r1, #0x1E
	add   r1, r1, r0
	ldrh  r0, [r1, #0x0]
	cmp   r0, #0x0
	bne   ExitLooper
		mov   r0, r4
		add   r0, #0x50
		ldrh  r0, [r0, #0x0]
		cmp   r0, #0x0
		beq   NotGoingDown
			cmp   r0, #0x10
			beq   NotGoingDown
				cmp   r0, #0x40
				bne   CheckIfGoingDown
		NotGoingDown:
			mov   r0, r4
			blh   UpFunc
			b     ExitLooper
	CheckIfGoingDown:
		cmp   r0, #0x80
		bne   ExitLooper
			mov   r0, r4
			blh   DownFunc
ExitLooper:
	pop   {r4-r6}
	pop   {r0}
	bx    r0
	
.align
.ltorg
