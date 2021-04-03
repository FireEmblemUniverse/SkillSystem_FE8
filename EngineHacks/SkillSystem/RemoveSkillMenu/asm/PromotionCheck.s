
	.thumb

	.include "Definitions.inc"

	lCheckForSkillForgetting = EALiterals+0x00

PromotionCheck:
	push {r4, lr}

	mov r4, r0

	ldr r0, [r4, #0x14] @ get parent
	ldr r0, [r0, #0x14] @ get parent's parent (welcome to promotion procs)
	ldr r0, [r0, #0x38] @ get unit

	@ implied  @ arg r0 = unit
	mov r1, r4 @ arg r1 = parent proc

	ldr  r3, lCheckForSkillForgetting
	_blr r3

	pop {r4}

	pop {r1}
	bx r1

	.pool
	.align

EALiterals:
	@ POIN (CheckForSkillForgetting|1)
