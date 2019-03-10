
	.thumb

	gBattleActor  = 0x0203A4EC
	gBattleTarget = 0x0203A56C
	gPopupItem    = 0x030005F4

	lBattleUnitLearnLevelSkill = EALiterals+0x00

InitLevelUpSkillPopup:
	@ We are going to do learning and showing popups at the same time even if this is probably a turbo bad idea

	push {lr}

	@ Check acting battle unit

	ldr r3, lBattleUnitLearnLevelSkill

	ldr r0, =gBattleActor

	bl BXR3

	cmp r0, #0
	bne yes

	@ Check target battle unit

	ldr r3, lBattleUnitLearnLevelSkill

	ldr r0, =gBattleTarget

	bl BXR3

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

EALiterals:
	@ POIN (BattleUnitLearnLevelSkill|1)
