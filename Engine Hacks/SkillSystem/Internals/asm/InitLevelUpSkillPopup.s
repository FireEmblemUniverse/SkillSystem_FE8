
	.thumb

	gBattleActor  = 0x0203A4EC
	gBattleTarget = 0x0203A56C
	gPopupItem    = 0x030005F4

	lGetUnitLevelSkills = EALiterals+0x00
	lAddSkill           = EALiterals+0x04

InitLevelUpSkillPopup:
	@ We are going to do learning and showing popups at the same time even if this is probably a turbo bad idea

	push {lr}

	@ Check acting battle unit

	ldr r0, =gBattleActor
	bl TryLearnSkill

	cmp r0, #0
	bne yes

	@ Check target battle unit

	ldr r0, =gBattleTarget
	bl TryLearnSkill

	cmp r0, #0
	bne yes

no:
	mov r0, #0
	b end

yes:
	ldr  r1, =gPopupItem
	strh r0, [r1]

	mov r0, #1

end:
	pop {r3}
BXR3:
	bx r3

	.pool
	.align

TryLearnSkill:
	@ Arguments: r0 = Battle Unit
	@ Returns:   r0 = Skill Id Learned (0 if none)

	push {r4, lr}

	ldrb r2, [r0, #0x08] @ r1 = battle unit level

	mov  r1, #0x70
	ldrb r1, [r0, r1] @ r2 = battle unit initial level

	cmp r1, r2
	beq TryLearnSkill.no_skill @ if level didn't change, no new skill

	mov r4, r0 @ var r4 = bu

	sub sp, #8 @ allocate buffer

	ldr r3, lGetUnitLevelSkills
	mov ip, r3

	@ implied  @ arg r0 = (battle) unit
	@ implied  @ arg r1 = level from
	@ implied  @ arg r2 = level to
	mov r3, sp @ arg r3 = output buffer

	bl BXIP

	@ implied  @ ret r0 = output buffer

	ldrb r0, [r0] @ get first skill in output buffer

	add sp, #8 @ free buffer

	cmp r0, #0
	beq TryLearnSkill.end @ Do not learn anything if list was empty

	ldr r3, lAddSkill

	mov r1, r0 @ arg r1 = skill id
	mov r0, r4 @ arg r0 = unit

	mov r4, r1 @ var r4 = skill id

	bl  BXR3

	cmp r0, #0
	beq TryLearnSkill.no_skill

	@ return skill id
	mov r0, r4

	b TryLearnSkill.end

TryLearnSkill.no_skill:
	@ return 0
	mov r0, #0

TryLearnSkill.end:
	pop {r4}

	pop {r1}
	bx r1

BXIP:
	bx ip

	.pool
	.align

EALiterals:
	@ POIN (GetUnitLevelSkills|1)
	@ POIN (AddSkill|1)
