
	.thumb

	lClassLevelUpTable = EALiterals+0x00
	lCharLevelUpTable  = EALiterals+0x04

	PROMOTION_LEVEL_MAX = 20

GetUnitLevelSkills:
	@ Arguments: r0 = Unit, r1 = level, r2 = output buffer
	@ Returns:   r0 = output buffer (for convenience)

	@ Given a Unit (or Battle Unit) and a level, gets what skills that unit would learn at the given level.
	@ Skills are stored in a null-termnated list of address given in r2.

	@ Used for both Skill learning on level up and Skill learning on unit loading.
	@ May be used for Skill learning on promotion later as well.

	@ (Skill learning on level up only cares for the first returned skill, so order is important!).

	@ This is an improvement over the skill system before march 2019, where each cases were handled separately
	@ As it makes it easier to hack in (or out) methods of defining level-up skills.

	@ Note: a level of 0xFF means on-load.

	push {r2, r4-r5} @ save r2 for returning it later

	mov r4, r2 @ var r4 = output

check_char_skill:
	@ Checking char skill list

	ldr r2, [r0, #0x00] @ r2 = unit character
	ldr r3, [r0, #0x04] @ r3 = unit class

	ldr r5, [r2, #0x28] @ r5 = unit character attributes
	ldr r3, [r3, #0x28] @ r3 = unit class attributes

	orr r3, r5 @ r3 = unit cattributes

	lsl r3, #8
	mov r5, #1
	and r5, r3 @ r5 = 1 if promoted else 0

	ldr r3, lCharLevelUpTable

	ldrb r2, [r2, #0x04] @ r2 = unit character id

	lsl  r2, #2
	ldr  r3, [r3, r2] @ r3 = class level up skill list

	cmp r3, #0
	beq end_char_skill @ if no class skill list, then no class skill learned

lop_char_skill:
	ldrb r2, [r3]

	cmp r2, #0
	beq end_char_skill @ level 0 <=> end of list

	cmp r5, #0
	beq char_no_promoted

	@ if char is promoted, check if level is 0xFF (on-load) and if skill is learned before promotion level
	@ this is to allow prepromotes to load skills they would have learned as a non promoted class

	cmp r1, #0xFF
	bne char_promoted_no_init

	cmp r2, #PROMOTION_LEVEL_MAX
	ble yes_char_skill

char_promoted_no_init:
	@ substract promotion level to skill level, so that it matches promoted level instead of absolute level

	sub r2, #PROMOTION_LEVEL_MAX

char_no_promoted:
	cmp r2, r1
	beq yes_char_skill @ levels match

continue_char_skill:
	add r3, #2
	b lop_char_skill

yes_char_skill:
	ldrb r2, [r3, #1] @ get skill id
	strb r2, [r4]     @ add it to the list
	add  r4, #1       @ increment output iterator

	b continue_char_skill

end_char_skill:
check_class_skill:
	@ Checking class skill list

	ldr r3, lClassLevelUpTable

	ldr  r2, [r0, #0x04] @ r2 = unit class
	ldrb r2, [r2, #0x04] @ r2 = unit class id

	lsl  r2, #2
	ldr  r3, [r3, r2] @ r3 = class level up skill list

	cmp r3, #0
	beq end_class_skill @ if no class skill list, then no class skill learned

lop_class_skill:
	ldrb r2, [r3]

	cmp r2, #0
	beq end_class_skill @ level 0 <=> end of list

	cmp r2, r1
	beq yes_class_skill @ levels match

continue_class_skill:
	add r3, #2
	b lop_class_skill

yes_class_skill:
	ldrb r2, [r3, #1] @ get skill id
	strb r2, [r4]     @ add it to the list
	add  r4, #1       @ increment output iterator

	b continue_class_skill

end_class_skill:
	mov  r0, #0 @ terminate list
	strb r0, [r4]

	pop {r0, r4-r5} @ return output buffer in r0
	bx lr

	.pool
	.align

EALiterals:
	@ POIN ClassLevelUpTable
	@ POIN CharLevelUpTable
