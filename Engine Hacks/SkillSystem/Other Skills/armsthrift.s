.thumb

GetItemAfterUse = 0x08016AEC+1
RollBattleRN    = 0x0802A52C+1
_ReturnLocation = 0x0802B828+1

LUnitHasSkill      = EALiterals+0x00
LArmsthriftSkillID = EALiterals+0x04

@ Hook from 0802B7F8
ArmsthriftHook:
	@ r0 is Current Round Data (first word)
	@ r5 is Attacker
	@ Nothing needs to be saved (we branch back to the function epilogue)

	mov r1, #2   @ Miss flag

	tst r0, r1  @ <void> = CurrentRound & 2
	beq NonMiss @ goto NonMiss if zero (Miss flag is not set)

	ldr r1, [r5, #0x4C]    @ BattleUnit.weaponAttributes
	mov r2, #(0x02 | 0x80) @ IA_MAGIC | IA_UNCOUNTERABLE

	tst r1, r2 @ <void> = BattleUnit.weaponAttributes & (IA_MAGIC | IA_UNCOUNTERABLE)
	beq End    @ goto End if zero (weapon is neither magic or uncounterable)

NonMiss:
	@ ACTUAL ARMSTHRIFT CHECK BEGIN

	mov r0, r5                 @ arg r0 = (Battle) Unit
	ldr r1, LArmsthriftSkillID @ arg r1 = Skill Index

	ldr r3, LUnitHasSkill
	bl BXR3

	cmp r0, #0        @ compare result
	beq NonArmsthrift @ goto NonArmsthrift if zero (unit doesn't have armsthrift)

	@ Getting Armsthrift proc chance (=luck)
	ldrb r0, [r5, #0x19] @ BattleUnit.luck
@	lsl  r0, #1          @ multiply by 2

	@ ROLL
	ldr r3, =RollBattleRN
	bl BXR3

	cmp r0, #0 @ compare result
	bne End    @ goto End if non-zero (Armsthrift proc)

NonArmsthrift:
	@ ACTUAL ARMSTHRIFT CHECK END

	mov  r4, #0x48 @ offsetof(BattleUnit.weaponAfter)

	ldrh r0, [r5, r4] @ Load weapon

	ldr r3, =GetItemAfterUse
	bl BXR3

	strh r0, [r5, r4] @ Store used weapon

	cmp r0, #0 @ Compare weapon
	bne End    @ goto End if weapon != 0

	mov  r1, #0x7D @ BattleUnit.weaponBroke
	mov  r0, #1

	strb r0, [r5, r1] @ BattleUnit.weaponBroke = true

End:
	ldr r3, =_ReturnLocation
BXR3:
	bx  r3

.ltorg
.align

EALiterals:
	@ POIN SkillTester|1
	@ WORD ArmsthriftID
