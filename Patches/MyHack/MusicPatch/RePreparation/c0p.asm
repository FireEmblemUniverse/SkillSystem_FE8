@thumb
	push {lr, r4, r5, r6}
	mov  r4, r1
	mov  r5, r2
	mov  r6, r3
	
	ldr  r0, =$0202BCEC
	ldrb r0, [r0, #14]
	ldr  r1, =$08034520
	mov  lr, r1
	@dcw $F800
	add  r0, #0x72
	ldrh r0, [r0]
;mov	r0, #52
	ldr  r1, =$08002938
	mov  lr, r1
	mov  r1, r4
	mov  r2, r5
	mov  r3, r6
	@dcw $F800
	pop {pc, r4, r5, r6}