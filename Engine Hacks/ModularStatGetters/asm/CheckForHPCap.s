.thumb

.macro blh to, reg=r3
	ldr \reg, =\to
	mov lr, \reg
	.short 0xF800
.endm

CheckForHPCap:
	push {r4-r5, lr}
	
	mov r4, r0
	mov r5, r1
	
	mov r0, r1
	
	blh 0x08019190 @ Max HP Getter
	
	cmp r4, r0
	bgt CapReached
	
	mov r0, r4
	
	b End

CapReached:
	strb r0, [r5, #0x13] @ Storing capped HP as current HP

End:
	pop {r4-r5}
	pop {r1}
	bx r1

.ltorg
.align

EALiterals:
	@ none
