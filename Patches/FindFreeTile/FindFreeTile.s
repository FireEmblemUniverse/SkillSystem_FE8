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
@ FindFreeTile.c:45:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0xFF;
	ldr	r3, .L22	@ tmp222,
@ FindFreeTile.c:38: {
	sub	sp, sp, #20	@,,
@ FindFreeTile.c:38: {
	str	r2, [sp, #8]	@ tmp322, %sfp
@ FindFreeTile.c:45:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0xFF;
	str	r3, [sp, #12]	@ tmp222, %sfp
	ldr	r2, [r3]	@ gActiveUnit.9_2, gActiveUnit
	movs	r3, #17	@ tmp223,
@ FindFreeTile.c:38: {
	str	r1, [sp, #4]	@ tmp321, %sfp
@ FindFreeTile.c:45:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0xFF;
	ldr	r1, .L22+4	@ tmp225,
@ FindFreeTile.c:45:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0xFF;
	ldrsb	r3, [r2, r3]	@ tmp223,
@ FindFreeTile.c:45:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0xFF;
	ldr	r1, [r1]	@ gMapUnit, gMapUnit
	lsls	r3, r3, #2	@ tmp226, tmp223,
@ FindFreeTile.c:45:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0xFF;
	ldr	r3, [r3, r1]	@ *_6, *_6
	movs	r1, #255	@ tmp229,
@ FindFreeTile.c:45:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0xFF;
	ldrb	r2, [r2, #16]	@ tmp227,
	lsls	r2, r2, #24	@ tmp227, tmp227,
	asrs	r2, r2, #24	@ tmp227, tmp227,
@ FindFreeTile.c:45:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0xFF;
	strb	r1, [r3, r2]	@ tmp229, *_11
@ FindFreeTile.c:49: 	FillMovementMapForUnitAndMovement(unit, 15); // fill with flier movement & own movement 
	ldr	r3, .L22+8	@ tmp231,
	subs	r1, r1, #240	@,
@ FindFreeTile.c:38: {
	movs	r4, r0	@ unit, tmp320
@ FindFreeTile.c:49: 	FillMovementMapForUnitAndMovement(unit, 15); // fill with flier movement & own movement 
	bl	.L24		@
@ FindFreeTile.c:51:     for (iy = gMapSize.y - 1; iy >= 0; --iy)
	ldr	r3, .L22+12	@ tmp232,
	ldrh	r6, [r3, #2]	@ tmp233,
@ FindFreeTile.c:39:     int iy, ix, minDistance = 9999;
	ldr	r3, .L22+16	@ minDistance,
	str	r3, [sp]	@ minDistance, %sfp
@ FindFreeTile.c:51:     for (iy = gMapSize.y - 1; iy >= 0; --iy)
	subs	r6, r6, #1	@ iy,
.L2:
@ FindFreeTile.c:51:     for (iy = gMapSize.y - 1; iy >= 0; --iy)
	adds	r3, r6, #1	@ tmp328, iy,
	bne	.L6		@,
@ FindFreeTile.c:81: 	if (*xOut == (-1)) { 
	ldr	r3, [sp, #4]	@ xOut, %sfp
	ldr	r3, [r3]	@ *xOut_124(D), *xOut_124(D)
	adds	r3, r3, #1	@ tmp329, *xOut_124(D),
	beq	.L7		@,
.L13:
@ FindFreeTile.c:124:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0;
	ldr	r3, [sp, #12]	@ tmp222, %sfp
	ldr	r2, [r3]	@ gActiveUnit.36_92, gActiveUnit
	movs	r3, #17	@ tmp269,
@ FindFreeTile.c:124:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0;
	ldr	r1, .L22+4	@ tmp271,
@ FindFreeTile.c:124:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0;
	ldrsb	r3, [r2, r3]	@ tmp269,
@ FindFreeTile.c:124:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0;
	ldr	r1, [r1]	@ gMapUnit, gMapUnit
	lsls	r3, r3, #2	@ tmp272, tmp269,
@ FindFreeTile.c:124:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0;
	ldr	r3, [r3, r1]	@ *_96, *_96
	movs	r1, #0	@ tmp275,
@ FindFreeTile.c:124:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0;
	ldrb	r2, [r2, #16]	@ tmp273,
	lsls	r2, r2, #24	@ tmp273, tmp273,
	asrs	r2, r2, #24	@ tmp273, tmp273,
@ FindFreeTile.c:124:     gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0;
	strb	r1, [r3, r2]	@ tmp275, *_100
@ FindFreeTile.c:125: }
	add	sp, sp, #20	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L6:
@ FindFreeTile.c:53:         for (ix = gMapSize.x - 1; ix >= 0; --ix)
	ldr	r3, .L22+12	@ tmp234,
	ldrh	r5, [r3]	@ gMapSize, gMapSize
	lsls	r7, r6, #2	@ _196, iy,
@ FindFreeTile.c:53:         for (ix = gMapSize.x - 1; ix >= 0; --ix)
	subs	r5, r5, #1	@ ix,
.L3:
@ FindFreeTile.c:53:         for (ix = gMapSize.x - 1; ix >= 0; --ix)
	adds	r3, r5, #1	@ tmp327, ix,
	bne	.L5		@,
@ FindFreeTile.c:51:     for (iy = gMapSize.y - 1; iy >= 0; --iy)
	subs	r6, r6, #1	@ iy,
	b	.L2		@
.L5:
@ FindFreeTile.c:57:             if (gMapMovement[iy][ix] > 14) // I think high movement costs might cause an overflow issue here? So I'm using 1, 2, 15, 255 cost. 
	ldr	r3, .L22+20	@ tmp237,
	ldr	r3, [r3]	@ gMapMovement, gMapMovement
@ FindFreeTile.c:57:             if (gMapMovement[iy][ix] > 14) // I think high movement costs might cause an overflow issue here? So I'm using 1, 2, 15, 255 cost. 
	ldr	r3, [r3, r7]	@ *_19, *_19
@ FindFreeTile.c:57:             if (gMapMovement[iy][ix] > 14) // I think high movement costs might cause an overflow issue here? So I'm using 1, 2, 15, 255 cost. 
	ldrb	r3, [r3, r5]	@ *_22, *_22
	cmp	r3, #14	@ *_22,
	bhi	.L4		@,
@ FindFreeTile.c:60:             if (gMapUnit[iy][ix] != 0)
	ldr	r3, .L22+4	@ tmp243,
	ldr	r3, [r3]	@ gMapUnit, gMapUnit
@ FindFreeTile.c:60:             if (gMapUnit[iy][ix] != 0)
	ldr	r3, [r3, r7]	@ *_25, *_25
@ FindFreeTile.c:60:             if (gMapUnit[iy][ix] != 0)
	ldrb	r3, [r3, r5]	@ *_27, *_27
	cmp	r3, #0	@ *_27,
	bne	.L4		@,
@ FindFreeTile.c:63:             if (gMapHidden[iy][ix] & HIDDEN_BIT_UNIT)
	movs	r2, #1	@ tmp339,
@ FindFreeTile.c:63:             if (gMapHidden[iy][ix] & HIDDEN_BIT_UNIT)
	ldr	r3, .L22+24	@ tmp247,
	ldr	r3, [r3]	@ gMapHidden, gMapHidden
@ FindFreeTile.c:63:             if (gMapHidden[iy][ix] & HIDDEN_BIT_UNIT)
	ldr	r3, [r3, r7]	@ *_30, *_30
@ FindFreeTile.c:63:             if (gMapHidden[iy][ix] & HIDDEN_BIT_UNIT)
	ldrb	r3, [r3, r5]	@ *_32, *_32
	tst	r3, r2	@ *_32, tmp339
	bne	.L4		@,
@ FindFreeTile.c:66:             if (!CanUnitCrossTerrain(unit, gMapTerrain[iy][ix])) // movement costs that are 0x80 or higher won't be accepted 
	ldr	r3, .L22+28	@ tmp257,
	ldr	r3, [r3]	@ gMapTerrain, gMapTerrain
@ FindFreeTile.c:66:             if (!CanUnitCrossTerrain(unit, gMapTerrain[iy][ix])) // movement costs that are 0x80 or higher won't be accepted 
	ldr	r3, [r3, r7]	@ *_35, *_35
	movs	r0, r4	@, unit
	ldrb	r1, [r3, r5]	@ *_37, *_37
	ldr	r3, .L22+32	@ tmp260,
	bl	.L24		@
@ FindFreeTile.c:66:             if (!CanUnitCrossTerrain(unit, gMapTerrain[iy][ix])) // movement costs that are 0x80 or higher won't be accepted 
	cmp	r0, #0	@ tmp323,
	beq	.L4		@,
@ FindFreeTile.c:69:             distance = RECT_DISTANCE(ix, iy, unit->xPos, unit->yPos);
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
@ FindFreeTile.c:69:             distance = RECT_DISTANCE(ix, iy, unit->xPos, unit->yPos);
	adds	r3, r2, r3	@ distance, tmp263, tmp266
@ FindFreeTile.c:71:             if (minDistance >= distance)
	ldr	r2, [sp]	@ minDistance, %sfp
	cmp	r2, r3	@ minDistance, distance
	blt	.L4		@,
@ FindFreeTile.c:75:                 *xOut = ix;
	ldr	r2, [sp, #4]	@ xOut, %sfp
	str	r5, [r2]	@ ix, *xOut_124(D)
@ FindFreeTile.c:76:                 *yOut = iy;
	ldr	r2, [sp, #8]	@ yOut, %sfp
	str	r3, [sp]	@ distance, %sfp
	str	r6, [r2]	@ iy, *yOut_133(D)
.L4:
@ FindFreeTile.c:53:         for (ix = gMapSize.x - 1; ix >= 0; --ix)
	subs	r5, r5, #1	@ ix,
	b	.L3		@
.L7:
@ FindFreeTile.c:85: 		MapMovementFillMovementFromPosition(unit->xPos, unit->yPos, GenericMovCost); // void MapFloodExtended(int x, int y, i8 const move_table[]);
	movs	r1, #17	@ tmp278,
	movs	r0, #16	@ tmp279,
	ldr	r3, .L22+36	@ tmp280,
	ldr	r2, .L22+40	@ tmp277,
	ldrsb	r1, [r4, r1]	@ tmp278,
	ldrsb	r0, [r4, r0]	@ tmp279,
	bl	.L24		@
@ FindFreeTile.c:89: 		for (iy = gMapSize.y - 1; iy >= 0; --iy)
	ldr	r3, .L22+12	@ tmp281,
	ldrh	r6, [r3, #2]	@ tmp282,
.L21:
@ FindFreeTile.c:89: 		for (iy = gMapSize.y - 1; iy >= 0; --iy)
	subs	r6, r6, #1	@ iy,
@ FindFreeTile.c:89: 		for (iy = gMapSize.y - 1; iy >= 0; --iy)
	adds	r3, r6, #1	@ tmp333, iy,
	beq	.L13		@,
@ FindFreeTile.c:91: 			for (ix = gMapSize.x - 1; ix >= 0; --ix)
	ldr	r3, .L22+12	@ tmp283,
	ldrh	r5, [r3]	@ gMapSize, gMapSize
	lsls	r7, r6, #2	@ _199, iy,
@ FindFreeTile.c:91: 			for (ix = gMapSize.x - 1; ix >= 0; --ix)
	subs	r5, r5, #1	@ ix,
.L9:
@ FindFreeTile.c:98: 				if (gMapUnit[iy][ix] != 0)
	ldr	r3, .L22+4	@ tmp314,
	ldr	r3, [r3]	@ pretmp_205, gMapUnit
@ FindFreeTile.c:91: 			for (ix = gMapSize.x - 1; ix >= 0; --ix)
	adds	r2, r5, #1	@ tmp332, ix,
	beq	.L21		@,
@ FindFreeTile.c:95: 				if (gMapMovement[iy][ix] > 14) // I think high movement costs might cause an overflow issue here? So I'm using 1, 2, 15, 255 cost. 
	ldr	r2, .L22+20	@ tmp286,
	ldr	r2, [r2]	@ gMapMovement, gMapMovement
@ FindFreeTile.c:95: 				if (gMapMovement[iy][ix] > 14) // I think high movement costs might cause an overflow issue here? So I'm using 1, 2, 15, 255 cost. 
	ldr	r2, [r2, r7]	@ *_60, *_60
@ FindFreeTile.c:95: 				if (gMapMovement[iy][ix] > 14) // I think high movement costs might cause an overflow issue here? So I'm using 1, 2, 15, 255 cost. 
	ldrb	r2, [r2, r5]	@ *_63, *_63
	cmp	r2, #14	@ *_63,
	bhi	.L10		@,
@ FindFreeTile.c:98: 				if (gMapUnit[iy][ix] != 0)
	ldr	r3, [r3, r7]	@ *_68, *_68
@ FindFreeTile.c:98: 				if (gMapUnit[iy][ix] != 0)
	ldrb	r3, [r3, r5]	@ *_70, *_70
	cmp	r3, #0	@ *_70,
	bne	.L10		@,
@ FindFreeTile.c:101: 				if (gMapHidden[iy][ix] & HIDDEN_BIT_UNIT)
	movs	r2, #1	@ tmp345,
@ FindFreeTile.c:101: 				if (gMapHidden[iy][ix] & HIDDEN_BIT_UNIT)
	ldr	r3, .L22+24	@ tmp294,
	ldr	r3, [r3]	@ gMapHidden, gMapHidden
@ FindFreeTile.c:101: 				if (gMapHidden[iy][ix] & HIDDEN_BIT_UNIT)
	ldr	r3, [r3, r7]	@ *_73, *_73
@ FindFreeTile.c:101: 				if (gMapHidden[iy][ix] & HIDDEN_BIT_UNIT)
	ldrb	r3, [r3, r5]	@ *_75, *_75
	tst	r3, r2	@ *_75, tmp345
	bne	.L10		@,
@ FindFreeTile.c:104: 				if (!CanUnitCrossTerrain(unit, gMapTerrain[iy][ix]))
	ldr	r3, .L22+28	@ tmp304,
	ldr	r3, [r3]	@ gMapTerrain, gMapTerrain
@ FindFreeTile.c:104: 				if (!CanUnitCrossTerrain(unit, gMapTerrain[iy][ix]))
	ldr	r3, [r3, r7]	@ *_78, *_78
	movs	r0, r4	@, unit
	ldrb	r1, [r3, r5]	@ *_80, *_80
	ldr	r3, .L22+32	@ tmp307,
	bl	.L24		@
@ FindFreeTile.c:104: 				if (!CanUnitCrossTerrain(unit, gMapTerrain[iy][ix]))
	cmp	r0, #0	@ tmp324,
	beq	.L10		@,
@ FindFreeTile.c:107: 				distance = RECT_DISTANCE(ix, iy, unit->xPos, unit->yPos);
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
@ FindFreeTile.c:107: 				distance = RECT_DISTANCE(ix, iy, unit->xPos, unit->yPos);
	adds	r3, r2, r3	@ distance, tmp310, tmp313
@ FindFreeTile.c:109: 				if (minDistance >= distance)
	ldr	r2, [sp]	@ minDistance, %sfp
	cmp	r2, r3	@ minDistance, distance
	blt	.L10		@,
@ FindFreeTile.c:113: 					*xOut = ix;
	ldr	r2, [sp, #4]	@ xOut, %sfp
	str	r5, [r2]	@ ix, *xOut_124(D)
@ FindFreeTile.c:114: 					*yOut = iy;
	ldr	r2, [sp, #8]	@ yOut, %sfp
	str	r3, [sp]	@ distance, %sfp
	str	r6, [r2]	@ iy, *yOut_133(D)
.L10:
@ FindFreeTile.c:91: 			for (ix = gMapSize.x - 1; ix >= 0; --ix)
	subs	r5, r5, #1	@ ix,
	b	.L9		@
.L23:
	.align	2
.L22:
	.word	gActiveUnit
	.word	gMapUnit
	.word	FillMovementMapForUnitAndMovement
	.word	gMapSize
	.word	9999
	.word	gMapMovement
	.word	gMapHidden
	.word	gMapTerrain
	.word	CanUnitCrossTerrain
	.word	MapMovementFillMovementFromPosition
	.word	GenericMovCost
	.size	FindFreeTile, .-FindFreeTile
	.align	1
	.global	ASMC_FindFreeTile
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	ASMC_FindFreeTile, %function
ASMC_FindFreeTile:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r0, r1, r4, r5, r6, lr}	@
@ FindFreeTile.c:15: 	int unitID = gEventSlot[1]; 
	ldr	r6, .L36	@ tmp141,
@ FindFreeTile.c:16: 	struct Unit* unit = GetUnitStructFromEventParameter(unitID); 
	ldr	r3, .L36+4	@ tmp142,
	ldr	r0, [r6, #4]	@, gEventSlot[1]
	bl	.L24		@
@ FindFreeTile.c:14: 	int result = false; // default 
	movs	r5, #0	@ result,
@ FindFreeTile.c:17: 	if ((unit != 0) & (unit->pCharacterData != 0)) { 
	ldr	r3, [r0]	@ unit_34->pCharacterData, unit_34->pCharacterData
@ FindFreeTile.c:16: 	struct Unit* unit = GetUnitStructFromEventParameter(unitID); 
	movs	r4, r0	@ unit, tmp172
@ FindFreeTile.c:17: 	if ((unit != 0) & (unit->pCharacterData != 0)) { 
	cmp	r3, r5	@ unit_34->pCharacterData,
	beq	.L26		@,
@ FindFreeTile.c:18: 		result = unit->yPos << 16 | unit->xPos; 
	movs	r5, #17	@ tmp144,
@ FindFreeTile.c:18: 		result = unit->yPos << 16 | unit->xPos; 
	movs	r3, #16	@ tmp146,
@ FindFreeTile.c:18: 		result = unit->yPos << 16 | unit->xPos; 
	ldrsb	r5, [r0, r5]	@ tmp144,
@ FindFreeTile.c:18: 		result = unit->yPos << 16 | unit->xPos; 
	ldrsb	r3, [r0, r3]	@ tmp146,
@ FindFreeTile.c:18: 		result = unit->yPos << 16 | unit->xPos; 
	lsls	r5, r5, #16	@ tmp145, tmp144,
@ FindFreeTile.c:18: 		result = unit->yPos << 16 | unit->xPos; 
	orrs	r5, r3	@ result, tmp146
@ FindFreeTile.c:20: 		xOut = gEventSlot[0xB] & 0xFFFF; 
	ldr	r3, [r6, #44]	@ _10, gEventSlot[11]
@ FindFreeTile.c:20: 		xOut = gEventSlot[0xB] & 0xFFFF; 
	lsls	r2, r3, #16	@ _12, _10,
	lsrs	r2, r2, #16	@ _12, _12,
@ FindFreeTile.c:22: 		yOut = (gEventSlot[0xB] & 0xFFFF0000) >> 16;
	lsrs	r3, r3, #16	@ _13, _10,
@ FindFreeTile.c:23: 		unit->xPos = xOut; 
	strb	r2, [r0, #16]	@ _12, unit_34->xPos
@ FindFreeTile.c:24: 		unit->yPos = yOut; 
	strb	r3, [r0, #17]	@ _13, unit_34->yPos
@ FindFreeTile.c:25: 		FindFreeTile(unit, &xOut, &yOut); 
	mov	r1, sp	@,
@ FindFreeTile.c:20: 		xOut = gEventSlot[0xB] & 0xFFFF; 
	str	r2, [sp]	@ _12, xOut
@ FindFreeTile.c:25: 		FindFreeTile(unit, &xOut, &yOut); 
	add	r2, sp, #4	@,,
@ FindFreeTile.c:22: 		yOut = (gEventSlot[0xB] & 0xFFFF0000) >> 16;
	str	r3, [sp, #4]	@ _13, yOut
@ FindFreeTile.c:25: 		FindFreeTile(unit, &xOut, &yOut); 
	bl	FindFreeTile		@
@ FindFreeTile.c:29: 		if ((xOut != 9999) & (yOut != 9999)) {
	ldr	r2, [sp]	@ xOut.3_21, xOut
	ldr	r0, .L36+8	@ tmp174,
@ FindFreeTile.c:27: 		unit->yPos = (result & 0xFFFF0000) >> 16; 
	lsrs	r3, r5, #16	@ tmp154, result,
@ FindFreeTile.c:29: 		if ((xOut != 9999) & (yOut != 9999)) {
	adds	r1, r2, r0	@ tmp158, xOut.3_21, tmp174
@ FindFreeTile.c:27: 		unit->yPos = (result & 0xFFFF0000) >> 16; 
	strb	r3, [r4, #17]	@ tmp154, unit_34->yPos
@ FindFreeTile.c:26: 		unit->xPos = result & 0xFFFF; 
	strb	r5, [r4, #16]	@ result, unit_34->xPos
@ FindFreeTile.c:29: 		if ((xOut != 9999) & (yOut != 9999)) {
	ldr	r3, [sp, #4]	@ yOut.4_23, yOut
@ FindFreeTile.c:29: 		if ((xOut != 9999) & (yOut != 9999)) {
	cmp	r1, #0	@ tmp158,
	beq	.L26		@,
@ FindFreeTile.c:29: 		if ((xOut != 9999) & (yOut != 9999)) {
	adds	r1, r3, r0	@ tmp164, yOut.4_23, tmp175
@ FindFreeTile.c:29: 		if ((xOut != 9999) & (yOut != 9999)) {
	cmp	r1, #0	@ tmp164,
	beq	.L26		@,
@ FindFreeTile.c:30: 			result = (yOut << 16) | xOut; 
	lsls	r5, r3, #16	@ tmp168, yOut.4_23,
@ FindFreeTile.c:30: 			result = (yOut << 16) | xOut; 
	orrs	r5, r2	@ result, xOut.3_21
.L26:
@ FindFreeTile.c:33: 	gEventSlot[0xC] = result; // if no unit, return 0 as coord 
	str	r5, [r6, #48]	@ result, gEventSlot[12]
@ FindFreeTile.c:35: } 
	@ sp needed	@
@ FindFreeTile.c:34: 	ClearMenuCommandOverride();
	ldr	r3, .L36+12	@ tmp170,
	bl	.L24		@
@ FindFreeTile.c:35: } 
	pop	{r0, r1, r4, r5, r6}
	pop	{r0}
	bx	r0
.L37:
	.align	2
.L36:
	.word	gEventSlot
	.word	GetUnitStructFromEventParameter
	.word	-9999
	.word	ClearMenuCommandOverride
	.size	ASMC_FindFreeTile, .-ASMC_FindFreeTile
	.ident	"GCC: (devkitARM release 56) 11.1.0"
	.code 16
	.align	1
.L24:
	bx	r3
