
	.thumb

	.include "Definitions.inc"

	pExtraItemOrSkill = 0x0202BCDE
	pBWLTable         = 0x0203E884

	lpCharSkillTable  = EALiterals+0x00
	lpClassSkillTable = EALiterals+0x04

GetSkillIdByIndex:
	@ Arguments: r0 = Unit Struct, r1 = Index
	@ Returns:   r0 = Skill Id (0 if none)

	push {r4, lr}

	cmp r1, #0
	bne not_char_skill

	ldr  r2, [r0]
	ldrb r2, [r2, #4]

	ldr  r3, lpCharSkillTable
	ldrb r0, [r3, r2]

	b end

not_char_skill:
	cmp r1, #1
	bne not_class_skill

	ldr  r2, [r0, #4]
	ldrb r2, [r2, #4]

	ldr  r3, lpClassSkillTable
	ldrb r0, [r3, r2]

	b end

not_class_skill:
	cmp r1, #6
	bne not_extra_learn_skill

	ldr  r2, =pExtraItemOrSkill
	ldrb r0, [r2]

	b end

not_extra_learn_skill:
	sub r1, #2
	blt return_zero

	cmp r1, #4
	bge return_zero

	@ r2 = Char Id
	ldr  r2, [r0]
	ldrb r2, [r2, #4]

	@ if CharID > 0x46 then return 0
	cmp r2, #0x46
	bhi return_zero

	lsl  r2, #4

	ldr  r3, =pBWLTable
	add  r3, r2
	add  r3, #1
	ldrb r0, [r3, r1]

	b end

return_zero:
	mov r0, #0

end:
	pop {r4}

	pop {r1}
	bx r1

	.pool
	.align

EALiterals:
	@ POIN CharacterSkillTable
	@ POIN ClassSkillTable
