	.cpu arm7tdmi
	.eabi_attribute 20, 1	@ Tag_ABI_FP_denormal
	.eabi_attribute 21, 1	@ Tag_ABI_FP_exceptions
	.eabi_attribute 23, 3	@ Tag_ABI_FP_number_model
	.eabi_attribute 24, 1	@ Tag_ABI_align8_needed
	.eabi_attribute 25, 1	@ Tag_ABI_align8_preserved
	.eabi_attribute 26, 1	@ Tag_ABI_enum_size
	.eabi_attribute 30, 6	@ Tag_ABI_optimization_goals
	.eabi_attribute 34, 0	@ Tag_CPU_unaligned_access
	.eabi_attribute 18, 4	@ Tag_ABI_PCS_wchar_t
	.file	"GaidenMagic.c"
@ GNU C17 (devkitARM release 56) version 11.1.0 (arm-none-eabi)
@	compiled by GNU C version 10.3.0, GMP version 6.2.1, MPFR version 4.1.0, MPC version 1.2.1, isl version isl-0.18-GMP

@ GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
@ options passed: -mcpu=arm7tdmi -mthumb -mthumb-interwork -mtune=arm7tdmi -mlong-calls -march=armv4t
	.text
	.align	1
	.global	GaidenBlackMagicUMUsability
	.arch armv4t
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	GaidenBlackMagicUMUsability, %function
GaidenBlackMagicUMUsability:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}	@
	sub	sp, sp, #8	@,,
	add	r7, sp, #0	@,,
@ UnitMenu.c:9: 	u8* DisableMenuOptionsRam = (u8*) 0x30017C8;
	ldr	r3, .L4	@ tmp120,
	str	r3, [r7, #4]	@ tmp120, DisableMenuOptionsRam
@ UnitMenu.c:10: 	if (*DisableMenuOptionsRam & 1) return 3; // For tutorials 
	ldr	r3, [r7, #4]	@ tmp121, DisableMenuOptionsRam
	ldrb	r3, [r3]	@ _1, *DisableMenuOptionsRam_8
@ UnitMenu.c:10: 	if (*DisableMenuOptionsRam & 1) return 3; // For tutorials 
	movs	r2, r3	@ _2, _1
	movs	r3, #1	@ tmp122,
	ands	r3, r2	@ _3, _2
@ UnitMenu.c:10: 	if (*DisableMenuOptionsRam & 1) return 3; // For tutorials 
	beq	.L2		@,
@ UnitMenu.c:10: 	if (*DisableMenuOptionsRam & 1) return 3; // For tutorials 
	movs	r3, #3	@ _6,
	b	.L3		@
.L2:
@ UnitMenu.c:11: 	return GaidenMagicUMUsabilityExt(SpellsGetter(gActiveUnit,BLACK_MAGIC)); // This is a 0-terminated list of spells this character has learned.
	ldr	r3, .L4+4	@ tmp123,
	ldr	r3, [r3]	@ gActiveUnit.0_4, gActiveUnit
	movs	r1, #1	@,
	movs	r0, r3	@, gActiveUnit.0_4
	bl	SpellsGetter		@
	movs	r3, r0	@ _5,
	movs	r0, r3	@, _5
	bl	GaidenMagicUMUsabilityExt		@
	movs	r3, r0	@ _6,
.L3:
@ UnitMenu.c:12: }
	movs	r0, r3	@, <retval>
	mov	sp, r7	@,
	add	sp, sp, #8	@,,
	@ sp needed	@
	pop	{r7}
	pop	{r1}
	bx	r1
.L5:
	.align	2
.L4:
	.word	50337736
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
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}	@
	sub	sp, sp, #8	@,,
	add	r7, sp, #0	@,,
@ UnitMenu.c:20: 	u8* DisableMenuOptionsRam = (u8*) 0x30017C8;
	ldr	r3, .L10	@ tmp121,
	str	r3, [r7, #4]	@ tmp121, DisableMenuOptionsRam
@ UnitMenu.c:23: 	if (*DisableMenuOptionsRam & 2) return 3; 
	ldr	r3, [r7, #4]	@ tmp122, DisableMenuOptionsRam
	ldrb	r3, [r3]	@ _1, *DisableMenuOptionsRam_9
@ UnitMenu.c:23: 	if (*DisableMenuOptionsRam & 2) return 3; 
	movs	r2, r3	@ _2, _1
	movs	r3, #2	@ tmp123,
	ands	r3, r2	@ _3, _2
@ UnitMenu.c:23: 	if (*DisableMenuOptionsRam & 2) return 3; 
	beq	.L7		@,
@ UnitMenu.c:23: 	if (*DisableMenuOptionsRam & 2) return 3; 
	movs	r3, #3	@ _7,
	b	.L8		@
.L7:
@ UnitMenu.c:25: 	if (!(Capture_Usability())) { return 3; }
	ldr	r3, .L10+4	@ tmp124,
	bl	.L12		@
	subs	r3, r0, #0	@ _4,,
@ UnitMenu.c:25: 	if (!(Capture_Usability())) { return 3; }
	bne	.L9		@,
@ UnitMenu.c:25: 	if (!(Capture_Usability())) { return 3; }
	movs	r3, #3	@ _7,
	b	.L8		@
.L9:
@ UnitMenu.c:27: 	return GaidenMagicUMUsabilityExt(SpellsGetter(gActiveUnit,BLACK_MAGIC)); // This is a 0-terminated list of spells this character has learned.
	ldr	r3, .L10+8	@ tmp125,
	ldr	r3, [r3]	@ gActiveUnit.1_5, gActiveUnit
	movs	r1, #1	@,
	movs	r0, r3	@, gActiveUnit.1_5
	bl	SpellsGetter		@
	movs	r3, r0	@ _6,
	movs	r0, r3	@, _6
	bl	GaidenMagicUMUsabilityExt		@
	movs	r3, r0	@ _7,
.L8:
@ UnitMenu.c:28: }
	movs	r0, r3	@, <retval>
	mov	sp, r7	@,
	add	sp, sp, #8	@,,
	@ sp needed	@
	pop	{r7}
	pop	{r1}
	bx	r1
.L11:
	.align	2
.L10:
	.word	50337736
	.word	Capture_Usability
	.word	gActiveUnit
	.size	CaptureGaidenBlackMagicUMUsability, .-CaptureGaidenBlackMagicUMUsability
	.align	1
	.global	CaptureGaidenBlackMagicUMEffect
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	CaptureGaidenBlackMagicUMEffect, %function
CaptureGaidenBlackMagicUMEffect:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}	@
	sub	sp, sp, #16	@,,
	add	r7, sp, #0	@,,
	str	r0, [r7, #4]	@ proc, proc
	str	r1, [r7]	@ commandProc, commandProc
@ UnitMenu.c:33: 	Unit* unit = gActiveUnit;
	ldr	r3, .L15	@ tmp119,
	ldr	r3, [r3]	@ tmp120, gActiveUnit
	str	r3, [r7, #12]	@ tmp120, unit
@ UnitMenu.c:34: 	unit->state = unit->state | (1<<30); // Capturing bit 
	ldr	r3, [r7, #12]	@ tmp121, unit
	ldr	r3, [r3, #12]	@ _1, unit_6->state
@ UnitMenu.c:34: 	unit->state = unit->state | (1<<30); // Capturing bit 
	movs	r2, #128	@ tmp131,
	lsls	r2, r2, #23	@ tmp122, tmp131,
	orrs	r2, r3	@ _2, _1
@ UnitMenu.c:34: 	unit->state = unit->state | (1<<30); // Capturing bit 
	ldr	r3, [r7, #12]	@ tmp123, unit
	str	r2, [r3, #12]	@ _2, unit_6->state
@ UnitMenu.c:37: 	UsingSpellMenu = BLACK_MAGIC;
	ldr	r3, .L15+4	@ tmp124,
	movs	r2, #1	@ tmp125,
	strb	r2, [r3]	@ tmp126, UsingSpellMenu
@ UnitMenu.c:38: 	return GaidenMagicUMEffectExt(SpellsGetter(gActiveUnit,BLACK_MAGIC),proc,commandProc);
	ldr	r3, .L15	@ tmp127,
	ldr	r3, [r3]	@ gActiveUnit.2_3, gActiveUnit
	movs	r1, #1	@,
	movs	r0, r3	@, gActiveUnit.2_3
	bl	SpellsGetter		@
	ldr	r2, [r7]	@ tmp128, commandProc
	ldr	r3, [r7, #4]	@ tmp129, proc
	movs	r1, r3	@, tmp129
	bl	GaidenMagicUMEffectExt		@
	movs	r3, r0	@ _13,
@ UnitMenu.c:39: }
	movs	r0, r3	@, <retval>
	mov	sp, r7	@,
	add	sp, sp, #16	@,,
	@ sp needed	@
	pop	{r7}
	pop	{r1}
	bx	r1
.L16:
	.align	2
.L15:
	.word	gActiveUnit
	.word	UsingSpellMenu
	.size	CaptureGaidenBlackMagicUMEffect, .-CaptureGaidenBlackMagicUMEffect
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
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}	@
	add	r7, sp, #0	@,,
@ UnitMenu.c:45: 	return GaidenMagicUMUsabilityExt(SpellsGetter(gActiveUnit,WHITE_MAGIC));
	ldr	r3, .L19	@ tmp117,
	ldr	r3, [r3]	@ gActiveUnit.3_1, gActiveUnit
	movs	r1, #2	@,
	movs	r0, r3	@, gActiveUnit.3_1
	bl	SpellsGetter		@
	movs	r3, r0	@ _2,
	movs	r0, r3	@, _2
	bl	GaidenMagicUMUsabilityExt		@
	movs	r3, r0	@ _6,
@ UnitMenu.c:46: }
	movs	r0, r3	@, <retval>
	mov	sp, r7	@,
	@ sp needed	@
	pop	{r7}
	pop	{r1}
	bx	r1
.L20:
	.align	2
.L19:
	.word	gActiveUnit
	.size	GaidenWhiteMagicUMUsability, .-GaidenWhiteMagicUMUsability
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	GaidenMagicUMUsabilityExt, %function
GaidenMagicUMUsabilityExt:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}	@
	sub	sp, sp, #24	@,,
	add	r7, sp, #0	@,,
	str	r0, [r7, #4]	@ spellList, spellList
@ UnitMenu.c:50: 	u8* validList = gGenericBuffer; // Let's build a list of valid spells.
	ldr	r3, .L32	@ tmp138,
	str	r3, [r7, #20]	@ tmp138, validList
@ UnitMenu.c:51: 	for ( int i = 0 ; spellList[i] ; i++ )
	movs	r3, #0	@ tmp139,
	str	r3, [r7, #16]	@ tmp139, i
@ UnitMenu.c:51: 	for ( int i = 0 ; spellList[i] ; i++ )
	b	.L22		@
.L25:
@ UnitMenu.c:53: 		if ( !CanCastSpellNow(gActiveUnit,spellList[i]|0xFF00) ) { continue; }
	ldr	r3, .L32+4	@ tmp140,
	ldr	r0, [r3]	@ gActiveUnit.4_1, gActiveUnit
@ UnitMenu.c:53: 		if ( !CanCastSpellNow(gActiveUnit,spellList[i]|0xFF00) ) { continue; }
	ldr	r3, [r7, #16]	@ i.5_2, i
	ldr	r2, [r7, #4]	@ tmp141, spellList
	adds	r3, r2, r3	@ _3, tmp141, i.5_2
	ldrb	r3, [r3]	@ _4, *_3
	movs	r2, r3	@ _5, _4
@ UnitMenu.c:53: 		if ( !CanCastSpellNow(gActiveUnit,spellList[i]|0xFF00) ) { continue; }
	movs	r3, #255	@ tmp163,
	lsls	r3, r3, #8	@ tmp142, tmp163,
	orrs	r3, r2	@ _6, _5
	movs	r1, r3	@, _6
	bl	CanCastSpellNow		@
	subs	r3, r0, #0	@ _7,,
@ UnitMenu.c:53: 		if ( !CanCastSpellNow(gActiveUnit,spellList[i]|0xFF00) ) { continue; }
	beq	.L31		@,
@ UnitMenu.c:54: 		*validList = spellList[i];
	ldr	r3, [r7, #16]	@ i.6_8, i
	ldr	r2, [r7, #4]	@ tmp143, spellList
	adds	r3, r2, r3	@ _9, tmp143, i.6_8
	ldrb	r2, [r3]	@ _10, *_9
@ UnitMenu.c:54: 		*validList = spellList[i];
	ldr	r3, [r7, #20]	@ tmp144, validList
	strb	r2, [r3]	@ tmp145, *validList_25
@ UnitMenu.c:55: 		validList++;
	ldr	r3, [r7, #20]	@ tmp147, validList
	adds	r3, r3, #1	@ tmp146,
	str	r3, [r7, #20]	@ tmp146, validList
	b	.L24		@
.L31:
@ UnitMenu.c:53: 		if ( !CanCastSpellNow(gActiveUnit,spellList[i]|0xFF00) ) { continue; }
	nop	
.L24:
@ UnitMenu.c:51: 	for ( int i = 0 ; spellList[i] ; i++ )
	ldr	r3, [r7, #16]	@ tmp149, i
	adds	r3, r3, #1	@ tmp148,
	str	r3, [r7, #16]	@ tmp148, i
.L22:
@ UnitMenu.c:51: 	for ( int i = 0 ; spellList[i] ; i++ )
	ldr	r3, [r7, #16]	@ i.7_11, i
	ldr	r2, [r7, #4]	@ tmp150, spellList
	adds	r3, r2, r3	@ _12, tmp150, i.7_11
	ldrb	r3, [r3]	@ _13, *_12
@ UnitMenu.c:51: 	for ( int i = 0 ; spellList[i] ; i++ )
	cmp	r3, #0	@ _13,
	bne	.L25		@,
@ UnitMenu.c:57: 	*validList = 0;
	ldr	r3, [r7, #20]	@ tmp151, validList
	movs	r2, #0	@ tmp152,
	strb	r2, [r3]	@ tmp153, *validList_25
@ UnitMenu.c:59: 	validList = gGenericBuffer;
	ldr	r3, .L32	@ tmp154,
	str	r3, [r7, #20]	@ tmp154, validList
@ UnitMenu.c:60: 	if ( !*validList ) { return 3; } // Return unusable if there are no valid spells.
	ldr	r3, [r7, #20]	@ tmp155, validList
	ldrb	r3, [r3]	@ _14, *validList_38
@ UnitMenu.c:60: 	if ( !*validList ) { return 3; } // Return unusable if there are no valid spells.
	cmp	r3, #0	@ _14,
	bne	.L26		@,
@ UnitMenu.c:60: 	if ( !*validList ) { return 3; } // Return unusable if there are no valid spells.
	movs	r3, #3	@ _28,
	b	.L27		@
.L26:
@ UnitMenu.c:61: 	for ( int i = 0 ; validList[i] ; i++ )
	movs	r3, #0	@ tmp156,
	str	r3, [r7, #12]	@ tmp156, i
@ UnitMenu.c:61: 	for ( int i = 0 ; validList[i] ; i++ )
	b	.L28		@
.L30:
@ UnitMenu.c:64: 		if ( HasSufficientHP(gActiveUnit,validList[i]) ) { return 1; } // We've found a spell we can cast! Return usable.
	ldr	r3, .L32+4	@ tmp157,
	ldr	r0, [r3]	@ gActiveUnit.8_15, gActiveUnit
@ UnitMenu.c:64: 		if ( HasSufficientHP(gActiveUnit,validList[i]) ) { return 1; } // We've found a spell we can cast! Return usable.
	ldr	r3, [r7, #12]	@ i.9_16, i
	ldr	r2, [r7, #20]	@ tmp158, validList
	adds	r3, r2, r3	@ _17, tmp158, i.9_16
	ldrb	r3, [r3]	@ _18, *_17
@ UnitMenu.c:64: 		if ( HasSufficientHP(gActiveUnit,validList[i]) ) { return 1; } // We've found a spell we can cast! Return usable.
	movs	r1, r3	@, _19
	bl	HasSufficientHP		@
	subs	r3, r0, #0	@ _20,,
@ UnitMenu.c:64: 		if ( HasSufficientHP(gActiveUnit,validList[i]) ) { return 1; } // We've found a spell we can cast! Return usable.
	beq	.L29		@,
@ UnitMenu.c:64: 		if ( HasSufficientHP(gActiveUnit,validList[i]) ) { return 1; } // We've found a spell we can cast! Return usable.
	movs	r3, #1	@ _28,
	b	.L27		@
.L29:
@ UnitMenu.c:61: 	for ( int i = 0 ; validList[i] ; i++ )
	ldr	r3, [r7, #12]	@ tmp160, i
	adds	r3, r3, #1	@ tmp159,
	str	r3, [r7, #12]	@ tmp159, i
.L28:
@ UnitMenu.c:61: 	for ( int i = 0 ; validList[i] ; i++ )
	ldr	r3, [r7, #12]	@ i.10_21, i
	ldr	r2, [r7, #20]	@ tmp161, validList
	adds	r3, r2, r3	@ _22, tmp161, i.10_21
	ldrb	r3, [r3]	@ _23, *_22
@ UnitMenu.c:61: 	for ( int i = 0 ; validList[i] ; i++ )
	cmp	r3, #0	@ _23,
	bne	.L30		@,
@ UnitMenu.c:66: 	return 2; // There were valid spells, but we don't have enough HP to cast any of them. Return greyed out.
	movs	r3, #2	@ _28,
.L27:
@ UnitMenu.c:67: }
	movs	r0, r3	@, <retval>
	mov	sp, r7	@,
	add	sp, sp, #24	@,,
	@ sp needed	@
	pop	{r7}
	pop	{r1}
	bx	r1
.L33:
	.align	2
.L32:
	.word	gGenericBuffer
	.word	gActiveUnit
	.size	GaidenMagicUMUsabilityExt, .-GaidenMagicUMUsabilityExt
	.align	1
	.global	GaidenBlackMagicUMEffect
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	GaidenBlackMagicUMEffect, %function
GaidenBlackMagicUMEffect:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}	@
	sub	sp, sp, #8	@,,
	add	r7, sp, #0	@,,
	str	r0, [r7, #4]	@ proc, proc
	str	r1, [r7]	@ commandProc, commandProc
@ UnitMenu.c:71: 	UsingSpellMenu = BLACK_MAGIC;
	ldr	r3, .L36	@ tmp117,
	movs	r2, #1	@ tmp118,
	strb	r2, [r3]	@ tmp119, UsingSpellMenu
@ UnitMenu.c:72: 	return GaidenMagicUMEffectExt(SpellsGetter(gActiveUnit,BLACK_MAGIC),proc,commandProc);
	ldr	r3, .L36+4	@ tmp120,
	ldr	r3, [r3]	@ gActiveUnit.11_1, gActiveUnit
	movs	r1, #1	@,
	movs	r0, r3	@, gActiveUnit.11_1
	bl	SpellsGetter		@
	ldr	r2, [r7]	@ tmp121, commandProc
	ldr	r3, [r7, #4]	@ tmp122, proc
	movs	r1, r3	@, tmp122
	bl	GaidenMagicUMEffectExt		@
	movs	r3, r0	@ _9,
@ UnitMenu.c:73: }
	movs	r0, r3	@, <retval>
	mov	sp, r7	@,
	add	sp, sp, #8	@,,
	@ sp needed	@
	pop	{r7}
	pop	{r1}
	bx	r1
.L37:
	.align	2
.L36:
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
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}	@
	sub	sp, sp, #8	@,,
	add	r7, sp, #0	@,,
	str	r0, [r7, #4]	@ proc, proc
	str	r1, [r7]	@ commandProc, commandProc
@ UnitMenu.c:81: 	UsingSpellMenu = WHITE_MAGIC;
	ldr	r3, .L40	@ tmp117,
	movs	r2, #2	@ tmp118,
	strb	r2, [r3]	@ tmp119, UsingSpellMenu
@ UnitMenu.c:82: 	return GaidenMagicUMEffectExt(SpellsGetter(gActiveUnit,WHITE_MAGIC),proc,commandProc);
	ldr	r3, .L40+4	@ tmp120,
	ldr	r3, [r3]	@ gActiveUnit.12_1, gActiveUnit
	movs	r1, #2	@,
	movs	r0, r3	@, gActiveUnit.12_1
	bl	SpellsGetter		@
	ldr	r2, [r7]	@ tmp121, commandProc
	ldr	r3, [r7, #4]	@ tmp122, proc
	movs	r1, r3	@, tmp122
	bl	GaidenMagicUMEffectExt		@
	movs	r3, r0	@ _9,
@ UnitMenu.c:83: }
	movs	r0, r3	@, <retval>
	mov	sp, r7	@,
	add	sp, sp, #8	@,,
	@ sp needed	@
	pop	{r7}
	pop	{r1}
	bx	r1
.L41:
	.align	2
.L40:
	.word	UsingSpellMenu
	.word	gActiveUnit
	.size	GaidenWhiteMagicUMEffect, .-GaidenWhiteMagicUMEffect
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	GaidenMagicUMEffectExt, %function
GaidenMagicUMEffectExt:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r7, lr}	@
	sub	sp, sp, #36	@,,
	add	r7, sp, #8	@,,
	str	r0, [r7, #12]	@ spellsList, spellsList
	str	r1, [r7, #8]	@ proc, proc
	str	r2, [r7, #4]	@ commandProc, commandProc
@ UnitMenu.c:87: 	if ( proc && commandProc->availability == 2 )
	ldr	r3, [r7, #8]	@ tmp121, proc
	cmp	r3, #0	@ tmp121,
	beq	.L43		@,
@ UnitMenu.c:87: 	if ( proc && commandProc->availability == 2 )
	ldr	r3, [r7, #4]	@ tmp122, commandProc
	movs	r2, #61	@ tmp123,
	ldrb	r3, [r3, r2]	@ _1,
@ UnitMenu.c:87: 	if ( proc && commandProc->availability == 2 )
	cmp	r3, #2	@ _1,
	bne	.L43		@,
@ UnitMenu.c:90: 		MenuCallHelpBox(proc,gGaidenMagicUMErrorText);
	ldr	r3, .L45	@ tmp124,
	ldrh	r2, [r3]	@ gGaidenMagicUMErrorText.13_2, gGaidenMagicUMErrorText
	ldr	r3, [r7, #8]	@ tmp125, proc
	movs	r1, r2	@, gGaidenMagicUMErrorText.13_2
	movs	r0, r3	@, tmp125
	ldr	r3, .L45+4	@ tmp126,
	bl	.L12		@
@ UnitMenu.c:91: 		return 0x08;
	movs	r3, #8	@ _7,
	b	.L44		@
.L43:
@ UnitMenu.c:95: 		_ResetIconGraphics();
	ldr	r3, .L45+8	@ tmp127,
	bl	.L12		@
@ UnitMenu.c:96: 		SelectedSpell = spellsList[0];
	ldr	r3, [r7, #12]	@ tmp128, spellsList
	ldrb	r2, [r3]	@ _3, *spellsList_15(D)
@ UnitMenu.c:96: 		SelectedSpell = spellsList[0];
	ldr	r3, .L45+12	@ tmp129,
	strb	r2, [r3]	@ tmp130, SelectedSpell
@ UnitMenu.c:97: 		LoadIconPalettes(4);
	movs	r0, #4	@,
	ldr	r3, .L45+16	@ tmp131,
	bl	.L12		@
@ UnitMenu.c:98: 		MenuProc* menu = StartMenu(&SpellSelectMenuDefs);
	ldr	r3, .L45+20	@ tmp132,
	movs	r0, r3	@, tmp132
	ldr	r3, .L45+24	@ tmp133,
	bl	.L12		@
	movs	r3, r0	@ tmp134,
	str	r3, [r7, #20]	@ tmp134, menu
@ UnitMenu.c:100: 		StartFace(0,GetUnitPortraitId(gActiveUnit),0xB0,0xC,2);
	ldr	r3, .L45+28	@ tmp135,
	ldr	r3, [r3]	@ gActiveUnit.14_4, gActiveUnit
	movs	r0, r3	@, gActiveUnit.14_4
	ldr	r3, .L45+32	@ tmp136,
	bl	.L12		@
	movs	r1, r0	@ _5,
	movs	r3, #2	@ tmp137,
	str	r3, [sp]	@ tmp137,
	movs	r3, #12	@,
	movs	r2, #176	@,
	movs	r0, #0	@,
	ldr	r4, .L45+36	@ tmp138,
	bl	.L47		@
@ UnitMenu.c:101: 		SetFaceBlinkControlById(0,5);
	movs	r1, #5	@,
	movs	r0, #0	@,
	ldr	r3, .L45+40	@ tmp139,
	bl	.L12		@
@ UnitMenu.c:102: 		ForceMenuItemPanel(menu,gActiveUnit,15,11);
	ldr	r3, .L45+28	@ tmp140,
	ldr	r1, [r3]	@ gActiveUnit.15_6, gActiveUnit
	ldr	r0, [r7, #20]	@ tmp141, menu
	movs	r3, #11	@,
	movs	r2, #15	@,
	ldr	r4, .L45+44	@ tmp142,
	bl	.L47		@
@ UnitMenu.c:103: 		return 0x17;
	movs	r3, #23	@ _7,
.L44:
@ UnitMenu.c:105: }
	movs	r0, r3	@, <retval>
	mov	sp, r7	@,
	add	sp, sp, #28	@,,
	@ sp needed	@
	pop	{r4, r7}
	pop	{r1}
	bx	r1
.L46:
	.align	2
.L45:
	.word	gGaidenMagicUMErrorText
	.word	MenuCallHelpBox
	.word	_ResetIconGraphics
	.word	SelectedSpell
	.word	LoadIconPalettes
	.word	SpellSelectMenuDefs
	.word	StartMenu
	.word	gActiveUnit
	.word	GetUnitPortraitId
	.word	StartFace
	.word	SetFaceBlinkControlById
	.word	ForceMenuItemPanel
	.size	GaidenMagicUMEffectExt, .-GaidenMagicUMEffectExt
	.align	1
	.global	GaidenBlackMagicUMHover
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	GaidenBlackMagicUMHover, %function
GaidenBlackMagicUMHover:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}	@
	sub	sp, sp, #8	@,,
	add	r7, sp, #0	@,,
	str	r0, [r7, #4]	@ proc, proc
@ UnitMenu.c:109: 	UsingSpellMenu = BLACK_MAGIC;
	ldr	r3, .L52	@ tmp121,
	movs	r2, #1	@ tmp122,
	strb	r2, [r3]	@ tmp123, UsingSpellMenu
@ UnitMenu.c:110: 	BmMapFill(gMapMovement,-1);
	ldr	r3, .L52+4	@ tmp124,
	ldr	r3, [r3]	@ gMapMovement.16_1, gMapMovement
	movs	r1, #255	@,
	movs	r0, r3	@, gMapMovement.16_1
	ldr	r3, .L52+8	@ tmp125,
	bl	.L12		@
@ UnitMenu.c:111: 	BmMapFill(gMapRange,0);
	ldr	r3, .L52+12	@ tmp126,
	ldr	r3, [r3]	@ gMapRange.17_2, gMapRange
	movs	r1, #0	@,
	movs	r0, r3	@, gMapRange.17_2
	ldr	r3, .L52+8	@ tmp127,
	bl	.L12		@
@ UnitMenu.c:112: 	if ( CanUseAttackSpellsNow(gActiveUnit,BLACK_MAGIC) ) // If we can use an attack spell now, display the red range.
	ldr	r3, .L52+16	@ tmp128,
	ldr	r3, [r3]	@ gActiveUnit.18_3, gActiveUnit
	movs	r1, #1	@,
	movs	r0, r3	@, gActiveUnit.18_3
	bl	CanUseAttackSpellsNow		@
	subs	r3, r0, #0	@ _4,,
@ UnitMenu.c:112: 	if ( CanUseAttackSpellsNow(gActiveUnit,BLACK_MAGIC) ) // If we can use an attack spell now, display the red range.
	beq	.L49		@,
@ UnitMenu.c:114: 		All_Spells_One_Square(gActiveUnit,&RangeUsabilityCheckNotStaff);
	ldr	r3, .L52+16	@ tmp129,
	ldr	r3, [r3]	@ gActiveUnit.19_5, gActiveUnit
	ldr	r2, .L52+20	@ tmp130,
	movs	r1, r2	@, tmp130
	movs	r0, r3	@, gActiveUnit.19_5
	bl	All_Spells_One_Square		@
@ UnitMenu.c:115: 		DisplayMoveRangeGraphics(3);
	movs	r0, #3	@,
	ldr	r3, .L52+24	@ tmp131,
	bl	.L12		@
	b	.L50		@
.L49:
@ UnitMenu.c:119: 		All_Spells_One_Square(gActiveUnit,&RangeUsabilityCheckStaff);
	ldr	r3, .L52+16	@ tmp132,
	ldr	r3, [r3]	@ gActiveUnit.20_6, gActiveUnit
	ldr	r2, .L52+28	@ tmp133,
	movs	r1, r2	@, tmp133
	movs	r0, r3	@, gActiveUnit.20_6
	bl	All_Spells_One_Square		@
@ UnitMenu.c:120: 		DisplayMoveRangeGraphics(5);
	movs	r0, #5	@,
	ldr	r3, .L52+24	@ tmp134,
	bl	.L12		@
.L50:
@ UnitMenu.c:125: 	return 0;
	movs	r3, #0	@ _17,
@ UnitMenu.c:126: }
	movs	r0, r3	@, <retval>
	mov	sp, r7	@,
	add	sp, sp, #8	@,,
	@ sp needed	@
	pop	{r7}
	pop	{r1}
	bx	r1
.L53:
	.align	2
.L52:
	.word	UsingSpellMenu
	.word	gMapMovement
	.word	BmMapFill
	.word	gMapRange
	.word	gActiveUnit
	.word	RangeUsabilityCheckNotStaff
	.word	DisplayMoveRangeGraphics
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
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}	@
	sub	sp, sp, #8	@,,
	add	r7, sp, #0	@,,
	str	r0, [r7, #4]	@ proc, proc
@ UnitMenu.c:130: 	UsingSpellMenu = WHITE_MAGIC;
	ldr	r3, .L58	@ tmp121,
	movs	r2, #2	@ tmp122,
	strb	r2, [r3]	@ tmp123, UsingSpellMenu
@ UnitMenu.c:131: 	BmMapFill(gMapMovement,-1);
	ldr	r3, .L58+4	@ tmp124,
	ldr	r3, [r3]	@ gMapMovement.21_1, gMapMovement
	movs	r1, #255	@,
	movs	r0, r3	@, gMapMovement.21_1
	ldr	r3, .L58+8	@ tmp125,
	bl	.L12		@
@ UnitMenu.c:132: 	BmMapFill(gMapRange,0);
	ldr	r3, .L58+12	@ tmp126,
	ldr	r3, [r3]	@ gMapRange.22_2, gMapRange
	movs	r1, #0	@,
	movs	r0, r3	@, gMapRange.22_2
	ldr	r3, .L58+8	@ tmp127,
	bl	.L12		@
@ UnitMenu.c:133: 	if ( CanUseAttackSpellsNow(gActiveUnit,WHITE_MAGIC) ) // If we can use an attack spell now, display the red range.
	ldr	r3, .L58+16	@ tmp128,
	ldr	r3, [r3]	@ gActiveUnit.23_3, gActiveUnit
	movs	r1, #2	@,
	movs	r0, r3	@, gActiveUnit.23_3
	bl	CanUseAttackSpellsNow		@
	subs	r3, r0, #0	@ _4,,
@ UnitMenu.c:133: 	if ( CanUseAttackSpellsNow(gActiveUnit,WHITE_MAGIC) ) // If we can use an attack spell now, display the red range.
	beq	.L55		@,
@ UnitMenu.c:135: 		All_Spells_One_Square(gActiveUnit,&RangeUsabilityCheckNotStaff);
	ldr	r3, .L58+16	@ tmp129,
	ldr	r3, [r3]	@ gActiveUnit.24_5, gActiveUnit
	ldr	r2, .L58+20	@ tmp130,
	movs	r1, r2	@, tmp130
	movs	r0, r3	@, gActiveUnit.24_5
	bl	All_Spells_One_Square		@
@ UnitMenu.c:136: 		DisplayMoveRangeGraphics(3);
	movs	r0, #3	@,
	ldr	r3, .L58+24	@ tmp131,
	bl	.L12		@
	b	.L56		@
.L55:
@ UnitMenu.c:140: 		All_Spells_One_Square(gActiveUnit,&RangeUsabilityCheckStaff);
	ldr	r3, .L58+16	@ tmp132,
	ldr	r3, [r3]	@ gActiveUnit.25_6, gActiveUnit
	ldr	r2, .L58+28	@ tmp133,
	movs	r1, r2	@, tmp133
	movs	r0, r3	@, gActiveUnit.25_6
	bl	All_Spells_One_Square		@
@ UnitMenu.c:141: 		DisplayMoveRangeGraphics(5);
	movs	r0, #5	@,
	ldr	r3, .L58+24	@ tmp134,
	bl	.L12		@
.L56:
@ UnitMenu.c:143: 	return 0;
	movs	r3, #0	@ _17,
@ UnitMenu.c:144: }
	movs	r0, r3	@, <retval>
	mov	sp, r7	@,
	add	sp, sp, #8	@,,
	@ sp needed	@
	pop	{r7}
	pop	{r1}
	bx	r1
.L59:
	.align	2
.L58:
	.word	UsingSpellMenu
	.word	gMapMovement
	.word	BmMapFill
	.word	gMapRange
	.word	gActiveUnit
	.word	RangeUsabilityCheckNotStaff
	.word	DisplayMoveRangeGraphics
	.word	RangeUsabilityCheckStaff
	.size	GaidenWhiteMagicUMHover, .-GaidenWhiteMagicUMHover
	.align	1
	.global	GaidenMagicUMUnhover
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	GaidenMagicUMUnhover, %function
GaidenMagicUMUnhover:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}	@
	sub	sp, sp, #8	@,,
	add	r7, sp, #0	@,,
	str	r0, [r7, #4]	@ proc, proc
@ UnitMenu.c:148: 	if ( !SelectedSpell ) { UsingSpellMenu = 0; } // Don't unset this if we're going to the spell menu.
	ldr	r3, .L63	@ tmp116,
	ldrb	r3, [r3]	@ SelectedSpell.26_1, SelectedSpell
@ UnitMenu.c:148: 	if ( !SelectedSpell ) { UsingSpellMenu = 0; } // Don't unset this if we're going to the spell menu.
	cmp	r3, #0	@ SelectedSpell.26_1,
	bne	.L61		@,
@ UnitMenu.c:148: 	if ( !SelectedSpell ) { UsingSpellMenu = 0; } // Don't unset this if we're going to the spell menu.
	ldr	r3, .L63+4	@ tmp117,
	movs	r2, #0	@ tmp118,
	strb	r2, [r3]	@ tmp119, UsingSpellMenu
.L61:
@ UnitMenu.c:149: 	HideMoveRangeGraphics();
	ldr	r3, .L63+8	@ tmp120,
	bl	.L12		@
@ UnitMenu.c:150: 	return 0;
	movs	r3, #0	@ _6,
@ UnitMenu.c:151: }
	movs	r0, r3	@, <retval>
	mov	sp, r7	@,
	add	sp, sp, #8	@,,
	@ sp needed	@
	pop	{r7}
	pop	{r1}
	bx	r1
.L64:
	.align	2
.L63:
	.word	SelectedSpell
	.word	UsingSpellMenu
	.word	HideMoveRangeGraphics
	.size	GaidenMagicUMUnhover, .-GaidenMagicUMUnhover
	.align	1
	.global	SpellsGetter
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	SpellsGetter, %function
SpellsGetter:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}	@
	sub	sp, sp, #8	@,,
	add	r7, sp, #0	@,,
	str	r0, [r7, #4]	@ unit, unit
	str	r1, [r7]	@ type, type
@ SpellSystem.c:4: 	return SpellsGetterForLevel(unit,-1,type);
	ldr	r2, [r7]	@ tmp115, type
	movs	r3, #1	@ tmp119,
	rsbs	r1, r3, #0	@ tmp116, tmp119
	ldr	r3, [r7, #4]	@ tmp117, unit
	movs	r0, r3	@, tmp117
	bl	SpellsGetterForLevel		@
	movs	r3, r0	@ _5,
@ SpellSystem.c:5: }
	movs	r0, r3	@, <retval>
	mov	sp, r7	@,
	add	sp, sp, #8	@,,
	@ sp needed	@
	pop	{r7}
	pop	{r1}
	bx	r1
	.size	SpellsGetter, .-SpellsGetter
	.align	1
	.global	SpellsGetterForLevel
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	SpellsGetterForLevel, %function
SpellsGetterForLevel:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 40
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}	@
	sub	sp, sp, #40	@,,
	add	r7, sp, #0	@,,
	str	r0, [r7, #12]	@ unit, unit
	str	r1, [r7, #8]	@ level, level
	str	r2, [r7, #4]	@ type, type
@ SpellSystem.c:10: 	int unitLevel = unit->level;
	ldr	r3, [r7, #12]	@ tmp151, unit
	ldrb	r3, [r3, #8]	@ _1,
	lsls	r3, r3, #24	@ _1, _1,
	asrs	r3, r3, #24	@ _1, _1,
@ SpellSystem.c:10: 	int unitLevel = unit->level;
	str	r3, [r7, #36]	@ _1, unitLevel
@ SpellSystem.c:11: 	if ( UNIT_ATTRIBUTES(unit) & CA_PROMOTED ) { unitLevel += 80; } // Treat promoted as top bit set.
	ldr	r3, [r7, #12]	@ tmp152, unit
	ldr	r3, [r3]	@ _2, unit_52(D)->pCharacterData
	ldr	r2, [r3, #40]	@ _3, _2->attributes
	ldr	r3, [r7, #12]	@ tmp153, unit
	ldr	r3, [r3, #4]	@ _4, unit_52(D)->pClassData
	ldr	r3, [r3, #40]	@ _5, _4->attributes
	orrs	r2, r3	@ _6, _5
@ SpellSystem.c:11: 	if ( UNIT_ATTRIBUTES(unit) & CA_PROMOTED ) { unitLevel += 80; } // Treat promoted as top bit set.
	movs	r3, #128	@ tmp202,
	lsls	r3, r3, #1	@ tmp154, tmp202,
	ands	r3, r2	@ _7, _6
@ SpellSystem.c:11: 	if ( UNIT_ATTRIBUTES(unit) & CA_PROMOTED ) { unitLevel += 80; } // Treat promoted as top bit set.
	beq	.L68		@,
@ SpellSystem.c:11: 	if ( UNIT_ATTRIBUTES(unit) & CA_PROMOTED ) { unitLevel += 80; } // Treat promoted as top bit set.
	ldr	r3, [r7, #36]	@ tmp156, unitLevel
	adds	r3, r3, #80	@ tmp155,
	str	r3, [r7, #36]	@ tmp155, unitLevel
.L68:
@ SpellSystem.c:12: 	u8* currBuffer = SpellsBuffer;
	ldr	r3, .L82	@ tmp157,
	str	r3, [r7, #32]	@ tmp157, currBuffer
@ SpellSystem.c:14: 	SpellList* ROMList = SpellListTable[unit->pClassData->number];	
	ldr	r3, [r7, #12]	@ tmp158, unit
	ldr	r3, [r3, #4]	@ _8, unit_52(D)->pClassData
@ SpellSystem.c:14: 	SpellList* ROMList = SpellListTable[unit->pClassData->number];	
	ldrb	r3, [r3, #4]	@ _9,
	movs	r2, r3	@ _10, _9
@ SpellSystem.c:14: 	SpellList* ROMList = SpellListTable[unit->pClassData->number];	
	ldr	r3, .L82+4	@ tmp159,
	lsls	r2, r2, #2	@ tmp160, _10,
	ldr	r3, [r2, r3]	@ tmp161, SpellListTable[_10]
	str	r3, [r7, #20]	@ tmp161, ROMList
@ SpellSystem.c:16: 	for ( int i = 0 ; i < 5 ; i++ )	
	movs	r3, #0	@ tmp162,
	str	r3, [r7, #28]	@ tmp162, i
@ SpellSystem.c:16: 	for ( int i = 0 ; i < 5 ; i++ )	
	b	.L69		@
.L71:
@ SpellSystem.c:18: 		if (unit->ranks[i] != 0) {
	ldr	r2, [r7, #12]	@ tmp163, unit
	movs	r1, #40	@ tmp164,
	ldr	r3, [r7, #28]	@ tmp166, i
	adds	r3, r2, r3	@ tmp165, tmp163, tmp166
	adds	r3, r3, r1	@ tmp167, tmp165, tmp164
	ldrb	r3, [r3]	@ _11, *unit_52(D)
@ SpellSystem.c:18: 		if (unit->ranks[i] != 0) {
	cmp	r3, #0	@ _11,
	beq	.L70		@,
@ SpellSystem.c:20: 			*currBuffer = unit->ranks[i];
	ldr	r2, [r7, #12]	@ tmp168, unit
	movs	r1, #40	@ tmp169,
	ldr	r3, [r7, #28]	@ tmp171, i
	adds	r3, r2, r3	@ tmp170, tmp168, tmp171
	adds	r3, r3, r1	@ tmp172, tmp170, tmp169
	ldrb	r2, [r3]	@ _12, *unit_52(D)
@ SpellSystem.c:20: 			*currBuffer = unit->ranks[i];
	ldr	r3, [r7, #32]	@ tmp173, currBuffer
	strb	r2, [r3]	@ tmp174, *currBuffer_39
@ SpellSystem.c:21: 			currBuffer++;
	ldr	r3, [r7, #32]	@ tmp176, currBuffer
	adds	r3, r3, #1	@ tmp175,
	str	r3, [r7, #32]	@ tmp175, currBuffer
.L70:
@ SpellSystem.c:16: 	for ( int i = 0 ; i < 5 ; i++ )	
	ldr	r3, [r7, #28]	@ tmp178, i
	adds	r3, r3, #1	@ tmp177,
	str	r3, [r7, #28]	@ tmp177, i
.L69:
@ SpellSystem.c:16: 	for ( int i = 0 ; i < 5 ; i++ )	
	ldr	r3, [r7, #28]	@ tmp179, i
	cmp	r3, #4	@ tmp179,
	ble	.L71		@,
@ SpellSystem.c:27: 	if ( ROMList )
	ldr	r3, [r7, #20]	@ tmp180, ROMList
	cmp	r3, #0	@ tmp180,
	beq	.L72		@,
@ SpellSystem.c:30: 		for ( int i = 0 ; ROMList[i].level ; i++ )
	movs	r3, #0	@ tmp181,
	str	r3, [r7, #24]	@ tmp181, i
@ SpellSystem.c:30: 		for ( int i = 0 ; ROMList[i].level ; i++ )
	b	.L73		@
.L78:
@ SpellSystem.c:32: 			if ( (level == -1 && unitLevel >= ROMList[i].level) || (level == ROMList[i].level) )
	ldr	r3, [r7, #8]	@ tmp182, level
	adds	r3, r3, #1	@ tmp203, tmp182,
	bne	.L74		@,
@ SpellSystem.c:32: 			if ( (level == -1 && unitLevel >= ROMList[i].level) || (level == ROMList[i].level) )
	ldr	r3, [r7, #24]	@ i.27_13, i
	lsls	r3, r3, #1	@ _14, i.27_13,
	ldr	r2, [r7, #20]	@ tmp183, ROMList
	adds	r3, r2, r3	@ _15, tmp183, _14
@ SpellSystem.c:32: 			if ( (level == -1 && unitLevel >= ROMList[i].level) || (level == ROMList[i].level) )
	ldrb	r3, [r3]	@ _16, *_15
	movs	r2, r3	@ _17, _16
@ SpellSystem.c:32: 			if ( (level == -1 && unitLevel >= ROMList[i].level) || (level == ROMList[i].level) )
	ldr	r3, [r7, #36]	@ tmp184, unitLevel
	cmp	r3, r2	@ tmp184, _17
	bge	.L75		@,
.L74:
@ SpellSystem.c:32: 			if ( (level == -1 && unitLevel >= ROMList[i].level) || (level == ROMList[i].level) )
	ldr	r3, [r7, #24]	@ i.28_18, i
	lsls	r3, r3, #1	@ _19, i.28_18,
	ldr	r2, [r7, #20]	@ tmp185, ROMList
	adds	r3, r2, r3	@ _20, tmp185, _19
@ SpellSystem.c:32: 			if ( (level == -1 && unitLevel >= ROMList[i].level) || (level == ROMList[i].level) )
	ldrb	r3, [r3]	@ _21, *_20
	movs	r2, r3	@ _22, _21
@ SpellSystem.c:32: 			if ( (level == -1 && unitLevel >= ROMList[i].level) || (level == ROMList[i].level) )
	ldr	r3, [r7, #8]	@ tmp186, level
	cmp	r3, r2	@ tmp186, _22
	bne	.L76		@,
.L75:
@ SpellSystem.c:34: 				if ( type == -1 || type == GetSpellType(ROMList[i].spell) )
	ldr	r3, [r7, #4]	@ tmp187, type
	adds	r3, r3, #1	@ tmp204, tmp187,
	beq	.L77		@,
@ SpellSystem.c:34: 				if ( type == -1 || type == GetSpellType(ROMList[i].spell) )
	ldr	r3, [r7, #24]	@ i.29_23, i
	lsls	r3, r3, #1	@ _24, i.29_23,
	ldr	r2, [r7, #20]	@ tmp188, ROMList
	adds	r3, r2, r3	@ _25, tmp188, _24
@ SpellSystem.c:34: 				if ( type == -1 || type == GetSpellType(ROMList[i].spell) )
	ldrb	r3, [r3, #1]	@ _26,
@ SpellSystem.c:34: 				if ( type == -1 || type == GetSpellType(ROMList[i].spell) )
	movs	r0, r3	@, _27
	bl	GetSpellType		@
	movs	r2, r0	@ _28,
@ SpellSystem.c:34: 				if ( type == -1 || type == GetSpellType(ROMList[i].spell) )
	ldr	r3, [r7, #4]	@ tmp189, type
	cmp	r3, r2	@ tmp189, _28
	bne	.L76		@,
.L77:
@ SpellSystem.c:37: 					*currBuffer = ROMList[i].spell;
	ldr	r3, [r7, #24]	@ i.30_29, i
	lsls	r3, r3, #1	@ _30, i.30_29,
	ldr	r2, [r7, #20]	@ tmp190, ROMList
	adds	r3, r2, r3	@ _31, tmp190, _30
@ SpellSystem.c:37: 					*currBuffer = ROMList[i].spell;
	ldrb	r2, [r3, #1]	@ _32,
@ SpellSystem.c:37: 					*currBuffer = ROMList[i].spell;
	ldr	r3, [r7, #32]	@ tmp191, currBuffer
	strb	r2, [r3]	@ tmp192, *currBuffer_41
@ SpellSystem.c:38: 					currBuffer++;
	ldr	r3, [r7, #32]	@ tmp194, currBuffer
	adds	r3, r3, #1	@ tmp193,
	str	r3, [r7, #32]	@ tmp193, currBuffer
.L76:
@ SpellSystem.c:30: 		for ( int i = 0 ; ROMList[i].level ; i++ )
	ldr	r3, [r7, #24]	@ tmp196, i
	adds	r3, r3, #1	@ tmp195,
	str	r3, [r7, #24]	@ tmp195, i
.L73:
@ SpellSystem.c:30: 		for ( int i = 0 ; ROMList[i].level ; i++ )
	ldr	r3, [r7, #24]	@ i.31_33, i
	lsls	r3, r3, #1	@ _34, i.31_33,
	ldr	r2, [r7, #20]	@ tmp197, ROMList
	adds	r3, r2, r3	@ _35, tmp197, _34
@ SpellSystem.c:30: 		for ( int i = 0 ; ROMList[i].level ; i++ )
	ldrb	r3, [r3]	@ _36, *_35
@ SpellSystem.c:30: 		for ( int i = 0 ; ROMList[i].level ; i++ )
	cmp	r3, #0	@ _36,
	bne	.L78		@,
.L72:
@ SpellSystem.c:44: 	*currBuffer = 0;
	ldr	r3, [r7, #32]	@ tmp198, currBuffer
	movs	r2, #0	@ tmp199,
	strb	r2, [r3]	@ tmp200, *currBuffer_42
@ SpellSystem.c:45: 	return SpellsBuffer;
	ldr	r3, .L82	@ _66,
@ SpellSystem.c:46: }
	movs	r0, r3	@, <retval>
	mov	sp, r7	@,
	add	sp, sp, #40	@,,
	@ sp needed	@
	pop	{r7}
	pop	{r1}
	bx	r1
.L83:
	.align	2
.L82:
	.word	SpellsBuffer
	.word	SpellListTable
	.size	SpellsGetterForLevel, .-SpellsGetterForLevel
	.align	1
	.global	NewGetUnitEquippedWeapon
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	NewGetUnitEquippedWeapon, %function
NewGetUnitEquippedWeapon:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}	@
	sub	sp, sp, #16	@,,
	add	r7, sp, #0	@,,
	str	r0, [r7, #4]	@ unit, unit
@ SpellSystem.c:135: 	int vanillaEquipped = GetVanillaEquipped(unit);
	ldr	r3, [r7, #4]	@ tmp143, unit
	movs	r0, r3	@, tmp143
	bl	GetVanillaEquipped		@
	movs	r3, r0	@ tmp144,
	str	r3, [r7, #12]	@ tmp144, vanillaEquipped
@ SpellSystem.c:140: 	int spell = GetFirstAttackSpell(unit);
	ldr	r3, [r7, #4]	@ tmp145, unit
	movs	r0, r3	@, tmp145
	bl	GetFirstAttackSpell		@
	movs	r3, r0	@ tmp146,
	str	r3, [r7, #8]	@ tmp146, spell
@ SpellSystem.c:143: 	if ( gChapterData.currentPhase == ( unit->index & 0xC0 ) )
	ldr	r3, .L98	@ tmp147,
	ldrb	r3, [r3, #15]	@ _1,
	movs	r2, r3	@ _2, _1
@ SpellSystem.c:143: 	if ( gChapterData.currentPhase == ( unit->index & 0xC0 ) )
	ldr	r3, [r7, #4]	@ tmp148, unit
	ldrb	r3, [r3, #11]	@ _3,
	lsls	r3, r3, #24	@ _3, _3,
	asrs	r3, r3, #24	@ _3, _3,
	movs	r1, r3	@ _4, _3
@ SpellSystem.c:143: 	if ( gChapterData.currentPhase == ( unit->index & 0xC0 ) )
	movs	r3, #192	@ tmp149,
	ands	r3, r1	@ _5, _4
@ SpellSystem.c:143: 	if ( gChapterData.currentPhase == ( unit->index & 0xC0 ) )
	cmp	r2, r3	@ _2, _5
	bne	.L85		@,
@ SpellSystem.c:147: 		if ( !UsingSpellMenu && ( unit->index & 0xC0 ) ) { return vanillaEquipped; } // enemies wielding their vanilla wep 		
	ldr	r3, .L98+4	@ tmp150,
	ldrb	r3, [r3]	@ UsingSpellMenu.32_6, UsingSpellMenu
@ SpellSystem.c:147: 		if ( !UsingSpellMenu && ( unit->index & 0xC0 ) ) { return vanillaEquipped; } // enemies wielding their vanilla wep 		
	cmp	r3, #0	@ UsingSpellMenu.32_6,
	bne	.L86		@,
@ SpellSystem.c:147: 		if ( !UsingSpellMenu && ( unit->index & 0xC0 ) ) { return vanillaEquipped; } // enemies wielding their vanilla wep 		
	ldr	r3, [r7, #4]	@ tmp151, unit
	ldrb	r3, [r3, #11]	@ _7,
	lsls	r3, r3, #24	@ _7, _7,
	asrs	r3, r3, #24	@ _7, _7,
	movs	r2, r3	@ _8, _7
@ SpellSystem.c:147: 		if ( !UsingSpellMenu && ( unit->index & 0xC0 ) ) { return vanillaEquipped; } // enemies wielding their vanilla wep 		
	movs	r3, #192	@ tmp152,
	ands	r3, r2	@ _9, _8
@ SpellSystem.c:147: 		if ( !UsingSpellMenu && ( unit->index & 0xC0 ) ) { return vanillaEquipped; } // enemies wielding their vanilla wep 		
	beq	.L86		@,
@ SpellSystem.c:147: 		if ( !UsingSpellMenu && ( unit->index & 0xC0 ) ) { return vanillaEquipped; } // enemies wielding their vanilla wep 		
	ldr	r3, [r7, #12]	@ iftmp.34_30, vanillaEquipped
	b	.L87		@
.L86:
@ SpellSystem.c:148: 		if ( !UsingSpellMenu && !( unit->index & 0xC0 ) ) { return ( spell ? spell|0xFF00 : 0 ); } // for mmb - show first spell 
	ldr	r3, .L98+4	@ tmp153,
	ldrb	r3, [r3]	@ UsingSpellMenu.33_10, UsingSpellMenu
@ SpellSystem.c:148: 		if ( !UsingSpellMenu && !( unit->index & 0xC0 ) ) { return ( spell ? spell|0xFF00 : 0 ); } // for mmb - show first spell 
	cmp	r3, #0	@ UsingSpellMenu.33_10,
	bne	.L88		@,
@ SpellSystem.c:148: 		if ( !UsingSpellMenu && !( unit->index & 0xC0 ) ) { return ( spell ? spell|0xFF00 : 0 ); } // for mmb - show first spell 
	ldr	r3, [r7, #4]	@ tmp154, unit
	ldrb	r3, [r3, #11]	@ _11,
	lsls	r3, r3, #24	@ _11, _11,
	asrs	r3, r3, #24	@ _11, _11,
	movs	r2, r3	@ _12, _11
@ SpellSystem.c:148: 		if ( !UsingSpellMenu && !( unit->index & 0xC0 ) ) { return ( spell ? spell|0xFF00 : 0 ); } // for mmb - show first spell 
	movs	r3, #192	@ tmp155,
	ands	r3, r2	@ _13, _12
@ SpellSystem.c:148: 		if ( !UsingSpellMenu && !( unit->index & 0xC0 ) ) { return ( spell ? spell|0xFF00 : 0 ); } // for mmb - show first spell 
	bne	.L88		@,
@ SpellSystem.c:148: 		if ( !UsingSpellMenu && !( unit->index & 0xC0 ) ) { return ( spell ? spell|0xFF00 : 0 ); } // for mmb - show first spell 
	ldr	r3, [r7, #8]	@ tmp156, spell
	cmp	r3, #0	@ tmp156,
	beq	.L89		@,
@ SpellSystem.c:148: 		if ( !UsingSpellMenu && !( unit->index & 0xC0 ) ) { return ( spell ? spell|0xFF00 : 0 ); } // for mmb - show first spell 
	ldr	r3, [r7, #8]	@ tmp157, spell
	movs	r2, #255	@ tmp181,
	lsls	r2, r2, #8	@ tmp158, tmp181,
	orrs	r3, r2	@ iftmp.34_30, tmp158
	b	.L87		@
.L89:
@ SpellSystem.c:148: 		if ( !UsingSpellMenu && !( unit->index & 0xC0 ) ) { return ( spell ? spell|0xFF00 : 0 ); } // for mmb - show first spell 
	movs	r3, #0	@ iftmp.34_30,
	b	.L87		@
.L88:
@ SpellSystem.c:153: 			if ( unit->index == gBattleTarget.unit.index && GetItemType(SelectedSpell) == ITYPE_STAFF )
	ldr	r3, [r7, #4]	@ tmp159, unit
	movs	r2, #11	@ _14,
	ldrsb	r2, [r3, r2]	@ _14,* _14
@ SpellSystem.c:153: 			if ( unit->index == gBattleTarget.unit.index && GetItemType(SelectedSpell) == ITYPE_STAFF )
	ldr	r3, .L98+8	@ tmp160,
	ldrb	r3, [r3, #11]	@ _15,
	lsls	r3, r3, #24	@ _15, _15,
	asrs	r3, r3, #24	@ _15, _15,
@ SpellSystem.c:153: 			if ( unit->index == gBattleTarget.unit.index && GetItemType(SelectedSpell) == ITYPE_STAFF )
	cmp	r2, r3	@ _14, _15
	bne	.L91		@,
@ SpellSystem.c:153: 			if ( unit->index == gBattleTarget.unit.index && GetItemType(SelectedSpell) == ITYPE_STAFF )
	ldr	r3, .L98+12	@ tmp161,
	ldrb	r3, [r3]	@ SelectedSpell.35_16, SelectedSpell
	movs	r0, r3	@, _17
	ldr	r3, .L98+16	@ tmp162,
	bl	.L12		@
	movs	r3, r0	@ _18,
@ SpellSystem.c:153: 			if ( unit->index == gBattleTarget.unit.index && GetItemType(SelectedSpell) == ITYPE_STAFF )
	cmp	r3, #4	@ _18,
	bne	.L91		@,
@ SpellSystem.c:155: 				return vanillaEquipped;
	ldr	r3, [r7, #12]	@ iftmp.34_30, vanillaEquipped
	b	.L87		@
.L91:
@ SpellSystem.c:184: 				return SelectedSpell|0xFF00; 
	ldr	r3, .L98+12	@ tmp163,
	ldrb	r3, [r3]	@ SelectedSpell.36_19, SelectedSpell
	movs	r2, r3	@ _20, SelectedSpell.36_19
	movs	r3, #255	@ tmp180,
	lsls	r3, r3, #8	@ tmp164, tmp180,
	orrs	r3, r2	@ iftmp.34_30, _20
	b	.L87		@
.L85:
@ SpellSystem.c:202: 		if ( !UsingSpellMenu && ( unit->index & 0xC0 ) ) { return vanillaEquipped; } // mmb - enemies wielding their vanilla wep 		
	ldr	r3, .L98+4	@ tmp165,
	ldrb	r3, [r3]	@ UsingSpellMenu.37_21, UsingSpellMenu
@ SpellSystem.c:202: 		if ( !UsingSpellMenu && ( unit->index & 0xC0 ) ) { return vanillaEquipped; } // mmb - enemies wielding their vanilla wep 		
	cmp	r3, #0	@ UsingSpellMenu.37_21,
	bne	.L92		@,
@ SpellSystem.c:202: 		if ( !UsingSpellMenu && ( unit->index & 0xC0 ) ) { return vanillaEquipped; } // mmb - enemies wielding their vanilla wep 		
	ldr	r3, [r7, #4]	@ tmp166, unit
	ldrb	r3, [r3, #11]	@ _22,
	lsls	r3, r3, #24	@ _22, _22,
	asrs	r3, r3, #24	@ _22, _22,
	movs	r2, r3	@ _23, _22
@ SpellSystem.c:202: 		if ( !UsingSpellMenu && ( unit->index & 0xC0 ) ) { return vanillaEquipped; } // mmb - enemies wielding their vanilla wep 		
	movs	r3, #192	@ tmp167,
	ands	r3, r2	@ _24, _23
@ SpellSystem.c:202: 		if ( !UsingSpellMenu && ( unit->index & 0xC0 ) ) { return vanillaEquipped; } // mmb - enemies wielding their vanilla wep 		
	beq	.L92		@,
@ SpellSystem.c:202: 		if ( !UsingSpellMenu && ( unit->index & 0xC0 ) ) { return vanillaEquipped; } // mmb - enemies wielding their vanilla wep 		
	ldr	r3, [r7, #12]	@ iftmp.34_30, vanillaEquipped
	b	.L87		@
.L92:
@ SpellSystem.c:203: 		if ( !UsingSpellMenu && !( unit->index & 0xC0 ) ) { return ( spell ? spell|0xFF00 : 0 ); } // for mmb - show first spell 
	ldr	r3, .L98+4	@ tmp168,
	ldrb	r3, [r3]	@ UsingSpellMenu.38_25, UsingSpellMenu
@ SpellSystem.c:203: 		if ( !UsingSpellMenu && !( unit->index & 0xC0 ) ) { return ( spell ? spell|0xFF00 : 0 ); } // for mmb - show first spell 
	cmp	r3, #0	@ UsingSpellMenu.38_25,
	bne	.L93		@,
@ SpellSystem.c:203: 		if ( !UsingSpellMenu && !( unit->index & 0xC0 ) ) { return ( spell ? spell|0xFF00 : 0 ); } // for mmb - show first spell 
	ldr	r3, [r7, #4]	@ tmp169, unit
	ldrb	r3, [r3, #11]	@ _26,
	lsls	r3, r3, #24	@ _26, _26,
	asrs	r3, r3, #24	@ _26, _26,
	movs	r2, r3	@ _27, _26
@ SpellSystem.c:203: 		if ( !UsingSpellMenu && !( unit->index & 0xC0 ) ) { return ( spell ? spell|0xFF00 : 0 ); } // for mmb - show first spell 
	movs	r3, #192	@ tmp170,
	ands	r3, r2	@ _28, _27
@ SpellSystem.c:203: 		if ( !UsingSpellMenu && !( unit->index & 0xC0 ) ) { return ( spell ? spell|0xFF00 : 0 ); } // for mmb - show first spell 
	bne	.L93		@,
@ SpellSystem.c:203: 		if ( !UsingSpellMenu && !( unit->index & 0xC0 ) ) { return ( spell ? spell|0xFF00 : 0 ); } // for mmb - show first spell 
	ldr	r3, [r7, #8]	@ tmp171, spell
	cmp	r3, #0	@ tmp171,
	beq	.L94		@,
@ SpellSystem.c:203: 		if ( !UsingSpellMenu && !( unit->index & 0xC0 ) ) { return ( spell ? spell|0xFF00 : 0 ); } // for mmb - show first spell 
	ldr	r3, [r7, #8]	@ tmp172, spell
	movs	r2, #255	@ tmp179,
	lsls	r2, r2, #8	@ tmp173, tmp179,
	orrs	r3, r2	@ iftmp.34_30, tmp173
	b	.L87		@
.L94:
@ SpellSystem.c:203: 		if ( !UsingSpellMenu && !( unit->index & 0xC0 ) ) { return ( spell ? spell|0xFF00 : 0 ); } // for mmb - show first spell 
	movs	r3, #0	@ iftmp.34_30,
	b	.L87		@
.L93:
@ SpellSystem.c:205: 		return ( spell ? spell|0xFF00 : 0 );
	ldr	r3, [r7, #8]	@ tmp174, spell
	cmp	r3, #0	@ tmp174,
	beq	.L96		@,
@ SpellSystem.c:205: 		return ( spell ? spell|0xFF00 : 0 );
	ldr	r3, [r7, #8]	@ tmp175, spell
	movs	r2, #255	@ tmp178,
	lsls	r2, r2, #8	@ tmp176, tmp178,
	orrs	r3, r2	@ iftmp.34_30, tmp176
	b	.L87		@
.L96:
@ SpellSystem.c:205: 		return ( spell ? spell|0xFF00 : 0 );
	movs	r3, #0	@ iftmp.34_30,
.L87:
@ SpellSystem.c:208: }
	movs	r0, r3	@, <retval>
	mov	sp, r7	@,
	add	sp, sp, #16	@,,
	@ sp needed	@
	pop	{r7}
	pop	{r1}
	bx	r1
.L99:
	.align	2
.L98:
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
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}	@
	sub	sp, sp, #24	@,,
	add	r7, sp, #0	@,,
	str	r0, [r7, #4]	@ unit, unit
@ SpellSystem.c:226: 	int spell = GetFirstAttackSpell(unit);
	ldr	r3, [r7, #4]	@ tmp150, unit
	movs	r0, r3	@, tmp150
	bl	GetFirstAttackSpell		@
	movs	r3, r0	@ tmp151,
	str	r3, [r7, #12]	@ tmp151, spell
@ SpellSystem.c:229: 	if ( !(UsingSpellMenu) && unit->index != gBattleTarget.unit.index && (gBattleStats.config & (BATTLE_CONFIG_REAL|BATTLE_CONFIG_SIMULATE)) ) { 
	ldr	r3, .L120	@ tmp152,
	ldrb	r3, [r3]	@ UsingSpellMenu.41_1, UsingSpellMenu
@ SpellSystem.c:229: 	if ( !(UsingSpellMenu) && unit->index != gBattleTarget.unit.index && (gBattleStats.config & (BATTLE_CONFIG_REAL|BATTLE_CONFIG_SIMULATE)) ) { 
	cmp	r3, #0	@ UsingSpellMenu.41_1,
	bne	.L101		@,
@ SpellSystem.c:229: 	if ( !(UsingSpellMenu) && unit->index != gBattleTarget.unit.index && (gBattleStats.config & (BATTLE_CONFIG_REAL|BATTLE_CONFIG_SIMULATE)) ) { 
	ldr	r3, [r7, #4]	@ tmp153, unit
	movs	r2, #11	@ _2,
	ldrsb	r2, [r3, r2]	@ _2,* _2
@ SpellSystem.c:229: 	if ( !(UsingSpellMenu) && unit->index != gBattleTarget.unit.index && (gBattleStats.config & (BATTLE_CONFIG_REAL|BATTLE_CONFIG_SIMULATE)) ) { 
	ldr	r3, .L120+4	@ tmp154,
	ldrb	r3, [r3, #11]	@ _3,
	lsls	r3, r3, #24	@ _3, _3,
	asrs	r3, r3, #24	@ _3, _3,
@ SpellSystem.c:229: 	if ( !(UsingSpellMenu) && unit->index != gBattleTarget.unit.index && (gBattleStats.config & (BATTLE_CONFIG_REAL|BATTLE_CONFIG_SIMULATE)) ) { 
	cmp	r2, r3	@ _2, _3
	beq	.L101		@,
@ SpellSystem.c:229: 	if ( !(UsingSpellMenu) && unit->index != gBattleTarget.unit.index && (gBattleStats.config & (BATTLE_CONFIG_REAL|BATTLE_CONFIG_SIMULATE)) ) { 
	ldr	r3, .L120+8	@ tmp155,
	ldrh	r3, [r3]	@ _4, gBattleStats
@ SpellSystem.c:229: 	if ( !(UsingSpellMenu) && unit->index != gBattleTarget.unit.index && (gBattleStats.config & (BATTLE_CONFIG_REAL|BATTLE_CONFIG_SIMULATE)) ) { 
	movs	r2, r3	@ _5, _4
	movs	r3, #3	@ tmp156,
	ands	r3, r2	@ _6, _5
@ SpellSystem.c:229: 	if ( !(UsingSpellMenu) && unit->index != gBattleTarget.unit.index && (gBattleStats.config & (BATTLE_CONFIG_REAL|BATTLE_CONFIG_SIMULATE)) ) { 
	beq	.L101		@,
@ SpellSystem.c:230: 		for ( int i = 0 ; i < 5 ; i++ )
	movs	r3, #0	@ tmp157,
	str	r3, [r7, #20]	@ tmp157, i
@ SpellSystem.c:230: 		for ( int i = 0 ; i < 5 ; i++ )
	b	.L102		@
.L107:
@ SpellSystem.c:233: 			if ( CanUnitUseWeapon(unit,unit->items[i]) )
	ldr	r2, [r7, #4]	@ tmp158, unit
	ldr	r3, [r7, #20]	@ tmp160, i
	adds	r3, r3, #12	@ tmp159,
	lsls	r3, r3, #1	@ tmp161, tmp159,
	adds	r3, r2, r3	@ tmp162, tmp158, tmp161
	adds	r3, r3, #6	@ tmp163,
	ldrh	r3, [r3]	@ _7, *unit_48(D)
@ SpellSystem.c:233: 			if ( CanUnitUseWeapon(unit,unit->items[i]) )
	movs	r2, r3	@ _8, _7
	ldr	r3, [r7, #4]	@ tmp164, unit
	movs	r1, r2	@, _8
	movs	r0, r3	@, tmp164
	ldr	r3, .L120+12	@ tmp165,
	bl	.L12		@
	subs	r3, r0, #0	@ _9,,
@ SpellSystem.c:233: 			if ( CanUnitUseWeapon(unit,unit->items[i]) )
	beq	.L119		@,
@ SpellSystem.c:236: 				if ( gCan_Attack_Target(unit->items[i],gBattleStats.range,unit) ) { return i; }
	ldr	r3, .L120+16	@ tmp166,
	ldr	r3, [r3]	@ gCan_Attack_Target.42_10, gCan_Attack_Target
@ SpellSystem.c:236: 				if ( gCan_Attack_Target(unit->items[i],gBattleStats.range,unit) ) { return i; }
	ldr	r1, [r7, #4]	@ tmp167, unit
	ldr	r2, [r7, #20]	@ tmp169, i
	adds	r2, r2, #12	@ tmp168,
	lsls	r2, r2, #1	@ tmp170, tmp168,
	adds	r2, r1, r2	@ tmp171, tmp167, tmp170
	adds	r2, r2, #6	@ tmp172,
	ldrh	r2, [r2]	@ _11, *unit_48(D)
@ SpellSystem.c:236: 				if ( gCan_Attack_Target(unit->items[i],gBattleStats.range,unit) ) { return i; }
	movs	r0, r2	@ _12, _11
@ SpellSystem.c:236: 				if ( gCan_Attack_Target(unit->items[i],gBattleStats.range,unit) ) { return i; }
	ldr	r2, .L120+8	@ tmp173,
	ldrb	r2, [r2, #2]	@ _13,
@ SpellSystem.c:236: 				if ( gCan_Attack_Target(unit->items[i],gBattleStats.range,unit) ) { return i; }
	movs	r1, r2	@ _14, _13
	ldr	r2, [r7, #4]	@ tmp174, unit
	bl	.L12		@
	subs	r3, r0, #0	@ _15,,
@ SpellSystem.c:236: 				if ( gCan_Attack_Target(unit->items[i],gBattleStats.range,unit) ) { return i; }
	beq	.L104		@,
@ SpellSystem.c:236: 				if ( gCan_Attack_Target(unit->items[i],gBattleStats.range,unit) ) { return i; }
	ldr	r3, [r7, #20]	@ _38, i
	b	.L105		@
.L104:
@ SpellSystem.c:230: 		for ( int i = 0 ; i < 5 ; i++ )
	ldr	r3, [r7, #20]	@ tmp176, i
	adds	r3, r3, #1	@ tmp175,
	str	r3, [r7, #20]	@ tmp175, i
.L102:
@ SpellSystem.c:230: 		for ( int i = 0 ; i < 5 ; i++ )
	ldr	r3, [r7, #20]	@ tmp177, i
	cmp	r3, #4	@ tmp177,
	ble	.L107		@,
	b	.L106		@
.L119:
@ SpellSystem.c:238: 			else { break; } 
	nop	
.L106:
@ SpellSystem.c:240: 		return -1; 
	movs	r3, #1	@ tmp212,
	rsbs	r3, r3, #0	@ _38, tmp212
	b	.L105		@
.L101:
@ SpellSystem.c:246: 	if ( UsingSpellMenu && CanUnitUseWeapon(unit,SelectedSpell) && !(unit->index & 0xC0) ) { 
	ldr	r3, .L120	@ tmp178,
	ldrb	r3, [r3]	@ UsingSpellMenu.43_16, UsingSpellMenu
@ SpellSystem.c:246: 	if ( UsingSpellMenu && CanUnitUseWeapon(unit,SelectedSpell) && !(unit->index & 0xC0) ) { 
	cmp	r3, #0	@ UsingSpellMenu.43_16,
	beq	.L108		@,
@ SpellSystem.c:246: 	if ( UsingSpellMenu && CanUnitUseWeapon(unit,SelectedSpell) && !(unit->index & 0xC0) ) { 
	ldr	r3, .L120+20	@ tmp179,
	ldrb	r3, [r3]	@ SelectedSpell.44_17, SelectedSpell
	movs	r2, r3	@ _18, SelectedSpell.44_17
	ldr	r3, [r7, #4]	@ tmp180, unit
	movs	r1, r2	@, _18
	movs	r0, r3	@, tmp180
	ldr	r3, .L120+12	@ tmp181,
	bl	.L12		@
	subs	r3, r0, #0	@ _19,,
@ SpellSystem.c:246: 	if ( UsingSpellMenu && CanUnitUseWeapon(unit,SelectedSpell) && !(unit->index & 0xC0) ) { 
	beq	.L108		@,
@ SpellSystem.c:246: 	if ( UsingSpellMenu && CanUnitUseWeapon(unit,SelectedSpell) && !(unit->index & 0xC0) ) { 
	ldr	r3, [r7, #4]	@ tmp182, unit
	ldrb	r3, [r3, #11]	@ _20,
	lsls	r3, r3, #24	@ _20, _20,
	asrs	r3, r3, #24	@ _20, _20,
	movs	r2, r3	@ _21, _20
@ SpellSystem.c:246: 	if ( UsingSpellMenu && CanUnitUseWeapon(unit,SelectedSpell) && !(unit->index & 0xC0) ) { 
	movs	r3, #192	@ tmp183,
	ands	r3, r2	@ _22, _21
@ SpellSystem.c:246: 	if ( UsingSpellMenu && CanUnitUseWeapon(unit,SelectedSpell) && !(unit->index & 0xC0) ) { 
	bne	.L108		@,
@ SpellSystem.c:248: 		return 9;
	movs	r3, #9	@ _38,
	b	.L105		@
.L108:
@ SpellSystem.c:256: 	if ( unit->index & 0xC0 ) {
	ldr	r3, [r7, #4]	@ tmp184, unit
	ldrb	r3, [r3, #11]	@ _23,
	lsls	r3, r3, #24	@ _23, _23,
	asrs	r3, r3, #24	@ _23, _23,
	movs	r2, r3	@ _24, _23
@ SpellSystem.c:256: 	if ( unit->index & 0xC0 ) {
	movs	r3, #192	@ tmp185,
	ands	r3, r2	@ _25, _24
@ SpellSystem.c:256: 	if ( unit->index & 0xC0 ) {
	beq	.L109		@,
@ SpellSystem.c:257: 		for ( int i = 0 ; i < 5 ; i++ )
	movs	r3, #0	@ tmp186,
	str	r3, [r7, #16]	@ tmp186, i
@ SpellSystem.c:257: 		for ( int i = 0 ; i < 5 ; i++ )
	b	.L110		@
.L112:
@ SpellSystem.c:259: 				if ( CanUnitUseWeapon(unit,unit->items[i]) ) { return i; }
	ldr	r2, [r7, #4]	@ tmp187, unit
	ldr	r3, [r7, #16]	@ tmp189, i
	adds	r3, r3, #12	@ tmp188,
	lsls	r3, r3, #1	@ tmp190, tmp188,
	adds	r3, r2, r3	@ tmp191, tmp187, tmp190
	adds	r3, r3, #6	@ tmp192,
	ldrh	r3, [r3]	@ _26, *unit_48(D)
@ SpellSystem.c:259: 				if ( CanUnitUseWeapon(unit,unit->items[i]) ) { return i; }
	movs	r2, r3	@ _27, _26
	ldr	r3, [r7, #4]	@ tmp193, unit
	movs	r1, r2	@, _27
	movs	r0, r3	@, tmp193
	ldr	r3, .L120+12	@ tmp194,
	bl	.L12		@
	subs	r3, r0, #0	@ _28,,
@ SpellSystem.c:259: 				if ( CanUnitUseWeapon(unit,unit->items[i]) ) { return i; }
	beq	.L111		@,
@ SpellSystem.c:259: 				if ( CanUnitUseWeapon(unit,unit->items[i]) ) { return i; }
	ldr	r3, [r7, #16]	@ _38, i
	b	.L105		@
.L111:
@ SpellSystem.c:257: 		for ( int i = 0 ; i < 5 ; i++ )
	ldr	r3, [r7, #16]	@ tmp196, i
	adds	r3, r3, #1	@ tmp195,
	str	r3, [r7, #16]	@ tmp195, i
.L110:
@ SpellSystem.c:257: 		for ( int i = 0 ; i < 5 ; i++ )
	ldr	r3, [r7, #16]	@ tmp197, i
	cmp	r3, #4	@ tmp197,
	ble	.L112		@,
@ SpellSystem.c:261: 		return -1;
	movs	r3, #1	@ tmp211,
	rsbs	r3, r3, #0	@ _38, tmp211
	b	.L105		@
.L109:
@ SpellSystem.c:268: 	if ( gChapterData.currentPhase != ( unit->index & 0xC0 ) && ( CanUnitUseWeapon( unit, spell ) ) ) { return ( spell ? 9 : 0 ); } // Enemy phase - Always counter attack with first spell.
	ldr	r3, .L120+24	@ tmp198,
	ldrb	r3, [r3, #15]	@ _29,
	movs	r2, r3	@ _30, _29
@ SpellSystem.c:268: 	if ( gChapterData.currentPhase != ( unit->index & 0xC0 ) && ( CanUnitUseWeapon( unit, spell ) ) ) { return ( spell ? 9 : 0 ); } // Enemy phase - Always counter attack with first spell.
	ldr	r3, [r7, #4]	@ tmp199, unit
	ldrb	r3, [r3, #11]	@ _31,
	lsls	r3, r3, #24	@ _31, _31,
	asrs	r3, r3, #24	@ _31, _31,
	movs	r1, r3	@ _32, _31
@ SpellSystem.c:268: 	if ( gChapterData.currentPhase != ( unit->index & 0xC0 ) && ( CanUnitUseWeapon( unit, spell ) ) ) { return ( spell ? 9 : 0 ); } // Enemy phase - Always counter attack with first spell.
	movs	r3, #192	@ tmp200,
	ands	r3, r1	@ _33, _32
@ SpellSystem.c:268: 	if ( gChapterData.currentPhase != ( unit->index & 0xC0 ) && ( CanUnitUseWeapon( unit, spell ) ) ) { return ( spell ? 9 : 0 ); } // Enemy phase - Always counter attack with first spell.
	cmp	r2, r3	@ _30, _33
	beq	.L113		@,
@ SpellSystem.c:268: 	if ( gChapterData.currentPhase != ( unit->index & 0xC0 ) && ( CanUnitUseWeapon( unit, spell ) ) ) { return ( spell ? 9 : 0 ); } // Enemy phase - Always counter attack with first spell.
	ldr	r2, [r7, #12]	@ tmp201, spell
	ldr	r3, [r7, #4]	@ tmp202, unit
	movs	r1, r2	@, tmp201
	movs	r0, r3	@, tmp202
	ldr	r3, .L120+12	@ tmp203,
	bl	.L12		@
	subs	r3, r0, #0	@ _34,,
@ SpellSystem.c:268: 	if ( gChapterData.currentPhase != ( unit->index & 0xC0 ) && ( CanUnitUseWeapon( unit, spell ) ) ) { return ( spell ? 9 : 0 ); } // Enemy phase - Always counter attack with first spell.
	beq	.L113		@,
@ SpellSystem.c:268: 	if ( gChapterData.currentPhase != ( unit->index & 0xC0 ) && ( CanUnitUseWeapon( unit, spell ) ) ) { return ( spell ? 9 : 0 ); } // Enemy phase - Always counter attack with first spell.
	ldr	r3, [r7, #12]	@ tmp204, spell
	cmp	r3, #0	@ tmp204,
	beq	.L114		@,
@ SpellSystem.c:268: 	if ( gChapterData.currentPhase != ( unit->index & 0xC0 ) && ( CanUnitUseWeapon( unit, spell ) ) ) { return ( spell ? 9 : 0 ); } // Enemy phase - Always counter attack with first spell.
	movs	r3, #9	@ _38,
	b	.L105		@
.L114:
@ SpellSystem.c:268: 	if ( gChapterData.currentPhase != ( unit->index & 0xC0 ) && ( CanUnitUseWeapon( unit, spell ) ) ) { return ( spell ? 9 : 0 ); } // Enemy phase - Always counter attack with first spell.
	movs	r3, #0	@ _38,
	b	.L105		@
.L113:
@ SpellSystem.c:275: 	if ( CanUnitUseWeapon( unit, spell ) ) { return ( spell ? 9 : 0 ); } // Used in stat screen by players. 
	ldr	r2, [r7, #12]	@ tmp205, spell
	ldr	r3, [r7, #4]	@ tmp206, unit
	movs	r1, r2	@, tmp205
	movs	r0, r3	@, tmp206
	ldr	r3, .L120+12	@ tmp207,
	bl	.L12		@
	subs	r3, r0, #0	@ _35,,
@ SpellSystem.c:275: 	if ( CanUnitUseWeapon( unit, spell ) ) { return ( spell ? 9 : 0 ); } // Used in stat screen by players. 
	beq	.L116		@,
@ SpellSystem.c:275: 	if ( CanUnitUseWeapon( unit, spell ) ) { return ( spell ? 9 : 0 ); } // Used in stat screen by players. 
	ldr	r3, [r7, #12]	@ tmp208, spell
	cmp	r3, #0	@ tmp208,
	beq	.L117		@,
@ SpellSystem.c:275: 	if ( CanUnitUseWeapon( unit, spell ) ) { return ( spell ? 9 : 0 ); } // Used in stat screen by players. 
	movs	r3, #9	@ _38,
	b	.L105		@
.L117:
@ SpellSystem.c:275: 	if ( CanUnitUseWeapon( unit, spell ) ) { return ( spell ? 9 : 0 ); } // Used in stat screen by players. 
	movs	r3, #0	@ _38,
	b	.L105		@
.L116:
@ SpellSystem.c:356: 	return -1;
	movs	r3, #1	@ tmp210,
	rsbs	r3, r3, #0	@ _38, tmp210
.L105:
@ SpellSystem.c:357: }
	movs	r0, r3	@, <retval>
	mov	sp, r7	@,
	add	sp, sp, #24	@,,
	@ sp needed	@
	pop	{r7}
	pop	{r1}
	bx	r1
.L121:
	.align	2
.L120:
	.word	UsingSpellMenu
	.word	gBattleTarget
	.word	gBattleStats
	.word	CanUnitUseWeapon
	.word	gCan_Attack_Target
	.word	SelectedSpell
	.word	gChapterData
	.size	NewGetUnitEquippedWeaponSlot, .-NewGetUnitEquippedWeaponSlot
	.align	1
	.global	NewGetUnitUseFlags
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	NewGetUnitUseFlags, %function
NewGetUnitUseFlags:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 32
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}	@
	sub	sp, sp, #32	@,,
	add	r7, sp, #0	@,,
	str	r0, [r7, #4]	@ unit, unit
@ SpellSystem.c:364: 	u32 ret = 0;
	movs	r3, #0	@ tmp145,
	str	r3, [r7, #28]	@ tmp145, ret
@ SpellSystem.c:365: 	for ( int i = 0 ; i < 5 && unit->items[i] ; i++ )
	movs	r3, #0	@ tmp146,
	str	r3, [r7, #24]	@ tmp146, i
@ SpellSystem.c:365: 	for ( int i = 0 ; i < 5 && unit->items[i] ; i++ )
	b	.L123		@
.L127:
@ SpellSystem.c:367: 		u32 attributes = GetItemAttributes(unit->items[i]);
	ldr	r2, [r7, #4]	@ tmp147, unit
	ldr	r3, [r7, #24]	@ tmp149, i
	adds	r3, r3, #12	@ tmp148,
	lsls	r3, r3, #1	@ tmp150, tmp148,
	adds	r3, r2, r3	@ tmp151, tmp147, tmp150
	adds	r3, r3, #6	@ tmp152,
	ldrh	r3, [r3]	@ _1, *unit_44(D)
@ SpellSystem.c:367: 		u32 attributes = GetItemAttributes(unit->items[i]);
	movs	r0, r3	@, _2
	ldr	r3, .L133	@ tmp153,
	bl	.L12		@
	movs	r3, r0	@ tmp154,
	str	r3, [r7, #16]	@ tmp154, attributes
@ SpellSystem.c:368: 		if ( attributes & IA_WEAPON )
	ldr	r3, [r7, #16]	@ tmp155, attributes
	movs	r2, #1	@ tmp156,
	ands	r3, r2	@ _3, tmp156
@ SpellSystem.c:368: 		if ( attributes & IA_WEAPON )
	beq	.L124		@,
@ SpellSystem.c:370: 			if ( CanUnitUseWeaponNow(unit,unit->items[i]) ) { ret |= 1; }
	ldr	r2, [r7, #4]	@ tmp157, unit
	ldr	r3, [r7, #24]	@ tmp159, i
	adds	r3, r3, #12	@ tmp158,
	lsls	r3, r3, #1	@ tmp160, tmp158,
	adds	r3, r2, r3	@ tmp161, tmp157, tmp160
	adds	r3, r3, #6	@ tmp162,
	ldrh	r3, [r3]	@ _4, *unit_44(D)
@ SpellSystem.c:370: 			if ( CanUnitUseWeaponNow(unit,unit->items[i]) ) { ret |= 1; }
	movs	r2, r3	@ _5, _4
	ldr	r3, [r7, #4]	@ tmp163, unit
	movs	r1, r2	@, _5
	movs	r0, r3	@, tmp163
	ldr	r3, .L133+4	@ tmp164,
	bl	.L12		@
	subs	r3, r0, #0	@ _6,,
@ SpellSystem.c:370: 			if ( CanUnitUseWeaponNow(unit,unit->items[i]) ) { ret |= 1; }
	beq	.L125		@,
@ SpellSystem.c:370: 			if ( CanUnitUseWeaponNow(unit,unit->items[i]) ) { ret |= 1; }
	ldr	r3, [r7, #28]	@ tmp166, ret
	movs	r2, #1	@ tmp167,
	orrs	r3, r2	@ tmp165, tmp167
	str	r3, [r7, #28]	@ tmp165, ret
	b	.L125		@
.L124:
@ SpellSystem.c:372: 		else if ( attributes & IA_STAFF )
	ldr	r3, [r7, #16]	@ tmp168, attributes
	movs	r2, #4	@ tmp169,
	ands	r3, r2	@ _7, tmp169
@ SpellSystem.c:372: 		else if ( attributes & IA_STAFF )
	beq	.L125		@,
@ SpellSystem.c:374: 			if ( CanUnitUseStaffNow(unit,unit->items[i]) ) { ret |= 2; }
	ldr	r2, [r7, #4]	@ tmp170, unit
	ldr	r3, [r7, #24]	@ tmp172, i
	adds	r3, r3, #12	@ tmp171,
	lsls	r3, r3, #1	@ tmp173, tmp171,
	adds	r3, r2, r3	@ tmp174, tmp170, tmp173
	adds	r3, r3, #6	@ tmp175,
	ldrh	r3, [r3]	@ _8, *unit_44(D)
@ SpellSystem.c:374: 			if ( CanUnitUseStaffNow(unit,unit->items[i]) ) { ret |= 2; }
	movs	r2, r3	@ _9, _8
	ldr	r3, [r7, #4]	@ tmp176, unit
	movs	r1, r2	@, _9
	movs	r0, r3	@, tmp176
	ldr	r3, .L133+8	@ tmp177,
	bl	.L12		@
	subs	r3, r0, #0	@ _10,,
@ SpellSystem.c:374: 			if ( CanUnitUseStaffNow(unit,unit->items[i]) ) { ret |= 2; }
	beq	.L125		@,
@ SpellSystem.c:374: 			if ( CanUnitUseStaffNow(unit,unit->items[i]) ) { ret |= 2; }
	ldr	r3, [r7, #28]	@ tmp179, ret
	movs	r2, #2	@ tmp180,
	orrs	r3, r2	@ tmp178, tmp180
	str	r3, [r7, #28]	@ tmp178, ret
.L125:
@ SpellSystem.c:365: 	for ( int i = 0 ; i < 5 && unit->items[i] ; i++ )
	ldr	r3, [r7, #24]	@ tmp182, i
	adds	r3, r3, #1	@ tmp181,
	str	r3, [r7, #24]	@ tmp181, i
.L123:
@ SpellSystem.c:365: 	for ( int i = 0 ; i < 5 && unit->items[i] ; i++ )
	ldr	r3, [r7, #24]	@ tmp183, i
	cmp	r3, #4	@ tmp183,
	bgt	.L126		@,
@ SpellSystem.c:365: 	for ( int i = 0 ; i < 5 && unit->items[i] ; i++ )
	ldr	r2, [r7, #4]	@ tmp184, unit
	ldr	r3, [r7, #24]	@ tmp186, i
	adds	r3, r3, #12	@ tmp185,
	lsls	r3, r3, #1	@ tmp187, tmp185,
	adds	r3, r2, r3	@ tmp188, tmp184, tmp187
	adds	r3, r3, #6	@ tmp189,
	ldrh	r3, [r3]	@ _11, *unit_44(D)
@ SpellSystem.c:365: 	for ( int i = 0 ; i < 5 && unit->items[i] ; i++ )
	cmp	r3, #0	@ _11,
	bne	.L127		@,
.L126:
@ SpellSystem.c:378: 	u8* spells = SpellsGetter(unit,-1);
	movs	r3, #1	@ tmp217,
	rsbs	r2, r3, #0	@ tmp190, tmp217
	ldr	r3, [r7, #4]	@ tmp191, unit
	movs	r1, r2	@, tmp190
	movs	r0, r3	@, tmp191
	bl	SpellsGetter		@
	movs	r3, r0	@ tmp192,
	str	r3, [r7, #12]	@ tmp192, spells
@ SpellSystem.c:379: 	for ( int i = 0 ; spells[i] ; i++ )
	movs	r3, #0	@ tmp193,
	str	r3, [r7, #20]	@ tmp193, i
@ SpellSystem.c:379: 	for ( int i = 0 ; spells[i] ; i++ )
	b	.L128		@
.L131:
@ SpellSystem.c:381: 		u32 attributes = GetItemAttributes(spells[i]);
	ldr	r3, [r7, #20]	@ i.47_12, i
	ldr	r2, [r7, #12]	@ tmp194, spells
	adds	r3, r2, r3	@ _13, tmp194, i.47_12
	ldrb	r3, [r3]	@ _14, *_13
@ SpellSystem.c:381: 		u32 attributes = GetItemAttributes(spells[i]);
	movs	r0, r3	@, _15
	ldr	r3, .L133	@ tmp195,
	bl	.L12		@
	movs	r3, r0	@ tmp196,
	str	r3, [r7, #8]	@ tmp196, attributes
@ SpellSystem.c:382: 		if ( attributes & IA_WEAPON )
	ldr	r3, [r7, #8]	@ tmp197, attributes
	movs	r2, #1	@ tmp198,
	ands	r3, r2	@ _16, tmp198
@ SpellSystem.c:382: 		if ( attributes & IA_WEAPON )
	beq	.L129		@,
@ SpellSystem.c:384: 			if ( CanUnitUseWeaponNow(unit,spells[i]) ) { ret |= 1; }
	ldr	r3, [r7, #20]	@ i.48_17, i
	ldr	r2, [r7, #12]	@ tmp199, spells
	adds	r3, r2, r3	@ _18, tmp199, i.48_17
	ldrb	r3, [r3]	@ _19, *_18
@ SpellSystem.c:384: 			if ( CanUnitUseWeaponNow(unit,spells[i]) ) { ret |= 1; }
	movs	r2, r3	@ _20, _19
	ldr	r3, [r7, #4]	@ tmp200, unit
	movs	r1, r2	@, _20
	movs	r0, r3	@, tmp200
	ldr	r3, .L133+4	@ tmp201,
	bl	.L12		@
	subs	r3, r0, #0	@ _21,,
@ SpellSystem.c:384: 			if ( CanUnitUseWeaponNow(unit,spells[i]) ) { ret |= 1; }
	beq	.L130		@,
@ SpellSystem.c:384: 			if ( CanUnitUseWeaponNow(unit,spells[i]) ) { ret |= 1; }
	ldr	r3, [r7, #28]	@ tmp203, ret
	movs	r2, #1	@ tmp204,
	orrs	r3, r2	@ tmp202, tmp204
	str	r3, [r7, #28]	@ tmp202, ret
	b	.L130		@
.L129:
@ SpellSystem.c:386: 		else if ( attributes & IA_STAFF )
	ldr	r3, [r7, #8]	@ tmp205, attributes
	movs	r2, #4	@ tmp206,
	ands	r3, r2	@ _22, tmp206
@ SpellSystem.c:386: 		else if ( attributes & IA_STAFF )
	beq	.L130		@,
@ SpellSystem.c:388: 			if ( CanUnitUseStaffNow(unit,spells[i]) ) { ret |= 2; }
	ldr	r3, [r7, #20]	@ i.49_23, i
	ldr	r2, [r7, #12]	@ tmp207, spells
	adds	r3, r2, r3	@ _24, tmp207, i.49_23
	ldrb	r3, [r3]	@ _25, *_24
@ SpellSystem.c:388: 			if ( CanUnitUseStaffNow(unit,spells[i]) ) { ret |= 2; }
	movs	r2, r3	@ _26, _25
	ldr	r3, [r7, #4]	@ tmp208, unit
	movs	r1, r2	@, _26
	movs	r0, r3	@, tmp208
	ldr	r3, .L133+8	@ tmp209,
	bl	.L12		@
	subs	r3, r0, #0	@ _27,,
@ SpellSystem.c:388: 			if ( CanUnitUseStaffNow(unit,spells[i]) ) { ret |= 2; }
	beq	.L130		@,
@ SpellSystem.c:388: 			if ( CanUnitUseStaffNow(unit,spells[i]) ) { ret |= 2; }
	ldr	r3, [r7, #28]	@ tmp211, ret
	movs	r2, #2	@ tmp212,
	orrs	r3, r2	@ tmp210, tmp212
	str	r3, [r7, #28]	@ tmp210, ret
.L130:
@ SpellSystem.c:379: 	for ( int i = 0 ; spells[i] ; i++ )
	ldr	r3, [r7, #20]	@ tmp214, i
	adds	r3, r3, #1	@ tmp213,
	str	r3, [r7, #20]	@ tmp213, i
.L128:
@ SpellSystem.c:379: 	for ( int i = 0 ; spells[i] ; i++ )
	ldr	r3, [r7, #20]	@ i.50_28, i
	ldr	r2, [r7, #12]	@ tmp215, spells
	adds	r3, r2, r3	@ _29, tmp215, i.50_28
	ldrb	r3, [r3]	@ _30, *_29
@ SpellSystem.c:379: 	for ( int i = 0 ; spells[i] ; i++ )
	cmp	r3, #0	@ _30,
	bne	.L131		@,
@ SpellSystem.c:391: 	return ret;
	ldr	r3, [r7, #28]	@ _55, ret
@ SpellSystem.c:392: }
	movs	r0, r3	@, <retval>
	mov	sp, r7	@,
	add	sp, sp, #32	@,,
	@ sp needed	@
	pop	{r7}
	pop	{r1}
	bx	r1
.L134:
	.align	2
.L133:
	.word	GetItemAttributes
	.word	CanUnitUseWeaponNow
	.word	CanUnitUseStaffNow
	.size	NewGetUnitUseFlags, .-NewGetUnitUseFlags
	.align	1
	.global	Proc_GaidenMagicHPCost
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	Proc_GaidenMagicHPCost, %function
Proc_GaidenMagicHPCost:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}	@
	sub	sp, sp, #16	@,,
	add	r7, sp, #0	@,,
	str	r0, [r7, #12]	@ attacker, attacker
	str	r1, [r7, #8]	@ defender, defender
	str	r2, [r7, #4]	@ buffer, buffer
	str	r3, [r7]	@ battleData, battleData
@ SpellSystem.c:400: 	if ( GetUnitEquippedWeaponSlot(&attacker->unit) == 9 ) // Instead of checking against UsingSpellMenu, we do this to cover the case of defense.
	ldr	r3, [r7, #12]	@ _1, attacker
@ SpellSystem.c:400: 	if ( GetUnitEquippedWeaponSlot(&attacker->unit) == 9 ) // Instead of checking against UsingSpellMenu, we do this to cover the case of defense.
	movs	r0, r3	@, _1
	ldr	r3, .L138	@ tmp115,
	bl	.L12		@
	movs	r3, r0	@ _2,
@ SpellSystem.c:400: 	if ( GetUnitEquippedWeaponSlot(&attacker->unit) == 9 ) // Instead of checking against UsingSpellMenu, we do this to cover the case of defense.
	cmp	r3, #9	@ _2,
	bne	.L137		@,
@ SpellSystem.c:402: 		SetRoundForSpell(attacker,buffer);
	ldr	r2, [r7, #4]	@ tmp116, buffer
	ldr	r3, [r7, #12]	@ tmp117, attacker
	movs	r1, r2	@, tmp116
	movs	r0, r3	@, tmp117
	bl	SetRoundForSpell		@
.L137:
@ SpellSystem.c:404: }
	nop	
	mov	sp, r7	@,
	add	sp, sp, #16	@,,
	@ sp needed	@
	pop	{r7}
	pop	{r0}
	bx	r0
.L139:
	.align	2
.L138:
	.word	GetUnitEquippedWeaponSlot
	.size	Proc_GaidenMagicHPCost, .-Proc_GaidenMagicHPCost
	.align	1
	.global	SetRoundForSpell
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	SetRoundForSpell, %function
SetRoundForSpell:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}	@
	sub	sp, sp, #16	@,,
	add	r7, sp, #0	@,,
	str	r0, [r7, #4]	@ unit, unit
	str	r1, [r7]	@ buffer, buffer
@ SpellSystem.c:408: 	if ( HasSufficientHP(&unit->unit,unit->weapon) )
	ldr	r2, [r7, #4]	@ _1, unit
@ SpellSystem.c:408: 	if ( HasSufficientHP(&unit->unit,unit->weapon) )
	ldr	r3, [r7, #4]	@ tmp133, unit
	movs	r1, #72	@ tmp134,
	ldrh	r3, [r3, r1]	@ _2,
@ SpellSystem.c:408: 	if ( HasSufficientHP(&unit->unit,unit->weapon) )
	movs	r1, r3	@, _3
	movs	r0, r2	@, _1
	bl	HasSufficientHP		@
	subs	r3, r0, #0	@ _4,,
@ SpellSystem.c:408: 	if ( HasSufficientHP(&unit->unit,unit->weapon) )
	beq	.L141		@,
@ SpellSystem.c:410: 		int cost = GetSpellCost(unit->weapon);
	ldr	r3, [r7, #4]	@ tmp135, unit
	movs	r2, #72	@ tmp136,
	ldrh	r3, [r3, r2]	@ _5,
@ SpellSystem.c:410: 		int cost = GetSpellCost(unit->weapon);
	movs	r0, r3	@, _6
	bl	GetSpellCost		@
	movs	r3, r0	@ tmp137,
	str	r3, [r7, #12]	@ tmp137, cost
@ SpellSystem.c:412: 		buffer->attributes |= BATTLE_HIT_ATTR_HPSTEAL; // "HP drain" bit.
	ldr	r3, [r7]	@ tmp138, buffer
	ldr	r3, [r3]	@ tmp139, *buffer_25(D)
	lsls	r3, r3, #13	@ tmp140, tmp139,
	lsrs	r3, r3, #13	@ _7, tmp140,
	movs	r2, #128	@ tmp182,
	lsls	r2, r2, #1	@ tmp141, tmp182,
	orrs	r2, r3	@ _8, _7
	ldr	r3, [r7]	@ tmp142, buffer
	lsls	r2, r2, #13	@ tmp145, _8,
	lsrs	r2, r2, #13	@ tmp144, tmp145,
	ldr	r1, [r3]	@ tmp146,
	lsrs	r1, r1, #19	@ tmp148, tmp146,
	lsls	r1, r1, #19	@ tmp147, tmp148,
	orrs	r2, r1	@ tmp149, tmp147
	str	r2, [r3]	@ tmp149,
@ SpellSystem.c:414: 		unit->unit.curHP -= cost;
	ldr	r3, [r7, #4]	@ tmp150, unit
	ldrb	r3, [r3, #19]	@ _9,
	lsls	r3, r3, #24	@ _9, _9,
	asrs	r3, r3, #24	@ _9, _9,
	lsls	r3, r3, #24	@ tmp151, _9,
	lsrs	r2, r3, #24	@ _10, tmp151,
	ldr	r3, [r7, #12]	@ tmp153, cost
	lsls	r3, r3, #24	@ tmp154, tmp152,
	lsrs	r3, r3, #24	@ _11, tmp154,
	subs	r3, r2, r3	@ tmp155, _10, _11
	lsls	r3, r3, #24	@ tmp156, tmp155,
	lsrs	r3, r3, #24	@ _12, tmp156,
	lsls	r3, r3, #24	@ tmp157, _12,
	asrs	r2, r3, #24	@ _13, tmp157,
	ldr	r3, [r7, #4]	@ tmp158, unit
	strb	r2, [r3, #19]	@ tmp159, unit_22(D)->unit.curHP
@ SpellSystem.c:415: 		buffer->damage -= cost;
	ldr	r3, [r7]	@ tmp160, buffer
	ldrb	r3, [r3, #5]	@ _14,
	lsls	r3, r3, #24	@ _14, _14,
	asrs	r3, r3, #24	@ _14, _14,
	lsls	r3, r3, #24	@ tmp161, _14,
	lsrs	r2, r3, #24	@ _15, tmp161,
	ldr	r3, [r7, #12]	@ tmp163, cost
	lsls	r3, r3, #24	@ tmp164, tmp162,
	lsrs	r3, r3, #24	@ _16, tmp164,
	subs	r3, r2, r3	@ tmp165, _15, _16
	lsls	r3, r3, #24	@ tmp166, tmp165,
	lsrs	r3, r3, #24	@ _17, tmp166,
	lsls	r3, r3, #24	@ tmp167, _17,
	asrs	r2, r3, #24	@ _18, tmp167,
	ldr	r3, [r7]	@ tmp168, buffer
	strb	r2, [r3, #5]	@ tmp169, buffer_25(D)->damage
@ SpellSystem.c:422: }
	b	.L143		@
.L141:
@ SpellSystem.c:420: 		buffer->attributes |= BATTLE_HIT_ATTR_5; // This bit is checked in an external hack I've made.
	ldr	r3, [r7]	@ tmp170, buffer
	ldr	r3, [r3]	@ tmp171, *buffer_25(D)
	lsls	r3, r3, #13	@ tmp172, tmp171,
	lsrs	r3, r3, #13	@ _19, tmp172,
	movs	r2, #32	@ tmp173,
	orrs	r2, r3	@ _20, _19
	ldr	r3, [r7]	@ tmp174, buffer
	lsls	r2, r2, #13	@ tmp177, _20,
	lsrs	r2, r2, #13	@ tmp176, tmp177,
	ldr	r1, [r3]	@ tmp178,
	lsrs	r1, r1, #19	@ tmp180, tmp178,
	lsls	r1, r1, #19	@ tmp179, tmp180,
	orrs	r2, r1	@ tmp181, tmp179
	str	r2, [r3]	@ tmp181,
.L143:
@ SpellSystem.c:422: }
	nop	
	mov	sp, r7	@,
	add	sp, sp, #16	@,,
	@ sp needed	@
	pop	{r7}
	pop	{r0}
	bx	r0
	.size	SetRoundForSpell, .-SetRoundForSpell
	.align	1
	.global	InitGaidenSpellLearnPopup
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	InitGaidenSpellLearnPopup, %function
InitGaidenSpellLearnPopup:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}	@
	sub	sp, sp, #8	@,,
	add	r7, sp, #0	@,,
@ SpellSystem.c:428: 	BattleUnit* subject = NULL;
	movs	r3, #0	@ tmp131,
	str	r3, [r7, #4]	@ tmp131, subject
@ SpellSystem.c:429: 	if ( gBattleActor.levelPrevious != gBattleActor.unit.level ) { subject = &gBattleActor; }
	ldr	r3, .L150	@ tmp132,
	movs	r2, #112	@ tmp133,
	ldrb	r3, [r3, r2]	@ _1,
	movs	r2, r3	@ _2, _1
@ SpellSystem.c:429: 	if ( gBattleActor.levelPrevious != gBattleActor.unit.level ) { subject = &gBattleActor; }
	ldr	r3, .L150	@ tmp134,
	ldrb	r3, [r3, #8]	@ _3,
	lsls	r3, r3, #24	@ _3, _3,
	asrs	r3, r3, #24	@ _3, _3,
@ SpellSystem.c:429: 	if ( gBattleActor.levelPrevious != gBattleActor.unit.level ) { subject = &gBattleActor; }
	cmp	r2, r3	@ _2, _4
	beq	.L145		@,
@ SpellSystem.c:429: 	if ( gBattleActor.levelPrevious != gBattleActor.unit.level ) { subject = &gBattleActor; }
	ldr	r3, .L150	@ tmp135,
	str	r3, [r7, #4]	@ tmp135, subject
.L145:
@ SpellSystem.c:430: 	if ( gBattleTarget.levelPrevious != gBattleTarget.unit.level ) { subject = &gBattleTarget; }
	ldr	r3, .L150+4	@ tmp136,
	movs	r2, #112	@ tmp137,
	ldrb	r3, [r3, r2]	@ _5,
	movs	r2, r3	@ _6, _5
@ SpellSystem.c:430: 	if ( gBattleTarget.levelPrevious != gBattleTarget.unit.level ) { subject = &gBattleTarget; }
	ldr	r3, .L150+4	@ tmp138,
	ldrb	r3, [r3, #8]	@ _7,
	lsls	r3, r3, #24	@ _7, _7,
	asrs	r3, r3, #24	@ _7, _7,
@ SpellSystem.c:430: 	if ( gBattleTarget.levelPrevious != gBattleTarget.unit.level ) { subject = &gBattleTarget; }
	cmp	r2, r3	@ _6, _8
	beq	.L146		@,
@ SpellSystem.c:430: 	if ( gBattleTarget.levelPrevious != gBattleTarget.unit.level ) { subject = &gBattleTarget; }
	ldr	r3, .L150+4	@ tmp139,
	str	r3, [r7, #4]	@ tmp139, subject
.L146:
@ SpellSystem.c:431: 	if ( !subject ) { return 0; } // If this isn't filled, we shouldn't show a popup.
	ldr	r3, [r7, #4]	@ tmp140, subject
	cmp	r3, #0	@ tmp140,
	bne	.L147		@,
@ SpellSystem.c:431: 	if ( !subject ) { return 0; } // If this isn't filled, we shouldn't show a popup.
	movs	r3, #0	@ _19,
	b	.L148		@
.L147:
@ SpellSystem.c:433: 	u8* spells = SpellsGetterForLevel(&subject->unit,subject->unit.level,-1);
	ldr	r0, [r7, #4]	@ _9, subject
@ SpellSystem.c:433: 	u8* spells = SpellsGetterForLevel(&subject->unit,subject->unit.level,-1);
	ldr	r3, [r7, #4]	@ tmp141, subject
	ldrb	r3, [r3, #8]	@ _10,
	lsls	r3, r3, #24	@ _10, _10,
	asrs	r3, r3, #24	@ _10, _10,
@ SpellSystem.c:433: 	u8* spells = SpellsGetterForLevel(&subject->unit,subject->unit.level,-1);
	movs	r1, r3	@ _11, _10
	movs	r3, #1	@ tmp152,
	rsbs	r3, r3, #0	@ tmp142, tmp152
	movs	r2, r3	@, tmp142
	bl	SpellsGetterForLevel		@
	movs	r3, r0	@ tmp143,
	str	r3, [r7]	@ tmp143, spells
@ SpellSystem.c:435: 	if ( *spells )
	ldr	r3, [r7]	@ tmp144, spells
	ldrb	r3, [r3]	@ _12, *spells_26
@ SpellSystem.c:435: 	if ( *spells )
	cmp	r3, #0	@ _12,
	beq	.L149		@,
@ SpellSystem.c:437: 		gPopupItem = *spells|0xFF00;
	ldr	r3, [r7]	@ tmp145, spells
	ldrb	r3, [r3]	@ _13, *spells_26
	lsls	r3, r3, #16	@ _14, _13,
	asrs	r3, r3, #16	@ _14, _14,
@ SpellSystem.c:437: 		gPopupItem = *spells|0xFF00;
	ldr	r2, .L150+8	@ tmp147,
	orrs	r3, r2	@ tmp146, tmp147
	lsls	r3, r3, #16	@ _15, tmp146,
	asrs	r3, r3, #16	@ _15, _15,
	lsls	r3, r3, #16	@ tmp148, _15,
	lsrs	r2, r3, #16	@ _16, tmp148,
@ SpellSystem.c:437: 		gPopupItem = *spells|0xFF00;
	ldr	r3, .L150+12	@ tmp149,
	strh	r2, [r3]	@ tmp150, gPopupItem
@ SpellSystem.c:438: 		return 1;
	movs	r3, #1	@ _19,
	b	.L148		@
.L149:
@ SpellSystem.c:439: 	} else { return 0; }
	movs	r3, #0	@ _19,
.L148:
@ SpellSystem.c:440: }
	movs	r0, r3	@, <retval>
	mov	sp, r7	@,
	add	sp, sp, #8	@,,
	@ sp needed	@
	pop	{r7}
	pop	{r1}
	bx	r1
.L151:
	.align	2
.L150:
	.word	gBattleActor
	.word	gBattleTarget
	.word	-256
	.word	gPopupItem
	.size	InitGaidenSpellLearnPopup, .-InitGaidenSpellLearnPopup
	.align	1
	.global	HasSufficientHP
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	HasSufficientHP, %function
HasSufficientHP:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r7, lr}	@
	sub	sp, sp, #12	@,,
	add	r7, sp, #0	@,,
	str	r0, [r7, #4]	@ unit, unit
	str	r1, [r7]	@ spell, spell
@ SpellSystem.c:445: 	return unit->curHP > GetSpellCost(spell);
	ldr	r3, [r7, #4]	@ tmp119, unit
	ldrb	r3, [r3, #19]	@ _1,
	lsls	r3, r3, #24	@ _1, _1,
	asrs	r3, r3, #24	@ _1, _1,
	movs	r4, r3	@ _2, _1
@ SpellSystem.c:445: 	return unit->curHP > GetSpellCost(spell);
	ldr	r3, [r7]	@ tmp120, spell
	movs	r0, r3	@, tmp120
	bl	GetSpellCost		@
	movs	r3, r0	@ _3,
@ SpellSystem.c:445: 	return unit->curHP > GetSpellCost(spell);
	movs	r2, #1	@ tmp123,
	cmp	r4, r3	@ _2, _3
	bgt	.L153		@,
	movs	r3, #0	@ tmp124,
	adds	r2, r3, #0	@ tmp121, tmp124
.L153:
	lsls	r3, r2, #24	@ tmp125, tmp121,
	lsrs	r3, r3, #24	@ _4, tmp125,
@ SpellSystem.c:446: }
	movs	r0, r3	@, <retval>
	mov	sp, r7	@,
	add	sp, sp, #12	@,,
	@ sp needed	@
	pop	{r4, r7}
	pop	{r1}
	bx	r1
	.size	HasSufficientHP, .-HasSufficientHP
	.align	1
	.global	CanCastSpellNow
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	CanCastSpellNow, %function
CanCastSpellNow:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}	@
	sub	sp, sp, #16	@,,
	add	r7, sp, #0	@,,
	str	r0, [r7, #4]	@ unit, unit
	str	r1, [r7]	@ spell, spell
@ SpellSystem.c:453: 	int type = GetItemType(spell);
	ldr	r3, [r7]	@ tmp121, spell
	movs	r0, r3	@, tmp121
	ldr	r3, .L159	@ tmp122,
	bl	.L12		@
	movs	r3, r0	@ tmp123,
	str	r3, [r7, #12]	@ tmp123, type
@ SpellSystem.c:454: 	if ( type != ITYPE_STAFF )
	ldr	r3, [r7, #12]	@ tmp124, type
	cmp	r3, #4	@ tmp124,
	beq	.L156		@,
@ SpellSystem.c:456: 		if ( !CanUnitUseWeaponNow(gActiveUnit,spell) ) { return 0; }
	ldr	r3, .L159+4	@ tmp125,
	ldr	r3, [r3]	@ gActiveUnit.51_1, gActiveUnit
	ldr	r2, [r7]	@ tmp126, spell
	movs	r1, r2	@, tmp126
	movs	r0, r3	@, gActiveUnit.51_1
	ldr	r3, .L159+8	@ tmp127,
	bl	.L12		@
	subs	r3, r0, #0	@ _2,,
@ SpellSystem.c:456: 		if ( !CanUnitUseWeaponNow(gActiveUnit,spell) ) { return 0; }
	bne	.L157		@,
@ SpellSystem.c:456: 		if ( !CanUnitUseWeaponNow(gActiveUnit,spell) ) { return 0; }
	movs	r3, #0	@ _7,
	b	.L158		@
.L157:
@ SpellSystem.c:458: 		MakeTargetListForWeapon(gActiveUnit,spell);
	ldr	r3, .L159+4	@ tmp128,
	ldr	r3, [r3]	@ gActiveUnit.52_3, gActiveUnit
	ldr	r2, [r7]	@ tmp129, spell
	movs	r1, r2	@, tmp129
	movs	r0, r3	@, gActiveUnit.52_3
	ldr	r3, .L159+12	@ tmp130,
	bl	.L12		@
@ SpellSystem.c:459: 		return GetTargetListSize() != 0;
	ldr	r3, .L159+16	@ tmp131,
	bl	.L12		@
	movs	r3, r0	@ _4,
@ SpellSystem.c:459: 		return GetTargetListSize() != 0;
	subs	r2, r3, #1	@ tmp134, _4
	sbcs	r3, r3, r2	@ tmp133, _4, tmp134
	lsls	r3, r3, #24	@ tmp135, tmp132,
	lsrs	r3, r3, #24	@ _5, tmp135,
	b	.L158		@
.L156:
@ SpellSystem.c:463: 		return CanUnitUseItem(gActiveUnit,spell);
	ldr	r3, .L159+4	@ tmp136,
	ldr	r3, [r3]	@ gActiveUnit.53_6, gActiveUnit
	ldr	r2, [r7]	@ tmp137, spell
	movs	r1, r2	@, tmp137
	movs	r0, r3	@, gActiveUnit.53_6
	ldr	r3, .L159+20	@ tmp138,
	bl	.L12		@
	movs	r3, r0	@ _7,
.L158:
@ SpellSystem.c:465: }
	movs	r0, r3	@, <retval>
	mov	sp, r7	@,
	add	sp, sp, #16	@,,
	@ sp needed	@
	pop	{r7}
	pop	{r1}
	bx	r1
.L160:
	.align	2
.L159:
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
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}	@
	sub	sp, sp, #16	@,,
	add	r7, sp, #0	@,,
	str	r0, [r7, #4]	@ unit, unit
	str	r1, [r7]	@ spell, spell
@ SpellSystem.c:469: 	int type = GetItemType(spell);
	ldr	r3, [r7]	@ tmp121, spell
	movs	r0, r3	@, tmp121
	ldr	r3, .L165	@ tmp122,
	bl	.L12		@
	movs	r3, r0	@ tmp123,
	str	r3, [r7, #12]	@ tmp123, type
@ SpellSystem.c:470: 	if ( type != ITYPE_STAFF )
	ldr	r3, [r7, #12]	@ tmp124, type
	cmp	r3, #4	@ tmp124,
	beq	.L162		@,
@ SpellSystem.c:472: 		if ( !CanUnitUseWeapon(gActiveUnit,spell) ) { return 0; }
	ldr	r3, .L165+4	@ tmp125,
	ldr	r3, [r3]	@ gActiveUnit.54_1, gActiveUnit
	ldr	r2, [r7]	@ tmp126, spell
	movs	r1, r2	@, tmp126
	movs	r0, r3	@, gActiveUnit.54_1
	ldr	r3, .L165+8	@ tmp127,
	bl	.L12		@
	subs	r3, r0, #0	@ _2,,
@ SpellSystem.c:472: 		if ( !CanUnitUseWeapon(gActiveUnit,spell) ) { return 0; }
	bne	.L163		@,
@ SpellSystem.c:472: 		if ( !CanUnitUseWeapon(gActiveUnit,spell) ) { return 0; }
	movs	r3, #0	@ _7,
	b	.L164		@
.L163:
@ SpellSystem.c:474: 		MakeTargetListForWeapon(gActiveUnit,spell);
	ldr	r3, .L165+4	@ tmp128,
	ldr	r3, [r3]	@ gActiveUnit.55_3, gActiveUnit
	ldr	r2, [r7]	@ tmp129, spell
	movs	r1, r2	@, tmp129
	movs	r0, r3	@, gActiveUnit.55_3
	ldr	r3, .L165+12	@ tmp130,
	bl	.L12		@
@ SpellSystem.c:475: 		return GetTargetListSize() != 0;
	ldr	r3, .L165+16	@ tmp131,
	bl	.L12		@
	movs	r3, r0	@ _4,
@ SpellSystem.c:475: 		return GetTargetListSize() != 0;
	subs	r2, r3, #1	@ tmp134, _4
	sbcs	r3, r3, r2	@ tmp133, _4, tmp134
	lsls	r3, r3, #24	@ tmp135, tmp132,
	lsrs	r3, r3, #24	@ _5, tmp135,
	b	.L164		@
.L162:
@ SpellSystem.c:479: 		return CanUnitUseItem(gActiveUnit,spell);
	ldr	r3, .L165+4	@ tmp136,
	ldr	r3, [r3]	@ gActiveUnit.56_6, gActiveUnit
	ldr	r2, [r7]	@ tmp137, spell
	movs	r1, r2	@, tmp137
	movs	r0, r3	@, gActiveUnit.56_6
	ldr	r3, .L165+20	@ tmp138,
	bl	.L12		@
	movs	r3, r0	@ _7,
.L164:
@ SpellSystem.c:481: }
	movs	r0, r3	@, <retval>
	mov	sp, r7	@,
	add	sp, sp, #16	@,,
	@ sp needed	@
	pop	{r7}
	pop	{r1}
	bx	r1
.L166:
	.align	2
.L165:
	.word	GetItemType
	.word	gActiveUnit
	.word	CanUnitUseWeapon
	.word	MakeTargetListForWeapon
	.word	GetTargetListSize
	.word	CanUnitUseItem
	.size	CanCastSpell, .-CanCastSpell
	.align	1
	.global	CanUseAttackSpellsNow
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	CanUseAttackSpellsNow, %function
CanUseAttackSpellsNow:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}	@
	sub	sp, sp, #16	@,,
	add	r7, sp, #0	@,,
	str	r0, [r7, #4]	@ unit, unit
	str	r1, [r7]	@ type, type
@ SpellSystem.c:485: 	u8* spells = SpellsGetter(unit,type);
	ldr	r2, [r7]	@ tmp128, type
	ldr	r3, [r7, #4]	@ tmp129, unit
	movs	r1, r2	@, tmp128
	movs	r0, r3	@, tmp129
	bl	SpellsGetter		@
	movs	r3, r0	@ tmp130,
	str	r3, [r7, #8]	@ tmp130, spells
@ SpellSystem.c:486: 	for ( int i = 0 ; spells[i] ; i++ )
	movs	r3, #0	@ tmp131,
	str	r3, [r7, #12]	@ tmp131, i
@ SpellSystem.c:486: 	for ( int i = 0 ; spells[i] ; i++ )
	b	.L168		@
.L171:
@ SpellSystem.c:488: 		if ( GetItemType(spells[i]) != ITYPE_STAFF && CanCastSpellNow(unit,spells[i]) )
	ldr	r3, [r7, #12]	@ i.57_1, i
	ldr	r2, [r7, #8]	@ tmp132, spells
	adds	r3, r2, r3	@ _2, tmp132, i.57_1
	ldrb	r3, [r3]	@ _3, *_2
@ SpellSystem.c:488: 		if ( GetItemType(spells[i]) != ITYPE_STAFF && CanCastSpellNow(unit,spells[i]) )
	movs	r0, r3	@, _4
	ldr	r3, .L172	@ tmp133,
	bl	.L12		@
	movs	r3, r0	@ _5,
@ SpellSystem.c:488: 		if ( GetItemType(spells[i]) != ITYPE_STAFF && CanCastSpellNow(unit,spells[i]) )
	cmp	r3, #4	@ _5,
	beq	.L169		@,
@ SpellSystem.c:488: 		if ( GetItemType(spells[i]) != ITYPE_STAFF && CanCastSpellNow(unit,spells[i]) )
	ldr	r3, [r7, #12]	@ i.58_6, i
	ldr	r2, [r7, #8]	@ tmp134, spells
	adds	r3, r2, r3	@ _7, tmp134, i.58_6
	ldrb	r3, [r3]	@ _8, *_7
@ SpellSystem.c:488: 		if ( GetItemType(spells[i]) != ITYPE_STAFF && CanCastSpellNow(unit,spells[i]) )
	movs	r2, r3	@ _9, _8
	ldr	r3, [r7, #4]	@ tmp135, unit
	movs	r1, r2	@, _9
	movs	r0, r3	@, tmp135
	bl	CanCastSpellNow		@
	subs	r3, r0, #0	@ _10,,
@ SpellSystem.c:488: 		if ( GetItemType(spells[i]) != ITYPE_STAFF && CanCastSpellNow(unit,spells[i]) )
	beq	.L169		@,
@ SpellSystem.c:490: 			return 1;
	movs	r3, #1	@ _15,
	b	.L170		@
.L169:
@ SpellSystem.c:486: 	for ( int i = 0 ; spells[i] ; i++ )
	ldr	r3, [r7, #12]	@ tmp137, i
	adds	r3, r3, #1	@ tmp136,
	str	r3, [r7, #12]	@ tmp136, i
.L168:
@ SpellSystem.c:486: 	for ( int i = 0 ; spells[i] ; i++ )
	ldr	r3, [r7, #12]	@ i.59_11, i
	ldr	r2, [r7, #8]	@ tmp138, spells
	adds	r3, r2, r3	@ _12, tmp138, i.59_11
	ldrb	r3, [r3]	@ _13, *_12
@ SpellSystem.c:486: 	for ( int i = 0 ; spells[i] ; i++ )
	cmp	r3, #0	@ _13,
	bne	.L171		@,
@ SpellSystem.c:493: 	return 0;
	movs	r3, #0	@ _15,
.L170:
@ SpellSystem.c:494: }
	movs	r0, r3	@, <retval>
	mov	sp, r7	@,
	add	sp, sp, #16	@,,
	@ sp needed	@
	pop	{r7}
	pop	{r1}
	bx	r1
.L173:
	.align	2
.L172:
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
	@ args = 0, pretend = 0, frame = 32
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}	@
	sub	sp, sp, #32	@,,
	add	r7, sp, #0	@,,
	str	r0, [r7, #12]	@ unit, unit
	str	r1, [r7, #8]	@ n, n
	str	r2, [r7, #4]	@ type, type
@ SpellSystem.c:500: 	u8* spells = SpellsGetter(unit,type);
	ldr	r2, [r7, #4]	@ tmp123, type
	ldr	r3, [r7, #12]	@ tmp124, unit
	movs	r1, r2	@, tmp123
	movs	r0, r3	@, tmp124
	bl	SpellsGetter		@
	movs	r3, r0	@ tmp125,
	str	r3, [r7, #20]	@ tmp125, spells
@ SpellSystem.c:501: 	int k = -1;
	movs	r3, #1	@ tmp139,
	rsbs	r3, r3, #0	@ tmp126, tmp139
	str	r3, [r7, #28]	@ tmp126, k
@ SpellSystem.c:502: 	for ( int i = 0 ; spells[i] ; i++ )
	movs	r3, #0	@ tmp127,
	str	r3, [r7, #24]	@ tmp127, i
@ SpellSystem.c:502: 	for ( int i = 0 ; spells[i] ; i++ )
	b	.L175		@
.L178:
@ SpellSystem.c:504: 		if ( CanCastSpellNow(unit,spells[i]) )
	ldr	r3, [r7, #24]	@ i.60_1, i
	ldr	r2, [r7, #20]	@ tmp128, spells
	adds	r3, r2, r3	@ _2, tmp128, i.60_1
	ldrb	r3, [r3]	@ _3, *_2
@ SpellSystem.c:504: 		if ( CanCastSpellNow(unit,spells[i]) )
	movs	r2, r3	@ _4, _3
	ldr	r3, [r7, #12]	@ tmp129, unit
	movs	r1, r2	@, _4
	movs	r0, r3	@, tmp129
	bl	CanCastSpellNow		@
	subs	r3, r0, #0	@ _5,,
@ SpellSystem.c:504: 		if ( CanCastSpellNow(unit,spells[i]) )
	beq	.L176		@,
@ SpellSystem.c:506: 			k++;
	ldr	r3, [r7, #28]	@ tmp131, k
	adds	r3, r3, #1	@ tmp130,
	str	r3, [r7, #28]	@ tmp130, k
@ SpellSystem.c:507: 			if ( k == n ) { return i; }
	ldr	r2, [r7, #28]	@ tmp132, k
	ldr	r3, [r7, #8]	@ tmp133, n
	cmp	r2, r3	@ tmp132, tmp133
	bne	.L176		@,
@ SpellSystem.c:507: 			if ( k == n ) { return i; }
	ldr	r3, [r7, #24]	@ _12, i
	b	.L177		@
.L176:
@ SpellSystem.c:502: 	for ( int i = 0 ; spells[i] ; i++ )
	ldr	r3, [r7, #24]	@ tmp135, i
	adds	r3, r3, #1	@ tmp134,
	str	r3, [r7, #24]	@ tmp134, i
.L175:
@ SpellSystem.c:502: 	for ( int i = 0 ; spells[i] ; i++ )
	ldr	r3, [r7, #24]	@ i.61_6, i
	ldr	r2, [r7, #20]	@ tmp136, spells
	adds	r3, r2, r3	@ _7, tmp136, i.61_6
	ldrb	r3, [r3]	@ _8, *_7
@ SpellSystem.c:502: 	for ( int i = 0 ; spells[i] ; i++ )
	cmp	r3, #0	@ _8,
	bne	.L178		@,
@ SpellSystem.c:510: 	return -1;
	movs	r3, #1	@ tmp138,
	rsbs	r3, r3, #0	@ _12, tmp138
.L177:
@ SpellSystem.c:511: }
	movs	r0, r3	@, <retval>
	mov	sp, r7	@,
	add	sp, sp, #32	@,,
	@ sp needed	@
	pop	{r7}
	pop	{r1}
	bx	r1
	.size	GetNthUsableSpell, .-GetNthUsableSpell
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	GetVanillaEquipped, %function
GetVanillaEquipped:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}	@
	sub	sp, sp, #16	@,,
	add	r7, sp, #0	@,,
	str	r0, [r7, #4]	@ unit, unit
@ SpellSystem.c:515: 	for ( int i = 0 ; i < 5 ; i++ )
	movs	r3, #0	@ tmp119,
	str	r3, [r7, #12]	@ tmp119, i
@ SpellSystem.c:515: 	for ( int i = 0 ; i < 5 ; i++ )
	b	.L180		@
.L183:
@ SpellSystem.c:517: 		if ( CanUnitUseWeapon(unit,unit->items[i]) ) { return unit->items[i]; }
	ldr	r2, [r7, #4]	@ tmp120, unit
	ldr	r3, [r7, #12]	@ tmp122, i
	adds	r3, r3, #12	@ tmp121,
	lsls	r3, r3, #1	@ tmp123, tmp121,
	adds	r3, r2, r3	@ tmp124, tmp120, tmp123
	adds	r3, r3, #6	@ tmp125,
	ldrh	r3, [r3]	@ _1, *unit_12(D)
@ SpellSystem.c:517: 		if ( CanUnitUseWeapon(unit,unit->items[i]) ) { return unit->items[i]; }
	movs	r2, r3	@ _2, _1
	ldr	r3, [r7, #4]	@ tmp126, unit
	movs	r1, r2	@, _2
	movs	r0, r3	@, tmp126
	ldr	r3, .L184	@ tmp127,
	bl	.L12		@
	subs	r3, r0, #0	@ _3,,
@ SpellSystem.c:517: 		if ( CanUnitUseWeapon(unit,unit->items[i]) ) { return unit->items[i]; }
	beq	.L181		@,
@ SpellSystem.c:517: 		if ( CanUnitUseWeapon(unit,unit->items[i]) ) { return unit->items[i]; }
	ldr	r2, [r7, #4]	@ tmp128, unit
	ldr	r3, [r7, #12]	@ tmp130, i
	adds	r3, r3, #12	@ tmp129,
	lsls	r3, r3, #1	@ tmp131, tmp129,
	adds	r3, r2, r3	@ tmp132, tmp128, tmp131
	adds	r3, r3, #6	@ tmp133,
	ldrh	r3, [r3]	@ _4, *unit_12(D)
	b	.L182		@
.L181:
@ SpellSystem.c:515: 	for ( int i = 0 ; i < 5 ; i++ )
	ldr	r3, [r7, #12]	@ tmp135, i
	adds	r3, r3, #1	@ tmp134,
	str	r3, [r7, #12]	@ tmp134, i
.L180:
@ SpellSystem.c:515: 	for ( int i = 0 ; i < 5 ; i++ )
	ldr	r3, [r7, #12]	@ tmp136, i
	cmp	r3, #4	@ tmp136,
	ble	.L183		@,
@ SpellSystem.c:519: 	return 0;
	movs	r3, #0	@ _6,
.L182:
@ SpellSystem.c:520: }
	movs	r0, r3	@, <retval>
	mov	sp, r7	@,
	add	sp, sp, #16	@,,
	@ sp needed	@
	pop	{r7}
	pop	{r1}
	bx	r1
.L185:
	.align	2
.L184:
	.word	CanUnitUseWeapon
	.size	GetVanillaEquipped, .-GetVanillaEquipped
	.align	1
	.global	DoesUnitKnowSpell
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	DoesUnitKnowSpell, %function
DoesUnitKnowSpell:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}	@
	sub	sp, sp, #16	@,,
	add	r7, sp, #0	@,,
	str	r0, [r7, #4]	@ unit, unit
	movs	r2, r1	@ tmp121, spell
	adds	r3, r7, #3	@ tmp122,,
	strb	r2, [r3]	@ tmp123, spell
@ SpellSystem.c:526: 	u8* spells = SpellsGetter(unit,-1);
	movs	r3, #1	@ tmp135,
	rsbs	r2, r3, #0	@ tmp124, tmp135
	ldr	r3, [r7, #4]	@ tmp125, unit
	movs	r1, r2	@, tmp124
	movs	r0, r3	@, tmp125
	bl	SpellsGetter		@
	movs	r3, r0	@ tmp126,
	str	r3, [r7, #8]	@ tmp126, spells
@ SpellSystem.c:527: 	for ( int i = 0 ; spells[i] ; i++ )
	movs	r3, #0	@ tmp127,
	str	r3, [r7, #12]	@ tmp127, i
@ SpellSystem.c:527: 	for ( int i = 0 ; spells[i] ; i++ )
	b	.L187		@
.L190:
@ SpellSystem.c:529: 		if ( spell == spells[i] ) { return 1; }
	ldr	r3, [r7, #12]	@ i.62_1, i
	ldr	r2, [r7, #8]	@ tmp128, spells
	adds	r3, r2, r3	@ _2, tmp128, i.62_1
	ldrb	r3, [r3]	@ _3, *_2
@ SpellSystem.c:529: 		if ( spell == spells[i] ) { return 1; }
	adds	r2, r7, #3	@ tmp129,,
	ldrb	r2, [r2]	@ tmp130, spell
	cmp	r2, r3	@ tmp130, _3
	bne	.L188		@,
@ SpellSystem.c:529: 		if ( spell == spells[i] ) { return 1; }
	movs	r3, #1	@ _8,
	b	.L189		@
.L188:
@ SpellSystem.c:527: 	for ( int i = 0 ; spells[i] ; i++ )
	ldr	r3, [r7, #12]	@ tmp132, i
	adds	r3, r3, #1	@ tmp131,
	str	r3, [r7, #12]	@ tmp131, i
.L187:
@ SpellSystem.c:527: 	for ( int i = 0 ; spells[i] ; i++ )
	ldr	r3, [r7, #12]	@ i.63_4, i
	ldr	r2, [r7, #8]	@ tmp133, spells
	adds	r3, r2, r3	@ _5, tmp133, i.63_4
	ldrb	r3, [r3]	@ _6, *_5
@ SpellSystem.c:527: 	for ( int i = 0 ; spells[i] ; i++ )
	cmp	r3, #0	@ _6,
	bne	.L190		@,
@ SpellSystem.c:531: 	return 0;
	movs	r3, #0	@ _8,
.L189:
@ SpellSystem.c:532: }
	movs	r0, r3	@, <retval>
	mov	sp, r7	@,
	add	sp, sp, #16	@,,
	@ sp needed	@
	pop	{r7}
	pop	{r1}
	bx	r1
	.size	DoesUnitKnowSpell, .-DoesUnitKnowSpell
	.align	1
	.global	GetSpellType
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	GetSpellType, %function
GetSpellType:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}	@
	sub	sp, sp, #16	@,,
	add	r7, sp, #0	@,,
	str	r0, [r7, #4]	@ spell, spell
@ SpellSystem.c:536: 	int wType = GetItemType(spell);
	ldr	r3, [r7, #4]	@ tmp115, spell
	movs	r0, r3	@, tmp115
	ldr	r3, .L197	@ tmp116,
	bl	.L12		@
	movs	r3, r0	@ tmp117,
	str	r3, [r7, #12]	@ tmp117, wType
@ SpellSystem.c:537: 	if ( wType == ITYPE_ANIMA || wType == ITYPE_DARK ) { return BLACK_MAGIC; }
	ldr	r3, [r7, #12]	@ tmp118, wType
	cmp	r3, #5	@ tmp118,
	beq	.L192		@,
@ SpellSystem.c:537: 	if ( wType == ITYPE_ANIMA || wType == ITYPE_DARK ) { return BLACK_MAGIC; }
	ldr	r3, [r7, #12]	@ tmp119, wType
	cmp	r3, #7	@ tmp119,
	bne	.L193		@,
.L192:
@ SpellSystem.c:537: 	if ( wType == ITYPE_ANIMA || wType == ITYPE_DARK ) { return BLACK_MAGIC; }
	movs	r3, #1	@ _1,
	b	.L194		@
.L193:
@ SpellSystem.c:538: 	else if ( wType == ITYPE_STAFF || wType == ITYPE_LIGHT) { return WHITE_MAGIC; }
	ldr	r3, [r7, #12]	@ tmp120, wType
	cmp	r3, #4	@ tmp120,
	beq	.L195		@,
@ SpellSystem.c:538: 	else if ( wType == ITYPE_STAFF || wType == ITYPE_LIGHT) { return WHITE_MAGIC; }
	ldr	r3, [r7, #12]	@ tmp121, wType
	cmp	r3, #6	@ tmp121,
	bne	.L196		@,
.L195:
@ SpellSystem.c:538: 	else if ( wType == ITYPE_STAFF || wType == ITYPE_LIGHT) { return WHITE_MAGIC; }
	movs	r3, #2	@ _1,
	b	.L194		@
.L196:
@ SpellSystem.c:539: 	else { return -1; }
	movs	r3, #1	@ tmp123,
	rsbs	r3, r3, #0	@ _1, tmp123
.L194:
@ SpellSystem.c:540: }
	movs	r0, r3	@, <retval>
	mov	sp, r7	@,
	add	sp, sp, #16	@,,
	@ sp needed	@
	pop	{r7}
	pop	{r1}
	bx	r1
.L198:
	.align	2
.L197:
	.word	GetItemType
	.size	GetSpellType, .-GetSpellType
	.align	1
	.global	GetSpellCost
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	GetSpellCost, %function
GetSpellCost:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}	@
	sub	sp, sp, #8	@,,
	add	r7, sp, #0	@,,
	str	r0, [r7, #4]	@ spell, spell
@ SpellSystem.c:544: 	return GaidenSpellCostTable[GetItemIndex(spell)];
	ldr	r3, [r7, #4]	@ tmp118, spell
	movs	r0, r3	@, tmp118
	ldr	r3, .L201	@ tmp119,
	bl	.L12		@
	movs	r3, r0	@ tmp120,
	movs	r2, r3	@ _2, _1
@ SpellSystem.c:544: 	return GaidenSpellCostTable[GetItemIndex(spell)];
	ldr	r3, .L201+4	@ tmp122,
	ldrb	r3, [r3, r2]	@ _3, GaidenSpellCostTable
@ SpellSystem.c:545: }
	movs	r0, r3	@, <retval>
	mov	sp, r7	@,
	add	sp, sp, #8	@,,
	@ sp needed	@
	pop	{r7}
	pop	{r1}
	bx	r1
.L202:
	.align	2
.L201:
	.word	GetItemIndex
	.word	GaidenSpellCostTable
	.size	GetSpellCost, .-GetSpellCost
	.align	1
	.global	GetFirstAttackSpell
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	GetFirstAttackSpell, %function
GetFirstAttackSpell:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}	@
	sub	sp, sp, #24	@,,
	add	r7, sp, #0	@,,
	str	r0, [r7, #4]	@ unit, unit
@ SpellSystem.c:549: 	u8* spells = SpellsGetter(unit,-1);
	movs	r3, #1	@ tmp138,
	rsbs	r2, r3, #0	@ tmp126, tmp138
	ldr	r3, [r7, #4]	@ tmp127, unit
	movs	r1, r2	@, tmp126
	movs	r0, r3	@, tmp127
	bl	SpellsGetter		@
	movs	r3, r0	@ tmp128,
	str	r3, [r7, #12]	@ tmp128, spells
@ SpellSystem.c:550: 	int spell = 0;
	movs	r3, #0	@ tmp129,
	str	r3, [r7, #20]	@ tmp129, spell
@ SpellSystem.c:551: 	for ( int i = 0 ; spells[i] ; i++ )
	movs	r3, #0	@ tmp130,
	str	r3, [r7, #16]	@ tmp130, i
@ SpellSystem.c:551: 	for ( int i = 0 ; spells[i] ; i++ )
	b	.L204		@
.L207:
@ SpellSystem.c:553: 		if ( GetItemType(spells[i]) != ITYPE_STAFF ) { spell = spells[i]; break; } // Ensure that the spell we could counter with would be an attack spell.
	ldr	r3, [r7, #16]	@ i.64_1, i
	ldr	r2, [r7, #12]	@ tmp131, spells
	adds	r3, r2, r3	@ _2, tmp131, i.64_1
	ldrb	r3, [r3]	@ _3, *_2
@ SpellSystem.c:553: 		if ( GetItemType(spells[i]) != ITYPE_STAFF ) { spell = spells[i]; break; } // Ensure that the spell we could counter with would be an attack spell.
	movs	r0, r3	@, _4
	ldr	r3, .L209	@ tmp132,
	bl	.L12		@
	movs	r3, r0	@ _5,
@ SpellSystem.c:553: 		if ( GetItemType(spells[i]) != ITYPE_STAFF ) { spell = spells[i]; break; } // Ensure that the spell we could counter with would be an attack spell.
	cmp	r3, #4	@ _5,
	beq	.L205		@,
@ SpellSystem.c:553: 		if ( GetItemType(spells[i]) != ITYPE_STAFF ) { spell = spells[i]; break; } // Ensure that the spell we could counter with would be an attack spell.
	ldr	r3, [r7, #16]	@ i.65_6, i
	ldr	r2, [r7, #12]	@ tmp133, spells
	adds	r3, r2, r3	@ _7, tmp133, i.65_6
	ldrb	r3, [r3]	@ _8, *_7
@ SpellSystem.c:553: 		if ( GetItemType(spells[i]) != ITYPE_STAFF ) { spell = spells[i]; break; } // Ensure that the spell we could counter with would be an attack spell.
	str	r3, [r7, #20]	@ _8, spell
@ SpellSystem.c:553: 		if ( GetItemType(spells[i]) != ITYPE_STAFF ) { spell = spells[i]; break; } // Ensure that the spell we could counter with would be an attack spell.
	b	.L206		@
.L205:
@ SpellSystem.c:551: 	for ( int i = 0 ; spells[i] ; i++ )
	ldr	r3, [r7, #16]	@ tmp135, i
	adds	r3, r3, #1	@ tmp134,
	str	r3, [r7, #16]	@ tmp134, i
.L204:
@ SpellSystem.c:551: 	for ( int i = 0 ; spells[i] ; i++ )
	ldr	r3, [r7, #16]	@ i.66_9, i
	ldr	r2, [r7, #12]	@ tmp136, spells
	adds	r3, r2, r3	@ _10, tmp136, i.66_9
	ldrb	r3, [r3]	@ _11, *_10
@ SpellSystem.c:551: 	for ( int i = 0 ; spells[i] ; i++ )
	cmp	r3, #0	@ _11,
	bne	.L207		@,
.L206:
@ SpellSystem.c:555: 	return spell;
	ldr	r3, [r7, #20]	@ _25, spell
@ SpellSystem.c:556: }
	movs	r0, r3	@, <retval>
	mov	sp, r7	@,
	add	sp, sp, #24	@,,
	@ sp needed	@
	pop	{r7}
	pop	{r1}
	bx	r1
.L210:
	.align	2
.L209:
	.word	GetItemType
	.size	GetFirstAttackSpell, .-GetFirstAttackSpell
	.align	1
	.global	Target_Routine_For_Fortify
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	Target_Routine_For_Fortify, %function
Target_Routine_For_Fortify:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}	@
	sub	sp, sp, #16	@,,
	add	r7, sp, #0	@,,
	str	r0, [r7, #4]	@ unit, unit
@ SpellSystem.c:562: 	u16 item = 0;
	movs	r1, #14	@ tmp142,
	adds	r3, r7, r1	@ tmp121,, tmp142
	movs	r2, #0	@ tmp122,
	strh	r2, [r3]	@ tmp123, item
@ SpellSystem.c:563: 	if ( UsingSpellMenu )
	ldr	r3, .L214	@ tmp124,
	ldrb	r3, [r3]	@ UsingSpellMenu.67_1, UsingSpellMenu
@ SpellSystem.c:563: 	if ( UsingSpellMenu )
	cmp	r3, #0	@ UsingSpellMenu.67_1,
	beq	.L212		@,
@ SpellSystem.c:565: 		item = SelectedSpell|0xFF00;
	ldr	r3, .L214+4	@ tmp125,
	ldrb	r3, [r3]	@ SelectedSpell.68_2, SelectedSpell
	lsls	r3, r3, #16	@ _3, SelectedSpell.68_2,
	asrs	r3, r3, #16	@ _3, _3,
	ldr	r2, .L214+8	@ tmp127,
	orrs	r3, r2	@ tmp126, tmp127
	lsls	r3, r3, #16	@ _4, tmp126,
	asrs	r3, r3, #16	@ _4, _4,
@ SpellSystem.c:565: 		item = SelectedSpell|0xFF00;
	adds	r2, r7, r1	@ tmp128,, tmp143
	strh	r3, [r2]	@ tmp129, item
	b	.L213		@
.L212:
@ SpellSystem.c:569: 		item = unit->unit.items[gActionData.itemSlotIndex];
	ldr	r3, .L214+12	@ tmp130,
	ldrb	r3, [r3, #18]	@ _5,
	movs	r2, r3	@ _6, _5
@ SpellSystem.c:569: 		item = unit->unit.items[gActionData.itemSlotIndex];
	movs	r3, #14	@ tmp144,
	adds	r3, r7, r3	@ tmp131,, tmp144
	ldr	r1, [r7, #4]	@ tmp132, unit
	adds	r2, r2, #12	@ tmp133,
	lsls	r2, r2, #1	@ tmp134, tmp133,
	adds	r2, r1, r2	@ tmp135, tmp132, tmp134
	adds	r2, r2, #6	@ tmp136,
	ldrh	r2, [r2]	@ tmp137, *unit_12(D)
	strh	r2, [r3]	@ tmp137, item
.L213:
@ SpellSystem.c:571: 	gHealStaff_RangeSetup(unit,0,item);
	ldr	r3, .L214+16	@ tmp138,
	ldr	r3, [r3]	@ gHealStaff_RangeSetup.69_7, gHealStaff_RangeSetup
	movs	r2, #14	@ tmp145,
	adds	r2, r7, r2	@ tmp139,, tmp145
	ldrh	r2, [r2]	@ _8, item
	ldr	r0, [r7, #4]	@ tmp140, unit
	movs	r1, #0	@,
	bl	.L12		@
@ SpellSystem.c:572: }
	nop	
	mov	sp, r7	@,
	add	sp, sp, #16	@,,
	@ sp needed	@
	pop	{r7}
	pop	{r0}
	bx	r0
.L215:
	.align	2
.L214:
	.word	UsingSpellMenu
	.word	SelectedSpell
	.word	-256
	.word	gActionData
	.word	gHealStaff_RangeSetup
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
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}	@
	add	r7, sp, #0	@,,
@ SpellSystem.c:576: 	UsingSpellMenu = 0;
	ldr	r3, .L217	@ tmp113,
	movs	r2, #0	@ tmp114,
	strb	r2, [r3]	@ tmp115, UsingSpellMenu
@ SpellSystem.c:577: 	SelectedSpell = 0;
	ldr	r3, .L217+4	@ tmp116,
	movs	r2, #0	@ tmp117,
	strb	r2, [r3]	@ tmp118, SelectedSpell
@ SpellSystem.c:578: 	DidSelectSpell = 0;
	ldr	r3, .L217+8	@ tmp119,
	movs	r2, #0	@ tmp120,
	strb	r2, [r3]	@ tmp121, DidSelectSpell
@ SpellSystem.c:579: }
	nop	
	mov	sp, r7	@,
	@ sp needed	@
	pop	{r7}
	pop	{r0}
	bx	r0
.L218:
	.align	2
.L217:
	.word	UsingSpellMenu
	.word	SelectedSpell
	.word	DidSelectSpell
	.size	GaidenZeroOutSpellVariables, .-GaidenZeroOutSpellVariables
	.align	1
	.global	Return_Range_Bitfield
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	Return_Range_Bitfield, %function
Return_Range_Bitfield:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 32
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}	@
	sub	sp, sp, #32	@,,
	add	r7, sp, #0	@,,
	str	r0, [r7, #12]	@ unit, unit
	str	r1, [r7, #8]	@ slot, slot
	str	r2, [r7, #4]	@ usability, usability
@ RangeDisplay.c:10: 	long long current = 0;
	movs	r2, #0	@ tmp127,
	movs	r3, #0	@,
	str	r2, [r7, #24]	@ tmp127, current
	str	r3, [r7, #28]	@ tmp127,
@ RangeDisplay.c:11: 	if ( slot == -1 || slot == -2 )
	ldr	r3, [r7, #8]	@ tmp128, slot
	adds	r3, r3, #1	@ tmp174, tmp128,
	beq	.L220		@,
@ RangeDisplay.c:11: 	if ( slot == -1 || slot == -2 )
	ldr	r3, [r7, #8]	@ tmp129, slot
	adds	r3, r3, #2	@ tmp175, tmp129,
	bne	.L221		@,
.L220:
@ RangeDisplay.c:14: 		for ( int i = 0 ; i < 5 && unit->items[i] ; i++ )
	movs	r3, #0	@ tmp130,
	str	r3, [r7, #20]	@ tmp130, i
@ RangeDisplay.c:14: 		for ( int i = 0 ; i < 5 && unit->items[i] ; i++ )
	b	.L222		@
.L225:
@ RangeDisplay.c:16: 			if ( usability(unit,unit->items[i]) )
	ldr	r2, [r7, #12]	@ tmp131, unit
	ldr	r3, [r7, #20]	@ tmp133, i
	adds	r3, r3, #12	@ tmp132,
	lsls	r3, r3, #1	@ tmp134, tmp132,
	adds	r3, r2, r3	@ tmp135, tmp131, tmp134
	adds	r3, r3, #6	@ tmp136,
	ldrh	r3, [r3]	@ _1, *unit_25(D)
@ RangeDisplay.c:16: 			if ( usability(unit,unit->items[i]) )
	movs	r1, r3	@ _2, _1
	ldr	r2, [r7, #12]	@ tmp137, unit
	ldr	r3, [r7, #4]	@ tmp138, usability
	movs	r0, r2	@, tmp137
	bl	.L12		@
	subs	r3, r0, #0	@ _3,,
@ RangeDisplay.c:16: 			if ( usability(unit,unit->items[i]) )
	beq	.L223		@,
@ RangeDisplay.c:18: 				current = IncorporateNewRange(current,gGet_Item_Range(unit,unit->items[i]));
	ldr	r3, .L231	@ tmp139,
	ldr	r3, [r3]	@ gGet_Item_Range.70_4, gGet_Item_Range
@ RangeDisplay.c:18: 				current = IncorporateNewRange(current,gGet_Item_Range(unit,unit->items[i]));
	ldr	r1, [r7, #12]	@ tmp140, unit
	ldr	r2, [r7, #20]	@ tmp142, i
	adds	r2, r2, #12	@ tmp141,
	lsls	r2, r2, #1	@ tmp143, tmp141,
	adds	r2, r1, r2	@ tmp144, tmp140, tmp143
	adds	r2, r2, #6	@ tmp145,
	ldrh	r2, [r2]	@ _5, *unit_25(D)
@ RangeDisplay.c:18: 				current = IncorporateNewRange(current,gGet_Item_Range(unit,unit->items[i]));
	movs	r1, r2	@ _6, _5
	ldr	r2, [r7, #12]	@ tmp146, unit
	movs	r0, r2	@, tmp146
	bl	.L12		@
	movs	r2, r0	@ _7,
	movs	r3, r1	@ _7,
	ldr	r0, [r7, #24]	@ tmp147, current
	ldr	r1, [r7, #28]	@ tmp147, current
	bl	IncorporateNewRange		@
	movs	r2, r0	@ tmp148,
	movs	r3, r1	@,
	str	r2, [r7, #24]	@ tmp148, current
	str	r3, [r7, #28]	@ tmp148,
.L223:
@ RangeDisplay.c:14: 		for ( int i = 0 ; i < 5 && unit->items[i] ; i++ )
	ldr	r3, [r7, #20]	@ tmp150, i
	adds	r3, r3, #1	@ tmp149,
	str	r3, [r7, #20]	@ tmp149, i
.L222:
@ RangeDisplay.c:14: 		for ( int i = 0 ; i < 5 && unit->items[i] ; i++ )
	ldr	r3, [r7, #20]	@ tmp151, i
	cmp	r3, #4	@ tmp151,
	bgt	.L224		@,
@ RangeDisplay.c:14: 		for ( int i = 0 ; i < 5 && unit->items[i] ; i++ )
	ldr	r2, [r7, #12]	@ tmp152, unit
	ldr	r3, [r7, #20]	@ tmp154, i
	adds	r3, r3, #12	@ tmp153,
	lsls	r3, r3, #1	@ tmp155, tmp153,
	adds	r3, r2, r3	@ tmp156, tmp152, tmp155
	adds	r3, r3, #6	@ tmp157,
	ldrh	r3, [r3]	@ _8, *unit_25(D)
@ RangeDisplay.c:14: 		for ( int i = 0 ; i < 5 && unit->items[i] ; i++ )
	cmp	r3, #0	@ _8,
	bne	.L225		@,
.L224:
@ RangeDisplay.c:21: 		return ( slot == -1 ? IncorporateNewRange(current,GetUnitRangeMaskForSpells(unit,usability)) : current );
	ldr	r3, [r7, #8]	@ tmp158, slot
	adds	r3, r3, #1	@ tmp176, tmp158,
	bne	.L226		@,
@ RangeDisplay.c:21: 		return ( slot == -1 ? IncorporateNewRange(current,GetUnitRangeMaskForSpells(unit,usability)) : current );
	ldr	r2, [r7, #4]	@ tmp159, usability
	ldr	r3, [r7, #12]	@ tmp160, unit
	movs	r1, r2	@, tmp159
	movs	r0, r3	@, tmp160
	bl	GetUnitRangeMaskForSpells		@
	movs	r2, r0	@ _9,
	movs	r3, r1	@ _9,
	ldr	r0, [r7, #24]	@ tmp161, current
	ldr	r1, [r7, #28]	@ tmp161, current
	bl	IncorporateNewRange		@
	movs	r2, r0	@ iftmp.71_17,
	movs	r3, r1	@ iftmp.71_17,
@ RangeDisplay.c:21: 		return ( slot == -1 ? IncorporateNewRange(current,GetUnitRangeMaskForSpells(unit,usability)) : current );
	b	.L228		@
.L226:
@ RangeDisplay.c:21: 		return ( slot == -1 ? IncorporateNewRange(current,GetUnitRangeMaskForSpells(unit,usability)) : current );
	ldr	r2, [r7, #24]	@ iftmp.71_17, current
	ldr	r3, [r7, #28]	@ iftmp.71_17, current
	b	.L228		@
.L221:
@ RangeDisplay.c:26: 		if ( slot != 9 )
	ldr	r3, [r7, #8]	@ tmp162, slot
	cmp	r3, #9	@ tmp162,
	beq	.L229		@,
@ RangeDisplay.c:28: 			return gGet_Item_Range(unit,unit->items[slot]);
	ldr	r3, .L231	@ tmp163,
	ldr	r3, [r3]	@ gGet_Item_Range.72_10, gGet_Item_Range
@ RangeDisplay.c:28: 			return gGet_Item_Range(unit,unit->items[slot]);
	ldr	r1, [r7, #12]	@ tmp164, unit
	ldr	r2, [r7, #8]	@ tmp166, slot
	adds	r2, r2, #12	@ tmp165,
	lsls	r2, r2, #1	@ tmp167, tmp165,
	adds	r2, r1, r2	@ tmp168, tmp164, tmp167
	adds	r2, r2, #6	@ tmp169,
	ldrh	r2, [r2]	@ _11, *unit_25(D)
@ RangeDisplay.c:28: 			return gGet_Item_Range(unit,unit->items[slot]);
	movs	r1, r2	@ _12, _11
	ldr	r2, [r7, #12]	@ tmp170, unit
	movs	r0, r2	@, tmp170
	bl	.L12		@
	movs	r2, r0	@ iftmp.71_17,
	movs	r3, r1	@ iftmp.71_17,
	b	.L228		@
.L229:
@ RangeDisplay.c:33: 			return GetUnitRangeMaskForSpells(unit,usability);
	ldr	r2, [r7, #4]	@ tmp171, usability
	ldr	r3, [r7, #12]	@ tmp172, unit
	movs	r1, r2	@, tmp171
	movs	r0, r3	@, tmp172
	bl	GetUnitRangeMaskForSpells		@
	movs	r2, r0	@ iftmp.71_17,
	movs	r3, r1	@ iftmp.71_17,
.L228:
@ RangeDisplay.c:36: }
	movs	r0, r2	@, <retval>
	movs	r1, r3	@, <retval>
	mov	sp, r7	@,
	add	sp, sp, #32	@,,
	@ sp needed	@
	pop	{r7}
	pop	{r2}
	bx	r2
.L232:
	.align	2
.L231:
	.word	gGet_Item_Range
	.size	Return_Range_Bitfield, .-Return_Range_Bitfield
	.align	1
	.global	GetUnitRangeMaskForSpells
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	GetUnitRangeMaskForSpells, %function
GetUnitRangeMaskForSpells:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 32
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}	@
	sub	sp, sp, #32	@,,
	add	r7, sp, #0	@,,
	str	r0, [r7, #4]	@ unit, unit
	str	r1, [r7]	@ usability, usability
@ RangeDisplay.c:41: 	long long current = 0;
	movs	r2, #0	@ tmp131,
	movs	r3, #0	@,
	str	r2, [r7, #24]	@ tmp131, current
	str	r3, [r7, #28]	@ tmp131,
@ RangeDisplay.c:42: 	u8* spells = SpellsGetter(unit,(UsingSpellMenu ? UsingSpellMenu : -1)); // If UsingSpellMenu is nonzero, only get Gaiden spells of that type.
	ldr	r3, .L241	@ tmp132,
	ldrb	r3, [r3]	@ UsingSpellMenu.74_1, UsingSpellMenu
@ RangeDisplay.c:42: 	u8* spells = SpellsGetter(unit,(UsingSpellMenu ? UsingSpellMenu : -1)); // If UsingSpellMenu is nonzero, only get Gaiden spells of that type.
	cmp	r3, #0	@ UsingSpellMenu.74_1,
	beq	.L234		@,
@ RangeDisplay.c:42: 	u8* spells = SpellsGetter(unit,(UsingSpellMenu ? UsingSpellMenu : -1)); // If UsingSpellMenu is nonzero, only get Gaiden spells of that type.
	ldr	r3, .L241	@ tmp133,
	ldrb	r3, [r3]	@ UsingSpellMenu.75_2, UsingSpellMenu
	b	.L235		@
.L234:
@ RangeDisplay.c:42: 	u8* spells = SpellsGetter(unit,(UsingSpellMenu ? UsingSpellMenu : -1)); // If UsingSpellMenu is nonzero, only get Gaiden spells of that type.
	movs	r3, #1	@ tmp161,
	rsbs	r3, r3, #0	@ iftmp.73_19, tmp161
.L235:
@ RangeDisplay.c:42: 	u8* spells = SpellsGetter(unit,(UsingSpellMenu ? UsingSpellMenu : -1)); // If UsingSpellMenu is nonzero, only get Gaiden spells of that type.
	ldr	r2, [r7, #4]	@ tmp134, unit
	movs	r1, r3	@, iftmp.73_19
	movs	r0, r2	@, tmp134
	bl	SpellsGetter		@
	movs	r3, r0	@ tmp135,
	str	r3, [r7, #16]	@ tmp135, spells
@ RangeDisplay.c:43: 	for ( int i = 0 ; spells[i] ; i++ )
	movs	r3, #0	@ tmp136,
	str	r3, [r7, #20]	@ tmp136, i
@ RangeDisplay.c:43: 	for ( int i = 0 ; spells[i] ; i++ )
	b	.L236		@
.L239:
@ RangeDisplay.c:45: 		int spell = spells[i]|0xFF00;
	ldr	r3, [r7, #20]	@ i.76_3, i
	ldr	r2, [r7, #16]	@ tmp137, spells
	adds	r3, r2, r3	@ _4, tmp137, i.76_3
	ldrb	r3, [r3]	@ _5, *_4
	movs	r2, r3	@ _6, _5
@ RangeDisplay.c:45: 		int spell = spells[i]|0xFF00;
	movs	r3, #255	@ tmp160,
	lsls	r3, r3, #8	@ tmp139, tmp160,
	orrs	r3, r2	@ tmp138, _6
	str	r3, [r7, #12]	@ tmp138, spell
@ RangeDisplay.c:46: 		if ( usability == NULL )
	ldr	r3, [r7]	@ tmp140, usability
	cmp	r3, #0	@ tmp140,
	bne	.L237		@,
@ RangeDisplay.c:48: 			if ( CanCastSpell(unit,spell) ) { current = IncorporateNewRange(current,gGet_Item_Range(unit,spell)); }
	ldr	r2, [r7, #12]	@ tmp141, spell
	ldr	r3, [r7, #4]	@ tmp142, unit
	movs	r1, r2	@, tmp141
	movs	r0, r3	@, tmp142
	bl	CanCastSpell		@
	subs	r3, r0, #0	@ _7,,
@ RangeDisplay.c:48: 			if ( CanCastSpell(unit,spell) ) { current = IncorporateNewRange(current,gGet_Item_Range(unit,spell)); }
	beq	.L238		@,
@ RangeDisplay.c:48: 			if ( CanCastSpell(unit,spell) ) { current = IncorporateNewRange(current,gGet_Item_Range(unit,spell)); }
	ldr	r3, .L241+4	@ tmp143,
	ldr	r3, [r3]	@ gGet_Item_Range.77_8, gGet_Item_Range
	ldr	r1, [r7, #12]	@ tmp144, spell
	ldr	r2, [r7, #4]	@ tmp145, unit
	movs	r0, r2	@, tmp145
	bl	.L12		@
	movs	r2, r0	@ _9,
	movs	r3, r1	@ _9,
	ldr	r0, [r7, #24]	@ tmp146, current
	ldr	r1, [r7, #28]	@ tmp146, current
	bl	IncorporateNewRange		@
	movs	r2, r0	@ tmp147,
	movs	r3, r1	@,
	str	r2, [r7, #24]	@ tmp147, current
	str	r3, [r7, #28]	@ tmp147,
	b	.L238		@
.L237:
@ RangeDisplay.c:52: 			if ( usability(unit,spell) ) { current = IncorporateNewRange(current,gGet_Item_Range(unit,spell)); }
	ldr	r1, [r7, #12]	@ tmp148, spell
	ldr	r2, [r7, #4]	@ tmp149, unit
	ldr	r3, [r7]	@ tmp150, usability
	movs	r0, r2	@, tmp149
	bl	.L12		@
	subs	r3, r0, #0	@ _10,,
@ RangeDisplay.c:52: 			if ( usability(unit,spell) ) { current = IncorporateNewRange(current,gGet_Item_Range(unit,spell)); }
	beq	.L238		@,
@ RangeDisplay.c:52: 			if ( usability(unit,spell) ) { current = IncorporateNewRange(current,gGet_Item_Range(unit,spell)); }
	ldr	r3, .L241+4	@ tmp151,
	ldr	r3, [r3]	@ gGet_Item_Range.78_11, gGet_Item_Range
	ldr	r1, [r7, #12]	@ tmp152, spell
	ldr	r2, [r7, #4]	@ tmp153, unit
	movs	r0, r2	@, tmp153
	bl	.L12		@
	movs	r2, r0	@ _12,
	movs	r3, r1	@ _12,
	ldr	r0, [r7, #24]	@ tmp154, current
	ldr	r1, [r7, #28]	@ tmp154, current
	bl	IncorporateNewRange		@
	movs	r2, r0	@ tmp155,
	movs	r3, r1	@,
	str	r2, [r7, #24]	@ tmp155, current
	str	r3, [r7, #28]	@ tmp155,
.L238:
@ RangeDisplay.c:43: 	for ( int i = 0 ; spells[i] ; i++ )
	ldr	r3, [r7, #20]	@ tmp157, i
	adds	r3, r3, #1	@ tmp156,
	str	r3, [r7, #20]	@ tmp156, i
.L236:
@ RangeDisplay.c:43: 	for ( int i = 0 ; spells[i] ; i++ )
	ldr	r3, [r7, #20]	@ i.79_13, i
	ldr	r2, [r7, #16]	@ tmp158, spells
	adds	r3, r2, r3	@ _14, tmp158, i.79_13
	ldrb	r3, [r3]	@ _15, *_14
@ RangeDisplay.c:43: 	for ( int i = 0 ; spells[i] ; i++ )
	cmp	r3, #0	@ _15,
	bne	.L239		@,
@ RangeDisplay.c:55: 	return current;
	ldr	r2, [r7, #24]	@ _30, current
	ldr	r3, [r7, #28]	@ _30, current
@ RangeDisplay.c:56: }
	movs	r0, r2	@, <retval>
	movs	r1, r3	@, <retval>
	mov	sp, r7	@,
	add	sp, sp, #32	@,,
	@ sp needed	@
	pop	{r7}
	pop	{r2}
	bx	r2
.L242:
	.align	2
.L241:
	.word	UsingSpellMenu
	.word	gGet_Item_Range
	.size	GetUnitRangeMaskForSpells, .-GetUnitRangeMaskForSpells
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	IncorporateNewRange, %function
IncorporateNewRange:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 120
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, r7, lr}	@
	sub	sp, sp, #120	@,,
	add	r7, sp, #0	@,,
	str	r0, [r7, #72]	@ existing, existing
	str	r1, [r7, #76]	@ existing,
	str	r2, [r7, #64]	@ new, new
	str	r3, [r7, #68]	@ new,
@ RangeDisplay.c:60: 	u32 existingMask = existing & 0xFFFFFFFF;
	ldr	r3, [r7, #72]	@ tmp124, existing
	str	r3, [r7, #116]	@ tmp124, existingMask
@ RangeDisplay.c:61: 	u32 newMask = new & 0xFFFFFFFF;
	ldr	r3, [r7, #64]	@ tmp125, new
	str	r3, [r7, #112]	@ tmp125, newMask
@ RangeDisplay.c:62: 	long long existingMin = existing >> 40;
	ldr	r3, [r7, #76]	@ tmp127, existing
	asrs	r4, r3, #8	@ tmp126, tmp127,
	ldr	r3, [r7, #76]	@ tmp128, existing
	asrs	r5, r3, #31	@, tmp128,
	str	r4, [r7, #104]	@ tmp126, existingMin
	str	r5, [r7, #108]	@ tmp126,
@ RangeDisplay.c:63: 	long long newMin = new >> 40;
	ldr	r3, [r7, #68]	@ tmp130, new
	asrs	r3, r3, #8	@ tmp153, tmp130,
	str	r3, [r7]	@ tmp153, %sfp
	ldr	r3, [r7, #68]	@ tmp131, new
	asrs	r3, r3, #31	@ tmp154, tmp131,
	str	r3, [r7, #4]	@ tmp154, %sfp
	ldr	r3, [r7]	@ tmp129, %sfp
	ldr	r4, [r7, #4]	@ tmp129, %sfp
	str	r3, [r7, #96]	@ tmp129, newMin
	str	r4, [r7, #100]	@ tmp129,
@ RangeDisplay.c:64: 	long long existingMax = (existing >> 32) & 0xFF;
	ldr	r3, [r7, #76]	@ tmp132, existing
	asrs	r3, r3, #0	@ tmp156, tmp132,
	str	r3, [r7, #56]	@ tmp156, %sfp
	ldr	r3, [r7, #76]	@ tmp133, existing
	asrs	r3, r3, #31	@ tmp157, tmp133,
	str	r3, [r7, #60]	@ tmp157, %sfp
@ RangeDisplay.c:64: 	long long existingMax = (existing >> 32) & 0xFF;
	movs	r3, #255	@ tmp135,
	ldr	r1, [r7, #56]	@ _1, %sfp
	ldr	r2, [r7, #60]	@ _1, %sfp
	movs	r0, r1	@ tmp158, _1
	ands	r3, r0	@ tmp134, tmp158
	str	r3, [r7, #88]	@ tmp134, existingMax
	movs	r3, #0	@ tmp137,
	ands	r2, r3	@ tmp136, tmp137
	movs	r3, r2	@ tmp136, tmp136
	str	r3, [r7, #92]	@ tmp136, existingMax
@ RangeDisplay.c:65: 	long long newMax = (new >> 32) & 0xFF;
	ldr	r3, [r7, #68]	@ tmp138, new
	asrs	r3, r3, #0	@ tmp160, tmp138,
	str	r3, [r7, #48]	@ tmp160, %sfp
	ldr	r3, [r7, #68]	@ tmp139, new
	asrs	r3, r3, #31	@ tmp161, tmp139,
	str	r3, [r7, #52]	@ tmp161, %sfp
@ RangeDisplay.c:65: 	long long newMax = (new >> 32) & 0xFF;
	movs	r3, #255	@ tmp141,
	ldr	r1, [r7, #48]	@ _2, %sfp
	ldr	r2, [r7, #52]	@ _2, %sfp
	movs	r0, r1	@ tmp162, _2
	ands	r3, r0	@ tmp140, tmp162
	str	r3, [r7, #80]	@ tmp140, newMax
	movs	r3, #0	@ tmp143,
	ands	r2, r3	@ tmp142, tmp143
	movs	r3, r2	@ tmp142, tmp142
	str	r3, [r7, #84]	@ tmp142, newMax
@ RangeDisplay.c:66: 	return existingMask|newMask|(( newMin < existingMin ? newMin : existingMin ) << 40)|(( newMax > existingMax ? newMax : existingMax ) << 32);
	ldr	r2, [r7, #116]	@ tmp144, existingMask
	ldr	r3, [r7, #112]	@ tmp145, newMask
	orrs	r3, r2	@ _3, tmp144
	str	r3, [r7, #40]	@ _3, %sfp
	movs	r3, #0	@ tmp146,
	str	r3, [r7, #44]	@ tmp146, %sfp
@ RangeDisplay.c:66: 	return existingMask|newMask|(( newMin < existingMin ? newMin : existingMin ) << 40)|(( newMax > existingMax ? newMax : existingMax ) << 32);
	ldr	r0, [r7, #96]	@ tmp147, newMin
	ldr	r1, [r7, #100]	@ tmp147, newMin
	ldr	r2, [r7, #104]	@ _5, existingMin
	ldr	r3, [r7, #108]	@ _5, existingMin
	cmp	r3, r1	@ _5,
	bgt	.L245		@,
	bne	.L244		@,
	cmp	r2, r0	@ _5, tmp147
	bls	.L244		@,
.L245:
	movs	r2, r0	@ _5, tmp147
	movs	r3, r1	@ _5,
.L244:
@ RangeDisplay.c:66: 	return existingMask|newMask|(( newMin < existingMin ? newMin : existingMin ) << 40)|(( newMax > existingMax ? newMax : existingMax ) << 32);
	lsls	r3, r2, #8	@ tmp164, _5,
	str	r3, [r7, #36]	@ tmp164, %sfp
	movs	r3, #0	@ tmp148,
	str	r3, [r7, #32]	@ tmp148, %sfp
@ RangeDisplay.c:66: 	return existingMask|newMask|(( newMin < existingMin ? newMin : existingMin ) << 40)|(( newMax > existingMax ? newMax : existingMax ) << 32);
	ldr	r1, [r7, #40]	@ _4, %sfp
	ldr	r2, [r7, #44]	@ _4, %sfp
	movs	r0, r1	@ tmp165, _4
	ldr	r3, [r7, #32]	@ _6, %sfp
	ldr	r4, [r7, #36]	@ _6, %sfp
	movs	r5, r3	@ tmp166, _6
	orrs	r0, r5	@ tmp165, tmp166
	str	r0, [r7, #24]	@ tmp165, %sfp
	movs	r3, r4	@ tmp168, _6
	orrs	r2, r3	@ tmp167, tmp168
	str	r2, [r7, #28]	@ tmp167, %sfp
@ RangeDisplay.c:66: 	return existingMask|newMask|(( newMin < existingMin ? newMin : existingMin ) << 40)|(( newMax > existingMax ? newMax : existingMax ) << 32);
	ldr	r0, [r7, #80]	@ tmp149, newMax
	ldr	r1, [r7, #84]	@ tmp149, newMax
	ldr	r2, [r7, #88]	@ _8, existingMax
	ldr	r3, [r7, #92]	@ _8, existingMax
	cmp	r1, r3	@, _8
	bgt	.L247		@,
	bne	.L246		@,
	cmp	r0, r2	@ tmp149, _8
	bls	.L246		@,
.L247:
	movs	r2, r0	@ _8, tmp149
	movs	r3, r1	@ _8,
.L246:
@ RangeDisplay.c:66: 	return existingMask|newMask|(( newMin < existingMin ? newMin : existingMin ) << 40)|(( newMax > existingMax ? newMax : existingMax ) << 32);
	lsls	r3, r2, #0	@ tmp169, _8,
	str	r3, [r7, #20]	@ tmp169, %sfp
	movs	r3, #0	@ tmp150,
	str	r3, [r7, #16]	@ tmp150, %sfp
@ RangeDisplay.c:66: 	return existingMask|newMask|(( newMin < existingMin ? newMin : existingMin ) << 40)|(( newMax > existingMax ? newMax : existingMax ) << 32);
	ldr	r1, [r7, #24]	@ _7, %sfp
	ldr	r2, [r7, #28]	@ _7, %sfp
	movs	r0, r1	@ tmp170, _7
	ldr	r3, [r7, #16]	@ _9, %sfp
	ldr	r4, [r7, #20]	@ _9, %sfp
	movs	r5, r3	@ tmp171, _9
	orrs	r0, r5	@ tmp170, tmp171
	str	r0, [r7, #8]	@ tmp170, %sfp
	movs	r3, r4	@ tmp173, _9
	orrs	r2, r3	@ tmp172, tmp173
	str	r2, [r7, #12]	@ tmp172, %sfp
	ldr	r2, [r7, #8]	@ <retval>, %sfp
	ldr	r3, [r7, #12]	@ <retval>, %sfp
@ RangeDisplay.c:67: }
	movs	r0, r2	@, <retval>
	movs	r1, r3	@, <retval>
	mov	sp, r7	@,
	add	sp, sp, #120	@,,
	@ sp needed	@
	pop	{r4, r5, r7}
	pop	{r2}
	bx	r2
	.size	IncorporateNewRange, .-IncorporateNewRange
	.align	1
	.global	RangeUsabilityCheckStaff
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	RangeUsabilityCheckStaff, %function
RangeUsabilityCheckStaff:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}	@
	sub	sp, sp, #8	@,,
	add	r7, sp, #0	@,,
	str	r0, [r7, #4]	@ unit, unit
	str	r1, [r7]	@ item, item
@ RangeDisplay.c:72: 	return GetItemType(item) == ITYPE_STAFF && CanCastSpell(unit,item);
	ldr	r3, [r7]	@ tmp117, item
	movs	r0, r3	@, tmp117
	ldr	r3, .L253	@ tmp118,
	bl	.L12		@
	movs	r3, r0	@ _1,
@ RangeDisplay.c:72: 	return GetItemType(item) == ITYPE_STAFF && CanCastSpell(unit,item);
	cmp	r3, #4	@ _1,
	bne	.L250		@,
@ RangeDisplay.c:72: 	return GetItemType(item) == ITYPE_STAFF && CanCastSpell(unit,item);
	ldr	r2, [r7]	@ tmp119, item
	ldr	r3, [r7, #4]	@ tmp120, unit
	movs	r1, r2	@, tmp119
	movs	r0, r3	@, tmp120
	bl	CanCastSpell		@
	subs	r3, r0, #0	@ _2,,
@ RangeDisplay.c:72: 	return GetItemType(item) == ITYPE_STAFF && CanCastSpell(unit,item);
	beq	.L250		@,
@ RangeDisplay.c:72: 	return GetItemType(item) == ITYPE_STAFF && CanCastSpell(unit,item);
	movs	r3, #1	@ iftmp.80_3,
	b	.L252		@
.L250:
@ RangeDisplay.c:72: 	return GetItemType(item) == ITYPE_STAFF && CanCastSpell(unit,item);
	movs	r3, #0	@ iftmp.80_3,
.L252:
@ RangeDisplay.c:73: }
	movs	r0, r3	@, <retval>
	mov	sp, r7	@,
	add	sp, sp, #8	@,,
	@ sp needed	@
	pop	{r7}
	pop	{r1}
	bx	r1
.L254:
	.align	2
.L253:
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
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}	@
	sub	sp, sp, #8	@,,
	add	r7, sp, #0	@,,
	str	r0, [r7, #4]	@ unit, unit
	str	r1, [r7]	@ item, item
@ RangeDisplay.c:77: 	return GetItemType(item) != ITYPE_STAFF && CanCastSpell(unit,item);
	ldr	r3, [r7]	@ tmp117, item
	movs	r0, r3	@, tmp117
	ldr	r3, .L259	@ tmp118,
	bl	.L12		@
	movs	r3, r0	@ _1,
@ RangeDisplay.c:77: 	return GetItemType(item) != ITYPE_STAFF && CanCastSpell(unit,item);
	cmp	r3, #4	@ _1,
	beq	.L256		@,
@ RangeDisplay.c:77: 	return GetItemType(item) != ITYPE_STAFF && CanCastSpell(unit,item);
	ldr	r2, [r7]	@ tmp119, item
	ldr	r3, [r7, #4]	@ tmp120, unit
	movs	r1, r2	@, tmp119
	movs	r0, r3	@, tmp120
	bl	CanCastSpell		@
	subs	r3, r0, #0	@ _2,,
@ RangeDisplay.c:77: 	return GetItemType(item) != ITYPE_STAFF && CanCastSpell(unit,item);
	beq	.L256		@,
@ RangeDisplay.c:77: 	return GetItemType(item) != ITYPE_STAFF && CanCastSpell(unit,item);
	movs	r3, #1	@ iftmp.81_3,
	b	.L258		@
.L256:
@ RangeDisplay.c:77: 	return GetItemType(item) != ITYPE_STAFF && CanCastSpell(unit,item);
	movs	r3, #0	@ iftmp.81_3,
.L258:
@ RangeDisplay.c:78: }
	movs	r0, r3	@, <retval>
	mov	sp, r7	@,
	add	sp, sp, #8	@,,
	@ sp needed	@
	pop	{r7}
	pop	{r1}
	bx	r1
.L260:
	.align	2
.L259:
	.word	GetItemType
	.size	RangeUsabilityCheckNotStaff, .-RangeUsabilityCheckNotStaff
	.align	1
	.global	All_Spells_One_Square
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	All_Spells_One_Square, %function
All_Spells_One_Square:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r7, lr}	@
	sub	sp, sp, #20	@,,
	add	r7, sp, #0	@,,
	str	r0, [r7, #4]	@ unit, unit
	str	r1, [r7]	@ usability, usability
@ RangeDisplay.c:82: 	asm("push { r7 }");
	.syntax divided
@ 82 "RangeDisplay.c" 1
	push { r7 }
@ 0 "" 2
@ RangeDisplay.c:83: 	long long mask = Return_Range_Bitfield(unit,9,usability);
	.thumb
	.syntax unified
	ldr	r2, [r7]	@ tmp118, usability
	ldr	r3, [r7, #4]	@ tmp119, unit
	movs	r1, #9	@,
	movs	r0, r3	@, tmp119
	bl	Return_Range_Bitfield		@
	movs	r2, r0	@ tmp120,
	movs	r3, r1	@,
	str	r2, [r7, #8]	@ tmp120, mask
	str	r3, [r7, #12]	@ tmp120,
@ RangeDisplay.c:84: 	asm("mov r7, #0x00\nmov r12, r7"); // Write_Range takes this parameter through r12?
	.syntax divided
@ 84 "RangeDisplay.c" 1
	mov r7, #0x00
mov r12, r7
@ 0 "" 2
@ RangeDisplay.c:85: 	gWrite_Range(unit->xPos,unit->yPos,mask);
	.thumb
	.syntax unified
	ldr	r3, .L262	@ tmp121,
	ldr	r4, [r3]	@ gWrite_Range.82_1, gWrite_Range
@ RangeDisplay.c:85: 	gWrite_Range(unit->xPos,unit->yPos,mask);
	ldr	r3, [r7, #4]	@ tmp122, unit
	ldrb	r3, [r3, #16]	@ _2,
	lsls	r3, r3, #24	@ _2, _2,
	asrs	r3, r3, #24	@ _2, _2,
@ RangeDisplay.c:85: 	gWrite_Range(unit->xPos,unit->yPos,mask);
	movs	r0, r3	@ _3, _2
@ RangeDisplay.c:85: 	gWrite_Range(unit->xPos,unit->yPos,mask);
	ldr	r3, [r7, #4]	@ tmp123, unit
	ldrb	r3, [r3, #17]	@ _4,
	lsls	r3, r3, #24	@ _4, _4,
	asrs	r3, r3, #24	@ _4, _4,
@ RangeDisplay.c:85: 	gWrite_Range(unit->xPos,unit->yPos,mask);
	movs	r1, r3	@ _5, _4
	ldr	r2, [r7, #8]	@ tmp124, mask
	ldr	r3, [r7, #12]	@ tmp124, mask
	bl	.L47		@
@ RangeDisplay.c:86: 	asm("pop { r7 }");
	.syntax divided
@ 86 "RangeDisplay.c" 1
	pop { r7 }
@ 0 "" 2
@ RangeDisplay.c:87: }
	.thumb
	.syntax unified
	nop	
	mov	sp, r7	@,
	add	sp, sp, #20	@,,
	@ sp needed	@
	pop	{r4, r7}
	pop	{r0}
	bx	r0
.L263:
	.align	2
.L262:
	.word	gWrite_Range
	.size	All_Spells_One_Square, .-All_Spells_One_Square
	.align	1
	.global	SpellUsability
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	SpellUsability, %function
SpellUsability:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r7, lr}	@
	sub	sp, sp, #28	@,,
	add	r7, sp, #0	@,,
	str	r0, [r7, #12]	@ menuEntry, menuEntry
	str	r1, [r7, #8]	@ index, index
	str	r2, [r7, #4]	@ idk, idk
@ SpellMenu.c:5: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,index,UsingSpellMenu)];
	ldr	r3, .L270	@ tmp130,
	ldr	r2, [r3]	@ gActiveUnit.83_1, gActiveUnit
	ldr	r3, .L270+4	@ tmp131,
	ldrb	r3, [r3]	@ UsingSpellMenu.84_2, UsingSpellMenu
	movs	r1, r3	@, _3
	movs	r0, r2	@, gActiveUnit.83_1
	bl	SpellsGetter		@
	movs	r4, r0	@ _4,
@ SpellMenu.c:5: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,index,UsingSpellMenu)];
	ldr	r3, .L270	@ tmp132,
	ldr	r0, [r3]	@ gActiveUnit.85_5, gActiveUnit
	ldr	r3, .L270+4	@ tmp133,
	ldrb	r3, [r3]	@ UsingSpellMenu.86_6, UsingSpellMenu
	movs	r2, r3	@ _7, UsingSpellMenu.86_6
	ldr	r3, [r7, #8]	@ tmp134, index
	movs	r1, r3	@, tmp134
	bl	GetNthUsableSpell		@
	movs	r3, r0	@ _8,
@ SpellMenu.c:5: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,index,UsingSpellMenu)];
	adds	r3, r4, r3	@ _10, _4, _9
	ldrb	r3, [r3]	@ _11, *_10
@ SpellMenu.c:5: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,index,UsingSpellMenu)];
	str	r3, [r7, #20]	@ _11, spell
@ SpellMenu.c:6: 	if ( !spell ) { return 3; }
	ldr	r3, [r7, #20]	@ tmp135, spell
	cmp	r3, #0	@ tmp135,
	bne	.L265		@,
@ SpellMenu.c:6: 	if ( !spell ) { return 3; }
	movs	r3, #3	@ iftmp.88_17,
	b	.L266		@
.L265:
@ SpellMenu.c:8: 	if ( !CanCastSpellNow(gActiveUnit,spell) ) { return 3; }
	ldr	r3, .L270	@ tmp136,
	ldr	r3, [r3]	@ gActiveUnit.87_12, gActiveUnit
	ldr	r2, [r7, #20]	@ tmp137, spell
	movs	r1, r2	@, tmp137
	movs	r0, r3	@, gActiveUnit.87_12
	bl	CanCastSpellNow		@
	subs	r3, r0, #0	@ _13,,
@ SpellMenu.c:8: 	if ( !CanCastSpellNow(gActiveUnit,spell) ) { return 3; }
	bne	.L267		@,
@ SpellMenu.c:8: 	if ( !CanCastSpellNow(gActiveUnit,spell) ) { return 3; }
	movs	r3, #3	@ iftmp.88_17,
	b	.L266		@
.L267:
@ SpellMenu.c:10: 	return ( HasSufficientHP(gActiveUnit,spell) ? 1 : 2 );
	ldr	r3, .L270	@ tmp138,
	ldr	r3, [r3]	@ gActiveUnit.89_14, gActiveUnit
	ldr	r2, [r7, #20]	@ tmp139, spell
	movs	r1, r2	@, tmp139
	movs	r0, r3	@, gActiveUnit.89_14
	bl	HasSufficientHP		@
	subs	r3, r0, #0	@ _15,,
@ SpellMenu.c:10: 	return ( HasSufficientHP(gActiveUnit,spell) ? 1 : 2 );
	beq	.L268		@,
@ SpellMenu.c:10: 	return ( HasSufficientHP(gActiveUnit,spell) ? 1 : 2 );
	movs	r3, #1	@ iftmp.88_17,
	b	.L266		@
.L268:
@ SpellMenu.c:10: 	return ( HasSufficientHP(gActiveUnit,spell) ? 1 : 2 );
	movs	r3, #2	@ iftmp.88_17,
.L266:
@ SpellMenu.c:11: }
	movs	r0, r3	@, <retval>
	mov	sp, r7	@,
	add	sp, sp, #28	@,,
	@ sp needed	@
	pop	{r4, r7}
	pop	{r1}
	bx	r1
.L271:
	.align	2
.L270:
	.word	gActiveUnit
	.word	UsingSpellMenu
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
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r7, lr}	@
	sub	sp, sp, #20	@,,
	add	r7, sp, #0	@,,
	str	r0, [r7, #4]	@ menu, menu
	str	r1, [r7]	@ menuCommand, menuCommand
@ SpellMenu.c:16: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,menuCommand->commandDefinitionIndex,UsingSpellMenu)];
	ldr	r3, .L274	@ tmp138,
	ldr	r2, [r3]	@ gActiveUnit.90_1, gActiveUnit
	ldr	r3, .L274+4	@ tmp139,
	ldrb	r3, [r3]	@ UsingSpellMenu.91_2, UsingSpellMenu
	movs	r1, r3	@, _3
	movs	r0, r2	@, gActiveUnit.90_1
	bl	SpellsGetter		@
	movs	r4, r0	@ _4,
@ SpellMenu.c:16: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,menuCommand->commandDefinitionIndex,UsingSpellMenu)];
	ldr	r3, .L274	@ tmp140,
	ldr	r0, [r3]	@ gActiveUnit.92_5, gActiveUnit
@ SpellMenu.c:16: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,menuCommand->commandDefinitionIndex,UsingSpellMenu)];
	ldr	r3, [r7]	@ tmp141, menuCommand
	movs	r2, #60	@ tmp142,
	ldrb	r3, [r3, r2]	@ _6,
@ SpellMenu.c:16: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,menuCommand->commandDefinitionIndex,UsingSpellMenu)];
	movs	r1, r3	@ _7, _6
	ldr	r3, .L274+4	@ tmp143,
	ldrb	r3, [r3]	@ UsingSpellMenu.93_8, UsingSpellMenu
	movs	r2, r3	@, _9
	bl	GetNthUsableSpell		@
	movs	r3, r0	@ _10,
@ SpellMenu.c:16: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,menuCommand->commandDefinitionIndex,UsingSpellMenu)];
	adds	r3, r4, r3	@ _12, _4, _11
	ldrb	r3, [r3]	@ _13, *_12
@ SpellMenu.c:16: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,menuCommand->commandDefinitionIndex,UsingSpellMenu)];
	str	r3, [r7, #12]	@ _13, spell
@ SpellMenu.c:18: 	int canUse = HasSufficientHP(gActiveUnit,spell);
	ldr	r3, .L274	@ tmp144,
	ldr	r3, [r3]	@ gActiveUnit.94_14, gActiveUnit
	ldr	r2, [r7, #12]	@ tmp145, spell
	movs	r1, r2	@, tmp145
	movs	r0, r3	@, gActiveUnit.94_14
	bl	HasSufficientHP		@
	movs	r3, r0	@ tmp146,
	str	r3, [r7, #8]	@ tmp146, canUse
@ SpellMenu.c:19: 	DrawItemMenuCommand(&menuCommand->text,spell,canUse,&gBg0MapBuffer[menuCommand->yDrawTile * 32 + menuCommand->xDrawTile]);
	ldr	r3, [r7]	@ tmp147, menuCommand
	adds	r3, r3, #52	@ tmp147,
	movs	r0, r3	@ _15, tmp147
@ SpellMenu.c:19: 	DrawItemMenuCommand(&menuCommand->text,spell,canUse,&gBg0MapBuffer[menuCommand->yDrawTile * 32 + menuCommand->xDrawTile]);
	ldr	r3, [r7, #12]	@ tmp149, spell
	lsls	r3, r3, #16	@ tmp150, tmp148,
	lsrs	r1, r3, #16	@ _16, tmp150,
@ SpellMenu.c:19: 	DrawItemMenuCommand(&menuCommand->text,spell,canUse,&gBg0MapBuffer[menuCommand->yDrawTile * 32 + menuCommand->xDrawTile]);
	ldr	r3, [r7]	@ tmp151, menuCommand
	ldrh	r3, [r3, #44]	@ _17,
@ SpellMenu.c:19: 	DrawItemMenuCommand(&menuCommand->text,spell,canUse,&gBg0MapBuffer[menuCommand->yDrawTile * 32 + menuCommand->xDrawTile]);
	lsls	r3, r3, #5	@ _19, _18,
@ SpellMenu.c:19: 	DrawItemMenuCommand(&menuCommand->text,spell,canUse,&gBg0MapBuffer[menuCommand->yDrawTile * 32 + menuCommand->xDrawTile]);
	ldr	r2, [r7]	@ tmp152, menuCommand
	ldrh	r2, [r2, #42]	@ _20,
@ SpellMenu.c:19: 	DrawItemMenuCommand(&menuCommand->text,spell,canUse,&gBg0MapBuffer[menuCommand->yDrawTile * 32 + menuCommand->xDrawTile]);
	adds	r3, r3, r2	@ _22, _19, _21
@ SpellMenu.c:19: 	DrawItemMenuCommand(&menuCommand->text,spell,canUse,&gBg0MapBuffer[menuCommand->yDrawTile * 32 + menuCommand->xDrawTile]);
	lsls	r2, r3, #1	@ tmp153, _22,
	ldr	r3, .L274+8	@ tmp154,
	adds	r3, r2, r3	@ _23, tmp153, tmp154
	ldr	r2, [r7, #8]	@ tmp155, canUse
	ldr	r4, .L274+12	@ tmp156,
	bl	.L47		@
@ SpellMenu.c:20: 	EnableBgSyncByMask(1);
	movs	r0, #1	@,
	ldr	r3, .L274+16	@ tmp157,
	bl	.L12		@
@ SpellMenu.c:21: 	return 0;
	movs	r3, #0	@ _33,
@ SpellMenu.c:22: }
	movs	r0, r3	@, <retval>
	mov	sp, r7	@,
	add	sp, sp, #20	@,,
	@ sp needed	@
	pop	{r4, r7}
	pop	{r1}
	bx	r1
.L275:
	.align	2
.L274:
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
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r7, lr}	@
	sub	sp, sp, #12	@,,
	add	r7, sp, #0	@,,
@ SpellMenu.c:28: 	Unit* unit = gActiveUnit;
	ldr	r3, .L278	@ tmp122,
	ldr	r3, [r3]	@ tmp123, gActiveUnit
	str	r3, [r7, #4]	@ tmp123, unit
@ SpellMenu.c:29: 	unit->state &= ~(1UL << 30); // Always clear capturing bit if leaving menu 
	ldr	r3, [r7, #4]	@ tmp124, unit
	ldr	r3, [r3, #12]	@ _1, unit_9->state
	ldr	r2, .L278+4	@ tmp125,
	ands	r2, r3	@ _2, _1
	ldr	r3, [r7, #4]	@ tmp126, unit
	str	r2, [r3, #12]	@ _2, unit_9->state
@ SpellMenu.c:32: 	FillBgMap(gBg2MapBuffer,0);
	ldr	r3, .L278+8	@ tmp127,
	movs	r1, #0	@,
	movs	r0, r3	@, tmp127
	ldr	r3, .L278+12	@ tmp128,
	bl	.L12		@
@ SpellMenu.c:33: 	EnableBgSyncByMask(4);
	movs	r0, #4	@,
	ldr	r3, .L278+16	@ tmp129,
	bl	.L12		@
@ SpellMenu.c:34: 	Text_ResetTileAllocation();
	ldr	r3, .L278+20	@ tmp130,
	bl	.L12		@
@ SpellMenu.c:36: 	StartMenu_AndDoSomethingCommands(&gMenu_UnitMenu,gGameState._unk1C.x - gGameState.cameraRealPos.x,1,16);
	ldr	r3, .L278+24	@ tmp131,
	ldrh	r3, [r3, #28]	@ _3,
	movs	r2, r3	@ _4, _3
@ SpellMenu.c:36: 	StartMenu_AndDoSomethingCommands(&gMenu_UnitMenu,gGameState._unk1C.x - gGameState.cameraRealPos.x,1,16);
	ldr	r3, .L278+24	@ tmp132,
	ldrh	r3, [r3, #12]	@ _5,
@ SpellMenu.c:36: 	StartMenu_AndDoSomethingCommands(&gMenu_UnitMenu,gGameState._unk1C.x - gGameState.cameraRealPos.x,1,16);
	subs	r1, r2, r3	@ _7, _4, _6
	ldr	r0, .L278+28	@ tmp133,
	movs	r3, #16	@,
	movs	r2, #1	@,
	ldr	r4, .L278+32	@ tmp134,
	bl	.L47		@
@ SpellMenu.c:37: 	HideMoveRangeGraphics();
	ldr	r3, .L278+36	@ tmp135,
	bl	.L12		@
@ SpellMenu.c:38: 	SelectedSpell = 0;
	ldr	r3, .L278+40	@ tmp136,
	movs	r2, #0	@ tmp137,
	strb	r2, [r3]	@ tmp138, SelectedSpell
@ SpellMenu.c:39: 	UsingSpellMenu = 0;
	ldr	r3, .L278+44	@ tmp139,
	movs	r2, #0	@ tmp140,
	strb	r2, [r3]	@ tmp141, UsingSpellMenu
@ SpellMenu.c:40: 	return 0x3B;
	movs	r3, #59	@ _18,
@ SpellMenu.c:41: }
	movs	r0, r3	@, <retval>
	mov	sp, r7	@,
	add	sp, sp, #12	@,,
	@ sp needed	@
	pop	{r4, r7}
	pop	{r1}
	bx	r1
.L279:
	.align	2
.L278:
	.word	gActiveUnit
	.word	-1073741825
	.word	gBg2MapBuffer
	.word	FillBgMap
	.word	EnableBgSyncByMask
	.word	Text_ResetTileAllocation
	.word	gGameState
	.word	gMenu_UnitMenu
	.word	StartMenu_AndDoSomethingCommands
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
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}	@
	sub	sp, sp, #24	@,,
	add	r7, sp, #0	@,,
	str	r0, [r7, #4]	@ proc, proc
	str	r1, [r7]	@ commandProc, commandProc
@ SpellMenu.c:45: 	if ( commandProc->availability == 2)
	ldr	r3, [r7]	@ tmp134, commandProc
	movs	r2, #61	@ tmp135,
	ldrb	r3, [r3, r2]	@ _1,
@ SpellMenu.c:45: 	if ( commandProc->availability == 2)
	cmp	r3, #2	@ _1,
	bne	.L281		@,
@ SpellMenu.c:48: 		MenuCallHelpBox(proc,gGaidenMagicSpellMenuErrorText);
	ldr	r3, .L289	@ tmp136,
	ldrh	r2, [r3]	@ gGaidenMagicSpellMenuErrorText.95_2, gGaidenMagicSpellMenuErrorText
	ldr	r3, [r7, #4]	@ tmp137, proc
	movs	r1, r2	@, gGaidenMagicSpellMenuErrorText.95_2
	movs	r0, r3	@, tmp137
	ldr	r3, .L289+4	@ tmp138,
	bl	.L12		@
@ SpellMenu.c:49: 		return 0x08;
	movs	r3, #8	@ _21,
	b	.L282		@
.L281:
@ SpellMenu.c:53: 		Unit* unit = gActiveUnit;
	ldr	r3, .L289+8	@ tmp139,
	ldr	r3, [r3]	@ tmp140, gActiveUnit
	str	r3, [r7, #16]	@ tmp140, unit
@ SpellMenu.c:54: 		if ( unit->ranks[0] != SelectedSpell) 
	ldr	r3, [r7, #16]	@ tmp141, unit
	movs	r2, #40	@ tmp142,
	ldrb	r2, [r3, r2]	@ _3,
@ SpellMenu.c:54: 		if ( unit->ranks[0] != SelectedSpell) 
	ldr	r3, .L289+12	@ tmp143,
	ldrb	r3, [r3]	@ SelectedSpell.96_4, SelectedSpell
@ SpellMenu.c:54: 		if ( unit->ranks[0] != SelectedSpell) 
	cmp	r2, r3	@ _3, SelectedSpell.96_4
	beq	.L283		@,
@ SpellMenu.c:56: 		int PreviousSelection = unit->ranks[0]; // save 
	ldr	r3, [r7, #16]	@ tmp144, unit
	movs	r2, #40	@ tmp145,
	ldrb	r3, [r3, r2]	@ _5,
@ SpellMenu.c:56: 		int PreviousSelection = unit->ranks[0]; // save 
	str	r3, [r7, #12]	@ _5, PreviousSelection
@ SpellMenu.c:57: 		for ( int i = 1 ; i < 5 ; i++ ) 
	movs	r3, #1	@ tmp146,
	str	r3, [r7, #20]	@ tmp146, i
@ SpellMenu.c:57: 		for ( int i = 1 ; i < 5 ; i++ ) 
	b	.L284		@
.L286:
@ SpellMenu.c:59: 			if (unit->ranks[i] == SelectedSpell) 
	ldr	r2, [r7, #16]	@ tmp147, unit
	movs	r1, #40	@ tmp148,
	ldr	r3, [r7, #20]	@ tmp150, i
	adds	r3, r2, r3	@ tmp149, tmp147, tmp150
	adds	r3, r3, r1	@ tmp151, tmp149, tmp148
	ldrb	r2, [r3]	@ _6, *unit_29
@ SpellMenu.c:59: 			if (unit->ranks[i] == SelectedSpell) 
	ldr	r3, .L289+12	@ tmp152,
	ldrb	r3, [r3]	@ SelectedSpell.97_7, SelectedSpell
@ SpellMenu.c:59: 			if (unit->ranks[i] == SelectedSpell) 
	cmp	r2, r3	@ _6, SelectedSpell.97_7
	bne	.L285		@,
@ SpellMenu.c:61: 			unit->ranks[i] = PreviousSelection;
	ldr	r3, [r7, #12]	@ tmp154, PreviousSelection
	lsls	r3, r3, #24	@ tmp155, tmp153,
	lsrs	r0, r3, #24	@ _8, tmp155,
	ldr	r2, [r7, #16]	@ tmp156, unit
	movs	r1, #40	@ tmp157,
	ldr	r3, [r7, #20]	@ tmp159, i
	adds	r3, r2, r3	@ tmp158, tmp156, tmp159
	adds	r3, r3, r1	@ tmp160, tmp158, tmp157
	adds	r2, r0, #0	@ tmp161, _8
	strb	r2, [r3]	@ tmp161, unit_29->ranks[i_20]
@ SpellMenu.c:62: 			unit->ranks[0] = SelectedSpell;
	ldr	r3, .L289+12	@ tmp162,
	ldrb	r1, [r3]	@ SelectedSpell.98_9, SelectedSpell
	ldr	r3, [r7, #16]	@ tmp163, unit
	movs	r2, #40	@ tmp164,
	strb	r1, [r3, r2]	@ tmp165, unit_29->ranks[0]
.L285:
@ SpellMenu.c:57: 		for ( int i = 1 ; i < 5 ; i++ ) 
	ldr	r3, [r7, #20]	@ tmp167, i
	adds	r3, r3, #1	@ tmp166,
	str	r3, [r7, #20]	@ tmp166, i
.L284:
@ SpellMenu.c:57: 		for ( int i = 1 ; i < 5 ; i++ ) 
	ldr	r3, [r7, #20]	@ tmp168, i
	cmp	r3, #4	@ tmp168,
	ble	.L286		@,
.L283:
@ SpellMenu.c:83: 		gActionData.itemSlotIndex = 0;
	ldr	r3, .L289+16	@ tmp169,
	movs	r2, #0	@ tmp170,
	strb	r2, [r3, #18]	@ tmp171, gActionData.itemSlotIndex
@ SpellMenu.c:84: 		DidSelectSpell = 1;
	ldr	r3, .L289+20	@ tmp172,
	movs	r2, #1	@ tmp173,
	strb	r2, [r3]	@ tmp174, DidSelectSpell
@ SpellMenu.c:85: 		ClearBG0BG1();
	ldr	r3, .L289+24	@ tmp175,
	bl	.L12		@
@ SpellMenu.c:86: 		int type = GetItemType(SelectedSpell);
	ldr	r3, .L289+12	@ tmp176,
	ldrb	r3, [r3]	@ SelectedSpell.99_10, SelectedSpell
	movs	r0, r3	@, _11
	ldr	r3, .L289+28	@ tmp177,
	bl	.L12		@
	movs	r3, r0	@ tmp178,
	str	r3, [r7, #8]	@ tmp178, type
@ SpellMenu.c:87: 		if ( type != ITYPE_STAFF )
	ldr	r3, [r7, #8]	@ tmp179, type
	cmp	r3, #4	@ tmp179,
	beq	.L287		@,
@ SpellMenu.c:93: 			MakeTargetListForWeapon(gActiveUnit,SelectedSpell|0xFF00);
	ldr	r3, .L289+8	@ tmp180,
	ldr	r2, [r3]	@ gActiveUnit.100_12, gActiveUnit
	ldr	r3, .L289+12	@ tmp181,
	ldrb	r3, [r3]	@ SelectedSpell.101_13, SelectedSpell
	movs	r1, r3	@ _14, SelectedSpell.101_13
	movs	r3, #255	@ tmp192,
	lsls	r3, r3, #8	@ tmp182, tmp192,
	orrs	r3, r1	@ _15, _14
	movs	r1, r3	@, _15
	movs	r0, r2	@, gActiveUnit.100_12
	ldr	r3, .L289+32	@ tmp183,
	bl	.L12		@
@ SpellMenu.c:94: 			StartTargetSelection(&SpellTargetSelection);
	ldr	r3, .L289+36	@ tmp184,
	movs	r0, r3	@, tmp184
	ldr	r3, .L289+40	@ tmp185,
	bl	.L12		@
	b	.L288		@
.L287:
@ SpellMenu.c:98: 			ItemEffect_Call(gActiveUnit,SelectedSpell|0xFF00);
	ldr	r3, .L289+8	@ tmp186,
	ldr	r2, [r3]	@ gActiveUnit.102_16, gActiveUnit
	ldr	r3, .L289+12	@ tmp187,
	ldrb	r3, [r3]	@ SelectedSpell.103_17, SelectedSpell
	movs	r1, r3	@ _18, SelectedSpell.103_17
	movs	r3, #255	@ tmp191,
	lsls	r3, r3, #8	@ tmp188, tmp191,
	orrs	r3, r1	@ _19, _18
	movs	r1, r3	@, _19
	movs	r0, r2	@, gActiveUnit.102_16
	ldr	r3, .L289+44	@ tmp189,
	bl	.L12		@
.L288:
@ SpellMenu.c:100: 		return 0x27;
	movs	r3, #39	@ _21,
.L282:
@ SpellMenu.c:102: }
	movs	r0, r3	@, <retval>
	mov	sp, r7	@,
	add	sp, sp, #24	@,,
	@ sp needed	@
	pop	{r7}
	pop	{r1}
	bx	r1
.L290:
	.align	2
.L289:
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
	@ args = 0, pretend = 0, frame = 48
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}	@
	sub	sp, sp, #60	@,,
	add	r7, sp, #8	@,,
	str	r0, [r7, #4]	@ proc, proc
@ SpellMenu.c:106: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,proc->commandIndex,UsingSpellMenu)];
	ldr	r3, .L305	@ tmp192,
	ldr	r2, [r3]	@ gActiveUnit.104_1, gActiveUnit
	ldr	r3, .L305+4	@ tmp193,
	ldrb	r3, [r3]	@ UsingSpellMenu.105_2, UsingSpellMenu
	movs	r1, r3	@, _3
	movs	r0, r2	@, gActiveUnit.104_1
	bl	SpellsGetter		@
	movs	r4, r0	@ _4,
@ SpellMenu.c:106: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,proc->commandIndex,UsingSpellMenu)];
	ldr	r3, .L305	@ tmp194,
	ldr	r0, [r3]	@ gActiveUnit.106_5, gActiveUnit
@ SpellMenu.c:106: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,proc->commandIndex,UsingSpellMenu)];
	ldr	r3, [r7, #4]	@ tmp195, proc
	movs	r2, #97	@ tmp196,
	ldrb	r3, [r3, r2]	@ _6,
@ SpellMenu.c:106: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,proc->commandIndex,UsingSpellMenu)];
	movs	r1, r3	@ _7, _6
	ldr	r3, .L305+4	@ tmp197,
	ldrb	r3, [r3]	@ UsingSpellMenu.107_8, UsingSpellMenu
	movs	r2, r3	@, _9
	bl	GetNthUsableSpell		@
	movs	r3, r0	@ _10,
@ SpellMenu.c:106: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,proc->commandIndex,UsingSpellMenu)];
	adds	r3, r4, r3	@ _12, _4, _11
	ldrb	r3, [r3]	@ _13, *_12
@ SpellMenu.c:106: 	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,proc->commandIndex,UsingSpellMenu)];
	str	r3, [r7, #24]	@ _13, spell
@ SpellMenu.c:107: 	SelectedSpell = spell;
	ldr	r3, [r7, #24]	@ tmp199, spell
	lsls	r3, r3, #24	@ tmp200, tmp198,
	lsrs	r2, r3, #24	@ _14, tmp200,
	ldr	r3, .L305+8	@ tmp201,
	strb	r2, [r3]	@ tmp202, SelectedSpell
@ SpellMenu.c:125: 	MenuItemPanelProc* menuItemPanel = (MenuItemPanelProc*)ProcFind(&gProc_MenuItemPanel);
	ldr	r3, .L305+12	@ tmp203,
	movs	r0, r3	@, tmp203
	ldr	r3, .L305+16	@ tmp204,
	bl	.L12		@
	movs	r3, r0	@ tmp205,
	str	r3, [r7, #20]	@ tmp205, menuItemPanel
@ SpellMenu.c:126: 	int x = menuItemPanel->x;
	ldr	r3, [r7, #20]	@ tmp206, menuItemPanel
	movs	r2, #48	@ tmp207,
	ldrb	r3, [r3, r2]	@ _15,
@ SpellMenu.c:126: 	int x = menuItemPanel->x;
	str	r3, [r7, #16]	@ _15, x
@ SpellMenu.c:127: 	int y = menuItemPanel->y;
	ldr	r3, [r7, #20]	@ tmp208, menuItemPanel
	movs	r2, #49	@ tmp209,
	ldrb	r3, [r3, r2]	@ _16,
@ SpellMenu.c:127: 	int y = menuItemPanel->y;
	str	r3, [r7, #12]	@ _16, y
@ SpellMenu.c:131: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Clear(&menuItemPanel->textHandles[i]); }
	movs	r3, #0	@ tmp210,
	str	r3, [r7, #44]	@ tmp210, i
@ SpellMenu.c:131: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Clear(&menuItemPanel->textHandles[i]); }
	b	.L292		@
.L293:
@ SpellMenu.c:131: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Clear(&menuItemPanel->textHandles[i]); }
	ldr	r3, [r7, #44]	@ tmp212, i
	adds	r3, r3, #6	@ tmp211,
	lsls	r3, r3, #3	@ tmp213, tmp211,
	ldr	r2, [r7, #20]	@ tmp215, menuItemPanel
	adds	r3, r2, r3	@ tmp214, tmp215, tmp213
	adds	r3, r3, #4	@ _17,
@ SpellMenu.c:131: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Clear(&menuItemPanel->textHandles[i]); }
	movs	r0, r3	@, _17
	ldr	r3, .L305+20	@ tmp216,
	bl	.L12		@
@ SpellMenu.c:131: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Clear(&menuItemPanel->textHandles[i]); }
	ldr	r3, [r7, #44]	@ tmp218, i
	adds	r3, r3, #1	@ tmp217,
	str	r3, [r7, #44]	@ tmp217, i
.L292:
@ SpellMenu.c:131: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Clear(&menuItemPanel->textHandles[i]); }
	ldr	r3, [r7, #44]	@ tmp219, i
	cmp	r3, #2	@ tmp219,
	ble	.L293		@,
@ SpellMenu.c:132: 	MakeUIWindowTileMap_BG0BG1(x,y,14,8,0);
	ldr	r1, [r7, #12]	@ tmp220, y
	ldr	r0, [r7, #16]	@ tmp221, x
	movs	r3, #0	@ tmp222,
	str	r3, [sp]	@ tmp222,
	movs	r3, #8	@,
	movs	r2, #14	@,
	ldr	r4, .L305+24	@ tmp223,
	bl	.L47		@
@ SpellMenu.c:134: 	int spellType = GetItemType(spell);
	ldr	r3, [r7, #24]	@ tmp224, spell
	movs	r0, r3	@, tmp224
	ldr	r3, .L305+28	@ tmp225,
	bl	.L12		@
	movs	r3, r0	@ tmp226,
	str	r3, [r7, #8]	@ tmp226, spellType
@ SpellMenu.c:135: 	if ( spellType != ITYPE_STAFF )
	ldr	r3, [r7, #8]	@ tmp227, spellType
	cmp	r3, #4	@ tmp227,
	bne	.LCB3620	@
	b	.L294	@long jump	@
.LCB3620:
@ SpellMenu.c:137: 		BattleGenerateUiStats(gActiveUnit,9); // 9 is using a Gaiden spell.
	ldr	r3, .L305	@ tmp228,
	ldr	r3, [r3]	@ gActiveUnit.108_18, gActiveUnit
	movs	r1, #9	@,
	movs	r0, r3	@, gActiveUnit.108_18
	ldr	r3, .L305+32	@ tmp229,
	bl	.L12		@
@ SpellMenu.c:139: 		Text_InsertString(&menuItemPanel->textHandles[0],0x02,0,GetStringFromIndex(0x0039)); // "Stats"
	ldr	r3, [r7, #20]	@ tmp230, menuItemPanel
	adds	r3, r3, #52	@ tmp230,
	movs	r4, r3	@ _19, tmp230
@ SpellMenu.c:139: 		Text_InsertString(&menuItemPanel->textHandles[0],0x02,0,GetStringFromIndex(0x0039)); // "Stats"
	movs	r0, #57	@,
	ldr	r3, .L305+36	@ tmp231,
	bl	.L12		@
	movs	r3, r0	@ _20,
@ SpellMenu.c:139: 		Text_InsertString(&menuItemPanel->textHandles[0],0x02,0,GetStringFromIndex(0x0039)); // "Stats"
	movs	r2, #0	@,
	movs	r1, #2	@,
	movs	r0, r4	@, _19
	ldr	r4, .L305+40	@ tmp232,
	bl	.L47		@
@ SpellMenu.c:141: 		if (GetSpellCost(spell)>0) { 
	ldr	r3, [r7, #24]	@ tmp233, spell
	movs	r0, r3	@, tmp233
	bl	GetSpellCost		@
	subs	r3, r0, #0	@ _21,,
@ SpellMenu.c:141: 		if (GetSpellCost(spell)>0) { 
	ble	.L295		@,
@ SpellMenu.c:142: 			Text_InsertString(&menuItemPanel->textHandles[0],0x32,0,GetStringFromIndex(gGaidenMagicHPCostText)); // HP Cost.
	ldr	r3, [r7, #20]	@ tmp234, menuItemPanel
	adds	r3, r3, #52	@ tmp234,
	movs	r4, r3	@ _22, tmp234
@ SpellMenu.c:142: 			Text_InsertString(&menuItemPanel->textHandles[0],0x32,0,GetStringFromIndex(gGaidenMagicHPCostText)); // HP Cost.
	ldr	r3, .L305+44	@ tmp235,
	ldrh	r3, [r3]	@ gGaidenMagicHPCostText.109_23, gGaidenMagicHPCostText
	movs	r0, r3	@, _24
	ldr	r3, .L305+36	@ tmp236,
	bl	.L12		@
	movs	r3, r0	@ _25,
@ SpellMenu.c:142: 			Text_InsertString(&menuItemPanel->textHandles[0],0x32,0,GetStringFromIndex(gGaidenMagicHPCostText)); // HP Cost.
	movs	r2, #0	@,
	movs	r1, #50	@,
	movs	r0, r4	@, _22
	ldr	r4, .L305+40	@ tmp237,
	bl	.L47		@
.L295:
@ SpellMenu.c:144: 		Text_InsertString(&menuItemPanel->textHandles[1],0x02,0,GetStringFromIndex(0x4F3)); // Atk.
	ldr	r3, [r7, #20]	@ tmp238, menuItemPanel
	adds	r3, r3, #60	@ tmp238,
	movs	r4, r3	@ _26, tmp238
@ SpellMenu.c:144: 		Text_InsertString(&menuItemPanel->textHandles[1],0x02,0,GetStringFromIndex(0x4F3)); // Atk.
	ldr	r3, .L305+48	@ tmp239,
	movs	r0, r3	@, tmp239
	ldr	r3, .L305+36	@ tmp240,
	bl	.L12		@
	movs	r3, r0	@ _27,
@ SpellMenu.c:144: 		Text_InsertString(&menuItemPanel->textHandles[1],0x02,0,GetStringFromIndex(0x4F3)); // Atk.
	movs	r2, #0	@,
	movs	r1, #2	@,
	movs	r0, r4	@, _26
	ldr	r4, .L305+40	@ tmp241,
	bl	.L47		@
@ SpellMenu.c:145: 		Text_InsertString(&menuItemPanel->textHandles[2],0x02,0,GetStringFromIndex(0x4F4)); // Hit.
	ldr	r3, [r7, #20]	@ tmp242, menuItemPanel
	adds	r3, r3, #68	@ tmp242,
	movs	r4, r3	@ _28, tmp242
@ SpellMenu.c:145: 		Text_InsertString(&menuItemPanel->textHandles[2],0x02,0,GetStringFromIndex(0x4F4)); // Hit.
	ldr	r3, .L305+52	@ tmp243,
	movs	r0, r3	@, tmp243
	ldr	r3, .L305+36	@ tmp244,
	bl	.L12		@
	movs	r3, r0	@ _29,
@ SpellMenu.c:145: 		Text_InsertString(&menuItemPanel->textHandles[2],0x02,0,GetStringFromIndex(0x4F4)); // Hit.
	movs	r2, #0	@,
	movs	r1, #2	@,
	movs	r0, r4	@, _28
	ldr	r4, .L305+40	@ tmp245,
	bl	.L47		@
@ SpellMenu.c:146: 		Text_InsertString(&menuItemPanel->textHandles[1],0x32,0,GetStringFromIndex(0x501)); // Crit.
	ldr	r3, [r7, #20]	@ tmp246, menuItemPanel
	adds	r3, r3, #60	@ tmp246,
	movs	r4, r3	@ _30, tmp246
@ SpellMenu.c:146: 		Text_InsertString(&menuItemPanel->textHandles[1],0x32,0,GetStringFromIndex(0x501)); // Crit.
	ldr	r3, .L305+56	@ tmp247,
	movs	r0, r3	@, tmp247
	ldr	r3, .L305+36	@ tmp248,
	bl	.L12		@
	movs	r3, r0	@ _31,
@ SpellMenu.c:146: 		Text_InsertString(&menuItemPanel->textHandles[1],0x32,0,GetStringFromIndex(0x501)); // Crit.
	movs	r2, #0	@,
	movs	r1, #50	@,
	movs	r0, r4	@, _30
	ldr	r4, .L305+40	@ tmp249,
	bl	.L47		@
@ SpellMenu.c:147: 		Text_InsertString(&menuItemPanel->textHandles[2],0x32,0,GetStringFromIndex(0x4F5)); // Avoid.
	ldr	r3, [r7, #20]	@ tmp250, menuItemPanel
	adds	r3, r3, #68	@ tmp250,
	movs	r4, r3	@ _32, tmp250
@ SpellMenu.c:147: 		Text_InsertString(&menuItemPanel->textHandles[2],0x32,0,GetStringFromIndex(0x4F5)); // Avoid.
	ldr	r3, .L305+60	@ tmp251,
	movs	r0, r3	@, tmp251
	ldr	r3, .L305+36	@ tmp252,
	bl	.L12		@
	movs	r3, r0	@ _33,
@ SpellMenu.c:147: 		Text_InsertString(&menuItemPanel->textHandles[2],0x32,0,GetStringFromIndex(0x4F5)); // Avoid.
	movs	r2, #0	@,
	movs	r1, #50	@,
	movs	r0, r4	@, _32
	ldr	r4, .L305+40	@ tmp253,
	bl	.L47		@
@ SpellMenu.c:149: 		int CostColor = 2;
	movs	r3, #2	@ tmp254,
	str	r3, [r7, #40]	@ tmp254, CostColor
@ SpellMenu.c:150: 		if ( !HasSufficientHP(gActiveUnit,spell) ) { CostColor = 1; }
	ldr	r3, .L305	@ tmp255,
	ldr	r3, [r3]	@ gActiveUnit.110_34, gActiveUnit
	ldr	r2, [r7, #24]	@ tmp256, spell
	movs	r1, r2	@, tmp256
	movs	r0, r3	@, gActiveUnit.110_34
	bl	HasSufficientHP		@
	subs	r3, r0, #0	@ _35,,
@ SpellMenu.c:150: 		if ( !HasSufficientHP(gActiveUnit,spell) ) { CostColor = 1; }
	bne	.L296		@,
@ SpellMenu.c:150: 		if ( !HasSufficientHP(gActiveUnit,spell) ) { CostColor = 1; }
	movs	r3, #1	@ tmp257,
	str	r3, [r7, #40]	@ tmp257, CostColor
.L296:
@ SpellMenu.c:151: 		if (GetSpellCost(spell)>0) { Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[0],0x54,CostColor,GetSpellCost(spell)); } 
	ldr	r3, [r7, #24]	@ tmp258, spell
	movs	r0, r3	@, tmp258
	bl	GetSpellCost		@
	subs	r3, r0, #0	@ _36,,
@ SpellMenu.c:151: 		if (GetSpellCost(spell)>0) { Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[0],0x54,CostColor,GetSpellCost(spell)); } 
	ble	.L297		@,
@ SpellMenu.c:151: 		if (GetSpellCost(spell)>0) { Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[0],0x54,CostColor,GetSpellCost(spell)); } 
	ldr	r3, [r7, #20]	@ tmp259, menuItemPanel
	adds	r3, r3, #52	@ tmp259,
	movs	r4, r3	@ _37, tmp259
@ SpellMenu.c:151: 		if (GetSpellCost(spell)>0) { Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[0],0x54,CostColor,GetSpellCost(spell)); } 
	ldr	r3, [r7, #24]	@ tmp260, spell
	movs	r0, r3	@, tmp260
	bl	GetSpellCost		@
	movs	r3, r0	@ _38,
@ SpellMenu.c:151: 		if (GetSpellCost(spell)>0) { Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[0],0x54,CostColor,GetSpellCost(spell)); } 
	lsls	r3, r3, #24	@ tmp261, _38,
	lsrs	r3, r3, #24	@ _39, tmp261,
	ldr	r2, [r7, #40]	@ tmp262, CostColor
	movs	r1, #84	@,
	movs	r0, r4	@, _37
	ldr	r4, .L305+64	@ tmp263,
	bl	.L47		@
.L297:
@ SpellMenu.c:152: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[1],0x24,2,gBattleActor.battleAttack);
	ldr	r3, [r7, #20]	@ tmp264, menuItemPanel
	adds	r3, r3, #60	@ tmp264,
	movs	r0, r3	@ _40, tmp264
@ SpellMenu.c:152: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[1],0x24,2,gBattleActor.battleAttack);
	ldr	r3, .L305+68	@ tmp265,
	movs	r2, #90	@ tmp266,
	ldrsh	r3, [r3, r2]	@ _41,
@ SpellMenu.c:152: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[1],0x24,2,gBattleActor.battleAttack);
	lsls	r3, r3, #24	@ tmp267, _41,
	lsrs	r3, r3, #24	@ _42, tmp267,
	movs	r2, #2	@,
	movs	r1, #36	@,
	ldr	r4, .L305+64	@ tmp268,
	bl	.L47		@
@ SpellMenu.c:153: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[2],0x24,2,gBattleActor.battleHitRate);
	ldr	r3, [r7, #20]	@ tmp269, menuItemPanel
	adds	r3, r3, #68	@ tmp269,
	movs	r0, r3	@ _43, tmp269
@ SpellMenu.c:153: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[2],0x24,2,gBattleActor.battleHitRate);
	ldr	r3, .L305+68	@ tmp270,
	movs	r2, #96	@ tmp271,
	ldrsh	r3, [r3, r2]	@ _44,
@ SpellMenu.c:153: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[2],0x24,2,gBattleActor.battleHitRate);
	lsls	r3, r3, #24	@ tmp272, _44,
	lsrs	r3, r3, #24	@ _45, tmp272,
	movs	r2, #2	@,
	movs	r1, #36	@,
	ldr	r4, .L305+64	@ tmp273,
	bl	.L47		@
@ SpellMenu.c:154: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[1],0x54,2,gBattleActor.battleCritRate);
	ldr	r3, [r7, #20]	@ tmp274, menuItemPanel
	adds	r3, r3, #60	@ tmp274,
	movs	r0, r3	@ _46, tmp274
@ SpellMenu.c:154: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[1],0x54,2,gBattleActor.battleCritRate);
	ldr	r3, .L305+68	@ tmp275,
	movs	r2, #102	@ tmp276,
	ldrsh	r3, [r3, r2]	@ _47,
@ SpellMenu.c:154: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[1],0x54,2,gBattleActor.battleCritRate);
	lsls	r3, r3, #24	@ tmp277, _47,
	lsrs	r3, r3, #24	@ _48, tmp277,
	movs	r2, #2	@,
	movs	r1, #84	@,
	ldr	r4, .L305+64	@ tmp278,
	bl	.L47		@
@ SpellMenu.c:155: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[2],0x54,2,gBattleActor.battleAvoidRate);
	ldr	r3, [r7, #20]	@ tmp279, menuItemPanel
	adds	r3, r3, #68	@ tmp279,
	movs	r0, r3	@ _49, tmp279
@ SpellMenu.c:155: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[2],0x54,2,gBattleActor.battleAvoidRate);
	ldr	r3, .L305+68	@ tmp280,
	movs	r2, #98	@ tmp281,
	ldrsh	r3, [r3, r2]	@ _50,
@ SpellMenu.c:155: 		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[2],0x54,2,gBattleActor.battleAvoidRate);
	lsls	r3, r3, #24	@ tmp282, _50,
	lsrs	r3, r3, #24	@ _51, tmp282,
	movs	r2, #2	@,
	movs	r1, #84	@,
	ldr	r4, .L305+64	@ tmp283,
	bl	.L47		@
	b	.L298		@
.L294:
@ SpellMenu.c:160: 		const char* desc = GetStringFromIndex(GetItemUseDescId(spell));
	ldr	r3, [r7, #24]	@ tmp284, spell
	movs	r0, r3	@, tmp284
	ldr	r3, .L305+72	@ tmp285,
	bl	.L12		@
	movs	r3, r0	@ _52,
	movs	r0, r3	@, _52
	ldr	r3, .L305+36	@ tmp286,
	bl	.L12		@
	movs	r3, r0	@ tmp287,
	str	r3, [r7, #36]	@ tmp287, desc
@ SpellMenu.c:161: 		int j = 0;
	movs	r3, #0	@ tmp288,
	str	r3, [r7, #32]	@ tmp288, j
@ SpellMenu.c:162: 		desc--;
	ldr	r3, [r7, #36]	@ tmp290, desc
	subs	r3, r3, #1	@ tmp289,
	str	r3, [r7, #36]	@ tmp289, desc
.L299:
@ SpellMenu.c:165: 			desc++;
	ldr	r3, [r7, #36]	@ tmp292, desc
	adds	r3, r3, #1	@ tmp291,
	str	r3, [r7, #36]	@ tmp291, desc
@ SpellMenu.c:166: 			Text_InsertString(&menuItemPanel->textHandles[j],0,0,desc);
	ldr	r3, [r7, #32]	@ tmp294, j
	adds	r3, r3, #6	@ tmp293,
	lsls	r3, r3, #3	@ tmp295, tmp293,
	ldr	r2, [r7, #20]	@ tmp297, menuItemPanel
	adds	r3, r2, r3	@ tmp296, tmp297, tmp295
	adds	r0, r3, #4	@ _53, tmp296,
@ SpellMenu.c:166: 			Text_InsertString(&menuItemPanel->textHandles[j],0,0,desc);
	ldr	r3, [r7, #36]	@ tmp298, desc
	movs	r2, #0	@,
	movs	r1, #0	@,
	ldr	r4, .L305+40	@ tmp299,
	bl	.L47		@
@ SpellMenu.c:167: 			desc = Text_GetStringNextLine(desc);
	ldr	r3, [r7, #36]	@ tmp300, desc
	movs	r0, r3	@, tmp300
	ldr	r3, .L305+76	@ tmp301,
	bl	.L12		@
	movs	r3, r0	@ tmp302,
	str	r3, [r7, #36]	@ tmp302, desc
@ SpellMenu.c:168: 			j++;
	ldr	r3, [r7, #32]	@ tmp304, j
	adds	r3, r3, #1	@ tmp303,
	str	r3, [r7, #32]	@ tmp303, j
@ SpellMenu.c:169: 		} while ( *desc );
	ldr	r3, [r7, #36]	@ tmp305, desc
	ldrb	r3, [r3]	@ _54, *desc_111
	cmp	r3, #0	@ _54,
	bne	.L299		@,
@ SpellMenu.c:170: 		gBattleActor.battleAttack = gBattleTarget.battleAttack; // ??? this is something vanilla does???
	ldr	r3, .L305+80	@ tmp306,
	movs	r2, #90	@ tmp307,
	ldrsh	r1, [r3, r2]	@ _55,
@ SpellMenu.c:170: 		gBattleActor.battleAttack = gBattleTarget.battleAttack; // ??? this is something vanilla does???
	ldr	r3, .L305+68	@ tmp308,
	movs	r2, #90	@ tmp309,
	strh	r1, [r3, r2]	@ tmp310, gBattleActor.battleAttack
@ SpellMenu.c:171: 		gBattleActor.battleHitRate = gBattleTarget.battleHitRate; // ??? this fixes the green/red arrows from showing on staves???
	ldr	r3, .L305+80	@ tmp311,
	movs	r2, #96	@ tmp312,
	ldrsh	r1, [r3, r2]	@ _56,
@ SpellMenu.c:171: 		gBattleActor.battleHitRate = gBattleTarget.battleHitRate; // ??? this fixes the green/red arrows from showing on staves???
	ldr	r3, .L305+68	@ tmp313,
	movs	r2, #96	@ tmp314,
	strh	r1, [r3, r2]	@ tmp315, gBattleActor.battleHitRate
@ SpellMenu.c:172: 		gBattleActor.battleCritRate = gBattleTarget.battleCritRate;
	ldr	r3, .L305+80	@ tmp316,
	movs	r2, #102	@ tmp317,
	ldrsh	r1, [r3, r2]	@ _57,
@ SpellMenu.c:172: 		gBattleActor.battleCritRate = gBattleTarget.battleCritRate;
	ldr	r3, .L305+68	@ tmp318,
	movs	r2, #102	@ tmp319,
	strh	r1, [r3, r2]	@ tmp320, gBattleActor.battleCritRate
@ SpellMenu.c:173: 		gBattleActor.battleAvoidRate = gBattleTarget.battleAvoidRate;
	ldr	r3, .L305+80	@ tmp321,
	movs	r2, #98	@ tmp322,
	ldrsh	r1, [r3, r2]	@ _58,
@ SpellMenu.c:173: 		gBattleActor.battleAvoidRate = gBattleTarget.battleAvoidRate;
	ldr	r3, .L305+68	@ tmp323,
	movs	r2, #98	@ tmp324,
	strh	r1, [r3, r2]	@ tmp325, gBattleActor.battleAvoidRate
.L298:
@ SpellMenu.c:175: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Display(&menuItemPanel->textHandles[i],&gBG0MapBuffer[y+1+2*i][x+1]); }
	movs	r3, #0	@ tmp326,
	str	r3, [r7, #28]	@ tmp326, i
@ SpellMenu.c:175: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Display(&menuItemPanel->textHandles[i],&gBG0MapBuffer[y+1+2*i][x+1]); }
	b	.L300		@
.L301:
@ SpellMenu.c:175: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Display(&menuItemPanel->textHandles[i],&gBG0MapBuffer[y+1+2*i][x+1]); }
	ldr	r3, [r7, #28]	@ tmp328, i
	adds	r3, r3, #6	@ tmp327,
	lsls	r3, r3, #3	@ tmp329, tmp327,
	ldr	r2, [r7, #20]	@ tmp331, menuItemPanel
	adds	r3, r2, r3	@ tmp330, tmp331, tmp329
	adds	r0, r3, #4	@ _59, tmp330,
@ SpellMenu.c:175: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Display(&menuItemPanel->textHandles[i],&gBG0MapBuffer[y+1+2*i][x+1]); }
	ldr	r3, [r7, #12]	@ tmp332, y
	adds	r2, r3, #1	@ _60, tmp332,
@ SpellMenu.c:175: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Display(&menuItemPanel->textHandles[i],&gBG0MapBuffer[y+1+2*i][x+1]); }
	ldr	r3, [r7, #28]	@ tmp333, i
	lsls	r3, r3, #1	@ _61, tmp333,
@ SpellMenu.c:175: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Display(&menuItemPanel->textHandles[i],&gBG0MapBuffer[y+1+2*i][x+1]); }
	adds	r2, r2, r3	@ _62, _60, _61
@ SpellMenu.c:175: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Display(&menuItemPanel->textHandles[i],&gBG0MapBuffer[y+1+2*i][x+1]); }
	ldr	r3, [r7, #16]	@ tmp334, x
	adds	r3, r3, #1	@ _63,
@ SpellMenu.c:175: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Display(&menuItemPanel->textHandles[i],&gBG0MapBuffer[y+1+2*i][x+1]); }
	lsls	r2, r2, #5	@ tmp335, _62,
	adds	r3, r2, r3	@ tmp336, tmp335, _63
	lsls	r2, r3, #1	@ tmp337, tmp336,
	ldr	r3, .L305+84	@ tmp338,
	adds	r3, r2, r3	@ _64, tmp337, tmp338
	movs	r1, r3	@, _64
	ldr	r3, .L305+88	@ tmp339,
	bl	.L12		@
@ SpellMenu.c:175: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Display(&menuItemPanel->textHandles[i],&gBG0MapBuffer[y+1+2*i][x+1]); }
	ldr	r3, [r7, #28]	@ tmp341, i
	adds	r3, r3, #1	@ tmp340,
	str	r3, [r7, #28]	@ tmp340, i
.L300:
@ SpellMenu.c:175: 	for ( int i = 0 ; i < 3 ; i++ ) { Text_Display(&menuItemPanel->textHandles[i],&gBG0MapBuffer[y+1+2*i][x+1]); }
	ldr	r3, [r7, #28]	@ tmp342, i
	cmp	r3, #2	@ tmp342,
	ble	.L301		@,
@ SpellMenu.c:183: 	BmMapFill(gMapMovement,-1);
	ldr	r3, .L305+92	@ tmp343,
	ldr	r3, [r3]	@ gMapMovement.111_65, gMapMovement
	movs	r1, #255	@,
	movs	r0, r3	@, gMapMovement.111_65
	ldr	r3, .L305+96	@ tmp344,
	bl	.L12		@
@ SpellMenu.c:184: 	BmMapFill(gMapRange,0);
	ldr	r3, .L305+100	@ tmp345,
	ldr	r3, [r3]	@ gMapRange.112_66, gMapRange
	movs	r1, #0	@,
	movs	r0, r3	@, gMapRange.112_66
	ldr	r3, .L305+96	@ tmp346,
	bl	.L12		@
@ SpellMenu.c:187: 	gWrite_Range(gActiveUnit->xPos,gActiveUnit->yPos,gGet_Item_Range(gActiveUnit,spell));
	ldr	r3, .L305+104	@ tmp347,
	ldr	r4, [r3]	@ gWrite_Range.113_67, gWrite_Range
@ SpellMenu.c:187: 	gWrite_Range(gActiveUnit->xPos,gActiveUnit->yPos,gGet_Item_Range(gActiveUnit,spell));
	ldr	r3, .L305	@ tmp348,
	ldr	r3, [r3]	@ gActiveUnit.114_68, gActiveUnit
	ldrb	r3, [r3, #16]	@ _69,
	lsls	r3, r3, #24	@ _69, _69,
	asrs	r3, r3, #24	@ _69, _69,
@ SpellMenu.c:187: 	gWrite_Range(gActiveUnit->xPos,gActiveUnit->yPos,gGet_Item_Range(gActiveUnit,spell));
	movs	r5, r3	@ _70, _69
@ SpellMenu.c:187: 	gWrite_Range(gActiveUnit->xPos,gActiveUnit->yPos,gGet_Item_Range(gActiveUnit,spell));
	ldr	r3, .L305	@ tmp349,
	ldr	r3, [r3]	@ gActiveUnit.115_71, gActiveUnit
	ldrb	r3, [r3, #17]	@ _72,
	lsls	r3, r3, #24	@ _72, _72,
	asrs	r3, r3, #24	@ _72, _72,
@ SpellMenu.c:187: 	gWrite_Range(gActiveUnit->xPos,gActiveUnit->yPos,gGet_Item_Range(gActiveUnit,spell));
	movs	r6, r3	@ _73, _72
	ldr	r3, .L305+108	@ tmp350,
	ldr	r2, [r3]	@ gGet_Item_Range.116_74, gGet_Item_Range
	ldr	r3, .L305	@ tmp351,
	ldr	r3, [r3]	@ gActiveUnit.117_75, gActiveUnit
	ldr	r1, [r7, #24]	@ tmp352, spell
	movs	r0, r3	@, gActiveUnit.117_75
	bl	.L307		@
	movs	r2, r0	@ _76,
	movs	r3, r1	@ _76,
	movs	r1, r6	@, _73
	movs	r0, r5	@, _70
	bl	.L47		@
@ SpellMenu.c:188: 	DisplayMoveRangeGraphics(( spellType == ITYPE_STAFF ? 4 : 2 )); // See note in UnitMenu.c.
	ldr	r3, [r7, #8]	@ tmp353, spellType
	cmp	r3, #4	@ tmp353,
	bne	.L302		@,
@ SpellMenu.c:188: 	DisplayMoveRangeGraphics(( spellType == ITYPE_STAFF ? 4 : 2 )); // See note in UnitMenu.c.
	movs	r3, #4	@ iftmp.118_82,
	b	.L303		@
.L302:
@ SpellMenu.c:188: 	DisplayMoveRangeGraphics(( spellType == ITYPE_STAFF ? 4 : 2 )); // See note in UnitMenu.c.
	movs	r3, #2	@ iftmp.118_82,
.L303:
@ SpellMenu.c:188: 	DisplayMoveRangeGraphics(( spellType == ITYPE_STAFF ? 4 : 2 )); // See note in UnitMenu.c.
	movs	r0, r3	@, iftmp.118_82
	ldr	r3, .L305+112	@ tmp354,
	bl	.L12		@
@ SpellMenu.c:189: 	return 0;
	movs	r3, #0	@ _149,
@ SpellMenu.c:190: }
	movs	r0, r3	@, <retval>
	mov	sp, r7	@,
	add	sp, sp, #52	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L306:
	.align	2
.L305:
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
	.word	Text_InsertString
	.word	gGaidenMagicHPCostText
	.word	1267
	.word	1268
	.word	1281
	.word	1269
	.word	Text_InsertNumberOr2Dashes
	.word	gBattleActor
	.word	GetItemUseDescId
	.word	Text_GetStringNextLine
	.word	gBattleTarget
	.word	gBG0MapBuffer
	.word	Text_Display
	.word	gMapMovement
	.word	BmMapFill
	.word	gMapRange
	.word	gWrite_Range
	.word	gGet_Item_Range
	.word	DisplayMoveRangeGraphics
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
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}	@
	sub	sp, sp, #8	@,,
	add	r7, sp, #0	@,,
	str	r0, [r7, #4]	@ proc, proc
@ SpellMenu.c:194: 	if ( !DidSelectSpell ) // Don't hide the squares if we're going to the target selection menu.
	ldr	r3, .L311	@ tmp116,
	ldrb	r3, [r3]	@ DidSelectSpell.119_1, DidSelectSpell
@ SpellMenu.c:194: 	if ( !DidSelectSpell ) // Don't hide the squares if we're going to the target selection menu.
	cmp	r3, #0	@ DidSelectSpell.119_1,
	bne	.L309		@,
@ SpellMenu.c:196: 		HideMoveRangeGraphics();
	ldr	r3, .L311+4	@ tmp117,
	bl	.L12		@
.L309:
@ SpellMenu.c:198: 	DidSelectSpell = 0; // Unset this variable.
	ldr	r3, .L311	@ tmp118,
	movs	r2, #0	@ tmp119,
	strb	r2, [r3]	@ tmp120, DidSelectSpell
@ SpellMenu.c:199: 	return 0;
	movs	r3, #0	@ _6,
@ SpellMenu.c:200: }
	movs	r0, r3	@, <retval>
	mov	sp, r7	@,
	add	sp, sp, #8	@,,
	@ sp needed	@
	pop	{r7}
	pop	{r1}
	bx	r1
.L312:
	.align	2
.L311:
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
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r7, lr}	@
	sub	sp, sp, #20	@,,
	add	r7, sp, #0	@,,
	str	r0, [r7, #4]	@ menuProc, menuProc
	str	r1, [r7]	@ commandProc, commandProc
@ SpellMenu.c:204: 	int xTile = commandProc->xDrawTile * 8;
	ldr	r3, [r7]	@ tmp141, commandProc
	ldrh	r3, [r3, #42]	@ _1,
@ SpellMenu.c:204: 	int xTile = commandProc->xDrawTile * 8;
	lsls	r3, r3, #3	@ tmp142, _2,
	str	r3, [r7, #12]	@ tmp142, xTile
@ SpellMenu.c:205: 	int yTile = commandProc->yDrawTile * 8;
	ldr	r3, [r7]	@ tmp143, commandProc
	ldrh	r3, [r3, #44]	@ _3,
@ SpellMenu.c:205: 	int yTile = commandProc->yDrawTile * 8;
	lsls	r3, r3, #3	@ tmp144, _4,
	str	r3, [r7, #8]	@ tmp144, yTile
@ SpellMenu.c:206: 	if ( UsingSpellMenu )
	ldr	r3, .L318	@ tmp145,
	ldrb	r3, [r3]	@ UsingSpellMenu.120_5, UsingSpellMenu
@ SpellMenu.c:206: 	if ( UsingSpellMenu )
	cmp	r3, #0	@ UsingSpellMenu.120_5,
	beq	.L314		@,
@ SpellMenu.c:209: 		DrawItemRText(xTile,yTile,SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,commandProc->commandDefinitionIndex,UsingSpellMenu)]);
	ldr	r3, .L318+4	@ tmp146,
	ldr	r2, [r3]	@ gActiveUnit.121_6, gActiveUnit
	ldr	r3, .L318	@ tmp147,
	ldrb	r3, [r3]	@ UsingSpellMenu.122_7, UsingSpellMenu
	movs	r1, r3	@, _8
	movs	r0, r2	@, gActiveUnit.121_6
	bl	SpellsGetter		@
	movs	r4, r0	@ _9,
@ SpellMenu.c:209: 		DrawItemRText(xTile,yTile,SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,commandProc->commandDefinitionIndex,UsingSpellMenu)]);
	ldr	r3, .L318+4	@ tmp148,
	ldr	r0, [r3]	@ gActiveUnit.123_10, gActiveUnit
@ SpellMenu.c:209: 		DrawItemRText(xTile,yTile,SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,commandProc->commandDefinitionIndex,UsingSpellMenu)]);
	ldr	r3, [r7]	@ tmp149, commandProc
	movs	r2, #60	@ tmp150,
	ldrb	r3, [r3, r2]	@ _11,
@ SpellMenu.c:209: 		DrawItemRText(xTile,yTile,SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,commandProc->commandDefinitionIndex,UsingSpellMenu)]);
	movs	r1, r3	@ _12, _11
	ldr	r3, .L318	@ tmp151,
	ldrb	r3, [r3]	@ UsingSpellMenu.124_13, UsingSpellMenu
	movs	r2, r3	@, _14
	bl	GetNthUsableSpell		@
	movs	r3, r0	@ _15,
@ SpellMenu.c:209: 		DrawItemRText(xTile,yTile,SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,commandProc->commandDefinitionIndex,UsingSpellMenu)]);
	adds	r3, r4, r3	@ _17, _9, _16
	ldrb	r3, [r3]	@ _18, *_17
@ SpellMenu.c:209: 		DrawItemRText(xTile,yTile,SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,commandProc->commandDefinitionIndex,UsingSpellMenu)]);
	movs	r2, r3	@ _19, _18
	ldr	r1, [r7, #8]	@ tmp152, yTile
	ldr	r3, [r7, #12]	@ tmp153, xTile
	movs	r0, r3	@, tmp153
	ldr	r3, .L318+8	@ tmp154,
	bl	.L12		@
@ SpellMenu.c:223: }
	b	.L317		@
.L314:
@ SpellMenu.c:214: 		if ( commandProc->commandDefinitionIndex <= 4 )
	ldr	r3, [r7]	@ tmp155, commandProc
	movs	r2, #60	@ tmp156,
	ldrb	r3, [r3, r2]	@ _20,
@ SpellMenu.c:214: 		if ( commandProc->commandDefinitionIndex <= 4 )
	cmp	r3, #4	@ _20,
	bhi	.L316		@,
@ SpellMenu.c:216: 			DrawItemRText(xTile,yTile,gActiveUnit->items[commandProc->commandDefinitionIndex]);
	ldr	r3, .L318+4	@ tmp159,
	ldr	r2, [r3]	@ gActiveUnit.125_21, gActiveUnit
@ SpellMenu.c:216: 			DrawItemRText(xTile,yTile,gActiveUnit->items[commandProc->commandDefinitionIndex]);
	ldr	r3, [r7]	@ tmp160, commandProc
	movs	r1, #60	@ tmp161,
	ldrb	r3, [r3, r1]	@ _22,
@ SpellMenu.c:216: 			DrawItemRText(xTile,yTile,gActiveUnit->items[commandProc->commandDefinitionIndex]);
	adds	r3, r3, #12	@ tmp162,
	lsls	r3, r3, #1	@ tmp163, tmp162,
	adds	r3, r2, r3	@ tmp164, gActiveUnit.125_21, tmp163
	adds	r3, r3, #6	@ tmp165,
	ldrh	r3, [r3]	@ _24, *gActiveUnit.125_21
@ SpellMenu.c:216: 			DrawItemRText(xTile,yTile,gActiveUnit->items[commandProc->commandDefinitionIndex]);
	movs	r2, r3	@ _25, _24
	ldr	r1, [r7, #8]	@ tmp166, yTile
	ldr	r3, [r7, #12]	@ tmp167, xTile
	movs	r0, r3	@, tmp167
	ldr	r3, .L318+8	@ tmp168,
	bl	.L12		@
@ SpellMenu.c:223: }
	b	.L317		@
.L316:
@ SpellMenu.c:220: 			DrawItemRText(xTile,yTile,*((u16*)&gGameState+0x16)); // Probably related to special cases like ballistae?
	ldr	r3, .L318+12	@ _26,
@ SpellMenu.c:220: 			DrawItemRText(xTile,yTile,*((u16*)&gGameState+0x16)); // Probably related to special cases like ballistae?
	ldrh	r3, [r3]	@ _27, *_26
@ SpellMenu.c:220: 			DrawItemRText(xTile,yTile,*((u16*)&gGameState+0x16)); // Probably related to special cases like ballistae?
	movs	r2, r3	@ _28, _27
	ldr	r1, [r7, #8]	@ tmp169, yTile
	ldr	r3, [r7, #12]	@ tmp170, xTile
	movs	r0, r3	@, tmp170
	ldr	r3, .L318+8	@ tmp171,
	bl	.L12		@
.L317:
@ SpellMenu.c:223: }
	nop	
	mov	sp, r7	@,
	add	sp, sp, #20	@,,
	@ sp needed	@
	pop	{r4, r7}
	pop	{r0}
	bx	r0
.L319:
	.align	2
.L318:
	.word	UsingSpellMenu
	.word	gActiveUnit
	.word	DrawItemRText
	.word	gGameState+44
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
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}	@
	sub	sp, sp, #8	@,,
	add	r7, sp, #0	@,,
	str	r0, [r7, #4]	@ proc, proc
@ SpellMenu.c:231: 	if ( UsingSpellMenu == BLACK_MAGIC ) { GaidenBlackMagicUMEffect(NULL,NULL); }
	ldr	r3, .L324	@ tmp115,
	ldrb	r3, [r3]	@ UsingSpellMenu.126_1, UsingSpellMenu
@ SpellMenu.c:231: 	if ( UsingSpellMenu == BLACK_MAGIC ) { GaidenBlackMagicUMEffect(NULL,NULL); }
	cmp	r3, #1	@ UsingSpellMenu.126_1,
	bne	.L321		@,
@ SpellMenu.c:231: 	if ( UsingSpellMenu == BLACK_MAGIC ) { GaidenBlackMagicUMEffect(NULL,NULL); }
	movs	r1, #0	@,
	movs	r0, #0	@,
	bl	GaidenBlackMagicUMEffect		@
	b	.L322		@
.L321:
@ SpellMenu.c:232: 	else if ( UsingSpellMenu == WHITE_MAGIC ) { GaidenWhiteMagicUMEffect(NULL,NULL); }
	ldr	r3, .L324	@ tmp116,
	ldrb	r3, [r3]	@ UsingSpellMenu.127_2, UsingSpellMenu
@ SpellMenu.c:232: 	else if ( UsingSpellMenu == WHITE_MAGIC ) { GaidenWhiteMagicUMEffect(NULL,NULL); }
	cmp	r3, #2	@ UsingSpellMenu.127_2,
	bne	.L323		@,
@ SpellMenu.c:232: 	else if ( UsingSpellMenu == WHITE_MAGIC ) { GaidenWhiteMagicUMEffect(NULL,NULL); }
	movs	r1, #0	@,
	movs	r0, #0	@,
	bl	GaidenWhiteMagicUMEffect		@
	b	.L322		@
.L323:
@ SpellMenu.c:236: 		AttackUMEffect(NULL,NULL);
	movs	r1, #0	@,
	movs	r0, #0	@,
	ldr	r3, .L324+4	@ tmp117,
	bl	.L12		@
.L322:
@ SpellMenu.c:238: 	SelectedSpell = 0; // Regardless of use case, ensure that this is 0.
	ldr	r3, .L324+8	@ tmp118,
	movs	r2, #0	@ tmp119,
	strb	r2, [r3]	@ tmp120, SelectedSpell
@ SpellMenu.c:239: }
	nop	
	mov	sp, r7	@,
	add	sp, sp, #8	@,,
	@ sp needed	@
	pop	{r7}
	pop	{r0}
	bx	r0
.L325:
	.align	2
.L324:
	.word	UsingSpellMenu
	.word	AttackUMEffect
	.word	SelectedSpell
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
	@ args = 0, pretend = 0, frame = 40
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r7, lr}	@
	sub	sp, sp, #44	@,,
	add	r7, sp, #0	@,,
	str	r0, [r7, #12]	@ x, x
	str	r1, [r7, #8]	@ y, y
	str	r2, [r7, #4]	@ currHandle, currHandle
@ StatScreen.c:4: 	u8* spells = SpellsGetter(gpStatScreenUnit,-1);
	ldr	r3, .L332	@ tmp133,
	ldr	r3, [r3]	@ gpStatScreenUnit.128_1, gpStatScreenUnit
	movs	r2, #1	@ tmp207,
	rsbs	r2, r2, #0	@ tmp134, tmp207
	movs	r1, r2	@, tmp134
	movs	r0, r3	@, gpStatScreenUnit.128_1
	bl	SpellsGetter		@
	movs	r3, r0	@ tmp135,
	str	r3, [r7, #20]	@ tmp135, spells
@ StatScreen.c:5: 	int tile = (currHandle-1)->tileIndexOffset;
	ldr	r3, [r7, #4]	@ tmp136, currHandle
	subs	r3, r3, #8	@ _2,
@ StatScreen.c:5: 	int tile = (currHandle-1)->tileIndexOffset;
	ldrh	r3, [r3]	@ _3, *_2
@ StatScreen.c:5: 	int tile = (currHandle-1)->tileIndexOffset;
	str	r3, [r7, #36]	@ _3, tile
@ StatScreen.c:6: 	int iconX = x;
	ldr	r3, [r7, #12]	@ tmp137, x
	str	r3, [r7, #32]	@ tmp137, iconX
@ StatScreen.c:7: 	int iconY = y;
	ldr	r3, [r7, #8]	@ tmp138, y
	str	r3, [r7, #28]	@ tmp138, iconY
@ StatScreen.c:8: 	for ( int i = 0 ; spells[i] ; i++ )
	movs	r3, #0	@ tmp139,
	str	r3, [r7, #24]	@ tmp139, i
@ StatScreen.c:8: 	for ( int i = 0 ; spells[i] ; i++ )
	b	.L327		@
.L330:
@ StatScreen.c:10: 		const ItemData* item = GetItemData(spells[i]);
	ldr	r3, [r7, #24]	@ i.129_4, i
	ldr	r2, [r7, #20]	@ tmp140, spells
	adds	r3, r2, r3	@ _5, tmp140, i.129_4
@ StatScreen.c:10: 		const ItemData* item = GetItemData(spells[i]);
	ldrb	r3, [r3]	@ _6, *_5
	movs	r0, r3	@, _6
	ldr	r3, .L332+4	@ tmp141,
	bl	.L12		@
	movs	r3, r0	@ tmp142,
	str	r3, [r7, #16]	@ tmp142, item
@ StatScreen.c:11: 		DrawIcon(&StatScreenBufferMap[iconY][iconX],item->iconId,0x4000);
	ldr	r3, [r7, #28]	@ tmp144, iconY
	lsls	r2, r3, #5	@ tmp143, tmp144,
	ldr	r3, [r7, #32]	@ tmp146, iconX
	adds	r3, r2, r3	@ tmp145, tmp143, tmp146
	lsls	r2, r3, #1	@ tmp147, tmp145,
	ldr	r3, .L332+8	@ tmp148,
	adds	r0, r2, r3	@ _7, tmp147, tmp148
@ StatScreen.c:11: 		DrawIcon(&StatScreenBufferMap[iconY][iconX],item->iconId,0x4000);
	ldr	r3, [r7, #16]	@ tmp149, item
	ldrb	r3, [r3, #29]	@ _8,
@ StatScreen.c:11: 		DrawIcon(&StatScreenBufferMap[iconY][iconX],item->iconId,0x4000);
	movs	r1, r3	@ _9, _8
	movs	r3, #128	@ tmp206,
	lsls	r3, r3, #7	@ tmp150, tmp206,
	movs	r2, r3	@, tmp150
	ldr	r3, .L332+12	@ tmp151,
	bl	.L12		@
@ StatScreen.c:13: 		tile += 6;
	ldr	r3, [r7, #36]	@ tmp153, tile
	adds	r3, r3, #6	@ tmp152,
	str	r3, [r7, #36]	@ tmp152, tile
@ StatScreen.c:14: 		currHandle->tileIndexOffset = tile;
	ldr	r3, [r7, #36]	@ tmp155, tile
	lsls	r3, r3, #16	@ tmp156, tmp154,
	lsrs	r2, r3, #16	@ _10, tmp156,
	ldr	r3, [r7, #4]	@ tmp157, currHandle
	strh	r2, [r3]	@ tmp158, currHandle_19->tileIndexOffset
@ StatScreen.c:15: 		currHandle->xCursor = 0;
	ldr	r3, [r7, #4]	@ tmp159, currHandle
	movs	r2, #0	@ tmp160,
	strb	r2, [r3, #2]	@ tmp161, currHandle_19->xCursor
@ StatScreen.c:16: 		currHandle->colorId = TEXT_COLOR_NORMAL;
	ldr	r3, [r7, #4]	@ tmp162, currHandle
	movs	r2, #0	@ tmp163,
	strb	r2, [r3, #3]	@ tmp164, currHandle_19->colorId
@ StatScreen.c:17: 		currHandle->tileWidth = 6;
	ldr	r3, [r7, #4]	@ tmp165, currHandle
	movs	r2, #6	@ tmp166,
	strb	r2, [r3, #4]	@ tmp167, currHandle_19->tileWidth
@ StatScreen.c:18: 		currHandle->useDoubleBuffer = 0;
	ldr	r3, [r7, #4]	@ tmp168, currHandle
	movs	r2, #0	@ tmp169,
	strb	r2, [r3, #5]	@ tmp170, currHandle_19->useDoubleBuffer
@ StatScreen.c:19: 		currHandle->currentBufferId = 0;
	ldr	r3, [r7, #4]	@ tmp171, currHandle
	movs	r2, #0	@ tmp172,
	strb	r2, [r3, #6]	@ tmp173, currHandle_19->currentBufferId
@ StatScreen.c:20: 		currHandle->unk07 = 0;
	ldr	r3, [r7, #4]	@ tmp174, currHandle
	movs	r2, #0	@ tmp175,
	strb	r2, [r3, #7]	@ tmp176, currHandle_19->unk07
@ StatScreen.c:22: 		Text_Clear(currHandle);
	ldr	r3, [r7, #4]	@ tmp177, currHandle
	movs	r0, r3	@, tmp177
	ldr	r3, .L332+16	@ tmp178,
	bl	.L12		@
@ StatScreen.c:23: 		Text_SetColorId(currHandle,TEXT_COLOR_NORMAL);
	ldr	r3, [r7, #4]	@ tmp179, currHandle
	movs	r1, #0	@,
	movs	r0, r3	@, tmp179
	ldr	r3, .L332+20	@ tmp180,
	bl	.L12		@
@ StatScreen.c:24: 		Text_InsertString(currHandle,0,TEXT_COLOR_NORMAL,GetStringFromIndex(item->nameTextId));
	ldr	r3, [r7, #16]	@ tmp181, item
	ldrh	r3, [r3]	@ _11, *item_39
@ StatScreen.c:24: 		Text_InsertString(currHandle,0,TEXT_COLOR_NORMAL,GetStringFromIndex(item->nameTextId));
	movs	r0, r3	@, _12
	ldr	r3, .L332+24	@ tmp182,
	bl	.L12		@
	movs	r3, r0	@ _13,
@ StatScreen.c:24: 		Text_InsertString(currHandle,0,TEXT_COLOR_NORMAL,GetStringFromIndex(item->nameTextId));
	ldr	r0, [r7, #4]	@ tmp183, currHandle
	movs	r2, #0	@,
	movs	r1, #0	@,
	ldr	r4, .L332+28	@ tmp184,
	bl	.L47		@
@ StatScreen.c:25: 		Text_Display(currHandle,&StatScreenBufferMap[iconY][iconX+2]);
	ldr	r3, [r7, #32]	@ tmp185, iconX
	adds	r3, r3, #2	@ _14,
@ StatScreen.c:25: 		Text_Display(currHandle,&StatScreenBufferMap[iconY][iconX+2]);
	ldr	r2, [r7, #28]	@ tmp187, iconY
	lsls	r2, r2, #5	@ tmp186, tmp187,
	adds	r3, r2, r3	@ tmp188, tmp186, _14
	lsls	r2, r3, #1	@ tmp189, tmp188,
	ldr	r3, .L332+8	@ tmp190,
	adds	r2, r2, r3	@ _15, tmp189, tmp190
	ldr	r3, [r7, #4]	@ tmp191, currHandle
	movs	r1, r2	@, _15
	movs	r0, r3	@, tmp191
	ldr	r3, .L332+32	@ tmp192,
	bl	.L12		@
@ StatScreen.c:27: 		currHandle++;
	ldr	r3, [r7, #4]	@ tmp194, currHandle
	adds	r3, r3, #8	@ tmp193,
	str	r3, [r7, #4]	@ tmp193, currHandle
@ StatScreen.c:28: 		if ( iconX == x ) { iconX += 8; }
	ldr	r2, [r7, #32]	@ tmp195, iconX
	ldr	r3, [r7, #12]	@ tmp196, x
	cmp	r2, r3	@ tmp195, tmp196
	bne	.L328		@,
@ StatScreen.c:28: 		if ( iconX == x ) { iconX += 8; }
	ldr	r3, [r7, #32]	@ tmp198, iconX
	adds	r3, r3, #8	@ tmp197,
	str	r3, [r7, #32]	@ tmp197, iconX
	b	.L329		@
.L328:
@ StatScreen.c:29: 		else { iconX = x; iconY += 2; }
	ldr	r3, [r7, #12]	@ tmp199, x
	str	r3, [r7, #32]	@ tmp199, iconX
@ StatScreen.c:29: 		else { iconX = x; iconY += 2; }
	ldr	r3, [r7, #28]	@ tmp201, iconY
	adds	r3, r3, #2	@ tmp200,
	str	r3, [r7, #28]	@ tmp200, iconY
.L329:
@ StatScreen.c:8: 	for ( int i = 0 ; spells[i] ; i++ )
	ldr	r3, [r7, #24]	@ tmp203, i
	adds	r3, r3, #1	@ tmp202,
	str	r3, [r7, #24]	@ tmp202, i
.L327:
@ StatScreen.c:8: 	for ( int i = 0 ; spells[i] ; i++ )
	ldr	r3, [r7, #24]	@ i.130_16, i
	ldr	r2, [r7, #20]	@ tmp204, spells
	adds	r3, r2, r3	@ _17, tmp204, i.130_16
	ldrb	r3, [r3]	@ _18, *_17
@ StatScreen.c:8: 	for ( int i = 0 ; spells[i] ; i++ )
	cmp	r3, #0	@ _18,
	bne	.L330		@,
@ StatScreen.c:31: 	return currHandle;
	ldr	r3, [r7, #4]	@ _37, currHandle
@ StatScreen.c:32: }
	movs	r0, r3	@, <retval>
	mov	sp, r7	@,
	add	sp, sp, #44	@,,
	@ sp needed	@
	pop	{r4, r7}
	pop	{r1}
	bx	r1
.L333:
	.align	2
.L332:
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
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}	@
	sub	sp, sp, #16	@,,
	add	r7, sp, #0	@,,
	str	r0, [r7, #4]	@ proc, proc
@ StatScreen.c:36: 	int index = *(proc->rTextData+0x12);
	ldr	r3, [r7, #4]	@ tmp126, proc
	ldr	r3, [r3, #44]	@ _1, proc_15(D)->rTextData
@ StatScreen.c:36: 	int index = *(proc->rTextData+0x12);
	adds	r3, r3, #18	@ _2,
@ StatScreen.c:36: 	int index = *(proc->rTextData+0x12);
	ldrb	r3, [r3]	@ _3, *_2
@ StatScreen.c:36: 	int index = *(proc->rTextData+0x12);
	str	r3, [r7, #12]	@ _3, index
@ StatScreen.c:37: 	proc->type = SpellsGetter(gpStatScreenUnit,-1)[index]; // I think if this is positive, it treats this as an item bubble.
	ldr	r3, .L335	@ tmp127,
	ldr	r3, [r3]	@ gpStatScreenUnit.131_4, gpStatScreenUnit
	movs	r2, #1	@ tmp140,
	rsbs	r2, r2, #0	@ tmp128, tmp140
	movs	r1, r2	@, tmp128
	movs	r0, r3	@, gpStatScreenUnit.131_4
	bl	SpellsGetter		@
	movs	r2, r0	@ _5,
@ StatScreen.c:37: 	proc->type = SpellsGetter(gpStatScreenUnit,-1)[index]; // I think if this is positive, it treats this as an item bubble.
	ldr	r3, [r7, #12]	@ index.132_6, index
	adds	r3, r2, r3	@ _7, _5, index.132_6
	ldrb	r3, [r3]	@ _8, *_7
	lsls	r3, r3, #16	@ tmp129, _8,
	lsrs	r1, r3, #16	@ _9, tmp129,
@ StatScreen.c:37: 	proc->type = SpellsGetter(gpStatScreenUnit,-1)[index]; // I think if this is positive, it treats this as an item bubble.
	ldr	r3, [r7, #4]	@ tmp130, proc
	movs	r2, #78	@ tmp131,
	strh	r1, [r3, r2]	@ tmp132, proc_15(D)->type
@ StatScreen.c:38: 	proc->textID = GetItemData(proc->type)->descTextId;
	ldr	r3, [r7, #4]	@ tmp133, proc
	movs	r2, #78	@ tmp134,
	ldrh	r3, [r3, r2]	@ _10,
@ StatScreen.c:38: 	proc->textID = GetItemData(proc->type)->descTextId;
	lsls	r3, r3, #24	@ tmp135, _10,
	lsrs	r3, r3, #24	@ _11, tmp135,
	movs	r0, r3	@, _11
	ldr	r3, .L335+4	@ tmp136,
	bl	.L12		@
	movs	r3, r0	@ _12,
@ StatScreen.c:38: 	proc->textID = GetItemData(proc->type)->descTextId;
	ldrh	r1, [r3, #2]	@ _13,
@ StatScreen.c:38: 	proc->textID = GetItemData(proc->type)->descTextId;
	ldr	r3, [r7, #4]	@ tmp137, proc
	movs	r2, #76	@ tmp138,
	strh	r1, [r3, r2]	@ tmp139, proc_15(D)->textID
@ StatScreen.c:39: }
	nop	
	mov	sp, r7	@,
	add	sp, sp, #16	@,,
	@ sp needed	@
	pop	{r7}
	pop	{r0}
	bx	r0
.L336:
	.align	2
.L335:
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
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r7, lr}	@
	sub	sp, sp, #20	@,,
	add	r7, sp, #0	@,,
	str	r0, [r7, #4]	@ proc, proc
@ StatScreen.c:43: 	int index = *(proc->rTextData+0x12);
	ldr	r3, [r7, #4]	@ tmp142, proc
	ldr	r3, [r3, #44]	@ _1, proc_34(D)->rTextData
@ StatScreen.c:43: 	int index = *(proc->rTextData+0x12);
	adds	r3, r3, #18	@ _2,
@ StatScreen.c:43: 	int index = *(proc->rTextData+0x12);
	ldrb	r3, [r3]	@ _3, *_2
@ StatScreen.c:43: 	int index = *(proc->rTextData+0x12);
	str	r3, [r7, #12]	@ _3, index
@ StatScreen.c:44: 	if ( proc->direction == DIRECTION_RIGHT )
	ldr	r3, [r7, #4]	@ tmp143, proc
	movs	r2, #80	@ tmp144,
	ldrh	r3, [r3, r2]	@ _4,
@ StatScreen.c:44: 	if ( proc->direction == DIRECTION_RIGHT )
	cmp	r3, #16	@ _4,
	bne	.L338		@,
@ StatScreen.c:47: 		while ( index >= 0 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index]) )
	b	.L339		@
.L341:
@ StatScreen.c:49: 			RTextUp(proc);
	ldr	r3, [r7, #4]	@ tmp145, proc
	movs	r0, r3	@, tmp145
	ldr	r3, .L343	@ tmp146,
	bl	.L12		@
@ StatScreen.c:50: 			index -= 2;
	ldr	r3, [r7, #12]	@ tmp148, index
	subs	r3, r3, #2	@ tmp147,
	str	r3, [r7, #12]	@ tmp147, index
.L339:
@ StatScreen.c:47: 		while ( index >= 0 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index]) )
	ldr	r3, [r7, #12]	@ tmp149, index
	cmp	r3, #0	@ tmp149,
	blt	.L342		@,
@ StatScreen.c:47: 		while ( index >= 0 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index]) )
	ldr	r3, .L343+4	@ tmp150,
	ldr	r4, [r3]	@ gpStatScreenUnit.133_5, gpStatScreenUnit
@ StatScreen.c:47: 		while ( index >= 0 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index]) )
	ldr	r3, .L343+4	@ tmp151,
	ldr	r3, [r3]	@ gpStatScreenUnit.134_6, gpStatScreenUnit
	movs	r2, #1	@ tmp168,
	rsbs	r2, r2, #0	@ tmp152, tmp168
	movs	r1, r2	@, tmp152
	movs	r0, r3	@, gpStatScreenUnit.134_6
	bl	SpellsGetter		@
	movs	r2, r0	@ _7,
@ StatScreen.c:47: 		while ( index >= 0 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index]) )
	ldr	r3, [r7, #12]	@ index.135_8, index
	adds	r3, r2, r3	@ _9, _7, index.135_8
@ StatScreen.c:47: 		while ( index >= 0 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index]) )
	ldrb	r3, [r3]	@ _10, *_9
	movs	r1, r3	@, _10
	movs	r0, r4	@, gpStatScreenUnit.133_5
	bl	DoesUnitKnowSpell		@
	subs	r3, r0, #0	@ _11,,
@ StatScreen.c:47: 		while ( index >= 0 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index]) )
	beq	.L341		@,
@ StatScreen.c:63: }
	b	.L342		@
.L338:
@ StatScreen.c:53: 	else if ( proc->direction == DIRECTION_DOWN )
	ldr	r3, [r7, #4]	@ tmp153, proc
	movs	r2, #80	@ tmp154,
	ldrh	r3, [r3, r2]	@ _12,
@ StatScreen.c:53: 	else if ( proc->direction == DIRECTION_DOWN )
	cmp	r3, #128	@ _12,
	bne	.L342		@,
@ StatScreen.c:56: 		if ( !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index]) )
	ldr	r3, .L343+4	@ tmp155,
	ldr	r4, [r3]	@ gpStatScreenUnit.136_13, gpStatScreenUnit
@ StatScreen.c:56: 		if ( !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index]) )
	ldr	r3, .L343+4	@ tmp156,
	ldr	r3, [r3]	@ gpStatScreenUnit.137_14, gpStatScreenUnit
	movs	r2, #1	@ tmp167,
	rsbs	r2, r2, #0	@ tmp157, tmp167
	movs	r1, r2	@, tmp157
	movs	r0, r3	@, gpStatScreenUnit.137_14
	bl	SpellsGetter		@
	movs	r2, r0	@ _15,
@ StatScreen.c:56: 		if ( !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index]) )
	ldr	r3, [r7, #12]	@ index.138_16, index
	adds	r3, r2, r3	@ _17, _15, index.138_16
@ StatScreen.c:56: 		if ( !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index]) )
	ldrb	r3, [r3]	@ _18, *_17
	movs	r1, r3	@, _18
	movs	r0, r4	@, gpStatScreenUnit.136_13
	bl	DoesUnitKnowSpell		@
	subs	r3, r0, #0	@ _19,,
@ StatScreen.c:56: 		if ( !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index]) )
	bne	.L342		@,
@ StatScreen.c:58: 			RTextLeft(proc);
	ldr	r3, [r7, #4]	@ tmp158, proc
	movs	r0, r3	@, tmp158
	ldr	r3, .L343+8	@ tmp159,
	bl	.L12		@
@ StatScreen.c:60: 			if ( index % 2 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index-1]) ) { RTextLeft(proc); }
	ldr	r3, [r7, #12]	@ index.139_20, index
	movs	r2, #1	@ tmp160,
	ands	r3, r2	@ _21, tmp160
@ StatScreen.c:60: 			if ( index % 2 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index-1]) ) { RTextLeft(proc); }
	beq	.L342		@,
@ StatScreen.c:60: 			if ( index % 2 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index-1]) ) { RTextLeft(proc); }
	ldr	r3, .L343+4	@ tmp161,
	ldr	r4, [r3]	@ gpStatScreenUnit.140_22, gpStatScreenUnit
@ StatScreen.c:60: 			if ( index % 2 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index-1]) ) { RTextLeft(proc); }
	ldr	r3, .L343+4	@ tmp162,
	ldr	r3, [r3]	@ gpStatScreenUnit.141_23, gpStatScreenUnit
	movs	r2, #1	@ tmp166,
	rsbs	r2, r2, #0	@ tmp163, tmp166
	movs	r1, r2	@, tmp163
	movs	r0, r3	@, gpStatScreenUnit.141_23
	bl	SpellsGetter		@
	movs	r2, r0	@ _24,
@ StatScreen.c:60: 			if ( index % 2 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index-1]) ) { RTextLeft(proc); }
	ldr	r3, [r7, #12]	@ index.142_25, index
	subs	r3, r3, #1	@ _26,
	adds	r3, r2, r3	@ _27, _24, _26
@ StatScreen.c:60: 			if ( index % 2 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index-1]) ) { RTextLeft(proc); }
	ldrb	r3, [r3]	@ _28, *_27
	movs	r1, r3	@, _28
	movs	r0, r4	@, gpStatScreenUnit.140_22
	bl	DoesUnitKnowSpell		@
	subs	r3, r0, #0	@ _29,,
@ StatScreen.c:60: 			if ( index % 2 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index-1]) ) { RTextLeft(proc); }
	bne	.L342		@,
@ StatScreen.c:60: 			if ( index % 2 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index-1]) ) { RTextLeft(proc); }
	ldr	r3, [r7, #4]	@ tmp164, proc
	movs	r0, r3	@, tmp164
	ldr	r3, .L343+8	@ tmp165,
	bl	.L12		@
.L342:
@ StatScreen.c:63: }
	nop	
	mov	sp, r7	@,
	add	sp, sp, #20	@,,
	@ sp needed	@
	pop	{r4, r7}
	pop	{r0}
	bx	r0
.L344:
	.align	2
.L343:
	.word	RTextUp
	.word	gpStatScreenUnit
	.word	RTextLeft
	.size	GaidenRTextLooper, .-GaidenRTextLooper
	.ident	"GCC: (devkitARM release 56) 11.1.0"
	.code 16
	.align	1
.L307:
	bx	r2
.L12:
	bx	r3
.L47:
	bx	r4
