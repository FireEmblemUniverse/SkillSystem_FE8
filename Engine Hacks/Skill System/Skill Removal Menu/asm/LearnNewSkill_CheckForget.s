
	.thumb

	.include "Definitions.inc"

	lprCheckForSkillForgetting = EALiterals+0x00

LearnNewSkill_CheckForget:
	mov r1, r0
	ldr r0, [r1, #0x2C] @ field 2C is Unit

	ldr r3, lprCheckForSkillForgetting
	bx  r3

	.pool
	.align

EALiterals:
	@ POIN prCheckForSkillForgetting
