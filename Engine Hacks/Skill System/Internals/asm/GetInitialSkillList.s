
	.thumb

	lGetUnitLevelSkills = EALiterals+0x00

GetInitialSkillList:
	@ Arguments: r0 = Unit, r1 = output buffer (0x10 bytes seems reasonable)
	@ Returns:   r0 = output buffer (for convenience)

	push {r1, r4-r6, lr} @ note: [sp] = output buffer

	mov r4, r0 @ var r4 = unit
	mov r6, r1 @ var r6 = output buffer

	ldr r3, lGetUnitLevelSkills

	@ implied     @ arg r0 = Unit
	mov r1, #0xFF @ arg r1 = level (0xFF means on-load)
	mov r2, r6    @ arg r2 = output buffer

	bl BXR3

	@ Advance buffer until we reach the current terminator

AutoloadSkills.lop_adv_buf:
	ldrb r0, [r6]

	cmp r0, #0
	beq AutoloadSkills.end_adv_buf

	add r6, #1
	b AutoloadSkills.lop_adv_buf

AutoloadSkills.end_adv_buf:
	mov r5, #0 @ var r5 = i = 0

	sub sp, #8 @ room for temp buf

AutoloadSkills.lop:
	add r5, #1 @ i++

	ldr r3, lGetUnitLevelSkills

	mov r0, r4 @ arg r0 = unit
	mov r1, r5 @ arg r1 = level
	mov r2, sp @ arg r2 = output buffer

	bl BXR3

	@ implied  @ ret r0 = output buffer

	ldrb r0, [r0]

	cmp r0, #0
	beq AutoloadSkills.continue @ do not add in skill is null (obv)

	@ check if skill already in list

	ldr r1, [sp, #8] @ r1 = output buffer

AutoloadSkills.check_lop:
	cmp r1, r6
	beq AutoloadSkills.check_end @ no in list, add

	ldrb r2, [r1]

	cmp r2, r0
	beq AutoloadSkills.continue @ yes in list, do not add

	add r1, #1
	b AutoloadSkills.check_lop

AutoloadSkills.check_end:
	strb r0, [r6]
	add  r6, #1

AutoloadSkills.continue:
	ldrb r1, [r4, #8] @ r1 = unit->level

	cmp r1, r5
	bgt AutoloadSkills.lop @ continue until we reached unit's current level

	add sp, #8

	@ terminate list
	mov  r0, #0
	strb r0, [r6]

	pop {r0, r4-r6} @ note: r0 = output buffer

	pop {r3}
BXR3:
	bx r3

	.pool
	.align

EALiterals:
	@ POIN (GetUnitLevelSkills|1)
