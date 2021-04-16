.thumb

@hook at 892d4, allows you to use flag 0xFFFD to return boxtype 4

ldr r0, =0xFFFE
cmp r4, r0
bne CheckForSupportData
	mov r0, #0x3
	b ExitFunc

CheckForSupportData:
ldr r0, =0xFFFD
cmp r4, r0
bne CheckForItemData
	mov r0, #0x4
	ExitFunc:
	ldr r1, =0x0808931B
	bx r1
	
CheckForItemData:
ldr r1, =0x080892E5
bx r1

.ltorg
.align
