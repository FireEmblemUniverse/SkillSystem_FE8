.thumb
.include "_Definitions.h.s"

Command_Usability:
	push {lr}
	
	ldr r0, =ppActiveUnit
	ldr r0, [r0]
	
	ldr r3, EALiterals
	_blr r3
	
	cmp r0, #0
	beq Unusable
	
	mov r0, #1
	b End
	
Unusable:
	mov r0, #3
	
End:
	pop {r1}
	bx r1

.ltorg
.align

EALiterals:
	@ POIN prGetSkillIdByIndex
