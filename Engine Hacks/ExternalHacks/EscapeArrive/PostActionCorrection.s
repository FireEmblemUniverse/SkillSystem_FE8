.thumb
.align

@ This has been incorporated into the Post-Action calc loop.
@ r0 = character struct.
mov r3, r0
ldr r0,=#0x2040000
mov r2,r0
ldrb r0,[r0]
mov r1,#0x4
tst r0,r1
beq End
	bic r0,r1
	strb r0,[r2]
	
	ldr	r1,[r3,#0xC]
	mov	r2,#1
	orr	r1,r2
	mov r2,#0x8
	orr r1,r2
	str	r1,[r3,#0xC]
	
	
End:
bx lr
