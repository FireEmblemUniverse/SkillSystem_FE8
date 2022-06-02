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
@ GNU C17 (devkitARM release 55) version 10.2.0 (arm-none-eabi)
@	compiled by GNU C version 6.4.0, GMP version 6.0.0, MPFR version 3.1.2, MPC version 1.0.2, isl version none
@ GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
@ options passed:  -imultilib thumb
@ -iprefix c:\devkitpro\devkitarm\bin\../lib/gcc/arm-none-eabi/10.2.0/
@ -D__USES_INITFINI__ GaidenMagic.c -mcpu=arm7tdmi -mthumb
@ -mthumb-interwork -mtune=arm7tdmi -mlong-calls -march=armv4t
@ -auxbase-strip GaidenMagic.s -Os -Wall -fverbose-asm
@ options enabled:  -faggressive-loop-optimizations -fallocation-dce
@ -fauto-inc-dec -fbranch-count-reg -fcaller-saves -fcode-hoisting
@ -fcombine-stack-adjustments -fcompare-elim -fcprop-registers
@ -fcrossjumping -fcse-follow-jumps -fdefer-pop
@ -fdelete-null-pointer-checks -fdevirtualize -fdevirtualize-speculatively
@ -fdwarf2-cfi-asm -fearly-inlining -feliminate-unused-debug-symbols
@ -feliminate-unused-debug-types -fexpensive-optimizations
@ -fforward-propagate -ffp-int-builtin-inexact -ffunction-cse -fgcse
@ -fgcse-lm -fgnu-unique -fguess-branch-probability -fhoist-adjacent-loads
@ -fident -fif-conversion -fif-conversion2 -findirect-inlining -finline
@ -finline-atomics -finline-functions -finline-functions-called-once
@ -finline-small-functions -fipa-bit-cp -fipa-cp -fipa-icf
@ -fipa-icf-functions -fipa-icf-variables -fipa-profile -fipa-pure-const
@ -fipa-reference -fipa-reference-addressable -fipa-sra
@ -fipa-stack-alignment -fipa-vrp -fira-hoist-pressure
@ -fira-share-save-slots -fira-share-spill-slots
@ -fisolate-erroneous-paths-dereference -fivopts -fkeep-static-consts
@ -fleading-underscore -flifetime-dse -flra-remat -fmath-errno
@ -fmerge-constants -fmerge-debug-strings -fmove-loop-invariants
@ -fomit-frame-pointer -foptimize-sibling-calls -fpartial-inlining
@ -fpeephole -fpeephole2 -fplt -fprefetch-loop-arrays -freg-struct-return
@ -freorder-blocks -freorder-functions -frerun-cse-after-loop
@ -fsched-critical-path-heuristic -fsched-dep-count-heuristic
@ -fsched-group-heuristic -fsched-interblock -fsched-last-insn-heuristic
@ -fsched-pressure -fsched-rank-heuristic -fsched-spec
@ -fsched-spec-insn-heuristic -fsched-stalled-insns-dep -fschedule-insns2
@ -fsection-anchors -fsemantic-interposition -fshow-column -fshrink-wrap
@ -fshrink-wrap-separate -fsigned-zeros -fsplit-ivs-in-unroller
@ -fsplit-wide-types -fssa-backprop -fssa-phiopt -fstdarg-opt
@ -fstore-merging -fstrict-aliasing -fstrict-volatile-bitfields
@ -fsync-libcalls -fthread-jumps -ftoplevel-reorder -ftrapping-math
@ -ftree-bit-ccp -ftree-builtin-call-dce -ftree-ccp -ftree-ch
@ -ftree-coalesce-vars -ftree-copy-prop -ftree-cselim -ftree-dce
@ -ftree-dominator-opts -ftree-dse -ftree-forwprop -ftree-fre
@ -ftree-loop-distribute-patterns -ftree-loop-if-convert -ftree-loop-im
@ -ftree-loop-ivcanon -ftree-loop-optimize -ftree-parallelize-loops=
@ -ftree-phiprop -ftree-pre -ftree-pta -ftree-reassoc -ftree-scev-cprop
@ -ftree-sink -ftree-slsr -ftree-sra -ftree-switch-conversion
@ -ftree-tail-merge -ftree-ter -ftree-vrp -funit-at-a-time -fverbose-asm
@ -fzero-initialized-in-bss -mbe32 -mlittle-endian -mlong-calls
@ -mpic-data-is-text-relative -msched-prolog -mthumb -mthumb-interwork
@ -mvectorize-with-neon-quad

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
@ RangeDisplay.c:62: 	long long existingMin = existing >> 40;
	asrs	r7, r1, #31	@ existingMin, existing,
@ RangeDisplay.c:63: 	long long newMin = new >> 40;
	asrs	r5, r3, #8	@ newMin, new,
	asrs	r6, r3, #31	@ newMin, new,
@ RangeDisplay.c:66: 	return existingMask|newMask|(( newMin < existingMin ? newMin : existingMin ) << 40)|(( newMax > existingMax ? newMax : existingMax ) << 32);
	asrs	r4, r1, #8	@ existingMin, existing,
	cmp	r7, r6	@ existingMin, newMin
	bgt	.L3		@,
	bne	.L2		@,
	cmp	r4, r5	@ existingMin, newMin
	bls	.L2		@,
.L3:
	movs	r4, r5	@ existingMin, newMin
.L2:
@ RangeDisplay.c:66: 	return existingMask|newMask|(( newMin < existingMin ? newMin : existingMin ) << 40)|(( newMax > existingMax ? newMax : existingMax ) << 32);
	orrs	r0, r2	@ tmp137, new
@ RangeDisplay.c:64: 	long long existingMax = (existing >> 32) & 0xFF;
	movs	r2, #255	@ tmp144,
@ RangeDisplay.c:66: 	return existingMask|newMask|(( newMin < existingMin ? newMin : existingMin ) << 40)|(( newMax > existingMax ? newMax : existingMax ) << 32);
	lsls	r4, r4, #8	@ tmp167, existingMin,
@ RangeDisplay.c:65: 	long long newMax = (new >> 32) & 0xFF;
	ands	r3, r2	@ newMax, tmp144
@ RangeDisplay.c:66: 	return existingMask|newMask|(( newMin < existingMin ? newMin : existingMin ) << 40)|(( newMax > existingMax ? newMax : existingMax ) << 32);
	ands	r1, r2	@ existingMax, tmp144
	cmp	r3, r1	@ newMax, existingMax
	bls	.L4		@,
	movs	r1, r3	@ existingMax, newMax
.L4:
@ RangeDisplay.c:67: }
	@ sp needed	@
@ RangeDisplay.c:66: 	return existingMask|newMask|(( newMin < existingMin ? newMin : existingMin ) << 40)|(( newMax > existingMax ? newMax : existingMax ) << 32);
	orrs	r1, r4	@ tmp159, tmp167
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
	ldr	r0, .L12+24	@,
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
	.fpu softvfp
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
	.fpu softvfp
	.type	CanCastSpellNow, %function
CanCastSpellNow:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ SpellSystem.c:198: 	int type = GetItemType(spell);
	movs	r0, r1	@, spell
	ldr	r3, .L27	@ tmp122,
@ SpellSystem.c:196: {
	movs	r4, r1	@ spell, tmp135
@ SpellSystem.c:198: 	int type = GetItemType(spell);
	bl	.L14		@
@ SpellSystem.c:201: 		if ( !CanUnitUseWeaponNow(gActiveUnit,spell) ) { return 0; }
	movs	r1, r4	@, spell
	ldr	r5, .L27+4	@ tmp134,
@ SpellSystem.c:199: 	if ( type != ITYPE_STAFF )
	cmp	r0, #4	@ tmp136,
	beq	.L22		@,
@ SpellSystem.c:201: 		if ( !CanUnitUseWeaponNow(gActiveUnit,spell) ) { return 0; }
	ldr	r0, [r5]	@, gActiveUnit
	ldr	r3, .L27+8	@ tmp124,
	bl	.L14		@
@ SpellSystem.c:201: 		if ( !CanUnitUseWeaponNow(gActiveUnit,spell) ) { return 0; }
	cmp	r0, #0	@ <retval>,
	beq	.L21		@,
@ SpellSystem.c:203: 		MakeTargetListForWeapon(gActiveUnit,spell);
	movs	r1, r4	@, spell
	ldr	r0, [r5]	@, gActiveUnit
	ldr	r3, .L27+12	@ tmp126,
	bl	.L14		@
@ SpellSystem.c:204: 		return GetTargetListSize() != 0;
	ldr	r3, .L27+16	@ tmp127,
	bl	.L14		@
@ SpellSystem.c:204: 		return GetTargetListSize() != 0;
	subs	r3, r0, #1	@ tmp130, tmp138
	sbcs	r0, r0, r3	@ <retval>, tmp138, tmp130
.L21:
@ SpellSystem.c:210: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L22:
@ SpellSystem.c:208: 		return CanUnitUseItem(gActiveUnit,spell);
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
	.fpu softvfp
	.type	CanCastSpell, %function
CanCastSpell:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ SpellSystem.c:214: 	int type = GetItemType(spell);
	movs	r0, r1	@, spell
	ldr	r3, .L35	@ tmp122,
@ SpellSystem.c:213: {
	movs	r4, r1	@ spell, tmp135
@ SpellSystem.c:214: 	int type = GetItemType(spell);
	bl	.L14		@
@ SpellSystem.c:217: 		if ( !CanUnitUseWeapon(gActiveUnit,spell) ) { return 0; }
	movs	r1, r4	@, spell
	ldr	r5, .L35+4	@ tmp134,
@ SpellSystem.c:215: 	if ( type != ITYPE_STAFF )
	cmp	r0, #4	@ tmp136,
	beq	.L30		@,
@ SpellSystem.c:217: 		if ( !CanUnitUseWeapon(gActiveUnit,spell) ) { return 0; }
	ldr	r0, [r5]	@, gActiveUnit
	ldr	r3, .L35+8	@ tmp124,
	bl	.L14		@
@ SpellSystem.c:217: 		if ( !CanUnitUseWeapon(gActiveUnit,spell) ) { return 0; }
	cmp	r0, #0	@ <retval>,
	beq	.L29		@,
@ SpellSystem.c:219: 		MakeTargetListForWeapon(gActiveUnit,spell);
	movs	r1, r4	@, spell
	ldr	r0, [r5]	@, gActiveUnit
	ldr	r3, .L35+12	@ tmp126,
	bl	.L14		@
@ SpellSystem.c:220: 		return GetTargetListSize() != 0;
	ldr	r3, .L35+16	@ tmp127,
	bl	.L14		@
@ SpellSystem.c:220: 		return GetTargetListSize() != 0;
	subs	r3, r0, #1	@ tmp130, tmp138
	sbcs	r0, r0, r3	@ <retval>, tmp138, tmp130
.L29:
@ SpellSystem.c:226: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L30:
@ SpellSystem.c:208: 		return CanUnitUseItem(gActiveUnit,spell);
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
	.fpu softvfp
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
	.fpu softvfp
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
@ RangeDisplay.c:72: 	return GetItemType(item) == ITYPE_STAFF && CanCastSpell(unit,item);
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
	.fpu softvfp
	.type	GetSpellType, %function
GetSpellType:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
@ SpellSystem.c:280: 	int wType = GetItemType(spell);
	ldr	r3, .L52	@ tmp117,
@ SpellSystem.c:279: {
	push	{r4, lr}	@
@ SpellSystem.c:280: 	int wType = GetItemType(spell);
	bl	.L14		@
@ SpellSystem.c:281: 	if ( wType == ITYPE_ANIMA || wType == ITYPE_DARK ) { return BLACK_MAGIC; }
	movs	r2, #2	@ tmp118,
	movs	r3, r0	@ tmp127, tmp127
@ SpellSystem.c:281: 	if ( wType == ITYPE_ANIMA || wType == ITYPE_DARK ) { return BLACK_MAGIC; }
	movs	r0, #1	@ <retval>,
@ SpellSystem.c:281: 	if ( wType == ITYPE_ANIMA || wType == ITYPE_DARK ) { return BLACK_MAGIC; }
	bics	r3, r2	@ tmp127, tmp118
	cmp	r3, #5	@ _6,
	beq	.L48		@,
@ SpellSystem.c:282: 	else if ( wType == ITYPE_STAFF || wType == ITYPE_LIGHT) { return WHITE_MAGIC; }
	movs	r0, r2	@ <retval>, tmp118
@ SpellSystem.c:282: 	else if ( wType == ITYPE_STAFF || wType == ITYPE_LIGHT) { return WHITE_MAGIC; }
	cmp	r3, #4	@ _6,
	beq	.L48		@,
@ SpellSystem.c:283: 	else { return -1; }
	subs	r0, r0, #3	@ <retval>,
.L48:
@ SpellSystem.c:284: }
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
	str	r1, [sp]	@ tmp153, %sfp
	str	r2, [sp, #4]	@ tmp154, %sfp
@ SpellSystem.c:10: 	int unitLevel = unit->level;
	ldrsb	r6, [r0, r6]	@ unitLevel,* unitLevel
@ SpellSystem.c:11: 	if ( UNIT_ATTRIBUTES(unit) & CA_PROMOTED ) { unitLevel += 80; } // Treat promoted as top bit set.
	ldmia	r0!, {r2, r3}	@,,
	ldr	r3, [r3, #40]	@ _4->attributes, _4->attributes
	ldr	r1, [r2, #40]	@ tmp159, _2->attributes
	orrs	r3, r1	@ tmp138, tmp159
@ SpellSystem.c:11: 	if ( UNIT_ATTRIBUTES(unit) & CA_PROMOTED ) { unitLevel += 80; } // Treat promoted as top bit set.
	lsls	r3, r3, #23	@ tmp156, tmp138,
	bpl	.L55		@,
@ SpellSystem.c:11: 	if ( UNIT_ATTRIBUTES(unit) & CA_PROMOTED ) { unitLevel += 80; } // Treat promoted as top bit set.
	adds	r6, r6, #80	@ unitLevel,
.L55:
@ SpellSystem.c:13: 	SpellList* ROMList = SpellListTable[unit->pCharacterData->number];
	ldrb	r3, [r2, #4]	@ tmp144,
@ SpellSystem.c:13: 	SpellList* ROMList = SpellListTable[unit->pCharacterData->number];
	ldr	r2, .L69	@ tmp143,
	lsls	r3, r3, #2	@ tmp145, tmp144,
	ldr	r7, .L69+4	@ <retval>,
	ldr	r4, [r3, r2]	@ ROMList, SpellListTable[_9]
@ SpellSystem.c:12: 	u8* currBuffer = SpellsBuffer;
	movs	r5, r7	@ currBuffer, <retval>
@ SpellSystem.c:14: 	if ( ROMList )
	cmp	r4, #0	@ ROMList,
	beq	.L56		@,
.L57:
@ SpellSystem.c:17: 		for ( int i = 0 ; ROMList[i].level ; i++ )
	ldrb	r3, [r4]	@ _19, MEM[base: _11, offset: 0B]
@ SpellSystem.c:17: 		for ( int i = 0 ; ROMList[i].level ; i++ )
	cmp	r3, #0	@ _19,
	bne	.L63		@,
.L56:
@ SpellSystem.c:33: }
	@ sp needed	@
@ SpellSystem.c:31: 	*currBuffer = 0;
	movs	r3, #0	@ tmp148,
@ SpellSystem.c:33: }
	movs	r0, r7	@, <retval>
@ SpellSystem.c:31: 	*currBuffer = 0;
	strb	r3, [r5]	@ tmp148, *currBuffer_23
@ SpellSystem.c:33: }
	pop	{r1, r2, r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L63:
@ SpellSystem.c:19: 			if ( (level == -1 && unitLevel >= ROMList[i].level) || (level == ROMList[i].level) )
	ldr	r2, [sp]	@ level, %sfp
	adds	r2, r2, #1	@ tmp157, level,
	bne	.L58		@,
@ SpellSystem.c:19: 			if ( (level == -1 && unitLevel >= ROMList[i].level) || (level == ROMList[i].level) )
	cmp	r6, r3	@ unitLevel, _19
	bge	.L59		@,
.L60:
	adds	r4, r4, #2	@ ivtmp.207,
	b	.L57		@
.L58:
@ SpellSystem.c:19: 			if ( (level == -1 && unitLevel >= ROMList[i].level) || (level == ROMList[i].level) )
	ldr	r2, [sp]	@ level, %sfp
	cmp	r2, r3	@ level, _19
	bne	.L60		@,
.L59:
@ SpellSystem.c:21: 				if ( type == -1 || type == GetSpellType(ROMList[i].spell) )
	ldr	r3, [sp, #4]	@ type, %sfp
	adds	r3, r3, #1	@ tmp158, type,
	bne	.L61		@,
.L62:
@ SpellSystem.c:24: 					*currBuffer = ROMList[i].spell;
	ldrb	r3, [r4, #1]	@ _15, MEM[base: _11, offset: 1B]
@ SpellSystem.c:24: 					*currBuffer = ROMList[i].spell;
	strb	r3, [r5]	@ _15, *currBuffer_22
@ SpellSystem.c:25: 					currBuffer++;
	adds	r5, r5, #1	@ currBuffer,
	b	.L60		@
.L61:
@ SpellSystem.c:21: 				if ( type == -1 || type == GetSpellType(ROMList[i].spell) )
	ldrb	r0, [r4, #1]	@ MEM[base: _11, offset: 1B], MEM[base: _11, offset: 1B]
	bl	GetSpellType		@
@ SpellSystem.c:21: 				if ( type == -1 || type == GetSpellType(ROMList[i].spell) )
	ldr	r3, [sp, #4]	@ type, %sfp
	cmp	r0, r3	@ tmp155, type
	bne	.L60		@,
	b	.L62		@
.L70:
	.align	2
.L69:
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
@ UnitMenu.c:38: {
	movs	r5, r1	@ commandProc, tmp124
@ UnitMenu.c:41: }
	@ sp needed	@
@ UnitMenu.c:39: 	UsingSpellMenu = BLACK_MAGIC;
	movs	r1, #1	@ tmp119,
@ UnitMenu.c:38: {
	movs	r4, r0	@ proc, tmp123
@ UnitMenu.c:39: 	UsingSpellMenu = BLACK_MAGIC;
	ldr	r3, .L73	@ tmp118,
	strb	r1, [r3]	@ tmp119, UsingSpellMenu
@ UnitMenu.c:40: 	return GaidenMagicUMEffectExt(SpellsGetter(gActiveUnit,BLACK_MAGIC),proc,commandProc);
	ldr	r3, .L73+4	@ tmp121,
	ldr	r0, [r3]	@, gActiveUnit
	bl	SpellsGetter		@
	movs	r2, r5	@, commandProc
	movs	r1, r4	@, proc
	bl	GaidenMagicUMEffectExt		@
@ UnitMenu.c:41: }
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L74:
	.align	2
.L73:
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
@ UnitMenu.c:44: {
	movs	r5, r1	@ commandProc, tmp124
@ UnitMenu.c:47: }
	@ sp needed	@
@ UnitMenu.c:45: 	UsingSpellMenu = WHITE_MAGIC;
	movs	r1, #2	@ tmp119,
@ UnitMenu.c:44: {
	movs	r4, r0	@ proc, tmp123
@ UnitMenu.c:45: 	UsingSpellMenu = WHITE_MAGIC;
	ldr	r3, .L76	@ tmp118,
	strb	r1, [r3]	@ tmp119, UsingSpellMenu
@ UnitMenu.c:46: 	return GaidenMagicUMEffectExt(SpellsGetter(gActiveUnit,WHITE_MAGIC),proc,commandProc);
	ldr	r3, .L76+4	@ tmp121,
	ldr	r0, [r3]	@, gActiveUnit
	bl	SpellsGetter		@
	movs	r2, r5	@, commandProc
	movs	r1, r4	@, proc
	bl	GaidenMagicUMEffectExt		@
@ UnitMenu.c:47: }
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L77:
	.align	2
.L76:
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
	movs	r6, r0	@ ivtmp.231, unit
@ SpellSystem.c:110: {
	movs	r5, r0	@ unit, tmp181
@ SpellSystem.c:111: 	u32 ret = 0;
	movs	r4, #0	@ <retval>,
@ SpellSystem.c:115: 		if ( attributes & IA_WEAPON )
	movs	r7, #1	@ tmp179,
	adds	r3, r3, #40	@ _72,
	str	r3, [sp, #4]	@ _72, %sfp
	adds	r6, r6, #30	@ ivtmp.231,
.L79:
@ SpellSystem.c:112: 	for ( int i = 0 ; i < 5 && unit->items[i] ; i++ )
	ldrh	r0, [r6]	@ _11, MEM[base: _68, offset: 0B]
@ SpellSystem.c:112: 	for ( int i = 0 ; i < 5 && unit->items[i] ; i++ )
	cmp	r0, #0	@ _11,
	beq	.L82		@,
@ SpellSystem.c:114: 		u32 attributes = GetItemAttributes(unit->items[i]);
	ldr	r3, .L106	@ tmp145,
	bl	.L14		@
@ SpellSystem.c:115: 		if ( attributes & IA_WEAPON )
	tst	r0, r7	@ attributes, tmp179
	beq	.L80		@,
@ SpellSystem.c:117: 			if ( CanUnitUseWeaponNow(unit,unit->items[i]) ) { ret |= 1; }
	movs	r0, r5	@, unit
	ldrh	r1, [r6]	@ MEM[base: _68, offset: 0B], MEM[base: _68, offset: 0B]
	ldr	r3, .L106+4	@ tmp149,
	bl	.L14		@
@ SpellSystem.c:117: 			if ( CanUnitUseWeaponNow(unit,unit->items[i]) ) { ret |= 1; }
	cmp	r0, #0	@ tmp183,
	beq	.L81		@,
@ SpellSystem.c:117: 			if ( CanUnitUseWeaponNow(unit,unit->items[i]) ) { ret |= 1; }
	orrs	r4, r7	@ <retval>, tmp179
.L81:
@ SpellSystem.c:112: 	for ( int i = 0 ; i < 5 && unit->items[i] ; i++ )
	ldr	r3, [sp, #4]	@ _72, %sfp
	adds	r6, r6, #2	@ ivtmp.231,
	cmp	r6, r3	@ ivtmp.231, _72
	bne	.L79		@,
.L82:
@ SpellSystem.c:125: 	u8* spells = SpellsGetter(unit,-1);
	movs	r1, #1	@,
	movs	r0, r5	@, unit
	rsbs	r1, r1, #0	@,
	bl	SpellsGetter		@
@ SpellSystem.c:129: 		if ( attributes & IA_WEAPON )
	movs	r7, #1	@ tmp177,
@ SpellSystem.c:125: 	u8* spells = SpellsGetter(unit,-1);
	movs	r6, r0	@ ivtmp.225, tmp185
.L84:
@ SpellSystem.c:126: 	for ( int i = 0 ; spells[i] ; i++ )
	ldrb	r0, [r6]	@ _24, MEM[base: _60, offset: 0B]
@ SpellSystem.c:126: 	for ( int i = 0 ; spells[i] ; i++ )
	cmp	r0, #0	@ _24,
	bne	.L87		@,
@ SpellSystem.c:139: }
	@ sp needed	@
	movs	r0, r4	@, <retval>
	pop	{r1, r2, r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L80:
@ SpellSystem.c:119: 		else if ( attributes & IA_STAFF )
	movs	r3, #4	@ tmp192,
	tst	r0, r3	@ attributes, tmp192
	beq	.L81		@,
@ SpellSystem.c:121: 			if ( CanUnitUseStaffNow(unit,unit->items[i]) ) { ret |= 2; }
	movs	r0, r5	@, unit
	ldrh	r1, [r6]	@ MEM[base: _68, offset: 0B], MEM[base: _68, offset: 0B]
	ldr	r3, .L106+8	@ tmp156,
	bl	.L14		@
@ SpellSystem.c:121: 			if ( CanUnitUseStaffNow(unit,unit->items[i]) ) { ret |= 2; }
	cmp	r0, #0	@ tmp184,
	beq	.L81		@,
@ SpellSystem.c:121: 			if ( CanUnitUseStaffNow(unit,unit->items[i]) ) { ret |= 2; }
	movs	r3, #2	@ tmp159,
	orrs	r4, r3	@ <retval>, tmp159
	b	.L81		@
.L87:
@ SpellSystem.c:128: 		u32 attributes = GetItemAttributes(spells[i]);
	ldr	r3, .L106	@ tmp161,
	bl	.L14		@
@ SpellSystem.c:129: 		if ( attributes & IA_WEAPON )
	tst	r0, r7	@ attributes, tmp177
	beq	.L85		@,
@ SpellSystem.c:131: 			if ( CanUnitUseWeaponNow(unit,spells[i]) ) { ret |= 1; }
	movs	r0, r5	@, unit
	ldrb	r1, [r6]	@ MEM[base: _60, offset: 0B], MEM[base: _60, offset: 0B]
	ldr	r3, .L106+4	@ tmp165,
	bl	.L14		@
@ SpellSystem.c:131: 			if ( CanUnitUseWeaponNow(unit,spells[i]) ) { ret |= 1; }
	cmp	r0, #0	@ tmp187,
	beq	.L86		@,
@ SpellSystem.c:131: 			if ( CanUnitUseWeaponNow(unit,spells[i]) ) { ret |= 1; }
	orrs	r4, r7	@ <retval>, tmp177
.L86:
	adds	r6, r6, #1	@ ivtmp.225,
	b	.L84		@
.L85:
@ SpellSystem.c:133: 		else if ( attributes & IA_STAFF )
	movs	r3, #4	@ tmp195,
	tst	r0, r3	@ attributes, tmp195
	beq	.L86		@,
@ SpellSystem.c:135: 			if ( CanUnitUseStaffNow(unit,spells[i]) ) { ret |= 2; }
	movs	r0, r5	@, unit
	ldrb	r1, [r6]	@ MEM[base: _60, offset: 0B], MEM[base: _60, offset: 0B]
	ldr	r3, .L106+8	@ tmp172,
	bl	.L14		@
@ SpellSystem.c:135: 			if ( CanUnitUseStaffNow(unit,spells[i]) ) { ret |= 2; }
	cmp	r0, #0	@ tmp188,
	beq	.L86		@,
@ SpellSystem.c:135: 			if ( CanUnitUseStaffNow(unit,spells[i]) ) { ret |= 2; }
	movs	r3, #2	@ tmp175,
	orrs	r4, r3	@ <retval>, tmp175
	b	.L86		@
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
	.fpu softvfp
	.type	CanUseAttackSpellsNow, %function
CanUseAttackSpellsNow:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ SpellSystem.c:229: {
	movs	r5, r0	@ unit, tmp128
@ SpellSystem.c:230: 	u8* spells = SpellsGetter(unit,type);
	bl	SpellsGetter		@
	movs	r4, r0	@ ivtmp.239, tmp130
.L109:
@ SpellSystem.c:231: 	for ( int i = 0 ; spells[i] ; i++ )
	ldrb	r0, [r4]	@ _8, MEM[base: _25, offset: 0B]
@ SpellSystem.c:231: 	for ( int i = 0 ; spells[i] ; i++ )
	cmp	r0, #0	@ _8,
	bne	.L113		@,
.L108:
@ SpellSystem.c:239: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L113:
@ SpellSystem.c:233: 		if ( GetItemType(spells[i]) != ITYPE_STAFF && CanCastSpellNow(unit,spells[i]) )
	ldr	r3, .L115	@ tmp125,
	bl	.L14		@
@ SpellSystem.c:233: 		if ( GetItemType(spells[i]) != ITYPE_STAFF && CanCastSpellNow(unit,spells[i]) )
	cmp	r0, #4	@ tmp131,
	bne	.L110		@,
.L112:
	adds	r4, r4, #1	@ ivtmp.239,
	b	.L109		@
.L110:
@ SpellSystem.c:233: 		if ( GetItemType(spells[i]) != ITYPE_STAFF && CanCastSpellNow(unit,spells[i]) )
	movs	r0, r5	@, unit
	ldrb	r1, [r4]	@ MEM[base: _25, offset: 0B], MEM[base: _25, offset: 0B]
	bl	CanCastSpellNow		@
@ SpellSystem.c:233: 		if ( GetItemType(spells[i]) != ITYPE_STAFF && CanCastSpellNow(unit,spells[i]) )
	cmp	r0, #0	@ tmp132,
	beq	.L112		@,
@ SpellSystem.c:235: 			return 1;
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
	.fpu softvfp
	.type	GetNthUsableSpell, %function
GetNthUsableSpell:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r0, r1, r2, r4, r5, r6, r7, lr}	@
@ SpellSystem.c:244: {
	movs	r7, r1	@ n, tmp125
	movs	r1, r2	@ type, tmp126
	movs	r5, r0	@ unit, tmp124
@ SpellSystem.c:245: 	u8* spells = SpellsGetter(unit,type);
	bl	SpellsGetter		@
@ SpellSystem.c:246: 	int k = -1;
	movs	r6, #1	@ k,
@ SpellSystem.c:247: 	for ( int i = 0 ; spells[i] ; i++ )
	movs	r4, #0	@ <retval>,
@ SpellSystem.c:245: 	u8* spells = SpellsGetter(unit,type);
	str	r0, [sp, #4]	@ tmp127, %sfp
@ SpellSystem.c:246: 	int k = -1;
	rsbs	r6, r6, #0	@ k, k
.L118:
@ SpellSystem.c:247: 	for ( int i = 0 ; spells[i] ; i++ )
	ldr	r3, [sp, #4]	@ spells, %sfp
	ldrb	r1, [r3, r4]	@ _6, MEM[base: spells_17, index: _1, offset: 0B]
@ SpellSystem.c:247: 	for ( int i = 0 ; spells[i] ; i++ )
	cmp	r1, #0	@ _6,
	bne	.L121		@,
@ SpellSystem.c:255: 	return -1;
	movs	r4, #1	@ <retval>,
	rsbs	r4, r4, #0	@ <retval>, <retval>
.L117:
@ SpellSystem.c:256: }
	movs	r0, r4	@, <retval>
	@ sp needed	@
	pop	{r1, r2, r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L121:
@ SpellSystem.c:249: 		if ( CanCastSpellNow(unit,spells[i]) )
	movs	r0, r5	@, unit
	bl	CanCastSpellNow		@
@ SpellSystem.c:249: 		if ( CanCastSpellNow(unit,spells[i]) )
	cmp	r0, #0	@ tmp128,
	beq	.L119		@,
@ SpellSystem.c:251: 			k++;
	adds	r6, r6, #1	@ k,
@ SpellSystem.c:252: 			if ( k == n ) { return i; }
	cmp	r6, r7	@ k, n
	beq	.L117		@,
.L119:
@ SpellSystem.c:247: 	for ( int i = 0 ; spells[i] ; i++ )
	adds	r4, r4, #1	@ <retval>,
	b	.L118		@
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
@ SpellSystem.c:268: {
	movs	r4, r1	@ spell, tmp123
@ SpellSystem.c:270: 	u8* spells = SpellsGetter(unit,-1);
	movs	r1, #1	@,
	rsbs	r1, r1, #0	@,
	bl	SpellsGetter		@
	movs	r3, r0	@ ivtmp.253, tmp124
.L126:
@ SpellSystem.c:271: 	for ( int i = 0 ; spells[i] ; i++ )
	ldrb	r0, [r3]	@ _3, MEM[base: _15, offset: 0B]
@ SpellSystem.c:271: 	for ( int i = 0 ; spells[i] ; i++ )
	cmp	r0, #0	@ _3,
	bne	.L128		@,
.L125:
@ SpellSystem.c:276: }
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L128:
@ SpellSystem.c:273: 		if ( spell == spells[i] ) { return 1; }
	adds	r3, r3, #1	@ ivtmp.253,
	cmp	r0, r4	@ _3, spell
	bne	.L126		@,
@ SpellSystem.c:273: 		if ( spell == spells[i] ) { return 1; }
	movs	r0, #1	@ <retval>,
	b	.L125		@
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
@ SpellSystem.c:174: 	if ( gBattleActor.levelPrevious != gBattleActor.unit.level ) { subject = &gBattleActor; }
	ldr	r3, .L140	@ tmp131,
	movs	r2, r3	@ tmp134, tmp131
@ SpellSystem.c:170: {
	push	{r4, lr}	@
@ SpellSystem.c:174: 	if ( gBattleActor.levelPrevious != gBattleActor.unit.level ) { subject = &gBattleActor; }
	adds	r2, r2, #112	@ tmp134,
	ldrb	r1, [r2]	@ tmp135,
@ SpellSystem.c:174: 	if ( gBattleActor.levelPrevious != gBattleActor.unit.level ) { subject = &gBattleActor; }
	movs	r2, #8	@ tmp137,
	ldrsb	r2, [r3, r2]	@ tmp137,
@ SpellSystem.c:173: 	BattleUnit* subject = NULL;
	movs	r0, #0	@ subject,
@ SpellSystem.c:174: 	if ( gBattleActor.levelPrevious != gBattleActor.unit.level ) { subject = &gBattleActor; }
	cmp	r1, r2	@ tmp135, tmp137
	beq	.L131		@,
@ SpellSystem.c:174: 	if ( gBattleActor.levelPrevious != gBattleActor.unit.level ) { subject = &gBattleActor; }
	movs	r0, r3	@ subject, tmp131
.L131:
@ SpellSystem.c:175: 	if ( gBattleTarget.levelPrevious != gBattleTarget.unit.level ) { subject = &gBattleTarget; }
	ldr	r3, .L140+4	@ tmp138,
	movs	r2, r3	@ tmp141, tmp138
	adds	r2, r2, #112	@ tmp141,
	ldrb	r1, [r2]	@ tmp142,
@ SpellSystem.c:175: 	if ( gBattleTarget.levelPrevious != gBattleTarget.unit.level ) { subject = &gBattleTarget; }
	movs	r2, #8	@ tmp144,
	ldrsb	r2, [r3, r2]	@ tmp144,
@ SpellSystem.c:175: 	if ( gBattleTarget.levelPrevious != gBattleTarget.unit.level ) { subject = &gBattleTarget; }
	cmp	r1, r2	@ tmp142, tmp144
	bne	.L136		@,
@ SpellSystem.c:176: 	if ( !subject ) { return 0; } // If this isn't filled, we shouldn't show a popup.
	cmp	r0, #0	@ subject,
	bne	.L132		@,
.L134:
@ SpellSystem.c:176: 	if ( !subject ) { return 0; } // If this isn't filled, we shouldn't show a popup.
	movs	r0, #0	@ <retval>,
.L130:
@ SpellSystem.c:185: }
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L136:
@ SpellSystem.c:175: 	if ( gBattleTarget.levelPrevious != gBattleTarget.unit.level ) { subject = &gBattleTarget; }
	movs	r0, r3	@ subject, tmp138
.L132:
@ SpellSystem.c:178: 	u8* spells = SpellsGetterForLevel(&subject->unit,subject->unit.level,-1);
	movs	r1, #8	@ tmp146,
	movs	r2, #1	@,
	ldrsb	r1, [r0, r1]	@ tmp146,
	rsbs	r2, r2, #0	@,
	bl	SpellsGetterForLevel		@
@ SpellSystem.c:180: 	if ( *spells )
	ldrb	r2, [r0]	@ _12, *spells_22
@ SpellSystem.c:180: 	if ( *spells )
	cmp	r2, #0	@ _12,
	beq	.L134		@,
@ SpellSystem.c:182: 		gPopupItem = *spells|0xFF00;
	ldr	r3, .L140+8	@ tmp150,
	orrs	r3, r2	@ tmp149, _12
@ SpellSystem.c:182: 		gPopupItem = *spells|0xFF00;
	ldr	r2, .L140+12	@ tmp147,
@ SpellSystem.c:183: 		return 1;
	movs	r0, #1	@ <retval>,
@ SpellSystem.c:182: 		gPopupItem = *spells|0xFF00;
	strh	r3, [r2]	@ tmp149, gPopupItem
@ SpellSystem.c:183: 		return 1;
	b	.L130		@
.L141:
	.align	2
.L140:
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
@ SpellSystem.c:288: 	return GaidenSpellCostTable[GetItemIndex(spell)];
	ldr	r3, .L143	@ tmp118,
@ SpellSystem.c:289: }
	@ sp needed	@
@ SpellSystem.c:288: 	return GaidenSpellCostTable[GetItemIndex(spell)];
	bl	.L14		@
@ SpellSystem.c:288: 	return GaidenSpellCostTable[GetItemIndex(spell)];
	ldr	r3, .L143+4	@ tmp122,
	ldrb	r0, [r3, r0]	@ tmp121, GaidenSpellCostTable
@ SpellSystem.c:289: }
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
	.fpu softvfp
	.type	HasSufficientHP, %function
HasSufficientHP:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ SpellSystem.c:190: 	return unit->curHP > GetSpellCost(spell);
	movs	r4, #19	@ _2,
	ldrsb	r4, [r0, r4]	@ _2,* _2
@ SpellSystem.c:190: 	return unit->curHP > GetSpellCost(spell);
	movs	r0, r1	@, spell
	bl	GetSpellCost		@
@ SpellSystem.c:190: 	return unit->curHP > GetSpellCost(spell);
	movs	r3, #1	@ tmp121,
	cmp	r4, r0	@ _2, tmp130
	bgt	.L146		@,
	movs	r3, #0	@ tmp121,
.L146:
@ SpellSystem.c:191: }
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
@ UnitMenu.c:18: 	u8* validList = gGenericBuffer; // Let's build a list of valid spells.
	ldr	r6, .L159	@ validList,
@ UnitMenu.c:21: 		if ( !CanCastSpellNow(gActiveUnit,spellList[i]|0xFF00) ) { continue; }
	movs	r7, #255	@ tmp142,
@ UnitMenu.c:17: {
	movs	r5, r0	@ ivtmp.275, tmp143
	movs	r4, r6	@ validList, validList
@ UnitMenu.c:21: 		if ( !CanCastSpellNow(gActiveUnit,spellList[i]|0xFF00) ) { continue; }
	lsls	r7, r7, #8	@ tmp142, tmp142,
.L148:
@ UnitMenu.c:19: 	for ( int i = 0 ; spellList[i] ; i++ )
	ldrb	r1, [r5]	@ _9, MEM[base: _42, offset: 0B]
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
	ldrb	r1, [r4]	@ _30, MEM[base: _37, offset: 0B]
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
	ldrb	r3, [r5]	@ _6, MEM[base: _42, offset: 0B]
@ UnitMenu.c:22: 		*validList = spellList[i];
	strb	r3, [r6]	@ _6, *validList_15
@ UnitMenu.c:23: 		validList++;
	adds	r6, r6, #1	@ validList,
.L149:
	adds	r5, r5, #1	@ ivtmp.275,
	b	.L148		@
.L153:
@ UnitMenu.c:32: 		if ( HasSufficientHP(gActiveUnit,validList[i]) ) { return 1; } // We've found a spell we can cast! Return usable.
	ldr	r3, .L159+4	@ tmp139,
	ldr	r0, [r3]	@, gActiveUnit
	bl	HasSufficientHP		@
@ UnitMenu.c:32: 		if ( HasSufficientHP(gActiveUnit,validList[i]) ) { return 1; } // We've found a spell we can cast! Return usable.
	adds	r4, r4, #1	@ ivtmp.271,
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
	.fpu softvfp
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
	.fpu softvfp
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
	.fpu softvfp
	.type	SetRoundForSpell, %function
SetRoundForSpell:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ SpellSystem.c:153: 	if ( HasSufficientHP(&unit->unit,unit->weapon) )
	movs	r6, r0	@ tmp137, unit
	adds	r6, r6, #72	@ tmp137,
@ SpellSystem.c:152: {
	movs	r4, r1	@ buffer, tmp159
@ SpellSystem.c:153: 	if ( HasSufficientHP(&unit->unit,unit->weapon) )
	ldrh	r1, [r6]	@ tmp138,
@ SpellSystem.c:152: {
	movs	r5, r0	@ unit, tmp158
@ SpellSystem.c:153: 	if ( HasSufficientHP(&unit->unit,unit->weapon) )
	bl	HasSufficientHP		@
@ SpellSystem.c:153: 	if ( HasSufficientHP(&unit->unit,unit->weapon) )
	cmp	r0, #0	@ tmp160,
	beq	.L168		@,
@ SpellSystem.c:155: 		int cost = GetSpellCost(unit->weapon);
	ldrh	r0, [r6]	@ tmp142,
	bl	GetSpellCost		@
@ SpellSystem.c:157: 		buffer->attributes |= BATTLE_HIT_ATTR_HPSTEAL; // "HP drain" bit.
	movs	r3, #128	@ tmp145,
	ldr	r2, [r4]	@ tmp164,* buffer
	lsls	r3, r3, #1	@ tmp145, tmp145,
	orrs	r3, r2	@ tmp143, tmp164
	str	r3, [r4]	@ tmp143,* buffer
@ SpellSystem.c:159: 		unit->unit.curHP -= cost;
	lsls	r3, r0, #24	@ _21, tmp161,
	ldrb	r2, [r5, #19]	@ tmp148,
	lsrs	r3, r3, #24	@ _21, _21,
	subs	r2, r2, r3	@ tmp149, tmp148, _21
	strb	r2, [r5, #19]	@ tmp149, unit_8(D)->unit.curHP
@ SpellSystem.c:160: 		buffer->damage -= cost;
	ldrb	r0, [r4, #5]	@ tmp152,
	subs	r3, r0, r3	@ tmp153, tmp152, _21
	strb	r3, [r4, #5]	@ tmp153, buffer_11(D)->damage
.L167:
@ SpellSystem.c:167: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L168:
@ SpellSystem.c:165: 		buffer->attributes |= BATTLE_HIT_ATTR_5; // This bit is checked in an external hack I've made.
	movs	r3, #32	@ tmp157,
	ldr	r2, [r4]	@ tmp165,* buffer
	orrs	r3, r2	@ tmp155, tmp165
	str	r3, [r4]	@ tmp155,* buffer
@ SpellSystem.c:167: }
	b	.L167		@
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
@ SpellSystem.c:145: 	if ( GetUnitEquippedWeaponSlot(&attacker->unit) == 9 ) // Instead of checking against UsingSpellMenu, we do this to cover the case of defense.
	ldr	r3, .L172	@ tmp119,
@ SpellSystem.c:143: {
	movs	r4, r0	@ attacker, tmp120
	movs	r5, r2	@ buffer, tmp121
@ SpellSystem.c:145: 	if ( GetUnitEquippedWeaponSlot(&attacker->unit) == 9 ) // Instead of checking against UsingSpellMenu, we do this to cover the case of defense.
	bl	.L14		@
@ SpellSystem.c:145: 	if ( GetUnitEquippedWeaponSlot(&attacker->unit) == 9 ) // Instead of checking against UsingSpellMenu, we do this to cover the case of defense.
	cmp	r0, #9	@ tmp122,
	bne	.L170		@,
@ SpellSystem.c:147: 		SetRoundForSpell(attacker,buffer);
	movs	r1, r5	@, buffer
	movs	r0, r4	@, attacker
	bl	SetRoundForSpell		@
.L170:
@ SpellSystem.c:149: }
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
	.fpu softvfp
	.type	GetFirstAttackSpell, %function
GetFirstAttackSpell:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
@ SpellSystem.c:293: 	u8* spells = SpellsGetter(unit,-1);
	movs	r1, #1	@,
@ SpellSystem.c:292: {
	push	{r4, r5, r6, lr}	@
@ SpellSystem.c:293: 	u8* spells = SpellsGetter(unit,-1);
	rsbs	r1, r1, #0	@,
	bl	SpellsGetter		@
	movs	r4, r0	@ ivtmp.295, tmp126
.L175:
@ SpellSystem.c:295: 	for ( int i = 0 ; spells[i] ; i++ )
	ldrb	r0, [r4]	@ _7, MEM[base: _6, offset: 0B]
	movs	r5, r4	@ _6, ivtmp.295
@ SpellSystem.c:295: 	for ( int i = 0 ; spells[i] ; i++ )
	cmp	r0, #0	@ _7,
	beq	.L174		@,
@ SpellSystem.c:297: 		if ( GetItemType(spells[i]) != ITYPE_STAFF ) { spell = spells[i]; break; } // Ensure that the spell we could counter with would be an attack spell.
	ldr	r3, .L180	@ tmp123,
	bl	.L14		@
@ SpellSystem.c:297: 		if ( GetItemType(spells[i]) != ITYPE_STAFF ) { spell = spells[i]; break; } // Ensure that the spell we could counter with would be an attack spell.
	adds	r4, r4, #1	@ ivtmp.295,
	cmp	r0, #4	@ tmp127,
	beq	.L175		@,
@ SpellSystem.c:297: 		if ( GetItemType(spells[i]) != ITYPE_STAFF ) { spell = spells[i]; break; } // Ensure that the spell we could counter with would be an attack spell.
	ldrb	r0, [r5]	@ <retval>, *_6
.L174:
@ SpellSystem.c:300: }
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
	.fpu softvfp
	.type	NewGetUnitEquippedWeapon, %function
NewGetUnitEquippedWeapon:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ SpellSystem.c:45: {
	movs	r6, r0	@ unit, tmp163
@ SpellSystem.c:260: 	for ( int i = 0 ; i < 5 ; i++ )
	movs	r5, #0	@ i,
.L185:
@ SpellSystem.c:262: 		if ( CanUnitUseWeapon(unit,unit->items[i]) ) { return unit->items[i]; }
	movs	r3, r6	@ tmp135, unit
@ SpellSystem.c:262: 		if ( CanUnitUseWeapon(unit,unit->items[i]) ) { return unit->items[i]; }
	lsls	r2, r5, #1	@ tmp136, i,
@ SpellSystem.c:262: 		if ( CanUnitUseWeapon(unit,unit->items[i]) ) { return unit->items[i]; }
	adds	r3, r3, #30	@ tmp135,
	ldrh	r1, [r3, r2]	@ MEM[base: _28, index: _37, offset: 0B], MEM[base: _28, index: _37, offset: 0B]
	movs	r0, r6	@, unit
	ldr	r3, .L200	@ tmp138,
	bl	.L14		@
	subs	r4, r0, #0	@ <retval>, tmp164,
@ SpellSystem.c:262: 		if ( CanUnitUseWeapon(unit,unit->items[i]) ) { return unit->items[i]; }
	beq	.L183		@,
@ SpellSystem.c:262: 		if ( CanUnitUseWeapon(unit,unit->items[i]) ) { return unit->items[i]; }
	adds	r5, r5, #12	@ tmp139,
	lsls	r5, r5, #1	@ tmp140, tmp139,
	adds	r5, r6, r5	@ tmp141, unit, tmp140
	ldrh	r4, [r5, #6]	@ <retval>, *unit_19(D)
.L184:
@ SpellSystem.c:47: 	if ( gChapterData.currentPhase == ( unit->index & 0xC0 ) )
	ldr	r3, .L200+4	@ tmp143,
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
	ldr	r3, .L200+8	@ tmp147,
@ SpellSystem.c:50: 		if ( !UsingSpellMenu ) { return vanillaEquipped; }
	ldrb	r3, [r3]	@ UsingSpellMenu, UsingSpellMenu
	cmp	r3, #0	@ UsingSpellMenu,
	beq	.L182		@,
@ SpellSystem.c:54: 			if ( unit->index == gBattleTarget.unit.index && GetItemType(SelectedSpell) == ITYPE_STAFF )
	ldr	r3, .L200+12	@ tmp149,
@ SpellSystem.c:54: 			if ( unit->index == gBattleTarget.unit.index && GetItemType(SelectedSpell) == ITYPE_STAFF )
	ldrb	r3, [r3, #11]	@ tmp150,
	lsls	r3, r3, #24	@ tmp150, tmp150,
	ldr	r5, .L200+16	@ tmp162,
	asrs	r3, r3, #24	@ tmp150, tmp150,
	cmp	r3, r2	@ tmp150, _3
	beq	.L188		@,
.L189:
@ SpellSystem.c:57: 			} else { return SelectedSpell|0xFF00; }
	movs	r4, #255	@ tmp153,
	ldrb	r0, [r5]	@ SelectedSpell, SelectedSpell
	lsls	r4, r4, #8	@ tmp153, tmp153,
	orrs	r4, r0	@ <retval>, SelectedSpell
.L182:
@ SpellSystem.c:72: }
	movs	r0, r4	@, <retval>
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L183:
@ SpellSystem.c:260: 	for ( int i = 0 ; i < 5 ; i++ )
	adds	r5, r5, #1	@ i,
@ SpellSystem.c:260: 	for ( int i = 0 ; i < 5 ; i++ )
	cmp	r5, #5	@ i,
	bne	.L185		@,
	b	.L184		@
.L188:
@ SpellSystem.c:54: 			if ( unit->index == gBattleTarget.unit.index && GetItemType(SelectedSpell) == ITYPE_STAFF )
	ldrb	r0, [r5]	@ SelectedSpell, SelectedSpell
	ldr	r3, .L200+20	@ tmp156,
	bl	.L14		@
@ SpellSystem.c:54: 			if ( unit->index == gBattleTarget.unit.index && GetItemType(SelectedSpell) == ITYPE_STAFF )
	cmp	r0, #4	@ tmp165,
	bne	.L189		@,
	b	.L182		@
.L186:
@ SpellSystem.c:64: 		if ( GetUnitEquippedWeaponSlot(unit) == 9 )
	movs	r0, r6	@, unit
	ldr	r3, .L200+24	@ tmp157,
	bl	.L14		@
@ SpellSystem.c:64: 		if ( GetUnitEquippedWeaponSlot(unit) == 9 )
	cmp	r0, #9	@ tmp166,
	bne	.L182		@,
@ SpellSystem.c:67: 			int spell = GetFirstAttackSpell(unit);
	movs	r0, r6	@, unit
	bl	GetFirstAttackSpell		@
	subs	r4, r0, #0	@ <retval>, tmp167,
@ SpellSystem.c:68: 			return ( spell ? spell|0xFF00 : 0 );
	beq	.L182		@,
@ SpellSystem.c:68: 			return ( spell ? spell|0xFF00 : 0 );
	movs	r3, #255	@ tmp160,
	lsls	r3, r3, #8	@ tmp160, tmp160,
	orrs	r4, r3	@ <retval>, tmp160
	b	.L182		@
.L201:
	.align	2
.L200:
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
	.fpu softvfp
	.type	NewGetUnitEquippedWeaponSlot, %function
NewGetUnitEquippedWeaponSlot:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r0, r1, r2, r4, r5, r6, r7, lr}	@
@ SpellSystem.c:77: 	if ( UsingSpellMenu && unit->index == gBattleActor.unit.index && CanUnitUseWeapon(unit,SelectedSpell) ) { return 9; }
	ldr	r3, .L219	@ tmp144,
@ SpellSystem.c:77: 	if ( UsingSpellMenu && unit->index == gBattleActor.unit.index && CanUnitUseWeapon(unit,SelectedSpell) ) { return 9; }
	ldrb	r3, [r3]	@ UsingSpellMenu, UsingSpellMenu
@ SpellSystem.c:75: {
	movs	r5, r0	@ unit, tmp185
	ldr	r6, .L219+4	@ tmp181,
@ SpellSystem.c:77: 	if ( UsingSpellMenu && unit->index == gBattleActor.unit.index && CanUnitUseWeapon(unit,SelectedSpell) ) { return 9; }
	cmp	r3, #0	@ UsingSpellMenu,
	bne	.L203		@,
.L206:
@ SpellSystem.c:79: 	if ( (gBattleStats.config & (BATTLE_CONFIG_REAL|BATTLE_CONFIG_SIMULATE)) && unit->index == gBattleTarget.unit.index )
	ldr	r7, .L219+8	@ tmp146,
@ SpellSystem.c:79: 	if ( (gBattleStats.config & (BATTLE_CONFIG_REAL|BATTLE_CONFIG_SIMULATE)) && unit->index == gBattleTarget.unit.index )
	ldrh	r2, [r7]	@ gBattleStats, gBattleStats
	movs	r1, r5	@ tmp183, unit
	movs	r3, #3	@ tmp150,
	movs	r4, r2	@ tmp152, gBattleStats
	adds	r1, r1, #30	@ tmp183,
	str	r1, [sp, #4]	@ tmp183, %sfp
	ands	r4, r3	@ tmp152, tmp150
	tst	r2, r3	@ gBattleStats, tmp150
	bne	.L204		@,
.L211:
@ SpellSystem.c:102: 			if ( CanUnitUseWeapon(unit,unit->items[i]) ) { return i; }
	ldr	r2, [sp, #4]	@ tmp183, %sfp
@ SpellSystem.c:102: 			if ( CanUnitUseWeapon(unit,unit->items[i]) ) { return i; }
	lsls	r3, r4, #1	@ tmp177, <retval>,
@ SpellSystem.c:102: 			if ( CanUnitUseWeapon(unit,unit->items[i]) ) { return i; }
	movs	r0, r5	@, unit
	ldrh	r1, [r2, r3]	@ MEM[base: _41, index: _48, offset: 0B], MEM[base: _41, index: _48, offset: 0B]
	bl	.L15		@
@ SpellSystem.c:102: 			if ( CanUnitUseWeapon(unit,unit->items[i]) ) { return i; }
	cmp	r0, #0	@ tmp190,
	bne	.L202		@,
@ SpellSystem.c:100: 		for ( int i = 0 ; i < 5 ; i++ )
	adds	r4, r4, #1	@ <retval>,
@ SpellSystem.c:100: 		for ( int i = 0 ; i < 5 ; i++ )
	cmp	r4, #5	@ <retval>,
	bne	.L211		@,
	b	.L212		@
.L203:
@ SpellSystem.c:77: 	if ( UsingSpellMenu && unit->index == gBattleActor.unit.index && CanUnitUseWeapon(unit,SelectedSpell) ) { return 9; }
	movs	r2, #11	@ tmp155,
	ldr	r3, .L219+12	@ tmp154,
	ldrb	r3, [r3, #11]	@ tmp156,
	ldrsb	r2, [r0, r2]	@ tmp155,
	lsls	r3, r3, #24	@ tmp156, tmp156,
	asrs	r3, r3, #24	@ tmp156, tmp156,
	cmp	r2, r3	@ tmp155, tmp156
	bne	.L206		@,
@ SpellSystem.c:77: 	if ( UsingSpellMenu && unit->index == gBattleActor.unit.index && CanUnitUseWeapon(unit,SelectedSpell) ) { return 9; }
	ldr	r3, .L219+16	@ tmp157,
	ldrb	r1, [r3]	@ SelectedSpell, SelectedSpell
	bl	.L15		@
@ SpellSystem.c:77: 	if ( UsingSpellMenu && unit->index == gBattleActor.unit.index && CanUnitUseWeapon(unit,SelectedSpell) ) { return 9; }
	cmp	r0, #0	@ tmp186,
	beq	.L206		@,
.L207:
@ SpellSystem.c:77: 	if ( UsingSpellMenu && unit->index == gBattleActor.unit.index && CanUnitUseWeapon(unit,SelectedSpell) ) { return 9; }
	movs	r4, #9	@ <retval>,
	b	.L202		@
.L204:
@ SpellSystem.c:79: 	if ( (gBattleStats.config & (BATTLE_CONFIG_REAL|BATTLE_CONFIG_SIMULATE)) && unit->index == gBattleTarget.unit.index )
	movs	r2, #11	@ tmp161,
	ldr	r3, .L219+20	@ tmp160,
	ldrb	r3, [r3, #11]	@ tmp162,
	ldrsb	r2, [r5, r2]	@ tmp161,
	lsls	r3, r3, #24	@ tmp162, tmp162,
	movs	r4, #0	@ <retval>,
	asrs	r3, r3, #24	@ tmp162, tmp162,
	cmp	r2, r3	@ tmp161, tmp162
	bne	.L211		@,
@ SpellSystem.c:81: 		int spell = GetFirstAttackSpell(unit);
	movs	r0, r5	@, unit
	bl	GetFirstAttackSpell		@
	str	r0, [sp]	@ tmp187, %sfp
.L210:
@ SpellSystem.c:86: 			if ( CanUnitUseWeapon(unit,unit->items[i]) )
	ldr	r2, [sp, #4]	@ tmp183, %sfp
@ SpellSystem.c:86: 			if ( CanUnitUseWeapon(unit,unit->items[i]) )
	lsls	r3, r4, #1	@ tmp164, <retval>,
@ SpellSystem.c:86: 			if ( CanUnitUseWeapon(unit,unit->items[i]) )
	movs	r0, r5	@, unit
	ldrh	r1, [r2, r3]	@ MEM[base: _49, index: _23, offset: 0B], MEM[base: _49, index: _23, offset: 0B]
	bl	.L15		@
@ SpellSystem.c:86: 			if ( CanUnitUseWeapon(unit,unit->items[i]) )
	cmp	r0, #0	@ tmp188,
	beq	.L208		@,
@ SpellSystem.c:89: 				if ( !gCan_Attack_Target(unit->items[i],gBattleStats.range,unit) )
	movs	r3, r4	@ tmp169, <retval>
	adds	r3, r3, #12	@ tmp169,
	lsls	r3, r3, #1	@ tmp170, tmp169,
	adds	r3, r5, r3	@ tmp171, unit, tmp170
@ SpellSystem.c:89: 				if ( !gCan_Attack_Target(unit->items[i],gBattleStats.range,unit) )
	ldrh	r0, [r3, #6]	@ tmp173, *unit_32(D)
	ldr	r3, .L219+24	@ tmp174,
	movs	r2, r5	@, unit
	ldrb	r1, [r7, #2]	@ tmp168,
	ldr	r3, [r3]	@ gCan_Attack_Target, gCan_Attack_Target
	bl	.L14		@
@ SpellSystem.c:89: 				if ( !gCan_Attack_Target(unit->items[i],gBattleStats.range,unit) )
	cmp	r0, #0	@ tmp189,
	bne	.L202		@,
@ SpellSystem.c:91: 					return ( spell ? 9 : i );
	ldr	r3, [sp]	@ spell, %sfp
	cmp	r3, #0	@ spell,
	bne	.L207		@,
.L202:
@ SpellSystem.c:106: }
	@ sp needed	@
	movs	r0, r4	@, <retval>
	pop	{r1, r2, r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L208:
@ SpellSystem.c:84: 		for ( int i = 0 ; i < 5 ; i++ )
	adds	r4, r4, #1	@ <retval>,
@ SpellSystem.c:84: 		for ( int i = 0 ; i < 5 ; i++ )
	cmp	r4, #5	@ <retval>,
	bne	.L210		@,
@ SpellSystem.c:96: 		return ( spell ? 9 : -1 );
	ldr	r3, [sp]	@ spell, %sfp
	cmp	r3, #0	@ spell,
	bne	.L207		@,
.L212:
@ SpellSystem.c:96: 		return ( spell ? 9 : -1 );
	movs	r4, #1	@ <retval>,
	rsbs	r4, r4, #0	@ <retval>, <retval>
	b	.L202		@
.L220:
	.align	2
.L219:
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
	.fpu softvfp
	.type	Target_Routine_For_Fortify, %function
Target_Routine_For_Fortify:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ SpellSystem.c:305: 	if ( UsingSpellMenu )
	ldr	r3, .L224	@ tmp123,
@ SpellSystem.c:305: 	if ( UsingSpellMenu )
	ldrb	r3, [r3]	@ UsingSpellMenu, UsingSpellMenu
	cmp	r3, #0	@ UsingSpellMenu,
	beq	.L222		@,
@ SpellSystem.c:307: 		item = SelectedSpell|0xFF00;
	ldr	r3, .L224+4	@ tmp125,
	ldrb	r2, [r3]	@ SelectedSpell, SelectedSpell
@ SpellSystem.c:307: 		item = SelectedSpell|0xFF00;
	movs	r3, #255	@ tmp128,
	lsls	r3, r3, #8	@ tmp128, tmp128,
	orrs	r2, r3	@ item, tmp128
.L223:
@ SpellSystem.c:313: 	gHealStaff_RangeSetup(unit,0,item);
	ldr	r3, .L224+8	@ tmp137,
@ SpellSystem.c:314: }
	@ sp needed	@
@ SpellSystem.c:313: 	gHealStaff_RangeSetup(unit,0,item);
	movs	r1, #0	@,
	ldr	r3, [r3]	@ gHealStaff_RangeSetup, gHealStaff_RangeSetup
	bl	.L14		@
@ SpellSystem.c:314: }
	pop	{r4}
	pop	{r0}
	bx	r0
.L222:
@ SpellSystem.c:311: 		item = unit->unit.items[gActionData.itemSlotIndex];
	ldr	r3, .L224+12	@ tmp131,
	ldrb	r3, [r3, #18]	@ tmp132,
@ SpellSystem.c:311: 		item = unit->unit.items[gActionData.itemSlotIndex];
	adds	r3, r3, #12	@ tmp133,
	lsls	r3, r3, #1	@ tmp134, tmp133,
	adds	r3, r0, r3	@ tmp135, unit, tmp134
	ldrh	r2, [r3, #6]	@ item, *unit_11(D)
	b	.L223		@
.L225:
	.align	2
.L224:
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
@ SpellSystem.c:318: 	UsingSpellMenu = 0;
	movs	r3, #0	@ tmp114,
@ SpellSystem.c:321: }
	@ sp needed	@
@ SpellSystem.c:318: 	UsingSpellMenu = 0;
	ldr	r2, .L227	@ tmp113,
	strb	r3, [r2]	@ tmp114, UsingSpellMenu
@ SpellSystem.c:319: 	SelectedSpell = 0;
	ldr	r2, .L227+4	@ tmp116,
	strb	r3, [r2]	@ tmp114, SelectedSpell
@ SpellSystem.c:320: 	DidSelectSpell = 0;
	ldr	r2, .L227+8	@ tmp119,
	strb	r3, [r2]	@ tmp114, DidSelectSpell
@ SpellSystem.c:321: }
	bx	lr
.L228:
	.align	2
.L227:
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
	ldr	r3, .L245	@ tmp130,
@ RangeDisplay.c:40: {
	str	r1, [sp, #4]	@ tmp139, %sfp
@ RangeDisplay.c:42: 	u8* spells = SpellsGetter(unit,(UsingSpellMenu ? UsingSpellMenu : -1)); // If UsingSpellMenu is nonzero, only get Gaiden spells of that type.
	ldrb	r1, [r3]	@ UsingSpellMenu.67_1, UsingSpellMenu
@ RangeDisplay.c:40: {
	movs	r7, r0	@ unit, tmp138
@ RangeDisplay.c:42: 	u8* spells = SpellsGetter(unit,(UsingSpellMenu ? UsingSpellMenu : -1)); // If UsingSpellMenu is nonzero, only get Gaiden spells of that type.
	cmp	r1, #0	@ UsingSpellMenu.67_1,
	bne	.L230		@,
	subs	r1, r1, #1	@ iftmp.66_16,
.L230:
@ RangeDisplay.c:41: 	long long current = 0;
	movs	r5, #0	@ <retval>,
@ RangeDisplay.c:42: 	u8* spells = SpellsGetter(unit,(UsingSpellMenu ? UsingSpellMenu : -1)); // If UsingSpellMenu is nonzero, only get Gaiden spells of that type.
	movs	r0, r7	@, unit
	bl	SpellsGetter		@
@ RangeDisplay.c:41: 	long long current = 0;
	movs	r4, r5	@ <retval>, <retval>
@ RangeDisplay.c:42: 	u8* spells = SpellsGetter(unit,(UsingSpellMenu ? UsingSpellMenu : -1)); // If UsingSpellMenu is nonzero, only get Gaiden spells of that type.
	str	r0, [sp]	@ tmp140, %sfp
.L231:
@ RangeDisplay.c:43: 	for ( int i = 0 ; spells[i] ; i++ )
	ldr	r3, [sp]	@ ivtmp.338, %sfp
	ldrb	r6, [r3]	@ _12, MEM[base: _36, offset: 0B]
@ RangeDisplay.c:43: 	for ( int i = 0 ; spells[i] ; i++ )
	cmp	r6, #0	@ _12,
	bne	.L234		@,
@ RangeDisplay.c:56: }
	movs	r0, r5	@, <retval>
	movs	r1, r4	@, <retval>
	add	sp, sp, #12	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7}
	pop	{r2}
	bx	r2
.L234:
@ RangeDisplay.c:45: 		int spell = spells[i]|0xFF00;
	movs	r3, #255	@ tmp163,
	lsls	r3, r3, #8	@ tmp163, tmp163,
	orrs	r6, r3	@ spell, tmp163
@ RangeDisplay.c:46: 		if ( usability == NULL )
	ldr	r3, [sp, #4]	@ usability, %sfp
@ RangeDisplay.c:48: 			if ( CanCastSpell(unit,spell) ) { current = IncorporateNewRange(current,gGet_Item_Range(unit,spell)); }
	movs	r1, r6	@, spell
	movs	r0, r7	@, unit
@ RangeDisplay.c:46: 		if ( usability == NULL )
	cmp	r3, #0	@ usability,
	bne	.L232		@,
@ RangeDisplay.c:48: 			if ( CanCastSpell(unit,spell) ) { current = IncorporateNewRange(current,gGet_Item_Range(unit,spell)); }
	bl	CanCastSpell		@
.L244:
@ RangeDisplay.c:52: 			if ( usability(unit,spell) ) { current = IncorporateNewRange(current,gGet_Item_Range(unit,spell)); }
	cmp	r0, #0	@ tmp144,
	beq	.L233		@,
@ RangeDisplay.c:52: 			if ( usability(unit,spell) ) { current = IncorporateNewRange(current,gGet_Item_Range(unit,spell)); }
	ldr	r3, .L245+4	@ tmp134,
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
.L233:
	ldr	r3, [sp]	@ ivtmp.338, %sfp
	adds	r3, r3, #1	@ ivtmp.338,
	str	r3, [sp]	@ ivtmp.338, %sfp
	b	.L231		@
.L232:
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
	bcc	.L248		@,
@ RangeDisplay.c:10: 	long long current = 0;
	movs	r5, #0	@ <retval>,
	movs	r3, r0	@ _19, unit
	movs	r7, r0	@ ivtmp.347, unit
	movs	r4, r5	@ <retval>, <retval>
	adds	r3, r3, #40	@ _19,
	str	r3, [sp, #12]	@ _19, %sfp
	adds	r7, r7, #30	@ ivtmp.347,
.L249:
@ RangeDisplay.c:14: 		for ( int i = 0 ; i < 5 && unit->items[i] ; i++ )
	ldrh	r1, [r7]	@ _10, MEM[base: _38, offset: 0B]
@ RangeDisplay.c:14: 		for ( int i = 0 ; i < 5 && unit->items[i] ; i++ )
	cmp	r1, #0	@ _10,
	beq	.L251		@,
@ RangeDisplay.c:16: 			if ( usability(unit,unit->items[i]) )
	movs	r0, r6	@, unit
	ldr	r3, [sp, #8]	@ usability, %sfp
	bl	.L14		@
@ RangeDisplay.c:16: 			if ( usability(unit,unit->items[i]) )
	cmp	r0, #0	@ tmp150,
	beq	.L250		@,
@ RangeDisplay.c:18: 				current = IncorporateNewRange(current,gGet_Item_Range(unit,unit->items[i]));
	ldr	r3, .L259	@ tmp137,
	movs	r0, r6	@, unit
	ldr	r3, [r3]	@ gGet_Item_Range, gGet_Item_Range
	ldrh	r1, [r7]	@ MEM[base: _38, offset: 0B], MEM[base: _38, offset: 0B]
	bl	.L14		@
	movs	r2, r0	@ _9, tmp163
	movs	r3, r1	@ _9, tmp164
	movs	r0, r5	@, <retval>
	movs	r1, r4	@, <retval>
	bl	IncorporateNewRange		@
	movs	r5, r0	@ <retval>, tmp165
	movs	r4, r1	@ <retval>, tmp166
.L250:
@ RangeDisplay.c:14: 		for ( int i = 0 ; i < 5 && unit->items[i] ; i++ )
	ldr	r3, [sp, #12]	@ _19, %sfp
	adds	r7, r7, #2	@ ivtmp.347,
	cmp	r7, r3	@ ivtmp.347, _19
	bne	.L249		@,
.L251:
@ RangeDisplay.c:21: 		return ( slot == -1 ? IncorporateNewRange(current,GetUnitRangeMaskForSpells(unit,usability)) : current );
	ldr	r3, [sp, #4]	@ slot, %sfp
	adds	r3, r3, #1	@ tmp176, slot,
	bne	.L247		@,
@ RangeDisplay.c:21: 		return ( slot == -1 ? IncorporateNewRange(current,GetUnitRangeMaskForSpells(unit,usability)) : current );
	movs	r0, r6	@, unit
	ldr	r1, [sp, #8]	@, %sfp
	bl	GetUnitRangeMaskForSpells		@
	movs	r2, r0	@ _11, tmp167
	movs	r3, r1	@ _11, tmp168
	movs	r0, r5	@, <retval>
	movs	r1, r4	@, <retval>
	bl	IncorporateNewRange		@
.L258:
@ RangeDisplay.c:33: 			return GetUnitRangeMaskForSpells(unit,usability);
	movs	r5, r0	@ <retval>, tmp173
	movs	r4, r1	@ <retval>, tmp174
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
	movs	r1, r3	@ slot, slot
	adds	r1, r1, #12	@ slot,
@ RangeDisplay.c:28: 			return gGet_Item_Range(unit,unit->items[slot]);
	ldr	r3, .L259	@ tmp144,
@ RangeDisplay.c:28: 			return gGet_Item_Range(unit,unit->items[slot]);
	lsls	r1, r1, #1	@ tmp140, tmp139,
	adds	r1, r0, r1	@ tmp141, unit, tmp140
@ RangeDisplay.c:28: 			return gGet_Item_Range(unit,unit->items[slot]);
	ldr	r3, [r3]	@ gGet_Item_Range, gGet_Item_Range
	ldrh	r1, [r1, #6]	@ tmp143, *unit_26(D)
	bl	.L14		@
	b	.L258		@
.L254:
@ RangeDisplay.c:33: 			return GetUnitRangeMaskForSpells(unit,usability);
	ldr	r1, [sp, #8]	@, %sfp
	bl	GetUnitRangeMaskForSpells		@
	b	.L258		@
.L260:
	.align	2
.L259:
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
	ldr	r4, .L262	@ tmp123,
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
.L263:
	.align	2
.L262:
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
@ UnitMenu.c:73: 	UsingSpellMenu = BLACK_MAGIC;
	movs	r5, #1	@ tmp122,
	ldr	r3, .L268	@ tmp121,
	strb	r5, [r3]	@ tmp122, UsingSpellMenu
@ UnitMenu.c:74: 	BmMapFill(gMapMovement,-1);
	ldr	r3, .L268+4	@ tmp124,
	ldr	r4, .L268+8	@ tmp125,
	ldr	r0, [r3]	@, gMapMovement
	movs	r1, #255	@,
	bl	.L16		@
@ UnitMenu.c:75: 	BmMapFill(gMapRange,0);
	ldr	r3, .L268+12	@ tmp126,
	movs	r1, #0	@,
	ldr	r0, [r3]	@, gMapRange
	bl	.L16		@
@ UnitMenu.c:76: 	if ( CanUseAttackSpellsNow(gActiveUnit,BLACK_MAGIC) ) // If we can use an attack spell now, display the red range.
	ldr	r4, .L268+16	@ tmp128,
	movs	r1, r5	@, tmp122
	ldr	r0, [r4]	@, gActiveUnit
	bl	CanUseAttackSpellsNow		@
	ldr	r5, .L268+20	@ tmp136,
@ UnitMenu.c:76: 	if ( CanUseAttackSpellsNow(gActiveUnit,BLACK_MAGIC) ) // If we can use an attack spell now, display the red range.
	cmp	r0, #0	@ tmp137,
	beq	.L265		@,
@ UnitMenu.c:78: 		All_Spells_One_Square(gActiveUnit,&RangeUsabilityCheckNotStaff);
	ldr	r0, [r4]	@, gActiveUnit
	ldr	r1, .L268+24	@,
	bl	All_Spells_One_Square		@
@ UnitMenu.c:79: 		DisplayMoveRangeGraphics(3);
	movs	r0, #3	@,
.L267:
@ UnitMenu.c:90: }
	@ sp needed	@
@ UnitMenu.c:84: 		DisplayMoveRangeGraphics(5);
	bl	.L270		@
@ UnitMenu.c:90: }
	movs	r0, #0	@,
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L265:
@ UnitMenu.c:83: 		All_Spells_One_Square(gActiveUnit,&RangeUsabilityCheckStaff);
	ldr	r0, [r4]	@, gActiveUnit
	ldr	r1, .L268+28	@,
	bl	All_Spells_One_Square		@
@ UnitMenu.c:84: 		DisplayMoveRangeGraphics(5);
	movs	r0, #5	@,
	b	.L267		@
.L269:
	.align	2
.L268:
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
@ UnitMenu.c:94: 	UsingSpellMenu = WHITE_MAGIC;
	movs	r5, #2	@ tmp122,
	ldr	r3, .L275	@ tmp121,
	strb	r5, [r3]	@ tmp122, UsingSpellMenu
@ UnitMenu.c:95: 	BmMapFill(gMapMovement,-1);
	ldr	r3, .L275+4	@ tmp124,
	ldr	r4, .L275+8	@ tmp125,
	ldr	r0, [r3]	@, gMapMovement
	movs	r1, #255	@,
	bl	.L16		@
@ UnitMenu.c:96: 	BmMapFill(gMapRange,0);
	ldr	r3, .L275+12	@ tmp126,
	movs	r1, #0	@,
	ldr	r0, [r3]	@, gMapRange
	bl	.L16		@
@ UnitMenu.c:97: 	if ( CanUseAttackSpellsNow(gActiveUnit,WHITE_MAGIC) ) // If we can use an attack spell now, display the red range.
	ldr	r4, .L275+16	@ tmp128,
	movs	r1, r5	@, tmp122
	ldr	r0, [r4]	@, gActiveUnit
	bl	CanUseAttackSpellsNow		@
	ldr	r5, .L275+20	@ tmp136,
@ UnitMenu.c:97: 	if ( CanUseAttackSpellsNow(gActiveUnit,WHITE_MAGIC) ) // If we can use an attack spell now, display the red range.
	cmp	r0, #0	@ tmp137,
	beq	.L272		@,
@ UnitMenu.c:99: 		All_Spells_One_Square(gActiveUnit,&RangeUsabilityCheckNotStaff);
	ldr	r0, [r4]	@, gActiveUnit
	ldr	r1, .L275+24	@,
	bl	All_Spells_One_Square		@
@ UnitMenu.c:100: 		DisplayMoveRangeGraphics(3);
	movs	r0, #3	@,
.L274:
@ UnitMenu.c:108: }
	@ sp needed	@
@ UnitMenu.c:105: 		DisplayMoveRangeGraphics(5);
	bl	.L270		@
@ UnitMenu.c:108: }
	movs	r0, #0	@,
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L272:
@ UnitMenu.c:104: 		All_Spells_One_Square(gActiveUnit,&RangeUsabilityCheckStaff);
	ldr	r0, [r4]	@, gActiveUnit
	ldr	r1, .L275+28	@,
	bl	All_Spells_One_Square		@
@ UnitMenu.c:105: 		DisplayMoveRangeGraphics(5);
	movs	r0, #5	@,
	b	.L274		@
.L276:
	.align	2
.L275:
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
	ldr	r7, .L285	@ tmp133,
	ldr	r4, .L285+4	@ tmp135,
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
	bne	.L278		@,
.L280:
@ SpellMenu.c:6: 	if ( !spell ) { return 3; }
	movs	r0, #3	@ <retval>,
.L277:
@ SpellMenu.c:11: }
	@ sp needed	@
	pop	{r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L278:
@ SpellMenu.c:8: 	if ( !CanCastSpellNow(gActiveUnit,spell) ) { return 3; }
	movs	r1, r5	@, spell
	ldr	r0, [r4]	@, gActiveUnit
	bl	CanCastSpellNow		@
@ SpellMenu.c:8: 	if ( !CanCastSpellNow(gActiveUnit,spell) ) { return 3; }
	cmp	r0, #0	@ tmp147,
	beq	.L280		@,
@ SpellMenu.c:10: 	return ( HasSufficientHP(gActiveUnit,spell) ? 1 : 2 );
	movs	r1, r5	@, spell
	ldr	r0, [r4]	@, gActiveUnit
	bl	HasSufficientHP		@
@ SpellMenu.c:10: 	return ( HasSufficientHP(gActiveUnit,spell) ? 1 : 2 );
	rsbs	r3, r0, #0	@ tmp143, tmp148
	adcs	r0, r0, r3	@ tmp142, tmp148, tmp143
	adds	r0, r0, #1	@ <retval>,
	b	.L277		@
.L286:
	.align	2
.L285:
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
@ SpellMenu.c:14: {
	movs	r4, r1	@ menuCommand, tmp167
@ SpellMenu.c:22: }
	@ sp needed	@
@ SpellMenu.c:16: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,menuCommand->commandDefinitionIndex,UsingSpellMenu)];
	ldr	r6, .L288	@ tmp145,
	ldr	r7, .L288+4	@ tmp143,
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
	movs	r5, r0	@ _4, tmp168
@ SpellMenu.c:16: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,menuCommand->commandDefinitionIndex,UsingSpellMenu)];
	ldr	r0, [r6]	@, gActiveUnit
	bl	GetNthUsableSpell		@
@ SpellMenu.c:16: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,menuCommand->commandDefinitionIndex,UsingSpellMenu)];
	ldrb	r5, [r5, r0]	@ _13, *_12
@ SpellMenu.c:18: 	int canUse = HasSufficientHP(gActiveUnit,spell);
	ldr	r0, [r6]	@, gActiveUnit
	movs	r1, r5	@, _13
	bl	HasSufficientHP		@
	movs	r2, r0	@ canUse, tmp170
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
	ldr	r1, .L288+8	@ tmp160,
	lsls	r3, r3, #1	@ tmp158, tmp157,
	adds	r3, r3, r1	@ tmp159, tmp158, tmp160
	ldr	r4, .L288+12	@ tmp164,
	movs	r1, r5	@ tmp161, _13
@ SpellMenu.c:19: 	DrawItemMenuCommand(&menuCommand->text,spell,canUse,&gBg0MapBuffer[menuCommand->yDrawTile * 32 + menuCommand->xDrawTile]);
	adds	r0, r0, #52	@ menuCommand,
@ SpellMenu.c:19: 	DrawItemMenuCommand(&menuCommand->text,spell,canUse,&gBg0MapBuffer[menuCommand->yDrawTile * 32 + menuCommand->xDrawTile]);
	bl	.L16		@
@ SpellMenu.c:20: 	EnableBgSyncByMask(1);
	movs	r0, #1	@,
	ldr	r3, .L288+16	@ tmp165,
	bl	.L14		@
@ SpellMenu.c:22: }
	movs	r0, #0	@,
	pop	{r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L289:
	.align	2
.L288:
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
	push	{r4, lr}	@
@ SpellMenu.c:26: 	FillBgMap(gBg2MapBuffer,0);
	movs	r1, #0	@,
@ SpellMenu.c:35: }
	@ sp needed	@
@ SpellMenu.c:26: 	FillBgMap(gBg2MapBuffer,0);
	ldr	r0, .L291	@,
	ldr	r3, .L291+4	@ tmp120,
	bl	.L14		@
@ SpellMenu.c:27: 	EnableBgSyncByMask(4);
	movs	r0, #4	@,
	ldr	r3, .L291+8	@ tmp121,
	bl	.L14		@
@ SpellMenu.c:28: 	Text_ResetTileAllocation();
	ldr	r3, .L291+12	@ tmp122,
	bl	.L14		@
@ SpellMenu.c:30: 	StartMenu_AndDoSomethingCommands(&gMenu_UnitMenu,gGameState._unk1C.x - gGameState.cameraRealPos.x,1,16);
	ldr	r3, .L291+16	@ tmp123,
	ldrh	r1, [r3, #28]	@ tmp124,
@ SpellMenu.c:30: 	StartMenu_AndDoSomethingCommands(&gMenu_UnitMenu,gGameState._unk1C.x - gGameState.cameraRealPos.x,1,16);
	ldrh	r3, [r3, #12]	@ tmp126,
@ SpellMenu.c:30: 	StartMenu_AndDoSomethingCommands(&gMenu_UnitMenu,gGameState._unk1C.x - gGameState.cameraRealPos.x,1,16);
	movs	r2, #1	@,
	subs	r1, r1, r3	@ tmp127, tmp124, tmp126
	ldr	r4, .L291+20	@ tmp129,
	movs	r3, #16	@,
	ldr	r0, .L291+24	@,
	bl	.L16		@
@ SpellMenu.c:31: 	HideMoveRangeGraphics();
	ldr	r3, .L291+28	@ tmp130,
	bl	.L14		@
@ SpellMenu.c:32: 	SelectedSpell = 0;
	movs	r3, #0	@ tmp132,
	ldr	r2, .L291+32	@ tmp131,
	strb	r3, [r2]	@ tmp132, SelectedSpell
@ SpellMenu.c:33: 	UsingSpellMenu = 0;
	ldr	r2, .L291+36	@ tmp134,
@ SpellMenu.c:35: }
	movs	r0, #59	@,
@ SpellMenu.c:33: 	UsingSpellMenu = 0;
	strb	r3, [r2]	@ tmp132, UsingSpellMenu
@ SpellMenu.c:35: }
	pop	{r4}
	pop	{r1}
	bx	r1
.L292:
	.align	2
.L291:
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
	.fpu softvfp
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
	bne	.L294		@,
@ SpellMenu.c:42: 		MenuCallHelpBox(proc,gGaidenMagicSpellMenuErrorText);
	ldr	r3, .L298	@ tmp133,
	ldrh	r1, [r3]	@ gGaidenMagicSpellMenuErrorText, gGaidenMagicSpellMenuErrorText
	ldr	r3, .L298+4	@ tmp135,
	bl	.L14		@
@ SpellMenu.c:43: 		return 0x08;
	movs	r0, #8	@ <retval>,
.L293:
@ SpellMenu.c:63: }
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L294:
@ SpellMenu.c:48: 		gActionData.itemSlotIndex = 0;
	movs	r2, #0	@ tmp137,
	ldr	r3, .L298+8	@ tmp136,
	strb	r2, [r3, #18]	@ tmp137, gActionData.itemSlotIndex
@ SpellMenu.c:49: 		DidSelectSpell = 1;
	ldr	r3, .L298+12	@ tmp139,
	adds	r2, r2, #1	@ tmp140,
	strb	r2, [r3]	@ tmp140, DidSelectSpell
@ SpellMenu.c:50: 		ClearBG0BG1();
	ldr	r3, .L298+16	@ tmp142,
	bl	.L14		@
@ SpellMenu.c:51: 		int type = GetItemType(SelectedSpell);
	ldr	r4, .L298+20	@ tmp143,
	ldr	r3, .L298+24	@ tmp145,
	ldrb	r0, [r4]	@ SelectedSpell, SelectedSpell
	bl	.L14		@
	movs	r1, #255	@ tmp162,
	ldrb	r2, [r4]	@ SelectedSpell, SelectedSpell
	lsls	r1, r1, #8	@ tmp162, tmp162,
	ldr	r3, .L298+28	@ tmp163,
@ SpellMenu.c:54: 			MakeTargetListForWeapon(gActiveUnit,SelectedSpell|0xFF00);
	orrs	r1, r2	@ tmp148, SelectedSpell
@ SpellMenu.c:52: 		if ( type != ITYPE_STAFF )
	cmp	r0, #4	@ tmp166,
	beq	.L296		@,
@ SpellMenu.c:54: 			MakeTargetListForWeapon(gActiveUnit,SelectedSpell|0xFF00);
	ldr	r0, [r3]	@, gActiveUnit
	ldr	r3, .L298+32	@ tmp151,
	bl	.L14		@
@ SpellMenu.c:55: 			StartTargetSelection(&SpellTargetSelection);
	ldr	r0, .L298+36	@,
	ldr	r3, .L298+40	@ tmp153,
	bl	.L14		@
.L297:
@ SpellMenu.c:61: 		return 0x27;
	movs	r0, #39	@ <retval>,
	b	.L293		@
.L296:
@ SpellMenu.c:59: 			ItemEffect_Call(gActiveUnit,SelectedSpell|0xFF00);
	ldr	r0, [r3]	@, gActiveUnit
	ldr	r3, .L298+44	@ tmp159,
	bl	.L14		@
	b	.L297		@
.L299:
	.align	2
.L298:
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
	.fpu softvfp
	.type	SpellOnHover, %function
SpellOnHover:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}	@
@ SpellMenu.c:67: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,proc->commandIndex,UsingSpellMenu)];
	ldr	r3, .L315	@ tmp389,
	ldr	r6, .L315+4	@ tmp206,
@ SpellMenu.c:66: {
	sub	sp, sp, #36	@,,
@ SpellMenu.c:67: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,proc->commandIndex,UsingSpellMenu)];
	ldrb	r1, [r6]	@ UsingSpellMenu, UsingSpellMenu
@ SpellMenu.c:66: {
	movs	r4, r0	@ proc, tmp367
@ SpellMenu.c:67: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,proc->commandIndex,UsingSpellMenu)];
	ldr	r0, [r3]	@, gActiveUnit
	bl	SpellsGetter		@
@ SpellMenu.c:67: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,proc->commandIndex,UsingSpellMenu)];
	ldr	r3, .L315	@ tmp390,
@ SpellMenu.c:67: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,proc->commandIndex,UsingSpellMenu)];
	adds	r4, r4, #97	@ tmp213,
@ SpellMenu.c:67: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,proc->commandIndex,UsingSpellMenu)];
	ldrb	r2, [r6]	@ UsingSpellMenu, UsingSpellMenu
	ldrb	r1, [r4]	@ tmp214,
@ SpellMenu.c:67: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,proc->commandIndex,UsingSpellMenu)];
	movs	r5, r0	@ _4, tmp368
@ SpellMenu.c:67: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,proc->commandIndex,UsingSpellMenu)];
	ldr	r0, [r3]	@, gActiveUnit
	bl	GetNthUsableSpell		@
@ SpellMenu.c:68: 	SelectedSpell = spell;
	ldr	r3, .L315+8	@ tmp216,
@ SpellMenu.c:67: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,proc->commandIndex,UsingSpellMenu)];
	ldrb	r7, [r5, r0]	@ spell, *_12
@ SpellMenu.c:71: 	MenuItemPanelProc* menuItemPanel = (MenuItemPanelProc*)ProcFind(&gProc_MenuItemPanel);
	ldr	r0, .L315+12	@,
@ SpellMenu.c:68: 	SelectedSpell = spell;
	strb	r7, [r3]	@ spell, SelectedSpell
@ SpellMenu.c:71: 	MenuItemPanelProc* menuItemPanel = (MenuItemPanelProc*)ProcFind(&gProc_MenuItemPanel);
	ldr	r3, .L315+16	@ tmp219,
	bl	.L14		@
@ SpellMenu.c:72: 	int x = menuItemPanel->x;
	movs	r3, r0	@ tmp222, tmp370
@ SpellMenu.c:71: 	MenuItemPanelProc* menuItemPanel = (MenuItemPanelProc*)ProcFind(&gProc_MenuItemPanel);
	str	r0, [sp, #8]	@ tmp370, %sfp
@ SpellMenu.c:72: 	int x = menuItemPanel->x;
	adds	r3, r3, #48	@ tmp222,
	ldrb	r3, [r3]	@ _14,
	str	r3, [sp, #24]	@ _14, %sfp
@ SpellMenu.c:73: 	int y = menuItemPanel->y;
	movs	r3, r0	@ tmp225, tmp370
@ SpellMenu.c:75: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Clear(&menuItemPanel->textHandles[i]); }
	movs	r4, r0	@ _140, tmp370
@ SpellMenu.c:73: 	int y = menuItemPanel->y;
	adds	r3, r3, #49	@ tmp225,
@ SpellMenu.c:73: 	int y = menuItemPanel->y;
	ldrb	r3, [r3]	@ y,
@ SpellMenu.c:75: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Clear(&menuItemPanel->textHandles[i]); }
	adds	r4, r4, #52	@ _140,
@ SpellMenu.c:75: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Clear(&menuItemPanel->textHandles[i]); }
	ldr	r5, .L315+20	@ tmp226,
	movs	r0, r4	@, _140
@ SpellMenu.c:73: 	int y = menuItemPanel->y;
	str	r3, [sp, #28]	@ y, %sfp
@ SpellMenu.c:75: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Clear(&menuItemPanel->textHandles[i]); }
	str	r4, [sp, #16]	@ _140, %sfp
@ SpellMenu.c:75: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Clear(&menuItemPanel->textHandles[i]); }
	bl	.L270		@
@ SpellMenu.c:75: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Clear(&menuItemPanel->textHandles[i]); }
	ldr	r3, [sp, #8]	@ _145, %sfp
	adds	r3, r3, #60	@ _145,
@ SpellMenu.c:75: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Clear(&menuItemPanel->textHandles[i]); }
	movs	r0, r3	@, _145
@ SpellMenu.c:75: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Clear(&menuItemPanel->textHandles[i]); }
	str	r3, [sp, #20]	@ _145, %sfp
@ SpellMenu.c:75: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Clear(&menuItemPanel->textHandles[i]); }
	bl	.L270		@
@ SpellMenu.c:75: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Clear(&menuItemPanel->textHandles[i]); }
	ldr	r6, [sp, #8]	@ _150, %sfp
	adds	r6, r6, #68	@ _150,
@ SpellMenu.c:75: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Clear(&menuItemPanel->textHandles[i]); }
	movs	r0, r6	@, _150
	bl	.L270		@
@ SpellMenu.c:76: 	MakeUIWindowTileMap_BG0BG1(x,y,14,8,0);
	movs	r5, #0	@ tmp229,
	movs	r3, #8	@,
	movs	r2, #14	@,
	ldr	r1, [sp, #28]	@, %sfp
	ldr	r0, [sp, #24]	@, %sfp
	str	r5, [sp]	@ tmp229,
	ldr	r4, .L315+24	@ tmp398,
	bl	.L16		@
@ SpellMenu.c:78: 	int spellType = GetItemType(spell);
	movs	r0, r7	@, spell
	ldr	r3, .L315+28	@ tmp231,
	bl	.L14		@
	str	r0, [sp, #12]	@ tmp371, %sfp
@ SpellMenu.c:79: 	if ( spellType != ITYPE_STAFF )
	cmp	r0, #4	@ spellType,
	bne	.LCB2129	@
	b	.L301	@long jump	@
.LCB2129:
@ SpellMenu.c:81: 		BattleGenerateUiStats(gActiveUnit,9); // 9 is using a Gaiden spell.
	ldr	r3, .L315	@ tmp401,
	movs	r1, #9	@,
	ldr	r0, [r3]	@, gActiveUnit
	ldr	r3, .L315+32	@ tmp233,
	bl	.L14		@
@ SpellMenu.c:82: 		Text_InsertString(&menuItemPanel->textHandles[0],0x02,0,GetStringFromIndex(0x4F1)); // Affin.
	ldr	r3, .L315+36	@ tmp402,
	ldr	r0, .L315+40	@,
	bl	.L14		@
@ SpellMenu.c:82: 		Text_InsertString(&menuItemPanel->textHandles[0],0x02,0,GetStringFromIndex(0x4F1)); // Affin.
	movs	r2, r5	@, tmp229
@ SpellMenu.c:82: 		Text_InsertString(&menuItemPanel->textHandles[0],0x02,0,GetStringFromIndex(0x4F1)); // Affin.
	movs	r3, r0	@ _19, tmp372
@ SpellMenu.c:82: 		Text_InsertString(&menuItemPanel->textHandles[0],0x02,0,GetStringFromIndex(0x4F1)); // Affin.
	movs	r1, #2	@,
	ldr	r0, [sp, #16]	@, %sfp
	ldr	r4, .L315+44	@ tmp404,
	bl	.L16		@
@ SpellMenu.c:83: 		Text_InsertString(&menuItemPanel->textHandles[0],0x32,0,GetStringFromIndex(gGaidenMagicHPCostText)); // HP Cost.
	ldr	r3, .L315+48	@ tmp237,
	ldrh	r0, [r3]	@ gGaidenMagicHPCostText, gGaidenMagicHPCostText
	ldr	r3, .L315+36	@ tmp406,
	bl	.L14		@
@ SpellMenu.c:83: 		Text_InsertString(&menuItemPanel->textHandles[0],0x32,0,GetStringFromIndex(gGaidenMagicHPCostText)); // HP Cost.
	movs	r2, r5	@, tmp229
@ SpellMenu.c:83: 		Text_InsertString(&menuItemPanel->textHandles[0],0x32,0,GetStringFromIndex(gGaidenMagicHPCostText)); // HP Cost.
	movs	r3, r0	@ _23, tmp373
@ SpellMenu.c:83: 		Text_InsertString(&menuItemPanel->textHandles[0],0x32,0,GetStringFromIndex(gGaidenMagicHPCostText)); // HP Cost.
	movs	r1, #50	@,
	ldr	r0, [sp, #16]	@, %sfp
	ldr	r4, .L315+44	@ tmp408,
	bl	.L16		@
@ SpellMenu.c:84: 		Text_InsertString(&menuItemPanel->textHandles[1],0x02,0,GetStringFromIndex(0x4F3)); // Atk.
	ldr	r3, .L315+36	@ tmp410,
	ldr	r0, .L315+52	@,
	bl	.L14		@
@ SpellMenu.c:84: 		Text_InsertString(&menuItemPanel->textHandles[1],0x02,0,GetStringFromIndex(0x4F3)); // Atk.
	movs	r2, r5	@, tmp229
@ SpellMenu.c:84: 		Text_InsertString(&menuItemPanel->textHandles[1],0x02,0,GetStringFromIndex(0x4F3)); // Atk.
	movs	r3, r0	@ _25, tmp374
@ SpellMenu.c:84: 		Text_InsertString(&menuItemPanel->textHandles[1],0x02,0,GetStringFromIndex(0x4F3)); // Atk.
	movs	r1, #2	@,
	ldr	r0, [sp, #20]	@, %sfp
	ldr	r4, .L315+44	@ tmp412,
	bl	.L16		@
@ SpellMenu.c:85: 		Text_InsertString(&menuItemPanel->textHandles[2],0x02,0,GetStringFromIndex(0x4F4)); // Hit.
	ldr	r3, .L315+36	@ tmp414,
	ldr	r0, .L315+56	@,
	bl	.L14		@
@ SpellMenu.c:85: 		Text_InsertString(&menuItemPanel->textHandles[2],0x02,0,GetStringFromIndex(0x4F4)); // Hit.
	movs	r2, r5	@, tmp229
@ SpellMenu.c:85: 		Text_InsertString(&menuItemPanel->textHandles[2],0x02,0,GetStringFromIndex(0x4F4)); // Hit.
	movs	r3, r0	@ _27, tmp375
@ SpellMenu.c:85: 		Text_InsertString(&menuItemPanel->textHandles[2],0x02,0,GetStringFromIndex(0x4F4)); // Hit.
	movs	r1, #2	@,
	movs	r0, r6	@, _150
	ldr	r4, .L315+44	@ tmp416,
	bl	.L16		@
@ SpellMenu.c:86: 		Text_InsertString(&menuItemPanel->textHandles[1],0x32,0,GetStringFromIndex(0x501)); // Crit.
	ldr	r3, .L315+36	@ tmp418,
	ldr	r0, .L315+60	@,
	bl	.L14		@
@ SpellMenu.c:86: 		Text_InsertString(&menuItemPanel->textHandles[1],0x32,0,GetStringFromIndex(0x501)); // Crit.
	movs	r2, r5	@, tmp229
@ SpellMenu.c:86: 		Text_InsertString(&menuItemPanel->textHandles[1],0x32,0,GetStringFromIndex(0x501)); // Crit.
	movs	r3, r0	@ _28, tmp376
@ SpellMenu.c:86: 		Text_InsertString(&menuItemPanel->textHandles[1],0x32,0,GetStringFromIndex(0x501)); // Crit.
	movs	r1, #50	@,
	ldr	r0, [sp, #20]	@, %sfp
	ldr	r4, .L315+44	@ tmp420,
	bl	.L16		@
@ SpellMenu.c:87: 		Text_InsertString(&menuItemPanel->textHandles[2],0x32,0,GetStringFromIndex(0x4F5)); // Avoid.
	ldr	r3, .L315+36	@ tmp422,
	ldr	r0, .L315+64	@,
	bl	.L14		@
@ SpellMenu.c:87: 		Text_InsertString(&menuItemPanel->textHandles[2],0x32,0,GetStringFromIndex(0x4F5)); // Avoid.
	movs	r2, r5	@, tmp229
@ SpellMenu.c:87: 		Text_InsertString(&menuItemPanel->textHandles[2],0x32,0,GetStringFromIndex(0x4F5)); // Avoid.
	movs	r3, r0	@ _29, tmp377
@ SpellMenu.c:87: 		Text_InsertString(&menuItemPanel->textHandles[2],0x32,0,GetStringFromIndex(0x4F5)); // Avoid.
	movs	r1, #50	@,
	movs	r0, r6	@, _150
	ldr	r4, .L315+44	@ tmp424,
	bl	.L16		@
@ SpellMenu.c:90: 		if ( !HasSufficientHP(gActiveUnit,spell) ) { CostColor = 1; }
	ldr	r3, .L315	@ tmp426,
	movs	r1, r7	@, spell
	ldr	r0, [r3]	@, gActiveUnit
	bl	HasSufficientHP		@
@ SpellMenu.c:90: 		if ( !HasSufficientHP(gActiveUnit,spell) ) { CostColor = 1; }
	subs	r3, r0, #1	@ tmp355, tmp378
	sbcs	r0, r0, r3	@ tmp378, tmp378, tmp355
	movs	r5, r0	@ tmp354, tmp378
@ SpellMenu.c:91: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[0],0x54,CostColor,GetSpellCost(spell));
	movs	r0, r7	@, spell
	bl	GetSpellCost		@
@ SpellMenu.c:90: 		if ( !HasSufficientHP(gActiveUnit,spell) ) { CostColor = 1; }
	adds	r5, r5, #1	@ CostColor,
@ SpellMenu.c:91: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[0],0x54,CostColor,GetSpellCost(spell));
	lsls	r3, r0, #24	@ tmp254, tmp379,
	movs	r2, r5	@, CostColor
	movs	r1, #84	@,
	ldr	r5, .L315+68	@ tmp256,
	ldr	r0, [sp, #16]	@, %sfp
	lsrs	r3, r3, #24	@ tmp254, tmp254,
	bl	.L270		@
@ SpellMenu.c:92: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[1],0x24,2,gBattleActor.battleAttack);
	ldr	r4, .L315+72	@ tmp257,
	movs	r3, r4	@ tmp260, tmp257
	adds	r3, r3, #90	@ tmp260,
@ SpellMenu.c:92: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[1],0x24,2,gBattleActor.battleAttack);
	movs	r2, #2	@,
	movs	r1, #36	@,
	ldrb	r3, [r3]	@ tmp264,
	ldr	r0, [sp, #20]	@, %sfp
	bl	.L270		@
@ SpellMenu.c:93: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[2],0x24,2,gBattleActor.battleHitRate);
	movs	r3, r4	@ tmp270, tmp257
	adds	r3, r3, #96	@ tmp270,
@ SpellMenu.c:93: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[2],0x24,2,gBattleActor.battleHitRate);
	movs	r2, #2	@,
	movs	r1, #36	@,
	movs	r0, r6	@, _150
	ldrb	r3, [r3]	@ tmp274,
	bl	.L270		@
@ SpellMenu.c:94: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[1],0x54,2,gBattleActor.battleCritRate);
	movs	r3, r4	@ tmp280, tmp257
	adds	r3, r3, #102	@ tmp280,
@ SpellMenu.c:94: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[1],0x54,2,gBattleActor.battleCritRate);
	movs	r2, #2	@,
	movs	r1, #84	@,
	ldrb	r3, [r3]	@ tmp284,
	ldr	r0, [sp, #20]	@, %sfp
@ SpellMenu.c:95: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[2],0x54,2,gBattleActor.battleAvoidRate);
	adds	r4, r4, #98	@ tmp290,
@ SpellMenu.c:94: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[1],0x54,2,gBattleActor.battleCritRate);
	bl	.L270		@
@ SpellMenu.c:95: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[2],0x54,2,gBattleActor.battleAvoidRate);
	movs	r2, #2	@,
	movs	r1, #84	@,
	movs	r0, r6	@, _150
	ldrb	r3, [r4]	@ tmp294,
	bl	.L270		@
.L305:
	ldr	r5, [sp, #28]	@ y, %sfp
	ldr	r3, [sp, #24]	@ _14, %sfp
	adds	r5, r5, #1	@ y,
	adds	r4, r3, #1	@ tmp298, _14,
	lsls	r5, r5, #5	@ _158, tmp297,
	ldr	r3, .L315+76	@ tmp434,
	adds	r4, r4, r5	@ tmp299, tmp298, _158
	lsls	r4, r4, #1	@ tmp300, tmp299,
	adds	r4, r4, r3	@ ivtmp.381, tmp300, tmp434
	ldr	r3, [sp, #8]	@ _173, %sfp
	ldr	r6, [sp, #8]	@ ivtmp.379, %sfp
	adds	r3, r3, #76	@ _173,
	str	r3, [sp, #16]	@ _173, %sfp
	adds	r6, r6, #52	@ ivtmp.379,
.L303:
@ SpellMenu.c:115: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Display(&menuItemPanel->textHandles[i],&gBG0MapBuffer[y+1+2*i][x+1]); }
	movs	r1, r4	@, ivtmp.381
	movs	r0, r6	@, ivtmp.379
	ldr	r3, .L315+80	@ tmp330,
	bl	.L14		@
@ SpellMenu.c:115: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Display(&menuItemPanel->textHandles[i],&gBG0MapBuffer[y+1+2*i][x+1]); }
	ldr	r3, [sp, #16]	@ _173, %sfp
	adds	r6, r6, #8	@ ivtmp.379,
	adds	r4, r4, #128	@ ivtmp.381,
	cmp	r6, r3	@ ivtmp.379, _173
	bne	.L303		@,
@ SpellMenu.c:117: 	if ( spellType != ITYPE_STAFF ) { DrawIcon(&gBG0MapBuffer[y+1][x+5],spellType+0x70,menuItemPanel->oam2base<<0xC); } // This HAS to happen after the Text_Display calls.
	ldr	r3, [sp, #12]	@ spellType, %sfp
	cmp	r3, #4	@ spellType,
	beq	.L306		@,
@ SpellMenu.c:117: 	if ( spellType != ITYPE_STAFF ) { DrawIcon(&gBG0MapBuffer[y+1][x+5],spellType+0x70,menuItemPanel->oam2base<<0xC); } // This HAS to happen after the Text_Display calls.
	ldr	r0, [sp, #8]	@ menuItemPanel, %sfp
	adds	r0, r0, #50	@ menuItemPanel,
	ldrb	r2, [r0]	@ tmp334,
@ SpellMenu.c:117: 	if ( spellType != ITYPE_STAFF ) { DrawIcon(&gBG0MapBuffer[y+1][x+5],spellType+0x70,menuItemPanel->oam2base<<0xC); } // This HAS to happen after the Text_Display calls.
	ldr	r0, [sp, #24]	@ _14, %sfp
	adds	r0, r0, #5	@ _14,
@ SpellMenu.c:117: 	if ( spellType != ITYPE_STAFF ) { DrawIcon(&gBG0MapBuffer[y+1][x+5],spellType+0x70,menuItemPanel->oam2base<<0xC); } // This HAS to happen after the Text_Display calls.
	ldr	r3, .L315+76	@ tmp446,
	ldr	r1, [sp, #12]	@ tmp336, %sfp
	adds	r0, r0, r5	@ tmp338, tmp337, _158
	lsls	r0, r0, #1	@ tmp339, tmp338,
	adds	r0, r3, r0	@ tmp340, tmp446, tmp339
	lsls	r2, r2, #12	@ tmp335, tmp334,
	ldr	r3, .L315+84	@ tmp342,
	adds	r1, r1, #112	@ tmp336,
	bl	.L14		@
.L306:
@ SpellMenu.c:123: 	gWrite_Range(gActiveUnit->xPos,gActiveUnit->yPos,gGet_Item_Range(gActiveUnit,spell));
	movs	r5, #16	@ _67,
	movs	r6, #17	@ _69,
@ SpellMenu.c:119: 	BmMapFill(gMapMovement,-1);
	ldr	r3, .L315+88	@ tmp343,
	ldr	r4, .L315+92	@ tmp344,
	ldr	r0, [r3]	@, gMapMovement
	movs	r1, #255	@,
	bl	.L16		@
@ SpellMenu.c:120: 	BmMapFill(gMapRange,0);
	ldr	r3, .L315+96	@ tmp345,
	movs	r1, #0	@,
	ldr	r0, [r3]	@, gMapRange
	bl	.L16		@
@ SpellMenu.c:123: 	gWrite_Range(gActiveUnit->xPos,gActiveUnit->yPos,gGet_Item_Range(gActiveUnit,spell));
	ldr	r3, .L315+100	@ tmp347,
	ldr	r4, [r3]	@ gWrite_Range.103_64, gWrite_Range
@ SpellMenu.c:123: 	gWrite_Range(gActiveUnit->xPos,gActiveUnit->yPos,gGet_Item_Range(gActiveUnit,spell));
	ldr	r3, .L315	@ tmp348,
	ldr	r0, [r3]	@ gActiveUnit.104_65, gActiveUnit
@ SpellMenu.c:123: 	gWrite_Range(gActiveUnit->xPos,gActiveUnit->yPos,gGet_Item_Range(gActiveUnit,spell));
	ldr	r3, .L315+104	@ tmp349,
	movs	r1, r7	@, spell
	ldr	r3, [r3]	@ gGet_Item_Range, gGet_Item_Range
	ldrsb	r5, [r0, r5]	@ _67,* _67
	ldrsb	r6, [r0, r6]	@ _69,* _69
	bl	.L14		@
	movs	r2, r0	@ _71, tmp386
	movs	r3, r1	@ _71, tmp387
	movs	r0, r5	@, _67
	movs	r1, r6	@, _69
	bl	.L16		@
@ SpellMenu.c:124: 	DisplayMoveRangeGraphics(( spellType == ITYPE_STAFF ? 4 : 2 )); // See note in UnitMenu.c.
	ldr	r0, [sp, #12]	@ iftmp.108_77, %sfp
	cmp	r0, #4	@ spellType,
	beq	.L307		@,
	movs	r0, #2	@ iftmp.108_77,
.L307:
@ SpellMenu.c:124: 	DisplayMoveRangeGraphics(( spellType == ITYPE_STAFF ? 4 : 2 )); // See note in UnitMenu.c.
	ldr	r3, .L315+108	@ tmp351,
	bl	.L14		@
@ SpellMenu.c:126: }
	movs	r0, #0	@,
	add	sp, sp, #36	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L301:
@ SpellMenu.c:100: 		const char* desc = GetStringFromIndex(GetItemUseDescId(spell));
	ldr	r3, .L315+112	@ tmp302,
	movs	r0, r7	@, spell
	bl	.L14		@
	ldr	r3, .L315+36	@ tmp303,
	bl	.L14		@
	ldr	r4, [sp, #16]	@ ivtmp.386, %sfp
@ SpellMenu.c:102: 		desc--;
	subs	r0, r0, #1	@ desc,
.L304:
@ SpellMenu.c:106: 			Text_InsertString(&menuItemPanel->textHandles[j],0,0,desc);
	movs	r2, #0	@,
@ SpellMenu.c:105: 			desc++;
	adds	r5, r0, #1	@ desc, desc,
@ SpellMenu.c:106: 			Text_InsertString(&menuItemPanel->textHandles[j],0,0,desc);
	movs	r3, r5	@, desc
	movs	r0, r4	@, ivtmp.386
	movs	r1, r2	@,
	ldr	r6, .L315+44	@ tmp304,
	bl	.L15		@
@ SpellMenu.c:107: 			desc = Text_GetStringNextLine(desc);
	ldr	r3, .L315+116	@ tmp305,
	movs	r0, r5	@, desc
	bl	.L14		@
@ SpellMenu.c:109: 		} while ( *desc );
	ldrb	r3, [r0]	@ *desc_103, *desc_103
	adds	r4, r4, #8	@ ivtmp.386,
	cmp	r3, #0	@ *desc_103,
	bne	.L304		@,
@ SpellMenu.c:110: 		gBattleActor.battleAttack = gBattleTarget.battleAttack; // ??? this is something vanilla does???
	ldr	r2, .L315+120	@ tmp308,
@ SpellMenu.c:110: 		gBattleActor.battleAttack = gBattleTarget.battleAttack; // ??? this is something vanilla does???
	ldr	r3, .L315+72	@ tmp307,
@ SpellMenu.c:110: 		gBattleActor.battleAttack = gBattleTarget.battleAttack; // ??? this is something vanilla does???
	movs	r0, r2	@ tmp311, tmp308
@ SpellMenu.c:110: 		gBattleActor.battleAttack = gBattleTarget.battleAttack; // ??? this is something vanilla does???
	movs	r1, r3	@ tmp314, tmp307
@ SpellMenu.c:110: 		gBattleActor.battleAttack = gBattleTarget.battleAttack; // ??? this is something vanilla does???
	adds	r0, r0, #90	@ tmp311,
@ SpellMenu.c:110: 		gBattleActor.battleAttack = gBattleTarget.battleAttack; // ??? this is something vanilla does???
	ldrh	r0, [r0]	@ tmp315,
	adds	r1, r1, #90	@ tmp314,
	strh	r0, [r1]	@ tmp315, gBattleActor.battleAttack
@ SpellMenu.c:112: 		gBattleActor.battleCritRate = gBattleTarget.battleCritRate;
	movs	r0, r2	@ tmp321, tmp308
@ SpellMenu.c:112: 		gBattleActor.battleCritRate = gBattleTarget.battleCritRate;
	movs	r1, r3	@ tmp324, tmp307
@ SpellMenu.c:112: 		gBattleActor.battleCritRate = gBattleTarget.battleCritRate;
	adds	r0, r0, #102	@ tmp321,
@ SpellMenu.c:112: 		gBattleActor.battleCritRate = gBattleTarget.battleCritRate;
	ldrh	r0, [r0]	@ tmp325,
@ SpellMenu.c:111: 		gBattleActor.battleHitRate = gBattleTarget.battleHitRate; // ??? this fixes the green/red arrows from showing on staves???
	ldr	r2, [r2, #96]	@ tmp440, MEM <unsigned int> [(short int *)&gBattleTarget + 96B]
@ SpellMenu.c:112: 		gBattleActor.battleCritRate = gBattleTarget.battleCritRate;
	adds	r1, r1, #102	@ tmp324,
	strh	r0, [r1]	@ tmp325, gBattleActor.battleCritRate
@ SpellMenu.c:111: 		gBattleActor.battleHitRate = gBattleTarget.battleHitRate; // ??? this fixes the green/red arrows from showing on staves???
	str	r2, [r3, #96]	@ tmp440, MEM <unsigned int> [(short int *)&gBattleActor + 96B]
	b	.L305		@
.L316:
	.align	2
.L315:
	.word	gActiveUnit
	.word	UsingSpellMenu
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
@ SpellMenu.c:130: 	if ( !DidSelectSpell ) // Don't hide the squares if we're going to the target selection menu.
	ldr	r4, .L319	@ tmp116,
@ SpellMenu.c:130: 	if ( !DidSelectSpell ) // Don't hide the squares if we're going to the target selection menu.
	ldrb	r3, [r4]	@ DidSelectSpell, DidSelectSpell
	cmp	r3, #0	@ DidSelectSpell,
	bne	.L318		@,
@ SpellMenu.c:132: 		HideMoveRangeGraphics();
	ldr	r3, .L319+4	@ tmp118,
	bl	.L14		@
.L318:
@ SpellMenu.c:136: }
	@ sp needed	@
@ SpellMenu.c:134: 	DidSelectSpell = 0; // Unset this variable.
	movs	r0, #0	@ tmp120,
	strb	r0, [r4]	@ tmp120, DidSelectSpell
@ SpellMenu.c:136: }
	pop	{r4}
	pop	{r1}
	bx	r1
.L320:
	.align	2
.L319:
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
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	movs	r3, r1	@ commandProc, tmp173
	push	{r0, r1, r2, r4, r5, r6, r7, lr}	@
@ SpellMenu.c:142: 	if ( UsingSpellMenu )
	ldr	r2, .L326	@ tmp176,
@ SpellMenu.c:140: 	int xTile = commandProc->xDrawTile * 8;
	ldrh	r4, [r1, #42]	@ tmp142,
@ SpellMenu.c:141: 	int yTile = commandProc->yDrawTile * 8;
	ldrh	r5, [r1, #44]	@ tmp143,
@ SpellMenu.c:142: 	if ( UsingSpellMenu )
	ldrb	r1, [r2]	@ UsingSpellMenu.110_5, UsingSpellMenu
	adds	r3, r3, #60	@ commandProc,
	str	r3, [sp]	@ commandProc, %sfp
	ldr	r6, .L326+4	@ tmp172,
@ SpellMenu.c:140: 	int xTile = commandProc->xDrawTile * 8;
	lsls	r4, r4, #3	@ xTile, tmp142,
@ SpellMenu.c:141: 	int yTile = commandProc->yDrawTile * 8;
	lsls	r5, r5, #3	@ yTile, tmp143,
@ SpellMenu.c:142: 	if ( UsingSpellMenu )
	cmp	r1, #0	@ UsingSpellMenu.110_5,
	beq	.L322		@,
@ SpellMenu.c:145: 		DrawItemRText(xTile,yTile,SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,commandProc->commandDefinitionIndex,UsingSpellMenu)]);
	ldr	r7, .L326+8	@ tmp145,
	ldr	r0, [r7]	@, gActiveUnit
	bl	SpellsGetter		@
@ SpellMenu.c:145: 		DrawItemRText(xTile,yTile,SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,commandProc->commandDefinitionIndex,UsingSpellMenu)]);
	ldr	r3, .L326	@ tmp178,
@ SpellMenu.c:145: 		DrawItemRText(xTile,yTile,SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,commandProc->commandDefinitionIndex,UsingSpellMenu)]);
	str	r0, [sp, #4]	@ tmp174, %sfp
@ SpellMenu.c:145: 		DrawItemRText(xTile,yTile,SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,commandProc->commandDefinitionIndex,UsingSpellMenu)]);
	ldrb	r2, [r3]	@ UsingSpellMenu, UsingSpellMenu
	ldr	r3, [sp]	@ tmp171, %sfp
	ldr	r0, [r7]	@, gActiveUnit
	ldrb	r1, [r3]	@ tmp151,
	bl	GetNthUsableSpell		@
@ SpellMenu.c:145: 		DrawItemRText(xTile,yTile,SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,commandProc->commandDefinitionIndex,UsingSpellMenu)]);
	ldr	r3, [sp, #4]	@ _8, %sfp
	ldrb	r2, [r3, r0]	@ *_16, *_16
.L325:
@ SpellMenu.c:159: }
	@ sp needed	@
@ SpellMenu.c:156: 			DrawItemRText(xTile,yTile,*((u16*)&gGameState+0x16)); // Probably related to special cases like ballistae?
	movs	r1, r5	@, yTile
	movs	r0, r4	@, xTile
	bl	.L15		@
@ SpellMenu.c:159: }
	pop	{r0, r1, r2, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L322:
@ SpellMenu.c:150: 		if ( commandProc->commandDefinitionIndex <= 4 )
	ldr	r3, [sp]	@ tmp171, %sfp
	ldrb	r3, [r3]	@ _19,
@ SpellMenu.c:150: 		if ( commandProc->commandDefinitionIndex <= 4 )
	cmp	r3, #4	@ _19,
	bhi	.L324		@,
@ SpellMenu.c:152: 			DrawItemRText(xTile,yTile,gActiveUnit->items[commandProc->commandDefinitionIndex]);
	ldr	r2, .L326+8	@ tmp161,
	adds	r3, r3, #12	@ tmp162,
	ldr	r2, [r2]	@ gActiveUnit, gActiveUnit
	lsls	r3, r3, #1	@ tmp163, tmp162,
	adds	r3, r2, r3	@ tmp164, gActiveUnit, tmp163
@ SpellMenu.c:152: 			DrawItemRText(xTile,yTile,gActiveUnit->items[commandProc->commandDefinitionIndex]);
	ldrh	r2, [r3, #6]	@ tmp166, *gActiveUnit.115_20
	b	.L325		@
.L324:
@ SpellMenu.c:156: 			DrawItemRText(xTile,yTile,*((u16*)&gGameState+0x16)); // Probably related to special cases like ballistae?
	ldr	r3, .L326+12	@ tmp168,
@ SpellMenu.c:156: 			DrawItemRText(xTile,yTile,*((u16*)&gGameState+0x16)); // Probably related to special cases like ballistae?
	ldrh	r2, [r3, #44]	@ MEM[(u16 *)&gGameState + 44B], MEM[(u16 *)&gGameState + 44B]
	b	.L325		@
.L327:
	.align	2
.L326:
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
	.fpu softvfp
	.type	GaidenStatScreen, %function
GaidenStatScreen:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}	@
	sub	sp, sp, #28	@,,
@ StatScreen.c:3: {
	str	r1, [sp, #12]	@ tmp182, %sfp
@ StatScreen.c:4: 	u8* spells = SpellsGetter(gpStatScreenUnit,-1);
	movs	r1, #1	@,
@ StatScreen.c:3: {
	movs	r4, r2	@ currHandle, tmp183
@ StatScreen.c:4: 	u8* spells = SpellsGetter(gpStatScreenUnit,-1);
	ldr	r3, .L339	@ tmp144,
@ StatScreen.c:3: {
	str	r0, [sp, #8]	@ tmp181, %sfp
@ StatScreen.c:4: 	u8* spells = SpellsGetter(gpStatScreenUnit,-1);
	rsbs	r1, r1, #0	@,
	ldr	r0, [r3]	@, gpStatScreenUnit
	bl	SpellsGetter		@
@ StatScreen.c:5: 	int tile = (currHandle-1)->tileIndexOffset;
	movs	r3, r4	@ tmp145, currHandle
	movs	r7, r0	@ ivtmp.409, tmp184
	subs	r3, r3, #8	@ tmp145,
@ StatScreen.c:5: 	int tile = (currHandle-1)->tileIndexOffset;
	ldrh	r3, [r3]	@ tile, MEM[(struct TextHandle *)currHandle_27(D) + 4294967288B]
@ StatScreen.c:8: 	for ( int i = 0 ; spells[i] ; i++ )
	ldr	r6, [sp, #8]	@ iconX, %sfp
@ StatScreen.c:5: 	int tile = (currHandle-1)->tileIndexOffset;
	str	r3, [sp, #4]	@ tile, %sfp
.L335:
@ StatScreen.c:8: 	for ( int i = 0 ; spells[i] ; i++ )
	ldrb	r0, [r7]	@ _15, MEM[base: _62, offset: 0B]
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
	ldr	r3, [sp, #12]	@ y, %sfp
@ StatScreen.c:10: 		const ItemData* item = GetItemData(spells[i]);
	str	r0, [sp, #16]	@ tmp185, %sfp
	lsls	r3, r3, #5	@ _56, y,
@ StatScreen.c:11: 		DrawIcon(&StatScreenBufferMap[iconY][iconX],item->iconId,0x4000);
	ldrb	r1, [r0, #29]	@ tmp148,
	str	r3, [sp, #20]	@ _56, %sfp
	adds	r0, r6, r3	@ tmp149, iconX, _56
	ldr	r3, .L339+8	@ tmp195,
	lsls	r0, r0, #1	@ tmp150, tmp149,
	lsls	r2, r2, #7	@,,
	adds	r0, r0, r3	@ tmp151, tmp150, tmp195
	ldr	r3, .L339+12	@ tmp153,
	bl	.L14		@
@ StatScreen.c:13: 		tile += 6;
	ldr	r3, [sp, #4]	@ tile, %sfp
	adds	r3, r3, #6	@ tile,
@ StatScreen.c:15: 		currHandle->xCursor = 0;
	movs	r5, #0	@ tmp155,
@ StatScreen.c:14: 		currHandle->tileIndexOffset = tile;
	strh	r3, [r4]	@ tile, MEM[base: currHandle_16, offset: 0B]
@ StatScreen.c:13: 		tile += 6;
	str	r3, [sp, #4]	@ tile, %sfp
@ StatScreen.c:17: 		currHandle->tileWidth = 6;
	movs	r3, #6	@ tmp199,
@ StatScreen.c:22: 		Text_Clear(currHandle);
	movs	r0, r4	@, currHandle
@ StatScreen.c:15: 		currHandle->xCursor = 0;
	strb	r5, [r4, #2]	@ tmp155, MEM[base: currHandle_16, offset: 2B]
@ StatScreen.c:16: 		currHandle->colorId = TEXT_COLOR_NORMAL;
	strb	r5, [r4, #3]	@ tmp155, MEM[base: currHandle_16, offset: 3B]
@ StatScreen.c:17: 		currHandle->tileWidth = 6;
	strb	r3, [r4, #4]	@ tmp198, MEM[base: currHandle_16, offset: 4B]
@ StatScreen.c:18: 		currHandle->useDoubleBuffer = 0;
	strb	r5, [r4, #5]	@ tmp155, MEM[base: currHandle_16, offset: 5B]
@ StatScreen.c:19: 		currHandle->currentBufferId = 0;
	strb	r5, [r4, #6]	@ tmp155, MEM[base: currHandle_16, offset: 6B]
@ StatScreen.c:20: 		currHandle->unk07 = 0;
	strb	r5, [r4, #7]	@ tmp155, MEM[base: currHandle_16, offset: 7B]
@ StatScreen.c:22: 		Text_Clear(currHandle);
	ldr	r3, .L339+16	@ tmp167,
	bl	.L14		@
@ StatScreen.c:23: 		Text_SetColorId(currHandle,TEXT_COLOR_NORMAL);
	movs	r1, r5	@, tmp155
	movs	r0, r4	@, currHandle
	ldr	r3, .L339+20	@ tmp168,
	bl	.L14		@
@ StatScreen.c:24: 		Text_InsertString(currHandle,0,TEXT_COLOR_NORMAL,GetStringFromIndex(item->nameTextId));
	ldr	r3, [sp, #16]	@ item, %sfp
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
	bl	.L270		@
@ StatScreen.c:25: 		Text_Display(currHandle,&StatScreenBufferMap[iconY][iconX+2]);
	ldr	r3, [sp, #20]	@ _56, %sfp
@ StatScreen.c:25: 		Text_Display(currHandle,&StatScreenBufferMap[iconY][iconX+2]);
	adds	r1, r6, #2	@ tmp172, iconX,
@ StatScreen.c:25: 		Text_Display(currHandle,&StatScreenBufferMap[iconY][iconX+2]);
	adds	r1, r1, r3	@ tmp173, tmp172, _56
	ldr	r3, .L339+8	@ tmp202,
	lsls	r1, r1, #1	@ tmp174, tmp173,
	movs	r0, r4	@, currHandle
	adds	r1, r1, r3	@ tmp175, tmp174, tmp202
	ldr	r3, .L339+32	@ tmp177,
	bl	.L14		@
@ StatScreen.c:28: 		if ( iconX == x ) { iconX += 8; }
	ldr	r3, [sp, #8]	@ x, %sfp
@ StatScreen.c:27: 		currHandle++;
	adds	r4, r4, #8	@ currHandle,
@ StatScreen.c:28: 		if ( iconX == x ) { iconX += 8; }
	cmp	r6, r3	@ iconX, x
	bne	.L336		@,
@ StatScreen.c:28: 		if ( iconX == x ) { iconX += 8; }
	adds	r6, r6, #8	@ iconX,
.L337:
	adds	r7, r7, #1	@ ivtmp.409,
	b	.L335		@
.L336:
@ StatScreen.c:29: 		else { iconX = x; iconY += 2; }
	ldr	r3, [sp, #12]	@ y, %sfp
	adds	r3, r3, #2	@ y,
	str	r3, [sp, #12]	@ y, %sfp
	ldr	r6, [sp, #8]	@ iconX, %sfp
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
	.fpu softvfp
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
	ldr	r3, [r0, #44]	@ tmp141, proc_12(D)->rTextData
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
	.fpu softvfp
	.type	GaidenRTextLooper, %function
GaidenRTextLooper:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, lr}	@
@ StatScreen.c:43: 	int index = *(proc->rTextData+0x12);
	ldr	r3, [r0, #44]	@ tmp173, proc_26(D)->rTextData
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
	ldr	r3, .L354	@ tmp142,
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
	ldr	r3, .L354+4	@ tmp141,
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
	ldr	r7, .L354	@ tmp145,
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
	ldr	r6, .L354+8	@ tmp148,
	bl	.L15		@
@ StatScreen.c:60: 			if ( index % 2 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index-1]) ) { RTextLeft(proc); }
	lsls	r3, r4, #31	@ tmp172, _2,
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
	adds	r4, r0, r4	@ tmp156, tmp166, _2
	subs	r4, r4, #1	@ tmp157,
	movs	r0, r7	@, gpStatScreenUnit.130_16
	ldrb	r1, [r4]	@ *_19, *_19
	bl	DoesUnitKnowSpell		@
@ StatScreen.c:60: 			if ( index % 2 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index-1]) ) { RTextLeft(proc); }
	cmp	r0, #0	@ tmp167,
	bne	.L344		@,
@ StatScreen.c:60: 			if ( index % 2 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index-1]) ) { RTextLeft(proc); }
	movs	r0, r5	@, proc
	bl	.L15		@
@ StatScreen.c:63: }
	b	.L344		@
.L355:
	.align	2
.L354:
	.word	gpStatScreenUnit
	.word	RTextUp
	.word	RTextLeft
	.size	GaidenRTextLooper, .-GaidenRTextLooper
	.ident	"GCC: (devkitARM release 55) 10.2.0"
	.code 16
	.align	1
.L14:
	bx	r3
.L16:
	bx	r4
.L270:
	bx	r5
.L15:
	bx	r6
