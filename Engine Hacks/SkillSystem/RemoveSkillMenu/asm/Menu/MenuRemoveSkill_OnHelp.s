
	.thumb

	.include "../Definitions.inc"

	lprGetSkillIdByIndex = EALiterals+0x00
	lpaSkillDescTable    = EALiterals+0x04

	@ mimic 804F458

OnHelp:
	push {r4-r5, lr}

	mov  r4, #0x2A
	ldsh r4, [r1, r4]
	lsl  r4, #3 @ r4 = x coord

	mov  r5, #0x2C
	ldsh r5, [r1, r5]
	lsl  r5, #3 @ r5 = y coord

	ldr r0, [r1, #0x14] @ parent proc (Menu)
	ldr r0, [r0, #0x14] @ grandparent proc (Wrapper holding Unit)
	ldr r0, [r0, #0x2C] @ arg r0 = Unit

	mov  r2, #0x3C
	ldrb r1, [r1, r2] @ arg r1 = skill index

	ldr r2, lprGetSkillIdByIndex
	mov lr, r2
	.short 0xf800

	@ now, r0 = skill id

	ldr  r1, lpaSkillDescTable
	lsl  r0, #1
	ldrh r2, [r1, r0] @ arg r2 = text id

	mov r0, r4 @ arg r0 = x coord
	mov r1, r5 @ arg r1 = y coord

	_blh 0x08088DE0, r4

	pop {r4-r5}

	pop {r1}
	bx r1

.ltorg
.align

EALiterals:
	@ POIN prGetSkillIdByIndex
	@ POIN SkillDescTable
