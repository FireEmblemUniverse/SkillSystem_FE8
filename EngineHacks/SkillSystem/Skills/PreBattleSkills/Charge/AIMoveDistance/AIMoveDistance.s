.thumb

	gActionData = 0x203A958
	gActiveUnit = 0x3004E50
	gChapterData = 0x202BCF0

	.global AIMoveDistance
	.type   AIMoveDistance, function

	.global NewClearAttackFlag
	.type   NewClearAttackFlag, function

AIMoveDistance:
	// r0 - x coord
	// r1 - y coord

	// hook at 39C44

	// new code


	push {r0-r4}

	ldr r2, = gActionData

	// x and y moved to
	strb r0, [r2, #0xE]
	strb r1, [r2, #0xF]

	// total distance

	
	mov r4, #0

	ldr r2, =gActiveUnit
	ldr r2, [r2]
	ldrb r3, [r2, #0x11]
	ldrb r2, [r2, #0x10]

	cmp r0, r2
	beq GetYDistance
	bgt XMovedBackwards
	sub r2, r0
	add r4, r2
	b GetYDistance

	XMovedBackwards:
	sub r0, r2
	add r4, r0

	GetYDistance:
	cmp r1, r3
	beq EndGetDistance
	bgt YMovedBackwards
	sub r3, r1
	add r4, r3
	b EndGetDistance

	YMovedBackwards:
	sub r1, r3
	add r4, r1

	EndGetDistance:
	ldr r2, = gActionData
	strb r4, [r2, #0x10]

	pop {r0-r4}

	// vanilla code

	mov r0, r8
	strb r0, [r4, #0x8]
	mov r0, r9
	strb r0, [r4, #0x9]

	// return

	ldr r1, =#0x8039C4C + 1
	bx r1

	.pool
	.align

NewClearAttackFlag:

	ldr r3, =gChapterData
	@Check if in preps
	ldrb r1, [r3, #0x14]
	mov r2, #0x10
	tst r1, r2
	bne Clear
	@Check if in player phase
	ldrb r3, [r3, #0xF]
	cmp r3, #0
	bne DontClear
	
	Clear:
	strb r5, [r0, #0x10]

	DontClear:

	ldr r0, =0x203f101
	strb r5, [r0]
	ldr r0, =0x202bcb0
	mov r1, r0
	add r1, #0x3d
	ldr r3, =0x8018689
	bx r3

	.pool
	.align
