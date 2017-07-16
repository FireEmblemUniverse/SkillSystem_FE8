.thumb

StatScreenGetterWrapper:
	push {r4, lr}
	
	ldr r0, [r5, #0xC]
	mov r4, r0
	
	bl MovGetter
	
	cmp r0, #0
	bne NonZeroMov
	
	mov r0, #1
	neg r0, r0
	
	mov r3, r0
	
	b End
	
NonZeroMov:
	ldr r3, [r4, #0x4]
	
	mov r1, #0x12
	ldsb r3, [r3, r1]
	
End:
	pop {r4}
	pop {r1}
	bx r1

.ltorg
.align

MovGetter:
