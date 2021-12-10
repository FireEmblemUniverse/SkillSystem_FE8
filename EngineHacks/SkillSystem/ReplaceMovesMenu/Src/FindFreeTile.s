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
	.file	"FindFreeTile.c"
@ GNU C17 (devkitARM release 54) version 10.1.0 (arm-none-eabi)
@	compiled by GNU C version 6.4.0, GMP version 6.0.0, MPFR version 3.1.2, MPC version 1.0.2, isl version none
@ GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
@ options passed:  -imultilib thumb
@ -iprefix c:\devkitpro\devkitarm\bin\../lib/gcc/arm-none-eabi/10.1.0/
@ -D__USES_INITFINI__ FindFreeTile.c -mcpu=arm7tdmi -mthumb
@ -mthumb-interwork -mtune=arm7tdmi -mlong-calls -march=armv4t
@ -auxbase-strip FindFreeTile.s -Os -Wall -fverbose-asm
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
	.global	FindFreeTile
	.arch armv4t
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	FindFreeTile, %function
FindFreeTile:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}	@
	sub	sp, sp, #28	@,,
@ FindFreeTile.c:5: {
	str	r1, [sp, #16]	@ tmp243, %sfp
@ FindFreeTile.c:10:     MapMovementFillMovementFromPosition(unit->xPos, unit->yPos, GenericMovCost); // void MapFloodExtended(int x, int y, i8 const move_table[]);
	movs	r1, #17	@ tmp182,
@ FindFreeTile.c:5: {
	str	r0, [sp, #4]	@ tmp242, %sfp
	str	r2, [sp, #20]	@ tmp244, %sfp
@ FindFreeTile.c:10:     MapMovementFillMovementFromPosition(unit->xPos, unit->yPos, GenericMovCost); // void MapFloodExtended(int x, int y, i8 const move_table[]);
	movs	r3, r0	@ unit, tmp242
	ldrsb	r1, [r0, r1]	@ tmp182,
	movs	r0, #16	@ tmp183,
	ldr	r2, .L10	@,
	ldrsb	r0, [r3, r0]	@ tmp183,
	ldr	r3, .L10+4	@ tmp184,
	bl	.L12		@
@ FindFreeTile.c:13:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0xFF;
	movs	r3, #17	@ tmp186,
	ldr	r7, .L10+8	@ tmp185,
	ldr	r2, [r7]	@ gActiveUnit.1_6, gActiveUnit
@ FindFreeTile.c:13:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0xFF;
	ldr	r6, .L10+12	@ tmp188,
@ FindFreeTile.c:13:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0xFF;
	ldrsb	r3, [r2, r3]	@ tmp186,
@ FindFreeTile.c:13:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0xFF;
	ldr	r1, [r6]	@ tmp252, gMapUnit
@ FindFreeTile.c:13:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0xFF;
	lsls	r3, r3, #2	@ tmp189, tmp186,
@ FindFreeTile.c:13:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0xFF;
	ldr	r3, [r3, r1]	@ *_10, *_10
	movs	r1, #255	@ tmp192,
@ FindFreeTile.c:13:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0xFF;
	ldrb	r2, [r2, #16]	@ tmp190,
	lsls	r2, r2, #24	@ tmp190, tmp190,
	asrs	r2, r2, #24	@ tmp190, tmp190,
@ FindFreeTile.c:13:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0xFF;
	strb	r1, [r3, r2]	@ tmp192, *_15
@ FindFreeTile.c:16:     for (iy = gMapSize.y - 1; iy >= 0; --iy)
	ldr	r3, .L10+16	@ tmp194,
	ldrh	r5, [r3, #2]	@ tmp195,
@ FindFreeTile.c:6:     int iy, ix, minDistance = 9999;
	ldr	r3, .L10+20	@ minDistance,
	str	r3, [sp, #12]	@ minDistance, %sfp
@ FindFreeTile.c:16:     for (iy = gMapSize.y - 1; iy >= 0; --iy)
	subs	r5, r5, #1	@ iy,
.L2:
@ FindFreeTile.c:16:     for (iy = gMapSize.y - 1; iy >= 0; --iy)
	adds	r3, r5, #1	@ tmp249, iy,
	bne	.L6		@,
@ FindFreeTile.c:47:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0;
	movs	r3, #17	@ tmp230,
	ldr	r2, [r7]	@ gActiveUnit.16_53, gActiveUnit
	ldrsb	r3, [r2, r3]	@ tmp230,
@ FindFreeTile.c:47:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0;
	ldr	r1, [r6]	@ gMapUnit, gMapUnit
	lsls	r3, r3, #2	@ tmp233, tmp230,
@ FindFreeTile.c:47:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0;
	ldr	r3, [r3, r1]	@ *_57, *_57
	movs	r1, #0	@ tmp236,
@ FindFreeTile.c:47:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0;
	ldrb	r2, [r2, #16]	@ tmp234,
	lsls	r2, r2, #24	@ tmp234, tmp234,
	asrs	r2, r2, #24	@ tmp234, tmp234,
@ FindFreeTile.c:47:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0;
	strb	r1, [r3, r2]	@ tmp236, *_61
@ FindFreeTile.c:48: }
	add	sp, sp, #28	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L6:
@ FindFreeTile.c:18:         for (ix = gMapSize.x - 1; ix >= 0; --ix)
	ldr	r3, .L10+16	@ tmp196,
	ldrh	r4, [r3]	@ gMapSize, gMapSize
	lsls	r3, r5, #2	@ _124, iy,
	str	r3, [sp, #8]	@ _124, %sfp
@ FindFreeTile.c:18:         for (ix = gMapSize.x - 1; ix >= 0; --ix)
	subs	r4, r4, #1	@ ix,
.L3:
@ FindFreeTile.c:18:         for (ix = gMapSize.x - 1; ix >= 0; --ix)
	adds	r3, r4, #1	@ tmp248, ix,
	bne	.L5		@,
@ FindFreeTile.c:16:     for (iy = gMapSize.y - 1; iy >= 0; --iy)
	subs	r5, r5, #1	@ iy,
	b	.L2		@
.L5:
@ FindFreeTile.c:22:             if (gMapMovement[iy][ix] > 14) // NEW_MAP_MOVEMENT_MAX
	ldr	r3, .L10+24	@ tmp199,
@ FindFreeTile.c:22:             if (gMapMovement[iy][ix] > 14) // NEW_MAP_MOVEMENT_MAX
	ldr	r2, [sp, #8]	@ _124, %sfp
@ FindFreeTile.c:22:             if (gMapMovement[iy][ix] > 14) // NEW_MAP_MOVEMENT_MAX
	ldr	r3, [r3]	@ gMapMovement, gMapMovement
@ FindFreeTile.c:22:             if (gMapMovement[iy][ix] > 14) // NEW_MAP_MOVEMENT_MAX
	ldr	r3, [r3, r2]	@ *_23, *_23
@ FindFreeTile.c:22:             if (gMapMovement[iy][ix] > 14) // NEW_MAP_MOVEMENT_MAX
	ldrb	r3, [r3, r4]	@ *_26, *_26
	cmp	r3, #14	@ *_26,
	bhi	.L4		@,
@ FindFreeTile.c:25:             if (gMapUnit[iy][ix] != 0)
	ldr	r3, .L10+12	@ tmp205,
	ldr	r3, [r3]	@ gMapUnit, gMapUnit
@ FindFreeTile.c:25:             if (gMapUnit[iy][ix] != 0)
	ldr	r3, [r3, r2]	@ *_29, *_29
@ FindFreeTile.c:25:             if (gMapUnit[iy][ix] != 0)
	ldrb	r3, [r3, r4]	@ *_31, *_31
	cmp	r3, #0	@ *_31,
	bne	.L4		@,
@ FindFreeTile.c:28:             if (gMapHidden[iy][ix] & HIDDEN_BIT_UNIT)
	ldr	r3, .L10+28	@ tmp209,
	ldr	r3, [r3]	@ gMapHidden, gMapHidden
@ FindFreeTile.c:28:             if (gMapHidden[iy][ix] & HIDDEN_BIT_UNIT)
	ldr	r3, [r3, r2]	@ *_34, *_34
@ FindFreeTile.c:28:             if (gMapHidden[iy][ix] & HIDDEN_BIT_UNIT)
	movs	r2, #1	@ tmp258,
	ldrb	r3, [r3, r4]	@ *_36, *_36
	tst	r3, r2	@ *_36, tmp258
	bne	.L4		@,
@ FindFreeTile.c:31:             if (!CanUnitCrossTerrain(unit, gMapTerrain[iy][ix]))
	ldr	r3, .L10+32	@ tmp219,
@ FindFreeTile.c:31:             if (!CanUnitCrossTerrain(unit, gMapTerrain[iy][ix]))
	ldr	r2, [sp, #8]	@ _124, %sfp
@ FindFreeTile.c:31:             if (!CanUnitCrossTerrain(unit, gMapTerrain[iy][ix]))
	ldr	r3, [r3]	@ gMapTerrain, gMapTerrain
@ FindFreeTile.c:31:             if (!CanUnitCrossTerrain(unit, gMapTerrain[iy][ix]))
	ldr	r3, [r3, r2]	@ *_39, *_39
	ldr	r0, [sp, #4]	@, %sfp
	ldrb	r1, [r3, r4]	@ *_41, *_41
	ldr	r3, .L10+36	@ tmp222,
	bl	.L12		@
@ FindFreeTile.c:31:             if (!CanUnitCrossTerrain(unit, gMapTerrain[iy][ix]))
	cmp	r0, #0	@ tmp245,
	beq	.L4		@,
@ FindFreeTile.c:34:             distance = RECT_DISTANCE(ix, iy, unit->xPos, unit->yPos);
	ldr	r3, [sp, #4]	@ unit, %sfp
	ldrb	r3, [r3, #16]	@ tmp223,
	lsls	r3, r3, #24	@ tmp223, tmp223,
	asrs	r3, r3, #24	@ tmp223, tmp223,
	subs	r3, r4, r3	@ tmp224, ix, tmp223
	asrs	r2, r3, #31	@ tmp246, tmp224,
	adds	r3, r3, r2	@ tmp225, tmp224, tmp246
	eors	r3, r2	@ tmp225, tmp246
	ldr	r2, [sp, #4]	@ unit, %sfp
	ldrb	r2, [r2, #17]	@ tmp226,
	lsls	r2, r2, #24	@ tmp226, tmp226,
	asrs	r2, r2, #24	@ tmp226, tmp226,
	subs	r2, r5, r2	@ tmp227, iy, tmp226
	asrs	r1, r2, #31	@ tmp247, tmp227,
	adds	r2, r2, r1	@ tmp228, tmp227, tmp247
	eors	r2, r1	@ tmp228, tmp247
@ FindFreeTile.c:34:             distance = RECT_DISTANCE(ix, iy, unit->xPos, unit->yPos);
	adds	r3, r3, r2	@ distance, tmp225, tmp228
@ FindFreeTile.c:36:             if (minDistance >= distance)
	ldr	r2, [sp, #12]	@ minDistance, %sfp
	cmp	r2, r3	@ minDistance, distance
	blt	.L4		@,
@ FindFreeTile.c:40:                 *xOut = ix;
	ldr	r2, [sp, #16]	@ xOut, %sfp
	str	r4, [r2]	@ ix, *xOut_81(D)
@ FindFreeTile.c:41:                 *yOut = iy;
	ldr	r2, [sp, #20]	@ yOut, %sfp
	str	r3, [sp, #12]	@ distance, %sfp
	str	r5, [r2]	@ iy, *yOut_83(D)
.L4:
@ FindFreeTile.c:18:         for (ix = gMapSize.x - 1; ix >= 0; --ix)
	subs	r4, r4, #1	@ ix,
	b	.L3		@
.L11:
	.align	2
.L10:
	.word	GenericMovCost
	.word	MapMovementFillMovementFromPosition
	.word	gActiveUnit
	.word	gMapUnit
	.word	gMapSize
	.word	9999
	.word	gMapMovement
	.word	gMapHidden
	.word	gMapTerrain
	.word	CanUnitCrossTerrain
	.size	FindFreeTile, .-FindFreeTile
	.ident	"GCC: (devkitARM release 54) 10.1.0"
	.code 16
	.align	1
.L12:
	bx	r3
