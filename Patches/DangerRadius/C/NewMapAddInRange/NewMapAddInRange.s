	.cpu arm7tdmi
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
@ GNU C17 (devkitARM release 56) version 11.1.0 (arm-none-eabi)
@	compiled by GNU C version 10.3.0, GMP version 6.2.1, MPFR version 4.1.0, MPC version 1.2.1, isl version isl-0.18-GMP

@ GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
@ options passed: -mcpu=arm7tdmi -mtune=arm7tdmi -mlong-calls -marm -march=armv4t -O2
	.text
	.align	2
	.global	PokemblemMapAddInRange
	.arch armv4t
	.syntax unified
	.arm
	.fpu softvfp
	.type	PokemblemMapAddInRange, %function
PokemblemMapAddInRange:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}	@
@ NewMapAddInRange.c:12: 	int setFog = (gBmSt.gameStateBits & BM_FLAG_3); // @ Check if we're called by DangerRadius
	ldr	ip, .L29	@ tmp186,
@ NewMapAddInRange.c:17:     for (iRange = range, iy = y; (iy <= y + range) && (iy < gBmMapSize.y); --iRange, ++iy)
	add	fp, r2, r1	@ _99, range, y
	ldrb	ip, [ip, #4]	@ zero_extendqisi2	@ gBmSt.gameStateBits, gBmSt.gameStateBits
@ NewMapAddInRange.c:10: {
	sub	sp, sp, #28	@,,
@ NewMapAddInRange.c:17:     for (iRange = range, iy = y; (iy <= y + range) && (iy < gBmMapSize.y); --iRange, ++iy)
	cmp	r1, fp	@ y, _99
@ NewMapAddInRange.c:10: {
	str	r1, [sp, #8]	@ y, %sfp
	str	r2, [sp, #12]	@ range, %sfp
	str	r0, [sp, #16]	@ tmp249, %sfp
	str	r3, [sp, #20]	@ tmp252, %sfp
	and	ip, ip, #8	@ _61, gBmSt.gameStateBits,
@ NewMapAddInRange.c:17:     for (iRange = range, iy = y; (iy <= y + range) && (iy < gBmMapSize.y); --iRange, ++iy)
	bgt	.L7		@,
@ NewMapAddInRange.c:42: 				gBmMapFog[iy][ix] = 1; 
	mov	r8, #1	@ tmp244,
	ldr	r2, [sp, #16]	@ x, %sfp
	lsl	r3, r2, r8	@ _101, x,
	add	r3, r3, r8	@ tmp240, _101,
	str	r3, [sp, #4]	@ tmp240, %sfp
	ldr	r3, [sp, #12]	@ range, %sfp
	sub	r9, r2, r3	@ ivtmp.51, x, range
@ NewMapAddInRange.c:72:             gWorkingBmMap[iy][ix] += value;
	ldr	r3, [sp, #20]	@ value, %sfp
@ NewMapAddInRange.c:17:     for (iRange = range, iy = y; (iy <= y + range) && (iy < gBmMapSize.y); --iRange, ++iy)
	ldr	r6, [sp, #8]	@ iy, %sfp
	ldr	r10, .L29+4	@ tmp229,
	ldr	r5, .L29+8	@ tmp242,
@ NewMapAddInRange.c:42: 				gBmMapFog[iy][ix] = 1; 
	ldr	r7, .L29+12	@ tmp243,
@ NewMapAddInRange.c:72:             gWorkingBmMap[iy][ix] += value;
	and	r4, r3, #255	@ _138, value,
.L6:
@ NewMapAddInRange.c:17:     for (iRange = range, iy = y; (iy <= y + range) && (iy < gBmMapSize.y); --iRange, ++iy)
	ldrsh	r3, [r10, #2]	@ gBmMapSize.y, gBmMapSize.y
@ NewMapAddInRange.c:17:     for (iRange = range, iy = y; (iy <= y + range) && (iy < gBmMapSize.y); --iRange, ++iy)
	cmp	r3, r6	@ gBmMapSize.y, iy
	ble	.L7		@,
	ldr	r2, [sp, #4]	@ tmp240, %sfp
@ NewMapAddInRange.c:32:         if (xMax > gBmMapSize.x)
	ldrsh	r3, [r10]	@ gBmMapSize.x, gBmMapSize.x
	sub	r0, r2, r9	@ tmp191, tmp240, ivtmp.51
	cmp	r0, r3	@ tmp191, gBmMapSize.x
	movge	r0, r3	@ _6, gBmMapSize.x
	bic	r3, r9, r9, asr #31	@ ix, ivtmp.51
@ NewMapAddInRange.c:38:         for (ix = xMin; ix < xMax; ++ix)
	cmp	r0, r3	@ _6, ix
	lslgt	lr, r6, #2	@ _94, iy,
	ble	.L10		@,
.L9:
@ NewMapAddInRange.c:40:             gWorkingBmMap[iy][ix] += value;
	ldr	r2, [r5]	@ gWorkingBmMap, gWorkingBmMap
@ NewMapAddInRange.c:40:             gWorkingBmMap[iy][ix] += value;
	ldr	r1, [r2, lr]	@ *_10, *_10
	ldrb	r2, [r1, r3]	@ zero_extendqisi2	@ *_13, *_13
	add	r2, r4, r2	@ tmp199, _138, *_13
	strb	r2, [r1, r3]	@ tmp199, *_13
@ NewMapAddInRange.c:41: 			if (setFog) { 
	cmp	ip, #0	@ _61,
@ NewMapAddInRange.c:42: 				gBmMapFog[iy][ix] = 1; 
	ldrne	r2, [r7]	@ gBmMapFog, gBmMapFog
@ NewMapAddInRange.c:42: 				gBmMapFog[iy][ix] = 1; 
	ldrne	r2, [r2, lr]	@ *_18, *_18
	strbne	r8, [r2, r3]	@ tmp244, *_20
@ NewMapAddInRange.c:38:         for (ix = xMin; ix < xMax; ++ix)
	add	r3, r3, #1	@ ix, ix,
@ NewMapAddInRange.c:38:         for (ix = xMin; ix < xMax; ++ix)
	cmp	r0, r3	@ _6, ix
	bne	.L9		@,
.L10:
@ NewMapAddInRange.c:17:     for (iRange = range, iy = y; (iy <= y + range) && (iy < gBmMapSize.y); --iRange, ++iy)
	add	r6, r6, #1	@ iy, iy,
@ NewMapAddInRange.c:17:     for (iRange = range, iy = y; (iy <= y + range) && (iy < gBmMapSize.y); --iRange, ++iy)
	cmp	r6, fp	@ iy, _99
	add	r9, r9, #1	@ ivtmp.51, ivtmp.51,
	ble	.L6		@,
.L7:
@ NewMapAddInRange.c:49:     for (iRange = (range - 1), iy = (y - 1); (iy >= y - range) && (iy >= 0); --iRange, --iy)
	ldr	r2, [sp, #8]	@ y, %sfp
	ldr	r1, [sp, #12]	@ range, %sfp
	sub	r3, r2, r1	@ _21, y, range
	bic	r3, r3, r3, asr #31	@ _21, _21
@ NewMapAddInRange.c:49:     for (iRange = (range - 1), iy = (y - 1); (iy >= y - range) && (iy >= 0); --iRange, --iy)
	sub	r0, r2, #1	@ iy, y,
@ NewMapAddInRange.c:49:     for (iRange = (range - 1), iy = (y - 1); (iy >= y - range) && (iy >= 0); --iRange, --iy)
	cmp	r3, r0	@ _21, iy
@ NewMapAddInRange.c:49:     for (iRange = (range - 1), iy = (y - 1); (iy >= y - range) && (iy >= 0); --iRange, --iy)
	sub	r6, r1, #1	@ iRange, range,
@ NewMapAddInRange.c:49:     for (iRange = (range - 1), iy = (y - 1); (iy >= y - range) && (iy >= 0); --iRange, --iy)
	bgt	.L1		@,
@ NewMapAddInRange.c:74: 				gBmMapFog[iy][ix] = 1; 
	mov	r7, #1	@ tmp235,
@ NewMapAddInRange.c:72:             gWorkingBmMap[iy][ix] += value;
	ldr	r1, [sp, #20]	@ value, %sfp
	ldr	r2, [sp, #16]	@ x, %sfp
	and	r5, r1, #255	@ _141, value,
	ldr	r1, [sp, #8]	@ y, %sfp
	add	r9, r2, r7	@ tmp208, x,
	add	r9, r9, r1	@ tmp209, tmp208, y
	ldr	r1, [sp, #12]	@ range, %sfp
	lsl	fp, r2, r7	@ _126, x,
	sub	r9, r9, r1	@ tmp210, tmp209, range
	ldr	r10, .L29+4	@ tmp229,
	ldr	r4, .L29+8	@ tmp233,
@ NewMapAddInRange.c:74: 				gBmMapFog[iy][ix] = 1; 
	ldr	r8, .L29+12	@ tmp234,
	sub	r6, r2, r6	@ ivtmp.35, x, iRange
	lsl	r0, r0, #2	@ ivtmp.40, iy,
	sub	r9, r9, r3	@ _128, tmp210, _21
	add	fp, fp, r7	@ tmp228, _126,
.L13:
@ NewMapAddInRange.c:64:         if (xMax > gBmMapSize.x)
	ldrsh	r3, [r10]	@ gBmMapSize.x, gBmMapSize.x
	sub	lr, fp, r6	@ tmp212, tmp228, ivtmp.35
	cmp	lr, r3	@ tmp212, gBmMapSize.x
	movge	lr, r3	@ _2, gBmMapSize.x
	bic	r3, r6, r6, asr #31	@ ix, ivtmp.35
@ NewMapAddInRange.c:70:         for (ix = xMin; ix < xMax; ++ix)
	cmp	lr, r3	@ _2, ix
	ble	.L16		@,
.L15:
@ NewMapAddInRange.c:72:             gWorkingBmMap[iy][ix] += value;
	ldr	r2, [r4]	@ gWorkingBmMap, gWorkingBmMap
@ NewMapAddInRange.c:72:             gWorkingBmMap[iy][ix] += value;
	ldr	r1, [r2, r0]	@ *_30, *_30
	ldrb	r2, [r1, r3]	@ zero_extendqisi2	@ *_33, *_33
	add	r2, r5, r2	@ tmp220, _141, *_33
	strb	r2, [r1, r3]	@ tmp220, *_33
@ NewMapAddInRange.c:73: 			if (setFog) { 
	cmp	ip, #0	@ _61,
@ NewMapAddInRange.c:74: 				gBmMapFog[iy][ix] = 1; 
	ldrne	r2, [r8]	@ gBmMapFog, gBmMapFog
@ NewMapAddInRange.c:74: 				gBmMapFog[iy][ix] = 1; 
	ldrne	r2, [r2, r0]	@ *_38, *_38
	strbne	r7, [r2, r3]	@ tmp235, *_40
@ NewMapAddInRange.c:70:         for (ix = xMin; ix < xMax; ++ix)
	add	r3, r3, #1	@ ix, ix,
@ NewMapAddInRange.c:70:         for (ix = xMin; ix < xMax; ++ix)
	cmp	lr, r3	@ _2, ix
	bne	.L15		@,
.L16:
@ NewMapAddInRange.c:49:     for (iRange = (range - 1), iy = (y - 1); (iy >= y - range) && (iy >= 0); --iRange, --iy)
	add	r6, r6, #1	@ ivtmp.35, ivtmp.35,
	cmp	r6, r9	@ ivtmp.35, _128
	sub	r0, r0, #4	@ ivtmp.40, ivtmp.40,
	bne	.L13		@,
.L1:
@ NewMapAddInRange.c:78: }
	add	sp, sp, #28	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, lr}	@
	bx	lr	@
.L30:
	.align	2
.L29:
	.word	gBmSt
	.word	gBmMapSize
	.word	gWorkingBmMap
	.word	gBmMapFog
	.size	PokemblemMapAddInRange, .-PokemblemMapAddInRange
	.ident	"GCC: (devkitARM release 56) 11.1.0"
