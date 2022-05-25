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
@ onIdle:
	.space	4
	.word	PokedexIdle
	.space	8
	.space	36
	.align	2
	.type	Menu_Pokedex, %object
	.size	Menu_Pokedex, 36
Menu_Pokedex:
@ geometry:
@ x:
	.byte	9
@ y:
	.byte	1
@ h:
	.byte	11
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
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}	@
	sub	sp, sp, #16	@,,
	add	r7, sp, #0	@,,
	str	r0, [r7, #4]	@ menu, menu
	str	r1, [r7]	@ command, command
@ Pokedex.c:122:     struct PokedexProc* const proc = (void*) menu->parent;
	ldr	r3, [r7, #4]	@ tmp143, menu
	ldr	r3, [r3, #20]	@ tmp144, menu_38(D)->parent
	str	r3, [r7, #12]	@ tmp144, proc
@ Pokedex.c:125:     if (gKeyState.repeatedKeys & KEY_DPAD_LEFT) {
	ldr	r3, .L11	@ tmp145,
	ldrh	r3, [r3, #6]	@ _1,
@ Pokedex.c:125:     if (gKeyState.repeatedKeys & KEY_DPAD_LEFT) {
	movs	r2, r3	@ _2, _1
	movs	r3, #32	@ tmp146,
	ands	r3, r2	@ _3, _2
@ Pokedex.c:125:     if (gKeyState.repeatedKeys & KEY_DPAD_LEFT) {
	beq	.L2		@,
@ Pokedex.c:126:         if (proc->menuIndex < 0xFF) {
	ldr	r3, [r7, #12]	@ tmp147, proc
	movs	r2, #48	@ tmp148,
	ldrb	r3, [r3, r2]	@ _4,
@ Pokedex.c:126:         if (proc->menuIndex < 0xFF) {
	cmp	r3, #255	@ _4,
	beq	.L2		@,
@ Pokedex.c:127:             proc->menuIndex--;
	ldr	r3, [r7, #12]	@ tmp149, proc
	movs	r2, #48	@ tmp150,
	ldrb	r3, [r3, r2]	@ _5,
@ Pokedex.c:127:             proc->menuIndex--;
	subs	r3, r3, #1	@ tmp151,
	lsls	r3, r3, #24	@ tmp152, tmp151,
	lsrs	r1, r3, #24	@ _7, tmp152,
	ldr	r3, [r7, #12]	@ tmp153, proc
	movs	r2, #48	@ tmp154,
	strb	r1, [r3, r2]	@ tmp155, proc_39->menuIndex
@ Pokedex.c:128: 			while (!PokedexTable[proc->menuIndex].IndexNumber)
	b	.L3		@
.L5:
@ Pokedex.c:130: 				if (proc->menuIndex > 2) 
	ldr	r3, [r7, #12]	@ tmp156, proc
	movs	r2, #48	@ tmp157,
	ldrb	r3, [r3, r2]	@ _8,
@ Pokedex.c:130: 				if (proc->menuIndex > 2) 
	cmp	r3, #2	@ _8,
	bls	.L4		@,
@ Pokedex.c:132: 					proc->menuIndex--;
	ldr	r3, [r7, #12]	@ tmp160, proc
	movs	r2, #48	@ tmp161,
	ldrb	r3, [r3, r2]	@ _9,
@ Pokedex.c:132: 					proc->menuIndex--;
	subs	r3, r3, #1	@ tmp162,
	lsls	r3, r3, #24	@ tmp163, tmp162,
	lsrs	r1, r3, #24	@ _11, tmp163,
	ldr	r3, [r7, #12]	@ tmp164, proc
	movs	r2, #48	@ tmp165,
	strb	r1, [r3, r2]	@ tmp166, proc_39->menuIndex
	b	.L3		@
.L4:
@ Pokedex.c:134: 				else { proc->menuIndex = 0xFF; }
	ldr	r3, [r7, #12]	@ tmp167, proc
	movs	r2, #48	@ tmp168,
	movs	r1, #255	@ tmp169,
	strb	r1, [r3, r2]	@ tmp170, proc_39->menuIndex
.L3:
@ Pokedex.c:128: 			while (!PokedexTable[proc->menuIndex].IndexNumber)
	ldr	r3, [r7, #12]	@ tmp171, proc
	movs	r2, #48	@ tmp172,
	ldrb	r3, [r3, r2]	@ _12,
	movs	r2, r3	@ _13, _12
@ Pokedex.c:128: 			while (!PokedexTable[proc->menuIndex].IndexNumber)
	ldr	r3, .L11+4	@ tmp173,
	lsls	r2, r2, #2	@ tmp174, _13,
	ldrb	r3, [r2, r3]	@ _14, PokedexTable
@ Pokedex.c:128: 			while (!PokedexTable[proc->menuIndex].IndexNumber)
	cmp	r3, #0	@ _14,
	beq	.L5		@,
@ Pokedex.c:136:             PokedexDraw(menu, command);
	ldr	r2, [r7]	@ tmp175, command
	ldr	r3, [r7, #4]	@ tmp176, menu
	movs	r1, r2	@, tmp175
	movs	r0, r3	@, tmp176
	bl	PokedexDraw		@
@ Pokedex.c:137:             PlaySfx(0x6B);
	ldr	r3, .L11+8	@ tmp177,
	movs	r2, #65	@ tmp178,
	ldrb	r3, [r3, r2]	@ _15, gChapterData
	movs	r2, #2	@ tmp180,
	ands	r3, r2	@ tmp179, tmp180
	lsls	r3, r3, #24	@ tmp181, tmp179,
	lsrs	r3, r3, #24	@ _16, tmp181,
	bne	.L2		@,
@ Pokedex.c:137:             PlaySfx(0x6B);
	movs	r0, #107	@,
	ldr	r3, .L11+12	@ tmp182,
	bl	.L13		@
.L2:
@ Pokedex.c:141:     if (gKeyState.repeatedKeys & KEY_DPAD_RIGHT) {
	ldr	r3, .L11	@ tmp183,
	ldrh	r3, [r3, #6]	@ _17,
@ Pokedex.c:141:     if (gKeyState.repeatedKeys & KEY_DPAD_RIGHT) {
	movs	r2, r3	@ _18, _17
	movs	r3, #16	@ tmp184,
	ands	r3, r2	@ _19, _18
@ Pokedex.c:141:     if (gKeyState.repeatedKeys & KEY_DPAD_RIGHT) {
	beq	.L6		@,
@ Pokedex.c:142:         if (proc->menuIndex < 0xFF) {
	ldr	r3, [r7, #12]	@ tmp185, proc
	movs	r2, #48	@ tmp186,
	ldrb	r3, [r3, r2]	@ _20,
@ Pokedex.c:142:         if (proc->menuIndex < 0xFF) {
	cmp	r3, #255	@ _20,
	beq	.L6		@,
@ Pokedex.c:143:             proc->menuIndex++;
	ldr	r3, [r7, #12]	@ tmp187, proc
	movs	r2, #48	@ tmp188,
	ldrb	r3, [r3, r2]	@ _21,
@ Pokedex.c:143:             proc->menuIndex++;
	adds	r3, r3, #1	@ tmp189,
	lsls	r3, r3, #24	@ tmp190, tmp189,
	lsrs	r1, r3, #24	@ _23, tmp190,
	ldr	r3, [r7, #12]	@ tmp191, proc
	movs	r2, #48	@ tmp192,
	strb	r1, [r3, r2]	@ tmp193, proc_39->menuIndex
@ Pokedex.c:144: 			while (!PokedexTable[proc->menuIndex].IndexNumber)
	b	.L7		@
.L9:
@ Pokedex.c:146: 				if (proc->menuIndex < 0xFF) 
	ldr	r3, [r7, #12]	@ tmp194, proc
	movs	r2, #48	@ tmp195,
	ldrb	r3, [r3, r2]	@ _24,
@ Pokedex.c:146: 				if (proc->menuIndex < 0xFF) 
	cmp	r3, #255	@ _24,
	beq	.L8		@,
@ Pokedex.c:148: 					proc->menuIndex++;
	ldr	r3, [r7, #12]	@ tmp196, proc
	movs	r2, #48	@ tmp197,
	ldrb	r3, [r3, r2]	@ _25,
@ Pokedex.c:148: 					proc->menuIndex++;
	adds	r3, r3, #1	@ tmp198,
	lsls	r3, r3, #24	@ tmp199, tmp198,
	lsrs	r1, r3, #24	@ _27, tmp199,
	ldr	r3, [r7, #12]	@ tmp200, proc
	movs	r2, #48	@ tmp201,
	strb	r1, [r3, r2]	@ tmp202, proc_39->menuIndex
	b	.L7		@
.L8:
@ Pokedex.c:150: 				else { proc->menuIndex = 1; }
	ldr	r3, [r7, #12]	@ tmp203, proc
	movs	r2, #48	@ tmp204,
	movs	r1, #1	@ tmp205,
	strb	r1, [r3, r2]	@ tmp206, proc_39->menuIndex
.L7:
@ Pokedex.c:144: 			while (!PokedexTable[proc->menuIndex].IndexNumber)
	ldr	r3, [r7, #12]	@ tmp207, proc
	movs	r2, #48	@ tmp208,
	ldrb	r3, [r3, r2]	@ _28,
	movs	r2, r3	@ _29, _28
@ Pokedex.c:144: 			while (!PokedexTable[proc->menuIndex].IndexNumber)
	ldr	r3, .L11+4	@ tmp209,
	lsls	r2, r2, #2	@ tmp210, _29,
	ldrb	r3, [r2, r3]	@ _30, PokedexTable
@ Pokedex.c:144: 			while (!PokedexTable[proc->menuIndex].IndexNumber)
	cmp	r3, #0	@ _30,
	beq	.L9		@,
@ Pokedex.c:152:             PokedexDraw(menu, command);
	ldr	r2, [r7]	@ tmp211, command
	ldr	r3, [r7, #4]	@ tmp212, menu
	movs	r1, r2	@, tmp211
	movs	r0, r3	@, tmp212
	bl	PokedexDraw		@
@ Pokedex.c:153:             PlaySfx(0x6B);
	ldr	r3, .L11+8	@ tmp213,
	movs	r2, #65	@ tmp214,
	ldrb	r3, [r3, r2]	@ _31, gChapterData
	movs	r2, #2	@ tmp216,
	ands	r3, r2	@ tmp215, tmp216
	lsls	r3, r3, #24	@ tmp217, tmp215,
	lsrs	r3, r3, #24	@ _32, tmp217,
	bne	.L6		@,
@ Pokedex.c:153:             PlaySfx(0x6B);
	movs	r0, #107	@,
	ldr	r3, .L11+12	@ tmp218,
	bl	.L13		@
.L6:
@ Pokedex.c:157:     return ME_NONE;
	movs	r3, #0	@ _51,
@ Pokedex.c:158: }
	movs	r0, r3	@, <retval>
	mov	sp, r7	@,
	add	sp, sp, #16	@,,
	@ sp needed	@
	pop	{r7}
	pop	{r1}
	bx	r1
.L12:
	.align	2
.L11:
	.word	gKeyState
	.word	PokedexTable
	.word	gChapterData
	.word	m4aSongNumStart
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
@ Pokedex.c:163: 	Text_Clear(&handle);
	movs	r4, r5	@ tmp132, tmp131
	adds	r3, r7, r4	@ tmp115,, tmp132
	movs	r0, r3	@, tmp115
	ldr	r3, .L15	@ tmp116,
	bl	.L13		@
@ Pokedex.c:164: 	Text_SetColorId(&handle,TEXT_COLOR_GOLD);
	adds	r3, r7, r4	@ tmp117,, tmp133
	movs	r1, #3	@,
	movs	r0, r3	@, tmp117
	ldr	r3, .L15+4	@ tmp118,
	bl	.L13		@
@ Pokedex.c:165: 	Text_DrawString(&handle,string);
	ldr	r2, [r7, #4]	@ tmp119, string
	adds	r3, r7, r4	@ tmp120,, tmp134
	movs	r1, r2	@, tmp119
	movs	r0, r3	@, tmp120
	ldr	r3, .L15+8	@ tmp121,
	bl	.L13		@
@ Pokedex.c:166: 	Text_Display(&handle,&gBG0MapBuffer[y][x]);
	ldr	r3, [r7, #32]	@ tmp123, y
	lsls	r2, r3, #5	@ tmp122, tmp123,
	ldr	r3, [r7]	@ tmp125, x
	adds	r3, r2, r3	@ tmp124, tmp122, tmp125
	lsls	r2, r3, #1	@ tmp126, tmp124,
	ldr	r3, .L15+12	@ tmp127,
	adds	r2, r2, r3	@ _1, tmp126, tmp127
	adds	r3, r7, r4	@ tmp128,, tmp135
	movs	r1, r2	@, _1
	movs	r0, r3	@, tmp128
	ldr	r3, .L15+16	@ tmp129,
	bl	.L13		@
@ Pokedex.c:167: }
	nop	
	mov	sp, r7	@,
	add	sp, sp, #16	@,,
	@ sp needed	@
	pop	{r4, r5, r7}
	pop	{r0}
	bx	r0
.L16:
	.align	2
.L15:
	.word	Text_Clear
	.word	Text_SetColorId
	.word	Text_DrawString
	.word	gBG0MapBuffer
	.word	Text_Display
	.size	DrawRawText, .-DrawRawText
	.section	.rodata
	.align	2
.LC20:
	.ascii	"???\000"
	.align	2
.LC24:
	.ascii	" Seen\000"
	.align	2
.LC26:
	.ascii	" Caught\000"
	.text
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	PokedexDrawIdle, %function
PokedexDrawIdle:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 88
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, r7, lr}	@
	sub	sp, sp, #96	@,,
	add	r7, sp, #8	@,,
	str	r0, [r7, #4]	@ menu, menu
	str	r1, [r7]	@ command, command
@ Pokedex.c:170:     struct PokedexProc* const proc = (void*) menu->parent;
	ldr	r3, [r7, #4]	@ tmp169, menu
	ldr	r3, [r3, #20]	@ tmp170, menu_69(D)->parent
	str	r3, [r7, #68]	@ tmp170, proc
@ Pokedex.c:171:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldr	r3, [r7]	@ tmp171, command
	ldrh	r3, [r3, #44]	@ _1,
	lsls	r3, r3, #5	@ _3, _2,
	ldr	r2, [r7]	@ tmp172, command
	ldrh	r2, [r2, #42]	@ _4,
	adds	r3, r3, r2	@ _6, _3, _5
@ Pokedex.c:171:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r2, r3, #1	@ _8, _7,
@ Pokedex.c:171:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldr	r3, .L32	@ tmp174,
	adds	r3, r2, r3	@ tmp173, _8, tmp174
	str	r3, [r7, #64]	@ tmp173, out
@ Pokedex.c:173: 	int* areaBitfield_A = &proc->areaBitfield_A;
	ldr	r3, [r7, #68]	@ tmp176, proc
	adds	r3, r3, #52	@ tmp175,
	str	r3, [r7, #60]	@ tmp175, areaBitfield_A
@ Pokedex.c:174: 	int* areaBitfield_B = &proc->areaBitfield_B;
	ldr	r3, [r7, #68]	@ tmp178, proc
	adds	r3, r3, #56	@ tmp177,
	str	r3, [r7, #56]	@ tmp177, areaBitfield_B
@ Pokedex.c:175: 	*areaBitfield_A = 0;
	ldr	r3, [r7, #60]	@ tmp179, areaBitfield_A
	movs	r2, #0	@ tmp180,
	str	r2, [r3]	@ tmp180, *areaBitfield_A_73
@ Pokedex.c:176: 	*areaBitfield_B = 0;
	ldr	r3, [r7, #56]	@ tmp181, areaBitfield_B
	movs	r2, #0	@ tmp182,
	str	r2, [r3]	@ tmp182, *areaBitfield_B_74
@ Pokedex.c:177: 	proc->areaBitfield_A = 0;
	ldr	r3, [r7, #68]	@ tmp183, proc
	movs	r2, #0	@ tmp184,
	str	r2, [r3, #52]	@ tmp184, proc_70->areaBitfield_A
@ Pokedex.c:178: 	proc->areaBitfield_B = 0;
	ldr	r3, [r7, #68]	@ tmp185, proc
	movs	r2, #0	@ tmp186,
	str	r2, [r3, #56]	@ tmp186, proc_70->areaBitfield_B
@ Pokedex.c:180: 	bool caught = CheckIfCaught(proc->menuIndex);
	ldr	r3, [r7, #68]	@ tmp187, proc
	movs	r2, #48	@ tmp188,
	ldrb	r3, [r3, r2]	@ _9,
	movs	r0, r3	@, _9
	ldr	r3, .L32+4	@ tmp189,
	bl	.L13		@
	movs	r2, r0	@ _10,
@ Pokedex.c:180: 	bool caught = CheckIfCaught(proc->menuIndex);
	movs	r3, #55	@ tmp390,
	adds	r3, r7, r3	@ tmp190,, tmp390
	subs	r1, r2, #1	@ tmp192, _10
	sbcs	r2, r2, r1	@ tmp191, _10, tmp192
	strb	r2, [r3]	@ tmp193, caught
@ Pokedex.c:181: 	bool seen = CheckIfSeen(proc->menuIndex);
	ldr	r3, [r7, #68]	@ tmp194, proc
	movs	r2, #48	@ tmp195,
	ldrb	r3, [r3, r2]	@ _11,
	movs	r0, r3	@, _11
	ldr	r3, .L32+8	@ tmp196,
	bl	.L13		@
	movs	r2, r0	@ _12,
@ Pokedex.c:181: 	bool seen = CheckIfSeen(proc->menuIndex);
	movs	r5, #54	@ tmp391,
	adds	r3, r7, r5	@ tmp197,, tmp391
	subs	r1, r2, #1	@ tmp199, _12
	sbcs	r2, r2, r1	@ tmp198, _12, tmp199
	strb	r2, [r3]	@ tmp200, seen
@ Pokedex.c:183: 	const struct ClassData* ClassData = GetClassData(proc->menuIndex);
	ldr	r3, [r7, #68]	@ tmp201, proc
	movs	r2, #48	@ tmp202,
	ldrb	r3, [r3, r2]	@ _13,
	movs	r0, r3	@, _13
	ldr	r3, .L32+12	@ tmp203,
	bl	.L13		@
	movs	r3, r0	@ tmp204,
	str	r3, [r7, #48]	@ tmp204, ClassData
@ Pokedex.c:184: 	u16 title = 0;
	movs	r4, #86	@ tmp392,
	adds	r3, r7, r4	@ tmp205,, tmp392
	movs	r2, #0	@ tmp206,
	strh	r2, [r3]	@ tmp207, title
@ Pokedex.c:185:     Text_Clear(&command->text);
	ldr	r3, [r7]	@ tmp208, command
	adds	r3, r3, #52	@ _14,
	movs	r0, r3	@, _14
	ldr	r3, .L32+16	@ tmp209,
	bl	.L13		@
@ Pokedex.c:186: 	Text_ResetTileAllocation(); // 0x08003D20
	ldr	r3, .L32+20	@ tmp210,
	bl	.L13		@
@ Pokedex.c:189: 	Pokedex_RetrieveAreasFound(proc->menuIndex, areaBitfield_A, areaBitfield_B);
	ldr	r3, [r7, #68]	@ tmp211, proc
	movs	r2, #48	@ tmp212,
	ldrb	r3, [r3, r2]	@ _15,
	ldr	r2, [r7, #56]	@ tmp213, areaBitfield_B
	ldr	r1, [r7, #60]	@ tmp214, areaBitfield_A
	movs	r0, r3	@, _15
	bl	Pokedex_RetrieveAreasFound		@
@ Pokedex.c:193: 	if (proc->menuIndex)
	ldr	r3, [r7, #68]	@ tmp215, proc
	movs	r2, #48	@ tmp216,
	ldrb	r3, [r3, r2]	@ _16,
@ Pokedex.c:193: 	if (proc->menuIndex)
	cmp	r3, #0	@ _16,
	beq	.L18		@,
@ Pokedex.c:195: 		if (seen)
	adds	r3, r7, r5	@ tmp217,, tmp393
	ldrb	r3, [r3]	@ tmp218, seen
	cmp	r3, #0	@ tmp218,
	beq	.L18		@,
@ Pokedex.c:197: 			title = ClassData->nameTextId;
	movs	r1, r4	@ tmp394, tmp392
	adds	r3, r7, r1	@ tmp219,, tmp394
	ldr	r2, [r7, #48]	@ tmp220, ClassData
	ldrh	r2, [r2]	@ tmp221, *ClassData_84
	strh	r2, [r3]	@ tmp221, title
@ Pokedex.c:198: 			Text_DrawString(&command->text, GetStringFromIndex(title));
	ldr	r3, [r7]	@ tmp222, command
	adds	r3, r3, #52	@ tmp222,
	movs	r4, r3	@ _17, tmp222
@ Pokedex.c:198: 			Text_DrawString(&command->text, GetStringFromIndex(title));
	adds	r3, r7, r1	@ tmp223,, tmp396
	ldrh	r3, [r3]	@ _18, title
	movs	r0, r3	@, _18
	ldr	r3, .L32+24	@ tmp224,
	bl	.L13		@
	movs	r3, r0	@ _19,
@ Pokedex.c:198: 			Text_DrawString(&command->text, GetStringFromIndex(title));
	movs	r1, r3	@, _19
	movs	r0, r4	@, _17
	ldr	r3, .L32+28	@ tmp225,
	bl	.L13		@
@ Pokedex.c:199: 			Text_Display(&command->text, out); // Class name 
	ldr	r3, [r7]	@ tmp226, command
	adds	r3, r3, #52	@ _20,
	ldr	r2, [r7, #64]	@ tmp227, out
	movs	r1, r2	@, tmp227
	movs	r0, r3	@, _20
	ldr	r3, .L32+32	@ tmp228,
	bl	.L13		@
.L18:
@ Pokedex.c:205:     Text_SetColorId(&command->text, TEXT_COLOR_NORMAL);
	ldr	r3, [r7]	@ tmp229, command
	adds	r3, r3, #52	@ _21,
	movs	r1, #0	@,
	movs	r0, r3	@, _21
	ldr	r3, .L32+36	@ tmp230,
	bl	.L13		@
@ Pokedex.c:206:     if (!title) {
	movs	r3, #86	@ tmp397,
	adds	r3, r7, r3	@ tmp231,, tmp397
	ldrh	r3, [r3]	@ tmp232, title
	cmp	r3, #0	@ tmp232,
	bne	.L19		@,
@ Pokedex.c:207: 		Text_SetXCursor(&command->text, 0xC);
	ldr	r3, [r7]	@ tmp233, command
	adds	r3, r3, #52	@ _22,
	movs	r1, #12	@,
	movs	r0, r3	@, _22
	ldr	r3, .L32+40	@ tmp234,
	bl	.L13		@
@ Pokedex.c:208: 		Text_DrawString(&command->text, "???");
	ldr	r3, [r7]	@ tmp235, command
	adds	r3, r3, #52	@ _23,
	ldr	r2, .L32+44	@ tmp236,
	movs	r1, r2	@, tmp236
	movs	r0, r3	@, _23
	ldr	r3, .L32+28	@ tmp237,
	bl	.L13		@
@ Pokedex.c:210: 		Text_Display(&command->text, out); // Class name 
	ldr	r3, [r7]	@ tmp238, command
	adds	r3, r3, #52	@ _24,
	ldr	r2, [r7, #64]	@ tmp239, out
	movs	r1, r2	@, tmp239
	movs	r0, r3	@, _24
	ldr	r3, .L32+32	@ tmp240,
	bl	.L13		@
.L19:
@ Pokedex.c:217: 	int tile = 40;
	movs	r3, #40	@ tmp241,
	str	r3, [r7, #44]	@ tmp241, tile
@ Pokedex.c:219: 	TextHandle caughtNameHandle = {
	movs	r4, #20	@ tmp398,
	adds	r3, r7, r4	@ tmp242,, tmp398
	movs	r0, r3	@ tmp243, tmp242
	movs	r3, #8	@ tmp244,
	movs	r2, r3	@, tmp244
	movs	r1, #0	@,
	ldr	r3, .L32+48	@ tmp245,
	bl	.L13		@
@ Pokedex.c:220: 		.tileIndexOffset = gpCurrentFont->tileNext+tile,
	ldr	r3, .L32+52	@ tmp248,
	ldr	r3, [r3]	@ gpCurrentFont.0_25, gpCurrentFont
	ldrh	r2, [r3, #18]	@ _26,
@ Pokedex.c:220: 		.tileIndexOffset = gpCurrentFont->tileNext+tile,
	ldr	r3, [r7, #44]	@ tmp250, tile
	lsls	r3, r3, #16	@ tmp251, tmp249,
	lsrs	r3, r3, #16	@ _27, tmp251,
	adds	r3, r2, r3	@ tmp252, _26, _27
	lsls	r3, r3, #16	@ tmp253, tmp252,
	lsrs	r2, r3, #16	@ _28, tmp253,
@ Pokedex.c:219: 	TextHandle caughtNameHandle = {
	adds	r3, r7, r4	@ tmp254,, tmp399
	strh	r2, [r3]	@ tmp255, caughtNameHandle.tileIndexOffset
	adds	r3, r7, r4	@ tmp256,, tmp400
	movs	r2, #4	@ tmp257,
	strb	r2, [r3, #4]	@ tmp258, caughtNameHandle.tileWidth
@ Pokedex.c:223: 	tile += 4;
	ldr	r3, [r7, #44]	@ tmp260, tile
	adds	r3, r3, #4	@ tmp259,
	str	r3, [r7, #44]	@ tmp259, tile
@ Pokedex.c:224: 	DrawRawText(caughtNameHandle," Seen",1,1);
	ldr	r2, .L32+56	@ tmp261,
	adds	r1, r7, r4	@ tmp262,, tmp401
	movs	r3, #1	@ tmp263,
	str	r3, [sp]	@ tmp263,
	movs	r3, #1	@,
	ldr	r0, [r1]	@, caughtNameHandle
	ldr	r1, [r1, #4]	@, caughtNameHandle
	bl	DrawRawText		@
@ Pokedex.c:226: 	TextHandle seenNameHandle = {
	movs	r4, #12	@ tmp402,
	adds	r3, r7, r4	@ tmp264,, tmp402
	movs	r0, r3	@ tmp265, tmp264
	movs	r3, #8	@ tmp266,
	movs	r2, r3	@, tmp266
	movs	r1, #0	@,
	ldr	r3, .L32+48	@ tmp267,
	bl	.L13		@
@ Pokedex.c:227: 		.tileIndexOffset = gpCurrentFont->tileNext+tile,
	ldr	r3, .L32+52	@ tmp270,
	ldr	r3, [r3]	@ gpCurrentFont.1_29, gpCurrentFont
	ldrh	r2, [r3, #18]	@ _30,
@ Pokedex.c:227: 		.tileIndexOffset = gpCurrentFont->tileNext+tile,
	ldr	r3, [r7, #44]	@ tmp272, tile
	lsls	r3, r3, #16	@ tmp273, tmp271,
	lsrs	r3, r3, #16	@ _31, tmp273,
	adds	r3, r2, r3	@ tmp274, _30, _31
	lsls	r3, r3, #16	@ tmp275, tmp274,
	lsrs	r2, r3, #16	@ _32, tmp275,
@ Pokedex.c:226: 	TextHandle seenNameHandle = {
	adds	r3, r7, r4	@ tmp276,, tmp403
	strh	r2, [r3]	@ tmp277, seenNameHandle.tileIndexOffset
	adds	r3, r7, r4	@ tmp278,, tmp404
	movs	r2, #5	@ tmp279,
	strb	r2, [r3, #4]	@ tmp280, seenNameHandle.tileWidth
@ Pokedex.c:230: 	tile += 5;
	ldr	r3, [r7, #44]	@ tmp282, tile
	adds	r3, r3, #5	@ tmp281,
	str	r3, [r7, #44]	@ tmp281, tile
@ Pokedex.c:231: 	DrawRawText(seenNameHandle," Caught",1,3);
	ldr	r2, .L32+60	@ tmp283,
	adds	r1, r7, r4	@ tmp284,, tmp405
	movs	r3, #3	@ tmp285,
	str	r3, [sp]	@ tmp285,
	movs	r3, #1	@,
	ldr	r0, [r1]	@, seenNameHandle
	ldr	r1, [r1, #4]	@, seenNameHandle
	bl	DrawRawText		@
@ Pokedex.c:234: 	DrawUiNumber(&gBG0MapBuffer[1][7],TEXT_COLOR_GOLD,  proc->TotalSeen); 
	ldr	r3, [r7, #68]	@ tmp286, proc
	movs	r2, #49	@ tmp287,
	ldrb	r3, [r3, r2]	@ _33,
@ Pokedex.c:234: 	DrawUiNumber(&gBG0MapBuffer[1][7],TEXT_COLOR_GOLD,  proc->TotalSeen); 
	movs	r2, r3	@ _34, _33
	ldr	r3, .L32+64	@ tmp288,
	movs	r1, #3	@,
	movs	r0, r3	@, tmp288
	ldr	r3, .L32+68	@ tmp289,
	bl	.L13		@
@ Pokedex.c:235: 	DrawUiNumber(&gBG0MapBuffer[3][7],TEXT_COLOR_GOLD,  proc->TotalCaught);
	ldr	r3, [r7, #68]	@ tmp290, proc
	movs	r2, #50	@ tmp291,
	ldrb	r3, [r3, r2]	@ _35,
@ Pokedex.c:235: 	DrawUiNumber(&gBG0MapBuffer[3][7],TEXT_COLOR_GOLD,  proc->TotalCaught);
	movs	r2, r3	@ _36, _35
	ldr	r3, .L32+72	@ tmp292,
	movs	r1, #3	@,
	movs	r0, r3	@, tmp292
	ldr	r3, .L32+68	@ tmp293,
	bl	.L13		@
@ Pokedex.c:236: 	Text_Display(&command->text,out);
	ldr	r3, [r7]	@ tmp294, command
	adds	r3, r3, #52	@ _37,
	ldr	r2, [r7, #64]	@ tmp295, out
	movs	r1, r2	@, tmp295
	movs	r0, r3	@, _37
	ldr	r3, .L32+32	@ tmp296,
	bl	.L13		@
@ Pokedex.c:237: 	Text_Display(&command->text,out);
	ldr	r3, [r7]	@ tmp297, command
	adds	r3, r3, #52	@ _38,
	ldr	r2, [r7, #64]	@ tmp298, out
	movs	r1, r2	@, tmp298
	movs	r0, r3	@, _38
	ldr	r3, .L32+32	@ tmp299,
	bl	.L13		@
@ Pokedex.c:239: 	BgMap_ApplyTsa(&gBG1MapBuffer[0][0], &PokedexSeenCaughtBox, 0);
	ldr	r1, .L32+76	@ tmp300,
	ldr	r3, .L32+80	@ tmp301,
	movs	r2, #0	@,
	movs	r0, r3	@, tmp301
	ldr	r3, .L32+84	@ tmp302,
	bl	.L13		@
@ Pokedex.c:240: 	EndFaceById(0);
	movs	r0, #0	@,
	ldr	r3, .L32+88	@ tmp303,
	bl	.L13		@
@ Pokedex.c:241: 	struct FaceProc* FaceProc = StartFace(0, ClassData->defaultPortraitId, 200, 4, 1);
	ldr	r3, [r7, #48]	@ tmp304, ClassData
	ldrh	r3, [r3, #8]	@ _39,
@ Pokedex.c:241: 	struct FaceProc* FaceProc = StartFace(0, ClassData->defaultPortraitId, 200, 4, 1);
	movs	r1, r3	@ _40, _39
	movs	r3, #1	@ tmp305,
	str	r3, [sp]	@ tmp305,
	movs	r3, #4	@,
	movs	r2, #200	@,
	movs	r0, #0	@,
	ldr	r4, .L32+92	@ tmp306,
	bl	.L34		@
	movs	r3, r0	@ tmp307,
	str	r3, [r7, #40]	@ tmp307, FaceProc
@ Pokedex.c:242: 	FaceProc->tileData &= ~(3 << 10); // Clear bits 10 and 11 (priority) such that they are 0 (highest priority) and appear above the background 
	ldr	r3, [r7, #40]	@ tmp308, FaceProc
	ldrh	r3, [r3, #60]	@ _41,
	ldr	r2, .L32+96	@ tmp310,
	ands	r3, r2	@ tmp309, tmp310
	lsls	r3, r3, #16	@ tmp311, tmp309,
	lsrs	r2, r3, #16	@ _42, tmp311,
	ldr	r3, [r7, #40]	@ tmp312, FaceProc
	strh	r2, [r3, #60]	@ tmp313, FaceProc_115->tileData
@ Pokedex.c:244: 	BgMap_ApplyTsa(&gBG1MapBuffer[0][20], &PokedexPortraitBox, 0);
	ldr	r1, .L32+100	@ tmp314,
	ldr	r3, .L32+104	@ tmp315,
	movs	r2, #0	@,
	movs	r0, r3	@, tmp315
	ldr	r3, .L32+84	@ tmp316,
	bl	.L13		@
@ Pokedex.c:246: 	if (!seen)
	movs	r3, #54	@ tmp406,
	adds	r3, r7, r3	@ tmp317,, tmp406
	ldrb	r3, [r3]	@ tmp318, seen
	movs	r2, #1	@ tmp320,
	eors	r3, r2	@ tmp319, tmp320
	lsls	r3, r3, #24	@ tmp321, tmp319,
	lsrs	r3, r3, #24	@ _43, tmp321,
@ Pokedex.c:246: 	if (!seen)
	beq	.L20		@,
@ Pokedex.c:249: 		int paletteID = 22*32;
	movs	r3, #176	@ tmp388,
	lsls	r3, r3, #2	@ tmp322, tmp388,
	str	r3, [r7, #36]	@ tmp322, paletteID
@ Pokedex.c:250: 		int paletteSize = 32; 
	movs	r3, #32	@ tmp323,
	str	r3, [r7, #32]	@ tmp323, paletteSize
@ Pokedex.c:251: 		CopyToPaletteBuffer(MyPalette, paletteID, paletteSize); // source pointer, palette offset, size 
	ldr	r1, [r7, #36]	@ paletteID.2_44, paletteID
	ldr	r2, [r7, #32]	@ paletteSize.3_45, paletteSize
	ldr	r3, .L32+108	@ tmp324,
	movs	r0, r3	@, tmp324
	ldr	r3, .L32+112	@ tmp325,
	bl	.L13		@
@ Pokedex.c:252: 		gPaletteSyncFlag = 1;
	ldr	r3, .L32+116	@ tmp326,
	movs	r2, #1	@ tmp327,
	strb	r2, [r3]	@ tmp328, gPaletteSyncFlag
.L20:
@ Pokedex.c:255: 	LoadIconPalettes(4);
	movs	r0, #4	@,
	ldr	r3, .L32+120	@ tmp329,
	bl	.L13		@
@ Pokedex.c:256: 	ClearIcons();
	ldr	r3, .L32+124	@ tmp330,
	bl	.L13		@
@ Pokedex.c:257: 	EnableBgSyncByMask(BG0_SYNC_BIT);
	movs	r0, #1	@,
	ldr	r3, .L32+128	@ tmp331,
	bl	.L13		@
@ Pokedex.c:259: 	for (int x = 0; x < 30; x++) { // clear out most of bg0 
	movs	r3, #0	@ tmp332,
	str	r3, [r7, #80]	@ tmp332, x
@ Pokedex.c:259: 	for (int x = 0; x < 30; x++) { // clear out most of bg0 
	b	.L21		@
.L24:
@ Pokedex.c:260: 		for (int y = 5; y < 20; y++) { 
	movs	r3, #5	@ tmp333,
	str	r3, [r7, #76]	@ tmp333, y
@ Pokedex.c:260: 		for (int y = 5; y < 20; y++) { 
	b	.L22		@
.L23:
@ Pokedex.c:261: 			gBG0MapBuffer[y][x] = 0;
	ldr	r3, .L32+132	@ tmp334,
	ldr	r2, [r7, #76]	@ tmp335, y
	lsls	r1, r2, #5	@ tmp336, tmp335,
	ldr	r2, [r7, #80]	@ tmp338, x
	adds	r2, r1, r2	@ tmp337, tmp336, tmp338
	lsls	r2, r2, #1	@ tmp339, tmp337,
	movs	r1, #0	@ tmp340,
	strh	r1, [r2, r3]	@ tmp341, gBG0MapBuffer[y_57][x_56]
@ Pokedex.c:260: 		for (int y = 5; y < 20; y++) { 
	ldr	r3, [r7, #76]	@ tmp343, y
	adds	r3, r3, #1	@ tmp342,
	str	r3, [r7, #76]	@ tmp342, y
.L22:
@ Pokedex.c:260: 		for (int y = 5; y < 20; y++) { 
	ldr	r3, [r7, #76]	@ tmp344, y
	cmp	r3, #19	@ tmp344,
	ble	.L23		@,
@ Pokedex.c:259: 	for (int x = 0; x < 30; x++) { // clear out most of bg0 
	ldr	r3, [r7, #80]	@ tmp346, x
	adds	r3, r3, #1	@ tmp345,
	str	r3, [r7, #80]	@ tmp345, x
.L21:
@ Pokedex.c:259: 	for (int x = 0; x < 30; x++) { // clear out most of bg0 
	ldr	r3, [r7, #80]	@ tmp347, x
	cmp	r3, #29	@ tmp347,
	ble	.L24		@,
@ Pokedex.c:265: 	if (caught)
	movs	r3, #55	@ tmp407,
	adds	r3, r7, r3	@ tmp348,, tmp407
	ldrb	r3, [r3]	@ tmp349, caught
	cmp	r3, #0	@ tmp349,
	beq	.L25		@,
@ Pokedex.c:267: 		DrawIcon(
	ldr	r3, [r7, #64]	@ tmp350, out
	adds	r3, r3, #14	@ _46,
	movs	r2, #128	@ tmp387,
	lsls	r2, r2, #7	@ tmp351, tmp387,
	movs	r1, #171	@,
	movs	r0, r3	@, _46
	ldr	r3, .L32+136	@ tmp352,
	bl	.L13		@
	b	.L26		@
.L25:
@ Pokedex.c:273: 		DrawIcon(
	ldr	r3, [r7, #64]	@ tmp353, out
	adds	r3, r3, #14	@ _47,
	movs	r2, #128	@ tmp386,
	lsls	r2, r2, #7	@ tmp354, tmp386,
	movs	r1, #170	@,
	movs	r0, r3	@, _47
	ldr	r3, .L32+136	@ tmp355,
	bl	.L13		@
.L26:
@ Pokedex.c:278: 	if (proc->areaBitfield_A)
	ldr	r3, [r7, #68]	@ tmp356, proc
	ldr	r3, [r3, #52]	@ _48, proc_70->areaBitfield_A
@ Pokedex.c:278: 	if (proc->areaBitfield_A)
	cmp	r3, #0	@ _48,
	beq	.L27		@,
@ Pokedex.c:280: 		for (int i = 0; i<64; i++)
	movs	r3, #0	@ tmp357,
	str	r3, [r7, #72]	@ tmp357, i
@ Pokedex.c:280: 		for (int i = 0; i<64; i++)
	b	.L28		@
.L30:
@ Pokedex.c:282: 			if (proc->areaBitfield_A & 1<<i)
	ldr	r3, [r7, #68]	@ tmp358, proc
	ldr	r2, [r3, #52]	@ _49, proc_70->areaBitfield_A
@ Pokedex.c:282: 			if (proc->areaBitfield_A & 1<<i)
	ldr	r3, [r7, #72]	@ tmp359, i
	asrs	r2, r2, r3	@ _49, _49, tmp359
	movs	r3, r2	@ _50, _49
	movs	r2, #1	@ tmp360,
	ands	r3, r2	@ _51, tmp360
@ Pokedex.c:282: 			if (proc->areaBitfield_A & 1<<i)
	beq	.L29		@,
@ Pokedex.c:284: 				u8 xx = AreaTable[i].xx;
	movs	r0, #31	@ tmp409,
	adds	r3, r7, r0	@ tmp361,, tmp409
	ldr	r2, .L32+140	@ tmp362,
	ldr	r1, [r7, #72]	@ tmp363, i
	lsls	r1, r1, #1	@ tmp364, tmp363,
	ldrb	r2, [r1, r2]	@ tmp365, AreaTable
	strb	r2, [r3]	@ tmp365, xx
@ Pokedex.c:285: 				u8 yy = AreaTable[i].yy;
	movs	r4, #30	@ tmp410,
	adds	r3, r7, r4	@ tmp366,, tmp410
	ldr	r1, .L32+140	@ tmp367,
	ldr	r2, [r7, #72]	@ tmp368, i
	lsls	r2, r2, #1	@ tmp369, tmp368,
	adds	r2, r1, r2	@ tmp370, tmp367, tmp369
	adds	r2, r2, #1	@ tmp371,
	ldrb	r2, [r2]	@ tmp372, AreaTable
	strb	r2, [r3]	@ tmp372, yy
@ Pokedex.c:286: 				DrawIcon(&gBG0MapBuffer[yy][xx],0xC,TILEREF(0, 0x4));
	adds	r3, r7, r4	@ tmp373,, tmp411
	ldrb	r2, [r3]	@ _52, yy
	adds	r3, r7, r0	@ tmp374,, tmp412
	ldrb	r3, [r3]	@ _53, xx
@ Pokedex.c:286: 				DrawIcon(&gBG0MapBuffer[yy][xx],0xC,TILEREF(0, 0x4));
	lsls	r2, r2, #5	@ tmp375, _52,
	adds	r3, r2, r3	@ tmp376, tmp375, _53
	lsls	r2, r3, #1	@ tmp377, tmp376,
	ldr	r3, .L32+132	@ tmp378,
	adds	r3, r2, r3	@ _54, tmp377, tmp378
	movs	r2, #128	@ tmp385,
	lsls	r2, r2, #7	@ tmp379, tmp385,
	movs	r1, #12	@,
	movs	r0, r3	@, _54
	ldr	r3, .L32+136	@ tmp380,
	bl	.L13		@
.L29:
@ Pokedex.c:280: 		for (int i = 0; i<64; i++)
	ldr	r3, [r7, #72]	@ tmp382, i
	adds	r3, r3, #1	@ tmp381,
	str	r3, [r7, #72]	@ tmp381, i
.L28:
@ Pokedex.c:280: 		for (int i = 0; i<64; i++)
	ldr	r3, [r7, #72]	@ tmp383, i
	cmp	r3, #63	@ tmp383,
	ble	.L30		@,
.L27:
@ Pokedex.c:296:     return ME_NONE;
	movs	r3, #0	@ _133,
@ Pokedex.c:297: }
	movs	r0, r3	@, <retval>
	mov	sp, r7	@,
	add	sp, sp, #88	@,,
	@ sp needed	@
	pop	{r4, r5, r7}
	pop	{r1}
	bx	r1
.L33:
	.align	2
.L32:
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
	.word	.LC20
	.word	memset
	.word	gpCurrentFont
	.word	.LC24
	.word	.LC26
	.word	gBG0MapBuffer+78
	.word	DrawUiNumber
	.word	gBG0MapBuffer+206
	.word	PokedexSeenCaughtBox
	.word	gBG1MapBuffer
	.word	BgMap_ApplyTsa
	.word	EndFaceById
	.word	StartFace
	.word	-3073
	.word	PokedexPortraitBox
	.word	gBG1MapBuffer+40
	.word	MyPalette
	.word	CopyToPaletteBuffer
	.word	gPaletteSyncFlag
	.word	LoadIconPalettes
	.word	ClearIcons
	.word	EnableBgSyncByMask
	.word	gBG0MapBuffer
	.word	DrawIcon
	.word	AreaTable
	.size	PokedexDrawIdle, .-PokedexDrawIdle
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
@ Pokedex.c:306:     struct PokedexProc* proc = (void*) ProcStart(Proc_ChapterPokedex, ROOT_PROC_3);
	ldr	r3, .L42	@ tmp147,
	movs	r1, #3	@,
	movs	r0, r3	@, tmp147
	ldr	r3, .L42+4	@ tmp148,
	bl	.L13		@
	movs	r3, r0	@ tmp149,
	str	r3, [r7, #20]	@ tmp149, proc
@ Pokedex.c:308:     proc->menuIndex = 1;
	ldr	r3, [r7, #20]	@ tmp150, proc
	movs	r2, #48	@ tmp151,
	movs	r1, #1	@ tmp152,
	strb	r1, [r3, r2]	@ tmp153, proc_41->menuIndex
@ Pokedex.c:309: 	proc->TotalCaught = CountCaught();
	ldr	r3, .L42+8	@ tmp154,
	bl	.L13		@
	movs	r3, r0	@ _1,
@ Pokedex.c:309: 	proc->TotalCaught = CountCaught();
	lsls	r3, r3, #24	@ tmp155, _1,
	lsrs	r1, r3, #24	@ _2, tmp155,
	ldr	r3, [r7, #20]	@ tmp156, proc
	movs	r2, #50	@ tmp157,
	strb	r1, [r3, r2]	@ tmp158, proc_41->TotalCaught
@ Pokedex.c:310: 	proc->TotalSeen = CountSeen();
	ldr	r3, .L42+12	@ tmp159,
	bl	.L13		@
	movs	r3, r0	@ _3,
@ Pokedex.c:310: 	proc->TotalSeen = CountSeen();
	lsls	r3, r3, #24	@ tmp160, _3,
	lsrs	r1, r3, #24	@ _4, tmp160,
	ldr	r3, [r7, #20]	@ tmp161, proc
	movs	r2, #49	@ tmp162,
	strb	r1, [r3, r2]	@ tmp163, proc_41->TotalSeen
@ Pokedex.c:312: 	Decompress(WorldMap_img,(void*)0x6008000);
	ldr	r2, .L42+16	@ tmp164,
	ldr	r3, .L42+20	@ tmp165,
	movs	r1, r2	@, tmp164
	movs	r0, r3	@, tmp165
	ldr	r3, .L42+24	@ tmp166,
	bl	.L13		@
@ Pokedex.c:314: 	CopyToPaletteBuffer(WorldMap_pal,0x20*6,(gWorldMapPaletteCount-2)*32);
	ldr	r3, .L42+28	@ tmp167,
	ldrb	r3, [r3]	@ gWorldMapPaletteCount.4_5, gWorldMapPaletteCount
	subs	r3, r3, #2	@ _7,
@ Pokedex.c:314: 	CopyToPaletteBuffer(WorldMap_pal,0x20*6,(gWorldMapPaletteCount-2)*32);
	lsls	r3, r3, #5	@ _8, _7,
@ Pokedex.c:314: 	CopyToPaletteBuffer(WorldMap_pal,0x20*6,(gWorldMapPaletteCount-2)*32);
	movs	r2, r3	@ _9, _8
	ldr	r3, .L42+32	@ tmp168,
	movs	r1, #192	@,
	movs	r0, r3	@, tmp168
	ldr	r3, .L42+36	@ tmp169,
	bl	.L13		@
@ Pokedex.c:315: 	CopyToPaletteBuffer(WorldMap_pal+(gWorldMapPaletteCount-1)*16,0x20*15,32);
	ldr	r3, .L42+28	@ tmp170,
	ldrb	r3, [r3]	@ gWorldMapPaletteCount.5_10, gWorldMapPaletteCount
	subs	r3, r3, #1	@ _12,
@ Pokedex.c:315: 	CopyToPaletteBuffer(WorldMap_pal+(gWorldMapPaletteCount-1)*16,0x20*15,32);
	lsls	r2, r3, #5	@ _14, _13,
@ Pokedex.c:315: 	CopyToPaletteBuffer(WorldMap_pal+(gWorldMapPaletteCount-1)*16,0x20*15,32);
	ldr	r3, .L42+32	@ tmp171,
	adds	r3, r2, r3	@ _15, _14, tmp171
	movs	r2, #240	@ tmp252,
	lsls	r1, r2, #1	@ tmp172, tmp252,
	movs	r2, #32	@,
	movs	r0, r3	@, _15
	ldr	r3, .L42+36	@ tmp173,
	bl	.L13		@
@ Pokedex.c:317: 	memcpy(gGenericBuffer, WorldMap_tsa, 0x4B2);
	ldr	r2, .L42+40	@ tmp174,
	ldr	r1, .L42+44	@ tmp175,
	ldr	r3, .L42+48	@ tmp176,
	movs	r0, r3	@, tmp176
	ldr	r3, .L42+52	@ tmp177,
	bl	.L13		@
@ Pokedex.c:319: 	TSA* tsaBuffer = (TSA*)gGenericBuffer;
	ldr	r3, .L42+48	@ tmp178,
	str	r3, [r7, #16]	@ tmp178, tsaBuffer
@ Pokedex.c:320: 	for ( int i = 0 ; i < tsaBuffer->height+1 ; i++ )
	movs	r3, #0	@ tmp179,
	str	r3, [r7, #28]	@ tmp179, i
@ Pokedex.c:320: 	for ( int i = 0 ; i < tsaBuffer->height+1 ; i++ )
	b	.L36		@
.L40:
@ Pokedex.c:322: 		for ( int j = 0 ; j < tsaBuffer->width+1 ; j++ )
	movs	r3, #0	@ tmp180,
	str	r3, [r7, #24]	@ tmp180, j
@ Pokedex.c:322: 		for ( int j = 0 ; j < tsaBuffer->width+1 ; j++ )
	b	.L37		@
.L39:
@ Pokedex.c:324: 			if ( tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID == 16-6 )
	ldr	r3, [r7, #16]	@ tmp181, tsaBuffer
	ldrb	r3, [r3]	@ _16, *tsaBuffer_51
@ Pokedex.c:324: 			if ( tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID == 16-6 )
	adds	r3, r3, #1	@ _18,
@ Pokedex.c:324: 			if ( tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID == 16-6 )
	ldr	r2, [r7, #28]	@ tmp182, i
	muls	r2, r3	@ _19, _18
@ Pokedex.c:324: 			if ( tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID == 16-6 )
	ldr	r3, [r7, #24]	@ tmp183, j
	adds	r3, r2, r3	@ _20, _19, tmp183
@ Pokedex.c:324: 			if ( tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID == 16-6 )
	ldr	r2, [r7, #16]	@ tmp184, tsaBuffer
	lsls	r3, r3, #1	@ tmp185, _20,
	adds	r3, r2, r3	@ tmp188, tmp184, tmp185
	ldrb	r3, [r3, #3]	@ tmp189,
	lsls	r3, r3, #24	@ tmp191, tmp189,
	lsrs	r3, r3, #28	@ tmp190, tmp191,
	lsls	r3, r3, #24	@ tmp192, tmp190,
	lsrs	r3, r3, #24	@ _21, tmp192,
@ Pokedex.c:324: 			if ( tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID == 16-6 )
	cmp	r3, #10	@ _21,
	bne	.L38		@,
@ Pokedex.c:326: 				tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID--;
	ldr	r3, [r7, #16]	@ tmp193, tsaBuffer
	ldrb	r3, [r3]	@ _22, *tsaBuffer_51
@ Pokedex.c:326: 				tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID--;
	adds	r3, r3, #1	@ _24,
@ Pokedex.c:326: 				tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID--;
	ldr	r2, [r7, #28]	@ tmp194, i
	muls	r2, r3	@ _25, _24
@ Pokedex.c:326: 				tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID--;
	ldr	r3, [r7, #24]	@ tmp195, j
	adds	r3, r2, r3	@ _26, _25, tmp195
@ Pokedex.c:326: 				tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID--;
	ldr	r1, [r7, #16]	@ tmp196, tsaBuffer
	lsls	r2, r3, #1	@ tmp197, _26,
	adds	r2, r1, r2	@ tmp200, tmp196, tmp197
	ldrb	r2, [r2, #3]	@ tmp201,
	lsls	r2, r2, #24	@ tmp203, tmp201,
	lsrs	r2, r2, #28	@ tmp202, tmp203,
	lsls	r2, r2, #24	@ tmp204, tmp202,
	lsrs	r2, r2, #24	@ _27, tmp204,
@ Pokedex.c:326: 				tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID--;
	adds	r2, r2, #15	@ tmp205,
	adds	r1, r2, #0	@ tmp206, tmp205
	movs	r2, #15	@ tmp208,
	ands	r2, r1	@ tmp207, tmp206
	lsls	r2, r2, #24	@ tmp209, tmp207,
	lsrs	r2, r2, #24	@ _29, tmp209,
	ldr	r1, [r7, #16]	@ tmp210, tsaBuffer
	lsls	r3, r3, #1	@ tmp211, _26,
	adds	r3, r1, r3	@ tmp212, tmp210, tmp211
	lsls	r0, r2, #4	@ tmp214, _29,
	ldrb	r2, [r3, #3]	@ tmp215,
	movs	r1, #15	@ tmp217,
	ands	r2, r1	@ tmp216, tmp217
	adds	r1, r2, #0	@ tmp218, tmp216
	adds	r2, r0, #0	@ tmp219, tmp214
	orrs	r2, r1	@ tmp220, tmp218
	strb	r2, [r3, #3]	@ tmp221,
.L38:
@ Pokedex.c:322: 		for ( int j = 0 ; j < tsaBuffer->width+1 ; j++ )
	ldr	r3, [r7, #24]	@ tmp223, j
	adds	r3, r3, #1	@ tmp222,
	str	r3, [r7, #24]	@ tmp222, j
.L37:
@ Pokedex.c:322: 		for ( int j = 0 ; j < tsaBuffer->width+1 ; j++ )
	ldr	r3, [r7, #16]	@ tmp224, tsaBuffer
	ldrb	r3, [r3]	@ _30, *tsaBuffer_51
	movs	r2, r3	@ _31, _30
@ Pokedex.c:322: 		for ( int j = 0 ; j < tsaBuffer->width+1 ; j++ )
	ldr	r3, [r7, #24]	@ tmp225, j
	cmp	r3, r2	@ tmp225, _31
	ble	.L39		@,
@ Pokedex.c:320: 	for ( int i = 0 ; i < tsaBuffer->height+1 ; i++ )
	ldr	r3, [r7, #28]	@ tmp227, i
	adds	r3, r3, #1	@ tmp226,
	str	r3, [r7, #28]	@ tmp226, i
.L36:
@ Pokedex.c:320: 	for ( int i = 0 ; i < tsaBuffer->height+1 ; i++ )
	ldr	r3, [r7, #16]	@ tmp228, tsaBuffer
	ldrb	r3, [r3, #1]	@ _32,
	movs	r2, r3	@ _33, _32
@ Pokedex.c:320: 	for ( int i = 0 ; i < tsaBuffer->height+1 ; i++ )
	ldr	r3, [r7, #28]	@ tmp229, i
	cmp	r3, r2	@ tmp229, _33
	ble	.L40		@,
@ Pokedex.c:330: 	BgMap_ApplyTsa(gBg3MapBuffer,gGenericBuffer, 6<<12);
	movs	r3, #192	@ tmp250,
	lsls	r2, r3, #7	@ tmp230, tmp250,
	ldr	r1, .L42+48	@ tmp231,
	ldr	r3, .L42+56	@ tmp232,
	movs	r0, r3	@, tmp232
	ldr	r3, .L42+60	@ tmp233,
	bl	.L13		@
@ Pokedex.c:331: 	SetBgTileDataOffset(2,0x8000);
	movs	r3, #128	@ tmp251,
	lsls	r3, r3, #8	@ tmp234, tmp251,
	movs	r1, r3	@, tmp234
	movs	r0, #2	@,
	ldr	r3, .L42+64	@ tmp235,
	bl	.L13		@
@ Pokedex.c:333: 	struct LCDIOBuffer* LCDIOBuffer = &gLCDIOBuffer;
	ldr	r3, .L42+68	@ tmp236,
	str	r3, [r7, #12]	@ tmp236, LCDIOBuffer
@ Pokedex.c:334: 	LCDIOBuffer->bgOffset[3].x = 0; // make offset as 0, rather than scrolled to the right
	ldr	r3, [r7, #12]	@ tmp237, LCDIOBuffer
	movs	r2, #0	@ tmp238,
	strh	r2, [r3, #40]	@ tmp239, LCDIOBuffer_55->bgOffset[3].x
@ Pokedex.c:335: 	LCDIOBuffer->bgOffset[3].y = 0; 
	ldr	r3, [r7, #12]	@ tmp240, LCDIOBuffer
	movs	r2, #0	@ tmp241,
	strh	r2, [r3, #42]	@ tmp242, LCDIOBuffer_55->bgOffset[3].y
@ Pokedex.c:339: 	LoadIconPalettes(4);
	movs	r0, #4	@,
	ldr	r3, .L42+72	@ tmp243,
	bl	.L13		@
@ Pokedex.c:340: 	EnableBgSyncByMask(BG_SYNC_BIT(3)); // sync bg 3 
	movs	r0, #8	@,
	ldr	r3, .L42+76	@ tmp244,
	bl	.L13		@
@ Pokedex.c:341: 	EnablePaletteSync();
	ldr	r3, .L42+80	@ tmp245,
	bl	.L13		@
@ Pokedex.c:344:     StartMenuChild(&Menu_Pokedex, (void*) proc);
	ldr	r2, [r7, #20]	@ tmp246, proc
	ldr	r3, .L42+84	@ tmp247,
	movs	r1, r2	@, tmp246
	movs	r0, r3	@, tmp247
	ldr	r3, .L42+88	@ tmp248,
	bl	.L13		@
@ Pokedex.c:346:     return ME_DISABLE | ME_END | ME_PLAY_BEEP | ME_CLEAR_GFX;
	movs	r3, #23	@ _62,
@ Pokedex.c:347: }
	movs	r0, r3	@, <retval>
	mov	sp, r7	@,
	add	sp, sp, #32	@,,
	@ sp needed	@
	pop	{r7}
	pop	{r1}
	bx	r1
.L43:
	.align	2
.L42:
	.word	Proc_ChapterPokedex
	.word	ProcStart
	.word	CountCaught
	.word	CountSeen
	.word	100696064
	.word	WorldMap_img
	.word	Decompress
	.word	gWorldMapPaletteCount
	.word	WorldMap_pal
	.word	CopyToPaletteBuffer
	.word	1202
	.word	WorldMap_tsa
	.word	gGenericBuffer
	.word	memcpy
	.word	gBg3MapBuffer
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
@ Pokedex.c:351:     command->onCycle = (void*) PokedexDrawIdle(menu, command);
	ldr	r2, [r7]	@ tmp115, command
	ldr	r3, [r7, #4]	@ tmp116, menu
	movs	r1, r2	@, tmp115
	movs	r0, r3	@, tmp116
	bl	PokedexDrawIdle		@
	movs	r3, r0	@ _1,
@ Pokedex.c:351:     command->onCycle = (void*) PokedexDrawIdle(menu, command);
	movs	r2, r3	@ _2, _1
@ Pokedex.c:351:     command->onCycle = (void*) PokedexDrawIdle(menu, command);
	ldr	r3, [r7]	@ tmp117, command
	str	r2, [r3, #12]	@ _2, command_5(D)->onCycle
@ Pokedex.c:352: }
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
@ Pokedex.c:356: 	EndFaceById(0);
	movs	r0, #0	@,
	ldr	r3, .L47	@ tmp113,
	bl	.L13		@
@ Pokedex.c:357: 	RenderBmMap();
	ldr	r3, .L47+4	@ tmp114,
	bl	.L13		@
@ Pokedex.c:358: 	UpdateBmMapDisplay();
	ldr	r3, .L47+8	@ tmp115,
	bl	.L13		@
@ Pokedex.c:359:     return;
	nop	
@ Pokedex.c:360: }
	mov	sp, r7	@,
	add	sp, sp, #8	@,,
	@ sp needed	@
	pop	{r7}
	pop	{r0}
	bx	r0
.L48:
	.align	2
.L47:
	.word	EndFaceById
	.word	RenderBmMap
	.word	UpdateBmMapDisplay
	.size	PokedexMenuEnd, .-PokedexMenuEnd
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	Pokedex_RetrieveAreasFound, %function
Pokedex_RetrieveAreasFound:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}	@
	sub	sp, sp, #28	@,,
	add	r7, sp, #0	@,,
	str	r1, [r7, #8]	@ areaBitfield_A, areaBitfield_A
	str	r2, [r7, #4]	@ areaBitfield_B, areaBitfield_B
	movs	r3, #15	@ tmp256,
	adds	r3, r7, r3	@ tmp147,, tmp256
	adds	r2, r0, #0	@ tmp148, tmp146
	strb	r2, [r3]	@ tmp148, classID
@ Pokedex.c:387: 	for (u16 i = 0 ; i <= 0x80 ; i++) 
	movs	r3, #22	@ tmp257,
	adds	r3, r7, r3	@ tmp149,, tmp257
	movs	r2, #0	@ tmp150,
	strh	r2, [r3]	@ tmp151, i
@ Pokedex.c:387: 	for (u16 i = 0 ; i <= 0x80 ; i++) 
	b	.L50		@
.L53:
@ Pokedex.c:389: 		u8 Chapter = MonsterSpawnTable[i].ChID;
	movs	r4, #22	@ tmp258,
	adds	r3, r7, r4	@ tmp152,, tmp258
	ldrh	r2, [r3]	@ _1, i
@ Pokedex.c:389: 		u8 Chapter = MonsterSpawnTable[i].ChID;
	movs	r6, #21	@ tmp259,
	adds	r1, r7, r6	@ tmp153,, tmp259
	ldr	r0, .L55	@ tmp154,
	movs	r3, r2	@ tmp155, _1
	lsls	r3, r3, #1	@ tmp155, tmp155,
	adds	r3, r3, r2	@ tmp155, tmp155, _1
	lsls	r3, r3, #2	@ tmp156, tmp155,
	adds	r3, r0, r3	@ tmp157, tmp154, tmp155
	adds	r3, r3, #10	@ tmp158,
	ldrb	r3, [r3]	@ tmp159, MonsterSpawnTable
	strb	r3, [r1]	@ tmp159, Chapter
@ Pokedex.c:390: 		if (Chapter)
	adds	r3, r7, r6	@ tmp160,, tmp260
	ldrb	r3, [r3]	@ tmp161, Chapter
	cmp	r3, #0	@ tmp161,
	bne	.LCB1102	@
	b	.L51	@long jump	@
.LCB1102:
@ Pokedex.c:393: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	adds	r3, r7, r4	@ tmp162,, tmp261
	ldrh	r2, [r3]	@ _2, i
	ldr	r1, .L55	@ tmp163,
	movs	r3, r2	@ tmp164, _2
	lsls	r3, r3, #1	@ tmp164, tmp164,
	adds	r3, r3, r2	@ tmp164, tmp164, _2
	lsls	r3, r3, #2	@ tmp165, tmp164,
	ldrb	r3, [r3, r1]	@ _3, MonsterSpawnTable
@ Pokedex.c:393: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	movs	r5, #15	@ tmp262,
	adds	r2, r7, r5	@ tmp166,, tmp262
	ldrb	r2, [r2]	@ tmp168, classID
	subs	r3, r2, r3	@ tmp170, tmp168, _3
	rsbs	r2, r3, #0	@ tmp171, tmp170
	adcs	r3, r3, r2	@ tmp169, tmp170, tmp171
	lsls	r3, r3, #24	@ tmp172, tmp167,
	lsrs	r1, r3, #24	@ _4, tmp172,
@ Pokedex.c:393: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	adds	r3, r7, r4	@ tmp173,, tmp263
	ldrh	r2, [r3]	@ _5, i
	ldr	r0, .L55	@ tmp174,
	movs	r3, r2	@ tmp175, _5
	lsls	r3, r3, #1	@ tmp175, tmp175,
	adds	r3, r3, r2	@ tmp175, tmp175, _5
	lsls	r3, r3, #2	@ tmp176, tmp175,
	adds	r3, r0, r3	@ tmp177, tmp174, tmp175
	adds	r3, r3, #1	@ tmp178,
	ldrb	r3, [r3]	@ _6, MonsterSpawnTable
@ Pokedex.c:393: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	adds	r2, r7, r5	@ tmp179,, tmp264
	ldrb	r2, [r2]	@ tmp181, classID
	subs	r3, r2, r3	@ tmp183, tmp181, _6
	rsbs	r2, r3, #0	@ tmp184, tmp183
	adcs	r3, r3, r2	@ tmp182, tmp183, tmp184
	lsls	r3, r3, #24	@ tmp185, tmp180,
	lsrs	r3, r3, #24	@ _7, tmp185,
	orrs	r3, r1	@ tmp186, _4
	lsls	r3, r3, #24	@ tmp187, tmp186,
	lsrs	r3, r3, #24	@ _8, tmp187,
	movs	r0, r3	@ _9, _8
@ Pokedex.c:393: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	adds	r3, r7, r4	@ tmp188,, tmp265
	ldrh	r2, [r3]	@ _10, i
	ldr	r1, .L55	@ tmp189,
	movs	r3, r2	@ tmp190, _10
	lsls	r3, r3, #1	@ tmp190, tmp190,
	adds	r3, r3, r2	@ tmp190, tmp190, _10
	lsls	r3, r3, #2	@ tmp191, tmp190,
	adds	r3, r1, r3	@ tmp192, tmp189, tmp190
	adds	r3, r3, #2	@ tmp193,
	ldrb	r3, [r3]	@ _11, MonsterSpawnTable
@ Pokedex.c:393: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	adds	r2, r7, r5	@ tmp194,, tmp266
	ldrb	r2, [r2]	@ tmp196, classID
	subs	r3, r2, r3	@ tmp198, tmp196, _11
	rsbs	r2, r3, #0	@ tmp199, tmp198
	adcs	r3, r3, r2	@ tmp197, tmp198, tmp199
	lsls	r3, r3, #24	@ tmp200, tmp195,
	lsrs	r3, r3, #24	@ _12, tmp200,
@ Pokedex.c:393: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	movs	r1, r0	@ _9, _9
	orrs	r1, r3	@ _9, _13
@ Pokedex.c:393: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	adds	r3, r7, r4	@ tmp201,, tmp268
	ldrh	r2, [r3]	@ _15, i
	ldr	r0, .L55	@ tmp202,
	movs	r3, r2	@ tmp203, _15
	lsls	r3, r3, #1	@ tmp203, tmp203,
	adds	r3, r3, r2	@ tmp203, tmp203, _15
	lsls	r3, r3, #2	@ tmp204, tmp203,
	adds	r3, r0, r3	@ tmp205, tmp202, tmp203
	adds	r3, r3, #3	@ tmp206,
	ldrb	r3, [r3]	@ _16, MonsterSpawnTable
@ Pokedex.c:393: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	adds	r2, r7, r5	@ tmp207,, tmp269
	ldrb	r2, [r2]	@ tmp209, classID
	subs	r3, r2, r3	@ tmp211, tmp209, _16
	rsbs	r2, r3, #0	@ tmp212, tmp211
	adcs	r3, r3, r2	@ tmp210, tmp211, tmp212
	lsls	r3, r3, #24	@ tmp213, tmp208,
	lsrs	r3, r3, #24	@ _17, tmp213,
@ Pokedex.c:393: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	orrs	r1, r3	@ _19, _18
@ Pokedex.c:393: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	adds	r3, r7, r4	@ tmp214,, tmp270
	ldrh	r2, [r3]	@ _20, i
	ldr	r0, .L55	@ tmp215,
	movs	r3, r2	@ tmp216, _20
	lsls	r3, r3, #1	@ tmp216, tmp216,
	adds	r3, r3, r2	@ tmp216, tmp216, _20
	lsls	r3, r3, #2	@ tmp217, tmp216,
	adds	r3, r0, r3	@ tmp218, tmp215, tmp216
	adds	r3, r3, #4	@ tmp219,
	ldrb	r3, [r3]	@ _21, MonsterSpawnTable
@ Pokedex.c:393: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	adds	r2, r7, r5	@ tmp220,, tmp271
	ldrb	r2, [r2]	@ tmp222, classID
	subs	r3, r2, r3	@ tmp224, tmp222, _21
	rsbs	r2, r3, #0	@ tmp225, tmp224
	adcs	r3, r3, r2	@ tmp223, tmp224, tmp225
	lsls	r3, r3, #24	@ tmp226, tmp221,
	lsrs	r3, r3, #24	@ _22, tmp226,
@ Pokedex.c:393: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	orrs	r3, r1	@ _24, _19
@ Pokedex.c:393: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	beq	.L51		@,
@ Pokedex.c:395: 				if (Chapter <= 63)
	adds	r3, r7, r6	@ tmp227,, tmp272
	ldrb	r3, [r3]	@ tmp230, Chapter
	cmp	r3, #63	@ tmp230,
	bhi	.L52		@,
@ Pokedex.c:399: 					*areaBitfield_A = *areaBitfield_A | 1<<Chapter;
	ldr	r3, [r7, #8]	@ tmp231, areaBitfield_A
	ldr	r2, [r3]	@ _25, *areaBitfield_A_42(D)
@ Pokedex.c:399: 					*areaBitfield_A = *areaBitfield_A | 1<<Chapter;
	adds	r3, r7, r6	@ tmp232,, tmp273
	ldrb	r3, [r3]	@ _26, Chapter
	movs	r1, #1	@ tmp233,
	lsls	r1, r1, r3	@ tmp233, tmp233, _26
	movs	r3, r1	@ _27, tmp233
@ Pokedex.c:399: 					*areaBitfield_A = *areaBitfield_A | 1<<Chapter;
	orrs	r2, r3	@ _28, _27
@ Pokedex.c:399: 					*areaBitfield_A = *areaBitfield_A | 1<<Chapter;
	ldr	r3, [r7, #8]	@ tmp234, areaBitfield_A
	str	r2, [r3]	@ _28, *areaBitfield_A_42(D)
.L52:
@ Pokedex.c:401: 				if ((Chapter > 63) && (Chapter < 127))
	movs	r1, #21	@ tmp275,
	adds	r3, r7, r1	@ tmp235,, tmp275
	ldrb	r3, [r3]	@ tmp238, Chapter
	cmp	r3, #63	@ tmp238,
	bls	.L51		@,
@ Pokedex.c:401: 				if ((Chapter > 63) && (Chapter < 127))
	adds	r3, r7, r1	@ tmp239,, tmp276
	ldrb	r3, [r3]	@ tmp242, Chapter
	cmp	r3, #126	@ tmp242,
	bhi	.L51		@,
@ Pokedex.c:403: 					*areaBitfield_B = *areaBitfield_B | 1<<Chapter;
	ldr	r3, [r7, #4]	@ tmp243, areaBitfield_B
	ldr	r2, [r3]	@ _29, *areaBitfield_B_44(D)
@ Pokedex.c:403: 					*areaBitfield_B = *areaBitfield_B | 1<<Chapter;
	adds	r3, r7, r1	@ tmp244,, tmp277
	ldrb	r3, [r3]	@ _30, Chapter
	movs	r1, #1	@ tmp245,
	lsls	r1, r1, r3	@ tmp245, tmp245, _30
	movs	r3, r1	@ _31, tmp245
@ Pokedex.c:403: 					*areaBitfield_B = *areaBitfield_B | 1<<Chapter;
	orrs	r2, r3	@ _32, _31
@ Pokedex.c:403: 					*areaBitfield_B = *areaBitfield_B | 1<<Chapter;
	ldr	r3, [r7, #4]	@ tmp246, areaBitfield_B
	str	r2, [r3]	@ _32, *areaBitfield_B_44(D)
.L51:
@ Pokedex.c:387: 	for (u16 i = 0 ; i <= 0x80 ; i++) 
	movs	r1, #22	@ tmp279,
	adds	r3, r7, r1	@ tmp247,, tmp279
	ldrh	r2, [r3]	@ i.6_33, i
	adds	r3, r7, r1	@ tmp248,, tmp280
	adds	r2, r2, #1	@ tmp249,
	strh	r2, [r3]	@ tmp250, i
.L50:
@ Pokedex.c:387: 	for (u16 i = 0 ; i <= 0x80 ; i++) 
	movs	r3, #22	@ tmp281,
	adds	r3, r7, r3	@ tmp251,, tmp281
	ldrh	r3, [r3]	@ tmp254, i
	cmp	r3, #128	@ tmp254,
	bhi	.LCB1255	@
	b	.L53	@long jump	@
.LCB1255:
@ Pokedex.c:408: 	return;
	nop	
@ Pokedex.c:409: }
	mov	sp, r7	@,
	add	sp, sp, #28	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L56:
	.align	2
.L55:
	.word	MonsterSpawnTable
	.size	Pokedex_RetrieveAreasFound, .-Pokedex_RetrieveAreasFound
	.ident	"GCC: (devkitARM release 56) 11.1.0"
	.code 16
	.align	1
.L13:
	bx	r3
.L34:
	bx	r4
