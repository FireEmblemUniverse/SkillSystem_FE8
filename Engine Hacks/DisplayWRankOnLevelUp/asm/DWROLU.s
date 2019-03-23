
	.thumb

	@ build using lyn

	Text_GetStringTextWidth = 0x08003EDC|1
	Text_DrawString         = 0x08004004|1

	GetWRankSpecialChar = 0x08016DF8|1
	GetBattleUnitUpdatedWeaponExp = 0x0802C0B4|1
	BattleUnit_ShouldDisplayWRankUp = 0x0807A7D8|1

	gpCurrentFont = 0x02028E70

	gPopupItem    = 0x030005F4
	gPopupNumber  = 0x030005F8

	gBattleActor  = 0x0203A4EC
	gBattleTarget = 0x0203A56C

	.type   PopRWeaponLevelComponent, object
	.global PopRWeaponLevelComponent

	.type   InitWeaponLevelUpPopup, function
	.global InitWeaponLevelUpPopup

	.type PopRWRankTextLength, function
	.type PopRWRankTextDisplay, function
	.type DoWithSpecialCharGlyphSet, function

PopRWRankTextLength:
	adr r0, PopRWRankTextLength.do
	add r0, #1

	@ we do not need to go back here
	@ so we let DoWithSpecialCharGlyphSet return to this function's caller immediately
	@ and just b there instead of bl

	b DoWithSpecialCharGlyphSet

	.align

PopRWRankTextLength.do:
	push {r0, lr} @ pushing r0 to make 4 bytes of space on the stack

	ldr r3, =GetWRankSpecialChar

	ldr r0, =gPopupNumber
	ldr r0, [r0] @ arg r0 = wrank

	bl BXR3

	@ make string ("<char>\x00")

	mov r1, sp
	mov r2, #0

	strb r0, [r1]
	strb r2, [r1, #1]

	ldr r3, =Text_GetStringTextWidth

	mov r0, sp @ arg r0 = string

	bl BXR3

	pop {r2, r3}
BXR3:
	bx r3

	.pool
	.align

PopRWRankTextDisplay:
	push {r4, lr}

	mov r4, r1 @ var r4 = text

	adr r0, PopRWRankTextDisplay.do
	add r0, #1

	bl DoWithSpecialCharGlyphSet

	pop {r4}

	pop {r1}
	bx r1

	.align

PopRWRankTextDisplay.do:
	push {r0, lr} @ pushing r0 to make 4 bytes of space on the stack

	ldr r3, =GetWRankSpecialChar

	ldr r0, =gPopupNumber
	ldr r0, [r0] @ arg r0 = wrank

	bl BXR3

	@ make string ("<char>\x00")

	mov r1, sp
	mov r2, #0

	strb r0, [r1]
	strb r2, [r1, #1]

	ldr r3, =Text_DrawString

	mov r0, r4 @ arg r0 = text
	mov r1, sp @ arg r1 = string

	bl BXR3

	pop {r2, r3}
	bx r3

	.pool
	.align

DoWithSpecialCharGlyphSet:
	@ argument: r0 = function pointer
	@ note: registers r4-r11 are unchanged, making them suitable to pass information from caller to wrapper function

	push {lr}

	ldr r1, =gpCurrentFont
	ldr r1, [r1] @ r1 = current font

	ldr r2, [r1, #4]

	push {r1-r2}

	ldr r2, =0x08590B44 @ special char glyph set
	str r2, [r1, #4]

	bl BXR0

	pop {r1-r2}

	str r2, [r1, #4] @ restore previous glyph set

	pop {r3}
	bx r3

BXR0:
	bx r0

	.pool
	.align

InitWeaponLevelUpPopup:
	push {r4, lr}

	@ check acting unit

	ldr r4, =gBattleActor

	ldr r3, =BattleUnit_ShouldDisplayWRankUp
	mov r0, r4 @ arg r0 = bu
	bl  BXR3

	cmp r0, #0
	bne InitWeaponLevelUpPopup.yes

	@ check target unit

	ldr r4, =gBattleTarget

	ldr r3, =BattleUnit_ShouldDisplayWRankUp
	mov r0, r4 @ arg r0 = bu
	bl  BXR3

	cmp r0, #0
	bne InitWeaponLevelUpPopup.yes

InitWeaponLevelUpPopup.no:
	@ implied @ return 0

InitWeaponLevelUpPopup.end:
	pop {r4}

	pop {r1}
	bx r1

InitWeaponLevelUpPopup.yes:
	ldr r3, =GetBattleUnitUpdatedWeaponExp

	mov r0, r4 @ arg r0 = bu

	bl BXR3

	ldr r1, =gPopupNumber
	str r0, [r1] @ store new wexp as popup number

	mov  r0, #0x50
	ldrb r0, [r4, r0] @ load wtype

	ldr  r1, =gPopupItem
	strh r0, [r1] @ store wtype as popup item (as vanilla does it)

	mov r0, #1

	b InitWeaponLevelUpPopup.end

	.pool
	.align

	.section .rodata

PopRWeaponLevelComponent:
	.word PopRWRankTextLength
	.word PopRWRankTextDisplay

