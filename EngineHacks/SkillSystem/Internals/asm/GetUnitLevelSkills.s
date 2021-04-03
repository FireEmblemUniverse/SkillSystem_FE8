
	.thumb

	.equ ChapterData, 0x202BCF0

	lClassLevelUpTable = EALiterals+0x00
	lCharLevelUpTable  = EALiterals+0x04

	PROMOTION_LEVEL_MAX = 20

GetUnitLevelSkills:
	@ Arguments: r0 = Unit, r1 = level from, r2 = level to, r3 = output buffer
	@ Returns:   r0 = output buffer (for convenience)

	@ Given a Unit (or Battle Unit) and a level range, gets what skills that unit would learn within that range.
	@ Skills are stored in a null-termnated list of address given in r3.

	@ Used for, Skill learning on level, Skill learning on unit loading, and Skill learning on promotion.

	@ Skill learning on unit loading gives ranges [0xFE, 0xFF] and [0, level], and cares for all returned skills.
	@ Skill learning on level up gives range [old level, new level] and only cares for the first returned skill.
	@ Skill learning on promotion gives range [0, 1] and only cares for the first returned skill.

	@ This is an improvement over the skill system before march 2019, where each cases were handled separately
	@ As it makes it easier to hack in (or out) methods of defining level-up skills.

	push {r3, r4-r7} @ save r3 for returning it later

	push {r1, r2}
	mov r7, r0 @ var r7 = unit
	mov r6, r3 @ var r6 = output

check_char_skill:
	@ Checking char skill list

	ldr r3, [r7, #0x00] @ r3 = unit character
	ldr r4, [r7, #0x04] @ r4 = unit class

	ldr r5, [r3, #0x28] @ r5 = unit character attributes
	ldr r4, [r4, #0x28] @ r4 = unit class attributes

	orr r4, r5 @ r4 = unit cattributes


	mov r5, #1
	lsl r5, #8
	and r5, r4 @ var r5 = 1 if promoted else 0

	ldr r4, lCharLevelUpTable

	ldrb r3, [r3, #0x04] @ r3 = unit character id

	lsl  r3, #2
	ldr  r4, [r4, r3] @ var r4 = class level up skill list it

	cmp r4, #0
	beq end_char_skill @ if no class skill list, then no class skill learned

lop_char_skill:
	ldrb r3, [r4]

	cmp r3, #0
	beq end_char_skill @ level 0 <=> end of list

	cmp r5, #0
	beq char_no_promoted

	@ if char is promoted, check if level is 0xFF (on-load) and if skill is learned before promotion level
	@ this is to allow prepromotes to load skills they would have learned as a non promoted class

	cmp r1, #0xFF
	bne char_promoted_no_init


	cmp r3, #PROMOTION_LEVEL_MAX
	ble yes_char_skill


char_promoted_no_init:
	@ substract promotion level to skill level, so that it matches promoted level instead of absolute level

	sub r3, #PROMOTION_LEVEL_MAX

char_no_promoted:
	cmp r3, r1
	ble continue_char_skill

	cmp r3, r2
	ble yes_char_skill @ level is between from (excluded) and to (included)
	

continue_char_skill:
	add r4, #2
	b lop_char_skill

yes_char_skill:
	ldrb r3, [r4, #1] @ get skill id
	strb r3, [r6]     @ add it to the list
	add  r6, #1       @ increment output iterator

	b continue_char_skill

end_char_skill:
check_class_skill:
	@ Checking class skill list

	ldr r4, lClassLevelUpTable

	ldr  r3, [r7, #0x04] @ r3 = unit class
	ldrb r3, [r3, #0x04] @ r3 = unit class id

	lsl  r3, #2
	ldr  r4, [r4, r3] @ r4 = class level up skill list

	cmp r4, #0
	beq end_class_skill @ if no class skill list, then no class skill learned

lop_class_skill:
	ldrb r3, [r4]
	
	cmp r2,#0xFF @if getting initial skill list, this is true
	beq DontStripAllegiance
	
	mov r0, #0x1F @use last 5 bits for level, (0-31)
	and r3, r3, r0
	
	
	DontStripAllegiance:
	cmp r3, #0
	beq end_class_skill @ level 0 <=> end of list

	pop {r1, r2}
	push {r1, r2}

	cmp r3, r1
	ble continue_class_skill

	cmp r3, r2
	ble yes_class_skill @ level is between from (excluded) and to (included)

continue_class_skill:
	add r4, #2
	b lop_class_skill

yes_class_skill:
	ldrb r3, [r4]
	
	cmp r2,#0xFF
	beq write_class_skill
	
	lsr r3, r3, #5 @first 3 digits as options

	cmp r3, #0     @0, vanilla behavior
	beq write_class_skill

	ldrb r0, [r7, #0xB] @allegiance
	lsr r0, #0x6 @ top two bits are used for allegiance (0x00 for player, 0x40 for NPC, 0x80 for enemy)
	cmp r0, #0x0
	bne enemy_check

	cmp r3, #1     @1, player only
	beq write_class_skill

	b continue_class_skill

@includes green units
enemy_check:
	cmp r3, #2     @2, enemy only
	beq write_class_skill

	cmp r3, #3     @3, normal & hard mode only
	bne hard_mode_check

	ldr r0, =ChapterData
	mov r1, #0x42
	ldrb r1, [r0, r1]

	mov r2, #0x20 @ Set if not easy mode
	tst r1, r2
	bne write_class_skill

	b continue_class_skill
	
hard_mode_check:
	cmp r3, #4     @4, hard mode only
	bne custom_check

	ldr r0, =ChapterData
	mov r1, #0x14
	ldrb r1, [r0, r1]

	mov r2, #0x40 @ not easy mode
	tst r1, r2
	bne write_class_skill

	b continue_class_skill

custom_check:
	@ add custom checks for 5,6,7
	b continue_class_skill

write_class_skill:
	ldrb r3, [r4, #1] @ get skill id
	strb r3, [r6]     @ add it to the list
	add  r6, #1       @ increment output iterator

	b continue_class_skill

end_class_skill:
	mov  r0, #0 @ terminate list
	strb r0, [r6]

	pop {r1, r2}
	pop {r0, r4-r7} @ return output buffer in r0
	bx lr

	.pool
	.align

EALiterals:
	@ POIN ClassLevelUpTable
	@ POIN CharLevelUpTable
