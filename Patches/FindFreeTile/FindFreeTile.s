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
@ GNU C17 (devkitARM release 56) version 11.1.0 (arm-none-eabi)
@	compiled by GNU C version 10.3.0, GMP version 6.2.1, MPFR version 4.1.0, MPC version 1.2.1, isl version isl-0.18-GMP

@ GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
@ options passed: -mcpu=arm7tdmi -mthumb -mthumb-interwork -mtune=arm7tdmi -mlong-calls -march=armv4t -Os
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
@ FindFreeTile.c:14:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0xFF;
	ldr	r3, .L22	@ tmp222,
@ FindFreeTile.c:7: {
	sub	sp, sp, #20	@,,
@ FindFreeTile.c:7: {
	str	r2, [sp, #8]	@ tmp322, %sfp
@ FindFreeTile.c:14:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0xFF;
	str	r3, [sp, #12]	@ tmp222, %sfp
	ldr	r2, [r3]	@ gActiveUnit.1_2, gActiveUnit
	movs	r3, #17	@ tmp223,
@ FindFreeTile.c:7: {
	str	r1, [sp, #4]	@ tmp321, %sfp
@ FindFreeTile.c:14:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0xFF;
	ldr	r1, .L22+4	@ tmp225,
@ FindFreeTile.c:14:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0xFF;
	ldrsb	r3, [r2, r3]	@ tmp223,
@ FindFreeTile.c:14:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0xFF;
	ldr	r1, [r1]	@ gMapUnit, gMapUnit
	lsls	r3, r3, #2	@ tmp226, tmp223,
@ FindFreeTile.c:14:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0xFF;
	ldr	r3, [r3, r1]	@ *_6, *_6
	movs	r1, #255	@ tmp229,
@ FindFreeTile.c:14:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0xFF;
	ldrb	r2, [r2, #16]	@ tmp227,
	lsls	r2, r2, #24	@ tmp227, tmp227,
	asrs	r2, r2, #24	@ tmp227, tmp227,
@ FindFreeTile.c:14:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0xFF;
	strb	r1, [r3, r2]	@ tmp229, *_11
@ FindFreeTile.c:18: 	FillMovementMapForUnit(unit); // fill with flier movement & own movement 
	ldr	r3, .L22+8	@ tmp231,
@ FindFreeTile.c:7: {
	movs	r4, r0	@ unit, tmp320
@ FindFreeTile.c:18: 	FillMovementMapForUnit(unit); // fill with flier movement & own movement 
	bl	.L24		@
@ FindFreeTile.c:20:     for (iy = gMapSize.y - 1; iy >= 0; --iy)
	ldr	r3, .L22+12	@ tmp232,
	ldrh	r6, [r3, #2]	@ tmp233,
@ FindFreeTile.c:8:     int iy, ix, minDistance = 9999;
	ldr	r3, .L22+16	@ minDistance,
	str	r3, [sp]	@ minDistance, %sfp
@ FindFreeTile.c:20:     for (iy = gMapSize.y - 1; iy >= 0; --iy)
	subs	r6, r6, #1	@ iy,
.L2:
@ FindFreeTile.c:20:     for (iy = gMapSize.y - 1; iy >= 0; --iy)
	adds	r3, r6, #1	@ tmp328, iy,
	bne	.L6		@,
@ FindFreeTile.c:50: 	if (*xOut == 0xFFFFFFFF) { 
	ldr	r3, [sp, #4]	@ xOut, %sfp
	ldr	r3, [r3]	@ *xOut_124(D), *xOut_124(D)
	adds	r3, r3, #1	@ tmp329, *xOut_124(D),
	beq	.L7		@,
.L13:
@ FindFreeTile.c:94:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0;
	ldr	r3, [sp, #12]	@ tmp222, %sfp
	ldr	r2, [r3]	@ gActiveUnit.28_92, gActiveUnit
	movs	r3, #17	@ tmp269,
@ FindFreeTile.c:94:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0;
	ldr	r1, .L22+4	@ tmp271,
@ FindFreeTile.c:94:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0;
	ldrsb	r3, [r2, r3]	@ tmp269,
@ FindFreeTile.c:94:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0;
	ldr	r1, [r1]	@ gMapUnit, gMapUnit
	lsls	r3, r3, #2	@ tmp272, tmp269,
@ FindFreeTile.c:94:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0;
	ldr	r3, [r3, r1]	@ *_96, *_96
	movs	r1, #0	@ tmp275,
@ FindFreeTile.c:94:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0;
	ldrb	r2, [r2, #16]	@ tmp273,
	lsls	r2, r2, #24	@ tmp273, tmp273,
	asrs	r2, r2, #24	@ tmp273, tmp273,
@ FindFreeTile.c:94:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0;
	strb	r1, [r3, r2]	@ tmp275, *_100
@ FindFreeTile.c:95: }
	add	sp, sp, #20	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L6:
@ FindFreeTile.c:22:         for (ix = gMapSize.x - 1; ix >= 0; --ix)
	ldr	r3, .L22+12	@ tmp234,
	ldrh	r5, [r3]	@ gMapSize, gMapSize
	lsls	r7, r6, #2	@ _196, iy,
@ FindFreeTile.c:22:         for (ix = gMapSize.x - 1; ix >= 0; --ix)
	subs	r5, r5, #1	@ ix,
.L3:
@ FindFreeTile.c:22:         for (ix = gMapSize.x - 1; ix >= 0; --ix)
	adds	r3, r5, #1	@ tmp327, ix,
	bne	.L5		@,
@ FindFreeTile.c:20:     for (iy = gMapSize.y - 1; iy >= 0; --iy)
	subs	r6, r6, #1	@ iy,
	b	.L2		@
.L5:
@ FindFreeTile.c:26:             if (gMapMovement[iy][ix] > 14) // I think high movement costs might cause an overflow issue here? So I'm using 1, 2, 15, 255 cost. 
	ldr	r3, .L22+20	@ tmp237,
	ldr	r3, [r3]	@ gMapMovement, gMapMovement
@ FindFreeTile.c:26:             if (gMapMovement[iy][ix] > 14) // I think high movement costs might cause an overflow issue here? So I'm using 1, 2, 15, 255 cost. 
	ldr	r3, [r3, r7]	@ *_19, *_19
@ FindFreeTile.c:26:             if (gMapMovement[iy][ix] > 14) // I think high movement costs might cause an overflow issue here? So I'm using 1, 2, 15, 255 cost. 
	ldrb	r3, [r3, r5]	@ *_22, *_22
	cmp	r3, #14	@ *_22,
	bhi	.L4		@,
@ FindFreeTile.c:29:             if (gMapUnit[iy][ix] != 0)
	ldr	r3, .L22+4	@ tmp243,
	ldr	r3, [r3]	@ gMapUnit, gMapUnit
@ FindFreeTile.c:29:             if (gMapUnit[iy][ix] != 0)
	ldr	r3, [r3, r7]	@ *_25, *_25
@ FindFreeTile.c:29:             if (gMapUnit[iy][ix] != 0)
	ldrb	r3, [r3, r5]	@ *_27, *_27
	cmp	r3, #0	@ *_27,
	bne	.L4		@,
@ FindFreeTile.c:32:             if (gMapHidden[iy][ix] & HIDDEN_BIT_UNIT)
	movs	r2, #1	@ tmp339,
@ FindFreeTile.c:32:             if (gMapHidden[iy][ix] & HIDDEN_BIT_UNIT)
	ldr	r3, .L22+24	@ tmp247,
	ldr	r3, [r3]	@ gMapHidden, gMapHidden
@ FindFreeTile.c:32:             if (gMapHidden[iy][ix] & HIDDEN_BIT_UNIT)
	ldr	r3, [r3, r7]	@ *_30, *_30
@ FindFreeTile.c:32:             if (gMapHidden[iy][ix] & HIDDEN_BIT_UNIT)
	ldrb	r3, [r3, r5]	@ *_32, *_32
	tst	r3, r2	@ *_32, tmp339
	bne	.L4		@,
@ FindFreeTile.c:35:             if (!CanUnitCrossTerrain(unit, gMapTerrain[iy][ix])) // movement costs that are 0x80 or higher won't be accepted 
	ldr	r3, .L22+28	@ tmp257,
	ldr	r3, [r3]	@ gMapTerrain, gMapTerrain
@ FindFreeTile.c:35:             if (!CanUnitCrossTerrain(unit, gMapTerrain[iy][ix])) // movement costs that are 0x80 or higher won't be accepted 
	ldr	r3, [r3, r7]	@ *_35, *_35
	movs	r0, r4	@, unit
	ldrb	r1, [r3, r5]	@ *_37, *_37
	ldr	r3, .L22+32	@ tmp260,
	bl	.L24		@
@ FindFreeTile.c:35:             if (!CanUnitCrossTerrain(unit, gMapTerrain[iy][ix])) // movement costs that are 0x80 or higher won't be accepted 
	cmp	r0, #0	@ tmp323,
	beq	.L4		@,
@ FindFreeTile.c:38:             distance = RECT_DISTANCE(ix, iy, unit->xPos, unit->yPos);
	movs	r3, #16	@ tmp261,
	ldrsb	r3, [r4, r3]	@ tmp261,
	subs	r3, r5, r3	@ tmp262, ix, tmp261
	asrs	r1, r3, #31	@ tmp325, tmp262,
	adds	r2, r3, r1	@ tmp263, tmp262, tmp325
	movs	r3, #17	@ tmp264,
	ldrsb	r3, [r4, r3]	@ tmp264,
	subs	r3, r6, r3	@ tmp265, iy, tmp264
	eors	r2, r1	@ tmp263, tmp325
	asrs	r1, r3, #31	@ tmp326, tmp265,
	adds	r3, r3, r1	@ tmp266, tmp265, tmp326
	eors	r3, r1	@ tmp266, tmp326
@ FindFreeTile.c:38:             distance = RECT_DISTANCE(ix, iy, unit->xPos, unit->yPos);
	adds	r3, r2, r3	@ distance, tmp263, tmp266
@ FindFreeTile.c:40:             if (minDistance >= distance)
	ldr	r2, [sp]	@ minDistance, %sfp
	cmp	r2, r3	@ minDistance, distance
	blt	.L4		@,
@ FindFreeTile.c:44:                 *xOut = ix;
	ldr	r2, [sp, #4]	@ xOut, %sfp
	str	r5, [r2]	@ ix, *xOut_124(D)
@ FindFreeTile.c:45:                 *yOut = iy;
	ldr	r2, [sp, #8]	@ yOut, %sfp
	str	r3, [sp]	@ distance, %sfp
	str	r6, [r2]	@ iy, *yOut_133(D)
.L4:
@ FindFreeTile.c:22:         for (ix = gMapSize.x - 1; ix >= 0; --ix)
	subs	r5, r5, #1	@ ix,
	b	.L3		@
.L7:
@ FindFreeTile.c:55: 		MapMovementFillMovementFromPosition(unit->xPos, unit->yPos, GenericMovCost); // void MapFloodExtended(int x, int y, i8 const move_table[]);
	movs	r1, #17	@ tmp278,
	movs	r0, #16	@ tmp279,
	ldr	r3, .L22+36	@ tmp280,
	ldr	r2, .L22+40	@ tmp277,
	ldrsb	r1, [r4, r1]	@ tmp278,
	ldrsb	r0, [r4, r0]	@ tmp279,
	bl	.L24		@
@ FindFreeTile.c:59: 		for (iy = gMapSize.y - 1; iy >= 0; --iy)
	ldr	r3, .L22+12	@ tmp281,
	ldrh	r6, [r3, #2]	@ tmp282,
.L21:
@ FindFreeTile.c:59: 		for (iy = gMapSize.y - 1; iy >= 0; --iy)
	subs	r6, r6, #1	@ iy,
@ FindFreeTile.c:59: 		for (iy = gMapSize.y - 1; iy >= 0; --iy)
	adds	r3, r6, #1	@ tmp333, iy,
	beq	.L13		@,
@ FindFreeTile.c:61: 			for (ix = gMapSize.x - 1; ix >= 0; --ix)
	ldr	r3, .L22+12	@ tmp283,
	ldrh	r5, [r3]	@ gMapSize, gMapSize
	lsls	r7, r6, #2	@ _199, iy,
@ FindFreeTile.c:61: 			for (ix = gMapSize.x - 1; ix >= 0; --ix)
	subs	r5, r5, #1	@ ix,
.L9:
@ FindFreeTile.c:68: 				if (gMapUnit[iy][ix] != 0)
	ldr	r3, .L22+4	@ tmp314,
	ldr	r3, [r3]	@ pretmp_205, gMapUnit
@ FindFreeTile.c:61: 			for (ix = gMapSize.x - 1; ix >= 0; --ix)
	adds	r2, r5, #1	@ tmp332, ix,
	beq	.L21		@,
@ FindFreeTile.c:65: 				if (gMapMovement[iy][ix] > 14) // I think high movement costs might cause an overflow issue here? So I'm using 1, 2, 15, 255 cost. 
	ldr	r2, .L22+20	@ tmp286,
	ldr	r2, [r2]	@ gMapMovement, gMapMovement
@ FindFreeTile.c:65: 				if (gMapMovement[iy][ix] > 14) // I think high movement costs might cause an overflow issue here? So I'm using 1, 2, 15, 255 cost. 
	ldr	r2, [r2, r7]	@ *_60, *_60
@ FindFreeTile.c:65: 				if (gMapMovement[iy][ix] > 14) // I think high movement costs might cause an overflow issue here? So I'm using 1, 2, 15, 255 cost. 
	ldrb	r2, [r2, r5]	@ *_63, *_63
	cmp	r2, #14	@ *_63,
	bhi	.L10		@,
@ FindFreeTile.c:68: 				if (gMapUnit[iy][ix] != 0)
	ldr	r3, [r3, r7]	@ *_68, *_68
@ FindFreeTile.c:68: 				if (gMapUnit[iy][ix] != 0)
	ldrb	r3, [r3, r5]	@ *_70, *_70
	cmp	r3, #0	@ *_70,
	bne	.L10		@,
@ FindFreeTile.c:71: 				if (gMapHidden[iy][ix] & HIDDEN_BIT_UNIT)
	movs	r2, #1	@ tmp345,
@ FindFreeTile.c:71: 				if (gMapHidden[iy][ix] & HIDDEN_BIT_UNIT)
	ldr	r3, .L22+24	@ tmp294,
	ldr	r3, [r3]	@ gMapHidden, gMapHidden
@ FindFreeTile.c:71: 				if (gMapHidden[iy][ix] & HIDDEN_BIT_UNIT)
	ldr	r3, [r3, r7]	@ *_73, *_73
@ FindFreeTile.c:71: 				if (gMapHidden[iy][ix] & HIDDEN_BIT_UNIT)
	ldrb	r3, [r3, r5]	@ *_75, *_75
	tst	r3, r2	@ *_75, tmp345
	bne	.L10		@,
@ FindFreeTile.c:74: 				if (!CanUnitCrossTerrain(unit, gMapTerrain[iy][ix]))
	ldr	r3, .L22+28	@ tmp304,
	ldr	r3, [r3]	@ gMapTerrain, gMapTerrain
@ FindFreeTile.c:74: 				if (!CanUnitCrossTerrain(unit, gMapTerrain[iy][ix]))
	ldr	r3, [r3, r7]	@ *_78, *_78
	movs	r0, r4	@, unit
	ldrb	r1, [r3, r5]	@ *_80, *_80
	ldr	r3, .L22+32	@ tmp307,
	bl	.L24		@
@ FindFreeTile.c:74: 				if (!CanUnitCrossTerrain(unit, gMapTerrain[iy][ix]))
	cmp	r0, #0	@ tmp324,
	beq	.L10		@,
@ FindFreeTile.c:77: 				distance = RECT_DISTANCE(ix, iy, unit->xPos, unit->yPos);
	movs	r3, #16	@ tmp308,
	ldrsb	r3, [r4, r3]	@ tmp308,
	subs	r3, r5, r3	@ tmp309, ix, tmp308
	asrs	r1, r3, #31	@ tmp330, tmp309,
	adds	r2, r3, r1	@ tmp310, tmp309, tmp330
	movs	r3, #17	@ tmp311,
	ldrsb	r3, [r4, r3]	@ tmp311,
	subs	r3, r6, r3	@ tmp312, iy, tmp311
	eors	r2, r1	@ tmp310, tmp330
	asrs	r1, r3, #31	@ tmp331, tmp312,
	adds	r3, r3, r1	@ tmp313, tmp312, tmp331
	eors	r3, r1	@ tmp313, tmp331
@ FindFreeTile.c:77: 				distance = RECT_DISTANCE(ix, iy, unit->xPos, unit->yPos);
	adds	r3, r2, r3	@ distance, tmp310, tmp313
@ FindFreeTile.c:79: 				if (minDistance >= distance)
	ldr	r2, [sp]	@ minDistance, %sfp
	cmp	r2, r3	@ minDistance, distance
	blt	.L10		@,
@ FindFreeTile.c:83: 					*xOut = ix;
	ldr	r2, [sp, #4]	@ xOut, %sfp
	str	r5, [r2]	@ ix, *xOut_124(D)
@ FindFreeTile.c:84: 					*yOut = iy;
	ldr	r2, [sp, #8]	@ yOut, %sfp
	str	r3, [sp]	@ distance, %sfp
	str	r6, [r2]	@ iy, *yOut_133(D)
.L10:
@ FindFreeTile.c:61: 			for (ix = gMapSize.x - 1; ix >= 0; --ix)
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
	.ident	"GCC: (devkitARM release 56) 11.1.0"
	.code 16
	.align	1
.L24:
	bx	r3
