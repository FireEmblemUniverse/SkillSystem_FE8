.thumb

.equ ParentCheck, EALiterals+0x00

NotCheck:
	push {r4, lr}
	
	@ Calling parent check
	ldr r4, ParentCheck
	mov lr, r4
	.short 0xF800
	
	@ r0 = (!r0) = (r0 ^ 0x1)
	mov r1, #1
	eor r0, r1
	
End:
	pop {r4}
	pop {r1}
	bx r1

.ltorg
.align

EALiterals:
	@ WORD attribute mask to check for
