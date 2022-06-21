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
	push	{r4, r5, r7, lr}	@
	sub	sp, sp, #32	@,,
	add	r7, sp, #8	@,,
	str	r0, [r7, #4]	@ dst, dst
@ DebugMap.c:51: 	dst[0] = (((NextRN_N(25)+10)<<8) | (NextRN_N(20)+15)); 
	movs	r0, #25	@,
	ldr	r3, .L9	@ tmp148,
	bl	.L11		@
	movs	r3, r0	@ _1,
@ DebugMap.c:51: 	dst[0] = (((NextRN_N(25)+10)<<8) | (NextRN_N(20)+15)); 
	adds	r3, r3, #10	@ _2,
@ DebugMap.c:51: 	dst[0] = (((NextRN_N(25)+10)<<8) | (NextRN_N(20)+15)); 
	lsls	r3, r3, #8	@ _3, _2,
@ DebugMap.c:51: 	dst[0] = (((NextRN_N(25)+10)<<8) | (NextRN_N(20)+15)); 
	lsls	r4, r3, #16	@ _4, _3,
	asrs	r4, r4, #16	@ _4, _4,
@ DebugMap.c:51: 	dst[0] = (((NextRN_N(25)+10)<<8) | (NextRN_N(20)+15)); 
	movs	r0, #20	@,
	ldr	r3, .L9	@ tmp149,
	bl	.L11		@
	movs	r3, r0	@ _5,
@ DebugMap.c:51: 	dst[0] = (((NextRN_N(25)+10)<<8) | (NextRN_N(20)+15)); 
	lsls	r3, r3, #16	@ tmp150, _5,
	lsrs	r3, r3, #16	@ _6, tmp150,
	adds	r3, r3, #15	@ tmp151,
	lsls	r3, r3, #16	@ tmp152, tmp151,
	lsrs	r3, r3, #16	@ _7, tmp152,
	lsls	r3, r3, #16	@ _8, _7,
	asrs	r3, r3, #16	@ _8, _8,
@ DebugMap.c:51: 	dst[0] = (((NextRN_N(25)+10)<<8) | (NextRN_N(20)+15)); 
	orrs	r3, r4	@ tmp153, _4
	lsls	r3, r3, #16	@ _9, tmp153,
	asrs	r3, r3, #16	@ _9, _9,
	lsls	r3, r3, #16	@ tmp154, _9,
	lsrs	r2, r3, #16	@ _10, tmp154,
@ DebugMap.c:51: 	dst[0] = (((NextRN_N(25)+10)<<8) | (NextRN_N(20)+15)); 
	ldr	r3, [r7, #4]	@ tmp155, dst
	strh	r2, [r3]	@ tmp156, *dst_46(D)
@ DebugMap.c:52: 	u8 x = (dst[0] & 0xFF); 
	ldr	r3, [r7, #4]	@ tmp157, dst
	ldrh	r2, [r3]	@ _11, *dst_46(D)
@ DebugMap.c:52: 	u8 x = (dst[0] & 0xFF); 
	movs	r3, #13	@ tmp204,
	adds	r3, r7, r3	@ tmp158,, tmp204
	strb	r2, [r3]	@ tmp159, x
@ DebugMap.c:53: 	u8 y = ((dst[0] & 0xFF00) >>8); // no -1 since compare as less than 
	ldr	r3, [r7, #4]	@ tmp160, dst
	ldrh	r3, [r3]	@ _12, *dst_46(D)
@ DebugMap.c:53: 	u8 y = ((dst[0] & 0xFF00) >>8); // no -1 since compare as less than 
	lsrs	r3, r3, #8	@ tmp161, _12,
	lsls	r3, r3, #16	@ tmp162, tmp161,
	lsrs	r2, r3, #16	@ _13, tmp162,
@ DebugMap.c:53: 	u8 y = ((dst[0] & 0xFF00) >>8); // no -1 since compare as less than 
	movs	r3, #12	@ tmp205,
	adds	r3, r7, r3	@ tmp163,, tmp205
	strb	r2, [r3]	@ tmp164, y
@ DebugMap.c:56: 	for (int iy = 0; iy<y; iy++) {
	movs	r3, #0	@ tmp165,
	str	r3, [r7, #20]	@ tmp165, iy
@ DebugMap.c:56: 	for (int iy = 0; iy<y; iy++) {
	b	.L2		@
.L8:
@ DebugMap.c:57: 		for (int ix = 0; ix < x; ix++) {
	movs	r3, #0	@ tmp166,
	str	r3, [r7, #16]	@ tmp166, ix
@ DebugMap.c:57: 		for (int ix = 0; ix < x; ix++) {
	b	.L3		@
.L7:
@ DebugMap.c:59: 			if (ix | iy){  // if they are both 0, then it will overwrite coordinates 
	ldr	r2, [r7, #16]	@ tmp167, ix
	ldr	r3, [r7, #20]	@ tmp168, iy
	orrs	r3, r2	@ _14, tmp167
@ DebugMap.c:59: 			if (ix | iy){  // if they are both 0, then it will overwrite coordinates 
	beq	.L4		@,
@ DebugMap.c:60: 				u16 value = 0;
	movs	r3, #14	@ tmp206,
	adds	r3, r7, r3	@ tmp169,, tmp206
	movs	r2, #0	@ tmp170,
	strh	r2, [r3]	@ tmp171, value
@ DebugMap.c:61: 				while (!value) { // never be 0 
	b	.L5		@
.L6:
@ DebugMap.c:62: 					value = NextRN_N(32) <<7 | (NextRN_N(32)<<2); // I think NextRN_N is 0-indexed, so given 4 it will return max 3 
	movs	r0, #32	@,
	ldr	r3, .L9	@ tmp172,
	bl	.L11		@
	movs	r3, r0	@ _15,
@ DebugMap.c:62: 					value = NextRN_N(32) <<7 | (NextRN_N(32)<<2); // I think NextRN_N is 0-indexed, so given 4 it will return max 3 
	lsls	r3, r3, #7	@ _16, _15,
@ DebugMap.c:62: 					value = NextRN_N(32) <<7 | (NextRN_N(32)<<2); // I think NextRN_N is 0-indexed, so given 4 it will return max 3 
	lsls	r4, r3, #16	@ _17, _16,
	asrs	r4, r4, #16	@ _17, _17,
@ DebugMap.c:62: 					value = NextRN_N(32) <<7 | (NextRN_N(32)<<2); // I think NextRN_N is 0-indexed, so given 4 it will return max 3 
	movs	r0, #32	@,
	ldr	r3, .L9	@ tmp173,
	bl	.L11		@
	movs	r3, r0	@ _18,
@ DebugMap.c:62: 					value = NextRN_N(32) <<7 | (NextRN_N(32)<<2); // I think NextRN_N is 0-indexed, so given 4 it will return max 3 
	lsls	r3, r3, #2	@ _19, _18,
@ DebugMap.c:62: 					value = NextRN_N(32) <<7 | (NextRN_N(32)<<2); // I think NextRN_N is 0-indexed, so given 4 it will return max 3 
	lsls	r3, r3, #16	@ _20, _19,
	asrs	r3, r3, #16	@ _20, _20,
	orrs	r3, r4	@ tmp174, _17
	lsls	r3, r3, #16	@ _21, tmp174,
	asrs	r3, r3, #16	@ _21, _21,
@ DebugMap.c:62: 					value = NextRN_N(32) <<7 | (NextRN_N(32)<<2); // I think NextRN_N is 0-indexed, so given 4 it will return max 3 
	movs	r2, #14	@ tmp207,
	adds	r2, r7, r2	@ tmp175,, tmp207
	strh	r3, [r2]	@ tmp176, value
.L5:
@ DebugMap.c:61: 				while (!value) { // never be 0 
	movs	r3, #14	@ tmp208,
	adds	r3, r7, r3	@ tmp177,, tmp208
	ldrh	r3, [r3]	@ tmp178, value
	cmp	r3, #0	@ tmp178,
	beq	.L6		@,
@ DebugMap.c:65: 				if (NextRN_N(5) == 0 ) { 
	movs	r0, #5	@,
	ldr	r3, .L9	@ tmp179,
	bl	.L11		@
	subs	r3, r0, #0	@ _22,,
@ DebugMap.c:65: 				if (NextRN_N(5) == 0 ) { 
	bne	.L4		@,
@ DebugMap.c:68: 					CopyMapPiece(dst, ix, iy, x, y, dst[y*x+x]);
	ldr	r3, [r7, #16]	@ tmp181, ix
	lsls	r3, r3, #24	@ tmp182, tmp180,
	lsrs	r1, r3, #24	@ _23, tmp182,
	ldr	r3, [r7, #20]	@ tmp184, iy
	lsls	r3, r3, #24	@ tmp185, tmp183,
	lsrs	r4, r3, #24	@ _24, tmp185,
@ DebugMap.c:68: 					CopyMapPiece(dst, ix, iy, x, y, dst[y*x+x]);
	movs	r5, #12	@ tmp209,
	adds	r3, r7, r5	@ tmp186,, tmp209
	ldrb	r3, [r3]	@ _25, y
	movs	r0, #13	@ tmp210,
	adds	r2, r7, r0	@ tmp187,, tmp210
	ldrb	r2, [r2]	@ _26, x
	muls	r2, r3	@ _27, _25
@ DebugMap.c:68: 					CopyMapPiece(dst, ix, iy, x, y, dst[y*x+x]);
	adds	r3, r7, r0	@ tmp188,, tmp212
	ldrb	r3, [r3]	@ _28, x
	adds	r3, r2, r3	@ _29, _27, _28
@ DebugMap.c:68: 					CopyMapPiece(dst, ix, iy, x, y, dst[y*x+x]);
	lsls	r3, r3, #1	@ _31, _30,
	ldr	r2, [r7, #4]	@ tmp189, dst
	adds	r3, r2, r3	@ _32, tmp189, _31
@ DebugMap.c:68: 					CopyMapPiece(dst, ix, iy, x, y, dst[y*x+x]);
	ldrh	r3, [r3]	@ _33, *_32
	adds	r2, r7, r0	@ tmp190,, tmp213
	ldrb	r2, [r2]	@ tmp191, x
	ldr	r0, [r7, #4]	@ tmp192, dst
	str	r3, [sp, #4]	@ _33,
	adds	r3, r7, r5	@ tmp193,, tmp214
	ldrb	r3, [r3]	@ tmp194, y
	str	r3, [sp]	@ tmp194,
	movs	r3, r2	@, tmp191
	movs	r2, r4	@, _24
	bl	CopyMapPiece		@
.L4:
@ DebugMap.c:57: 		for (int ix = 0; ix < x; ix++) {
	ldr	r3, [r7, #16]	@ tmp196, ix
	adds	r3, r3, #1	@ tmp195,
	str	r3, [r7, #16]	@ tmp195, ix
.L3:
@ DebugMap.c:57: 		for (int ix = 0; ix < x; ix++) {
	movs	r3, #13	@ tmp215,
	adds	r3, r7, r3	@ tmp197,, tmp215
	ldrb	r3, [r3]	@ _34, x
	ldr	r2, [r7, #16]	@ tmp198, ix
	cmp	r2, r3	@ tmp198, _34
	blt	.L7		@,
@ DebugMap.c:56: 	for (int iy = 0; iy<y; iy++) {
	ldr	r3, [r7, #20]	@ tmp200, iy
	adds	r3, r3, #1	@ tmp199,
	str	r3, [r7, #20]	@ tmp199, iy
.L2:
@ DebugMap.c:56: 	for (int iy = 0; iy<y; iy++) {
	movs	r3, #12	@ tmp216,
	adds	r3, r7, r3	@ tmp201,, tmp216
	ldrb	r3, [r3]	@ _35, y
	ldr	r2, [r7, #20]	@ tmp202, iy
	cmp	r2, r3	@ tmp202, _35
	blt	.L8		@,
@ DebugMap.c:73: }
	nop	
	nop	
	mov	sp, r7	@,
	add	sp, sp, #24	@,,
	@ sp needed	@
	pop	{r4, r5, r7}
	pop	{r0}
	bx	r0
.L10:
	.align	2
.L9:
	.word	NextRN_N
	.size	DebugMap_ASMC, .-DebugMap_ASMC
	.align	1
	.global	CopyMapPiece
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	CopyMapPiece, %function
CopyMapPiece:
	@ Function supports interworking.
	@ args = 8, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r7, lr}	@
	sub	sp, sp, #28	@,,
	add	r7, sp, #0	@,,
	str	r0, [r7, #4]	@ dst, dst
	movs	r4, r1	@ tmp164, xx
	movs	r0, r2	@ tmp167, yy
	movs	r1, r3	@ tmp170, real_x_max_size
	adds	r3, r7, #3	@ tmp165,,
	adds	r2, r4, #0	@ tmp166, tmp164
	strb	r2, [r3]	@ tmp166, xx
	adds	r3, r7, #2	@ tmp168,,
	adds	r2, r0, #0	@ tmp169, tmp167
	strb	r2, [r3]	@ tmp169, yy
	adds	r3, r7, #1	@ tmp171,,
	adds	r2, r1, #0	@ tmp172, tmp170
	strb	r2, [r3]	@ tmp172, real_x_max_size
@ DebugMap.c:77: 	struct MapPieces_Struct* T = MapPiecesTable[NextRN_N(NumberOfMapPieces)];
	ldr	r3, .L24	@ tmp173,
	ldr	r3, [r3]	@ NumberOfMapPieces.0_1, NumberOfMapPieces
	movs	r0, r3	@, NumberOfMapPieces.0_1
	ldr	r3, .L24+4	@ tmp174,
	bl	.L11		@
	movs	r2, r0	@ _2,
@ DebugMap.c:77: 	struct MapPieces_Struct* T = MapPiecesTable[NextRN_N(NumberOfMapPieces)];
	ldr	r3, .L24+8	@ tmp175,
	lsls	r2, r2, #2	@ tmp176, _2,
	ldr	r3, [r2, r3]	@ tmp177, MapPiecesTable[_2]
	str	r3, [r7, #12]	@ tmp177, T
@ DebugMap.c:78: 	u8 size_x = T->x;
	movs	r3, #11	@ tmp276,
	adds	r3, r7, r3	@ tmp178,, tmp276
	ldr	r2, [r7, #12]	@ tmp179, T
	ldrb	r2, [r2]	@ tmp180, *T_64
	strb	r2, [r3]	@ tmp180, size_x
@ DebugMap.c:79: 	u8 size_y = T->y;
	movs	r3, #10	@ tmp277,
	adds	r3, r7, r3	@ tmp181,, tmp277
	ldr	r2, [r7, #12]	@ tmp182, T
	ldrb	r2, [r2, #1]	@ tmp183,
	strb	r2, [r3]	@ tmp183, size_y
@ DebugMap.c:80: 	u8 exit = false; // false 
	movs	r3, #23	@ tmp278,
	adds	r3, r7, r3	@ tmp184,, tmp278
	movs	r2, #0	@ tmp185,
	strb	r2, [r3]	@ tmp186, exit
@ DebugMap.c:83: 	for (u8 y = 0; y<size_y; y++) {
	movs	r3, #22	@ tmp279,
	adds	r3, r7, r3	@ tmp187,, tmp279
	movs	r2, #0	@ tmp188,
	strb	r2, [r3]	@ tmp189, y
@ DebugMap.c:83: 	for (u8 y = 0; y<size_y; y++) {
	b	.L13		@
.L17:
@ DebugMap.c:84: 		for (u8 x = 0; x < size_x; x++) { // if any tile is not the default, then immediately exit 
	movs	r3, #21	@ tmp280,
	adds	r3, r7, r3	@ tmp190,, tmp280
	movs	r2, #0	@ tmp191,
	strb	r2, [r3]	@ tmp192, x
@ DebugMap.c:84: 		for (u8 x = 0; x < size_x; x++) { // if any tile is not the default, then immediately exit 
	b	.L14		@
.L16:
@ DebugMap.c:85: 			if (!(dst[((yy+y) * real_x_max_size) + xx+x] == defaultTile)) { exit = true; } 
	adds	r3, r7, #2	@ tmp193,,
	ldrb	r2, [r3]	@ _3, yy
	movs	r3, #22	@ tmp281,
	adds	r3, r7, r3	@ tmp194,, tmp281
	ldrb	r3, [r3]	@ _4, y
	adds	r3, r2, r3	@ _5, _3, _4
@ DebugMap.c:85: 			if (!(dst[((yy+y) * real_x_max_size) + xx+x] == defaultTile)) { exit = true; } 
	adds	r2, r7, #1	@ tmp195,,
	ldrb	r2, [r2]	@ _6, real_x_max_size
	muls	r2, r3	@ _7, _5
@ DebugMap.c:85: 			if (!(dst[((yy+y) * real_x_max_size) + xx+x] == defaultTile)) { exit = true; } 
	adds	r3, r7, #3	@ tmp196,,
	ldrb	r3, [r3]	@ _8, xx
	adds	r2, r2, r3	@ _9, _7, _8
@ DebugMap.c:85: 			if (!(dst[((yy+y) * real_x_max_size) + xx+x] == defaultTile)) { exit = true; } 
	movs	r3, #21	@ tmp283,
	adds	r3, r7, r3	@ tmp197,, tmp283
	ldrb	r3, [r3]	@ _10, x
	adds	r3, r2, r3	@ _11, _9, _10
@ DebugMap.c:85: 			if (!(dst[((yy+y) * real_x_max_size) + xx+x] == defaultTile)) { exit = true; } 
	lsls	r3, r3, #1	@ _13, _12,
	ldr	r2, [r7, #4]	@ tmp198, dst
	adds	r3, r2, r3	@ _14, tmp198, _13
	ldrh	r3, [r3]	@ _15, *_14
@ DebugMap.c:85: 			if (!(dst[((yy+y) * real_x_max_size) + xx+x] == defaultTile)) { exit = true; } 
	movs	r2, #44	@ tmp284,
	adds	r2, r7, r2	@ tmp199,, tmp284
	ldrh	r2, [r2]	@ tmp200, defaultTile
	cmp	r2, r3	@ tmp200, _15
	beq	.L15		@,
@ DebugMap.c:85: 			if (!(dst[((yy+y) * real_x_max_size) + xx+x] == defaultTile)) { exit = true; } 
	movs	r3, #23	@ tmp285,
	adds	r3, r7, r3	@ tmp201,, tmp285
	movs	r2, #1	@ tmp202,
	strb	r2, [r3]	@ tmp203, exit
.L15:
@ DebugMap.c:84: 		for (u8 x = 0; x < size_x; x++) { // if any tile is not the default, then immediately exit 
	movs	r1, #21	@ tmp286,
	adds	r3, r7, r1	@ tmp204,, tmp286
	ldrb	r2, [r3]	@ x.1_16, x
	adds	r3, r7, r1	@ tmp205,, tmp287
	adds	r2, r2, #1	@ tmp206,
	strb	r2, [r3]	@ tmp207, x
.L14:
@ DebugMap.c:84: 		for (u8 x = 0; x < size_x; x++) { // if any tile is not the default, then immediately exit 
	movs	r3, #21	@ tmp288,
	adds	r2, r7, r3	@ tmp208,, tmp288
	movs	r3, #11	@ tmp289,
	adds	r3, r7, r3	@ tmp209,, tmp289
	ldrb	r2, [r2]	@ tmp210, x
	ldrb	r3, [r3]	@ tmp211, size_x
	cmp	r2, r3	@ tmp210, tmp211
	bcc	.L16		@,
@ DebugMap.c:83: 	for (u8 y = 0; y<size_y; y++) {
	movs	r1, #22	@ tmp290,
	adds	r3, r7, r1	@ tmp212,, tmp290
	ldrb	r2, [r3]	@ y.2_17, y
	adds	r3, r7, r1	@ tmp213,, tmp291
	adds	r2, r2, #1	@ tmp214,
	strb	r2, [r3]	@ tmp215, y
.L13:
@ DebugMap.c:83: 	for (u8 y = 0; y<size_y; y++) {
	movs	r3, #22	@ tmp292,
	adds	r2, r7, r3	@ tmp216,, tmp292
	movs	r4, #10	@ tmp293,
	adds	r3, r7, r4	@ tmp217,, tmp293
	ldrb	r2, [r2]	@ tmp218, y
	ldrb	r3, [r3]	@ tmp219, size_y
	cmp	r2, r3	@ tmp218, tmp219
	bcc	.L17		@,
@ DebugMap.c:90: 	if (!((size_x + xx >= real_x_max_size) | (size_y + yy >= real_y_max_size) | (exit)))  { 
	movs	r3, #11	@ tmp294,
	adds	r3, r7, r3	@ tmp220,, tmp294
	ldrb	r2, [r3]	@ _18, size_x
	adds	r3, r7, #3	@ tmp221,,
	ldrb	r3, [r3]	@ _19, xx
	adds	r2, r2, r3	@ _20, _18, _19
@ DebugMap.c:90: 	if (!((size_x + xx >= real_x_max_size) | (size_y + yy >= real_y_max_size) | (exit)))  { 
	adds	r3, r7, #1	@ tmp222,,
	ldrb	r3, [r3]	@ _21, real_x_max_size
	asrs	r0, r2, #31	@ tmp225, _20,
	lsrs	r1, r3, #31	@ tmp226, _21,
	cmp	r2, r3	@ _20, _21
	adcs	r0, r0, r1	@ tmp225, tmp225, tmp226
	movs	r3, r0	@ tmp224, tmp225
	lsls	r3, r3, #24	@ tmp227, tmp223,
	lsrs	r1, r3, #24	@ _22, tmp227,
@ DebugMap.c:90: 	if (!((size_x + xx >= real_x_max_size) | (size_y + yy >= real_y_max_size) | (exit)))  { 
	adds	r3, r7, r4	@ tmp228,, tmp296
	ldrb	r2, [r3]	@ _23, size_y
	adds	r3, r7, #2	@ tmp229,,
	ldrb	r3, [r3]	@ _24, yy
	adds	r2, r2, r3	@ _25, _23, _24
@ DebugMap.c:90: 	if (!((size_x + xx >= real_x_max_size) | (size_y + yy >= real_y_max_size) | (exit)))  { 
	movs	r3, #40	@ tmp297,
	adds	r3, r7, r3	@ tmp230,, tmp297
	ldrb	r3, [r3]	@ _26, real_y_max_size
	asrs	r4, r2, #31	@ tmp233, _25,
	lsrs	r0, r3, #31	@ tmp234, _26,
	cmp	r2, r3	@ _25, _26
	adcs	r4, r4, r0	@ tmp233, tmp233, tmp234
	movs	r3, r4	@ tmp232, tmp233
	lsls	r3, r3, #24	@ tmp235, tmp231,
	lsrs	r3, r3, #24	@ _27, tmp235,
	orrs	r3, r1	@ tmp236, _22
	lsls	r3, r3, #24	@ tmp237, tmp236,
	lsrs	r3, r3, #24	@ _28, tmp237,
	movs	r2, r3	@ _29, _28
@ DebugMap.c:90: 	if (!((size_x + xx >= real_x_max_size) | (size_y + yy >= real_y_max_size) | (exit)))  { 
	movs	r3, #23	@ tmp299,
	adds	r3, r7, r3	@ tmp238,, tmp299
	ldrb	r3, [r3]	@ _30, exit
	orrs	r3, r2	@ _31, _29
@ DebugMap.c:90: 	if (!((size_x + xx >= real_x_max_size) | (size_y + yy >= real_y_max_size) | (exit)))  { 
	bne	.L23		@,
@ DebugMap.c:91: 		for (u8 y = 0; y<size_y; y++) {
	movs	r3, #20	@ tmp300,
	adds	r3, r7, r3	@ tmp239,, tmp300
	movs	r2, #0	@ tmp240,
	strb	r2, [r3]	@ tmp241, y
@ DebugMap.c:91: 		for (u8 y = 0; y<size_y; y++) {
	b	.L19		@
.L22:
@ DebugMap.c:92: 			for (u8 x = 0; x < size_x; x++) {
	movs	r3, #19	@ tmp301,
	adds	r3, r7, r3	@ tmp242,, tmp301
	movs	r2, #0	@ tmp243,
	strb	r2, [r3]	@ tmp244, x
@ DebugMap.c:92: 			for (u8 x = 0; x < size_x; x++) {
	b	.L20		@
.L21:
@ DebugMap.c:93: 				dst[((yy+y) * real_x_max_size) + xx+x] = T->data[y*size_x+x]; 
	movs	r4, #20	@ tmp302,
	adds	r3, r7, r4	@ tmp245,, tmp302
	ldrb	r3, [r3]	@ _32, y
	movs	r2, #11	@ tmp303,
	adds	r2, r7, r2	@ tmp246,, tmp303
	ldrb	r2, [r2]	@ _33, size_x
	muls	r2, r3	@ _34, _32
@ DebugMap.c:93: 				dst[((yy+y) * real_x_max_size) + xx+x] = T->data[y*size_x+x]; 
	movs	r0, #19	@ tmp305,
	adds	r3, r7, r0	@ tmp247,, tmp305
	ldrb	r3, [r3]	@ _35, x
	adds	r2, r2, r3	@ _36, _34, _35
@ DebugMap.c:93: 				dst[((yy+y) * real_x_max_size) + xx+x] = T->data[y*size_x+x]; 
	adds	r3, r7, #2	@ tmp248,,
	ldrb	r1, [r3]	@ _37, yy
	adds	r3, r7, r4	@ tmp249,, tmp306
	ldrb	r3, [r3]	@ _38, y
	adds	r3, r1, r3	@ _39, _37, _38
@ DebugMap.c:93: 				dst[((yy+y) * real_x_max_size) + xx+x] = T->data[y*size_x+x]; 
	adds	r1, r7, #1	@ tmp250,,
	ldrb	r1, [r1]	@ _40, real_x_max_size
	muls	r1, r3	@ _41, _39
@ DebugMap.c:93: 				dst[((yy+y) * real_x_max_size) + xx+x] = T->data[y*size_x+x]; 
	adds	r3, r7, #3	@ tmp251,,
	ldrb	r3, [r3]	@ _42, xx
	adds	r1, r1, r3	@ _43, _41, _42
@ DebugMap.c:93: 				dst[((yy+y) * real_x_max_size) + xx+x] = T->data[y*size_x+x]; 
	adds	r3, r7, r0	@ tmp252,, tmp308
	ldrb	r3, [r3]	@ _44, x
	adds	r3, r1, r3	@ _45, _43, _44
@ DebugMap.c:93: 				dst[((yy+y) * real_x_max_size) + xx+x] = T->data[y*size_x+x]; 
	lsls	r3, r3, #1	@ _47, _46,
	ldr	r1, [r7, #4]	@ tmp253, dst
	adds	r3, r1, r3	@ _48, tmp253, _47
@ DebugMap.c:93: 				dst[((yy+y) * real_x_max_size) + xx+x] = T->data[y*size_x+x]; 
	ldr	r1, [r7, #12]	@ tmp254, T
	lsls	r2, r2, #1	@ tmp255, _36,
	adds	r2, r1, r2	@ tmp256, tmp254, tmp255
	adds	r2, r2, #2	@ tmp257,
	ldrh	r2, [r2]	@ _49, *T_64
@ DebugMap.c:93: 				dst[((yy+y) * real_x_max_size) + xx+x] = T->data[y*size_x+x]; 
	strh	r2, [r3]	@ tmp258, *_48
@ DebugMap.c:92: 			for (u8 x = 0; x < size_x; x++) {
	adds	r3, r7, r0	@ tmp259,, tmp309
	ldrb	r2, [r3]	@ x.3_50, x
	adds	r3, r7, r0	@ tmp260,, tmp310
	adds	r2, r2, #1	@ tmp261,
	strb	r2, [r3]	@ tmp262, x
.L20:
@ DebugMap.c:92: 			for (u8 x = 0; x < size_x; x++) {
	movs	r3, #19	@ tmp311,
	adds	r2, r7, r3	@ tmp263,, tmp311
	movs	r3, #11	@ tmp312,
	adds	r3, r7, r3	@ tmp264,, tmp312
	ldrb	r2, [r2]	@ tmp265, x
	ldrb	r3, [r3]	@ tmp266, size_x
	cmp	r2, r3	@ tmp265, tmp266
	bcc	.L21		@,
@ DebugMap.c:91: 		for (u8 y = 0; y<size_y; y++) {
	movs	r1, #20	@ tmp313,
	adds	r3, r7, r1	@ tmp267,, tmp313
	ldrb	r2, [r3]	@ y.4_51, y
	adds	r3, r7, r1	@ tmp268,, tmp314
	adds	r2, r2, #1	@ tmp269,
	strb	r2, [r3]	@ tmp270, y
.L19:
@ DebugMap.c:91: 		for (u8 y = 0; y<size_y; y++) {
	movs	r3, #20	@ tmp315,
	adds	r2, r7, r3	@ tmp271,, tmp315
	movs	r3, #10	@ tmp316,
	adds	r3, r7, r3	@ tmp272,, tmp316
	ldrb	r2, [r2]	@ tmp273, y
	ldrb	r3, [r3]	@ tmp274, size_y
	cmp	r2, r3	@ tmp273, tmp274
	bcc	.L22		@,
.L23:
@ DebugMap.c:98: }
	nop	
	mov	sp, r7	@,
	add	sp, sp, #28	@,,
	@ sp needed	@
	pop	{r4, r7}
	pop	{r0}
	bx	r0
.L25:
	.align	2
.L24:
	.word	NumberOfMapPieces
	.word	NextRN_N
	.word	MapPiecesTable
	.size	CopyMapPiece, .-CopyMapPiece
	.ident	"GCC: (devkitARM release 56) 11.1.0"
	.code 16
	.align	1
.L11:
	bx	r3
