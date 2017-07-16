.thumb

.equ RoutineArrayPtr, EALiterals+0x00

@ call from whatever stat getter
CoreLoop:
	push {r4-r6, lr}
	
	mov r4, r0
	mov r5, r1

	ldr r6, RoutineArrayPtr
	
	mov r0, #0 @ stat starts at 0
	
StartLoop:
	ldmia r6!, {r3}
	
	cmp r3, #0
	beq Finish
	
	mov r1, #1
	eor r3, r1 @ reverse the last bit, so that it assumes thumb by default
	
	@ r0 is already current stat value
	mov r1, r4 @ r1 = param 0
	mov r2, r5 @ r2 = param 1
	
	@ call modifier routine
	mov lr, r3
	.short 0xF800
	
	b StartLoop
	
Finish:
	@ Check if greater or equal to zero
	cmp r0, #0
	bge End
	
	mov r0, #0

End:	
	pop {r4-r6}
	pop {r1}
	bx r1

.ltorg
.align

EALiterals:
	@ POIN to null terminated routine pointer array
