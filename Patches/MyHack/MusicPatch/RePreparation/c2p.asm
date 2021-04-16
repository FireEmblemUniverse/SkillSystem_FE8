@thumb
	push {lr}
	ldr  r0, =$0202BCEC
	ldrb r0, [r0, #14]
	ldr  r1, =$08034520
	mov  lr, r1
	@dcw $F800
	add  r0, #0x72
	ldrh r0, [r0]
;mov	r0, #52
	ldr  r1, =$08002570
	mov  lr, r1
	@dcw $F800
	pop {pc}