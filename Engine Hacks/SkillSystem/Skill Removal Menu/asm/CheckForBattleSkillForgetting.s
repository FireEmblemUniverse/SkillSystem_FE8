
	.thumb

	.include "Definitions.inc"

	lprCheckForSkillForgetting = EALiterals+0x00

CheckForBattleSkillForgetting:
	push {r4, lr}

	mov r4, r0 @ var r4 = Battle/Arena proc

check_acting:
	ldr r0, =pBattleUnitInstiagator

	ldrb r1, [r0, #0x13] @ Current HP

	cmp r1, #0
	beq check_target @ Unit is ded

	ldrb r0, [r0, #0x0B] @ Unit Index

	mov r1, #0xC0
	tst r0, r1
	beq yes @ not NPC nor Enemy

check_target:
	ldr r0, =pBattleUnitTarget

	ldrb r1, [r0, #0x13] @ Current HP

	cmp r1, #0
	beq no @ Unit is ded

	ldrb r0, [r0, #0x0B] @ Unit Index

	mov r1, #0xC0
	tst r0, r1
	bne no @ NPC or Enemy

yes:
	_blh prUnit_GetStruct

	mov r1, r4

	ldr  r3, lprCheckForSkillForgetting
	_blr r3

	b end

no:
	mov r0, #1 @ Continue

end:
	pop {r4}

	pop {r1}
	bx r1

	.pool
	.align

EALiterals:
	@ POIN prCheckForSkillForgetting
