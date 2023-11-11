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
@ GNU C17 (devkitARM release 61) version 13.1.0 (arm-none-eabi)
@	compiled by GNU C version 10.3.0, GMP version 6.2.1, MPFR version 4.1.0, MPC version 1.2.1, isl version isl-0.18-GMP

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
	movs	r4, r1	@ existing, tmp186
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
	orrs	r0, r2	@ tmp138, new
@ RangeDisplay.c:64: 	long long existingMax = (existing >> 32) & 0xFF;
	movs	r2, #255	@ tmp145,
@ RangeDisplay.c:66: 	return existingMask|newMask|(( newMin < existingMin ? newMin : existingMin ) << 40)|(( newMax > existingMax ? newMax : existingMax ) << 32);
	lsls	r1, r1, #8	@ tmp168, existingMin,
@ RangeDisplay.c:65: 	long long newMax = (new >> 32) & 0xFF;
	ands	r3, r2	@ newMax, tmp145
@ RangeDisplay.c:66: 	return existingMask|newMask|(( newMin < existingMin ? newMin : existingMin ) << 40)|(( newMax > existingMax ? newMax : existingMax ) << 32);
	ands	r4, r2	@ existingMax, tmp145
	cmp	r3, r4	@ newMax, existingMax
	bls	.L4		@,
	movs	r4, r3	@ existingMax, newMax
.L4:
@ RangeDisplay.c:67: }
	@ sp needed	@
@ RangeDisplay.c:66: 	return existingMask|newMask|(( newMin < existingMin ? newMin : existingMin ) << 40)|(( newMax > existingMax ? newMax : existingMax ) << 32);
	orrs	r1, r4	@ tmp160, existingMax
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
	movs	r4, r0	@ spellsList, tmp146
	subs	r0, r1, #0	@ proc, tmp147,
@ UnitMenu.c:51: 	if ( proc && commandProc->availability == 2 )
	beq	.L7		@,
@ UnitMenu.c:51: 	if ( proc && commandProc->availability == 2 )
	adds	r2, r2, #61	@ tmp127,
@ UnitMenu.c:51: 	if ( proc && commandProc->availability == 2 )
	ldrb	r3, [r2]	@ tmp128,
	cmp	r3, #2	@ tmp128,
	bne	.L7		@,
@ UnitMenu.c:54: 		MenuCallHelpBox(proc,gGaidenMagicUMErrorText);
	ldr	r3, .L12	@ tmp129,
	ldrh	r1, [r3]	@ gGaidenMagicUMErrorText, gGaidenMagicUMErrorText
	ldr	r3, .L12+4	@ tmp131,
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
	ldr	r3, .L12+8	@ tmp132,
	bl	.L14		@
@ UnitMenu.c:60: 		SelectedSpell = spellsList[0];
	ldrb	r2, [r4]	@ _3, *spellsList_14(D)
@ UnitMenu.c:60: 		SelectedSpell = spellsList[0];
	ldr	r3, .L12+12	@ tmp133,
@ UnitMenu.c:61: 		LoadIconPalettes(4);
	movs	r0, #4	@,
@ UnitMenu.c:60: 		SelectedSpell = spellsList[0];
	strb	r2, [r3]	@ _3, SelectedSpell
@ UnitMenu.c:61: 		LoadIconPalettes(4);
	ldr	r3, .L12+16	@ tmp135,
	bl	.L14		@
@ UnitMenu.c:62: 		MenuProc* menu = StartMenu(&SpellSelectMenuDefs);
	ldr	r3, .L12+20	@ tmp137,
	ldr	r0, .L12+24	@ tmp136,
	bl	.L14		@
@ UnitMenu.c:64: 		StartFace(0,GetUnitPortraitId(gActiveUnit),0xB0,0xC,2);
	ldr	r5, .L12+28	@ tmp138,
@ UnitMenu.c:62: 		MenuProc* menu = StartMenu(&SpellSelectMenuDefs);
	movs	r4, r0	@ menu, tmp149
@ UnitMenu.c:64: 		StartFace(0,GetUnitPortraitId(gActiveUnit),0xB0,0xC,2);
	ldr	r3, .L12+32	@ tmp139,
	ldr	r0, [r5]	@, gActiveUnit
	bl	.L14		@
@ UnitMenu.c:64: 		StartFace(0,GetUnitPortraitId(gActiveUnit),0xB0,0xC,2);
	movs	r3, #2	@ tmp140,
@ UnitMenu.c:64: 		StartFace(0,GetUnitPortraitId(gActiveUnit),0xB0,0xC,2);
	movs	r1, r0	@ _5, tmp150
@ UnitMenu.c:64: 		StartFace(0,GetUnitPortraitId(gActiveUnit),0xB0,0xC,2);
	movs	r2, #176	@,
	str	r3, [sp]	@ tmp140,
	movs	r0, #0	@,
	adds	r3, r3, #10	@,
	ldr	r6, .L12+36	@ tmp141,
	bl	.L15		@
@ UnitMenu.c:65: 		SetFaceBlinkControlById(0,5);
	movs	r1, #5	@,
	movs	r0, #0	@,
	ldr	r3, .L12+40	@ tmp142,
	bl	.L14		@
@ UnitMenu.c:66: 		ForceMenuItemPanel(menu,gActiveUnit,15,11);
	movs	r0, r4	@, menu
	movs	r3, #11	@,
	movs	r2, #15	@,
	ldr	r1, [r5]	@, gActiveUnit
	ldr	r4, .L12+44	@ tmp144,
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
	ldr	r3, .L19	@ tmp117,
@ UnitMenu.c:112: 	if ( !SelectedSpell ) { UsingSpellMenu = 0; } // Don't unset this if we're going to the spell menu.
	ldrb	r3, [r3]	@ SelectedSpell, SelectedSpell
	cmp	r3, #0	@ SelectedSpell,
	bne	.L18		@,
@ UnitMenu.c:112: 	if ( !SelectedSpell ) { UsingSpellMenu = 0; } // Don't unset this if we're going to the spell menu.
	ldr	r2, .L19+4	@ tmp119,
	strb	r3, [r2]	@ SelectedSpell, UsingSpellMenu
.L18:
@ UnitMenu.c:115: }
	@ sp needed	@
@ UnitMenu.c:113: 	HideMoveRangeGraphics();
	ldr	r3, .L19+8	@ tmp122,
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
	ldr	r3, .L27	@ tmp123,
@ SpellSystem.c:205: {
	movs	r4, r1	@ spell, tmp136
@ SpellSystem.c:207: 	int type = GetItemType(spell);
	bl	.L14		@
@ SpellSystem.c:210: 		if ( !CanUnitUseWeaponNow(gActiveUnit,spell) ) { return 0; }
	movs	r1, r4	@, spell
	ldr	r5, .L27+4	@ tmp135,
@ SpellSystem.c:208: 	if ( type != ITYPE_STAFF )
	cmp	r0, #4	@ tmp137,
	beq	.L22		@,
@ SpellSystem.c:210: 		if ( !CanUnitUseWeaponNow(gActiveUnit,spell) ) { return 0; }
	ldr	r0, [r5]	@, gActiveUnit
	ldr	r3, .L27+8	@ tmp125,
	bl	.L14		@
@ SpellSystem.c:210: 		if ( !CanUnitUseWeaponNow(gActiveUnit,spell) ) { return 0; }
	cmp	r0, #0	@ <retval>,
	beq	.L21		@,
@ SpellSystem.c:212: 		MakeTargetListForWeapon(gActiveUnit,spell);
	movs	r1, r4	@, spell
	ldr	r0, [r5]	@, gActiveUnit
	ldr	r3, .L27+12	@ tmp127,
	bl	.L14		@
@ SpellSystem.c:213: 		return GetTargetListSize() != 0;
	ldr	r3, .L27+16	@ tmp128,
	bl	.L14		@
@ SpellSystem.c:213: 		return GetTargetListSize() != 0;
	subs	r3, r0, #1	@ tmp131, tmp139
	sbcs	r0, r0, r3	@ <retval>, tmp139, tmp131
.L21:
@ SpellSystem.c:219: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L22:
@ SpellSystem.c:217: 		return CanUnitUseItem(gActiveUnit,spell);
	ldr	r0, [r5]	@, gActiveUnit
	ldr	r3, .L27+20	@ tmp133,
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
	ldr	r3, .L35	@ tmp123,
@ SpellSystem.c:222: {
	movs	r4, r1	@ spell, tmp136
@ SpellSystem.c:223: 	int type = GetItemType(spell);
	bl	.L14		@
@ SpellSystem.c:226: 		if ( !CanUnitUseWeapon(gActiveUnit,spell) ) { return 0; }
	movs	r1, r4	@, spell
	ldr	r5, .L35+4	@ tmp135,
@ SpellSystem.c:224: 	if ( type != ITYPE_STAFF )
	cmp	r0, #4	@ tmp137,
	beq	.L30		@,
@ SpellSystem.c:226: 		if ( !CanUnitUseWeapon(gActiveUnit,spell) ) { return 0; }
	ldr	r0, [r5]	@, gActiveUnit
	ldr	r3, .L35+8	@ tmp125,
	bl	.L14		@
@ SpellSystem.c:226: 		if ( !CanUnitUseWeapon(gActiveUnit,spell) ) { return 0; }
	cmp	r0, #0	@ <retval>,
	beq	.L29		@,
@ SpellSystem.c:228: 		MakeTargetListForWeapon(gActiveUnit,spell);
	movs	r1, r4	@, spell
	ldr	r0, [r5]	@, gActiveUnit
	ldr	r3, .L35+12	@ tmp127,
	bl	.L14		@
@ SpellSystem.c:229: 		return GetTargetListSize() != 0;
	ldr	r3, .L35+16	@ tmp128,
	bl	.L14		@
@ SpellSystem.c:229: 		return GetTargetListSize() != 0;
	subs	r3, r0, #1	@ tmp131, tmp139
	sbcs	r0, r0, r3	@ <retval>, tmp139, tmp131
.L29:
@ SpellSystem.c:235: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L30:
@ SpellSystem.c:217: 		return CanUnitUseItem(gActiveUnit,spell);
	ldr	r0, [r5]	@, gActiveUnit
	ldr	r3, .L35+20	@ tmp133,
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
	ldr	r3, .L40	@ tmp120,
@ RangeDisplay.c:70: {
	movs	r5, r0	@ unit, tmp125
@ RangeDisplay.c:72: 	return GetItemType(item) == ITYPE_STAFF && CanCastSpell(unit,item);
	movs	r0, r1	@, item
@ RangeDisplay.c:70: {
	movs	r4, r1	@ item, tmp126
@ RangeDisplay.c:72: 	return GetItemType(item) == ITYPE_STAFF && CanCastSpell(unit,item);
	bl	.L14		@
	movs	r3, r0	@ tmp127,
@ RangeDisplay.c:72: 	return GetItemType(item) == ITYPE_STAFF && CanCastSpell(unit,item);
	movs	r0, #0	@ <retval>,
@ RangeDisplay.c:72: 	return GetItemType(item) == ITYPE_STAFF && CanCastSpell(unit,item);
	cmp	r3, #4	@ tmp127,
	bne	.L37		@,
@ RangeDisplay.c:72: 	return GetItemType(item) == ITYPE_STAFF && CanCastSpell(unit,item);
	movs	r1, r4	@, item
	movs	r0, r5	@, unit
	bl	CanCastSpell		@
@ RangeDisplay.c:72: 	return GetItemType(item) == ITYPE_STAFF && CanCastSpell(unit,item);
	subs	r3, r0, #1	@ tmp123, tmp128
	sbcs	r0, r0, r3	@ <retval>, tmp128, tmp123
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
	ldr	r3, .L46	@ tmp120,
@ RangeDisplay.c:76: {
	movs	r5, r0	@ unit, tmp125
@ RangeDisplay.c:77: 	return GetItemType(item) != ITYPE_STAFF && CanCastSpell(unit,item);
	movs	r0, r1	@, item
@ RangeDisplay.c:76: {
	movs	r4, r1	@ item, tmp126
@ RangeDisplay.c:77: 	return GetItemType(item) != ITYPE_STAFF && CanCastSpell(unit,item);
	bl	.L14		@
	movs	r3, r0	@ tmp127,
@ RangeDisplay.c:77: 	return GetItemType(item) != ITYPE_STAFF && CanCastSpell(unit,item);
	movs	r0, #0	@ <retval>,
@ RangeDisplay.c:77: 	return GetItemType(item) != ITYPE_STAFF && CanCastSpell(unit,item);
	cmp	r3, #4	@ tmp127,
	beq	.L42		@,
@ RangeDisplay.c:77: 	return GetItemType(item) != ITYPE_STAFF && CanCastSpell(unit,item);
	movs	r1, r4	@, item
	movs	r0, r5	@, unit
	bl	CanCastSpell		@
@ RangeDisplay.c:77: 	return GetItemType(item) != ITYPE_STAFF && CanCastSpell(unit,item);
	subs	r3, r0, #1	@ tmp123, tmp128
	sbcs	r0, r0, r3	@ <retval>, tmp128, tmp123
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
	push	{r4, lr}	@
@ SpellSystem.c:289: 	int wType = GetItemType(spell);
	ldr	r3, .L54	@ tmp117,
	bl	.L14		@
	subs	r0, r0, #4	@ tmp118,
	cmp	r0, #3	@ tmp118,
	bhi	.L49		@,
	bl	__gnu_thumb1_case_uqi
.L51:
	.byte	(.L53-.L51)/2
	.byte	(.L50-.L51)/2
	.byte	(.L53-.L51)/2
	.byte	(.L50-.L51)/2
	.p2align 1
.L50:
@ SpellSystem.c:290: 	if ( wType == ITYPE_ANIMA || wType == ITYPE_DARK ) { return BLACK_MAGIC; }
	movs	r0, #1	@ <retval>,
.L48:
@ SpellSystem.c:293: }
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L49:
@ SpellSystem.c:292: 	else { return -1; }
	movs	r0, #1	@ <retval>,
	rsbs	r0, r0, #0	@ <retval>, <retval>
	b	.L48		@
.L53:
@ SpellSystem.c:289: 	int wType = GetItemType(spell);
	movs	r0, #2	@ <retval>,
	b	.L48		@
.L55:
	.align	2
.L54:
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
	str	r2, [sp]	@ tmp154, %sfp
@ SpellSystem.c:10: 	int unitLevel = unit->level;
	ldrsb	r6, [r0, r6]	@ unitLevel,* unitLevel
@ SpellSystem.c:11: 	if ( UNIT_ATTRIBUTES(unit) & CA_PROMOTED ) { unitLevel += 80; } // Treat promoted as top bit set.
	ldmia	r0!, {r2, r3}	@,,
@ SpellSystem.c:8: {
	movs	r7, r1	@ level, tmp153
@ SpellSystem.c:11: 	if ( UNIT_ATTRIBUTES(unit) & CA_PROMOTED ) { unitLevel += 80; } // Treat promoted as top bit set.
	ldr	r3, [r3, #40]	@ _4->attributes, _4->attributes
	ldr	r1, [r2, #40]	@ _2->attributes, _2->attributes
	orrs	r3, r1	@ tmp139, _2->attributes
@ SpellSystem.c:11: 	if ( UNIT_ATTRIBUTES(unit) & CA_PROMOTED ) { unitLevel += 80; } // Treat promoted as top bit set.
	lsls	r3, r3, #23	@ tmp156, tmp139,
	bpl	.L57		@,
@ SpellSystem.c:11: 	if ( UNIT_ATTRIBUTES(unit) & CA_PROMOTED ) { unitLevel += 80; } // Treat promoted as top bit set.
	adds	r6, r6, #80	@ unitLevel,
.L57:
@ SpellSystem.c:13: 	SpellList* ROMList = SpellListTable[unit->pCharacterData->number];
	ldrb	r2, [r2, #4]	@ tmp145,
@ SpellSystem.c:13: 	SpellList* ROMList = SpellListTable[unit->pCharacterData->number];
	ldr	r3, .L73	@ tmp144,
	lsls	r2, r2, #2	@ tmp146, tmp145,
	ldr	r4, [r2, r3]	@ ROMList, SpellListTable[_10]
	ldr	r3, .L73+4	@ <retval>,
@ SpellSystem.c:12: 	u8* currBuffer = SpellsBuffer;
	movs	r5, r3	@ currBuffer, <retval>
	str	r3, [sp, #4]	@ <retval>, %sfp
@ SpellSystem.c:14: 	if ( ROMList )
	cmp	r4, #0	@ ROMList,
	beq	.L58		@,
.L59:
@ SpellSystem.c:17: 		for ( int i = 0 ; ROMList[i].level ; i++ )
	ldrb	r3, [r4]	@ _20, MEM[(unsigned char *)_13]
@ SpellSystem.c:17: 		for ( int i = 0 ; ROMList[i].level ; i++ )
	cmp	r3, #0	@ _20,
	bne	.L66		@,
.L58:
@ SpellSystem.c:33: }
	@ sp needed	@
@ SpellSystem.c:31: 	*currBuffer = 0;
	movs	r3, #0	@ tmp148,
@ SpellSystem.c:33: }
	ldr	r0, [sp, #4]	@, %sfp
@ SpellSystem.c:31: 	*currBuffer = 0;
	strb	r3, [r5]	@ tmp148, *currBuffer_24
@ SpellSystem.c:33: }
	pop	{r1, r2, r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L66:
@ SpellSystem.c:19: 			if ( (level == -1 && unitLevel >= ROMList[i].level) || (level == ROMList[i].level) )
	adds	r2, r7, #1	@ tmp157, level,
	bne	.L60		@,
@ SpellSystem.c:19: 			if ( (level == -1 && unitLevel >= ROMList[i].level) || (level == ROMList[i].level) )
	cmp	r6, r3	@ unitLevel, _20
	bge	.L61		@,
.L64:
	adds	r4, r4, #2	@ ivtmp.207,
	b	.L59		@
.L60:
@ SpellSystem.c:19: 			if ( (level == -1 && unitLevel >= ROMList[i].level) || (level == ROMList[i].level) )
	cmp	r7, r3	@ level, _20
	bne	.L64		@,
.L61:
@ SpellSystem.c:21: 				if ( type == -1 || type == GetSpellType(ROMList[i].spell) )
	ldr	r3, [sp]	@ type, %sfp
@ SpellSystem.c:21: 				if ( type == -1 || type == GetSpellType(ROMList[i].spell) )
	ldrb	r0, [r4, #1]	@ pretmp_44, MEM[(unsigned char *)_13 + 1B]
@ SpellSystem.c:21: 				if ( type == -1 || type == GetSpellType(ROMList[i].spell) )
	adds	r3, r3, #1	@ tmp158, type,
	bne	.L63		@,
.L65:
@ SpellSystem.c:24: 					*currBuffer = ROMList[i].spell;
	ldrb	r3, [r4, #1]	@ _16, MEM[(unsigned char *)_13 + 1B]
@ SpellSystem.c:24: 					*currBuffer = ROMList[i].spell;
	strb	r3, [r5]	@ _16, *currBuffer_23
@ SpellSystem.c:25: 					currBuffer++;
	adds	r5, r5, #1	@ currBuffer,
	b	.L64		@
.L63:
@ SpellSystem.c:21: 				if ( type == -1 || type == GetSpellType(ROMList[i].spell) )
	bl	GetSpellType		@
@ SpellSystem.c:21: 				if ( type == -1 || type == GetSpellType(ROMList[i].spell) )
	ldr	r3, [sp]	@ type, %sfp
	cmp	r0, r3	@ tmp155, type
	bne	.L64		@,
	b	.L65		@
.L74:
	.align	2
.L73:
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
	movs	r2, r1	@ type, tmp120
@ SpellSystem.c:4: 	return SpellsGetterForLevel(unit,-1,type);
	movs	r1, #1	@ tmp122,
@ SpellSystem.c:3: {
	push	{r4, lr}	@
@ SpellSystem.c:4: 	return SpellsGetterForLevel(unit,-1,type);
	rsbs	r1, r1, #0	@, tmp122
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
	movs	r5, r1	@ commandProc, tmp125
@ UnitMenu.c:41: }
	@ sp needed	@
@ UnitMenu.c:39: 	UsingSpellMenu = BLACK_MAGIC;
	movs	r1, #1	@ tmp120,
@ UnitMenu.c:38: {
	movs	r4, r0	@ proc, tmp124
@ UnitMenu.c:39: 	UsingSpellMenu = BLACK_MAGIC;
	ldr	r3, .L77	@ tmp119,
	strb	r1, [r3]	@ tmp120, UsingSpellMenu
@ UnitMenu.c:40: 	return GaidenMagicUMEffectExt(SpellsGetter(gActiveUnit,BLACK_MAGIC),proc,commandProc);
	ldr	r3, .L77+4	@ tmp122,
	ldr	r0, [r3]	@, gActiveUnit
	bl	SpellsGetter		@
@ UnitMenu.c:40: 	return GaidenMagicUMEffectExt(SpellsGetter(gActiveUnit,BLACK_MAGIC),proc,commandProc);
	movs	r2, r5	@, commandProc
	movs	r1, r4	@, proc
	bl	GaidenMagicUMEffectExt		@
@ UnitMenu.c:41: }
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L78:
	.align	2
.L77:
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
	movs	r5, r1	@ commandProc, tmp125
@ UnitMenu.c:47: }
	@ sp needed	@
@ UnitMenu.c:45: 	UsingSpellMenu = WHITE_MAGIC;
	movs	r1, #2	@ tmp120,
@ UnitMenu.c:44: {
	movs	r4, r0	@ proc, tmp124
@ UnitMenu.c:45: 	UsingSpellMenu = WHITE_MAGIC;
	ldr	r3, .L80	@ tmp119,
	strb	r1, [r3]	@ tmp120, UsingSpellMenu
@ UnitMenu.c:46: 	return GaidenMagicUMEffectExt(SpellsGetter(gActiveUnit,WHITE_MAGIC),proc,commandProc);
	ldr	r3, .L80+4	@ tmp122,
	ldr	r0, [r3]	@, gActiveUnit
	bl	SpellsGetter		@
@ UnitMenu.c:46: 	return GaidenMagicUMEffectExt(SpellsGetter(gActiveUnit,WHITE_MAGIC),proc,commandProc);
	movs	r2, r5	@, commandProc
	movs	r1, r4	@, proc
	bl	GaidenMagicUMEffectExt		@
@ UnitMenu.c:47: }
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L81:
	.align	2
.L80:
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
	movs	r3, r0	@ _77, unit
	push	{r0, r1, r2, r4, r5, r6, r7, lr}	@
	movs	r6, r0	@ ivtmp.232, unit
@ SpellSystem.c:120: {
	movs	r5, r0	@ unit, tmp182
@ SpellSystem.c:121: 	u32 ret = 0;
	movs	r4, #0	@ <retval>,
@ SpellSystem.c:125: 		if ( attributes & IA_WEAPON )
	movs	r7, #1	@ tmp180,
	adds	r3, r3, #40	@ _77,
	str	r3, [sp, #4]	@ _77, %sfp
	adds	r6, r6, #30	@ ivtmp.232,
.L83:
@ SpellSystem.c:122: 	for ( int i = 0 ; i < 5 && unit->items[i] ; i++ )
	ldrh	r0, [r6]	@ _11, MEM[(short unsigned int *)_73]
@ SpellSystem.c:122: 	for ( int i = 0 ; i < 5 && unit->items[i] ; i++ )
	cmp	r0, #0	@ _11,
	beq	.L88		@,
@ SpellSystem.c:124: 		u32 attributes = GetItemAttributes(unit->items[i]);
	ldr	r3, .L108	@ tmp146,
	bl	.L14		@
@ SpellSystem.c:125: 		if ( attributes & IA_WEAPON )
	tst	r0, r7	@ attributes, tmp180
	beq	.L84		@,
@ SpellSystem.c:127: 			if ( CanUnitUseWeaponNow(unit,unit->items[i]) ) { ret |= 1; }
	movs	r0, r5	@, unit
	ldrh	r1, [r6]	@ MEM[(short unsigned int *)_73], MEM[(short unsigned int *)_73]
	ldr	r3, .L108+4	@ tmp150,
	bl	.L14		@
@ SpellSystem.c:127: 			if ( CanUnitUseWeaponNow(unit,unit->items[i]) ) { ret |= 1; }
	cmp	r0, #0	@ tmp184,
	beq	.L86		@,
@ SpellSystem.c:127: 			if ( CanUnitUseWeaponNow(unit,unit->items[i]) ) { ret |= 1; }
	orrs	r4, r7	@ <retval>, tmp180
.L86:
@ SpellSystem.c:122: 	for ( int i = 0 ; i < 5 && unit->items[i] ; i++ )
	ldr	r3, [sp, #4]	@ _77, %sfp
	adds	r6, r6, #2	@ ivtmp.232,
	cmp	r6, r3	@ ivtmp.232, _77
	bne	.L83		@,
.L88:
@ SpellSystem.c:135: 	u8* spells = SpellsGetter(unit,-1);
	movs	r1, #1	@,
	movs	r0, r5	@, unit
	rsbs	r1, r1, #0	@,
	bl	SpellsGetter		@
@ SpellSystem.c:139: 		if ( attributes & IA_WEAPON )
	movs	r7, #1	@ tmp178,
@ SpellSystem.c:135: 	u8* spells = SpellsGetter(unit,-1);
	movs	r6, r0	@ ivtmp.226, tmp186
.L90:
@ SpellSystem.c:136: 	for ( int i = 0 ; spells[i] ; i++ )
	ldrb	r0, [r6]	@ _26, MEM[(u8 *)_66]
@ SpellSystem.c:136: 	for ( int i = 0 ; spells[i] ; i++ )
	cmp	r0, #0	@ _26,
	bne	.L95		@,
@ SpellSystem.c:149: }
	@ sp needed	@
	movs	r0, r4	@, <retval>
	pop	{r1, r2, r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L84:
@ SpellSystem.c:129: 		else if ( attributes & IA_STAFF )
	movs	r3, #4	@ tmp194,
	tst	r0, r3	@ attributes, tmp194
	beq	.L86		@,
@ SpellSystem.c:131: 			if ( CanUnitUseStaffNow(unit,unit->items[i]) ) { ret |= 2; }
	movs	r0, r5	@, unit
	ldrh	r1, [r6]	@ MEM[(short unsigned int *)_73], MEM[(short unsigned int *)_73]
	ldr	r3, .L108+8	@ tmp157,
	bl	.L14		@
@ SpellSystem.c:131: 			if ( CanUnitUseStaffNow(unit,unit->items[i]) ) { ret |= 2; }
	cmp	r0, #0	@ tmp185,
	beq	.L86		@,
@ SpellSystem.c:131: 			if ( CanUnitUseStaffNow(unit,unit->items[i]) ) { ret |= 2; }
	movs	r3, #2	@ tmp160,
	orrs	r4, r3	@ <retval>, tmp160
	b	.L86		@
.L95:
@ SpellSystem.c:138: 		u32 attributes = GetItemAttributes(spells[i]);
	ldr	r3, .L108	@ tmp162,
	bl	.L14		@
@ SpellSystem.c:139: 		if ( attributes & IA_WEAPON )
	tst	r0, r7	@ attributes, tmp178
	beq	.L91		@,
@ SpellSystem.c:141: 			if ( CanUnitUseWeaponNow(unit,spells[i]) ) { ret |= 1; }
	movs	r0, r5	@, unit
	ldrb	r1, [r6]	@ MEM[(u8 *)_66], MEM[(u8 *)_66]
	ldr	r3, .L108+4	@ tmp166,
	bl	.L14		@
@ SpellSystem.c:141: 			if ( CanUnitUseWeaponNow(unit,spells[i]) ) { ret |= 1; }
	cmp	r0, #0	@ tmp188,
	beq	.L93		@,
@ SpellSystem.c:141: 			if ( CanUnitUseWeaponNow(unit,spells[i]) ) { ret |= 1; }
	orrs	r4, r7	@ <retval>, tmp178
.L93:
	adds	r6, r6, #1	@ ivtmp.226,
	b	.L90		@
.L91:
@ SpellSystem.c:143: 		else if ( attributes & IA_STAFF )
	movs	r3, #4	@ tmp196,
	tst	r0, r3	@ attributes, tmp196
	beq	.L93		@,
@ SpellSystem.c:145: 			if ( CanUnitUseStaffNow(unit,spells[i]) ) { ret |= 2; }
	movs	r0, r5	@, unit
	ldrb	r1, [r6]	@ MEM[(u8 *)_66], MEM[(u8 *)_66]
	ldr	r3, .L108+8	@ tmp173,
	bl	.L14		@
@ SpellSystem.c:145: 			if ( CanUnitUseStaffNow(unit,spells[i]) ) { ret |= 2; }
	cmp	r0, #0	@ tmp189,
	beq	.L93		@,
@ SpellSystem.c:145: 			if ( CanUnitUseStaffNow(unit,spells[i]) ) { ret |= 2; }
	movs	r3, #2	@ tmp176,
	orrs	r4, r3	@ <retval>, tmp176
	b	.L93		@
.L109:
	.align	2
.L108:
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
	movs	r5, r0	@ unit, tmp129
@ SpellSystem.c:239: 	u8* spells = SpellsGetter(unit,type);
	bl	SpellsGetter		@
	movs	r4, r0	@ ivtmp.240, tmp131
.L111:
@ SpellSystem.c:240: 	for ( int i = 0 ; spells[i] ; i++ )
	ldrb	r0, [r4]	@ _8, MEM[(u8 *)_25]
@ SpellSystem.c:240: 	for ( int i = 0 ; spells[i] ; i++ )
	cmp	r0, #0	@ _8,
	bne	.L115		@,
.L110:
@ SpellSystem.c:248: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L115:
@ SpellSystem.c:242: 		if ( GetItemType(spells[i]) != ITYPE_STAFF && CanCastSpellNow(unit,spells[i]) )
	ldr	r3, .L117	@ tmp126,
	bl	.L14		@
@ SpellSystem.c:242: 		if ( GetItemType(spells[i]) != ITYPE_STAFF && CanCastSpellNow(unit,spells[i]) )
	cmp	r0, #4	@ tmp132,
	bne	.L112		@,
.L114:
	adds	r4, r4, #1	@ ivtmp.240,
	b	.L111		@
.L112:
@ SpellSystem.c:242: 		if ( GetItemType(spells[i]) != ITYPE_STAFF && CanCastSpellNow(unit,spells[i]) )
	movs	r0, r5	@, unit
	ldrb	r1, [r4]	@ MEM[(u8 *)_25], MEM[(u8 *)_25]
	bl	CanCastSpellNow		@
@ SpellSystem.c:242: 		if ( GetItemType(spells[i]) != ITYPE_STAFF && CanCastSpellNow(unit,spells[i]) )
	cmp	r0, #0	@ tmp133,
	beq	.L114		@,
@ SpellSystem.c:244: 			return 1;
	movs	r0, #1	@ <retval>,
	b	.L110		@
.L118:
	.align	2
.L117:
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
	movs	r7, r1	@ n, tmp126
	movs	r1, r2	@ type, tmp127
	movs	r5, r0	@ unit, tmp125
@ SpellSystem.c:254: 	u8* spells = SpellsGetter(unit,type);
	bl	SpellsGetter		@
@ SpellSystem.c:255: 	int k = -1;
	movs	r6, #1	@ k,
@ SpellSystem.c:256: 	for ( int i = 0 ; spells[i] ; i++ )
	movs	r4, #0	@ <retval>,
@ SpellSystem.c:254: 	u8* spells = SpellsGetter(unit,type);
	str	r0, [sp, #4]	@ tmp128, %sfp
@ SpellSystem.c:255: 	int k = -1;
	rsbs	r6, r6, #0	@ k, k
.L120:
@ SpellSystem.c:256: 	for ( int i = 0 ; spells[i] ; i++ )
	ldr	r3, [sp, #4]	@ spells, %sfp
	ldrb	r1, [r3, r4]	@ _6, MEM[(u8 *)spells_17 + _24 * 1]
@ SpellSystem.c:256: 	for ( int i = 0 ; spells[i] ; i++ )
	cmp	r1, #0	@ _6,
	bne	.L123		@,
@ SpellSystem.c:264: 	return -1;
	movs	r4, #1	@ <retval>,
	rsbs	r4, r4, #0	@ <retval>, <retval>
.L119:
@ SpellSystem.c:265: }
	movs	r0, r4	@, <retval>
	@ sp needed	@
	pop	{r1, r2, r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L123:
@ SpellSystem.c:258: 		if ( CanCastSpellNow(unit,spells[i]) )
	movs	r0, r5	@, unit
	bl	CanCastSpellNow		@
@ SpellSystem.c:258: 		if ( CanCastSpellNow(unit,spells[i]) )
	cmp	r0, #0	@ tmp129,
	beq	.L121		@,
@ SpellSystem.c:260: 			k++;
	adds	r6, r6, #1	@ k,
@ SpellSystem.c:261: 			if ( k == n ) { return i; }
	cmp	r6, r7	@ k, n
	beq	.L119		@,
.L121:
@ SpellSystem.c:256: 	for ( int i = 0 ; spells[i] ; i++ )
	adds	r4, r4, #1	@ <retval>,
	b	.L120		@
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
	movs	r4, r1	@ spell, tmp124
@ SpellSystem.c:279: 	u8* spells = SpellsGetter(unit,-1);
	movs	r1, #1	@,
	rsbs	r1, r1, #0	@,
	bl	SpellsGetter		@
.L128:
@ SpellSystem.c:280: 	for ( int i = 0 ; spells[i] ; i++ )
	ldrb	r3, [r0]	@ _3, MEM[(u8 *)_15]
@ SpellSystem.c:280: 	for ( int i = 0 ; spells[i] ; i++ )
	cmp	r3, #0	@ _3,
	bne	.L130		@,
@ SpellSystem.c:284: 	return 0;
	movs	r0, r3	@ <retval>, _3
.L127:
@ SpellSystem.c:285: }
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L130:
@ SpellSystem.c:282: 		if ( spell == spells[i] ) { return 1; }
	adds	r0, r0, #1	@ ivtmp.254,
	cmp	r3, r4	@ _3, spell
	bne	.L128		@,
@ SpellSystem.c:282: 		if ( spell == spells[i] ) { return 1; }
	movs	r0, #1	@ <retval>,
	b	.L127		@
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
	push	{r4, lr}	@
@ SpellSystem.c:183: 	if ( gBattleActor.levelPrevious != gBattleActor.unit.level ) { subject = &gBattleActor; }
	ldr	r2, .L142	@ tmp135,
	ldrb	r0, [r2]	@ tmp136,
@ SpellSystem.c:183: 	if ( gBattleActor.levelPrevious != gBattleActor.unit.level ) { subject = &gBattleActor; }
	movs	r2, #8	@ tmp138,
@ SpellSystem.c:183: 	if ( gBattleActor.levelPrevious != gBattleActor.unit.level ) { subject = &gBattleActor; }
	ldr	r3, .L142+4	@ tmp132,
@ SpellSystem.c:183: 	if ( gBattleActor.levelPrevious != gBattleActor.unit.level ) { subject = &gBattleActor; }
	ldrsb	r2, [r3, r2]	@ tmp138,
@ SpellSystem.c:182: 	BattleUnit* subject = NULL;
	subs	r0, r0, r2	@ tmp156, tmp136, tmp138
	subs	r2, r0, #1	@ tmp157, tmp156
	sbcs	r0, r0, r2	@ tmp155, tmp156, tmp157
@ SpellSystem.c:184: 	if ( gBattleTarget.levelPrevious != gBattleTarget.unit.level ) { subject = &gBattleTarget; }
	ldr	r2, .L142+8	@ tmp142,
	ldrb	r1, [r2]	@ tmp143,
@ SpellSystem.c:184: 	if ( gBattleTarget.levelPrevious != gBattleTarget.unit.level ) { subject = &gBattleTarget; }
	movs	r2, #8	@ tmp145,
@ SpellSystem.c:182: 	BattleUnit* subject = NULL;
	rsbs	r0, r0, #0	@ tmp158, tmp155
	ands	r0, r3	@ subject, tmp132
@ SpellSystem.c:184: 	if ( gBattleTarget.levelPrevious != gBattleTarget.unit.level ) { subject = &gBattleTarget; }
	ldr	r3, .L142+12	@ tmp139,
@ SpellSystem.c:184: 	if ( gBattleTarget.levelPrevious != gBattleTarget.unit.level ) { subject = &gBattleTarget; }
	ldrsb	r2, [r3, r2]	@ tmp145,
@ SpellSystem.c:184: 	if ( gBattleTarget.levelPrevious != gBattleTarget.unit.level ) { subject = &gBattleTarget; }
	cmp	r1, r2	@ tmp143, tmp145
	bne	.L138		@,
@ SpellSystem.c:185: 	if ( !subject ) { return 0; } // If this isn't filled, we shouldn't show a popup.
	cmp	r0, #0	@ subject,
	bne	.L134		@,
.L136:
@ SpellSystem.c:185: 	if ( !subject ) { return 0; } // If this isn't filled, we shouldn't show a popup.
	movs	r0, #0	@ <retval>,
.L132:
@ SpellSystem.c:194: }
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L138:
@ SpellSystem.c:184: 	if ( gBattleTarget.levelPrevious != gBattleTarget.unit.level ) { subject = &gBattleTarget; }
	movs	r0, r3	@ subject, tmp139
.L134:
@ SpellSystem.c:187: 	u8* spells = SpellsGetterForLevel(&subject->unit,subject->unit.level,-1);
	movs	r1, #8	@ tmp147,
	movs	r2, #1	@,
	ldrsb	r1, [r0, r1]	@ tmp147,
	rsbs	r2, r2, #0	@,
	bl	SpellsGetterForLevel		@
@ SpellSystem.c:189: 	if ( *spells )
	ldrb	r1, [r0]	@ _12, *spells_23
@ SpellSystem.c:189: 	if ( *spells )
	cmp	r1, #0	@ _12,
	beq	.L136		@,
@ SpellSystem.c:191: 		gPopupItem = *spells|0xFF00;
	ldr	r2, .L142+16	@ tmp151,
@ SpellSystem.c:191: 		gPopupItem = *spells|0xFF00;
	ldr	r3, .L142+20	@ tmp148,
@ SpellSystem.c:191: 		gPopupItem = *spells|0xFF00;
	orrs	r2, r1	@ tmp150, _12
@ SpellSystem.c:192: 		return 1;
	movs	r0, #1	@ <retval>,
@ SpellSystem.c:191: 		gPopupItem = *spells|0xFF00;
	strh	r2, [r3]	@ tmp150, gPopupItem
@ SpellSystem.c:192: 		return 1;
	b	.L132		@
.L143:
	.align	2
.L142:
	.word	gBattleActor+112
	.word	gBattleActor
	.word	gBattleTarget+112
	.word	gBattleTarget
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
	ldr	r3, .L145	@ tmp119,
@ SpellSystem.c:298: }
	@ sp needed	@
@ SpellSystem.c:297: 	return GaidenSpellCostTable[GetItemIndex(spell)];
	bl	.L14		@
@ SpellSystem.c:297: 	return GaidenSpellCostTable[GetItemIndex(spell)];
	ldr	r3, .L145+4	@ tmp123,
	ldrb	r0, [r3, r0]	@ tmp122, GaidenSpellCostTable
@ SpellSystem.c:298: }
	pop	{r4}
	pop	{r1}
	bx	r1
.L146:
	.align	2
.L145:
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
	movs	r3, #1	@ tmp122,
	cmp	r4, r0	@ _2, tmp131
	bgt	.L148		@,
	movs	r3, #0	@ tmp122,
.L148:
@ SpellSystem.c:200: }
	@ sp needed	@
	movs	r0, r3	@, tmp122
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
	ldr	r6, .L161	@ validList,
@ UnitMenu.c:21: 		if ( !CanCastSpellNow(gActiveUnit,spellList[i]|0xFF00) ) { continue; }
	movs	r7, #255	@ tmp143,
@ UnitMenu.c:17: {
	movs	r5, r0	@ ivtmp.276, tmp144
	movs	r4, r6	@ validList, validList
@ UnitMenu.c:21: 		if ( !CanCastSpellNow(gActiveUnit,spellList[i]|0xFF00) ) { continue; }
	lsls	r7, r7, #8	@ tmp143, tmp143,
.L150:
@ UnitMenu.c:19: 	for ( int i = 0 ; spellList[i] ; i++ )
	ldrb	r1, [r5]	@ _9, MEM[(u8 *)_45]
@ UnitMenu.c:19: 	for ( int i = 0 ; spellList[i] ; i++ )
	cmp	r1, #0	@ _9,
	bne	.L152		@,
@ UnitMenu.c:25: 	*validList = 0;
	strb	r1, [r6]	@ _9, *validList_15
@ UnitMenu.c:28: 	if ( !*validList ) { return 3; } // Return unusable if there are no valid spells.
	ldrb	r3, [r4]	@ MEM[(u8 *)&gGenericBuffer], MEM[(u8 *)&gGenericBuffer]
@ UnitMenu.c:28: 	if ( !*validList ) { return 3; } // Return unusable if there are no valid spells.
	movs	r0, #3	@ <retval>,
@ UnitMenu.c:28: 	if ( !*validList ) { return 3; } // Return unusable if there are no valid spells.
	cmp	r3, #0	@ MEM[(u8 *)&gGenericBuffer],
	beq	.L149		@,
.L154:
@ UnitMenu.c:29: 	for ( int i = 0 ; validList[i] ; i++ )
	ldrb	r1, [r4]	@ _30, MEM[(u8 *)_2]
@ UnitMenu.c:29: 	for ( int i = 0 ; validList[i] ; i++ )
	cmp	r1, #0	@ _30,
	bne	.L155		@,
@ UnitMenu.c:34: 	return 2; // There were valid spells, but we don't have enough HP to cast any of them. Return greyed out.
	movs	r0, #2	@ <retval>,
.L149:
@ UnitMenu.c:35: }
	@ sp needed	@
	pop	{r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L152:
@ UnitMenu.c:21: 		if ( !CanCastSpellNow(gActiveUnit,spellList[i]|0xFF00) ) { continue; }
	ldr	r3, .L161+4	@ tmp134,
	orrs	r1, r7	@ tmp132, tmp143
	ldr	r0, [r3]	@, gActiveUnit
	bl	CanCastSpellNow		@
@ UnitMenu.c:21: 		if ( !CanCastSpellNow(gActiveUnit,spellList[i]|0xFF00) ) { continue; }
	cmp	r0, #0	@ tmp145,
	beq	.L151		@,
@ UnitMenu.c:22: 		*validList = spellList[i];
	ldrb	r3, [r5]	@ _6, MEM[(u8 *)_45]
@ UnitMenu.c:22: 		*validList = spellList[i];
	strb	r3, [r6]	@ _6, *validList_15
@ UnitMenu.c:23: 		validList++;
	adds	r6, r6, #1	@ validList,
.L151:
	adds	r5, r5, #1	@ ivtmp.276,
	b	.L150		@
.L155:
@ UnitMenu.c:32: 		if ( HasSufficientHP(gActiveUnit,validList[i]) ) { return 1; } // We've found a spell we can cast! Return usable.
	ldr	r3, .L161+4	@ tmp140,
	ldr	r0, [r3]	@, gActiveUnit
	bl	HasSufficientHP		@
@ UnitMenu.c:32: 		if ( HasSufficientHP(gActiveUnit,validList[i]) ) { return 1; } // We've found a spell we can cast! Return usable.
	adds	r4, r4, #1	@ ivtmp.272,
	cmp	r0, #0	@ tmp146,
	beq	.L154		@,
@ UnitMenu.c:32: 		if ( HasSufficientHP(gActiveUnit,validList[i]) ) { return 1; } // We've found a spell we can cast! Return usable.
	movs	r0, #1	@ <retval>,
	b	.L149		@
.L162:
	.align	2
.L161:
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
	ldr	r3, .L164	@ tmp117,
@ UnitMenu.c:9: }
	@ sp needed	@
@ UnitMenu.c:8: 	return GaidenMagicUMUsabilityExt(SpellsGetter(gActiveUnit,BLACK_MAGIC)); // This is a 0-terminated list of spells this character has learned.
	movs	r1, #1	@,
	ldr	r0, [r3]	@, gActiveUnit
	bl	SpellsGetter		@
@ UnitMenu.c:8: 	return GaidenMagicUMUsabilityExt(SpellsGetter(gActiveUnit,BLACK_MAGIC)); // This is a 0-terminated list of spells this character has learned.
	bl	GaidenMagicUMUsabilityExt		@
@ UnitMenu.c:9: }
	pop	{r4}
	pop	{r1}
	bx	r1
.L165:
	.align	2
.L164:
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
	ldr	r3, .L167	@ tmp117,
@ UnitMenu.c:14: }
	@ sp needed	@
@ UnitMenu.c:13: 	return GaidenMagicUMUsabilityExt(SpellsGetter(gActiveUnit,WHITE_MAGIC));
	movs	r1, #2	@,
	ldr	r0, [r3]	@, gActiveUnit
	bl	SpellsGetter		@
@ UnitMenu.c:13: 	return GaidenMagicUMUsabilityExt(SpellsGetter(gActiveUnit,WHITE_MAGIC));
	bl	GaidenMagicUMUsabilityExt		@
@ UnitMenu.c:14: }
	pop	{r4}
	pop	{r1}
	bx	r1
.L168:
	.align	2
.L167:
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
	movs	r5, r0	@ tmp134, unit
	adds	r5, r5, #72	@ tmp134,
@ SpellSystem.c:162: {
	movs	r4, r1	@ buffer, tmp152
@ SpellSystem.c:163: 	if ( HasSufficientHP(&unit->unit,unit->weapon) )
	ldrh	r1, [r5]	@ tmp135,
	bl	HasSufficientHP		@
@ SpellSystem.c:163: 	if ( HasSufficientHP(&unit->unit,unit->weapon) )
	cmp	r0, #0	@ tmp153,
	beq	.L170		@,
@ SpellSystem.c:165: 		int cost = GetSpellCost(unit->weapon);
	ldrh	r0, [r5]	@ MEM[(short unsigned int *)unit_7(D) + 72B], MEM[(short unsigned int *)unit_7(D) + 72B]
	bl	GetSpellCost		@
@ SpellSystem.c:167: 		buffer->attributes |= BATTLE_HIT_ATTR_HPSTEAL; // "HP drain" bit.
	movs	r3, #128	@ tmp142,
	ldr	r2, [r4]	@ tmp141,* buffer
	lsls	r3, r3, #1	@ tmp142, tmp142,
	orrs	r3, r2	@ tmp140, tmp141
	str	r3, [r4]	@ tmp140,* buffer
@ SpellSystem.c:169: 		buffer->damage -= cost;
	ldrb	r3, [r4, #5]	@ tmp144,
	subs	r3, r3, r0	@ tmp146, tmp144, tmp154
	strb	r3, [r4, #5]	@ tmp146, buffer_10(D)->damage
.L169:
@ SpellSystem.c:176: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L170:
@ SpellSystem.c:174: 		buffer->attributes |= BATTLE_HIT_ATTR_5; // This bit is checked in an external hack I've made.
	movs	r3, #32	@ tmp150,
	ldr	r2, [r4]	@ tmp149,* buffer
	orrs	r3, r2	@ tmp148, tmp149
	str	r3, [r4]	@ tmp148,* buffer
@ SpellSystem.c:176: }
	b	.L169		@
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
	ldr	r3, .L174	@ tmp120,
@ SpellSystem.c:153: {
	movs	r4, r0	@ attacker, tmp121
	movs	r5, r2	@ buffer, tmp122
@ SpellSystem.c:155: 	if ( GetUnitEquippedWeaponSlot(&attacker->unit) == 9 ) // Instead of checking against UsingSpellMenu, we do this to cover the case of defense.
	bl	.L14		@
@ SpellSystem.c:155: 	if ( GetUnitEquippedWeaponSlot(&attacker->unit) == 9 ) // Instead of checking against UsingSpellMenu, we do this to cover the case of defense.
	cmp	r0, #9	@ tmp123,
	bne	.L172		@,
@ SpellSystem.c:157: 		SetRoundForSpell(attacker,buffer);
	movs	r1, r5	@, buffer
	movs	r0, r4	@, attacker
	bl	SetRoundForSpell		@
.L172:
@ SpellSystem.c:159: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L175:
	.align	2
.L174:
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
	movs	r4, r0	@ ivtmp.297, tmp127
.L177:
@ SpellSystem.c:304: 	for ( int i = 0 ; spells[i] ; i++ )
	ldrb	r0, [r4]	@ _7, MEM[(u8 *)_6]
	movs	r5, r4	@ _6, ivtmp.297
@ SpellSystem.c:304: 	for ( int i = 0 ; spells[i] ; i++ )
	cmp	r0, #0	@ _7,
	beq	.L176		@,
@ SpellSystem.c:306: 		if ( GetItemType(spells[i]) != ITYPE_STAFF ) { spell = spells[i]; break; } // Ensure that the spell we could counter with would be an attack spell.
	ldr	r3, .L182	@ tmp124,
	bl	.L14		@
@ SpellSystem.c:306: 		if ( GetItemType(spells[i]) != ITYPE_STAFF ) { spell = spells[i]; break; } // Ensure that the spell we could counter with would be an attack spell.
	adds	r4, r4, #1	@ ivtmp.297,
	cmp	r0, #4	@ tmp128,
	beq	.L177		@,
@ SpellSystem.c:306: 		if ( GetItemType(spells[i]) != ITYPE_STAFF ) { spell = spells[i]; break; } // Ensure that the spell we could counter with would be an attack spell.
	ldrb	r0, [r5]	@ <retval>, *_6
.L176:
@ SpellSystem.c:309: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L183:
	.align	2
.L182:
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
	movs	r6, r0	@ unit, tmp163
@ SpellSystem.c:269: 	for ( int i = 0 ; i < 5 ; i++ )
	movs	r5, #0	@ i,
.L187:
@ SpellSystem.c:271: 		if ( CanUnitUseWeapon(unit,unit->items[i]) ) { return unit->items[i]; }
	movs	r3, r6	@ tmp136, unit
@ SpellSystem.c:271: 		if ( CanUnitUseWeapon(unit,unit->items[i]) ) { return unit->items[i]; }
	lsls	r2, r5, #1	@ tmp137, i,
@ SpellSystem.c:271: 		if ( CanUnitUseWeapon(unit,unit->items[i]) ) { return unit->items[i]; }
	adds	r3, r3, #30	@ tmp136,
	ldrh	r1, [r3, r2]	@ MEM[(short unsigned int *)_44 + _10 * 1], MEM[(short unsigned int *)_44 + _10 * 1]
	movs	r0, r6	@, unit
	ldr	r3, .L201	@ tmp139,
	bl	.L14		@
	subs	r4, r0, #0	@ <retval>, tmp164,
@ SpellSystem.c:271: 		if ( CanUnitUseWeapon(unit,unit->items[i]) ) { return unit->items[i]; }
	beq	.L185		@,
@ SpellSystem.c:271: 		if ( CanUnitUseWeapon(unit,unit->items[i]) ) { return unit->items[i]; }
	adds	r5, r5, #12	@ tmp140,
	lsls	r5, r5, #1	@ tmp141, tmp140,
	adds	r5, r6, r5	@ tmp142, unit, tmp141
	ldrh	r4, [r5, #6]	@ <retval>, *unit_20(D)
.L186:
@ SpellSystem.c:47: 	if ( gChapterData.currentPhase == ( unit->index & 0xC0 ) )
	ldr	r3, .L201+4	@ tmp144,
@ SpellSystem.c:47: 	if ( gChapterData.currentPhase == ( unit->index & 0xC0 ) )
	movs	r2, #11	@ _3,
@ SpellSystem.c:47: 	if ( gChapterData.currentPhase == ( unit->index & 0xC0 ) )
	ldrb	r1, [r3, #15]	@ tmp145,
@ SpellSystem.c:47: 	if ( gChapterData.currentPhase == ( unit->index & 0xC0 ) )
	movs	r3, #192	@ tmp147,
@ SpellSystem.c:47: 	if ( gChapterData.currentPhase == ( unit->index & 0xC0 ) )
	ldrsb	r2, [r6, r2]	@ _3,* _3
@ SpellSystem.c:47: 	if ( gChapterData.currentPhase == ( unit->index & 0xC0 ) )
	ands	r3, r2	@ tmp146, _3
@ SpellSystem.c:47: 	if ( gChapterData.currentPhase == ( unit->index & 0xC0 ) )
	cmp	r1, r3	@ tmp145, tmp146
	bne	.L188		@,
@ SpellSystem.c:50: 		if ( !UsingSpellMenu ) { return vanillaEquipped; }
	ldr	r3, .L201+8	@ tmp148,
@ SpellSystem.c:50: 		if ( !UsingSpellMenu ) { return vanillaEquipped; }
	ldrb	r3, [r3]	@ UsingSpellMenu, UsingSpellMenu
	cmp	r3, #0	@ UsingSpellMenu,
	beq	.L184		@,
@ SpellSystem.c:54: 			if ( unit->index == gBattleTarget.unit.index && GetItemType(SelectedSpell) == ITYPE_STAFF )
	ldr	r3, .L201+12	@ tmp151,
@ SpellSystem.c:54: 			if ( unit->index == gBattleTarget.unit.index && GetItemType(SelectedSpell) == ITYPE_STAFF )
	ldrb	r3, [r3, #11]	@ tmp152,
@ SpellSystem.c:54: 			if ( unit->index == gBattleTarget.unit.index && GetItemType(SelectedSpell) == ITYPE_STAFF )
	ldr	r5, .L201+16	@ tmp150,
@ SpellSystem.c:54: 			if ( unit->index == gBattleTarget.unit.index && GetItemType(SelectedSpell) == ITYPE_STAFF )
	lsls	r3, r3, #24	@ tmp152, tmp152,
@ SpellSystem.c:54: 			if ( unit->index == gBattleTarget.unit.index && GetItemType(SelectedSpell) == ITYPE_STAFF )
	ldrb	r0, [r5]	@ pretmp_21, SelectedSpell
@ SpellSystem.c:54: 			if ( unit->index == gBattleTarget.unit.index && GetItemType(SelectedSpell) == ITYPE_STAFF )
	asrs	r3, r3, #24	@ tmp152, tmp152,
	cmp	r3, r2	@ tmp152, _3
	beq	.L190		@,
.L192:
@ SpellSystem.c:57: 			} else { return SelectedSpell|0xFF00; }
	movs	r4, #255	@ tmp155,
	ldrb	r3, [r5]	@ SelectedSpell, SelectedSpell
	lsls	r4, r4, #8	@ tmp155, tmp155,
.L200:
@ SpellSystem.c:68: 			return ( spell ? spell|0xFF00 : 0 );
	orrs	r4, r3	@ <retval>, tmp160
	b	.L184		@
.L185:
@ SpellSystem.c:269: 	for ( int i = 0 ; i < 5 ; i++ )
	adds	r5, r5, #1	@ i,
@ SpellSystem.c:269: 	for ( int i = 0 ; i < 5 ; i++ )
	cmp	r5, #5	@ i,
	bne	.L187		@,
	b	.L186		@
.L190:
@ SpellSystem.c:54: 			if ( unit->index == gBattleTarget.unit.index && GetItemType(SelectedSpell) == ITYPE_STAFF )
	ldr	r3, .L201+20	@ tmp156,
	bl	.L14		@
@ SpellSystem.c:54: 			if ( unit->index == gBattleTarget.unit.index && GetItemType(SelectedSpell) == ITYPE_STAFF )
	cmp	r0, #4	@ tmp165,
	bne	.L192		@,
.L184:
@ SpellSystem.c:72: }
	@ sp needed	@
	movs	r0, r4	@, <retval>
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L188:
@ SpellSystem.c:64: 		if ( GetUnitEquippedWeaponSlot(unit) == 9 )
	movs	r0, r6	@, unit
	ldr	r3, .L201+24	@ tmp157,
	bl	.L14		@
@ SpellSystem.c:64: 		if ( GetUnitEquippedWeaponSlot(unit) == 9 )
	cmp	r0, #9	@ tmp166,
	bne	.L184		@,
@ SpellSystem.c:67: 			int spell = GetFirstAttackSpell(unit);
	movs	r0, r6	@, unit
	bl	GetFirstAttackSpell		@
	subs	r4, r0, #0	@ <retval>, tmp167,
@ SpellSystem.c:68: 			return ( spell ? spell|0xFF00 : 0 );
	beq	.L184		@,
@ SpellSystem.c:68: 			return ( spell ? spell|0xFF00 : 0 );
	movs	r3, #255	@ tmp160,
	lsls	r3, r3, #8	@ tmp160, tmp160,
	b	.L200		@
.L202:
	.align	2
.L201:
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
	ldr	r3, .L220	@ tmp145,
@ SpellSystem.c:87: 	if ( UsingSpellMenu && unit->index == gBattleActor.unit.index && CanUnitUseWeapon(unit,SelectedSpell) ) { return 9; }
	ldrb	r3, [r3]	@ UsingSpellMenu, UsingSpellMenu
@ SpellSystem.c:85: {
	movs	r5, r0	@ unit, tmp186
	ldr	r6, .L220+4	@ tmp182,
@ SpellSystem.c:87: 	if ( UsingSpellMenu && unit->index == gBattleActor.unit.index && CanUnitUseWeapon(unit,SelectedSpell) ) { return 9; }
	cmp	r3, #0	@ UsingSpellMenu,
	bne	.L204		@,
.L207:
@ SpellSystem.c:89: 	if ( (gBattleStats.config & (BATTLE_CONFIG_REAL|BATTLE_CONFIG_SIMULATE)) && unit->index == gBattleTarget.unit.index )
	ldr	r7, .L220+8	@ tmp147,
@ SpellSystem.c:89: 	if ( (gBattleStats.config & (BATTLE_CONFIG_REAL|BATTLE_CONFIG_SIMULATE)) && unit->index == gBattleTarget.unit.index )
	ldrh	r2, [r7]	@ gBattleStats, gBattleStats
	movs	r1, r5	@ tmp184, unit
	movs	r3, #3	@ tmp151,
	movs	r4, r2	@ tmp153, gBattleStats
	adds	r1, r1, #30	@ tmp184,
	str	r1, [sp, #4]	@ tmp184, %sfp
	ands	r4, r3	@ tmp153, tmp151
	tst	r2, r3	@ gBattleStats, tmp151
	bne	.L205		@,
.L212:
@ SpellSystem.c:112: 			if ( CanUnitUseWeapon(unit,unit->items[i]) ) { return i; }
	ldr	r2, [sp, #4]	@ tmp184, %sfp
@ SpellSystem.c:112: 			if ( CanUnitUseWeapon(unit,unit->items[i]) ) { return i; }
	lsls	r3, r4, #1	@ tmp178, <retval>,
@ SpellSystem.c:112: 			if ( CanUnitUseWeapon(unit,unit->items[i]) ) { return i; }
	movs	r0, r5	@, unit
	ldrh	r1, [r2, r3]	@ MEM[(short unsigned int *)_56 + _55 * 1], MEM[(short unsigned int *)_56 + _55 * 1]
	bl	.L15		@
@ SpellSystem.c:112: 			if ( CanUnitUseWeapon(unit,unit->items[i]) ) { return i; }
	cmp	r0, #0	@ tmp191,
	bne	.L203		@,
@ SpellSystem.c:110: 		for ( int i = 0 ; i < 5 ; i++ )
	adds	r4, r4, #1	@ <retval>,
@ SpellSystem.c:110: 		for ( int i = 0 ; i < 5 ; i++ )
	cmp	r4, #5	@ <retval>,
	bne	.L212		@,
	b	.L213		@
.L204:
@ SpellSystem.c:87: 	if ( UsingSpellMenu && unit->index == gBattleActor.unit.index && CanUnitUseWeapon(unit,SelectedSpell) ) { return 9; }
	movs	r2, #11	@ tmp156,
@ SpellSystem.c:87: 	if ( UsingSpellMenu && unit->index == gBattleActor.unit.index && CanUnitUseWeapon(unit,SelectedSpell) ) { return 9; }
	ldr	r3, .L220+12	@ tmp155,
@ SpellSystem.c:87: 	if ( UsingSpellMenu && unit->index == gBattleActor.unit.index && CanUnitUseWeapon(unit,SelectedSpell) ) { return 9; }
	ldrb	r3, [r3, #11]	@ tmp157,
	ldrsb	r2, [r0, r2]	@ tmp156,
	lsls	r3, r3, #24	@ tmp157, tmp157,
	asrs	r3, r3, #24	@ tmp157, tmp157,
	cmp	r2, r3	@ tmp156, tmp157
	bne	.L207		@,
@ SpellSystem.c:87: 	if ( UsingSpellMenu && unit->index == gBattleActor.unit.index && CanUnitUseWeapon(unit,SelectedSpell) ) { return 9; }
	ldr	r3, .L220+16	@ tmp158,
	ldrb	r1, [r3]	@ SelectedSpell, SelectedSpell
	bl	.L15		@
@ SpellSystem.c:87: 	if ( UsingSpellMenu && unit->index == gBattleActor.unit.index && CanUnitUseWeapon(unit,SelectedSpell) ) { return 9; }
	cmp	r0, #0	@ tmp187,
	beq	.L207		@,
.L208:
@ SpellSystem.c:101: 					return ( spell ? 9 : i );
	movs	r4, #9	@ <retval>,
	b	.L203		@
.L205:
@ SpellSystem.c:89: 	if ( (gBattleStats.config & (BATTLE_CONFIG_REAL|BATTLE_CONFIG_SIMULATE)) && unit->index == gBattleTarget.unit.index )
	movs	r2, #11	@ tmp162,
@ SpellSystem.c:89: 	if ( (gBattleStats.config & (BATTLE_CONFIG_REAL|BATTLE_CONFIG_SIMULATE)) && unit->index == gBattleTarget.unit.index )
	ldr	r3, .L220+20	@ tmp161,
@ SpellSystem.c:89: 	if ( (gBattleStats.config & (BATTLE_CONFIG_REAL|BATTLE_CONFIG_SIMULATE)) && unit->index == gBattleTarget.unit.index )
	ldrb	r3, [r3, #11]	@ tmp163,
	ldrsb	r2, [r5, r2]	@ tmp162,
	lsls	r3, r3, #24	@ tmp163, tmp163,
	movs	r4, #0	@ <retval>,
	asrs	r3, r3, #24	@ tmp163, tmp163,
	cmp	r2, r3	@ tmp162, tmp163
	bne	.L212		@,
@ SpellSystem.c:91: 		int spell = GetFirstAttackSpell(unit);
	movs	r0, r5	@, unit
	bl	GetFirstAttackSpell		@
	str	r0, [sp]	@ tmp188, %sfp
.L211:
@ SpellSystem.c:96: 			if ( CanUnitUseWeapon(unit,unit->items[i]) )
	ldr	r2, [sp, #4]	@ tmp184, %sfp
@ SpellSystem.c:96: 			if ( CanUnitUseWeapon(unit,unit->items[i]) )
	lsls	r3, r4, #1	@ tmp165, <retval>,
@ SpellSystem.c:96: 			if ( CanUnitUseWeapon(unit,unit->items[i]) )
	movs	r0, r5	@, unit
	ldrh	r1, [r2, r3]	@ MEM[(short unsigned int *)_53 + _52 * 1], MEM[(short unsigned int *)_53 + _52 * 1]
	bl	.L15		@
@ SpellSystem.c:96: 			if ( CanUnitUseWeapon(unit,unit->items[i]) )
	cmp	r0, #0	@ tmp189,
	beq	.L209		@,
@ SpellSystem.c:99: 				if ( !gCan_Attack_Target(unit->items[i],gBattleStats.range,unit) )
	movs	r3, r4	@ tmp170, <retval>
	adds	r3, r3, #12	@ tmp170,
	lsls	r3, r3, #1	@ tmp171, tmp170,
	adds	r3, r5, r3	@ tmp172, unit, tmp171
@ SpellSystem.c:99: 				if ( !gCan_Attack_Target(unit->items[i],gBattleStats.range,unit) )
	ldrh	r0, [r3, #6]	@ tmp174, *unit_33(D)
	ldr	r3, .L220+24	@ tmp175,
	movs	r2, r5	@, unit
	ldrb	r1, [r7, #2]	@ tmp169,
	ldr	r3, [r3]	@ gCan_Attack_Target, gCan_Attack_Target
	bl	.L14		@
@ SpellSystem.c:99: 				if ( !gCan_Attack_Target(unit->items[i],gBattleStats.range,unit) )
	cmp	r0, #0	@ tmp190,
	bne	.L203		@,
@ SpellSystem.c:101: 					return ( spell ? 9 : i );
	ldr	r3, [sp]	@ spell, %sfp
	cmp	r3, #0	@ spell,
	bne	.L208		@,
.L203:
@ SpellSystem.c:116: }
	@ sp needed	@
	movs	r0, r4	@, <retval>
	pop	{r1, r2, r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L209:
@ SpellSystem.c:94: 		for ( int i = 0 ; i < 5 ; i++ )
	adds	r4, r4, #1	@ <retval>,
@ SpellSystem.c:94: 		for ( int i = 0 ; i < 5 ; i++ )
	cmp	r4, #5	@ <retval>,
	bne	.L211		@,
@ SpellSystem.c:106: 		return ( spell ? 9 : -1 );
	ldr	r3, [sp]	@ spell, %sfp
	cmp	r3, #0	@ spell,
	bne	.L208		@,
.L213:
@ SpellSystem.c:106: 		return ( spell ? 9 : -1 );
	movs	r4, #1	@ <retval>,
	rsbs	r4, r4, #0	@ <retval>, <retval>
	b	.L203		@
.L221:
	.align	2
.L220:
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
	ldr	r3, .L225	@ tmp124,
@ SpellSystem.c:314: 	if ( UsingSpellMenu )
	ldrb	r3, [r3]	@ UsingSpellMenu, UsingSpellMenu
	cmp	r3, #0	@ UsingSpellMenu,
	beq	.L223		@,
@ SpellSystem.c:316: 		item = SelectedSpell|0xFF00;
	ldr	r3, .L225+4	@ tmp126,
	ldrb	r2, [r3]	@ SelectedSpell, SelectedSpell
@ SpellSystem.c:316: 		item = SelectedSpell|0xFF00;
	movs	r3, #255	@ tmp129,
	lsls	r3, r3, #8	@ tmp129, tmp129,
	orrs	r2, r3	@ item, tmp129
.L224:
@ SpellSystem.c:322: 	gHealStaff_RangeSetup(unit,0,item);
	ldr	r3, .L225+8	@ tmp138,
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
.L223:
@ SpellSystem.c:320: 		item = unit->unit.items[gActionData.itemSlotIndex];
	ldr	r3, .L225+12	@ tmp132,
	ldrb	r3, [r3, #18]	@ tmp133,
@ SpellSystem.c:320: 		item = unit->unit.items[gActionData.itemSlotIndex];
	adds	r3, r3, #12	@ tmp134,
	lsls	r3, r3, #1	@ tmp135, tmp134,
	adds	r3, r0, r3	@ tmp136, unit, tmp135
	ldrh	r2, [r3, #6]	@ item, *unit_11(D)
	b	.L224		@
.L226:
	.align	2
.L225:
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
	movs	r3, #0	@ tmp115,
@ SpellSystem.c:330: }
	@ sp needed	@
@ SpellSystem.c:327: 	UsingSpellMenu = 0;
	ldr	r2, .L228	@ tmp114,
	strb	r3, [r2]	@ tmp115, UsingSpellMenu
@ SpellSystem.c:328: 	SelectedSpell = 0;
	ldr	r2, .L228+4	@ tmp117,
	strb	r3, [r2]	@ tmp115, SelectedSpell
@ SpellSystem.c:329: 	DidSelectSpell = 0;
	ldr	r2, .L228+8	@ tmp120,
	strb	r3, [r2]	@ tmp115, DidSelectSpell
@ SpellSystem.c:330: }
	bx	lr
.L229:
	.align	2
.L228:
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
	ldr	r3, .L245	@ tmp131,
@ RangeDisplay.c:40: {
	str	r1, [sp, #4]	@ tmp140, %sfp
@ RangeDisplay.c:42: 	u8* spells = SpellsGetter(unit,(UsingSpellMenu ? UsingSpellMenu : -1)); // If UsingSpellMenu is nonzero, only get Gaiden spells of that type.
	ldrb	r1, [r3]	@ UsingSpellMenu.67_1, UsingSpellMenu
@ RangeDisplay.c:40: {
	movs	r7, r0	@ unit, tmp139
@ RangeDisplay.c:42: 	u8* spells = SpellsGetter(unit,(UsingSpellMenu ? UsingSpellMenu : -1)); // If UsingSpellMenu is nonzero, only get Gaiden spells of that type.
	cmp	r1, #0	@ UsingSpellMenu.67_1,
	bne	.L231		@,
@ RangeDisplay.c:42: 	u8* spells = SpellsGetter(unit,(UsingSpellMenu ? UsingSpellMenu : -1)); // If UsingSpellMenu is nonzero, only get Gaiden spells of that type.
	subs	r1, r1, #1	@ iftmp.66_17,
.L231:
@ RangeDisplay.c:41: 	long long current = 0;
	movs	r5, #0	@ <retval>,
@ RangeDisplay.c:42: 	u8* spells = SpellsGetter(unit,(UsingSpellMenu ? UsingSpellMenu : -1)); // If UsingSpellMenu is nonzero, only get Gaiden spells of that type.
	movs	r0, r7	@, unit
	bl	SpellsGetter		@
@ RangeDisplay.c:41: 	long long current = 0;
	movs	r4, r5	@ <retval>, <retval>
@ RangeDisplay.c:42: 	u8* spells = SpellsGetter(unit,(UsingSpellMenu ? UsingSpellMenu : -1)); // If UsingSpellMenu is nonzero, only get Gaiden spells of that type.
	str	r0, [sp]	@ tmp141, %sfp
.L232:
@ RangeDisplay.c:43: 	for ( int i = 0 ; spells[i] ; i++ )
	ldr	r3, [sp]	@ ivtmp.343, %sfp
	ldrb	r6, [r3]	@ _13, MEM[(u8 *)_38]
@ RangeDisplay.c:43: 	for ( int i = 0 ; spells[i] ; i++ )
	cmp	r6, #0	@ _13,
	bne	.L237		@,
@ RangeDisplay.c:56: }
	movs	r0, r5	@, <retval>
	movs	r1, r4	@, <retval>
	add	sp, sp, #12	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7}
	pop	{r2}
	bx	r2
.L237:
@ RangeDisplay.c:45: 		int spell = spells[i]|0xFF00;
	movs	r3, #255	@ tmp165,
	lsls	r3, r3, #8	@ tmp165, tmp165,
	orrs	r6, r3	@ spell, tmp165
@ RangeDisplay.c:46: 		if ( usability == NULL )
	ldr	r3, [sp, #4]	@ usability, %sfp
@ RangeDisplay.c:48: 			if ( CanCastSpell(unit,spell) ) { current = IncorporateNewRange(current,gGet_Item_Range(unit,spell)); }
	movs	r1, r6	@, spell
	movs	r0, r7	@, unit
@ RangeDisplay.c:46: 		if ( usability == NULL )
	cmp	r3, #0	@ usability,
	bne	.L233		@,
@ RangeDisplay.c:48: 			if ( CanCastSpell(unit,spell) ) { current = IncorporateNewRange(current,gGet_Item_Range(unit,spell)); }
	bl	CanCastSpell		@
.L244:
@ RangeDisplay.c:52: 			if ( usability(unit,spell) ) { current = IncorporateNewRange(current,gGet_Item_Range(unit,spell)); }
	cmp	r0, #0	@ tmp145,
	beq	.L235		@,
@ RangeDisplay.c:52: 			if ( usability(unit,spell) ) { current = IncorporateNewRange(current,gGet_Item_Range(unit,spell)); }
	ldr	r3, .L245+4	@ tmp135,
	movs	r1, r6	@, spell
	ldr	r3, [r3]	@ gGet_Item_Range, gGet_Item_Range
	movs	r0, r7	@, unit
	bl	.L14		@
	movs	r2, r0	@ _10, tmp160
	movs	r3, r1	@ _10, tmp161
	movs	r0, r5	@, <retval>
	movs	r1, r4	@, <retval>
	bl	IncorporateNewRange		@
	movs	r5, r0	@ <retval>, tmp162
	movs	r4, r1	@ <retval>, tmp163
.L235:
	ldr	r3, [sp]	@ ivtmp.343, %sfp
	adds	r3, r3, #1	@ ivtmp.343,
	str	r3, [sp]	@ ivtmp.343, %sfp
	b	.L232		@
.L233:
@ RangeDisplay.c:52: 			if ( usability(unit,spell) ) { current = IncorporateNewRange(current,gGet_Item_Range(unit,spell)); }
	ldr	r3, [sp, #4]	@ usability, %sfp
	bl	.L14		@
	b	.L244		@
.L246:
	.align	2
.L245:
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
	movs	r3, r1	@ slot, tmp149
@ RangeDisplay.c:9: {
	push	{r4, r5, r6, r7, lr}	@
	sub	sp, sp, #20	@,,
@ RangeDisplay.c:9: {
	movs	r6, r0	@ unit, tmp148
	str	r1, [sp, #4]	@ tmp149, %sfp
	str	r2, [sp, #8]	@ tmp150, %sfp
@ RangeDisplay.c:11: 	if ( slot == -1 || slot == -2 )
	adds	r3, r3, #2	@ tmp176, slot,
	bcc	.L248		@,
@ RangeDisplay.c:10: 	long long current = 0;
	movs	r5, #0	@ <retval>,
	movs	r3, r0	@ _50, unit
	movs	r7, r0	@ ivtmp.353, unit
	movs	r4, r5	@ <retval>, <retval>
	adds	r3, r3, #40	@ _50,
	str	r3, [sp, #12]	@ _50, %sfp
	adds	r7, r7, #30	@ ivtmp.353,
.L249:
@ RangeDisplay.c:14: 		for ( int i = 0 ; i < 5 && unit->items[i] ; i++ )
	ldrh	r1, [r7]	@ _10, MEM[(short unsigned int *)_47]
@ RangeDisplay.c:14: 		for ( int i = 0 ; i < 5 && unit->items[i] ; i++ )
	cmp	r1, #0	@ _10,
	beq	.L251		@,
@ RangeDisplay.c:16: 			if ( usability(unit,unit->items[i]) )
	movs	r0, r6	@, unit
	ldr	r3, [sp, #8]	@ usability, %sfp
	bl	.L14		@
@ RangeDisplay.c:16: 			if ( usability(unit,unit->items[i]) )
	cmp	r0, #0	@ tmp151,
	beq	.L250		@,
@ RangeDisplay.c:18: 				current = IncorporateNewRange(current,gGet_Item_Range(unit,unit->items[i]));
	ldr	r3, .L260	@ tmp138,
	movs	r0, r6	@, unit
	ldr	r3, [r3]	@ gGet_Item_Range, gGet_Item_Range
	ldrh	r1, [r7]	@ MEM[(short unsigned int *)_47], MEM[(short unsigned int *)_47]
	bl	.L14		@
	movs	r2, r0	@ _9, tmp164
	movs	r3, r1	@ _9, tmp165
@ RangeDisplay.c:18: 				current = IncorporateNewRange(current,gGet_Item_Range(unit,unit->items[i]));
	movs	r0, r5	@, <retval>
	movs	r1, r4	@, <retval>
	bl	IncorporateNewRange		@
	movs	r5, r0	@ <retval>, tmp166
	movs	r4, r1	@ <retval>, tmp167
.L250:
@ RangeDisplay.c:14: 		for ( int i = 0 ; i < 5 && unit->items[i] ; i++ )
	ldr	r3, [sp, #12]	@ _50, %sfp
	adds	r7, r7, #2	@ ivtmp.353,
	cmp	r7, r3	@ ivtmp.353, _50
	bne	.L249		@,
.L251:
@ RangeDisplay.c:21: 		return ( slot == -1 ? IncorporateNewRange(current,GetUnitRangeMaskForSpells(unit,usability)) : current );
	ldr	r3, [sp, #4]	@ slot, %sfp
	adds	r3, r3, #1	@ tmp177, slot,
	bne	.L247		@,
@ RangeDisplay.c:21: 		return ( slot == -1 ? IncorporateNewRange(current,GetUnitRangeMaskForSpells(unit,usability)) : current );
	movs	r0, r6	@, unit
	ldr	r1, [sp, #8]	@, %sfp
	bl	GetUnitRangeMaskForSpells		@
	movs	r2, r0	@ _11, tmp168
	movs	r3, r1	@ _11, tmp169
	movs	r0, r5	@, <retval>
	movs	r1, r4	@, <retval>
	bl	IncorporateNewRange		@
.L259:
@ RangeDisplay.c:33: 			return GetUnitRangeMaskForSpells(unit,usability);
	movs	r5, r0	@ <retval>, tmp174
	movs	r4, r1	@ <retval>, tmp175
.L247:
@ RangeDisplay.c:36: }
	movs	r0, r5	@, <retval>
	movs	r1, r4	@, <retval>
	add	sp, sp, #20	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7}
	pop	{r2}
	bx	r2
.L248:
@ RangeDisplay.c:26: 		if ( slot != 9 )
	ldr	r3, [sp, #4]	@ slot, %sfp
	cmp	r3, #9	@ slot,
	beq	.L254		@,
@ RangeDisplay.c:28: 			return gGet_Item_Range(unit,unit->items[slot]);
	adds	r3, r3, #12	@ slot,
	lsls	r3, r3, #1	@ tmp141, tmp140,
	adds	r3, r0, r3	@ tmp142, unit, tmp141
@ RangeDisplay.c:28: 			return gGet_Item_Range(unit,unit->items[slot]);
	ldrh	r1, [r3, #6]	@ tmp144, *unit_26(D)
	ldr	r3, .L260	@ tmp145,
	ldr	r3, [r3]	@ gGet_Item_Range, gGet_Item_Range
	bl	.L14		@
	b	.L259		@
.L254:
@ RangeDisplay.c:33: 			return GetUnitRangeMaskForSpells(unit,usability);
	ldr	r1, [sp, #8]	@, %sfp
	bl	GetUnitRangeMaskForSpells		@
	b	.L259		@
.L261:
	.align	2
.L260:
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
	movs	r4, r0	@ unit, tmp126
@ RangeDisplay.c:82: 	asm("push { r7 }");
	.syntax divided
@ 82 "RangeDisplay.c" 1
	push { r7 }
@ 0 "" 2
@ RangeDisplay.c:33: 			return GetUnitRangeMaskForSpells(unit,usability);
	.thumb
	.syntax unified
	bl	GetUnitRangeMaskForSpells		@
	movs	r2, r0	@ _13, tmp131
	movs	r3, r1	@ _13, tmp132
@ RangeDisplay.c:84: 	asm("mov r7, #0x00\nmov r12, r7"); // Write_Range takes this parameter through r12?
	.syntax divided
@ 84 "RangeDisplay.c" 1
	mov r7, #0x00
mov r12, r7
@ 0 "" 2
@ RangeDisplay.c:85: 	gWrite_Range(unit->xPos,unit->yPos,mask);
	.thumb
	.syntax unified
	movs	r1, #17	@ tmp122,
	movs	r0, #16	@ tmp123,
	ldrsb	r1, [r4, r1]	@ tmp122,
	ldrsb	r0, [r4, r0]	@ tmp123,
	ldr	r4, .L263	@ tmp124,
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
.L264:
	.align	2
.L263:
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
	movs	r5, #1	@ tmp123,
	ldr	r3, .L269	@ tmp122,
	strb	r5, [r3]	@ tmp123, UsingSpellMenu
@ UnitMenu.c:74: 	BmMapFill(gMapMovement,-1);
	ldr	r3, .L269+4	@ tmp125,
	ldr	r4, .L269+8	@ tmp126,
	ldr	r0, [r3]	@, gMapMovement
	movs	r1, #255	@,
	bl	.L16		@
@ UnitMenu.c:75: 	BmMapFill(gMapRange,0);
	ldr	r3, .L269+12	@ tmp127,
	movs	r1, #0	@,
	ldr	r0, [r3]	@, gMapRange
	bl	.L16		@
@ UnitMenu.c:76: 	if ( CanUseAttackSpellsNow(gActiveUnit,BLACK_MAGIC) ) // If we can use an attack spell now, display the red range.
	ldr	r4, .L269+16	@ tmp129,
	movs	r1, r5	@, tmp123
	ldr	r0, [r4]	@, gActiveUnit
	bl	CanUseAttackSpellsNow		@
	ldr	r5, .L269+20	@ tmp137,
@ UnitMenu.c:76: 	if ( CanUseAttackSpellsNow(gActiveUnit,BLACK_MAGIC) ) // If we can use an attack spell now, display the red range.
	cmp	r0, #0	@ tmp138,
	beq	.L266		@,
@ UnitMenu.c:78: 		All_Spells_One_Square(gActiveUnit,&RangeUsabilityCheckNotStaff);
	ldr	r0, [r4]	@, gActiveUnit
	ldr	r1, .L269+24	@ tmp130,
	bl	All_Spells_One_Square		@
@ UnitMenu.c:79: 		DisplayMoveRangeGraphics(3);
	movs	r0, #3	@,
.L268:
@ UnitMenu.c:90: }
	@ sp needed	@
@ UnitMenu.c:84: 		DisplayMoveRangeGraphics(5);
	bl	.L271		@
@ UnitMenu.c:90: }
	movs	r0, #0	@,
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L266:
@ UnitMenu.c:83: 		All_Spells_One_Square(gActiveUnit,&RangeUsabilityCheckStaff);
	ldr	r0, [r4]	@, gActiveUnit
	ldr	r1, .L269+28	@ tmp133,
	bl	All_Spells_One_Square		@
@ UnitMenu.c:84: 		DisplayMoveRangeGraphics(5);
	movs	r0, #5	@,
	b	.L268		@
.L270:
	.align	2
.L269:
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
	movs	r5, #2	@ tmp123,
	ldr	r3, .L276	@ tmp122,
	strb	r5, [r3]	@ tmp123, UsingSpellMenu
@ UnitMenu.c:95: 	BmMapFill(gMapMovement,-1);
	ldr	r3, .L276+4	@ tmp125,
	ldr	r4, .L276+8	@ tmp126,
	ldr	r0, [r3]	@, gMapMovement
	movs	r1, #255	@,
	bl	.L16		@
@ UnitMenu.c:96: 	BmMapFill(gMapRange,0);
	ldr	r3, .L276+12	@ tmp127,
	movs	r1, #0	@,
	ldr	r0, [r3]	@, gMapRange
	bl	.L16		@
@ UnitMenu.c:97: 	if ( CanUseAttackSpellsNow(gActiveUnit,WHITE_MAGIC) ) // If we can use an attack spell now, display the red range.
	ldr	r4, .L276+16	@ tmp129,
	movs	r1, r5	@, tmp123
	ldr	r0, [r4]	@, gActiveUnit
	bl	CanUseAttackSpellsNow		@
	ldr	r5, .L276+20	@ tmp137,
@ UnitMenu.c:97: 	if ( CanUseAttackSpellsNow(gActiveUnit,WHITE_MAGIC) ) // If we can use an attack spell now, display the red range.
	cmp	r0, #0	@ tmp138,
	beq	.L273		@,
@ UnitMenu.c:99: 		All_Spells_One_Square(gActiveUnit,&RangeUsabilityCheckNotStaff);
	ldr	r0, [r4]	@, gActiveUnit
	ldr	r1, .L276+24	@ tmp130,
	bl	All_Spells_One_Square		@
@ UnitMenu.c:100: 		DisplayMoveRangeGraphics(3);
	movs	r0, #3	@,
.L275:
@ UnitMenu.c:108: }
	@ sp needed	@
@ UnitMenu.c:105: 		DisplayMoveRangeGraphics(5);
	bl	.L271		@
@ UnitMenu.c:108: }
	movs	r0, #0	@,
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L273:
@ UnitMenu.c:104: 		All_Spells_One_Square(gActiveUnit,&RangeUsabilityCheckStaff);
	ldr	r0, [r4]	@, gActiveUnit
	ldr	r1, .L276+28	@ tmp133,
	bl	All_Spells_One_Square		@
@ UnitMenu.c:105: 		DisplayMoveRangeGraphics(5);
	movs	r0, #5	@,
	b	.L275		@
.L277:
	.align	2
.L276:
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
	ldr	r7, .L286	@ tmp134,
	ldr	r4, .L286+4	@ tmp136,
@ SpellMenu.c:4: {
	movs	r6, r1	@ index, tmp145
@ SpellMenu.c:5: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,index,UsingSpellMenu)];
	ldr	r0, [r4]	@, gActiveUnit
	ldrb	r1, [r7]	@ UsingSpellMenu, UsingSpellMenu
	bl	SpellsGetter		@
@ SpellMenu.c:5: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,index,UsingSpellMenu)];
	movs	r1, r6	@, index
@ SpellMenu.c:5: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,index,UsingSpellMenu)];
	movs	r5, r0	@ _4, tmp146
@ SpellMenu.c:5: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,index,UsingSpellMenu)];
	ldrb	r2, [r7]	@ UsingSpellMenu, UsingSpellMenu
	ldr	r0, [r4]	@, gActiveUnit
	bl	GetNthUsableSpell		@
@ SpellMenu.c:5: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,index,UsingSpellMenu)];
	ldrb	r5, [r5, r0]	@ spell, *_10
@ SpellMenu.c:6: 	if ( !spell ) { return 3; }
	cmp	r5, #0	@ spell,
	bne	.L279		@,
.L281:
@ SpellMenu.c:6: 	if ( !spell ) { return 3; }
	movs	r0, #3	@ <retval>,
.L278:
@ SpellMenu.c:11: }
	@ sp needed	@
	pop	{r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L279:
@ SpellMenu.c:8: 	if ( !CanCastSpellNow(gActiveUnit,spell) ) { return 3; }
	movs	r1, r5	@, spell
	ldr	r0, [r4]	@, gActiveUnit
	bl	CanCastSpellNow		@
@ SpellMenu.c:8: 	if ( !CanCastSpellNow(gActiveUnit,spell) ) { return 3; }
	cmp	r0, #0	@ tmp148,
	beq	.L281		@,
@ SpellMenu.c:10: 	return ( HasSufficientHP(gActiveUnit,spell) ? 1 : 2 );
	movs	r1, r5	@, spell
	ldr	r0, [r4]	@, gActiveUnit
	bl	HasSufficientHP		@
@ SpellMenu.c:10: 	return ( HasSufficientHP(gActiveUnit,spell) ? 1 : 2 );
	rsbs	r3, r0, #0	@ tmp144, tmp149
	adcs	r0, r0, r3	@ tmp143, tmp149, tmp144
	adds	r0, r0, #1	@ <retval>,
	b	.L278		@
.L287:
	.align	2
.L286:
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
	movs	r4, r1	@ menuCommand, tmp166
@ SpellMenu.c:22: }
	@ sp needed	@
@ SpellMenu.c:16: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,menuCommand->commandDefinitionIndex,UsingSpellMenu)];
	ldr	r6, .L289	@ tmp146,
	ldr	r7, .L289+4	@ tmp144,
	ldr	r0, [r6]	@, gActiveUnit
	ldrb	r1, [r7]	@ UsingSpellMenu, UsingSpellMenu
	bl	SpellsGetter		@
@ SpellMenu.c:16: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,menuCommand->commandDefinitionIndex,UsingSpellMenu)];
	movs	r3, r4	@ tmp151, menuCommand
	adds	r3, r3, #60	@ tmp151,
@ SpellMenu.c:16: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,menuCommand->commandDefinitionIndex,UsingSpellMenu)];
	ldrb	r2, [r7]	@ UsingSpellMenu, UsingSpellMenu
	ldrb	r1, [r3]	@ tmp152,
@ SpellMenu.c:16: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,menuCommand->commandDefinitionIndex,UsingSpellMenu)];
	movs	r5, r0	@ _4, tmp167
@ SpellMenu.c:16: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,menuCommand->commandDefinitionIndex,UsingSpellMenu)];
	ldr	r0, [r6]	@, gActiveUnit
	bl	GetNthUsableSpell		@
@ SpellMenu.c:16: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,menuCommand->commandDefinitionIndex,UsingSpellMenu)];
	ldrb	r5, [r5, r0]	@ _13, *_12
@ SpellMenu.c:18: 	int canUse = HasSufficientHP(gActiveUnit,spell);
	ldr	r0, [r6]	@, gActiveUnit
	movs	r1, r5	@, _13
	bl	HasSufficientHP		@
	movs	r2, r0	@ canUse, tmp169
@ SpellMenu.c:19: 	DrawItemMenuCommand(&menuCommand->text,spell,canUse,&gBg0MapBuffer[menuCommand->yDrawTile * 32 + menuCommand->xDrawTile]);
	movs	r0, r4	@ menuCommand, menuCommand
@ SpellMenu.c:19: 	DrawItemMenuCommand(&menuCommand->text,spell,canUse,&gBg0MapBuffer[menuCommand->yDrawTile * 32 + menuCommand->xDrawTile]);
	ldrh	r3, [r4, #44]	@ tmp155,
@ SpellMenu.c:19: 	DrawItemMenuCommand(&menuCommand->text,spell,canUse,&gBg0MapBuffer[menuCommand->yDrawTile * 32 + menuCommand->xDrawTile]);
	ldrh	r1, [r4, #42]	@ tmp157,
@ SpellMenu.c:19: 	DrawItemMenuCommand(&menuCommand->text,spell,canUse,&gBg0MapBuffer[menuCommand->yDrawTile * 32 + menuCommand->xDrawTile]);
	lsls	r3, r3, #5	@ tmp156, tmp155,
@ SpellMenu.c:19: 	DrawItemMenuCommand(&menuCommand->text,spell,canUse,&gBg0MapBuffer[menuCommand->yDrawTile * 32 + menuCommand->xDrawTile]);
	adds	r3, r3, r1	@ tmp158, tmp156, tmp157
@ SpellMenu.c:19: 	DrawItemMenuCommand(&menuCommand->text,spell,canUse,&gBg0MapBuffer[menuCommand->yDrawTile * 32 + menuCommand->xDrawTile]);
	ldr	r1, .L289+8	@ tmp161,
	lsls	r3, r3, #1	@ tmp159, tmp158,
	adds	r3, r3, r1	@ tmp160, tmp159, tmp161
	ldr	r4, .L289+12	@ tmp163,
	movs	r1, r5	@, _13
@ SpellMenu.c:19: 	DrawItemMenuCommand(&menuCommand->text,spell,canUse,&gBg0MapBuffer[menuCommand->yDrawTile * 32 + menuCommand->xDrawTile]);
	adds	r0, r0, #52	@ menuCommand,
@ SpellMenu.c:19: 	DrawItemMenuCommand(&menuCommand->text,spell,canUse,&gBg0MapBuffer[menuCommand->yDrawTile * 32 + menuCommand->xDrawTile]);
	bl	.L16		@
@ SpellMenu.c:20: 	EnableBgSyncByMask(1);
	movs	r0, #1	@,
	ldr	r3, .L289+16	@ tmp164,
	bl	.L14		@
@ SpellMenu.c:22: }
	movs	r0, #0	@,
	pop	{r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L290:
	.align	2
.L289:
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
	ldr	r0, .L292	@ tmp120,
	ldr	r3, .L292+4	@ tmp121,
	bl	.L14		@
@ SpellMenu.c:27: 	EnableBgSyncByMask(4);
	movs	r0, #4	@,
	ldr	r3, .L292+8	@ tmp122,
	bl	.L14		@
@ SpellMenu.c:28: 	Text_ResetTileAllocation();
	ldr	r3, .L292+12	@ tmp123,
	bl	.L14		@
@ SpellMenu.c:30: 	StartMenu_AndDoSomethingCommands(&gMenu_UnitMenu,gGameState._unk1C.x - gGameState.cameraRealPos.x,1,16);
	ldr	r3, .L292+16	@ tmp124,
	ldrh	r1, [r3, #28]	@ tmp125,
@ SpellMenu.c:30: 	StartMenu_AndDoSomethingCommands(&gMenu_UnitMenu,gGameState._unk1C.x - gGameState.cameraRealPos.x,1,16);
	ldrh	r3, [r3, #12]	@ tmp127,
@ SpellMenu.c:30: 	StartMenu_AndDoSomethingCommands(&gMenu_UnitMenu,gGameState._unk1C.x - gGameState.cameraRealPos.x,1,16);
	movs	r2, #1	@,
	subs	r1, r1, r3	@ tmp128, tmp125, tmp127
	ldr	r4, .L292+20	@ tmp130,
	movs	r3, #16	@,
	ldr	r0, .L292+24	@ tmp129,
	bl	.L16		@
@ SpellMenu.c:31: 	HideMoveRangeGraphics();
	ldr	r3, .L292+28	@ tmp131,
	bl	.L14		@
@ SpellMenu.c:32: 	SelectedSpell = 0;
	movs	r2, #0	@ tmp133,
	ldr	r3, .L292+32	@ tmp132,
	strb	r2, [r3]	@ tmp133, SelectedSpell
@ SpellMenu.c:33: 	UsingSpellMenu = 0;
	ldr	r3, .L292+36	@ tmp135,
@ SpellMenu.c:35: }
	movs	r0, #59	@,
@ SpellMenu.c:33: 	UsingSpellMenu = 0;
	strb	r2, [r3]	@ tmp133, UsingSpellMenu
@ SpellMenu.c:35: }
	pop	{r4}
	pop	{r1}
	bx	r1
.L293:
	.align	2
.L292:
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
	adds	r1, r1, #61	@ tmp132,
@ SpellMenu.c:39: 	if ( commandProc->availability == 2)
	ldrb	r3, [r1]	@ tmp133,
	cmp	r3, #2	@ tmp133,
	bne	.L295		@,
@ SpellMenu.c:42: 		MenuCallHelpBox(proc,gGaidenMagicSpellMenuErrorText);
	ldr	r3, .L299	@ tmp134,
	ldrh	r1, [r3]	@ gGaidenMagicSpellMenuErrorText, gGaidenMagicSpellMenuErrorText
	ldr	r3, .L299+4	@ tmp136,
	bl	.L14		@
@ SpellMenu.c:43: 		return 0x08;
	movs	r0, #8	@ <retval>,
.L294:
@ SpellMenu.c:63: }
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L295:
@ SpellMenu.c:48: 		gActionData.itemSlotIndex = 0;
	movs	r2, #0	@ tmp138,
	ldr	r3, .L299+8	@ tmp137,
	strb	r2, [r3, #18]	@ tmp138, gActionData.itemSlotIndex
@ SpellMenu.c:49: 		DidSelectSpell = 1;
	ldr	r3, .L299+12	@ tmp140,
	adds	r2, r2, #1	@ tmp141,
	strb	r2, [r3]	@ tmp141, DidSelectSpell
@ SpellMenu.c:50: 		ClearBG0BG1();
	ldr	r3, .L299+16	@ tmp143,
	bl	.L14		@
@ SpellMenu.c:51: 		int type = GetItemType(SelectedSpell);
	ldr	r4, .L299+20	@ tmp144,
	ldr	r3, .L299+24	@ tmp146,
	ldrb	r0, [r4]	@ SelectedSpell, SelectedSpell
	bl	.L14		@
	movs	r1, #255	@ tmp163,
	ldrb	r2, [r4]	@ SelectedSpell, SelectedSpell
	lsls	r1, r1, #8	@ tmp163, tmp163,
	ldr	r3, .L299+28	@ tmp164,
@ SpellMenu.c:54: 			MakeTargetListForWeapon(gActiveUnit,SelectedSpell|0xFF00);
	orrs	r1, r2	@ tmp149, SelectedSpell
@ SpellMenu.c:52: 		if ( type != ITYPE_STAFF )
	cmp	r0, #4	@ tmp167,
	beq	.L297		@,
@ SpellMenu.c:54: 			MakeTargetListForWeapon(gActiveUnit,SelectedSpell|0xFF00);
	ldr	r0, [r3]	@, gActiveUnit
	ldr	r3, .L299+32	@ tmp152,
	bl	.L14		@
@ SpellMenu.c:55: 			StartTargetSelection(&SpellTargetSelection);
	ldr	r0, .L299+36	@ tmp153,
	ldr	r3, .L299+40	@ tmp154,
	bl	.L14		@
.L298:
@ SpellMenu.c:61: 		return 0x27;
	movs	r0, #39	@ <retval>,
	b	.L294		@
.L297:
@ SpellMenu.c:59: 			ItemEffect_Call(gActiveUnit,SelectedSpell|0xFF00);
	ldr	r0, [r3]	@, gActiveUnit
	ldr	r3, .L299+44	@ tmp160,
	bl	.L14		@
	b	.L298		@
.L300:
	.align	2
.L299:
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
	ldr	r6, .L316	@ tmp205,
	ldr	r7, .L316+4	@ tmp207,
@ SpellMenu.c:66: {
	sub	sp, sp, #44	@,,
@ SpellMenu.c:66: {
	movs	r4, r0	@ proc, tmp366
@ SpellMenu.c:67: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,proc->commandIndex,UsingSpellMenu)];
	ldrb	r1, [r6]	@ UsingSpellMenu, UsingSpellMenu
	ldr	r0, [r7]	@, gActiveUnit
	bl	SpellsGetter		@
@ SpellMenu.c:67: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,proc->commandIndex,UsingSpellMenu)];
	adds	r4, r4, #97	@ tmp212,
@ SpellMenu.c:67: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,proc->commandIndex,UsingSpellMenu)];
	ldrb	r1, [r4]	@ tmp213,
@ SpellMenu.c:67: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,proc->commandIndex,UsingSpellMenu)];
	movs	r5, r0	@ _4, tmp367
@ SpellMenu.c:67: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,proc->commandIndex,UsingSpellMenu)];
	ldrb	r2, [r6]	@ UsingSpellMenu, UsingSpellMenu
	ldr	r0, [r7]	@, gActiveUnit
	bl	GetNthUsableSpell		@
@ SpellMenu.c:67: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,proc->commandIndex,UsingSpellMenu)];
	ldrb	r3, [r5, r0]	@ spell, *_12
	str	r3, [sp, #12]	@ spell, %sfp
@ SpellMenu.c:68: 	SelectedSpell = spell;
	ldr	r2, [sp, #12]	@ spell, %sfp
	ldr	r3, .L316+8	@ tmp215,
@ SpellMenu.c:71: 	MenuItemPanelProc* menuItemPanel = (MenuItemPanelProc*)ProcFind(&gProc_MenuItemPanel);
	ldr	r0, .L316+12	@ tmp217,
@ SpellMenu.c:68: 	SelectedSpell = spell;
	strb	r2, [r3]	@ spell, SelectedSpell
@ SpellMenu.c:71: 	MenuItemPanelProc* menuItemPanel = (MenuItemPanelProc*)ProcFind(&gProc_MenuItemPanel);
	ldr	r3, .L316+16	@ tmp218,
	bl	.L14		@
@ SpellMenu.c:72: 	int x = menuItemPanel->x;
	movs	r3, r0	@ tmp221, tmp369
@ SpellMenu.c:71: 	MenuItemPanelProc* menuItemPanel = (MenuItemPanelProc*)ProcFind(&gProc_MenuItemPanel);
	str	r0, [sp, #8]	@ tmp369, %sfp
@ SpellMenu.c:72: 	int x = menuItemPanel->x;
	adds	r3, r3, #48	@ tmp221,
	ldrb	r3, [r3]	@ _14,
	str	r3, [sp, #32]	@ _14, %sfp
@ SpellMenu.c:73: 	int y = menuItemPanel->y;
	movs	r3, r0	@ tmp224, tmp369
	adds	r3, r3, #49	@ tmp224,
@ SpellMenu.c:73: 	int y = menuItemPanel->y;
	ldrb	r3, [r3]	@ y,
	str	r3, [sp, #36]	@ y, %sfp
@ SpellMenu.c:75: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Clear(&menuItemPanel->textHandles[i]); }
	movs	r3, r0	@ _140, tmp369
	adds	r3, r3, #52	@ _140,
@ SpellMenu.c:75: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Clear(&menuItemPanel->textHandles[i]); }
	ldr	r4, .L316+20	@ tmp225,
	movs	r0, r3	@, _140
@ SpellMenu.c:75: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Clear(&menuItemPanel->textHandles[i]); }
	str	r3, [sp, #16]	@ _140, %sfp
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
	movs	r4, #0	@ tmp228,
	movs	r3, #8	@,
	movs	r2, #14	@,
	ldr	r1, [sp, #36]	@, %sfp
	ldr	r0, [sp, #32]	@, %sfp
	str	r4, [sp]	@ tmp228,
	ldr	r5, .L316+24	@ tmp229,
	bl	.L271		@
@ SpellMenu.c:78: 	int spellType = GetItemType(spell);
	ldr	r0, [sp, #12]	@, %sfp
	ldr	r3, .L316+28	@ tmp230,
	bl	.L14		@
	str	r0, [sp, #20]	@ tmp370, %sfp
@ SpellMenu.c:79: 	if ( spellType != ITYPE_STAFF )
	cmp	r0, #4	@ spellType,
	bne	.LCB2126	@
	b	.L302	@long jump	@
.LCB2126:
@ SpellMenu.c:81: 		BattleGenerateUiStats(gActiveUnit,9); // 9 is using a Gaiden spell.
	movs	r1, #9	@,
	ldr	r3, .L316+32	@ tmp232,
	ldr	r0, [r7]	@, gActiveUnit
	bl	.L14		@
@ SpellMenu.c:82: 		Text_InsertString(&menuItemPanel->textHandles[0],0x02,0,GetStringFromIndex(0x4F1)); // Affin.
	ldr	r6, .L316+36	@ tmp234,
	ldr	r0, .L316+40	@,
	bl	.L15		@
@ SpellMenu.c:82: 		Text_InsertString(&menuItemPanel->textHandles[0],0x02,0,GetStringFromIndex(0x4F1)); // Affin.
	ldr	r5, .L316+44	@ tmp235,
	movs	r2, r4	@, tmp228
@ SpellMenu.c:82: 		Text_InsertString(&menuItemPanel->textHandles[0],0x02,0,GetStringFromIndex(0x4F1)); // Affin.
	movs	r3, r0	@ _19, tmp371
@ SpellMenu.c:82: 		Text_InsertString(&menuItemPanel->textHandles[0],0x02,0,GetStringFromIndex(0x4F1)); // Affin.
	movs	r1, #2	@,
	ldr	r0, [sp, #16]	@, %sfp
	bl	.L271		@
@ SpellMenu.c:83: 		Text_InsertString(&menuItemPanel->textHandles[0],0x32,0,GetStringFromIndex(gGaidenMagicHPCostText)); // HP Cost.
	ldr	r3, .L316+48	@ tmp236,
	ldrh	r0, [r3]	@ gGaidenMagicHPCostText, gGaidenMagicHPCostText
	bl	.L15		@
@ SpellMenu.c:83: 		Text_InsertString(&menuItemPanel->textHandles[0],0x32,0,GetStringFromIndex(gGaidenMagicHPCostText)); // HP Cost.
	movs	r2, r4	@, tmp228
@ SpellMenu.c:83: 		Text_InsertString(&menuItemPanel->textHandles[0],0x32,0,GetStringFromIndex(gGaidenMagicHPCostText)); // HP Cost.
	movs	r3, r0	@ _22, tmp372
@ SpellMenu.c:83: 		Text_InsertString(&menuItemPanel->textHandles[0],0x32,0,GetStringFromIndex(gGaidenMagicHPCostText)); // HP Cost.
	movs	r1, #50	@,
	ldr	r0, [sp, #16]	@, %sfp
	bl	.L271		@
@ SpellMenu.c:84: 		Text_InsertString(&menuItemPanel->textHandles[1],0x02,0,GetStringFromIndex(0x4F3)); // Atk.
	ldr	r0, .L316+52	@,
	bl	.L15		@
@ SpellMenu.c:84: 		Text_InsertString(&menuItemPanel->textHandles[1],0x02,0,GetStringFromIndex(0x4F3)); // Atk.
	movs	r2, r4	@, tmp228
@ SpellMenu.c:84: 		Text_InsertString(&menuItemPanel->textHandles[1],0x02,0,GetStringFromIndex(0x4F3)); // Atk.
	movs	r3, r0	@ _24, tmp373
@ SpellMenu.c:84: 		Text_InsertString(&menuItemPanel->textHandles[1],0x02,0,GetStringFromIndex(0x4F3)); // Atk.
	movs	r1, #2	@,
	ldr	r0, [sp, #24]	@, %sfp
	bl	.L271		@
@ SpellMenu.c:85: 		Text_InsertString(&menuItemPanel->textHandles[2],0x02,0,GetStringFromIndex(0x4F4)); // Hit.
	ldr	r0, .L316+56	@,
	bl	.L15		@
@ SpellMenu.c:85: 		Text_InsertString(&menuItemPanel->textHandles[2],0x02,0,GetStringFromIndex(0x4F4)); // Hit.
	movs	r2, r4	@, tmp228
@ SpellMenu.c:85: 		Text_InsertString(&menuItemPanel->textHandles[2],0x02,0,GetStringFromIndex(0x4F4)); // Hit.
	movs	r3, r0	@ _26, tmp374
@ SpellMenu.c:85: 		Text_InsertString(&menuItemPanel->textHandles[2],0x02,0,GetStringFromIndex(0x4F4)); // Hit.
	movs	r1, #2	@,
	ldr	r0, [sp, #28]	@, %sfp
	bl	.L271		@
@ SpellMenu.c:86: 		Text_InsertString(&menuItemPanel->textHandles[1],0x32,0,GetStringFromIndex(0x501)); // Crit.
	ldr	r0, .L316+60	@,
	bl	.L15		@
@ SpellMenu.c:86: 		Text_InsertString(&menuItemPanel->textHandles[1],0x32,0,GetStringFromIndex(0x501)); // Crit.
	movs	r2, r4	@, tmp228
@ SpellMenu.c:86: 		Text_InsertString(&menuItemPanel->textHandles[1],0x32,0,GetStringFromIndex(0x501)); // Crit.
	movs	r3, r0	@ _27, tmp375
@ SpellMenu.c:86: 		Text_InsertString(&menuItemPanel->textHandles[1],0x32,0,GetStringFromIndex(0x501)); // Crit.
	movs	r1, #50	@,
	ldr	r0, [sp, #24]	@, %sfp
	bl	.L271		@
@ SpellMenu.c:87: 		Text_InsertString(&menuItemPanel->textHandles[2],0x32,0,GetStringFromIndex(0x4F5)); // Avoid.
	ldr	r0, .L316+64	@,
	bl	.L15		@
@ SpellMenu.c:87: 		Text_InsertString(&menuItemPanel->textHandles[2],0x32,0,GetStringFromIndex(0x4F5)); // Avoid.
	movs	r2, r4	@, tmp228
@ SpellMenu.c:87: 		Text_InsertString(&menuItemPanel->textHandles[2],0x32,0,GetStringFromIndex(0x4F5)); // Avoid.
	movs	r3, r0	@ _28, tmp376
@ SpellMenu.c:87: 		Text_InsertString(&menuItemPanel->textHandles[2],0x32,0,GetStringFromIndex(0x4F5)); // Avoid.
	movs	r1, #50	@,
	ldr	r0, [sp, #28]	@, %sfp
	bl	.L271		@
@ SpellMenu.c:90: 		if ( !HasSufficientHP(gActiveUnit,spell) ) { CostColor = 1; }
	ldr	r1, [sp, #12]	@, %sfp
	ldr	r0, [r7]	@, gActiveUnit
	bl	HasSufficientHP		@
@ SpellMenu.c:89: 		int CostColor = 2;
	subs	r3, r0, #1	@ tmp354, tmp377
	sbcs	r0, r0, r3	@ tmp377, tmp377, tmp354
	movs	r4, r0	@ tmp353, tmp377
@ SpellMenu.c:91: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[0],0x54,CostColor,GetSpellCost(spell));
	ldr	r0, [sp, #12]	@, %sfp
	bl	GetSpellCost		@
@ SpellMenu.c:89: 		int CostColor = 2;
	adds	r4, r4, #1	@ CostColor,
@ SpellMenu.c:91: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[0],0x54,CostColor,GetSpellCost(spell));
	lsls	r3, r0, #24	@ tmp253, tmp378,
	ldr	r5, .L316+68	@ tmp255,
	movs	r2, r4	@, CostColor
	movs	r1, #84	@,
	ldr	r0, [sp, #16]	@, %sfp
	lsrs	r3, r3, #24	@ tmp253, tmp253,
	bl	.L271		@
@ SpellMenu.c:92: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[1],0x24,2,gBattleActor.battleAttack);
	ldr	r3, .L316+72	@ tmp259,
	ldr	r4, .L316+76	@ tmp256,
@ SpellMenu.c:92: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[1],0x24,2,gBattleActor.battleAttack);
	movs	r2, #2	@,
	movs	r1, #36	@,
	ldrb	r3, [r3]	@ tmp263,
	ldr	r0, [sp, #24]	@, %sfp
	bl	.L271		@
@ SpellMenu.c:93: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[2],0x24,2,gBattleActor.battleHitRate);
	movs	r3, r4	@ tmp269, tmp256
	adds	r3, r3, #96	@ tmp269,
@ SpellMenu.c:93: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[2],0x24,2,gBattleActor.battleHitRate);
	movs	r2, #2	@,
	movs	r1, #36	@,
	ldrb	r3, [r3]	@ tmp273,
	ldr	r0, [sp, #28]	@, %sfp
	bl	.L271		@
@ SpellMenu.c:94: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[1],0x54,2,gBattleActor.battleCritRate);
	movs	r3, r4	@ tmp279, tmp256
	adds	r3, r3, #102	@ tmp279,
@ SpellMenu.c:94: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[1],0x54,2,gBattleActor.battleCritRate);
	movs	r2, #2	@,
	movs	r1, #84	@,
	ldrb	r3, [r3]	@ tmp283,
	ldr	r0, [sp, #24]	@, %sfp
@ SpellMenu.c:95: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[2],0x54,2,gBattleActor.battleAvoidRate);
	adds	r4, r4, #98	@ tmp289,
@ SpellMenu.c:94: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[1],0x54,2,gBattleActor.battleCritRate);
	bl	.L271		@
@ SpellMenu.c:95: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[2],0x54,2,gBattleActor.battleAvoidRate);
	movs	r2, #2	@,
	movs	r1, #84	@,
	ldrb	r3, [r4]	@ tmp293,
	ldr	r0, [sp, #28]	@, %sfp
	bl	.L271		@
.L304:
	ldr	r3, [sp, #32]	@ _14, %sfp
	ldr	r6, [sp, #36]	@ y, %sfp
	adds	r5, r3, #1	@ tmp325, _14,
	adds	r6, r6, #1	@ y,
	ldr	r3, [sp, #8]	@ _173, %sfp
	lsls	r6, r6, #5	@ _138, tmp324,
	ldr	r7, .L316+80	@ tmp328,
	adds	r5, r5, r6	@ tmp326, tmp325, _138
	adds	r3, r3, #76	@ _173,
	ldr	r4, [sp, #16]	@ ivtmp.386, %sfp
	lsls	r5, r5, #1	@ tmp327, tmp326,
	str	r3, [sp, #16]	@ _173, %sfp
	adds	r5, r5, r7	@ ivtmp.388, tmp327, tmp328
.L306:
@ SpellMenu.c:115: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Display(&menuItemPanel->textHandles[i],&gBG0MapBuffer[y+1+2*i][x+1]); }
	movs	r1, r5	@, ivtmp.388
	movs	r0, r4	@, ivtmp.386
	ldr	r3, .L316+84	@ tmp329,
	bl	.L14		@
@ SpellMenu.c:115: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Display(&menuItemPanel->textHandles[i],&gBG0MapBuffer[y+1+2*i][x+1]); }
	ldr	r3, [sp, #16]	@ _173, %sfp
	adds	r4, r4, #8	@ ivtmp.386,
	adds	r5, r5, #128	@ ivtmp.388,
	cmp	r4, r3	@ ivtmp.386, _173
	bne	.L306		@,
@ SpellMenu.c:117: 	if ( spellType != ITYPE_STAFF ) { DrawIcon(&gBG0MapBuffer[y+1][x+5],spellType+0x70,menuItemPanel->oam2base<<0xC); } // This HAS to happen after the Text_Display calls.
	ldr	r3, [sp, #20]	@ spellType, %sfp
	cmp	r3, #4	@ spellType,
	beq	.L307		@,
@ SpellMenu.c:117: 	if ( spellType != ITYPE_STAFF ) { DrawIcon(&gBG0MapBuffer[y+1][x+5],spellType+0x70,menuItemPanel->oam2base<<0xC); } // This HAS to happen after the Text_Display calls.
	ldr	r3, [sp, #8]	@ menuItemPanel, %sfp
@ SpellMenu.c:117: 	if ( spellType != ITYPE_STAFF ) { DrawIcon(&gBG0MapBuffer[y+1][x+5],spellType+0x70,menuItemPanel->oam2base<<0xC); } // This HAS to happen after the Text_Display calls.
	ldr	r0, [sp, #32]	@ _14, %sfp
@ SpellMenu.c:117: 	if ( spellType != ITYPE_STAFF ) { DrawIcon(&gBG0MapBuffer[y+1][x+5],spellType+0x70,menuItemPanel->oam2base<<0xC); } // This HAS to happen after the Text_Display calls.
	adds	r3, r3, #50	@ menuItemPanel,
@ SpellMenu.c:117: 	if ( spellType != ITYPE_STAFF ) { DrawIcon(&gBG0MapBuffer[y+1][x+5],spellType+0x70,menuItemPanel->oam2base<<0xC); } // This HAS to happen after the Text_Display calls.
	adds	r0, r0, #5	@ _14,
@ SpellMenu.c:117: 	if ( spellType != ITYPE_STAFF ) { DrawIcon(&gBG0MapBuffer[y+1][x+5],spellType+0x70,menuItemPanel->oam2base<<0xC); } // This HAS to happen after the Text_Display calls.
	ldrb	r2, [r3]	@ tmp333,
@ SpellMenu.c:117: 	if ( spellType != ITYPE_STAFF ) { DrawIcon(&gBG0MapBuffer[y+1][x+5],spellType+0x70,menuItemPanel->oam2base<<0xC); } // This HAS to happen after the Text_Display calls.
	ldr	r1, [sp, #20]	@ tmp335, %sfp
	adds	r0, r0, r6	@ tmp337, tmp336, _138
	lsls	r0, r0, #1	@ tmp338, tmp337,
	ldr	r3, .L316+88	@ tmp341,
	lsls	r2, r2, #12	@ tmp334, tmp333,
	adds	r0, r7, r0	@ tmp339, tmp328, tmp338
	adds	r1, r1, #112	@ tmp335,
	bl	.L14		@
.L307:
@ SpellMenu.c:123: 	gWrite_Range(gActiveUnit->xPos,gActiveUnit->yPos,gGet_Item_Range(gActiveUnit,spell));
	movs	r5, #16	@ _67,
	movs	r6, #17	@ _69,
@ SpellMenu.c:119: 	BmMapFill(gMapMovement,-1);
	ldr	r3, .L316+92	@ tmp342,
	ldr	r4, .L316+96	@ tmp343,
	ldr	r0, [r3]	@, gMapMovement
	movs	r1, #255	@,
	bl	.L16		@
@ SpellMenu.c:120: 	BmMapFill(gMapRange,0);
	ldr	r3, .L316+100	@ tmp344,
	movs	r1, #0	@,
	ldr	r0, [r3]	@, gMapRange
	bl	.L16		@
@ SpellMenu.c:123: 	gWrite_Range(gActiveUnit->xPos,gActiveUnit->yPos,gGet_Item_Range(gActiveUnit,spell));
	ldr	r3, .L316+104	@ tmp346,
	ldr	r4, [r3]	@ gWrite_Range.103_64, gWrite_Range
@ SpellMenu.c:123: 	gWrite_Range(gActiveUnit->xPos,gActiveUnit->yPos,gGet_Item_Range(gActiveUnit,spell));
	ldr	r3, .L316+4	@ tmp347,
	ldr	r0, [r3]	@ gActiveUnit.104_65, gActiveUnit
@ SpellMenu.c:123: 	gWrite_Range(gActiveUnit->xPos,gActiveUnit->yPos,gGet_Item_Range(gActiveUnit,spell));
	ldr	r3, .L316+108	@ tmp348,
	ldr	r1, [sp, #12]	@, %sfp
	ldr	r3, [r3]	@ gGet_Item_Range, gGet_Item_Range
	ldrsb	r5, [r0, r5]	@ _67,* _67
	ldrsb	r6, [r0, r6]	@ _69,* _69
	bl	.L14		@
	movs	r3, r1	@ _71, tmp386
	movs	r2, r0	@ _71, tmp385
@ SpellMenu.c:123: 	gWrite_Range(gActiveUnit->xPos,gActiveUnit->yPos,gGet_Item_Range(gActiveUnit,spell));
	movs	r1, r6	@, _69
	movs	r0, r5	@, _67
	bl	.L16		@
@ SpellMenu.c:124: 	DisplayMoveRangeGraphics(( spellType == ITYPE_STAFF ? 4 : 2 )); // See note in UnitMenu.c.
	ldr	r3, [sp, #20]	@ spellType, %sfp
@ SpellMenu.c:124: 	DisplayMoveRangeGraphics(( spellType == ITYPE_STAFF ? 4 : 2 )); // See note in UnitMenu.c.
	movs	r0, #2	@ iftmp.108_77,
@ SpellMenu.c:124: 	DisplayMoveRangeGraphics(( spellType == ITYPE_STAFF ? 4 : 2 )); // See note in UnitMenu.c.
	cmp	r3, #4	@ spellType,
	bne	.L308		@,
@ SpellMenu.c:124: 	DisplayMoveRangeGraphics(( spellType == ITYPE_STAFF ? 4 : 2 )); // See note in UnitMenu.c.
	movs	r0, r3	@ iftmp.108_77, spellType
.L308:
@ SpellMenu.c:124: 	DisplayMoveRangeGraphics(( spellType == ITYPE_STAFF ? 4 : 2 )); // See note in UnitMenu.c.
	ldr	r3, .L316+112	@ tmp350,
	bl	.L14		@
@ SpellMenu.c:126: }
	movs	r0, #0	@,
	add	sp, sp, #44	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L302:
@ SpellMenu.c:100: 		const char* desc = GetStringFromIndex(GetItemUseDescId(spell));
	ldr	r3, .L316+116	@ tmp296,
	ldr	r0, [sp, #12]	@, %sfp
	bl	.L14		@
@ SpellMenu.c:100: 		const char* desc = GetStringFromIndex(GetItemUseDescId(spell));
	ldr	r3, .L316+36	@ tmp297,
	bl	.L14		@
	ldr	r5, [sp, #16]	@ ivtmp.393, %sfp
@ SpellMenu.c:102: 		desc--;
	subs	r0, r0, #1	@ desc,
.L305:
@ SpellMenu.c:106: 			Text_InsertString(&menuItemPanel->textHandles[j],0,0,desc);
	movs	r2, #0	@,
@ SpellMenu.c:105: 			desc++;
	adds	r4, r0, #1	@ desc, desc,
@ SpellMenu.c:106: 			Text_InsertString(&menuItemPanel->textHandles[j],0,0,desc);
	movs	r3, r4	@, desc
	movs	r0, r5	@, ivtmp.393
	movs	r1, r2	@,
	ldr	r6, .L316+44	@ tmp298,
	bl	.L15		@
@ SpellMenu.c:107: 			desc = Text_GetStringNextLine(desc);
	ldr	r3, .L316+120	@ tmp299,
	movs	r0, r4	@, desc
	bl	.L14		@
@ SpellMenu.c:109: 		} while ( *desc );
	ldrb	r3, [r0]	@ *desc_103, *desc_103
	adds	r5, r5, #8	@ ivtmp.393,
	cmp	r3, #0	@ *desc_103,
	bne	.L305		@,
@ SpellMenu.c:110: 		gBattleActor.battleAttack = gBattleTarget.battleAttack; // ??? this is something vanilla does???
	ldr	r0, .L316+124	@ tmp305,
	ldr	r2, .L316+128	@ tmp302,
@ SpellMenu.c:110: 		gBattleActor.battleAttack = gBattleTarget.battleAttack; // ??? this is something vanilla does???
	ldrh	r0, [r0]	@ tmp309,
	ldr	r1, .L316+72	@ tmp308,
	ldr	r3, .L316+76	@ tmp301,
	strh	r0, [r1]	@ tmp309, gBattleActor.battleAttack
@ SpellMenu.c:112: 		gBattleActor.battleCritRate = gBattleTarget.battleCritRate;
	movs	r0, r2	@ tmp315, tmp302
@ SpellMenu.c:112: 		gBattleActor.battleCritRate = gBattleTarget.battleCritRate;
	movs	r1, r3	@ tmp318, tmp301
@ SpellMenu.c:112: 		gBattleActor.battleCritRate = gBattleTarget.battleCritRate;
	adds	r0, r0, #102	@ tmp315,
@ SpellMenu.c:112: 		gBattleActor.battleCritRate = gBattleTarget.battleCritRate;
	ldrh	r0, [r0]	@ tmp319,
@ SpellMenu.c:111: 		gBattleActor.battleHitRate = gBattleTarget.battleHitRate; // ??? this fixes the green/red arrows from showing on staves???
	ldr	r2, [r2, #96]	@ MEM <unsigned int> [(short int *)&gBattleTarget + 96B], MEM <unsigned int> [(short int *)&gBattleTarget + 96B]
@ SpellMenu.c:112: 		gBattleActor.battleCritRate = gBattleTarget.battleCritRate;
	adds	r1, r1, #102	@ tmp318,
	strh	r0, [r1]	@ tmp319, gBattleActor.battleCritRate
@ SpellMenu.c:111: 		gBattleActor.battleHitRate = gBattleTarget.battleHitRate; // ??? this fixes the green/red arrows from showing on staves???
	str	r2, [r3, #96]	@ MEM <unsigned int> [(short int *)&gBattleTarget + 96B], MEM <unsigned int> [(short int *)&gBattleActor + 96B]
	b	.L304		@
.L317:
	.align	2
.L316:
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
	ldr	r4, .L320	@ tmp117,
@ SpellMenu.c:130: 	if ( !DidSelectSpell ) // Don't hide the squares if we're going to the target selection menu.
	ldrb	r3, [r4]	@ DidSelectSpell, DidSelectSpell
	cmp	r3, #0	@ DidSelectSpell,
	bne	.L319		@,
@ SpellMenu.c:132: 		HideMoveRangeGraphics();
	ldr	r3, .L320+4	@ tmp119,
	bl	.L14		@
.L319:
@ SpellMenu.c:136: }
	@ sp needed	@
@ SpellMenu.c:134: 	DidSelectSpell = 0; // Unset this variable.
	movs	r0, #0	@ tmp121,
	strb	r0, [r4]	@ tmp121, DidSelectSpell
@ SpellMenu.c:136: }
	pop	{r4}
	pop	{r1}
	bx	r1
.L321:
	.align	2
.L320:
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
	movs	r3, r1	@ commandProc, tmp174
	push	{r4, r5, r6, r7, lr}	@
@ SpellMenu.c:142: 	if ( UsingSpellMenu )
	ldr	r2, .L327	@ tmp145,
@ SpellMenu.c:140: 	int xTile = commandProc->xDrawTile * 8;
	ldrh	r4, [r1, #42]	@ tmp143,
@ SpellMenu.c:141: 	int yTile = commandProc->yDrawTile * 8;
	ldrh	r5, [r1, #44]	@ tmp144,
@ SpellMenu.c:142: 	if ( UsingSpellMenu )
	ldrb	r1, [r2]	@ UsingSpellMenu.110_5, UsingSpellMenu
@ SpellMenu.c:139: {
	sub	sp, sp, #20	@,,
	adds	r3, r3, #60	@ commandProc,
@ SpellMenu.c:142: 	if ( UsingSpellMenu )
	str	r2, [sp, #4]	@ tmp145, %sfp
	str	r3, [sp, #8]	@ commandProc, %sfp
	ldr	r7, .L327+4	@ tmp173,
@ SpellMenu.c:140: 	int xTile = commandProc->xDrawTile * 8;
	lsls	r4, r4, #3	@ xTile, tmp143,
@ SpellMenu.c:141: 	int yTile = commandProc->yDrawTile * 8;
	lsls	r5, r5, #3	@ yTile, tmp144,
@ SpellMenu.c:142: 	if ( UsingSpellMenu )
	cmp	r1, #0	@ UsingSpellMenu.110_5,
	beq	.L323		@,
@ SpellMenu.c:145: 		DrawItemRText(xTile,yTile,SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,commandProc->commandDefinitionIndex,UsingSpellMenu)]);
	ldr	r6, .L327+8	@ tmp146,
	ldr	r0, [r6]	@, gActiveUnit
	bl	SpellsGetter		@
@ SpellMenu.c:145: 		DrawItemRText(xTile,yTile,SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,commandProc->commandDefinitionIndex,UsingSpellMenu)]);
	ldr	r3, [sp, #4]	@ tmp145, %sfp
@ SpellMenu.c:145: 		DrawItemRText(xTile,yTile,SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,commandProc->commandDefinitionIndex,UsingSpellMenu)]);
	str	r0, [sp, #12]	@ tmp175, %sfp
@ SpellMenu.c:145: 		DrawItemRText(xTile,yTile,SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,commandProc->commandDefinitionIndex,UsingSpellMenu)]);
	ldrb	r2, [r3]	@ UsingSpellMenu, UsingSpellMenu
	ldr	r3, [sp, #8]	@ tmp172, %sfp
	ldr	r0, [r6]	@, gActiveUnit
	ldrb	r1, [r3]	@ tmp152,
	bl	GetNthUsableSpell		@
@ SpellMenu.c:145: 		DrawItemRText(xTile,yTile,SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,commandProc->commandDefinitionIndex,UsingSpellMenu)]);
	ldr	r3, [sp, #12]	@ _8, %sfp
	ldrb	r2, [r3, r0]	@ *_16, *_16
.L326:
@ SpellMenu.c:156: 			DrawItemRText(xTile,yTile,*((u16*)&gGameState+0x16)); // Probably related to special cases like ballistae?
	movs	r1, r5	@, yTile
	movs	r0, r4	@, xTile
	bl	.L329		@
@ SpellMenu.c:159: }
	add	sp, sp, #20	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L323:
@ SpellMenu.c:150: 		if ( commandProc->commandDefinitionIndex <= 4 )
	ldr	r3, [sp, #8]	@ tmp172, %sfp
	ldrb	r3, [r3]	@ _19,
@ SpellMenu.c:150: 		if ( commandProc->commandDefinitionIndex <= 4 )
	cmp	r3, #4	@ _19,
	bhi	.L325		@,
@ SpellMenu.c:152: 			DrawItemRText(xTile,yTile,gActiveUnit->items[commandProc->commandDefinitionIndex]);
	ldr	r2, .L327+8	@ tmp162,
	adds	r3, r3, #12	@ tmp163,
	ldr	r2, [r2]	@ gActiveUnit, gActiveUnit
	lsls	r3, r3, #1	@ tmp164, tmp163,
	adds	r3, r2, r3	@ tmp165, gActiveUnit, tmp164
@ SpellMenu.c:152: 			DrawItemRText(xTile,yTile,gActiveUnit->items[commandProc->commandDefinitionIndex]);
	ldrh	r2, [r3, #6]	@ tmp167, *gActiveUnit.115_20
	b	.L326		@
.L325:
@ SpellMenu.c:156: 			DrawItemRText(xTile,yTile,*((u16*)&gGameState+0x16)); // Probably related to special cases like ballistae?
	ldr	r3, .L327+12	@ tmp169,
@ SpellMenu.c:156: 			DrawItemRText(xTile,yTile,*((u16*)&gGameState+0x16)); // Probably related to special cases like ballistae?
	ldrh	r2, [r3, #44]	@ MEM[(u16 *)&gGameState + 44B], MEM[(u16 *)&gGameState + 44B]
	b	.L326		@
.L328:
	.align	2
.L327:
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
	ldr	r3, .L334	@ tmp116,
	ldrb	r3, [r3]	@ UsingSpellMenu.116_1, UsingSpellMenu
@ SpellMenu.c:165: 	if ( UsingSpellMenu == BLACK_MAGIC ) { GaidenBlackMagicUMEffect(NULL,NULL); }
	movs	r0, r1	@,
@ SpellMenu.c:165: 	if ( UsingSpellMenu == BLACK_MAGIC ) { GaidenBlackMagicUMEffect(NULL,NULL); }
	cmp	r3, #1	@ UsingSpellMenu.116_1,
	bne	.L331		@,
@ SpellMenu.c:165: 	if ( UsingSpellMenu == BLACK_MAGIC ) { GaidenBlackMagicUMEffect(NULL,NULL); }
	bl	GaidenBlackMagicUMEffect		@
.L332:
@ SpellMenu.c:173: }
	@ sp needed	@
@ SpellMenu.c:172: 	SelectedSpell = 0; // Regardless of use case, ensure that this is 0.
	movs	r2, #0	@ tmp119,
	ldr	r3, .L334+4	@ tmp118,
	strb	r2, [r3]	@ tmp119, SelectedSpell
@ SpellMenu.c:173: }
	pop	{r4}
	pop	{r0}
	bx	r0
.L331:
@ SpellMenu.c:166: 	else if ( UsingSpellMenu == WHITE_MAGIC ) { GaidenWhiteMagicUMEffect(NULL,NULL); }
	cmp	r3, #2	@ UsingSpellMenu.116_1,
	bne	.L333		@,
@ SpellMenu.c:166: 	else if ( UsingSpellMenu == WHITE_MAGIC ) { GaidenWhiteMagicUMEffect(NULL,NULL); }
	bl	GaidenWhiteMagicUMEffect		@
	b	.L332		@
.L333:
@ SpellMenu.c:170: 		AttackUMEffect(NULL,NULL);
	ldr	r3, .L334+8	@ tmp117,
	bl	.L14		@
	b	.L332		@
.L335:
	.align	2
.L334:
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
	str	r1, [sp, #8]	@ tmp183, %sfp
@ StatScreen.c:4: 	u8* spells = SpellsGetter(gpStatScreenUnit,-1);
	movs	r1, #1	@,
@ StatScreen.c:3: {
	movs	r4, r2	@ currHandle, tmp184
@ StatScreen.c:4: 	u8* spells = SpellsGetter(gpStatScreenUnit,-1);
	ldr	r3, .L341	@ tmp145,
@ StatScreen.c:3: {
	str	r0, [sp, #4]	@ tmp182, %sfp
@ StatScreen.c:4: 	u8* spells = SpellsGetter(gpStatScreenUnit,-1);
	rsbs	r1, r1, #0	@,
	ldr	r0, [r3]	@, gpStatScreenUnit
	bl	SpellsGetter		@
@ StatScreen.c:5: 	int tile = (currHandle-1)->tileIndexOffset;
	movs	r3, r4	@ tmp146, currHandle
	movs	r7, r0	@ ivtmp.416, tmp185
	subs	r3, r3, #8	@ tmp146,
@ StatScreen.c:5: 	int tile = (currHandle-1)->tileIndexOffset;
	ldrh	r3, [r3]	@ tile, MEM[(struct TextHandle *)currHandle_27(D) + 4294967288B]
@ StatScreen.c:6: 	int iconX = x;
	ldr	r6, [sp, #4]	@ iconX, %sfp
@ StatScreen.c:5: 	int tile = (currHandle-1)->tileIndexOffset;
	str	r3, [sp]	@ tile, %sfp
.L337:
@ StatScreen.c:8: 	for ( int i = 0 ; spells[i] ; i++ )
	ldrb	r0, [r7]	@ _15, MEM[(u8 *)_63]
@ StatScreen.c:8: 	for ( int i = 0 ; spells[i] ; i++ )
	cmp	r0, #0	@ _15,
	bne	.L340		@,
@ StatScreen.c:32: }
	movs	r0, r4	@, currHandle
	add	sp, sp, #28	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L340:
@ StatScreen.c:10: 		const ItemData* item = GetItemData(spells[i]);
	ldr	r3, .L341+4	@ tmp147,
	bl	.L14		@
@ StatScreen.c:11: 		DrawIcon(&StatScreenBufferMap[iconY][iconX],item->iconId,0x4000);
	movs	r2, #128	@,
	ldr	r3, [sp, #8]	@ y, %sfp
@ StatScreen.c:10: 		const ItemData* item = GetItemData(spells[i]);
	str	r0, [sp, #12]	@ tmp186, %sfp
	lsls	r3, r3, #5	@ _51, y,
@ StatScreen.c:11: 		DrawIcon(&StatScreenBufferMap[iconY][iconX],item->iconId,0x4000);
	ldrb	r1, [r0, #29]	@ tmp149,
	str	r3, [sp, #16]	@ _51, %sfp
	adds	r0, r6, r3	@ tmp150, iconX, _51
	ldr	r3, .L341+8	@ tmp153,
	lsls	r0, r0, #1	@ tmp151, tmp150,
	lsls	r2, r2, #7	@,,
	adds	r0, r0, r3	@ tmp152, tmp151, tmp153
	str	r3, [sp, #20]	@ tmp153, %sfp
	ldr	r3, .L341+12	@ tmp154,
	bl	.L14		@
@ StatScreen.c:13: 		tile += 6;
	ldr	r3, [sp]	@ tile, %sfp
	adds	r3, r3, #6	@ tile,
@ StatScreen.c:15: 		currHandle->xCursor = 0;
	movs	r5, #0	@ tmp156,
@ StatScreen.c:14: 		currHandle->tileIndexOffset = tile;
	strh	r3, [r4]	@ tile, MEM[(short unsigned int *)currHandle_16]
@ StatScreen.c:13: 		tile += 6;
	str	r3, [sp]	@ tile, %sfp
@ StatScreen.c:17: 		currHandle->tileWidth = 6;
	movs	r3, #6	@ tmp203,
@ StatScreen.c:22: 		Text_Clear(currHandle);
	movs	r0, r4	@, currHandle
@ StatScreen.c:15: 		currHandle->xCursor = 0;
	strb	r5, [r4, #2]	@ tmp156, MEM[(unsigned char *)currHandle_16 + 2B]
@ StatScreen.c:16: 		currHandle->colorId = TEXT_COLOR_NORMAL;
	strb	r5, [r4, #3]	@ tmp156, MEM[(unsigned char *)currHandle_16 + 3B]
@ StatScreen.c:17: 		currHandle->tileWidth = 6;
	strb	r3, [r4, #4]	@ tmp202, MEM[(unsigned char *)currHandle_16 + 4B]
@ StatScreen.c:18: 		currHandle->useDoubleBuffer = 0;
	strb	r5, [r4, #5]	@ tmp156, MEM[(unsigned char *)currHandle_16 + 5B]
@ StatScreen.c:19: 		currHandle->currentBufferId = 0;
	strb	r5, [r4, #6]	@ tmp156, MEM[(unsigned char *)currHandle_16 + 6B]
@ StatScreen.c:20: 		currHandle->unk07 = 0;
	strb	r5, [r4, #7]	@ tmp156, MEM[(unsigned char *)currHandle_16 + 7B]
@ StatScreen.c:22: 		Text_Clear(currHandle);
	ldr	r3, .L341+16	@ tmp168,
	bl	.L14		@
@ StatScreen.c:23: 		Text_SetColorId(currHandle,TEXT_COLOR_NORMAL);
	movs	r1, r5	@, tmp156
	movs	r0, r4	@, currHandle
	ldr	r3, .L341+20	@ tmp169,
	bl	.L14		@
@ StatScreen.c:24: 		Text_InsertString(currHandle,0,TEXT_COLOR_NORMAL,GetStringFromIndex(item->nameTextId));
	ldr	r3, [sp, #12]	@ item, %sfp
	ldrh	r0, [r3]	@ *item_32, *item_32
	ldr	r3, .L341+24	@ tmp171,
	bl	.L14		@
@ StatScreen.c:24: 		Text_InsertString(currHandle,0,TEXT_COLOR_NORMAL,GetStringFromIndex(item->nameTextId));
	movs	r2, r5	@, tmp156
@ StatScreen.c:24: 		Text_InsertString(currHandle,0,TEXT_COLOR_NORMAL,GetStringFromIndex(item->nameTextId));
	movs	r3, r0	@ _10, tmp187
@ StatScreen.c:24: 		Text_InsertString(currHandle,0,TEXT_COLOR_NORMAL,GetStringFromIndex(item->nameTextId));
	movs	r1, r5	@, tmp156
	movs	r0, r4	@, currHandle
	ldr	r5, .L341+28	@ tmp172,
	bl	.L271		@
@ StatScreen.c:25: 		Text_Display(currHandle,&StatScreenBufferMap[iconY][iconX+2]);
	ldr	r3, [sp, #16]	@ _51, %sfp
@ StatScreen.c:25: 		Text_Display(currHandle,&StatScreenBufferMap[iconY][iconX+2]);
	adds	r1, r6, #2	@ tmp173, iconX,
@ StatScreen.c:25: 		Text_Display(currHandle,&StatScreenBufferMap[iconY][iconX+2]);
	adds	r1, r1, r3	@ tmp174, tmp173, _51
	ldr	r3, [sp, #20]	@ tmp153, %sfp
	lsls	r1, r1, #1	@ tmp175, tmp174,
	movs	r0, r4	@, currHandle
	adds	r1, r1, r3	@ tmp176, tmp175, tmp153
	ldr	r3, .L341+32	@ tmp178,
	bl	.L14		@
@ StatScreen.c:28: 		if ( iconX == x ) { iconX += 8; }
	ldr	r3, [sp, #4]	@ x, %sfp
@ StatScreen.c:27: 		currHandle++;
	adds	r4, r4, #8	@ currHandle,
@ StatScreen.c:28: 		if ( iconX == x ) { iconX += 8; }
	cmp	r6, r3	@ iconX, x
	bne	.L338		@,
@ StatScreen.c:28: 		if ( iconX == x ) { iconX += 8; }
	adds	r6, r6, #8	@ iconX,
.L339:
	adds	r7, r7, #1	@ ivtmp.416,
	b	.L337		@
.L338:
@ StatScreen.c:29: 		else { iconX = x; iconY += 2; }
	ldr	r3, [sp, #8]	@ y, %sfp
	adds	r3, r3, #2	@ y,
	str	r3, [sp, #8]	@ y, %sfp
@ StatScreen.c:29: 		else { iconX = x; iconY += 2; }
	ldr	r6, [sp, #4]	@ iconX, %sfp
	b	.L339		@
.L342:
	.align	2
.L341:
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
	movs	r1, #1	@ tmp141,
@ StatScreen.c:35: {
	push	{r4, r5, r6, lr}	@
@ StatScreen.c:35: {
	movs	r4, r0	@ proc, tmp138
@ StatScreen.c:39: }
	@ sp needed	@
@ StatScreen.c:36: 	int index = *(proc->rTextData+0x12);
	ldr	r3, [r0, #44]	@ proc_12(D)->rTextData, proc_12(D)->rTextData
	ldrb	r5, [r3, #18]	@ _2, MEM[(char *)_1 + 18B]
@ StatScreen.c:37: 	proc->type = SpellsGetter(gpStatScreenUnit,-1)[index]; // I think if this is positive, it treats this as an item bubble.
	ldr	r3, .L344	@ tmp127,
	rsbs	r1, r1, #0	@, tmp141
	ldr	r0, [r3]	@, gpStatScreenUnit
	bl	SpellsGetter		@
@ StatScreen.c:37: 	proc->type = SpellsGetter(gpStatScreenUnit,-1)[index]; // I think if this is positive, it treats this as an item bubble.
	movs	r3, r4	@ tmp130, proc
@ StatScreen.c:37: 	proc->type = SpellsGetter(gpStatScreenUnit,-1)[index]; // I think if this is positive, it treats this as an item bubble.
	ldrb	r0, [r0, r5]	@ _7, *_6
@ StatScreen.c:37: 	proc->type = SpellsGetter(gpStatScreenUnit,-1)[index]; // I think if this is positive, it treats this as an item bubble.
	adds	r3, r3, #78	@ tmp130,
	strh	r0, [r3]	@ _7, proc_12(D)->type
@ StatScreen.c:38: 	proc->textID = GetItemData(proc->type)->descTextId;
	ldr	r3, .L344+4	@ tmp132,
	bl	.L14		@
@ StatScreen.c:38: 	proc->textID = GetItemData(proc->type)->descTextId;
	ldrh	r3, [r0, #2]	@ tmp136,
	adds	r4, r4, #76	@ tmp135,
	strh	r3, [r4]	@ tmp136, proc_12(D)->textID
@ StatScreen.c:39: }
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L345:
	.align	2
.L344:
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
	movs	r3, r0	@ tmp141, proc
	adds	r3, r3, #80	@ tmp141,
	ldrh	r3, [r3]	@ _3,
@ StatScreen.c:42: {
	movs	r5, r0	@ proc, tmp162
@ StatScreen.c:44: 	if ( proc->direction == DIRECTION_RIGHT )
	cmp	r3, #16	@ _3,
	bne	.L347		@,
@ StatScreen.c:47: 		while ( index >= 0 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index]) )
	movs	r7, #1	@ tmp161,
	rsbs	r7, r7, #0	@ tmp161, tmp161
.L348:
@ StatScreen.c:47: 		while ( index >= 0 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index]) )
	ldr	r3, .L358	@ tmp143,
	ldr	r6, [r3]	@ gpStatScreenUnit.123_4, gpStatScreenUnit
@ StatScreen.c:47: 		while ( index >= 0 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index]) )
	movs	r1, r7	@, tmp161
	movs	r0, r6	@, gpStatScreenUnit.123_4
	bl	SpellsGetter		@
@ StatScreen.c:47: 		while ( index >= 0 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index]) )
	ldrb	r1, [r0, r4]	@ *_7, *_7
	movs	r0, r6	@, gpStatScreenUnit.123_4
	bl	DoesUnitKnowSpell		@
@ StatScreen.c:47: 		while ( index >= 0 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index]) )
	cmp	r0, #0	@ tmp164,
	bne	.L346		@,
@ StatScreen.c:49: 			RTextUp(proc);
	movs	r0, r5	@, proc
	ldr	r3, .L358+4	@ tmp142,
	bl	.L14		@
@ StatScreen.c:47: 		while ( index >= 0 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index]) )
	subs	r4, r4, #2	@ index, index,
	bpl	.L348		@,
.L346:
@ StatScreen.c:63: }
	@ sp needed	@
	pop	{r3, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L347:
@ StatScreen.c:53: 	else if ( proc->direction == DIRECTION_DOWN )
	cmp	r3, #128	@ _3,
	bne	.L346		@,
@ StatScreen.c:56: 		if ( !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index]) )
	movs	r1, #1	@,
@ StatScreen.c:56: 		if ( !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index]) )
	ldr	r7, .L358	@ tmp146,
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
	cmp	r0, #0	@ tmp166,
	bne	.L346		@,
@ StatScreen.c:58: 			RTextLeft(proc);
	movs	r0, r5	@, proc
	ldr	r6, .L358+8	@ tmp149,
	bl	.L15		@
@ StatScreen.c:60: 			if ( index % 2 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index-1]) ) { RTextLeft(proc); }
	lsls	r3, r4, #31	@ tmp172, _2,
	bpl	.L346		@,
@ StatScreen.c:60: 			if ( index % 2 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index-1]) ) { RTextLeft(proc); }
	movs	r1, #1	@,
@ StatScreen.c:60: 			if ( index % 2 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index-1]) ) { RTextLeft(proc); }
	ldr	r7, [r7]	@ gpStatScreenUnit.130_16, gpStatScreenUnit
@ StatScreen.c:60: 			if ( index % 2 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index-1]) ) { RTextLeft(proc); }
	rsbs	r1, r1, #0	@,
	movs	r0, r7	@, gpStatScreenUnit.130_16
	bl	SpellsGetter		@
@ StatScreen.c:60: 			if ( index % 2 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index-1]) ) { RTextLeft(proc); }
	adds	r0, r0, r4	@ tmp157, tmp167, _2
	subs	r0, r0, #1	@ tmp158,
	ldrb	r1, [r0]	@ *_19, *_19
	movs	r0, r7	@, gpStatScreenUnit.130_16
	bl	DoesUnitKnowSpell		@
@ StatScreen.c:60: 			if ( index % 2 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index-1]) ) { RTextLeft(proc); }
	cmp	r0, #0	@ tmp168,
	bne	.L346		@,
@ StatScreen.c:60: 			if ( index % 2 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index-1]) ) { RTextLeft(proc); }
	movs	r0, r5	@, proc
	bl	.L15		@
@ StatScreen.c:63: }
	b	.L346		@
.L359:
	.align	2
.L358:
	.word	gpStatScreenUnit
	.word	RTextUp
	.word	RTextLeft
	.size	GaidenRTextLooper, .-GaidenRTextLooper
	.ident	"GCC: (devkitARM release 61) 13.1.0"
	.code 16
	.align	1
.L14:
	bx	r3
.L16:
	bx	r4
.L271:
	bx	r5
.L15:
	bx	r6
.L329:
	bx	r7
