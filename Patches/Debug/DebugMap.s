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
	.file	"DebugMap.c"
@ GNU C17 (devkitARM release 56) version 11.1.0 (arm-none-eabi)
@	compiled by GNU C version 10.3.0, GMP version 6.2.1, MPFR version 4.1.0, MPC version 1.2.1, isl version isl-0.18-GMP

@ GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
@ options passed: -mcpu=arm7tdmi -mthumb -mthumb-interwork -mtune=arm7tdmi -mlong-calls -march=armv4t
	.text
	.align	1
	.global	DebugMap_ASMC
	.arch armv4t
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	DebugMap_ASMC, %function
DebugMap_ASMC:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r7, lr}	@
	sub	sp, sp, #28	@,,
	add	r7, sp, #0	@,,
	str	r0, [r7, #4]	@ dst, dst
@ DebugMap.c:39: 	asm("mov r11, r11");
	.syntax divided
@ 39 "DebugMap.c" 1
	mov r11, r11
@ 0 "" 2
@ DebugMap.c:41: 	u8 x = (dst[0] & 0xFF); 
	.thumb
	.syntax unified
	ldr	r3, [r7, #4]	@ tmp131, dst
	ldrh	r2, [r3]	@ _1, *dst_28(D)
@ DebugMap.c:41: 	u8 x = (dst[0] & 0xFF); 
	movs	r3, #13	@ tmp168,
	adds	r3, r7, r3	@ tmp132,, tmp168
	strb	r2, [r3]	@ tmp133, x
@ DebugMap.c:42: 	u8 y = ((dst[0] & 0xFF00) >>8); // no -1 since compare as less than 
	ldr	r3, [r7, #4]	@ tmp134, dst
	ldrh	r3, [r3]	@ _2, *dst_28(D)
@ DebugMap.c:42: 	u8 y = ((dst[0] & 0xFF00) >>8); // no -1 since compare as less than 
	lsrs	r3, r3, #8	@ tmp135, _2,
	lsls	r3, r3, #16	@ tmp136, tmp135,
	lsrs	r2, r3, #16	@ _3, tmp136,
@ DebugMap.c:42: 	u8 y = ((dst[0] & 0xFF00) >>8); // no -1 since compare as less than 
	movs	r3, #12	@ tmp169,
	adds	r3, r7, r3	@ tmp137,, tmp169
	strb	r2, [r3]	@ tmp138, y
@ DebugMap.c:44: 	for (int iy = 0; iy<y; iy++) {
	movs	r3, #0	@ tmp139,
	str	r3, [r7, #20]	@ tmp139, iy
@ DebugMap.c:44: 	for (int iy = 0; iy<y; iy++) {
	b	.L2		@
.L8:
@ DebugMap.c:45: 		for (int ix = 0; ix < x; ix++) {
	movs	r3, #0	@ tmp140,
	str	r3, [r7, #16]	@ tmp140, ix
@ DebugMap.c:45: 		for (int ix = 0; ix < x; ix++) {
	b	.L3		@
.L7:
@ DebugMap.c:46: 			if (ix | iy) {  // if they are both 0, then it will overwrite coordinates 
	ldr	r2, [r7, #16]	@ tmp141, ix
	ldr	r3, [r7, #20]	@ tmp142, iy
	orrs	r3, r2	@ _4, tmp141
@ DebugMap.c:46: 			if (ix | iy) {  // if they are both 0, then it will overwrite coordinates 
	beq	.L4		@,
@ DebugMap.c:47: 				u16 value = 0;
	movs	r3, #14	@ tmp170,
	adds	r3, r7, r3	@ tmp143,, tmp170
	movs	r2, #0	@ tmp144,
	strh	r2, [r3]	@ tmp145, value
@ DebugMap.c:48: 				while (value == 0) { // never be 0 
	b	.L5		@
.L6:
@ DebugMap.c:49: 					value = NextRN_N(31) <<6 | NextRN_N(31);
	movs	r0, #31	@,
	ldr	r3, .L9	@ tmp146,
	bl	.L11		@
	movs	r3, r0	@ _5,
@ DebugMap.c:49: 					value = NextRN_N(31) <<6 | NextRN_N(31);
	lsls	r3, r3, #6	@ _6, _5,
@ DebugMap.c:49: 					value = NextRN_N(31) <<6 | NextRN_N(31);
	lsls	r4, r3, #16	@ _7, _6,
	asrs	r4, r4, #16	@ _7, _7,
@ DebugMap.c:49: 					value = NextRN_N(31) <<6 | NextRN_N(31);
	movs	r0, #31	@,
	ldr	r3, .L9	@ tmp147,
	bl	.L11		@
	movs	r3, r0	@ _8,
@ DebugMap.c:49: 					value = NextRN_N(31) <<6 | NextRN_N(31);
	lsls	r3, r3, #16	@ _9, _8,
	asrs	r3, r3, #16	@ _9, _9,
	orrs	r3, r4	@ tmp148, _7
	lsls	r3, r3, #16	@ _10, tmp148,
	asrs	r3, r3, #16	@ _10, _10,
@ DebugMap.c:49: 					value = NextRN_N(31) <<6 | NextRN_N(31);
	movs	r2, #14	@ tmp171,
	adds	r2, r7, r2	@ tmp149,, tmp171
	strh	r3, [r2]	@ tmp150, value
.L5:
@ DebugMap.c:48: 				while (value == 0) { // never be 0 
	movs	r1, #14	@ tmp172,
	adds	r3, r7, r1	@ tmp151,, tmp172
	ldrh	r3, [r3]	@ tmp152, value
	cmp	r3, #0	@ tmp152,
	beq	.L6		@,
@ DebugMap.c:51: 				dst[iy*x+ix] = value; 
	movs	r3, #13	@ tmp173,
	adds	r3, r7, r3	@ tmp153,, tmp173
	ldrb	r3, [r3]	@ _11, x
	ldr	r2, [r7, #20]	@ tmp154, iy
	muls	r2, r3	@ _12, _11
@ DebugMap.c:51: 				dst[iy*x+ix] = value; 
	ldr	r3, [r7, #16]	@ tmp155, ix
	adds	r3, r2, r3	@ _13, _12, tmp155
@ DebugMap.c:51: 				dst[iy*x+ix] = value; 
	lsls	r3, r3, #1	@ _15, _14,
	ldr	r2, [r7, #4]	@ tmp156, dst
	adds	r3, r2, r3	@ _16, tmp156, _15
@ DebugMap.c:51: 				dst[iy*x+ix] = value; 
	adds	r2, r7, r1	@ tmp157,, tmp175
	ldrh	r2, [r2]	@ tmp158, value
	strh	r2, [r3]	@ tmp158, *_16
.L4:
@ DebugMap.c:45: 		for (int ix = 0; ix < x; ix++) {
	ldr	r3, [r7, #16]	@ tmp160, ix
	adds	r3, r3, #1	@ tmp159,
	str	r3, [r7, #16]	@ tmp159, ix
.L3:
@ DebugMap.c:45: 		for (int ix = 0; ix < x; ix++) {
	movs	r3, #13	@ tmp176,
	adds	r3, r7, r3	@ tmp161,, tmp176
	ldrb	r3, [r3]	@ _17, x
	ldr	r2, [r7, #16]	@ tmp162, ix
	cmp	r2, r3	@ tmp162, _17
	blt	.L7		@,
@ DebugMap.c:44: 	for (int iy = 0; iy<y; iy++) {
	ldr	r3, [r7, #20]	@ tmp164, iy
	adds	r3, r3, #1	@ tmp163,
	str	r3, [r7, #20]	@ tmp163, iy
.L2:
@ DebugMap.c:44: 	for (int iy = 0; iy<y; iy++) {
	movs	r3, #12	@ tmp177,
	adds	r3, r7, r3	@ tmp165,, tmp177
	ldrb	r3, [r3]	@ _18, y
	ldr	r2, [r7, #20]	@ tmp166, iy
	cmp	r2, r3	@ tmp166, _18
	blt	.L8		@,
@ DebugMap.c:55: 	asm("mov r11, r11");
	.syntax divided
@ 55 "DebugMap.c" 1
	mov r11, r11
@ 0 "" 2
@ DebugMap.c:57: }
	.thumb
	.syntax unified
	nop	
	mov	sp, r7	@,
	add	sp, sp, #28	@,,
	@ sp needed	@
	pop	{r4, r7}
	pop	{r0}
	bx	r0
.L10:
	.align	2
.L9:
	.word	NextRN_N
	.size	DebugMap_ASMC, .-DebugMap_ASMC
	.ident	"GCC: (devkitARM release 56) 11.1.0"
	.code 16
	.align	1
.L11:
	bx	r3
