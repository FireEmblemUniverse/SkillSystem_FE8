	.cpu arm7tdmi
	.arch armv4t
	.fpu softvfp
	.eabi_attribute 20, 1	@ Tag_ABI_FP_denormal
	.eabi_attribute 21, 1	@ Tag_ABI_FP_exceptions
	.eabi_attribute 23, 3	@ Tag_ABI_FP_number_model
	.eabi_attribute 24, 1	@ Tag_ABI_align8_needed
	.eabi_attribute 25, 1	@ Tag_ABI_align8_preserved
	.eabi_attribute 26, 1	@ Tag_ABI_enum_size
	.eabi_attribute 30, 4	@ Tag_ABI_optimization_goals
	.eabi_attribute 34, 0	@ Tag_CPU_unaligned_access
	.eabi_attribute 18, 4	@ Tag_ABI_PCS_wchar_t
	.file	"GaidenMagic.c"
@ GNU C17 (devkitARM release 58) version 12.1.0 (arm-none-eabi)
@	compiled by GNU C version 8.3.0, GMP version 6.2.1, MPFR version 4.1.0, MPC version 1.2.1, isl version isl-0.18-GMP

@ GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
@ options passed: -mcpu=arm7tdmi -mthumb -mthumb-interwork -mtune=arm7tdmi -mlong-calls -march=armv4t -Os
	.text
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.type	IncorporateNewRange, %function
IncorporateNewRange:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}	@
@ RangeDisplay.c:59: {
	movs	r4, r1	@ existing, tmp185
@ RangeDisplay.c:62: 	long long existingMin = existing >> 40;
	asrs	r7, r1, #31	@ existingMin, existing,
@ RangeDisplay.c:63: 	long long newMin = new >> 40;
	asrs	r5, r3, #8	@ newMin, new,
	asrs	r6, r3, #31	@ newMin, new,
@ RangeDisplay.c:66: 	return existingMask|newMask|(( newMin < existingMin ? newMin : existingMin ) << 40)|(( newMax > existingMax ? newMax : existingMax ) << 32);
	asrs	r1, r1, #8	@ existingMin, existing,
	cmp	r7, r6	@ existingMin, newMin
	bgt	.L3		@,
	bne	.L2		@,
	cmp	r1, r5	@ existingMin, newMin
	bls	.L2		@,
.L3:
	movs	r1, r5	@ existingMin, newMin
.L2:
@ RangeDisplay.c:66: 	return existingMask|newMask|(( newMin < existingMin ? newMin : existingMin ) << 40)|(( newMax > existingMax ? newMax : existingMax ) << 32);
	orrs	r0, r2	@ tmp137, new
@ RangeDisplay.c:64: 	long long existingMax = (existing >> 32) & 0xFF;
	movs	r2, #255	@ tmp144,
@ RangeDisplay.c:66: 	return existingMask|newMask|(( newMin < existingMin ? newMin : existingMin ) << 40)|(( newMax > existingMax ? newMax : existingMax ) << 32);
	lsls	r1, r1, #8	@ tmp167, existingMin,
@ RangeDisplay.c:65: 	long long newMax = (new >> 32) & 0xFF;
	ands	r3, r2	@ newMax, tmp144
@ RangeDisplay.c:66: 	return existingMask|newMask|(( newMin < existingMin ? newMin : existingMin ) << 40)|(( newMax > existingMax ? newMax : existingMax ) << 32);
	ands	r4, r2	@ existingMax, tmp144
	cmp	r3, r4	@ newMax, existingMax
	bls	.L4		@,
	movs	r4, r3	@ existingMax, newMax
.L4:
@ RangeDisplay.c:67: }
	@ sp needed	@
@ RangeDisplay.c:66: 	return existingMask|newMask|(( newMin < existingMin ? newMin : existingMin ) << 40)|(( newMax > existingMax ? newMax : existingMax ) << 32);
	orrs	r1, r4	@ tmp159, existingMax
@ RangeDisplay.c:67: }
	pop	{r4, r5, r6, r7}
	pop	{r2}
	bx	r2
	.size	IncorporateNewRange, .-IncorporateNewRange
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.type	GaidenMagicUMEffectExt, %function
GaidenMagicUMEffectExt:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r0, r1, r4, r5, r6, lr}	@
@ UnitMenu.c:50: {
	movs	r4, r0	@ spellsList, tmp145
	subs	r0, r1, #0	@ proc, tmp146,
@ UnitMenu.c:51: 	if ( proc && commandProc->availability == 2 )
	beq	.L7		@,
@ UnitMenu.c:51: 	if ( proc && commandProc->availability == 2 )
	adds	r2, r2, #61	@ tmp126,
@ UnitMenu.c:51: 	if ( proc && commandProc->availability == 2 )
	ldrb	r3, [r2]	@ tmp127,
	cmp	r3, #2	@ tmp127,
	bne	.L7		@,
@ UnitMenu.c:54: 		MenuCallHelpBox(proc,gGaidenMagicUMErrorText);
	ldr	r3, .L12	@ tmp128,
	ldrh	r1, [r3]	@ gGaidenMagicUMErrorText, gGaidenMagicUMErrorText
	ldr	r3, .L12+4	@ tmp130,
	bl	.L14		@
@ UnitMenu.c:55: 		return 0x08;
	movs	r0, #8	@ <retval>,
.L6:
@ UnitMenu.c:69: }
	@ sp needed	@
	pop	{r1, r2, r4, r5, r6}
	pop	{r1}
	bx	r1
.L7:
@ UnitMenu.c:59: 		_ResetIconGraphics();
	ldr	r3, .L12+8	@ tmp131,
	bl	.L14		@
@ UnitMenu.c:60: 		SelectedSpell = spellsList[0];
	ldrb	r2, [r4]	@ _3, *spellsList_14(D)
@ UnitMenu.c:60: 		SelectedSpell = spellsList[0];
	ldr	r3, .L12+12	@ tmp132,
@ UnitMenu.c:61: 		LoadIconPalettes(4);
	movs	r0, #4	@,
@ UnitMenu.c:60: 		SelectedSpell = spellsList[0];
	strb	r2, [r3]	@ _3, SelectedSpell
@ UnitMenu.c:61: 		LoadIconPalettes(4);
	ldr	r3, .L12+16	@ tmp134,
	bl	.L14		@
@ UnitMenu.c:62: 		MenuProc* menu = StartMenu(&SpellSelectMenuDefs);
	ldr	r3, .L12+20	@ tmp136,
	ldr	r0, .L12+24	@ tmp135,
	bl	.L14		@
@ UnitMenu.c:64: 		StartFace(0,GetUnitPortraitId(gActiveUnit),0xB0,0xC,2);
	ldr	r5, .L12+28	@ tmp137,
@ UnitMenu.c:62: 		MenuProc* menu = StartMenu(&SpellSelectMenuDefs);
	movs	r4, r0	@ menu, tmp148
@ UnitMenu.c:64: 		StartFace(0,GetUnitPortraitId(gActiveUnit),0xB0,0xC,2);
	ldr	r3, .L12+32	@ tmp138,
	ldr	r0, [r5]	@, gActiveUnit
	bl	.L14		@
	movs	r3, #2	@ tmp139,
	movs	r1, r0	@ _5, tmp149
	movs	r2, #176	@,
	str	r3, [sp]	@ tmp139,
	movs	r0, #0	@,
	adds	r3, r3, #10	@,
	ldr	r6, .L12+36	@ tmp140,
	bl	.L15		@
@ UnitMenu.c:65: 		SetFaceBlinkControlById(0,5);
	movs	r1, #5	@,
	movs	r0, #0	@,
	ldr	r3, .L12+40	@ tmp141,
	bl	.L14		@
@ UnitMenu.c:66: 		ForceMenuItemPanel(menu,gActiveUnit,15,11);
	movs	r0, r4	@, menu
	movs	r3, #11	@,
	movs	r2, #15	@,
	ldr	r1, [r5]	@, gActiveUnit
	ldr	r4, .L12+44	@ tmp143,
	bl	.L16		@
@ UnitMenu.c:67: 		return 0x17;
	movs	r0, #23	@ <retval>,
	b	.L6		@
.L13:
	.align	2
.L12:
	.word	gGaidenMagicUMErrorText
	.word	MenuCallHelpBox
	.word	_ResetIconGraphics
	.word	SelectedSpell
	.word	LoadIconPalettes
	.word	StartMenu
	.word	SpellSelectMenuDefs
	.word	gActiveUnit
	.word	GetUnitPortraitId
	.word	StartFace
	.word	SetFaceBlinkControlById
	.word	ForceMenuItemPanel
	.size	GaidenMagicUMEffectExt, .-GaidenMagicUMEffectExt
	.align	1
	.global	GaidenMagicUMUnhover
	.syntax unified
	.code	16
	.thumb_func
	.type	GaidenMagicUMUnhover, %function
GaidenMagicUMUnhover:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ UnitMenu.c:112: 	if ( !SelectedSpell ) { UsingSpellMenu = 0; } // Don't unset this if we're going to the spell menu.
	ldr	r3, .L19	@ tmp116,
@ UnitMenu.c:112: 	if ( !SelectedSpell ) { UsingSpellMenu = 0; } // Don't unset this if we're going to the spell menu.
	ldrb	r3, [r3]	@ SelectedSpell, SelectedSpell
	cmp	r3, #0	@ SelectedSpell,
	bne	.L18		@,
@ UnitMenu.c:112: 	if ( !SelectedSpell ) { UsingSpellMenu = 0; } // Don't unset this if we're going to the spell menu.
	ldr	r2, .L19+4	@ tmp118,
	strb	r3, [r2]	@ SelectedSpell, UsingSpellMenu
.L18:
@ UnitMenu.c:115: }
	@ sp needed	@
@ UnitMenu.c:113: 	HideMoveRangeGraphics();
	ldr	r3, .L19+8	@ tmp121,
	bl	.L14		@
@ UnitMenu.c:115: }
	movs	r0, #0	@,
	pop	{r4}
	pop	{r1}
	bx	r1
.L20:
	.align	2
.L19:
	.word	SelectedSpell
	.word	UsingSpellMenu
	.word	HideMoveRangeGraphics
	.size	GaidenMagicUMUnhover, .-GaidenMagicUMUnhover
	.align	1
	.global	CanCastSpellNow
	.syntax unified
	.code	16
	.thumb_func
	.type	CanCastSpellNow, %function
CanCastSpellNow:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ SpellSystem.c:207: 	int type = GetItemType(spell);
	movs	r0, r1	@, spell
	ldr	r3, .L27	@ tmp122,
@ SpellSystem.c:205: {
	movs	r4, r1	@ spell, tmp135
@ SpellSystem.c:207: 	int type = GetItemType(spell);
	bl	.L14		@
@ SpellSystem.c:210: 		if ( !CanUnitUseWeaponNow(gActiveUnit,spell) ) { return 0; }
	movs	r1, r4	@, spell
	ldr	r5, .L27+4	@ tmp134,
@ SpellSystem.c:208: 	if ( type != ITYPE_STAFF )
	cmp	r0, #4	@ tmp136,
	beq	.L22		@,
@ SpellSystem.c:210: 		if ( !CanUnitUseWeaponNow(gActiveUnit,spell) ) { return 0; }
	ldr	r0, [r5]	@, gActiveUnit
	ldr	r3, .L27+8	@ tmp124,
	bl	.L14		@
@ SpellSystem.c:210: 		if ( !CanUnitUseWeaponNow(gActiveUnit,spell) ) { return 0; }
	cmp	r0, #0	@ <retval>,
	beq	.L21		@,
@ SpellSystem.c:212: 		MakeTargetListForWeapon(gActiveUnit,spell);
	movs	r1, r4	@, spell
	ldr	r0, [r5]	@, gActiveUnit
	ldr	r3, .L27+12	@ tmp126,
	bl	.L14		@
@ SpellSystem.c:213: 		return GetTargetListSize() != 0;
	ldr	r3, .L27+16	@ tmp127,
	bl	.L14		@
@ SpellSystem.c:213: 		return GetTargetListSize() != 0;
	subs	r3, r0, #1	@ tmp130, tmp138
	sbcs	r0, r0, r3	@ <retval>, tmp138, tmp130
.L21:
@ SpellSystem.c:219: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L22:
@ SpellSystem.c:217: 		return CanUnitUseItem(gActiveUnit,spell);
	ldr	r0, [r5]	@, gActiveUnit
	ldr	r3, .L27+20	@ tmp132,
	bl	.L14		@
	b	.L21		@
.L28:
	.align	2
.L27:
	.word	GetItemType
	.word	gActiveUnit
	.word	CanUnitUseWeaponNow
	.word	MakeTargetListForWeapon
	.word	GetTargetListSize
	.word	CanUnitUseItem
	.size	CanCastSpellNow, .-CanCastSpellNow
	.align	1
	.global	CanCastSpell
	.syntax unified
	.code	16
	.thumb_func
	.type	CanCastSpell, %function
CanCastSpell:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ SpellSystem.c:223: 	int type = GetItemType(spell);
	movs	r0, r1	@, spell
	ldr	r3, .L35	@ tmp122,
@ SpellSystem.c:222: {
	movs	r4, r1	@ spell, tmp135
@ SpellSystem.c:223: 	int type = GetItemType(spell);
	bl	.L14		@
@ SpellSystem.c:226: 		if ( !CanUnitUseWeapon(gActiveUnit,spell) ) { return 0; }
	movs	r1, r4	@, spell
	ldr	r5, .L35+4	@ tmp134,
@ SpellSystem.c:224: 	if ( type != ITYPE_STAFF )
	cmp	r0, #4	@ tmp136,
	beq	.L30		@,
@ SpellSystem.c:226: 		if ( !CanUnitUseWeapon(gActiveUnit,spell) ) { return 0; }
	ldr	r0, [r5]	@, gActiveUnit
	ldr	r3, .L35+8	@ tmp124,
	bl	.L14		@
@ SpellSystem.c:226: 		if ( !CanUnitUseWeapon(gActiveUnit,spell) ) { return 0; }
	cmp	r0, #0	@ <retval>,
	beq	.L29		@,
@ SpellSystem.c:228: 		MakeTargetListForWeapon(gActiveUnit,spell);
	movs	r1, r4	@, spell
	ldr	r0, [r5]	@, gActiveUnit
	ldr	r3, .L35+12	@ tmp126,
	bl	.L14		@
@ SpellSystem.c:229: 		return GetTargetListSize() != 0;
	ldr	r3, .L35+16	@ tmp127,
	bl	.L14		@
@ SpellSystem.c:229: 		return GetTargetListSize() != 0;
	subs	r3, r0, #1	@ tmp130, tmp138
	sbcs	r0, r0, r3	@ <retval>, tmp138, tmp130
.L29:
@ SpellSystem.c:235: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L30:
@ SpellSystem.c:217: 		return CanUnitUseItem(gActiveUnit,spell);
	ldr	r0, [r5]	@, gActiveUnit
	ldr	r3, .L35+20	@ tmp132,
	bl	.L14		@
	b	.L29		@
.L36:
	.align	2
.L35:
	.word	GetItemType
	.word	gActiveUnit
	.word	CanUnitUseWeapon
	.word	MakeTargetListForWeapon
	.word	GetTargetListSize
	.word	CanUnitUseItem
	.size	CanCastSpell, .-CanCastSpell
	.align	1
	.global	RangeUsabilityCheckStaff
	.syntax unified
	.code	16
	.thumb_func
	.type	RangeUsabilityCheckStaff, %function
RangeUsabilityCheckStaff:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ RangeDisplay.c:72: 	return GetItemType(item) == ITYPE_STAFF && CanCastSpell(unit,item);
	ldr	r3, .L40	@ tmp119,
@ RangeDisplay.c:70: {
	movs	r5, r0	@ unit, tmp124
@ RangeDisplay.c:72: 	return GetItemType(item) == ITYPE_STAFF && CanCastSpell(unit,item);
	movs	r0, r1	@, item
@ RangeDisplay.c:70: {
	movs	r4, r1	@ item, tmp125
@ RangeDisplay.c:72: 	return GetItemType(item) == ITYPE_STAFF && CanCastSpell(unit,item);
	bl	.L14		@
	movs	r3, r0	@ tmp126,
@ RangeDisplay.c:72: 	return GetItemType(item) == ITYPE_STAFF && CanCastSpell(unit,item);
	movs	r0, #0	@ <retval>,
	cmp	r3, #4	@ tmp126,
	bne	.L37		@,
@ RangeDisplay.c:72: 	return GetItemType(item) == ITYPE_STAFF && CanCastSpell(unit,item);
	movs	r1, r4	@, item
	movs	r0, r5	@, unit
	bl	CanCastSpell		@
@ RangeDisplay.c:72: 	return GetItemType(item) == ITYPE_STAFF && CanCastSpell(unit,item);
	subs	r3, r0, #1	@ tmp122, tmp127
	sbcs	r0, r0, r3	@ <retval>, tmp127, tmp122
.L37:
@ RangeDisplay.c:73: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L41:
	.align	2
.L40:
	.word	GetItemType
	.size	RangeUsabilityCheckStaff, .-RangeUsabilityCheckStaff
	.align	1
	.global	RangeUsabilityCheckNotStaff
	.syntax unified
	.code	16
	.thumb_func
	.type	RangeUsabilityCheckNotStaff, %function
RangeUsabilityCheckNotStaff:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ RangeDisplay.c:77: 	return GetItemType(item) != ITYPE_STAFF && CanCastSpell(unit,item);
	ldr	r3, .L46	@ tmp119,
@ RangeDisplay.c:76: {
	movs	r5, r0	@ unit, tmp124
@ RangeDisplay.c:77: 	return GetItemType(item) != ITYPE_STAFF && CanCastSpell(unit,item);
	movs	r0, r1	@, item
@ RangeDisplay.c:76: {
	movs	r4, r1	@ item, tmp125
@ RangeDisplay.c:77: 	return GetItemType(item) != ITYPE_STAFF && CanCastSpell(unit,item);
	bl	.L14		@
	movs	r3, r0	@ tmp126,
@ RangeDisplay.c:77: 	return GetItemType(item) != ITYPE_STAFF && CanCastSpell(unit,item);
	movs	r0, #0	@ <retval>,
	cmp	r3, #4	@ tmp126,
	beq	.L42		@,
@ RangeDisplay.c:77: 	return GetItemType(item) != ITYPE_STAFF && CanCastSpell(unit,item);
	movs	r1, r4	@, item
	movs	r0, r5	@, unit
	bl	CanCastSpell		@
@ RangeDisplay.c:77: 	return GetItemType(item) != ITYPE_STAFF && CanCastSpell(unit,item);
	subs	r3, r0, #1	@ tmp122, tmp127
	sbcs	r0, r0, r3	@ <retval>, tmp127, tmp122
.L42:
@ RangeDisplay.c:78: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L47:
	.align	2
.L46:
	.word	GetItemType
	.size	RangeUsabilityCheckNotStaff, .-RangeUsabilityCheckNotStaff
	.align	1
	.global	GetSpellType
	.syntax unified
	.code	16
	.thumb_func
	.type	GetSpellType, %function
GetSpellType:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
@ SpellSystem.c:289: 	int wType = GetItemType(spell);
	ldr	r3, .L52	@ tmp117,
@ SpellSystem.c:288: {
	push	{r4, lr}	@
@ SpellSystem.c:289: 	int wType = GetItemType(spell);
	bl	.L14		@
@ SpellSystem.c:290: 	if ( wType == ITYPE_ANIMA || wType == ITYPE_DARK ) { return BLACK_MAGIC; }
	movs	r2, #2	@ tmp118,
	movs	r3, r0	@ tmp127, tmp127
@ SpellSystem.c:290: 	if ( wType == ITYPE_ANIMA || wType == ITYPE_DARK ) { return BLACK_MAGIC; }
	movs	r0, #1	@ <retval>,
@ SpellSystem.c:290: 	if ( wType == ITYPE_ANIMA || wType == ITYPE_DARK ) { return BLACK_MAGIC; }
	bics	r3, r2	@ tmp127, tmp118
	cmp	r3, #5	@ _6,
	beq	.L48		@,
@ SpellSystem.c:291: 	else if ( wType == ITYPE_STAFF || wType == ITYPE_LIGHT) { return WHITE_MAGIC; }
	movs	r0, r2	@ <retval>, tmp118
@ SpellSystem.c:291: 	else if ( wType == ITYPE_STAFF || wType == ITYPE_LIGHT) { return WHITE_MAGIC; }
	cmp	r3, #4	@ _6,
	beq	.L48		@,
@ SpellSystem.c:292: 	else { return -1; }
	movs	r0, #1	@ <retval>,
	rsbs	r0, r0, #0	@ <retval>, <retval>
.L48:
@ SpellSystem.c:293: }
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L53:
	.align	2
.L52:
	.word	GetItemType
	.size	GetSpellType, .-GetSpellType
	.align	1
	.global	SpellsGetterForLevel
	.syntax unified
	.code	16
	.thumb_func
	.type	SpellsGetterForLevel, %function
SpellsGetterForLevel:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r0, r1, r2, r4, r5, r6, r7, lr}	@
@ SpellSystem.c:10: 	int unitLevel = unit->level;
	movs	r6, #8	@ unitLevel,
@ SpellSystem.c:8: {
	str	r2, [sp]	@ tmp153, %sfp
@ SpellSystem.c:10: 	int unitLevel = unit->level;
	ldrsb	r6, [r0, r6]	@ unitLevel,* unitLevel
@ SpellSystem.c:11: 	if ( UNIT_ATTRIBUTES(unit) & CA_PROMOTED ) { unitLevel += 80; } // Treat promoted as top bit set.
	ldmia	r0!, {r2, r3}	@,,
@ SpellSystem.c:8: {
	movs	r7, r1	@ level, tmp152
@ SpellSystem.c:11: 	if ( UNIT_ATTRIBUTES(unit) & CA_PROMOTED ) { unitLevel += 80; } // Treat promoted as top bit set.
	ldr	r3, [r3, #40]	@ _4->attributes, _4->attributes
	ldr	r1, [r2, #40]	@ _2->attributes, _2->attributes
	orrs	r3, r1	@ tmp138, _2->attributes
@ SpellSystem.c:11: 	if ( UNIT_ATTRIBUTES(unit) & CA_PROMOTED ) { unitLevel += 80; } // Treat promoted as top bit set.
	lsls	r3, r3, #23	@ tmp155, tmp138,
	bpl	.L55		@,
@ SpellSystem.c:11: 	if ( UNIT_ATTRIBUTES(unit) & CA_PROMOTED ) { unitLevel += 80; } // Treat promoted as top bit set.
	adds	r6, r6, #80	@ unitLevel,
.L55:
@ SpellSystem.c:13: 	SpellList* ROMList = SpellListTable[unit->pCharacterData->number];
	ldrb	r2, [r2, #4]	@ tmp144,
@ SpellSystem.c:13: 	SpellList* ROMList = SpellListTable[unit->pCharacterData->number];
	ldr	r3, .L71	@ tmp143,
	lsls	r2, r2, #2	@ tmp145, tmp144,
	ldr	r4, [r2, r3]	@ ROMList, SpellListTable[_10]
	ldr	r3, .L71+4	@ <retval>,
@ SpellSystem.c:12: 	u8* currBuffer = SpellsBuffer;
	movs	r5, r3	@ currBuffer, <retval>
	str	r3, [sp, #4]	@ <retval>, %sfp
@ SpellSystem.c:14: 	if ( ROMList )
	cmp	r4, #0	@ ROMList,
	beq	.L56		@,
.L57:
@ SpellSystem.c:17: 		for ( int i = 0 ; ROMList[i].level ; i++ )
	ldrb	r3, [r4]	@ _20, MEM[(unsigned char *)_11]
@ SpellSystem.c:17: 		for ( int i = 0 ; ROMList[i].level ; i++ )
	cmp	r3, #0	@ _20,
	bne	.L64		@,
.L56:
@ SpellSystem.c:33: }
	@ sp needed	@
@ SpellSystem.c:31: 	*currBuffer = 0;
	movs	r3, #0	@ tmp147,
@ SpellSystem.c:33: }
	ldr	r0, [sp, #4]	@, %sfp
@ SpellSystem.c:31: 	*currBuffer = 0;
	strb	r3, [r5]	@ tmp147, *currBuffer_24
@ SpellSystem.c:33: }
	pop	{r1, r2, r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L64:
@ SpellSystem.c:19: 			if ( (level == -1 && unitLevel >= ROMList[i].level) || (level == ROMList[i].level) )
	adds	r2, r7, #1	@ tmp156, level,
	bne	.L58		@,
@ SpellSystem.c:19: 			if ( (level == -1 && unitLevel >= ROMList[i].level) || (level == ROMList[i].level) )
	cmp	r6, r3	@ unitLevel, _20
	bge	.L59		@,
.L62:
	adds	r4, r4, #2	@ ivtmp.207,
	b	.L57		@
.L58:
@ SpellSystem.c:19: 			if ( (level == -1 && unitLevel >= ROMList[i].level) || (level == ROMList[i].level) )
	cmp	r7, r3	@ level, _20
	bne	.L62		@,
.L59:
@ SpellSystem.c:21: 				if ( type == -1 || type == GetSpellType(ROMList[i].spell) )
	ldr	r3, [sp]	@ type, %sfp
@ SpellSystem.c:21: 				if ( type == -1 || type == GetSpellType(ROMList[i].spell) )
	ldrb	r0, [r4, #1]	@ pretmp_49, MEM[(unsigned char *)_11 + 1B]
@ SpellSystem.c:21: 				if ( type == -1 || type == GetSpellType(ROMList[i].spell) )
	adds	r3, r3, #1	@ tmp157, type,
	bne	.L61		@,
.L63:
@ SpellSystem.c:24: 					*currBuffer = ROMList[i].spell;
	ldrb	r3, [r4, #1]	@ _16, MEM[(unsigned char *)_11 + 1B]
@ SpellSystem.c:24: 					*currBuffer = ROMList[i].spell;
	strb	r3, [r5]	@ _16, *currBuffer_23
@ SpellSystem.c:25: 					currBuffer++;
	adds	r5, r5, #1	@ currBuffer,
	b	.L62		@
.L61:
@ SpellSystem.c:21: 				if ( type == -1 || type == GetSpellType(ROMList[i].spell) )
	bl	GetSpellType		@
@ SpellSystem.c:21: 				if ( type == -1 || type == GetSpellType(ROMList[i].spell) )
	ldr	r3, [sp]	@ type, %sfp
	cmp	r0, r3	@ tmp154, type
	bne	.L62		@,
	b	.L63		@
.L72:
	.align	2
.L71:
	.word	SpellListTable
	.word	SpellsBuffer
	.size	SpellsGetterForLevel, .-SpellsGetterForLevel
	.align	1
	.global	SpellsGetter
	.syntax unified
	.code	16
	.thumb_func
	.type	SpellsGetter, %function
SpellsGetter:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	movs	r2, r1	@ type, tmp119
@ SpellSystem.c:4: 	return SpellsGetterForLevel(unit,-1,type);
	movs	r1, #1	@ tmp121,
@ SpellSystem.c:3: {
	push	{r4, lr}	@
@ SpellSystem.c:4: 	return SpellsGetterForLevel(unit,-1,type);
	rsbs	r1, r1, #0	@, tmp121
	bl	SpellsGetterForLevel		@
@ SpellSystem.c:5: }
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
	.size	SpellsGetter, .-SpellsGetter
	.align	1
	.global	GaidenBlackMagicUMEffect
	.syntax unified
	.code	16
	.thumb_func
	.type	GaidenBlackMagicUMEffect, %function
GaidenBlackMagicUMEffect:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ UnitMenu.c:38: {
	movs	r5, r1	@ commandProc, tmp124
@ UnitMenu.c:41: }
	@ sp needed	@
@ UnitMenu.c:39: 	UsingSpellMenu = BLACK_MAGIC;
	movs	r1, #1	@ tmp119,
@ UnitMenu.c:38: {
	movs	r4, r0	@ proc, tmp123
@ UnitMenu.c:39: 	UsingSpellMenu = BLACK_MAGIC;
	ldr	r3, .L75	@ tmp118,
	strb	r1, [r3]	@ tmp119, UsingSpellMenu
@ UnitMenu.c:40: 	return GaidenMagicUMEffectExt(SpellsGetter(gActiveUnit,BLACK_MAGIC),proc,commandProc);
	ldr	r3, .L75+4	@ tmp121,
	ldr	r0, [r3]	@, gActiveUnit
	bl	SpellsGetter		@
	movs	r2, r5	@, commandProc
	movs	r1, r4	@, proc
	bl	GaidenMagicUMEffectExt		@
@ UnitMenu.c:41: }
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L76:
	.align	2
.L75:
	.word	UsingSpellMenu
	.word	gActiveUnit
	.size	GaidenBlackMagicUMEffect, .-GaidenBlackMagicUMEffect
	.align	1
	.global	GaidenWhiteMagicUMEffect
	.syntax unified
	.code	16
	.thumb_func
	.type	GaidenWhiteMagicUMEffect, %function
GaidenWhiteMagicUMEffect:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ UnitMenu.c:44: {
	movs	r5, r1	@ commandProc, tmp124
@ UnitMenu.c:47: }
	@ sp needed	@
@ UnitMenu.c:45: 	UsingSpellMenu = WHITE_MAGIC;
	movs	r1, #2	@ tmp119,
@ UnitMenu.c:44: {
	movs	r4, r0	@ proc, tmp123
@ UnitMenu.c:45: 	UsingSpellMenu = WHITE_MAGIC;
	ldr	r3, .L78	@ tmp118,
	strb	r1, [r3]	@ tmp119, UsingSpellMenu
@ UnitMenu.c:46: 	return GaidenMagicUMEffectExt(SpellsGetter(gActiveUnit,WHITE_MAGIC),proc,commandProc);
	ldr	r3, .L78+4	@ tmp121,
	ldr	r0, [r3]	@, gActiveUnit
	bl	SpellsGetter		@
	movs	r2, r5	@, commandProc
	movs	r1, r4	@, proc
	bl	GaidenMagicUMEffectExt		@
@ UnitMenu.c:47: }
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L79:
	.align	2
.L78:
	.word	UsingSpellMenu
	.word	gActiveUnit
	.size	GaidenWhiteMagicUMEffect, .-GaidenWhiteMagicUMEffect
	.align	1
	.global	NewGetUnitUseFlags
	.syntax unified
	.code	16
	.thumb_func
	.type	NewGetUnitUseFlags, %function
NewGetUnitUseFlags:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	movs	r3, r0	@ _74, unit
	push	{r0, r1, r2, r4, r5, r6, r7, lr}	@
	movs	r6, r0	@ ivtmp.232, unit
@ SpellSystem.c:120: {
	movs	r5, r0	@ unit, tmp181
@ SpellSystem.c:121: 	u32 ret = 0;
	movs	r4, #0	@ <retval>,
@ SpellSystem.c:125: 		if ( attributes & IA_WEAPON )
	movs	r7, #1	@ tmp179,
	adds	r3, r3, #40	@ _74,
	str	r3, [sp, #4]	@ _74, %sfp
	adds	r6, r6, #30	@ ivtmp.232,
.L81:
@ SpellSystem.c:122: 	for ( int i = 0 ; i < 5 && unit->items[i] ; i++ )
	ldrh	r0, [r6]	@ _11, MEM[(short unsigned int *)_70]
@ SpellSystem.c:122: 	for ( int i = 0 ; i < 5 && unit->items[i] ; i++ )
	cmp	r0, #0	@ _11,
	beq	.L86		@,
@ SpellSystem.c:124: 		u32 attributes = GetItemAttributes(unit->items[i]);
	ldr	r3, .L106	@ tmp145,
	bl	.L14		@
@ SpellSystem.c:125: 		if ( attributes & IA_WEAPON )
	tst	r0, r7	@ attributes, tmp179
	beq	.L82		@,
@ SpellSystem.c:127: 			if ( CanUnitUseWeaponNow(unit,unit->items[i]) ) { ret |= 1; }
	movs	r0, r5	@, unit
	ldrh	r1, [r6]	@ MEM[(short unsigned int *)_70], MEM[(short unsigned int *)_70]
	ldr	r3, .L106+4	@ tmp149,
	bl	.L14		@
@ SpellSystem.c:127: 			if ( CanUnitUseWeaponNow(unit,unit->items[i]) ) { ret |= 1; }
	cmp	r0, #0	@ tmp183,
	beq	.L84		@,
@ SpellSystem.c:127: 			if ( CanUnitUseWeaponNow(unit,unit->items[i]) ) { ret |= 1; }
	orrs	r4, r7	@ <retval>, tmp179
.L84:
@ SpellSystem.c:122: 	for ( int i = 0 ; i < 5 && unit->items[i] ; i++ )
	ldr	r3, [sp, #4]	@ _74, %sfp
	adds	r6, r6, #2	@ ivtmp.232,
	cmp	r6, r3	@ ivtmp.232, _74
	bne	.L81		@,
.L86:
@ SpellSystem.c:135: 	u8* spells = SpellsGetter(unit,-1);
	movs	r1, #1	@,
	movs	r0, r5	@, unit
	rsbs	r1, r1, #0	@,
	bl	SpellsGetter		@
@ SpellSystem.c:139: 		if ( attributes & IA_WEAPON )
	movs	r7, #1	@ tmp177,
@ SpellSystem.c:135: 	u8* spells = SpellsGetter(unit,-1);
	movs	r6, r0	@ ivtmp.226, tmp185
.L88:
@ SpellSystem.c:136: 	for ( int i = 0 ; spells[i] ; i++ )
	ldrb	r0, [r6]	@ _26, MEM[(u8 *)_63]
@ SpellSystem.c:136: 	for ( int i = 0 ; spells[i] ; i++ )
	cmp	r0, #0	@ _26,
	bne	.L93		@,
@ SpellSystem.c:149: }
	@ sp needed	@
	movs	r0, r4	@, <retval>
	pop	{r1, r2, r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L82:
@ SpellSystem.c:129: 		else if ( attributes & IA_STAFF )
	movs	r3, #4	@ tmp193,
	tst	r0, r3	@ attributes, tmp193
	beq	.L84		@,
@ SpellSystem.c:131: 			if ( CanUnitUseStaffNow(unit,unit->items[i]) ) { ret |= 2; }
	movs	r0, r5	@, unit
	ldrh	r1, [r6]	@ MEM[(short unsigned int *)_70], MEM[(short unsigned int *)_70]
	ldr	r3, .L106+8	@ tmp156,
	bl	.L14		@
@ SpellSystem.c:131: 			if ( CanUnitUseStaffNow(unit,unit->items[i]) ) { ret |= 2; }
	cmp	r0, #0	@ tmp184,
	beq	.L84		@,
@ SpellSystem.c:131: 			if ( CanUnitUseStaffNow(unit,unit->items[i]) ) { ret |= 2; }
	movs	r3, #2	@ tmp159,
	orrs	r4, r3	@ <retval>, tmp159
	b	.L84		@
.L93:
@ SpellSystem.c:138: 		u32 attributes = GetItemAttributes(spells[i]);
	ldr	r3, .L106	@ tmp161,
	bl	.L14		@
@ SpellSystem.c:139: 		if ( attributes & IA_WEAPON )
	tst	r0, r7	@ attributes, tmp177
	beq	.L89		@,
@ SpellSystem.c:141: 			if ( CanUnitUseWeaponNow(unit,spells[i]) ) { ret |= 1; }
	movs	r0, r5	@, unit
	ldrb	r1, [r6]	@ MEM[(u8 *)_63], MEM[(u8 *)_63]
	ldr	r3, .L106+4	@ tmp165,
	bl	.L14		@
@ SpellSystem.c:141: 			if ( CanUnitUseWeaponNow(unit,spells[i]) ) { ret |= 1; }
	cmp	r0, #0	@ tmp187,
	beq	.L91		@,
@ SpellSystem.c:141: 			if ( CanUnitUseWeaponNow(unit,spells[i]) ) { ret |= 1; }
	orrs	r4, r7	@ <retval>, tmp177
.L91:
	adds	r6, r6, #1	@ ivtmp.226,
	b	.L88		@
.L89:
@ SpellSystem.c:143: 		else if ( attributes & IA_STAFF )
	movs	r3, #4	@ tmp195,
	tst	r0, r3	@ attributes, tmp195
	beq	.L91		@,
@ SpellSystem.c:145: 			if ( CanUnitUseStaffNow(unit,spells[i]) ) { ret |= 2; }
	movs	r0, r5	@, unit
	ldrb	r1, [r6]	@ MEM[(u8 *)_63], MEM[(u8 *)_63]
	ldr	r3, .L106+8	@ tmp172,
	bl	.L14		@
@ SpellSystem.c:145: 			if ( CanUnitUseStaffNow(unit,spells[i]) ) { ret |= 2; }
	cmp	r0, #0	@ tmp188,
	beq	.L91		@,
@ SpellSystem.c:145: 			if ( CanUnitUseStaffNow(unit,spells[i]) ) { ret |= 2; }
	movs	r3, #2	@ tmp175,
	orrs	r4, r3	@ <retval>, tmp175
	b	.L91		@
.L107:
	.align	2
.L106:
	.word	GetItemAttributes
	.word	CanUnitUseWeaponNow
	.word	CanUnitUseStaffNow
	.size	NewGetUnitUseFlags, .-NewGetUnitUseFlags
	.align	1
	.global	CanUseAttackSpellsNow
	.syntax unified
	.code	16
	.thumb_func
	.type	CanUseAttackSpellsNow, %function
CanUseAttackSpellsNow:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ SpellSystem.c:238: {
	movs	r5, r0	@ unit, tmp128
@ SpellSystem.c:239: 	u8* spells = SpellsGetter(unit,type);
	bl	SpellsGetter		@
	movs	r4, r0	@ ivtmp.240, tmp130
.L109:
@ SpellSystem.c:240: 	for ( int i = 0 ; spells[i] ; i++ )
	ldrb	r0, [r4]	@ _8, MEM[(u8 *)_25]
@ SpellSystem.c:240: 	for ( int i = 0 ; spells[i] ; i++ )
	cmp	r0, #0	@ _8,
	bne	.L113		@,
.L108:
@ SpellSystem.c:248: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L113:
@ SpellSystem.c:242: 		if ( GetItemType(spells[i]) != ITYPE_STAFF && CanCastSpellNow(unit,spells[i]) )
	ldr	r3, .L115	@ tmp125,
	bl	.L14		@
@ SpellSystem.c:242: 		if ( GetItemType(spells[i]) != ITYPE_STAFF && CanCastSpellNow(unit,spells[i]) )
	cmp	r0, #4	@ tmp131,
	bne	.L110		@,
.L112:
	adds	r4, r4, #1	@ ivtmp.240,
	b	.L109		@
.L110:
@ SpellSystem.c:242: 		if ( GetItemType(spells[i]) != ITYPE_STAFF && CanCastSpellNow(unit,spells[i]) )
	movs	r0, r5	@, unit
	ldrb	r1, [r4]	@ MEM[(u8 *)_25], MEM[(u8 *)_25]
	bl	CanCastSpellNow		@
@ SpellSystem.c:242: 		if ( GetItemType(spells[i]) != ITYPE_STAFF && CanCastSpellNow(unit,spells[i]) )
	cmp	r0, #0	@ tmp132,
	beq	.L112		@,
@ SpellSystem.c:244: 			return 1;
	movs	r0, #1	@ <retval>,
	b	.L108		@
.L116:
	.align	2
.L115:
	.word	GetItemType
	.size	CanUseAttackSpellsNow, .-CanUseAttackSpellsNow
	.align	1
	.global	GetNthUsableSpell
	.syntax unified
	.code	16
	.thumb_func
	.type	GetNthUsableSpell, %function
GetNthUsableSpell:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r0, r1, r2, r4, r5, r6, r7, lr}	@
@ SpellSystem.c:253: {
	movs	r7, r1	@ n, tmp125
	movs	r1, r2	@ type, tmp126
	movs	r5, r0	@ unit, tmp124
@ SpellSystem.c:254: 	u8* spells = SpellsGetter(unit,type);
	bl	SpellsGetter		@
@ SpellSystem.c:255: 	int k = -1;
	movs	r6, #1	@ k,
@ SpellSystem.c:256: 	for ( int i = 0 ; spells[i] ; i++ )
	movs	r4, #0	@ <retval>,
@ SpellSystem.c:254: 	u8* spells = SpellsGetter(unit,type);
	str	r0, [sp, #4]	@ tmp127, %sfp
@ SpellSystem.c:255: 	int k = -1;
	rsbs	r6, r6, #0	@ k, k
.L118:
@ SpellSystem.c:256: 	for ( int i = 0 ; spells[i] ; i++ )
	ldr	r3, [sp, #4]	@ spells, %sfp
	ldrb	r1, [r3, r4]	@ _6, MEM[(u8 *)spells_17 + _1 * 1]
@ SpellSystem.c:256: 	for ( int i = 0 ; spells[i] ; i++ )
	cmp	r1, #0	@ _6,
	bne	.L121		@,
@ SpellSystem.c:264: 	return -1;
	movs	r4, #1	@ <retval>,
	rsbs	r4, r4, #0	@ <retval>, <retval>
.L117:
@ SpellSystem.c:265: }
	movs	r0, r4	@, <retval>
	@ sp needed	@
	pop	{r1, r2, r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L121:
@ SpellSystem.c:258: 		if ( CanCastSpellNow(unit,spells[i]) )
	movs	r0, r5	@, unit
	bl	CanCastSpellNow		@
@ SpellSystem.c:258: 		if ( CanCastSpellNow(unit,spells[i]) )
	cmp	r0, #0	@ tmp128,
	beq	.L119		@,
@ SpellSystem.c:260: 			k++;
	adds	r6, r6, #1	@ k,
@ SpellSystem.c:261: 			if ( k == n ) { return i; }
	cmp	r6, r7	@ k, n
	beq	.L117		@,
.L119:
@ SpellSystem.c:256: 	for ( int i = 0 ; spells[i] ; i++ )
	adds	r4, r4, #1	@ <retval>,
	b	.L118		@
	.size	GetNthUsableSpell, .-GetNthUsableSpell
	.align	1
	.global	DoesUnitKnowSpell
	.syntax unified
	.code	16
	.thumb_func
	.type	DoesUnitKnowSpell, %function
DoesUnitKnowSpell:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ SpellSystem.c:277: {
	movs	r4, r1	@ spell, tmp123
@ SpellSystem.c:279: 	u8* spells = SpellsGetter(unit,-1);
	movs	r1, #1	@,
	rsbs	r1, r1, #0	@,
	bl	SpellsGetter		@
.L126:
@ SpellSystem.c:280: 	for ( int i = 0 ; spells[i] ; i++ )
	ldrb	r3, [r0]	@ _3, MEM[(u8 *)_15]
@ SpellSystem.c:280: 	for ( int i = 0 ; spells[i] ; i++ )
	cmp	r3, #0	@ _3,
	bne	.L128		@,
@ SpellSystem.c:284: 	return 0;
	movs	r0, r3	@ <retval>, _3
.L125:
@ SpellSystem.c:285: }
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L128:
@ SpellSystem.c:282: 		if ( spell == spells[i] ) { return 1; }
	adds	r0, r0, #1	@ ivtmp.254,
	cmp	r3, r4	@ _3, spell
	bne	.L126		@,
@ SpellSystem.c:282: 		if ( spell == spells[i] ) { return 1; }
	movs	r0, #1	@ <retval>,
	b	.L125		@
	.size	DoesUnitKnowSpell, .-DoesUnitKnowSpell
	.align	1
	.global	InitGaidenSpellLearnPopup
	.syntax unified
	.code	16
	.thumb_func
	.type	InitGaidenSpellLearnPopup, %function
InitGaidenSpellLearnPopup:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ SpellSystem.c:183: 	if ( gBattleActor.levelPrevious != gBattleActor.unit.level ) { subject = &gBattleActor; }
	ldr	r4, .L140	@ tmp139,
	ldrb	r5, [r4]	@ tmp140,
@ SpellSystem.c:183: 	if ( gBattleActor.levelPrevious != gBattleActor.unit.level ) { subject = &gBattleActor; }
	movs	r4, #8	@ tmp142,
@ SpellSystem.c:184: 	if ( gBattleTarget.levelPrevious != gBattleTarget.unit.level ) { subject = &gBattleTarget; }
	movs	r1, #8	@ _8,
@ SpellSystem.c:183: 	if ( gBattleActor.levelPrevious != gBattleActor.unit.level ) { subject = &gBattleActor; }
	ldr	r0, .L140+4	@ tmp136,
@ SpellSystem.c:184: 	if ( gBattleTarget.levelPrevious != gBattleTarget.unit.level ) { subject = &gBattleTarget; }
	ldr	r3, .L140+8	@ tmp131,
	ldr	r2, .L140+12	@ tmp134,
@ SpellSystem.c:183: 	if ( gBattleActor.levelPrevious != gBattleActor.unit.level ) { subject = &gBattleActor; }
	ldrsb	r4, [r0, r4]	@ tmp142,
@ SpellSystem.c:184: 	if ( gBattleTarget.levelPrevious != gBattleTarget.unit.level ) { subject = &gBattleTarget; }
	ldrb	r2, [r2]	@ _17,
@ SpellSystem.c:184: 	if ( gBattleTarget.levelPrevious != gBattleTarget.unit.level ) { subject = &gBattleTarget; }
	ldrsb	r1, [r3, r1]	@ _8,* _8
@ SpellSystem.c:183: 	if ( gBattleActor.levelPrevious != gBattleActor.unit.level ) { subject = &gBattleActor; }
	cmp	r5, r4	@ tmp140, tmp142
	bne	.L131		@,
@ SpellSystem.c:184: 	if ( gBattleTarget.levelPrevious != gBattleTarget.unit.level ) { subject = &gBattleTarget; }
	cmp	r1, r2	@ _8, _17
	bne	.L135		@,
.L134:
@ SpellSystem.c:185: 	if ( !subject ) { return 0; } // If this isn't filled, we shouldn't show a popup.
	movs	r0, #0	@ <retval>,
.L130:
@ SpellSystem.c:194: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L131:
@ SpellSystem.c:184: 	if ( gBattleTarget.levelPrevious != gBattleTarget.unit.level ) { subject = &gBattleTarget; }
	cmp	r1, r2	@ _8, _17
	beq	.L132		@,
.L135:
@ SpellSystem.c:184: 	if ( gBattleTarget.levelPrevious != gBattleTarget.unit.level ) { subject = &gBattleTarget; }
	movs	r0, r3	@ subject, tmp131
.L132:
@ SpellSystem.c:187: 	u8* spells = SpellsGetterForLevel(&subject->unit,subject->unit.level,-1);
	movs	r1, #8	@ tmp144,
	movs	r2, #1	@,
	ldrsb	r1, [r0, r1]	@ tmp144,
	rsbs	r2, r2, #0	@,
	bl	SpellsGetterForLevel		@
@ SpellSystem.c:189: 	if ( *spells )
	ldrb	r1, [r0]	@ _12, *spells_23
@ SpellSystem.c:189: 	if ( *spells )
	cmp	r1, #0	@ _12,
	beq	.L134		@,
@ SpellSystem.c:191: 		gPopupItem = *spells|0xFF00;
	ldr	r2, .L140+16	@ tmp148,
@ SpellSystem.c:191: 		gPopupItem = *spells|0xFF00;
	ldr	r3, .L140+20	@ tmp145,
@ SpellSystem.c:191: 		gPopupItem = *spells|0xFF00;
	orrs	r2, r1	@ tmp147, _12
@ SpellSystem.c:192: 		return 1;
	movs	r0, #1	@ <retval>,
@ SpellSystem.c:191: 		gPopupItem = *spells|0xFF00;
	strh	r2, [r3]	@ tmp147, gPopupItem
@ SpellSystem.c:192: 		return 1;
	b	.L130		@
.L141:
	.align	2
.L140:
	.word	gBattleActor+112
	.word	gBattleActor
	.word	gBattleTarget
	.word	gBattleTarget+112
	.word	-256
	.word	gPopupItem
	.size	InitGaidenSpellLearnPopup, .-InitGaidenSpellLearnPopup
	.align	1
	.global	GetSpellCost
	.syntax unified
	.code	16
	.thumb_func
	.type	GetSpellCost, %function
GetSpellCost:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ SpellSystem.c:297: 	return GaidenSpellCostTable[GetItemIndex(spell)];
	ldr	r3, .L143	@ tmp118,
@ SpellSystem.c:298: }
	@ sp needed	@
@ SpellSystem.c:297: 	return GaidenSpellCostTable[GetItemIndex(spell)];
	bl	.L14		@
@ SpellSystem.c:297: 	return GaidenSpellCostTable[GetItemIndex(spell)];
	ldr	r3, .L143+4	@ tmp122,
	ldrb	r0, [r3, r0]	@ tmp121, GaidenSpellCostTable
@ SpellSystem.c:298: }
	pop	{r4}
	pop	{r1}
	bx	r1
.L144:
	.align	2
.L143:
	.word	GetItemIndex
	.word	GaidenSpellCostTable
	.size	GetSpellCost, .-GetSpellCost
	.align	1
	.global	HasSufficientHP
	.syntax unified
	.code	16
	.thumb_func
	.type	HasSufficientHP, %function
HasSufficientHP:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ SpellSystem.c:199: 	return unit->curHP > GetSpellCost(spell);
	movs	r4, #19	@ _2,
	ldrsb	r4, [r0, r4]	@ _2,* _2
@ SpellSystem.c:199: 	return unit->curHP > GetSpellCost(spell);
	movs	r0, r1	@, spell
	bl	GetSpellCost		@
@ SpellSystem.c:199: 	return unit->curHP > GetSpellCost(spell);
	movs	r3, #1	@ tmp121,
	cmp	r4, r0	@ _2, tmp130
	bgt	.L146		@,
	movs	r3, #0	@ tmp121,
.L146:
@ SpellSystem.c:200: }
	@ sp needed	@
	movs	r0, r3	@, tmp121
	pop	{r4}
	pop	{r1}
	bx	r1
	.size	HasSufficientHP, .-HasSufficientHP
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.type	GaidenMagicUMUsabilityExt, %function
GaidenMagicUMUsabilityExt:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, lr}	@
@ UnitMenu.c:18: 	u8* validList = gGenericBuffer; // Let's build a list of valid spells.
	ldr	r6, .L159	@ validList,
@ UnitMenu.c:21: 		if ( !CanCastSpellNow(gActiveUnit,spellList[i]|0xFF00) ) { continue; }
	movs	r7, #255	@ tmp142,
@ UnitMenu.c:17: {
	movs	r5, r0	@ ivtmp.276, tmp143
	movs	r4, r6	@ validList, validList
@ UnitMenu.c:21: 		if ( !CanCastSpellNow(gActiveUnit,spellList[i]|0xFF00) ) { continue; }
	lsls	r7, r7, #8	@ tmp142, tmp142,
.L148:
@ UnitMenu.c:19: 	for ( int i = 0 ; spellList[i] ; i++ )
	ldrb	r1, [r5]	@ _9, MEM[(u8 *)_42]
@ UnitMenu.c:19: 	for ( int i = 0 ; spellList[i] ; i++ )
	cmp	r1, #0	@ _9,
	bne	.L150		@,
@ UnitMenu.c:25: 	*validList = 0;
	strb	r1, [r6]	@ _9, *validList_15
@ UnitMenu.c:28: 	if ( !*validList ) { return 3; } // Return unusable if there are no valid spells.
	ldrb	r3, [r4]	@ MEM[(u8 *)&gGenericBuffer], MEM[(u8 *)&gGenericBuffer]
@ UnitMenu.c:28: 	if ( !*validList ) { return 3; } // Return unusable if there are no valid spells.
	movs	r0, #3	@ <retval>,
@ UnitMenu.c:28: 	if ( !*validList ) { return 3; } // Return unusable if there are no valid spells.
	cmp	r3, #0	@ MEM[(u8 *)&gGenericBuffer],
	beq	.L147		@,
.L152:
@ UnitMenu.c:29: 	for ( int i = 0 ; validList[i] ; i++ )
	ldrb	r1, [r4]	@ _30, MEM[(u8 *)_37]
@ UnitMenu.c:29: 	for ( int i = 0 ; validList[i] ; i++ )
	cmp	r1, #0	@ _30,
	bne	.L153		@,
@ UnitMenu.c:34: 	return 2; // There were valid spells, but we don't have enough HP to cast any of them. Return greyed out.
	movs	r0, #2	@ <retval>,
.L147:
@ UnitMenu.c:35: }
	@ sp needed	@
	pop	{r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L150:
@ UnitMenu.c:21: 		if ( !CanCastSpellNow(gActiveUnit,spellList[i]|0xFF00) ) { continue; }
	ldr	r3, .L159+4	@ tmp133,
	orrs	r1, r7	@ tmp131, tmp142
	ldr	r0, [r3]	@, gActiveUnit
	bl	CanCastSpellNow		@
@ UnitMenu.c:21: 		if ( !CanCastSpellNow(gActiveUnit,spellList[i]|0xFF00) ) { continue; }
	cmp	r0, #0	@ tmp144,
	beq	.L149		@,
@ UnitMenu.c:22: 		*validList = spellList[i];
	ldrb	r3, [r5]	@ _6, MEM[(u8 *)_42]
@ UnitMenu.c:22: 		*validList = spellList[i];
	strb	r3, [r6]	@ _6, *validList_15
@ UnitMenu.c:23: 		validList++;
	adds	r6, r6, #1	@ validList,
.L149:
	adds	r5, r5, #1	@ ivtmp.276,
	b	.L148		@
.L153:
@ UnitMenu.c:32: 		if ( HasSufficientHP(gActiveUnit,validList[i]) ) { return 1; } // We've found a spell we can cast! Return usable.
	ldr	r3, .L159+4	@ tmp139,
	ldr	r0, [r3]	@, gActiveUnit
	bl	HasSufficientHP		@
@ UnitMenu.c:32: 		if ( HasSufficientHP(gActiveUnit,validList[i]) ) { return 1; } // We've found a spell we can cast! Return usable.
	adds	r4, r4, #1	@ ivtmp.272,
	cmp	r0, #0	@ tmp145,
	beq	.L152		@,
@ UnitMenu.c:32: 		if ( HasSufficientHP(gActiveUnit,validList[i]) ) { return 1; } // We've found a spell we can cast! Return usable.
	movs	r0, #1	@ <retval>,
	b	.L147		@
.L160:
	.align	2
.L159:
	.word	gGenericBuffer
	.word	gActiveUnit
	.size	GaidenMagicUMUsabilityExt, .-GaidenMagicUMUsabilityExt
	.align	1
	.global	GaidenBlackMagicUMUsability
	.syntax unified
	.code	16
	.thumb_func
	.type	GaidenBlackMagicUMUsability, %function
GaidenBlackMagicUMUsability:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ UnitMenu.c:8: 	return GaidenMagicUMUsabilityExt(SpellsGetter(gActiveUnit,BLACK_MAGIC)); // This is a 0-terminated list of spells this character has learned.
	ldr	r3, .L162	@ tmp116,
@ UnitMenu.c:9: }
	@ sp needed	@
@ UnitMenu.c:8: 	return GaidenMagicUMUsabilityExt(SpellsGetter(gActiveUnit,BLACK_MAGIC)); // This is a 0-terminated list of spells this character has learned.
	movs	r1, #1	@,
	ldr	r0, [r3]	@, gActiveUnit
	bl	SpellsGetter		@
	bl	GaidenMagicUMUsabilityExt		@
@ UnitMenu.c:9: }
	pop	{r4}
	pop	{r1}
	bx	r1
.L163:
	.align	2
.L162:
	.word	gActiveUnit
	.size	GaidenBlackMagicUMUsability, .-GaidenBlackMagicUMUsability
	.align	1
	.global	GaidenWhiteMagicUMUsability
	.syntax unified
	.code	16
	.thumb_func
	.type	GaidenWhiteMagicUMUsability, %function
GaidenWhiteMagicUMUsability:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ UnitMenu.c:13: 	return GaidenMagicUMUsabilityExt(SpellsGetter(gActiveUnit,WHITE_MAGIC));
	ldr	r3, .L165	@ tmp116,
@ UnitMenu.c:14: }
	@ sp needed	@
@ UnitMenu.c:13: 	return GaidenMagicUMUsabilityExt(SpellsGetter(gActiveUnit,WHITE_MAGIC));
	movs	r1, #2	@,
	ldr	r0, [r3]	@, gActiveUnit
	bl	SpellsGetter		@
	bl	GaidenMagicUMUsabilityExt		@
@ UnitMenu.c:14: }
	pop	{r4}
	pop	{r1}
	bx	r1
.L166:
	.align	2
.L165:
	.word	gActiveUnit
	.size	GaidenWhiteMagicUMUsability, .-GaidenWhiteMagicUMUsability
	.align	1
	.global	SetRoundForSpell
	.syntax unified
	.code	16
	.thumb_func
	.type	SetRoundForSpell, %function
SetRoundForSpell:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ SpellSystem.c:163: 	if ( HasSufficientHP(&unit->unit,unit->weapon) )
	movs	r5, r0	@ tmp133, unit
	adds	r5, r5, #72	@ tmp133,
@ SpellSystem.c:162: {
	movs	r4, r1	@ buffer, tmp151
@ SpellSystem.c:163: 	if ( HasSufficientHP(&unit->unit,unit->weapon) )
	ldrh	r1, [r5]	@ tmp134,
	bl	HasSufficientHP		@
@ SpellSystem.c:163: 	if ( HasSufficientHP(&unit->unit,unit->weapon) )
	cmp	r0, #0	@ tmp152,
	beq	.L168		@,
@ SpellSystem.c:165: 		int cost = GetSpellCost(unit->weapon);
	ldrh	r0, [r5]	@ MEM[(short unsigned int *)unit_7(D) + 72B], MEM[(short unsigned int *)unit_7(D) + 72B]
	bl	GetSpellCost		@
@ SpellSystem.c:167: 		buffer->attributes |= BATTLE_HIT_ATTR_HPSTEAL; // "HP drain" bit.
	movs	r3, #128	@ tmp141,
	ldr	r2, [r4]	@ tmp140,* buffer
	lsls	r3, r3, #1	@ tmp141, tmp141,
	orrs	r3, r2	@ tmp139, tmp140
	str	r3, [r4]	@ tmp139,* buffer
@ SpellSystem.c:169: 		buffer->damage -= cost;
	ldrb	r3, [r4, #5]	@ tmp143,
	subs	r3, r3, r0	@ tmp145, tmp143, tmp153
	strb	r3, [r4, #5]	@ tmp145, buffer_10(D)->damage
.L167:
@ SpellSystem.c:176: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L168:
@ SpellSystem.c:174: 		buffer->attributes |= BATTLE_HIT_ATTR_5; // This bit is checked in an external hack I've made.
	movs	r3, #32	@ tmp149,
	ldr	r2, [r4]	@ tmp148,* buffer
	orrs	r3, r2	@ tmp147, tmp148
	str	r3, [r4]	@ tmp147,* buffer
@ SpellSystem.c:176: }
	b	.L167		@
	.size	SetRoundForSpell, .-SetRoundForSpell
	.align	1
	.global	Proc_GaidenMagicHPCost
	.syntax unified
	.code	16
	.thumb_func
	.type	Proc_GaidenMagicHPCost, %function
Proc_GaidenMagicHPCost:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ SpellSystem.c:155: 	if ( GetUnitEquippedWeaponSlot(&attacker->unit) == 9 ) // Instead of checking against UsingSpellMenu, we do this to cover the case of defense.
	ldr	r3, .L172	@ tmp119,
@ SpellSystem.c:153: {
	movs	r4, r0	@ attacker, tmp120
	movs	r5, r2	@ buffer, tmp121
@ SpellSystem.c:155: 	if ( GetUnitEquippedWeaponSlot(&attacker->unit) == 9 ) // Instead of checking against UsingSpellMenu, we do this to cover the case of defense.
	bl	.L14		@
@ SpellSystem.c:155: 	if ( GetUnitEquippedWeaponSlot(&attacker->unit) == 9 ) // Instead of checking against UsingSpellMenu, we do this to cover the case of defense.
	cmp	r0, #9	@ tmp122,
	bne	.L170		@,
@ SpellSystem.c:157: 		SetRoundForSpell(attacker,buffer);
	movs	r1, r5	@, buffer
	movs	r0, r4	@, attacker
	bl	SetRoundForSpell		@
.L170:
@ SpellSystem.c:159: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L173:
	.align	2
.L172:
	.word	GetUnitEquippedWeaponSlot
	.size	Proc_GaidenMagicHPCost, .-Proc_GaidenMagicHPCost
	.align	1
	.global	GetFirstAttackSpell
	.syntax unified
	.code	16
	.thumb_func
	.type	GetFirstAttackSpell, %function
GetFirstAttackSpell:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
@ SpellSystem.c:302: 	u8* spells = SpellsGetter(unit,-1);
	movs	r1, #1	@,
@ SpellSystem.c:301: {
	push	{r4, r5, r6, lr}	@
@ SpellSystem.c:302: 	u8* spells = SpellsGetter(unit,-1);
	rsbs	r1, r1, #0	@,
	bl	SpellsGetter		@
	movs	r4, r0	@ ivtmp.297, tmp126
.L175:
@ SpellSystem.c:304: 	for ( int i = 0 ; spells[i] ; i++ )
	ldrb	r0, [r4]	@ _7, MEM[(u8 *)_6]
	movs	r5, r4	@ _6, ivtmp.297
@ SpellSystem.c:304: 	for ( int i = 0 ; spells[i] ; i++ )
	cmp	r0, #0	@ _7,
	beq	.L174		@,
@ SpellSystem.c:306: 		if ( GetItemType(spells[i]) != ITYPE_STAFF ) { spell = spells[i]; break; } // Ensure that the spell we could counter with would be an attack spell.
	ldr	r3, .L180	@ tmp123,
	bl	.L14		@
@ SpellSystem.c:306: 		if ( GetItemType(spells[i]) != ITYPE_STAFF ) { spell = spells[i]; break; } // Ensure that the spell we could counter with would be an attack spell.
	adds	r4, r4, #1	@ ivtmp.297,
	cmp	r0, #4	@ tmp127,
	beq	.L175		@,
@ SpellSystem.c:306: 		if ( GetItemType(spells[i]) != ITYPE_STAFF ) { spell = spells[i]; break; } // Ensure that the spell we could counter with would be an attack spell.
	ldrb	r0, [r5]	@ <retval>, *_6
.L174:
@ SpellSystem.c:309: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L181:
	.align	2
.L180:
	.word	GetItemType
	.size	GetFirstAttackSpell, .-GetFirstAttackSpell
	.align	1
	.global	NewGetUnitEquippedWeapon
	.syntax unified
	.code	16
	.thumb_func
	.type	NewGetUnitEquippedWeapon, %function
NewGetUnitEquippedWeapon:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ SpellSystem.c:45: {
	movs	r6, r0	@ unit, tmp162
@ SpellSystem.c:269: 	for ( int i = 0 ; i < 5 ; i++ )
	movs	r5, #0	@ i,
.L185:
@ SpellSystem.c:271: 		if ( CanUnitUseWeapon(unit,unit->items[i]) ) { return unit->items[i]; }
	movs	r3, r6	@ tmp135, unit
@ SpellSystem.c:271: 		if ( CanUnitUseWeapon(unit,unit->items[i]) ) { return unit->items[i]; }
	lsls	r2, r5, #1	@ tmp136, i,
@ SpellSystem.c:271: 		if ( CanUnitUseWeapon(unit,unit->items[i]) ) { return unit->items[i]; }
	adds	r3, r3, #30	@ tmp135,
	ldrh	r1, [r3, r2]	@ MEM[(short unsigned int *)_7 + _22 * 1], MEM[(short unsigned int *)_7 + _22 * 1]
	movs	r0, r6	@, unit
	ldr	r3, .L199	@ tmp138,
	bl	.L14		@
	subs	r4, r0, #0	@ <retval>, tmp163,
@ SpellSystem.c:271: 		if ( CanUnitUseWeapon(unit,unit->items[i]) ) { return unit->items[i]; }
	beq	.L183		@,
@ SpellSystem.c:271: 		if ( CanUnitUseWeapon(unit,unit->items[i]) ) { return unit->items[i]; }
	adds	r5, r5, #12	@ tmp139,
	lsls	r5, r5, #1	@ tmp140, tmp139,
	adds	r5, r6, r5	@ tmp141, unit, tmp140
	ldrh	r4, [r5, #6]	@ <retval>, *unit_20(D)
.L184:
@ SpellSystem.c:47: 	if ( gChapterData.currentPhase == ( unit->index & 0xC0 ) )
	ldr	r3, .L199+4	@ tmp143,
@ SpellSystem.c:47: 	if ( gChapterData.currentPhase == ( unit->index & 0xC0 ) )
	movs	r2, #11	@ _3,
@ SpellSystem.c:47: 	if ( gChapterData.currentPhase == ( unit->index & 0xC0 ) )
	ldrb	r1, [r3, #15]	@ tmp144,
@ SpellSystem.c:47: 	if ( gChapterData.currentPhase == ( unit->index & 0xC0 ) )
	movs	r3, #192	@ tmp146,
@ SpellSystem.c:47: 	if ( gChapterData.currentPhase == ( unit->index & 0xC0 ) )
	ldrsb	r2, [r6, r2]	@ _3,* _3
@ SpellSystem.c:47: 	if ( gChapterData.currentPhase == ( unit->index & 0xC0 ) )
	ands	r3, r2	@ tmp145, _3
@ SpellSystem.c:47: 	if ( gChapterData.currentPhase == ( unit->index & 0xC0 ) )
	cmp	r1, r3	@ tmp144, tmp145
	bne	.L186		@,
@ SpellSystem.c:50: 		if ( !UsingSpellMenu ) { return vanillaEquipped; }
	ldr	r3, .L199+8	@ tmp147,
@ SpellSystem.c:50: 		if ( !UsingSpellMenu ) { return vanillaEquipped; }
	ldrb	r3, [r3]	@ UsingSpellMenu, UsingSpellMenu
	cmp	r3, #0	@ UsingSpellMenu,
	beq	.L182		@,
@ SpellSystem.c:54: 			if ( unit->index == gBattleTarget.unit.index && GetItemType(SelectedSpell) == ITYPE_STAFF )
	ldr	r3, .L199+12	@ tmp150,
@ SpellSystem.c:54: 			if ( unit->index == gBattleTarget.unit.index && GetItemType(SelectedSpell) == ITYPE_STAFF )
	ldrb	r3, [r3, #11]	@ tmp151,
@ SpellSystem.c:54: 			if ( unit->index == gBattleTarget.unit.index && GetItemType(SelectedSpell) == ITYPE_STAFF )
	ldr	r5, .L199+16	@ tmp149,
@ SpellSystem.c:54: 			if ( unit->index == gBattleTarget.unit.index && GetItemType(SelectedSpell) == ITYPE_STAFF )
	lsls	r3, r3, #24	@ tmp151, tmp151,
@ SpellSystem.c:54: 			if ( unit->index == gBattleTarget.unit.index && GetItemType(SelectedSpell) == ITYPE_STAFF )
	ldrb	r0, [r5]	@ pretmp_21, SelectedSpell
@ SpellSystem.c:54: 			if ( unit->index == gBattleTarget.unit.index && GetItemType(SelectedSpell) == ITYPE_STAFF )
	asrs	r3, r3, #24	@ tmp151, tmp151,
	cmp	r3, r2	@ tmp151, _3
	beq	.L188		@,
.L190:
@ SpellSystem.c:57: 			} else { return SelectedSpell|0xFF00; }
	movs	r4, #255	@ tmp154,
	ldrb	r3, [r5]	@ SelectedSpell, SelectedSpell
	lsls	r4, r4, #8	@ tmp154, tmp154,
.L198:
@ SpellSystem.c:68: 			return ( spell ? spell|0xFF00 : 0 );
	orrs	r4, r3	@ <retval>, tmp159
	b	.L182		@
.L183:
@ SpellSystem.c:269: 	for ( int i = 0 ; i < 5 ; i++ )
	adds	r5, r5, #1	@ i,
@ SpellSystem.c:269: 	for ( int i = 0 ; i < 5 ; i++ )
	cmp	r5, #5	@ i,
	bne	.L185		@,
	b	.L184		@
.L188:
@ SpellSystem.c:54: 			if ( unit->index == gBattleTarget.unit.index && GetItemType(SelectedSpell) == ITYPE_STAFF )
	ldr	r3, .L199+20	@ tmp155,
	bl	.L14		@
@ SpellSystem.c:54: 			if ( unit->index == gBattleTarget.unit.index && GetItemType(SelectedSpell) == ITYPE_STAFF )
	cmp	r0, #4	@ tmp164,
	bne	.L190		@,
.L182:
@ SpellSystem.c:72: }
	@ sp needed	@
	movs	r0, r4	@, <retval>
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L186:
@ SpellSystem.c:64: 		if ( GetUnitEquippedWeaponSlot(unit) == 9 )
	movs	r0, r6	@, unit
	ldr	r3, .L199+24	@ tmp156,
	bl	.L14		@
@ SpellSystem.c:64: 		if ( GetUnitEquippedWeaponSlot(unit) == 9 )
	cmp	r0, #9	@ tmp165,
	bne	.L182		@,
@ SpellSystem.c:67: 			int spell = GetFirstAttackSpell(unit);
	movs	r0, r6	@, unit
	bl	GetFirstAttackSpell		@
	subs	r4, r0, #0	@ <retval>, tmp166,
@ SpellSystem.c:68: 			return ( spell ? spell|0xFF00 : 0 );
	beq	.L182		@,
@ SpellSystem.c:68: 			return ( spell ? spell|0xFF00 : 0 );
	movs	r3, #255	@ tmp159,
	lsls	r3, r3, #8	@ tmp159, tmp159,
	b	.L198		@
.L200:
	.align	2
.L199:
	.word	CanUnitUseWeapon
	.word	gChapterData
	.word	UsingSpellMenu
	.word	gBattleTarget
	.word	SelectedSpell
	.word	GetItemType
	.word	GetUnitEquippedWeaponSlot
	.size	NewGetUnitEquippedWeapon, .-NewGetUnitEquippedWeapon
	.align	1
	.global	NewGetUnitEquippedWeaponSlot
	.syntax unified
	.code	16
	.thumb_func
	.type	NewGetUnitEquippedWeaponSlot, %function
NewGetUnitEquippedWeaponSlot:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r0, r1, r2, r4, r5, r6, r7, lr}	@
@ SpellSystem.c:87: 	if ( UsingSpellMenu && unit->index == gBattleActor.unit.index && CanUnitUseWeapon(unit,SelectedSpell) ) { return 9; }
	ldr	r3, .L218	@ tmp144,
@ SpellSystem.c:87: 	if ( UsingSpellMenu && unit->index == gBattleActor.unit.index && CanUnitUseWeapon(unit,SelectedSpell) ) { return 9; }
	ldrb	r3, [r3]	@ UsingSpellMenu, UsingSpellMenu
@ SpellSystem.c:85: {
	movs	r5, r0	@ unit, tmp185
	ldr	r6, .L218+4	@ tmp181,
@ SpellSystem.c:87: 	if ( UsingSpellMenu && unit->index == gBattleActor.unit.index && CanUnitUseWeapon(unit,SelectedSpell) ) { return 9; }
	cmp	r3, #0	@ UsingSpellMenu,
	bne	.L202		@,
.L205:
@ SpellSystem.c:89: 	if ( (gBattleStats.config & (BATTLE_CONFIG_REAL|BATTLE_CONFIG_SIMULATE)) && unit->index == gBattleTarget.unit.index )
	ldr	r7, .L218+8	@ tmp146,
@ SpellSystem.c:89: 	if ( (gBattleStats.config & (BATTLE_CONFIG_REAL|BATTLE_CONFIG_SIMULATE)) && unit->index == gBattleTarget.unit.index )
	ldrh	r2, [r7]	@ gBattleStats, gBattleStats
	movs	r1, r5	@ tmp183, unit
	movs	r3, #3	@ tmp150,
	movs	r4, r2	@ tmp152, gBattleStats
	adds	r1, r1, #30	@ tmp183,
	str	r1, [sp, #4]	@ tmp183, %sfp
	ands	r4, r3	@ tmp152, tmp150
	tst	r2, r3	@ gBattleStats, tmp150
	bne	.L203		@,
.L210:
@ SpellSystem.c:112: 			if ( CanUnitUseWeapon(unit,unit->items[i]) ) { return i; }
	ldr	r2, [sp, #4]	@ tmp183, %sfp
@ SpellSystem.c:112: 			if ( CanUnitUseWeapon(unit,unit->items[i]) ) { return i; }
	lsls	r3, r4, #1	@ tmp177, <retval>,
@ SpellSystem.c:112: 			if ( CanUnitUseWeapon(unit,unit->items[i]) ) { return i; }
	movs	r0, r5	@, unit
	ldrh	r1, [r2, r3]	@ MEM[(short unsigned int *)_52 + _51 * 1], MEM[(short unsigned int *)_52 + _51 * 1]
	bl	.L15		@
@ SpellSystem.c:112: 			if ( CanUnitUseWeapon(unit,unit->items[i]) ) { return i; }
	cmp	r0, #0	@ tmp190,
	bne	.L201		@,
@ SpellSystem.c:110: 		for ( int i = 0 ; i < 5 ; i++ )
	adds	r4, r4, #1	@ <retval>,
@ SpellSystem.c:110: 		for ( int i = 0 ; i < 5 ; i++ )
	cmp	r4, #5	@ <retval>,
	bne	.L210		@,
	b	.L211		@
.L202:
@ SpellSystem.c:87: 	if ( UsingSpellMenu && unit->index == gBattleActor.unit.index && CanUnitUseWeapon(unit,SelectedSpell) ) { return 9; }
	movs	r2, #11	@ tmp155,
@ SpellSystem.c:87: 	if ( UsingSpellMenu && unit->index == gBattleActor.unit.index && CanUnitUseWeapon(unit,SelectedSpell) ) { return 9; }
	ldr	r3, .L218+12	@ tmp154,
@ SpellSystem.c:87: 	if ( UsingSpellMenu && unit->index == gBattleActor.unit.index && CanUnitUseWeapon(unit,SelectedSpell) ) { return 9; }
	ldrb	r3, [r3, #11]	@ tmp156,
	ldrsb	r2, [r0, r2]	@ tmp155,
	lsls	r3, r3, #24	@ tmp156, tmp156,
	asrs	r3, r3, #24	@ tmp156, tmp156,
	cmp	r2, r3	@ tmp155, tmp156
	bne	.L205		@,
@ SpellSystem.c:87: 	if ( UsingSpellMenu && unit->index == gBattleActor.unit.index && CanUnitUseWeapon(unit,SelectedSpell) ) { return 9; }
	ldr	r3, .L218+16	@ tmp157,
	ldrb	r1, [r3]	@ SelectedSpell, SelectedSpell
	bl	.L15		@
@ SpellSystem.c:87: 	if ( UsingSpellMenu && unit->index == gBattleActor.unit.index && CanUnitUseWeapon(unit,SelectedSpell) ) { return 9; }
	cmp	r0, #0	@ tmp186,
	beq	.L205		@,
.L206:
@ SpellSystem.c:87: 	if ( UsingSpellMenu && unit->index == gBattleActor.unit.index && CanUnitUseWeapon(unit,SelectedSpell) ) { return 9; }
	movs	r4, #9	@ <retval>,
	b	.L201		@
.L203:
@ SpellSystem.c:89: 	if ( (gBattleStats.config & (BATTLE_CONFIG_REAL|BATTLE_CONFIG_SIMULATE)) && unit->index == gBattleTarget.unit.index )
	movs	r2, #11	@ tmp161,
@ SpellSystem.c:89: 	if ( (gBattleStats.config & (BATTLE_CONFIG_REAL|BATTLE_CONFIG_SIMULATE)) && unit->index == gBattleTarget.unit.index )
	ldr	r3, .L218+20	@ tmp160,
@ SpellSystem.c:89: 	if ( (gBattleStats.config & (BATTLE_CONFIG_REAL|BATTLE_CONFIG_SIMULATE)) && unit->index == gBattleTarget.unit.index )
	ldrb	r3, [r3, #11]	@ tmp162,
	ldrsb	r2, [r5, r2]	@ tmp161,
	lsls	r3, r3, #24	@ tmp162, tmp162,
	movs	r4, #0	@ <retval>,
	asrs	r3, r3, #24	@ tmp162, tmp162,
	cmp	r2, r3	@ tmp161, tmp162
	bne	.L210		@,
@ SpellSystem.c:91: 		int spell = GetFirstAttackSpell(unit);
	movs	r0, r5	@, unit
	bl	GetFirstAttackSpell		@
	str	r0, [sp]	@ tmp187, %sfp
.L209:
@ SpellSystem.c:96: 			if ( CanUnitUseWeapon(unit,unit->items[i]) )
	ldr	r2, [sp, #4]	@ tmp183, %sfp
@ SpellSystem.c:96: 			if ( CanUnitUseWeapon(unit,unit->items[i]) )
	lsls	r3, r4, #1	@ tmp164, <retval>,
@ SpellSystem.c:96: 			if ( CanUnitUseWeapon(unit,unit->items[i]) )
	movs	r0, r5	@, unit
	ldrh	r1, [r2, r3]	@ MEM[(short unsigned int *)_48 + _8 * 1], MEM[(short unsigned int *)_48 + _8 * 1]
	bl	.L15		@
@ SpellSystem.c:96: 			if ( CanUnitUseWeapon(unit,unit->items[i]) )
	cmp	r0, #0	@ tmp188,
	beq	.L207		@,
@ SpellSystem.c:99: 				if ( !gCan_Attack_Target(unit->items[i],gBattleStats.range,unit) )
	movs	r3, r4	@ tmp169, <retval>
	adds	r3, r3, #12	@ tmp169,
	lsls	r3, r3, #1	@ tmp170, tmp169,
	adds	r3, r5, r3	@ tmp171, unit, tmp170
@ SpellSystem.c:99: 				if ( !gCan_Attack_Target(unit->items[i],gBattleStats.range,unit) )
	ldrh	r0, [r3, #6]	@ tmp173, *unit_33(D)
	ldr	r3, .L218+24	@ tmp174,
	movs	r2, r5	@, unit
	ldrb	r1, [r7, #2]	@ tmp168,
	ldr	r3, [r3]	@ gCan_Attack_Target, gCan_Attack_Target
	bl	.L14		@
@ SpellSystem.c:99: 				if ( !gCan_Attack_Target(unit->items[i],gBattleStats.range,unit) )
	cmp	r0, #0	@ tmp189,
	bne	.L201		@,
@ SpellSystem.c:101: 					return ( spell ? 9 : i );
	ldr	r3, [sp]	@ spell, %sfp
	cmp	r3, #0	@ spell,
	bne	.L206		@,
.L201:
@ SpellSystem.c:116: }
	@ sp needed	@
	movs	r0, r4	@, <retval>
	pop	{r1, r2, r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L207:
@ SpellSystem.c:94: 		for ( int i = 0 ; i < 5 ; i++ )
	adds	r4, r4, #1	@ <retval>,
@ SpellSystem.c:94: 		for ( int i = 0 ; i < 5 ; i++ )
	cmp	r4, #5	@ <retval>,
	bne	.L209		@,
@ SpellSystem.c:106: 		return ( spell ? 9 : -1 );
	ldr	r3, [sp]	@ spell, %sfp
	cmp	r3, #0	@ spell,
	bne	.L206		@,
.L211:
@ SpellSystem.c:106: 		return ( spell ? 9 : -1 );
	movs	r4, #1	@ <retval>,
	rsbs	r4, r4, #0	@ <retval>, <retval>
	b	.L201		@
.L219:
	.align	2
.L218:
	.word	UsingSpellMenu
	.word	CanUnitUseWeapon
	.word	gBattleStats
	.word	gBattleActor
	.word	SelectedSpell
	.word	gBattleTarget
	.word	gCan_Attack_Target
	.size	NewGetUnitEquippedWeaponSlot, .-NewGetUnitEquippedWeaponSlot
	.align	1
	.global	Target_Routine_For_Fortify
	.syntax unified
	.code	16
	.thumb_func
	.type	Target_Routine_For_Fortify, %function
Target_Routine_For_Fortify:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ SpellSystem.c:314: 	if ( UsingSpellMenu )
	ldr	r3, .L223	@ tmp123,
@ SpellSystem.c:314: 	if ( UsingSpellMenu )
	ldrb	r3, [r3]	@ UsingSpellMenu, UsingSpellMenu
	cmp	r3, #0	@ UsingSpellMenu,
	beq	.L221		@,
@ SpellSystem.c:316: 		item = SelectedSpell|0xFF00;
	ldr	r3, .L223+4	@ tmp125,
	ldrb	r2, [r3]	@ SelectedSpell, SelectedSpell
@ SpellSystem.c:316: 		item = SelectedSpell|0xFF00;
	movs	r3, #255	@ tmp128,
	lsls	r3, r3, #8	@ tmp128, tmp128,
	orrs	r2, r3	@ item, tmp128
.L222:
@ SpellSystem.c:322: 	gHealStaff_RangeSetup(unit,0,item);
	ldr	r3, .L223+8	@ tmp137,
@ SpellSystem.c:323: }
	@ sp needed	@
@ SpellSystem.c:322: 	gHealStaff_RangeSetup(unit,0,item);
	movs	r1, #0	@,
	ldr	r3, [r3]	@ gHealStaff_RangeSetup, gHealStaff_RangeSetup
	bl	.L14		@
@ SpellSystem.c:323: }
	pop	{r4}
	pop	{r0}
	bx	r0
.L221:
@ SpellSystem.c:320: 		item = unit->unit.items[gActionData.itemSlotIndex];
	ldr	r3, .L223+12	@ tmp131,
	ldrb	r3, [r3, #18]	@ tmp132,
@ SpellSystem.c:320: 		item = unit->unit.items[gActionData.itemSlotIndex];
	adds	r3, r3, #12	@ tmp133,
	lsls	r3, r3, #1	@ tmp134, tmp133,
	adds	r3, r0, r3	@ tmp135, unit, tmp134
	ldrh	r2, [r3, #6]	@ item, *unit_11(D)
	b	.L222		@
.L224:
	.align	2
.L223:
	.word	UsingSpellMenu
	.word	SelectedSpell
	.word	gHealStaff_RangeSetup
	.word	gActionData
	.size	Target_Routine_For_Fortify, .-Target_Routine_For_Fortify
	.align	1
	.global	GaidenZeroOutSpellVariables
	.syntax unified
	.code	16
	.thumb_func
	.type	GaidenZeroOutSpellVariables, %function
GaidenZeroOutSpellVariables:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
@ SpellSystem.c:327: 	UsingSpellMenu = 0;
	movs	r3, #0	@ tmp114,
@ SpellSystem.c:330: }
	@ sp needed	@
@ SpellSystem.c:327: 	UsingSpellMenu = 0;
	ldr	r2, .L226	@ tmp113,
	strb	r3, [r2]	@ tmp114, UsingSpellMenu
@ SpellSystem.c:328: 	SelectedSpell = 0;
	ldr	r2, .L226+4	@ tmp116,
	strb	r3, [r2]	@ tmp114, SelectedSpell
@ SpellSystem.c:329: 	DidSelectSpell = 0;
	ldr	r2, .L226+8	@ tmp119,
	strb	r3, [r2]	@ tmp114, DidSelectSpell
@ SpellSystem.c:330: }
	bx	lr
.L227:
	.align	2
.L226:
	.word	UsingSpellMenu
	.word	SelectedSpell
	.word	DidSelectSpell
	.size	GaidenZeroOutSpellVariables, .-GaidenZeroOutSpellVariables
	.align	1
	.global	GetUnitRangeMaskForSpells
	.syntax unified
	.code	16
	.thumb_func
	.type	GetUnitRangeMaskForSpells, %function
GetUnitRangeMaskForSpells:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r0, r1, r2, r4, r5, r6, r7, lr}	@
@ RangeDisplay.c:42: 	u8* spells = SpellsGetter(unit,(UsingSpellMenu ? UsingSpellMenu : -1)); // If UsingSpellMenu is nonzero, only get Gaiden spells of that type.
	ldr	r3, .L243	@ tmp130,
@ RangeDisplay.c:40: {
	str	r1, [sp, #4]	@ tmp139, %sfp
@ RangeDisplay.c:42: 	u8* spells = SpellsGetter(unit,(UsingSpellMenu ? UsingSpellMenu : -1)); // If UsingSpellMenu is nonzero, only get Gaiden spells of that type.
	ldrb	r1, [r3]	@ UsingSpellMenu.67_1, UsingSpellMenu
@ RangeDisplay.c:40: {
	movs	r7, r0	@ unit, tmp138
@ RangeDisplay.c:42: 	u8* spells = SpellsGetter(unit,(UsingSpellMenu ? UsingSpellMenu : -1)); // If UsingSpellMenu is nonzero, only get Gaiden spells of that type.
	cmp	r1, #0	@ UsingSpellMenu.67_1,
	bne	.L229		@,
	subs	r1, r1, #1	@ iftmp.66_17,
.L229:
@ RangeDisplay.c:41: 	long long current = 0;
	movs	r5, #0	@ <retval>,
@ RangeDisplay.c:42: 	u8* spells = SpellsGetter(unit,(UsingSpellMenu ? UsingSpellMenu : -1)); // If UsingSpellMenu is nonzero, only get Gaiden spells of that type.
	movs	r0, r7	@, unit
	bl	SpellsGetter		@
@ RangeDisplay.c:41: 	long long current = 0;
	movs	r4, r5	@ <retval>, <retval>
@ RangeDisplay.c:42: 	u8* spells = SpellsGetter(unit,(UsingSpellMenu ? UsingSpellMenu : -1)); // If UsingSpellMenu is nonzero, only get Gaiden spells of that type.
	str	r0, [sp]	@ tmp140, %sfp
.L230:
@ RangeDisplay.c:43: 	for ( int i = 0 ; spells[i] ; i++ )
	ldr	r3, [sp]	@ ivtmp.343, %sfp
	ldrb	r6, [r3]	@ _13, MEM[(u8 *)_37]
@ RangeDisplay.c:43: 	for ( int i = 0 ; spells[i] ; i++ )
	cmp	r6, #0	@ _13,
	bne	.L235		@,
@ RangeDisplay.c:56: }
	movs	r0, r5	@, <retval>
	movs	r1, r4	@, <retval>
	add	sp, sp, #12	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7}
	pop	{r2}
	bx	r2
.L235:
@ RangeDisplay.c:45: 		int spell = spells[i]|0xFF00;
	movs	r3, #255	@ tmp164,
	lsls	r3, r3, #8	@ tmp164, tmp164,
	orrs	r6, r3	@ spell, tmp164
@ RangeDisplay.c:46: 		if ( usability == NULL )
	ldr	r3, [sp, #4]	@ usability, %sfp
@ RangeDisplay.c:48: 			if ( CanCastSpell(unit,spell) ) { current = IncorporateNewRange(current,gGet_Item_Range(unit,spell)); }
	movs	r1, r6	@, spell
	movs	r0, r7	@, unit
@ RangeDisplay.c:46: 		if ( usability == NULL )
	cmp	r3, #0	@ usability,
	bne	.L231		@,
@ RangeDisplay.c:48: 			if ( CanCastSpell(unit,spell) ) { current = IncorporateNewRange(current,gGet_Item_Range(unit,spell)); }
	bl	CanCastSpell		@
.L242:
@ RangeDisplay.c:52: 			if ( usability(unit,spell) ) { current = IncorporateNewRange(current,gGet_Item_Range(unit,spell)); }
	cmp	r0, #0	@ tmp144,
	beq	.L233		@,
@ RangeDisplay.c:52: 			if ( usability(unit,spell) ) { current = IncorporateNewRange(current,gGet_Item_Range(unit,spell)); }
	ldr	r3, .L243+4	@ tmp134,
	movs	r1, r6	@, spell
	ldr	r3, [r3]	@ gGet_Item_Range, gGet_Item_Range
	movs	r0, r7	@, unit
	bl	.L14		@
	movs	r2, r0	@ _10, tmp159
	movs	r3, r1	@ _10, tmp160
	movs	r0, r5	@, <retval>
	movs	r1, r4	@, <retval>
	bl	IncorporateNewRange		@
	movs	r5, r0	@ <retval>, tmp161
	movs	r4, r1	@ <retval>, tmp162
.L233:
	ldr	r3, [sp]	@ ivtmp.343, %sfp
	adds	r3, r3, #1	@ ivtmp.343,
	str	r3, [sp]	@ ivtmp.343, %sfp
	b	.L230		@
.L231:
@ RangeDisplay.c:52: 			if ( usability(unit,spell) ) { current = IncorporateNewRange(current,gGet_Item_Range(unit,spell)); }
	ldr	r3, [sp, #4]	@ usability, %sfp
	bl	.L14		@
	b	.L242		@
.L244:
	.align	2
.L243:
	.word	UsingSpellMenu
	.word	gGet_Item_Range
	.size	GetUnitRangeMaskForSpells, .-GetUnitRangeMaskForSpells
	.align	1
	.global	Return_Range_Bitfield
	.syntax unified
	.code	16
	.thumb_func
	.type	Return_Range_Bitfield, %function
Return_Range_Bitfield:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
@ RangeDisplay.c:11: 	if ( slot == -1 || slot == -2 )
	movs	r3, r1	@ slot, tmp148
@ RangeDisplay.c:9: {
	push	{r4, r5, r6, r7, lr}	@
	sub	sp, sp, #20	@,,
@ RangeDisplay.c:9: {
	movs	r6, r0	@ unit, tmp147
	str	r1, [sp, #4]	@ tmp148, %sfp
	str	r2, [sp, #8]	@ tmp149, %sfp
@ RangeDisplay.c:11: 	if ( slot == -1 || slot == -2 )
	adds	r3, r3, #2	@ tmp175, slot,
	bcc	.L246		@,
@ RangeDisplay.c:10: 	long long current = 0;
	movs	r5, #0	@ <retval>,
	movs	r3, r0	@ _48, unit
	movs	r7, r0	@ ivtmp.353, unit
	movs	r4, r5	@ <retval>, <retval>
	adds	r3, r3, #40	@ _48,
	str	r3, [sp, #12]	@ _48, %sfp
	adds	r7, r7, #30	@ ivtmp.353,
.L247:
@ RangeDisplay.c:14: 		for ( int i = 0 ; i < 5 && unit->items[i] ; i++ )
	ldrh	r1, [r7]	@ _10, MEM[(short unsigned int *)_45]
@ RangeDisplay.c:14: 		for ( int i = 0 ; i < 5 && unit->items[i] ; i++ )
	cmp	r1, #0	@ _10,
	beq	.L249		@,
@ RangeDisplay.c:16: 			if ( usability(unit,unit->items[i]) )
	movs	r0, r6	@, unit
	ldr	r3, [sp, #8]	@ usability, %sfp
	bl	.L14		@
@ RangeDisplay.c:16: 			if ( usability(unit,unit->items[i]) )
	cmp	r0, #0	@ tmp150,
	beq	.L248		@,
@ RangeDisplay.c:18: 				current = IncorporateNewRange(current,gGet_Item_Range(unit,unit->items[i]));
	ldr	r3, .L258	@ tmp137,
	movs	r0, r6	@, unit
	ldr	r3, [r3]	@ gGet_Item_Range, gGet_Item_Range
	ldrh	r1, [r7]	@ MEM[(short unsigned int *)_45], MEM[(short unsigned int *)_45]
	bl	.L14		@
	movs	r2, r0	@ _9, tmp163
	movs	r3, r1	@ _9, tmp164
	movs	r0, r5	@, <retval>
	movs	r1, r4	@, <retval>
	bl	IncorporateNewRange		@
	movs	r5, r0	@ <retval>, tmp165
	movs	r4, r1	@ <retval>, tmp166
.L248:
@ RangeDisplay.c:14: 		for ( int i = 0 ; i < 5 && unit->items[i] ; i++ )
	ldr	r3, [sp, #12]	@ _48, %sfp
	adds	r7, r7, #2	@ ivtmp.353,
	cmp	r7, r3	@ ivtmp.353, _48
	bne	.L247		@,
.L249:
@ RangeDisplay.c:21: 		return ( slot == -1 ? IncorporateNewRange(current,GetUnitRangeMaskForSpells(unit,usability)) : current );
	ldr	r3, [sp, #4]	@ slot, %sfp
	adds	r3, r3, #1	@ tmp176, slot,
	bne	.L245		@,
@ RangeDisplay.c:21: 		return ( slot == -1 ? IncorporateNewRange(current,GetUnitRangeMaskForSpells(unit,usability)) : current );
	movs	r0, r6	@, unit
	ldr	r1, [sp, #8]	@, %sfp
	bl	GetUnitRangeMaskForSpells		@
	movs	r2, r0	@ _11, tmp167
	movs	r3, r1	@ _11, tmp168
	movs	r0, r5	@, <retval>
	movs	r1, r4	@, <retval>
	bl	IncorporateNewRange		@
.L257:
@ RangeDisplay.c:33: 			return GetUnitRangeMaskForSpells(unit,usability);
	movs	r5, r0	@ <retval>, tmp173
	movs	r4, r1	@ <retval>, tmp174
.L245:
@ RangeDisplay.c:36: }
	movs	r0, r5	@, <retval>
	movs	r1, r4	@, <retval>
	add	sp, sp, #20	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7}
	pop	{r2}
	bx	r2
.L246:
@ RangeDisplay.c:26: 		if ( slot != 9 )
	ldr	r3, [sp, #4]	@ slot, %sfp
	cmp	r3, #9	@ slot,
	beq	.L252		@,
@ RangeDisplay.c:28: 			return gGet_Item_Range(unit,unit->items[slot]);
	adds	r3, r3, #12	@ slot,
	lsls	r3, r3, #1	@ tmp140, tmp139,
	adds	r3, r0, r3	@ tmp141, unit, tmp140
@ RangeDisplay.c:28: 			return gGet_Item_Range(unit,unit->items[slot]);
	ldrh	r1, [r3, #6]	@ tmp143, *unit_26(D)
	ldr	r3, .L258	@ tmp144,
	ldr	r3, [r3]	@ gGet_Item_Range, gGet_Item_Range
	bl	.L14		@
	b	.L257		@
.L252:
@ RangeDisplay.c:33: 			return GetUnitRangeMaskForSpells(unit,usability);
	ldr	r1, [sp, #8]	@, %sfp
	bl	GetUnitRangeMaskForSpells		@
	b	.L257		@
.L259:
	.align	2
.L258:
	.word	gGet_Item_Range
	.size	Return_Range_Bitfield, .-Return_Range_Bitfield
	.align	1
	.global	All_Spells_One_Square
	.syntax unified
	.code	16
	.thumb_func
	.type	All_Spells_One_Square, %function
All_Spells_One_Square:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ RangeDisplay.c:81: {
	movs	r4, r0	@ unit, tmp125
@ RangeDisplay.c:82: 	asm("push { r7 }");
	.syntax divided
@ 82 "RangeDisplay.c" 1
	push { r7 }
@ 0 "" 2
@ RangeDisplay.c:33: 			return GetUnitRangeMaskForSpells(unit,usability);
	.thumb
	.syntax unified
	bl	GetUnitRangeMaskForSpells		@
	movs	r2, r0	@ _13, tmp130
	movs	r3, r1	@ _13, tmp131
@ RangeDisplay.c:84: 	asm("mov r7, #0x00\nmov r12, r7"); // Write_Range takes this parameter through r12?
	.syntax divided
@ 84 "RangeDisplay.c" 1
	mov r7, #0x00
mov r12, r7
@ 0 "" 2
@ RangeDisplay.c:85: 	gWrite_Range(unit->xPos,unit->yPos,mask);
	.thumb
	.syntax unified
	movs	r1, #17	@ tmp121,
	movs	r0, #16	@ tmp122,
	ldrsb	r1, [r4, r1]	@ tmp121,
	ldrsb	r0, [r4, r0]	@ tmp122,
	ldr	r4, .L261	@ tmp123,
	ldr	r4, [r4]	@ gWrite_Range, gWrite_Range
	bl	.L16		@
@ RangeDisplay.c:86: 	asm("pop { r7 }");
	.syntax divided
@ 86 "RangeDisplay.c" 1
	pop { r7 }
@ 0 "" 2
@ RangeDisplay.c:87: }
	.thumb
	.syntax unified
	@ sp needed	@
	pop	{r4}
	pop	{r0}
	bx	r0
.L262:
	.align	2
.L261:
	.word	gWrite_Range
	.size	All_Spells_One_Square, .-All_Spells_One_Square
	.align	1
	.global	GaidenBlackMagicUMHover
	.syntax unified
	.code	16
	.thumb_func
	.type	GaidenBlackMagicUMHover, %function
GaidenBlackMagicUMHover:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ UnitMenu.c:73: 	UsingSpellMenu = BLACK_MAGIC;
	movs	r5, #1	@ tmp122,
	ldr	r3, .L267	@ tmp121,
	strb	r5, [r3]	@ tmp122, UsingSpellMenu
@ UnitMenu.c:74: 	BmMapFill(gMapMovement,-1);
	ldr	r3, .L267+4	@ tmp124,
	ldr	r4, .L267+8	@ tmp125,
	ldr	r0, [r3]	@, gMapMovement
	movs	r1, #255	@,
	bl	.L16		@
@ UnitMenu.c:75: 	BmMapFill(gMapRange,0);
	ldr	r3, .L267+12	@ tmp126,
	movs	r1, #0	@,
	ldr	r0, [r3]	@, gMapRange
	bl	.L16		@
@ UnitMenu.c:76: 	if ( CanUseAttackSpellsNow(gActiveUnit,BLACK_MAGIC) ) // If we can use an attack spell now, display the red range.
	ldr	r4, .L267+16	@ tmp128,
	movs	r1, r5	@, tmp122
	ldr	r0, [r4]	@, gActiveUnit
	bl	CanUseAttackSpellsNow		@
	ldr	r5, .L267+20	@ tmp136,
@ UnitMenu.c:76: 	if ( CanUseAttackSpellsNow(gActiveUnit,BLACK_MAGIC) ) // If we can use an attack spell now, display the red range.
	cmp	r0, #0	@ tmp137,
	beq	.L264		@,
@ UnitMenu.c:78: 		All_Spells_One_Square(gActiveUnit,&RangeUsabilityCheckNotStaff);
	ldr	r0, [r4]	@, gActiveUnit
	ldr	r1, .L267+24	@ tmp129,
	bl	All_Spells_One_Square		@
@ UnitMenu.c:79: 		DisplayMoveRangeGraphics(3);
	movs	r0, #3	@,
.L266:
@ UnitMenu.c:90: }
	@ sp needed	@
@ UnitMenu.c:84: 		DisplayMoveRangeGraphics(5);
	bl	.L269		@
@ UnitMenu.c:90: }
	movs	r0, #0	@,
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L264:
@ UnitMenu.c:83: 		All_Spells_One_Square(gActiveUnit,&RangeUsabilityCheckStaff);
	ldr	r0, [r4]	@, gActiveUnit
	ldr	r1, .L267+28	@ tmp132,
	bl	All_Spells_One_Square		@
@ UnitMenu.c:84: 		DisplayMoveRangeGraphics(5);
	movs	r0, #5	@,
	b	.L266		@
.L268:
	.align	2
.L267:
	.word	UsingSpellMenu
	.word	gMapMovement
	.word	BmMapFill
	.word	gMapRange
	.word	gActiveUnit
	.word	DisplayMoveRangeGraphics
	.word	RangeUsabilityCheckNotStaff
	.word	RangeUsabilityCheckStaff
	.size	GaidenBlackMagicUMHover, .-GaidenBlackMagicUMHover
	.align	1
	.global	GaidenWhiteMagicUMHover
	.syntax unified
	.code	16
	.thumb_func
	.type	GaidenWhiteMagicUMHover, %function
GaidenWhiteMagicUMHover:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ UnitMenu.c:94: 	UsingSpellMenu = WHITE_MAGIC;
	movs	r5, #2	@ tmp122,
	ldr	r3, .L274	@ tmp121,
	strb	r5, [r3]	@ tmp122, UsingSpellMenu
@ UnitMenu.c:95: 	BmMapFill(gMapMovement,-1);
	ldr	r3, .L274+4	@ tmp124,
	ldr	r4, .L274+8	@ tmp125,
	ldr	r0, [r3]	@, gMapMovement
	movs	r1, #255	@,
	bl	.L16		@
@ UnitMenu.c:96: 	BmMapFill(gMapRange,0);
	ldr	r3, .L274+12	@ tmp126,
	movs	r1, #0	@,
	ldr	r0, [r3]	@, gMapRange
	bl	.L16		@
@ UnitMenu.c:97: 	if ( CanUseAttackSpellsNow(gActiveUnit,WHITE_MAGIC) ) // If we can use an attack spell now, display the red range.
	ldr	r4, .L274+16	@ tmp128,
	movs	r1, r5	@, tmp122
	ldr	r0, [r4]	@, gActiveUnit
	bl	CanUseAttackSpellsNow		@
	ldr	r5, .L274+20	@ tmp136,
@ UnitMenu.c:97: 	if ( CanUseAttackSpellsNow(gActiveUnit,WHITE_MAGIC) ) // If we can use an attack spell now, display the red range.
	cmp	r0, #0	@ tmp137,
	beq	.L271		@,
@ UnitMenu.c:99: 		All_Spells_One_Square(gActiveUnit,&RangeUsabilityCheckNotStaff);
	ldr	r0, [r4]	@, gActiveUnit
	ldr	r1, .L274+24	@ tmp129,
	bl	All_Spells_One_Square		@
@ UnitMenu.c:100: 		DisplayMoveRangeGraphics(3);
	movs	r0, #3	@,
.L273:
@ UnitMenu.c:108: }
	@ sp needed	@
@ UnitMenu.c:105: 		DisplayMoveRangeGraphics(5);
	bl	.L269		@
@ UnitMenu.c:108: }
	movs	r0, #0	@,
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L271:
@ UnitMenu.c:104: 		All_Spells_One_Square(gActiveUnit,&RangeUsabilityCheckStaff);
	ldr	r0, [r4]	@, gActiveUnit
	ldr	r1, .L274+28	@ tmp132,
	bl	All_Spells_One_Square		@
@ UnitMenu.c:105: 		DisplayMoveRangeGraphics(5);
	movs	r0, #5	@,
	b	.L273		@
.L275:
	.align	2
.L274:
	.word	UsingSpellMenu
	.word	gMapMovement
	.word	BmMapFill
	.word	gMapRange
	.word	gActiveUnit
	.word	DisplayMoveRangeGraphics
	.word	RangeUsabilityCheckNotStaff
	.word	RangeUsabilityCheckStaff
	.size	GaidenWhiteMagicUMHover, .-GaidenWhiteMagicUMHover
	.align	1
	.global	SpellUsability
	.syntax unified
	.code	16
	.thumb_func
	.type	SpellUsability, %function
SpellUsability:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, lr}	@
@ SpellMenu.c:5: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,index,UsingSpellMenu)];
	ldr	r7, .L284	@ tmp133,
	ldr	r4, .L284+4	@ tmp135,
@ SpellMenu.c:4: {
	movs	r6, r1	@ index, tmp144
@ SpellMenu.c:5: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,index,UsingSpellMenu)];
	ldr	r0, [r4]	@, gActiveUnit
	ldrb	r1, [r7]	@ UsingSpellMenu, UsingSpellMenu
	bl	SpellsGetter		@
@ SpellMenu.c:5: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,index,UsingSpellMenu)];
	movs	r1, r6	@, index
@ SpellMenu.c:5: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,index,UsingSpellMenu)];
	movs	r5, r0	@ _4, tmp145
@ SpellMenu.c:5: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,index,UsingSpellMenu)];
	ldrb	r2, [r7]	@ UsingSpellMenu, UsingSpellMenu
	ldr	r0, [r4]	@, gActiveUnit
	bl	GetNthUsableSpell		@
@ SpellMenu.c:5: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,index,UsingSpellMenu)];
	ldrb	r5, [r5, r0]	@ spell, *_10
@ SpellMenu.c:6: 	if ( !spell ) { return 3; }
	cmp	r5, #0	@ spell,
	bne	.L277		@,
.L279:
@ SpellMenu.c:6: 	if ( !spell ) { return 3; }
	movs	r0, #3	@ <retval>,
.L276:
@ SpellMenu.c:11: }
	@ sp needed	@
	pop	{r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L277:
@ SpellMenu.c:8: 	if ( !CanCastSpellNow(gActiveUnit,spell) ) { return 3; }
	movs	r1, r5	@, spell
	ldr	r0, [r4]	@, gActiveUnit
	bl	CanCastSpellNow		@
@ SpellMenu.c:8: 	if ( !CanCastSpellNow(gActiveUnit,spell) ) { return 3; }
	cmp	r0, #0	@ tmp147,
	beq	.L279		@,
@ SpellMenu.c:10: 	return ( HasSufficientHP(gActiveUnit,spell) ? 1 : 2 );
	movs	r1, r5	@, spell
	ldr	r0, [r4]	@, gActiveUnit
	bl	HasSufficientHP		@
@ SpellMenu.c:10: 	return ( HasSufficientHP(gActiveUnit,spell) ? 1 : 2 );
	rsbs	r3, r0, #0	@ tmp143, tmp148
	adcs	r0, r0, r3	@ tmp142, tmp148, tmp143
	adds	r0, r0, #1	@ <retval>,
	b	.L276		@
.L285:
	.align	2
.L284:
	.word	UsingSpellMenu
	.word	gActiveUnit
	.size	SpellUsability, .-SpellUsability
	.align	1
	.global	SpellDrawingRoutine
	.syntax unified
	.code	16
	.thumb_func
	.type	SpellDrawingRoutine, %function
SpellDrawingRoutine:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, lr}	@
@ SpellMenu.c:14: {
	movs	r4, r1	@ menuCommand, tmp165
@ SpellMenu.c:22: }
	@ sp needed	@
@ SpellMenu.c:16: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,menuCommand->commandDefinitionIndex,UsingSpellMenu)];
	ldr	r6, .L287	@ tmp145,
	ldr	r7, .L287+4	@ tmp143,
	ldr	r0, [r6]	@, gActiveUnit
	ldrb	r1, [r7]	@ UsingSpellMenu, UsingSpellMenu
	bl	SpellsGetter		@
@ SpellMenu.c:16: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,menuCommand->commandDefinitionIndex,UsingSpellMenu)];
	movs	r3, r4	@ tmp150, menuCommand
	adds	r3, r3, #60	@ tmp150,
@ SpellMenu.c:16: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,menuCommand->commandDefinitionIndex,UsingSpellMenu)];
	ldrb	r2, [r7]	@ UsingSpellMenu, UsingSpellMenu
	ldrb	r1, [r3]	@ tmp151,
@ SpellMenu.c:16: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,menuCommand->commandDefinitionIndex,UsingSpellMenu)];
	movs	r5, r0	@ _4, tmp166
@ SpellMenu.c:16: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,menuCommand->commandDefinitionIndex,UsingSpellMenu)];
	ldr	r0, [r6]	@, gActiveUnit
	bl	GetNthUsableSpell		@
@ SpellMenu.c:16: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,menuCommand->commandDefinitionIndex,UsingSpellMenu)];
	ldrb	r5, [r5, r0]	@ _13, *_12
@ SpellMenu.c:18: 	int canUse = HasSufficientHP(gActiveUnit,spell);
	ldr	r0, [r6]	@, gActiveUnit
	movs	r1, r5	@, _13
	bl	HasSufficientHP		@
	movs	r2, r0	@ canUse, tmp168
@ SpellMenu.c:19: 	DrawItemMenuCommand(&menuCommand->text,spell,canUse,&gBg0MapBuffer[menuCommand->yDrawTile * 32 + menuCommand->xDrawTile]);
	movs	r0, r4	@ menuCommand, menuCommand
@ SpellMenu.c:19: 	DrawItemMenuCommand(&menuCommand->text,spell,canUse,&gBg0MapBuffer[menuCommand->yDrawTile * 32 + menuCommand->xDrawTile]);
	ldrh	r3, [r4, #44]	@ tmp154,
@ SpellMenu.c:19: 	DrawItemMenuCommand(&menuCommand->text,spell,canUse,&gBg0MapBuffer[menuCommand->yDrawTile * 32 + menuCommand->xDrawTile]);
	ldrh	r1, [r4, #42]	@ tmp156,
@ SpellMenu.c:19: 	DrawItemMenuCommand(&menuCommand->text,spell,canUse,&gBg0MapBuffer[menuCommand->yDrawTile * 32 + menuCommand->xDrawTile]);
	lsls	r3, r3, #5	@ tmp155, tmp154,
@ SpellMenu.c:19: 	DrawItemMenuCommand(&menuCommand->text,spell,canUse,&gBg0MapBuffer[menuCommand->yDrawTile * 32 + menuCommand->xDrawTile]);
	adds	r3, r3, r1	@ tmp157, tmp155, tmp156
@ SpellMenu.c:19: 	DrawItemMenuCommand(&menuCommand->text,spell,canUse,&gBg0MapBuffer[menuCommand->yDrawTile * 32 + menuCommand->xDrawTile]);
	ldr	r1, .L287+8	@ tmp160,
	lsls	r3, r3, #1	@ tmp158, tmp157,
	adds	r3, r3, r1	@ tmp159, tmp158, tmp160
	ldr	r4, .L287+12	@ tmp162,
	movs	r1, r5	@, _13
@ SpellMenu.c:19: 	DrawItemMenuCommand(&menuCommand->text,spell,canUse,&gBg0MapBuffer[menuCommand->yDrawTile * 32 + menuCommand->xDrawTile]);
	adds	r0, r0, #52	@ menuCommand,
@ SpellMenu.c:19: 	DrawItemMenuCommand(&menuCommand->text,spell,canUse,&gBg0MapBuffer[menuCommand->yDrawTile * 32 + menuCommand->xDrawTile]);
	bl	.L16		@
@ SpellMenu.c:20: 	EnableBgSyncByMask(1);
	movs	r0, #1	@,
	ldr	r3, .L287+16	@ tmp163,
	bl	.L14		@
@ SpellMenu.c:22: }
	movs	r0, #0	@,
	pop	{r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L288:
	.align	2
.L287:
	.word	gActiveUnit
	.word	UsingSpellMenu
	.word	gBg0MapBuffer
	.word	DrawItemMenuCommand
	.word	EnableBgSyncByMask
	.size	SpellDrawingRoutine, .-SpellDrawingRoutine
	.align	1
	.global	MagicMenuBPress
	.syntax unified
	.code	16
	.thumb_func
	.type	MagicMenuBPress, %function
MagicMenuBPress:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ SpellMenu.c:26: 	FillBgMap(gBg2MapBuffer,0);
	movs	r1, #0	@,
@ SpellMenu.c:35: }
	@ sp needed	@
@ SpellMenu.c:26: 	FillBgMap(gBg2MapBuffer,0);
	ldr	r0, .L290	@ tmp119,
	ldr	r3, .L290+4	@ tmp120,
	bl	.L14		@
@ SpellMenu.c:27: 	EnableBgSyncByMask(4);
	movs	r0, #4	@,
	ldr	r3, .L290+8	@ tmp121,
	bl	.L14		@
@ SpellMenu.c:28: 	Text_ResetTileAllocation();
	ldr	r3, .L290+12	@ tmp122,
	bl	.L14		@
@ SpellMenu.c:30: 	StartMenu_AndDoSomethingCommands(&gMenu_UnitMenu,gGameState._unk1C.x - gGameState.cameraRealPos.x,1,16);
	ldr	r3, .L290+16	@ tmp123,
	ldrh	r1, [r3, #28]	@ tmp124,
@ SpellMenu.c:30: 	StartMenu_AndDoSomethingCommands(&gMenu_UnitMenu,gGameState._unk1C.x - gGameState.cameraRealPos.x,1,16);
	ldrh	r3, [r3, #12]	@ tmp126,
@ SpellMenu.c:30: 	StartMenu_AndDoSomethingCommands(&gMenu_UnitMenu,gGameState._unk1C.x - gGameState.cameraRealPos.x,1,16);
	movs	r2, #1	@,
	subs	r1, r1, r3	@ tmp127, tmp124, tmp126
	ldr	r4, .L290+20	@ tmp129,
	movs	r3, #16	@,
	ldr	r0, .L290+24	@ tmp128,
	bl	.L16		@
@ SpellMenu.c:31: 	HideMoveRangeGraphics();
	ldr	r3, .L290+28	@ tmp130,
	bl	.L14		@
@ SpellMenu.c:32: 	SelectedSpell = 0;
	movs	r2, #0	@ tmp132,
	ldr	r3, .L290+32	@ tmp131,
	strb	r2, [r3]	@ tmp132, SelectedSpell
@ SpellMenu.c:33: 	UsingSpellMenu = 0;
	ldr	r3, .L290+36	@ tmp134,
@ SpellMenu.c:35: }
	movs	r0, #59	@,
@ SpellMenu.c:33: 	UsingSpellMenu = 0;
	strb	r2, [r3]	@ tmp132, UsingSpellMenu
@ SpellMenu.c:35: }
	pop	{r4}
	pop	{r1}
	bx	r1
.L291:
	.align	2
.L290:
	.word	gBg2MapBuffer
	.word	FillBgMap
	.word	EnableBgSyncByMask
	.word	Text_ResetTileAllocation
	.word	gGameState
	.word	StartMenu_AndDoSomethingCommands
	.word	gMenu_UnitMenu
	.word	HideMoveRangeGraphics
	.word	SelectedSpell
	.word	UsingSpellMenu
	.size	MagicMenuBPress, .-MagicMenuBPress
	.align	1
	.global	SpellEffectRoutine
	.syntax unified
	.code	16
	.thumb_func
	.type	SpellEffectRoutine, %function
SpellEffectRoutine:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ SpellMenu.c:39: 	if ( commandProc->availability == 2)
	adds	r1, r1, #61	@ tmp131,
@ SpellMenu.c:39: 	if ( commandProc->availability == 2)
	ldrb	r3, [r1]	@ tmp132,
	cmp	r3, #2	@ tmp132,
	bne	.L293		@,
@ SpellMenu.c:42: 		MenuCallHelpBox(proc,gGaidenMagicSpellMenuErrorText);
	ldr	r3, .L297	@ tmp133,
	ldrh	r1, [r3]	@ gGaidenMagicSpellMenuErrorText, gGaidenMagicSpellMenuErrorText
	ldr	r3, .L297+4	@ tmp135,
	bl	.L14		@
@ SpellMenu.c:43: 		return 0x08;
	movs	r0, #8	@ <retval>,
.L292:
@ SpellMenu.c:63: }
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L293:
@ SpellMenu.c:48: 		gActionData.itemSlotIndex = 0;
	movs	r2, #0	@ tmp137,
	ldr	r3, .L297+8	@ tmp136,
	strb	r2, [r3, #18]	@ tmp137, gActionData.itemSlotIndex
@ SpellMenu.c:49: 		DidSelectSpell = 1;
	ldr	r3, .L297+12	@ tmp139,
	adds	r2, r2, #1	@ tmp140,
	strb	r2, [r3]	@ tmp140, DidSelectSpell
@ SpellMenu.c:50: 		ClearBG0BG1();
	ldr	r3, .L297+16	@ tmp142,
	bl	.L14		@
@ SpellMenu.c:51: 		int type = GetItemType(SelectedSpell);
	ldr	r4, .L297+20	@ tmp143,
	ldr	r3, .L297+24	@ tmp145,
	ldrb	r0, [r4]	@ SelectedSpell, SelectedSpell
	bl	.L14		@
	movs	r1, #255	@ tmp162,
	ldrb	r2, [r4]	@ SelectedSpell, SelectedSpell
	lsls	r1, r1, #8	@ tmp162, tmp162,
	ldr	r3, .L297+28	@ tmp163,
@ SpellMenu.c:54: 			MakeTargetListForWeapon(gActiveUnit,SelectedSpell|0xFF00);
	orrs	r1, r2	@ tmp148, SelectedSpell
@ SpellMenu.c:52: 		if ( type != ITYPE_STAFF )
	cmp	r0, #4	@ tmp166,
	beq	.L295		@,
@ SpellMenu.c:54: 			MakeTargetListForWeapon(gActiveUnit,SelectedSpell|0xFF00);
	ldr	r0, [r3]	@, gActiveUnit
	ldr	r3, .L297+32	@ tmp151,
	bl	.L14		@
@ SpellMenu.c:55: 			StartTargetSelection(&SpellTargetSelection);
	ldr	r0, .L297+36	@ tmp152,
	ldr	r3, .L297+40	@ tmp153,
	bl	.L14		@
.L296:
@ SpellMenu.c:61: 		return 0x27;
	movs	r0, #39	@ <retval>,
	b	.L292		@
.L295:
@ SpellMenu.c:59: 			ItemEffect_Call(gActiveUnit,SelectedSpell|0xFF00);
	ldr	r0, [r3]	@, gActiveUnit
	ldr	r3, .L297+44	@ tmp159,
	bl	.L14		@
	b	.L296		@
.L298:
	.align	2
.L297:
	.word	gGaidenMagicSpellMenuErrorText
	.word	MenuCallHelpBox
	.word	gActionData
	.word	DidSelectSpell
	.word	ClearBG0BG1
	.word	SelectedSpell
	.word	GetItemType
	.word	gActiveUnit
	.word	MakeTargetListForWeapon
	.word	SpellTargetSelection
	.word	StartTargetSelection
	.word	ItemEffect_Call
	.size	SpellEffectRoutine, .-SpellEffectRoutine
	.align	1
	.global	SpellOnHover
	.syntax unified
	.code	16
	.thumb_func
	.type	SpellOnHover, %function
SpellOnHover:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 32
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}	@
@ SpellMenu.c:67: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,proc->commandIndex,UsingSpellMenu)];
	ldr	r6, .L314	@ tmp206,
	ldr	r7, .L314+4	@ tmp208,
@ SpellMenu.c:66: {
	sub	sp, sp, #44	@,,
@ SpellMenu.c:66: {
	movs	r4, r0	@ proc, tmp367
@ SpellMenu.c:67: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,proc->commandIndex,UsingSpellMenu)];
	ldrb	r1, [r6]	@ UsingSpellMenu, UsingSpellMenu
	ldr	r0, [r7]	@, gActiveUnit
	bl	SpellsGetter		@
@ SpellMenu.c:67: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,proc->commandIndex,UsingSpellMenu)];
	adds	r4, r4, #97	@ tmp213,
@ SpellMenu.c:67: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,proc->commandIndex,UsingSpellMenu)];
	ldrb	r1, [r4]	@ tmp214,
@ SpellMenu.c:67: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,proc->commandIndex,UsingSpellMenu)];
	movs	r5, r0	@ _4, tmp368
@ SpellMenu.c:67: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,proc->commandIndex,UsingSpellMenu)];
	ldrb	r2, [r6]	@ UsingSpellMenu, UsingSpellMenu
	ldr	r0, [r7]	@, gActiveUnit
	bl	GetNthUsableSpell		@
@ SpellMenu.c:67: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,proc->commandIndex,UsingSpellMenu)];
	ldrb	r3, [r5, r0]	@ spell, *_12
	str	r3, [sp, #12]	@ spell, %sfp
@ SpellMenu.c:68: 	SelectedSpell = spell;
	ldr	r2, [sp, #12]	@ spell, %sfp
	ldr	r3, .L314+8	@ tmp216,
@ SpellMenu.c:71: 	MenuItemPanelProc* menuItemPanel = (MenuItemPanelProc*)ProcFind(&gProc_MenuItemPanel);
	ldr	r0, .L314+12	@ tmp218,
@ SpellMenu.c:68: 	SelectedSpell = spell;
	strb	r2, [r3]	@ spell, SelectedSpell
@ SpellMenu.c:71: 	MenuItemPanelProc* menuItemPanel = (MenuItemPanelProc*)ProcFind(&gProc_MenuItemPanel);
	ldr	r3, .L314+16	@ tmp219,
	bl	.L14		@
@ SpellMenu.c:72: 	int x = menuItemPanel->x;
	movs	r3, r0	@ tmp222, tmp370
@ SpellMenu.c:71: 	MenuItemPanelProc* menuItemPanel = (MenuItemPanelProc*)ProcFind(&gProc_MenuItemPanel);
	str	r0, [sp, #8]	@ tmp370, %sfp
@ SpellMenu.c:72: 	int x = menuItemPanel->x;
	adds	r3, r3, #48	@ tmp222,
	ldrb	r3, [r3]	@ _14,
	str	r3, [sp, #32]	@ _14, %sfp
@ SpellMenu.c:73: 	int y = menuItemPanel->y;
	movs	r3, r0	@ tmp225, tmp370
	adds	r3, r3, #49	@ tmp225,
@ SpellMenu.c:73: 	int y = menuItemPanel->y;
	ldrb	r3, [r3]	@ y,
	str	r3, [sp, #36]	@ y, %sfp
@ SpellMenu.c:75: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Clear(&menuItemPanel->textHandles[i]); }
	movs	r3, r0	@ _140, tmp370
	adds	r3, r3, #52	@ _140,
@ SpellMenu.c:75: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Clear(&menuItemPanel->textHandles[i]); }
	ldr	r4, .L314+20	@ tmp226,
	movs	r0, r3	@, _140
@ SpellMenu.c:75: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Clear(&menuItemPanel->textHandles[i]); }
	str	r3, [sp, #20]	@ _140, %sfp
@ SpellMenu.c:75: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Clear(&menuItemPanel->textHandles[i]); }
	bl	.L16		@
@ SpellMenu.c:75: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Clear(&menuItemPanel->textHandles[i]); }
	ldr	r3, [sp, #8]	@ _145, %sfp
	adds	r3, r3, #60	@ _145,
@ SpellMenu.c:75: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Clear(&menuItemPanel->textHandles[i]); }
	movs	r0, r3	@, _145
@ SpellMenu.c:75: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Clear(&menuItemPanel->textHandles[i]); }
	str	r3, [sp, #24]	@ _145, %sfp
@ SpellMenu.c:75: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Clear(&menuItemPanel->textHandles[i]); }
	bl	.L16		@
@ SpellMenu.c:75: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Clear(&menuItemPanel->textHandles[i]); }
	ldr	r3, [sp, #8]	@ _150, %sfp
	adds	r3, r3, #68	@ _150,
@ SpellMenu.c:75: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Clear(&menuItemPanel->textHandles[i]); }
	movs	r0, r3	@, _150
@ SpellMenu.c:75: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Clear(&menuItemPanel->textHandles[i]); }
	str	r3, [sp, #28]	@ _150, %sfp
@ SpellMenu.c:75: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Clear(&menuItemPanel->textHandles[i]); }
	bl	.L16		@
@ SpellMenu.c:76: 	MakeUIWindowTileMap_BG0BG1(x,y,14,8,0);
	movs	r4, #0	@ tmp229,
	movs	r3, #8	@,
	movs	r2, #14	@,
	ldr	r1, [sp, #36]	@, %sfp
	ldr	r0, [sp, #32]	@, %sfp
	str	r4, [sp]	@ tmp229,
	ldr	r5, .L314+24	@ tmp230,
	bl	.L269		@
@ SpellMenu.c:78: 	int spellType = GetItemType(spell);
	ldr	r0, [sp, #12]	@, %sfp
	ldr	r3, .L314+28	@ tmp231,
	bl	.L14		@
	str	r0, [sp, #16]	@ tmp371, %sfp
@ SpellMenu.c:79: 	if ( spellType != ITYPE_STAFF )
	cmp	r0, #4	@ spellType,
	bne	.LCB2117	@
	b	.L300	@long jump	@
.LCB2117:
@ SpellMenu.c:81: 		BattleGenerateUiStats(gActiveUnit,9); // 9 is using a Gaiden spell.
	movs	r1, #9	@,
	ldr	r3, .L314+32	@ tmp233,
	ldr	r0, [r7]	@, gActiveUnit
	bl	.L14		@
@ SpellMenu.c:82: 		Text_InsertString(&menuItemPanel->textHandles[0],0x02,0,GetStringFromIndex(0x4F1)); // Affin.
	ldr	r6, .L314+36	@ tmp235,
	ldr	r0, .L314+40	@,
	bl	.L15		@
@ SpellMenu.c:82: 		Text_InsertString(&menuItemPanel->textHandles[0],0x02,0,GetStringFromIndex(0x4F1)); // Affin.
	ldr	r5, .L314+44	@ tmp236,
	movs	r2, r4	@, tmp229
@ SpellMenu.c:82: 		Text_InsertString(&menuItemPanel->textHandles[0],0x02,0,GetStringFromIndex(0x4F1)); // Affin.
	movs	r3, r0	@ _19, tmp372
@ SpellMenu.c:82: 		Text_InsertString(&menuItemPanel->textHandles[0],0x02,0,GetStringFromIndex(0x4F1)); // Affin.
	movs	r1, #2	@,
	ldr	r0, [sp, #20]	@, %sfp
	bl	.L269		@
@ SpellMenu.c:83: 		Text_InsertString(&menuItemPanel->textHandles[0],0x32,0,GetStringFromIndex(gGaidenMagicHPCostText)); // HP Cost.
	ldr	r3, .L314+48	@ tmp237,
	ldrh	r0, [r3]	@ gGaidenMagicHPCostText, gGaidenMagicHPCostText
	bl	.L15		@
@ SpellMenu.c:83: 		Text_InsertString(&menuItemPanel->textHandles[0],0x32,0,GetStringFromIndex(gGaidenMagicHPCostText)); // HP Cost.
	movs	r2, r4	@, tmp229
@ SpellMenu.c:83: 		Text_InsertString(&menuItemPanel->textHandles[0],0x32,0,GetStringFromIndex(gGaidenMagicHPCostText)); // HP Cost.
	movs	r3, r0	@ _23, tmp373
@ SpellMenu.c:83: 		Text_InsertString(&menuItemPanel->textHandles[0],0x32,0,GetStringFromIndex(gGaidenMagicHPCostText)); // HP Cost.
	movs	r1, #50	@,
	ldr	r0, [sp, #20]	@, %sfp
	bl	.L269		@
@ SpellMenu.c:84: 		Text_InsertString(&menuItemPanel->textHandles[1],0x02,0,GetStringFromIndex(0x4F3)); // Atk.
	ldr	r0, .L314+52	@,
	bl	.L15		@
@ SpellMenu.c:84: 		Text_InsertString(&menuItemPanel->textHandles[1],0x02,0,GetStringFromIndex(0x4F3)); // Atk.
	movs	r2, r4	@, tmp229
@ SpellMenu.c:84: 		Text_InsertString(&menuItemPanel->textHandles[1],0x02,0,GetStringFromIndex(0x4F3)); // Atk.
	movs	r3, r0	@ _25, tmp374
@ SpellMenu.c:84: 		Text_InsertString(&menuItemPanel->textHandles[1],0x02,0,GetStringFromIndex(0x4F3)); // Atk.
	movs	r1, #2	@,
	ldr	r0, [sp, #24]	@, %sfp
	bl	.L269		@
@ SpellMenu.c:85: 		Text_InsertString(&menuItemPanel->textHandles[2],0x02,0,GetStringFromIndex(0x4F4)); // Hit.
	ldr	r0, .L314+56	@,
	bl	.L15		@
@ SpellMenu.c:85: 		Text_InsertString(&menuItemPanel->textHandles[2],0x02,0,GetStringFromIndex(0x4F4)); // Hit.
	movs	r2, r4	@, tmp229
@ SpellMenu.c:85: 		Text_InsertString(&menuItemPanel->textHandles[2],0x02,0,GetStringFromIndex(0x4F4)); // Hit.
	movs	r3, r0	@ _27, tmp375
@ SpellMenu.c:85: 		Text_InsertString(&menuItemPanel->textHandles[2],0x02,0,GetStringFromIndex(0x4F4)); // Hit.
	movs	r1, #2	@,
	ldr	r0, [sp, #28]	@, %sfp
	bl	.L269		@
@ SpellMenu.c:86: 		Text_InsertString(&menuItemPanel->textHandles[1],0x32,0,GetStringFromIndex(0x501)); // Crit.
	ldr	r0, .L314+60	@,
	bl	.L15		@
@ SpellMenu.c:86: 		Text_InsertString(&menuItemPanel->textHandles[1],0x32,0,GetStringFromIndex(0x501)); // Crit.
	movs	r2, r4	@, tmp229
@ SpellMenu.c:86: 		Text_InsertString(&menuItemPanel->textHandles[1],0x32,0,GetStringFromIndex(0x501)); // Crit.
	movs	r3, r0	@ _28, tmp376
@ SpellMenu.c:86: 		Text_InsertString(&menuItemPanel->textHandles[1],0x32,0,GetStringFromIndex(0x501)); // Crit.
	movs	r1, #50	@,
	ldr	r0, [sp, #24]	@, %sfp
	bl	.L269		@
@ SpellMenu.c:87: 		Text_InsertString(&menuItemPanel->textHandles[2],0x32,0,GetStringFromIndex(0x4F5)); // Avoid.
	ldr	r0, .L314+64	@,
	bl	.L15		@
@ SpellMenu.c:87: 		Text_InsertString(&menuItemPanel->textHandles[2],0x32,0,GetStringFromIndex(0x4F5)); // Avoid.
	movs	r2, r4	@, tmp229
@ SpellMenu.c:87: 		Text_InsertString(&menuItemPanel->textHandles[2],0x32,0,GetStringFromIndex(0x4F5)); // Avoid.
	movs	r3, r0	@ _29, tmp377
@ SpellMenu.c:87: 		Text_InsertString(&menuItemPanel->textHandles[2],0x32,0,GetStringFromIndex(0x4F5)); // Avoid.
	movs	r1, #50	@,
	ldr	r0, [sp, #28]	@, %sfp
	bl	.L269		@
@ SpellMenu.c:90: 		if ( !HasSufficientHP(gActiveUnit,spell) ) { CostColor = 1; }
	ldr	r1, [sp, #12]	@, %sfp
	ldr	r0, [r7]	@, gActiveUnit
	bl	HasSufficientHP		@
@ SpellMenu.c:89: 		int CostColor = 2;
	subs	r3, r0, #1	@ tmp355, tmp378
	sbcs	r0, r0, r3	@ tmp378, tmp378, tmp355
	movs	r4, r0	@ tmp354, tmp378
@ SpellMenu.c:91: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[0],0x54,CostColor,GetSpellCost(spell));
	ldr	r0, [sp, #12]	@, %sfp
	bl	GetSpellCost		@
@ SpellMenu.c:89: 		int CostColor = 2;
	adds	r4, r4, #1	@ CostColor,
@ SpellMenu.c:91: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[0],0x54,CostColor,GetSpellCost(spell));
	lsls	r3, r0, #24	@ tmp254, tmp379,
	ldr	r5, .L314+68	@ tmp256,
	movs	r2, r4	@, CostColor
	movs	r1, #84	@,
	ldr	r0, [sp, #20]	@, %sfp
	lsrs	r3, r3, #24	@ tmp254, tmp254,
	bl	.L269		@
@ SpellMenu.c:92: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[1],0x24,2,gBattleActor.battleAttack);
	ldr	r3, .L314+72	@ tmp260,
	ldr	r4, .L314+76	@ tmp257,
@ SpellMenu.c:92: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[1],0x24,2,gBattleActor.battleAttack);
	movs	r2, #2	@,
	movs	r1, #36	@,
	ldrb	r3, [r3]	@ tmp264,
	ldr	r0, [sp, #24]	@, %sfp
	bl	.L269		@
@ SpellMenu.c:93: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[2],0x24,2,gBattleActor.battleHitRate);
	movs	r3, r4	@ tmp270, tmp257
	adds	r3, r3, #96	@ tmp270,
@ SpellMenu.c:93: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[2],0x24,2,gBattleActor.battleHitRate);
	movs	r2, #2	@,
	movs	r1, #36	@,
	ldrb	r3, [r3]	@ tmp274,
	ldr	r0, [sp, #28]	@, %sfp
	bl	.L269		@
@ SpellMenu.c:94: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[1],0x54,2,gBattleActor.battleCritRate);
	movs	r3, r4	@ tmp280, tmp257
	adds	r3, r3, #102	@ tmp280,
@ SpellMenu.c:94: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[1],0x54,2,gBattleActor.battleCritRate);
	movs	r2, #2	@,
	movs	r1, #84	@,
	ldrb	r3, [r3]	@ tmp284,
	ldr	r0, [sp, #24]	@, %sfp
@ SpellMenu.c:95: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[2],0x54,2,gBattleActor.battleAvoidRate);
	adds	r4, r4, #98	@ tmp290,
@ SpellMenu.c:94: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[1],0x54,2,gBattleActor.battleCritRate);
	bl	.L269		@
@ SpellMenu.c:95: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[2],0x54,2,gBattleActor.battleAvoidRate);
	movs	r2, #2	@,
	movs	r1, #84	@,
	ldrb	r3, [r4]	@ tmp294,
	ldr	r0, [sp, #28]	@, %sfp
	bl	.L269		@
.L302:
	ldr	r3, [sp, #32]	@ _14, %sfp
	ldr	r5, [sp, #36]	@ y, %sfp
	adds	r4, r3, #1	@ tmp326, _14,
	adds	r5, r5, #1	@ y,
	ldr	r3, [sp, #8]	@ _173, %sfp
	lsls	r5, r5, #5	@ _158, tmp325,
	ldr	r6, [sp, #8]	@ ivtmp.386, %sfp
	ldr	r7, .L314+80	@ tmp329,
	adds	r4, r4, r5	@ tmp327, tmp326, _158
	adds	r3, r3, #76	@ _173,
	lsls	r4, r4, #1	@ tmp328, tmp327,
	str	r3, [sp, #20]	@ _173, %sfp
	adds	r6, r6, #52	@ ivtmp.386,
	adds	r4, r4, r7	@ ivtmp.388, tmp328, tmp329
.L304:
@ SpellMenu.c:115: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Display(&menuItemPanel->textHandles[i],&gBG0MapBuffer[y+1+2*i][x+1]); }
	movs	r1, r4	@, ivtmp.388
	movs	r0, r6	@, ivtmp.386
	ldr	r3, .L314+84	@ tmp330,
	bl	.L14		@
@ SpellMenu.c:115: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Display(&menuItemPanel->textHandles[i],&gBG0MapBuffer[y+1+2*i][x+1]); }
	ldr	r3, [sp, #20]	@ _173, %sfp
	adds	r6, r6, #8	@ ivtmp.386,
	adds	r4, r4, #128	@ ivtmp.388,
	cmp	r6, r3	@ ivtmp.386, _173
	bne	.L304		@,
@ SpellMenu.c:117: 	if ( spellType != ITYPE_STAFF ) { DrawIcon(&gBG0MapBuffer[y+1][x+5],spellType+0x70,menuItemPanel->oam2base<<0xC); } // This HAS to happen after the Text_Display calls.
	ldr	r3, [sp, #16]	@ spellType, %sfp
	cmp	r3, #4	@ spellType,
	beq	.L305		@,
@ SpellMenu.c:117: 	if ( spellType != ITYPE_STAFF ) { DrawIcon(&gBG0MapBuffer[y+1][x+5],spellType+0x70,menuItemPanel->oam2base<<0xC); } // This HAS to happen after the Text_Display calls.
	ldr	r3, [sp, #8]	@ menuItemPanel, %sfp
@ SpellMenu.c:117: 	if ( spellType != ITYPE_STAFF ) { DrawIcon(&gBG0MapBuffer[y+1][x+5],spellType+0x70,menuItemPanel->oam2base<<0xC); } // This HAS to happen after the Text_Display calls.
	ldr	r0, [sp, #32]	@ _14, %sfp
@ SpellMenu.c:117: 	if ( spellType != ITYPE_STAFF ) { DrawIcon(&gBG0MapBuffer[y+1][x+5],spellType+0x70,menuItemPanel->oam2base<<0xC); } // This HAS to happen after the Text_Display calls.
	adds	r3, r3, #50	@ menuItemPanel,
@ SpellMenu.c:117: 	if ( spellType != ITYPE_STAFF ) { DrawIcon(&gBG0MapBuffer[y+1][x+5],spellType+0x70,menuItemPanel->oam2base<<0xC); } // This HAS to happen after the Text_Display calls.
	adds	r0, r0, #5	@ _14,
@ SpellMenu.c:117: 	if ( spellType != ITYPE_STAFF ) { DrawIcon(&gBG0MapBuffer[y+1][x+5],spellType+0x70,menuItemPanel->oam2base<<0xC); } // This HAS to happen after the Text_Display calls.
	ldrb	r2, [r3]	@ tmp334,
@ SpellMenu.c:117: 	if ( spellType != ITYPE_STAFF ) { DrawIcon(&gBG0MapBuffer[y+1][x+5],spellType+0x70,menuItemPanel->oam2base<<0xC); } // This HAS to happen after the Text_Display calls.
	ldr	r1, [sp, #16]	@ tmp336, %sfp
	adds	r0, r0, r5	@ tmp338, tmp337, _158
	lsls	r0, r0, #1	@ tmp339, tmp338,
	ldr	r3, .L314+88	@ tmp342,
	lsls	r2, r2, #12	@ tmp335, tmp334,
	adds	r0, r7, r0	@ tmp340, tmp329, tmp339
	adds	r1, r1, #112	@ tmp336,
	bl	.L14		@
.L305:
@ SpellMenu.c:123: 	gWrite_Range(gActiveUnit->xPos,gActiveUnit->yPos,gGet_Item_Range(gActiveUnit,spell));
	movs	r5, #16	@ _67,
	movs	r6, #17	@ _69,
@ SpellMenu.c:119: 	BmMapFill(gMapMovement,-1);
	ldr	r3, .L314+92	@ tmp343,
	ldr	r4, .L314+96	@ tmp344,
	ldr	r0, [r3]	@, gMapMovement
	movs	r1, #255	@,
	bl	.L16		@
@ SpellMenu.c:120: 	BmMapFill(gMapRange,0);
	ldr	r3, .L314+100	@ tmp345,
	movs	r1, #0	@,
	ldr	r0, [r3]	@, gMapRange
	bl	.L16		@
@ SpellMenu.c:123: 	gWrite_Range(gActiveUnit->xPos,gActiveUnit->yPos,gGet_Item_Range(gActiveUnit,spell));
	ldr	r3, .L314+104	@ tmp347,
	ldr	r4, [r3]	@ gWrite_Range.103_64, gWrite_Range
@ SpellMenu.c:123: 	gWrite_Range(gActiveUnit->xPos,gActiveUnit->yPos,gGet_Item_Range(gActiveUnit,spell));
	ldr	r3, .L314+4	@ tmp348,
	ldr	r0, [r3]	@ gActiveUnit.104_65, gActiveUnit
@ SpellMenu.c:123: 	gWrite_Range(gActiveUnit->xPos,gActiveUnit->yPos,gGet_Item_Range(gActiveUnit,spell));
	ldr	r3, .L314+108	@ tmp349,
	ldr	r1, [sp, #12]	@, %sfp
	ldr	r3, [r3]	@ gGet_Item_Range, gGet_Item_Range
	ldrsb	r5, [r0, r5]	@ _67,* _67
	ldrsb	r6, [r0, r6]	@ _69,* _69
	bl	.L14		@
	movs	r3, r1	@ _71, tmp387
	movs	r2, r0	@ _71, tmp386
	movs	r1, r6	@, _69
	movs	r0, r5	@, _67
	bl	.L16		@
@ SpellMenu.c:124: 	DisplayMoveRangeGraphics(( spellType == ITYPE_STAFF ? 4 : 2 )); // See note in UnitMenu.c.
	ldr	r3, [sp, #16]	@ spellType, %sfp
	movs	r0, #2	@ iftmp.108_77,
	cmp	r3, #4	@ spellType,
	bne	.L306		@,
	movs	r0, r3	@ iftmp.108_77, spellType
.L306:
@ SpellMenu.c:124: 	DisplayMoveRangeGraphics(( spellType == ITYPE_STAFF ? 4 : 2 )); // See note in UnitMenu.c.
	ldr	r3, .L314+112	@ tmp351,
	bl	.L14		@
@ SpellMenu.c:126: }
	movs	r0, #0	@,
	add	sp, sp, #44	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L300:
@ SpellMenu.c:100: 		const char* desc = GetStringFromIndex(GetItemUseDescId(spell));
	ldr	r3, .L314+116	@ tmp297,
	ldr	r0, [sp, #12]	@, %sfp
	bl	.L14		@
	ldr	r3, .L314+36	@ tmp298,
	bl	.L14		@
	ldr	r5, [sp, #20]	@ ivtmp.393, %sfp
@ SpellMenu.c:102: 		desc--;
	subs	r0, r0, #1	@ desc,
.L303:
@ SpellMenu.c:106: 			Text_InsertString(&menuItemPanel->textHandles[j],0,0,desc);
	movs	r2, #0	@,
@ SpellMenu.c:105: 			desc++;
	adds	r4, r0, #1	@ desc, desc,
@ SpellMenu.c:106: 			Text_InsertString(&menuItemPanel->textHandles[j],0,0,desc);
	movs	r3, r4	@, desc
	movs	r0, r5	@, ivtmp.393
	movs	r1, r2	@,
	ldr	r6, .L314+44	@ tmp299,
	bl	.L15		@
@ SpellMenu.c:107: 			desc = Text_GetStringNextLine(desc);
	ldr	r3, .L314+120	@ tmp300,
	movs	r0, r4	@, desc
	bl	.L14		@
@ SpellMenu.c:109: 		} while ( *desc );
	ldrb	r3, [r0]	@ *desc_103, *desc_103
	adds	r5, r5, #8	@ ivtmp.393,
	cmp	r3, #0	@ *desc_103,
	bne	.L303		@,
@ SpellMenu.c:110: 		gBattleActor.battleAttack = gBattleTarget.battleAttack; // ??? this is something vanilla does???
	ldr	r0, .L314+124	@ tmp306,
	ldr	r2, .L314+128	@ tmp303,
@ SpellMenu.c:110: 		gBattleActor.battleAttack = gBattleTarget.battleAttack; // ??? this is something vanilla does???
	ldrh	r0, [r0]	@ tmp310,
	ldr	r1, .L314+72	@ tmp309,
	ldr	r3, .L314+76	@ tmp302,
	strh	r0, [r1]	@ tmp310, gBattleActor.battleAttack
@ SpellMenu.c:112: 		gBattleActor.battleCritRate = gBattleTarget.battleCritRate;
	movs	r0, r2	@ tmp316, tmp303
@ SpellMenu.c:112: 		gBattleActor.battleCritRate = gBattleTarget.battleCritRate;
	movs	r1, r3	@ tmp319, tmp302
@ SpellMenu.c:112: 		gBattleActor.battleCritRate = gBattleTarget.battleCritRate;
	adds	r0, r0, #102	@ tmp316,
@ SpellMenu.c:112: 		gBattleActor.battleCritRate = gBattleTarget.battleCritRate;
	ldrh	r0, [r0]	@ tmp320,
@ SpellMenu.c:111: 		gBattleActor.battleHitRate = gBattleTarget.battleHitRate; // ??? this fixes the green/red arrows from showing on staves???
	ldr	r2, [r2, #96]	@ MEM <unsigned int> [(short int *)&gBattleTarget + 96B], MEM <unsigned int> [(short int *)&gBattleTarget + 96B]
@ SpellMenu.c:112: 		gBattleActor.battleCritRate = gBattleTarget.battleCritRate;
	adds	r1, r1, #102	@ tmp319,
	strh	r0, [r1]	@ tmp320, gBattleActor.battleCritRate
@ SpellMenu.c:111: 		gBattleActor.battleHitRate = gBattleTarget.battleHitRate; // ??? this fixes the green/red arrows from showing on staves???
	str	r2, [r3, #96]	@ MEM <unsigned int> [(short int *)&gBattleTarget + 96B], MEM <unsigned int> [(short int *)&gBattleActor + 96B]
	b	.L302		@
.L315:
	.align	2
.L314:
	.word	UsingSpellMenu
	.word	gActiveUnit
	.word	SelectedSpell
	.word	gProc_MenuItemPanel
	.word	ProcFind
	.word	Text_Clear
	.word	MakeUIWindowTileMap_BG0BG1
	.word	GetItemType
	.word	BattleGenerateUiStats
	.word	GetStringFromIndex
	.word	1265
	.word	Text_InsertString
	.word	gGaidenMagicHPCostText
	.word	1267
	.word	1268
	.word	1281
	.word	1269
	.word	Text_InsertNumberOr2Dashes
	.word	gBattleActor+90
	.word	gBattleActor
	.word	gBG0MapBuffer
	.word	Text_Display
	.word	DrawIcon
	.word	gMapMovement
	.word	BmMapFill
	.word	gMapRange
	.word	gWrite_Range
	.word	gGet_Item_Range
	.word	DisplayMoveRangeGraphics
	.word	GetItemUseDescId
	.word	Text_GetStringNextLine
	.word	gBattleTarget+90
	.word	gBattleTarget
	.size	SpellOnHover, .-SpellOnHover
	.align	1
	.global	SpellOnUnhover
	.syntax unified
	.code	16
	.thumb_func
	.type	SpellOnUnhover, %function
SpellOnUnhover:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ SpellMenu.c:130: 	if ( !DidSelectSpell ) // Don't hide the squares if we're going to the target selection menu.
	ldr	r4, .L318	@ tmp116,
@ SpellMenu.c:130: 	if ( !DidSelectSpell ) // Don't hide the squares if we're going to the target selection menu.
	ldrb	r3, [r4]	@ DidSelectSpell, DidSelectSpell
	cmp	r3, #0	@ DidSelectSpell,
	bne	.L317		@,
@ SpellMenu.c:132: 		HideMoveRangeGraphics();
	ldr	r3, .L318+4	@ tmp118,
	bl	.L14		@
.L317:
@ SpellMenu.c:136: }
	@ sp needed	@
@ SpellMenu.c:134: 	DidSelectSpell = 0; // Unset this variable.
	movs	r0, #0	@ tmp120,
	strb	r0, [r4]	@ tmp120, DidSelectSpell
@ SpellMenu.c:136: }
	pop	{r4}
	pop	{r1}
	bx	r1
.L319:
	.align	2
.L318:
	.word	DidSelectSpell
	.word	HideMoveRangeGraphics
	.size	SpellOnUnhover, .-SpellOnUnhover
	.align	1
	.global	NewMenuRText
	.syntax unified
	.code	16
	.thumb_func
	.type	NewMenuRText, %function
NewMenuRText:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	movs	r3, r1	@ commandProc, tmp173
	push	{r4, r5, r6, r7, lr}	@
@ SpellMenu.c:142: 	if ( UsingSpellMenu )
	ldr	r2, .L325	@ tmp144,
@ SpellMenu.c:140: 	int xTile = commandProc->xDrawTile * 8;
	ldrh	r4, [r1, #42]	@ tmp142,
@ SpellMenu.c:141: 	int yTile = commandProc->yDrawTile * 8;
	ldrh	r5, [r1, #44]	@ tmp143,
@ SpellMenu.c:142: 	if ( UsingSpellMenu )
	ldrb	r1, [r2]	@ UsingSpellMenu.110_5, UsingSpellMenu
@ SpellMenu.c:139: {
	sub	sp, sp, #20	@,,
	adds	r3, r3, #60	@ commandProc,
@ SpellMenu.c:142: 	if ( UsingSpellMenu )
	str	r2, [sp, #4]	@ tmp144, %sfp
	str	r3, [sp, #8]	@ commandProc, %sfp
	ldr	r7, .L325+4	@ tmp172,
@ SpellMenu.c:140: 	int xTile = commandProc->xDrawTile * 8;
	lsls	r4, r4, #3	@ xTile, tmp142,
@ SpellMenu.c:141: 	int yTile = commandProc->yDrawTile * 8;
	lsls	r5, r5, #3	@ yTile, tmp143,
@ SpellMenu.c:142: 	if ( UsingSpellMenu )
	cmp	r1, #0	@ UsingSpellMenu.110_5,
	beq	.L321		@,
@ SpellMenu.c:145: 		DrawItemRText(xTile,yTile,SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,commandProc->commandDefinitionIndex,UsingSpellMenu)]);
	ldr	r6, .L325+8	@ tmp145,
	ldr	r0, [r6]	@, gActiveUnit
	bl	SpellsGetter		@
@ SpellMenu.c:145: 		DrawItemRText(xTile,yTile,SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,commandProc->commandDefinitionIndex,UsingSpellMenu)]);
	ldr	r3, [sp, #4]	@ tmp144, %sfp
@ SpellMenu.c:145: 		DrawItemRText(xTile,yTile,SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,commandProc->commandDefinitionIndex,UsingSpellMenu)]);
	str	r0, [sp, #12]	@ tmp174, %sfp
@ SpellMenu.c:145: 		DrawItemRText(xTile,yTile,SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,commandProc->commandDefinitionIndex,UsingSpellMenu)]);
	ldrb	r2, [r3]	@ UsingSpellMenu, UsingSpellMenu
	ldr	r3, [sp, #8]	@ tmp171, %sfp
	ldr	r0, [r6]	@, gActiveUnit
	ldrb	r1, [r3]	@ tmp151,
	bl	GetNthUsableSpell		@
@ SpellMenu.c:145: 		DrawItemRText(xTile,yTile,SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,commandProc->commandDefinitionIndex,UsingSpellMenu)]);
	ldr	r3, [sp, #12]	@ _8, %sfp
	ldrb	r2, [r3, r0]	@ *_16, *_16
.L324:
@ SpellMenu.c:156: 			DrawItemRText(xTile,yTile,*((u16*)&gGameState+0x16)); // Probably related to special cases like ballistae?
	movs	r1, r5	@, yTile
	movs	r0, r4	@, xTile
	bl	.L327		@
@ SpellMenu.c:159: }
	add	sp, sp, #20	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L321:
@ SpellMenu.c:150: 		if ( commandProc->commandDefinitionIndex <= 4 )
	ldr	r3, [sp, #8]	@ tmp171, %sfp
	ldrb	r3, [r3]	@ _19,
@ SpellMenu.c:150: 		if ( commandProc->commandDefinitionIndex <= 4 )
	cmp	r3, #4	@ _19,
	bhi	.L323		@,
@ SpellMenu.c:152: 			DrawItemRText(xTile,yTile,gActiveUnit->items[commandProc->commandDefinitionIndex]);
	ldr	r2, .L325+8	@ tmp161,
	adds	r3, r3, #12	@ tmp162,
	ldr	r2, [r2]	@ gActiveUnit, gActiveUnit
	lsls	r3, r3, #1	@ tmp163, tmp162,
	adds	r3, r2, r3	@ tmp164, gActiveUnit, tmp163
@ SpellMenu.c:152: 			DrawItemRText(xTile,yTile,gActiveUnit->items[commandProc->commandDefinitionIndex]);
	ldrh	r2, [r3, #6]	@ tmp166, *gActiveUnit.115_20
	b	.L324		@
.L323:
@ SpellMenu.c:156: 			DrawItemRText(xTile,yTile,*((u16*)&gGameState+0x16)); // Probably related to special cases like ballistae?
	ldr	r3, .L325+12	@ tmp168,
@ SpellMenu.c:156: 			DrawItemRText(xTile,yTile,*((u16*)&gGameState+0x16)); // Probably related to special cases like ballistae?
	ldrh	r2, [r3, #44]	@ MEM[(u16 *)&gGameState + 44B], MEM[(u16 *)&gGameState + 44B]
	b	.L324		@
.L326:
	.align	2
.L325:
	.word	UsingSpellMenu
	.word	DrawItemRText
	.word	gActiveUnit
	.word	gGameState
	.size	NewMenuRText, .-NewMenuRText
	.align	1
	.global	NewExitBattleForecast
	.syntax unified
	.code	16
	.thumb_func
	.type	NewExitBattleForecast, %function
NewExitBattleForecast:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
@ SpellMenu.c:165: 	if ( UsingSpellMenu == BLACK_MAGIC ) { GaidenBlackMagicUMEffect(NULL,NULL); }
	movs	r1, #0	@,
@ SpellMenu.c:162: {
	push	{r4, lr}	@
@ SpellMenu.c:165: 	if ( UsingSpellMenu == BLACK_MAGIC ) { GaidenBlackMagicUMEffect(NULL,NULL); }
	ldr	r3, .L332	@ tmp115,
	ldrb	r3, [r3]	@ UsingSpellMenu.116_1, UsingSpellMenu
@ SpellMenu.c:165: 	if ( UsingSpellMenu == BLACK_MAGIC ) { GaidenBlackMagicUMEffect(NULL,NULL); }
	movs	r0, r1	@,
@ SpellMenu.c:165: 	if ( UsingSpellMenu == BLACK_MAGIC ) { GaidenBlackMagicUMEffect(NULL,NULL); }
	cmp	r3, #1	@ UsingSpellMenu.116_1,
	bne	.L329		@,
@ SpellMenu.c:165: 	if ( UsingSpellMenu == BLACK_MAGIC ) { GaidenBlackMagicUMEffect(NULL,NULL); }
	bl	GaidenBlackMagicUMEffect		@
.L330:
@ SpellMenu.c:173: }
	@ sp needed	@
@ SpellMenu.c:172: 	SelectedSpell = 0; // Regardless of use case, ensure that this is 0.
	movs	r2, #0	@ tmp118,
	ldr	r3, .L332+4	@ tmp117,
	strb	r2, [r3]	@ tmp118, SelectedSpell
@ SpellMenu.c:173: }
	pop	{r4}
	pop	{r0}
	bx	r0
.L329:
@ SpellMenu.c:166: 	else if ( UsingSpellMenu == WHITE_MAGIC ) { GaidenWhiteMagicUMEffect(NULL,NULL); }
	cmp	r3, #2	@ UsingSpellMenu.116_1,
	bne	.L331		@,
@ SpellMenu.c:166: 	else if ( UsingSpellMenu == WHITE_MAGIC ) { GaidenWhiteMagicUMEffect(NULL,NULL); }
	bl	GaidenWhiteMagicUMEffect		@
	b	.L330		@
.L331:
@ SpellMenu.c:170: 		AttackUMEffect(NULL,NULL);
	ldr	r3, .L332+8	@ tmp116,
	bl	.L14		@
	b	.L330		@
.L333:
	.align	2
.L332:
	.word	UsingSpellMenu
	.word	SelectedSpell
	.word	AttackUMEffect
	.size	NewExitBattleForecast, .-NewExitBattleForecast
	.align	1
	.global	GaidenStatScreen
	.syntax unified
	.code	16
	.thumb_func
	.type	GaidenStatScreen, %function
GaidenStatScreen:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}	@
	sub	sp, sp, #28	@,,
@ StatScreen.c:3: {
	str	r1, [sp, #8]	@ tmp182, %sfp
@ StatScreen.c:4: 	u8* spells = SpellsGetter(gpStatScreenUnit,-1);
	movs	r1, #1	@,
@ StatScreen.c:3: {
	movs	r4, r2	@ currHandle, tmp183
@ StatScreen.c:4: 	u8* spells = SpellsGetter(gpStatScreenUnit,-1);
	ldr	r3, .L339	@ tmp144,
@ StatScreen.c:3: {
	str	r0, [sp, #4]	@ tmp181, %sfp
@ StatScreen.c:4: 	u8* spells = SpellsGetter(gpStatScreenUnit,-1);
	rsbs	r1, r1, #0	@,
	ldr	r0, [r3]	@, gpStatScreenUnit
	bl	SpellsGetter		@
@ StatScreen.c:5: 	int tile = (currHandle-1)->tileIndexOffset;
	movs	r3, r4	@ tmp145, currHandle
	movs	r7, r0	@ ivtmp.416, tmp184
	subs	r3, r3, #8	@ tmp145,
@ StatScreen.c:5: 	int tile = (currHandle-1)->tileIndexOffset;
	ldrh	r3, [r3]	@ tile, MEM[(struct TextHandle *)currHandle_27(D) + 4294967288B]
@ StatScreen.c:8: 	for ( int i = 0 ; spells[i] ; i++ )
	ldr	r6, [sp, #4]	@ iconX, %sfp
@ StatScreen.c:5: 	int tile = (currHandle-1)->tileIndexOffset;
	str	r3, [sp]	@ tile, %sfp
.L335:
@ StatScreen.c:8: 	for ( int i = 0 ; spells[i] ; i++ )
	ldrb	r0, [r7]	@ _15, MEM[(u8 *)_62]
@ StatScreen.c:8: 	for ( int i = 0 ; spells[i] ; i++ )
	cmp	r0, #0	@ _15,
	bne	.L338		@,
@ StatScreen.c:32: }
	movs	r0, r4	@, currHandle
	add	sp, sp, #28	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L338:
@ StatScreen.c:10: 		const ItemData* item = GetItemData(spells[i]);
	ldr	r3, .L339+4	@ tmp146,
	bl	.L14		@
@ StatScreen.c:11: 		DrawIcon(&StatScreenBufferMap[iconY][iconX],item->iconId,0x4000);
	movs	r2, #128	@,
	ldr	r3, [sp, #8]	@ y, %sfp
@ StatScreen.c:10: 		const ItemData* item = GetItemData(spells[i]);
	str	r0, [sp, #12]	@ tmp185, %sfp
	lsls	r3, r3, #5	@ _56, y,
@ StatScreen.c:11: 		DrawIcon(&StatScreenBufferMap[iconY][iconX],item->iconId,0x4000);
	ldrb	r1, [r0, #29]	@ tmp148,
	str	r3, [sp, #16]	@ _56, %sfp
	adds	r0, r6, r3	@ tmp149, iconX, _56
	ldr	r3, .L339+8	@ tmp152,
	lsls	r0, r0, #1	@ tmp150, tmp149,
	lsls	r2, r2, #7	@,,
	adds	r0, r0, r3	@ tmp151, tmp150, tmp152
	str	r3, [sp, #20]	@ tmp152, %sfp
	ldr	r3, .L339+12	@ tmp153,
	bl	.L14		@
@ StatScreen.c:13: 		tile += 6;
	ldr	r3, [sp]	@ tile, %sfp
	adds	r3, r3, #6	@ tile,
@ StatScreen.c:15: 		currHandle->xCursor = 0;
	movs	r5, #0	@ tmp155,
@ StatScreen.c:14: 		currHandle->tileIndexOffset = tile;
	strh	r3, [r4]	@ tile, MEM[(short unsigned int *)currHandle_16]
@ StatScreen.c:13: 		tile += 6;
	str	r3, [sp]	@ tile, %sfp
@ StatScreen.c:17: 		currHandle->tileWidth = 6;
	movs	r3, #6	@ tmp202,
@ StatScreen.c:22: 		Text_Clear(currHandle);
	movs	r0, r4	@, currHandle
@ StatScreen.c:15: 		currHandle->xCursor = 0;
	strb	r5, [r4, #2]	@ tmp155, MEM[(unsigned char *)currHandle_16 + 2B]
@ StatScreen.c:16: 		currHandle->colorId = TEXT_COLOR_NORMAL;
	strb	r5, [r4, #3]	@ tmp155, MEM[(unsigned char *)currHandle_16 + 3B]
@ StatScreen.c:17: 		currHandle->tileWidth = 6;
	strb	r3, [r4, #4]	@ tmp201, MEM[(unsigned char *)currHandle_16 + 4B]
@ StatScreen.c:18: 		currHandle->useDoubleBuffer = 0;
	strb	r5, [r4, #5]	@ tmp155, MEM[(unsigned char *)currHandle_16 + 5B]
@ StatScreen.c:19: 		currHandle->currentBufferId = 0;
	strb	r5, [r4, #6]	@ tmp155, MEM[(unsigned char *)currHandle_16 + 6B]
@ StatScreen.c:20: 		currHandle->unk07 = 0;
	strb	r5, [r4, #7]	@ tmp155, MEM[(unsigned char *)currHandle_16 + 7B]
@ StatScreen.c:22: 		Text_Clear(currHandle);
	ldr	r3, .L339+16	@ tmp167,
	bl	.L14		@
@ StatScreen.c:23: 		Text_SetColorId(currHandle,TEXT_COLOR_NORMAL);
	movs	r1, r5	@, tmp155
	movs	r0, r4	@, currHandle
	ldr	r3, .L339+20	@ tmp168,
	bl	.L14		@
@ StatScreen.c:24: 		Text_InsertString(currHandle,0,TEXT_COLOR_NORMAL,GetStringFromIndex(item->nameTextId));
	ldr	r3, [sp, #12]	@ item, %sfp
	ldrh	r0, [r3]	@ *item_32, *item_32
	ldr	r3, .L339+24	@ tmp170,
	bl	.L14		@
@ StatScreen.c:24: 		Text_InsertString(currHandle,0,TEXT_COLOR_NORMAL,GetStringFromIndex(item->nameTextId));
	movs	r2, r5	@, tmp155
@ StatScreen.c:24: 		Text_InsertString(currHandle,0,TEXT_COLOR_NORMAL,GetStringFromIndex(item->nameTextId));
	movs	r3, r0	@ _10, tmp186
@ StatScreen.c:24: 		Text_InsertString(currHandle,0,TEXT_COLOR_NORMAL,GetStringFromIndex(item->nameTextId));
	movs	r1, r5	@, tmp155
	movs	r0, r4	@, currHandle
	ldr	r5, .L339+28	@ tmp171,
	bl	.L269		@
@ StatScreen.c:25: 		Text_Display(currHandle,&StatScreenBufferMap[iconY][iconX+2]);
	ldr	r3, [sp, #16]	@ _56, %sfp
@ StatScreen.c:25: 		Text_Display(currHandle,&StatScreenBufferMap[iconY][iconX+2]);
	adds	r1, r6, #2	@ tmp172, iconX,
@ StatScreen.c:25: 		Text_Display(currHandle,&StatScreenBufferMap[iconY][iconX+2]);
	adds	r1, r1, r3	@ tmp173, tmp172, _56
	ldr	r3, [sp, #20]	@ tmp152, %sfp
	lsls	r1, r1, #1	@ tmp174, tmp173,
	movs	r0, r4	@, currHandle
	adds	r1, r1, r3	@ tmp175, tmp174, tmp152
	ldr	r3, .L339+32	@ tmp177,
	bl	.L14		@
@ StatScreen.c:28: 		if ( iconX == x ) { iconX += 8; }
	ldr	r3, [sp, #4]	@ x, %sfp
@ StatScreen.c:27: 		currHandle++;
	adds	r4, r4, #8	@ currHandle,
@ StatScreen.c:28: 		if ( iconX == x ) { iconX += 8; }
	cmp	r6, r3	@ iconX, x
	bne	.L336		@,
@ StatScreen.c:28: 		if ( iconX == x ) { iconX += 8; }
	adds	r6, r6, #8	@ iconX,
.L337:
	adds	r7, r7, #1	@ ivtmp.416,
	b	.L335		@
.L336:
@ StatScreen.c:29: 		else { iconX = x; iconY += 2; }
	ldr	r3, [sp, #8]	@ y, %sfp
	adds	r3, r3, #2	@ y,
	str	r3, [sp, #8]	@ y, %sfp
	ldr	r6, [sp, #4]	@ iconX, %sfp
	b	.L337		@
.L340:
	.align	2
.L339:
	.word	gpStatScreenUnit
	.word	GetItemData
	.word	StatScreenBufferMap
	.word	DrawIcon
	.word	Text_Clear
	.word	Text_SetColorId
	.word	GetStringFromIndex
	.word	Text_InsertString
	.word	Text_Display
	.size	GaidenStatScreen, .-GaidenStatScreen
	.align	1
	.global	GaidenRTextGetter
	.syntax unified
	.code	16
	.thumb_func
	.type	GaidenRTextGetter, %function
GaidenRTextGetter:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
@ StatScreen.c:37: 	proc->type = SpellsGetter(gpStatScreenUnit,-1)[index]; // I think if this is positive, it treats this as an item bubble.
	movs	r1, #1	@ tmp140,
@ StatScreen.c:35: {
	push	{r4, r5, r6, lr}	@
@ StatScreen.c:35: {
	movs	r4, r0	@ proc, tmp137
@ StatScreen.c:39: }
	@ sp needed	@
@ StatScreen.c:36: 	int index = *(proc->rTextData+0x12);
	ldr	r3, [r0, #44]	@ proc_12(D)->rTextData, proc_12(D)->rTextData
	ldrb	r5, [r3, #18]	@ _2, MEM[(char *)_1 + 18B]
@ StatScreen.c:37: 	proc->type = SpellsGetter(gpStatScreenUnit,-1)[index]; // I think if this is positive, it treats this as an item bubble.
	ldr	r3, .L342	@ tmp126,
	rsbs	r1, r1, #0	@, tmp140
	ldr	r0, [r3]	@, gpStatScreenUnit
	bl	SpellsGetter		@
@ StatScreen.c:37: 	proc->type = SpellsGetter(gpStatScreenUnit,-1)[index]; // I think if this is positive, it treats this as an item bubble.
	movs	r3, r4	@ tmp129, proc
@ StatScreen.c:37: 	proc->type = SpellsGetter(gpStatScreenUnit,-1)[index]; // I think if this is positive, it treats this as an item bubble.
	ldrb	r0, [r0, r5]	@ _7, *_6
@ StatScreen.c:37: 	proc->type = SpellsGetter(gpStatScreenUnit,-1)[index]; // I think if this is positive, it treats this as an item bubble.
	adds	r3, r3, #78	@ tmp129,
	strh	r0, [r3]	@ _7, proc_12(D)->type
@ StatScreen.c:38: 	proc->textID = GetItemData(proc->type)->descTextId;
	ldr	r3, .L342+4	@ tmp131,
	bl	.L14		@
@ StatScreen.c:38: 	proc->textID = GetItemData(proc->type)->descTextId;
	ldrh	r3, [r0, #2]	@ tmp135,
	adds	r4, r4, #76	@ tmp134,
	strh	r3, [r4]	@ tmp135, proc_12(D)->textID
@ StatScreen.c:39: }
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L343:
	.align	2
.L342:
	.word	gpStatScreenUnit
	.word	GetItemData
	.size	GaidenRTextGetter, .-GaidenRTextGetter
	.align	1
	.global	GaidenRTextLooper
	.syntax unified
	.code	16
	.thumb_func
	.type	GaidenRTextLooper, %function
GaidenRTextLooper:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, lr}	@
@ StatScreen.c:43: 	int index = *(proc->rTextData+0x12);
	ldr	r3, [r0, #44]	@ proc_26(D)->rTextData, proc_26(D)->rTextData
	ldrb	r4, [r3, #18]	@ _2, MEM[(char *)_1 + 18B]
@ StatScreen.c:44: 	if ( proc->direction == DIRECTION_RIGHT )
	movs	r3, r0	@ tmp140, proc
	adds	r3, r3, #80	@ tmp140,
	ldrh	r3, [r3]	@ _3,
@ StatScreen.c:42: {
	movs	r5, r0	@ proc, tmp161
@ StatScreen.c:44: 	if ( proc->direction == DIRECTION_RIGHT )
	cmp	r3, #16	@ _3,
	bne	.L345		@,
@ StatScreen.c:47: 		while ( index >= 0 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index]) )
	movs	r7, #1	@ tmp160,
	rsbs	r7, r7, #0	@ tmp160, tmp160
.L346:
@ StatScreen.c:47: 		while ( index >= 0 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index]) )
	ldr	r3, .L356	@ tmp142,
	ldr	r6, [r3]	@ gpStatScreenUnit.123_4, gpStatScreenUnit
@ StatScreen.c:47: 		while ( index >= 0 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index]) )
	movs	r1, r7	@, tmp160
	movs	r0, r6	@, gpStatScreenUnit.123_4
	bl	SpellsGetter		@
@ StatScreen.c:47: 		while ( index >= 0 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index]) )
	ldrb	r1, [r0, r4]	@ *_7, *_7
	movs	r0, r6	@, gpStatScreenUnit.123_4
	bl	DoesUnitKnowSpell		@
@ StatScreen.c:47: 		while ( index >= 0 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index]) )
	cmp	r0, #0	@ tmp163,
	bne	.L344		@,
@ StatScreen.c:49: 			RTextUp(proc);
	movs	r0, r5	@, proc
	ldr	r3, .L356+4	@ tmp141,
	bl	.L14		@
@ StatScreen.c:47: 		while ( index >= 0 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index]) )
	subs	r4, r4, #2	@ index, index,
	bpl	.L346		@,
.L344:
@ StatScreen.c:63: }
	@ sp needed	@
	pop	{r3, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L345:
@ StatScreen.c:53: 	else if ( proc->direction == DIRECTION_DOWN )
	cmp	r3, #128	@ _3,
	bne	.L344		@,
@ StatScreen.c:56: 		if ( !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index]) )
	movs	r1, #1	@,
@ StatScreen.c:56: 		if ( !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index]) )
	ldr	r7, .L356	@ tmp145,
	ldr	r6, [r7]	@ gpStatScreenUnit.126_10, gpStatScreenUnit
@ StatScreen.c:56: 		if ( !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index]) )
	rsbs	r1, r1, #0	@,
	movs	r0, r6	@, gpStatScreenUnit.126_10
	bl	SpellsGetter		@
@ StatScreen.c:56: 		if ( !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index]) )
	ldrb	r1, [r0, r4]	@ *_13, *_13
	movs	r0, r6	@, gpStatScreenUnit.126_10
	bl	DoesUnitKnowSpell		@
@ StatScreen.c:56: 		if ( !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index]) )
	cmp	r0, #0	@ tmp165,
	bne	.L344		@,
@ StatScreen.c:58: 			RTextLeft(proc);
	movs	r0, r5	@, proc
	ldr	r6, .L356+8	@ tmp148,
	bl	.L15		@
@ StatScreen.c:60: 			if ( index % 2 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index-1]) ) { RTextLeft(proc); }
	lsls	r3, r4, #31	@ tmp171, _2,
	bpl	.L344		@,
@ StatScreen.c:60: 			if ( index % 2 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index-1]) ) { RTextLeft(proc); }
	movs	r1, #1	@,
@ StatScreen.c:60: 			if ( index % 2 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index-1]) ) { RTextLeft(proc); }
	ldr	r7, [r7]	@ gpStatScreenUnit.130_16, gpStatScreenUnit
@ StatScreen.c:60: 			if ( index % 2 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index-1]) ) { RTextLeft(proc); }
	rsbs	r1, r1, #0	@,
	movs	r0, r7	@, gpStatScreenUnit.130_16
	bl	SpellsGetter		@
@ StatScreen.c:60: 			if ( index % 2 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index-1]) ) { RTextLeft(proc); }
	adds	r0, r0, r4	@ tmp156, tmp166, _2
	subs	r0, r0, #1	@ tmp157,
	ldrb	r1, [r0]	@ *_19, *_19
	movs	r0, r7	@, gpStatScreenUnit.130_16
	bl	DoesUnitKnowSpell		@
@ StatScreen.c:60: 			if ( index % 2 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index-1]) ) { RTextLeft(proc); }
	cmp	r0, #0	@ tmp167,
	bne	.L344		@,
@ StatScreen.c:60: 			if ( index % 2 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index-1]) ) { RTextLeft(proc); }
	movs	r0, r5	@, proc
	bl	.L15		@
@ StatScreen.c:63: }
	b	.L344		@
.L357:
	.align	2
.L356:
	.word	gpStatScreenUnit
	.word	RTextUp
	.word	RTextLeft
	.size	GaidenRTextLooper, .-GaidenRTextLooper
	.ident	"GCC: (devkitARM release 58) 12.1.0"
	.code 16
	.align	1
.L14:
	bx	r3
.L16:
	bx	r4
.L269:
	bx	r5
.L15:
	bx	r6
.L327:
	bx	r7
