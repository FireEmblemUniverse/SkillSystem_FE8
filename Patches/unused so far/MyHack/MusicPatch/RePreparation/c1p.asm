@thumb
	
	ldr  r0, =$0202BCEC
	ldrb r0, [r0, #14]
	ldr  r1, =$08034520
	mov  lr, r1
	@dcw $F800
	add  r0, #0x72
	ldrh r0, [r0]
;mov	r0, #52
	ldr  r1, =$08002424
	mov  lr, r1
	mov  r1, #0
	@dcw $F800
	ldr  r0, =$080b692a
	mov  pc, r0