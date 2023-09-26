	.cpu arm7tdmi
	.arch armv4t
	.fpu softvfp
	.eabi_attribute 20, 1	@ Tag_ABI_FP_denormal
	.eabi_attribute 21, 1	@ Tag_ABI_FP_exceptions
	.eabi_attribute 23, 3	@ Tag_ABI_FP_number_model
	.eabi_attribute 24, 1	@ Tag_ABI_align8_needed
	.eabi_attribute 25, 1	@ Tag_ABI_align8_preserved
	.eabi_attribute 26, 1	@ Tag_ABI_enum_size
	.eabi_attribute 30, 2	@ Tag_ABI_optimization_goals
	.eabi_attribute 34, 0	@ Tag_CPU_unaligned_access
	.eabi_attribute 18, 4	@ Tag_ABI_PCS_wchar_t
	.file	"NewMapAddInRange.c"
@ GNU C17 (devkitARM release 59) version 12.2.0 (arm-none-eabi)
@	compiled by GNU C version 10.3.0, GMP version 6.2.1, MPFR version 4.1.0, MPC version 1.2.1, isl version isl-0.18-GMP

@ GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
@ options passed: -mcpu=arm7tdmi -mtune=arm7tdmi -mlong-calls -marm -march=armv4t -O2
	.text
	.align	2
	.global	NewForEachInMovementRange
	.syntax unified
	.arm
	.type	NewForEachInMovementRange, %function
NewForEachInMovementRange:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 64
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}	@
@ NewMapAddInRange.c:13: 	for (iy = gBmMapSize.y - 1; iy >= 0; --iy) 
	ldr	ip, .L68	@ tmp399,
	ldrsh	r3, [ip, #2]	@ _1, gBmMapSize.y
@ NewMapAddInRange.c:11: void NewForEachInMovementRange(int minRange, int maxRange) { 
	sub	sp, sp, #68	@,,
@ NewMapAddInRange.c:13: 	for (iy = gBmMapSize.y - 1; iy >= 0; --iy) 
	subs	lr, r3, #1	@ iy, _1,
@ NewMapAddInRange.c:11: void NewForEachInMovementRange(int minRange, int maxRange) { 
	str	r0, [sp, #36]	@ minRange, %sfp
	str	r1, [sp, #28]	@ maxRange, %sfp
@ NewMapAddInRange.c:13: 	for (iy = gBmMapSize.y - 1; iy >= 0; --iy) 
	bmi	.L1		@,
	sub	r3, r3, #2	@ tmp277, _1,
	add	r3, r3, r0	@ ivtmp.124, tmp277, minRange
	str	r3, [sp, #40]	@ ivtmp.124, %sfp
	sub	r3, lr, r1	@ ivtmp.128, iy, maxRange
	str	r3, [sp, #8]	@ ivtmp.128, %sfp
	add	r3, lr, r1	@ ivtmp.130, iy, maxRange
	ldr	fp, .L68+4	@ tmp446,
@ NewMapAddInRange.c:62: 				gBmMapFog[iy][ix] = 1; 
	ldr	r8, .L68+8	@ tmp447,
	str	r3, [sp, #12]	@ ivtmp.130, %sfp
	str	lr, [sp, #16]	@ iy, %sfp
.L4:
	ldr	r1, [sp, #16]	@ iy, %sfp
@ NewMapAddInRange.c:15:             for (ix = gBmMapSize.x - 1; ix >= 0; --ix) 
	ldrsh	r2, [ip]	@ _3, gBmMapSize.x
	str	r1, [sp, #24]	@ iy, %sfp
@ NewMapAddInRange.c:15:             for (ix = gBmMapSize.x - 1; ix >= 0; --ix) 
	subs	r3, r2, #1	@ ix, _3,
@ NewMapAddInRange.c:13: 	for (iy = gBmMapSize.y - 1; iy >= 0; --iy) 
	sub	r1, r1, #1	@ iy, iy,
	str	r1, [sp, #16]	@ iy, %sfp
@ NewMapAddInRange.c:15:             for (ix = gBmMapSize.x - 1; ix >= 0; --ix) 
	bmi	.L8		@,
	ldr	r1, [sp, #28]	@ maxRange, %sfp
	ldr	r0, [sp, #36]	@ minRange, %sfp
	add	r2, r2, #1	@ tmp279, _3,
	sub	lr, r2, r0	@ ivtmp.103, tmp279, minRange
	mvn	r2, r1	@ _199, maxRange
	str	r2, [sp, #32]	@ _199, %sfp
	sub	r2, r1, r0	@ tmp438, maxRange, minRange
	add	r2, r2, #1	@ _32, tmp438,
	str	r2, [sp, #44]	@ _32, %sfp
@ NewMapAddInRange.c:17:                 if (gBmMapMovement[iy][ix] > MAP_MOVEMENT_MAX) 
	ldr	r2, [sp, #24]	@ iy, %sfp
	lsl	r4, r3, #1	@ ivtmp.110, ix,
	lsl	r2, r2, #2	@ _7, iy,
	str	r2, [sp, #20]	@ _7, %sfp
	mov	r2, r4	@ ivtmp.110, ivtmp.110
	sub	r10, r3, r1	@ ivtmp.112, ix, maxRange
.L7:
	ldr	r3, .L68+12	@ tmp554,
@ NewMapAddInRange.c:17:                 if (gBmMapMovement[iy][ix] > MAP_MOVEMENT_MAX) 
	ldr	r1, [sp, #20]	@ _7, %sfp
@ NewMapAddInRange.c:17:                 if (gBmMapMovement[iy][ix] > MAP_MOVEMENT_MAX) 
	ldr	r3, [r3]	@ gBmMapMovement, gBmMapMovement
@ NewMapAddInRange.c:17:                 if (gBmMapMovement[iy][ix] > MAP_MOVEMENT_MAX) 
	ldr	r1, [r3, r1]	@ *_8, *_8
	ldr	r3, [sp, #28]	@ maxRange, %sfp
	add	r3, r3, r10	@ _201, maxRange, ivtmp.112
@ NewMapAddInRange.c:17:                 if (gBmMapMovement[iy][ix] > MAP_MOVEMENT_MAX) 
	ldrb	r1, [r1, r3]	@ zero_extendqisi2	@ *_11, *_11
	cmp	r1, #120	@ *_11,
	bhi	.L64		@,
@ NewMapAddInRange.c:19:                 if (gBmMapUnit[iy][ix]) 
	ldr	r1, .L68+16	@ tmp558,
@ NewMapAddInRange.c:19:                 if (gBmMapUnit[iy][ix]) 
	ldr	r0, [sp, #20]	@ _7, %sfp
@ NewMapAddInRange.c:19:                 if (gBmMapUnit[iy][ix]) 
	ldr	r1, [r1]	@ gBmMapUnit, gBmMapUnit
@ NewMapAddInRange.c:19:                 if (gBmMapUnit[iy][ix]) 
	ldr	r1, [r1, r0]	@ *_14, *_14
@ NewMapAddInRange.c:19:                 if (gBmMapUnit[iy][ix]) 
	ldrb	r3, [r1, r3]	@ zero_extendqisi2	@ *_16, *_16
	cmp	r3, #0	@ *_16,
	bne	.L64		@,
	ldr	r3, .L68+20	@ tmp560,
@ NewMapAddInRange.c:37:     for (iRange = range, iy = y; (iy <= y + range) && (iy < gBmMapSize.y); --iRange, ++iy)
	add	r1, sp, #40	@,,
	ldrb	r0, [r3, #4]	@ zero_extendqisi2	@ gBmSt.gameStateBits, gBmSt.gameStateBits
	ldm	r1, {r1, r3}	@,,
	add	r3, r3, r1	@ tmp296, _32, ivtmp.124
	ldr	r1, [sp, #24]	@ iy, %sfp
	cmp	r1, r3	@ iy, tmp296
	and	r0, r0, #8	@ _102, gBmSt.gameStateBits,
	bgt	.L14		@,
@ NewMapAddInRange.c:62: 				gBmMapFog[iy][ix] = 1; 
	mov	r5, #1	@ tmp433,
@ NewMapAddInRange.c:37:     for (iRange = range, iy = y; (iy <= y + range) && (iy < gBmMapSize.y); --iRange, ++iy)
	mov	r6, r10	@ ivtmp.94, ivtmp.112
@ NewMapAddInRange.c:46:             xRange += xMin;
	str	r10, [sp, #4]	@ ivtmp.112, %sfp
	mov	r10, lr	@ ivtmp.103, ivtmp.103
@ NewMapAddInRange.c:37:     for (iRange = range, iy = y; (iy <= y + range) && (iy < gBmMapSize.y); --iRange, ++iy)
	ldr	r1, [sp, #24]	@ iy, %sfp
@ NewMapAddInRange.c:46:             xRange += xMin;
	str	r2, [sp, #48]	@ ivtmp.110, %sfp
	add	r7, r2, r5	@ tmp430, ivtmp.110,
.L10:
@ NewMapAddInRange.c:37:     for (iRange = range, iy = y; (iy <= y + range) && (iy < gBmMapSize.y); --iRange, ++iy)
	ldrsh	r3, [ip, #2]	@ gBmMapSize.y, gBmMapSize.y
@ NewMapAddInRange.c:37:     for (iRange = range, iy = y; (iy <= y + range) && (iy < gBmMapSize.y); --iRange, ++iy)
	cmp	r3, r1	@ gBmMapSize.y, iy
	ble	.L65		@,
@ NewMapAddInRange.c:52:         if (xMax > gBmMapSize.x)
	ldrsh	r3, [ip]	@ gBmMapSize.x, gBmMapSize.x
@ NewMapAddInRange.c:46:             xRange += xMin;
	sub	r4, r7, r6	@ tmp305, tmp430, ivtmp.94
	cmp	r4, r3	@ tmp305, gBmMapSize.x
	movge	r4, r3	@ _113, gBmMapSize.x
@ NewMapAddInRange.c:44:         if (xMin < 0)
	bic	r3, r6, r6, asr #31	@ ix, ivtmp.94
@ NewMapAddInRange.c:58:         for (ix = xMin; ix < xMax; ++ix)
	cmp	r4, r3	@ _113, ix
	lslgt	r9, r1, #2	@ _263, iy,
	ble	.L17		@,
.L16:
@ NewMapAddInRange.c:60:             gWorkingBmMap[iy][ix] += value;
	ldr	r2, [fp]	@ gWorkingBmMap, gWorkingBmMap
@ NewMapAddInRange.c:60:             gWorkingBmMap[iy][ix] += value;
	ldr	lr, [r2, r9]	@ *_118, *_118
@ NewMapAddInRange.c:60:             gWorkingBmMap[iy][ix] += value;
	ldrb	r2, [lr, r3]	@ zero_extendqisi2	@ *_122, *_122
	add	r2, r2, #1	@ tmp313, *_122,
	strb	r2, [lr, r3]	@ tmp313, *_122
@ NewMapAddInRange.c:61: 			if (setFog) { 
	cmp	r0, #0	@ _102,
@ NewMapAddInRange.c:62: 				gBmMapFog[iy][ix] = 1; 
	ldrne	r2, [r8]	@ gBmMapFog, gBmMapFog
@ NewMapAddInRange.c:62: 				gBmMapFog[iy][ix] = 1; 
	ldrne	r2, [r2, r9]	@ *_127, *_127
	strbne	r5, [r2, r3]	@ tmp433, *_129
@ NewMapAddInRange.c:58:         for (ix = xMin; ix < xMax; ++ix)
	add	r3, r3, #1	@ ix, ix,
@ NewMapAddInRange.c:58:         for (ix = xMin; ix < xMax; ++ix)
	cmp	r4, r3	@ _113, ix
	bne	.L16		@,
.L17:
@ NewMapAddInRange.c:37:     for (iRange = range, iy = y; (iy <= y + range) && (iy < gBmMapSize.y); --iRange, ++iy)
	ldr	r3, [sp, #12]	@ ivtmp.130, %sfp
@ NewMapAddInRange.c:37:     for (iRange = range, iy = y; (iy <= y + range) && (iy < gBmMapSize.y); --iRange, ++iy)
	add	r1, r1, #1	@ iy, iy,
@ NewMapAddInRange.c:37:     for (iRange = range, iy = y; (iy <= y + range) && (iy < gBmMapSize.y); --iRange, ++iy)
	cmp	r1, r3	@ iy, ivtmp.130
	add	r6, r6, #1	@ ivtmp.94, ivtmp.94,
	ble	.L10		@,
.L65:
	mov	lr, r10	@ ivtmp.103, ivtmp.103
	ldr	r2, [sp, #48]	@ ivtmp.110, %sfp
	ldr	r10, [sp, #4]	@ ivtmp.112, %sfp
.L14:
@ NewMapAddInRange.c:69:     for (iRange = (range - 1), iy = (y - 1); (iy >= y - range) && (iy >= 0); --iRange, --iy)
	ldr	r1, [sp, #16]	@ iy, %sfp
	adds	r3, r1, #1	@ _211, iy,
	movne	r3, #1	@ _211,
	ldr	r4, [sp, #8]	@ ivtmp.128, %sfp
	str	r3, [sp, #48]	@ _211, %sfp
	cmp	r4, r1	@ ivtmp.128, iy
	movgt	r3, #0	@, tmp303
	andle	r3, r3, #1	@,, tmp303, tmp303
	cmp	r3, #0	@ tmp303,
	beq	.L12		@,
@ NewMapAddInRange.c:94: 				gBmMapFog[iy][ix] = 1; 
	mov	r5, #1	@ tmp425,
@ NewMapAddInRange.c:69:     for (iRange = (range - 1), iy = (y - 1); (iy >= y - range) && (iy >= 0); --iRange, --iy)
	ldr	r1, [sp, #16]	@ iy, %sfp
	str	r10, [sp, #4]	@ ivtmp.112, %sfp
	str	r2, [sp, #52]	@ ivtmp.110, %sfp
	add	r6, r10, r5	@ ivtmp.78, ivtmp.112,
	add	r7, r2, r5	@ tmp401, ivtmp.110,
.L22:
@ NewMapAddInRange.c:84:         if (xMax > gBmMapSize.x)
	ldrsh	r3, [ip]	@ gBmMapSize.x, gBmMapSize.x
@ NewMapAddInRange.c:78:             xRange += xMin;
	sub	r4, r7, r6	@ tmp328, tmp401, ivtmp.78
	cmp	r4, r3	@ tmp328, gBmMapSize.x
	movge	r4, r3	@ _148, gBmMapSize.x
@ NewMapAddInRange.c:76:         if (xMin < 0)
	bic	r3, r6, r6, asr #31	@ ix, ivtmp.78
@ NewMapAddInRange.c:90:         for (ix = xMin; ix < xMax; ++ix)
	cmp	r3, r4	@ ix, _148
	lsllt	r10, r1, #2	@ _275, iy,
	bge	.L25		@,
.L24:
@ NewMapAddInRange.c:92:             gWorkingBmMap[iy][ix] += value;
	ldr	r2, [fp]	@ gWorkingBmMap, gWorkingBmMap
@ NewMapAddInRange.c:92:             gWorkingBmMap[iy][ix] += value;
	ldr	r9, [r2, r10]	@ *_153, *_153
@ NewMapAddInRange.c:92:             gWorkingBmMap[iy][ix] += value;
	ldrb	r2, [r9, r3]	@ zero_extendqisi2	@ *_157, *_157
	add	r2, r2, #1	@ tmp343, *_157,
	strb	r2, [r9, r3]	@ tmp343, *_157
@ NewMapAddInRange.c:93: 			if (setFog) { 
	cmp	r0, #0	@ _102,
@ NewMapAddInRange.c:94: 				gBmMapFog[iy][ix] = 1; 
	ldrne	r2, [r8]	@ gBmMapFog, gBmMapFog
@ NewMapAddInRange.c:94: 				gBmMapFog[iy][ix] = 1; 
	ldrne	r2, [r2, r10]	@ *_162, *_162
	strbne	r5, [r2, r3]	@ tmp425, *_164
@ NewMapAddInRange.c:90:         for (ix = xMin; ix < xMax; ++ix)
	add	r3, r3, #1	@ ix, ix,
@ NewMapAddInRange.c:90:         for (ix = xMin; ix < xMax; ++ix)
	cmp	r4, r3	@ _148, ix
	bne	.L24		@,
.L25:
@ NewMapAddInRange.c:69:     for (iRange = (range - 1), iy = (y - 1); (iy >= y - range) && (iy >= 0); --iRange, --iy)
	ldr	r3, [sp, #8]	@ tmp337, %sfp
@ NewMapAddInRange.c:69:     for (iRange = (range - 1), iy = (y - 1); (iy >= y - range) && (iy >= 0); --iRange, --iy)
	sub	r1, r1, #1	@ iy, iy,
@ NewMapAddInRange.c:69:     for (iRange = (range - 1), iy = (y - 1); (iy >= y - range) && (iy >= 0); --iRange, --iy)
	cmp	r1, r3	@ iy, tmp337
	movlt	r3, #0	@ tmp337,
	movge	r3, #1	@ tmp337,
	cmn	r1, #1	@ iy,
	moveq	r3, #0	@ tmp337,
	cmp	r3, #0	@ tmp337,
	add	r6, r6, #1	@ ivtmp.78, ivtmp.78,
	bne	.L22		@,
	ldr	r10, [sp, #4]	@ ivtmp.112, %sfp
	ldr	r2, [sp, #52]	@ ivtmp.110, %sfp
.L12:
	ldr	r3, .L68+20	@ tmp570,
@ NewMapAddInRange.c:37:     for (iRange = range, iy = y; (iy <= y + range) && (iy < gBmMapSize.y); --iRange, ++iy)
	ldr	r1, [sp, #36]	@ minRange, %sfp
	ldrb	r0, [r3, #4]	@ zero_extendqisi2	@ gBmSt.gameStateBits, gBmSt.gameStateBits
	ldr	r3, [sp, #16]	@ iy, %sfp
	add	r3, r3, r1	@ tmp326, iy, minRange
	ldr	r1, [sp, #24]	@ iy, %sfp
	cmp	r1, r3	@ iy, tmp326
	and	r0, r0, #8	@ _34, gBmSt.gameStateBits,
	sub	r3, lr, #1	@ ivtmp.103, ivtmp.103,
	bgt	.L20		@,
@ NewMapAddInRange.c:46:             xRange += xMin;
	ldr	r4, [sp, #12]	@ ivtmp.130, %sfp
	ldr	r7, [sp, #36]	@ minRange, %sfp
	add	r7, r4, r7	@ tmp414, ivtmp.130, minRange
	str	r10, [sp, #52]	@ ivtmp.112, %sfp
	add	r7, r7, r10	@ tmp415, tmp414, ivtmp.112
	mov	r6, r3	@ ivtmp.64, ivtmp.103
@ NewMapAddInRange.c:62: 				gBmMapFog[iy][ix] = 1; 
	mov	r5, #1	@ tmp418,
@ NewMapAddInRange.c:46:             xRange += xMin;
	mov	r10, r3	@ ivtmp.103, ivtmp.103
	str	lr, [sp, #60]	@ ivtmp.103, %sfp
@ NewMapAddInRange.c:37:     for (iRange = range, iy = y; (iy <= y + range) && (iy < gBmMapSize.y); --iRange, ++iy)
	ldr	r1, [sp, #24]	@ iy, %sfp
@ NewMapAddInRange.c:46:             xRange += xMin;
	str	r2, [sp, #56]	@ ivtmp.110, %sfp
	ldr	lr, [sp, #40]	@ ivtmp.124, %sfp
.L28:
@ NewMapAddInRange.c:37:     for (iRange = range, iy = y; (iy <= y + range) && (iy < gBmMapSize.y); --iRange, ++iy)
	ldrsh	r3, [ip, #2]	@ gBmMapSize.y, gBmMapSize.y
@ NewMapAddInRange.c:37:     for (iRange = range, iy = y; (iy <= y + range) && (iy < gBmMapSize.y); --iRange, ++iy)
	cmp	r3, r1	@ gBmMapSize.y, iy
	ble	.L66		@,
@ NewMapAddInRange.c:52:         if (xMax > gBmMapSize.x)
	ldrsh	r3, [ip]	@ gBmMapSize.x, gBmMapSize.x
@ NewMapAddInRange.c:46:             xRange += xMin;
	sub	r4, r7, r1	@ tmp357, tmp415, iy
	cmp	r4, r3	@ tmp357, gBmMapSize.x
	movge	r4, r3	@ _45, gBmMapSize.x
@ NewMapAddInRange.c:44:         if (xMin < 0)
	bic	r3, r6, r6, asr #31	@ ix, ivtmp.64
@ NewMapAddInRange.c:58:         for (ix = xMin; ix < xMax; ++ix)
	cmp	r4, r3	@ _45, ix
	strgt	r1, [sp, #4]	@ iy, %sfp
	lslgt	r9, r1, #2	@ _290, iy,
	ble	.L31		@,
.L30:
@ NewMapAddInRange.c:60:             gWorkingBmMap[iy][ix] += value;
	ldr	r2, [fp]	@ gWorkingBmMap, gWorkingBmMap
@ NewMapAddInRange.c:60:             gWorkingBmMap[iy][ix] += value;
	ldr	r1, [r2, r9]	@ *_50, *_50
@ NewMapAddInRange.c:60:             gWorkingBmMap[iy][ix] += value;
	ldrb	r2, [r1, r3]	@ zero_extendqisi2	@ *_54, *_54
	sub	r2, r2, #1	@ tmp365, *_54,
	strb	r2, [r1, r3]	@ tmp365, *_54
@ NewMapAddInRange.c:61: 			if (setFog) { 
	cmp	r0, #0	@ _34,
@ NewMapAddInRange.c:62: 				gBmMapFog[iy][ix] = 1; 
	ldrne	r2, [r8]	@ gBmMapFog, gBmMapFog
@ NewMapAddInRange.c:62: 				gBmMapFog[iy][ix] = 1; 
	ldrne	r2, [r2, r9]	@ *_59, *_59
	strbne	r5, [r2, r3]	@ tmp418, *_61
@ NewMapAddInRange.c:58:         for (ix = xMin; ix < xMax; ++ix)
	add	r3, r3, #1	@ ix, ix,
@ NewMapAddInRange.c:58:         for (ix = xMin; ix < xMax; ++ix)
	cmp	r4, r3	@ _45, ix
	bne	.L30		@,
	ldr	r1, [sp, #4]	@ iy, %sfp
.L31:
@ NewMapAddInRange.c:37:     for (iRange = range, iy = y; (iy <= y + range) && (iy < gBmMapSize.y); --iRange, ++iy)
	add	r1, r1, #1	@ iy, iy,
@ NewMapAddInRange.c:37:     for (iRange = range, iy = y; (iy <= y + range) && (iy < gBmMapSize.y); --iRange, ++iy)
	cmp	r1, lr	@ iy, ivtmp.124
	add	r6, r6, #1	@ ivtmp.64, ivtmp.64,
	ble	.L28		@,
.L66:
	add	r2, sp, #56	@,,
	mov	r3, r10	@ ivtmp.103, ivtmp.103
	ldm	r2, {r2, lr}	@,,
	ldr	r10, [sp, #52]	@ ivtmp.112, %sfp
.L20:
	ldr	r1, [sp, #44]	@ _32, %sfp
	ldr	r4, [sp, #8]	@ ivtmp.128, %sfp
@ NewMapAddInRange.c:69:     for (iRange = (range - 1), iy = (y - 1); (iy >= y - range) && (iy >= 0); --iRange, --iy)
	ldr	r5, [sp, #16]	@ iy, %sfp
	add	r4, r1, r4	@ _19, _32, ivtmp.128
	ldr	r1, [sp, #48]	@ _211, %sfp
	cmp	r4, r5	@ _19, iy
	movgt	r1, #0	@, _211
	andle	r1, r1, #1	@,, _211, _211
	cmp	r1, #0	@ tmp354,
	str	r4, [sp, #4]	@ _19, %sfp
	beq	.L9		@,
	mov	r6, lr	@ ivtmp.48, ivtmp.103
	ldr	r4, [sp, #8]	@ ivtmp.128, %sfp
	ldr	lr, [sp, #36]	@ minRange, %sfp
	sub	r7, lr, r4	@ tmp404, minRange, ivtmp.128
@ NewMapAddInRange.c:78:             xRange += xMin;
	str	r10, [sp, #48]	@ ivtmp.112, %sfp
	add	r7, r7, r10	@ tmp375, tmp404, ivtmp.112
@ NewMapAddInRange.c:94: 				gBmMapFog[iy][ix] = 1; 
	mov	r5, #1	@ tmp409,
@ NewMapAddInRange.c:78:             xRange += xMin;
	mov	r10, r3	@ ivtmp.103, ivtmp.103
@ NewMapAddInRange.c:69:     for (iRange = (range - 1), iy = (y - 1); (iy >= y - range) && (iy >= 0); --iRange, --iy)
	ldr	r1, [sp, #16]	@ iy, %sfp
@ NewMapAddInRange.c:78:             xRange += xMin;
	str	r2, [sp, #52]	@ ivtmp.110, %sfp
.L26:
@ NewMapAddInRange.c:84:         if (xMax > gBmMapSize.x)
	ldrsh	r3, [ip]	@ gBmMapSize.x, gBmMapSize.x
@ NewMapAddInRange.c:78:             xRange += xMin;
	add	r4, r7, r1	@ tmp376, tmp375, iy
	cmp	r4, r3	@ tmp376, gBmMapSize.x
	movge	r4, r3	@ _80, gBmMapSize.x
@ NewMapAddInRange.c:76:         if (xMin < 0)
	bic	r3, r6, r6, asr #31	@ ix, ivtmp.48
@ NewMapAddInRange.c:90:         for (ix = xMin; ix < xMax; ++ix)
	cmp	r4, r3	@ _80, ix
	lslgt	r9, r1, #2	@ _307, iy,
	ble	.L36		@,
.L35:
@ NewMapAddInRange.c:92:             gWorkingBmMap[iy][ix] += value;
	ldr	r2, [fp]	@ gWorkingBmMap, gWorkingBmMap
@ NewMapAddInRange.c:92:             gWorkingBmMap[iy][ix] += value;
	ldr	lr, [r2, r9]	@ *_85, *_85
@ NewMapAddInRange.c:92:             gWorkingBmMap[iy][ix] += value;
	ldrb	r2, [lr, r3]	@ zero_extendqisi2	@ *_89, *_89
	sub	r2, r2, #1	@ tmp391, *_89,
	strb	r2, [lr, r3]	@ tmp391, *_89
@ NewMapAddInRange.c:93: 			if (setFog) { 
	cmp	r0, #0	@ _34,
@ NewMapAddInRange.c:94: 				gBmMapFog[iy][ix] = 1; 
	ldrne	r2, [r8]	@ gBmMapFog, gBmMapFog
@ NewMapAddInRange.c:94: 				gBmMapFog[iy][ix] = 1; 
	ldrne	r2, [r2, r9]	@ *_94, *_94
	strbne	r5, [r2, r3]	@ tmp409, *_96
@ NewMapAddInRange.c:90:         for (ix = xMin; ix < xMax; ++ix)
	add	r3, r3, #1	@ ix, ix,
@ NewMapAddInRange.c:90:         for (ix = xMin; ix < xMax; ++ix)
	cmp	r4, r3	@ _80, ix
	bne	.L35		@,
.L36:
@ NewMapAddInRange.c:69:     for (iRange = (range - 1), iy = (y - 1); (iy >= y - range) && (iy >= 0); --iRange, --iy)
	ldr	r3, [sp, #4]	@ tmp385, %sfp
@ NewMapAddInRange.c:69:     for (iRange = (range - 1), iy = (y - 1); (iy >= y - range) && (iy >= 0); --iRange, --iy)
	sub	r1, r1, #1	@ iy, iy,
@ NewMapAddInRange.c:69:     for (iRange = (range - 1), iy = (y - 1); (iy >= y - range) && (iy >= 0); --iRange, --iy)
	cmp	r3, r1	@ tmp385, iy
	movgt	r3, #0	@ tmp385,
	movle	r3, #1	@ tmp385,
	cmn	r1, #1	@ iy,
	moveq	r3, #0	@ tmp385,
	cmp	r3, #0	@ tmp385,
	add	r6, r6, #1	@ ivtmp.48, ivtmp.48,
	bne	.L26		@,
	mov	r3, r10	@ ivtmp.103, ivtmp.103
	ldr	r2, [sp, #52]	@ ivtmp.110, %sfp
	ldr	r10, [sp, #48]	@ ivtmp.112, %sfp
.L9:
@ NewMapAddInRange.c:15:             for (ix = gBmMapSize.x - 1; ix >= 0; --ix) 
	ldr	r1, [sp, #32]	@ _199, %sfp
	sub	r10, r10, #1	@ ivtmp.112, ivtmp.112,
	cmp	r1, r10	@ _199, ivtmp.112
	mov	lr, r3	@ ivtmp.103, ivtmp.103
	sub	r2, r2, #2	@ ivtmp.110, ivtmp.110,
	bne	.L7		@,
.L8:
@ NewMapAddInRange.c:13: 	for (iy = gBmMapSize.y - 1; iy >= 0; --iy) 
	ldr	r3, [sp, #16]	@ iy, %sfp
	cmn	r3, #1	@ iy,
	ldr	r3, [sp, #40]	@ ivtmp.124, %sfp
	sub	r3, r3, #1	@ ivtmp.124, ivtmp.124,
	str	r3, [sp, #40]	@ ivtmp.124, %sfp
	ldr	r3, [sp, #8]	@ ivtmp.128, %sfp
	sub	r3, r3, #1	@ ivtmp.128, ivtmp.128,
	str	r3, [sp, #8]	@ ivtmp.128, %sfp
	ldr	r3, [sp, #12]	@ ivtmp.130, %sfp
	sub	r3, r3, #1	@ ivtmp.130, ivtmp.130,
	str	r3, [sp, #12]	@ ivtmp.130, %sfp
	bne	.L4		@,
.L1:
@ NewMapAddInRange.c:27: } 
	add	sp, sp, #68	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, lr}	@
	bx	lr	@
.L64:
	sub	r3, lr, #1	@ ivtmp.103, ivtmp.103,
	b	.L9		@
.L69:
	.align	2
.L68:
	.word	gBmMapSize
	.word	gWorkingBmMap
	.word	gBmMapFog
	.word	gBmMapMovement
	.word	gBmMapUnit
	.word	gBmSt
	.size	NewForEachInMovementRange, .-NewForEachInMovementRange
	.align	2
	.global	PokemblemMapAddInRange
	.syntax unified
	.arm
	.type	PokemblemMapAddInRange, %function
PokemblemMapAddInRange:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}	@
	mov	lr, r3	@ tmp252, value
@ NewMapAddInRange.c:32: 	int setFog = (gBmSt.gameStateBits & BM_FLAG_3); // @ Check if we're called by DangerRadius
	ldr	r3, .L98	@ tmp186,
	ldrb	ip, [r3, #4]	@ zero_extendqisi2	@ gBmSt.gameStateBits, gBmSt.gameStateBits
@ NewMapAddInRange.c:37:     for (iRange = range, iy = y; (iy <= y + range) && (iy < gBmMapSize.y); --iRange, ++iy)
	cmp	r2, #0	@ range,
@ NewMapAddInRange.c:30: {
	mov	r3, r1	@ y, tmp250
	sub	sp, sp, #28	@,,
	and	ip, ip, #8	@ _60, gBmSt.gameStateBits,
@ NewMapAddInRange.c:37:     for (iRange = range, iy = y; (iy <= y + range) && (iy < gBmMapSize.y); --iRange, ++iy)
	add	r10, r2, r1	@ _99, range, y
@ NewMapAddInRange.c:37:     for (iRange = range, iy = y; (iy <= y + range) && (iy < gBmMapSize.y); --iRange, ++iy)
	blt	.L76		@,
@ NewMapAddInRange.c:62: 				gBmMapFog[iy][ix] = 1; 
	mov	r7, #1	@ tmp244,
@ NewMapAddInRange.c:92:             gWorkingBmMap[iy][ix] += value;
	str	r0, [sp, #8]	@ x, %sfp
	lsl	r4, r0, r7	@ _97, x,
	sub	r8, r0, r2	@ ivtmp.164, x, range
	mov	r0, r10	@ _99, _99
	ldr	r9, .L98+4	@ tmp227,
	ldr	r5, .L98+8	@ tmp242,
@ NewMapAddInRange.c:62: 				gBmMapFog[iy][ix] = 1; 
	ldr	r6, .L98+12	@ tmp243,
@ NewMapAddInRange.c:92:             gWorkingBmMap[iy][ix] += value;
	str	r1, [sp, #12]	@ y, %sfp
	str	r2, [sp, #16]	@ range, %sfp
	str	lr, [sp, #20]	@ value, %sfp
@ NewMapAddInRange.c:46:             xRange += xMin;
	add	fp, r4, r7	@ tmp240, _97,
@ NewMapAddInRange.c:92:             gWorkingBmMap[iy][ix] += value;
	and	r4, lr, #255	@ _134, value,
.L75:
@ NewMapAddInRange.c:37:     for (iRange = range, iy = y; (iy <= y + range) && (iy < gBmMapSize.y); --iRange, ++iy)
	ldrsh	r3, [r9, #2]	@ gBmMapSize.y, gBmMapSize.y
@ NewMapAddInRange.c:37:     for (iRange = range, iy = y; (iy <= y + range) && (iy < gBmMapSize.y); --iRange, ++iy)
	cmp	r3, r1	@ gBmMapSize.y, iy
	ble	.L97		@,
@ NewMapAddInRange.c:52:         if (xMax > gBmMapSize.x)
	ldrsh	r3, [r9]	@ gBmMapSize.x, gBmMapSize.x
@ NewMapAddInRange.c:46:             xRange += xMin;
	sub	lr, fp, r8	@ tmp191, tmp240, ivtmp.164
	cmp	lr, r3	@ tmp191, gBmMapSize.x
	movge	lr, r3	@ _58, gBmMapSize.x
@ NewMapAddInRange.c:44:         if (xMin < 0)
	bic	r3, r8, r8, asr #31	@ ix, ivtmp.164
@ NewMapAddInRange.c:58:         for (ix = xMin; ix < xMax; ++ix)
	cmp	lr, r3	@ _58, ix
	strgt	r1, [sp, #4]	@ iy, %sfp
	lslgt	r10, r1, #2	@ _92, iy,
	ble	.L79		@,
.L78:
@ NewMapAddInRange.c:60:             gWorkingBmMap[iy][ix] += value;
	ldr	r2, [r5]	@ gWorkingBmMap, gWorkingBmMap
@ NewMapAddInRange.c:60:             gWorkingBmMap[iy][ix] += value;
	ldr	r1, [r2, r10]	@ *_9, *_9
@ NewMapAddInRange.c:60:             gWorkingBmMap[iy][ix] += value;
	ldrb	r2, [r1, r3]	@ zero_extendqisi2	@ *_12, *_12
	add	r2, r4, r2	@ tmp199, _134, *_12
	strb	r2, [r1, r3]	@ tmp199, *_12
@ NewMapAddInRange.c:61: 			if (setFog) { 
	cmp	ip, #0	@ _60,
@ NewMapAddInRange.c:62: 				gBmMapFog[iy][ix] = 1; 
	ldrne	r2, [r6]	@ gBmMapFog, gBmMapFog
@ NewMapAddInRange.c:62: 				gBmMapFog[iy][ix] = 1; 
	ldrne	r2, [r2, r10]	@ *_17, *_17
	strbne	r7, [r2, r3]	@ tmp244, *_19
@ NewMapAddInRange.c:58:         for (ix = xMin; ix < xMax; ++ix)
	add	r3, r3, #1	@ ix, ix,
@ NewMapAddInRange.c:58:         for (ix = xMin; ix < xMax; ++ix)
	cmp	lr, r3	@ _58, ix
	bne	.L78		@,
	ldr	r1, [sp, #4]	@ iy, %sfp
.L79:
@ NewMapAddInRange.c:37:     for (iRange = range, iy = y; (iy <= y + range) && (iy < gBmMapSize.y); --iRange, ++iy)
	add	r1, r1, #1	@ iy, iy,
@ NewMapAddInRange.c:37:     for (iRange = range, iy = y; (iy <= y + range) && (iy < gBmMapSize.y); --iRange, ++iy)
	cmp	r1, r0	@ iy, _99
	add	r8, r8, #1	@ ivtmp.164, ivtmp.164,
	ble	.L75		@,
.L97:
	add	r0, sp, #8	@,,
	add	r2, sp, #16	@,,
	ldm	r0, {r0, r3}	@,,
	ldm	r2, {r2, lr}	@,,
.L76:
@ NewMapAddInRange.c:69:     for (iRange = (range - 1), iy = (y - 1); (iy >= y - range) && (iy >= 0); --iRange, --iy)
	sub	r1, r3, r2	@ _20, y, range
	bic	r1, r1, r1, asr #31	@ _20, _20
@ NewMapAddInRange.c:69:     for (iRange = (range - 1), iy = (y - 1); (iy >= y - range) && (iy >= 0); --iRange, --iy)
	sub	r4, r3, #1	@ iy, y,
@ NewMapAddInRange.c:69:     for (iRange = (range - 1), iy = (y - 1); (iy >= y - range) && (iy >= 0); --iRange, --iy)
	cmp	r1, r4	@ _20, iy
@ NewMapAddInRange.c:69:     for (iRange = (range - 1), iy = (y - 1); (iy >= y - range) && (iy >= 0); --iRange, --iy)
	sub	r6, r2, #1	@ iRange, range,
@ NewMapAddInRange.c:69:     for (iRange = (range - 1), iy = (y - 1); (iy >= y - range) && (iy >= 0); --iRange, --iy)
	bgt	.L70		@,
@ NewMapAddInRange.c:94: 				gBmMapFog[iy][ix] = 1; 
	mov	r7, #1	@ tmp235,
	add	r10, r0, r7	@ tmp208, x,
	add	r10, r10, r3	@ tmp209, tmp208, y
	sub	r6, r0, r6	@ ivtmp.148, x, iRange
@ NewMapAddInRange.c:92:             gWorkingBmMap[iy][ix] += value;
	and	r5, lr, #255	@ _137, value,
	sub	r10, r10, r2	@ tmp210, tmp209, range
	lsl	r0, r0, r7	@ _122, x,
	ldr	r9, .L98+4	@ tmp227,
	ldr	lr, .L98+8	@ tmp233,
@ NewMapAddInRange.c:94: 				gBmMapFog[iy][ix] = 1; 
	ldr	r8, .L98+12	@ tmp234,
	lsl	r4, r4, #2	@ ivtmp.153, iy,
	sub	r10, r10, r1	@ _124, tmp210, _20
	add	fp, r0, r7	@ tmp228, _122,
.L82:
@ NewMapAddInRange.c:84:         if (xMax > gBmMapSize.x)
	ldrsh	r3, [r9]	@ gBmMapSize.x, gBmMapSize.x
@ NewMapAddInRange.c:78:             xRange += xMin;
	sub	r0, fp, r6	@ tmp212, tmp228, ivtmp.148
	cmp	r0, r3	@ tmp212, gBmMapSize.x
	movge	r0, r3	@ _2, gBmMapSize.x
@ NewMapAddInRange.c:76:         if (xMin < 0)
	bic	r3, r6, r6, asr #31	@ ix, ivtmp.148
@ NewMapAddInRange.c:90:         for (ix = xMin; ix < xMax; ++ix)
	cmp	r0, r3	@ _2, ix
	ble	.L85		@,
.L84:
@ NewMapAddInRange.c:92:             gWorkingBmMap[iy][ix] += value;
	ldr	r2, [lr]	@ gWorkingBmMap, gWorkingBmMap
@ NewMapAddInRange.c:92:             gWorkingBmMap[iy][ix] += value;
	ldr	r1, [r2, r4]	@ *_29, *_29
@ NewMapAddInRange.c:92:             gWorkingBmMap[iy][ix] += value;
	ldrb	r2, [r1, r3]	@ zero_extendqisi2	@ *_32, *_32
	add	r2, r5, r2	@ tmp220, _137, *_32
	strb	r2, [r1, r3]	@ tmp220, *_32
@ NewMapAddInRange.c:93: 			if (setFog) { 
	cmp	ip, #0	@ _60,
@ NewMapAddInRange.c:94: 				gBmMapFog[iy][ix] = 1; 
	ldrne	r2, [r8]	@ gBmMapFog, gBmMapFog
@ NewMapAddInRange.c:94: 				gBmMapFog[iy][ix] = 1; 
	ldrne	r2, [r2, r4]	@ *_37, *_37
	strbne	r7, [r2, r3]	@ tmp235, *_39
@ NewMapAddInRange.c:90:         for (ix = xMin; ix < xMax; ++ix)
	add	r3, r3, #1	@ ix, ix,
@ NewMapAddInRange.c:90:         for (ix = xMin; ix < xMax; ++ix)
	cmp	r0, r3	@ _2, ix
	bne	.L84		@,
.L85:
@ NewMapAddInRange.c:69:     for (iRange = (range - 1), iy = (y - 1); (iy >= y - range) && (iy >= 0); --iRange, --iy)
	add	r6, r6, #1	@ ivtmp.148, ivtmp.148,
	cmp	r6, r10	@ ivtmp.148, _124
	sub	r4, r4, #4	@ ivtmp.153, ivtmp.153,
	bne	.L82		@,
.L70:
@ NewMapAddInRange.c:98: }
	add	sp, sp, #28	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, lr}	@
	bx	lr	@
.L99:
	.align	2
.L98:
	.word	gBmSt
	.word	gBmMapSize
	.word	gWorkingBmMap
	.word	gBmMapFog
	.size	PokemblemMapAddInRange, .-PokemblemMapAddInRange
	.ident	"GCC: (devkitARM release 59) 12.2.0"
