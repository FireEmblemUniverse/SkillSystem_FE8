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
@ NewMapAddInRange.c:13: 	int setFog = (gBmSt.gameStateBits & BM_FLAG_3); // @ Check if we're called by DangerRadius
	ldr	r3, .L30	@ tmp186,
	ldrb	ip, [r3, #4]	@ zero_extendqisi2	@ gBmSt.gameStateBits, gBmSt.gameStateBits
@ NewMapAddInRange.c:18:     for (iRange = range, iy = y; (iy <= y + range) && (iy < gBmMapSize.y); --iRange, ++iy)
	cmp	r2, #0	@ range,
@ NewMapAddInRange.c:11: {
	mov	r3, r1	@ y, tmp250
	sub	sp, sp, #28	@,,
	and	ip, ip, #8	@ _60, gBmSt.gameStateBits,
@ NewMapAddInRange.c:18:     for (iRange = range, iy = y; (iy <= y + range) && (iy < gBmMapSize.y); --iRange, ++iy)
	add	r10, r2, r1	@ _99, range, y
@ NewMapAddInRange.c:18:     for (iRange = range, iy = y; (iy <= y + range) && (iy < gBmMapSize.y); --iRange, ++iy)
	blt	.L7		@,
@ NewMapAddInRange.c:43: 				gBmMapFog[iy][ix] = 1; 
	mov	r7, #1	@ tmp244,
@ NewMapAddInRange.c:73:             gWorkingBmMap[iy][ix] += value;
	str	r0, [sp, #8]	@ x, %sfp
	lsl	r4, r0, r7	@ _97, x,
	sub	r8, r0, r2	@ ivtmp.51, x, range
	mov	r0, r10	@ _99, _99
	ldr	r9, .L30+4	@ tmp229,
	ldr	r5, .L30+8	@ tmp242,
@ NewMapAddInRange.c:43: 				gBmMapFog[iy][ix] = 1; 
	ldr	r6, .L30+12	@ tmp243,
@ NewMapAddInRange.c:73:             gWorkingBmMap[iy][ix] += value;
	str	r1, [sp, #12]	@ y, %sfp
	str	r2, [sp, #16]	@ range, %sfp
	str	lr, [sp, #20]	@ value, %sfp
@ NewMapAddInRange.c:27:             xRange += xMin;
	add	fp, r4, r7	@ tmp240, _97,
@ NewMapAddInRange.c:73:             gWorkingBmMap[iy][ix] += value;
	and	r4, lr, #255	@ _134, value,
.L6:
@ NewMapAddInRange.c:18:     for (iRange = range, iy = y; (iy <= y + range) && (iy < gBmMapSize.y); --iRange, ++iy)
	ldrsh	r3, [r9, #2]	@ gBmMapSize.y, gBmMapSize.y
@ NewMapAddInRange.c:18:     for (iRange = range, iy = y; (iy <= y + range) && (iy < gBmMapSize.y); --iRange, ++iy)
	cmp	r3, r1	@ gBmMapSize.y, iy
	ble	.L28		@,
@ NewMapAddInRange.c:33:         if (xMax > gBmMapSize.x)
	ldrsh	r3, [r9]	@ gBmMapSize.x, gBmMapSize.x
@ NewMapAddInRange.c:27:             xRange += xMin;
	sub	lr, fp, r8	@ tmp191, tmp240, ivtmp.51
	cmp	lr, r3	@ tmp191, gBmMapSize.x
	movge	lr, r3	@ _58, gBmMapSize.x
@ NewMapAddInRange.c:25:         if (xMin < 0)
	bic	r3, r8, r8, asr #31	@ ix, ivtmp.51
@ NewMapAddInRange.c:39:         for (ix = xMin; ix < xMax; ++ix)
	cmp	lr, r3	@ _58, ix
	strgt	r1, [sp, #4]	@ iy, %sfp
	lslgt	r10, r1, #2	@ _92, iy,
	ble	.L10		@,
.L9:
@ NewMapAddInRange.c:41:             gWorkingBmMap[iy][ix] += value;
	ldr	r2, [r5]	@ gWorkingBmMap, gWorkingBmMap
@ NewMapAddInRange.c:41:             gWorkingBmMap[iy][ix] += value;
	ldr	r1, [r2, r10]	@ *_9, *_9
@ NewMapAddInRange.c:41:             gWorkingBmMap[iy][ix] += value;
	ldrb	r2, [r1, r3]	@ zero_extendqisi2	@ *_12, *_12
	add	r2, r4, r2	@ tmp199, _134, *_12
	strb	r2, [r1, r3]	@ tmp199, *_12
@ NewMapAddInRange.c:42: 			if (setFog) { 
	cmp	ip, #0	@ _60,
@ NewMapAddInRange.c:43: 				gBmMapFog[iy][ix] = 1; 
	ldrne	r2, [r6]	@ gBmMapFog, gBmMapFog
@ NewMapAddInRange.c:43: 				gBmMapFog[iy][ix] = 1; 
	ldrne	r2, [r2, r10]	@ *_17, *_17
	strbne	r7, [r2, r3]	@ tmp244, *_19
@ NewMapAddInRange.c:39:         for (ix = xMin; ix < xMax; ++ix)
	add	r3, r3, #1	@ ix, ix,
@ NewMapAddInRange.c:39:         for (ix = xMin; ix < xMax; ++ix)
	cmp	lr, r3	@ _58, ix
	bne	.L9		@,
	ldr	r1, [sp, #4]	@ iy, %sfp
.L10:
@ NewMapAddInRange.c:18:     for (iRange = range, iy = y; (iy <= y + range) && (iy < gBmMapSize.y); --iRange, ++iy)
	add	r1, r1, #1	@ iy, iy,
@ NewMapAddInRange.c:18:     for (iRange = range, iy = y; (iy <= y + range) && (iy < gBmMapSize.y); --iRange, ++iy)
	cmp	r1, r0	@ iy, _99
	add	r8, r8, #1	@ ivtmp.51, ivtmp.51,
	ble	.L6		@,
.L28:
	add	r0, sp, #8	@,,
	add	r2, sp, #16	@,,
	ldm	r0, {r0, r3}	@,,
	ldm	r2, {r2, lr}	@,,
.L7:
@ NewMapAddInRange.c:50:     for (iRange = (range - 1), iy = (y - 1); (iy >= y - range) && (iy >= 0); --iRange, --iy)
	sub	r1, r3, r2	@ _20, y, range
	bic	r1, r1, r1, asr #31	@ _20, _20
@ NewMapAddInRange.c:50:     for (iRange = (range - 1), iy = (y - 1); (iy >= y - range) && (iy >= 0); --iRange, --iy)
	sub	r4, r3, #1	@ iy, y,
@ NewMapAddInRange.c:50:     for (iRange = (range - 1), iy = (y - 1); (iy >= y - range) && (iy >= 0); --iRange, --iy)
	cmp	r1, r4	@ _20, iy
@ NewMapAddInRange.c:50:     for (iRange = (range - 1), iy = (y - 1); (iy >= y - range) && (iy >= 0); --iRange, --iy)
	sub	r6, r2, #1	@ iRange, range,
@ NewMapAddInRange.c:50:     for (iRange = (range - 1), iy = (y - 1); (iy >= y - range) && (iy >= 0); --iRange, --iy)
	bgt	.L1		@,
@ NewMapAddInRange.c:75: 				gBmMapFog[iy][ix] = 1; 
	mov	r7, #1	@ tmp235,
	add	r10, r0, r7	@ tmp208, x,
	add	r10, r10, r3	@ tmp209, tmp208, y
	sub	r6, r0, r6	@ ivtmp.35, x, iRange
@ NewMapAddInRange.c:73:             gWorkingBmMap[iy][ix] += value;
	and	r5, lr, #255	@ _137, value,
	sub	r10, r10, r2	@ tmp210, tmp209, range
	lsl	r0, r0, r7	@ _122, x,
	ldr	r9, .L30+4	@ tmp229,
	ldr	lr, .L30+8	@ tmp233,
@ NewMapAddInRange.c:75: 				gBmMapFog[iy][ix] = 1; 
	ldr	r8, .L30+12	@ tmp234,
	lsl	r4, r4, #2	@ ivtmp.40, iy,
	sub	r10, r10, r1	@ _124, tmp210, _20
	add	fp, r0, r7	@ tmp228, _122,
.L13:
@ NewMapAddInRange.c:65:         if (xMax > gBmMapSize.x)
	ldrsh	r3, [r9]	@ gBmMapSize.x, gBmMapSize.x
@ NewMapAddInRange.c:59:             xRange += xMin;
	sub	r0, fp, r6	@ tmp212, tmp228, ivtmp.35
	cmp	r0, r3	@ tmp212, gBmMapSize.x
	movge	r0, r3	@ _2, gBmMapSize.x
@ NewMapAddInRange.c:57:         if (xMin < 0)
	bic	r3, r6, r6, asr #31	@ ix, ivtmp.35
@ NewMapAddInRange.c:71:         for (ix = xMin; ix < xMax; ++ix)
	cmp	r0, r3	@ _2, ix
	ble	.L16		@,
.L15:
@ NewMapAddInRange.c:73:             gWorkingBmMap[iy][ix] += value;
	ldr	r2, [lr]	@ gWorkingBmMap, gWorkingBmMap
@ NewMapAddInRange.c:73:             gWorkingBmMap[iy][ix] += value;
	ldr	r1, [r2, r4]	@ *_29, *_29
@ NewMapAddInRange.c:73:             gWorkingBmMap[iy][ix] += value;
	ldrb	r2, [r1, r3]	@ zero_extendqisi2	@ *_32, *_32
	add	r2, r5, r2	@ tmp220, _137, *_32
	strb	r2, [r1, r3]	@ tmp220, *_32
@ NewMapAddInRange.c:74: 			if (setFog) { 
	cmp	ip, #0	@ _60,
@ NewMapAddInRange.c:75: 				gBmMapFog[iy][ix] = 1; 
	ldrne	r2, [r8]	@ gBmMapFog, gBmMapFog
@ NewMapAddInRange.c:75: 				gBmMapFog[iy][ix] = 1; 
	ldrne	r2, [r2, r4]	@ *_37, *_37
	strbne	r7, [r2, r3]	@ tmp235, *_39
@ NewMapAddInRange.c:71:         for (ix = xMin; ix < xMax; ++ix)
	add	r3, r3, #1	@ ix, ix,
@ NewMapAddInRange.c:71:         for (ix = xMin; ix < xMax; ++ix)
	cmp	r0, r3	@ _2, ix
	bne	.L15		@,
.L16:
@ NewMapAddInRange.c:50:     for (iRange = (range - 1), iy = (y - 1); (iy >= y - range) && (iy >= 0); --iRange, --iy)
	add	r6, r6, #1	@ ivtmp.35, ivtmp.35,
	cmp	r6, r10	@ ivtmp.35, _124
	sub	r4, r4, #4	@ ivtmp.40, ivtmp.40,
	bne	.L13		@,
.L1:
@ NewMapAddInRange.c:79: }
	add	sp, sp, #28	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, lr}	@
	bx	lr	@
.L31:
	.align	2
.L30:
	.word	gBmSt
	.word	gBmMapSize
	.word	gWorkingBmMap
	.word	gBmMapFog
	.size	PokemblemMapAddInRange, .-PokemblemMapAddInRange
	.ident	"GCC: (devkitARM release 59) 12.2.0"
