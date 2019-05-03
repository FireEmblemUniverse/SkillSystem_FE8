
	.thumb

	gpBeforeBattleUnit = 0x0203E18C @ unused, but here for reference
	gpAfterBattleUnit  = 0x0203E188 @ this is the one we are looking at

	gPopupItem         = 0x030005F4

	lGetUnitLevelSkills = EALiterals+0x00
	lAddSkill           = EALiterals+0x04

InitPromotionSkillPopup:
	@ We are going to do learning and showing popups at the same time even if this is probably a turbo bad idea

	push {lr}

	ldr r0, =gpAfterBattleUnit
	ldr r0, [r0]

	bl TryLearnSkill

	cmp r0, #0
	beq end

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
	@ Arguments: r0 = (Battle) Unit
	@ Returns:   r0 = Skill Id Learned (0 if none)

	push {r0-r1, r4, lr} @ note: pushing r0-r1 allocated 8 bytes on the stack

	mov r4, r0 @ var r4 = bu

	ldr r3, lGetUnitLevelSkills
	mov ip, r3

	@ implied  @ arg r0 = (battle) unit
	mov r1, #0 @ arg r1 = level from
	mov r2, #1 @ arg r2 = level to
	mov r3, sp @ arg r3 = output buffer

	bl BXIP

	@ implied  @ ret r0 = output buffer

	ldrb r0, [r0] @ get first skill in output buffer

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
	pop {r1-r2, r4} @ note: popping r1-r2 freed 8 bytes on the stack

	pop {r1}
	bx r1

BXIP:
	bx ip

	.pool
	.align

EALiterals:
	@ POIN (GetUnitLevelSkills|1)
	@ POIN (AddSkill|1)
