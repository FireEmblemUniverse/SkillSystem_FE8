
	.thumb

	@ This is to allow all skill-learning-on-level-up hooks to reuse the same code
	@ That way, hacking in new ways to learn skills on level up should be simpler.
	@ As this should be the only thing you need to edit.

	lAddSkill          = EALiterals+0x00
	lClassLevelUpTable = EALiterals+0x04
@	lCharLevelUpTable  = EALiterals+0x08

BattleUnitLearnLevelSkill:
	@ Arguments: r0 = Battle Unit
	@ Returns: r0 = Skill Id Learned (0 if none)

	ldrb r1, [r0, #0x08] @ r1 = battle unit level

	mov  r2, #0x70
	ldrb r2, [r0, r2] @ r2 = battle unit initial level

	cmp r1, r2
	beq no_skill @ if level didn't change, no new skill

	@ reminder:
	@ r0 = battle unit
	@ r1 = level

	ldr r2, lClassLevelUpTable

	ldr  r3, [r0, #0x04] @ r3 = unit class
	ldrb r3, [r3, #0x04] @ r3 = unit class id

	lsl  r3, #2
	ldr  r2, [r2, r3] @ r2 = class level up skill list

	cmp r2, #0
	beq no_class_skill @ if no class skill list, then no class skill learned

lop_class_skill:
	ldrb r3, [r2]

	cmp r3, #0
	beq no_class_skill

	cmp r3, r1
	beq yes_class_skill

	add r2, #2
	b lop_class_skill

yes_class_skill:
	@ implied         @ arg r0 = (battle) unit
	ldrb r1, [r2, #1] @ arg r1 = skill id

	@ b learn_skill

learn_skill:
	push {r1, lr} @ push skill id, lr

	ldr r3, lAddSkill
	bl  BXR3

	cmp r0, #0
	beq learn_skill.fail

	@ pop skill id in r0 (= return value)

	pop {r0, r3}
BXR3:
	bx r3

learn_skill.fail:
	pop {r1, r2}
	bx r2

no_class_skill:
no_skill:
	mov r0, #0
	bx lr

	.pool
	.align

EALiterals:
	@ POIN SkillAdder
	@ POIN ClassLevelUpSkillTable
	@ // POIN CharLevelUpSkillTable
