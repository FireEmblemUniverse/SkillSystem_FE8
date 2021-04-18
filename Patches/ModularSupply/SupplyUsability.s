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
	.file	"SupplyUsability.c"
@ GNU C17 (devkitARM release 52-2) version 8.3.0 (arm-none-eabi)
@	compiled by GNU C version 6.4.0, GMP version 6.0.0, MPFR version 3.1.2, MPC version 1.0.2, isl version none
@ GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
@ options passed:  -imultilib thumb
@ -iprefix c:\devkitpro\devkitarm\bin\../lib/gcc/arm-none-eabi/8.3.0/
@ -D__USES_INITFINI__ SupplyUsability.c -mcpu=arm7tdmi -mthumb
@ -mthumb-interwork -mtune=arm7tdmi -mlong-calls -march=armv4t
@ -auxbase-strip SupplyUsability.s -Os -Wall -fverbose-asm
@ options enabled:  -faggressive-loop-optimizations -falign-jumps
@ -falign-labels -falign-loops -fauto-inc-dec -fbranch-count-reg
@ -fcaller-saves -fchkp-check-incomplete-type -fchkp-check-read
@ -fchkp-check-write -fchkp-instrument-calls -fchkp-narrow-bounds
@ -fchkp-optimize -fchkp-store-bounds -fchkp-use-static-bounds
@ -fchkp-use-static-const-bounds -fchkp-use-wrappers -fcode-hoisting
@ -fcombine-stack-adjustments -fcommon -fcompare-elim -fcprop-registers
@ -fcrossjumping -fcse-follow-jumps -fdefer-pop
@ -fdelete-null-pointer-checks -fdevirtualize -fdevirtualize-speculatively
@ -fdwarf2-cfi-asm -fearly-inlining -feliminate-unused-debug-types
@ -fexpensive-optimizations -fforward-propagate -ffp-int-builtin-inexact
@ -ffunction-cse -fgcse -fgcse-lm -fgnu-runtime -fgnu-unique
@ -fguess-branch-probability -fhoist-adjacent-loads -fident -fif-conversion
@ -fif-conversion2 -findirect-inlining -finline -finline-atomics
@ -finline-functions -finline-functions-called-once
@ -finline-small-functions -fipa-bit-cp -fipa-cp -fipa-icf
@ -fipa-icf-functions -fipa-icf-variables -fipa-profile -fipa-pure-const
@ -fipa-reference -fipa-sra -fipa-vrp -fira-hoist-pressure
@ -fira-share-save-slots -fira-share-spill-slots
@ -fisolate-erroneous-paths-dereference -fivopts -fkeep-static-consts
@ -fleading-underscore -flifetime-dse -flra-remat -flto-odr-type-merging
@ -fmath-errno -fmerge-constants -fmerge-debug-strings
@ -fmove-loop-invariants -fomit-frame-pointer -foptimize-sibling-calls
@ -fpartial-inlining -fpeephole -fpeephole2 -fplt -fprefetch-loop-arrays
@ -freg-struct-return -freorder-blocks -freorder-functions
@ -frerun-cse-after-loop -fsched-critical-path-heuristic
@ -fsched-dep-count-heuristic -fsched-group-heuristic -fsched-interblock
@ -fsched-last-insn-heuristic -fsched-pressure -fsched-rank-heuristic
@ -fsched-spec -fsched-spec-insn-heuristic -fsched-stalled-insns-dep
@ -fschedule-insns2 -fsection-anchors -fsemantic-interposition
@ -fshow-column -fshrink-wrap -fshrink-wrap-separate -fsigned-zeros
@ -fsplit-ivs-in-unroller -fsplit-wide-types -fssa-backprop -fssa-phiopt
@ -fstdarg-opt -fstore-merging -fstrict-aliasing
@ -fstrict-volatile-bitfields -fsync-libcalls -fthread-jumps
@ -ftoplevel-reorder -ftrapping-math -ftree-bit-ccp -ftree-builtin-call-dce
@ -ftree-ccp -ftree-ch -ftree-coalesce-vars -ftree-copy-prop -ftree-cselim
@ -ftree-dce -ftree-dominator-opts -ftree-dse -ftree-forwprop -ftree-fre
@ -ftree-loop-if-convert -ftree-loop-im -ftree-loop-ivcanon
@ -ftree-loop-optimize -ftree-parallelize-loops= -ftree-phiprop -ftree-pre
@ -ftree-pta -ftree-reassoc -ftree-scev-cprop -ftree-sink -ftree-slsr
@ -ftree-sra -ftree-switch-conversion -ftree-tail-merge -ftree-ter
@ -ftree-vrp -funit-at-a-time -fverbose-asm -fzero-initialized-in-bss
@ -mbe32 -mlittle-endian -mlong-calls -mpic-data-is-text-relative
@ -msched-prolog -mthumb -mthumb-interwork -mvectorize-with-neon-quad

	.text
	.align	1
	.global	HasConvoyAccess
	.arch armv4t
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	HasConvoyAccess, %function
HasConvoyAccess:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
@ SupplyUsability.c:13: 	if ( SupplyUsabilityTable[gChapterData.chapterIndex] == NULL )
	ldr	r3, .L2	@ tmp117,
	ldrb	r3, [r3, #14]	@ tmp118,
@ SupplyUsability.c:13: 	if ( SupplyUsabilityTable[gChapterData.chapterIndex] == NULL )
	ldr	r2, .L2+4	@ tmp116,
@ SupplyUsability.c:13: 	if ( SupplyUsabilityTable[gChapterData.chapterIndex] == NULL )
	lsls	r3, r3, #2	@ tmp119, tmp118,
@ SupplyUsability.c:13: 	if ( SupplyUsabilityTable[gChapterData.chapterIndex] == NULL )
	ldr	r0, [r3, r2]	@ tmp120, SupplyUsabilityTable
@ SupplyUsability.c:21: }
	@ sp needed	@
	subs	r3, r0, #1	@ tmp122, tmp120
	sbcs	r0, r0, r3	@ tmp123, tmp120, tmp122
	bx	lr
.L3:
	.align	2
.L2:
	.word	gChapterData
	.word	SupplyUsabilityTable
	.size	HasConvoyAccess, .-HasConvoyAccess
	.align	1
	.global	DoesCharacterHaveSupply
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	DoesCharacterHaveSupply, %function
DoesCharacterHaveSupply:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
@ SupplyUsability.c:25: 	for (u8 i = 0; supplyList[i] != 0; i++)
	movs	r3, #0	@ i,
@ SupplyUsability.c:24: {
	push	{r4, lr}	@
.L5:
@ SupplyUsability.c:25: 	for (u8 i = 0; supplyList[i] != 0; i++)
	ldrb	r2, [r1, r3]	@ <retval>, *_4
@ SupplyUsability.c:25: 	for (u8 i = 0; supplyList[i] != 0; i++)
	cmp	r2, #0	@ <retval>,
	bne	.L7		@,
.L6:
@ SupplyUsability.c:33: }
	movs	r0, r2	@, <retval>
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L7:
@ SupplyUsability.c:27:         if ( supplyList[i] == unit->pCharacterData->number )
	ldr	r4, [r0]	@ tmp123, unit_10(D)->pCharacterData
	ldrb	r4, [r4, #4]	@ tmp119,
	cmp	r4, r2	@ tmp119, <retval>
	beq	.L8		@,
@ SupplyUsability.c:25: 	for (u8 i = 0; supplyList[i] != 0; i++)
	adds	r3, r3, #1	@ tmp120,
	lsls	r3, r3, #24	@ i, tmp120,
	lsrs	r3, r3, #24	@ i, i,
	b	.L5		@
.L8:
@ SupplyUsability.c:29:             return 1;
	movs	r2, #1	@ <retval>,
	b	.L6		@
	.size	DoesCharacterHaveSupply, .-DoesCharacterHaveSupply
	.align	1
	.global	SupplyUsability
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	SupplyUsability, %function
SupplyUsability:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r0, r1, r2, r4, r5, r6, r7, lr}	@
@ SupplyUsability.c:40: 	u8* supplyList = SupplyUsabilityTable[gChapterData.chapterIndex];
	ldr	r3, .L29	@ tmp139,
	ldrb	r3, [r3, #14]	@ tmp140,
@ SupplyUsability.c:40: 	u8* supplyList = SupplyUsabilityTable[gChapterData.chapterIndex];
	ldr	r2, .L29+4	@ tmp138,
	lsls	r3, r3, #2	@ tmp141, tmp140,
	ldr	r6, [r3, r2]	@ supplyList, SupplyUsabilityTable
@ SupplyUsability.c:41: 	if ( supplyList != NULL )
	cmp	r6, #0	@ supplyList,
	beq	.L15		@,
@ SupplyUsability.c:43: 		if ( gActiveUnit->pCharacterData->number != *SupplyUsabilityPhantomIDLink )
	ldr	r3, .L29+8	@ tmp142,
	ldr	r5, [r3]	@ gActiveUnit.1_3, gActiveUnit
@ SupplyUsability.c:43: 		if ( gActiveUnit->pCharacterData->number != *SupplyUsabilityPhantomIDLink )
	ldr	r3, .L29+12	@ tmp145,
@ SupplyUsability.c:43: 		if ( gActiveUnit->pCharacterData->number != *SupplyUsabilityPhantomIDLink )
	ldr	r2, [r5]	@ tmp159, gActiveUnit.1_3->pCharacterData
@ SupplyUsability.c:43: 		if ( gActiveUnit->pCharacterData->number != *SupplyUsabilityPhantomIDLink )
	ldr	r3, [r3]	@ SupplyUsabilityPhantomIDLink, SupplyUsabilityPhantomIDLink
@ SupplyUsability.c:43: 		if ( gActiveUnit->pCharacterData->number != *SupplyUsabilityPhantomIDLink )
	ldrb	r2, [r2, #4]	@ tmp146,
	ldrb	r3, [r3]	@ *SupplyUsabilityPhantomIDLink.2_6, *SupplyUsabilityPhantomIDLink.2_6
@ SupplyUsability.c:39: 	int Return = 3;
	movs	r0, #3	@ Return,
@ SupplyUsability.c:43: 		if ( gActiveUnit->pCharacterData->number != *SupplyUsabilityPhantomIDLink )
	cmp	r2, r3	@ tmp146, *SupplyUsabilityPhantomIDLink.2_6
	beq	.L13		@,
@ SupplyUsability.c:45: 			if ( DoesCharacterHaveSupply(gActiveUnit,supplyList) )
	movs	r1, r6	@, supplyList
	movs	r0, r5	@, gActiveUnit.1_3
	bl	DoesCharacterHaveSupply		@
@ SupplyUsability.c:45: 			if ( DoesCharacterHaveSupply(gActiveUnit,supplyList) )
	cmp	r0, #0	@ tmp148,
	bne	.L21		@,
	ldr	r7, .L29+16	@ ivtmp.22,
@ SupplyUsability.c:52: 				for ( int i = 0 ; i < 50 ; i++ )
	str	r0, [sp, #4]	@ tmp148, %sfp
.L14:
@ SupplyUsability.c:55: 					if ( curr->pCharacterData != NULL && DoesCharacterHaveSupply(curr,supplyList) )
	ldr	r3, [r7]	@ tmp160, MEM[base: _26, offset: 0B]
	cmp	r3, #0	@ tmp160,
	beq	.L11		@,
@ SupplyUsability.c:55: 					if ( curr->pCharacterData != NULL && DoesCharacterHaveSupply(curr,supplyList) )
	movs	r1, r6	@, supplyList
	movs	r0, r7	@, ivtmp.22
	bl	DoesCharacterHaveSupply		@
@ SupplyUsability.c:55: 					if ( curr->pCharacterData != NULL && DoesCharacterHaveSupply(curr,supplyList) )
	cmp	r0, #0	@ tmp151,
	beq	.L11		@,
@ SupplyUsability.c:57: 						if ( ( gActiveUnit->xPos == curr->xPos && ( ( gActiveUnit->yPos == curr->yPos+1 || gActiveUnit->yPos == curr->yPos-1 ) ) ) /* Unit is above || below.*/
	movs	r2, #16	@ _11,
@ SupplyUsability.c:57: 						if ( ( gActiveUnit->xPos == curr->xPos && ( ( gActiveUnit->yPos == curr->yPos+1 || gActiveUnit->yPos == curr->yPos-1 ) ) ) /* Unit is above || below.*/
	movs	r3, #16	@ _12,
	movs	r1, #17	@ pretmp_41,
	movs	r0, #17	@ pretmp_39,
@ SupplyUsability.c:57: 						if ( ( gActiveUnit->xPos == curr->xPos && ( ( gActiveUnit->yPos == curr->yPos+1 || gActiveUnit->yPos == curr->yPos-1 ) ) ) /* Unit is above || below.*/
	ldrsb	r2, [r5, r2]	@ _11,* _11
@ SupplyUsability.c:57: 						if ( ( gActiveUnit->xPos == curr->xPos && ( ( gActiveUnit->yPos == curr->yPos+1 || gActiveUnit->yPos == curr->yPos-1 ) ) ) /* Unit is above || below.*/
	ldrsb	r3, [r7, r3]	@ _12,* _12
	ldrsb	r1, [r5, r1]	@ pretmp_41,* pretmp_41
	ldrsb	r0, [r7, r0]	@ pretmp_39,* pretmp_39
@ SupplyUsability.c:57: 						if ( ( gActiveUnit->xPos == curr->xPos && ( ( gActiveUnit->yPos == curr->yPos+1 || gActiveUnit->yPos == curr->yPos-1 ) ) ) /* Unit is above || below.*/
	cmp	r2, r3	@ _11, _12
	bne	.L12		@,
@ SupplyUsability.c:57: 						if ( ( gActiveUnit->xPos == curr->xPos && ( ( gActiveUnit->yPos == curr->yPos+1 || gActiveUnit->yPos == curr->yPos-1 ) ) ) /* Unit is above || below.*/
	adds	r4, r0, #1	@ tmp153, pretmp_39,
@ SupplyUsability.c:57: 						if ( ( gActiveUnit->xPos == curr->xPos && ( ( gActiveUnit->yPos == curr->yPos+1 || gActiveUnit->yPos == curr->yPos-1 ) ) ) /* Unit is above || below.*/
	cmp	r1, r4	@ pretmp_41, tmp153
	beq	.L21		@,
@ SupplyUsability.c:57: 						if ( ( gActiveUnit->xPos == curr->xPos && ( ( gActiveUnit->yPos == curr->yPos+1 || gActiveUnit->yPos == curr->yPos-1 ) ) ) /* Unit is above || below.*/
	subs	r4, r0, #1	@ tmp154, pretmp_39,
@ SupplyUsability.c:57: 						if ( ( gActiveUnit->xPos == curr->xPos && ( ( gActiveUnit->yPos == curr->yPos+1 || gActiveUnit->yPos == curr->yPos-1 ) ) ) /* Unit is above || below.*/
	cmp	r1, r4	@ pretmp_41, tmp154
	beq	.L21		@,
.L12:
@ SupplyUsability.c:58: 							|| ( gActiveUnit->yPos == curr->yPos && ( ( gActiveUnit->xPos == curr->xPos+1 || gActiveUnit->xPos == curr->xPos-1 ) ) ) ) /* Unit is right || left. */
	cmp	r0, r1	@ pretmp_39, pretmp_41
	bne	.L11		@,
@ SupplyUsability.c:58: 							|| ( gActiveUnit->yPos == curr->yPos && ( ( gActiveUnit->xPos == curr->xPos+1 || gActiveUnit->xPos == curr->xPos-1 ) ) ) ) /* Unit is right || left. */
	adds	r1, r3, #1	@ tmp155, _12,
@ SupplyUsability.c:58: 							|| ( gActiveUnit->yPos == curr->yPos && ( ( gActiveUnit->xPos == curr->xPos+1 || gActiveUnit->xPos == curr->xPos-1 ) ) ) ) /* Unit is right || left. */
	cmp	r2, r1	@ _11, tmp155
	beq	.L21		@,
@ SupplyUsability.c:58: 							|| ( gActiveUnit->yPos == curr->yPos && ( ( gActiveUnit->xPos == curr->xPos+1 || gActiveUnit->xPos == curr->xPos-1 ) ) ) ) /* Unit is right || left. */
	subs	r3, r3, #1	@ tmp156,
@ SupplyUsability.c:58: 							|| ( gActiveUnit->yPos == curr->yPos && ( ( gActiveUnit->xPos == curr->xPos+1 || gActiveUnit->xPos == curr->xPos-1 ) ) ) ) /* Unit is right || left. */
	cmp	r2, r3	@ _11, tmp156
	beq	.L21		@,
.L11:
@ SupplyUsability.c:52: 				for ( int i = 0 ; i < 50 ; i++ )
	ldr	r3, [sp, #4]	@ i, %sfp
	adds	r3, r3, #1	@ i,
	str	r3, [sp, #4]	@ i, %sfp
	adds	r7, r7, #72	@ ivtmp.22,
@ SupplyUsability.c:52: 				for ( int i = 0 ; i < 50 ; i++ )
	cmp	r3, #50	@ i,
	bne	.L14		@,
.L15:
@ SupplyUsability.c:39: 	int Return = 3;
	movs	r0, #3	@ Return,
.L13:
@ SupplyUsability.c:68: }
	@ sp needed	@
	pop	{r1, r2, r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L21:
@ SupplyUsability.c:60: 							return 1;
	movs	r0, #1	@ <retval>,
	b	.L13		@
.L30:
	.align	2
.L29:
	.word	gChapterData
	.word	SupplyUsabilityTable
	.word	gActiveUnit
	.word	SupplyUsabilityPhantomIDLink
	.word	gUnitArrayBlue
	.size	SupplyUsability, .-SupplyUsability
	.ident	"GCC: (devkitARM release 52-2) 8.3.0"
