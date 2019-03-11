
	.thumb

	lGetUnitLevelSkills = EALiterals+0x00
	lAddSkill           = EALiterals+0x04

AutoloadSkills:
	@ Arguments: r0 = Unit
	@ Returns:   r0 = Unit (because I can)

	push {r0-r1, r4-r5, lr} @ note: allocated 8 bytes on the stack by pushing r0-r1

	mov r4, r0 @ var r4 = unit

	ldr r3, lGetUnitLevelSkills

	@ implied     @ arg r0 = Unit
	mov r1, #0xFF @ arg r1 = level (0xFF means on-load)
	mov r2, sp    @ arg r2 = output buffer

	bl BXR3

	@ implied     @ ret r0 = output buffer

	mov r1, r0 @ arg r1 = skill list
	mov r0, r4 @ arg r0 = unit

	bl AddSkills

	mov r5, #0 @ var r5 = i = 0

AutoloadSkills.lop:
	add r5, #1 @ i++

	ldr r3, lGetUnitLevelSkills

	@ implied  @ arg r0 = unit
	mov r1, r5 @ arg r1 = level
	mov r2, sp @ arg r2 = output buffer

	bl BXR3

	@ implied  @ ret r0 = output buffer

	mov r1, r0 @ arg r1 = skill list
	mov r0, r4 @ arg r0 = unit

	bl AddSkills

	@ implied  @ ret r0 = unit

	ldrb r1, [r0, #8] @ r1 = unit->level

	cmp r1, r5
	bgt AutoloadSkills.lop @ continue until we reached unit's current level

	pop {r1-r2, r4-r5} @ note: freed 8 bytes from the stack by popping into r1-r2

	pop {r1}
	bx r1

AddSkills:
	@ Arguments: r0 = Unit, r1 = null terminated skill list
	@ Returns:   r0 = Unit (because I can)

	push {r0, r4, lr} @ note: [sp] = Unit

	mov r4, r1 @ var r4 = skill list iterator

AddSkills.lop:
	ldrb r1, [r4]

	cmp r1, #0
	beq AddSkills.end @ end if reached list end

	ldr r3, lAddSkill

	ldr r0, [sp] @ arg r0 = unit
	@ implied    @ arg r1 = skill id

	bl BXR3

	add r4, #1

	b AddSkills.lop

AddSkills.end:
	pop {r0, r4} @ note: r0 = Unit

	pop {r3}
BXR3:
	bx r3

EALiterals:
	@ POIN (GetUnitLevelSkills|1)
	@ POIN (AddSkill|1)
