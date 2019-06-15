
	.thumb

	.include "Definitions.inc"

	pExtraItemOrSkill = 0x0202BCDE

	lprCallSkillForgetMenu = EALiterals+0x00

CheckForSkillForgetting:
	@ Arguments: r0 = Unit, r1 = Parent proc
	@ Returns:   r0 = 0 on success (aka a skill is to be learned)

	push {r4, lr}

	ldr  r3, =pExtraItemOrSkill
	ldrh r3, [r3]

	lsr r3, #15
	beq no_new_skill @ last bit not set

	@ implied @ arg r0 = Unit
	@ implied @ arg r1 = Parent proc

	ldr  r3, lprCallSkillForgetMenu
	_blr r3

	mov r0, #0
	b end

no_new_skill:
	mov r0, #1

end:
	pop {r4}

	pop {r1}
	bx r1

	.pool
	.align

EALiterals:
	@ POIN prCallSkillForgetMenu

