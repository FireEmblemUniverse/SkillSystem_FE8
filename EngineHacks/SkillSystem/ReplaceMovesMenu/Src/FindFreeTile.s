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
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}	@
@ FindFreeTile.c:12:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0xFF;
	ldr	r3, .L22	@ tmp335,
@ FindFreeTile.c:5: {
	sub	sp, sp, #20	@,,
@ FindFreeTile.c:5: {
	str	r2, [sp, #8]	@ tmp323, %sfp
@ FindFreeTile.c:12:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0xFF;
	ldr	r2, [r3]	@ gActiveUnit.1_2, gActiveUnit
	movs	r3, #17	@ tmp223,
@ FindFreeTile.c:5: {
	str	r1, [sp, #4]	@ tmp322, %sfp
@ FindFreeTile.c:12:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0xFF;
	ldr	r1, .L22+4	@ tmp225,
@ FindFreeTile.c:12:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0xFF;
	ldrsb	r3, [r2, r3]	@ tmp223,
@ FindFreeTile.c:12:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0xFF;
	ldr	r1, [r1]	@ gMapUnit, gMapUnit
	lsls	r3, r3, #2	@ tmp226, tmp223,
@ FindFreeTile.c:12:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0xFF;
	ldr	r3, [r3, r1]	@ *_6, *_6
	movs	r1, #255	@ tmp229,
@ FindFreeTile.c:12:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0xFF;
	ldrb	r2, [r2, #16]	@ tmp227,
	lsls	r2, r2, #24	@ tmp227, tmp227,
	asrs	r2, r2, #24	@ tmp227, tmp227,
@ FindFreeTile.c:12:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0xFF;
	strb	r1, [r3, r2]	@ tmp229, *_11
@ FindFreeTile.c:16: 	FillMovementMapForUnit(unit); // fill with flier movement & own movement 
	ldr	r3, .L22+8	@ tmp231,
@ FindFreeTile.c:5: {
	movs	r4, r0	@ unit, tmp321
@ FindFreeTile.c:16: 	FillMovementMapForUnit(unit); // fill with flier movement & own movement 
	bl	.L24		@
@ FindFreeTile.c:18:     for (iy = gMapSize.y - 1; iy >= 0; --iy)
	ldr	r3, .L22+12	@ tmp232,
	ldrh	r6, [r3, #2]	@ tmp233,
@ FindFreeTile.c:6:     int iy, ix, minDistance = 9999;
	ldr	r3, .L22+16	@ minDistance,
	str	r3, [sp]	@ minDistance, %sfp
@ FindFreeTile.c:18:     for (iy = gMapSize.y - 1; iy >= 0; --iy)
	subs	r6, r6, #1	@ iy,
.L2:
@ FindFreeTile.c:18:     for (iy = gMapSize.y - 1; iy >= 0; --iy)
	adds	r3, r6, #1	@ tmp329, iy,
	bne	.L6		@,
@ FindFreeTile.c:48: 	if (*xOut == 0xFFFFFFFF) { 
	ldr	r3, [sp, #4]	@ xOut, %sfp
	ldr	r3, [r3]	@ *xOut_124(D), *xOut_124(D)
	str	r3, [sp, #12]	@ *xOut_124(D), %sfp
	adds	r3, r3, #1	@ tmp330, *xOut_124(D),
	beq	.L7		@,
.L13:
@ FindFreeTile.c:92:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0;
	ldr	r3, .L22	@ tmp345,
	ldr	r2, [r3]	@ gActiveUnit.28_92, gActiveUnit
	movs	r3, #17	@ tmp269,
@ FindFreeTile.c:92:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0;
	ldr	r1, .L22+4	@ tmp271,
@ FindFreeTile.c:92:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0;
	ldrsb	r3, [r2, r3]	@ tmp269,
@ FindFreeTile.c:92:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0;
	ldr	r1, [r1]	@ gMapUnit, gMapUnit
	lsls	r3, r3, #2	@ tmp272, tmp269,
@ FindFreeTile.c:92:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0;
	ldr	r3, [r3, r1]	@ *_96, *_96
	movs	r1, #0	@ tmp275,
@ FindFreeTile.c:92:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0;
	ldrb	r2, [r2, #16]	@ tmp273,
	lsls	r2, r2, #24	@ tmp273, tmp273,
	asrs	r2, r2, #24	@ tmp273, tmp273,
@ FindFreeTile.c:92:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0;
	strb	r1, [r3, r2]	@ tmp275, *_100
@ FindFreeTile.c:93: }
	add	sp, sp, #20	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L6:
@ FindFreeTile.c:20:         for (ix = gMapSize.x - 1; ix >= 0; --ix)
	ldr	r3, .L22+12	@ tmp234,
	ldrh	r5, [r3]	@ gMapSize, gMapSize
	lsls	r7, r6, #2	@ _187, iy,
@ FindFreeTile.c:20:         for (ix = gMapSize.x - 1; ix >= 0; --ix)
	subs	r5, r5, #1	@ ix,
.L3:
@ FindFreeTile.c:20:         for (ix = gMapSize.x - 1; ix >= 0; --ix)
	adds	r3, r5, #1	@ tmp328, ix,
	bne	.L5		@,
@ FindFreeTile.c:18:     for (iy = gMapSize.y - 1; iy >= 0; --iy)
	subs	r6, r6, #1	@ iy,
	b	.L2		@
.L5:
@ FindFreeTile.c:24:             if (gMapMovement[iy][ix] > 14) // I think high movement costs might cause an overflow issue here? So I'm using 1, 2, 15, 255 cost. 
	ldr	r3, .L22+20	@ tmp237,
	ldr	r3, [r3]	@ gMapMovement, gMapMovement
@ FindFreeTile.c:24:             if (gMapMovement[iy][ix] > 14) // I think high movement costs might cause an overflow issue here? So I'm using 1, 2, 15, 255 cost. 
	ldr	r3, [r3, r7]	@ *_19, *_19
@ FindFreeTile.c:24:             if (gMapMovement[iy][ix] > 14) // I think high movement costs might cause an overflow issue here? So I'm using 1, 2, 15, 255 cost. 
	ldrb	r3, [r3, r5]	@ *_22, *_22
	cmp	r3, #14	@ *_22,
	bhi	.L4		@,
@ FindFreeTile.c:27:             if (gMapUnit[iy][ix] != 0)
	ldr	r3, .L22+4	@ tmp243,
	ldr	r3, [r3]	@ gMapUnit, gMapUnit
@ FindFreeTile.c:27:             if (gMapUnit[iy][ix] != 0)
	ldr	r3, [r3, r7]	@ *_25, *_25
@ FindFreeTile.c:27:             if (gMapUnit[iy][ix] != 0)
	ldrb	r3, [r3, r5]	@ *_27, *_27
	cmp	r3, #0	@ *_27,
	bne	.L4		@,
@ FindFreeTile.c:30:             if (gMapHidden[iy][ix] & HIDDEN_BIT_UNIT)
	movs	r2, #1	@ tmp337,
@ FindFreeTile.c:30:             if (gMapHidden[iy][ix] & HIDDEN_BIT_UNIT)
	ldr	r3, .L22+24	@ tmp247,
	ldr	r3, [r3]	@ gMapHidden, gMapHidden
@ FindFreeTile.c:30:             if (gMapHidden[iy][ix] & HIDDEN_BIT_UNIT)
	ldr	r3, [r3, r7]	@ *_30, *_30
@ FindFreeTile.c:30:             if (gMapHidden[iy][ix] & HIDDEN_BIT_UNIT)
	ldrb	r3, [r3, r5]	@ *_32, *_32
	tst	r3, r2	@ *_32, tmp337
	bne	.L4		@,
@ FindFreeTile.c:33:             if (!CanUnitCrossTerrain(unit, gMapTerrain[iy][ix]))
	ldr	r3, .L22+28	@ tmp257,
	ldr	r3, [r3]	@ gMapTerrain, gMapTerrain
@ FindFreeTile.c:33:             if (!CanUnitCrossTerrain(unit, gMapTerrain[iy][ix]))
	ldr	r3, [r3, r7]	@ *_35, *_35
	movs	r0, r4	@, unit
	ldrb	r1, [r3, r5]	@ *_37, *_37
	ldr	r3, .L22+32	@ tmp260,
	bl	.L24		@
@ FindFreeTile.c:33:             if (!CanUnitCrossTerrain(unit, gMapTerrain[iy][ix]))
	cmp	r0, #0	@ tmp324,
	beq	.L4		@,
@ FindFreeTile.c:36:             distance = RECT_DISTANCE(ix, iy, unit->xPos, unit->yPos);
	movs	r3, #16	@ tmp261,
	ldrsb	r3, [r4, r3]	@ tmp261,
	subs	r3, r5, r3	@ tmp262, ix, tmp261
	asrs	r2, r3, #31	@ tmp326, tmp262,
	adds	r3, r3, r2	@ tmp263, tmp262, tmp326
	eors	r3, r2	@ tmp263, tmp326
	movs	r2, #17	@ tmp264,
	ldrsb	r2, [r4, r2]	@ tmp264,
	subs	r2, r6, r2	@ tmp265, iy, tmp264
	asrs	r1, r2, #31	@ tmp327, tmp265,
	adds	r2, r2, r1	@ tmp266, tmp265, tmp327
	eors	r2, r1	@ tmp266, tmp327
@ FindFreeTile.c:36:             distance = RECT_DISTANCE(ix, iy, unit->xPos, unit->yPos);
	adds	r3, r3, r2	@ distance, tmp263, tmp266
@ FindFreeTile.c:38:             if (minDistance >= distance)
	ldr	r2, [sp]	@ minDistance, %sfp
	cmp	r2, r3	@ minDistance, distance
	blt	.L4		@,
@ FindFreeTile.c:42:                 *xOut = ix;
	ldr	r2, [sp, #4]	@ xOut, %sfp
	str	r5, [r2]	@ ix, *xOut_124(D)
@ FindFreeTile.c:43:                 *yOut = iy;
	ldr	r2, [sp, #8]	@ yOut, %sfp
	str	r3, [sp]	@ distance, %sfp
	str	r6, [r2]	@ iy, *yOut_133(D)
.L4:
@ FindFreeTile.c:20:         for (ix = gMapSize.x - 1; ix >= 0; --ix)
	subs	r5, r5, #1	@ ix,
	b	.L3		@
.L7:
@ FindFreeTile.c:53: 		MapMovementFillMovementFromPosition(unit->xPos, unit->yPos, GenericMovCost); // void MapFloodExtended(int x, int y, i8 const move_table[]);
	movs	r1, #17	@ tmp278,
	movs	r0, #16	@ tmp279,
	ldr	r3, .L22+36	@ tmp280,
	ldrsb	r1, [r4, r1]	@ tmp278,
	ldrsb	r0, [r4, r0]	@ tmp279,
	ldr	r2, .L22+40	@,
	bl	.L24		@
@ FindFreeTile.c:57: 		for (iy = gMapSize.y - 1; iy >= 0; --iy)
	ldr	r3, .L22+12	@ tmp281,
	ldrh	r6, [r3, #2]	@ tmp282,
.L21:
@ FindFreeTile.c:57: 		for (iy = gMapSize.y - 1; iy >= 0; --iy)
	subs	r6, r6, #1	@ iy,
@ FindFreeTile.c:57: 		for (iy = gMapSize.y - 1; iy >= 0; --iy)
	adds	r3, r6, #1	@ tmp334, iy,
	beq	.L13		@,
@ FindFreeTile.c:59: 			for (ix = gMapSize.x - 1; ix >= 0; --ix)
	ldr	r3, .L22+12	@ tmp283,
	ldrh	r5, [r3]	@ gMapSize, gMapSize
	lsls	r7, r6, #2	@ _190, iy,
@ FindFreeTile.c:59: 			for (ix = gMapSize.x - 1; ix >= 0; --ix)
	subs	r5, r5, #1	@ ix,
.L9:
@ FindFreeTile.c:59: 			for (ix = gMapSize.x - 1; ix >= 0; --ix)
	adds	r3, r5, #1	@ tmp333, ix,
	beq	.L21		@,
@ FindFreeTile.c:63: 				if (gMapMovement[iy][ix] > 14) // I think high movement costs might cause an overflow issue here? So I'm using 1, 2, 15, 255 cost. 
	ldr	r3, .L22+20	@ tmp286,
	ldr	r3, [r3]	@ gMapMovement, gMapMovement
@ FindFreeTile.c:63: 				if (gMapMovement[iy][ix] > 14) // I think high movement costs might cause an overflow issue here? So I'm using 1, 2, 15, 255 cost. 
	ldr	r3, [r3, r7]	@ *_60, *_60
@ FindFreeTile.c:63: 				if (gMapMovement[iy][ix] > 14) // I think high movement costs might cause an overflow issue here? So I'm using 1, 2, 15, 255 cost. 
	ldrb	r3, [r3, r5]	@ *_63, *_63
	cmp	r3, #14	@ *_63,
	bhi	.L10		@,
@ FindFreeTile.c:66: 				if (gMapUnit[iy][ix] != 0)
	ldr	r3, .L22+4	@ tmp292,
	ldr	r3, [r3]	@ gMapUnit, gMapUnit
@ FindFreeTile.c:66: 				if (gMapUnit[iy][ix] != 0)
	ldr	r3, [r3, r7]	@ *_68, *_68
@ FindFreeTile.c:66: 				if (gMapUnit[iy][ix] != 0)
	ldrb	r3, [r3, r5]	@ *_70, *_70
	cmp	r3, #0	@ *_70,
	bne	.L10		@,
@ FindFreeTile.c:69: 				if (gMapHidden[iy][ix] & HIDDEN_BIT_UNIT)
	movs	r2, #1	@ tmp346,
@ FindFreeTile.c:69: 				if (gMapHidden[iy][ix] & HIDDEN_BIT_UNIT)
	ldr	r3, .L22+24	@ tmp296,
	ldr	r3, [r3]	@ gMapHidden, gMapHidden
@ FindFreeTile.c:69: 				if (gMapHidden[iy][ix] & HIDDEN_BIT_UNIT)
	ldr	r3, [r3, r7]	@ *_73, *_73
@ FindFreeTile.c:69: 				if (gMapHidden[iy][ix] & HIDDEN_BIT_UNIT)
	ldrb	r3, [r3, r5]	@ *_75, *_75
	tst	r3, r2	@ *_75, tmp346
	bne	.L10		@,
@ FindFreeTile.c:72: 				if (!CanUnitCrossTerrain(unit, gMapTerrain[iy][ix]))
	ldr	r3, .L22+28	@ tmp306,
	ldr	r3, [r3]	@ gMapTerrain, gMapTerrain
@ FindFreeTile.c:72: 				if (!CanUnitCrossTerrain(unit, gMapTerrain[iy][ix]))
	ldr	r3, [r3, r7]	@ *_78, *_78
	movs	r0, r4	@, unit
	ldrb	r1, [r3, r5]	@ *_80, *_80
	ldr	r3, .L22+32	@ tmp309,
	bl	.L24		@
@ FindFreeTile.c:72: 				if (!CanUnitCrossTerrain(unit, gMapTerrain[iy][ix]))
	cmp	r0, #0	@ tmp325,
	beq	.L10		@,
@ FindFreeTile.c:75: 				distance = RECT_DISTANCE(ix, iy, unit->xPos, unit->yPos);
	movs	r3, #16	@ tmp310,
	ldrsb	r3, [r4, r3]	@ tmp310,
	subs	r3, r5, r3	@ tmp311, ix, tmp310
	asrs	r2, r3, #31	@ tmp331, tmp311,
	adds	r3, r3, r2	@ tmp312, tmp311, tmp331
	eors	r3, r2	@ tmp312, tmp331
	movs	r2, #17	@ tmp313,
	ldrsb	r2, [r4, r2]	@ tmp313,
	subs	r2, r6, r2	@ tmp314, iy, tmp313
	asrs	r1, r2, #31	@ tmp332, tmp314,
	adds	r2, r2, r1	@ tmp315, tmp314, tmp332
	eors	r2, r1	@ tmp315, tmp332
@ FindFreeTile.c:75: 				distance = RECT_DISTANCE(ix, iy, unit->xPos, unit->yPos);
	adds	r3, r3, r2	@ distance, tmp312, tmp315
@ FindFreeTile.c:77: 				if (minDistance >= distance)
	ldr	r2, [sp]	@ minDistance, %sfp
	cmp	r2, r3	@ minDistance, distance
	blt	.L10		@,
@ FindFreeTile.c:81: 					*xOut = ix;
	ldr	r2, [sp, #4]	@ xOut, %sfp
	str	r5, [r2]	@ ix, *xOut_124(D)
@ FindFreeTile.c:82: 					*yOut = iy;
	ldr	r2, [sp, #8]	@ yOut, %sfp
	str	r3, [sp]	@ distance, %sfp
	str	r6, [r2]	@ iy, *yOut_133(D)
.L10:
@ FindFreeTile.c:59: 			for (ix = gMapSize.x - 1; ix >= 0; --ix)
	subs	r5, r5, #1	@ ix,
	b	.L9		@
.L23:
	.align	2
.L22:
	.word	gActiveUnit
	.word	gMapUnit
	.word	FillMovementMapForUnit
	.word	gMapSize
	.word	9999
	.word	gMapMovement
	.word	gMapHidden
	.word	gMapTerrain
	.word	CanUnitCrossTerrain
	.word	MapMovementFillMovementFromPosition
	.word	GenericMovCost
	.size	FindFreeTile, .-FindFreeTile
	.ident	"GCC: (devkitARM release 54) 10.1.0"
	.code 16
	.align	1
.L24:
	bx	r3
