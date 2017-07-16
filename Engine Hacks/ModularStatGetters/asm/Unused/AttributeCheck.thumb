.thumb

.equ MaskToCheck, EALiterals+0x00

AttributeCheck:
	ldr r0, [r1]
	ldr r1, [r1, #4]
	
	ldr r0, [r0, #0x28]
	ldr r1, [r1, #0x28]
	
	orr r0, r1
	
	ldr r1, MaskToCheck
	
	and r0, r1
	
	cmp r0, #0
	beq End
	
	mov r0, #1

End:
	bx lr

.ltorg
.align

EALiterals:
	@ WORD attribute mask to check for
