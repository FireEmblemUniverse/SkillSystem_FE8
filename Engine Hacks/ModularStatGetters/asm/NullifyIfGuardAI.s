.thumb

NullifyIfGuardAI:
	mov r2, #0x41 @ AI4
	ldrb r1, [r1, r2]
	
	mov r2, #0x20 @ Guard I guess
	
	tst r1, r2
	beq End
	
	mov r0, #0
	
End:
	bx lr

.ltorg
.align

EALiterals:
	@ none
