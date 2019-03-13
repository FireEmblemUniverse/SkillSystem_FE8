
	.thumb

	lClassLevelUpTable = EALiterals+0x00
@	lCharLevelUpTable  = EALiterals+0x04

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

	push {r2, r4} @ save r2 for returning it later

	mov r4, r2 @ var r4 = output

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

	pop {r0, r4} @ return output buffer in r0
	bx lr

	.pool
	.align

EALiterals:
	@ POIN ClassLevelUpTable
	@ // POIN CharLevelUpTable
