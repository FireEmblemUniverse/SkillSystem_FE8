
	.thumb

	.include "Definitions.inc"

	pExtraItemOrSkill = 0x0202BCDE

	prNewPopup        = 0x08011474|1
	prSetPopupShort   = 0x0801145C|1

	lpPopupDef        = EALiterals+0x00
	lTime             = EALiterals+0x04

CallSkillLearnedPopup:
	@ Arguments: r0 = Parent proc
	@ Returns:   r0 = 0 on success (skill is displayed)

	push {r4, lr}

	@ Save proc for later
	mov r4, r0

	@ Load Skill index short
	ldr  r3, =pExtraItemOrSkill
	ldrh r0, [r3]

	@ Check if zero
	cmp r0, #0
	beq no_popup

	@ Set skill index
	ldrb r0, [r3]
	_blh prSetPopupShort

	ldr r0, lpPopupDef @ arg r0 = popup definition pointer
	ldr r1, lTime      @ arg r1 = time the popup stays up
	mov r2, #0         @ arg r2 = popup window style
	mov r3, r4         @ arg r3 = parent 6C (0 works)

	_blh prNewPopup, r4

	mov r0, #0 @ Yield proc (in case it was used with proc code 0x16)
	b end

no_popup:
	mov r0, #1 @ Continue proc (in case it was used with proc code 0x16)

end:
	pop {r4}

	pop {r1}
	bx r1

	.pool
	.align

EALiterals:
	@ POIN pPopupDef
	@ WORD Time
