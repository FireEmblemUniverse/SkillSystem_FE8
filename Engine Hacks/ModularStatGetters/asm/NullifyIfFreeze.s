.thumb

NullifyIfGuardAI:
	mov r2, #0x30 @ status
	ldrb r1, [r1, r2]
	
	mov r2, #0xF
	and r1, r2
	
	cmp r1, #9
	bne End
	
	mov r0, #0
	
End:
	bx lr

.ltorg
.align

EALiterals:
	@ none
