.thumb
.include "_Definitions.h.s"

.set prUnit_CanStandOnPosition, EALiterals+0x00

@ Arguments: r0 = Target Unit Struct, r1 = Direction X, r2 = Direction Y
@ Returns: Position Offset Pair
GetSmiteTargetOffset:
	push {r4-r6, lr}
	
	@ Moving direction coordinates for later use
	mov r4, r1
	mov r5, r2
	
	mov r6, r0
	
	@ Getting target X
	ldrb r1, [r0, #0x10]
	add r1, r4
	
	@ Getting target Y
	ldrb r2, [r0, #0x11]
	add r2, r5
	
	@ Checking position
	ldr r3, prUnit_CanStandOnPosition
	_blr r3
	
	@ Return pair(0, 0) = int(0) if cannot stand
	cmp r0, #0
	beq End
	
	@ Getting target X
	ldrb r1, [r6, #0x10]

	lsl r3, r4, #1
	add r1, r3
	
	@ Getting target Y
	ldrb r2, [r6, #0x11]
	
	lsl r3, r5, #1
	add r2, r3
	
	@ Checking position
	ldr r3, prUnit_CanStandOnPosition
	_blr r3
	
	@ Return pair(0, 0) = int(0) if cannot stand
	cmp r0, #0
	beq ReturnDirection
	
	add r4, r4
	add r5, r5
	
ReturnDirection:
	_MakePair r0, r4, r5
	
End:
	pop {r4-r6}
	
	pop {r1}
	bx r1

.ltorg
.align

EALiterals:
	@ POIN prUnit_CanStandOnPosition
