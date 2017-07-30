.thumb

@ Arguments: r0 = Item Short, r1 = Unit Struct
GetMinRange:
	push {lr}
	
	ldr r3, =#0x0801766C @ Vanilla Min Range Getter (for Item only)
	
	mov lr, r3
	.short 0xF800
	
	pop {r1}
	bx r1

.ltorg
.align

EALiterals:
	@ notin
