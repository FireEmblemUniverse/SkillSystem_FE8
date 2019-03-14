
	.thumb

	LoadIconPalette = 0x080035D4|1

	gPopupItem = 0x030005F4

PopRSkillIconDisplay:
	@ args: r0 = PopR proc, r1 = PopR text, r2 = popup component argument

	push {r4-r5, lr}

	mov r4, r0 @ var r4 = PopR proc
	mov r5, r1 @ var r5 = PopR text

	ldr r3, [r4, #0x4C] @ r3 = popr->addIcon (function pointer)

	mov r1, #0x01
	lsl r1, #8

	ldr  r2, =gPopupItem
	ldrb r2, [r2]

	@ implied         @ arg r0 = PopR proc
	orr  r1, r2       @ arg r1 = icon id
	ldrb r2, [r5, #2] @ arg r2 = offset

	bl BXR3 @ popr->addIcon(popr, 0x100 | gPopupItem, text->xCursor)

	ldrb r0, [r5, #2]
	add  r0, #16
	strb r0, [r5, #2]

	ldr r3, =LoadIconPalette

	mov  r1, #0x42
	ldrb r1, [r4, r1] @ arg r1 = palette id

	mov  r0, #0       @ arg r0 = palette type (0 = items/skills, 1 = other)

	bl BXR3 @ LoadIconPalette(0, popr->iconPalId)

	pop {r4-r5}

	pop {r3}
BXR3:
	bx r3

