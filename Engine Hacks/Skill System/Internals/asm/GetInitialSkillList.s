
	.thumb

	lGetUnitLevelSkills = EALiterals+0x00

GetInitialSkillList:
	@ Arguments: r0 = Unit, r1 = output buffer (0x10 bytes seems reasonable)
	@ Returns:   r0 = output buffer (for convenience)

	push {r1, r4-r5, lr} @ note: [sp] = output buffer

	mov r4, r0 @ var r4 = unit
	mov r5, r1 @ var r5 = output buffer

	ldr r3, lGetUnitLevelSkills
	mov ip, r3

	@ implied     @ arg r0 = Unit
	mov r1, #0xFE @ arg r1 = level from
	mov r2, #0xFF @ arg r2 = level to
	mov r3, r5    @ arg r3 = output buffer

	bl BXIP

	@ Advance buffer until we reach the current terminator

AutoloadSkills.lop_adv_buf:
	ldrb r0, [r5]

	cmp r0, #0
	beq AutoloadSkills.end_adv_buf

	add r5, #1
	b AutoloadSkills.lop_adv_buf

AutoloadSkills.end_adv_buf:
	ldr r3, lGetUnitLevelSkills
	mov ip, r3

	ldrb r2, [r4, #0x8] @ r2 = unit level

	mov r0, r4 @ arg r0 = unit
	mov r1, #0 @ arg r1 = level from (here: 0)
	@ implied  @ arg r2 = level to (here: level)
	mov r3, r5 @ arg r2 = output buffer

	bl BXIP

	pop {r0, r4-r5} @ note: r0 = output buffer

	pop {r3}
BXR3:
	bx r3

BXIP:
	bx ip

	.pool
	.align

EALiterals:
	@ POIN (GetUnitLevelSkills|1)
