.thumb
.include "_Definitions.h.s"

.set EAL_prCheckForSkillForgetting, (EALiterals+0x00)

heho:
	push {lr}
	
	mov r1, r0
	ldr r0, [r1, #0x2C] @ field 2C is Unit
	
	ldr  r3, EAL_prCheckForSkillForgetting
	_blr r3
	
	pop {r1}
	bx r1

.ltorg
.align

EALiterals:
	@ POIN prCheckForSkillForgetting
