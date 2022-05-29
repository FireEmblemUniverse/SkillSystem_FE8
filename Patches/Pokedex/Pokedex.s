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
	.file	"Pokedex.c"
@ GNU C17 (devkitARM release 56) version 11.1.0 (arm-none-eabi)
@	compiled by GNU C version 10.3.0, GMP version 6.2.1, MPFR version 4.1.0, MPC version 1.2.1, isl version isl-0.18-GMP

@ GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
@ options passed: -mcpu=arm7tdmi -mthumb -mthumb-interwork -mtune=arm7tdmi -mlong-calls -march=armv4t
	.text
	.section	.rodata
	.align	2
	.type	Proc_ChapterPokedex, %object
	.size	Proc_ChapterPokedex, 48
Proc_ChapterPokedex:
@ type:
	.short	2
@ sArg:
	.short	0
@ lArg:
	.word	LockGameLogic
@ type:
	.short	2
@ sArg:
	.short	0
@ lArg:
	.word	LockGameGraphicsLogic
@ type:
	.short	14
@ sArg:
	.short	0
@ lArg:
	.word	0
@ type:
	.short	2
@ sArg:
	.short	0
@ lArg:
	.word	UnlockGameLogic
@ type:
	.short	2
@ sArg:
	.short	0
@ lArg:
	.word	UnlockGameGraphicsLogic
@ type:
	.short	0
@ sArg:
	.short	0
@ lArg:
	.word	0
	.align	2
	.type	MenuCommands_Pokedex, %object
	.size	MenuCommands_Pokedex, 72
MenuCommands_Pokedex:
@ isAvailable:
	.space	12
	.word	MenuCommandAlwaysUsable
@ onDraw:
	.word	PokedexDraw
@ onEffect:
	.word	CallPokedexMenuEnd
@ onIdle:
	.word	PokedexIdle
	.space	8
	.space	36
	.align	2
	.type	Menu_Pokedex, %object
	.size	Menu_Pokedex, 36
Menu_Pokedex:
@ geometry:
@ x:
	.byte	20
@ y:
	.byte	10
@ h:
	.byte	10
	.space	1
@ commandList:
	.space	4
	.word	MenuCommands_Pokedex
@ onBPress:
	.space	12
	.word	PokedexMenuEnd
	.space	8
	.text
	.align	1
	.arch armv4t
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	PokedexIdle, %function
PokedexIdle:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 40
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r7, lr}	@
	sub	sp, sp, #52	@,,
	add	r7, sp, #8	@,,
	str	r0, [r7, #4]	@ menu, menu
	str	r1, [r7]	@ command, command
@ Pokedex.c:124:     struct PokedexProc* const proc = (void*) menu->parent;
	ldr	r3, [r7, #4]	@ tmp214, menu
	ldr	r3, [r3, #20]	@ tmp215, menu_139(D)->parent
	str	r3, [r7, #16]	@ tmp215, proc
@ Pokedex.c:127:     if (gKeyState.repeatedKeys & KEY_DPAD_LEFT) {
	ldr	r3, .L40	@ tmp216,
	ldrh	r3, [r3, #6]	@ _1,
@ Pokedex.c:127:     if (gKeyState.repeatedKeys & KEY_DPAD_LEFT) {
	movs	r2, r3	@ _2, _1
	movs	r3, #32	@ tmp217,
	ands	r3, r2	@ _3, _2
@ Pokedex.c:127:     if (gKeyState.repeatedKeys & KEY_DPAD_LEFT) {
	beq	.L2		@,
@ Pokedex.c:128:         if (proc->menuIndex < 0xFF) { proc->menuIndex--; }
	ldr	r3, [r7, #16]	@ tmp218, proc
	movs	r2, #48	@ tmp219,
	ldrb	r3, [r3, r2]	@ _4,
@ Pokedex.c:128:         if (proc->menuIndex < 0xFF) { proc->menuIndex--; }
	cmp	r3, #255	@ _4,
	beq	.L4		@,
@ Pokedex.c:128:         if (proc->menuIndex < 0xFF) { proc->menuIndex--; }
	ldr	r3, [r7, #16]	@ tmp220, proc
	movs	r2, #48	@ tmp221,
	ldrb	r3, [r3, r2]	@ _5,
@ Pokedex.c:128:         if (proc->menuIndex < 0xFF) { proc->menuIndex--; }
	subs	r3, r3, #1	@ tmp222,
	lsls	r3, r3, #24	@ tmp223, tmp222,
	lsrs	r1, r3, #24	@ _7, tmp223,
	ldr	r3, [r7, #16]	@ tmp224, proc
	movs	r2, #48	@ tmp225,
	strb	r1, [r3, r2]	@ tmp226, proc_140->menuIndex
@ Pokedex.c:129: 		while (!PokedexTable[proc->menuIndex].IndexNumber)
	b	.L4		@
.L6:
@ Pokedex.c:131: 			if (proc->menuIndex > 1) 
	ldr	r3, [r7, #16]	@ tmp227, proc
	movs	r2, #48	@ tmp228,
	ldrb	r3, [r3, r2]	@ _8,
@ Pokedex.c:131: 			if (proc->menuIndex > 1) 
	cmp	r3, #1	@ _8,
	bls	.L5		@,
@ Pokedex.c:133: 				proc->menuIndex--;
	ldr	r3, [r7, #16]	@ tmp231, proc
	movs	r2, #48	@ tmp232,
	ldrb	r3, [r3, r2]	@ _9,
@ Pokedex.c:133: 				proc->menuIndex--;
	subs	r3, r3, #1	@ tmp233,
	lsls	r3, r3, #24	@ tmp234, tmp233,
	lsrs	r1, r3, #24	@ _11, tmp234,
	ldr	r3, [r7, #16]	@ tmp235, proc
	movs	r2, #48	@ tmp236,
	strb	r1, [r3, r2]	@ tmp237, proc_140->menuIndex
	b	.L4		@
.L5:
@ Pokedex.c:135: 			else { proc->menuIndex = 0xFF; }
	ldr	r3, [r7, #16]	@ tmp238, proc
	movs	r2, #48	@ tmp239,
	movs	r1, #255	@ tmp240,
	strb	r1, [r3, r2]	@ tmp241, proc_140->menuIndex
.L4:
@ Pokedex.c:129: 		while (!PokedexTable[proc->menuIndex].IndexNumber)
	ldr	r3, [r7, #16]	@ tmp242, proc
	movs	r2, #48	@ tmp243,
	ldrb	r3, [r3, r2]	@ _12,
	movs	r2, r3	@ _13, _12
@ Pokedex.c:129: 		while (!PokedexTable[proc->menuIndex].IndexNumber)
	ldr	r3, .L40+4	@ tmp244,
	lsls	r2, r2, #2	@ tmp245, _13,
	ldrb	r3, [r2, r3]	@ _14, PokedexTable
@ Pokedex.c:129: 		while (!PokedexTable[proc->menuIndex].IndexNumber)
	cmp	r3, #0	@ _14,
	beq	.L6		@,
@ Pokedex.c:137: 		PokedexDraw(menu, command);
	ldr	r2, [r7]	@ tmp246, command
	ldr	r3, [r7, #4]	@ tmp247, menu
	movs	r1, r2	@, tmp246
	movs	r0, r3	@, tmp247
	bl	PokedexDraw		@
@ Pokedex.c:138: 		PlaySfx(0x6B);
	ldr	r3, .L40+8	@ tmp248,
	movs	r2, #65	@ tmp249,
	ldrb	r3, [r3, r2]	@ _15, gChapterData
	movs	r2, #2	@ tmp251,
	ands	r3, r2	@ tmp250, tmp251
	lsls	r3, r3, #24	@ tmp252, tmp250,
	lsrs	r3, r3, #24	@ _16, tmp252,
	bne	.L2		@,
@ Pokedex.c:138: 		PlaySfx(0x6B);
	movs	r0, #107	@,
	ldr	r3, .L40+12	@ tmp253,
	bl	.L44		@
.L2:
@ Pokedex.c:141:     if (gKeyState.repeatedKeys & KEY_DPAD_RIGHT) {
	ldr	r3, .L40	@ tmp254,
	ldrh	r3, [r3, #6]	@ _17,
@ Pokedex.c:141:     if (gKeyState.repeatedKeys & KEY_DPAD_RIGHT) {
	movs	r2, r3	@ _18, _17
	movs	r3, #16	@ tmp255,
	ands	r3, r2	@ _19, _18
@ Pokedex.c:141:     if (gKeyState.repeatedKeys & KEY_DPAD_RIGHT) {
	beq	.L7		@,
@ Pokedex.c:142:         if (proc->menuIndex < 0xFF) { proc->menuIndex++; }
	ldr	r3, [r7, #16]	@ tmp256, proc
	movs	r2, #48	@ tmp257,
	ldrb	r3, [r3, r2]	@ _20,
@ Pokedex.c:142:         if (proc->menuIndex < 0xFF) { proc->menuIndex++; }
	cmp	r3, #255	@ _20,
	beq	.L9		@,
@ Pokedex.c:142:         if (proc->menuIndex < 0xFF) { proc->menuIndex++; }
	ldr	r3, [r7, #16]	@ tmp258, proc
	movs	r2, #48	@ tmp259,
	ldrb	r3, [r3, r2]	@ _21,
@ Pokedex.c:142:         if (proc->menuIndex < 0xFF) { proc->menuIndex++; }
	adds	r3, r3, #1	@ tmp260,
	lsls	r3, r3, #24	@ tmp261, tmp260,
	lsrs	r1, r3, #24	@ _23, tmp261,
	ldr	r3, [r7, #16]	@ tmp262, proc
	movs	r2, #48	@ tmp263,
	strb	r1, [r3, r2]	@ tmp264, proc_140->menuIndex
@ Pokedex.c:143: 		while (!PokedexTable[proc->menuIndex].IndexNumber)
	b	.L9		@
.L11:
@ Pokedex.c:145: 			if (proc->menuIndex < 0xFF) 
	ldr	r3, [r7, #16]	@ tmp265, proc
	movs	r2, #48	@ tmp266,
	ldrb	r3, [r3, r2]	@ _24,
@ Pokedex.c:145: 			if (proc->menuIndex < 0xFF) 
	cmp	r3, #255	@ _24,
	beq	.L10		@,
@ Pokedex.c:147: 				proc->menuIndex++;
	ldr	r3, [r7, #16]	@ tmp267, proc
	movs	r2, #48	@ tmp268,
	ldrb	r3, [r3, r2]	@ _25,
@ Pokedex.c:147: 				proc->menuIndex++;
	adds	r3, r3, #1	@ tmp269,
	lsls	r3, r3, #24	@ tmp270, tmp269,
	lsrs	r1, r3, #24	@ _27, tmp270,
	ldr	r3, [r7, #16]	@ tmp271, proc
	movs	r2, #48	@ tmp272,
	strb	r1, [r3, r2]	@ tmp273, proc_140->menuIndex
	b	.L9		@
.L10:
@ Pokedex.c:149: 			else { proc->menuIndex = 1; }
	ldr	r3, [r7, #16]	@ tmp274, proc
	movs	r2, #48	@ tmp275,
	movs	r1, #1	@ tmp276,
	strb	r1, [r3, r2]	@ tmp277, proc_140->menuIndex
.L9:
@ Pokedex.c:143: 		while (!PokedexTable[proc->menuIndex].IndexNumber)
	ldr	r3, [r7, #16]	@ tmp278, proc
	movs	r2, #48	@ tmp279,
	ldrb	r3, [r3, r2]	@ _28,
	movs	r2, r3	@ _29, _28
@ Pokedex.c:143: 		while (!PokedexTable[proc->menuIndex].IndexNumber)
	ldr	r3, .L40+4	@ tmp280,
	lsls	r2, r2, #2	@ tmp281, _29,
	ldrb	r3, [r2, r3]	@ _30, PokedexTable
@ Pokedex.c:143: 		while (!PokedexTable[proc->menuIndex].IndexNumber)
	cmp	r3, #0	@ _30,
	beq	.L11		@,
@ Pokedex.c:151: 		PokedexDraw(menu, command);
	ldr	r2, [r7]	@ tmp282, command
	ldr	r3, [r7, #4]	@ tmp283, menu
	movs	r1, r2	@, tmp282
	movs	r0, r3	@, tmp283
	bl	PokedexDraw		@
@ Pokedex.c:152: 		PlaySfx(0x6B);
	ldr	r3, .L40+8	@ tmp284,
	movs	r2, #65	@ tmp285,
	ldrb	r3, [r3, r2]	@ _31, gChapterData
	movs	r2, #2	@ tmp287,
	ands	r3, r2	@ tmp286, tmp287
	lsls	r3, r3, #24	@ tmp288, tmp286,
	lsrs	r3, r3, #24	@ _32, tmp288,
	bne	.L7		@,
@ Pokedex.c:152: 		PlaySfx(0x6B);
	movs	r0, #107	@,
	ldr	r3, .L40+12	@ tmp289,
	bl	.L44		@
.L7:
@ Pokedex.c:154:     if (gKeyState.repeatedKeys & KEY_DPAD_UP) {
	ldr	r3, .L40	@ tmp290,
	ldrh	r3, [r3, #6]	@ _33,
@ Pokedex.c:154:     if (gKeyState.repeatedKeys & KEY_DPAD_UP) {
	movs	r2, r3	@ _34, _33
	movs	r3, #64	@ tmp291,
	ands	r3, r2	@ _35, _34
@ Pokedex.c:154:     if (gKeyState.repeatedKeys & KEY_DPAD_UP) {
	beq	.L12		@,
@ Pokedex.c:155: 		u8 c = 0;
	movs	r3, #39	@ tmp542,
	adds	r3, r7, r3	@ tmp292,, tmp542
	movs	r2, #0	@ tmp293,
	strb	r2, [r3]	@ tmp294, c
@ Pokedex.c:156: 		while (c<10) {
	b	.L13		@
.L16:
@ Pokedex.c:157: 			if (proc->menuIndex > 1) 
	ldr	r3, [r7, #16]	@ tmp295, proc
	movs	r2, #48	@ tmp296,
	ldrb	r3, [r3, r2]	@ _36,
@ Pokedex.c:157: 			if (proc->menuIndex > 1) 
	cmp	r3, #1	@ _36,
	bls	.L14		@,
@ Pokedex.c:159: 					proc->menuIndex--;
	ldr	r3, [r7, #16]	@ tmp299, proc
	movs	r2, #48	@ tmp300,
	ldrb	r3, [r3, r2]	@ _37,
@ Pokedex.c:159: 					proc->menuIndex--;
	subs	r3, r3, #1	@ tmp301,
	lsls	r3, r3, #24	@ tmp302, tmp301,
	lsrs	r1, r3, #24	@ _39, tmp302,
	ldr	r3, [r7, #16]	@ tmp303, proc
	movs	r2, #48	@ tmp304,
	strb	r1, [r3, r2]	@ tmp305, proc_140->menuIndex
	b	.L15		@
.L14:
@ Pokedex.c:161: 			else { proc->menuIndex = 0xFF; }
	ldr	r3, [r7, #16]	@ tmp306, proc
	movs	r2, #48	@ tmp307,
	movs	r1, #255	@ tmp308,
	strb	r1, [r3, r2]	@ tmp309, proc_140->menuIndex
.L15:
@ Pokedex.c:163: 			if (PokedexTable[proc->menuIndex].IndexNumber) { c++; } 
	ldr	r3, [r7, #16]	@ tmp310, proc
	movs	r2, #48	@ tmp311,
	ldrb	r3, [r3, r2]	@ _40,
	movs	r2, r3	@ _41, _40
@ Pokedex.c:163: 			if (PokedexTable[proc->menuIndex].IndexNumber) { c++; } 
	ldr	r3, .L40+4	@ tmp312,
	lsls	r2, r2, #2	@ tmp313, _41,
	ldrb	r3, [r2, r3]	@ _42, PokedexTable
	movs	r0, #39	@ tmp543,
	adds	r2, r7, r0	@ tmp314,, tmp543
	adds	r1, r7, r0	@ tmp315,, tmp544
	ldrb	r1, [r1]	@ tmp316, c
	strb	r1, [r2]	@ tmp316, c
@ Pokedex.c:163: 			if (PokedexTable[proc->menuIndex].IndexNumber) { c++; } 
	cmp	r3, #0	@ _42,
	beq	.L13		@,
@ Pokedex.c:163: 			if (PokedexTable[proc->menuIndex].IndexNumber) { c++; } 
	movs	r1, r0	@ tmp545, tmp544
	adds	r3, r7, r1	@ tmp317,, tmp545
	ldrb	r2, [r3]	@ c.0_43, c
	adds	r3, r7, r1	@ tmp318,, tmp546
	adds	r2, r2, #1	@ tmp319,
	strb	r2, [r3]	@ tmp320, c
.L13:
@ Pokedex.c:156: 		while (c<10) {
	movs	r3, #39	@ tmp547,
	adds	r3, r7, r3	@ tmp321,, tmp547
	ldrb	r3, [r3]	@ tmp324, c
	cmp	r3, #9	@ tmp324,
	bls	.L16		@,
@ Pokedex.c:165: 		PokedexDraw(menu, command);
	ldr	r2, [r7]	@ tmp325, command
	ldr	r3, [r7, #4]	@ tmp326, menu
	movs	r1, r2	@, tmp325
	movs	r0, r3	@, tmp326
	bl	PokedexDraw		@
@ Pokedex.c:166: 		PlaySfx(0x6B);
	ldr	r3, .L40+8	@ tmp327,
	movs	r2, #65	@ tmp328,
	ldrb	r3, [r3, r2]	@ _44, gChapterData
	movs	r2, #2	@ tmp330,
	ands	r3, r2	@ tmp329, tmp330
	lsls	r3, r3, #24	@ tmp331, tmp329,
	lsrs	r3, r3, #24	@ _45, tmp331,
	bne	.L12		@,
@ Pokedex.c:166: 		PlaySfx(0x6B);
	movs	r0, #107	@,
	ldr	r3, .L40+12	@ tmp332,
	bl	.L44		@
.L12:
@ Pokedex.c:168:     if (gKeyState.repeatedKeys & KEY_DPAD_DOWN) {
	ldr	r3, .L40	@ tmp333,
	ldrh	r3, [r3, #6]	@ _46,
@ Pokedex.c:168:     if (gKeyState.repeatedKeys & KEY_DPAD_DOWN) {
	movs	r2, r3	@ _47, _46
	movs	r3, #128	@ tmp334,
	ands	r3, r2	@ _48, _47
@ Pokedex.c:168:     if (gKeyState.repeatedKeys & KEY_DPAD_DOWN) {
	beq	.L17		@,
@ Pokedex.c:169: 		u8 c = 0;
	movs	r3, #38	@ tmp548,
	adds	r3, r7, r3	@ tmp335,, tmp548
	movs	r2, #0	@ tmp336,
	strb	r2, [r3]	@ tmp337, c
@ Pokedex.c:170: 		while (c<10) {
	b	.L18		@
.L21:
@ Pokedex.c:171: 			if (proc->menuIndex < 0xFF) 
	ldr	r3, [r7, #16]	@ tmp338, proc
	movs	r2, #48	@ tmp339,
	ldrb	r3, [r3, r2]	@ _49,
@ Pokedex.c:171: 			if (proc->menuIndex < 0xFF) 
	cmp	r3, #255	@ _49,
	beq	.L19		@,
@ Pokedex.c:173: 					proc->menuIndex++;
	ldr	r3, [r7, #16]	@ tmp340, proc
	movs	r2, #48	@ tmp341,
	ldrb	r3, [r3, r2]	@ _50,
@ Pokedex.c:173: 					proc->menuIndex++;
	adds	r3, r3, #1	@ tmp342,
	lsls	r3, r3, #24	@ tmp343, tmp342,
	lsrs	r1, r3, #24	@ _52, tmp343,
	ldr	r3, [r7, #16]	@ tmp344, proc
	movs	r2, #48	@ tmp345,
	strb	r1, [r3, r2]	@ tmp346, proc_140->menuIndex
	b	.L20		@
.L19:
@ Pokedex.c:175: 			else { proc->menuIndex = 1; }
	ldr	r3, [r7, #16]	@ tmp347, proc
	movs	r2, #48	@ tmp348,
	movs	r1, #1	@ tmp349,
	strb	r1, [r3, r2]	@ tmp350, proc_140->menuIndex
.L20:
@ Pokedex.c:177: 			if (PokedexTable[proc->menuIndex].IndexNumber) { c++; } 
	ldr	r3, [r7, #16]	@ tmp351, proc
	movs	r2, #48	@ tmp352,
	ldrb	r3, [r3, r2]	@ _53,
	movs	r2, r3	@ _54, _53
@ Pokedex.c:177: 			if (PokedexTable[proc->menuIndex].IndexNumber) { c++; } 
	ldr	r3, .L40+4	@ tmp353,
	lsls	r2, r2, #2	@ tmp354, _54,
	ldrb	r3, [r2, r3]	@ _55, PokedexTable
	movs	r0, #38	@ tmp549,
	adds	r2, r7, r0	@ tmp355,, tmp549
	adds	r1, r7, r0	@ tmp356,, tmp550
	ldrb	r1, [r1]	@ tmp357, c
	strb	r1, [r2]	@ tmp357, c
@ Pokedex.c:177: 			if (PokedexTable[proc->menuIndex].IndexNumber) { c++; } 
	cmp	r3, #0	@ _55,
	beq	.L18		@,
@ Pokedex.c:177: 			if (PokedexTable[proc->menuIndex].IndexNumber) { c++; } 
	movs	r1, r0	@ tmp551, tmp550
	adds	r3, r7, r1	@ tmp358,, tmp551
	ldrb	r2, [r3]	@ c.1_56, c
	adds	r3, r7, r1	@ tmp359,, tmp552
	adds	r2, r2, #1	@ tmp360,
	strb	r2, [r3]	@ tmp361, c
.L18:
@ Pokedex.c:170: 		while (c<10) {
	movs	r3, #38	@ tmp553,
	adds	r3, r7, r3	@ tmp362,, tmp553
	ldrb	r3, [r3]	@ tmp365, c
	cmp	r3, #9	@ tmp365,
	bls	.L21		@,
@ Pokedex.c:179: 		PokedexDraw(menu, command);
	ldr	r2, [r7]	@ tmp366, command
	ldr	r3, [r7, #4]	@ tmp367, menu
	movs	r1, r2	@, tmp366
	movs	r0, r3	@, tmp367
	bl	PokedexDraw		@
@ Pokedex.c:180: 		PlaySfx(0x6B);
	ldr	r3, .L40+8	@ tmp368,
	movs	r2, #65	@ tmp369,
	ldrb	r3, [r3, r2]	@ _57, gChapterData
	movs	r2, #2	@ tmp371,
	ands	r3, r2	@ tmp370, tmp371
	lsls	r3, r3, #24	@ tmp372, tmp370,
	lsrs	r3, r3, #24	@ _58, tmp372,
	bne	.L17		@,
@ Pokedex.c:180: 		PlaySfx(0x6B);
	movs	r0, #107	@,
	ldr	r3, .L40+12	@ tmp373,
	bl	.L44		@
.L17:
@ Pokedex.c:186: 	if (proc->cycle >=50) { proc->cycle = 0; } 
	ldr	r3, [r7, #16]	@ tmp374, proc
	movs	r2, #51	@ tmp375,
	ldrb	r3, [r3, r2]	@ _59,
@ Pokedex.c:186: 	if (proc->cycle >=50) { proc->cycle = 0; } 
	cmp	r3, #49	@ _59,
	bls	.L22		@,
@ Pokedex.c:186: 	if (proc->cycle >=50) { proc->cycle = 0; } 
	ldr	r3, [r7, #16]	@ tmp378, proc
	movs	r2, #51	@ tmp379,
	movs	r1, #0	@ tmp380,
	strb	r1, [r3, r2]	@ tmp381, proc_140->cycle
.L22:
@ Pokedex.c:188: 	proc->cycle++; 
	ldr	r3, [r7, #16]	@ tmp382, proc
	movs	r2, #51	@ tmp383,
	ldrb	r3, [r3, r2]	@ _60,
@ Pokedex.c:188: 	proc->cycle++; 
	adds	r3, r3, #1	@ tmp384,
	lsls	r3, r3, #24	@ tmp385, tmp384,
	lsrs	r1, r3, #24	@ _62, tmp385,
	ldr	r3, [r7, #16]	@ tmp386, proc
	movs	r2, #51	@ tmp387,
	strb	r1, [r3, r2]	@ tmp388, proc_140->cycle
@ Pokedex.c:189: 	if ( (proc-> cycle < 25) & proc->seen) 
	ldr	r3, [r7, #16]	@ tmp389, proc
	movs	r2, #51	@ tmp390,
	ldrb	r2, [r3, r2]	@ _63,
@ Pokedex.c:189: 	if ( (proc-> cycle < 25) & proc->seen) 
	movs	r1, #24	@ tmp395,
	movs	r3, #0	@ tmp396,
	cmp	r1, r2	@ tmp395, _63
	adcs	r3, r3, r3	@ tmp394, tmp396, tmp396
	lsls	r3, r3, #24	@ tmp397, tmp391,
	lsrs	r3, r3, #24	@ _64, tmp397,
	movs	r1, r3	@ _65, _64
@ Pokedex.c:189: 	if ( (proc-> cycle < 25) & proc->seen) 
	ldr	r3, [r7, #16]	@ tmp398, proc
	movs	r2, #69	@ tmp399,
	ldrb	r3, [r3, r2]	@ _66,
@ Pokedex.c:189: 	if ( (proc-> cycle < 25) & proc->seen) 
	ands	r3, r1	@ _68, _65
@ Pokedex.c:189: 	if ( (proc-> cycle < 25) & proc->seen) 
	bne	.LCB376	@
	b	.L23	@long jump	@
.LCB376:
@ Pokedex.c:193: 		if (proc->areaBitfield_A)
	ldr	r3, [r7, #16]	@ tmp400, proc
	ldr	r3, [r3, #52]	@ _69, proc_140->areaBitfield_A
@ Pokedex.c:193: 		if (proc->areaBitfield_A)
	cmp	r3, #0	@ _69,
	beq	.L24		@,
@ Pokedex.c:195: 			for (int i = 0; i<32; i++)
	movs	r3, #0	@ tmp401,
	str	r3, [r7, #32]	@ tmp401, i
@ Pokedex.c:195: 			for (int i = 0; i<32; i++)
	b	.L25		@
.L27:
@ Pokedex.c:197: 				if (proc->areaBitfield_A & 1<<i)
	ldr	r3, [r7, #16]	@ tmp402, proc
	ldr	r2, [r3, #52]	@ _70, proc_140->areaBitfield_A
@ Pokedex.c:197: 				if (proc->areaBitfield_A & 1<<i)
	ldr	r3, [r7, #32]	@ tmp403, i
	asrs	r2, r2, r3	@ _70, _70, tmp403
	movs	r3, r2	@ _71, _70
	movs	r2, #1	@ tmp404,
	ands	r3, r2	@ _72, tmp404
@ Pokedex.c:197: 				if (proc->areaBitfield_A & 1<<i)
	beq	.L26		@,
@ Pokedex.c:199: 					u8 xx = AreaTable[i].xx;
	movs	r0, #15	@ tmp555,
	adds	r3, r7, r0	@ tmp405,, tmp555
	ldr	r2, .L40+16	@ tmp406,
	ldr	r1, [r7, #32]	@ tmp407, i
	lsls	r1, r1, #1	@ tmp408, tmp407,
	ldrb	r2, [r1, r2]	@ tmp409, AreaTable
	strb	r2, [r3]	@ tmp409, xx
@ Pokedex.c:200: 					u8 yy = AreaTable[i].yy;
	movs	r4, #14	@ tmp556,
	adds	r3, r7, r4	@ tmp410,, tmp556
	ldr	r1, .L40+16	@ tmp411,
	ldr	r2, [r7, #32]	@ tmp412, i
	lsls	r2, r2, #1	@ tmp413, tmp412,
	adds	r2, r1, r2	@ tmp414, tmp411, tmp413
	adds	r2, r2, #1	@ tmp415,
	ldrb	r2, [r2]	@ tmp416, AreaTable
	strb	r2, [r3]	@ tmp416, yy
@ Pokedex.c:201: 					ObjInsertSafe(0, xx*8, yy*8, &gObj_8x8, TILEREF(0x65, 0)); // + icon 
	adds	r3, r7, r0	@ tmp417,, tmp557
	ldrb	r3, [r3]	@ tmp419, xx
	lsls	r3, r3, #16	@ tmp420, tmp418,
	lsrs	r3, r3, #16	@ _73, tmp420,
	lsls	r3, r3, #3	@ tmp421, _73,
	lsls	r3, r3, #16	@ tmp422, tmp421,
	lsrs	r1, r3, #16	@ _74, tmp422,
	adds	r3, r7, r4	@ tmp423,, tmp558
	ldrb	r3, [r3]	@ tmp425, yy
	lsls	r3, r3, #16	@ tmp426, tmp424,
	lsrs	r3, r3, #16	@ _75, tmp426,
	lsls	r3, r3, #3	@ tmp427, _75,
	lsls	r3, r3, #16	@ tmp428, tmp427,
	lsrs	r2, r3, #16	@ _76, tmp428,
	ldr	r3, .L40+20	@ tmp429,
	movs	r0, #101	@ tmp430,
	str	r0, [sp]	@ tmp430,
	movs	r0, #0	@,
	ldr	r4, .L40+24	@ tmp431,
	bl	.L45		@
.L26:
@ Pokedex.c:195: 			for (int i = 0; i<32; i++)
	ldr	r3, [r7, #32]	@ tmp433, i
	adds	r3, r3, #1	@ tmp432,
	str	r3, [r7, #32]	@ tmp432, i
.L25:
@ Pokedex.c:195: 			for (int i = 0; i<32; i++)
	ldr	r3, [r7, #32]	@ tmp434, i
	cmp	r3, #31	@ tmp434,
	ble	.L27		@,
.L24:
@ Pokedex.c:205: 		if (proc->areaBitfield_B)
	ldr	r3, [r7, #16]	@ tmp435, proc
	ldr	r3, [r3, #56]	@ _77, proc_140->areaBitfield_B
@ Pokedex.c:205: 		if (proc->areaBitfield_B)
	cmp	r3, #0	@ _77,
	beq	.L28		@,
@ Pokedex.c:207: 			for (int i = 0; i<32; i++)
	movs	r3, #0	@ tmp436,
	str	r3, [r7, #28]	@ tmp436, i
@ Pokedex.c:207: 			for (int i = 0; i<32; i++)
	b	.L29		@
.L41:
	.align	2
.L40:
	.word	gKeyState
	.word	PokedexTable
	.word	gChapterData
	.word	m4aSongNumStart
	.word	AreaTable
	.word	gObj_8x8
	.word	ObjInsertSafe
.L31:
@ Pokedex.c:209: 				if (proc->areaBitfield_B & 1<<i)
	ldr	r3, [r7, #16]	@ tmp437, proc
	ldr	r2, [r3, #56]	@ _78, proc_140->areaBitfield_B
@ Pokedex.c:209: 				if (proc->areaBitfield_B & 1<<i)
	ldr	r3, [r7, #28]	@ tmp438, i
	asrs	r2, r2, r3	@ _78, _78, tmp438
	movs	r3, r2	@ _79, _78
	movs	r2, #1	@ tmp439,
	ands	r3, r2	@ _80, tmp439
@ Pokedex.c:209: 				if (proc->areaBitfield_B & 1<<i)
	beq	.L30		@,
@ Pokedex.c:211: 					u8 xx = AreaTable[i+32].xx; // bitpacked chapters, so add +32
	ldr	r3, [r7, #28]	@ tmp440, i
	adds	r3, r3, #32	@ tmp440,
	movs	r1, r3	@ _81, tmp440
@ Pokedex.c:211: 					u8 xx = AreaTable[i+32].xx; // bitpacked chapters, so add +32
	movs	r0, #13	@ tmp561,
	adds	r3, r7, r0	@ tmp441,, tmp561
	ldr	r2, .L42	@ tmp442,
	lsls	r1, r1, #1	@ tmp443, _81,
	ldrb	r2, [r1, r2]	@ tmp444, AreaTable
	strb	r2, [r3]	@ tmp444, xx
@ Pokedex.c:212: 					u8 yy = AreaTable[i+32].yy;
	ldr	r3, [r7, #28]	@ tmp445, i
	adds	r3, r3, #32	@ tmp445,
	movs	r2, r3	@ _82, tmp445
@ Pokedex.c:212: 					u8 yy = AreaTable[i+32].yy;
	movs	r4, #12	@ tmp563,
	adds	r3, r7, r4	@ tmp446,, tmp563
	ldr	r1, .L42	@ tmp447,
	lsls	r2, r2, #1	@ tmp448, _82,
	adds	r2, r1, r2	@ tmp449, tmp447, tmp448
	adds	r2, r2, #1	@ tmp450,
	ldrb	r2, [r2]	@ tmp451, AreaTable
	strb	r2, [r3]	@ tmp451, yy
@ Pokedex.c:213: 					ObjInsertSafe(0, xx*8, yy*8, &gObj_8x8, TILEREF(0x65, 0)); // + icon 
	adds	r3, r7, r0	@ tmp452,, tmp564
	ldrb	r3, [r3]	@ tmp454, xx
	lsls	r3, r3, #16	@ tmp455, tmp453,
	lsrs	r3, r3, #16	@ _83, tmp455,
	lsls	r3, r3, #3	@ tmp456, _83,
	lsls	r3, r3, #16	@ tmp457, tmp456,
	lsrs	r1, r3, #16	@ _84, tmp457,
	adds	r3, r7, r4	@ tmp458,, tmp565
	ldrb	r3, [r3]	@ tmp460, yy
	lsls	r3, r3, #16	@ tmp461, tmp459,
	lsrs	r3, r3, #16	@ _85, tmp461,
	lsls	r3, r3, #3	@ tmp462, _85,
	lsls	r3, r3, #16	@ tmp463, tmp462,
	lsrs	r2, r3, #16	@ _86, tmp463,
	ldr	r3, .L42+4	@ tmp464,
	movs	r0, #101	@ tmp465,
	str	r0, [sp]	@ tmp465,
	movs	r0, #0	@,
	ldr	r4, .L42+8	@ tmp466,
	bl	.L45		@
.L30:
@ Pokedex.c:207: 			for (int i = 0; i<32; i++)
	ldr	r3, [r7, #28]	@ tmp468, i
	adds	r3, r3, #1	@ tmp467,
	str	r3, [r7, #28]	@ tmp467, i
.L29:
@ Pokedex.c:207: 			for (int i = 0; i<32; i++)
	ldr	r3, [r7, #28]	@ tmp469, i
	cmp	r3, #31	@ tmp469,
	ble	.L31		@,
.L28:
@ Pokedex.c:217: 		if (proc->areaBitfield_C)
	ldr	r3, [r7, #16]	@ tmp470, proc
	ldr	r3, [r3, #60]	@ _87, proc_140->areaBitfield_C
@ Pokedex.c:217: 		if (proc->areaBitfield_C)
	cmp	r3, #0	@ _87,
	beq	.L32		@,
@ Pokedex.c:219: 			for (int i = 0; i<32; i++)
	movs	r3, #0	@ tmp471,
	str	r3, [r7, #24]	@ tmp471, i
@ Pokedex.c:219: 			for (int i = 0; i<32; i++)
	b	.L33		@
.L35:
@ Pokedex.c:221: 				if (proc->areaBitfield_C & 1<<i)
	ldr	r3, [r7, #16]	@ tmp472, proc
	ldr	r2, [r3, #60]	@ _88, proc_140->areaBitfield_C
@ Pokedex.c:221: 				if (proc->areaBitfield_C & 1<<i)
	ldr	r3, [r7, #24]	@ tmp473, i
	asrs	r2, r2, r3	@ _88, _88, tmp473
	movs	r3, r2	@ _89, _88
	movs	r2, #1	@ tmp474,
	ands	r3, r2	@ _90, tmp474
@ Pokedex.c:221: 				if (proc->areaBitfield_C & 1<<i)
	beq	.L34		@,
@ Pokedex.c:223: 					u8 xx = AreaTable[i+64].xx; // bitpacked chapters, so add +64 
	ldr	r3, [r7, #24]	@ tmp475, i
	adds	r3, r3, #64	@ tmp475,
	movs	r1, r3	@ _91, tmp475
@ Pokedex.c:223: 					u8 xx = AreaTable[i+64].xx; // bitpacked chapters, so add +64 
	movs	r0, #11	@ tmp568,
	adds	r3, r7, r0	@ tmp476,, tmp568
	ldr	r2, .L42	@ tmp477,
	lsls	r1, r1, #1	@ tmp478, _91,
	ldrb	r2, [r1, r2]	@ tmp479, AreaTable
	strb	r2, [r3]	@ tmp479, xx
@ Pokedex.c:224: 					u8 yy = AreaTable[i+64].yy;
	ldr	r3, [r7, #24]	@ tmp480, i
	adds	r3, r3, #64	@ tmp480,
	movs	r2, r3	@ _92, tmp480
@ Pokedex.c:224: 					u8 yy = AreaTable[i+64].yy;
	movs	r4, #10	@ tmp570,
	adds	r3, r7, r4	@ tmp481,, tmp570
	ldr	r1, .L42	@ tmp482,
	lsls	r2, r2, #1	@ tmp483, _92,
	adds	r2, r1, r2	@ tmp484, tmp482, tmp483
	adds	r2, r2, #1	@ tmp485,
	ldrb	r2, [r2]	@ tmp486, AreaTable
	strb	r2, [r3]	@ tmp486, yy
@ Pokedex.c:225: 					ObjInsertSafe(0, xx*8, yy*8, &gObj_8x8, TILEREF(0x65, 0)); // + icon 
	adds	r3, r7, r0	@ tmp487,, tmp571
	ldrb	r3, [r3]	@ tmp489, xx
	lsls	r3, r3, #16	@ tmp490, tmp488,
	lsrs	r3, r3, #16	@ _93, tmp490,
	lsls	r3, r3, #3	@ tmp491, _93,
	lsls	r3, r3, #16	@ tmp492, tmp491,
	lsrs	r1, r3, #16	@ _94, tmp492,
	adds	r3, r7, r4	@ tmp493,, tmp572
	ldrb	r3, [r3]	@ tmp495, yy
	lsls	r3, r3, #16	@ tmp496, tmp494,
	lsrs	r3, r3, #16	@ _95, tmp496,
	lsls	r3, r3, #3	@ tmp497, _95,
	lsls	r3, r3, #16	@ tmp498, tmp497,
	lsrs	r2, r3, #16	@ _96, tmp498,
	ldr	r3, .L42+4	@ tmp499,
	movs	r0, #101	@ tmp500,
	str	r0, [sp]	@ tmp500,
	movs	r0, #0	@,
	ldr	r4, .L42+8	@ tmp501,
	bl	.L45		@
.L34:
@ Pokedex.c:219: 			for (int i = 0; i<32; i++)
	ldr	r3, [r7, #24]	@ tmp503, i
	adds	r3, r3, #1	@ tmp502,
	str	r3, [r7, #24]	@ tmp502, i
.L33:
@ Pokedex.c:219: 			for (int i = 0; i<32; i++)
	ldr	r3, [r7, #24]	@ tmp504, i
	cmp	r3, #31	@ tmp504,
	ble	.L35		@,
.L32:
@ Pokedex.c:229: 		if (proc->areaBitfield_D)
	ldr	r3, [r7, #16]	@ tmp505, proc
	ldr	r3, [r3, #64]	@ _97, proc_140->areaBitfield_D
@ Pokedex.c:229: 		if (proc->areaBitfield_D)
	cmp	r3, #0	@ _97,
	beq	.L23		@,
@ Pokedex.c:231: 			for (int i = 0; i<32; i++)
	movs	r3, #0	@ tmp506,
	str	r3, [r7, #20]	@ tmp506, i
@ Pokedex.c:231: 			for (int i = 0; i<32; i++)
	b	.L36		@
.L38:
@ Pokedex.c:233: 				if (proc->areaBitfield_D & 1<<i)
	ldr	r3, [r7, #16]	@ tmp507, proc
	ldr	r2, [r3, #64]	@ _98, proc_140->areaBitfield_D
@ Pokedex.c:233: 				if (proc->areaBitfield_D & 1<<i)
	ldr	r3, [r7, #20]	@ tmp508, i
	asrs	r2, r2, r3	@ _98, _98, tmp508
	movs	r3, r2	@ _99, _98
	movs	r2, #1	@ tmp509,
	ands	r3, r2	@ _100, tmp509
@ Pokedex.c:233: 				if (proc->areaBitfield_D & 1<<i)
	beq	.L37		@,
@ Pokedex.c:235: 					u8 xx = AreaTable[i+96].xx; // bitpacked chapters, so add +96 
	ldr	r3, [r7, #20]	@ tmp510, i
	adds	r3, r3, #96	@ tmp510,
	movs	r1, r3	@ _101, tmp510
@ Pokedex.c:235: 					u8 xx = AreaTable[i+96].xx; // bitpacked chapters, so add +96 
	movs	r0, #9	@ tmp575,
	adds	r3, r7, r0	@ tmp511,, tmp575
	ldr	r2, .L42	@ tmp512,
	lsls	r1, r1, #1	@ tmp513, _101,
	ldrb	r2, [r1, r2]	@ tmp514, AreaTable
	strb	r2, [r3]	@ tmp514, xx
@ Pokedex.c:236: 					u8 yy = AreaTable[i+96].yy;
	ldr	r3, [r7, #20]	@ tmp515, i
	adds	r3, r3, #96	@ tmp515,
	movs	r2, r3	@ _102, tmp515
@ Pokedex.c:236: 					u8 yy = AreaTable[i+96].yy;
	movs	r4, #8	@ tmp577,
	adds	r3, r7, r4	@ tmp516,, tmp577
	ldr	r1, .L42	@ tmp517,
	lsls	r2, r2, #1	@ tmp518, _102,
	adds	r2, r1, r2	@ tmp519, tmp517, tmp518
	adds	r2, r2, #1	@ tmp520,
	ldrb	r2, [r2]	@ tmp521, AreaTable
	strb	r2, [r3]	@ tmp521, yy
@ Pokedex.c:237: 					ObjInsertSafe(0, xx*8, yy*8, &gObj_8x8, TILEREF(0x65, 0)); // + icon 
	adds	r3, r7, r0	@ tmp522,, tmp578
	ldrb	r3, [r3]	@ tmp524, xx
	lsls	r3, r3, #16	@ tmp525, tmp523,
	lsrs	r3, r3, #16	@ _103, tmp525,
	lsls	r3, r3, #3	@ tmp526, _103,
	lsls	r3, r3, #16	@ tmp527, tmp526,
	lsrs	r1, r3, #16	@ _104, tmp527,
	adds	r3, r7, r4	@ tmp528,, tmp579
	ldrb	r3, [r3]	@ tmp530, yy
	lsls	r3, r3, #16	@ tmp531, tmp529,
	lsrs	r3, r3, #16	@ _105, tmp531,
	lsls	r3, r3, #3	@ tmp532, _105,
	lsls	r3, r3, #16	@ tmp533, tmp532,
	lsrs	r2, r3, #16	@ _106, tmp533,
	ldr	r3, .L42+4	@ tmp534,
	movs	r0, #101	@ tmp535,
	str	r0, [sp]	@ tmp535,
	movs	r0, #0	@,
	ldr	r4, .L42+8	@ tmp536,
	bl	.L45		@
.L37:
@ Pokedex.c:231: 			for (int i = 0; i<32; i++)
	ldr	r3, [r7, #20]	@ tmp538, i
	adds	r3, r3, #1	@ tmp537,
	str	r3, [r7, #20]	@ tmp537, i
.L36:
@ Pokedex.c:231: 			for (int i = 0; i<32; i++)
	ldr	r3, [r7, #20]	@ tmp539, i
	cmp	r3, #31	@ tmp539,
	ble	.L38		@,
.L23:
@ Pokedex.c:242:     return ME_NONE;
	movs	r3, #0	@ _186,
@ Pokedex.c:243: }
	movs	r0, r3	@, <retval>
	mov	sp, r7	@,
	add	sp, sp, #44	@,,
	@ sp needed	@
	pop	{r4, r7}
	pop	{r1}
	bx	r1
.L43:
	.align	2
.L42:
	.word	AreaTable
	.word	gObj_8x8
	.word	ObjInsertSafe
	.size	PokedexIdle, .-PokedexIdle
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	DrawRawText, %function
DrawRawText:
	@ Function supports interworking.
	@ args = 4, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, r7, lr}	@
	sub	sp, sp, #16	@,,
	add	r7, sp, #0	@,,
	movs	r5, #8	@ tmp131,
	adds	r4, r7, r5	@ tmp114,, tmp131
	str	r0, [r4]	@, handle
	str	r1, [r4, #4]	@, handle
	str	r2, [r7, #4]	@ string, string
	str	r3, [r7]	@ x, x
@ Pokedex.c:248: 	Text_Clear(&handle);
	movs	r4, r5	@ tmp132, tmp131
	adds	r3, r7, r4	@ tmp115,, tmp132
	movs	r0, r3	@, tmp115
	ldr	r3, .L47	@ tmp116,
	bl	.L44		@
@ Pokedex.c:249: 	Text_SetColorId(&handle,TEXT_COLOR_GOLD);
	adds	r3, r7, r4	@ tmp117,, tmp133
	movs	r1, #3	@,
	movs	r0, r3	@, tmp117
	ldr	r3, .L47+4	@ tmp118,
	bl	.L44		@
@ Pokedex.c:250: 	Text_DrawString(&handle,string);
	ldr	r2, [r7, #4]	@ tmp119, string
	adds	r3, r7, r4	@ tmp120,, tmp134
	movs	r1, r2	@, tmp119
	movs	r0, r3	@, tmp120
	ldr	r3, .L47+8	@ tmp121,
	bl	.L44		@
@ Pokedex.c:251: 	Text_Display(&handle,&gBG0MapBuffer[y][x]);
	ldr	r3, [r7, #32]	@ tmp123, y
	lsls	r2, r3, #5	@ tmp122, tmp123,
	ldr	r3, [r7]	@ tmp125, x
	adds	r3, r2, r3	@ tmp124, tmp122, tmp125
	lsls	r2, r3, #1	@ tmp126, tmp124,
	ldr	r3, .L47+12	@ tmp127,
	adds	r2, r2, r3	@ _1, tmp126, tmp127
	adds	r3, r7, r4	@ tmp128,, tmp135
	movs	r1, r2	@, _1
	movs	r0, r3	@, tmp128
	ldr	r3, .L47+16	@ tmp129,
	bl	.L44		@
@ Pokedex.c:252: }
	nop	
	mov	sp, r7	@,
	add	sp, sp, #16	@,,
	@ sp needed	@
	pop	{r4, r5, r7}
	pop	{r0}
	bx	r0
.L48:
	.align	2
.L47:
	.word	Text_Clear
	.word	Text_SetColorId
	.word	Text_DrawString
	.word	gBG0MapBuffer
	.word	Text_Display
	.size	DrawRawText, .-DrawRawText
	.section	.rodata
	.align	2
.LC23:
	.ascii	"???\000"
	.align	2
.LC27:
	.ascii	" Seen\000"
	.align	2
.LC29:
	.ascii	" Caught\000"
	.align	2
.LC55:
	.ascii	"   ...   ...   ...   ...   ...   ...   ...   ...   "
	.ascii	"...\000"
	.align	2
.LC57:
	.ascii	"              MISSING DATA\000"
	.align	2
.LC60:
	.ascii	"No Data\000"
	.text
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	PokedexDrawIdle, %function
PokedexDrawIdle:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 136
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}	@
	mov	lr, r8	@,
	push	{lr}	@
	sub	sp, sp, #144	@,,
	add	r7, sp, #8	@,,
	str	r0, [r7, #28]	@ menu, menu
	str	r1, [r7, #24]	@ command, command
@ Pokedex.c:254: static int PokedexDrawIdle(MenuProc* menu, MenuCommandProc* command) {
	mov	r3, sp	@ tmp197,
	mov	r8, r3	@ saved_stack.13_96, tmp197
@ Pokedex.c:255:     struct PokedexProc* const proc = (void*) menu->parent;
	ldr	r3, [r7, #28]	@ tmp198, menu
	ldr	r3, [r3, #20]	@ tmp199, menu_97(D)->parent
	str	r3, [r7, #108]	@ tmp199, proc
@ Pokedex.c:256:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldr	r3, [r7, #24]	@ tmp200, command
	ldrh	r3, [r3, #44]	@ _1,
	lsls	r3, r3, #5	@ _3, _2,
	ldr	r2, [r7, #24]	@ tmp201, command
	ldrh	r2, [r2, #42]	@ _4,
	adds	r3, r3, r2	@ _6, _3, _5
@ Pokedex.c:256:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r2, r3, #1	@ _8, _7,
@ Pokedex.c:256:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldr	r3, .L67	@ tmp203,
	adds	r3, r2, r3	@ tmp202, _8, tmp203
	str	r3, [r7, #104]	@ tmp202, out
@ Pokedex.c:258: 	int* areaBitfield_A = &proc->areaBitfield_A;
	ldr	r3, [r7, #108]	@ tmp205, proc
	adds	r3, r3, #52	@ tmp204,
	str	r3, [r7, #100]	@ tmp204, areaBitfield_A
@ Pokedex.c:259: 	int* areaBitfield_B = &proc->areaBitfield_B;
	ldr	r3, [r7, #108]	@ tmp207, proc
	adds	r3, r3, #56	@ tmp206,
	str	r3, [r7, #96]	@ tmp206, areaBitfield_B
@ Pokedex.c:260: 	int* areaBitfield_C = &proc->areaBitfield_C;
	ldr	r3, [r7, #108]	@ tmp209, proc
	adds	r3, r3, #60	@ tmp208,
	str	r3, [r7, #92]	@ tmp208, areaBitfield_C
@ Pokedex.c:261: 	int* areaBitfield_D = &proc->areaBitfield_D;
	ldr	r3, [r7, #108]	@ tmp211, proc
	adds	r3, r3, #64	@ tmp210,
	str	r3, [r7, #88]	@ tmp210, areaBitfield_D
@ Pokedex.c:262: 	proc->areaBitfield_A = 0;
	ldr	r3, [r7, #108]	@ tmp212, proc
	movs	r2, #0	@ tmp213,
	str	r2, [r3, #52]	@ tmp213, proc_98->areaBitfield_A
@ Pokedex.c:263: 	proc->areaBitfield_B = 0;
	ldr	r3, [r7, #108]	@ tmp214, proc
	movs	r2, #0	@ tmp215,
	str	r2, [r3, #56]	@ tmp215, proc_98->areaBitfield_B
@ Pokedex.c:264: 	proc->areaBitfield_C = 0;
	ldr	r3, [r7, #108]	@ tmp216, proc
	movs	r2, #0	@ tmp217,
	str	r2, [r3, #60]	@ tmp217, proc_98->areaBitfield_C
@ Pokedex.c:265: 	proc->areaBitfield_D = 0;
	ldr	r3, [r7, #108]	@ tmp218, proc
	movs	r2, #0	@ tmp219,
	str	r2, [r3, #64]	@ tmp219, proc_98->areaBitfield_D
@ Pokedex.c:266: 	proc->cycle = 0;
	ldr	r3, [r7, #108]	@ tmp220, proc
	movs	r2, #51	@ tmp221,
	movs	r1, #0	@ tmp222,
	strb	r1, [r3, r2]	@ tmp223, proc_98->cycle
@ Pokedex.c:268: 	bool caught = CheckIfCaught(proc->menuIndex);
	ldr	r3, [r7, #108]	@ tmp224, proc
	movs	r2, #48	@ tmp225,
	ldrb	r3, [r3, r2]	@ _9,
	movs	r0, r3	@, _9
	ldr	r3, .L67+4	@ tmp226,
	bl	.L44		@
	movs	r2, r0	@ _10,
@ Pokedex.c:268: 	bool caught = CheckIfCaught(proc->menuIndex);
	movs	r3, #63	@ tmp572,
	movs	r4, #24	@ tmp714,
	adds	r3, r3, r4	@ tmp713, tmp572, tmp714
	adds	r3, r3, r7	@ tmp227, tmp713,
	subs	r1, r2, #1	@ tmp229, _10
	sbcs	r2, r2, r1	@ tmp228, _10, tmp229
	strb	r2, [r3]	@ tmp230, caught
@ Pokedex.c:269: 	bool seen = CheckIfSeen(proc->menuIndex);
	ldr	r3, [r7, #108]	@ tmp231, proc
	movs	r2, #48	@ tmp232,
	ldrb	r3, [r3, r2]	@ _11,
	movs	r0, r3	@, _11
	ldr	r3, .L67+8	@ tmp233,
	bl	.L44		@
	movs	r2, r0	@ _12,
@ Pokedex.c:269: 	bool seen = CheckIfSeen(proc->menuIndex);
	movs	r3, #62	@ tmp573,
	adds	r3, r3, r4	@ tmp711, tmp573, tmp712
	adds	r3, r3, r7	@ tmp234, tmp711,
	subs	r1, r2, #1	@ tmp236, _12
	sbcs	r2, r2, r1	@ tmp235, _12, tmp236
	strb	r2, [r3]	@ tmp237, seen
@ Pokedex.c:271: 	const struct ClassData* ClassData = GetClassData(proc->menuIndex);
	ldr	r3, [r7, #108]	@ tmp238, proc
	movs	r2, #48	@ tmp239,
	ldrb	r3, [r3, r2]	@ _13,
	movs	r0, r3	@, _13
	ldr	r3, .L67+12	@ tmp240,
	bl	.L44		@
	movs	r3, r0	@ tmp241,
	str	r3, [r7, #80]	@ tmp241, ClassData
@ Pokedex.c:272: 	u16 title = 0;
	movs	r1, #94	@ tmp574,
	adds	r3, r1, r4	@ tmp709, tmp574, tmp710
	adds	r3, r3, r7	@ tmp242, tmp709,
	movs	r2, #0	@ tmp243,
	strh	r2, [r3]	@ tmp244, title
@ Pokedex.c:273:     Text_Clear(&command->text);
	ldr	r3, [r7, #24]	@ tmp245, command
	adds	r3, r3, #52	@ _14,
	movs	r0, r3	@, _14
	ldr	r3, .L67+16	@ tmp246,
	bl	.L44		@
@ Pokedex.c:274: 	Text_ResetTileAllocation(); // 0x08003D20
	ldr	r3, .L67+20	@ tmp247,
	bl	.L44		@
@ Pokedex.c:277: 	Pokedex_RetrieveAreasFound(proc->menuIndex, areaBitfield_A, areaBitfield_B, areaBitfield_C, areaBitfield_D);
	ldr	r3, [r7, #108]	@ tmp248, proc
	movs	r2, #48	@ tmp249,
	ldrb	r4, [r3, r2]	@ _15,
	ldr	r2, [r7, #92]	@ tmp250, areaBitfield_C
	ldr	r1, [r7, #96]	@ tmp251, areaBitfield_B
	ldr	r0, [r7, #100]	@ tmp252, areaBitfield_A
	ldr	r3, [r7, #88]	@ tmp253, areaBitfield_D
	str	r3, [sp]	@ tmp253,
	movs	r3, r2	@, tmp250
	movs	r2, r1	@, tmp251
	movs	r1, r0	@, tmp252
	movs	r0, r4	@, _15
	bl	Pokedex_RetrieveAreasFound		@
@ Pokedex.c:280: 	if (proc->menuIndex)
	ldr	r3, [r7, #108]	@ tmp254, proc
	movs	r2, #48	@ tmp255,
	ldrb	r3, [r3, r2]	@ _16,
@ Pokedex.c:280: 	if (proc->menuIndex)
	cmp	r3, #0	@ _16,
	beq	.L50		@,
@ Pokedex.c:282: 		if (seen)
	movs	r3, #62	@ tmp575,
	movs	r0, #24	@ tmp708,
	adds	r3, r3, r0	@ tmp707, tmp575, tmp708
	adds	r3, r3, r7	@ tmp256, tmp707,
	ldrb	r3, [r3]	@ tmp257, seen
	cmp	r3, #0	@ tmp257,
	beq	.L50		@,
@ Pokedex.c:284: 			title = ClassData->nameTextId;
	movs	r1, #94	@ tmp576,
	adds	r3, r1, r0	@ tmp705, tmp576, tmp706
	adds	r3, r3, r7	@ tmp258, tmp705,
	ldr	r2, [r7, #80]	@ tmp259, ClassData
	ldrh	r2, [r2]	@ tmp260, *ClassData_115
	strh	r2, [r3]	@ tmp260, title
@ Pokedex.c:285: 			Text_DrawString(&command->text, GetStringFromIndex(title));
	ldr	r3, [r7, #24]	@ tmp261, command
	adds	r3, r3, #52	@ tmp261,
	movs	r4, r3	@ _17, tmp261
@ Pokedex.c:285: 			Text_DrawString(&command->text, GetStringFromIndex(title));
	adds	r3, r1, r0	@ tmp703, tmp578, tmp704
	adds	r3, r3, r7	@ tmp262, tmp703,
	ldrh	r3, [r3]	@ _18, title
	movs	r0, r3	@, _18
	ldr	r3, .L67+24	@ tmp263,
	bl	.L44		@
	movs	r3, r0	@ _19,
@ Pokedex.c:285: 			Text_DrawString(&command->text, GetStringFromIndex(title));
	movs	r1, r3	@, _19
	movs	r0, r4	@, _17
	ldr	r3, .L67+28	@ tmp264,
	bl	.L44		@
@ Pokedex.c:286: 			Text_Display(&command->text, out); // Class name 
	ldr	r3, [r7, #24]	@ tmp265, command
	adds	r3, r3, #52	@ _20,
	ldr	r2, [r7, #104]	@ tmp266, out
	movs	r1, r2	@, tmp266
	movs	r0, r3	@, _20
	ldr	r3, .L67+32	@ tmp267,
	bl	.L44		@
.L50:
@ Pokedex.c:292:     Text_SetColorId(&command->text, TEXT_COLOR_NORMAL);
	ldr	r3, [r7, #24]	@ tmp268, command
	adds	r3, r3, #52	@ _21,
	movs	r1, #0	@,
	movs	r0, r3	@, _21
	ldr	r3, .L67+36	@ tmp269,
	bl	.L44		@
@ Pokedex.c:293:     if (!title) {
	movs	r3, #94	@ tmp579,
	movs	r2, #24	@ tmp702,
	adds	r3, r3, r2	@ tmp701, tmp579, tmp702
	adds	r3, r3, r7	@ tmp270, tmp701,
	ldrh	r3, [r3]	@ tmp271, title
	cmp	r3, #0	@ tmp271,
	bne	.L51		@,
@ Pokedex.c:294: 		Text_SetXCursor(&command->text, 0xC);
	ldr	r3, [r7, #24]	@ tmp272, command
	adds	r3, r3, #52	@ _22,
	movs	r1, #12	@,
	movs	r0, r3	@, _22
	ldr	r3, .L67+40	@ tmp273,
	bl	.L44		@
@ Pokedex.c:295: 		Text_DrawString(&command->text, "???");
	ldr	r3, [r7, #24]	@ tmp274, command
	adds	r3, r3, #52	@ _23,
	ldr	r2, .L67+44	@ tmp275,
	movs	r1, r2	@, tmp275
	movs	r0, r3	@, _23
	ldr	r3, .L67+28	@ tmp276,
	bl	.L44		@
@ Pokedex.c:297: 		Text_Display(&command->text, out); // Class name 
	ldr	r3, [r7, #24]	@ tmp277, command
	adds	r3, r3, #52	@ _24,
	ldr	r2, [r7, #104]	@ tmp278, out
	movs	r1, r2	@, tmp278
	movs	r0, r3	@, _24
	ldr	r3, .L67+32	@ tmp279,
	bl	.L44		@
.L51:
@ Pokedex.c:301: 	int tile = 40;
	movs	r3, #40	@ tmp280,
	str	r3, [r7, #120]	@ tmp280, tile
@ Pokedex.c:303: 	TextHandle caughtNameHandle = {
	movs	r4, #20	@ tmp580,
	movs	r1, #24	@ tmp700,
	adds	r3, r4, r1	@ tmp699, tmp580, tmp700
	adds	r3, r3, r7	@ tmp281, tmp699,
	movs	r0, r3	@ tmp282, tmp281
	movs	r3, #8	@ tmp283,
	movs	r2, r3	@, tmp283
	movs	r1, #0	@,
	ldr	r3, .L67+48	@ tmp284,
	bl	.L44		@
@ Pokedex.c:304: 		.tileIndexOffset = gpCurrentFont->tileNext+tile,
	ldr	r3, .L67+52	@ tmp287,
	ldr	r3, [r3]	@ gpCurrentFont.2_25, gpCurrentFont
	ldrh	r2, [r3, #18]	@ _26,
@ Pokedex.c:304: 		.tileIndexOffset = gpCurrentFont->tileNext+tile,
	ldr	r3, [r7, #120]	@ tmp289, tile
	lsls	r3, r3, #16	@ tmp290, tmp288,
	lsrs	r3, r3, #16	@ _27, tmp290,
	adds	r3, r2, r3	@ tmp291, _26, _27
	lsls	r3, r3, #16	@ tmp292, tmp291,
	lsrs	r2, r3, #16	@ _28, tmp292,
@ Pokedex.c:303: 	TextHandle caughtNameHandle = {
	movs	r1, #24	@ tmp698,
	adds	r3, r4, r1	@ tmp697, tmp581, tmp698
	adds	r3, r3, r7	@ tmp293, tmp697,
	strh	r2, [r3]	@ tmp294, caughtNameHandle.tileIndexOffset
	adds	r3, r4, r1	@ tmp695, tmp582, tmp696
	adds	r3, r3, r7	@ tmp295, tmp695,
	movs	r2, #4	@ tmp296,
	strb	r2, [r3, #4]	@ tmp297, caughtNameHandle.tileWidth
@ Pokedex.c:307: 	tile += 4;
	ldr	r3, [r7, #120]	@ tmp299, tile
	adds	r3, r3, #4	@ tmp298,
	str	r3, [r7, #120]	@ tmp298, tile
@ Pokedex.c:308: 	DrawRawText(caughtNameHandle," Seen",1,16);
	ldr	r2, .L67+56	@ tmp300,
	adds	r3, r4, r1	@ tmp693, tmp583, tmp694
	adds	r1, r3, r7	@ tmp301, tmp693,
	movs	r3, #16	@ tmp302,
	str	r3, [sp]	@ tmp302,
	movs	r3, #1	@,
	ldr	r0, [r1]	@, caughtNameHandle
	ldr	r1, [r1, #4]	@, caughtNameHandle
	bl	DrawRawText		@
@ Pokedex.c:310: 	TextHandle seenNameHandle = {
	movs	r4, #12	@ tmp584,
	movs	r1, #24	@ tmp692,
	adds	r3, r4, r1	@ tmp691, tmp584, tmp692
	adds	r3, r3, r7	@ tmp303, tmp691,
	movs	r0, r3	@ tmp304, tmp303
	movs	r3, #8	@ tmp305,
	movs	r2, r3	@, tmp305
	movs	r1, #0	@,
	ldr	r3, .L67+48	@ tmp306,
	bl	.L44		@
@ Pokedex.c:311: 		.tileIndexOffset = gpCurrentFont->tileNext+tile,
	ldr	r3, .L67+52	@ tmp309,
	ldr	r3, [r3]	@ gpCurrentFont.3_29, gpCurrentFont
	ldrh	r2, [r3, #18]	@ _30,
@ Pokedex.c:311: 		.tileIndexOffset = gpCurrentFont->tileNext+tile,
	ldr	r3, [r7, #120]	@ tmp311, tile
	lsls	r3, r3, #16	@ tmp312, tmp310,
	lsrs	r3, r3, #16	@ _31, tmp312,
	adds	r3, r2, r3	@ tmp313, _30, _31
	lsls	r3, r3, #16	@ tmp314, tmp313,
	lsrs	r2, r3, #16	@ _32, tmp314,
@ Pokedex.c:310: 	TextHandle seenNameHandle = {
	movs	r1, #24	@ tmp690,
	adds	r3, r4, r1	@ tmp689, tmp585, tmp690
	adds	r3, r3, r7	@ tmp315, tmp689,
	strh	r2, [r3]	@ tmp316, seenNameHandle.tileIndexOffset
	adds	r3, r4, r1	@ tmp687, tmp586, tmp688
	adds	r3, r3, r7	@ tmp317, tmp687,
	movs	r2, #5	@ tmp318,
	strb	r2, [r3, #4]	@ tmp319, seenNameHandle.tileWidth
@ Pokedex.c:314: 	tile += 5;
	ldr	r3, [r7, #120]	@ tmp321, tile
	adds	r3, r3, #5	@ tmp320,
	str	r3, [r7, #120]	@ tmp320, tile
@ Pokedex.c:315: 	DrawRawText(seenNameHandle," Caught",1,18);
	ldr	r2, .L67+60	@ tmp322,
	adds	r3, r4, r1	@ tmp685, tmp587, tmp686
	adds	r1, r3, r7	@ tmp323, tmp685,
	movs	r3, #18	@ tmp324,
	str	r3, [sp]	@ tmp324,
	movs	r3, #1	@,
	ldr	r0, [r1]	@, seenNameHandle
	ldr	r1, [r1, #4]	@, seenNameHandle
	bl	DrawRawText		@
@ Pokedex.c:317: 	DrawUiNumber(&gBG0MapBuffer[16][9],TEXT_COLOR_GOLD,  proc->TotalSeen); 
	ldr	r3, [r7, #108]	@ tmp325, proc
	movs	r2, #49	@ tmp326,
	ldrb	r3, [r3, r2]	@ _33,
@ Pokedex.c:317: 	DrawUiNumber(&gBG0MapBuffer[16][9],TEXT_COLOR_GOLD,  proc->TotalSeen); 
	movs	r2, r3	@ _34, _33
	ldr	r3, .L67+64	@ tmp327,
	movs	r1, #3	@,
	movs	r0, r3	@, tmp327
	ldr	r3, .L67+68	@ tmp328,
	bl	.L44		@
@ Pokedex.c:318: 	DrawUiNumber(&gBG0MapBuffer[18][9],TEXT_COLOR_GOLD,  proc->TotalCaught);
	ldr	r3, [r7, #108]	@ tmp329, proc
	movs	r2, #50	@ tmp330,
	ldrb	r3, [r3, r2]	@ _35,
@ Pokedex.c:318: 	DrawUiNumber(&gBG0MapBuffer[18][9],TEXT_COLOR_GOLD,  proc->TotalCaught);
	movs	r2, r3	@ _36, _35
	ldr	r3, .L67+72	@ tmp331,
	movs	r1, #3	@,
	movs	r0, r3	@, tmp331
	ldr	r3, .L67+68	@ tmp332,
	bl	.L44		@
@ Pokedex.c:319: 	BgMap_ApplyTsa(&gBG1MapBuffer[16][1], &PokedexSeenCaughtBox, 0);
	ldr	r1, .L67+76	@ tmp333,
	ldr	r3, .L67+80	@ tmp334,
	movs	r2, #0	@,
	movs	r0, r3	@, tmp334
	ldr	r3, .L67+84	@ tmp335,
	bl	.L44		@
@ Pokedex.c:322: 	EndFaceById(0);
	movs	r0, #0	@,
	ldr	r3, .L67+88	@ tmp336,
	bl	.L44		@
@ Pokedex.c:323: 	struct FaceProc* FaceProc = StartFace(0, ClassData->defaultPortraitId, 200, 4, 1);
	ldr	r3, [r7, #80]	@ tmp337, ClassData
	ldrh	r3, [r3, #8]	@ _37,
@ Pokedex.c:323: 	struct FaceProc* FaceProc = StartFace(0, ClassData->defaultPortraitId, 200, 4, 1);
	movs	r1, r3	@ _38, _37
	movs	r3, #1	@ tmp338,
	str	r3, [sp]	@ tmp338,
	movs	r3, #4	@,
	movs	r2, #200	@,
	movs	r0, #0	@,
	ldr	r4, .L67+92	@ tmp339,
	bl	.L45		@
	movs	r3, r0	@ tmp340,
	str	r3, [r7, #76]	@ tmp340, FaceProc
@ Pokedex.c:324: 	FaceProc->tileData &= ~(3 << 10); // Clear bits 10 and 11 (priority) such that they are 0 (highest priority) and appear above the background 
	ldr	r3, [r7, #76]	@ tmp341, FaceProc
	ldrh	r3, [r3, #60]	@ _39,
	ldr	r2, .L67+96	@ tmp343,
	ands	r3, r2	@ tmp342, tmp343
	lsls	r3, r3, #16	@ tmp344, tmp342,
	lsrs	r2, r3, #16	@ _40, tmp344,
	ldr	r3, [r7, #76]	@ tmp345, FaceProc
	strh	r2, [r3, #60]	@ tmp346, FaceProc_144->tileData
@ Pokedex.c:326: 	BgMap_ApplyTsa(&gBG1MapBuffer[0][20], &PokedexPortraitBox, 0);
	ldr	r1, .L67+100	@ tmp347,
	ldr	r3, .L67+104	@ tmp348,
	movs	r2, #0	@,
	movs	r0, r3	@, tmp348
	ldr	r3, .L67+84	@ tmp349,
	bl	.L44		@
@ Pokedex.c:327: 	BgMap_ApplyTsa(&gBG1MapBuffer[14][12], &PokedexDescBox, 0);
	ldr	r1, .L67+108	@ tmp350,
	ldr	r3, .L67+112	@ tmp351,
	movs	r2, #0	@,
	movs	r0, r3	@, tmp351
	ldr	r3, .L67+84	@ tmp352,
	bl	.L44		@
@ Pokedex.c:331: 	if (!seen)
	movs	r3, #62	@ tmp588,
	movs	r1, #24	@ tmp684,
	adds	r3, r3, r1	@ tmp683, tmp588, tmp684
	adds	r3, r3, r7	@ tmp353, tmp683,
	ldrb	r3, [r3]	@ tmp354, seen
	movs	r2, #1	@ tmp356,
	eors	r3, r2	@ tmp355, tmp356
	lsls	r3, r3, #24	@ tmp357, tmp355,
	lsrs	r3, r3, #24	@ _41, tmp357,
@ Pokedex.c:331: 	if (!seen)
	beq	.L52		@,
@ Pokedex.c:333: 		int paletteID = 22*32;
	movs	r3, #176	@ tmp570,
	lsls	r3, r3, #2	@ tmp358, tmp570,
	str	r3, [r7, #72]	@ tmp358, paletteID
@ Pokedex.c:334: 		int paletteSize = 32; 
	movs	r3, #32	@ tmp359,
	str	r3, [r7, #68]	@ tmp359, paletteSize
@ Pokedex.c:335: 		CopyToPaletteBuffer(MyPalette, paletteID, paletteSize); // source pointer, palette offset, size 
	ldr	r1, [r7, #72]	@ paletteID.4_42, paletteID
	ldr	r2, [r7, #68]	@ paletteSize.5_43, paletteSize
	ldr	r3, .L67+116	@ tmp360,
	movs	r0, r3	@, tmp360
	ldr	r3, .L67+120	@ tmp361,
	bl	.L44		@
@ Pokedex.c:336: 		gPaletteSyncFlag = 1;
	ldr	r3, .L67+124	@ tmp362,
	movs	r2, #1	@ tmp363,
	strb	r2, [r3]	@ tmp364, gPaletteSyncFlag
.L52:
@ Pokedex.c:339: 	LoadIconPalettes(4);
	movs	r0, #4	@,
	ldr	r3, .L67+128	@ tmp365,
	bl	.L44		@
@ Pokedex.c:340: 	ClearIcons();
	ldr	r3, .L67+132	@ tmp366,
	bl	.L44		@
@ Pokedex.c:341: 	EnableBgSyncByMask(BG0_SYNC_BIT);
	movs	r0, #1	@,
	ldr	r3, .L67+136	@ tmp367,
	bl	.L44		@
@ Pokedex.c:343: 	for (int x = 0; x < 17; x++) { // clear out most of bg0 
	movs	r3, #0	@ tmp368,
	str	r3, [r7, #124]	@ tmp368, x
@ Pokedex.c:343: 	for (int x = 0; x < 17; x++) { // clear out most of bg0 
	b	.L53		@
.L56:
@ Pokedex.c:344: 		for (int y = 0; y < 15; y++) { 
	movs	r3, #0	@ tmp369,
	movs	r2, #128	@ tmp682,
	adds	r2, r7, r2	@ tmp681,, tmp682
	str	r3, [r2]	@ tmp369, y
@ Pokedex.c:344: 		for (int y = 0; y < 15; y++) { 
	b	.L54		@
.L55:
@ Pokedex.c:345: 			gBG0MapBuffer[y][x] = 0;
	ldr	r3, .L67+140	@ tmp370,
	movs	r0, #128	@ tmp679,
	adds	r2, r7, r0	@ tmp678,, tmp679
	ldr	r2, [r2]	@ tmp371, y
	lsls	r1, r2, #5	@ tmp372, tmp371,
	ldr	r2, [r7, #124]	@ tmp374, x
	adds	r2, r1, r2	@ tmp373, tmp372, tmp374
	lsls	r2, r2, #1	@ tmp375, tmp373,
	movs	r1, #0	@ tmp376,
	strh	r1, [r2, r3]	@ tmp377, gBG0MapBuffer[y_58][x_60]
@ Pokedex.c:344: 		for (int y = 0; y < 15; y++) { 
	adds	r3, r7, r0	@ tmp675,, tmp676
	ldr	r3, [r3]	@ tmp379, y
	adds	r3, r3, #1	@ tmp378,
	adds	r2, r7, r0	@ tmp672,, tmp673
	str	r3, [r2]	@ tmp378, y
.L54:
@ Pokedex.c:344: 		for (int y = 0; y < 15; y++) { 
	movs	r3, #128	@ tmp670,
	adds	r3, r7, r3	@ tmp669,, tmp670
	ldr	r3, [r3]	@ tmp380, y
	cmp	r3, #14	@ tmp380,
	ble	.L55		@,
@ Pokedex.c:343: 	for (int x = 0; x < 17; x++) { // clear out most of bg0 
	ldr	r3, [r7, #124]	@ tmp382, x
	adds	r3, r3, #1	@ tmp381,
	str	r3, [r7, #124]	@ tmp381, x
.L53:
@ Pokedex.c:343: 	for (int x = 0; x < 17; x++) { // clear out most of bg0 
	ldr	r3, [r7, #124]	@ tmp383, x
	cmp	r3, #16	@ tmp383,
	ble	.L56		@,
@ Pokedex.c:349: 	if (caught)
	movs	r3, #63	@ tmp589,
	movs	r2, #24	@ tmp667,
	adds	r3, r3, r2	@ tmp666, tmp589, tmp667
	adds	r3, r3, r7	@ tmp384, tmp666,
	ldrb	r3, [r3]	@ tmp385, caught
	cmp	r3, #0	@ tmp385,
	beq	.L57		@,
@ Pokedex.c:351: 		DrawIcon(
	ldr	r3, [r7, #104]	@ tmp386, out
	adds	r3, r3, #12	@ _44,
	movs	r2, #128	@ tmp569,
	lsls	r2, r2, #7	@ tmp387, tmp569,
	movs	r1, #171	@,
	movs	r0, r3	@, _44
	ldr	r3, .L67+144	@ tmp388,
	bl	.L44		@
	b	.L58		@
.L68:
	.align	2
.L67:
	.word	gBg0MapBuffer
	.word	CheckIfCaught
	.word	CheckIfSeen
	.word	GetClassData
	.word	Text_Clear
	.word	Text_ResetTileAllocation
	.word	GetStringFromIndex
	.word	Text_DrawString
	.word	Text_Display
	.word	Text_SetColorId
	.word	Text_SetXCursor
	.word	.LC23
	.word	memset
	.word	gpCurrentFont
	.word	.LC27
	.word	.LC29
	.word	gBG0MapBuffer+1042
	.word	DrawUiNumber
	.word	gBG0MapBuffer+1170
	.word	PokedexSeenCaughtBox
	.word	gBG1MapBuffer+1026
	.word	BgMap_ApplyTsa
	.word	EndFaceById
	.word	StartFace
	.word	-3073
	.word	PokedexPortraitBox
	.word	gBG1MapBuffer+40
	.word	PokedexDescBox
	.word	gBG1MapBuffer+920
	.word	MyPalette
	.word	CopyToPaletteBuffer
	.word	gPaletteSyncFlag
	.word	LoadIconPalettes
	.word	ClearIcons
	.word	EnableBgSyncByMask
	.word	gBG0MapBuffer
	.word	DrawIcon
.L57:
@ Pokedex.c:357: 		DrawIcon(
	ldr	r3, [r7, #104]	@ tmp389, out
	adds	r3, r3, #12	@ _45,
	movs	r2, #128	@ tmp568,
	lsls	r2, r2, #7	@ tmp390, tmp568,
	movs	r1, #170	@,
	movs	r0, r3	@, _45
	ldr	r3, .L69	@ tmp391,
	bl	.L44		@
.L58:
@ Pokedex.c:363: 	BgMap_ApplyTsa(&gBG1MapBuffer[0][2], &PokedexNumberBox, 0);
	ldr	r1, .L69+4	@ tmp392,
	ldr	r3, .L69+8	@ tmp393,
	movs	r2, #0	@,
	movs	r0, r3	@, tmp393
	ldr	r3, .L69+12	@ tmp394,
	bl	.L44		@
@ Pokedex.c:364: 	DrawUiNumber(&gBG0MapBuffer[1][5], TEXT_COLOR_GOLD, PokedexTable[proc->menuIndex].IndexNumber);
	ldr	r3, [r7, #108]	@ tmp395, proc
	movs	r2, #48	@ tmp396,
	ldrb	r3, [r3, r2]	@ _46,
	movs	r2, r3	@ _47, _46
@ Pokedex.c:364: 	DrawUiNumber(&gBG0MapBuffer[1][5], TEXT_COLOR_GOLD, PokedexTable[proc->menuIndex].IndexNumber);
	ldr	r3, .L69+16	@ tmp397,
	lsls	r2, r2, #2	@ tmp398, _47,
	ldrb	r3, [r2, r3]	@ _48, PokedexTable
@ Pokedex.c:364: 	DrawUiNumber(&gBG0MapBuffer[1][5], TEXT_COLOR_GOLD, PokedexTable[proc->menuIndex].IndexNumber);
	movs	r2, r3	@ _49, _48
	ldr	r3, .L69+20	@ tmp399,
	movs	r1, #3	@,
	movs	r0, r3	@, tmp399
	ldr	r3, .L69+24	@ tmp400,
	bl	.L44		@
@ Pokedex.c:367: 	char* string = GetStringFromIndex(PokedexTable[proc->menuIndex].textID);
	ldr	r3, [r7, #108]	@ tmp401, proc
	movs	r2, #48	@ tmp402,
	ldrb	r3, [r3, r2]	@ _50,
@ Pokedex.c:367: 	char* string = GetStringFromIndex(PokedexTable[proc->menuIndex].textID);
	ldr	r2, .L69+16	@ tmp403,
	lsls	r3, r3, #2	@ tmp404, _51,
	adds	r3, r2, r3	@ tmp405, tmp403, tmp404
	adds	r3, r3, #2	@ tmp406,
	ldrh	r3, [r3]	@ _52, PokedexTable
@ Pokedex.c:367: 	char* string = GetStringFromIndex(PokedexTable[proc->menuIndex].textID);
	movs	r0, r3	@, _53
	ldr	r3, .L69+28	@ tmp407,
	bl	.L44		@
	movs	r3, r0	@ tmp408,
	str	r3, [r7, #64]	@ tmp408, string
@ Pokedex.c:368: 	int lines = GetNumLines(string);
	ldr	r3, [r7, #64]	@ tmp409, string
	movs	r0, r3	@, tmp409
	bl	GetNumLines		@
	movs	r3, r0	@ tmp410,
	str	r3, [r7, #60]	@ tmp410, lines
@ Pokedex.c:369: 	TextHandle handles[lines];
	ldr	r3, [r7, #60]	@ lines.6_164, lines
@ Pokedex.c:369: 	TextHandle handles[lines];
	subs	r2, r3, #1	@ _54, lines.6_164,
	str	r2, [r7, #56]	@ _54, D.7631
	movs	r2, r3	@ lines.7_56, lines.6_164
	str	r2, [r7, #8]	@ lines.7_56, %sfp
	movs	r2, #0	@ tmp411,
	str	r2, [r7, #12]	@ tmp411, %sfp
	ldr	r0, [r7, #8]	@ _57, %sfp
	ldr	r1, [r7, #12]	@ _57, %sfp
	movs	r2, r0	@ tmp590, _57
	lsrs	r2, r2, #26	@ tmp412, tmp590,
	movs	r4, r1	@ tmp592, _57
	lsls	r4, r4, #6	@ tmp591, tmp592,
	str	r4, [r7, #20]	@ tmp591, %sfp
	ldr	r4, [r7, #20]	@ tmp593, %sfp
	orrs	r4, r2	@ tmp593, tmp412
	str	r4, [r7, #20]	@ tmp593, %sfp
	movs	r2, r0	@ tmp595, _57
	lsls	r2, r2, #6	@ tmp594, tmp595,
	str	r2, [r7, #16]	@ tmp594, %sfp
	movs	r2, r3	@ lines.9_61, lines.6_164
	str	r2, [r7]	@ lines.9_61, %sfp
	movs	r2, #0	@ tmp413,
	str	r2, [r7, #4]	@ tmp413, %sfp
	ldr	r0, [r7]	@ _62, %sfp
	ldr	r1, [r7, #4]	@ _62, %sfp
	movs	r2, r0	@ tmp596, _62
	lsrs	r2, r2, #26	@ tmp414, tmp596,
	movs	r4, r1	@ tmp597, _62
	lsls	r6, r4, #6	@ _168, tmp597,
	orrs	r6, r2	@ _168, tmp414
	movs	r2, r0	@ tmp598, _62
	lsls	r5, r2, #6	@ _168, tmp598,
	lsls	r3, r3, #3	@ _169, lines.10_64,
	adds	r3, r3, #7	@ tmp415,
	lsrs	r3, r3, #3	@ tmp416, tmp415,
	lsls	r3, r3, #3	@ tmp417, tmp416,
	mov	r2, sp	@ tmp600,
	subs	r3, r2, r3	@ tmp599, tmp600, tmp417
	mov	sp, r3	@, tmp599
	add	r3, sp, #8	@ tmp418,,
	adds	r3, r3, #1	@ tmp419,
	lsrs	r3, r3, #1	@ tmp420, tmp419,
	lsls	r3, r3, #1	@ tmp421, tmp420,
	str	r3, [r7, #52]	@ tmp421, handles.11
@ Pokedex.c:370: 	for ( int i = 0 ; i < lines ; i++ )
	movs	r3, #0	@ tmp422,
	movs	r2, #132	@ tmp665,
	adds	r2, r7, r2	@ tmp664,, tmp665
	str	r3, [r2]	@ tmp422, i
@ Pokedex.c:370: 	for ( int i = 0 ; i < lines ; i++ )
	b	.L59		@
.L60:
@ Pokedex.c:372: 		handles[i].tileIndexOffset = gpCurrentFont->tileNext+tile;
	ldr	r3, .L69+32	@ tmp423,
	ldr	r3, [r3]	@ gpCurrentFont.12_66, gpCurrentFont
	ldrh	r2, [r3, #18]	@ _67,
@ Pokedex.c:372: 		handles[i].tileIndexOffset = gpCurrentFont->tileNext+tile;
	ldr	r3, [r7, #120]	@ tmp425, tile
	lsls	r3, r3, #16	@ tmp426, tmp424,
	lsrs	r3, r3, #16	@ _68, tmp426,
	adds	r3, r2, r3	@ tmp427, _67, _68
	lsls	r3, r3, #16	@ tmp428, tmp427,
	lsrs	r1, r3, #16	@ _69, tmp428,
@ Pokedex.c:372: 		handles[i].tileIndexOffset = gpCurrentFont->tileNext+tile;
	ldr	r3, [r7, #52]	@ tmp429, handles.11
	movs	r0, #132	@ tmp662,
	adds	r2, r7, r0	@ tmp661,, tmp662
	ldr	r2, [r2]	@ tmp430, i
	lsls	r2, r2, #3	@ tmp431, tmp430,
	strh	r1, [r2, r3]	@ tmp432, (*handles.11_171)[i_55].tileIndexOffset
@ Pokedex.c:373: 		handles[i].xCursor = 0;
	ldr	r2, [r7, #52]	@ tmp433, handles.11
	movs	r1, r0	@ tmp659, tmp662
	adds	r3, r7, r1	@ tmp658,, tmp659
	ldr	r3, [r3]	@ tmp434, i
	lsls	r3, r3, #3	@ tmp435, tmp434,
	adds	r3, r2, r3	@ tmp436, tmp433, tmp435
	adds	r3, r3, #2	@ tmp437,
	movs	r2, #0	@ tmp438,
	strb	r2, [r3]	@ tmp439, (*handles.11_171)[i_55].xCursor
@ Pokedex.c:374: 		handles[i].colorId = TEXT_COLOR_NORMAL;
	ldr	r2, [r7, #52]	@ tmp440, handles.11
	adds	r3, r7, r1	@ tmp655,, tmp656
	ldr	r3, [r3]	@ tmp441, i
	lsls	r3, r3, #3	@ tmp442, tmp441,
	adds	r3, r2, r3	@ tmp443, tmp440, tmp442
	adds	r3, r3, #3	@ tmp444,
	movs	r2, #0	@ tmp445,
	strb	r2, [r3]	@ tmp446, (*handles.11_171)[i_55].colorId
@ Pokedex.c:375: 		handles[i].tileWidth = 17;
	ldr	r2, [r7, #52]	@ tmp447, handles.11
	adds	r3, r7, r1	@ tmp652,, tmp653
	ldr	r3, [r3]	@ tmp448, i
	lsls	r3, r3, #3	@ tmp449, tmp448,
	adds	r3, r2, r3	@ tmp450, tmp447, tmp449
	adds	r3, r3, #4	@ tmp451,
	movs	r2, #17	@ tmp452,
	strb	r2, [r3]	@ tmp453, (*handles.11_171)[i_55].tileWidth
@ Pokedex.c:376: 		handles[i].useDoubleBuffer = 0;
	ldr	r2, [r7, #52]	@ tmp454, handles.11
	adds	r3, r7, r1	@ tmp649,, tmp650
	ldr	r3, [r3]	@ tmp455, i
	lsls	r3, r3, #3	@ tmp456, tmp455,
	adds	r3, r2, r3	@ tmp457, tmp454, tmp456
	adds	r3, r3, #5	@ tmp458,
	movs	r2, #0	@ tmp459,
	strb	r2, [r3]	@ tmp460, (*handles.11_171)[i_55].useDoubleBuffer
@ Pokedex.c:377: 		handles[i].currentBufferId = 0;
	ldr	r2, [r7, #52]	@ tmp461, handles.11
	adds	r3, r7, r1	@ tmp646,, tmp647
	ldr	r3, [r3]	@ tmp462, i
	lsls	r3, r3, #3	@ tmp463, tmp462,
	adds	r3, r2, r3	@ tmp464, tmp461, tmp463
	adds	r3, r3, #6	@ tmp465,
	movs	r2, #0	@ tmp466,
	strb	r2, [r3]	@ tmp467, (*handles.11_171)[i_55].currentBufferId
@ Pokedex.c:378: 		handles[i].unk07 = 0;
	ldr	r2, [r7, #52]	@ tmp468, handles.11
	adds	r3, r7, r1	@ tmp643,, tmp644
	ldr	r3, [r3]	@ tmp469, i
	lsls	r3, r3, #3	@ tmp470, tmp469,
	adds	r3, r2, r3	@ tmp471, tmp468, tmp470
	adds	r3, r3, #7	@ tmp472,
	movs	r2, #0	@ tmp473,
	strb	r2, [r3]	@ tmp474, (*handles.11_171)[i_55].unk07
@ Pokedex.c:379: 		tile += 17;
	ldr	r3, [r7, #120]	@ tmp476, tile
	adds	r3, r3, #17	@ tmp475,
	str	r3, [r7, #120]	@ tmp475, tile
@ Pokedex.c:380: 		Text_Clear(&handles[i]);
	movs	r4, r1	@ tmp641, tmp641
	adds	r3, r7, r1	@ tmp640,, tmp641
	ldr	r3, [r3]	@ tmp478, i
	lsls	r3, r3, #3	@ tmp477, tmp478,
	ldr	r2, [r7, #52]	@ tmp479, handles.11
	adds	r3, r2, r3	@ _70, tmp479, tmp477
@ Pokedex.c:380: 		Text_Clear(&handles[i]);
	movs	r0, r3	@, _70
	ldr	r3, .L69+36	@ tmp480,
	bl	.L44		@
@ Pokedex.c:370: 	for ( int i = 0 ; i < lines ; i++ )
	adds	r3, r7, r4	@ tmp637,, tmp638
	ldr	r3, [r3]	@ tmp482, i
	adds	r3, r3, #1	@ tmp481,
	adds	r2, r7, r4	@ tmp634,, tmp635
	str	r3, [r2]	@ tmp481, i
.L59:
@ Pokedex.c:370: 	for ( int i = 0 ; i < lines ; i++ )
	movs	r3, #132	@ tmp632,
	adds	r3, r7, r3	@ tmp631,, tmp632
	ldr	r2, [r3]	@ tmp483, i
	ldr	r3, [r7, #60]	@ tmp484, lines
	cmp	r2, r3	@ tmp483, tmp484
	blt	.L60		@,
@ Pokedex.c:382: 	if (seen & (!caught)) { 
	movs	r3, #62	@ tmp601,
	movs	r1, #24	@ tmp629,
	adds	r3, r3, r1	@ tmp628, tmp601, tmp629
	adds	r3, r3, r7	@ tmp485, tmp628,
	ldrb	r3, [r3]	@ _71, seen
@ Pokedex.c:382: 	if (seen & (!caught)) { 
	movs	r2, #63	@ tmp602,
	adds	r2, r2, r1	@ tmp626, tmp602, tmp627
	adds	r2, r2, r7	@ tmp486, tmp626,
	ldrb	r2, [r2]	@ tmp487, caught
	movs	r1, #1	@ tmp489,
	eors	r2, r1	@ tmp488, tmp489
	lsls	r2, r2, #24	@ tmp490, tmp488,
	lsrs	r2, r2, #24	@ _72, tmp490,
@ Pokedex.c:382: 	if (seen & (!caught)) { 
	ands	r3, r2	@ _74, _73
@ Pokedex.c:382: 	if (seen & (!caught)) { 
	beq	.L61		@,
@ Pokedex.c:383: 		DrawMultiline(handles, string, 1);
	ldr	r1, [r7, #64]	@ tmp491, string
	ldr	r3, [r7, #52]	@ tmp492, handles.11
	movs	r2, #1	@,
	movs	r0, r3	@, tmp492
	bl	DrawMultiline		@
@ Pokedex.c:384: 		DrawRawText(handles[1],"   ...   ...   ...   ...   ...   ...   ...   ...   ...",12,16);
	ldr	r0, .L69+40	@ tmp493,
	ldr	r3, [r7, #52]	@ tmp494, handles.11
	movs	r2, #16	@ tmp495,
	str	r2, [sp]	@ tmp495,
	ldrh	r2, [r3, #8]	@ tmp498, (*handles.11_171)[1]
	ldrh	r1, [r3, #10]	@ tmp499, (*handles.11_171)[1]
	lsls	r1, r1, #16	@ tmp500, tmp499,
	orrs	r2, r1	@ tmp501, tmp500
	movs	r4, r2	@ tmp496, tmp501
	ldrh	r2, [r3, #12]	@ tmp504, (*handles.11_171)[1]
	ldrh	r3, [r3, #14]	@ tmp505, (*handles.11_171)[1]
	lsls	r3, r3, #16	@ tmp506, tmp505,
	orrs	r3, r2	@ tmp507, tmp504
	movs	r1, r3	@ tmp502, tmp507
	movs	r3, #12	@,
	movs	r2, r0	@, tmp493
	movs	r0, r4	@, tmp496
	bl	DrawRawText		@
@ Pokedex.c:385: 		DrawRawText(handles[2],"              MISSING DATA",12,18);
	ldr	r0, .L69+44	@ tmp508,
	ldr	r3, [r7, #52]	@ tmp509, handles.11
	movs	r2, #18	@ tmp510,
	str	r2, [sp]	@ tmp510,
	ldrh	r2, [r3, #16]	@ tmp513, (*handles.11_171)[2]
	ldrh	r1, [r3, #18]	@ tmp514, (*handles.11_171)[2]
	lsls	r1, r1, #16	@ tmp515, tmp514,
	orrs	r2, r1	@ tmp516, tmp515
	movs	r4, r2	@ tmp511, tmp516
	ldrh	r2, [r3, #20]	@ tmp519, (*handles.11_171)[2]
	ldrh	r3, [r3, #22]	@ tmp520, (*handles.11_171)[2]
	lsls	r3, r3, #16	@ tmp521, tmp520,
	orrs	r3, r2	@ tmp522, tmp519
	movs	r1, r3	@ tmp517, tmp522
	movs	r3, #12	@,
	movs	r2, r0	@, tmp508
	movs	r0, r4	@, tmp511
	bl	DrawRawText		@
@ Pokedex.c:386: 		Text_Display(&handles[0],&gBG0MapBuffer[14+2*0][12]);
	ldr	r3, [r7, #52]	@ _75, handles.11
@ Pokedex.c:386: 		Text_Display(&handles[0],&gBG0MapBuffer[14+2*0][12]);
	ldr	r2, .L69+48	@ tmp523,
	movs	r1, r2	@, tmp523
	movs	r0, r3	@, _75
	ldr	r3, .L69+52	@ tmp524,
	bl	.L44		@
.L61:
@ Pokedex.c:388: 	if (!(seen | caught)) { 
	movs	r3, #62	@ tmp603,
	movs	r1, #24	@ tmp625,
	adds	r3, r3, r1	@ tmp624, tmp603, tmp625
	adds	r2, r3, r7	@ tmp525, tmp624,
	movs	r3, #63	@ tmp604,
	adds	r3, r3, r1	@ tmp622, tmp604, tmp623
	adds	r3, r3, r7	@ tmp526, tmp622,
	ldrb	r2, [r2]	@ tmp527, seen
	ldrb	r3, [r3]	@ tmp528, caught
	orrs	r3, r2	@ tmp529, tmp527
	lsls	r3, r3, #24	@ tmp530, tmp529,
	lsrs	r3, r3, #24	@ _76, tmp530,
@ Pokedex.c:388: 	if (!(seen | caught)) { 
	movs	r2, #1	@ tmp532,
	eors	r3, r2	@ tmp531, tmp532
	lsls	r3, r3, #24	@ tmp533, tmp531,
	lsrs	r3, r3, #24	@ _77, tmp533,
@ Pokedex.c:388: 	if (!(seen | caught)) { 
	beq	.L62		@,
@ Pokedex.c:389: 		DrawRawText(handles[0],"No Data",12,14);
	ldr	r0, .L69+56	@ tmp534,
	ldr	r3, [r7, #52]	@ tmp535, handles.11
	movs	r2, #14	@ tmp536,
	str	r2, [sp]	@ tmp536,
	ldrh	r2, [r3]	@ tmp539, (*handles.11_171)[0]
	ldrh	r1, [r3, #2]	@ tmp540, (*handles.11_171)[0]
	lsls	r1, r1, #16	@ tmp541, tmp540,
	orrs	r2, r1	@ tmp542, tmp541
	movs	r4, r2	@ tmp537, tmp542
	ldrh	r2, [r3, #4]	@ tmp545, (*handles.11_171)[0]
	ldrh	r3, [r3, #6]	@ tmp546, (*handles.11_171)[0]
	lsls	r3, r3, #16	@ tmp547, tmp546,
	orrs	r3, r2	@ tmp548, tmp545
	movs	r1, r3	@ tmp543, tmp548
	movs	r3, #12	@,
	movs	r2, r0	@, tmp534
	movs	r0, r4	@, tmp537
	bl	DrawRawText		@
.L62:
@ Pokedex.c:391: 	if (caught) {
	movs	r3, #63	@ tmp605,
	movs	r2, #24	@ tmp621,
	adds	r3, r3, r2	@ tmp620, tmp605, tmp621
	adds	r3, r3, r7	@ tmp549, tmp620,
	ldrb	r3, [r3]	@ tmp550, caught
	cmp	r3, #0	@ tmp550,
	beq	.L63		@,
@ Pokedex.c:392: 		DrawMultiline(handles, string, lines);
	ldr	r2, [r7, #60]	@ tmp551, lines
	ldr	r1, [r7, #64]	@ tmp552, string
	ldr	r3, [r7, #52]	@ tmp553, handles.11
	movs	r0, r3	@, tmp553
	bl	DrawMultiline		@
@ Pokedex.c:394: 		for ( int i = 0 ; i < lines ; i++ )
	movs	r3, #0	@ tmp554,
	str	r3, [r7, #112]	@ tmp554, i
@ Pokedex.c:394: 		for ( int i = 0 ; i < lines ; i++ )
	b	.L64		@
.L65:
@ Pokedex.c:396: 			Text_Display(&handles[i],&gBG0MapBuffer[14+2*i][12]);
	ldr	r3, [r7, #112]	@ tmp556, i
	lsls	r3, r3, #3	@ tmp555, tmp556,
	ldr	r2, [r7, #52]	@ tmp557, handles.11
	adds	r0, r2, r3	@ _78, tmp557, tmp555
@ Pokedex.c:396: 			Text_Display(&handles[i],&gBG0MapBuffer[14+2*i][12]);
	ldr	r3, [r7, #112]	@ tmp558, i
	adds	r3, r3, #7	@ _79,
	lsls	r3, r3, #1	@ _80, _79,
@ Pokedex.c:396: 			Text_Display(&handles[i],&gBG0MapBuffer[14+2*i][12]);
	lsls	r3, r3, #6	@ tmp559, _80,
	adds	r3, r3, #24	@ tmp559,
	movs	r2, r3	@ tmp560, tmp559
	ldr	r3, .L69+60	@ tmp561,
	adds	r3, r2, r3	@ _81, tmp560, tmp561
	movs	r1, r3	@, _81
	ldr	r3, .L69+52	@ tmp562,
	bl	.L44		@
@ Pokedex.c:394: 		for ( int i = 0 ; i < lines ; i++ )
	ldr	r3, [r7, #112]	@ tmp564, i
	adds	r3, r3, #1	@ tmp563,
	str	r3, [r7, #112]	@ tmp563, i
.L64:
@ Pokedex.c:394: 		for ( int i = 0 ; i < lines ; i++ )
	ldr	r2, [r7, #112]	@ tmp565, i
	ldr	r3, [r7, #60]	@ tmp566, lines
	cmp	r2, r3	@ tmp565, tmp566
	blt	.L65		@,
.L63:
@ Pokedex.c:400:     return ME_NONE;
	movs	r3, #0	@ _182,
	mov	sp, r8	@, saved_stack.13_96
@ Pokedex.c:401: }
	movs	r0, r3	@, <retval>
	mov	sp, r7	@,
	add	sp, sp, #136	@,,
	@ sp needed	@
	pop	{r7}
	mov	r8, r7
	pop	{r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L70:
	.align	2
.L69:
	.word	DrawIcon
	.word	PokedexNumberBox
	.word	gBG1MapBuffer+4
	.word	BgMap_ApplyTsa
	.word	PokedexTable
	.word	gBG0MapBuffer+74
	.word	DrawUiNumber
	.word	GetStringFromIndex
	.word	gpCurrentFont
	.word	Text_Clear
	.word	.LC55
	.word	.LC57
	.word	gBG0MapBuffer+920
	.word	Text_Display
	.word	.LC60
	.word	gBG0MapBuffer
	.size	PokedexDrawIdle, .-PokedexDrawIdle
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	DrawMultiline, %function
DrawMultiline:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 32
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r7, lr}	@
	sub	sp, sp, #36	@,,
	add	r7, sp, #0	@,,
	str	r0, [r7, #12]	@ handles, handles
	str	r1, [r7, #8]	@ string, string
	str	r2, [r7, #4]	@ lines, lines
@ Pokedex.c:410:     int j = 0;
	movs	r3, #0	@ tmp124,
	str	r3, [r7, #28]	@ tmp124, j
@ Pokedex.c:411:     for ( int i = 0 ; i < lines ; i++ )
	movs	r3, #0	@ tmp125,
	str	r3, [r7, #24]	@ tmp125, i
@ Pokedex.c:411:     for ( int i = 0 ; i < lines ; i++ )
	b	.L72		@
.L76:
@ Pokedex.c:413:         int k = 0;
	movs	r3, #0	@ tmp126,
	str	r3, [r7, #20]	@ tmp126, k
@ Pokedex.c:414:         for ( ; string[j] && string[j] != NL ; k++ )
	b	.L73		@
.L75:
@ Pokedex.c:416:             gGenericBuffer[k] = string[j];
	ldr	r3, [r7, #28]	@ j.14_1, j
	ldr	r2, [r7, #8]	@ tmp127, string
	adds	r3, r2, r3	@ _2, tmp127, j.14_1
	ldrb	r1, [r3]	@ _3, *_2
@ Pokedex.c:416:             gGenericBuffer[k] = string[j];
	ldr	r2, .L77	@ tmp128,
	ldr	r3, [r7, #20]	@ tmp130, k
	adds	r3, r2, r3	@ tmp129, tmp128, tmp130
	adds	r2, r1, #0	@ tmp131, _3
	strb	r2, [r3]	@ tmp131, gGenericBuffer[k_16]
@ Pokedex.c:417:             j++;
	ldr	r3, [r7, #28]	@ tmp133, j
	adds	r3, r3, #1	@ tmp132,
	str	r3, [r7, #28]	@ tmp132, j
@ Pokedex.c:414:         for ( ; string[j] && string[j] != NL ; k++ )
	ldr	r3, [r7, #20]	@ tmp135, k
	adds	r3, r3, #1	@ tmp134,
	str	r3, [r7, #20]	@ tmp134, k
.L73:
@ Pokedex.c:414:         for ( ; string[j] && string[j] != NL ; k++ )
	ldr	r3, [r7, #28]	@ j.15_4, j
	ldr	r2, [r7, #8]	@ tmp136, string
	adds	r3, r2, r3	@ _5, tmp136, j.15_4
	ldrb	r3, [r3]	@ _6, *_5
@ Pokedex.c:414:         for ( ; string[j] && string[j] != NL ; k++ )
	cmp	r3, #0	@ _6,
	beq	.L74		@,
@ Pokedex.c:414:         for ( ; string[j] && string[j] != NL ; k++ )
	ldr	r3, [r7, #28]	@ j.16_7, j
	ldr	r2, [r7, #8]	@ tmp137, string
	adds	r3, r2, r3	@ _8, tmp137, j.16_7
	ldrb	r3, [r3]	@ _9, *_8
@ Pokedex.c:414:         for ( ; string[j] && string[j] != NL ; k++ )
	cmp	r3, #1	@ _9,
	bne	.L75		@,
.L74:
@ Pokedex.c:419:         gGenericBuffer[k] = 0;
	ldr	r2, .L77	@ tmp138,
	ldr	r3, [r7, #20]	@ tmp140, k
	adds	r3, r2, r3	@ tmp139, tmp138, tmp140
	movs	r2, #0	@ tmp141,
	strb	r2, [r3]	@ tmp142, gGenericBuffer[k_16]
@ Pokedex.c:420:         Text_InsertString(handles,0,handles->colorId,(char*)gGenericBuffer);
	ldr	r3, [r7, #12]	@ tmp143, handles
	ldrb	r3, [r3, #3]	@ _10,
@ Pokedex.c:420:         Text_InsertString(handles,0,handles->colorId,(char*)gGenericBuffer);
	movs	r2, r3	@ _11, _10
	ldr	r3, .L77	@ tmp144,
	ldr	r0, [r7, #12]	@ tmp145, handles
	movs	r1, #0	@,
	ldr	r4, .L77+4	@ tmp146,
	bl	.L45		@
@ Pokedex.c:422:         handles++;
	ldr	r3, [r7, #12]	@ tmp148, handles
	adds	r3, r3, #8	@ tmp147,
	str	r3, [r7, #12]	@ tmp147, handles
@ Pokedex.c:423:         j++;
	ldr	r3, [r7, #28]	@ tmp150, j
	adds	r3, r3, #1	@ tmp149,
	str	r3, [r7, #28]	@ tmp149, j
@ Pokedex.c:411:     for ( int i = 0 ; i < lines ; i++ )
	ldr	r3, [r7, #24]	@ tmp152, i
	adds	r3, r3, #1	@ tmp151,
	str	r3, [r7, #24]	@ tmp151, i
.L72:
@ Pokedex.c:411:     for ( int i = 0 ; i < lines ; i++ )
	ldr	r2, [r7, #24]	@ tmp153, i
	ldr	r3, [r7, #4]	@ tmp154, lines
	cmp	r2, r3	@ tmp153, tmp154
	blt	.L76		@,
@ Pokedex.c:425: }
	nop	
	nop	
	mov	sp, r7	@,
	add	sp, sp, #36	@,,
	@ sp needed	@
	pop	{r4, r7}
	pop	{r0}
	bx	r0
.L78:
	.align	2
.L77:
	.word	gGenericBuffer
	.word	Text_InsertString
	.size	DrawMultiline, .-DrawMultiline
	.align	1
	.global	Pokedex_OnSelect
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	Pokedex_OnSelect, %function
Pokedex_OnSelect:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 32
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}	@
	sub	sp, sp, #32	@,,
	add	r7, sp, #0	@,,
	str	r0, [r7, #4]	@ menu, menu
	str	r1, [r7]	@ command, command
@ Pokedex.c:434:     struct PokedexProc* proc = (void*) ProcStart(Proc_ChapterPokedex, ROOT_PROC_3);
	ldr	r3, .L86	@ tmp153,
	movs	r1, #3	@,
	movs	r0, r3	@, tmp153
	ldr	r3, .L86+4	@ tmp154,
	bl	.L44		@
	movs	r3, r0	@ tmp155,
	str	r3, [r7, #20]	@ tmp155, proc
@ Pokedex.c:436:     proc->menuIndex = 1;
	ldr	r3, [r7, #20]	@ tmp156, proc
	movs	r2, #48	@ tmp157,
	movs	r1, #1	@ tmp158,
	strb	r1, [r3, r2]	@ tmp159, proc_47->menuIndex
@ Pokedex.c:437: 	proc->TotalCaught = CountCaught();
	ldr	r3, .L86+8	@ tmp160,
	bl	.L44		@
	movs	r3, r0	@ _1,
@ Pokedex.c:437: 	proc->TotalCaught = CountCaught();
	lsls	r3, r3, #24	@ tmp161, _1,
	lsrs	r1, r3, #24	@ _2, tmp161,
	ldr	r3, [r7, #20]	@ tmp162, proc
	movs	r2, #50	@ tmp163,
	strb	r1, [r3, r2]	@ tmp164, proc_47->TotalCaught
@ Pokedex.c:438: 	proc->TotalSeen = CountSeen();
	ldr	r3, .L86+12	@ tmp165,
	bl	.L44		@
	movs	r3, r0	@ _3,
@ Pokedex.c:438: 	proc->TotalSeen = CountSeen();
	lsls	r3, r3, #24	@ tmp166, _3,
	lsrs	r1, r3, #24	@ _4, tmp166,
	ldr	r3, [r7, #20]	@ tmp167, proc
	movs	r2, #49	@ tmp168,
	strb	r1, [r3, r2]	@ tmp169, proc_47->TotalSeen
@ Pokedex.c:439: 	proc->caught = CheckIfCaught(proc->menuIndex);
	ldr	r3, [r7, #20]	@ tmp170, proc
	movs	r2, #48	@ tmp171,
	ldrb	r3, [r3, r2]	@ _5,
	movs	r0, r3	@, _5
	ldr	r3, .L86+16	@ tmp172,
	bl	.L44		@
	movs	r3, r0	@ _6,
	subs	r2, r3, #1	@ tmp175, _6
	sbcs	r3, r3, r2	@ tmp174, _6, tmp175
	lsls	r3, r3, #24	@ tmp176, tmp173,
	lsrs	r1, r3, #24	@ _7, tmp176,
@ Pokedex.c:439: 	proc->caught = CheckIfCaught(proc->menuIndex);
	ldr	r3, [r7, #20]	@ tmp177, proc
	movs	r2, #68	@ tmp178,
	strb	r1, [r3, r2]	@ tmp179, proc_47->caught
@ Pokedex.c:440: 	proc->seen = CheckIfSeen(proc->menuIndex);
	ldr	r3, [r7, #20]	@ tmp180, proc
	movs	r2, #48	@ tmp181,
	ldrb	r3, [r3, r2]	@ _8,
	movs	r0, r3	@, _8
	ldr	r3, .L86+20	@ tmp182,
	bl	.L44		@
	movs	r3, r0	@ _9,
	subs	r2, r3, #1	@ tmp185, _9
	sbcs	r3, r3, r2	@ tmp184, _9, tmp185
	lsls	r3, r3, #24	@ tmp186, tmp183,
	lsrs	r1, r3, #24	@ _10, tmp186,
@ Pokedex.c:440: 	proc->seen = CheckIfSeen(proc->menuIndex);
	ldr	r3, [r7, #20]	@ tmp187, proc
	movs	r2, #69	@ tmp188,
	strb	r1, [r3, r2]	@ tmp189, proc_47->seen
@ Pokedex.c:442: 	Decompress(WorldMap_img,(void*)0x600C000);
	ldr	r2, .L86+24	@ tmp190,
	ldr	r3, .L86+28	@ tmp191,
	movs	r1, r2	@, tmp190
	movs	r0, r3	@, tmp191
	ldr	r3, .L86+32	@ tmp192,
	bl	.L44		@
@ Pokedex.c:444: 	CopyToPaletteBuffer(WorldMap_pal,0x20*6,(gWorldMapPaletteCount-2)*32);
	ldr	r3, .L86+36	@ tmp193,
	ldrb	r3, [r3]	@ gWorldMapPaletteCount.17_11, gWorldMapPaletteCount
	subs	r3, r3, #2	@ _13,
@ Pokedex.c:444: 	CopyToPaletteBuffer(WorldMap_pal,0x20*6,(gWorldMapPaletteCount-2)*32);
	lsls	r3, r3, #5	@ _14, _13,
@ Pokedex.c:444: 	CopyToPaletteBuffer(WorldMap_pal,0x20*6,(gWorldMapPaletteCount-2)*32);
	movs	r2, r3	@ _15, _14
	ldr	r3, .L86+40	@ tmp194,
	movs	r1, #192	@,
	movs	r0, r3	@, tmp194
	ldr	r3, .L86+44	@ tmp195,
	bl	.L44		@
@ Pokedex.c:445: 	CopyToPaletteBuffer(WorldMap_pal+(gWorldMapPaletteCount-1)*16,0x20*15,32);
	ldr	r3, .L86+36	@ tmp196,
	ldrb	r3, [r3]	@ gWorldMapPaletteCount.18_16, gWorldMapPaletteCount
	subs	r3, r3, #1	@ _18,
@ Pokedex.c:445: 	CopyToPaletteBuffer(WorldMap_pal+(gWorldMapPaletteCount-1)*16,0x20*15,32);
	lsls	r2, r3, #5	@ _20, _19,
@ Pokedex.c:445: 	CopyToPaletteBuffer(WorldMap_pal+(gWorldMapPaletteCount-1)*16,0x20*15,32);
	ldr	r3, .L86+40	@ tmp197,
	adds	r3, r2, r3	@ _21, _20, tmp197
	movs	r2, #240	@ tmp278,
	lsls	r1, r2, #1	@ tmp198, tmp278,
	movs	r2, #32	@,
	movs	r0, r3	@, _21
	ldr	r3, .L86+44	@ tmp199,
	bl	.L44		@
@ Pokedex.c:447: 	memcpy(gGenericBuffer, WorldMap_tsa, 0x4B2);
	ldr	r2, .L86+48	@ tmp200,
	ldr	r1, .L86+52	@ tmp201,
	ldr	r3, .L86+56	@ tmp202,
	movs	r0, r3	@, tmp202
	ldr	r3, .L86+60	@ tmp203,
	bl	.L44		@
@ Pokedex.c:449: 	TSA* tsaBuffer = (TSA*)gGenericBuffer;
	ldr	r3, .L86+56	@ tmp204,
	str	r3, [r7, #16]	@ tmp204, tsaBuffer
@ Pokedex.c:450: 	for ( int i = 0 ; i < tsaBuffer->height+1 ; i++ )
	movs	r3, #0	@ tmp205,
	str	r3, [r7, #28]	@ tmp205, i
@ Pokedex.c:450: 	for ( int i = 0 ; i < tsaBuffer->height+1 ; i++ )
	b	.L80		@
.L84:
@ Pokedex.c:452: 		for ( int j = 0 ; j < tsaBuffer->width+1 ; j++ )
	movs	r3, #0	@ tmp206,
	str	r3, [r7, #24]	@ tmp206, j
@ Pokedex.c:452: 		for ( int j = 0 ; j < tsaBuffer->width+1 ; j++ )
	b	.L81		@
.L83:
@ Pokedex.c:454: 			if ( tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID == 16-6 )
	ldr	r3, [r7, #16]	@ tmp207, tsaBuffer
	ldrb	r3, [r3]	@ _22, *tsaBuffer_61
@ Pokedex.c:454: 			if ( tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID == 16-6 )
	adds	r3, r3, #1	@ _24,
@ Pokedex.c:454: 			if ( tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID == 16-6 )
	ldr	r2, [r7, #28]	@ tmp208, i
	muls	r2, r3	@ _25, _24
@ Pokedex.c:454: 			if ( tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID == 16-6 )
	ldr	r3, [r7, #24]	@ tmp209, j
	adds	r3, r2, r3	@ _26, _25, tmp209
@ Pokedex.c:454: 			if ( tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID == 16-6 )
	ldr	r2, [r7, #16]	@ tmp210, tsaBuffer
	lsls	r3, r3, #1	@ tmp211, _26,
	adds	r3, r2, r3	@ tmp214, tmp210, tmp211
	ldrb	r3, [r3, #3]	@ tmp215,
	lsls	r3, r3, #24	@ tmp217, tmp215,
	lsrs	r3, r3, #28	@ tmp216, tmp217,
	lsls	r3, r3, #24	@ tmp218, tmp216,
	lsrs	r3, r3, #24	@ _27, tmp218,
@ Pokedex.c:454: 			if ( tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID == 16-6 )
	cmp	r3, #10	@ _27,
	bne	.L82		@,
@ Pokedex.c:456: 				tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID--;
	ldr	r3, [r7, #16]	@ tmp219, tsaBuffer
	ldrb	r3, [r3]	@ _28, *tsaBuffer_61
@ Pokedex.c:456: 				tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID--;
	adds	r3, r3, #1	@ _30,
@ Pokedex.c:456: 				tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID--;
	ldr	r2, [r7, #28]	@ tmp220, i
	muls	r2, r3	@ _31, _30
@ Pokedex.c:456: 				tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID--;
	ldr	r3, [r7, #24]	@ tmp221, j
	adds	r3, r2, r3	@ _32, _31, tmp221
@ Pokedex.c:456: 				tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID--;
	ldr	r1, [r7, #16]	@ tmp222, tsaBuffer
	lsls	r2, r3, #1	@ tmp223, _32,
	adds	r2, r1, r2	@ tmp226, tmp222, tmp223
	ldrb	r2, [r2, #3]	@ tmp227,
	lsls	r2, r2, #24	@ tmp229, tmp227,
	lsrs	r2, r2, #28	@ tmp228, tmp229,
	lsls	r2, r2, #24	@ tmp230, tmp228,
	lsrs	r2, r2, #24	@ _33, tmp230,
@ Pokedex.c:456: 				tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID--;
	adds	r2, r2, #15	@ tmp231,
	adds	r1, r2, #0	@ tmp232, tmp231
	movs	r2, #15	@ tmp234,
	ands	r2, r1	@ tmp233, tmp232
	lsls	r2, r2, #24	@ tmp235, tmp233,
	lsrs	r2, r2, #24	@ _35, tmp235,
	ldr	r1, [r7, #16]	@ tmp236, tsaBuffer
	lsls	r3, r3, #1	@ tmp237, _32,
	adds	r3, r1, r3	@ tmp238, tmp236, tmp237
	lsls	r0, r2, #4	@ tmp240, _35,
	ldrb	r2, [r3, #3]	@ tmp241,
	movs	r1, #15	@ tmp243,
	ands	r2, r1	@ tmp242, tmp243
	adds	r1, r2, #0	@ tmp244, tmp242
	adds	r2, r0, #0	@ tmp245, tmp240
	orrs	r2, r1	@ tmp246, tmp244
	strb	r2, [r3, #3]	@ tmp247,
.L82:
@ Pokedex.c:452: 		for ( int j = 0 ; j < tsaBuffer->width+1 ; j++ )
	ldr	r3, [r7, #24]	@ tmp249, j
	adds	r3, r3, #1	@ tmp248,
	str	r3, [r7, #24]	@ tmp248, j
.L81:
@ Pokedex.c:452: 		for ( int j = 0 ; j < tsaBuffer->width+1 ; j++ )
	ldr	r3, [r7, #16]	@ tmp250, tsaBuffer
	ldrb	r3, [r3]	@ _36, *tsaBuffer_61
	movs	r2, r3	@ _37, _36
@ Pokedex.c:452: 		for ( int j = 0 ; j < tsaBuffer->width+1 ; j++ )
	ldr	r3, [r7, #24]	@ tmp251, j
	cmp	r3, r2	@ tmp251, _37
	ble	.L83		@,
@ Pokedex.c:450: 	for ( int i = 0 ; i < tsaBuffer->height+1 ; i++ )
	ldr	r3, [r7, #28]	@ tmp253, i
	adds	r3, r3, #1	@ tmp252,
	str	r3, [r7, #28]	@ tmp252, i
.L80:
@ Pokedex.c:450: 	for ( int i = 0 ; i < tsaBuffer->height+1 ; i++ )
	ldr	r3, [r7, #16]	@ tmp254, tsaBuffer
	ldrb	r3, [r3, #1]	@ _38,
	movs	r2, r3	@ _39, _38
@ Pokedex.c:450: 	for ( int i = 0 ; i < tsaBuffer->height+1 ; i++ )
	ldr	r3, [r7, #28]	@ tmp255, i
	cmp	r3, r2	@ tmp255, _39
	ble	.L84		@,
@ Pokedex.c:460: 	BgMap_ApplyTsa(gBg2MapBuffer,gGenericBuffer, 6<<12);
	movs	r3, #192	@ tmp276,
	lsls	r2, r3, #7	@ tmp256, tmp276,
	ldr	r1, .L86+56	@ tmp257,
	ldr	r3, .L86+64	@ tmp258,
	movs	r0, r3	@, tmp258
	ldr	r3, .L86+68	@ tmp259,
	bl	.L44		@
@ Pokedex.c:461: 	SetBgTileDataOffset(2,0xC000);
	movs	r3, #192	@ tmp277,
	lsls	r3, r3, #8	@ tmp260, tmp277,
	movs	r1, r3	@, tmp260
	movs	r0, #2	@,
	ldr	r3, .L86+72	@ tmp261,
	bl	.L44		@
@ Pokedex.c:463: 	struct LCDIOBuffer* LCDIOBuffer = &gLCDIOBuffer;
	ldr	r3, .L86+76	@ tmp262,
	str	r3, [r7, #12]	@ tmp262, LCDIOBuffer
@ Pokedex.c:464: 	LCDIOBuffer->bgOffset[3].x = 0; // make offset as 0, rather than scrolled to the right
	ldr	r3, [r7, #12]	@ tmp263, LCDIOBuffer
	movs	r2, #0	@ tmp264,
	strh	r2, [r3, #40]	@ tmp265, LCDIOBuffer_65->bgOffset[3].x
@ Pokedex.c:465: 	LCDIOBuffer->bgOffset[3].y = 0; 
	ldr	r3, [r7, #12]	@ tmp266, LCDIOBuffer
	movs	r2, #0	@ tmp267,
	strh	r2, [r3, #42]	@ tmp268, LCDIOBuffer_65->bgOffset[3].y
@ Pokedex.c:469: 	LoadIconPalettes(4);
	movs	r0, #4	@,
	ldr	r3, .L86+80	@ tmp269,
	bl	.L44		@
@ Pokedex.c:470: 	EnableBgSyncByMask(BG_SYNC_BIT(2)); // sync bg 3 
	movs	r0, #4	@,
	ldr	r3, .L86+84	@ tmp270,
	bl	.L44		@
@ Pokedex.c:471: 	EnablePaletteSync();
	ldr	r3, .L86+88	@ tmp271,
	bl	.L44		@
@ Pokedex.c:474:     StartMenuChild(&Menu_Pokedex, (void*) proc);
	ldr	r2, [r7, #20]	@ tmp272, proc
	ldr	r3, .L86+92	@ tmp273,
	movs	r1, r2	@, tmp272
	movs	r0, r3	@, tmp273
	ldr	r3, .L86+96	@ tmp274,
	bl	.L44		@
@ Pokedex.c:476:     return ME_DISABLE | ME_END | ME_PLAY_BEEP | ME_CLEAR_GFX;
	movs	r3, #23	@ _72,
@ Pokedex.c:477: }
	movs	r0, r3	@, <retval>
	mov	sp, r7	@,
	add	sp, sp, #32	@,,
	@ sp needed	@
	pop	{r7}
	pop	{r1}
	bx	r1
.L87:
	.align	2
.L86:
	.word	Proc_ChapterPokedex
	.word	ProcStart
	.word	CountCaught
	.word	CountSeen
	.word	CheckIfCaught
	.word	CheckIfSeen
	.word	100712448
	.word	WorldMap_img
	.word	Decompress
	.word	gWorldMapPaletteCount
	.word	WorldMap_pal
	.word	CopyToPaletteBuffer
	.word	1202
	.word	WorldMap_tsa
	.word	gGenericBuffer
	.word	memcpy
	.word	gBg2MapBuffer
	.word	BgMap_ApplyTsa
	.word	SetBgTileDataOffset
	.word	gLCDIOBuffer
	.word	LoadIconPalettes
	.word	EnableBgSyncByMask
	.word	EnablePaletteSync
	.word	Menu_Pokedex
	.word	StartMenuChild
	.size	Pokedex_OnSelect, .-Pokedex_OnSelect
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	PokedexDraw, %function
PokedexDraw:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}	@
	sub	sp, sp, #8	@,,
	add	r7, sp, #0	@,,
	str	r0, [r7, #4]	@ menu, menu
	str	r1, [r7]	@ command, command
@ Pokedex.c:481:     command->onCycle = (void*) PokedexDrawIdle(menu, command);
	ldr	r2, [r7]	@ tmp115, command
	ldr	r3, [r7, #4]	@ tmp116, menu
	movs	r1, r2	@, tmp115
	movs	r0, r3	@, tmp116
	bl	PokedexDrawIdle		@
	movs	r3, r0	@ _1,
@ Pokedex.c:481:     command->onCycle = (void*) PokedexDrawIdle(menu, command);
	movs	r2, r3	@ _2, _1
@ Pokedex.c:481:     command->onCycle = (void*) PokedexDrawIdle(menu, command);
	ldr	r3, [r7]	@ tmp117, command
	str	r2, [r3, #12]	@ _2, command_5(D)->onCycle
@ Pokedex.c:482: }
	nop	
	mov	sp, r7	@,
	add	sp, sp, #8	@,,
	@ sp needed	@
	pop	{r7}
	pop	{r0}
	bx	r0
	.size	PokedexDraw, .-PokedexDraw
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	CallPokedexMenuEnd, %function
CallPokedexMenuEnd:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}	@
	sub	sp, sp, #16	@,,
	add	r7, sp, #0	@,,
	str	r0, [r7, #4]	@ menu, menu
	str	r1, [r7]	@ command, command
@ Pokedex.c:486: 	PokedexMenuEnd(menu, command);
	ldr	r2, [r7]	@ tmp115, command
	ldr	r3, [r7, #4]	@ tmp116, menu
	movs	r1, r2	@, tmp115
	movs	r0, r3	@, tmp116
	bl	PokedexMenuEnd		@
@ Pokedex.c:487: 	struct Proc* const proc = (void*) menu->parent; // latter makes more sense, but gives warning as EndProc expects Proc*, not PokedexProc* 
	ldr	r3, [r7, #4]	@ tmp117, menu
	ldr	r3, [r3, #20]	@ tmp118, menu_2(D)->parent
	str	r3, [r7, #12]	@ tmp118, proc
@ Pokedex.c:489: 	EndProc(proc);
	ldr	r3, [r7, #12]	@ tmp119, proc
	movs	r0, r3	@, tmp119
	ldr	r3, .L91	@ tmp120,
	bl	.L44		@
@ Pokedex.c:490: 	UnlockGameLogic();
	ldr	r3, .L91+4	@ tmp121,
	bl	.L44		@
@ Pokedex.c:491: 	UnlockGameGraphicsLogic(); 
	ldr	r3, .L91+8	@ tmp122,
	bl	.L44		@
@ Pokedex.c:492: 	return true;
	movs	r3, #1	@ _9,
@ Pokedex.c:493: }
	movs	r0, r3	@, <retval>
	mov	sp, r7	@,
	add	sp, sp, #16	@,,
	@ sp needed	@
	pop	{r7}
	pop	{r1}
	bx	r1
.L92:
	.align	2
.L91:
	.word	EndProc
	.word	UnlockGameLogic
	.word	UnlockGameGraphicsLogic
	.size	CallPokedexMenuEnd, .-CallPokedexMenuEnd
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	PokedexMenuEnd, %function
PokedexMenuEnd:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}	@
	sub	sp, sp, #8	@,,
	add	r7, sp, #0	@,,
	str	r0, [r7, #4]	@ menu, menu
	str	r1, [r7]	@ command, command
@ Pokedex.c:496: 	EndFaceById(0);
	movs	r0, #0	@,
	ldr	r3, .L95	@ tmp116,
	bl	.L44		@
@ Pokedex.c:497: 	FillBgMap(gBg0MapBuffer,0);
	ldr	r3, .L95+4	@ tmp117,
	movs	r1, #0	@,
	movs	r0, r3	@, tmp117
	ldr	r3, .L95+8	@ tmp118,
	bl	.L44		@
@ Pokedex.c:498: 	FillBgMap(gBg1MapBuffer,0);
	ldr	r3, .L95+12	@ tmp119,
	movs	r1, #0	@,
	movs	r0, r3	@, tmp119
	ldr	r3, .L95+8	@ tmp120,
	bl	.L44		@
@ Pokedex.c:499: 	FillBgMap(gBg2MapBuffer,0);
	ldr	r3, .L95+16	@ tmp121,
	movs	r1, #0	@,
	movs	r0, r3	@, tmp121
	ldr	r3, .L95+8	@ tmp122,
	bl	.L44		@
@ Pokedex.c:500: 	EnableBgSyncByMask(1|2|4);
	movs	r0, #7	@,
	ldr	r3, .L95+20	@ tmp123,
	bl	.L44		@
@ Pokedex.c:501: 	UnpackChapterMapPalette(gChapterData.chapterIndex); 
	ldr	r3, .L95+24	@ tmp124,
	ldrb	r3, [r3, #14]	@ _1,
@ Pokedex.c:501: 	UnpackChapterMapPalette(gChapterData.chapterIndex); 
	movs	r0, r3	@, _2
	ldr	r3, .L95+28	@ tmp125,
	bl	.L44		@
@ Pokedex.c:502: 	UnpackChapterMapGraphics(gChapterData.chapterIndex); // 1 frame of messed up graphics 
	ldr	r3, .L95+24	@ tmp126,
	ldrb	r3, [r3, #14]	@ _3,
	movs	r0, r3	@, _3
	ldr	r3, .L95+32	@ tmp127,
	bl	.L44		@
@ Pokedex.c:509:     return;
	nop	
@ Pokedex.c:510: }
	mov	sp, r7	@,
	add	sp, sp, #8	@,,
	@ sp needed	@
	pop	{r7}
	pop	{r0}
	bx	r0
.L96:
	.align	2
.L95:
	.word	EndFaceById
	.word	gBg0MapBuffer
	.word	FillBgMap
	.word	gBg1MapBuffer
	.word	gBg2MapBuffer
	.word	EnableBgSyncByMask
	.word	gChapterData
	.word	UnpackChapterMapPalette
	.word	UnpackChapterMapGraphics
	.size	PokedexMenuEnd, .-PokedexMenuEnd
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	Pokedex_RetrieveAreasFound, %function
Pokedex_RetrieveAreasFound:
	@ Function supports interworking.
	@ args = 4, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}	@
	sub	sp, sp, #28	@,,
	add	r7, sp, #0	@,,
	str	r1, [r7, #8]	@ areaBitfield_A, areaBitfield_A
	str	r2, [r7, #4]	@ areaBitfield_B, areaBitfield_B
	str	r3, [r7]	@ areaBitfield_C, areaBitfield_C
	movs	r3, #15	@ tmp292,
	adds	r3, r7, r3	@ tmp159,, tmp292
	adds	r2, r0, #0	@ tmp160, tmp158
	strb	r2, [r3]	@ tmp160, classID
@ Pokedex.c:537: 	for (u16 i = 0 ; i <= 0x80 ; i++) 
	movs	r3, #22	@ tmp293,
	adds	r3, r7, r3	@ tmp161,, tmp293
	movs	r2, #0	@ tmp162,
	strh	r2, [r3]	@ tmp163, i
@ Pokedex.c:537: 	for (u16 i = 0 ; i <= 0x80 ; i++) 
	b	.L98		@
.L103:
@ Pokedex.c:539: 		u8 Chapter = MonsterSpawnTable[i].ChID;
	movs	r4, #22	@ tmp294,
	adds	r3, r7, r4	@ tmp164,, tmp294
	ldrh	r2, [r3]	@ _1, i
@ Pokedex.c:539: 		u8 Chapter = MonsterSpawnTable[i].ChID;
	movs	r6, #21	@ tmp295,
	adds	r1, r7, r6	@ tmp165,, tmp295
	ldr	r0, .L105	@ tmp166,
	movs	r3, r2	@ tmp167, _1
	lsls	r3, r3, #1	@ tmp167, tmp167,
	adds	r3, r3, r2	@ tmp167, tmp167, _1
	lsls	r3, r3, #2	@ tmp168, tmp167,
	adds	r3, r0, r3	@ tmp169, tmp166, tmp167
	adds	r3, r3, #10	@ tmp170,
	ldrb	r3, [r3]	@ tmp171, MonsterSpawnTable
	strb	r3, [r1]	@ tmp171, Chapter
@ Pokedex.c:540: 		if (Chapter)
	adds	r3, r7, r6	@ tmp172,, tmp296
	ldrb	r3, [r3]	@ tmp173, Chapter
	cmp	r3, #0	@ tmp173,
	bne	.LCB2194	@
	b	.L99	@long jump	@
.LCB2194:
@ Pokedex.c:543: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	adds	r3, r7, r4	@ tmp174,, tmp297
	ldrh	r2, [r3]	@ _2, i
	ldr	r1, .L105	@ tmp175,
	movs	r3, r2	@ tmp176, _2
	lsls	r3, r3, #1	@ tmp176, tmp176,
	adds	r3, r3, r2	@ tmp176, tmp176, _2
	lsls	r3, r3, #2	@ tmp177, tmp176,
	ldrb	r3, [r3, r1]	@ _3, MonsterSpawnTable
@ Pokedex.c:543: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	movs	r5, #15	@ tmp298,
	adds	r2, r7, r5	@ tmp178,, tmp298
	ldrb	r2, [r2]	@ tmp180, classID
	subs	r3, r2, r3	@ tmp182, tmp180, _3
	rsbs	r2, r3, #0	@ tmp183, tmp182
	adcs	r3, r3, r2	@ tmp181, tmp182, tmp183
	lsls	r3, r3, #24	@ tmp184, tmp179,
	lsrs	r1, r3, #24	@ _4, tmp184,
@ Pokedex.c:543: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	adds	r3, r7, r4	@ tmp185,, tmp299
	ldrh	r2, [r3]	@ _5, i
	ldr	r0, .L105	@ tmp186,
	movs	r3, r2	@ tmp187, _5
	lsls	r3, r3, #1	@ tmp187, tmp187,
	adds	r3, r3, r2	@ tmp187, tmp187, _5
	lsls	r3, r3, #2	@ tmp188, tmp187,
	adds	r3, r0, r3	@ tmp189, tmp186, tmp187
	adds	r3, r3, #1	@ tmp190,
	ldrb	r3, [r3]	@ _6, MonsterSpawnTable
@ Pokedex.c:543: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	adds	r2, r7, r5	@ tmp191,, tmp300
	ldrb	r2, [r2]	@ tmp193, classID
	subs	r3, r2, r3	@ tmp195, tmp193, _6
	rsbs	r2, r3, #0	@ tmp196, tmp195
	adcs	r3, r3, r2	@ tmp194, tmp195, tmp196
	lsls	r3, r3, #24	@ tmp197, tmp192,
	lsrs	r3, r3, #24	@ _7, tmp197,
	orrs	r3, r1	@ tmp198, _4
	lsls	r3, r3, #24	@ tmp199, tmp198,
	lsrs	r3, r3, #24	@ _8, tmp199,
	movs	r0, r3	@ _9, _8
@ Pokedex.c:543: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	adds	r3, r7, r4	@ tmp200,, tmp301
	ldrh	r2, [r3]	@ _10, i
	ldr	r1, .L105	@ tmp201,
	movs	r3, r2	@ tmp202, _10
	lsls	r3, r3, #1	@ tmp202, tmp202,
	adds	r3, r3, r2	@ tmp202, tmp202, _10
	lsls	r3, r3, #2	@ tmp203, tmp202,
	adds	r3, r1, r3	@ tmp204, tmp201, tmp202
	adds	r3, r3, #2	@ tmp205,
	ldrb	r3, [r3]	@ _11, MonsterSpawnTable
@ Pokedex.c:543: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	adds	r2, r7, r5	@ tmp206,, tmp302
	ldrb	r2, [r2]	@ tmp208, classID
	subs	r3, r2, r3	@ tmp210, tmp208, _11
	rsbs	r2, r3, #0	@ tmp211, tmp210
	adcs	r3, r3, r2	@ tmp209, tmp210, tmp211
	lsls	r3, r3, #24	@ tmp212, tmp207,
	lsrs	r3, r3, #24	@ _12, tmp212,
@ Pokedex.c:543: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	movs	r1, r0	@ _9, _9
	orrs	r1, r3	@ _9, _13
@ Pokedex.c:543: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	adds	r3, r7, r4	@ tmp213,, tmp304
	ldrh	r2, [r3]	@ _15, i
	ldr	r0, .L105	@ tmp214,
	movs	r3, r2	@ tmp215, _15
	lsls	r3, r3, #1	@ tmp215, tmp215,
	adds	r3, r3, r2	@ tmp215, tmp215, _15
	lsls	r3, r3, #2	@ tmp216, tmp215,
	adds	r3, r0, r3	@ tmp217, tmp214, tmp215
	adds	r3, r3, #3	@ tmp218,
	ldrb	r3, [r3]	@ _16, MonsterSpawnTable
@ Pokedex.c:543: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	adds	r2, r7, r5	@ tmp219,, tmp305
	ldrb	r2, [r2]	@ tmp221, classID
	subs	r3, r2, r3	@ tmp223, tmp221, _16
	rsbs	r2, r3, #0	@ tmp224, tmp223
	adcs	r3, r3, r2	@ tmp222, tmp223, tmp224
	lsls	r3, r3, #24	@ tmp225, tmp220,
	lsrs	r3, r3, #24	@ _17, tmp225,
@ Pokedex.c:543: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	orrs	r1, r3	@ _19, _18
@ Pokedex.c:543: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	adds	r3, r7, r4	@ tmp226,, tmp306
	ldrh	r2, [r3]	@ _20, i
	ldr	r0, .L105	@ tmp227,
	movs	r3, r2	@ tmp228, _20
	lsls	r3, r3, #1	@ tmp228, tmp228,
	adds	r3, r3, r2	@ tmp228, tmp228, _20
	lsls	r3, r3, #2	@ tmp229, tmp228,
	adds	r3, r0, r3	@ tmp230, tmp227, tmp228
	adds	r3, r3, #4	@ tmp231,
	ldrb	r3, [r3]	@ _21, MonsterSpawnTable
@ Pokedex.c:543: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	adds	r2, r7, r5	@ tmp232,, tmp307
	ldrb	r2, [r2]	@ tmp234, classID
	subs	r3, r2, r3	@ tmp236, tmp234, _21
	rsbs	r2, r3, #0	@ tmp237, tmp236
	adcs	r3, r3, r2	@ tmp235, tmp236, tmp237
	lsls	r3, r3, #24	@ tmp238, tmp233,
	lsrs	r3, r3, #24	@ _22, tmp238,
@ Pokedex.c:543: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	orrs	r3, r1	@ _24, _19
@ Pokedex.c:543: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	beq	.L99		@,
@ Pokedex.c:545: 				if (Chapter < 32)
	adds	r3, r7, r6	@ tmp239,, tmp308
	ldrb	r3, [r3]	@ tmp242, Chapter
	cmp	r3, #31	@ tmp242,
	bhi	.L100		@,
@ Pokedex.c:547: 					*areaBitfield_A = *areaBitfield_A | 1<<Chapter;
	ldr	r3, [r7, #8]	@ tmp243, areaBitfield_A
	ldr	r2, [r3]	@ _25, *areaBitfield_A_56(D)
@ Pokedex.c:547: 					*areaBitfield_A = *areaBitfield_A | 1<<Chapter;
	adds	r3, r7, r6	@ tmp244,, tmp309
	ldrb	r3, [r3]	@ _26, Chapter
	movs	r1, #1	@ tmp245,
	lsls	r1, r1, r3	@ tmp245, tmp245, _26
	movs	r3, r1	@ _27, tmp245
@ Pokedex.c:547: 					*areaBitfield_A = *areaBitfield_A | 1<<Chapter;
	orrs	r2, r3	@ _28, _27
@ Pokedex.c:547: 					*areaBitfield_A = *areaBitfield_A | 1<<Chapter;
	ldr	r3, [r7, #8]	@ tmp246, areaBitfield_A
	str	r2, [r3]	@ _28, *areaBitfield_A_56(D)
.L100:
@ Pokedex.c:549: 				if ((Chapter >= 32) && (Chapter < 64))
	movs	r1, #21	@ tmp311,
	adds	r3, r7, r1	@ tmp247,, tmp311
	ldrb	r3, [r3]	@ tmp250, Chapter
	cmp	r3, #31	@ tmp250,
	bls	.L101		@,
@ Pokedex.c:549: 				if ((Chapter >= 32) && (Chapter < 64))
	adds	r3, r7, r1	@ tmp251,, tmp312
	ldrb	r3, [r3]	@ tmp254, Chapter
	cmp	r3, #63	@ tmp254,
	bhi	.L101		@,
@ Pokedex.c:551: 					*areaBitfield_B = *areaBitfield_B | 1<<(Chapter-32);
	ldr	r3, [r7, #4]	@ tmp255, areaBitfield_B
	ldr	r2, [r3]	@ _29, *areaBitfield_B_58(D)
@ Pokedex.c:551: 					*areaBitfield_B = *areaBitfield_B | 1<<(Chapter-32);
	adds	r3, r7, r1	@ tmp256,, tmp313
	ldrb	r3, [r3]	@ _30, Chapter
	subs	r3, r3, #32	@ _31,
@ Pokedex.c:551: 					*areaBitfield_B = *areaBitfield_B | 1<<(Chapter-32);
	movs	r1, #1	@ tmp257,
	lsls	r1, r1, r3	@ tmp257, tmp257, _31
	movs	r3, r1	@ _32, tmp257
@ Pokedex.c:551: 					*areaBitfield_B = *areaBitfield_B | 1<<(Chapter-32);
	orrs	r2, r3	@ _33, _32
@ Pokedex.c:551: 					*areaBitfield_B = *areaBitfield_B | 1<<(Chapter-32);
	ldr	r3, [r7, #4]	@ tmp258, areaBitfield_B
	str	r2, [r3]	@ _33, *areaBitfield_B_58(D)
.L101:
@ Pokedex.c:553: 				if ((Chapter >= 64) && (Chapter < 96))
	movs	r1, #21	@ tmp315,
	adds	r3, r7, r1	@ tmp259,, tmp315
	ldrb	r3, [r3]	@ tmp262, Chapter
	cmp	r3, #63	@ tmp262,
	bls	.L102		@,
@ Pokedex.c:553: 				if ((Chapter >= 64) && (Chapter < 96))
	adds	r3, r7, r1	@ tmp263,, tmp316
	ldrb	r3, [r3]	@ tmp266, Chapter
	cmp	r3, #95	@ tmp266,
	bhi	.L102		@,
@ Pokedex.c:555: 					*areaBitfield_C = *areaBitfield_C | 1<<(Chapter-64);
	ldr	r3, [r7]	@ tmp267, areaBitfield_C
	ldr	r2, [r3]	@ _34, *areaBitfield_C_60(D)
@ Pokedex.c:555: 					*areaBitfield_C = *areaBitfield_C | 1<<(Chapter-64);
	adds	r3, r7, r1	@ tmp268,, tmp317
	ldrb	r3, [r3]	@ _35, Chapter
	subs	r3, r3, #64	@ _36,
@ Pokedex.c:555: 					*areaBitfield_C = *areaBitfield_C | 1<<(Chapter-64);
	movs	r1, #1	@ tmp269,
	lsls	r1, r1, r3	@ tmp269, tmp269, _36
	movs	r3, r1	@ _37, tmp269
@ Pokedex.c:555: 					*areaBitfield_C = *areaBitfield_C | 1<<(Chapter-64);
	orrs	r2, r3	@ _38, _37
@ Pokedex.c:555: 					*areaBitfield_C = *areaBitfield_C | 1<<(Chapter-64);
	ldr	r3, [r7]	@ tmp270, areaBitfield_C
	str	r2, [r3]	@ _38, *areaBitfield_C_60(D)
.L102:
@ Pokedex.c:557: 				if ((Chapter >= 96) && (Chapter < 128))
	movs	r1, #21	@ tmp319,
	adds	r3, r7, r1	@ tmp271,, tmp319
	ldrb	r3, [r3]	@ tmp274, Chapter
	cmp	r3, #95	@ tmp274,
	bls	.L99		@,
@ Pokedex.c:557: 				if ((Chapter >= 96) && (Chapter < 128))
	adds	r3, r7, r1	@ tmp275,, tmp320
	ldrb	r3, [r3]	@ Chapter.19_39, Chapter
	lsls	r3, r3, #24	@ Chapter.19_39, Chapter.19_39,
	asrs	r3, r3, #24	@ Chapter.19_39, Chapter.19_39,
@ Pokedex.c:557: 				if ((Chapter >= 96) && (Chapter < 128))
	bmi	.L99		@,
@ Pokedex.c:559: 					*areaBitfield_D = *areaBitfield_D | 1<<(Chapter-96);
	ldr	r3, [r7, #48]	@ tmp279, areaBitfield_D
	ldr	r2, [r3]	@ _40, *areaBitfield_D_62(D)
@ Pokedex.c:559: 					*areaBitfield_D = *areaBitfield_D | 1<<(Chapter-96);
	adds	r3, r7, r1	@ tmp280,, tmp321
	ldrb	r3, [r3]	@ _41, Chapter
	subs	r3, r3, #96	@ _42,
@ Pokedex.c:559: 					*areaBitfield_D = *areaBitfield_D | 1<<(Chapter-96);
	movs	r1, #1	@ tmp281,
	lsls	r1, r1, r3	@ tmp281, tmp281, _42
	movs	r3, r1	@ _43, tmp281
@ Pokedex.c:559: 					*areaBitfield_D = *areaBitfield_D | 1<<(Chapter-96);
	orrs	r2, r3	@ _44, _43
@ Pokedex.c:559: 					*areaBitfield_D = *areaBitfield_D | 1<<(Chapter-96);
	ldr	r3, [r7, #48]	@ tmp282, areaBitfield_D
	str	r2, [r3]	@ _44, *areaBitfield_D_62(D)
.L99:
@ Pokedex.c:537: 	for (u16 i = 0 ; i <= 0x80 ; i++) 
	movs	r1, #22	@ tmp323,
	adds	r3, r7, r1	@ tmp283,, tmp323
	ldrh	r2, [r3]	@ i.20_45, i
	adds	r3, r7, r1	@ tmp284,, tmp324
	adds	r2, r2, #1	@ tmp285,
	strh	r2, [r3]	@ tmp286, i
.L98:
@ Pokedex.c:537: 	for (u16 i = 0 ; i <= 0x80 ; i++) 
	movs	r3, #22	@ tmp325,
	adds	r3, r7, r3	@ tmp287,, tmp325
	ldrh	r3, [r3]	@ tmp290, i
	cmp	r3, #128	@ tmp290,
	bhi	.LCB2398	@
	b	.L103	@long jump	@
.LCB2398:
@ Pokedex.c:565: 	return;
	nop	
@ Pokedex.c:566: }
	mov	sp, r7	@,
	add	sp, sp, #28	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L106:
	.align	2
.L105:
	.word	MonsterSpawnTable
	.size	Pokedex_RetrieveAreasFound, .-Pokedex_RetrieveAreasFound
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	GetNumLines, %function
GetNumLines:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}	@
	sub	sp, sp, #16	@,,
	add	r7, sp, #0	@,,
	str	r0, [r7, #4]	@ string, string
@ Pokedex.c:571: 	int sum = 1;
	movs	r3, #1	@ tmp121,
	str	r3, [r7, #12]	@ tmp121, sum
@ Pokedex.c:572: 	for ( int i = 0 ; string[i] ; i++ )
	movs	r3, #0	@ tmp122,
	str	r3, [r7, #8]	@ tmp122, i
@ Pokedex.c:572: 	for ( int i = 0 ; string[i] ; i++ )
	b	.L108		@
.L110:
@ Pokedex.c:574: 		if ( string[i] == NL ) { sum++; }
	ldr	r3, [r7, #8]	@ i.21_1, i
	ldr	r2, [r7, #4]	@ tmp123, string
	adds	r3, r2, r3	@ _2, tmp123, i.21_1
	ldrb	r3, [r3]	@ _3, *_2
@ Pokedex.c:574: 		if ( string[i] == NL ) { sum++; }
	cmp	r3, #1	@ _3,
	bne	.L109		@,
@ Pokedex.c:574: 		if ( string[i] == NL ) { sum++; }
	ldr	r3, [r7, #12]	@ tmp125, sum
	adds	r3, r3, #1	@ tmp124,
	str	r3, [r7, #12]	@ tmp124, sum
.L109:
@ Pokedex.c:572: 	for ( int i = 0 ; string[i] ; i++ )
	ldr	r3, [r7, #8]	@ tmp127, i
	adds	r3, r3, #1	@ tmp126,
	str	r3, [r7, #8]	@ tmp126, i
.L108:
@ Pokedex.c:572: 	for ( int i = 0 ; string[i] ; i++ )
	ldr	r3, [r7, #8]	@ i.22_4, i
	ldr	r2, [r7, #4]	@ tmp128, string
	adds	r3, r2, r3	@ _5, tmp128, i.22_4
	ldrb	r3, [r3]	@ _6, *_5
@ Pokedex.c:572: 	for ( int i = 0 ; string[i] ; i++ )
	cmp	r3, #0	@ _6,
	bne	.L110		@,
@ Pokedex.c:576: 	return sum;
	ldr	r3, [r7, #12]	@ _14, sum
@ Pokedex.c:577: }
	movs	r0, r3	@, <retval>
	mov	sp, r7	@,
	add	sp, sp, #16	@,,
	@ sp needed	@
	pop	{r7}
	pop	{r1}
	bx	r1
	.size	GetNumLines, .-GetNumLines
	.ident	"GCC: (devkitARM release 56) 11.1.0"
	.code 16
	.align	1
.L44:
	bx	r3
.L45:
	bx	r4
