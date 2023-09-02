	.cpu arm7tdmi
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
@ GNU C17 (devkitARM release 56) version 11.1.0 (arm-none-eabi)
@	compiled by GNU C version 10.3.0, GMP version 6.2.1, MPFR version 4.1.0, MPC version 1.2.1, isl version isl-0.18-GMP

@ GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
@ options passed: -mcpu=arm7tdmi -mthumb -mthumb-interwork -mtune=arm7tdmi -mlong-calls -march=armv4t -Os
	.text
	.align	1
	.arch armv4t
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
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
	.fpu softvfp
	.type	GaidenMagicUMEffectExt, %function
GaidenMagicUMEffectExt:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r0, r1, r4, r5, r6, lr}	@
@ UnitMenu.c:86: {
	movs	r4, r0	@ spellsList, tmp145
	subs	r0, r1, #0	@ proc, tmp146,
@ UnitMenu.c:87: 	if ( proc && commandProc->availability == 2 )
	beq	.L7		@,
@ UnitMenu.c:87: 	if ( proc && commandProc->availability == 2 )
	adds	r2, r2, #61	@ tmp126,
@ UnitMenu.c:87: 	if ( proc && commandProc->availability == 2 )
	ldrb	r3, [r2]	@ tmp127,
	cmp	r3, #2	@ tmp127,
	bne	.L7		@,
@ UnitMenu.c:90: 		MenuCallHelpBox(proc,gGaidenMagicUMErrorText);
	ldr	r3, .L12	@ tmp128,
	ldrh	r1, [r3]	@ gGaidenMagicUMErrorText, gGaidenMagicUMErrorText
	ldr	r3, .L12+4	@ tmp130,
	bl	.L14		@
@ UnitMenu.c:91: 		return 0x08;
	movs	r0, #8	@ <retval>,
.L6:
@ UnitMenu.c:105: }
	@ sp needed	@
	pop	{r1, r2, r4, r5, r6}
	pop	{r1}
	bx	r1
.L7:
@ UnitMenu.c:95: 		_ResetIconGraphics();
	ldr	r3, .L12+8	@ tmp131,
	bl	.L14		@
@ UnitMenu.c:96: 		SelectedSpell = spellsList[0];
	ldrb	r2, [r4]	@ _3, *spellsList_14(D)
@ UnitMenu.c:96: 		SelectedSpell = spellsList[0];
	ldr	r3, .L12+12	@ tmp132,
@ UnitMenu.c:97: 		LoadIconPalettes(4);
	movs	r0, #4	@,
@ UnitMenu.c:96: 		SelectedSpell = spellsList[0];
	strb	r2, [r3]	@ _3, SelectedSpell
@ UnitMenu.c:97: 		LoadIconPalettes(4);
	ldr	r3, .L12+16	@ tmp134,
	bl	.L14		@
@ UnitMenu.c:98: 		MenuProc* menu = StartMenu(&SpellSelectMenuDefs);
	ldr	r3, .L12+20	@ tmp136,
	ldr	r0, .L12+24	@ tmp135,
	bl	.L14		@
@ UnitMenu.c:100: 		StartFace(0,GetUnitPortraitId(gActiveUnit),0xB0,0xC,2);
	ldr	r5, .L12+28	@ tmp137,
@ UnitMenu.c:98: 		MenuProc* menu = StartMenu(&SpellSelectMenuDefs);
	movs	r4, r0	@ menu, tmp148
@ UnitMenu.c:100: 		StartFace(0,GetUnitPortraitId(gActiveUnit),0xB0,0xC,2);
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
@ UnitMenu.c:101: 		SetFaceBlinkControlById(0,5);
	movs	r1, #5	@,
	movs	r0, #0	@,
	ldr	r3, .L12+40	@ tmp141,
	bl	.L14		@
@ UnitMenu.c:102: 		ForceMenuItemPanel(menu,gActiveUnit,15,11);
	movs	r0, r4	@, menu
	movs	r3, #11	@,
	movs	r2, #15	@,
	ldr	r1, [r5]	@, gActiveUnit
	ldr	r4, .L12+44	@ tmp143,
	bl	.L16		@
@ UnitMenu.c:103: 		return 0x17;
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
	.fpu softvfp
	.type	GaidenMagicUMUnhover, %function
GaidenMagicUMUnhover:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ UnitMenu.c:148: 	if ( !SelectedSpell ) { UsingSpellMenu = 0; } // Don't unset this if we're going to the spell menu.
	ldr	r3, .L19	@ tmp116,
@ UnitMenu.c:148: 	if ( !SelectedSpell ) { UsingSpellMenu = 0; } // Don't unset this if we're going to the spell menu.
	ldrb	r3, [r3]	@ SelectedSpell, SelectedSpell
	cmp	r3, #0	@ SelectedSpell,
	bne	.L18		@,
@ UnitMenu.c:148: 	if ( !SelectedSpell ) { UsingSpellMenu = 0; } // Don't unset this if we're going to the spell menu.
	ldr	r2, .L19+4	@ tmp118,
	strb	r3, [r2]	@ SelectedSpell, UsingSpellMenu
.L18:
@ UnitMenu.c:151: }
	@ sp needed	@
@ UnitMenu.c:149: 	HideMoveRangeGraphics();
	ldr	r3, .L19+8	@ tmp121,
	bl	.L14		@
@ UnitMenu.c:151: }
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
	.fpu softvfp
	.type	CanCastSpellNow, %function
CanCastSpellNow:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ SpellSystem.c:456: 		if ( !CanUnitUseWeaponNow(gActiveUnit,spell) ) { return 0; }
	ldr	r5, .L26	@ tmp120,
	ldr	r3, .L26+4	@ tmp121,
	ldr	r0, [r5]	@, gActiveUnit
@ SpellSystem.c:451: {
	movs	r4, r1	@ spell, tmp129
@ SpellSystem.c:456: 		if ( !CanUnitUseWeaponNow(gActiveUnit,spell) ) { return 0; }
	bl	.L14		@
@ SpellSystem.c:456: 		if ( !CanUnitUseWeaponNow(gActiveUnit,spell) ) { return 0; }
	cmp	r0, #0	@ <retval>,
	beq	.L21		@,
@ SpellSystem.c:458: 		MakeTargetListForWeapon(gActiveUnit,spell);
	movs	r1, r4	@, spell
	ldr	r0, [r5]	@, gActiveUnit
	ldr	r3, .L26+8	@ tmp123,
	bl	.L14		@
@ SpellSystem.c:459: 		return GetTargetListSize() != 0;
	ldr	r3, .L26+12	@ tmp124,
	bl	.L14		@
@ SpellSystem.c:459: 		return GetTargetListSize() != 0;
	subs	r3, r0, #1	@ tmp127, tmp131
	sbcs	r0, r0, r3	@ <retval>, tmp131, tmp127
.L21:
@ SpellSystem.c:465: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L27:
	.align	2
.L26:
	.word	gActiveUnit
	.word	CanUnitUseWeaponNow
	.word	MakeTargetListForWeapon
	.word	GetTargetListSize
	.size	CanCastSpellNow, .-CanCastSpellNow
	.align	1
	.global	CanCastSpell
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	CanCastSpell, %function
CanCastSpell:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ SpellSystem.c:468: {
	movs	r4, r1	@ spell, tmp130
@ SpellSystem.c:469: 	int type = GetItemType(spell);
	movs	r0, r1	@, spell
	ldr	r3, .L33	@ tmp120,
	bl	.L14		@
@ SpellSystem.c:472: 		if ( !CanUnitUseWeapon(gActiveUnit,spell) ) { return 0; }
	ldr	r5, .L33+4	@ tmp121,
	movs	r1, r4	@, spell
	ldr	r0, [r5]	@, gActiveUnit
	ldr	r3, .L33+8	@ tmp122,
	bl	.L14		@
@ SpellSystem.c:472: 		if ( !CanUnitUseWeapon(gActiveUnit,spell) ) { return 0; }
	cmp	r0, #0	@ <retval>,
	beq	.L28		@,
@ SpellSystem.c:458: 		MakeTargetListForWeapon(gActiveUnit,spell);
	movs	r1, r4	@, spell
	ldr	r0, [r5]	@, gActiveUnit
	ldr	r3, .L33+12	@ tmp124,
	bl	.L14		@
@ SpellSystem.c:459: 		return GetTargetListSize() != 0;
	ldr	r3, .L33+16	@ tmp125,
	bl	.L14		@
@ SpellSystem.c:459: 		return GetTargetListSize() != 0;
	subs	r3, r0, #1	@ tmp128, tmp132
	sbcs	r0, r0, r3	@ <retval>, tmp132, tmp128
.L28:
@ SpellSystem.c:481: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L34:
	.align	2
.L33:
	.word	GetItemType
	.word	gActiveUnit
	.word	CanUnitUseWeapon
	.word	MakeTargetListForWeapon
	.word	GetTargetListSize
	.size	CanCastSpell, .-CanCastSpell
	.align	1
	.global	RangeUsabilityCheckStaff
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	RangeUsabilityCheckStaff, %function
RangeUsabilityCheckStaff:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ RangeDisplay.c:72: 	return GetItemType(item) == ITYPE_STAFF && CanCastSpell(unit,item);
	ldr	r3, .L38	@ tmp119,
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
	bne	.L35		@,
@ RangeDisplay.c:72: 	return GetItemType(item) == ITYPE_STAFF && CanCastSpell(unit,item);
	movs	r1, r4	@, item
	movs	r0, r5	@, unit
	bl	CanCastSpell		@
@ RangeDisplay.c:72: 	return GetItemType(item) == ITYPE_STAFF && CanCastSpell(unit,item);
	subs	r3, r0, #1	@ tmp122, tmp127
	sbcs	r0, r0, r3	@ <retval>, tmp127, tmp122
.L35:
@ RangeDisplay.c:73: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L39:
	.align	2
.L38:
	.word	GetItemType
	.size	RangeUsabilityCheckStaff, .-RangeUsabilityCheckStaff
	.align	1
	.global	RangeUsabilityCheckNotStaff
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	RangeUsabilityCheckNotStaff, %function
RangeUsabilityCheckNotStaff:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ RangeDisplay.c:77: 	return GetItemType(item) != ITYPE_STAFF && CanCastSpell(unit,item);
	ldr	r3, .L44	@ tmp119,
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
	beq	.L40		@,
@ RangeDisplay.c:72: 	return GetItemType(item) == ITYPE_STAFF && CanCastSpell(unit,item);
	movs	r1, r4	@, item
	movs	r0, r5	@, unit
	bl	CanCastSpell		@
@ RangeDisplay.c:77: 	return GetItemType(item) != ITYPE_STAFF && CanCastSpell(unit,item);
	subs	r3, r0, #1	@ tmp122, tmp127
	sbcs	r0, r0, r3	@ <retval>, tmp127, tmp122
.L40:
@ RangeDisplay.c:78: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L45:
	.align	2
.L44:
	.word	GetItemType
	.size	RangeUsabilityCheckNotStaff, .-RangeUsabilityCheckNotStaff
	.align	1
	.global	GetSpellType
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	GetSpellType, %function
GetSpellType:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
@ SpellSystem.c:536: 	int wType = GetItemType(spell);
	ldr	r3, .L50	@ tmp117,
@ SpellSystem.c:535: {
	push	{r4, lr}	@
@ SpellSystem.c:536: 	int wType = GetItemType(spell);
	bl	.L14		@
@ SpellSystem.c:537: 	if ( wType == ITYPE_ANIMA || wType == ITYPE_DARK ) { return BLACK_MAGIC; }
	movs	r2, #2	@ tmp118,
	movs	r3, r0	@ tmp127, tmp127
@ SpellSystem.c:537: 	if ( wType == ITYPE_ANIMA || wType == ITYPE_DARK ) { return BLACK_MAGIC; }
	movs	r0, #1	@ <retval>,
@ SpellSystem.c:537: 	if ( wType == ITYPE_ANIMA || wType == ITYPE_DARK ) { return BLACK_MAGIC; }
	bics	r3, r2	@ tmp127, tmp118
	cmp	r3, #5	@ _6,
	beq	.L46		@,
@ SpellSystem.c:538: 	else if ( wType == ITYPE_STAFF || wType == ITYPE_LIGHT) { return WHITE_MAGIC; }
	movs	r0, r2	@ <retval>, tmp118
@ SpellSystem.c:538: 	else if ( wType == ITYPE_STAFF || wType == ITYPE_LIGHT) { return WHITE_MAGIC; }
	cmp	r3, #4	@ _6,
	beq	.L46		@,
@ SpellSystem.c:539: 	else { return -1; }
	subs	r0, r0, #3	@ <retval>,
.L46:
@ SpellSystem.c:540: }
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L51:
	.align	2
.L50:
	.word	GetItemType
	.size	GetSpellType, .-GetSpellType
	.align	1
	.global	SpellsGetterForLevel
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	SpellsGetterForLevel, %function
SpellsGetterForLevel:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r0, r1, r2, r4, r5, r6, r7, lr}	@
@ SpellSystem.c:10: 	int unitLevel = unit->level;
	movs	r6, #8	@ unitLevel,
@ SpellSystem.c:8: {
	str	r2, [sp, #4]	@ tmp160, %sfp
@ SpellSystem.c:11: 	if ( UNIT_ATTRIBUTES(unit) & CA_PROMOTED ) { unitLevel += 80; } // Treat promoted as top bit set.
	ldr	r3, [r0]	@ unit_37(D)->pCharacterData, unit_37(D)->pCharacterData
	ldr	r2, [r0, #4]	@ _4, unit_37(D)->pClassData
@ SpellSystem.c:8: {
	movs	r7, r1	@ level, tmp159
@ SpellSystem.c:11: 	if ( UNIT_ATTRIBUTES(unit) & CA_PROMOTED ) { unitLevel += 80; } // Treat promoted as top bit set.
	ldr	r3, [r3, #40]	@ _2->attributes, _2->attributes
	ldr	r1, [r2, #40]	@ _4->attributes, _4->attributes
	orrs	r3, r1	@ tmp144, _4->attributes
@ SpellSystem.c:10: 	int unitLevel = unit->level;
	ldrsb	r6, [r0, r6]	@ unitLevel,* unitLevel
@ SpellSystem.c:11: 	if ( UNIT_ATTRIBUTES(unit) & CA_PROMOTED ) { unitLevel += 80; } // Treat promoted as top bit set.
	lsls	r3, r3, #23	@ tmp162, tmp144,
	bpl	.L53		@,
@ SpellSystem.c:11: 	if ( UNIT_ATTRIBUTES(unit) & CA_PROMOTED ) { unitLevel += 80; } // Treat promoted as top bit set.
	adds	r6, r6, #80	@ unitLevel,
.L53:
@ SpellSystem.c:14: 	SpellList* ROMList = SpellListTable[unit->pClassData->number];	
	ldrb	r2, [r2, #4]	@ tmp150,
@ SpellSystem.c:14: 	SpellList* ROMList = SpellListTable[unit->pClassData->number];	
	ldr	r3, .L75	@ tmp149,
	lsls	r2, r2, #2	@ tmp151, tmp150,
	ldr	r5, [r2, r3]	@ ROMList, SpellListTable[_10]
	movs	r3, r0	@ ivtmp.227, unit
@ SpellSystem.c:12: 	u8* currBuffer = SpellsBuffer;
	ldr	r4, .L75+4	@ currBuffer,
	adds	r3, r3, #40	@ ivtmp.227,
	adds	r0, r0, #45	@ _55,
.L55:
@ SpellSystem.c:18: 		if (unit->ranks[i] != 0) {
	ldrb	r2, [r3]	@ _11, MEM[(unsigned char *)_54]
@ SpellSystem.c:18: 		if (unit->ranks[i] != 0) {
	cmp	r2, #0	@ _11,
	beq	.L54		@,
@ SpellSystem.c:20: 			*currBuffer = unit->ranks[i];
	strb	r2, [r4]	@ _11, *currBuffer_67
@ SpellSystem.c:21: 			currBuffer++;
	adds	r4, r4, #1	@ currBuffer,
.L54:
@ SpellSystem.c:16: 	for ( int i = 0 ; i < 5 ; i++ )	
	adds	r3, r3, #1	@ ivtmp.227,
	cmp	r0, r3	@ _55, ivtmp.227
	bne	.L55		@,
@ SpellSystem.c:27: 	if ( ROMList )
	cmp	r5, #0	@ ROMList,
	beq	.L56		@,
.L57:
@ SpellSystem.c:30: 		for ( int i = 0 ; ROMList[i].level ; i++ )
	ldrb	r3, [r5]	@ _21, MEM[(unsigned char *)_65]
@ SpellSystem.c:30: 		for ( int i = 0 ; ROMList[i].level ; i++ )
	cmp	r3, #0	@ _21,
	bne	.L63		@,
.L56:
@ SpellSystem.c:46: }
	@ sp needed	@
@ SpellSystem.c:44: 	*currBuffer = 0;
	movs	r3, #0	@ tmp154,
@ SpellSystem.c:46: }
	ldr	r0, .L75+4	@,
@ SpellSystem.c:44: 	*currBuffer = 0;
	strb	r3, [r4]	@ tmp154, *currBuffer_27
@ SpellSystem.c:46: }
	pop	{r1, r2, r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L63:
@ SpellSystem.c:32: 			if ( (level == -1 && unitLevel >= ROMList[i].level) || (level == ROMList[i].level) )
	adds	r2, r7, #1	@ tmp163, level,
	bne	.L58		@,
@ SpellSystem.c:32: 			if ( (level == -1 && unitLevel >= ROMList[i].level) || (level == ROMList[i].level) )
	cmp	r6, r3	@ unitLevel, _21
	bge	.L59		@,
.L60:
	adds	r5, r5, #2	@ ivtmp.218,
	b	.L57		@
.L58:
@ SpellSystem.c:32: 			if ( (level == -1 && unitLevel >= ROMList[i].level) || (level == ROMList[i].level) )
	cmp	r3, r7	@ _21, level
	bne	.L60		@,
.L59:
@ SpellSystem.c:34: 				if ( type == -1 || type == GetSpellType(ROMList[i].spell) )
	ldr	r3, [sp, #4]	@ type, %sfp
@ SpellSystem.c:34: 				if ( type == -1 || type == GetSpellType(ROMList[i].spell) )
	ldrb	r0, [r5, #1]	@ pretmp_28, MEM[(unsigned char *)_65 + 1B]
@ SpellSystem.c:34: 				if ( type == -1 || type == GetSpellType(ROMList[i].spell) )
	adds	r3, r3, #1	@ tmp164, type,
	bne	.L61		@,
.L62:
@ SpellSystem.c:37: 					*currBuffer = ROMList[i].spell;
	ldrb	r3, [r5, #1]	@ _17, MEM[(unsigned char *)_65 + 1B]
@ SpellSystem.c:37: 					*currBuffer = ROMList[i].spell;
	strb	r3, [r4]	@ _17, *currBuffer_26
@ SpellSystem.c:38: 					currBuffer++;
	adds	r4, r4, #1	@ currBuffer,
	b	.L60		@
.L61:
@ SpellSystem.c:34: 				if ( type == -1 || type == GetSpellType(ROMList[i].spell) )
	bl	GetSpellType		@
@ SpellSystem.c:34: 				if ( type == -1 || type == GetSpellType(ROMList[i].spell) )
	ldr	r3, [sp, #4]	@ type, %sfp
	cmp	r0, r3	@ tmp161, type
	bne	.L60		@,
	b	.L62		@
.L76:
	.align	2
.L75:
	.word	SpellListTable
	.word	SpellsBuffer
	.size	SpellsGetterForLevel, .-SpellsGetterForLevel
	.align	1
	.global	SpellsGetter
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
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
	.global	CaptureGaidenBlackMagicUMEffect
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	CaptureGaidenBlackMagicUMEffect, %function
CaptureGaidenBlackMagicUMEffect:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
@ UnitMenu.c:33: 	Unit* unit = gActiveUnit;
	ldr	r3, .L79	@ tmp120,
@ UnitMenu.c:31: {
	push	{r4, r5, r6, lr}	@
@ UnitMenu.c:31: {
	movs	r4, r0	@ proc, tmp128
@ UnitMenu.c:39: }
	@ sp needed	@
@ UnitMenu.c:33: 	Unit* unit = gActiveUnit;
	ldr	r0, [r3]	@ unit, gActiveUnit
@ UnitMenu.c:34: 	unit->state = unit->state | (1<<30); // Capturing bit 
	movs	r3, #128	@ tmp123,
@ UnitMenu.c:31: {
	movs	r5, r1	@ commandProc, tmp129
@ UnitMenu.c:37: 	UsingSpellMenu = BLACK_MAGIC;
	movs	r1, #1	@ tmp125,
@ UnitMenu.c:34: 	unit->state = unit->state | (1<<30); // Capturing bit 
	ldr	r2, [r0, #12]	@ unit_5->state, unit_5->state
	lsls	r3, r3, #23	@ tmp123, tmp123,
	orrs	r3, r2	@ tmp121, unit_5->state
@ UnitMenu.c:34: 	unit->state = unit->state | (1<<30); // Capturing bit 
	str	r3, [r0, #12]	@ tmp121, unit_5->state
@ UnitMenu.c:37: 	UsingSpellMenu = BLACK_MAGIC;
	ldr	r3, .L79+4	@ tmp124,
	strb	r1, [r3]	@ tmp125, UsingSpellMenu
@ UnitMenu.c:38: 	return GaidenMagicUMEffectExt(SpellsGetter(gActiveUnit,BLACK_MAGIC),proc,commandProc);
	bl	SpellsGetter		@
	movs	r2, r5	@, commandProc
	movs	r1, r4	@, proc
	bl	GaidenMagicUMEffectExt		@
@ UnitMenu.c:39: }
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L80:
	.align	2
.L79:
	.word	gActiveUnit
	.word	UsingSpellMenu
	.size	CaptureGaidenBlackMagicUMEffect, .-CaptureGaidenBlackMagicUMEffect
	.align	1
	.global	GaidenBlackMagicUMEffect
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	GaidenBlackMagicUMEffect, %function
GaidenBlackMagicUMEffect:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ UnitMenu.c:70: {
	movs	r5, r1	@ commandProc, tmp124
@ UnitMenu.c:73: }
	@ sp needed	@
@ UnitMenu.c:71: 	UsingSpellMenu = BLACK_MAGIC;
	movs	r1, #1	@ tmp119,
@ UnitMenu.c:70: {
	movs	r4, r0	@ proc, tmp123
@ UnitMenu.c:71: 	UsingSpellMenu = BLACK_MAGIC;
	ldr	r3, .L82	@ tmp118,
	strb	r1, [r3]	@ tmp119, UsingSpellMenu
@ UnitMenu.c:72: 	return GaidenMagicUMEffectExt(SpellsGetter(gActiveUnit,BLACK_MAGIC),proc,commandProc);
	ldr	r3, .L82+4	@ tmp121,
	ldr	r0, [r3]	@, gActiveUnit
	bl	SpellsGetter		@
	movs	r2, r5	@, commandProc
	movs	r1, r4	@, proc
	bl	GaidenMagicUMEffectExt		@
@ UnitMenu.c:73: }
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L83:
	.align	2
.L82:
	.word	UsingSpellMenu
	.word	gActiveUnit
	.size	GaidenBlackMagicUMEffect, .-GaidenBlackMagicUMEffect
	.align	1
	.global	GaidenWhiteMagicUMEffect
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	GaidenWhiteMagicUMEffect, %function
GaidenWhiteMagicUMEffect:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ UnitMenu.c:80: {
	movs	r5, r1	@ commandProc, tmp124
@ UnitMenu.c:83: }
	@ sp needed	@
@ UnitMenu.c:81: 	UsingSpellMenu = WHITE_MAGIC;
	movs	r1, #2	@ tmp119,
@ UnitMenu.c:80: {
	movs	r4, r0	@ proc, tmp123
@ UnitMenu.c:81: 	UsingSpellMenu = WHITE_MAGIC;
	ldr	r3, .L85	@ tmp118,
	strb	r1, [r3]	@ tmp119, UsingSpellMenu
@ UnitMenu.c:82: 	return GaidenMagicUMEffectExt(SpellsGetter(gActiveUnit,WHITE_MAGIC),proc,commandProc);
	ldr	r3, .L85+4	@ tmp121,
	ldr	r0, [r3]	@, gActiveUnit
	bl	SpellsGetter		@
	movs	r2, r5	@, commandProc
	movs	r1, r4	@, proc
	bl	GaidenMagicUMEffectExt		@
@ UnitMenu.c:83: }
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L86:
	.align	2
.L85:
	.word	UsingSpellMenu
	.word	gActiveUnit
	.size	GaidenWhiteMagicUMEffect, .-GaidenWhiteMagicUMEffect
	.align	1
	.global	NewGetUnitUseFlags
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	NewGetUnitUseFlags, %function
NewGetUnitUseFlags:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	movs	r3, r0	@ _72, unit
	push	{r0, r1, r2, r4, r5, r6, r7, lr}	@
	movs	r6, r0	@ ivtmp.252, unit
@ SpellSystem.c:363: {
	movs	r5, r0	@ unit, tmp181
@ SpellSystem.c:364: 	u32 ret = 0;
	movs	r4, #0	@ <retval>,
@ SpellSystem.c:368: 		if ( attributes & IA_WEAPON )
	movs	r7, #1	@ tmp179,
	adds	r3, r3, #40	@ _72,
	str	r3, [sp, #4]	@ _72, %sfp
	adds	r6, r6, #30	@ ivtmp.252,
.L88:
@ SpellSystem.c:365: 	for ( int i = 0 ; i < 5 && unit->items[i] ; i++ )
	ldrh	r0, [r6]	@ _11, MEM[(short unsigned int *)_68]
@ SpellSystem.c:365: 	for ( int i = 0 ; i < 5 && unit->items[i] ; i++ )
	cmp	r0, #0	@ _11,
	beq	.L91		@,
@ SpellSystem.c:367: 		u32 attributes = GetItemAttributes(unit->items[i]);
	ldr	r3, .L115	@ tmp145,
	bl	.L14		@
@ SpellSystem.c:368: 		if ( attributes & IA_WEAPON )
	tst	r0, r7	@ attributes, tmp179
	beq	.L89		@,
@ SpellSystem.c:370: 			if ( CanUnitUseWeaponNow(unit,unit->items[i]) ) { ret |= 1; }
	movs	r0, r5	@, unit
	ldrh	r1, [r6]	@ MEM[(short unsigned int *)_68], MEM[(short unsigned int *)_68]
	ldr	r3, .L115+4	@ tmp149,
	bl	.L14		@
@ SpellSystem.c:370: 			if ( CanUnitUseWeaponNow(unit,unit->items[i]) ) { ret |= 1; }
	cmp	r0, #0	@ tmp183,
	beq	.L90		@,
@ SpellSystem.c:370: 			if ( CanUnitUseWeaponNow(unit,unit->items[i]) ) { ret |= 1; }
	orrs	r4, r7	@ <retval>, tmp179
.L90:
@ SpellSystem.c:365: 	for ( int i = 0 ; i < 5 && unit->items[i] ; i++ )
	ldr	r3, [sp, #4]	@ _72, %sfp
	adds	r6, r6, #2	@ ivtmp.252,
	cmp	r6, r3	@ ivtmp.252, _72
	bne	.L88		@,
.L91:
@ SpellSystem.c:378: 	u8* spells = SpellsGetter(unit,-1);
	movs	r1, #1	@,
	movs	r0, r5	@, unit
	rsbs	r1, r1, #0	@,
	bl	SpellsGetter		@
@ SpellSystem.c:382: 		if ( attributes & IA_WEAPON )
	movs	r7, #1	@ tmp177,
@ SpellSystem.c:378: 	u8* spells = SpellsGetter(unit,-1);
	movs	r6, r0	@ ivtmp.246, tmp185
.L93:
@ SpellSystem.c:379: 	for ( int i = 0 ; spells[i] ; i++ )
	ldrb	r0, [r6]	@ _24, MEM[(u8 *)_60]
@ SpellSystem.c:379: 	for ( int i = 0 ; spells[i] ; i++ )
	cmp	r0, #0	@ _24,
	bne	.L96		@,
@ SpellSystem.c:392: }
	@ sp needed	@
	movs	r0, r4	@, <retval>
	pop	{r1, r2, r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L89:
@ SpellSystem.c:372: 		else if ( attributes & IA_STAFF )
	movs	r3, #4	@ tmp193,
	tst	r0, r3	@ attributes, tmp193
	beq	.L90		@,
@ SpellSystem.c:374: 			if ( CanUnitUseStaffNow(unit,unit->items[i]) ) { ret |= 2; }
	movs	r0, r5	@, unit
	ldrh	r1, [r6]	@ MEM[(short unsigned int *)_68], MEM[(short unsigned int *)_68]
	ldr	r3, .L115+8	@ tmp156,
	bl	.L14		@
@ SpellSystem.c:374: 			if ( CanUnitUseStaffNow(unit,unit->items[i]) ) { ret |= 2; }
	cmp	r0, #0	@ tmp184,
	beq	.L90		@,
@ SpellSystem.c:374: 			if ( CanUnitUseStaffNow(unit,unit->items[i]) ) { ret |= 2; }
	movs	r3, #2	@ tmp159,
	orrs	r4, r3	@ <retval>, tmp159
	b	.L90		@
.L96:
@ SpellSystem.c:381: 		u32 attributes = GetItemAttributes(spells[i]);
	ldr	r3, .L115	@ tmp161,
	bl	.L14		@
@ SpellSystem.c:382: 		if ( attributes & IA_WEAPON )
	tst	r0, r7	@ attributes, tmp177
	beq	.L94		@,
@ SpellSystem.c:384: 			if ( CanUnitUseWeaponNow(unit,spells[i]) ) { ret |= 1; }
	movs	r0, r5	@, unit
	ldrb	r1, [r6]	@ MEM[(u8 *)_60], MEM[(u8 *)_60]
	ldr	r3, .L115+4	@ tmp165,
	bl	.L14		@
@ SpellSystem.c:384: 			if ( CanUnitUseWeaponNow(unit,spells[i]) ) { ret |= 1; }
	cmp	r0, #0	@ tmp187,
	beq	.L95		@,
@ SpellSystem.c:384: 			if ( CanUnitUseWeaponNow(unit,spells[i]) ) { ret |= 1; }
	orrs	r4, r7	@ <retval>, tmp177
.L95:
	adds	r6, r6, #1	@ ivtmp.246,
	b	.L93		@
.L94:
@ SpellSystem.c:386: 		else if ( attributes & IA_STAFF )
	movs	r3, #4	@ tmp195,
	tst	r0, r3	@ attributes, tmp195
	beq	.L95		@,
@ SpellSystem.c:388: 			if ( CanUnitUseStaffNow(unit,spells[i]) ) { ret |= 2; }
	movs	r0, r5	@, unit
	ldrb	r1, [r6]	@ MEM[(u8 *)_60], MEM[(u8 *)_60]
	ldr	r3, .L115+8	@ tmp172,
	bl	.L14		@
@ SpellSystem.c:388: 			if ( CanUnitUseStaffNow(unit,spells[i]) ) { ret |= 2; }
	cmp	r0, #0	@ tmp188,
	beq	.L95		@,
@ SpellSystem.c:388: 			if ( CanUnitUseStaffNow(unit,spells[i]) ) { ret |= 2; }
	movs	r3, #2	@ tmp175,
	orrs	r4, r3	@ <retval>, tmp175
	b	.L95		@
.L116:
	.align	2
.L115:
	.word	GetItemAttributes
	.word	CanUnitUseWeaponNow
	.word	CanUnitUseStaffNow
	.size	NewGetUnitUseFlags, .-NewGetUnitUseFlags
	.align	1
	.global	CanUseAttackSpellsNow
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	CanUseAttackSpellsNow, %function
CanUseAttackSpellsNow:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ SpellSystem.c:484: {
	movs	r5, r0	@ unit, tmp128
@ SpellSystem.c:485: 	u8* spells = SpellsGetter(unit,type);
	bl	SpellsGetter		@
	movs	r4, r0	@ ivtmp.260, tmp130
.L118:
@ SpellSystem.c:486: 	for ( int i = 0 ; spells[i] ; i++ )
	ldrb	r0, [r4]	@ _8, MEM[(u8 *)_25]
@ SpellSystem.c:486: 	for ( int i = 0 ; spells[i] ; i++ )
	cmp	r0, #0	@ _8,
	bne	.L122		@,
.L117:
@ SpellSystem.c:494: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L122:
@ SpellSystem.c:488: 		if ( GetItemType(spells[i]) != ITYPE_STAFF && CanCastSpellNow(unit,spells[i]) )
	ldr	r3, .L124	@ tmp125,
	bl	.L14		@
@ SpellSystem.c:488: 		if ( GetItemType(spells[i]) != ITYPE_STAFF && CanCastSpellNow(unit,spells[i]) )
	cmp	r0, #4	@ tmp131,
	bne	.L119		@,
.L121:
	adds	r4, r4, #1	@ ivtmp.260,
	b	.L118		@
.L119:
@ SpellSystem.c:488: 		if ( GetItemType(spells[i]) != ITYPE_STAFF && CanCastSpellNow(unit,spells[i]) )
	movs	r0, r5	@, unit
	ldrb	r1, [r4]	@ MEM[(u8 *)_25], MEM[(u8 *)_25]
	bl	CanCastSpellNow		@
@ SpellSystem.c:488: 		if ( GetItemType(spells[i]) != ITYPE_STAFF && CanCastSpellNow(unit,spells[i]) )
	cmp	r0, #0	@ tmp132,
	beq	.L121		@,
@ SpellSystem.c:490: 			return 1;
	movs	r0, #1	@ <retval>,
	b	.L117		@
.L125:
	.align	2
.L124:
	.word	GetItemType
	.size	CanUseAttackSpellsNow, .-CanUseAttackSpellsNow
	.align	1
	.global	GetNthUsableSpell
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	GetNthUsableSpell, %function
GetNthUsableSpell:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r0, r1, r2, r4, r5, r6, r7, lr}	@
@ SpellSystem.c:499: {
	movs	r7, r1	@ n, tmp125
	movs	r1, r2	@ type, tmp126
	movs	r5, r0	@ unit, tmp124
@ SpellSystem.c:500: 	u8* spells = SpellsGetter(unit,type);
	bl	SpellsGetter		@
@ SpellSystem.c:501: 	int k = -1;
	movs	r6, #1	@ k,
@ SpellSystem.c:502: 	for ( int i = 0 ; spells[i] ; i++ )
	movs	r4, #0	@ <retval>,
@ SpellSystem.c:500: 	u8* spells = SpellsGetter(unit,type);
	str	r0, [sp, #4]	@ tmp127, %sfp
@ SpellSystem.c:501: 	int k = -1;
	rsbs	r6, r6, #0	@ k, k
.L127:
@ SpellSystem.c:502: 	for ( int i = 0 ; spells[i] ; i++ )
	ldr	r3, [sp, #4]	@ spells, %sfp
	ldrb	r1, [r3, r4]	@ _6, MEM[(u8 *)spells_17 + _1 * 1]
@ SpellSystem.c:502: 	for ( int i = 0 ; spells[i] ; i++ )
	cmp	r1, #0	@ _6,
	bne	.L130		@,
@ SpellSystem.c:510: 	return -1;
	movs	r4, #1	@ <retval>,
	rsbs	r4, r4, #0	@ <retval>, <retval>
.L126:
@ SpellSystem.c:511: }
	movs	r0, r4	@, <retval>
	@ sp needed	@
	pop	{r1, r2, r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L130:
@ SpellSystem.c:504: 		if ( CanCastSpellNow(unit,spells[i]) )
	movs	r0, r5	@, unit
	bl	CanCastSpellNow		@
@ SpellSystem.c:504: 		if ( CanCastSpellNow(unit,spells[i]) )
	cmp	r0, #0	@ tmp128,
	beq	.L128		@,
@ SpellSystem.c:506: 			k++;
	adds	r6, r6, #1	@ k,
@ SpellSystem.c:507: 			if ( k == n ) { return i; }
	cmp	r6, r7	@ k, n
	beq	.L126		@,
.L128:
@ SpellSystem.c:502: 	for ( int i = 0 ; spells[i] ; i++ )
	adds	r4, r4, #1	@ <retval>,
	b	.L127		@
	.size	GetNthUsableSpell, .-GetNthUsableSpell
	.align	1
	.global	DoesUnitKnowSpell
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	DoesUnitKnowSpell, %function
DoesUnitKnowSpell:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ SpellSystem.c:524: {
	movs	r4, r1	@ spell, tmp123
@ SpellSystem.c:526: 	u8* spells = SpellsGetter(unit,-1);
	movs	r1, #1	@,
	rsbs	r1, r1, #0	@,
	bl	SpellsGetter		@
.L135:
@ SpellSystem.c:527: 	for ( int i = 0 ; spells[i] ; i++ )
	ldrb	r3, [r0]	@ _3, MEM[(u8 *)_15]
@ SpellSystem.c:527: 	for ( int i = 0 ; spells[i] ; i++ )
	cmp	r3, #0	@ _3,
	bne	.L137		@,
@ SpellSystem.c:531: 	return 0;
	movs	r0, r3	@ <retval>, _3
.L134:
@ SpellSystem.c:532: }
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L137:
@ SpellSystem.c:529: 		if ( spell == spells[i] ) { return 1; }
	adds	r0, r0, #1	@ ivtmp.274,
	cmp	r3, r4	@ _3, spell
	bne	.L135		@,
@ SpellSystem.c:529: 		if ( spell == spells[i] ) { return 1; }
	movs	r0, #1	@ <retval>,
	b	.L134		@
	.size	DoesUnitKnowSpell, .-DoesUnitKnowSpell
	.align	1
	.global	InitGaidenSpellLearnPopup
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	InitGaidenSpellLearnPopup, %function
InitGaidenSpellLearnPopup:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
@ SpellSystem.c:428: 	if ( gBattleActor.levelPrevious != gBattleActor.unit.level ) { subject = &gBattleActor; }
	ldr	r3, .L149	@ tmp131,
	movs	r2, r3	@ tmp134, tmp131
@ SpellSystem.c:424: {
	push	{r4, lr}	@
@ SpellSystem.c:428: 	if ( gBattleActor.levelPrevious != gBattleActor.unit.level ) { subject = &gBattleActor; }
	adds	r2, r2, #112	@ tmp134,
	ldrb	r1, [r2]	@ tmp135,
@ SpellSystem.c:428: 	if ( gBattleActor.levelPrevious != gBattleActor.unit.level ) { subject = &gBattleActor; }
	movs	r2, #8	@ tmp137,
	ldrsb	r2, [r3, r2]	@ tmp137,
@ SpellSystem.c:427: 	BattleUnit* subject = NULL;
	movs	r0, #0	@ subject,
@ SpellSystem.c:428: 	if ( gBattleActor.levelPrevious != gBattleActor.unit.level ) { subject = &gBattleActor; }
	cmp	r1, r2	@ tmp135, tmp137
	beq	.L140		@,
@ SpellSystem.c:428: 	if ( gBattleActor.levelPrevious != gBattleActor.unit.level ) { subject = &gBattleActor; }
	movs	r0, r3	@ subject, tmp131
.L140:
@ SpellSystem.c:429: 	if ( gBattleTarget.levelPrevious != gBattleTarget.unit.level ) { subject = &gBattleTarget; }
	ldr	r3, .L149+4	@ tmp138,
	movs	r2, r3	@ tmp141, tmp138
	adds	r2, r2, #112	@ tmp141,
	ldrb	r1, [r2]	@ tmp142,
@ SpellSystem.c:429: 	if ( gBattleTarget.levelPrevious != gBattleTarget.unit.level ) { subject = &gBattleTarget; }
	movs	r2, #8	@ tmp144,
	ldrsb	r2, [r3, r2]	@ tmp144,
@ SpellSystem.c:429: 	if ( gBattleTarget.levelPrevious != gBattleTarget.unit.level ) { subject = &gBattleTarget; }
	cmp	r1, r2	@ tmp142, tmp144
	bne	.L145		@,
@ SpellSystem.c:430: 	if ( !subject ) { return 0; } // If this isn't filled, we shouldn't show a popup.
	cmp	r0, #0	@ subject,
	bne	.L141		@,
.L143:
@ SpellSystem.c:430: 	if ( !subject ) { return 0; } // If this isn't filled, we shouldn't show a popup.
	movs	r0, #0	@ <retval>,
.L139:
@ SpellSystem.c:439: }
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L145:
@ SpellSystem.c:429: 	if ( gBattleTarget.levelPrevious != gBattleTarget.unit.level ) { subject = &gBattleTarget; }
	movs	r0, r3	@ subject, tmp138
.L141:
@ SpellSystem.c:432: 	u8* spells = SpellsGetterForLevel(&subject->unit,subject->unit.level,-1);
	movs	r1, #8	@ tmp146,
	movs	r2, #1	@,
	ldrsb	r1, [r0, r1]	@ tmp146,
	rsbs	r2, r2, #0	@,
	bl	SpellsGetterForLevel		@
@ SpellSystem.c:434: 	if ( *spells )
	ldrb	r1, [r0]	@ _12, *spells_22
@ SpellSystem.c:434: 	if ( *spells )
	cmp	r1, #0	@ _12,
	beq	.L143		@,
@ SpellSystem.c:436: 		gPopupItem = *spells|0xFF00;
	ldr	r2, .L149+8	@ tmp150,
@ SpellSystem.c:436: 		gPopupItem = *spells|0xFF00;
	ldr	r3, .L149+12	@ tmp147,
@ SpellSystem.c:436: 		gPopupItem = *spells|0xFF00;
	orrs	r2, r1	@ tmp149, _12
@ SpellSystem.c:437: 		return 1;
	movs	r0, #1	@ <retval>,
@ SpellSystem.c:436: 		gPopupItem = *spells|0xFF00;
	strh	r2, [r3]	@ tmp149, gPopupItem
@ SpellSystem.c:437: 		return 1;
	b	.L139		@
.L150:
	.align	2
.L149:
	.word	gBattleActor
	.word	gBattleTarget
	.word	-256
	.word	gPopupItem
	.size	InitGaidenSpellLearnPopup, .-InitGaidenSpellLearnPopup
	.align	1
	.global	GetSpellCost
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	GetSpellCost, %function
GetSpellCost:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ SpellSystem.c:544: 	return GaidenSpellCostTable[GetItemIndex(spell)];
	ldr	r3, .L152	@ tmp118,
@ SpellSystem.c:545: }
	@ sp needed	@
@ SpellSystem.c:544: 	return GaidenSpellCostTable[GetItemIndex(spell)];
	bl	.L14		@
@ SpellSystem.c:544: 	return GaidenSpellCostTable[GetItemIndex(spell)];
	ldr	r3, .L152+4	@ tmp122,
	ldrb	r0, [r3, r0]	@ tmp121, GaidenSpellCostTable
@ SpellSystem.c:545: }
	pop	{r4}
	pop	{r1}
	bx	r1
.L153:
	.align	2
.L152:
	.word	GetItemIndex
	.word	GaidenSpellCostTable
	.size	GetSpellCost, .-GetSpellCost
	.align	1
	.global	HasSufficientHP
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	HasSufficientHP, %function
HasSufficientHP:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ SpellSystem.c:445: 	return (unit->curHP > GetSpellCost(spell));
	movs	r4, #19	@ _2,
	ldrsb	r4, [r0, r4]	@ _2,* _2
@ SpellSystem.c:445: 	return (unit->curHP > GetSpellCost(spell));
	movs	r0, r1	@, spell
	bl	GetSpellCost		@
@ SpellSystem.c:445: 	return (unit->curHP > GetSpellCost(spell));
	movs	r3, #1	@ tmp121,
	cmp	r4, r0	@ _2, tmp130
	bgt	.L155		@,
	movs	r3, #0	@ tmp121,
.L155:
@ SpellSystem.c:446: }
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
	.fpu softvfp
	.type	GaidenMagicUMUsabilityExt, %function
GaidenMagicUMUsabilityExt:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, lr}	@
@ UnitMenu.c:50: 	u8* validList = gGenericBuffer; // Let's build a list of valid spells.
	ldr	r6, .L168	@ validList,
@ UnitMenu.c:53: 		if ( !CanCastSpellNow(gActiveUnit,spellList[i]|0xFF00) ) { continue; }
	movs	r7, #255	@ tmp142,
@ UnitMenu.c:49: {
	movs	r5, r0	@ ivtmp.296, tmp143
	movs	r4, r6	@ validList, validList
@ UnitMenu.c:53: 		if ( !CanCastSpellNow(gActiveUnit,spellList[i]|0xFF00) ) { continue; }
	lsls	r7, r7, #8	@ tmp142, tmp142,
.L157:
@ UnitMenu.c:51: 	for ( int i = 0 ; spellList[i] ; i++ )
	ldrb	r1, [r5]	@ _9, MEM[(u8 *)_42]
@ UnitMenu.c:51: 	for ( int i = 0 ; spellList[i] ; i++ )
	cmp	r1, #0	@ _9,
	bne	.L159		@,
@ UnitMenu.c:57: 	*validList = 0;
	strb	r1, [r6]	@ _9, *validList_15
@ UnitMenu.c:60: 	if ( !*validList ) { return 3; } // Return unusable if there are no valid spells.
	ldrb	r3, [r4]	@ MEM[(u8 *)&gGenericBuffer], MEM[(u8 *)&gGenericBuffer]
@ UnitMenu.c:60: 	if ( !*validList ) { return 3; } // Return unusable if there are no valid spells.
	movs	r0, #3	@ <retval>,
@ UnitMenu.c:60: 	if ( !*validList ) { return 3; } // Return unusable if there are no valid spells.
	cmp	r3, #0	@ MEM[(u8 *)&gGenericBuffer],
	beq	.L156		@,
.L161:
@ UnitMenu.c:61: 	for ( int i = 0 ; validList[i] ; i++ )
	ldrb	r1, [r4]	@ _30, MEM[(u8 *)_37]
@ UnitMenu.c:61: 	for ( int i = 0 ; validList[i] ; i++ )
	cmp	r1, #0	@ _30,
	bne	.L162		@,
@ UnitMenu.c:66: 	return 2; // There were valid spells, but we don't have enough HP to cast any of them. Return greyed out.
	movs	r0, #2	@ <retval>,
.L156:
@ UnitMenu.c:67: }
	@ sp needed	@
	pop	{r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L159:
@ UnitMenu.c:53: 		if ( !CanCastSpellNow(gActiveUnit,spellList[i]|0xFF00) ) { continue; }
	ldr	r3, .L168+4	@ tmp133,
	orrs	r1, r7	@ tmp131, tmp142
	ldr	r0, [r3]	@, gActiveUnit
	bl	CanCastSpellNow		@
@ UnitMenu.c:53: 		if ( !CanCastSpellNow(gActiveUnit,spellList[i]|0xFF00) ) { continue; }
	cmp	r0, #0	@ tmp144,
	beq	.L158		@,
@ UnitMenu.c:54: 		*validList = spellList[i];
	ldrb	r3, [r5]	@ _6, MEM[(u8 *)_42]
@ UnitMenu.c:54: 		*validList = spellList[i];
	strb	r3, [r6]	@ _6, *validList_15
@ UnitMenu.c:55: 		validList++;
	adds	r6, r6, #1	@ validList,
.L158:
	adds	r5, r5, #1	@ ivtmp.296,
	b	.L157		@
.L162:
@ UnitMenu.c:64: 		if ( HasSufficientHP(gActiveUnit,validList[i]) ) { return 1; } // We've found a spell we can cast! Return usable.
	ldr	r3, .L168+4	@ tmp139,
	ldr	r0, [r3]	@, gActiveUnit
	bl	HasSufficientHP		@
@ UnitMenu.c:64: 		if ( HasSufficientHP(gActiveUnit,validList[i]) ) { return 1; } // We've found a spell we can cast! Return usable.
	adds	r4, r4, #1	@ ivtmp.292,
	cmp	r0, #0	@ tmp145,
	beq	.L161		@,
@ UnitMenu.c:64: 		if ( HasSufficientHP(gActiveUnit,validList[i]) ) { return 1; } // We've found a spell we can cast! Return usable.
	movs	r0, #1	@ <retval>,
	b	.L156		@
.L169:
	.align	2
.L168:
	.word	gGenericBuffer
	.word	gActiveUnit
	.size	GaidenMagicUMUsabilityExt, .-GaidenMagicUMUsabilityExt
	.align	1
	.global	GaidenBlackMagicUMUsability
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	GaidenBlackMagicUMUsability, %function
GaidenBlackMagicUMUsability:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
@ UnitMenu.c:10: 	if (*DisableMenuOptionsRam & 1) return 3; // For tutorials 
	movs	r1, #1	@ tmp122,
@ UnitMenu.c:8: {
	push	{r4, lr}	@
@ UnitMenu.c:10: 	if (*DisableMenuOptionsRam & 1) return 3; // For tutorials 
	ldr	r3, .L173	@ tmp118,
@ UnitMenu.c:10: 	if (*DisableMenuOptionsRam & 1) return 3; // For tutorials 
	ldrb	r3, [r3]	@ MEM[(u8 *)50337716B], MEM[(u8 *)50337716B]
@ UnitMenu.c:10: 	if (*DisableMenuOptionsRam & 1) return 3; // For tutorials 
	movs	r0, #3	@ <retval>,
@ UnitMenu.c:10: 	if (*DisableMenuOptionsRam & 1) return 3; // For tutorials 
	tst	r3, r1	@ MEM[(u8 *)50337716B], tmp122
	bne	.L170		@,
@ UnitMenu.c:11: 	return GaidenMagicUMUsabilityExt(SpellsGetter(gActiveUnit,BLACK_MAGIC)); // This is a 0-terminated list of spells this character has learned.
	ldr	r3, .L173+4	@ tmp126,
	ldr	r0, [r3]	@, gActiveUnit
	bl	SpellsGetter		@
	bl	GaidenMagicUMUsabilityExt		@
.L170:
@ UnitMenu.c:12: }
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L174:
	.align	2
.L173:
	.word	50337716
	.word	gActiveUnit
	.size	GaidenBlackMagicUMUsability, .-GaidenBlackMagicUMUsability
	.align	1
	.global	CaptureGaidenBlackMagicUMUsability
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	CaptureGaidenBlackMagicUMUsability, %function
CaptureGaidenBlackMagicUMUsability:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ UnitMenu.c:23: 	if (*DisableMenuOptionsRam & 2) return 3; 
	ldr	r3, .L182	@ tmp119,
@ UnitMenu.c:23: 	if (*DisableMenuOptionsRam & 2) return 3; 
	ldrb	r3, [r3]	@ MEM[(u8 *)50337716B], MEM[(u8 *)50337716B]
	lsls	r3, r3, #30	@ tmp133, MEM[(u8 *)50337716B],
	bpl	.L176		@,
.L178:
@ UnitMenu.c:23: 	if (*DisableMenuOptionsRam & 2) return 3; 
	movs	r0, #3	@ <retval>,
.L175:
@ UnitMenu.c:28: }
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L176:
@ UnitMenu.c:25: 	if (!(Capture_Usability())) { return 3; }
	ldr	r3, .L182+4	@ tmp127,
	bl	.L14		@
@ UnitMenu.c:25: 	if (!(Capture_Usability())) { return 3; }
	cmp	r0, #0	@ tmp130,
	beq	.L178		@,
@ UnitMenu.c:27: 	return GaidenMagicUMUsabilityExt(SpellsGetter(gActiveUnit,BLACK_MAGIC)); // This is a 0-terminated list of spells this character has learned.
	ldr	r3, .L182+8	@ tmp128,
	movs	r1, #1	@,
	ldr	r0, [r3]	@, gActiveUnit
	bl	SpellsGetter		@
	bl	GaidenMagicUMUsabilityExt		@
	b	.L175		@
.L183:
	.align	2
.L182:
	.word	50337716
	.word	Capture_Usability
	.word	gActiveUnit
	.size	CaptureGaidenBlackMagicUMUsability, .-CaptureGaidenBlackMagicUMUsability
	.align	1
	.global	GaidenWhiteMagicUMUsability
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	GaidenWhiteMagicUMUsability, %function
GaidenWhiteMagicUMUsability:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ UnitMenu.c:45: 	return GaidenMagicUMUsabilityExt(SpellsGetter(gActiveUnit,WHITE_MAGIC));
	ldr	r3, .L185	@ tmp116,
@ UnitMenu.c:46: }
	@ sp needed	@
@ UnitMenu.c:45: 	return GaidenMagicUMUsabilityExt(SpellsGetter(gActiveUnit,WHITE_MAGIC));
	movs	r1, #2	@,
	ldr	r0, [r3]	@, gActiveUnit
	bl	SpellsGetter		@
	bl	GaidenMagicUMUsabilityExt		@
@ UnitMenu.c:46: }
	pop	{r4}
	pop	{r1}
	bx	r1
.L186:
	.align	2
.L185:
	.word	gActiveUnit
	.size	GaidenWhiteMagicUMUsability, .-GaidenWhiteMagicUMUsability
	.align	1
	.global	SetRoundForSpell
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	SetRoundForSpell, %function
SetRoundForSpell:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ SpellSystem.c:408: 	if ( HasSufficientHP(&unit->unit,unit->weapon) )
	movs	r5, r0	@ tmp133, unit
	adds	r5, r5, #72	@ tmp133,
@ SpellSystem.c:407: {
	movs	r4, r1	@ buffer, tmp151
@ SpellSystem.c:408: 	if ( HasSufficientHP(&unit->unit,unit->weapon) )
	ldrh	r1, [r5]	@ tmp134,
	bl	HasSufficientHP		@
@ SpellSystem.c:408: 	if ( HasSufficientHP(&unit->unit,unit->weapon) )
	cmp	r0, #0	@ tmp152,
	beq	.L188		@,
@ SpellSystem.c:410: 		int cost = GetSpellCost(unit->weapon);
	ldrh	r0, [r5]	@ MEM[(short unsigned int *)unit_7(D) + 72B], MEM[(short unsigned int *)unit_7(D) + 72B]
	bl	GetSpellCost		@
@ SpellSystem.c:412: 		buffer->attributes |= BATTLE_HIT_ATTR_HPSTEAL; // "HP drain" bit.
	movs	r3, #128	@ tmp141,
	ldr	r2, [r4]	@ tmp140,* buffer
	lsls	r3, r3, #1	@ tmp141, tmp141,
	orrs	r3, r2	@ tmp139, tmp140
	str	r3, [r4]	@ tmp139,* buffer
@ SpellSystem.c:414: 		buffer->damage -= cost;
	ldrb	r3, [r4, #5]	@ tmp143,
	subs	r3, r3, r0	@ tmp145, tmp143, tmp153
	strb	r3, [r4, #5]	@ tmp145, buffer_10(D)->damage
.L187:
@ SpellSystem.c:421: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L188:
@ SpellSystem.c:419: 		buffer->attributes |= BATTLE_HIT_ATTR_5; // This bit is checked in an external hack I've made.
	movs	r3, #32	@ tmp149,
	ldr	r2, [r4]	@ tmp148,* buffer
	orrs	r3, r2	@ tmp147, tmp148
	str	r3, [r4]	@ tmp147,* buffer
@ SpellSystem.c:421: }
	b	.L187		@
	.size	SetRoundForSpell, .-SetRoundForSpell
	.align	1
	.global	Proc_GaidenMagicHPCost
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	Proc_GaidenMagicHPCost, %function
Proc_GaidenMagicHPCost:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ SpellSystem.c:400: 	if ( GetUnitEquippedWeaponSlot(&attacker->unit) == 9 ) // Instead of checking against UsingSpellMenu, we do this to cover the case of defense.
	ldr	r3, .L192	@ tmp119,
@ SpellSystem.c:398: {
	movs	r4, r0	@ attacker, tmp120
	movs	r5, r2	@ buffer, tmp121
@ SpellSystem.c:400: 	if ( GetUnitEquippedWeaponSlot(&attacker->unit) == 9 ) // Instead of checking against UsingSpellMenu, we do this to cover the case of defense.
	bl	.L14		@
@ SpellSystem.c:400: 	if ( GetUnitEquippedWeaponSlot(&attacker->unit) == 9 ) // Instead of checking against UsingSpellMenu, we do this to cover the case of defense.
	cmp	r0, #9	@ tmp122,
	bne	.L190		@,
@ SpellSystem.c:402: 		SetRoundForSpell(attacker,buffer);
	movs	r1, r5	@, buffer
	movs	r0, r4	@, attacker
	bl	SetRoundForSpell		@
.L190:
@ SpellSystem.c:404: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L193:
	.align	2
.L192:
	.word	GetUnitEquippedWeaponSlot
	.size	Proc_GaidenMagicHPCost, .-Proc_GaidenMagicHPCost
	.align	1
	.global	GetFirstAttackSpell
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	GetFirstAttackSpell, %function
GetFirstAttackSpell:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
@ SpellSystem.c:549: 	u8* spells = SpellsGetter(unit,-1);
	movs	r1, #1	@,
@ SpellSystem.c:548: {
	push	{r4, r5, r6, lr}	@
@ SpellSystem.c:549: 	u8* spells = SpellsGetter(unit,-1);
	rsbs	r1, r1, #0	@,
	bl	SpellsGetter		@
	movs	r4, r0	@ ivtmp.320, tmp126
.L195:
@ SpellSystem.c:551: 	for ( int i = 0 ; spells[i] ; i++ )
	ldrb	r0, [r4]	@ _7, MEM[(u8 *)_6]
	movs	r5, r4	@ _6, ivtmp.320
@ SpellSystem.c:551: 	for ( int i = 0 ; spells[i] ; i++ )
	cmp	r0, #0	@ _7,
	beq	.L194		@,
@ SpellSystem.c:553: 		if ( GetItemType(spells[i]) != ITYPE_STAFF ) { spell = spells[i]; break; } // Ensure that the spell we could counter with would be an attack spell.
	ldr	r3, .L200	@ tmp123,
	bl	.L14		@
@ SpellSystem.c:553: 		if ( GetItemType(spells[i]) != ITYPE_STAFF ) { spell = spells[i]; break; } // Ensure that the spell we could counter with would be an attack spell.
	adds	r4, r4, #1	@ ivtmp.320,
	cmp	r0, #4	@ tmp127,
	beq	.L195		@,
@ SpellSystem.c:553: 		if ( GetItemType(spells[i]) != ITYPE_STAFF ) { spell = spells[i]; break; } // Ensure that the spell we could counter with would be an attack spell.
	ldrb	r0, [r5]	@ <retval>, *_6
.L194:
@ SpellSystem.c:556: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L201:
	.align	2
.L200:
	.word	GetItemType
	.size	GetFirstAttackSpell, .-GetFirstAttackSpell
	.align	1
	.global	NewGetUnitEquippedWeapon
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	NewGetUnitEquippedWeapon, %function
NewGetUnitEquippedWeapon:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ SpellSystem.c:133: {
	movs	r6, r0	@ unit, tmp164
@ SpellSystem.c:515: 	for ( int i = 0 ; i < 5 ; i++ )
	movs	r5, #0	@ i,
.L205:
@ SpellSystem.c:517: 		if ( CanUnitUseWeapon(unit,unit->items[i]) ) { return unit->items[i]; }
	movs	r3, r6	@ tmp136, unit
@ SpellSystem.c:517: 		if ( CanUnitUseWeapon(unit,unit->items[i]) ) { return unit->items[i]; }
	lsls	r2, r5, #1	@ tmp137, i,
@ SpellSystem.c:517: 		if ( CanUnitUseWeapon(unit,unit->items[i]) ) { return unit->items[i]; }
	adds	r3, r3, #30	@ tmp136,
	ldrh	r1, [r3, r2]	@ MEM[(short unsigned int *)_31 + _40 * 1], MEM[(short unsigned int *)_31 + _40 * 1]
	movs	r0, r6	@, unit
	ldr	r3, .L225	@ tmp139,
	bl	.L14		@
	subs	r4, r0, #0	@ <retval>, tmp165,
@ SpellSystem.c:517: 		if ( CanUnitUseWeapon(unit,unit->items[i]) ) { return unit->items[i]; }
	beq	.L203		@,
@ SpellSystem.c:517: 		if ( CanUnitUseWeapon(unit,unit->items[i]) ) { return unit->items[i]; }
	adds	r5, r5, #12	@ tmp140,
	lsls	r5, r5, #1	@ tmp141, tmp140,
	adds	r5, r6, r5	@ tmp142, unit, tmp141
	ldrh	r4, [r5, #6]	@ <retval>, *unit_21(D)
.L204:
@ SpellSystem.c:140: 	int spell = GetFirstAttackSpell(unit);
	movs	r0, r6	@, unit
	bl	GetFirstAttackSpell		@
@ SpellSystem.c:143: 	if ( gChapterData.currentPhase == ( unit->index & 0xC0 ) )
	movs	r3, #192	@ tmp144,
@ SpellSystem.c:143: 	if ( gChapterData.currentPhase == ( unit->index & 0xC0 ) )
	ldrb	r6, [r6, #11]	@ _3,
@ SpellSystem.c:143: 	if ( gChapterData.currentPhase == ( unit->index & 0xC0 ) )
	ldr	r2, .L225+4	@ tmp145,
@ SpellSystem.c:143: 	if ( gChapterData.currentPhase == ( unit->index & 0xC0 ) )
	lsls	r6, r6, #24	@ _3, _3,
@ SpellSystem.c:143: 	if ( gChapterData.currentPhase == ( unit->index & 0xC0 ) )
	ldrb	r2, [r2, #15]	@ tmp146,
@ SpellSystem.c:143: 	if ( gChapterData.currentPhase == ( unit->index & 0xC0 ) )
	asrs	r6, r6, #24	@ _3, _3,
	ldr	r1, .L225+8	@ tmp162,
@ SpellSystem.c:143: 	if ( gChapterData.currentPhase == ( unit->index & 0xC0 ) )
	ands	r3, r6	@ _5, _3
@ SpellSystem.c:143: 	if ( gChapterData.currentPhase == ( unit->index & 0xC0 ) )
	cmp	r2, r3	@ tmp146, _5
	bne	.L206		@,
@ SpellSystem.c:147: 		if ( !UsingSpellMenu && ( unit->index & 0xC0 ) ) { return vanillaEquipped; } // enemies wielding their vanilla wep 		
	ldrb	r3, [r1]	@ UsingSpellMenu, UsingSpellMenu
	cmp	r3, #0	@ UsingSpellMenu,
	bne	.L207		@,
@ SpellSystem.c:147: 		if ( !UsingSpellMenu && ( unit->index & 0xC0 ) ) { return vanillaEquipped; } // enemies wielding their vanilla wep 		
	cmp	r2, #0	@ tmp146,
	bne	.L202		@,
@ SpellSystem.c:148: 		if ( !UsingSpellMenu && !( unit->index & 0xC0 ) ) { return ( spell ? spell|0xFF00 : 0 ); } // for mmb - show first spell 
	movs	r4, r2	@ <retval>, tmp146
.L224:
@ SpellSystem.c:203: 		if ( !UsingSpellMenu && !( unit->index & 0xC0 ) ) { return ( spell ? spell|0xFF00 : 0 ); } // for mmb - show first spell 
	cmp	r0, #0	@ spell,
	beq	.L202		@,
.L222:
@ SpellSystem.c:205: 		return ( spell ? spell|0xFF00 : 0 );
	movs	r4, #255	@ tmp160,
	lsls	r4, r4, #8	@ tmp160, tmp160,
	orrs	r4, r0	@ <retval>, spell
	b	.L202		@
.L203:
@ SpellSystem.c:515: 	for ( int i = 0 ; i < 5 ; i++ )
	adds	r5, r5, #1	@ i,
@ SpellSystem.c:515: 	for ( int i = 0 ; i < 5 ; i++ )
	cmp	r5, #5	@ i,
	bne	.L205		@,
	b	.L204		@
.L207:
@ SpellSystem.c:153: 			if ( unit->index == gBattleTarget.unit.index && GetItemType(SelectedSpell) == ITYPE_STAFF )
	ldr	r3, .L225+12	@ tmp151,
@ SpellSystem.c:153: 			if ( unit->index == gBattleTarget.unit.index && GetItemType(SelectedSpell) == ITYPE_STAFF )
	ldrb	r3, [r3, #11]	@ tmp152,
@ SpellSystem.c:153: 			if ( unit->index == gBattleTarget.unit.index && GetItemType(SelectedSpell) == ITYPE_STAFF )
	ldr	r5, .L225+16	@ tmp150,
@ SpellSystem.c:153: 			if ( unit->index == gBattleTarget.unit.index && GetItemType(SelectedSpell) == ITYPE_STAFF )
	lsls	r3, r3, #24	@ tmp152, tmp152,
@ SpellSystem.c:153: 			if ( unit->index == gBattleTarget.unit.index && GetItemType(SelectedSpell) == ITYPE_STAFF )
	ldrb	r0, [r5]	@ pretmp_50, SelectedSpell
@ SpellSystem.c:153: 			if ( unit->index == gBattleTarget.unit.index && GetItemType(SelectedSpell) == ITYPE_STAFF )
	asrs	r3, r3, #24	@ tmp152, tmp152,
	cmp	r3, r6	@ tmp152, _3
	beq	.L209		@,
.L210:
@ SpellSystem.c:184: 				return SelectedSpell|0xFF00; 
	movs	r4, #255	@ tmp155,
	ldrb	r3, [r5]	@ SelectedSpell, SelectedSpell
	lsls	r4, r4, #8	@ tmp155, tmp155,
	orrs	r4, r3	@ <retval>, SelectedSpell
.L202:
@ SpellSystem.c:208: }
	movs	r0, r4	@, <retval>
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L209:
@ SpellSystem.c:153: 			if ( unit->index == gBattleTarget.unit.index && GetItemType(SelectedSpell) == ITYPE_STAFF )
	ldr	r3, .L225+20	@ tmp156,
	bl	.L14		@
@ SpellSystem.c:153: 			if ( unit->index == gBattleTarget.unit.index && GetItemType(SelectedSpell) == ITYPE_STAFF )
	cmp	r0, #4	@ tmp167,
	bne	.L210		@,
	b	.L202		@
.L206:
@ SpellSystem.c:202: 		if ( !UsingSpellMenu && ( unit->index & 0xC0 ) ) { return vanillaEquipped; } // mmb - enemies wielding their vanilla wep 		
	ldrb	r2, [r1]	@ UsingSpellMenu, UsingSpellMenu
	cmp	r2, #0	@ UsingSpellMenu,
	bne	.L211		@,
@ SpellSystem.c:202: 		if ( !UsingSpellMenu && ( unit->index & 0xC0 ) ) { return vanillaEquipped; } // mmb - enemies wielding their vanilla wep 		
	cmp	r3, #0	@ _5,
	bne	.L202		@,
@ SpellSystem.c:148: 		if ( !UsingSpellMenu && !( unit->index & 0xC0 ) ) { return ( spell ? spell|0xFF00 : 0 ); } // for mmb - show first spell 
	movs	r4, r3	@ <retval>, _5
	b	.L224		@
.L211:
@ SpellSystem.c:148: 		if ( !UsingSpellMenu && !( unit->index & 0xC0 ) ) { return ( spell ? spell|0xFF00 : 0 ); } // for mmb - show first spell 
	movs	r4, #0	@ <retval>,
@ SpellSystem.c:205: 		return ( spell ? spell|0xFF00 : 0 );
	cmp	r0, r4	@ spell,
	beq	.L202		@,
	b	.L222		@
.L226:
	.align	2
.L225:
	.word	CanUnitUseWeapon
	.word	gChapterData
	.word	UsingSpellMenu
	.word	gBattleTarget
	.word	SelectedSpell
	.word	GetItemType
	.size	NewGetUnitEquippedWeapon, .-NewGetUnitEquippedWeapon
	.align	1
	.global	NewGetUnitEquippedWeaponSlot
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	NewGetUnitEquippedWeaponSlot, %function
NewGetUnitEquippedWeaponSlot:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r0, r1, r2, r4, r5, r6, r7, lr}	@
@ SpellSystem.c:215: {
	movs	r5, r0	@ unit, tmp189
@ SpellSystem.c:226: 	int spell = GetFirstAttackSpell(unit);
	bl	GetFirstAttackSpell		@
@ SpellSystem.c:229: 	if ( !(UsingSpellMenu) && unit->index != gBattleTarget.unit.index && (gBattleStats.config & (BATTLE_CONFIG_REAL|BATTLE_CONFIG_SIMULATE)) ) { 
	ldr	r3, .L263	@ tmp150,
@ SpellSystem.c:229: 	if ( !(UsingSpellMenu) && unit->index != gBattleTarget.unit.index && (gBattleStats.config & (BATTLE_CONFIG_REAL|BATTLE_CONFIG_SIMULATE)) ) { 
	ldrb	r4, [r3]	@ UsingSpellMenu, UsingSpellMenu
@ SpellSystem.c:226: 	int spell = GetFirstAttackSpell(unit);
	movs	r6, r0	@ spell, tmp190
	ldr	r7, .L263+4	@ tmp187,
@ SpellSystem.c:229: 	if ( !(UsingSpellMenu) && unit->index != gBattleTarget.unit.index && (gBattleStats.config & (BATTLE_CONFIG_REAL|BATTLE_CONFIG_SIMULATE)) ) { 
	cmp	r4, #0	@ UsingSpellMenu,
	bne	.L228		@,
@ SpellSystem.c:229: 	if ( !(UsingSpellMenu) && unit->index != gBattleTarget.unit.index && (gBattleStats.config & (BATTLE_CONFIG_REAL|BATTLE_CONFIG_SIMULATE)) ) { 
	movs	r2, #11	@ tmp153,
@ SpellSystem.c:229: 	if ( !(UsingSpellMenu) && unit->index != gBattleTarget.unit.index && (gBattleStats.config & (BATTLE_CONFIG_REAL|BATTLE_CONFIG_SIMULATE)) ) { 
	ldr	r3, .L263+8	@ tmp152,
@ SpellSystem.c:229: 	if ( !(UsingSpellMenu) && unit->index != gBattleTarget.unit.index && (gBattleStats.config & (BATTLE_CONFIG_REAL|BATTLE_CONFIG_SIMULATE)) ) { 
	ldrb	r3, [r3, #11]	@ tmp154,
	ldrsb	r2, [r5, r2]	@ tmp153,
	lsls	r3, r3, #24	@ tmp154, tmp154,
	asrs	r3, r3, #24	@ tmp154, tmp154,
	cmp	r2, r3	@ tmp153, tmp154
	beq	.L229		@,
@ SpellSystem.c:229: 	if ( !(UsingSpellMenu) && unit->index != gBattleTarget.unit.index && (gBattleStats.config & (BATTLE_CONFIG_REAL|BATTLE_CONFIG_SIMULATE)) ) { 
	ldr	r3, .L263+12	@ tmp155,
	str	r3, [sp, #4]	@ tmp155, %sfp
@ SpellSystem.c:229: 	if ( !(UsingSpellMenu) && unit->index != gBattleTarget.unit.index && (gBattleStats.config & (BATTLE_CONFIG_REAL|BATTLE_CONFIG_SIMULATE)) ) { 
	ldrh	r3, [r3]	@ gBattleStats, gBattleStats
	lsls	r3, r3, #30	@ tmp198, gBattleStats,
	beq	.L229		@,
	movs	r6, r5	@ ivtmp.341, unit
	adds	r6, r6, #30	@ ivtmp.341,
.L232:
@ SpellSystem.c:233: 			if ( CanUnitUseWeapon(unit,unit->items[i]) )
	movs	r0, r5	@, unit
	ldrh	r1, [r6]	@ MEM[(short unsigned int *)_39], MEM[(short unsigned int *)_39]
	bl	.L265		@
@ SpellSystem.c:233: 			if ( CanUnitUseWeapon(unit,unit->items[i]) )
	cmp	r0, #0	@ tmp191,
	bne	.L230		@,
.L233:
@ SpellSystem.c:240: 		return -1; 
	movs	r4, #1	@ <retval>,
	rsbs	r4, r4, #0	@ <retval>, <retval>
.L227:
@ SpellSystem.c:357: }
	movs	r0, r4	@, <retval>
	@ sp needed	@
	pop	{r1, r2, r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L230:
@ SpellSystem.c:236: 				if ( gCan_Attack_Target(unit->items[i],gBattleStats.range,unit) ) { return i; }
	ldr	r3, [sp, #4]	@ tmp155, %sfp
	ldrb	r1, [r3, #2]	@ tmp166,
	ldr	r3, .L263+16	@ tmp168,
	movs	r2, r5	@, unit
	ldrh	r0, [r6]	@ MEM[(short unsigned int *)_39], MEM[(short unsigned int *)_39]
	ldr	r3, [r3]	@ gCan_Attack_Target, gCan_Attack_Target
	bl	.L14		@
@ SpellSystem.c:236: 				if ( gCan_Attack_Target(unit->items[i],gBattleStats.range,unit) ) { return i; }
	cmp	r0, #0	@ tmp192,
	bne	.L227		@,
@ SpellSystem.c:230: 		for ( int i = 0 ; i < 5 ; i++ )
	adds	r4, r4, #1	@ <retval>,
@ SpellSystem.c:230: 		for ( int i = 0 ; i < 5 ; i++ )
	adds	r6, r6, #2	@ ivtmp.341,
	cmp	r4, #5	@ <retval>,
	bne	.L232		@,
	b	.L233		@
.L228:
@ SpellSystem.c:246: 	if ( UsingSpellMenu && CanUnitUseWeapon(unit,SelectedSpell) && !(unit->index & 0xC0) ) { 
	ldr	r3, .L263+20	@ tmp170,
	movs	r0, r5	@, unit
	ldrb	r1, [r3]	@ SelectedSpell, SelectedSpell
	bl	.L265		@
@ SpellSystem.c:246: 	if ( UsingSpellMenu && CanUnitUseWeapon(unit,SelectedSpell) && !(unit->index & 0xC0) ) { 
	cmp	r0, #0	@ tmp193,
	beq	.L229		@,
@ SpellSystem.c:246: 	if ( UsingSpellMenu && CanUnitUseWeapon(unit,SelectedSpell) && !(unit->index & 0xC0) ) { 
	movs	r2, #11	@ tmp173,
@ SpellSystem.c:246: 	if ( UsingSpellMenu && CanUnitUseWeapon(unit,SelectedSpell) && !(unit->index & 0xC0) ) { 
	movs	r3, #192	@ tmp175,
@ SpellSystem.c:246: 	if ( UsingSpellMenu && CanUnitUseWeapon(unit,SelectedSpell) && !(unit->index & 0xC0) ) { 
	ldrsb	r2, [r5, r2]	@ tmp173,
@ SpellSystem.c:246: 	if ( UsingSpellMenu && CanUnitUseWeapon(unit,SelectedSpell) && !(unit->index & 0xC0) ) { 
	tst	r2, r3	@ tmp173, tmp175
	beq	.L234		@,
.L236:
@ SpellSystem.c:230: 		for ( int i = 0 ; i < 5 ; i++ )
	movs	r4, #0	@ <retval>,
.L235:
@ SpellSystem.c:259: 				if ( CanUnitUseWeapon(unit,unit->items[i]) ) { return i; }
	movs	r3, r5	@ tmp178, unit
@ SpellSystem.c:259: 				if ( CanUnitUseWeapon(unit,unit->items[i]) ) { return i; }
	lsls	r2, r4, #1	@ tmp179, <retval>,
@ SpellSystem.c:259: 				if ( CanUnitUseWeapon(unit,unit->items[i]) ) { return i; }
	adds	r3, r3, #30	@ tmp178,
	movs	r0, r5	@, unit
	ldrh	r1, [r3, r2]	@ MEM[(short unsigned int *)_37 + _14 * 1], MEM[(short unsigned int *)_37 + _14 * 1]
	bl	.L265		@
@ SpellSystem.c:259: 				if ( CanUnitUseWeapon(unit,unit->items[i]) ) { return i; }
	cmp	r0, #0	@ tmp194,
	bne	.L227		@,
@ SpellSystem.c:257: 		for ( int i = 0 ; i < 5 ; i++ )
	adds	r4, r4, #1	@ <retval>,
@ SpellSystem.c:257: 		for ( int i = 0 ; i < 5 ; i++ )
	cmp	r4, #5	@ <retval>,
	bne	.L235		@,
	b	.L233		@
.L229:
@ SpellSystem.c:256: 	if ( unit->index & 0xC0 ) {
	movs	r2, #11	@ tmp176,
	ldrsb	r2, [r5, r2]	@ tmp176,
@ SpellSystem.c:256: 	if ( unit->index & 0xC0 ) {
	movs	r3, #192	@ tmp177,
	movs	r4, r2	@ <retval>, tmp176
	ands	r4, r3	@ <retval>, tmp177
@ SpellSystem.c:256: 	if ( unit->index & 0xC0 ) {
	tst	r2, r3	@ tmp176, tmp177
	bne	.L236		@,
@ SpellSystem.c:268: 	if ( gChapterData.currentPhase != ( unit->index & 0xC0 ) && ( CanUnitUseWeapon( unit, spell ) ) ) { return ( spell ? 9 : 0 ); } // Enemy phase - Always counter attack with first spell.
	ldr	r3, .L263+24	@ tmp182,
@ SpellSystem.c:268: 	if ( gChapterData.currentPhase != ( unit->index & 0xC0 ) && ( CanUnitUseWeapon( unit, spell ) ) ) { return ( spell ? 9 : 0 ); } // Enemy phase - Always counter attack with first spell.
	ldrb	r3, [r3, #15]	@ tmp183,
	cmp	r3, #0	@ tmp183,
	beq	.L238		@,
@ SpellSystem.c:268: 	if ( gChapterData.currentPhase != ( unit->index & 0xC0 ) && ( CanUnitUseWeapon( unit, spell ) ) ) { return ( spell ? 9 : 0 ); } // Enemy phase - Always counter attack with first spell.
	movs	r1, r6	@, spell
	movs	r0, r5	@, unit
	bl	.L265		@
@ SpellSystem.c:268: 	if ( gChapterData.currentPhase != ( unit->index & 0xC0 ) && ( CanUnitUseWeapon( unit, spell ) ) ) { return ( spell ? 9 : 0 ); } // Enemy phase - Always counter attack with first spell.
	cmp	r0, #0	@ tmp195,
	beq	.L238		@,
.L262:
@ SpellSystem.c:275: 	if ( CanUnitUseWeapon( unit, spell ) ) { return ( spell ? 9 : 0 ); } // Used in stat screen by players. 
	cmp	r6, #0	@ spell,
	beq	.L227		@,
.L234:
@ SpellSystem.c:248: 		return 9;
	movs	r4, #9	@ <retval>,
	b	.L227		@
.L238:
@ SpellSystem.c:275: 	if ( CanUnitUseWeapon( unit, spell ) ) { return ( spell ? 9 : 0 ); } // Used in stat screen by players. 
	movs	r1, r6	@, spell
	movs	r0, r5	@, unit
	bl	.L265		@
@ SpellSystem.c:275: 	if ( CanUnitUseWeapon( unit, spell ) ) { return ( spell ? 9 : 0 ); } // Used in stat screen by players. 
	cmp	r0, #0	@ tmp196,
	bne	.L262		@,
	b	.L233		@
.L264:
	.align	2
.L263:
	.word	UsingSpellMenu
	.word	CanUnitUseWeapon
	.word	gBattleTarget
	.word	gBattleStats
	.word	gCan_Attack_Target
	.word	SelectedSpell
	.word	gChapterData
	.size	NewGetUnitEquippedWeaponSlot, .-NewGetUnitEquippedWeaponSlot
	.align	1
	.global	Target_Routine_For_Fortify
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	Target_Routine_For_Fortify, %function
Target_Routine_For_Fortify:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ SpellSystem.c:563: 	if ( UsingSpellMenu )
	ldr	r3, .L269	@ tmp123,
@ SpellSystem.c:563: 	if ( UsingSpellMenu )
	ldrb	r3, [r3]	@ UsingSpellMenu, UsingSpellMenu
	cmp	r3, #0	@ UsingSpellMenu,
	beq	.L267		@,
@ SpellSystem.c:565: 		item = SelectedSpell|0xFF00;
	ldr	r3, .L269+4	@ tmp125,
	ldrb	r2, [r3]	@ SelectedSpell, SelectedSpell
@ SpellSystem.c:565: 		item = SelectedSpell|0xFF00;
	movs	r3, #255	@ tmp128,
	lsls	r3, r3, #8	@ tmp128, tmp128,
	orrs	r2, r3	@ item, tmp128
.L268:
@ SpellSystem.c:571: 	gHealStaff_RangeSetup(unit,0,item);
	ldr	r3, .L269+8	@ tmp137,
@ SpellSystem.c:572: }
	@ sp needed	@
@ SpellSystem.c:571: 	gHealStaff_RangeSetup(unit,0,item);
	movs	r1, #0	@,
	ldr	r3, [r3]	@ gHealStaff_RangeSetup, gHealStaff_RangeSetup
	bl	.L14		@
@ SpellSystem.c:572: }
	pop	{r4}
	pop	{r0}
	bx	r0
.L267:
@ SpellSystem.c:569: 		item = unit->unit.items[gActionData.itemSlotIndex];
	ldr	r3, .L269+12	@ tmp131,
	ldrb	r3, [r3, #18]	@ tmp132,
@ SpellSystem.c:569: 		item = unit->unit.items[gActionData.itemSlotIndex];
	adds	r3, r3, #12	@ tmp133,
	lsls	r3, r3, #1	@ tmp134, tmp133,
	adds	r3, r0, r3	@ tmp135, unit, tmp134
	ldrh	r2, [r3, #6]	@ item, *unit_11(D)
	b	.L268		@
.L270:
	.align	2
.L269:
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
	.fpu softvfp
	.type	GaidenZeroOutSpellVariables, %function
GaidenZeroOutSpellVariables:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
@ SpellSystem.c:576: 	UsingSpellMenu = 0;
	movs	r3, #0	@ tmp114,
@ SpellSystem.c:579: }
	@ sp needed	@
@ SpellSystem.c:576: 	UsingSpellMenu = 0;
	ldr	r2, .L272	@ tmp113,
	strb	r3, [r2]	@ tmp114, UsingSpellMenu
@ SpellSystem.c:577: 	SelectedSpell = 0;
	ldr	r2, .L272+4	@ tmp116,
	strb	r3, [r2]	@ tmp114, SelectedSpell
@ SpellSystem.c:578: 	DidSelectSpell = 0;
	ldr	r2, .L272+8	@ tmp119,
	strb	r3, [r2]	@ tmp114, DidSelectSpell
@ SpellSystem.c:579: }
	bx	lr
.L273:
	.align	2
.L272:
	.word	UsingSpellMenu
	.word	SelectedSpell
	.word	DidSelectSpell
	.size	GaidenZeroOutSpellVariables, .-GaidenZeroOutSpellVariables
	.align	1
	.global	GetUnitRangeMaskForSpells
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	GetUnitRangeMaskForSpells, %function
GetUnitRangeMaskForSpells:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r0, r1, r2, r4, r5, r6, r7, lr}	@
@ RangeDisplay.c:42: 	u8* spells = SpellsGetter(unit,(UsingSpellMenu ? UsingSpellMenu : -1)); // If UsingSpellMenu is nonzero, only get Gaiden spells of that type.
	ldr	r3, .L290	@ tmp130,
@ RangeDisplay.c:40: {
	str	r1, [sp, #4]	@ tmp139, %sfp
@ RangeDisplay.c:42: 	u8* spells = SpellsGetter(unit,(UsingSpellMenu ? UsingSpellMenu : -1)); // If UsingSpellMenu is nonzero, only get Gaiden spells of that type.
	ldrb	r1, [r3]	@ UsingSpellMenu.73_1, UsingSpellMenu
@ RangeDisplay.c:40: {
	movs	r7, r0	@ unit, tmp138
@ RangeDisplay.c:42: 	u8* spells = SpellsGetter(unit,(UsingSpellMenu ? UsingSpellMenu : -1)); // If UsingSpellMenu is nonzero, only get Gaiden spells of that type.
	cmp	r1, #0	@ UsingSpellMenu.73_1,
	bne	.L275		@,
	subs	r1, r1, #1	@ iftmp.72_16,
.L275:
@ RangeDisplay.c:41: 	long long current = 0;
	movs	r5, #0	@ <retval>,
@ RangeDisplay.c:42: 	u8* spells = SpellsGetter(unit,(UsingSpellMenu ? UsingSpellMenu : -1)); // If UsingSpellMenu is nonzero, only get Gaiden spells of that type.
	movs	r0, r7	@, unit
	bl	SpellsGetter		@
@ RangeDisplay.c:41: 	long long current = 0;
	movs	r4, r5	@ <retval>, <retval>
@ RangeDisplay.c:42: 	u8* spells = SpellsGetter(unit,(UsingSpellMenu ? UsingSpellMenu : -1)); // If UsingSpellMenu is nonzero, only get Gaiden spells of that type.
	str	r0, [sp]	@ tmp140, %sfp
.L276:
@ RangeDisplay.c:43: 	for ( int i = 0 ; spells[i] ; i++ )
	ldr	r3, [sp]	@ ivtmp.363, %sfp
	ldrb	r6, [r3]	@ _12, MEM[(u8 *)_36]
@ RangeDisplay.c:43: 	for ( int i = 0 ; spells[i] ; i++ )
	cmp	r6, #0	@ _12,
	bne	.L279		@,
@ RangeDisplay.c:56: }
	movs	r0, r5	@, <retval>
	movs	r1, r4	@, <retval>
	add	sp, sp, #12	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7}
	pop	{r2}
	bx	r2
.L279:
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
	bne	.L277		@,
@ RangeDisplay.c:48: 			if ( CanCastSpell(unit,spell) ) { current = IncorporateNewRange(current,gGet_Item_Range(unit,spell)); }
	bl	CanCastSpell		@
.L289:
@ RangeDisplay.c:52: 			if ( usability(unit,spell) ) { current = IncorporateNewRange(current,gGet_Item_Range(unit,spell)); }
	cmp	r0, #0	@ tmp144,
	beq	.L278		@,
@ RangeDisplay.c:52: 			if ( usability(unit,spell) ) { current = IncorporateNewRange(current,gGet_Item_Range(unit,spell)); }
	ldr	r3, .L290+4	@ tmp134,
	movs	r1, r6	@, spell
	ldr	r3, [r3]	@ gGet_Item_Range, gGet_Item_Range
	movs	r0, r7	@, unit
	bl	.L14		@
	movs	r2, r0	@ _9, tmp159
	movs	r3, r1	@ _9, tmp160
	movs	r0, r5	@, <retval>
	movs	r1, r4	@, <retval>
	bl	IncorporateNewRange		@
	movs	r5, r0	@ <retval>, tmp161
	movs	r4, r1	@ <retval>, tmp162
.L278:
	ldr	r3, [sp]	@ ivtmp.363, %sfp
	adds	r3, r3, #1	@ ivtmp.363,
	str	r3, [sp]	@ ivtmp.363, %sfp
	b	.L276		@
.L277:
@ RangeDisplay.c:52: 			if ( usability(unit,spell) ) { current = IncorporateNewRange(current,gGet_Item_Range(unit,spell)); }
	ldr	r3, [sp, #4]	@ usability, %sfp
	bl	.L14		@
	b	.L289		@
.L291:
	.align	2
.L290:
	.word	UsingSpellMenu
	.word	gGet_Item_Range
	.size	GetUnitRangeMaskForSpells, .-GetUnitRangeMaskForSpells
	.align	1
	.global	Return_Range_Bitfield
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
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
	bcc	.L293		@,
@ RangeDisplay.c:10: 	long long current = 0;
	movs	r5, #0	@ <retval>,
	movs	r3, r0	@ _19, unit
	movs	r7, r0	@ ivtmp.372, unit
	movs	r4, r5	@ <retval>, <retval>
	adds	r3, r3, #40	@ _19,
	str	r3, [sp, #12]	@ _19, %sfp
	adds	r7, r7, #30	@ ivtmp.372,
.L294:
@ RangeDisplay.c:14: 		for ( int i = 0 ; i < 5 && unit->items[i] ; i++ )
	ldrh	r1, [r7]	@ _10, MEM[(short unsigned int *)_38]
@ RangeDisplay.c:14: 		for ( int i = 0 ; i < 5 && unit->items[i] ; i++ )
	cmp	r1, #0	@ _10,
	beq	.L296		@,
@ RangeDisplay.c:16: 			if ( usability(unit,unit->items[i]) )
	movs	r0, r6	@, unit
	ldr	r3, [sp, #8]	@ usability, %sfp
	bl	.L14		@
@ RangeDisplay.c:16: 			if ( usability(unit,unit->items[i]) )
	cmp	r0, #0	@ tmp150,
	beq	.L295		@,
@ RangeDisplay.c:18: 				current = IncorporateNewRange(current,gGet_Item_Range(unit,unit->items[i]));
	ldr	r3, .L305	@ tmp137,
	movs	r0, r6	@, unit
	ldr	r3, [r3]	@ gGet_Item_Range, gGet_Item_Range
	ldrh	r1, [r7]	@ MEM[(short unsigned int *)_38], MEM[(short unsigned int *)_38]
	bl	.L14		@
	movs	r2, r0	@ _9, tmp163
	movs	r3, r1	@ _9, tmp164
	movs	r0, r5	@, <retval>
	movs	r1, r4	@, <retval>
	bl	IncorporateNewRange		@
	movs	r5, r0	@ <retval>, tmp165
	movs	r4, r1	@ <retval>, tmp166
.L295:
@ RangeDisplay.c:14: 		for ( int i = 0 ; i < 5 && unit->items[i] ; i++ )
	ldr	r3, [sp, #12]	@ _19, %sfp
	adds	r7, r7, #2	@ ivtmp.372,
	cmp	r7, r3	@ ivtmp.372, _19
	bne	.L294		@,
.L296:
@ RangeDisplay.c:21: 		return ( slot == -1 ? IncorporateNewRange(current,GetUnitRangeMaskForSpells(unit,usability)) : current );
	ldr	r3, [sp, #4]	@ slot, %sfp
	adds	r3, r3, #1	@ tmp176, slot,
	bne	.L292		@,
@ RangeDisplay.c:21: 		return ( slot == -1 ? IncorporateNewRange(current,GetUnitRangeMaskForSpells(unit,usability)) : current );
	movs	r0, r6	@, unit
	ldr	r1, [sp, #8]	@, %sfp
	bl	GetUnitRangeMaskForSpells		@
	movs	r2, r0	@ _11, tmp167
	movs	r3, r1	@ _11, tmp168
	movs	r0, r5	@, <retval>
	movs	r1, r4	@, <retval>
	bl	IncorporateNewRange		@
.L304:
@ RangeDisplay.c:33: 			return GetUnitRangeMaskForSpells(unit,usability);
	movs	r5, r0	@ <retval>, tmp173
	movs	r4, r1	@ <retval>, tmp174
.L292:
@ RangeDisplay.c:36: }
	movs	r0, r5	@, <retval>
	movs	r1, r4	@, <retval>
	add	sp, sp, #20	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7}
	pop	{r2}
	bx	r2
.L293:
@ RangeDisplay.c:26: 		if ( slot != 9 )
	ldr	r3, [sp, #4]	@ slot, %sfp
	cmp	r3, #9	@ slot,
	beq	.L299		@,
@ RangeDisplay.c:28: 			return gGet_Item_Range(unit,unit->items[slot]);
	adds	r3, r3, #12	@ slot,
	lsls	r3, r3, #1	@ tmp140, tmp139,
	adds	r3, r0, r3	@ tmp141, unit, tmp140
@ RangeDisplay.c:28: 			return gGet_Item_Range(unit,unit->items[slot]);
	ldrh	r1, [r3, #6]	@ tmp143, *unit_26(D)
	ldr	r3, .L305	@ tmp144,
	ldr	r3, [r3]	@ gGet_Item_Range, gGet_Item_Range
	bl	.L14		@
	b	.L304		@
.L299:
@ RangeDisplay.c:33: 			return GetUnitRangeMaskForSpells(unit,usability);
	ldr	r1, [sp, #8]	@, %sfp
	bl	GetUnitRangeMaskForSpells		@
	b	.L304		@
.L306:
	.align	2
.L305:
	.word	gGet_Item_Range
	.size	Return_Range_Bitfield, .-Return_Range_Bitfield
	.align	1
	.global	All_Spells_One_Square
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
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
	ldr	r4, .L308	@ tmp123,
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
.L309:
	.align	2
.L308:
	.word	gWrite_Range
	.size	All_Spells_One_Square, .-All_Spells_One_Square
	.align	1
	.global	GaidenBlackMagicUMHover
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	GaidenBlackMagicUMHover, %function
GaidenBlackMagicUMHover:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ UnitMenu.c:109: 	UsingSpellMenu = BLACK_MAGIC;
	movs	r5, #1	@ tmp122,
	ldr	r3, .L314	@ tmp121,
	strb	r5, [r3]	@ tmp122, UsingSpellMenu
@ UnitMenu.c:110: 	BmMapFill(gMapMovement,-1);
	ldr	r3, .L314+4	@ tmp124,
	ldr	r4, .L314+8	@ tmp125,
	ldr	r0, [r3]	@, gMapMovement
	movs	r1, #255	@,
	bl	.L16		@
@ UnitMenu.c:111: 	BmMapFill(gMapRange,0);
	ldr	r3, .L314+12	@ tmp126,
	movs	r1, #0	@,
	ldr	r0, [r3]	@, gMapRange
	bl	.L16		@
@ UnitMenu.c:112: 	if ( CanUseAttackSpellsNow(gActiveUnit,BLACK_MAGIC) ) // If we can use an attack spell now, display the red range.
	ldr	r4, .L314+16	@ tmp128,
	movs	r1, r5	@, tmp122
	ldr	r0, [r4]	@, gActiveUnit
	bl	CanUseAttackSpellsNow		@
	ldr	r5, .L314+20	@ tmp136,
@ UnitMenu.c:112: 	if ( CanUseAttackSpellsNow(gActiveUnit,BLACK_MAGIC) ) // If we can use an attack spell now, display the red range.
	cmp	r0, #0	@ tmp137,
	beq	.L311		@,
@ UnitMenu.c:114: 		All_Spells_One_Square(gActiveUnit,&RangeUsabilityCheckNotStaff);
	ldr	r0, [r4]	@, gActiveUnit
	ldr	r1, .L314+24	@ tmp129,
	bl	All_Spells_One_Square		@
@ UnitMenu.c:115: 		DisplayMoveRangeGraphics(3);
	movs	r0, #3	@,
.L313:
@ UnitMenu.c:126: }
	@ sp needed	@
@ UnitMenu.c:120: 		DisplayMoveRangeGraphics(5);
	bl	.L316		@
@ UnitMenu.c:126: }
	movs	r0, #0	@,
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L311:
@ UnitMenu.c:119: 		All_Spells_One_Square(gActiveUnit,&RangeUsabilityCheckStaff);
	ldr	r0, [r4]	@, gActiveUnit
	ldr	r1, .L314+28	@ tmp132,
	bl	All_Spells_One_Square		@
@ UnitMenu.c:120: 		DisplayMoveRangeGraphics(5);
	movs	r0, #5	@,
	b	.L313		@
.L315:
	.align	2
.L314:
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
	.fpu softvfp
	.type	GaidenWhiteMagicUMHover, %function
GaidenWhiteMagicUMHover:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ UnitMenu.c:130: 	UsingSpellMenu = WHITE_MAGIC;
	movs	r5, #2	@ tmp122,
	ldr	r3, .L321	@ tmp121,
	strb	r5, [r3]	@ tmp122, UsingSpellMenu
@ UnitMenu.c:131: 	BmMapFill(gMapMovement,-1);
	ldr	r3, .L321+4	@ tmp124,
	ldr	r4, .L321+8	@ tmp125,
	ldr	r0, [r3]	@, gMapMovement
	movs	r1, #255	@,
	bl	.L16		@
@ UnitMenu.c:132: 	BmMapFill(gMapRange,0);
	ldr	r3, .L321+12	@ tmp126,
	movs	r1, #0	@,
	ldr	r0, [r3]	@, gMapRange
	bl	.L16		@
@ UnitMenu.c:133: 	if ( CanUseAttackSpellsNow(gActiveUnit,WHITE_MAGIC) ) // If we can use an attack spell now, display the red range.
	ldr	r4, .L321+16	@ tmp128,
	movs	r1, r5	@, tmp122
	ldr	r0, [r4]	@, gActiveUnit
	bl	CanUseAttackSpellsNow		@
	ldr	r5, .L321+20	@ tmp136,
@ UnitMenu.c:133: 	if ( CanUseAttackSpellsNow(gActiveUnit,WHITE_MAGIC) ) // If we can use an attack spell now, display the red range.
	cmp	r0, #0	@ tmp137,
	beq	.L318		@,
@ UnitMenu.c:135: 		All_Spells_One_Square(gActiveUnit,&RangeUsabilityCheckNotStaff);
	ldr	r0, [r4]	@, gActiveUnit
	ldr	r1, .L321+24	@ tmp129,
	bl	All_Spells_One_Square		@
@ UnitMenu.c:136: 		DisplayMoveRangeGraphics(3);
	movs	r0, #3	@,
.L320:
@ UnitMenu.c:144: }
	@ sp needed	@
@ UnitMenu.c:141: 		DisplayMoveRangeGraphics(5);
	bl	.L316		@
@ UnitMenu.c:144: }
	movs	r0, #0	@,
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L318:
@ UnitMenu.c:140: 		All_Spells_One_Square(gActiveUnit,&RangeUsabilityCheckStaff);
	ldr	r0, [r4]	@, gActiveUnit
	ldr	r1, .L321+28	@ tmp132,
	bl	All_Spells_One_Square		@
@ UnitMenu.c:141: 		DisplayMoveRangeGraphics(5);
	movs	r0, #5	@,
	b	.L320		@
.L322:
	.align	2
.L321:
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
	.fpu softvfp
	.type	SpellUsability, %function
SpellUsability:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, lr}	@
@ SpellMenu.c:5: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,index,UsingSpellMenu)];
	ldr	r7, .L331	@ tmp134,
	ldr	r4, .L331+4	@ tmp136,
@ SpellMenu.c:4: {
	movs	r6, r1	@ index, tmp148
@ SpellMenu.c:5: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,index,UsingSpellMenu)];
	ldr	r0, [r4]	@, gActiveUnit
	ldrb	r1, [r7]	@ UsingSpellMenu, UsingSpellMenu
	bl	SpellsGetter		@
@ SpellMenu.c:5: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,index,UsingSpellMenu)];
	movs	r1, r6	@, index
@ SpellMenu.c:5: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,index,UsingSpellMenu)];
	movs	r5, r0	@ _4, tmp149
@ SpellMenu.c:5: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,index,UsingSpellMenu)];
	ldrb	r2, [r7]	@ UsingSpellMenu, UsingSpellMenu
	ldr	r0, [r4]	@, gActiveUnit
	bl	GetNthUsableSpell		@
@ SpellMenu.c:5: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,index,UsingSpellMenu)];
	ldrb	r5, [r5, r0]	@ spell, *_10
@ SpellMenu.c:6: 	if ( !spell ) { return 3; }
	cmp	r5, #0	@ spell,
	bne	.L324		@,
.L326:
@ SpellMenu.c:6: 	if ( !spell ) { return 3; }
	movs	r0, #3	@ <retval>,
.L323:
@ SpellMenu.c:14: }
	@ sp needed	@
	pop	{r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L324:
@ SpellMenu.c:8: 	if ( !CanCastSpellNow(gActiveUnit,spell) ) { return 3; }
	movs	r1, r5	@, spell
	ldr	r0, [r4]	@, gActiveUnit
	bl	CanCastSpellNow		@
@ SpellMenu.c:8: 	if ( !CanCastSpellNow(gActiveUnit,spell) ) { return 3; }
	cmp	r0, #0	@ tmp151,
	beq	.L326		@,
@ SpellMenu.c:10: 	u8 HasEnoughHp = HasSufficientHP(gActiveUnit,spell);
	movs	r1, r5	@, spell
	ldr	r0, [r4]	@, gActiveUnit
	bl	HasSufficientHP		@
@ SpellMenu.c:11: 	if (HasEnoughHp) { return 1; }
	lsls	r0, r0, #24	@ tmp143, tmp152,
	lsrs	r0, r0, #24	@ tmp143, tmp143,
@ SpellMenu.c:11: 	if (HasEnoughHp) { return 1; }
	rsbs	r3, r0, #0	@ tmp147, tmp143
	adcs	r0, r0, r3	@ tmp146, tmp143, tmp147
	adds	r0, r0, #1	@ <retval>,
	b	.L323		@
.L332:
	.align	2
.L331:
	.word	UsingSpellMenu
	.word	gActiveUnit
	.size	SpellUsability, .-SpellUsability
	.align	1
	.global	SpellDrawingRoutine
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	SpellDrawingRoutine, %function
SpellDrawingRoutine:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, lr}	@
@ SpellMenu.c:17: {
	movs	r4, r1	@ menuCommand, tmp167
@ SpellMenu.c:25: }
	@ sp needed	@
@ SpellMenu.c:19: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,menuCommand->commandDefinitionIndex,UsingSpellMenu)];
	ldr	r6, .L334	@ tmp145,
	ldr	r7, .L334+4	@ tmp143,
	ldr	r0, [r6]	@, gActiveUnit
	ldrb	r1, [r7]	@ UsingSpellMenu, UsingSpellMenu
	bl	SpellsGetter		@
@ SpellMenu.c:19: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,menuCommand->commandDefinitionIndex,UsingSpellMenu)];
	movs	r3, r4	@ tmp150, menuCommand
	adds	r3, r3, #60	@ tmp150,
@ SpellMenu.c:19: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,menuCommand->commandDefinitionIndex,UsingSpellMenu)];
	ldrb	r2, [r7]	@ UsingSpellMenu, UsingSpellMenu
	ldrb	r1, [r3]	@ tmp151,
@ SpellMenu.c:19: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,menuCommand->commandDefinitionIndex,UsingSpellMenu)];
	movs	r5, r0	@ _4, tmp168
@ SpellMenu.c:19: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,menuCommand->commandDefinitionIndex,UsingSpellMenu)];
	ldr	r0, [r6]	@, gActiveUnit
	bl	GetNthUsableSpell		@
@ SpellMenu.c:19: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,menuCommand->commandDefinitionIndex,UsingSpellMenu)];
	ldrb	r5, [r5, r0]	@ _13, *_12
@ SpellMenu.c:21: 	int canUse = HasSufficientHP(gActiveUnit,spell);
	ldr	r0, [r6]	@, gActiveUnit
	movs	r1, r5	@, _13
	bl	HasSufficientHP		@
	movs	r2, r0	@ canUse, tmp170
@ SpellMenu.c:22: 	DrawItemMenuCommand(&menuCommand->text,spell,canUse,&gBg0MapBuffer[menuCommand->yDrawTile * 32 + menuCommand->xDrawTile]);
	movs	r0, r4	@ menuCommand, menuCommand
@ SpellMenu.c:22: 	DrawItemMenuCommand(&menuCommand->text,spell,canUse,&gBg0MapBuffer[menuCommand->yDrawTile * 32 + menuCommand->xDrawTile]);
	ldrh	r3, [r4, #44]	@ tmp154,
@ SpellMenu.c:22: 	DrawItemMenuCommand(&menuCommand->text,spell,canUse,&gBg0MapBuffer[menuCommand->yDrawTile * 32 + menuCommand->xDrawTile]);
	ldrh	r1, [r4, #42]	@ tmp156,
@ SpellMenu.c:22: 	DrawItemMenuCommand(&menuCommand->text,spell,canUse,&gBg0MapBuffer[menuCommand->yDrawTile * 32 + menuCommand->xDrawTile]);
	lsls	r3, r3, #5	@ tmp155, tmp154,
@ SpellMenu.c:22: 	DrawItemMenuCommand(&menuCommand->text,spell,canUse,&gBg0MapBuffer[menuCommand->yDrawTile * 32 + menuCommand->xDrawTile]);
	adds	r3, r3, r1	@ tmp157, tmp155, tmp156
@ SpellMenu.c:22: 	DrawItemMenuCommand(&menuCommand->text,spell,canUse,&gBg0MapBuffer[menuCommand->yDrawTile * 32 + menuCommand->xDrawTile]);
	ldr	r1, .L334+8	@ tmp160,
	lsls	r3, r3, #1	@ tmp158, tmp157,
	adds	r3, r3, r1	@ tmp159, tmp158, tmp160
	ldr	r4, .L334+12	@ tmp164,
	movs	r1, r5	@ tmp161, _13
@ SpellMenu.c:22: 	DrawItemMenuCommand(&menuCommand->text,spell,canUse,&gBg0MapBuffer[menuCommand->yDrawTile * 32 + menuCommand->xDrawTile]);
	adds	r0, r0, #52	@ menuCommand,
@ SpellMenu.c:22: 	DrawItemMenuCommand(&menuCommand->text,spell,canUse,&gBg0MapBuffer[menuCommand->yDrawTile * 32 + menuCommand->xDrawTile]);
	bl	.L16		@
@ SpellMenu.c:23: 	EnableBgSyncByMask(1);
	movs	r0, #1	@,
	ldr	r3, .L334+16	@ tmp165,
	bl	.L14		@
@ SpellMenu.c:25: }
	movs	r0, #0	@,
	pop	{r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L335:
	.align	2
.L334:
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
	.fpu softvfp
	.type	MagicMenuBPress, %function
MagicMenuBPress:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
@ SpellMenu.c:33: 	Unit* unit = gActiveUnit;
	ldr	r3, .L337	@ tmp126,
	ldr	r2, [r3]	@ unit, gActiveUnit
@ SpellMenu.c:34: 	unit->state &= ~(1UL << 30); // Always clear capturing bit if leaving menu 
	ldr	r1, .L337+4	@ tmp129,
	ldr	r3, [r2, #12]	@ unit_13->state, unit_13->state
	ands	r3, r1	@ tmp127, tmp129
@ SpellMenu.c:30: {
	push	{r4, lr}	@
@ SpellMenu.c:37: 	FillBgMap(gBg2MapBuffer,0);
	movs	r1, #0	@,
@ SpellMenu.c:46: }
	@ sp needed	@
@ SpellMenu.c:34: 	unit->state &= ~(1UL << 30); // Always clear capturing bit if leaving menu 
	str	r3, [r2, #12]	@ tmp127, unit_13->state
@ SpellMenu.c:37: 	FillBgMap(gBg2MapBuffer,0);
	ldr	r0, .L337+8	@ tmp130,
	ldr	r3, .L337+12	@ tmp131,
	bl	.L14		@
@ SpellMenu.c:38: 	EnableBgSyncByMask(4);
	movs	r0, #4	@,
	ldr	r3, .L337+16	@ tmp132,
	bl	.L14		@
@ SpellMenu.c:39: 	Text_ResetTileAllocation();
	ldr	r3, .L337+20	@ tmp133,
	bl	.L14		@
@ SpellMenu.c:41: 	StartMenu_AndDoSomethingCommands(&gMenu_UnitMenu,gGameState._unk1C.x - gGameState.cameraRealPos.x, UnitMenuLeft, UnitMenuRight);
	ldr	r0, .L337+24	@ tmp138,
@ SpellMenu.c:41: 	StartMenu_AndDoSomethingCommands(&gMenu_UnitMenu,gGameState._unk1C.x - gGameState.cameraRealPos.x, UnitMenuLeft, UnitMenuRight);
	ldr	r3, .L337+28	@ tmp134,
@ SpellMenu.c:41: 	StartMenu_AndDoSomethingCommands(&gMenu_UnitMenu,gGameState._unk1C.x - gGameState.cameraRealPos.x, UnitMenuLeft, UnitMenuRight);
	ldrh	r1, [r0, #28]	@ tmp139,
@ SpellMenu.c:41: 	StartMenu_AndDoSomethingCommands(&gMenu_UnitMenu,gGameState._unk1C.x - gGameState.cameraRealPos.x, UnitMenuLeft, UnitMenuRight);
	ldr	r2, .L337+32	@ tmp136,
@ SpellMenu.c:41: 	StartMenu_AndDoSomethingCommands(&gMenu_UnitMenu,gGameState._unk1C.x - gGameState.cameraRealPos.x, UnitMenuLeft, UnitMenuRight);
	ldrh	r0, [r0, #12]	@ tmp141,
@ SpellMenu.c:41: 	StartMenu_AndDoSomethingCommands(&gMenu_UnitMenu,gGameState._unk1C.x - gGameState.cameraRealPos.x, UnitMenuLeft, UnitMenuRight);
	ldrb	r2, [r2]	@ UnitMenuLeft, UnitMenuLeft
	subs	r1, r1, r0	@ tmp142, tmp139, tmp141
	ldrb	r3, [r3]	@ UnitMenuRight, UnitMenuRight
	ldr	r4, .L337+36	@ tmp144,
	ldr	r0, .L337+40	@ tmp143,
	bl	.L16		@
@ SpellMenu.c:42: 	HideMoveRangeGraphics();
	ldr	r3, .L337+44	@ tmp145,
	bl	.L14		@
@ SpellMenu.c:43: 	SelectedSpell = 0;
	movs	r2, #0	@ tmp147,
	ldr	r3, .L337+48	@ tmp146,
	strb	r2, [r3]	@ tmp147, SelectedSpell
@ SpellMenu.c:44: 	UsingSpellMenu = 0;
	ldr	r3, .L337+52	@ tmp149,
@ SpellMenu.c:46: }
	movs	r0, #59	@,
@ SpellMenu.c:44: 	UsingSpellMenu = 0;
	strb	r2, [r3]	@ tmp147, UsingSpellMenu
@ SpellMenu.c:46: }
	pop	{r4}
	pop	{r1}
	bx	r1
.L338:
	.align	2
.L337:
	.word	gActiveUnit
	.word	-1073741825
	.word	gBg2MapBuffer
	.word	FillBgMap
	.word	EnableBgSyncByMask
	.word	Text_ResetTileAllocation
	.word	gGameState
	.word	UnitMenuRight
	.word	UnitMenuLeft
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
	.fpu softvfp
	.type	SpellEffectRoutine, %function
SpellEffectRoutine:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, lr}	@
@ SpellMenu.c:50: 	if ( commandProc->availability == 2)
	adds	r1, r1, #61	@ tmp140,
@ SpellMenu.c:50: 	if ( commandProc->availability == 2)
	ldrb	r3, [r1]	@ tmp141,
	cmp	r3, #2	@ tmp141,
	bne	.L340		@,
@ SpellMenu.c:53: 		MenuCallHelpBox(proc,gGaidenMagicSpellMenuErrorText);
	ldr	r3, .L348	@ tmp142,
	ldrh	r1, [r3]	@ gGaidenMagicSpellMenuErrorText, gGaidenMagicSpellMenuErrorText
	ldr	r3, .L348+4	@ tmp144,
	bl	.L14		@
@ SpellMenu.c:54: 		return 0x08;
	movs	r0, #8	@ <retval>,
.L339:
@ SpellMenu.c:107: }
	@ sp needed	@
	pop	{r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L340:
@ SpellMenu.c:58: 		Unit* unit = gActiveUnit;
	ldr	r4, .L348+8	@ tmp145,
	ldr	r3, [r4]	@ unit, gActiveUnit
@ SpellMenu.c:59: 		if ( unit->ranks[0] != SelectedSpell) 
	movs	r6, r3	@ tmp148, unit
@ SpellMenu.c:59: 		if ( unit->ranks[0] != SelectedSpell) 
	ldr	r5, .L348+12	@ tmp149,
@ SpellMenu.c:59: 		if ( unit->ranks[0] != SelectedSpell) 
	adds	r6, r6, #40	@ tmp148,
	ldrb	r0, [r6]	@ _3,
@ SpellMenu.c:59: 		if ( unit->ranks[0] != SelectedSpell) 
	ldrb	r1, [r5]	@ SelectedSpell.96_4, SelectedSpell
@ SpellMenu.c:59: 		if ( unit->ranks[0] != SelectedSpell) 
	cmp	r0, r1	@ _3, SelectedSpell.96_4
	beq	.L342		@,
	movs	r2, r3	@ ivtmp.402, unit
	adds	r3, r3, #45	@ _47,
	adds	r2, r2, #41	@ ivtmp.402,
.L344:
@ SpellMenu.c:64: 			if (unit->ranks[i] == SelectedSpell) 
	ldrb	r7, [r2]	@ MEM[(unsigned char *)_40], MEM[(unsigned char *)_40]
	cmp	r7, r1	@ MEM[(unsigned char *)_40], SelectedSpell.96_4
	bne	.L343		@,
@ SpellMenu.c:66: 			unit->ranks[i] = PreviousSelection;
	strb	r0, [r2]	@ _3, MEM[(unsigned char *)_40]
@ SpellMenu.c:67: 			unit->ranks[0] = SelectedSpell;
	strb	r1, [r6]	@ SelectedSpell.96_4, unit_25->ranks[0]
.L343:
@ SpellMenu.c:62: 		for ( int i = 1 ; i < 5 ; i++ ) 
	adds	r2, r2, #1	@ ivtmp.402,
	cmp	r2, r3	@ ivtmp.402, _47
	bne	.L344		@,
.L342:
@ SpellMenu.c:88: 		gActionData.itemSlotIndex = 0;
	movs	r2, #0	@ tmp157,
	ldr	r3, .L348+16	@ tmp156,
	strb	r2, [r3, #18]	@ tmp157, gActionData.itemSlotIndex
@ SpellMenu.c:89: 		DidSelectSpell = 1;
	ldr	r3, .L348+20	@ tmp159,
	adds	r2, r2, #1	@ tmp160,
	strb	r2, [r3]	@ tmp160, DidSelectSpell
@ SpellMenu.c:90: 		ClearBG0BG1();
	ldr	r3, .L348+24	@ tmp162,
	bl	.L14		@
@ SpellMenu.c:91: 		int type = GetItemType(SelectedSpell);
	ldr	r3, .L348+28	@ tmp165,
	ldrb	r0, [r5]	@ SelectedSpell, SelectedSpell
	bl	.L14		@
	movs	r1, #255	@ tmp185,
	ldrb	r3, [r5]	@ SelectedSpell, SelectedSpell
	lsls	r1, r1, #8	@ tmp185, tmp185,
@ SpellMenu.c:98: 			MakeTargetListForWeapon(gActiveUnit,SelectedSpell|0xFF00);
	orrs	r1, r3	@ tmp168, SelectedSpell
@ SpellMenu.c:92: 		if ( type != ITYPE_STAFF )
	cmp	r0, #4	@ tmp188,
	beq	.L345		@,
@ SpellMenu.c:98: 			MakeTargetListForWeapon(gActiveUnit,SelectedSpell|0xFF00);
	ldr	r0, [r4]	@, gActiveUnit
	ldr	r3, .L348+32	@ tmp171,
	bl	.L14		@
@ SpellMenu.c:99: 			StartTargetSelection(&SpellTargetSelection);
	ldr	r0, .L348+36	@ tmp172,
	ldr	r3, .L348+40	@ tmp173,
	bl	.L14		@
.L347:
@ SpellMenu.c:105: 		return 0x27;
	movs	r0, #39	@ <retval>,
	b	.L339		@
.L345:
@ SpellMenu.c:103: 			ItemEffect_Call(gActiveUnit,SelectedSpell|0xFF00);
	ldr	r0, [r4]	@, gActiveUnit
	ldr	r3, .L348+44	@ tmp179,
	bl	.L14		@
	b	.L347		@
.L349:
	.align	2
.L348:
	.word	gGaidenMagicSpellMenuErrorText
	.word	MenuCallHelpBox
	.word	gActiveUnit
	.word	SelectedSpell
	.word	gActionData
	.word	DidSelectSpell
	.word	ClearBG0BG1
	.word	GetItemType
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
	.fpu softvfp
	.type	SpellOnHover, %function
SpellOnHover:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}	@
@ SpellMenu.c:111: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,proc->commandIndex,UsingSpellMenu)];
	ldr	r7, .L363	@ tmp199,
	ldr	r6, .L363+4	@ tmp201,
@ SpellMenu.c:110: {
	sub	sp, sp, #36	@,,
@ SpellMenu.c:111: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,proc->commandIndex,UsingSpellMenu)];
	ldrb	r1, [r7]	@ UsingSpellMenu, UsingSpellMenu
@ SpellMenu.c:110: {
	movs	r4, r0	@ proc, tmp347
@ SpellMenu.c:111: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,proc->commandIndex,UsingSpellMenu)];
	ldr	r0, [r6]	@, gActiveUnit
	bl	SpellsGetter		@
@ SpellMenu.c:111: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,proc->commandIndex,UsingSpellMenu)];
	adds	r4, r4, #97	@ tmp206,
@ SpellMenu.c:111: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,proc->commandIndex,UsingSpellMenu)];
	ldrb	r2, [r7]	@ UsingSpellMenu, UsingSpellMenu
	ldrb	r1, [r4]	@ tmp207,
@ SpellMenu.c:111: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,proc->commandIndex,UsingSpellMenu)];
	movs	r5, r0	@ _4, tmp348
@ SpellMenu.c:111: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,proc->commandIndex,UsingSpellMenu)];
	ldr	r0, [r6]	@, gActiveUnit
	bl	GetNthUsableSpell		@
@ SpellMenu.c:112: 	SelectedSpell = spell;
	ldr	r3, .L363+8	@ tmp209,
@ SpellMenu.c:111: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,proc->commandIndex,UsingSpellMenu)];
	ldrb	r4, [r5, r0]	@ spell, *_12
@ SpellMenu.c:130: 	MenuItemPanelProc* menuItemPanel = (MenuItemPanelProc*)ProcFind(&gProc_MenuItemPanel);
	ldr	r0, .L363+12	@ tmp211,
@ SpellMenu.c:112: 	SelectedSpell = spell;
	strb	r4, [r3]	@ spell, SelectedSpell
@ SpellMenu.c:130: 	MenuItemPanelProc* menuItemPanel = (MenuItemPanelProc*)ProcFind(&gProc_MenuItemPanel);
	ldr	r3, .L363+16	@ tmp212,
	bl	.L14		@
@ SpellMenu.c:131: 	int x = menuItemPanel->x;
	movs	r3, r0	@ tmp215, tmp350
@ SpellMenu.c:130: 	MenuItemPanelProc* menuItemPanel = (MenuItemPanelProc*)ProcFind(&gProc_MenuItemPanel);
	str	r0, [sp, #8]	@ tmp350, %sfp
@ SpellMenu.c:131: 	int x = menuItemPanel->x;
	adds	r3, r3, #48	@ tmp215,
	ldrb	r3, [r3]	@ _14,
	str	r3, [sp, #24]	@ _14, %sfp
@ SpellMenu.c:132: 	int y = menuItemPanel->y;
	movs	r3, r0	@ tmp218, tmp350
	adds	r3, r3, #49	@ tmp218,
@ SpellMenu.c:132: 	int y = menuItemPanel->y;
	ldrb	r3, [r3]	@ y,
	str	r3, [sp, #28]	@ y, %sfp
@ SpellMenu.c:136: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Clear(&menuItemPanel->textHandles[i]); }
	movs	r3, r0	@ _137, tmp350
	adds	r3, r3, #52	@ _137,
@ SpellMenu.c:136: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Clear(&menuItemPanel->textHandles[i]); }
	ldr	r5, .L363+20	@ tmp219,
	movs	r0, r3	@, _137
@ SpellMenu.c:136: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Clear(&menuItemPanel->textHandles[i]); }
	str	r3, [sp, #12]	@ _137, %sfp
@ SpellMenu.c:136: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Clear(&menuItemPanel->textHandles[i]); }
	bl	.L316		@
@ SpellMenu.c:136: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Clear(&menuItemPanel->textHandles[i]); }
	ldr	r3, [sp, #8]	@ _142, %sfp
	adds	r3, r3, #60	@ _142,
@ SpellMenu.c:136: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Clear(&menuItemPanel->textHandles[i]); }
	movs	r0, r3	@, _142
@ SpellMenu.c:136: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Clear(&menuItemPanel->textHandles[i]); }
	str	r3, [sp, #16]	@ _142, %sfp
@ SpellMenu.c:136: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Clear(&menuItemPanel->textHandles[i]); }
	bl	.L316		@
@ SpellMenu.c:136: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Clear(&menuItemPanel->textHandles[i]); }
	ldr	r7, [sp, #8]	@ _147, %sfp
	adds	r7, r7, #68	@ _147,
@ SpellMenu.c:136: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Clear(&menuItemPanel->textHandles[i]); }
	movs	r0, r7	@, _147
	bl	.L316		@
@ SpellMenu.c:137: 	MakeUIWindowTileMap_BG0BG1(x,y,14,8,0);
	movs	r3, #0	@ tmp401,
	movs	r2, #14	@,
	str	r3, [sp]	@ tmp401,
	ldr	r1, [sp, #28]	@, %sfp
	ldr	r0, [sp, #24]	@, %sfp
	adds	r3, r3, #8	@,
	ldr	r5, .L363+24	@ tmp223,
	bl	.L316		@
@ SpellMenu.c:139: 	int spellType = GetItemType(spell);
	movs	r0, r4	@, spell
	ldr	r3, .L363+28	@ tmp224,
	bl	.L14		@
	str	r0, [sp, #20]	@ tmp351, %sfp
@ SpellMenu.c:140: 	if ( spellType != ITYPE_STAFF )
	cmp	r0, #4	@ spellType,
	bne	.LCB2273	@
	b	.L351	@long jump	@
.LCB2273:
@ SpellMenu.c:142: 		BattleGenerateUiStats(gActiveUnit,9); // 9 is using a Gaiden spell.
	movs	r1, #9	@,
	ldr	r0, [r6]	@, gActiveUnit
	ldr	r3, .L363+32	@ tmp226,
	bl	.L14		@
@ SpellMenu.c:144: 		Text_InsertString(&menuItemPanel->textHandles[0],0x02,0,GetStringFromIndex(0x0039)); // "Stats"
	ldr	r3, .L363+36	@ tmp227,
	movs	r0, #57	@,
	movs	r5, r3	@ tmp227, tmp227
	bl	.L14		@
@ SpellMenu.c:144: 		Text_InsertString(&menuItemPanel->textHandles[0],0x02,0,GetStringFromIndex(0x0039)); // "Stats"
	movs	r2, #0	@,
@ SpellMenu.c:144: 		Text_InsertString(&menuItemPanel->textHandles[0],0x02,0,GetStringFromIndex(0x0039)); // "Stats"
	movs	r3, r0	@ _19, tmp352
@ SpellMenu.c:144: 		Text_InsertString(&menuItemPanel->textHandles[0],0x02,0,GetStringFromIndex(0x0039)); // "Stats"
	movs	r1, #2	@,
	ldr	r0, [sp, #12]	@, %sfp
	ldr	r6, .L363+40	@ tmp228,
	bl	.L15		@
@ SpellMenu.c:146: 		if (GetSpellCost(spell)>0) { 
	movs	r0, r4	@, spell
	bl	GetSpellCost		@
@ SpellMenu.c:146: 		if (GetSpellCost(spell)>0) { 
	cmp	r0, #0	@ tmp353,
	ble	.L352		@,
@ SpellMenu.c:147: 			Text_InsertString(&menuItemPanel->textHandles[0],0x32,0,GetStringFromIndex(gGaidenMagicHPCostText)); // HP Cost.
	ldr	r3, .L363+44	@ tmp229,
	ldrh	r0, [r3]	@ gGaidenMagicHPCostText, gGaidenMagicHPCostText
	bl	.L316		@
@ SpellMenu.c:147: 			Text_InsertString(&menuItemPanel->textHandles[0],0x32,0,GetStringFromIndex(gGaidenMagicHPCostText)); // HP Cost.
	movs	r2, #0	@,
@ SpellMenu.c:147: 			Text_InsertString(&menuItemPanel->textHandles[0],0x32,0,GetStringFromIndex(gGaidenMagicHPCostText)); // HP Cost.
	movs	r3, r0	@ _24, tmp354
@ SpellMenu.c:147: 			Text_InsertString(&menuItemPanel->textHandles[0],0x32,0,GetStringFromIndex(gGaidenMagicHPCostText)); // HP Cost.
	movs	r1, #50	@,
	ldr	r0, [sp, #12]	@, %sfp
	bl	.L15		@
.L352:
@ SpellMenu.c:149: 		Text_InsertString(&menuItemPanel->textHandles[1],0x02,0,GetStringFromIndex(0x4F3)); // Atk.
	ldr	r6, .L363+36	@ tmp234,
	ldr	r0, .L363+48	@,
	bl	.L15		@
@ SpellMenu.c:149: 		Text_InsertString(&menuItemPanel->textHandles[1],0x02,0,GetStringFromIndex(0x4F3)); // Atk.
	ldr	r5, .L363+40	@ tmp235,
@ SpellMenu.c:149: 		Text_InsertString(&menuItemPanel->textHandles[1],0x02,0,GetStringFromIndex(0x4F3)); // Atk.
	movs	r3, r0	@ _26, tmp355
@ SpellMenu.c:149: 		Text_InsertString(&menuItemPanel->textHandles[1],0x02,0,GetStringFromIndex(0x4F3)); // Atk.
	movs	r2, #0	@,
	movs	r1, #2	@,
	ldr	r0, [sp, #16]	@, %sfp
	bl	.L316		@
@ SpellMenu.c:150: 		Text_InsertString(&menuItemPanel->textHandles[2],0x02,0,GetStringFromIndex(0x4F4)); // Hit.
	ldr	r0, .L363+52	@,
	bl	.L15		@
@ SpellMenu.c:150: 		Text_InsertString(&menuItemPanel->textHandles[2],0x02,0,GetStringFromIndex(0x4F4)); // Hit.
	movs	r2, #0	@,
@ SpellMenu.c:150: 		Text_InsertString(&menuItemPanel->textHandles[2],0x02,0,GetStringFromIndex(0x4F4)); // Hit.
	movs	r3, r0	@ _28, tmp356
@ SpellMenu.c:150: 		Text_InsertString(&menuItemPanel->textHandles[2],0x02,0,GetStringFromIndex(0x4F4)); // Hit.
	movs	r1, #2	@,
	movs	r0, r7	@, _147
	bl	.L316		@
@ SpellMenu.c:151: 		Text_InsertString(&menuItemPanel->textHandles[1],0x32,0,GetStringFromIndex(0x501)); // Crit.
	ldr	r0, .L363+56	@,
	bl	.L15		@
@ SpellMenu.c:151: 		Text_InsertString(&menuItemPanel->textHandles[1],0x32,0,GetStringFromIndex(0x501)); // Crit.
	movs	r2, #0	@,
@ SpellMenu.c:151: 		Text_InsertString(&menuItemPanel->textHandles[1],0x32,0,GetStringFromIndex(0x501)); // Crit.
	movs	r3, r0	@ _29, tmp357
@ SpellMenu.c:151: 		Text_InsertString(&menuItemPanel->textHandles[1],0x32,0,GetStringFromIndex(0x501)); // Crit.
	movs	r1, #50	@,
	ldr	r0, [sp, #16]	@, %sfp
	bl	.L316		@
@ SpellMenu.c:152: 		Text_InsertString(&menuItemPanel->textHandles[2],0x32,0,GetStringFromIndex(0x4F5)); // Avoid.
	ldr	r0, .L363+60	@,
	bl	.L15		@
@ SpellMenu.c:152: 		Text_InsertString(&menuItemPanel->textHandles[2],0x32,0,GetStringFromIndex(0x4F5)); // Avoid.
	movs	r2, #0	@,
@ SpellMenu.c:152: 		Text_InsertString(&menuItemPanel->textHandles[2],0x32,0,GetStringFromIndex(0x4F5)); // Avoid.
	movs	r3, r0	@ _30, tmp358
@ SpellMenu.c:152: 		Text_InsertString(&menuItemPanel->textHandles[2],0x32,0,GetStringFromIndex(0x4F5)); // Avoid.
	movs	r1, #50	@,
	movs	r0, r7	@, _147
	bl	.L316		@
@ SpellMenu.c:155: 		if ( !HasSufficientHP(gActiveUnit,spell) ) { CostColor = 1; }
	ldr	r3, .L363+4	@ tmp245,
	movs	r1, r4	@, spell
	ldr	r0, [r3]	@, gActiveUnit
	bl	HasSufficientHP		@
@ SpellMenu.c:155: 		if ( !HasSufficientHP(gActiveUnit,spell) ) { CostColor = 1; }
	subs	r3, r0, #1	@ tmp335, tmp359
	sbcs	r0, r0, r3	@ tmp359, tmp359, tmp335
	movs	r5, r0	@ tmp334, tmp359
@ SpellMenu.c:156: 		if (GetSpellCost(spell)>0) { Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[0],0x54,CostColor,GetSpellCost(spell)); } 
	movs	r0, r4	@, spell
@ SpellMenu.c:155: 		if ( !HasSufficientHP(gActiveUnit,spell) ) { CostColor = 1; }
	adds	r5, r5, #1	@ CostColor,
@ SpellMenu.c:156: 		if (GetSpellCost(spell)>0) { Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[0],0x54,CostColor,GetSpellCost(spell)); } 
	bl	GetSpellCost		@
@ SpellMenu.c:156: 		if (GetSpellCost(spell)>0) { Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[0],0x54,CostColor,GetSpellCost(spell)); } 
	cmp	r0, #0	@ tmp360,
	ble	.L354		@,
@ SpellMenu.c:156: 		if (GetSpellCost(spell)>0) { Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[0],0x54,CostColor,GetSpellCost(spell)); } 
	movs	r0, r4	@, spell
	bl	GetSpellCost		@
@ SpellMenu.c:156: 		if (GetSpellCost(spell)>0) { Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[0],0x54,CostColor,GetSpellCost(spell)); } 
	lsls	r3, r0, #24	@ tmp246, tmp361,
	movs	r2, r5	@, CostColor
	movs	r1, #84	@,
	ldr	r0, [sp, #12]	@, %sfp
	ldr	r5, .L363+64	@ tmp248,
	lsrs	r3, r3, #24	@ tmp246, tmp246,
	bl	.L316		@
.L354:
@ SpellMenu.c:157: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[1],0x24,2,gBattleActor.battleAttack);
	ldr	r5, .L363+68	@ tmp249,
	movs	r3, r5	@ tmp252, tmp249
	adds	r3, r3, #90	@ tmp252,
@ SpellMenu.c:157: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[1],0x24,2,gBattleActor.battleAttack);
	ldr	r6, .L363+64	@ tmp258,
	movs	r2, #2	@,
	movs	r1, #36	@,
	ldrb	r3, [r3]	@ tmp256,
	ldr	r0, [sp, #16]	@, %sfp
	bl	.L15		@
@ SpellMenu.c:158: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[2],0x24,2,gBattleActor.battleHitRate);
	movs	r3, r5	@ tmp262, tmp249
	adds	r3, r3, #96	@ tmp262,
@ SpellMenu.c:158: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[2],0x24,2,gBattleActor.battleHitRate);
	movs	r2, #2	@,
	movs	r1, #36	@,
	movs	r0, r7	@, _147
	ldrb	r3, [r3]	@ tmp266,
	bl	.L15		@
@ SpellMenu.c:159: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[1],0x54,2,gBattleActor.battleCritRate);
	movs	r3, r5	@ tmp272, tmp249
	adds	r3, r3, #102	@ tmp272,
@ SpellMenu.c:159: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[1],0x54,2,gBattleActor.battleCritRate);
	movs	r2, #2	@,
	movs	r1, #84	@,
	ldrb	r3, [r3]	@ tmp276,
	ldr	r0, [sp, #16]	@, %sfp
@ SpellMenu.c:160: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[2],0x54,2,gBattleActor.battleAvoidRate);
	adds	r5, r5, #98	@ tmp282,
@ SpellMenu.c:159: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[1],0x54,2,gBattleActor.battleCritRate);
	bl	.L15		@
@ SpellMenu.c:160: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[2],0x54,2,gBattleActor.battleAvoidRate);
	movs	r2, #2	@,
	movs	r1, #84	@,
	movs	r0, r7	@, _147
	ldrb	r3, [r5]	@ tmp286,
	bl	.L15		@
.L357:
	ldr	r5, [sp, #28]	@ y, %sfp
	ldr	r3, [sp, #24]	@ _14, %sfp
	adds	r5, r5, #1	@ y,
	adds	r3, r3, #1	@ _14,
	lsls	r5, r5, #5	@ tmp290, tmp289,
	adds	r5, r5, r3	@ tmp292, tmp290, tmp291
	ldr	r6, [sp, #8]	@ ivtmp.412, %sfp
	ldr	r3, .L363+72	@ tmp294,
	ldr	r7, [sp, #8]	@ menuItemPanel, %sfp
	lsls	r5, r5, #1	@ tmp293, tmp292,
	adds	r6, r6, #52	@ ivtmp.412,
	adds	r5, r5, r3	@ ivtmp.414, tmp293, tmp294
	adds	r7, r7, #76	@ menuItemPanel,
.L355:
@ SpellMenu.c:180: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Display(&menuItemPanel->textHandles[i],&gBG0MapBuffer[y+1+2*i][x+1]); }
	movs	r1, r5	@, ivtmp.414
	movs	r0, r6	@, ivtmp.412
	ldr	r3, .L363+76	@ tmp323,
@ SpellMenu.c:180: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Display(&menuItemPanel->textHandles[i],&gBG0MapBuffer[y+1+2*i][x+1]); }
	adds	r6, r6, #8	@ ivtmp.412,
@ SpellMenu.c:180: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Display(&menuItemPanel->textHandles[i],&gBG0MapBuffer[y+1+2*i][x+1]); }
	bl	.L14		@
@ SpellMenu.c:180: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Display(&menuItemPanel->textHandles[i],&gBG0MapBuffer[y+1+2*i][x+1]); }
	adds	r5, r5, #128	@ ivtmp.414,
	cmp	r7, r6	@ _77, ivtmp.412
	bne	.L355		@,
@ SpellMenu.c:192: 	gWrite_Range(gActiveUnit->xPos,gActiveUnit->yPos,gGet_Item_Range(gActiveUnit,spell));
	movs	r6, #16	@ _62,
	movs	r7, #17	@ _64,
@ SpellMenu.c:188: 	BmMapFill(gMapMovement,-1);
	ldr	r3, .L363+80	@ tmp324,
	ldr	r5, .L363+84	@ tmp325,
	ldr	r0, [r3]	@, gMapMovement
	movs	r1, #255	@,
	bl	.L316		@
@ SpellMenu.c:189: 	BmMapFill(gMapRange,0);
	ldr	r3, .L363+88	@ tmp326,
	movs	r1, #0	@,
	ldr	r0, [r3]	@, gMapRange
	bl	.L316		@
@ SpellMenu.c:192: 	gWrite_Range(gActiveUnit->xPos,gActiveUnit->yPos,gGet_Item_Range(gActiveUnit,spell));
	ldr	r3, .L363+92	@ tmp328,
	ldr	r5, [r3]	@ gWrite_Range.113_59, gWrite_Range
@ SpellMenu.c:192: 	gWrite_Range(gActiveUnit->xPos,gActiveUnit->yPos,gGet_Item_Range(gActiveUnit,spell));
	ldr	r3, .L363+4	@ tmp329,
	ldr	r0, [r3]	@ gActiveUnit.114_60, gActiveUnit
@ SpellMenu.c:192: 	gWrite_Range(gActiveUnit->xPos,gActiveUnit->yPos,gGet_Item_Range(gActiveUnit,spell));
	ldr	r3, .L363+96	@ tmp330,
	movs	r1, r4	@, spell
	ldr	r3, [r3]	@ gGet_Item_Range, gGet_Item_Range
	ldrsb	r6, [r0, r6]	@ _62,* _62
	ldrsb	r7, [r0, r7]	@ _64,* _64
	bl	.L14		@
	movs	r2, r0	@ _66, tmp368
	movs	r3, r1	@ _66, tmp369
	movs	r0, r6	@, _62
	movs	r1, r7	@, _64
	bl	.L316		@
@ SpellMenu.c:193: 	DisplayMoveRangeGraphics(( spellType == ITYPE_STAFF ? 4 : 2 )); // See note in UnitMenu.c.
	ldr	r0, [sp, #20]	@ iftmp.118_72, %sfp
	cmp	r0, #4	@ spellType,
	beq	.L358		@,
	movs	r0, #2	@ iftmp.118_72,
.L358:
@ SpellMenu.c:193: 	DisplayMoveRangeGraphics(( spellType == ITYPE_STAFF ? 4 : 2 )); // See note in UnitMenu.c.
	ldr	r3, .L363+100	@ tmp332,
	bl	.L14		@
@ SpellMenu.c:195: }
	movs	r0, #0	@,
	add	sp, sp, #36	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L351:
@ SpellMenu.c:165: 		const char* desc = GetStringFromIndex(GetItemUseDescId(spell));
	ldr	r3, .L363+104	@ tmp295,
	movs	r0, r4	@, spell
	bl	.L14		@
	ldr	r3, .L363+36	@ tmp296,
	bl	.L14		@
	ldr	r6, [sp, #12]	@ ivtmp.419, %sfp
@ SpellMenu.c:167: 		desc--;
	subs	r0, r0, #1	@ desc,
.L356:
@ SpellMenu.c:171: 			Text_InsertString(&menuItemPanel->textHandles[j],0,0,desc);
	movs	r2, #0	@,
@ SpellMenu.c:170: 			desc++;
	adds	r5, r0, #1	@ desc, desc,
@ SpellMenu.c:171: 			Text_InsertString(&menuItemPanel->textHandles[j],0,0,desc);
	movs	r3, r5	@, desc
	movs	r0, r6	@, ivtmp.419
	movs	r1, r2	@,
	ldr	r7, .L363+40	@ tmp297,
	bl	.L265		@
@ SpellMenu.c:172: 			desc = Text_GetStringNextLine(desc);
	ldr	r3, .L363+108	@ tmp298,
	movs	r0, r5	@, desc
	bl	.L14		@
@ SpellMenu.c:174: 		} while ( *desc );
	ldrb	r3, [r0]	@ *desc_99, *desc_99
	adds	r6, r6, #8	@ ivtmp.419,
	cmp	r3, #0	@ *desc_99,
	bne	.L356		@,
@ SpellMenu.c:175: 		gBattleActor.battleAttack = gBattleTarget.battleAttack; // ??? this is something vanilla does???
	ldr	r2, .L363+112	@ tmp301,
@ SpellMenu.c:175: 		gBattleActor.battleAttack = gBattleTarget.battleAttack; // ??? this is something vanilla does???
	ldr	r3, .L363+68	@ tmp300,
@ SpellMenu.c:175: 		gBattleActor.battleAttack = gBattleTarget.battleAttack; // ??? this is something vanilla does???
	movs	r0, r2	@ tmp304, tmp301
@ SpellMenu.c:175: 		gBattleActor.battleAttack = gBattleTarget.battleAttack; // ??? this is something vanilla does???
	movs	r1, r3	@ tmp307, tmp300
@ SpellMenu.c:175: 		gBattleActor.battleAttack = gBattleTarget.battleAttack; // ??? this is something vanilla does???
	adds	r0, r0, #90	@ tmp304,
@ SpellMenu.c:175: 		gBattleActor.battleAttack = gBattleTarget.battleAttack; // ??? this is something vanilla does???
	ldrh	r0, [r0]	@ tmp308,
	adds	r1, r1, #90	@ tmp307,
	strh	r0, [r1]	@ tmp308, gBattleActor.battleAttack
@ SpellMenu.c:177: 		gBattleActor.battleCritRate = gBattleTarget.battleCritRate;
	movs	r0, r2	@ tmp314, tmp301
@ SpellMenu.c:177: 		gBattleActor.battleCritRate = gBattleTarget.battleCritRate;
	movs	r1, r3	@ tmp317, tmp300
@ SpellMenu.c:177: 		gBattleActor.battleCritRate = gBattleTarget.battleCritRate;
	adds	r0, r0, #102	@ tmp314,
@ SpellMenu.c:177: 		gBattleActor.battleCritRate = gBattleTarget.battleCritRate;
	ldrh	r0, [r0]	@ tmp318,
@ SpellMenu.c:176: 		gBattleActor.battleHitRate = gBattleTarget.battleHitRate; // ??? this fixes the green/red arrows from showing on staves???
	ldr	r2, [r2, #96]	@ MEM <unsigned int> [(short int *)&gBattleTarget + 96B], MEM <unsigned int> [(short int *)&gBattleTarget + 96B]
@ SpellMenu.c:177: 		gBattleActor.battleCritRate = gBattleTarget.battleCritRate;
	adds	r1, r1, #102	@ tmp317,
	strh	r0, [r1]	@ tmp318, gBattleActor.battleCritRate
@ SpellMenu.c:176: 		gBattleActor.battleHitRate = gBattleTarget.battleHitRate; // ??? this fixes the green/red arrows from showing on staves???
	str	r2, [r3, #96]	@ MEM <unsigned int> [(short int *)&gBattleTarget + 96B], MEM <unsigned int> [(short int *)&gBattleActor + 96B]
	b	.L357		@
.L364:
	.align	2
.L363:
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
	.word	Text_InsertString
	.word	gGaidenMagicHPCostText
	.word	1267
	.word	1268
	.word	1281
	.word	1269
	.word	Text_InsertNumberOr2Dashes
	.word	gBattleActor
	.word	gBG0MapBuffer
	.word	Text_Display
	.word	gMapMovement
	.word	BmMapFill
	.word	gMapRange
	.word	gWrite_Range
	.word	gGet_Item_Range
	.word	DisplayMoveRangeGraphics
	.word	GetItemUseDescId
	.word	Text_GetStringNextLine
	.word	gBattleTarget
	.size	SpellOnHover, .-SpellOnHover
	.align	1
	.global	SpellOnUnhover
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	SpellOnUnhover, %function
SpellOnUnhover:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ SpellMenu.c:199: 	if ( !DidSelectSpell ) // Don't hide the squares if we're going to the target selection menu.
	ldr	r4, .L367	@ tmp116,
@ SpellMenu.c:199: 	if ( !DidSelectSpell ) // Don't hide the squares if we're going to the target selection menu.
	ldrb	r3, [r4]	@ DidSelectSpell, DidSelectSpell
	cmp	r3, #0	@ DidSelectSpell,
	bne	.L366		@,
@ SpellMenu.c:201: 		HideMoveRangeGraphics();
	ldr	r3, .L367+4	@ tmp118,
	bl	.L14		@
.L366:
@ SpellMenu.c:205: }
	@ sp needed	@
@ SpellMenu.c:203: 	DidSelectSpell = 0; // Unset this variable.
	movs	r0, #0	@ tmp120,
	strb	r0, [r4]	@ tmp120, DidSelectSpell
@ SpellMenu.c:205: }
	pop	{r4}
	pop	{r1}
	bx	r1
.L368:
	.align	2
.L367:
	.word	DidSelectSpell
	.word	HideMoveRangeGraphics
	.size	SpellOnUnhover, .-SpellOnUnhover
	.align	1
	.global	NewMenuRText
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	NewMenuRText, %function
NewMenuRText:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	movs	r3, r1	@ commandProc, tmp173
	push	{r4, r5, r6, r7, lr}	@
@ SpellMenu.c:211: 	if ( UsingSpellMenu )
	ldr	r2, .L374	@ tmp144,
@ SpellMenu.c:209: 	int xTile = commandProc->xDrawTile * 8;
	ldrh	r4, [r1, #42]	@ tmp142,
@ SpellMenu.c:210: 	int yTile = commandProc->yDrawTile * 8;
	ldrh	r5, [r1, #44]	@ tmp143,
@ SpellMenu.c:211: 	if ( UsingSpellMenu )
	ldrb	r1, [r2]	@ UsingSpellMenu.120_5, UsingSpellMenu
@ SpellMenu.c:208: {
	sub	sp, sp, #20	@,,
	adds	r3, r3, #60	@ commandProc,
@ SpellMenu.c:211: 	if ( UsingSpellMenu )
	str	r2, [sp, #4]	@ tmp144, %sfp
	str	r3, [sp, #8]	@ commandProc, %sfp
	ldr	r7, .L374+4	@ tmp172,
@ SpellMenu.c:209: 	int xTile = commandProc->xDrawTile * 8;
	lsls	r4, r4, #3	@ xTile, tmp142,
@ SpellMenu.c:210: 	int yTile = commandProc->yDrawTile * 8;
	lsls	r5, r5, #3	@ yTile, tmp143,
@ SpellMenu.c:211: 	if ( UsingSpellMenu )
	cmp	r1, #0	@ UsingSpellMenu.120_5,
	beq	.L370		@,
@ SpellMenu.c:214: 		DrawItemRText(xTile,yTile,SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,commandProc->commandDefinitionIndex,UsingSpellMenu)]);
	ldr	r6, .L374+8	@ tmp145,
	ldr	r0, [r6]	@, gActiveUnit
	bl	SpellsGetter		@
@ SpellMenu.c:214: 		DrawItemRText(xTile,yTile,SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,commandProc->commandDefinitionIndex,UsingSpellMenu)]);
	ldr	r3, [sp, #4]	@ tmp144, %sfp
@ SpellMenu.c:214: 		DrawItemRText(xTile,yTile,SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,commandProc->commandDefinitionIndex,UsingSpellMenu)]);
	str	r0, [sp, #12]	@ tmp174, %sfp
@ SpellMenu.c:214: 		DrawItemRText(xTile,yTile,SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,commandProc->commandDefinitionIndex,UsingSpellMenu)]);
	ldrb	r2, [r3]	@ UsingSpellMenu, UsingSpellMenu
	ldr	r3, [sp, #8]	@ tmp171, %sfp
	ldr	r0, [r6]	@, gActiveUnit
	ldrb	r1, [r3]	@ tmp151,
	bl	GetNthUsableSpell		@
@ SpellMenu.c:214: 		DrawItemRText(xTile,yTile,SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,commandProc->commandDefinitionIndex,UsingSpellMenu)]);
	ldr	r3, [sp, #12]	@ _8, %sfp
	ldrb	r2, [r3, r0]	@ *_16, *_16
.L373:
@ SpellMenu.c:225: 			DrawItemRText(xTile,yTile,*((u16*)&gGameState+0x16)); // Probably related to special cases like ballistae?
	movs	r1, r5	@, yTile
	movs	r0, r4	@, xTile
	bl	.L265		@
@ SpellMenu.c:228: }
	add	sp, sp, #20	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L370:
@ SpellMenu.c:219: 		if ( commandProc->commandDefinitionIndex <= 4 )
	ldr	r3, [sp, #8]	@ tmp171, %sfp
	ldrb	r3, [r3]	@ _19,
@ SpellMenu.c:219: 		if ( commandProc->commandDefinitionIndex <= 4 )
	cmp	r3, #4	@ _19,
	bhi	.L372		@,
@ SpellMenu.c:221: 			DrawItemRText(xTile,yTile,gActiveUnit->items[commandProc->commandDefinitionIndex]);
	ldr	r2, .L374+8	@ tmp161,
	adds	r3, r3, #12	@ tmp162,
	ldr	r2, [r2]	@ gActiveUnit, gActiveUnit
	lsls	r3, r3, #1	@ tmp163, tmp162,
	adds	r3, r2, r3	@ tmp164, gActiveUnit, tmp163
@ SpellMenu.c:221: 			DrawItemRText(xTile,yTile,gActiveUnit->items[commandProc->commandDefinitionIndex]);
	ldrh	r2, [r3, #6]	@ tmp166, *gActiveUnit.125_20
	b	.L373		@
.L372:
@ SpellMenu.c:225: 			DrawItemRText(xTile,yTile,*((u16*)&gGameState+0x16)); // Probably related to special cases like ballistae?
	ldr	r3, .L374+12	@ tmp168,
@ SpellMenu.c:225: 			DrawItemRText(xTile,yTile,*((u16*)&gGameState+0x16)); // Probably related to special cases like ballistae?
	ldrh	r2, [r3, #44]	@ MEM[(u16 *)&gGameState + 44B], MEM[(u16 *)&gGameState + 44B]
	b	.L373		@
.L375:
	.align	2
.L374:
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
	.fpu softvfp
	.type	NewExitBattleForecast, %function
NewExitBattleForecast:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
@ SpellMenu.c:236: 	if ( UsingSpellMenu == BLACK_MAGIC ) { GaidenBlackMagicUMEffect(NULL,NULL); }
	movs	r1, #0	@,
@ SpellMenu.c:231: {
	push	{r4, lr}	@
@ SpellMenu.c:236: 	if ( UsingSpellMenu == BLACK_MAGIC ) { GaidenBlackMagicUMEffect(NULL,NULL); }
	ldr	r3, .L380	@ tmp115,
	ldrb	r3, [r3]	@ UsingSpellMenu.126_1, UsingSpellMenu
@ SpellMenu.c:236: 	if ( UsingSpellMenu == BLACK_MAGIC ) { GaidenBlackMagicUMEffect(NULL,NULL); }
	movs	r0, r1	@,
@ SpellMenu.c:236: 	if ( UsingSpellMenu == BLACK_MAGIC ) { GaidenBlackMagicUMEffect(NULL,NULL); }
	cmp	r3, #1	@ UsingSpellMenu.126_1,
	bne	.L377		@,
@ SpellMenu.c:236: 	if ( UsingSpellMenu == BLACK_MAGIC ) { GaidenBlackMagicUMEffect(NULL,NULL); }
	bl	GaidenBlackMagicUMEffect		@
.L378:
@ SpellMenu.c:244: }
	@ sp needed	@
@ SpellMenu.c:243: 	SelectedSpell = 0; // Regardless of use case, ensure that this is 0.
	movs	r2, #0	@ tmp118,
	ldr	r3, .L380+4	@ tmp117,
	strb	r2, [r3]	@ tmp118, SelectedSpell
@ SpellMenu.c:244: }
	pop	{r4}
	pop	{r0}
	bx	r0
.L377:
@ SpellMenu.c:237: 	else if ( UsingSpellMenu == WHITE_MAGIC ) { GaidenWhiteMagicUMEffect(NULL,NULL); }
	cmp	r3, #2	@ UsingSpellMenu.126_1,
	bne	.L379		@,
@ SpellMenu.c:237: 	else if ( UsingSpellMenu == WHITE_MAGIC ) { GaidenWhiteMagicUMEffect(NULL,NULL); }
	bl	GaidenWhiteMagicUMEffect		@
	b	.L378		@
.L379:
@ SpellMenu.c:241: 		AttackUMEffect(NULL,NULL);
	ldr	r3, .L380+8	@ tmp116,
	bl	.L14		@
	b	.L378		@
.L381:
	.align	2
.L380:
	.word	UsingSpellMenu
	.word	SelectedSpell
	.word	AttackUMEffect
	.size	NewExitBattleForecast, .-NewExitBattleForecast
	.align	1
	.global	GaidenStatScreen
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	GaidenStatScreen, %function
GaidenStatScreen:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r0, r1, r2, r4, r5, r6, r7, lr}	@
@ StatScreen.c:3: {
	movs	r5, r1	@ y, tmp177
@ StatScreen.c:4: 	u8* spells = SpellsGetter(gpStatScreenUnit,-1);
	movs	r1, #1	@,
@ StatScreen.c:3: {
	movs	r4, r2	@ currHandle, tmp178
@ StatScreen.c:4: 	u8* spells = SpellsGetter(gpStatScreenUnit,-1);
	ldr	r3, .L385	@ tmp142,
@ StatScreen.c:3: {
	movs	r7, r0	@ x, tmp176
@ StatScreen.c:4: 	u8* spells = SpellsGetter(gpStatScreenUnit,-1);
	rsbs	r1, r1, #0	@,
	ldr	r0, [r3]	@, gpStatScreenUnit
	bl	SpellsGetter		@
@ StatScreen.c:5: 	int tile = (currHandle-1)->tileIndexOffset;
	movs	r3, r4	@ tmp143, currHandle
	subs	r3, r3, #8	@ tmp143,
@ StatScreen.c:5: 	int tile = (currHandle-1)->tileIndexOffset;
	ldrh	r3, [r3]	@ tile, MEM[(struct TextHandle *)currHandle_24(D) + 4294967288B]
	lsls	r5, r5, #5	@ tmp144, y,
	str	r3, [sp]	@ tile, %sfp
	adds	r5, r5, r7	@ tmp145, tmp144, x
	ldr	r3, .L385+4	@ tmp147,
	lsls	r5, r5, #1	@ tmp146, tmp145,
	str	r0, [sp, #4]	@ tmp179, %sfp
	adds	r5, r5, r3	@ ivtmp.457, tmp146, tmp147
.L383:
@ StatScreen.c:8: 	for ( int i = 0 ; spells[i] ; i++ )
	ldr	r3, [sp, #4]	@ ivtmp.454, %sfp
	adds	r3, r3, #1	@ ivtmp.454,
	str	r3, [sp, #4]	@ ivtmp.454, %sfp
@ StatScreen.c:8: 	for ( int i = 0 ; spells[i] ; i++ )
	subs	r3, r3, #1	@ tmp172,
	ldrb	r0, [r3]	@ _15, MEM[(u8 *)_67 + 4294967295B]
@ StatScreen.c:8: 	for ( int i = 0 ; spells[i] ; i++ )
	cmp	r0, #0	@ _15,
	bne	.L384		@,
@ StatScreen.c:33: }
	@ sp needed	@
	movs	r0, r4	@, currHandle
	pop	{r1, r2, r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L384:
@ StatScreen.c:10: 		const ItemData* item = GetItemData(spells[i]);
	ldr	r3, .L385+8	@ tmp148,
	bl	.L14		@
@ StatScreen.c:11: 		DrawIcon(&StatScreenBufferMap[iconY][iconX],item->iconId,0x4000);
	movs	r2, #128	@,
	ldrb	r1, [r0, #29]	@ tmp150,
	lsls	r2, r2, #7	@,,
@ StatScreen.c:10: 		const ItemData* item = GetItemData(spells[i]);
	movs	r7, r0	@ item, tmp180
@ StatScreen.c:11: 		DrawIcon(&StatScreenBufferMap[iconY][iconX],item->iconId,0x4000);
	ldr	r3, .L385+12	@ tmp151,
	movs	r0, r5	@, ivtmp.457
	bl	.L14		@
@ StatScreen.c:13: 		tile += 8;
	ldr	r3, [sp]	@ tile, %sfp
	adds	r3, r3, #8	@ tile,
@ StatScreen.c:15: 		currHandle->xCursor = 0;
	movs	r6, #0	@ tmp153,
@ StatScreen.c:14: 		currHandle->tileIndexOffset = tile;
	strh	r3, [r4]	@ tile, MEM[(short unsigned int *)currHandle_16]
@ StatScreen.c:13: 		tile += 8;
	str	r3, [sp]	@ tile, %sfp
@ StatScreen.c:17: 		currHandle->tileWidth = 8;
	movs	r3, #8	@ tmp191,
@ StatScreen.c:22: 		Text_Clear(currHandle);
	movs	r0, r4	@, currHandle
@ StatScreen.c:15: 		currHandle->xCursor = 0;
	strb	r6, [r4, #2]	@ tmp153, MEM[(unsigned char *)currHandle_16 + 2B]
@ StatScreen.c:16: 		currHandle->colorId = TEXT_COLOR_NORMAL;
	strb	r6, [r4, #3]	@ tmp153, MEM[(unsigned char *)currHandle_16 + 3B]
@ StatScreen.c:17: 		currHandle->tileWidth = 8;
	strb	r3, [r4, #4]	@ tmp190, MEM[(unsigned char *)currHandle_16 + 4B]
@ StatScreen.c:18: 		currHandle->useDoubleBuffer = 0;
	strb	r6, [r4, #5]	@ tmp153, MEM[(unsigned char *)currHandle_16 + 5B]
@ StatScreen.c:19: 		currHandle->currentBufferId = 0;
	strb	r6, [r4, #6]	@ tmp153, MEM[(unsigned char *)currHandle_16 + 6B]
@ StatScreen.c:20: 		currHandle->unk07 = 0;
	strb	r6, [r4, #7]	@ tmp153, MEM[(unsigned char *)currHandle_16 + 7B]
@ StatScreen.c:22: 		Text_Clear(currHandle);
	ldr	r3, .L385+16	@ tmp165,
	bl	.L14		@
@ StatScreen.c:23: 		Text_SetColorId(currHandle,TEXT_COLOR_NORMAL);
	movs	r1, r6	@, tmp153
	movs	r0, r4	@, currHandle
	ldr	r3, .L385+20	@ tmp166,
	bl	.L14		@
@ StatScreen.c:24: 		Text_InsertString(currHandle,0,TEXT_COLOR_NORMAL,GetStringFromIndex(item->nameTextId));
	ldr	r3, .L385+24	@ tmp168,
	ldrh	r0, [r7]	@ *item_29, *item_29
	bl	.L14		@
@ StatScreen.c:24: 		Text_InsertString(currHandle,0,TEXT_COLOR_NORMAL,GetStringFromIndex(item->nameTextId));
	movs	r2, r6	@, tmp153
@ StatScreen.c:24: 		Text_InsertString(currHandle,0,TEXT_COLOR_NORMAL,GetStringFromIndex(item->nameTextId));
	movs	r3, r0	@ _10, tmp181
@ StatScreen.c:24: 		Text_InsertString(currHandle,0,TEXT_COLOR_NORMAL,GetStringFromIndex(item->nameTextId));
	movs	r1, r6	@, tmp153
	movs	r0, r4	@, currHandle
	ldr	r6, .L385+28	@ tmp169,
	bl	.L15		@
@ StatScreen.c:25: 		Text_Display(currHandle,&StatScreenBufferMap[iconY][iconX+2]);
	movs	r0, r4	@, currHandle
	adds	r1, r5, #4	@ tmp170, ivtmp.457,
	ldr	r3, .L385+32	@ tmp171,
	bl	.L14		@
@ StatScreen.c:27: 		currHandle++;
	adds	r4, r4, #8	@ currHandle,
	adds	r5, r5, #128	@ ivtmp.457,
	b	.L383		@
.L386:
	.align	2
.L385:
	.word	gpStatScreenUnit
	.word	StatScreenBufferMap
	.word	GetItemData
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
	.fpu softvfp
	.type	GaidenRTextGetter, %function
GaidenRTextGetter:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
@ StatScreen.c:38: 	proc->type = SpellsGetter(gpStatScreenUnit,-1)[index]; // I think if this is positive, it treats this as an item bubble.
	movs	r1, #1	@ tmp140,
@ StatScreen.c:36: {
	push	{r4, r5, r6, lr}	@
@ StatScreen.c:36: {
	movs	r4, r0	@ proc, tmp137
@ StatScreen.c:40: }
	@ sp needed	@
@ StatScreen.c:37: 	int index = *(proc->rTextData+0x12);
	ldr	r3, [r0, #44]	@ proc_12(D)->rTextData, proc_12(D)->rTextData
	ldrb	r5, [r3, #18]	@ _2, MEM[(char *)_1 + 18B]
@ StatScreen.c:38: 	proc->type = SpellsGetter(gpStatScreenUnit,-1)[index]; // I think if this is positive, it treats this as an item bubble.
	ldr	r3, .L388	@ tmp126,
	rsbs	r1, r1, #0	@, tmp140
	ldr	r0, [r3]	@, gpStatScreenUnit
	bl	SpellsGetter		@
@ StatScreen.c:38: 	proc->type = SpellsGetter(gpStatScreenUnit,-1)[index]; // I think if this is positive, it treats this as an item bubble.
	movs	r3, r4	@ tmp129, proc
@ StatScreen.c:38: 	proc->type = SpellsGetter(gpStatScreenUnit,-1)[index]; // I think if this is positive, it treats this as an item bubble.
	ldrb	r0, [r0, r5]	@ _7, *_6
@ StatScreen.c:38: 	proc->type = SpellsGetter(gpStatScreenUnit,-1)[index]; // I think if this is positive, it treats this as an item bubble.
	adds	r3, r3, #78	@ tmp129,
	strh	r0, [r3]	@ _7, proc_12(D)->type
@ StatScreen.c:39: 	proc->textID = GetItemData(proc->type)->descTextId;
	ldr	r3, .L388+4	@ tmp131,
	bl	.L14		@
@ StatScreen.c:39: 	proc->textID = GetItemData(proc->type)->descTextId;
	ldrh	r3, [r0, #2]	@ tmp135,
	adds	r4, r4, #76	@ tmp134,
	strh	r3, [r4]	@ tmp135, proc_12(D)->textID
@ StatScreen.c:40: }
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L389:
	.align	2
.L388:
	.word	gpStatScreenUnit
	.word	GetItemData
	.size	GaidenRTextGetter, .-GaidenRTextGetter
	.align	1
	.global	GaidenRTextLooper
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	GaidenRTextLooper, %function
GaidenRTextLooper:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r0, r1, r2, r4, r5, r6, r7, lr}	@
@ StatScreen.c:44: 	int index = *(proc->rTextData+0x12);
	ldr	r3, [r0, #44]	@ proc_26(D)->rTextData, proc_26(D)->rTextData
	ldrb	r5, [r3, #18]	@ _2, MEM[(char *)_1 + 18B]
@ StatScreen.c:45: 	if ( proc->direction == DIRECTION_UP )
	movs	r3, r0	@ tmp139, proc
	adds	r3, r3, #80	@ tmp139,
	str	r3, [sp, #4]	@ tmp139, %sfp
@ StatScreen.c:45: 	if ( proc->direction == DIRECTION_UP )
	ldrh	r3, [r3]	@ tmp140,
@ StatScreen.c:43: {
	movs	r4, r0	@ proc, tmp160
@ StatScreen.c:45: 	if ( proc->direction == DIRECTION_UP )
	cmp	r3, #0	@ tmp140,
	bne	.L392		@,
@ StatScreen.c:48: 		if ( !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index]) )
	movs	r1, #1	@,
@ StatScreen.c:48: 		if ( !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index]) )
	ldr	r7, .L397	@ tmp141,
	ldr	r6, [r7]	@ gpStatScreenUnit.133_4, gpStatScreenUnit
@ StatScreen.c:48: 		if ( !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index]) )
	rsbs	r1, r1, #0	@,
	movs	r0, r6	@, gpStatScreenUnit.133_4
	bl	SpellsGetter		@
@ StatScreen.c:48: 		if ( !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index]) )
	ldrb	r1, [r0, r5]	@ *_7, *_7
	movs	r0, r6	@, gpStatScreenUnit.133_4
	bl	DoesUnitKnowSpell		@
@ StatScreen.c:48: 		if ( !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index]) )
	cmp	r0, #0	@ tmp162,
	bne	.L392		@,
@ StatScreen.c:50: 			RTextUp(proc);
	movs	r0, r4	@, proc
	ldr	r6, .L397+4	@ tmp144,
	bl	.L15		@
@ StatScreen.c:52: 			if (!DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index-1]) ) { RTextUp(proc); }
	movs	r1, #1	@,
@ StatScreen.c:52: 			if (!DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index-1]) ) { RTextUp(proc); }
	ldr	r7, [r7]	@ gpStatScreenUnit.136_10, gpStatScreenUnit
@ StatScreen.c:52: 			if (!DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index-1]) ) { RTextUp(proc); }
	rsbs	r1, r1, #0	@,
	movs	r0, r7	@, gpStatScreenUnit.136_10
	bl	SpellsGetter		@
@ StatScreen.c:52: 			if (!DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index-1]) ) { RTextUp(proc); }
	adds	r0, r0, r5	@ tmp147, tmp163, _2
	subs	r0, r0, #1	@ tmp148,
	ldrb	r1, [r0]	@ *_13, *_13
	movs	r0, r7	@, gpStatScreenUnit.136_10
	bl	DoesUnitKnowSpell		@
@ StatScreen.c:52: 			if (!DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index-1]) ) { RTextUp(proc); }
	cmp	r0, #0	@ tmp164,
	bne	.L392		@,
@ StatScreen.c:52: 			if (!DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index-1]) ) { RTextUp(proc); }
	movs	r0, r4	@, proc
	bl	.L15		@
.L392:
@ StatScreen.c:65: 	if ( proc->direction == DIRECTION_DOWN )
	ldr	r3, [sp, #4]	@ tmp139, %sfp
	ldrh	r3, [r3]	@ tmp154,
	cmp	r3, #128	@ tmp154,
	bne	.L390		@,
@ StatScreen.c:68: 		if ( !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index]) )
	movs	r1, #1	@,
@ StatScreen.c:68: 		if ( !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index]) )
	ldr	r3, .L397	@ tmp155,
	ldr	r6, [r3]	@ gpStatScreenUnit.139_17, gpStatScreenUnit
@ StatScreen.c:68: 		if ( !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index]) )
	rsbs	r1, r1, #0	@,
	movs	r0, r6	@, gpStatScreenUnit.139_17
	bl	SpellsGetter		@
@ StatScreen.c:68: 		if ( !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index]) )
	ldrb	r1, [r0, r5]	@ *_20, *_20
	movs	r0, r6	@, gpStatScreenUnit.139_17
	bl	DoesUnitKnowSpell		@
@ StatScreen.c:68: 		if ( !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index]) )
	cmp	r0, #0	@ tmp166,
	bne	.L390		@,
@ StatScreen.c:70: 			RTextDown(proc);
	movs	r0, r4	@, proc
	ldr	r3, .L397+8	@ tmp158,
	bl	.L14		@
.L390:
@ StatScreen.c:75: }
	@ sp needed	@
	pop	{r0, r1, r2, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L398:
	.align	2
.L397:
	.word	gpStatScreenUnit
	.word	RTextUp
	.word	RTextDown
	.size	GaidenRTextLooper, .-GaidenRTextLooper
	.ident	"GCC: (devkitARM release 56) 11.1.0"
	.code 16
	.align	1
.L14:
	bx	r3
.L16:
	bx	r4
.L316:
	bx	r5
.L15:
	bx	r6
.L265:
	bx	r7
