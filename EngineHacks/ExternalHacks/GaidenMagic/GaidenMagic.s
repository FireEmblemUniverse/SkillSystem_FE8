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
@ GNU C17 (devkitARM release 54) version 10.1.0 (arm-none-eabi)
@	compiled by GNU C version 6.4.0, GMP version 6.0.0, MPFR version 3.1.2, MPC version 1.0.2, isl version none
@ GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
@ options passed:  -imultilib thumb
@ -iprefix c:\devkitpro\devkitarm\bin\../lib/gcc/arm-none-eabi/10.1.0/
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
@ SpellSystem.c:447: 	int type = GetItemType(spell);
	movs	r0, r1	@, spell
	ldr	r3, .L27	@ tmp122,
@ SpellSystem.c:445: {
	movs	r4, r1	@ spell, tmp135
@ SpellSystem.c:447: 	int type = GetItemType(spell);
	bl	.L14		@
@ SpellSystem.c:450: 		if ( !CanUnitUseWeaponNow(gActiveUnit,spell) ) { return 0; }
	movs	r1, r4	@, spell
	ldr	r5, .L27+4	@ tmp134,
@ SpellSystem.c:448: 	if ( type != ITYPE_STAFF )
	cmp	r0, #4	@ tmp136,
	beq	.L22		@,
@ SpellSystem.c:450: 		if ( !CanUnitUseWeaponNow(gActiveUnit,spell) ) { return 0; }
	ldr	r0, [r5]	@, gActiveUnit
	ldr	r3, .L27+8	@ tmp124,
	bl	.L14		@
@ SpellSystem.c:450: 		if ( !CanUnitUseWeaponNow(gActiveUnit,spell) ) { return 0; }
	cmp	r0, #0	@ <retval>,
	beq	.L21		@,
@ SpellSystem.c:452: 		MakeTargetListForWeapon(gActiveUnit,spell);
	movs	r1, r4	@, spell
	ldr	r0, [r5]	@, gActiveUnit
	ldr	r3, .L27+12	@ tmp126,
	bl	.L14		@
@ SpellSystem.c:453: 		return GetTargetListSize() != 0;
	ldr	r3, .L27+16	@ tmp127,
	bl	.L14		@
@ SpellSystem.c:453: 		return GetTargetListSize() != 0;
	subs	r3, r0, #1	@ tmp130, tmp138
	sbcs	r0, r0, r3	@ <retval>, tmp138, tmp130
.L21:
@ SpellSystem.c:459: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L22:
@ SpellSystem.c:457: 		return CanUnitUseItem(gActiveUnit,spell);
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
@ SpellSystem.c:463: 	int type = GetItemType(spell);
	movs	r0, r1	@, spell
	ldr	r3, .L35	@ tmp122,
@ SpellSystem.c:462: {
	movs	r4, r1	@ spell, tmp135
@ SpellSystem.c:463: 	int type = GetItemType(spell);
	bl	.L14		@
@ SpellSystem.c:466: 		if ( !CanUnitUseWeapon(gActiveUnit,spell) ) { return 0; }
	movs	r1, r4	@, spell
	ldr	r5, .L35+4	@ tmp134,
@ SpellSystem.c:464: 	if ( type != ITYPE_STAFF )
	cmp	r0, #4	@ tmp136,
	beq	.L30		@,
@ SpellSystem.c:466: 		if ( !CanUnitUseWeapon(gActiveUnit,spell) ) { return 0; }
	ldr	r0, [r5]	@, gActiveUnit
	ldr	r3, .L35+8	@ tmp124,
	bl	.L14		@
@ SpellSystem.c:466: 		if ( !CanUnitUseWeapon(gActiveUnit,spell) ) { return 0; }
	cmp	r0, #0	@ <retval>,
	beq	.L29		@,
@ SpellSystem.c:468: 		MakeTargetListForWeapon(gActiveUnit,spell);
	movs	r1, r4	@, spell
	ldr	r0, [r5]	@, gActiveUnit
	ldr	r3, .L35+12	@ tmp126,
	bl	.L14		@
@ SpellSystem.c:469: 		return GetTargetListSize() != 0;
	ldr	r3, .L35+16	@ tmp127,
	bl	.L14		@
@ SpellSystem.c:469: 		return GetTargetListSize() != 0;
	subs	r3, r0, #1	@ tmp130, tmp138
	sbcs	r0, r0, r3	@ <retval>, tmp138, tmp130
.L29:
@ SpellSystem.c:475: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L30:
@ SpellSystem.c:457: 		return CanUnitUseItem(gActiveUnit,spell);
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
@ SpellSystem.c:530: 	int wType = GetItemType(spell);
	ldr	r3, .L52	@ tmp117,
@ SpellSystem.c:529: {
	push	{r4, lr}	@
@ SpellSystem.c:530: 	int wType = GetItemType(spell);
	bl	.L14		@
@ SpellSystem.c:531: 	if ( wType == ITYPE_ANIMA || wType == ITYPE_DARK ) { return BLACK_MAGIC; }
	movs	r2, #2	@ tmp118,
	movs	r3, r0	@ tmp127, tmp127
@ SpellSystem.c:531: 	if ( wType == ITYPE_ANIMA || wType == ITYPE_DARK ) { return BLACK_MAGIC; }
	movs	r0, #1	@ <retval>,
@ SpellSystem.c:531: 	if ( wType == ITYPE_ANIMA || wType == ITYPE_DARK ) { return BLACK_MAGIC; }
	bics	r3, r2	@ tmp127, tmp118
	cmp	r3, #5	@ _6,
	beq	.L48		@,
@ SpellSystem.c:532: 	else if ( wType == ITYPE_STAFF || wType == ITYPE_LIGHT) { return WHITE_MAGIC; }
	movs	r0, r2	@ <retval>, tmp118
@ SpellSystem.c:532: 	else if ( wType == ITYPE_STAFF || wType == ITYPE_LIGHT) { return WHITE_MAGIC; }
	cmp	r3, #4	@ _6,
	beq	.L48		@,
@ SpellSystem.c:533: 	else { return -1; }
	subs	r0, r0, #3	@ <retval>,
.L48:
@ SpellSystem.c:534: }
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
	str	r2, [sp, #4]	@ tmp161, %sfp
@ SpellSystem.c:11: 	if ( UNIT_ATTRIBUTES(unit) & CA_PROMOTED ) { unitLevel += 80; } // Treat promoted as top bit set.
	ldr	r3, [r0]	@ unit_37(D)->pCharacterData, unit_37(D)->pCharacterData
	ldr	r2, [r0, #4]	@ _4, unit_37(D)->pClassData
@ SpellSystem.c:8: {
	movs	r7, r1	@ level, tmp160
@ SpellSystem.c:11: 	if ( UNIT_ATTRIBUTES(unit) & CA_PROMOTED ) { unitLevel += 80; } // Treat promoted as top bit set.
	ldr	r3, [r3, #40]	@ _2->attributes, _2->attributes
	ldr	r1, [r2, #40]	@ tmp166, _4->attributes
	orrs	r3, r1	@ tmp144, tmp166
@ SpellSystem.c:10: 	int unitLevel = unit->level;
	ldrsb	r6, [r0, r6]	@ unitLevel,* unitLevel
@ SpellSystem.c:11: 	if ( UNIT_ATTRIBUTES(unit) & CA_PROMOTED ) { unitLevel += 80; } // Treat promoted as top bit set.
	lsls	r3, r3, #23	@ tmp163, tmp144,
	bpl	.L55		@,
@ SpellSystem.c:11: 	if ( UNIT_ATTRIBUTES(unit) & CA_PROMOTED ) { unitLevel += 80; } // Treat promoted as top bit set.
	adds	r6, r6, #80	@ unitLevel,
.L55:
@ SpellSystem.c:14: 	SpellList* ROMList = SpellListTable[unit->pClassData->number];	
	ldrb	r3, [r2, #4]	@ tmp150,
@ SpellSystem.c:14: 	SpellList* ROMList = SpellListTable[unit->pClassData->number];	
	ldr	r2, .L76	@ tmp149,
	lsls	r3, r3, #2	@ tmp151, tmp150,
	ldr	r5, [r3, r2]	@ ROMList, SpellListTable
	movs	r3, r0	@ ivtmp.225, unit
@ SpellSystem.c:12: 	u8* currBuffer = SpellsBuffer;
	ldr	r4, .L76+4	@ currBuffer,
	adds	r3, r3, #40	@ ivtmp.225,
	adds	r0, r0, #45	@ _55,
.L57:
@ SpellSystem.c:18: 		if (unit->ranks[i] != 0) {
	ldrb	r2, [r3]	@ _11, MEM[base: _54, offset: 0B]
@ SpellSystem.c:18: 		if (unit->ranks[i] != 0) {
	cmp	r2, #0	@ _11,
	beq	.L56		@,
@ SpellSystem.c:20: 			*currBuffer = unit->ranks[i];
	strb	r2, [r4]	@ _11, *currBuffer_67
@ SpellSystem.c:21: 			currBuffer++;
	adds	r4, r4, #1	@ currBuffer,
.L56:
@ SpellSystem.c:16: 	for ( int i = 0 ; i < 5 ; i++ )	
	adds	r3, r3, #1	@ ivtmp.225,
	cmp	r0, r3	@ _55, ivtmp.225
	bne	.L57		@,
@ SpellSystem.c:27: 	if ( ROMList )
	cmp	r5, #0	@ ROMList,
	beq	.L58		@,
.L59:
@ SpellSystem.c:30: 		for ( int i = 0 ; ROMList[i].level ; i++ )
	ldrb	r3, [r5]	@ _21, MEM[base: _65, offset: 0B]
@ SpellSystem.c:30: 		for ( int i = 0 ; ROMList[i].level ; i++ )
	cmp	r3, #0	@ _21,
	bne	.L65		@,
.L58:
@ SpellSystem.c:46: }
	@ sp needed	@
@ SpellSystem.c:44: 	*currBuffer = 0;
	movs	r3, #0	@ tmp155,
@ SpellSystem.c:46: }
	ldr	r0, .L76+4	@,
@ SpellSystem.c:44: 	*currBuffer = 0;
	strb	r3, [r4]	@ tmp155, *currBuffer_27
@ SpellSystem.c:46: }
	pop	{r1, r2, r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L65:
@ SpellSystem.c:32: 			if ( (level == -1 && unitLevel >= ROMList[i].level) || (level == ROMList[i].level) )
	adds	r2, r7, #1	@ tmp164, level,
	bne	.L60		@,
@ SpellSystem.c:32: 			if ( (level == -1 && unitLevel >= ROMList[i].level) || (level == ROMList[i].level) )
	cmp	r6, r3	@ unitLevel, _21
	bge	.L61		@,
.L62:
	adds	r5, r5, #2	@ ivtmp.216,
	b	.L59		@
.L60:
@ SpellSystem.c:32: 			if ( (level == -1 && unitLevel >= ROMList[i].level) || (level == ROMList[i].level) )
	cmp	r3, r7	@ _21, level
	bne	.L62		@,
.L61:
@ SpellSystem.c:34: 				if ( type == -1 || type == GetSpellType(ROMList[i].spell) )
	ldr	r3, [sp, #4]	@ type, %sfp
	adds	r3, r3, #1	@ tmp165, type,
	bne	.L63		@,
.L64:
@ SpellSystem.c:37: 					*currBuffer = ROMList[i].spell;
	ldrb	r3, [r5, #1]	@ _17, MEM[base: _65, offset: 1B]
@ SpellSystem.c:37: 					*currBuffer = ROMList[i].spell;
	strb	r3, [r4]	@ _17, *currBuffer_26
@ SpellSystem.c:38: 					currBuffer++;
	adds	r4, r4, #1	@ currBuffer,
	b	.L62		@
.L63:
@ SpellSystem.c:34: 				if ( type == -1 || type == GetSpellType(ROMList[i].spell) )
	ldrb	r0, [r5, #1]	@ MEM[base: _65, offset: 1B], MEM[base: _65, offset: 1B]
	bl	GetSpellType		@
@ SpellSystem.c:34: 				if ( type == -1 || type == GetSpellType(ROMList[i].spell) )
	ldr	r3, [sp, #4]	@ type, %sfp
	cmp	r0, r3	@ tmp162, type
	bne	.L62		@,
	b	.L64		@
.L77:
	.align	2
.L76:
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
	ldr	r3, .L80	@ tmp118,
	strb	r1, [r3]	@ tmp119, UsingSpellMenu
@ UnitMenu.c:40: 	return GaidenMagicUMEffectExt(SpellsGetter(gActiveUnit,BLACK_MAGIC),proc,commandProc);
	ldr	r3, .L80+4	@ tmp121,
	ldr	r0, [r3]	@, gActiveUnit
	bl	SpellsGetter		@
	movs	r2, r5	@, commandProc
	movs	r1, r4	@, proc
	bl	GaidenMagicUMEffectExt		@
@ UnitMenu.c:41: }
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L81:
	.align	2
.L80:
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
	ldr	r3, .L83	@ tmp118,
	strb	r1, [r3]	@ tmp119, UsingSpellMenu
@ UnitMenu.c:46: 	return GaidenMagicUMEffectExt(SpellsGetter(gActiveUnit,WHITE_MAGIC),proc,commandProc);
	ldr	r3, .L83+4	@ tmp121,
	ldr	r0, [r3]	@, gActiveUnit
	bl	SpellsGetter		@
	movs	r2, r5	@, commandProc
	movs	r1, r4	@, proc
	bl	GaidenMagicUMEffectExt		@
@ UnitMenu.c:47: }
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L84:
	.align	2
.L83:
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
	movs	r6, r0	@ ivtmp.247, unit
@ SpellSystem.c:357: {
	movs	r5, r0	@ unit, tmp181
@ SpellSystem.c:358: 	u32 ret = 0;
	movs	r4, #0	@ <retval>,
@ SpellSystem.c:362: 		if ( attributes & IA_WEAPON )
	movs	r7, #1	@ tmp179,
	adds	r3, r3, #40	@ _72,
	str	r3, [sp, #4]	@ _72, %sfp
	adds	r6, r6, #30	@ ivtmp.247,
.L86:
@ SpellSystem.c:359: 	for ( int i = 0 ; i < 5 && unit->items[i] ; i++ )
	ldrh	r0, [r6]	@ _11, MEM[base: _68, offset: 0B]
@ SpellSystem.c:359: 	for ( int i = 0 ; i < 5 && unit->items[i] ; i++ )
	cmp	r0, #0	@ _11,
	beq	.L89		@,
@ SpellSystem.c:361: 		u32 attributes = GetItemAttributes(unit->items[i]);
	ldr	r3, .L113	@ tmp145,
	bl	.L14		@
@ SpellSystem.c:362: 		if ( attributes & IA_WEAPON )
	tst	r0, r7	@ attributes, tmp179
	beq	.L87		@,
@ SpellSystem.c:364: 			if ( CanUnitUseWeaponNow(unit,unit->items[i]) ) { ret |= 1; }
	movs	r0, r5	@, unit
	ldrh	r1, [r6]	@ MEM[base: _68, offset: 0B], MEM[base: _68, offset: 0B]
	ldr	r3, .L113+4	@ tmp149,
	bl	.L14		@
@ SpellSystem.c:364: 			if ( CanUnitUseWeaponNow(unit,unit->items[i]) ) { ret |= 1; }
	cmp	r0, #0	@ tmp183,
	beq	.L88		@,
@ SpellSystem.c:364: 			if ( CanUnitUseWeaponNow(unit,unit->items[i]) ) { ret |= 1; }
	orrs	r4, r7	@ <retval>, tmp179
.L88:
@ SpellSystem.c:359: 	for ( int i = 0 ; i < 5 && unit->items[i] ; i++ )
	ldr	r3, [sp, #4]	@ _72, %sfp
	adds	r6, r6, #2	@ ivtmp.247,
	cmp	r6, r3	@ ivtmp.247, _72
	bne	.L86		@,
.L89:
@ SpellSystem.c:372: 	u8* spells = SpellsGetter(unit,-1);
	movs	r1, #1	@,
	movs	r0, r5	@, unit
	rsbs	r1, r1, #0	@,
	bl	SpellsGetter		@
@ SpellSystem.c:376: 		if ( attributes & IA_WEAPON )
	movs	r7, #1	@ tmp177,
@ SpellSystem.c:372: 	u8* spells = SpellsGetter(unit,-1);
	movs	r6, r0	@ ivtmp.241, tmp185
.L91:
@ SpellSystem.c:373: 	for ( int i = 0 ; spells[i] ; i++ )
	ldrb	r0, [r6]	@ _24, MEM[base: _60, offset: 0B]
@ SpellSystem.c:373: 	for ( int i = 0 ; spells[i] ; i++ )
	cmp	r0, #0	@ _24,
	bne	.L94		@,
@ SpellSystem.c:386: }
	@ sp needed	@
	movs	r0, r4	@, <retval>
	pop	{r1, r2, r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L87:
@ SpellSystem.c:366: 		else if ( attributes & IA_STAFF )
	movs	r3, #4	@ tmp192,
	tst	r0, r3	@ attributes, tmp192
	beq	.L88		@,
@ SpellSystem.c:368: 			if ( CanUnitUseStaffNow(unit,unit->items[i]) ) { ret |= 2; }
	movs	r0, r5	@, unit
	ldrh	r1, [r6]	@ MEM[base: _68, offset: 0B], MEM[base: _68, offset: 0B]
	ldr	r3, .L113+8	@ tmp156,
	bl	.L14		@
@ SpellSystem.c:368: 			if ( CanUnitUseStaffNow(unit,unit->items[i]) ) { ret |= 2; }
	cmp	r0, #0	@ tmp184,
	beq	.L88		@,
@ SpellSystem.c:368: 			if ( CanUnitUseStaffNow(unit,unit->items[i]) ) { ret |= 2; }
	movs	r3, #2	@ tmp159,
	orrs	r4, r3	@ <retval>, tmp159
	b	.L88		@
.L94:
@ SpellSystem.c:375: 		u32 attributes = GetItemAttributes(spells[i]);
	ldr	r3, .L113	@ tmp161,
	bl	.L14		@
@ SpellSystem.c:376: 		if ( attributes & IA_WEAPON )
	tst	r0, r7	@ attributes, tmp177
	beq	.L92		@,
@ SpellSystem.c:378: 			if ( CanUnitUseWeaponNow(unit,spells[i]) ) { ret |= 1; }
	movs	r0, r5	@, unit
	ldrb	r1, [r6]	@ MEM[base: _60, offset: 0B], MEM[base: _60, offset: 0B]
	ldr	r3, .L113+4	@ tmp165,
	bl	.L14		@
@ SpellSystem.c:378: 			if ( CanUnitUseWeaponNow(unit,spells[i]) ) { ret |= 1; }
	cmp	r0, #0	@ tmp187,
	beq	.L93		@,
@ SpellSystem.c:378: 			if ( CanUnitUseWeaponNow(unit,spells[i]) ) { ret |= 1; }
	orrs	r4, r7	@ <retval>, tmp177
.L93:
	adds	r6, r6, #1	@ ivtmp.241,
	b	.L91		@
.L92:
@ SpellSystem.c:380: 		else if ( attributes & IA_STAFF )
	movs	r3, #4	@ tmp195,
	tst	r0, r3	@ attributes, tmp195
	beq	.L93		@,
@ SpellSystem.c:382: 			if ( CanUnitUseStaffNow(unit,spells[i]) ) { ret |= 2; }
	movs	r0, r5	@, unit
	ldrb	r1, [r6]	@ MEM[base: _60, offset: 0B], MEM[base: _60, offset: 0B]
	ldr	r3, .L113+8	@ tmp172,
	bl	.L14		@
@ SpellSystem.c:382: 			if ( CanUnitUseStaffNow(unit,spells[i]) ) { ret |= 2; }
	cmp	r0, #0	@ tmp188,
	beq	.L93		@,
@ SpellSystem.c:382: 			if ( CanUnitUseStaffNow(unit,spells[i]) ) { ret |= 2; }
	movs	r3, #2	@ tmp175,
	orrs	r4, r3	@ <retval>, tmp175
	b	.L93		@
.L114:
	.align	2
.L113:
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
@ SpellSystem.c:478: {
	movs	r5, r0	@ unit, tmp128
@ SpellSystem.c:479: 	u8* spells = SpellsGetter(unit,type);
	bl	SpellsGetter		@
	movs	r4, r0	@ ivtmp.255, tmp130
.L116:
@ SpellSystem.c:480: 	for ( int i = 0 ; spells[i] ; i++ )
	ldrb	r0, [r4]	@ _8, MEM[base: _25, offset: 0B]
@ SpellSystem.c:480: 	for ( int i = 0 ; spells[i] ; i++ )
	cmp	r0, #0	@ _8,
	bne	.L120		@,
.L115:
@ SpellSystem.c:488: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L120:
@ SpellSystem.c:482: 		if ( GetItemType(spells[i]) != ITYPE_STAFF && CanCastSpellNow(unit,spells[i]) )
	ldr	r3, .L122	@ tmp125,
	bl	.L14		@
@ SpellSystem.c:482: 		if ( GetItemType(spells[i]) != ITYPE_STAFF && CanCastSpellNow(unit,spells[i]) )
	cmp	r0, #4	@ tmp131,
	bne	.L117		@,
.L119:
	adds	r4, r4, #1	@ ivtmp.255,
	b	.L116		@
.L117:
@ SpellSystem.c:482: 		if ( GetItemType(spells[i]) != ITYPE_STAFF && CanCastSpellNow(unit,spells[i]) )
	movs	r0, r5	@, unit
	ldrb	r1, [r4]	@ MEM[base: _25, offset: 0B], MEM[base: _25, offset: 0B]
	bl	CanCastSpellNow		@
@ SpellSystem.c:482: 		if ( GetItemType(spells[i]) != ITYPE_STAFF && CanCastSpellNow(unit,spells[i]) )
	cmp	r0, #0	@ tmp132,
	beq	.L119		@,
@ SpellSystem.c:484: 			return 1;
	movs	r0, #1	@ <retval>,
	b	.L115		@
.L123:
	.align	2
.L122:
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
@ SpellSystem.c:493: {
	movs	r7, r1	@ n, tmp125
	movs	r1, r2	@ type, tmp126
	movs	r5, r0	@ unit, tmp124
@ SpellSystem.c:494: 	u8* spells = SpellsGetter(unit,type);
	bl	SpellsGetter		@
@ SpellSystem.c:495: 	int k = -1;
	movs	r6, #1	@ k,
@ SpellSystem.c:496: 	for ( int i = 0 ; spells[i] ; i++ )
	movs	r4, #0	@ <retval>,
@ SpellSystem.c:494: 	u8* spells = SpellsGetter(unit,type);
	str	r0, [sp, #4]	@ tmp127, %sfp
@ SpellSystem.c:495: 	int k = -1;
	rsbs	r6, r6, #0	@ k, k
.L125:
@ SpellSystem.c:496: 	for ( int i = 0 ; spells[i] ; i++ )
	ldr	r3, [sp, #4]	@ spells, %sfp
	ldrb	r1, [r3, r4]	@ _6, MEM[base: spells_17, index: _1, offset: 0B]
@ SpellSystem.c:496: 	for ( int i = 0 ; spells[i] ; i++ )
	cmp	r1, #0	@ _6,
	bne	.L128		@,
@ SpellSystem.c:504: 	return -1;
	movs	r4, #1	@ <retval>,
	rsbs	r4, r4, #0	@ <retval>, <retval>
.L124:
@ SpellSystem.c:505: }
	movs	r0, r4	@, <retval>
	@ sp needed	@
	pop	{r1, r2, r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L128:
@ SpellSystem.c:498: 		if ( CanCastSpellNow(unit,spells[i]) )
	movs	r0, r5	@, unit
	bl	CanCastSpellNow		@
@ SpellSystem.c:498: 		if ( CanCastSpellNow(unit,spells[i]) )
	cmp	r0, #0	@ tmp128,
	beq	.L126		@,
@ SpellSystem.c:500: 			k++;
	adds	r6, r6, #1	@ k,
@ SpellSystem.c:501: 			if ( k == n ) { return i; }
	cmp	r6, r7	@ k, n
	beq	.L124		@,
.L126:
@ SpellSystem.c:496: 	for ( int i = 0 ; spells[i] ; i++ )
	adds	r4, r4, #1	@ <retval>,
	b	.L125		@
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
@ SpellSystem.c:518: {
	movs	r4, r1	@ spell, tmp123
@ SpellSystem.c:520: 	u8* spells = SpellsGetter(unit,-1);
	movs	r1, #1	@,
	rsbs	r1, r1, #0	@,
	bl	SpellsGetter		@
	movs	r3, r0	@ ivtmp.269, tmp124
.L133:
@ SpellSystem.c:521: 	for ( int i = 0 ; spells[i] ; i++ )
	ldrb	r0, [r3]	@ _3, MEM[base: _15, offset: 0B]
@ SpellSystem.c:521: 	for ( int i = 0 ; spells[i] ; i++ )
	cmp	r0, #0	@ _3,
	bne	.L135		@,
.L132:
@ SpellSystem.c:526: }
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L135:
@ SpellSystem.c:523: 		if ( spell == spells[i] ) { return 1; }
	adds	r3, r3, #1	@ ivtmp.269,
	cmp	r0, r4	@ _3, spell
	bne	.L133		@,
@ SpellSystem.c:523: 		if ( spell == spells[i] ) { return 1; }
	movs	r0, #1	@ <retval>,
	b	.L132		@
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
@ SpellSystem.c:423: 	if ( gBattleActor.levelPrevious != gBattleActor.unit.level ) { subject = &gBattleActor; }
	ldr	r3, .L147	@ tmp131,
	movs	r2, r3	@ tmp134, tmp131
@ SpellSystem.c:419: {
	push	{r4, lr}	@
@ SpellSystem.c:423: 	if ( gBattleActor.levelPrevious != gBattleActor.unit.level ) { subject = &gBattleActor; }
	adds	r2, r2, #112	@ tmp134,
	ldrb	r1, [r2]	@ tmp135,
@ SpellSystem.c:423: 	if ( gBattleActor.levelPrevious != gBattleActor.unit.level ) { subject = &gBattleActor; }
	movs	r2, #8	@ tmp137,
	ldrsb	r2, [r3, r2]	@ tmp137,
@ SpellSystem.c:422: 	BattleUnit* subject = NULL;
	movs	r0, #0	@ subject,
@ SpellSystem.c:423: 	if ( gBattleActor.levelPrevious != gBattleActor.unit.level ) { subject = &gBattleActor; }
	cmp	r1, r2	@ tmp135, tmp137
	beq	.L138		@,
@ SpellSystem.c:423: 	if ( gBattleActor.levelPrevious != gBattleActor.unit.level ) { subject = &gBattleActor; }
	movs	r0, r3	@ subject, tmp131
.L138:
@ SpellSystem.c:424: 	if ( gBattleTarget.levelPrevious != gBattleTarget.unit.level ) { subject = &gBattleTarget; }
	ldr	r3, .L147+4	@ tmp138,
	movs	r2, r3	@ tmp141, tmp138
	adds	r2, r2, #112	@ tmp141,
	ldrb	r1, [r2]	@ tmp142,
@ SpellSystem.c:424: 	if ( gBattleTarget.levelPrevious != gBattleTarget.unit.level ) { subject = &gBattleTarget; }
	movs	r2, #8	@ tmp144,
	ldrsb	r2, [r3, r2]	@ tmp144,
@ SpellSystem.c:424: 	if ( gBattleTarget.levelPrevious != gBattleTarget.unit.level ) { subject = &gBattleTarget; }
	cmp	r1, r2	@ tmp142, tmp144
	bne	.L143		@,
@ SpellSystem.c:425: 	if ( !subject ) { return 0; } // If this isn't filled, we shouldn't show a popup.
	cmp	r0, #0	@ subject,
	bne	.L139		@,
.L141:
@ SpellSystem.c:425: 	if ( !subject ) { return 0; } // If this isn't filled, we shouldn't show a popup.
	movs	r0, #0	@ <retval>,
.L137:
@ SpellSystem.c:434: }
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L143:
@ SpellSystem.c:424: 	if ( gBattleTarget.levelPrevious != gBattleTarget.unit.level ) { subject = &gBattleTarget; }
	movs	r0, r3	@ subject, tmp138
.L139:
@ SpellSystem.c:427: 	u8* spells = SpellsGetterForLevel(&subject->unit,subject->unit.level,-1);
	movs	r1, #8	@ tmp146,
	movs	r2, #1	@,
	ldrsb	r1, [r0, r1]	@ tmp146,
	rsbs	r2, r2, #0	@,
	bl	SpellsGetterForLevel		@
@ SpellSystem.c:429: 	if ( *spells )
	ldrb	r2, [r0]	@ _12, *spells_22
@ SpellSystem.c:429: 	if ( *spells )
	cmp	r2, #0	@ _12,
	beq	.L141		@,
@ SpellSystem.c:431: 		gPopupItem = *spells|0xFF00;
	ldr	r3, .L147+8	@ tmp150,
	orrs	r3, r2	@ tmp149, _12
@ SpellSystem.c:431: 		gPopupItem = *spells|0xFF00;
	ldr	r2, .L147+12	@ tmp147,
@ SpellSystem.c:432: 		return 1;
	movs	r0, #1	@ <retval>,
@ SpellSystem.c:431: 		gPopupItem = *spells|0xFF00;
	strh	r3, [r2]	@ tmp149, gPopupItem
@ SpellSystem.c:432: 		return 1;
	b	.L137		@
.L148:
	.align	2
.L147:
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
@ SpellSystem.c:538: 	return GaidenSpellCostTable[GetItemIndex(spell)];
	ldr	r3, .L150	@ tmp118,
@ SpellSystem.c:539: }
	@ sp needed	@
@ SpellSystem.c:538: 	return GaidenSpellCostTable[GetItemIndex(spell)];
	bl	.L14		@
@ SpellSystem.c:538: 	return GaidenSpellCostTable[GetItemIndex(spell)];
	ldr	r3, .L150+4	@ tmp122,
	ldrb	r0, [r3, r0]	@ tmp121, GaidenSpellCostTable
@ SpellSystem.c:539: }
	pop	{r4}
	pop	{r1}
	bx	r1
.L151:
	.align	2
.L150:
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
@ SpellSystem.c:439: 	return unit->curHP > GetSpellCost(spell);
	movs	r4, #19	@ _2,
	ldrsb	r4, [r0, r4]	@ _2,* _2
@ SpellSystem.c:439: 	return unit->curHP > GetSpellCost(spell);
	movs	r0, r1	@, spell
	bl	GetSpellCost		@
@ SpellSystem.c:439: 	return unit->curHP > GetSpellCost(spell);
	movs	r3, #1	@ tmp121,
	cmp	r4, r0	@ _2, tmp130
	bgt	.L153		@,
	movs	r3, #0	@ tmp121,
.L153:
@ SpellSystem.c:440: }
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
	ldr	r6, .L166	@ validList,
@ UnitMenu.c:21: 		if ( !CanCastSpellNow(gActiveUnit,spellList[i]|0xFF00) ) { continue; }
	movs	r7, #255	@ tmp142,
@ UnitMenu.c:17: {
	movs	r5, r0	@ ivtmp.291, tmp143
	movs	r4, r6	@ validList, validList
@ UnitMenu.c:21: 		if ( !CanCastSpellNow(gActiveUnit,spellList[i]|0xFF00) ) { continue; }
	lsls	r7, r7, #8	@ tmp142, tmp142,
.L155:
@ UnitMenu.c:19: 	for ( int i = 0 ; spellList[i] ; i++ )
	ldrb	r1, [r5]	@ _9, MEM[base: _42, offset: 0B]
@ UnitMenu.c:19: 	for ( int i = 0 ; spellList[i] ; i++ )
	cmp	r1, #0	@ _9,
	bne	.L157		@,
@ UnitMenu.c:25: 	*validList = 0;
	strb	r1, [r6]	@ _9, *validList_15
@ UnitMenu.c:28: 	if ( !*validList ) { return 3; } // Return unusable if there are no valid spells.
	ldrb	r3, [r4]	@ MEM[(u8 *)&gGenericBuffer], MEM[(u8 *)&gGenericBuffer]
@ UnitMenu.c:28: 	if ( !*validList ) { return 3; } // Return unusable if there are no valid spells.
	movs	r0, #3	@ <retval>,
@ UnitMenu.c:28: 	if ( !*validList ) { return 3; } // Return unusable if there are no valid spells.
	cmp	r3, #0	@ MEM[(u8 *)&gGenericBuffer],
	beq	.L154		@,
.L159:
@ UnitMenu.c:29: 	for ( int i = 0 ; validList[i] ; i++ )
	ldrb	r1, [r4]	@ _30, MEM[base: _37, offset: 0B]
@ UnitMenu.c:29: 	for ( int i = 0 ; validList[i] ; i++ )
	cmp	r1, #0	@ _30,
	bne	.L160		@,
@ UnitMenu.c:34: 	return 2; // There were valid spells, but we don't have enough HP to cast any of them. Return greyed out.
	movs	r0, #2	@ <retval>,
.L154:
@ UnitMenu.c:35: }
	@ sp needed	@
	pop	{r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L157:
@ UnitMenu.c:21: 		if ( !CanCastSpellNow(gActiveUnit,spellList[i]|0xFF00) ) { continue; }
	ldr	r3, .L166+4	@ tmp133,
	orrs	r1, r7	@ tmp131, tmp142
	ldr	r0, [r3]	@, gActiveUnit
	bl	CanCastSpellNow		@
@ UnitMenu.c:21: 		if ( !CanCastSpellNow(gActiveUnit,spellList[i]|0xFF00) ) { continue; }
	cmp	r0, #0	@ tmp144,
	beq	.L156		@,
@ UnitMenu.c:22: 		*validList = spellList[i];
	ldrb	r3, [r5]	@ _6, MEM[base: _42, offset: 0B]
@ UnitMenu.c:22: 		*validList = spellList[i];
	strb	r3, [r6]	@ _6, *validList_15
@ UnitMenu.c:23: 		validList++;
	adds	r6, r6, #1	@ validList,
.L156:
	adds	r5, r5, #1	@ ivtmp.291,
	b	.L155		@
.L160:
@ UnitMenu.c:32: 		if ( HasSufficientHP(gActiveUnit,validList[i]) ) { return 1; } // We've found a spell we can cast! Return usable.
	ldr	r3, .L166+4	@ tmp139,
	ldr	r0, [r3]	@, gActiveUnit
	bl	HasSufficientHP		@
@ UnitMenu.c:32: 		if ( HasSufficientHP(gActiveUnit,validList[i]) ) { return 1; } // We've found a spell we can cast! Return usable.
	adds	r4, r4, #1	@ ivtmp.287,
	cmp	r0, #0	@ tmp145,
	beq	.L159		@,
@ UnitMenu.c:32: 		if ( HasSufficientHP(gActiveUnit,validList[i]) ) { return 1; } // We've found a spell we can cast! Return usable.
	movs	r0, #1	@ <retval>,
	b	.L154		@
.L167:
	.align	2
.L166:
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
	ldr	r3, .L169	@ tmp116,
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
.L170:
	.align	2
.L169:
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
	ldr	r3, .L172	@ tmp116,
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
.L173:
	.align	2
.L172:
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
@ SpellSystem.c:402: 	if ( HasSufficientHP(&unit->unit,unit->weapon) )
	movs	r6, r0	@ tmp137, unit
	adds	r6, r6, #72	@ tmp137,
@ SpellSystem.c:401: {
	movs	r4, r1	@ buffer, tmp159
@ SpellSystem.c:402: 	if ( HasSufficientHP(&unit->unit,unit->weapon) )
	ldrh	r1, [r6]	@ tmp138,
@ SpellSystem.c:401: {
	movs	r5, r0	@ unit, tmp158
@ SpellSystem.c:402: 	if ( HasSufficientHP(&unit->unit,unit->weapon) )
	bl	HasSufficientHP		@
@ SpellSystem.c:402: 	if ( HasSufficientHP(&unit->unit,unit->weapon) )
	cmp	r0, #0	@ tmp160,
	beq	.L175		@,
@ SpellSystem.c:404: 		int cost = GetSpellCost(unit->weapon);
	ldrh	r0, [r6]	@ tmp142,
	bl	GetSpellCost		@
@ SpellSystem.c:406: 		buffer->attributes |= BATTLE_HIT_ATTR_HPSTEAL; // "HP drain" bit.
	movs	r3, #128	@ tmp145,
	ldr	r2, [r4]	@ tmp164,* buffer
	lsls	r3, r3, #1	@ tmp145, tmp145,
	orrs	r3, r2	@ tmp143, tmp164
	str	r3, [r4]	@ tmp143,* buffer
@ SpellSystem.c:408: 		unit->unit.curHP -= cost;
	lsls	r3, r0, #24	@ _21, tmp161,
	ldrb	r2, [r5, #19]	@ tmp148,
	lsrs	r3, r3, #24	@ _21, _21,
	subs	r2, r2, r3	@ tmp149, tmp148, _21
	strb	r2, [r5, #19]	@ tmp149, unit_8(D)->unit.curHP
@ SpellSystem.c:409: 		buffer->damage -= cost;
	ldrb	r0, [r4, #5]	@ tmp152,
	subs	r3, r0, r3	@ tmp153, tmp152, _21
	strb	r3, [r4, #5]	@ tmp153, buffer_11(D)->damage
.L174:
@ SpellSystem.c:416: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L175:
@ SpellSystem.c:414: 		buffer->attributes |= BATTLE_HIT_ATTR_5; // This bit is checked in an external hack I've made.
	movs	r3, #32	@ tmp157,
	ldr	r2, [r4]	@ tmp165,* buffer
	orrs	r3, r2	@ tmp155, tmp165
	str	r3, [r4]	@ tmp155,* buffer
@ SpellSystem.c:416: }
	b	.L174		@
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
@ SpellSystem.c:394: 	if ( GetUnitEquippedWeaponSlot(&attacker->unit) == 9 ) // Instead of checking against UsingSpellMenu, we do this to cover the case of defense.
	ldr	r3, .L179	@ tmp119,
@ SpellSystem.c:392: {
	movs	r4, r0	@ attacker, tmp120
	movs	r5, r2	@ buffer, tmp121
@ SpellSystem.c:394: 	if ( GetUnitEquippedWeaponSlot(&attacker->unit) == 9 ) // Instead of checking against UsingSpellMenu, we do this to cover the case of defense.
	bl	.L14		@
@ SpellSystem.c:394: 	if ( GetUnitEquippedWeaponSlot(&attacker->unit) == 9 ) // Instead of checking against UsingSpellMenu, we do this to cover the case of defense.
	cmp	r0, #9	@ tmp122,
	bne	.L177		@,
@ SpellSystem.c:396: 		SetRoundForSpell(attacker,buffer);
	movs	r1, r5	@, buffer
	movs	r0, r4	@, attacker
	bl	SetRoundForSpell		@
.L177:
@ SpellSystem.c:398: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L180:
	.align	2
.L179:
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
@ SpellSystem.c:543: 	u8* spells = SpellsGetter(unit,-1);
	movs	r1, #1	@,
@ SpellSystem.c:542: {
	push	{r4, r5, r6, lr}	@
@ SpellSystem.c:543: 	u8* spells = SpellsGetter(unit,-1);
	rsbs	r1, r1, #0	@,
	bl	SpellsGetter		@
	movs	r4, r0	@ ivtmp.311, tmp126
.L182:
@ SpellSystem.c:545: 	for ( int i = 0 ; spells[i] ; i++ )
	ldrb	r0, [r4]	@ _7, MEM[base: _6, offset: 0B]
	movs	r5, r4	@ _6, ivtmp.311
@ SpellSystem.c:545: 	for ( int i = 0 ; spells[i] ; i++ )
	cmp	r0, #0	@ _7,
	beq	.L181		@,
@ SpellSystem.c:547: 		if ( GetItemType(spells[i]) != ITYPE_STAFF ) { spell = spells[i]; break; } // Ensure that the spell we could counter with would be an attack spell.
	ldr	r3, .L187	@ tmp123,
	bl	.L14		@
@ SpellSystem.c:547: 		if ( GetItemType(spells[i]) != ITYPE_STAFF ) { spell = spells[i]; break; } // Ensure that the spell we could counter with would be an attack spell.
	adds	r4, r4, #1	@ ivtmp.311,
	cmp	r0, #4	@ tmp127,
	beq	.L182		@,
@ SpellSystem.c:547: 		if ( GetItemType(spells[i]) != ITYPE_STAFF ) { spell = spells[i]; break; } // Ensure that the spell we could counter with would be an attack spell.
	ldrb	r0, [r5]	@ <retval>, *_6
.L181:
@ SpellSystem.c:550: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L188:
	.align	2
.L187:
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
	movs	r6, r0	@ unit, tmp165
@ SpellSystem.c:509: 	for ( int i = 0 ; i < 5 ; i++ )
	movs	r5, #0	@ i,
.L192:
@ SpellSystem.c:511: 		if ( CanUnitUseWeapon(unit,unit->items[i]) ) { return unit->items[i]; }
	movs	r3, r6	@ tmp136, unit
@ SpellSystem.c:511: 		if ( CanUnitUseWeapon(unit,unit->items[i]) ) { return unit->items[i]; }
	lsls	r2, r5, #1	@ tmp137, i,
@ SpellSystem.c:511: 		if ( CanUnitUseWeapon(unit,unit->items[i]) ) { return unit->items[i]; }
	adds	r3, r3, #30	@ tmp136,
	ldrh	r1, [r3, r2]	@ MEM[base: _31, index: _40, offset: 0B], MEM[base: _31, index: _40, offset: 0B]
	movs	r0, r6	@, unit
	ldr	r3, .L212	@ tmp139,
	bl	.L14		@
	subs	r4, r0, #0	@ <retval>, tmp166,
@ SpellSystem.c:511: 		if ( CanUnitUseWeapon(unit,unit->items[i]) ) { return unit->items[i]; }
	beq	.L190		@,
@ SpellSystem.c:511: 		if ( CanUnitUseWeapon(unit,unit->items[i]) ) { return unit->items[i]; }
	adds	r5, r5, #12	@ tmp140,
	lsls	r5, r5, #1	@ tmp141, tmp140,
	adds	r5, r6, r5	@ tmp142, unit, tmp141
	ldrh	r4, [r5, #6]	@ <retval>, *unit_21(D)
.L191:
@ SpellSystem.c:140: 	int spell = GetFirstAttackSpell(unit);
	movs	r0, r6	@, unit
	bl	GetFirstAttackSpell		@
@ SpellSystem.c:143: 	if ( gChapterData.currentPhase == ( unit->index & 0xC0 ) )
	movs	r3, #192	@ tmp144,
@ SpellSystem.c:143: 	if ( gChapterData.currentPhase == ( unit->index & 0xC0 ) )
	ldrb	r6, [r6, #11]	@ _3,
@ SpellSystem.c:143: 	if ( gChapterData.currentPhase == ( unit->index & 0xC0 ) )
	ldr	r1, .L212+4	@ tmp145,
@ SpellSystem.c:143: 	if ( gChapterData.currentPhase == ( unit->index & 0xC0 ) )
	lsls	r6, r6, #24	@ _3, _3,
@ SpellSystem.c:143: 	if ( gChapterData.currentPhase == ( unit->index & 0xC0 ) )
	ldrb	r1, [r1, #15]	@ tmp146,
@ SpellSystem.c:143: 	if ( gChapterData.currentPhase == ( unit->index & 0xC0 ) )
	asrs	r6, r6, #24	@ _3, _3,
@ SpellSystem.c:140: 	int spell = GetFirstAttackSpell(unit);
	movs	r2, r0	@ spell, tmp167
@ SpellSystem.c:143: 	if ( gChapterData.currentPhase == ( unit->index & 0xC0 ) )
	ands	r3, r6	@ _5, _3
	ldr	r0, .L212+8	@ tmp163,
@ SpellSystem.c:143: 	if ( gChapterData.currentPhase == ( unit->index & 0xC0 ) )
	cmp	r1, r3	@ tmp146, _5
	bne	.L193		@,
@ SpellSystem.c:147: 		if ( !UsingSpellMenu && ( unit->index & 0xC0 ) ) { return vanillaEquipped; } // enemies wielding their vanilla wep 		
	ldrb	r3, [r0]	@ UsingSpellMenu, UsingSpellMenu
	cmp	r3, #0	@ UsingSpellMenu,
	bne	.L194		@,
@ SpellSystem.c:147: 		if ( !UsingSpellMenu && ( unit->index & 0xC0 ) ) { return vanillaEquipped; } // enemies wielding their vanilla wep 		
	cmp	r1, #0	@ tmp146,
	bne	.L189		@,
@ SpellSystem.c:148: 		if ( !UsingSpellMenu && !( unit->index & 0xC0 ) ) { return ( spell ? spell|0xFF00 : 0 ); } // for mmb - show first spell 
	movs	r4, r1	@ <retval>, tmp146
.L211:
@ SpellSystem.c:198: 		if ( !UsingSpellMenu && !( unit->index & 0xC0 ) ) { return ( spell ? spell|0xFF00 : 0 ); } // for mmb - show first spell 
	cmp	r2, #0	@ spell,
	beq	.L189		@,
.L209:
@ SpellSystem.c:199: 		return ( spell ? spell|0xFF00 : 0 );
	movs	r4, #255	@ tmp161,
	lsls	r4, r4, #8	@ tmp161, tmp161,
	orrs	r4, r2	@ <retval>, spell
	b	.L189		@
.L190:
@ SpellSystem.c:509: 	for ( int i = 0 ; i < 5 ; i++ )
	adds	r5, r5, #1	@ i,
@ SpellSystem.c:509: 	for ( int i = 0 ; i < 5 ; i++ )
	cmp	r5, #5	@ i,
	bne	.L192		@,
	b	.L191		@
.L194:
@ SpellSystem.c:153: 			if ( unit->index == gBattleTarget.unit.index && GetItemType(SelectedSpell) == ITYPE_STAFF )
	ldr	r3, .L212+12	@ tmp150,
@ SpellSystem.c:153: 			if ( unit->index == gBattleTarget.unit.index && GetItemType(SelectedSpell) == ITYPE_STAFF )
	ldrb	r3, [r3, #11]	@ tmp151,
	lsls	r3, r3, #24	@ tmp151, tmp151,
	ldr	r5, .L212+16	@ tmp164,
	asrs	r3, r3, #24	@ tmp151, tmp151,
	cmp	r3, r6	@ tmp151, _3
	beq	.L196		@,
.L197:
@ SpellSystem.c:184: 				return SelectedSpell|0xFF00; 
	movs	r4, #255	@ tmp154,
	ldrb	r0, [r5]	@ SelectedSpell, SelectedSpell
	lsls	r4, r4, #8	@ tmp154, tmp154,
	orrs	r4, r0	@ <retval>, SelectedSpell
.L189:
@ SpellSystem.c:202: }
	movs	r0, r4	@, <retval>
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L196:
@ SpellSystem.c:153: 			if ( unit->index == gBattleTarget.unit.index && GetItemType(SelectedSpell) == ITYPE_STAFF )
	ldrb	r0, [r5]	@ SelectedSpell, SelectedSpell
	ldr	r3, .L212+20	@ tmp157,
	bl	.L14		@
@ SpellSystem.c:153: 			if ( unit->index == gBattleTarget.unit.index && GetItemType(SelectedSpell) == ITYPE_STAFF )
	cmp	r0, #4	@ tmp168,
	bne	.L197		@,
	b	.L189		@
.L193:
@ SpellSystem.c:197: 		if ( !UsingSpellMenu && ( unit->index & 0xC0 ) ) { return vanillaEquipped; } // enemies wielding their vanilla wep 		
	ldrb	r1, [r0]	@ UsingSpellMenu, UsingSpellMenu
	cmp	r1, #0	@ UsingSpellMenu,
	bne	.L198		@,
@ SpellSystem.c:197: 		if ( !UsingSpellMenu && ( unit->index & 0xC0 ) ) { return vanillaEquipped; } // enemies wielding their vanilla wep 		
	cmp	r3, #0	@ _5,
	bne	.L189		@,
@ SpellSystem.c:148: 		if ( !UsingSpellMenu && !( unit->index & 0xC0 ) ) { return ( spell ? spell|0xFF00 : 0 ); } // for mmb - show first spell 
	movs	r4, r3	@ <retval>, _5
	b	.L211		@
.L198:
@ SpellSystem.c:148: 		if ( !UsingSpellMenu && !( unit->index & 0xC0 ) ) { return ( spell ? spell|0xFF00 : 0 ); } // for mmb - show first spell 
	movs	r4, #0	@ <retval>,
@ SpellSystem.c:199: 		return ( spell ? spell|0xFF00 : 0 );
	cmp	r2, r4	@ spell,
	beq	.L189		@,
	b	.L209		@
.L213:
	.align	2
.L212:
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
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, lr}	@
@ SpellSystem.c:209: {
	movs	r5, r0	@ unit, tmp189
@ SpellSystem.c:220: 	int spell = GetFirstAttackSpell(unit);
	bl	GetFirstAttackSpell		@
@ SpellSystem.c:223: 	if ( !(UsingSpellMenu) && unit->index != gBattleTarget.unit.index && (gBattleStats.config & (BATTLE_CONFIG_REAL|BATTLE_CONFIG_SIMULATE)) ) { 
	ldr	r3, .L249	@ tmp150,
@ SpellSystem.c:223: 	if ( !(UsingSpellMenu) && unit->index != gBattleTarget.unit.index && (gBattleStats.config & (BATTLE_CONFIG_REAL|BATTLE_CONFIG_SIMULATE)) ) { 
	ldrb	r4, [r3]	@ UsingSpellMenu, UsingSpellMenu
@ SpellSystem.c:220: 	int spell = GetFirstAttackSpell(unit);
	movs	r6, r0	@ spell, tmp190
	ldr	r7, .L249+4	@ tmp187,
@ SpellSystem.c:223: 	if ( !(UsingSpellMenu) && unit->index != gBattleTarget.unit.index && (gBattleStats.config & (BATTLE_CONFIG_REAL|BATTLE_CONFIG_SIMULATE)) ) { 
	cmp	r4, #0	@ UsingSpellMenu,
	bne	.L215		@,
@ SpellSystem.c:223: 	if ( !(UsingSpellMenu) && unit->index != gBattleTarget.unit.index && (gBattleStats.config & (BATTLE_CONFIG_REAL|BATTLE_CONFIG_SIMULATE)) ) { 
	movs	r2, #11	@ tmp153,
	ldr	r3, .L249+8	@ tmp152,
	ldrb	r3, [r3, #11]	@ tmp154,
	ldrsb	r2, [r5, r2]	@ tmp153,
	lsls	r3, r3, #24	@ tmp154, tmp154,
	asrs	r3, r3, #24	@ tmp154, tmp154,
	cmp	r2, r3	@ tmp153, tmp154
	beq	.L216		@,
@ SpellSystem.c:223: 	if ( !(UsingSpellMenu) && unit->index != gBattleTarget.unit.index && (gBattleStats.config & (BATTLE_CONFIG_REAL|BATTLE_CONFIG_SIMULATE)) ) { 
	ldr	r3, .L249+12	@ tmp200,
	ldrh	r3, [r3]	@ gBattleStats, gBattleStats
	lsls	r3, r3, #30	@ tmp199, gBattleStats,
	beq	.L216		@,
	movs	r6, r5	@ ivtmp.332, unit
	adds	r6, r6, #30	@ ivtmp.332,
.L219:
@ SpellSystem.c:227: 			if ( CanUnitUseWeapon(unit,unit->items[i]) )
	movs	r0, r5	@, unit
	ldrh	r1, [r6]	@ MEM[base: _39, offset: 0B], MEM[base: _39, offset: 0B]
	bl	.L251		@
@ SpellSystem.c:227: 			if ( CanUnitUseWeapon(unit,unit->items[i]) )
	cmp	r0, #0	@ tmp191,
	bne	.L217		@,
.L220:
@ SpellSystem.c:234: 		return -1; 
	movs	r4, #1	@ <retval>,
	rsbs	r4, r4, #0	@ <retval>, <retval>
.L214:
@ SpellSystem.c:351: }
	movs	r0, r4	@, <retval>
	@ sp needed	@
	pop	{r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L217:
@ SpellSystem.c:230: 				if ( gCan_Attack_Target(unit->items[i],gBattleStats.range,unit) ) { return i; }
	ldr	r3, .L249+12	@ tmp202,
	ldrb	r1, [r3, #2]	@ tmp166,
	ldr	r3, .L249+16	@ tmp168,
	movs	r2, r5	@, unit
	ldrh	r0, [r6]	@ MEM[base: _39, offset: 0B], MEM[base: _39, offset: 0B]
	ldr	r3, [r3]	@ gCan_Attack_Target, gCan_Attack_Target
	bl	.L14		@
@ SpellSystem.c:230: 				if ( gCan_Attack_Target(unit->items[i],gBattleStats.range,unit) ) { return i; }
	cmp	r0, #0	@ tmp192,
	bne	.L214		@,
@ SpellSystem.c:224: 		for ( int i = 0 ; i < 5 ; i++ )
	adds	r4, r4, #1	@ <retval>,
@ SpellSystem.c:224: 		for ( int i = 0 ; i < 5 ; i++ )
	adds	r6, r6, #2	@ ivtmp.332,
	cmp	r4, #5	@ <retval>,
	bne	.L219		@,
	b	.L220		@
.L215:
@ SpellSystem.c:240: 	if ( UsingSpellMenu && CanUnitUseWeapon(unit,SelectedSpell) && !(unit->index & 0xC0) ) { 
	ldr	r3, .L249+20	@ tmp170,
	movs	r0, r5	@, unit
	ldrb	r1, [r3]	@ SelectedSpell, SelectedSpell
	bl	.L251		@
@ SpellSystem.c:240: 	if ( UsingSpellMenu && CanUnitUseWeapon(unit,SelectedSpell) && !(unit->index & 0xC0) ) { 
	cmp	r0, #0	@ tmp193,
	beq	.L216		@,
@ SpellSystem.c:240: 	if ( UsingSpellMenu && CanUnitUseWeapon(unit,SelectedSpell) && !(unit->index & 0xC0) ) { 
	movs	r2, #11	@ tmp173,
@ SpellSystem.c:240: 	if ( UsingSpellMenu && CanUnitUseWeapon(unit,SelectedSpell) && !(unit->index & 0xC0) ) { 
	movs	r3, #192	@ tmp175,
@ SpellSystem.c:240: 	if ( UsingSpellMenu && CanUnitUseWeapon(unit,SelectedSpell) && !(unit->index & 0xC0) ) { 
	ldrsb	r2, [r5, r2]	@ tmp173,
@ SpellSystem.c:240: 	if ( UsingSpellMenu && CanUnitUseWeapon(unit,SelectedSpell) && !(unit->index & 0xC0) ) { 
	tst	r2, r3	@ tmp173, tmp175
	beq	.L221		@,
.L223:
@ SpellSystem.c:224: 		for ( int i = 0 ; i < 5 ; i++ )
	movs	r4, #0	@ <retval>,
.L222:
@ SpellSystem.c:253: 				if ( CanUnitUseWeapon(unit,unit->items[i]) ) { return i; }
	movs	r3, r5	@ tmp178, unit
@ SpellSystem.c:253: 				if ( CanUnitUseWeapon(unit,unit->items[i]) ) { return i; }
	lsls	r2, r4, #1	@ tmp179, <retval>,
@ SpellSystem.c:253: 				if ( CanUnitUseWeapon(unit,unit->items[i]) ) { return i; }
	adds	r3, r3, #30	@ tmp178,
	movs	r0, r5	@, unit
	ldrh	r1, [r3, r2]	@ MEM[base: _37, index: _14, offset: 0B], MEM[base: _37, index: _14, offset: 0B]
	bl	.L251		@
@ SpellSystem.c:253: 				if ( CanUnitUseWeapon(unit,unit->items[i]) ) { return i; }
	cmp	r0, #0	@ tmp194,
	bne	.L214		@,
@ SpellSystem.c:251: 		for ( int i = 0 ; i < 5 ; i++ )
	adds	r4, r4, #1	@ <retval>,
@ SpellSystem.c:251: 		for ( int i = 0 ; i < 5 ; i++ )
	cmp	r4, #5	@ <retval>,
	bne	.L222		@,
	b	.L220		@
.L216:
@ SpellSystem.c:250: 	if ( unit->index & 0xC0 ) {
	movs	r2, #11	@ tmp176,
	ldrsb	r2, [r5, r2]	@ tmp176,
@ SpellSystem.c:250: 	if ( unit->index & 0xC0 ) {
	movs	r3, #192	@ tmp177,
	movs	r4, r2	@ <retval>, tmp176
	ands	r4, r3	@ <retval>, tmp177
@ SpellSystem.c:250: 	if ( unit->index & 0xC0 ) {
	tst	r2, r3	@ tmp176, tmp177
	bne	.L223		@,
@ SpellSystem.c:262: 	if ( gChapterData.currentPhase != ( unit->index & 0xC0 ) && ( CanUnitUseWeapon( unit, spell ) ) ) { return ( spell ? 9 : 0 ); } // Enemy phase - Always counter attack with first spell.
	ldr	r3, .L249+24	@ tmp182,
@ SpellSystem.c:262: 	if ( gChapterData.currentPhase != ( unit->index & 0xC0 ) && ( CanUnitUseWeapon( unit, spell ) ) ) { return ( spell ? 9 : 0 ); } // Enemy phase - Always counter attack with first spell.
	ldrb	r3, [r3, #15]	@ tmp183,
	cmp	r3, #0	@ tmp183,
	beq	.L225		@,
@ SpellSystem.c:262: 	if ( gChapterData.currentPhase != ( unit->index & 0xC0 ) && ( CanUnitUseWeapon( unit, spell ) ) ) { return ( spell ? 9 : 0 ); } // Enemy phase - Always counter attack with first spell.
	movs	r1, r6	@, spell
	movs	r0, r5	@, unit
	bl	.L251		@
@ SpellSystem.c:262: 	if ( gChapterData.currentPhase != ( unit->index & 0xC0 ) && ( CanUnitUseWeapon( unit, spell ) ) ) { return ( spell ? 9 : 0 ); } // Enemy phase - Always counter attack with first spell.
	cmp	r0, #0	@ tmp195,
	beq	.L225		@,
.L248:
@ SpellSystem.c:269: 	if ( CanUnitUseWeapon( unit, spell ) ) { return ( spell ? 9 : 0 ); } // Used in stat screen by players. 
	cmp	r6, #0	@ spell,
	beq	.L214		@,
.L221:
@ SpellSystem.c:242: 		return 9;
	movs	r4, #9	@ <retval>,
	b	.L214		@
.L225:
@ SpellSystem.c:269: 	if ( CanUnitUseWeapon( unit, spell ) ) { return ( spell ? 9 : 0 ); } // Used in stat screen by players. 
	movs	r1, r6	@, spell
	movs	r0, r5	@, unit
	bl	.L251		@
@ SpellSystem.c:269: 	if ( CanUnitUseWeapon( unit, spell ) ) { return ( spell ? 9 : 0 ); } // Used in stat screen by players. 
	cmp	r0, #0	@ tmp196,
	bne	.L248		@,
	b	.L220		@
.L250:
	.align	2
.L249:
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
@ SpellSystem.c:557: 	if ( UsingSpellMenu )
	ldr	r3, .L255	@ tmp123,
@ SpellSystem.c:557: 	if ( UsingSpellMenu )
	ldrb	r3, [r3]	@ UsingSpellMenu, UsingSpellMenu
	cmp	r3, #0	@ UsingSpellMenu,
	beq	.L253		@,
@ SpellSystem.c:559: 		item = SelectedSpell|0xFF00;
	ldr	r3, .L255+4	@ tmp125,
	ldrb	r2, [r3]	@ SelectedSpell, SelectedSpell
@ SpellSystem.c:559: 		item = SelectedSpell|0xFF00;
	movs	r3, #255	@ tmp128,
	lsls	r3, r3, #8	@ tmp128, tmp128,
	orrs	r2, r3	@ item, tmp128
.L254:
@ SpellSystem.c:565: 	gHealStaff_RangeSetup(unit,0,item);
	ldr	r3, .L255+8	@ tmp137,
@ SpellSystem.c:566: }
	@ sp needed	@
@ SpellSystem.c:565: 	gHealStaff_RangeSetup(unit,0,item);
	movs	r1, #0	@,
	ldr	r3, [r3]	@ gHealStaff_RangeSetup, gHealStaff_RangeSetup
	bl	.L14		@
@ SpellSystem.c:566: }
	pop	{r4}
	pop	{r0}
	bx	r0
.L253:
@ SpellSystem.c:563: 		item = unit->unit.items[gActionData.itemSlotIndex];
	ldr	r3, .L255+12	@ tmp131,
	ldrb	r3, [r3, #18]	@ tmp132,
@ SpellSystem.c:563: 		item = unit->unit.items[gActionData.itemSlotIndex];
	adds	r3, r3, #12	@ tmp133,
	lsls	r3, r3, #1	@ tmp134, tmp133,
	adds	r3, r0, r3	@ tmp135, unit, tmp134
	ldrh	r2, [r3, #6]	@ item, *unit_11(D)
	b	.L254		@
.L256:
	.align	2
.L255:
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
@ SpellSystem.c:570: 	UsingSpellMenu = 0;
	movs	r3, #0	@ tmp114,
@ SpellSystem.c:573: }
	@ sp needed	@
@ SpellSystem.c:570: 	UsingSpellMenu = 0;
	ldr	r2, .L258	@ tmp113,
	strb	r3, [r2]	@ tmp114, UsingSpellMenu
@ SpellSystem.c:571: 	SelectedSpell = 0;
	ldr	r2, .L258+4	@ tmp116,
	strb	r3, [r2]	@ tmp114, SelectedSpell
@ SpellSystem.c:572: 	DidSelectSpell = 0;
	ldr	r2, .L258+8	@ tmp119,
	strb	r3, [r2]	@ tmp114, DidSelectSpell
@ SpellSystem.c:573: }
	bx	lr
.L259:
	.align	2
.L258:
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
	ldr	r3, .L276	@ tmp130,
@ RangeDisplay.c:40: {
	str	r1, [sp, #4]	@ tmp139, %sfp
@ RangeDisplay.c:42: 	u8* spells = SpellsGetter(unit,(UsingSpellMenu ? UsingSpellMenu : -1)); // If UsingSpellMenu is nonzero, only get Gaiden spells of that type.
	ldrb	r1, [r3]	@ UsingSpellMenu.73_1, UsingSpellMenu
@ RangeDisplay.c:40: {
	movs	r7, r0	@ unit, tmp138
@ RangeDisplay.c:42: 	u8* spells = SpellsGetter(unit,(UsingSpellMenu ? UsingSpellMenu : -1)); // If UsingSpellMenu is nonzero, only get Gaiden spells of that type.
	cmp	r1, #0	@ UsingSpellMenu.73_1,
	bne	.L261		@,
	subs	r1, r1, #1	@ iftmp.72_16,
.L261:
@ RangeDisplay.c:41: 	long long current = 0;
	movs	r5, #0	@ <retval>,
@ RangeDisplay.c:42: 	u8* spells = SpellsGetter(unit,(UsingSpellMenu ? UsingSpellMenu : -1)); // If UsingSpellMenu is nonzero, only get Gaiden spells of that type.
	movs	r0, r7	@, unit
	bl	SpellsGetter		@
@ RangeDisplay.c:41: 	long long current = 0;
	movs	r4, r5	@ <retval>, <retval>
@ RangeDisplay.c:42: 	u8* spells = SpellsGetter(unit,(UsingSpellMenu ? UsingSpellMenu : -1)); // If UsingSpellMenu is nonzero, only get Gaiden spells of that type.
	str	r0, [sp]	@ tmp140, %sfp
.L262:
@ RangeDisplay.c:43: 	for ( int i = 0 ; spells[i] ; i++ )
	ldr	r3, [sp]	@ ivtmp.354, %sfp
	ldrb	r6, [r3]	@ _12, MEM[base: _36, offset: 0B]
@ RangeDisplay.c:43: 	for ( int i = 0 ; spells[i] ; i++ )
	cmp	r6, #0	@ _12,
	bne	.L265		@,
@ RangeDisplay.c:56: }
	movs	r0, r5	@, <retval>
	movs	r1, r4	@, <retval>
	add	sp, sp, #12	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7}
	pop	{r2}
	bx	r2
.L265:
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
	bne	.L263		@,
@ RangeDisplay.c:48: 			if ( CanCastSpell(unit,spell) ) { current = IncorporateNewRange(current,gGet_Item_Range(unit,spell)); }
	bl	CanCastSpell		@
.L275:
@ RangeDisplay.c:52: 			if ( usability(unit,spell) ) { current = IncorporateNewRange(current,gGet_Item_Range(unit,spell)); }
	cmp	r0, #0	@ tmp144,
	beq	.L264		@,
@ RangeDisplay.c:52: 			if ( usability(unit,spell) ) { current = IncorporateNewRange(current,gGet_Item_Range(unit,spell)); }
	ldr	r3, .L276+4	@ tmp134,
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
.L264:
	ldr	r3, [sp]	@ ivtmp.354, %sfp
	adds	r3, r3, #1	@ ivtmp.354,
	str	r3, [sp]	@ ivtmp.354, %sfp
	b	.L262		@
.L263:
@ RangeDisplay.c:52: 			if ( usability(unit,spell) ) { current = IncorporateNewRange(current,gGet_Item_Range(unit,spell)); }
	ldr	r3, [sp, #4]	@ usability, %sfp
	bl	.L14		@
	b	.L275		@
.L277:
	.align	2
.L276:
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
	bcc	.L279		@,
@ RangeDisplay.c:10: 	long long current = 0;
	movs	r5, #0	@ <retval>,
	movs	r3, r0	@ _19, unit
	movs	r7, r0	@ ivtmp.363, unit
	movs	r4, r5	@ <retval>, <retval>
	adds	r3, r3, #40	@ _19,
	str	r3, [sp, #12]	@ _19, %sfp
	adds	r7, r7, #30	@ ivtmp.363,
.L280:
@ RangeDisplay.c:14: 		for ( int i = 0 ; i < 5 && unit->items[i] ; i++ )
	ldrh	r1, [r7]	@ _10, MEM[base: _38, offset: 0B]
@ RangeDisplay.c:14: 		for ( int i = 0 ; i < 5 && unit->items[i] ; i++ )
	cmp	r1, #0	@ _10,
	beq	.L282		@,
@ RangeDisplay.c:16: 			if ( usability(unit,unit->items[i]) )
	movs	r0, r6	@, unit
	ldr	r3, [sp, #8]	@ usability, %sfp
	bl	.L14		@
@ RangeDisplay.c:16: 			if ( usability(unit,unit->items[i]) )
	cmp	r0, #0	@ tmp150,
	beq	.L281		@,
@ RangeDisplay.c:18: 				current = IncorporateNewRange(current,gGet_Item_Range(unit,unit->items[i]));
	ldr	r3, .L290	@ tmp137,
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
.L281:
@ RangeDisplay.c:14: 		for ( int i = 0 ; i < 5 && unit->items[i] ; i++ )
	ldr	r3, [sp, #12]	@ _19, %sfp
	adds	r7, r7, #2	@ ivtmp.363,
	cmp	r7, r3	@ ivtmp.363, _19
	bne	.L280		@,
.L282:
@ RangeDisplay.c:21: 		return ( slot == -1 ? IncorporateNewRange(current,GetUnitRangeMaskForSpells(unit,usability)) : current );
	ldr	r3, [sp, #4]	@ slot, %sfp
	adds	r3, r3, #1	@ tmp176, slot,
	bne	.L278		@,
@ RangeDisplay.c:21: 		return ( slot == -1 ? IncorporateNewRange(current,GetUnitRangeMaskForSpells(unit,usability)) : current );
	movs	r0, r6	@, unit
	ldr	r1, [sp, #8]	@, %sfp
	bl	GetUnitRangeMaskForSpells		@
	movs	r2, r0	@ _11, tmp167
	movs	r3, r1	@ _11, tmp168
	movs	r0, r5	@, <retval>
	movs	r1, r4	@, <retval>
	bl	IncorporateNewRange		@
.L289:
@ RangeDisplay.c:33: 			return GetUnitRangeMaskForSpells(unit,usability);
	movs	r5, r0	@ <retval>, tmp173
	movs	r4, r1	@ <retval>, tmp174
.L278:
@ RangeDisplay.c:36: }
	movs	r0, r5	@, <retval>
	movs	r1, r4	@, <retval>
	add	sp, sp, #20	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7}
	pop	{r2}
	bx	r2
.L279:
@ RangeDisplay.c:26: 		if ( slot != 9 )
	ldr	r3, [sp, #4]	@ slot, %sfp
	cmp	r3, #9	@ slot,
	beq	.L285		@,
@ RangeDisplay.c:28: 			return gGet_Item_Range(unit,unit->items[slot]);
	movs	r1, r3	@ slot, slot
	adds	r1, r1, #12	@ slot,
@ RangeDisplay.c:28: 			return gGet_Item_Range(unit,unit->items[slot]);
	ldr	r3, .L290	@ tmp144,
@ RangeDisplay.c:28: 			return gGet_Item_Range(unit,unit->items[slot]);
	lsls	r1, r1, #1	@ tmp140, tmp139,
	adds	r1, r0, r1	@ tmp141, unit, tmp140
@ RangeDisplay.c:28: 			return gGet_Item_Range(unit,unit->items[slot]);
	ldr	r3, [r3]	@ gGet_Item_Range, gGet_Item_Range
	ldrh	r1, [r1, #6]	@ tmp143, *unit_26(D)
	bl	.L14		@
	b	.L289		@
.L285:
@ RangeDisplay.c:33: 			return GetUnitRangeMaskForSpells(unit,usability);
	ldr	r1, [sp, #8]	@, %sfp
	bl	GetUnitRangeMaskForSpells		@
	b	.L289		@
.L291:
	.align	2
.L290:
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
	ldr	r4, .L293	@ tmp123,
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
.L294:
	.align	2
.L293:
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
	ldr	r3, .L299	@ tmp121,
	strb	r5, [r3]	@ tmp122, UsingSpellMenu
@ UnitMenu.c:74: 	BmMapFill(gMapMovement,-1);
	ldr	r3, .L299+4	@ tmp124,
	ldr	r4, .L299+8	@ tmp125,
	ldr	r0, [r3]	@, gMapMovement
	movs	r1, #255	@,
	bl	.L16		@
@ UnitMenu.c:75: 	BmMapFill(gMapRange,0);
	ldr	r3, .L299+12	@ tmp126,
	movs	r1, #0	@,
	ldr	r0, [r3]	@, gMapRange
	bl	.L16		@
@ UnitMenu.c:76: 	if ( CanUseAttackSpellsNow(gActiveUnit,BLACK_MAGIC) ) // If we can use an attack spell now, display the red range.
	ldr	r4, .L299+16	@ tmp128,
	movs	r1, r5	@, tmp122
	ldr	r0, [r4]	@, gActiveUnit
	bl	CanUseAttackSpellsNow		@
	ldr	r5, .L299+20	@ tmp136,
@ UnitMenu.c:76: 	if ( CanUseAttackSpellsNow(gActiveUnit,BLACK_MAGIC) ) // If we can use an attack spell now, display the red range.
	cmp	r0, #0	@ tmp137,
	beq	.L296		@,
@ UnitMenu.c:78: 		All_Spells_One_Square(gActiveUnit,&RangeUsabilityCheckNotStaff);
	ldr	r0, [r4]	@, gActiveUnit
	ldr	r1, .L299+24	@,
	bl	All_Spells_One_Square		@
@ UnitMenu.c:79: 		DisplayMoveRangeGraphics(3);
	movs	r0, #3	@,
.L298:
@ UnitMenu.c:90: }
	@ sp needed	@
@ UnitMenu.c:84: 		DisplayMoveRangeGraphics(5);
	bl	.L301		@
@ UnitMenu.c:90: }
	movs	r0, #0	@,
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L296:
@ UnitMenu.c:83: 		All_Spells_One_Square(gActiveUnit,&RangeUsabilityCheckStaff);
	ldr	r0, [r4]	@, gActiveUnit
	ldr	r1, .L299+28	@,
	bl	All_Spells_One_Square		@
@ UnitMenu.c:84: 		DisplayMoveRangeGraphics(5);
	movs	r0, #5	@,
	b	.L298		@
.L300:
	.align	2
.L299:
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
	ldr	r3, .L306	@ tmp121,
	strb	r5, [r3]	@ tmp122, UsingSpellMenu
@ UnitMenu.c:95: 	BmMapFill(gMapMovement,-1);
	ldr	r3, .L306+4	@ tmp124,
	ldr	r4, .L306+8	@ tmp125,
	ldr	r0, [r3]	@, gMapMovement
	movs	r1, #255	@,
	bl	.L16		@
@ UnitMenu.c:96: 	BmMapFill(gMapRange,0);
	ldr	r3, .L306+12	@ tmp126,
	movs	r1, #0	@,
	ldr	r0, [r3]	@, gMapRange
	bl	.L16		@
@ UnitMenu.c:97: 	if ( CanUseAttackSpellsNow(gActiveUnit,WHITE_MAGIC) ) // If we can use an attack spell now, display the red range.
	ldr	r4, .L306+16	@ tmp128,
	movs	r1, r5	@, tmp122
	ldr	r0, [r4]	@, gActiveUnit
	bl	CanUseAttackSpellsNow		@
	ldr	r5, .L306+20	@ tmp136,
@ UnitMenu.c:97: 	if ( CanUseAttackSpellsNow(gActiveUnit,WHITE_MAGIC) ) // If we can use an attack spell now, display the red range.
	cmp	r0, #0	@ tmp137,
	beq	.L303		@,
@ UnitMenu.c:99: 		All_Spells_One_Square(gActiveUnit,&RangeUsabilityCheckNotStaff);
	ldr	r0, [r4]	@, gActiveUnit
	ldr	r1, .L306+24	@,
	bl	All_Spells_One_Square		@
@ UnitMenu.c:100: 		DisplayMoveRangeGraphics(3);
	movs	r0, #3	@,
.L305:
@ UnitMenu.c:108: }
	@ sp needed	@
@ UnitMenu.c:105: 		DisplayMoveRangeGraphics(5);
	bl	.L301		@
@ UnitMenu.c:108: }
	movs	r0, #0	@,
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L303:
@ UnitMenu.c:104: 		All_Spells_One_Square(gActiveUnit,&RangeUsabilityCheckStaff);
	ldr	r0, [r4]	@, gActiveUnit
	ldr	r1, .L306+28	@,
	bl	All_Spells_One_Square		@
@ UnitMenu.c:105: 		DisplayMoveRangeGraphics(5);
	movs	r0, #5	@,
	b	.L305		@
.L307:
	.align	2
.L306:
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
	ldr	r7, .L316	@ tmp133,
	ldr	r4, .L316+4	@ tmp135,
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
	bne	.L309		@,
.L311:
@ SpellMenu.c:6: 	if ( !spell ) { return 3; }
	movs	r0, #3	@ <retval>,
.L308:
@ SpellMenu.c:11: }
	@ sp needed	@
	pop	{r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L309:
@ SpellMenu.c:8: 	if ( !CanCastSpellNow(gActiveUnit,spell) ) { return 3; }
	movs	r1, r5	@, spell
	ldr	r0, [r4]	@, gActiveUnit
	bl	CanCastSpellNow		@
@ SpellMenu.c:8: 	if ( !CanCastSpellNow(gActiveUnit,spell) ) { return 3; }
	cmp	r0, #0	@ tmp147,
	beq	.L311		@,
@ SpellMenu.c:10: 	return ( HasSufficientHP(gActiveUnit,spell) ? 1 : 2 );
	movs	r1, r5	@, spell
	ldr	r0, [r4]	@, gActiveUnit
	bl	HasSufficientHP		@
@ SpellMenu.c:10: 	return ( HasSufficientHP(gActiveUnit,spell) ? 1 : 2 );
	rsbs	r3, r0, #0	@ tmp143, tmp148
	adcs	r0, r0, r3	@ tmp142, tmp148, tmp143
	adds	r0, r0, #1	@ <retval>,
	b	.L308		@
.L317:
	.align	2
.L316:
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
	ldr	r6, .L319	@ tmp145,
	ldr	r7, .L319+4	@ tmp143,
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
	ldr	r1, .L319+8	@ tmp160,
	lsls	r3, r3, #1	@ tmp158, tmp157,
	adds	r3, r3, r1	@ tmp159, tmp158, tmp160
	ldr	r4, .L319+12	@ tmp164,
	movs	r1, r5	@ tmp161, _13
@ SpellMenu.c:19: 	DrawItemMenuCommand(&menuCommand->text,spell,canUse,&gBg0MapBuffer[menuCommand->yDrawTile * 32 + menuCommand->xDrawTile]);
	adds	r0, r0, #52	@ menuCommand,
@ SpellMenu.c:19: 	DrawItemMenuCommand(&menuCommand->text,spell,canUse,&gBg0MapBuffer[menuCommand->yDrawTile * 32 + menuCommand->xDrawTile]);
	bl	.L16		@
@ SpellMenu.c:20: 	EnableBgSyncByMask(1);
	movs	r0, #1	@,
	ldr	r3, .L319+16	@ tmp165,
	bl	.L14		@
@ SpellMenu.c:22: }
	movs	r0, #0	@,
	pop	{r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L320:
	.align	2
.L319:
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
	ldr	r0, .L322	@,
	ldr	r3, .L322+4	@ tmp120,
	bl	.L14		@
@ SpellMenu.c:27: 	EnableBgSyncByMask(4);
	movs	r0, #4	@,
	ldr	r3, .L322+8	@ tmp121,
	bl	.L14		@
@ SpellMenu.c:28: 	Text_ResetTileAllocation();
	ldr	r3, .L322+12	@ tmp122,
	bl	.L14		@
@ SpellMenu.c:30: 	StartMenu_AndDoSomethingCommands(&gMenu_UnitMenu,gGameState._unk1C.x - gGameState.cameraRealPos.x,1,16);
	ldr	r3, .L322+16	@ tmp123,
	ldrh	r1, [r3, #28]	@ tmp124,
@ SpellMenu.c:30: 	StartMenu_AndDoSomethingCommands(&gMenu_UnitMenu,gGameState._unk1C.x - gGameState.cameraRealPos.x,1,16);
	ldrh	r3, [r3, #12]	@ tmp126,
@ SpellMenu.c:30: 	StartMenu_AndDoSomethingCommands(&gMenu_UnitMenu,gGameState._unk1C.x - gGameState.cameraRealPos.x,1,16);
	movs	r2, #1	@,
	subs	r1, r1, r3	@ tmp127, tmp124, tmp126
	ldr	r4, .L322+20	@ tmp129,
	movs	r3, #16	@,
	ldr	r0, .L322+24	@,
	bl	.L16		@
@ SpellMenu.c:31: 	HideMoveRangeGraphics();
	ldr	r3, .L322+28	@ tmp130,
	bl	.L14		@
@ SpellMenu.c:32: 	SelectedSpell = 0;
	movs	r3, #0	@ tmp132,
	ldr	r2, .L322+32	@ tmp131,
	strb	r3, [r2]	@ tmp132, SelectedSpell
@ SpellMenu.c:33: 	UsingSpellMenu = 0;
	ldr	r2, .L322+36	@ tmp134,
@ SpellMenu.c:35: }
	movs	r0, #59	@,
@ SpellMenu.c:33: 	UsingSpellMenu = 0;
	strb	r3, [r2]	@ tmp132, UsingSpellMenu
@ SpellMenu.c:35: }
	pop	{r4}
	pop	{r1}
	bx	r1
.L323:
	.align	2
.L322:
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
	push	{r3, r4, r5, r6, r7, lr}	@
@ SpellMenu.c:39: 	if ( commandProc->availability == 2)
	adds	r1, r1, #61	@ tmp140,
@ SpellMenu.c:39: 	if ( commandProc->availability == 2)
	ldrb	r3, [r1]	@ tmp141,
	cmp	r3, #2	@ tmp141,
	bne	.L325		@,
@ SpellMenu.c:42: 		MenuCallHelpBox(proc,gGaidenMagicSpellMenuErrorText);
	ldr	r3, .L333	@ tmp142,
	ldrh	r1, [r3]	@ gGaidenMagicSpellMenuErrorText, gGaidenMagicSpellMenuErrorText
	ldr	r3, .L333+4	@ tmp144,
	bl	.L14		@
@ SpellMenu.c:43: 		return 0x08;
	movs	r0, #8	@ <retval>,
.L324:
@ SpellMenu.c:86: }
	@ sp needed	@
	pop	{r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L325:
@ SpellMenu.c:47: 		Unit* unit = gActiveUnit;
	ldr	r4, .L333+8	@ tmp145,
	ldr	r3, [r4]	@ unit, gActiveUnit
@ SpellMenu.c:48: 		if ( unit->ranks[0] != SelectedSpell) 
	movs	r6, r3	@ tmp148, unit
@ SpellMenu.c:48: 		if ( unit->ranks[0] != SelectedSpell) 
	ldr	r5, .L333+12	@ tmp149,
@ SpellMenu.c:48: 		if ( unit->ranks[0] != SelectedSpell) 
	adds	r6, r6, #40	@ tmp148,
	ldrb	r0, [r6]	@ _3,
@ SpellMenu.c:48: 		if ( unit->ranks[0] != SelectedSpell) 
	ldrb	r1, [r5]	@ SelectedSpell.95_4, SelectedSpell
@ SpellMenu.c:48: 		if ( unit->ranks[0] != SelectedSpell) 
	cmp	r0, r1	@ _3, SelectedSpell.95_4
	beq	.L327		@,
	movs	r2, r3	@ ivtmp.393, unit
	adds	r3, r3, #45	@ _47,
	adds	r2, r2, #41	@ ivtmp.393,
.L329:
@ SpellMenu.c:53: 			if (unit->ranks[i] == SelectedSpell) 
	ldrb	r7, [r2]	@ MEM[base: _40, offset: 0B], MEM[base: _40, offset: 0B]
	cmp	r7, r1	@ MEM[base: _40, offset: 0B], SelectedSpell.95_4
	bne	.L328		@,
@ SpellMenu.c:55: 			unit->ranks[i] = PreviousSelection;
	strb	r0, [r2]	@ _3, MEM[base: _40, offset: 0B]
@ SpellMenu.c:56: 			unit->ranks[0] = SelectedSpell;
	strb	r1, [r6]	@ SelectedSpell.95_4, unit_25->ranks
.L328:
@ SpellMenu.c:51: 		for ( int i = 1 ; i < 5 ; i++ ) 
	adds	r2, r2, #1	@ ivtmp.393,
	cmp	r2, r3	@ ivtmp.393, _47
	bne	.L329		@,
.L327:
@ SpellMenu.c:71: 		gActionData.itemSlotIndex = 0;
	movs	r2, #0	@ tmp157,
	ldr	r3, .L333+16	@ tmp156,
	strb	r2, [r3, #18]	@ tmp157, gActionData.itemSlotIndex
@ SpellMenu.c:72: 		DidSelectSpell = 1;
	ldr	r3, .L333+20	@ tmp159,
	adds	r2, r2, #1	@ tmp160,
	strb	r2, [r3]	@ tmp160, DidSelectSpell
@ SpellMenu.c:73: 		ClearBG0BG1();
	ldr	r3, .L333+24	@ tmp162,
	bl	.L14		@
@ SpellMenu.c:74: 		int type = GetItemType(SelectedSpell);
	ldr	r3, .L333+28	@ tmp165,
	ldrb	r0, [r5]	@ SelectedSpell, SelectedSpell
	bl	.L14		@
	movs	r1, #255	@ tmp185,
	ldrb	r3, [r5]	@ SelectedSpell, SelectedSpell
	lsls	r1, r1, #8	@ tmp185, tmp185,
@ SpellMenu.c:77: 			MakeTargetListForWeapon(gActiveUnit,SelectedSpell|0xFF00);
	orrs	r1, r3	@ tmp168, SelectedSpell
@ SpellMenu.c:75: 		if ( type != ITYPE_STAFF )
	cmp	r0, #4	@ tmp188,
	beq	.L330		@,
@ SpellMenu.c:77: 			MakeTargetListForWeapon(gActiveUnit,SelectedSpell|0xFF00);
	ldr	r0, [r4]	@, gActiveUnit
	ldr	r3, .L333+32	@ tmp171,
	bl	.L14		@
@ SpellMenu.c:78: 			StartTargetSelection(&SpellTargetSelection);
	ldr	r0, .L333+36	@,
	ldr	r3, .L333+40	@ tmp173,
	bl	.L14		@
.L332:
@ SpellMenu.c:84: 		return 0x27;
	movs	r0, #39	@ <retval>,
	b	.L324		@
.L330:
@ SpellMenu.c:82: 			ItemEffect_Call(gActiveUnit,SelectedSpell|0xFF00);
	ldr	r0, [r4]	@, gActiveUnit
	ldr	r3, .L333+44	@ tmp179,
	bl	.L14		@
	b	.L332		@
.L334:
	.align	2
.L333:
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
@ SpellMenu.c:90: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,proc->commandIndex,UsingSpellMenu)];
	ldr	r3, .L350	@ tmp389,
	ldr	r6, .L350+4	@ tmp206,
@ SpellMenu.c:89: {
	sub	sp, sp, #36	@,,
@ SpellMenu.c:90: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,proc->commandIndex,UsingSpellMenu)];
	ldrb	r1, [r6]	@ UsingSpellMenu, UsingSpellMenu
@ SpellMenu.c:89: {
	movs	r4, r0	@ proc, tmp367
@ SpellMenu.c:90: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,proc->commandIndex,UsingSpellMenu)];
	ldr	r0, [r3]	@, gActiveUnit
	bl	SpellsGetter		@
@ SpellMenu.c:90: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,proc->commandIndex,UsingSpellMenu)];
	ldr	r3, .L350	@ tmp390,
@ SpellMenu.c:90: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,proc->commandIndex,UsingSpellMenu)];
	adds	r4, r4, #97	@ tmp213,
@ SpellMenu.c:90: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,proc->commandIndex,UsingSpellMenu)];
	ldrb	r2, [r6]	@ UsingSpellMenu, UsingSpellMenu
	ldrb	r1, [r4]	@ tmp214,
@ SpellMenu.c:90: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,proc->commandIndex,UsingSpellMenu)];
	movs	r5, r0	@ _4, tmp368
@ SpellMenu.c:90: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,proc->commandIndex,UsingSpellMenu)];
	ldr	r0, [r3]	@, gActiveUnit
	bl	GetNthUsableSpell		@
@ SpellMenu.c:91: 	SelectedSpell = spell;
	ldr	r3, .L350+8	@ tmp216,
@ SpellMenu.c:90: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,proc->commandIndex,UsingSpellMenu)];
	ldrb	r7, [r5, r0]	@ spell, *_12
@ SpellMenu.c:94: 	MenuItemPanelProc* menuItemPanel = (MenuItemPanelProc*)ProcFind(&gProc_MenuItemPanel);
	ldr	r0, .L350+12	@,
@ SpellMenu.c:91: 	SelectedSpell = spell;
	strb	r7, [r3]	@ spell, SelectedSpell
@ SpellMenu.c:94: 	MenuItemPanelProc* menuItemPanel = (MenuItemPanelProc*)ProcFind(&gProc_MenuItemPanel);
	ldr	r3, .L350+16	@ tmp219,
	bl	.L14		@
@ SpellMenu.c:95: 	int x = menuItemPanel->x;
	movs	r3, r0	@ tmp222, tmp370
@ SpellMenu.c:94: 	MenuItemPanelProc* menuItemPanel = (MenuItemPanelProc*)ProcFind(&gProc_MenuItemPanel);
	str	r0, [sp, #8]	@ tmp370, %sfp
@ SpellMenu.c:95: 	int x = menuItemPanel->x;
	adds	r3, r3, #48	@ tmp222,
	ldrb	r3, [r3]	@ _14,
	str	r3, [sp, #24]	@ _14, %sfp
@ SpellMenu.c:96: 	int y = menuItemPanel->y;
	movs	r3, r0	@ tmp225, tmp370
@ SpellMenu.c:100: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Clear(&menuItemPanel->textHandles[i]); }
	movs	r4, r0	@ _140, tmp370
@ SpellMenu.c:96: 	int y = menuItemPanel->y;
	adds	r3, r3, #49	@ tmp225,
@ SpellMenu.c:96: 	int y = menuItemPanel->y;
	ldrb	r3, [r3]	@ y,
@ SpellMenu.c:100: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Clear(&menuItemPanel->textHandles[i]); }
	adds	r4, r4, #52	@ _140,
@ SpellMenu.c:100: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Clear(&menuItemPanel->textHandles[i]); }
	ldr	r5, .L350+20	@ tmp226,
	movs	r0, r4	@, _140
@ SpellMenu.c:96: 	int y = menuItemPanel->y;
	str	r3, [sp, #28]	@ y, %sfp
@ SpellMenu.c:100: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Clear(&menuItemPanel->textHandles[i]); }
	str	r4, [sp, #16]	@ _140, %sfp
@ SpellMenu.c:100: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Clear(&menuItemPanel->textHandles[i]); }
	bl	.L301		@
@ SpellMenu.c:100: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Clear(&menuItemPanel->textHandles[i]); }
	ldr	r3, [sp, #8]	@ _145, %sfp
	adds	r3, r3, #60	@ _145,
@ SpellMenu.c:100: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Clear(&menuItemPanel->textHandles[i]); }
	movs	r0, r3	@, _145
@ SpellMenu.c:100: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Clear(&menuItemPanel->textHandles[i]); }
	str	r3, [sp, #20]	@ _145, %sfp
@ SpellMenu.c:100: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Clear(&menuItemPanel->textHandles[i]); }
	bl	.L301		@
@ SpellMenu.c:100: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Clear(&menuItemPanel->textHandles[i]); }
	ldr	r6, [sp, #8]	@ _150, %sfp
	adds	r6, r6, #68	@ _150,
@ SpellMenu.c:100: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Clear(&menuItemPanel->textHandles[i]); }
	movs	r0, r6	@, _150
	bl	.L301		@
@ SpellMenu.c:101: 	MakeUIWindowTileMap_BG0BG1(x,y,14,8,0);
	movs	r5, #0	@ tmp229,
	movs	r3, #8	@,
	movs	r2, #14	@,
	ldr	r1, [sp, #28]	@, %sfp
	ldr	r0, [sp, #24]	@, %sfp
	str	r5, [sp]	@ tmp229,
	ldr	r4, .L350+24	@ tmp398,
	bl	.L16		@
@ SpellMenu.c:103: 	int spellType = GetItemType(spell);
	movs	r0, r7	@, spell
	ldr	r3, .L350+28	@ tmp231,
	bl	.L14		@
	str	r0, [sp, #12]	@ tmp371, %sfp
@ SpellMenu.c:104: 	if ( spellType != ITYPE_STAFF )
	cmp	r0, #4	@ spellType,
	bne	.LCB2206	@
	b	.L336	@long jump	@
.LCB2206:
@ SpellMenu.c:106: 		BattleGenerateUiStats(gActiveUnit,9); // 9 is using a Gaiden spell.
	ldr	r3, .L350	@ tmp401,
	movs	r1, #9	@,
	ldr	r0, [r3]	@, gActiveUnit
	ldr	r3, .L350+32	@ tmp233,
	bl	.L14		@
@ SpellMenu.c:107: 		Text_InsertString(&menuItemPanel->textHandles[0],0x02,0,GetStringFromIndex(0x4F1)); // Affin.
	ldr	r3, .L350+36	@ tmp402,
	ldr	r0, .L350+40	@,
	bl	.L14		@
@ SpellMenu.c:107: 		Text_InsertString(&menuItemPanel->textHandles[0],0x02,0,GetStringFromIndex(0x4F1)); // Affin.
	movs	r2, r5	@, tmp229
@ SpellMenu.c:107: 		Text_InsertString(&menuItemPanel->textHandles[0],0x02,0,GetStringFromIndex(0x4F1)); // Affin.
	movs	r3, r0	@ _19, tmp372
@ SpellMenu.c:107: 		Text_InsertString(&menuItemPanel->textHandles[0],0x02,0,GetStringFromIndex(0x4F1)); // Affin.
	movs	r1, #2	@,
	ldr	r0, [sp, #16]	@, %sfp
	ldr	r4, .L350+44	@ tmp404,
	bl	.L16		@
@ SpellMenu.c:108: 		Text_InsertString(&menuItemPanel->textHandles[0],0x32,0,GetStringFromIndex(gGaidenMagicHPCostText)); // HP Cost.
	ldr	r3, .L350+48	@ tmp237,
	ldrh	r0, [r3]	@ gGaidenMagicHPCostText, gGaidenMagicHPCostText
	ldr	r3, .L350+36	@ tmp406,
	bl	.L14		@
@ SpellMenu.c:108: 		Text_InsertString(&menuItemPanel->textHandles[0],0x32,0,GetStringFromIndex(gGaidenMagicHPCostText)); // HP Cost.
	movs	r2, r5	@, tmp229
@ SpellMenu.c:108: 		Text_InsertString(&menuItemPanel->textHandles[0],0x32,0,GetStringFromIndex(gGaidenMagicHPCostText)); // HP Cost.
	movs	r3, r0	@ _23, tmp373
@ SpellMenu.c:108: 		Text_InsertString(&menuItemPanel->textHandles[0],0x32,0,GetStringFromIndex(gGaidenMagicHPCostText)); // HP Cost.
	movs	r1, #50	@,
	ldr	r0, [sp, #16]	@, %sfp
	ldr	r4, .L350+44	@ tmp408,
	bl	.L16		@
@ SpellMenu.c:109: 		Text_InsertString(&menuItemPanel->textHandles[1],0x02,0,GetStringFromIndex(0x4F3)); // Atk.
	ldr	r3, .L350+36	@ tmp410,
	ldr	r0, .L350+52	@,
	bl	.L14		@
@ SpellMenu.c:109: 		Text_InsertString(&menuItemPanel->textHandles[1],0x02,0,GetStringFromIndex(0x4F3)); // Atk.
	movs	r2, r5	@, tmp229
@ SpellMenu.c:109: 		Text_InsertString(&menuItemPanel->textHandles[1],0x02,0,GetStringFromIndex(0x4F3)); // Atk.
	movs	r3, r0	@ _25, tmp374
@ SpellMenu.c:109: 		Text_InsertString(&menuItemPanel->textHandles[1],0x02,0,GetStringFromIndex(0x4F3)); // Atk.
	movs	r1, #2	@,
	ldr	r0, [sp, #20]	@, %sfp
	ldr	r4, .L350+44	@ tmp412,
	bl	.L16		@
@ SpellMenu.c:110: 		Text_InsertString(&menuItemPanel->textHandles[2],0x02,0,GetStringFromIndex(0x4F4)); // Hit.
	ldr	r3, .L350+36	@ tmp414,
	ldr	r0, .L350+56	@,
	bl	.L14		@
@ SpellMenu.c:110: 		Text_InsertString(&menuItemPanel->textHandles[2],0x02,0,GetStringFromIndex(0x4F4)); // Hit.
	movs	r2, r5	@, tmp229
@ SpellMenu.c:110: 		Text_InsertString(&menuItemPanel->textHandles[2],0x02,0,GetStringFromIndex(0x4F4)); // Hit.
	movs	r3, r0	@ _27, tmp375
@ SpellMenu.c:110: 		Text_InsertString(&menuItemPanel->textHandles[2],0x02,0,GetStringFromIndex(0x4F4)); // Hit.
	movs	r1, #2	@,
	movs	r0, r6	@, _150
	ldr	r4, .L350+44	@ tmp416,
	bl	.L16		@
@ SpellMenu.c:111: 		Text_InsertString(&menuItemPanel->textHandles[1],0x32,0,GetStringFromIndex(0x501)); // Crit.
	ldr	r3, .L350+36	@ tmp418,
	ldr	r0, .L350+60	@,
	bl	.L14		@
@ SpellMenu.c:111: 		Text_InsertString(&menuItemPanel->textHandles[1],0x32,0,GetStringFromIndex(0x501)); // Crit.
	movs	r2, r5	@, tmp229
@ SpellMenu.c:111: 		Text_InsertString(&menuItemPanel->textHandles[1],0x32,0,GetStringFromIndex(0x501)); // Crit.
	movs	r3, r0	@ _28, tmp376
@ SpellMenu.c:111: 		Text_InsertString(&menuItemPanel->textHandles[1],0x32,0,GetStringFromIndex(0x501)); // Crit.
	movs	r1, #50	@,
	ldr	r0, [sp, #20]	@, %sfp
	ldr	r4, .L350+44	@ tmp420,
	bl	.L16		@
@ SpellMenu.c:112: 		Text_InsertString(&menuItemPanel->textHandles[2],0x32,0,GetStringFromIndex(0x4F5)); // Avoid.
	ldr	r3, .L350+36	@ tmp422,
	ldr	r0, .L350+64	@,
	bl	.L14		@
@ SpellMenu.c:112: 		Text_InsertString(&menuItemPanel->textHandles[2],0x32,0,GetStringFromIndex(0x4F5)); // Avoid.
	movs	r2, r5	@, tmp229
@ SpellMenu.c:112: 		Text_InsertString(&menuItemPanel->textHandles[2],0x32,0,GetStringFromIndex(0x4F5)); // Avoid.
	movs	r3, r0	@ _29, tmp377
@ SpellMenu.c:112: 		Text_InsertString(&menuItemPanel->textHandles[2],0x32,0,GetStringFromIndex(0x4F5)); // Avoid.
	movs	r1, #50	@,
	movs	r0, r6	@, _150
	ldr	r4, .L350+44	@ tmp424,
	bl	.L16		@
@ SpellMenu.c:115: 		if ( !HasSufficientHP(gActiveUnit,spell) ) { CostColor = 1; }
	ldr	r3, .L350	@ tmp426,
	movs	r1, r7	@, spell
	ldr	r0, [r3]	@, gActiveUnit
	bl	HasSufficientHP		@
@ SpellMenu.c:115: 		if ( !HasSufficientHP(gActiveUnit,spell) ) { CostColor = 1; }
	subs	r3, r0, #1	@ tmp355, tmp378
	sbcs	r0, r0, r3	@ tmp378, tmp378, tmp355
	movs	r5, r0	@ tmp354, tmp378
@ SpellMenu.c:116: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[0],0x54,CostColor,GetSpellCost(spell));
	movs	r0, r7	@, spell
	bl	GetSpellCost		@
@ SpellMenu.c:115: 		if ( !HasSufficientHP(gActiveUnit,spell) ) { CostColor = 1; }
	adds	r5, r5, #1	@ CostColor,
@ SpellMenu.c:116: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[0],0x54,CostColor,GetSpellCost(spell));
	lsls	r3, r0, #24	@ tmp254, tmp379,
	movs	r2, r5	@, CostColor
	movs	r1, #84	@,
	ldr	r5, .L350+68	@ tmp256,
	ldr	r0, [sp, #16]	@, %sfp
	lsrs	r3, r3, #24	@ tmp254, tmp254,
	bl	.L301		@
@ SpellMenu.c:117: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[1],0x24,2,gBattleActor.battleAttack);
	ldr	r4, .L350+72	@ tmp257,
	movs	r3, r4	@ tmp260, tmp257
	adds	r3, r3, #90	@ tmp260,
@ SpellMenu.c:117: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[1],0x24,2,gBattleActor.battleAttack);
	movs	r2, #2	@,
	movs	r1, #36	@,
	ldrb	r3, [r3]	@ tmp264,
	ldr	r0, [sp, #20]	@, %sfp
	bl	.L301		@
@ SpellMenu.c:118: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[2],0x24,2,gBattleActor.battleHitRate);
	movs	r3, r4	@ tmp270, tmp257
	adds	r3, r3, #96	@ tmp270,
@ SpellMenu.c:118: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[2],0x24,2,gBattleActor.battleHitRate);
	movs	r2, #2	@,
	movs	r1, #36	@,
	movs	r0, r6	@, _150
	ldrb	r3, [r3]	@ tmp274,
	bl	.L301		@
@ SpellMenu.c:119: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[1],0x54,2,gBattleActor.battleCritRate);
	movs	r3, r4	@ tmp280, tmp257
	adds	r3, r3, #102	@ tmp280,
@ SpellMenu.c:119: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[1],0x54,2,gBattleActor.battleCritRate);
	movs	r2, #2	@,
	movs	r1, #84	@,
	ldrb	r3, [r3]	@ tmp284,
	ldr	r0, [sp, #20]	@, %sfp
@ SpellMenu.c:120: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[2],0x54,2,gBattleActor.battleAvoidRate);
	adds	r4, r4, #98	@ tmp290,
@ SpellMenu.c:119: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[1],0x54,2,gBattleActor.battleCritRate);
	bl	.L301		@
@ SpellMenu.c:120: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[2],0x54,2,gBattleActor.battleAvoidRate);
	movs	r2, #2	@,
	movs	r1, #84	@,
	movs	r0, r6	@, _150
	ldrb	r3, [r4]	@ tmp294,
	bl	.L301		@
.L340:
	ldr	r5, [sp, #28]	@ y, %sfp
	ldr	r3, [sp, #24]	@ _14, %sfp
	adds	r5, r5, #1	@ y,
	adds	r4, r3, #1	@ tmp298, _14,
	lsls	r5, r5, #5	@ _158, tmp297,
	ldr	r3, .L350+76	@ tmp434,
	adds	r4, r4, r5	@ tmp299, tmp298, _158
	lsls	r4, r4, #1	@ tmp300, tmp299,
	adds	r4, r4, r3	@ ivtmp.405, tmp300, tmp434
	ldr	r3, [sp, #8]	@ _173, %sfp
	ldr	r6, [sp, #8]	@ ivtmp.403, %sfp
	adds	r3, r3, #76	@ _173,
	str	r3, [sp, #16]	@ _173, %sfp
	adds	r6, r6, #52	@ ivtmp.403,
.L338:
@ SpellMenu.c:140: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Display(&menuItemPanel->textHandles[i],&gBG0MapBuffer[y+1+2*i][x+1]); }
	movs	r1, r4	@, ivtmp.405
	movs	r0, r6	@, ivtmp.403
	ldr	r3, .L350+80	@ tmp330,
	bl	.L14		@
@ SpellMenu.c:140: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Display(&menuItemPanel->textHandles[i],&gBG0MapBuffer[y+1+2*i][x+1]); }
	ldr	r3, [sp, #16]	@ _173, %sfp
	adds	r6, r6, #8	@ ivtmp.403,
	adds	r4, r4, #128	@ ivtmp.405,
	cmp	r6, r3	@ ivtmp.403, _173
	bne	.L338		@,
@ SpellMenu.c:142: 	if ( spellType != ITYPE_STAFF ) { DrawIcon(&gBG0MapBuffer[y+1][x+5],spellType+0x70,menuItemPanel->oam2base<<0xC); } // This HAS to happen after the Text_Display calls.
	ldr	r3, [sp, #12]	@ spellType, %sfp
	cmp	r3, #4	@ spellType,
	beq	.L341		@,
@ SpellMenu.c:142: 	if ( spellType != ITYPE_STAFF ) { DrawIcon(&gBG0MapBuffer[y+1][x+5],spellType+0x70,menuItemPanel->oam2base<<0xC); } // This HAS to happen after the Text_Display calls.
	ldr	r0, [sp, #8]	@ menuItemPanel, %sfp
	adds	r0, r0, #50	@ menuItemPanel,
	ldrb	r2, [r0]	@ tmp334,
@ SpellMenu.c:142: 	if ( spellType != ITYPE_STAFF ) { DrawIcon(&gBG0MapBuffer[y+1][x+5],spellType+0x70,menuItemPanel->oam2base<<0xC); } // This HAS to happen after the Text_Display calls.
	ldr	r0, [sp, #24]	@ _14, %sfp
	adds	r0, r0, #5	@ _14,
@ SpellMenu.c:142: 	if ( spellType != ITYPE_STAFF ) { DrawIcon(&gBG0MapBuffer[y+1][x+5],spellType+0x70,menuItemPanel->oam2base<<0xC); } // This HAS to happen after the Text_Display calls.
	ldr	r3, .L350+76	@ tmp446,
	ldr	r1, [sp, #12]	@ tmp336, %sfp
	adds	r0, r0, r5	@ tmp338, tmp337, _158
	lsls	r0, r0, #1	@ tmp339, tmp338,
	adds	r0, r3, r0	@ tmp340, tmp446, tmp339
	lsls	r2, r2, #12	@ tmp335, tmp334,
	ldr	r3, .L350+84	@ tmp342,
	adds	r1, r1, #112	@ tmp336,
	bl	.L14		@
.L341:
@ SpellMenu.c:148: 	gWrite_Range(gActiveUnit->xPos,gActiveUnit->yPos,gGet_Item_Range(gActiveUnit,spell));
	movs	r5, #16	@ _67,
	movs	r6, #17	@ _69,
@ SpellMenu.c:144: 	BmMapFill(gMapMovement,-1);
	ldr	r3, .L350+88	@ tmp343,
	ldr	r4, .L350+92	@ tmp344,
	ldr	r0, [r3]	@, gMapMovement
	movs	r1, #255	@,
	bl	.L16		@
@ SpellMenu.c:145: 	BmMapFill(gMapRange,0);
	ldr	r3, .L350+96	@ tmp345,
	movs	r1, #0	@,
	ldr	r0, [r3]	@, gMapRange
	bl	.L16		@
@ SpellMenu.c:148: 	gWrite_Range(gActiveUnit->xPos,gActiveUnit->yPos,gGet_Item_Range(gActiveUnit,spell));
	ldr	r3, .L350+100	@ tmp347,
	ldr	r4, [r3]	@ gWrite_Range.112_64, gWrite_Range
@ SpellMenu.c:148: 	gWrite_Range(gActiveUnit->xPos,gActiveUnit->yPos,gGet_Item_Range(gActiveUnit,spell));
	ldr	r3, .L350	@ tmp348,
	ldr	r0, [r3]	@ gActiveUnit.113_65, gActiveUnit
@ SpellMenu.c:148: 	gWrite_Range(gActiveUnit->xPos,gActiveUnit->yPos,gGet_Item_Range(gActiveUnit,spell));
	ldr	r3, .L350+104	@ tmp349,
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
@ SpellMenu.c:149: 	DisplayMoveRangeGraphics(( spellType == ITYPE_STAFF ? 4 : 2 )); // See note in UnitMenu.c.
	ldr	r0, [sp, #12]	@ iftmp.117_77, %sfp
	cmp	r0, #4	@ spellType,
	beq	.L342		@,
	movs	r0, #2	@ iftmp.117_77,
.L342:
@ SpellMenu.c:149: 	DisplayMoveRangeGraphics(( spellType == ITYPE_STAFF ? 4 : 2 )); // See note in UnitMenu.c.
	ldr	r3, .L350+108	@ tmp351,
	bl	.L14		@
@ SpellMenu.c:151: }
	movs	r0, #0	@,
	add	sp, sp, #36	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L336:
@ SpellMenu.c:125: 		const char* desc = GetStringFromIndex(GetItemUseDescId(spell));
	ldr	r3, .L350+112	@ tmp302,
	movs	r0, r7	@, spell
	bl	.L14		@
	ldr	r3, .L350+36	@ tmp303,
	bl	.L14		@
	ldr	r4, [sp, #16]	@ ivtmp.410, %sfp
@ SpellMenu.c:127: 		desc--;
	subs	r0, r0, #1	@ desc,
.L339:
@ SpellMenu.c:131: 			Text_InsertString(&menuItemPanel->textHandles[j],0,0,desc);
	movs	r2, #0	@,
@ SpellMenu.c:130: 			desc++;
	adds	r5, r0, #1	@ desc, desc,
@ SpellMenu.c:131: 			Text_InsertString(&menuItemPanel->textHandles[j],0,0,desc);
	movs	r3, r5	@, desc
	movs	r0, r4	@, ivtmp.410
	movs	r1, r2	@,
	ldr	r6, .L350+44	@ tmp304,
	bl	.L15		@
@ SpellMenu.c:132: 			desc = Text_GetStringNextLine(desc);
	ldr	r3, .L350+116	@ tmp305,
	movs	r0, r5	@, desc
	bl	.L14		@
@ SpellMenu.c:134: 		} while ( *desc );
	ldrb	r3, [r0]	@ *desc_103, *desc_103
	adds	r4, r4, #8	@ ivtmp.410,
	cmp	r3, #0	@ *desc_103,
	bne	.L339		@,
@ SpellMenu.c:135: 		gBattleActor.battleAttack = gBattleTarget.battleAttack; // ??? this is something vanilla does???
	ldr	r2, .L350+120	@ tmp308,
@ SpellMenu.c:135: 		gBattleActor.battleAttack = gBattleTarget.battleAttack; // ??? this is something vanilla does???
	ldr	r3, .L350+72	@ tmp307,
@ SpellMenu.c:135: 		gBattleActor.battleAttack = gBattleTarget.battleAttack; // ??? this is something vanilla does???
	movs	r0, r2	@ tmp311, tmp308
@ SpellMenu.c:135: 		gBattleActor.battleAttack = gBattleTarget.battleAttack; // ??? this is something vanilla does???
	movs	r1, r3	@ tmp314, tmp307
@ SpellMenu.c:135: 		gBattleActor.battleAttack = gBattleTarget.battleAttack; // ??? this is something vanilla does???
	adds	r0, r0, #90	@ tmp311,
@ SpellMenu.c:135: 		gBattleActor.battleAttack = gBattleTarget.battleAttack; // ??? this is something vanilla does???
	ldrh	r0, [r0]	@ tmp315,
	adds	r1, r1, #90	@ tmp314,
	strh	r0, [r1]	@ tmp315, gBattleActor.battleAttack
@ SpellMenu.c:137: 		gBattleActor.battleCritRate = gBattleTarget.battleCritRate;
	movs	r0, r2	@ tmp321, tmp308
@ SpellMenu.c:137: 		gBattleActor.battleCritRate = gBattleTarget.battleCritRate;
	movs	r1, r3	@ tmp324, tmp307
@ SpellMenu.c:137: 		gBattleActor.battleCritRate = gBattleTarget.battleCritRate;
	adds	r0, r0, #102	@ tmp321,
@ SpellMenu.c:137: 		gBattleActor.battleCritRate = gBattleTarget.battleCritRate;
	ldrh	r0, [r0]	@ tmp325,
@ SpellMenu.c:136: 		gBattleActor.battleHitRate = gBattleTarget.battleHitRate; // ??? this fixes the green/red arrows from showing on staves???
	ldr	r2, [r2, #96]	@ tmp440, MEM <unsigned int> [(short int *)&gBattleTarget + 96B]
@ SpellMenu.c:137: 		gBattleActor.battleCritRate = gBattleTarget.battleCritRate;
	adds	r1, r1, #102	@ tmp324,
	strh	r0, [r1]	@ tmp325, gBattleActor.battleCritRate
@ SpellMenu.c:136: 		gBattleActor.battleHitRate = gBattleTarget.battleHitRate; // ??? this fixes the green/red arrows from showing on staves???
	str	r2, [r3, #96]	@ tmp440, MEM <unsigned int> [(short int *)&gBattleActor + 96B]
	b	.L340		@
.L351:
	.align	2
.L350:
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
@ SpellMenu.c:155: 	if ( !DidSelectSpell ) // Don't hide the squares if we're going to the target selection menu.
	ldr	r4, .L354	@ tmp116,
@ SpellMenu.c:155: 	if ( !DidSelectSpell ) // Don't hide the squares if we're going to the target selection menu.
	ldrb	r3, [r4]	@ DidSelectSpell, DidSelectSpell
	cmp	r3, #0	@ DidSelectSpell,
	bne	.L353		@,
@ SpellMenu.c:157: 		HideMoveRangeGraphics();
	ldr	r3, .L354+4	@ tmp118,
	bl	.L14		@
.L353:
@ SpellMenu.c:161: }
	@ sp needed	@
@ SpellMenu.c:159: 	DidSelectSpell = 0; // Unset this variable.
	movs	r0, #0	@ tmp120,
	strb	r0, [r4]	@ tmp120, DidSelectSpell
@ SpellMenu.c:161: }
	pop	{r4}
	pop	{r1}
	bx	r1
.L355:
	.align	2
.L354:
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
@ SpellMenu.c:167: 	if ( UsingSpellMenu )
	ldr	r2, .L361	@ tmp176,
@ SpellMenu.c:165: 	int xTile = commandProc->xDrawTile * 8;
	ldrh	r4, [r1, #42]	@ tmp142,
@ SpellMenu.c:166: 	int yTile = commandProc->yDrawTile * 8;
	ldrh	r5, [r1, #44]	@ tmp143,
@ SpellMenu.c:167: 	if ( UsingSpellMenu )
	ldrb	r1, [r2]	@ UsingSpellMenu.119_5, UsingSpellMenu
	adds	r3, r3, #60	@ commandProc,
	str	r3, [sp]	@ commandProc, %sfp
	ldr	r6, .L361+4	@ tmp172,
@ SpellMenu.c:165: 	int xTile = commandProc->xDrawTile * 8;
	lsls	r4, r4, #3	@ xTile, tmp142,
@ SpellMenu.c:166: 	int yTile = commandProc->yDrawTile * 8;
	lsls	r5, r5, #3	@ yTile, tmp143,
@ SpellMenu.c:167: 	if ( UsingSpellMenu )
	cmp	r1, #0	@ UsingSpellMenu.119_5,
	beq	.L357		@,
@ SpellMenu.c:170: 		DrawItemRText(xTile,yTile,SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,commandProc->commandDefinitionIndex,UsingSpellMenu)]);
	ldr	r7, .L361+8	@ tmp145,
	ldr	r0, [r7]	@, gActiveUnit
	bl	SpellsGetter		@
@ SpellMenu.c:170: 		DrawItemRText(xTile,yTile,SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,commandProc->commandDefinitionIndex,UsingSpellMenu)]);
	ldr	r3, .L361	@ tmp178,
@ SpellMenu.c:170: 		DrawItemRText(xTile,yTile,SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,commandProc->commandDefinitionIndex,UsingSpellMenu)]);
	str	r0, [sp, #4]	@ tmp174, %sfp
@ SpellMenu.c:170: 		DrawItemRText(xTile,yTile,SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,commandProc->commandDefinitionIndex,UsingSpellMenu)]);
	ldrb	r2, [r3]	@ UsingSpellMenu, UsingSpellMenu
	ldr	r3, [sp]	@ tmp171, %sfp
	ldr	r0, [r7]	@, gActiveUnit
	ldrb	r1, [r3]	@ tmp151,
	bl	GetNthUsableSpell		@
@ SpellMenu.c:170: 		DrawItemRText(xTile,yTile,SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,commandProc->commandDefinitionIndex,UsingSpellMenu)]);
	ldr	r3, [sp, #4]	@ _8, %sfp
	ldrb	r2, [r3, r0]	@ *_16, *_16
.L360:
@ SpellMenu.c:184: }
	@ sp needed	@
@ SpellMenu.c:181: 			DrawItemRText(xTile,yTile,*((u16*)&gGameState+0x16)); // Probably related to special cases like ballistae?
	movs	r1, r5	@, yTile
	movs	r0, r4	@, xTile
	bl	.L15		@
@ SpellMenu.c:184: }
	pop	{r0, r1, r2, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L357:
@ SpellMenu.c:175: 		if ( commandProc->commandDefinitionIndex <= 4 )
	ldr	r3, [sp]	@ tmp171, %sfp
	ldrb	r3, [r3]	@ _19,
@ SpellMenu.c:175: 		if ( commandProc->commandDefinitionIndex <= 4 )
	cmp	r3, #4	@ _19,
	bhi	.L359		@,
@ SpellMenu.c:177: 			DrawItemRText(xTile,yTile,gActiveUnit->items[commandProc->commandDefinitionIndex]);
	ldr	r2, .L361+8	@ tmp161,
	adds	r3, r3, #12	@ tmp162,
	ldr	r2, [r2]	@ gActiveUnit, gActiveUnit
	lsls	r3, r3, #1	@ tmp163, tmp162,
	adds	r3, r2, r3	@ tmp164, gActiveUnit, tmp163
@ SpellMenu.c:177: 			DrawItemRText(xTile,yTile,gActiveUnit->items[commandProc->commandDefinitionIndex]);
	ldrh	r2, [r3, #6]	@ tmp166, *gActiveUnit.124_20
	b	.L360		@
.L359:
@ SpellMenu.c:181: 			DrawItemRText(xTile,yTile,*((u16*)&gGameState+0x16)); // Probably related to special cases like ballistae?
	ldr	r3, .L361+12	@ tmp168,
@ SpellMenu.c:181: 			DrawItemRText(xTile,yTile,*((u16*)&gGameState+0x16)); // Probably related to special cases like ballistae?
	ldrh	r2, [r3, #44]	@ MEM[(u16 *)&gGameState + 44B], MEM[(u16 *)&gGameState + 44B]
	b	.L360		@
.L362:
	.align	2
.L361:
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
@ SpellMenu.c:190: 	if ( UsingSpellMenu == BLACK_MAGIC ) { GaidenBlackMagicUMEffect(NULL,NULL); }
	movs	r1, #0	@,
@ SpellMenu.c:187: {
	push	{r4, lr}	@
@ SpellMenu.c:190: 	if ( UsingSpellMenu == BLACK_MAGIC ) { GaidenBlackMagicUMEffect(NULL,NULL); }
	ldr	r3, .L367	@ tmp115,
	ldrb	r3, [r3]	@ UsingSpellMenu.125_1, UsingSpellMenu
@ SpellMenu.c:190: 	if ( UsingSpellMenu == BLACK_MAGIC ) { GaidenBlackMagicUMEffect(NULL,NULL); }
	movs	r0, r1	@,
@ SpellMenu.c:190: 	if ( UsingSpellMenu == BLACK_MAGIC ) { GaidenBlackMagicUMEffect(NULL,NULL); }
	cmp	r3, #1	@ UsingSpellMenu.125_1,
	bne	.L364		@,
@ SpellMenu.c:190: 	if ( UsingSpellMenu == BLACK_MAGIC ) { GaidenBlackMagicUMEffect(NULL,NULL); }
	bl	GaidenBlackMagicUMEffect		@
.L365:
@ SpellMenu.c:198: }
	@ sp needed	@
@ SpellMenu.c:197: 	SelectedSpell = 0; // Regardless of use case, ensure that this is 0.
	movs	r2, #0	@ tmp118,
	ldr	r3, .L367+4	@ tmp117,
	strb	r2, [r3]	@ tmp118, SelectedSpell
@ SpellMenu.c:198: }
	pop	{r4}
	pop	{r0}
	bx	r0
.L364:
@ SpellMenu.c:191: 	else if ( UsingSpellMenu == WHITE_MAGIC ) { GaidenWhiteMagicUMEffect(NULL,NULL); }
	cmp	r3, #2	@ UsingSpellMenu.125_1,
	bne	.L366		@,
@ SpellMenu.c:191: 	else if ( UsingSpellMenu == WHITE_MAGIC ) { GaidenWhiteMagicUMEffect(NULL,NULL); }
	bl	GaidenWhiteMagicUMEffect		@
	b	.L365		@
.L366:
@ SpellMenu.c:195: 		AttackUMEffect(NULL,NULL);
	ldr	r3, .L367+8	@ tmp116,
	bl	.L14		@
	b	.L365		@
.L368:
	.align	2
.L367:
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
	ldr	r3, .L374	@ tmp144,
@ StatScreen.c:3: {
	str	r0, [sp, #8]	@ tmp181, %sfp
@ StatScreen.c:4: 	u8* spells = SpellsGetter(gpStatScreenUnit,-1);
	rsbs	r1, r1, #0	@,
	ldr	r0, [r3]	@, gpStatScreenUnit
	bl	SpellsGetter		@
@ StatScreen.c:5: 	int tile = (currHandle-1)->tileIndexOffset;
	movs	r3, r4	@ tmp145, currHandle
	movs	r7, r0	@ ivtmp.433, tmp184
	subs	r3, r3, #8	@ tmp145,
@ StatScreen.c:5: 	int tile = (currHandle-1)->tileIndexOffset;
	ldrh	r3, [r3]	@ tile, MEM[(struct TextHandle *)currHandle_27(D) + 4294967288B]
@ StatScreen.c:8: 	for ( int i = 0 ; spells[i] ; i++ )
	ldr	r6, [sp, #8]	@ iconX, %sfp
@ StatScreen.c:5: 	int tile = (currHandle-1)->tileIndexOffset;
	str	r3, [sp, #4]	@ tile, %sfp
.L370:
@ StatScreen.c:8: 	for ( int i = 0 ; spells[i] ; i++ )
	ldrb	r0, [r7]	@ _15, MEM[base: _62, offset: 0B]
@ StatScreen.c:8: 	for ( int i = 0 ; spells[i] ; i++ )
	cmp	r0, #0	@ _15,
	bne	.L373		@,
@ StatScreen.c:32: }
	movs	r0, r4	@, currHandle
	add	sp, sp, #28	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L373:
@ StatScreen.c:10: 		const ItemData* item = GetItemData(spells[i]);
	ldr	r3, .L374+4	@ tmp146,
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
	ldr	r3, .L374+8	@ tmp195,
	lsls	r0, r0, #1	@ tmp150, tmp149,
	lsls	r2, r2, #7	@,,
	adds	r0, r0, r3	@ tmp151, tmp150, tmp195
	ldr	r3, .L374+12	@ tmp153,
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
	ldr	r3, .L374+16	@ tmp167,
	bl	.L14		@
@ StatScreen.c:23: 		Text_SetColorId(currHandle,TEXT_COLOR_NORMAL);
	movs	r1, r5	@, tmp155
	movs	r0, r4	@, currHandle
	ldr	r3, .L374+20	@ tmp168,
	bl	.L14		@
@ StatScreen.c:24: 		Text_InsertString(currHandle,0,TEXT_COLOR_NORMAL,GetStringFromIndex(item->nameTextId));
	ldr	r3, [sp, #16]	@ item, %sfp
	ldrh	r0, [r3]	@ *item_32, *item_32
	ldr	r3, .L374+24	@ tmp170,
	bl	.L14		@
@ StatScreen.c:24: 		Text_InsertString(currHandle,0,TEXT_COLOR_NORMAL,GetStringFromIndex(item->nameTextId));
	movs	r2, r5	@, tmp155
@ StatScreen.c:24: 		Text_InsertString(currHandle,0,TEXT_COLOR_NORMAL,GetStringFromIndex(item->nameTextId));
	movs	r3, r0	@ _10, tmp186
@ StatScreen.c:24: 		Text_InsertString(currHandle,0,TEXT_COLOR_NORMAL,GetStringFromIndex(item->nameTextId));
	movs	r1, r5	@, tmp155
	movs	r0, r4	@, currHandle
	ldr	r5, .L374+28	@ tmp171,
	bl	.L301		@
@ StatScreen.c:25: 		Text_Display(currHandle,&StatScreenBufferMap[iconY][iconX+2]);
	ldr	r3, [sp, #20]	@ _56, %sfp
@ StatScreen.c:25: 		Text_Display(currHandle,&StatScreenBufferMap[iconY][iconX+2]);
	adds	r1, r6, #2	@ tmp172, iconX,
@ StatScreen.c:25: 		Text_Display(currHandle,&StatScreenBufferMap[iconY][iconX+2]);
	adds	r1, r1, r3	@ tmp173, tmp172, _56
	ldr	r3, .L374+8	@ tmp202,
	lsls	r1, r1, #1	@ tmp174, tmp173,
	movs	r0, r4	@, currHandle
	adds	r1, r1, r3	@ tmp175, tmp174, tmp202
	ldr	r3, .L374+32	@ tmp177,
	bl	.L14		@
@ StatScreen.c:28: 		if ( iconX == x ) { iconX += 8; }
	ldr	r3, [sp, #8]	@ x, %sfp
@ StatScreen.c:27: 		currHandle++;
	adds	r4, r4, #8	@ currHandle,
@ StatScreen.c:28: 		if ( iconX == x ) { iconX += 8; }
	cmp	r6, r3	@ iconX, x
	bne	.L371		@,
@ StatScreen.c:28: 		if ( iconX == x ) { iconX += 8; }
	adds	r6, r6, #8	@ iconX,
.L372:
	adds	r7, r7, #1	@ ivtmp.433,
	b	.L370		@
.L371:
@ StatScreen.c:29: 		else { iconX = x; iconY += 2; }
	ldr	r3, [sp, #12]	@ y, %sfp
	adds	r3, r3, #2	@ y,
	str	r3, [sp, #12]	@ y, %sfp
	ldr	r6, [sp, #8]	@ iconX, %sfp
	b	.L372		@
.L375:
	.align	2
.L374:
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
	ldr	r3, .L377	@ tmp126,
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
	ldr	r3, .L377+4	@ tmp131,
	bl	.L14		@
@ StatScreen.c:38: 	proc->textID = GetItemData(proc->type)->descTextId;
	ldrh	r3, [r0, #2]	@ tmp135,
	adds	r4, r4, #76	@ tmp134,
	strh	r3, [r4]	@ tmp135, proc_12(D)->textID
@ StatScreen.c:39: }
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L378:
	.align	2
.L377:
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
	bne	.L380		@,
@ StatScreen.c:47: 		while ( index >= 0 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index]) )
	movs	r7, #1	@ tmp160,
	rsbs	r7, r7, #0	@ tmp160, tmp160
.L381:
@ StatScreen.c:47: 		while ( index >= 0 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index]) )
	ldr	r3, .L389	@ tmp142,
	ldr	r6, [r3]	@ gpStatScreenUnit.132_4, gpStatScreenUnit
@ StatScreen.c:47: 		while ( index >= 0 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index]) )
	movs	r1, r7	@, tmp160
	movs	r0, r6	@, gpStatScreenUnit.132_4
	bl	SpellsGetter		@
@ StatScreen.c:47: 		while ( index >= 0 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index]) )
	ldrb	r1, [r0, r4]	@ *_7, *_7
	movs	r0, r6	@, gpStatScreenUnit.132_4
	bl	DoesUnitKnowSpell		@
@ StatScreen.c:47: 		while ( index >= 0 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index]) )
	cmp	r0, #0	@ tmp163,
	bne	.L379		@,
@ StatScreen.c:49: 			RTextUp(proc);
	movs	r0, r5	@, proc
	ldr	r3, .L389+4	@ tmp141,
	bl	.L14		@
@ StatScreen.c:47: 		while ( index >= 0 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index]) )
	subs	r4, r4, #2	@ index, index,
	bpl	.L381		@,
.L379:
@ StatScreen.c:63: }
	@ sp needed	@
	pop	{r3, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L380:
@ StatScreen.c:53: 	else if ( proc->direction == DIRECTION_DOWN )
	cmp	r3, #128	@ _3,
	bne	.L379		@,
@ StatScreen.c:56: 		if ( !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index]) )
	movs	r1, #1	@,
@ StatScreen.c:56: 		if ( !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index]) )
	ldr	r7, .L389	@ tmp145,
	ldr	r6, [r7]	@ gpStatScreenUnit.135_10, gpStatScreenUnit
@ StatScreen.c:56: 		if ( !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index]) )
	rsbs	r1, r1, #0	@,
	movs	r0, r6	@, gpStatScreenUnit.135_10
	bl	SpellsGetter		@
@ StatScreen.c:56: 		if ( !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index]) )
	ldrb	r1, [r0, r4]	@ *_13, *_13
	movs	r0, r6	@, gpStatScreenUnit.135_10
	bl	DoesUnitKnowSpell		@
@ StatScreen.c:56: 		if ( !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index]) )
	cmp	r0, #0	@ tmp165,
	bne	.L379		@,
@ StatScreen.c:58: 			RTextLeft(proc);
	movs	r0, r5	@, proc
	ldr	r6, .L389+8	@ tmp148,
	bl	.L15		@
@ StatScreen.c:60: 			if ( index % 2 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index-1]) ) { RTextLeft(proc); }
	lsls	r3, r4, #31	@ tmp172, _2,
	bpl	.L379		@,
@ StatScreen.c:60: 			if ( index % 2 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index-1]) ) { RTextLeft(proc); }
	movs	r1, #1	@,
@ StatScreen.c:60: 			if ( index % 2 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index-1]) ) { RTextLeft(proc); }
	ldr	r7, [r7]	@ gpStatScreenUnit.139_16, gpStatScreenUnit
@ StatScreen.c:60: 			if ( index % 2 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index-1]) ) { RTextLeft(proc); }
	rsbs	r1, r1, #0	@,
	movs	r0, r7	@, gpStatScreenUnit.139_16
	bl	SpellsGetter		@
@ StatScreen.c:60: 			if ( index % 2 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index-1]) ) { RTextLeft(proc); }
	adds	r4, r0, r4	@ tmp156, tmp166, _2
	subs	r4, r4, #1	@ tmp157,
	movs	r0, r7	@, gpStatScreenUnit.139_16
	ldrb	r1, [r4]	@ *_19, *_19
	bl	DoesUnitKnowSpell		@
@ StatScreen.c:60: 			if ( index % 2 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index-1]) ) { RTextLeft(proc); }
	cmp	r0, #0	@ tmp167,
	bne	.L379		@,
@ StatScreen.c:60: 			if ( index % 2 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index-1]) ) { RTextLeft(proc); }
	movs	r0, r5	@, proc
	bl	.L15		@
@ StatScreen.c:63: }
	b	.L379		@
.L390:
	.align	2
.L389:
	.word	gpStatScreenUnit
	.word	RTextUp
	.word	RTextLeft
	.size	GaidenRTextLooper, .-GaidenRTextLooper
	.ident	"GCC: (devkitARM release 54) 10.1.0"
	.code 16
	.align	1
.L14:
	bx	r3
.L16:
	bx	r4
.L301:
	bx	r5
.L15:
	bx	r6
.L251:
	bx	r7
