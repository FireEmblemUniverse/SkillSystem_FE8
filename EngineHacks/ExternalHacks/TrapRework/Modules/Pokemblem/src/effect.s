.thumb

.set Return, (0x08037668+1)

.set GetTriggeredTrapType, (0x080375E8+1)

Start:
	@ REPLACED (08037660)
	push {r4-r6, lr}
	mov r6, r0
	mov r5, r1
	mov r4, r2

	@ CONTINUED
	mov r0, r5
	ldr r3, =#GetTriggeredTrapType
	bl BXR3
	
	ldr r3, EAL_TRAPINDEX
	cmp r0, r3
	beq HandleMySuperTrap

	@ Dirty but idc
	ldr r3, =#Return
BXR3:
	bx  r3

HandleMySuperTrap:
	mov r0, r6
	mov r1, r5
	mov r2, r4
	
	bl HandleTrap
	
End:
	mov r0, #0
	pop {r4-r6}
	pop {r1}
	bx r1

.ltorg
.align

EAL_TRAPINDEX:
	@ WORD trap id
