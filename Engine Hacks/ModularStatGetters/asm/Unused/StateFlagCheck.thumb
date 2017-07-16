.thumb

.equ MaskToCheck, EALiterals+0x00

StateFlagCheck:
	ldr r0, [r1, #0xC]
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
	@ WORD state mask to check for
