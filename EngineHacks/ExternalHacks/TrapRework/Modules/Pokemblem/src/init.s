.thumb

.set AddTrap, (0x0802E2B8+1)
.set Return,  (0x08037900+1)

hi:
	@ r5 is pointer to trap data
	
	ldrb r0, [r5, #1]
	ldrb r1, [r5, #2]
	ldrb r3, [r5, #3]
	
	ldr  r2, EAL_TRAPINDEX
	
	push {r4}
	
	ldr r4, =#AddTrap
	bl BXR4
	
	pop  {r4}
	
	ldr r0, =#Return
	bx  r0

BXR4:
	bx r4

.ltorg
.align

EAL_TRAPINDEX:
	@ WORD trap id
