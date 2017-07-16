.thumb

CheckGuardAI:
	mov r2, #0x41 @ AI4
	ldrb r1, [r1, r2]
	
	mov r2, #0x20 @ Guard I guess
	
	mov r0, #0 @ False by default
	
	tst r1, r2
	beq End
	
	mov r0, #1
	
End:
	bx lr

.ltorg
.align

EALiterals:
	@ none
