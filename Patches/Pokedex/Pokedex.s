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
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}	@
	sub	sp, sp, #16	@,,
	add	r7, sp, #0	@,,
	str	r0, [r7, #4]	@ menu, menu
	str	r1, [r7]	@ command, command
@ Pokedex.c:123:     struct PokedexProc* const proc = (void*) menu->parent;
	ldr	r3, [r7, #4]	@ tmp143, menu
	ldr	r3, [r3, #20]	@ tmp144, menu_38(D)->parent
	str	r3, [r7, #12]	@ tmp144, proc
@ Pokedex.c:126:     if (gKeyState.repeatedKeys & KEY_DPAD_LEFT) {
	ldr	r3, .L11	@ tmp145,
	ldrh	r3, [r3, #6]	@ _1,
@ Pokedex.c:126:     if (gKeyState.repeatedKeys & KEY_DPAD_LEFT) {
	movs	r2, r3	@ _2, _1
	movs	r3, #32	@ tmp146,
	ands	r3, r2	@ _3, _2
@ Pokedex.c:126:     if (gKeyState.repeatedKeys & KEY_DPAD_LEFT) {
	beq	.L2		@,
@ Pokedex.c:127:         if (proc->menuIndex < 0xFF) {
	ldr	r3, [r7, #12]	@ tmp147, proc
	movs	r2, #48	@ tmp148,
	ldrb	r3, [r3, r2]	@ _4,
@ Pokedex.c:127:         if (proc->menuIndex < 0xFF) {
	cmp	r3, #255	@ _4,
	beq	.L2		@,
@ Pokedex.c:128:             proc->menuIndex--;
	ldr	r3, [r7, #12]	@ tmp149, proc
	movs	r2, #48	@ tmp150,
	ldrb	r3, [r3, r2]	@ _5,
@ Pokedex.c:128:             proc->menuIndex--;
	subs	r3, r3, #1	@ tmp151,
	lsls	r3, r3, #24	@ tmp152, tmp151,
	lsrs	r1, r3, #24	@ _7, tmp152,
	ldr	r3, [r7, #12]	@ tmp153, proc
	movs	r2, #48	@ tmp154,
	strb	r1, [r3, r2]	@ tmp155, proc_39->menuIndex
@ Pokedex.c:129: 			while (!PokedexTable[proc->menuIndex].IndexNumber)
	b	.L3		@
.L5:
@ Pokedex.c:131: 				if (proc->menuIndex > 2) 
	ldr	r3, [r7, #12]	@ tmp156, proc
	movs	r2, #48	@ tmp157,
	ldrb	r3, [r3, r2]	@ _8,
@ Pokedex.c:131: 				if (proc->menuIndex > 2) 
	cmp	r3, #2	@ _8,
	bls	.L4		@,
@ Pokedex.c:133: 					proc->menuIndex--;
	ldr	r3, [r7, #12]	@ tmp160, proc
	movs	r2, #48	@ tmp161,
	ldrb	r3, [r3, r2]	@ _9,
@ Pokedex.c:133: 					proc->menuIndex--;
	subs	r3, r3, #1	@ tmp162,
	lsls	r3, r3, #24	@ tmp163, tmp162,
	lsrs	r1, r3, #24	@ _11, tmp163,
	ldr	r3, [r7, #12]	@ tmp164, proc
	movs	r2, #48	@ tmp165,
	strb	r1, [r3, r2]	@ tmp166, proc_39->menuIndex
	b	.L3		@
.L4:
@ Pokedex.c:135: 				else { proc->menuIndex = 0xFF; }
	ldr	r3, [r7, #12]	@ tmp167, proc
	movs	r2, #48	@ tmp168,
	movs	r1, #255	@ tmp169,
	strb	r1, [r3, r2]	@ tmp170, proc_39->menuIndex
.L3:
@ Pokedex.c:129: 			while (!PokedexTable[proc->menuIndex].IndexNumber)
	ldr	r3, [r7, #12]	@ tmp171, proc
	movs	r2, #48	@ tmp172,
	ldrb	r3, [r3, r2]	@ _12,
	movs	r2, r3	@ _13, _12
@ Pokedex.c:129: 			while (!PokedexTable[proc->menuIndex].IndexNumber)
	ldr	r3, .L11+4	@ tmp173,
	lsls	r2, r2, #2	@ tmp174, _13,
	ldrb	r3, [r2, r3]	@ _14, PokedexTable
@ Pokedex.c:129: 			while (!PokedexTable[proc->menuIndex].IndexNumber)
	cmp	r3, #0	@ _14,
	beq	.L5		@,
@ Pokedex.c:137:             PokedexDraw(menu, command);
	ldr	r2, [r7]	@ tmp175, command
	ldr	r3, [r7, #4]	@ tmp176, menu
	movs	r1, r2	@, tmp175
	movs	r0, r3	@, tmp176
	bl	PokedexDraw		@
@ Pokedex.c:138:             PlaySfx(0x6B);
	ldr	r3, .L11+8	@ tmp177,
	movs	r2, #65	@ tmp178,
	ldrb	r3, [r3, r2]	@ _15, gChapterData
	movs	r2, #2	@ tmp180,
	ands	r3, r2	@ tmp179, tmp180
	lsls	r3, r3, #24	@ tmp181, tmp179,
	lsrs	r3, r3, #24	@ _16, tmp181,
	bne	.L2		@,
@ Pokedex.c:138:             PlaySfx(0x6B);
	movs	r0, #107	@,
	ldr	r3, .L11+12	@ tmp182,
	bl	.L13		@
.L2:
@ Pokedex.c:142:     if (gKeyState.repeatedKeys & KEY_DPAD_RIGHT) {
	ldr	r3, .L11	@ tmp183,
	ldrh	r3, [r3, #6]	@ _17,
@ Pokedex.c:142:     if (gKeyState.repeatedKeys & KEY_DPAD_RIGHT) {
	movs	r2, r3	@ _18, _17
	movs	r3, #16	@ tmp184,
	ands	r3, r2	@ _19, _18
@ Pokedex.c:142:     if (gKeyState.repeatedKeys & KEY_DPAD_RIGHT) {
	beq	.L6		@,
@ Pokedex.c:143:         if (proc->menuIndex < 0xFF) {
	ldr	r3, [r7, #12]	@ tmp185, proc
	movs	r2, #48	@ tmp186,
	ldrb	r3, [r3, r2]	@ _20,
@ Pokedex.c:143:         if (proc->menuIndex < 0xFF) {
	cmp	r3, #255	@ _20,
	beq	.L6		@,
@ Pokedex.c:144:             proc->menuIndex++;
	ldr	r3, [r7, #12]	@ tmp187, proc
	movs	r2, #48	@ tmp188,
	ldrb	r3, [r3, r2]	@ _21,
@ Pokedex.c:144:             proc->menuIndex++;
	adds	r3, r3, #1	@ tmp189,
	lsls	r3, r3, #24	@ tmp190, tmp189,
	lsrs	r1, r3, #24	@ _23, tmp190,
	ldr	r3, [r7, #12]	@ tmp191, proc
	movs	r2, #48	@ tmp192,
	strb	r1, [r3, r2]	@ tmp193, proc_39->menuIndex
@ Pokedex.c:145: 			while (!PokedexTable[proc->menuIndex].IndexNumber)
	b	.L7		@
.L9:
@ Pokedex.c:147: 				if (proc->menuIndex < 0xFF) 
	ldr	r3, [r7, #12]	@ tmp194, proc
	movs	r2, #48	@ tmp195,
	ldrb	r3, [r3, r2]	@ _24,
@ Pokedex.c:147: 				if (proc->menuIndex < 0xFF) 
	cmp	r3, #255	@ _24,
	beq	.L8		@,
@ Pokedex.c:149: 					proc->menuIndex++;
	ldr	r3, [r7, #12]	@ tmp196, proc
	movs	r2, #48	@ tmp197,
	ldrb	r3, [r3, r2]	@ _25,
@ Pokedex.c:149: 					proc->menuIndex++;
	adds	r3, r3, #1	@ tmp198,
	lsls	r3, r3, #24	@ tmp199, tmp198,
	lsrs	r1, r3, #24	@ _27, tmp199,
	ldr	r3, [r7, #12]	@ tmp200, proc
	movs	r2, #48	@ tmp201,
	strb	r1, [r3, r2]	@ tmp202, proc_39->menuIndex
	b	.L7		@
.L8:
@ Pokedex.c:151: 				else { proc->menuIndex = 1; }
	ldr	r3, [r7, #12]	@ tmp203, proc
	movs	r2, #48	@ tmp204,
	movs	r1, #1	@ tmp205,
	strb	r1, [r3, r2]	@ tmp206, proc_39->menuIndex
.L7:
@ Pokedex.c:145: 			while (!PokedexTable[proc->menuIndex].IndexNumber)
	ldr	r3, [r7, #12]	@ tmp207, proc
	movs	r2, #48	@ tmp208,
	ldrb	r3, [r3, r2]	@ _28,
	movs	r2, r3	@ _29, _28
@ Pokedex.c:145: 			while (!PokedexTable[proc->menuIndex].IndexNumber)
	ldr	r3, .L11+4	@ tmp209,
	lsls	r2, r2, #2	@ tmp210, _29,
	ldrb	r3, [r2, r3]	@ _30, PokedexTable
@ Pokedex.c:145: 			while (!PokedexTable[proc->menuIndex].IndexNumber)
	cmp	r3, #0	@ _30,
	beq	.L9		@,
@ Pokedex.c:153:             PokedexDraw(menu, command);
	ldr	r2, [r7]	@ tmp211, command
	ldr	r3, [r7, #4]	@ tmp212, menu
	movs	r1, r2	@, tmp211
	movs	r0, r3	@, tmp212
	bl	PokedexDraw		@
@ Pokedex.c:154:             PlaySfx(0x6B);
	ldr	r3, .L11+8	@ tmp213,
	movs	r2, #65	@ tmp214,
	ldrb	r3, [r3, r2]	@ _31, gChapterData
	movs	r2, #2	@ tmp216,
	ands	r3, r2	@ tmp215, tmp216
	lsls	r3, r3, #24	@ tmp217, tmp215,
	lsrs	r3, r3, #24	@ _32, tmp217,
	bne	.L6		@,
@ Pokedex.c:154:             PlaySfx(0x6B);
	movs	r0, #107	@,
	ldr	r3, .L11+12	@ tmp218,
	bl	.L13		@
.L6:
@ Pokedex.c:158:     return ME_NONE;
	movs	r3, #0	@ _51,
@ Pokedex.c:159: }
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
@ Pokedex.c:164: 	Text_Clear(&handle);
	movs	r4, r5	@ tmp132, tmp131
	adds	r3, r7, r4	@ tmp115,, tmp132
	movs	r0, r3	@, tmp115
	ldr	r3, .L15	@ tmp116,
	bl	.L13		@
@ Pokedex.c:165: 	Text_SetColorId(&handle,TEXT_COLOR_GOLD);
	adds	r3, r7, r4	@ tmp117,, tmp133
	movs	r1, #3	@,
	movs	r0, r3	@, tmp117
	ldr	r3, .L15+4	@ tmp118,
	bl	.L13		@
@ Pokedex.c:166: 	Text_DrawString(&handle,string);
	ldr	r2, [r7, #4]	@ tmp119, string
	adds	r3, r7, r4	@ tmp120,, tmp134
	movs	r1, r2	@, tmp119
	movs	r0, r3	@, tmp120
	ldr	r3, .L15+8	@ tmp121,
	bl	.L13		@
@ Pokedex.c:167: 	Text_Display(&handle,&gBG0MapBuffer[y][x]);
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
@ Pokedex.c:168: }
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
	@ args = 0, pretend = 0, frame = 136
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}	@
	mov	lr, r8	@,
	push	{lr}	@
	sub	sp, sp, #144	@,,
	add	r7, sp, #8	@,,
	str	r0, [r7, #28]	@ menu, menu
	str	r1, [r7, #24]	@ command, command
@ Pokedex.c:170: static int PokedexDrawIdle(MenuProc* menu, MenuCommandProc* command) {
	mov	r3, sp	@ tmp197,
	mov	r8, r3	@ saved_stack.11_97, tmp197
@ Pokedex.c:171:     struct PokedexProc* const proc = (void*) menu->parent;
	ldr	r3, [r7, #28]	@ tmp198, menu
	ldr	r3, [r3, #20]	@ tmp199, menu_98(D)->parent
	str	r3, [r7, #104]	@ tmp199, proc
@ Pokedex.c:172:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldr	r3, [r7, #24]	@ tmp200, command
	ldrh	r3, [r3, #44]	@ _1,
	lsls	r3, r3, #5	@ _3, _2,
	ldr	r2, [r7, #24]	@ tmp201, command
	ldrh	r2, [r2, #42]	@ _4,
	adds	r3, r3, r2	@ _6, _3, _5
@ Pokedex.c:172:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r2, r3, #1	@ _8, _7,
@ Pokedex.c:172:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldr	r3, .L36	@ tmp203,
	adds	r3, r2, r3	@ tmp202, _8, tmp203
	str	r3, [r7, #100]	@ tmp202, out
@ Pokedex.c:174: 	int* areaBitfield_A = &proc->areaBitfield_A;
	ldr	r3, [r7, #104]	@ tmp205, proc
	adds	r3, r3, #52	@ tmp204,
	str	r3, [r7, #96]	@ tmp204, areaBitfield_A
@ Pokedex.c:175: 	int* areaBitfield_B = &proc->areaBitfield_B;
	ldr	r3, [r7, #104]	@ tmp207, proc
	adds	r3, r3, #56	@ tmp206,
	str	r3, [r7, #92]	@ tmp206, areaBitfield_B
@ Pokedex.c:176: 	*areaBitfield_A = 0;
	ldr	r3, [r7, #96]	@ tmp208, areaBitfield_A
	movs	r2, #0	@ tmp209,
	str	r2, [r3]	@ tmp209, *areaBitfield_A_102
@ Pokedex.c:177: 	*areaBitfield_B = 0;
	ldr	r3, [r7, #92]	@ tmp210, areaBitfield_B
	movs	r2, #0	@ tmp211,
	str	r2, [r3]	@ tmp211, *areaBitfield_B_103
@ Pokedex.c:178: 	proc->areaBitfield_A = 0;
	ldr	r3, [r7, #104]	@ tmp212, proc
	movs	r2, #0	@ tmp213,
	str	r2, [r3, #52]	@ tmp213, proc_99->areaBitfield_A
@ Pokedex.c:179: 	proc->areaBitfield_B = 0;
	ldr	r3, [r7, #104]	@ tmp214, proc
	movs	r2, #0	@ tmp215,
	str	r2, [r3, #56]	@ tmp215, proc_99->areaBitfield_B
@ Pokedex.c:181: 	bool caught = CheckIfCaught(proc->menuIndex);
	ldr	r3, [r7, #104]	@ tmp216, proc
	movs	r2, #48	@ tmp217,
	ldrb	r3, [r3, r2]	@ _9,
	movs	r0, r3	@, _9
	ldr	r3, .L36+4	@ tmp218,
	bl	.L13		@
	movs	r2, r0	@ _10,
@ Pokedex.c:181: 	bool caught = CheckIfCaught(proc->menuIndex);
	movs	r3, #67	@ tmp519,
	movs	r4, #24	@ tmp646,
	adds	r3, r3, r4	@ tmp645, tmp519, tmp646
	adds	r3, r3, r7	@ tmp219, tmp645,
	subs	r1, r2, #1	@ tmp221, _10
	sbcs	r2, r2, r1	@ tmp220, _10, tmp221
	strb	r2, [r3]	@ tmp222, caught
@ Pokedex.c:182: 	bool seen = CheckIfSeen(proc->menuIndex);
	ldr	r3, [r7, #104]	@ tmp223, proc
	movs	r2, #48	@ tmp224,
	ldrb	r3, [r3, r2]	@ _11,
	movs	r0, r3	@, _11
	ldr	r3, .L36+8	@ tmp225,
	bl	.L13		@
	movs	r2, r0	@ _12,
@ Pokedex.c:182: 	bool seen = CheckIfSeen(proc->menuIndex);
	movs	r3, #66	@ tmp520,
	adds	r3, r3, r4	@ tmp643, tmp520, tmp644
	adds	r3, r3, r7	@ tmp226, tmp643,
	subs	r1, r2, #1	@ tmp228, _12
	sbcs	r2, r2, r1	@ tmp227, _12, tmp228
	strb	r2, [r3]	@ tmp229, seen
@ Pokedex.c:184: 	const struct ClassData* ClassData = GetClassData(proc->menuIndex);
	ldr	r3, [r7, #104]	@ tmp230, proc
	movs	r2, #48	@ tmp231,
	ldrb	r3, [r3, r2]	@ _13,
	movs	r0, r3	@, _13
	ldr	r3, .L36+12	@ tmp232,
	bl	.L13		@
	movs	r3, r0	@ tmp233,
	str	r3, [r7, #84]	@ tmp233, ClassData
@ Pokedex.c:185: 	u16 title = 0;
	movs	r4, #94	@ tmp521,
	movs	r0, #24	@ tmp642,
	adds	r3, r4, r0	@ tmp641, tmp521, tmp642
	adds	r3, r3, r7	@ tmp234, tmp641,
	movs	r2, #0	@ tmp235,
	strh	r2, [r3]	@ tmp236, title
@ Pokedex.c:186:     Text_Clear(&command->text);
	ldr	r3, [r7, #24]	@ tmp237, command
	adds	r3, r3, #52	@ _14,
	movs	r0, r3	@, _14
	ldr	r3, .L36+16	@ tmp238,
	bl	.L13		@
@ Pokedex.c:187: 	Text_ResetTileAllocation(); // 0x08003D20
	ldr	r3, .L36+20	@ tmp239,
	bl	.L13		@
@ Pokedex.c:190: 	Pokedex_RetrieveAreasFound(proc->menuIndex, areaBitfield_A, areaBitfield_B);
	ldr	r3, [r7, #104]	@ tmp240, proc
	movs	r2, #48	@ tmp241,
	ldrb	r3, [r3, r2]	@ _15,
	ldr	r2, [r7, #92]	@ tmp242, areaBitfield_B
	ldr	r1, [r7, #96]	@ tmp243, areaBitfield_A
	movs	r0, r3	@, _15
	bl	Pokedex_RetrieveAreasFound		@
@ Pokedex.c:194: 	if (proc->menuIndex)
	ldr	r3, [r7, #104]	@ tmp244, proc
	movs	r2, #48	@ tmp245,
	ldrb	r3, [r3, r2]	@ _16,
@ Pokedex.c:194: 	if (proc->menuIndex)
	cmp	r3, #0	@ _16,
	beq	.L18		@,
@ Pokedex.c:196: 		if (seen)
	movs	r3, #66	@ tmp522,
	movs	r0, #24	@ tmp640,
	adds	r3, r3, r0	@ tmp639, tmp522, tmp640
	adds	r3, r3, r7	@ tmp246, tmp639,
	ldrb	r3, [r3]	@ tmp247, seen
	cmp	r3, #0	@ tmp247,
	beq	.L18		@,
@ Pokedex.c:198: 			title = ClassData->nameTextId;
	movs	r1, r4	@ tmp523, tmp521
	adds	r3, r1, r0	@ tmp637, tmp523, tmp638
	adds	r3, r3, r7	@ tmp248, tmp637,
	ldr	r2, [r7, #84]	@ tmp249, ClassData
	ldrh	r2, [r2]	@ tmp250, *ClassData_113
	strh	r2, [r3]	@ tmp250, title
@ Pokedex.c:199: 			Text_DrawString(&command->text, GetStringFromIndex(title));
	ldr	r3, [r7, #24]	@ tmp251, command
	adds	r3, r3, #52	@ tmp251,
	movs	r4, r3	@ _17, tmp251
@ Pokedex.c:199: 			Text_DrawString(&command->text, GetStringFromIndex(title));
	adds	r3, r1, r0	@ tmp635, tmp525, tmp636
	adds	r3, r3, r7	@ tmp252, tmp635,
	ldrh	r3, [r3]	@ _18, title
	movs	r0, r3	@, _18
	ldr	r3, .L36+24	@ tmp253,
	bl	.L13		@
	movs	r3, r0	@ _19,
@ Pokedex.c:199: 			Text_DrawString(&command->text, GetStringFromIndex(title));
	movs	r1, r3	@, _19
	movs	r0, r4	@, _17
	ldr	r3, .L36+28	@ tmp254,
	bl	.L13		@
@ Pokedex.c:200: 			Text_Display(&command->text, out); // Class name 
	ldr	r3, [r7, #24]	@ tmp255, command
	adds	r3, r3, #52	@ _20,
	ldr	r2, [r7, #100]	@ tmp256, out
	movs	r1, r2	@, tmp256
	movs	r0, r3	@, _20
	ldr	r3, .L36+32	@ tmp257,
	bl	.L13		@
.L18:
@ Pokedex.c:206:     Text_SetColorId(&command->text, TEXT_COLOR_NORMAL);
	ldr	r3, [r7, #24]	@ tmp258, command
	adds	r3, r3, #52	@ _21,
	movs	r1, #0	@,
	movs	r0, r3	@, _21
	ldr	r3, .L36+36	@ tmp259,
	bl	.L13		@
@ Pokedex.c:207:     if (!title) {
	movs	r3, #94	@ tmp526,
	movs	r2, #24	@ tmp634,
	adds	r3, r3, r2	@ tmp633, tmp526, tmp634
	adds	r3, r3, r7	@ tmp260, tmp633,
	ldrh	r3, [r3]	@ tmp261, title
	cmp	r3, #0	@ tmp261,
	bne	.L19		@,
@ Pokedex.c:208: 		Text_SetXCursor(&command->text, 0xC);
	ldr	r3, [r7, #24]	@ tmp262, command
	adds	r3, r3, #52	@ _22,
	movs	r1, #12	@,
	movs	r0, r3	@, _22
	ldr	r3, .L36+40	@ tmp263,
	bl	.L13		@
@ Pokedex.c:209: 		Text_DrawString(&command->text, "???");
	ldr	r3, [r7, #24]	@ tmp264, command
	adds	r3, r3, #52	@ _23,
	ldr	r2, .L36+44	@ tmp265,
	movs	r1, r2	@, tmp265
	movs	r0, r3	@, _23
	ldr	r3, .L36+28	@ tmp266,
	bl	.L13		@
@ Pokedex.c:211: 		Text_Display(&command->text, out); // Class name 
	ldr	r3, [r7, #24]	@ tmp267, command
	adds	r3, r3, #52	@ _24,
	ldr	r2, [r7, #100]	@ tmp268, out
	movs	r1, r2	@, tmp268
	movs	r0, r3	@, _24
	ldr	r3, .L36+32	@ tmp269,
	bl	.L13		@
.L19:
@ Pokedex.c:218: 	int tile = 40;
	movs	r3, #40	@ tmp270,
	str	r3, [r7, #120]	@ tmp270, tile
@ Pokedex.c:220: 	TextHandle caughtNameHandle = {
	movs	r4, #20	@ tmp527,
	movs	r1, #24	@ tmp632,
	adds	r3, r4, r1	@ tmp631, tmp527, tmp632
	adds	r3, r3, r7	@ tmp271, tmp631,
	movs	r0, r3	@ tmp272, tmp271
	movs	r3, #8	@ tmp273,
	movs	r2, r3	@, tmp273
	movs	r1, #0	@,
	ldr	r3, .L36+48	@ tmp274,
	bl	.L13		@
@ Pokedex.c:221: 		.tileIndexOffset = gpCurrentFont->tileNext+tile,
	ldr	r3, .L36+52	@ tmp277,
	ldr	r3, [r3]	@ gpCurrentFont.0_25, gpCurrentFont
	ldrh	r2, [r3, #18]	@ _26,
@ Pokedex.c:221: 		.tileIndexOffset = gpCurrentFont->tileNext+tile,
	ldr	r3, [r7, #120]	@ tmp279, tile
	lsls	r3, r3, #16	@ tmp280, tmp278,
	lsrs	r3, r3, #16	@ _27, tmp280,
	adds	r3, r2, r3	@ tmp281, _26, _27
	lsls	r3, r3, #16	@ tmp282, tmp281,
	lsrs	r2, r3, #16	@ _28, tmp282,
@ Pokedex.c:220: 	TextHandle caughtNameHandle = {
	movs	r1, #24	@ tmp630,
	adds	r3, r4, r1	@ tmp629, tmp528, tmp630
	adds	r3, r3, r7	@ tmp283, tmp629,
	strh	r2, [r3]	@ tmp284, caughtNameHandle.tileIndexOffset
	adds	r3, r4, r1	@ tmp627, tmp529, tmp628
	adds	r3, r3, r7	@ tmp285, tmp627,
	movs	r2, #4	@ tmp286,
	strb	r2, [r3, #4]	@ tmp287, caughtNameHandle.tileWidth
@ Pokedex.c:224: 	tile += 4;
	ldr	r3, [r7, #120]	@ tmp289, tile
	adds	r3, r3, #4	@ tmp288,
	str	r3, [r7, #120]	@ tmp288, tile
@ Pokedex.c:225: 	DrawRawText(caughtNameHandle," Seen",1,16);
	ldr	r2, .L36+56	@ tmp290,
	adds	r3, r4, r1	@ tmp625, tmp530, tmp626
	adds	r1, r3, r7	@ tmp291, tmp625,
	movs	r3, #16	@ tmp292,
	str	r3, [sp]	@ tmp292,
	movs	r3, #1	@,
	ldr	r0, [r1]	@, caughtNameHandle
	ldr	r1, [r1, #4]	@, caughtNameHandle
	bl	DrawRawText		@
@ Pokedex.c:227: 	TextHandle seenNameHandle = {
	movs	r4, #12	@ tmp531,
	movs	r1, #24	@ tmp624,
	adds	r3, r4, r1	@ tmp623, tmp531, tmp624
	adds	r3, r3, r7	@ tmp293, tmp623,
	movs	r0, r3	@ tmp294, tmp293
	movs	r3, #8	@ tmp295,
	movs	r2, r3	@, tmp295
	movs	r1, #0	@,
	ldr	r3, .L36+48	@ tmp296,
	bl	.L13		@
@ Pokedex.c:228: 		.tileIndexOffset = gpCurrentFont->tileNext+tile,
	ldr	r3, .L36+52	@ tmp299,
	ldr	r3, [r3]	@ gpCurrentFont.1_29, gpCurrentFont
	ldrh	r2, [r3, #18]	@ _30,
@ Pokedex.c:228: 		.tileIndexOffset = gpCurrentFont->tileNext+tile,
	ldr	r3, [r7, #120]	@ tmp301, tile
	lsls	r3, r3, #16	@ tmp302, tmp300,
	lsrs	r3, r3, #16	@ _31, tmp302,
	adds	r3, r2, r3	@ tmp303, _30, _31
	lsls	r3, r3, #16	@ tmp304, tmp303,
	lsrs	r2, r3, #16	@ _32, tmp304,
@ Pokedex.c:227: 	TextHandle seenNameHandle = {
	movs	r1, #24	@ tmp622,
	adds	r3, r4, r1	@ tmp621, tmp532, tmp622
	adds	r3, r3, r7	@ tmp305, tmp621,
	strh	r2, [r3]	@ tmp306, seenNameHandle.tileIndexOffset
	adds	r3, r4, r1	@ tmp619, tmp533, tmp620
	adds	r3, r3, r7	@ tmp307, tmp619,
	movs	r2, #5	@ tmp308,
	strb	r2, [r3, #4]	@ tmp309, seenNameHandle.tileWidth
@ Pokedex.c:231: 	tile += 5;
	ldr	r3, [r7, #120]	@ tmp311, tile
	adds	r3, r3, #5	@ tmp310,
	str	r3, [r7, #120]	@ tmp310, tile
@ Pokedex.c:232: 	DrawRawText(seenNameHandle," Caught",1,18);
	ldr	r2, .L36+60	@ tmp312,
	adds	r3, r4, r1	@ tmp617, tmp534, tmp618
	adds	r1, r3, r7	@ tmp313, tmp617,
	movs	r3, #18	@ tmp314,
	str	r3, [sp]	@ tmp314,
	movs	r3, #1	@,
	ldr	r0, [r1]	@, seenNameHandle
	ldr	r1, [r1, #4]	@, seenNameHandle
	bl	DrawRawText		@
@ Pokedex.c:234: 	DrawUiNumber(&gBG0MapBuffer[16][9],TEXT_COLOR_GOLD,  proc->TotalSeen); 
	ldr	r3, [r7, #104]	@ tmp315, proc
	movs	r2, #49	@ tmp316,
	ldrb	r3, [r3, r2]	@ _33,
@ Pokedex.c:234: 	DrawUiNumber(&gBG0MapBuffer[16][9],TEXT_COLOR_GOLD,  proc->TotalSeen); 
	movs	r2, r3	@ _34, _33
	ldr	r3, .L36+64	@ tmp317,
	movs	r1, #3	@,
	movs	r0, r3	@, tmp317
	ldr	r3, .L36+68	@ tmp318,
	bl	.L13		@
@ Pokedex.c:235: 	DrawUiNumber(&gBG0MapBuffer[18][9],TEXT_COLOR_GOLD,  proc->TotalCaught);
	ldr	r3, [r7, #104]	@ tmp319, proc
	movs	r2, #50	@ tmp320,
	ldrb	r3, [r3, r2]	@ _35,
@ Pokedex.c:235: 	DrawUiNumber(&gBG0MapBuffer[18][9],TEXT_COLOR_GOLD,  proc->TotalCaught);
	movs	r2, r3	@ _36, _35
	ldr	r3, .L36+72	@ tmp321,
	movs	r1, #3	@,
	movs	r0, r3	@, tmp321
	ldr	r3, .L36+68	@ tmp322,
	bl	.L13		@
@ Pokedex.c:236: 	BgMap_ApplyTsa(&gBG1MapBuffer[16][1], &PokedexSeenCaughtBox, 0);
	ldr	r1, .L36+76	@ tmp323,
	ldr	r3, .L36+80	@ tmp324,
	movs	r2, #0	@,
	movs	r0, r3	@, tmp324
	ldr	r3, .L36+84	@ tmp325,
	bl	.L13		@
@ Pokedex.c:239: 	EndFaceById(0);
	movs	r0, #0	@,
	ldr	r3, .L36+88	@ tmp326,
	bl	.L13		@
@ Pokedex.c:240: 	struct FaceProc* FaceProc = StartFace(0, ClassData->defaultPortraitId, 200, 4, 1);
	ldr	r3, [r7, #84]	@ tmp327, ClassData
	ldrh	r3, [r3, #8]	@ _37,
@ Pokedex.c:240: 	struct FaceProc* FaceProc = StartFace(0, ClassData->defaultPortraitId, 200, 4, 1);
	movs	r1, r3	@ _38, _37
	movs	r3, #1	@ tmp328,
	str	r3, [sp]	@ tmp328,
	movs	r3, #4	@,
	movs	r2, #200	@,
	movs	r0, #0	@,
	ldr	r4, .L36+92	@ tmp329,
	bl	.L40		@
	movs	r3, r0	@ tmp330,
	str	r3, [r7, #80]	@ tmp330, FaceProc
@ Pokedex.c:241: 	FaceProc->tileData &= ~(3 << 10); // Clear bits 10 and 11 (priority) such that they are 0 (highest priority) and appear above the background 
	ldr	r3, [r7, #80]	@ tmp331, FaceProc
	ldrh	r3, [r3, #60]	@ _39,
	ldr	r2, .L36+96	@ tmp333,
	ands	r3, r2	@ tmp332, tmp333
	lsls	r3, r3, #16	@ tmp334, tmp332,
	lsrs	r2, r3, #16	@ _40, tmp334,
	ldr	r3, [r7, #80]	@ tmp335, FaceProc
	strh	r2, [r3, #60]	@ tmp336, FaceProc_142->tileData
@ Pokedex.c:243: 	BgMap_ApplyTsa(&gBG1MapBuffer[0][20], &PokedexPortraitBox, 0);
	ldr	r1, .L36+100	@ tmp337,
	ldr	r3, .L36+104	@ tmp338,
	movs	r2, #0	@,
	movs	r0, r3	@, tmp338
	ldr	r3, .L36+84	@ tmp339,
	bl	.L13		@
@ Pokedex.c:245: 	if (!seen)
	movs	r3, #66	@ tmp535,
	movs	r1, #24	@ tmp616,
	adds	r3, r3, r1	@ tmp615, tmp535, tmp616
	adds	r3, r3, r7	@ tmp340, tmp615,
	ldrb	r3, [r3]	@ tmp341, seen
	movs	r2, #1	@ tmp343,
	eors	r3, r2	@ tmp342, tmp343
	lsls	r3, r3, #24	@ tmp344, tmp342,
	lsrs	r3, r3, #24	@ _41, tmp344,
@ Pokedex.c:245: 	if (!seen)
	beq	.L20		@,
@ Pokedex.c:248: 		int paletteID = 22*32;
	movs	r3, #176	@ tmp517,
	lsls	r3, r3, #2	@ tmp345, tmp517,
	str	r3, [r7, #76]	@ tmp345, paletteID
@ Pokedex.c:249: 		int paletteSize = 32; 
	movs	r3, #32	@ tmp346,
	str	r3, [r7, #72]	@ tmp346, paletteSize
@ Pokedex.c:250: 		CopyToPaletteBuffer(MyPalette, paletteID, paletteSize); // source pointer, palette offset, size 
	ldr	r1, [r7, #76]	@ paletteID.2_42, paletteID
	ldr	r2, [r7, #72]	@ paletteSize.3_43, paletteSize
	ldr	r3, .L36+108	@ tmp347,
	movs	r0, r3	@, tmp347
	ldr	r3, .L36+112	@ tmp348,
	bl	.L13		@
@ Pokedex.c:251: 		gPaletteSyncFlag = 1;
	ldr	r3, .L36+116	@ tmp349,
	movs	r2, #1	@ tmp350,
	strb	r2, [r3]	@ tmp351, gPaletteSyncFlag
.L20:
@ Pokedex.c:254: 	LoadIconPalettes(4);
	movs	r0, #4	@,
	ldr	r3, .L36+120	@ tmp352,
	bl	.L13		@
@ Pokedex.c:255: 	ClearIcons();
	ldr	r3, .L36+124	@ tmp353,
	bl	.L13		@
@ Pokedex.c:256: 	EnableBgSyncByMask(BG0_SYNC_BIT);
	movs	r0, #1	@,
	ldr	r3, .L36+128	@ tmp354,
	bl	.L13		@
@ Pokedex.c:258: 	for (int x = 0; x < 20; x++) { // clear out most of bg0 
	movs	r3, #0	@ tmp355,
	str	r3, [r7, #124]	@ tmp355, x
@ Pokedex.c:258: 	for (int x = 0; x < 20; x++) { // clear out most of bg0 
	b	.L21		@
.L24:
@ Pokedex.c:259: 		for (int y = 0; y < 15; y++) { 
	movs	r3, #0	@ tmp356,
	movs	r2, #128	@ tmp614,
	adds	r2, r7, r2	@ tmp613,, tmp614
	str	r3, [r2]	@ tmp356, y
@ Pokedex.c:259: 		for (int y = 0; y < 15; y++) { 
	b	.L22		@
.L23:
@ Pokedex.c:260: 			gBG0MapBuffer[y][x] = 0;
	ldr	r3, .L36+132	@ tmp357,
	movs	r0, #128	@ tmp611,
	adds	r2, r7, r0	@ tmp610,, tmp611
	ldr	r2, [r2]	@ tmp358, y
	lsls	r1, r2, #5	@ tmp359, tmp358,
	ldr	r2, [r7, #124]	@ tmp361, x
	adds	r2, r1, r2	@ tmp360, tmp359, tmp361
	lsls	r2, r2, #1	@ tmp362, tmp360,
	movs	r1, #0	@ tmp363,
	strh	r1, [r2, r3]	@ tmp364, gBG0MapBuffer[y_65][x_67]
@ Pokedex.c:259: 		for (int y = 0; y < 15; y++) { 
	adds	r3, r7, r0	@ tmp607,, tmp608
	ldr	r3, [r3]	@ tmp366, y
	adds	r3, r3, #1	@ tmp365,
	adds	r2, r7, r0	@ tmp604,, tmp605
	str	r3, [r2]	@ tmp365, y
.L22:
@ Pokedex.c:259: 		for (int y = 0; y < 15; y++) { 
	movs	r3, #128	@ tmp602,
	adds	r3, r7, r3	@ tmp601,, tmp602
	ldr	r3, [r3]	@ tmp367, y
	cmp	r3, #14	@ tmp367,
	ble	.L23		@,
@ Pokedex.c:258: 	for (int x = 0; x < 20; x++) { // clear out most of bg0 
	ldr	r3, [r7, #124]	@ tmp369, x
	adds	r3, r3, #1	@ tmp368,
	str	r3, [r7, #124]	@ tmp368, x
.L21:
@ Pokedex.c:258: 	for (int x = 0; x < 20; x++) { // clear out most of bg0 
	ldr	r3, [r7, #124]	@ tmp370, x
	cmp	r3, #19	@ tmp370,
	ble	.L24		@,
@ Pokedex.c:264: 	if (caught)
	movs	r3, #67	@ tmp536,
	movs	r2, #24	@ tmp599,
	adds	r3, r3, r2	@ tmp598, tmp536, tmp599
	adds	r3, r3, r7	@ tmp371, tmp598,
	ldrb	r3, [r3]	@ tmp372, caught
	cmp	r3, #0	@ tmp372,
	beq	.L25		@,
@ Pokedex.c:266: 		DrawIcon(
	ldr	r3, [r7, #100]	@ tmp373, out
	adds	r3, r3, #12	@ _44,
	movs	r2, #128	@ tmp516,
	lsls	r2, r2, #7	@ tmp374, tmp516,
	movs	r1, #171	@,
	movs	r0, r3	@, _44
	ldr	r3, .L36+136	@ tmp375,
	bl	.L13		@
	b	.L26		@
.L25:
@ Pokedex.c:272: 		DrawIcon(
	ldr	r3, [r7, #100]	@ tmp376, out
	adds	r3, r3, #12	@ _45,
	movs	r2, #128	@ tmp515,
	lsls	r2, r2, #7	@ tmp377, tmp515,
	movs	r1, #170	@,
	movs	r0, r3	@, _45
	ldr	r3, .L36+136	@ tmp378,
	bl	.L13		@
.L26:
@ Pokedex.c:277: 	if (proc->areaBitfield_A)
	ldr	r3, [r7, #104]	@ tmp379, proc
	ldr	r3, [r3, #52]	@ _46, proc_99->areaBitfield_A
@ Pokedex.c:277: 	if (proc->areaBitfield_A)
	cmp	r3, #0	@ _46,
	bne	.LCB709	@
	b	.L27	@long jump	@
.LCB709:
@ Pokedex.c:279: 		for (int i = 0; i<64; i++)
	movs	r3, #0	@ tmp380,
	movs	r2, #132	@ tmp597,
	adds	r2, r7, r2	@ tmp596,, tmp597
	str	r3, [r2]	@ tmp380, i
@ Pokedex.c:279: 		for (int i = 0; i<64; i++)
	b	.L28		@
.L37:
	.align	2
.L36:
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
	.word	MyPalette
	.word	CopyToPaletteBuffer
	.word	gPaletteSyncFlag
	.word	LoadIconPalettes
	.word	ClearIcons
	.word	EnableBgSyncByMask
	.word	gBG0MapBuffer
	.word	DrawIcon
.L30:
@ Pokedex.c:281: 			if (proc->areaBitfield_A & 1<<i)
	ldr	r3, [r7, #104]	@ tmp381, proc
	ldr	r2, [r3, #52]	@ _47, proc_99->areaBitfield_A
@ Pokedex.c:281: 			if (proc->areaBitfield_A & 1<<i)
	movs	r4, #132	@ tmp594,
	adds	r3, r7, r4	@ tmp593,, tmp594
	ldr	r3, [r3]	@ tmp382, i
	asrs	r2, r2, r3	@ _47, _47, tmp382
	movs	r3, r2	@ _48, _47
	movs	r2, #1	@ tmp383,
	ands	r3, r2	@ _49, tmp383
@ Pokedex.c:281: 			if (proc->areaBitfield_A & 1<<i)
	beq	.L29		@,
@ Pokedex.c:283: 				u8 xx = AreaTable[i].xx;
	movs	r0, #47	@ tmp538,
	movs	r1, #24	@ tmp591,
	adds	r3, r0, r1	@ tmp590, tmp538, tmp591
	adds	r3, r3, r7	@ tmp384, tmp590,
	ldr	r2, .L38	@ tmp385,
	adds	r4, r7, r4	@ tmp588,, tmp589
	ldr	r1, [r4]	@ tmp386, i
	lsls	r1, r1, #1	@ tmp387, tmp386,
	ldrb	r2, [r1, r2]	@ tmp388, AreaTable
	strb	r2, [r3]	@ tmp388, xx
@ Pokedex.c:284: 				u8 yy = AreaTable[i].yy;
	movs	r4, #46	@ tmp539,
	movs	r1, #24	@ tmp586,
	adds	r3, r4, r1	@ tmp585, tmp539, tmp586
	adds	r3, r3, r7	@ tmp389, tmp585,
	ldr	r1, .L38	@ tmp390,
	movs	r2, #132	@ tmp584,
	adds	r2, r7, r2	@ tmp583,, tmp584
	ldr	r2, [r2]	@ tmp391, i
	lsls	r2, r2, #1	@ tmp392, tmp391,
	adds	r2, r1, r2	@ tmp393, tmp390, tmp392
	adds	r2, r2, #1	@ tmp394,
	ldrb	r2, [r2]	@ tmp395, AreaTable
	strb	r2, [r3]	@ tmp395, yy
@ Pokedex.c:285: 				DrawIcon(&gBG0MapBuffer[yy][xx],0xC,TILEREF(0, 0x4));
	movs	r1, #24	@ tmp581,
	adds	r3, r4, r1	@ tmp580, tmp540, tmp581
	adds	r3, r3, r7	@ tmp396, tmp580,
	ldrb	r2, [r3]	@ _50, yy
	adds	r3, r0, r1	@ tmp578, tmp541, tmp579
	adds	r3, r3, r7	@ tmp397, tmp578,
	ldrb	r3, [r3]	@ _51, xx
@ Pokedex.c:285: 				DrawIcon(&gBG0MapBuffer[yy][xx],0xC,TILEREF(0, 0x4));
	lsls	r2, r2, #5	@ tmp398, _50,
	adds	r3, r2, r3	@ tmp399, tmp398, _51
	lsls	r2, r3, #1	@ tmp400, tmp399,
	ldr	r3, .L38+4	@ tmp401,
	adds	r3, r2, r3	@ _52, tmp400, tmp401
	movs	r2, #128	@ tmp514,
	lsls	r2, r2, #7	@ tmp402, tmp514,
	movs	r1, #12	@,
	movs	r0, r3	@, _52
	ldr	r3, .L38+8	@ tmp403,
	bl	.L13		@
.L29:
@ Pokedex.c:279: 		for (int i = 0; i<64; i++)
	movs	r2, #132	@ tmp577,
	adds	r3, r7, r2	@ tmp576,, tmp577
	ldr	r3, [r3]	@ tmp405, i
	adds	r3, r3, #1	@ tmp404,
	adds	r2, r7, r2	@ tmp573,, tmp574
	str	r3, [r2]	@ tmp404, i
.L28:
@ Pokedex.c:279: 		for (int i = 0; i<64; i++)
	movs	r3, #132	@ tmp571,
	adds	r3, r7, r3	@ tmp570,, tmp571
	ldr	r3, [r3]	@ tmp406, i
	cmp	r3, #63	@ tmp406,
	ble	.L30		@,
.L27:
@ Pokedex.c:289: 	DrawUiNumber(&gBG0MapBuffer[12][18], TEXT_COLOR_GOLD, PokedexTable[proc->menuIndex].IndexNumber);
	ldr	r3, [r7, #104]	@ tmp407, proc
	movs	r2, #48	@ tmp408,
	ldrb	r3, [r3, r2]	@ _53,
	movs	r2, r3	@ _54, _53
@ Pokedex.c:289: 	DrawUiNumber(&gBG0MapBuffer[12][18], TEXT_COLOR_GOLD, PokedexTable[proc->menuIndex].IndexNumber);
	ldr	r3, .L38+12	@ tmp409,
	lsls	r2, r2, #2	@ tmp410, _54,
	ldrb	r3, [r2, r3]	@ _55, PokedexTable
@ Pokedex.c:289: 	DrawUiNumber(&gBG0MapBuffer[12][18], TEXT_COLOR_GOLD, PokedexTable[proc->menuIndex].IndexNumber);
	movs	r2, r3	@ _56, _55
	ldr	r3, .L38+16	@ tmp411,
	movs	r1, #3	@,
	movs	r0, r3	@, tmp411
	ldr	r3, .L38+20	@ tmp412,
	bl	.L13		@
@ Pokedex.c:291: 	char* string = GetStringFromIndex(PokedexTable[proc->menuIndex].textID);
	ldr	r3, [r7, #104]	@ tmp413, proc
	movs	r2, #48	@ tmp414,
	ldrb	r3, [r3, r2]	@ _57,
@ Pokedex.c:291: 	char* string = GetStringFromIndex(PokedexTable[proc->menuIndex].textID);
	ldr	r2, .L38+12	@ tmp415,
	lsls	r3, r3, #2	@ tmp416, _58,
	adds	r3, r2, r3	@ tmp417, tmp415, tmp416
	adds	r3, r3, #2	@ tmp418,
	ldrh	r3, [r3]	@ _59, PokedexTable
@ Pokedex.c:291: 	char* string = GetStringFromIndex(PokedexTable[proc->menuIndex].textID);
	movs	r0, r3	@, _60
	ldr	r3, .L38+24	@ tmp419,
	bl	.L13		@
	movs	r3, r0	@ tmp420,
	str	r3, [r7, #64]	@ tmp420, string
@ Pokedex.c:292: 	int lines = GetNumLines(string);
	ldr	r3, [r7, #64]	@ tmp421, string
	movs	r0, r3	@, tmp421
	bl	GetNumLines		@
	movs	r3, r0	@ tmp422,
	str	r3, [r7, #60]	@ tmp422, lines
@ Pokedex.c:295: 	TextHandle handles[lines];
	ldr	r3, [r7, #60]	@ lines.4_165, lines
@ Pokedex.c:295: 	TextHandle handles[lines];
	subs	r2, r3, #1	@ _61, lines.4_165,
	str	r2, [r7, #56]	@ _61, D.7555
	movs	r2, r3	@ lines.5_63, lines.4_165
	str	r2, [r7, #8]	@ lines.5_63, %sfp
	movs	r2, #0	@ tmp423,
	str	r2, [r7, #12]	@ tmp423, %sfp
	ldr	r0, [r7, #8]	@ _64, %sfp
	ldr	r1, [r7, #12]	@ _64, %sfp
	movs	r2, r0	@ tmp542, _64
	lsrs	r2, r2, #26	@ tmp424, tmp542,
	movs	r4, r1	@ tmp544, _64
	lsls	r4, r4, #6	@ tmp543, tmp544,
	str	r4, [r7, #20]	@ tmp543, %sfp
	ldr	r4, [r7, #20]	@ tmp545, %sfp
	orrs	r4, r2	@ tmp545, tmp424
	str	r4, [r7, #20]	@ tmp545, %sfp
	movs	r2, r0	@ tmp547, _64
	lsls	r2, r2, #6	@ tmp546, tmp547,
	str	r2, [r7, #16]	@ tmp546, %sfp
	movs	r2, r3	@ lines.7_68, lines.4_165
	str	r2, [r7]	@ lines.7_68, %sfp
	movs	r2, #0	@ tmp425,
	str	r2, [r7, #4]	@ tmp425, %sfp
	ldr	r0, [r7]	@ _69, %sfp
	ldr	r1, [r7, #4]	@ _69, %sfp
	movs	r2, r0	@ tmp548, _69
	lsrs	r2, r2, #26	@ tmp426, tmp548,
	movs	r4, r1	@ tmp549, _69
	lsls	r6, r4, #6	@ _169, tmp549,
	orrs	r6, r2	@ _169, tmp426
	movs	r2, r0	@ tmp550, _69
	lsls	r5, r2, #6	@ _169, tmp550,
	lsls	r3, r3, #3	@ _170, lines.8_71,
	adds	r3, r3, #7	@ tmp427,
	lsrs	r3, r3, #3	@ tmp428, tmp427,
	lsls	r3, r3, #3	@ tmp429, tmp428,
	mov	r2, sp	@ tmp552,
	subs	r3, r2, r3	@ tmp551, tmp552, tmp429
	mov	sp, r3	@, tmp551
	add	r3, sp, #8	@ tmp430,,
	adds	r3, r3, #1	@ tmp431,
	lsrs	r3, r3, #1	@ tmp432, tmp431,
	lsls	r3, r3, #1	@ tmp433, tmp432,
	str	r3, [r7, #52]	@ tmp433, handles.9
@ Pokedex.c:296: 	for ( int i = 0 ; i < lines ; i++ )
	movs	r3, #0	@ tmp434,
	str	r3, [r7, #112]	@ tmp434, i
@ Pokedex.c:296: 	for ( int i = 0 ; i < lines ; i++ )
	b	.L31		@
.L32:
@ Pokedex.c:298: 		handles[i].tileIndexOffset = gpCurrentFont->tileNext+tile;
	ldr	r3, .L38+28	@ tmp435,
	ldr	r3, [r3]	@ gpCurrentFont.10_73, gpCurrentFont
	ldrh	r2, [r3, #18]	@ _74,
@ Pokedex.c:298: 		handles[i].tileIndexOffset = gpCurrentFont->tileNext+tile;
	ldr	r3, [r7, #120]	@ tmp437, tile
	lsls	r3, r3, #16	@ tmp438, tmp436,
	lsrs	r3, r3, #16	@ _75, tmp438,
	adds	r3, r2, r3	@ tmp439, _74, _75
	lsls	r3, r3, #16	@ tmp440, tmp439,
	lsrs	r1, r3, #16	@ _76, tmp440,
@ Pokedex.c:298: 		handles[i].tileIndexOffset = gpCurrentFont->tileNext+tile;
	ldr	r3, [r7, #52]	@ tmp441, handles.9
	ldr	r2, [r7, #112]	@ tmp442, i
	lsls	r2, r2, #3	@ tmp443, tmp442,
	strh	r1, [r2, r3]	@ tmp444, (*handles.9_172)[i_82].tileIndexOffset
@ Pokedex.c:299: 		handles[i].xCursor = 0;
	ldr	r2, [r7, #52]	@ tmp445, handles.9
	ldr	r3, [r7, #112]	@ tmp446, i
	lsls	r3, r3, #3	@ tmp447, tmp446,
	adds	r3, r2, r3	@ tmp448, tmp445, tmp447
	adds	r3, r3, #2	@ tmp449,
	movs	r2, #0	@ tmp450,
	strb	r2, [r3]	@ tmp451, (*handles.9_172)[i_82].xCursor
@ Pokedex.c:300: 		handles[i].colorId = TEXT_COLOR_NORMAL;
	ldr	r2, [r7, #52]	@ tmp452, handles.9
	ldr	r3, [r7, #112]	@ tmp453, i
	lsls	r3, r3, #3	@ tmp454, tmp453,
	adds	r3, r2, r3	@ tmp455, tmp452, tmp454
	adds	r3, r3, #3	@ tmp456,
	movs	r2, #0	@ tmp457,
	strb	r2, [r3]	@ tmp458, (*handles.9_172)[i_82].colorId
@ Pokedex.c:301: 		handles[i].tileWidth = 18;
	ldr	r2, [r7, #52]	@ tmp459, handles.9
	ldr	r3, [r7, #112]	@ tmp460, i
	lsls	r3, r3, #3	@ tmp461, tmp460,
	adds	r3, r2, r3	@ tmp462, tmp459, tmp461
	adds	r3, r3, #4	@ tmp463,
	movs	r2, #18	@ tmp464,
	strb	r2, [r3]	@ tmp465, (*handles.9_172)[i_82].tileWidth
@ Pokedex.c:302: 		handles[i].useDoubleBuffer = 0;
	ldr	r2, [r7, #52]	@ tmp466, handles.9
	ldr	r3, [r7, #112]	@ tmp467, i
	lsls	r3, r3, #3	@ tmp468, tmp467,
	adds	r3, r2, r3	@ tmp469, tmp466, tmp468
	adds	r3, r3, #5	@ tmp470,
	movs	r2, #0	@ tmp471,
	strb	r2, [r3]	@ tmp472, (*handles.9_172)[i_82].useDoubleBuffer
@ Pokedex.c:303: 		handles[i].currentBufferId = 0;
	ldr	r2, [r7, #52]	@ tmp473, handles.9
	ldr	r3, [r7, #112]	@ tmp474, i
	lsls	r3, r3, #3	@ tmp475, tmp474,
	adds	r3, r2, r3	@ tmp476, tmp473, tmp475
	adds	r3, r3, #6	@ tmp477,
	movs	r2, #0	@ tmp478,
	strb	r2, [r3]	@ tmp479, (*handles.9_172)[i_82].currentBufferId
@ Pokedex.c:304: 		handles[i].unk07 = 0;
	ldr	r2, [r7, #52]	@ tmp480, handles.9
	ldr	r3, [r7, #112]	@ tmp481, i
	lsls	r3, r3, #3	@ tmp482, tmp481,
	adds	r3, r2, r3	@ tmp483, tmp480, tmp482
	adds	r3, r3, #7	@ tmp484,
	movs	r2, #0	@ tmp485,
	strb	r2, [r3]	@ tmp486, (*handles.9_172)[i_82].unk07
@ Pokedex.c:305: 		tile += 18;
	ldr	r3, [r7, #120]	@ tmp488, tile
	adds	r3, r3, #18	@ tmp487,
	str	r3, [r7, #120]	@ tmp487, tile
@ Pokedex.c:306: 		Text_Clear(&handles[i]);
	ldr	r3, [r7, #112]	@ tmp490, i
	lsls	r3, r3, #3	@ tmp489, tmp490,
	ldr	r2, [r7, #52]	@ tmp491, handles.9
	adds	r3, r2, r3	@ _77, tmp491, tmp489
@ Pokedex.c:306: 		Text_Clear(&handles[i]);
	movs	r0, r3	@, _77
	ldr	r3, .L38+32	@ tmp492,
	bl	.L13		@
@ Pokedex.c:296: 	for ( int i = 0 ; i < lines ; i++ )
	ldr	r3, [r7, #112]	@ tmp494, i
	adds	r3, r3, #1	@ tmp493,
	str	r3, [r7, #112]	@ tmp493, i
.L31:
@ Pokedex.c:296: 	for ( int i = 0 ; i < lines ; i++ )
	ldr	r2, [r7, #112]	@ tmp495, i
	ldr	r3, [r7, #60]	@ tmp496, lines
	cmp	r2, r3	@ tmp495, tmp496
	blt	.L32		@,
@ Pokedex.c:310: 	DrawMultiline(handles, string, lines);
	ldr	r2, [r7, #60]	@ tmp497, lines
	ldr	r1, [r7, #64]	@ tmp498, string
	ldr	r3, [r7, #52]	@ tmp499, handles.9
	movs	r0, r3	@, tmp499
	bl	DrawMultiline		@
@ Pokedex.c:312: 	for ( int i = 0 ; i < lines ; i++ )
	movs	r3, #0	@ tmp500,
	str	r3, [r7, #108]	@ tmp500, i
@ Pokedex.c:312: 	for ( int i = 0 ; i < lines ; i++ )
	b	.L33		@
.L34:
@ Pokedex.c:314: 		Text_Display(&handles[i],&gBG0MapBuffer[14+2*i][12]);
	ldr	r3, [r7, #108]	@ tmp502, i
	lsls	r3, r3, #3	@ tmp501, tmp502,
	ldr	r2, [r7, #52]	@ tmp503, handles.9
	adds	r0, r2, r3	@ _78, tmp503, tmp501
@ Pokedex.c:314: 		Text_Display(&handles[i],&gBG0MapBuffer[14+2*i][12]);
	ldr	r3, [r7, #108]	@ tmp504, i
	adds	r3, r3, #7	@ _79,
	lsls	r3, r3, #1	@ _80, _79,
@ Pokedex.c:314: 		Text_Display(&handles[i],&gBG0MapBuffer[14+2*i][12]);
	lsls	r3, r3, #6	@ tmp505, _80,
	adds	r3, r3, #24	@ tmp505,
	movs	r2, r3	@ tmp506, tmp505
	ldr	r3, .L38+4	@ tmp507,
	adds	r3, r2, r3	@ _81, tmp506, tmp507
	movs	r1, r3	@, _81
	ldr	r3, .L38+36	@ tmp508,
	bl	.L13		@
@ Pokedex.c:312: 	for ( int i = 0 ; i < lines ; i++ )
	ldr	r3, [r7, #108]	@ tmp510, i
	adds	r3, r3, #1	@ tmp509,
	str	r3, [r7, #108]	@ tmp509, i
.L33:
@ Pokedex.c:312: 	for ( int i = 0 ; i < lines ; i++ )
	ldr	r2, [r7, #108]	@ tmp511, i
	ldr	r3, [r7, #60]	@ tmp512, lines
	cmp	r2, r3	@ tmp511, tmp512
	blt	.L34		@,
@ Pokedex.c:318:     return ME_NONE;
	movs	r3, #0	@ _176,
	mov	sp, r8	@, saved_stack.11_97
@ Pokedex.c:319: }
	movs	r0, r3	@, <retval>
	mov	sp, r7	@,
	add	sp, sp, #136	@,,
	@ sp needed	@
	pop	{r7}
	mov	r8, r7
	pop	{r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L39:
	.align	2
.L38:
	.word	AreaTable
	.word	gBG0MapBuffer
	.word	DrawIcon
	.word	PokedexTable
	.word	gBG0MapBuffer+804
	.word	DrawUiNumber
	.word	GetStringFromIndex
	.word	gpCurrentFont
	.word	Text_Clear
	.word	Text_Display
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
@ Pokedex.c:328:     int j = 0;
	movs	r3, #0	@ tmp124,
	str	r3, [r7, #28]	@ tmp124, j
@ Pokedex.c:329:     for ( int i = 0 ; i < lines ; i++ )
	movs	r3, #0	@ tmp125,
	str	r3, [r7, #24]	@ tmp125, i
@ Pokedex.c:329:     for ( int i = 0 ; i < lines ; i++ )
	b	.L42		@
.L46:
@ Pokedex.c:331:         int k = 0;
	movs	r3, #0	@ tmp126,
	str	r3, [r7, #20]	@ tmp126, k
@ Pokedex.c:332:         for ( ; string[j] && string[j] != NL ; k++ )
	b	.L43		@
.L45:
@ Pokedex.c:334:             gGenericBuffer[k] = string[j];
	ldr	r3, [r7, #28]	@ j.12_1, j
	ldr	r2, [r7, #8]	@ tmp127, string
	adds	r3, r2, r3	@ _2, tmp127, j.12_1
	ldrb	r1, [r3]	@ _3, *_2
@ Pokedex.c:334:             gGenericBuffer[k] = string[j];
	ldr	r2, .L47	@ tmp128,
	ldr	r3, [r7, #20]	@ tmp130, k
	adds	r3, r2, r3	@ tmp129, tmp128, tmp130
	adds	r2, r1, #0	@ tmp131, _3
	strb	r2, [r3]	@ tmp131, gGenericBuffer[k_16]
@ Pokedex.c:335:             j++;
	ldr	r3, [r7, #28]	@ tmp133, j
	adds	r3, r3, #1	@ tmp132,
	str	r3, [r7, #28]	@ tmp132, j
@ Pokedex.c:332:         for ( ; string[j] && string[j] != NL ; k++ )
	ldr	r3, [r7, #20]	@ tmp135, k
	adds	r3, r3, #1	@ tmp134,
	str	r3, [r7, #20]	@ tmp134, k
.L43:
@ Pokedex.c:332:         for ( ; string[j] && string[j] != NL ; k++ )
	ldr	r3, [r7, #28]	@ j.13_4, j
	ldr	r2, [r7, #8]	@ tmp136, string
	adds	r3, r2, r3	@ _5, tmp136, j.13_4
	ldrb	r3, [r3]	@ _6, *_5
@ Pokedex.c:332:         for ( ; string[j] && string[j] != NL ; k++ )
	cmp	r3, #0	@ _6,
	beq	.L44		@,
@ Pokedex.c:332:         for ( ; string[j] && string[j] != NL ; k++ )
	ldr	r3, [r7, #28]	@ j.14_7, j
	ldr	r2, [r7, #8]	@ tmp137, string
	adds	r3, r2, r3	@ _8, tmp137, j.14_7
	ldrb	r3, [r3]	@ _9, *_8
@ Pokedex.c:332:         for ( ; string[j] && string[j] != NL ; k++ )
	cmp	r3, #1	@ _9,
	bne	.L45		@,
.L44:
@ Pokedex.c:337:         gGenericBuffer[k] = 0;
	ldr	r2, .L47	@ tmp138,
	ldr	r3, [r7, #20]	@ tmp140, k
	adds	r3, r2, r3	@ tmp139, tmp138, tmp140
	movs	r2, #0	@ tmp141,
	strb	r2, [r3]	@ tmp142, gGenericBuffer[k_16]
@ Pokedex.c:338:         Text_InsertString(handles,0,handles->colorId,(char*)gGenericBuffer);
	ldr	r3, [r7, #12]	@ tmp143, handles
	ldrb	r3, [r3, #3]	@ _10,
@ Pokedex.c:338:         Text_InsertString(handles,0,handles->colorId,(char*)gGenericBuffer);
	movs	r2, r3	@ _11, _10
	ldr	r3, .L47	@ tmp144,
	ldr	r0, [r7, #12]	@ tmp145, handles
	movs	r1, #0	@,
	ldr	r4, .L47+4	@ tmp146,
	bl	.L40		@
@ Pokedex.c:340:         handles++;
	ldr	r3, [r7, #12]	@ tmp148, handles
	adds	r3, r3, #8	@ tmp147,
	str	r3, [r7, #12]	@ tmp147, handles
@ Pokedex.c:341:         j++;
	ldr	r3, [r7, #28]	@ tmp150, j
	adds	r3, r3, #1	@ tmp149,
	str	r3, [r7, #28]	@ tmp149, j
@ Pokedex.c:329:     for ( int i = 0 ; i < lines ; i++ )
	ldr	r3, [r7, #24]	@ tmp152, i
	adds	r3, r3, #1	@ tmp151,
	str	r3, [r7, #24]	@ tmp151, i
.L42:
@ Pokedex.c:329:     for ( int i = 0 ; i < lines ; i++ )
	ldr	r2, [r7, #24]	@ tmp153, i
	ldr	r3, [r7, #4]	@ tmp154, lines
	cmp	r2, r3	@ tmp153, tmp154
	blt	.L46		@,
@ Pokedex.c:343: }
	nop	
	nop	
	mov	sp, r7	@,
	add	sp, sp, #36	@,,
	@ sp needed	@
	pop	{r4, r7}
	pop	{r0}
	bx	r0
.L48:
	.align	2
.L47:
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
@ Pokedex.c:352:     struct PokedexProc* proc = (void*) ProcStart(Proc_ChapterPokedex, ROOT_PROC_3);
	ldr	r3, .L56	@ tmp147,
	movs	r1, #3	@,
	movs	r0, r3	@, tmp147
	ldr	r3, .L56+4	@ tmp148,
	bl	.L13		@
	movs	r3, r0	@ tmp149,
	str	r3, [r7, #20]	@ tmp149, proc
@ Pokedex.c:354:     proc->menuIndex = 1;
	ldr	r3, [r7, #20]	@ tmp150, proc
	movs	r2, #48	@ tmp151,
	movs	r1, #1	@ tmp152,
	strb	r1, [r3, r2]	@ tmp153, proc_41->menuIndex
@ Pokedex.c:355: 	proc->TotalCaught = CountCaught();
	ldr	r3, .L56+8	@ tmp154,
	bl	.L13		@
	movs	r3, r0	@ _1,
@ Pokedex.c:355: 	proc->TotalCaught = CountCaught();
	lsls	r3, r3, #24	@ tmp155, _1,
	lsrs	r1, r3, #24	@ _2, tmp155,
	ldr	r3, [r7, #20]	@ tmp156, proc
	movs	r2, #50	@ tmp157,
	strb	r1, [r3, r2]	@ tmp158, proc_41->TotalCaught
@ Pokedex.c:356: 	proc->TotalSeen = CountSeen();
	ldr	r3, .L56+12	@ tmp159,
	bl	.L13		@
	movs	r3, r0	@ _3,
@ Pokedex.c:356: 	proc->TotalSeen = CountSeen();
	lsls	r3, r3, #24	@ tmp160, _3,
	lsrs	r1, r3, #24	@ _4, tmp160,
	ldr	r3, [r7, #20]	@ tmp161, proc
	movs	r2, #49	@ tmp162,
	strb	r1, [r3, r2]	@ tmp163, proc_41->TotalSeen
@ Pokedex.c:358: 	Decompress(WorldMap_img,(void*)0x600C000);
	ldr	r2, .L56+16	@ tmp164,
	ldr	r3, .L56+20	@ tmp165,
	movs	r1, r2	@, tmp164
	movs	r0, r3	@, tmp165
	ldr	r3, .L56+24	@ tmp166,
	bl	.L13		@
@ Pokedex.c:360: 	CopyToPaletteBuffer(WorldMap_pal,0x20*6,(gWorldMapPaletteCount-2)*32);
	ldr	r3, .L56+28	@ tmp167,
	ldrb	r3, [r3]	@ gWorldMapPaletteCount.15_5, gWorldMapPaletteCount
	subs	r3, r3, #2	@ _7,
@ Pokedex.c:360: 	CopyToPaletteBuffer(WorldMap_pal,0x20*6,(gWorldMapPaletteCount-2)*32);
	lsls	r3, r3, #5	@ _8, _7,
@ Pokedex.c:360: 	CopyToPaletteBuffer(WorldMap_pal,0x20*6,(gWorldMapPaletteCount-2)*32);
	movs	r2, r3	@ _9, _8
	ldr	r3, .L56+32	@ tmp168,
	movs	r1, #192	@,
	movs	r0, r3	@, tmp168
	ldr	r3, .L56+36	@ tmp169,
	bl	.L13		@
@ Pokedex.c:361: 	CopyToPaletteBuffer(WorldMap_pal+(gWorldMapPaletteCount-1)*16,0x20*15,32);
	ldr	r3, .L56+28	@ tmp170,
	ldrb	r3, [r3]	@ gWorldMapPaletteCount.16_10, gWorldMapPaletteCount
	subs	r3, r3, #1	@ _12,
@ Pokedex.c:361: 	CopyToPaletteBuffer(WorldMap_pal+(gWorldMapPaletteCount-1)*16,0x20*15,32);
	lsls	r2, r3, #5	@ _14, _13,
@ Pokedex.c:361: 	CopyToPaletteBuffer(WorldMap_pal+(gWorldMapPaletteCount-1)*16,0x20*15,32);
	ldr	r3, .L56+32	@ tmp171,
	adds	r3, r2, r3	@ _15, _14, tmp171
	movs	r2, #240	@ tmp252,
	lsls	r1, r2, #1	@ tmp172, tmp252,
	movs	r2, #32	@,
	movs	r0, r3	@, _15
	ldr	r3, .L56+36	@ tmp173,
	bl	.L13		@
@ Pokedex.c:363: 	memcpy(gGenericBuffer, WorldMap_tsa, 0x4B2);
	ldr	r2, .L56+40	@ tmp174,
	ldr	r1, .L56+44	@ tmp175,
	ldr	r3, .L56+48	@ tmp176,
	movs	r0, r3	@, tmp176
	ldr	r3, .L56+52	@ tmp177,
	bl	.L13		@
@ Pokedex.c:365: 	TSA* tsaBuffer = (TSA*)gGenericBuffer;
	ldr	r3, .L56+48	@ tmp178,
	str	r3, [r7, #16]	@ tmp178, tsaBuffer
@ Pokedex.c:366: 	for ( int i = 0 ; i < tsaBuffer->height+1 ; i++ )
	movs	r3, #0	@ tmp179,
	str	r3, [r7, #28]	@ tmp179, i
@ Pokedex.c:366: 	for ( int i = 0 ; i < tsaBuffer->height+1 ; i++ )
	b	.L50		@
.L54:
@ Pokedex.c:368: 		for ( int j = 0 ; j < tsaBuffer->width+1 ; j++ )
	movs	r3, #0	@ tmp180,
	str	r3, [r7, #24]	@ tmp180, j
@ Pokedex.c:368: 		for ( int j = 0 ; j < tsaBuffer->width+1 ; j++ )
	b	.L51		@
.L53:
@ Pokedex.c:370: 			if ( tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID == 16-6 )
	ldr	r3, [r7, #16]	@ tmp181, tsaBuffer
	ldrb	r3, [r3]	@ _16, *tsaBuffer_51
@ Pokedex.c:370: 			if ( tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID == 16-6 )
	adds	r3, r3, #1	@ _18,
@ Pokedex.c:370: 			if ( tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID == 16-6 )
	ldr	r2, [r7, #28]	@ tmp182, i
	muls	r2, r3	@ _19, _18
@ Pokedex.c:370: 			if ( tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID == 16-6 )
	ldr	r3, [r7, #24]	@ tmp183, j
	adds	r3, r2, r3	@ _20, _19, tmp183
@ Pokedex.c:370: 			if ( tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID == 16-6 )
	ldr	r2, [r7, #16]	@ tmp184, tsaBuffer
	lsls	r3, r3, #1	@ tmp185, _20,
	adds	r3, r2, r3	@ tmp188, tmp184, tmp185
	ldrb	r3, [r3, #3]	@ tmp189,
	lsls	r3, r3, #24	@ tmp191, tmp189,
	lsrs	r3, r3, #28	@ tmp190, tmp191,
	lsls	r3, r3, #24	@ tmp192, tmp190,
	lsrs	r3, r3, #24	@ _21, tmp192,
@ Pokedex.c:370: 			if ( tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID == 16-6 )
	cmp	r3, #10	@ _21,
	bne	.L52		@,
@ Pokedex.c:372: 				tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID--;
	ldr	r3, [r7, #16]	@ tmp193, tsaBuffer
	ldrb	r3, [r3]	@ _22, *tsaBuffer_51
@ Pokedex.c:372: 				tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID--;
	adds	r3, r3, #1	@ _24,
@ Pokedex.c:372: 				tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID--;
	ldr	r2, [r7, #28]	@ tmp194, i
	muls	r2, r3	@ _25, _24
@ Pokedex.c:372: 				tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID--;
	ldr	r3, [r7, #24]	@ tmp195, j
	adds	r3, r2, r3	@ _26, _25, tmp195
@ Pokedex.c:372: 				tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID--;
	ldr	r1, [r7, #16]	@ tmp196, tsaBuffer
	lsls	r2, r3, #1	@ tmp197, _26,
	adds	r2, r1, r2	@ tmp200, tmp196, tmp197
	ldrb	r2, [r2, #3]	@ tmp201,
	lsls	r2, r2, #24	@ tmp203, tmp201,
	lsrs	r2, r2, #28	@ tmp202, tmp203,
	lsls	r2, r2, #24	@ tmp204, tmp202,
	lsrs	r2, r2, #24	@ _27, tmp204,
@ Pokedex.c:372: 				tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID--;
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
.L52:
@ Pokedex.c:368: 		for ( int j = 0 ; j < tsaBuffer->width+1 ; j++ )
	ldr	r3, [r7, #24]	@ tmp223, j
	adds	r3, r3, #1	@ tmp222,
	str	r3, [r7, #24]	@ tmp222, j
.L51:
@ Pokedex.c:368: 		for ( int j = 0 ; j < tsaBuffer->width+1 ; j++ )
	ldr	r3, [r7, #16]	@ tmp224, tsaBuffer
	ldrb	r3, [r3]	@ _30, *tsaBuffer_51
	movs	r2, r3	@ _31, _30
@ Pokedex.c:368: 		for ( int j = 0 ; j < tsaBuffer->width+1 ; j++ )
	ldr	r3, [r7, #24]	@ tmp225, j
	cmp	r3, r2	@ tmp225, _31
	ble	.L53		@,
@ Pokedex.c:366: 	for ( int i = 0 ; i < tsaBuffer->height+1 ; i++ )
	ldr	r3, [r7, #28]	@ tmp227, i
	adds	r3, r3, #1	@ tmp226,
	str	r3, [r7, #28]	@ tmp226, i
.L50:
@ Pokedex.c:366: 	for ( int i = 0 ; i < tsaBuffer->height+1 ; i++ )
	ldr	r3, [r7, #16]	@ tmp228, tsaBuffer
	ldrb	r3, [r3, #1]	@ _32,
	movs	r2, r3	@ _33, _32
@ Pokedex.c:366: 	for ( int i = 0 ; i < tsaBuffer->height+1 ; i++ )
	ldr	r3, [r7, #28]	@ tmp229, i
	cmp	r3, r2	@ tmp229, _33
	ble	.L54		@,
@ Pokedex.c:376: 	BgMap_ApplyTsa(gBg2MapBuffer,gGenericBuffer, 6<<12);
	movs	r3, #192	@ tmp250,
	lsls	r2, r3, #7	@ tmp230, tmp250,
	ldr	r1, .L56+48	@ tmp231,
	ldr	r3, .L56+56	@ tmp232,
	movs	r0, r3	@, tmp232
	ldr	r3, .L56+60	@ tmp233,
	bl	.L13		@
@ Pokedex.c:377: 	SetBgTileDataOffset(2,0xC000);
	movs	r3, #192	@ tmp251,
	lsls	r3, r3, #8	@ tmp234, tmp251,
	movs	r1, r3	@, tmp234
	movs	r0, #2	@,
	ldr	r3, .L56+64	@ tmp235,
	bl	.L13		@
@ Pokedex.c:379: 	struct LCDIOBuffer* LCDIOBuffer = &gLCDIOBuffer;
	ldr	r3, .L56+68	@ tmp236,
	str	r3, [r7, #12]	@ tmp236, LCDIOBuffer
@ Pokedex.c:380: 	LCDIOBuffer->bgOffset[3].x = 0; // make offset as 0, rather than scrolled to the right
	ldr	r3, [r7, #12]	@ tmp237, LCDIOBuffer
	movs	r2, #0	@ tmp238,
	strh	r2, [r3, #40]	@ tmp239, LCDIOBuffer_55->bgOffset[3].x
@ Pokedex.c:381: 	LCDIOBuffer->bgOffset[3].y = 0; 
	ldr	r3, [r7, #12]	@ tmp240, LCDIOBuffer
	movs	r2, #0	@ tmp241,
	strh	r2, [r3, #42]	@ tmp242, LCDIOBuffer_55->bgOffset[3].y
@ Pokedex.c:385: 	LoadIconPalettes(4);
	movs	r0, #4	@,
	ldr	r3, .L56+72	@ tmp243,
	bl	.L13		@
@ Pokedex.c:386: 	EnableBgSyncByMask(BG_SYNC_BIT(2)); // sync bg 3 
	movs	r0, #4	@,
	ldr	r3, .L56+76	@ tmp244,
	bl	.L13		@
@ Pokedex.c:387: 	EnablePaletteSync();
	ldr	r3, .L56+80	@ tmp245,
	bl	.L13		@
@ Pokedex.c:390:     StartMenuChild(&Menu_Pokedex, (void*) proc);
	ldr	r2, [r7, #20]	@ tmp246, proc
	ldr	r3, .L56+84	@ tmp247,
	movs	r1, r2	@, tmp246
	movs	r0, r3	@, tmp247
	ldr	r3, .L56+88	@ tmp248,
	bl	.L13		@
@ Pokedex.c:392:     return ME_DISABLE | ME_END | ME_PLAY_BEEP | ME_CLEAR_GFX;
	movs	r3, #23	@ _62,
@ Pokedex.c:393: }
	movs	r0, r3	@, <retval>
	mov	sp, r7	@,
	add	sp, sp, #32	@,,
	@ sp needed	@
	pop	{r7}
	pop	{r1}
	bx	r1
.L57:
	.align	2
.L56:
	.word	Proc_ChapterPokedex
	.word	ProcStart
	.word	CountCaught
	.word	CountSeen
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
@ Pokedex.c:397:     command->onCycle = (void*) PokedexDrawIdle(menu, command);
	ldr	r2, [r7]	@ tmp115, command
	ldr	r3, [r7, #4]	@ tmp116, menu
	movs	r1, r2	@, tmp115
	movs	r0, r3	@, tmp116
	bl	PokedexDrawIdle		@
	movs	r3, r0	@ _1,
@ Pokedex.c:397:     command->onCycle = (void*) PokedexDrawIdle(menu, command);
	movs	r2, r3	@ _2, _1
@ Pokedex.c:397:     command->onCycle = (void*) PokedexDrawIdle(menu, command);
	ldr	r3, [r7]	@ tmp117, command
	str	r2, [r3, #12]	@ _2, command_5(D)->onCycle
@ Pokedex.c:398: }
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
@ Pokedex.c:402: 	PokedexMenuEnd(menu, command);
	ldr	r2, [r7]	@ tmp115, command
	ldr	r3, [r7, #4]	@ tmp116, menu
	movs	r1, r2	@, tmp115
	movs	r0, r3	@, tmp116
	bl	PokedexMenuEnd		@
@ Pokedex.c:403: 	struct Proc* const proc = (void*) menu->parent; // latter makes more sense, but gives warning as EndProc expects Proc*, not PokedexProc* 
	ldr	r3, [r7, #4]	@ tmp117, menu
	ldr	r3, [r3, #20]	@ tmp118, menu_2(D)->parent
	str	r3, [r7, #12]	@ tmp118, proc
@ Pokedex.c:405: 	EndProc(proc);
	ldr	r3, [r7, #12]	@ tmp119, proc
	movs	r0, r3	@, tmp119
	ldr	r3, .L61	@ tmp120,
	bl	.L13		@
@ Pokedex.c:406: 	UnlockGameLogic();
	ldr	r3, .L61+4	@ tmp121,
	bl	.L13		@
@ Pokedex.c:407: 	UnlockGameGraphicsLogic(); 
	ldr	r3, .L61+8	@ tmp122,
	bl	.L13		@
@ Pokedex.c:408: 	return true;
	movs	r3, #1	@ _9,
@ Pokedex.c:409: }
	movs	r0, r3	@, <retval>
	mov	sp, r7	@,
	add	sp, sp, #16	@,,
	@ sp needed	@
	pop	{r7}
	pop	{r1}
	bx	r1
.L62:
	.align	2
.L61:
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
@ Pokedex.c:412: 	EndFaceById(0);
	movs	r0, #0	@,
	ldr	r3, .L65	@ tmp116,
	bl	.L13		@
@ Pokedex.c:413: 	FillBgMap(gBg0MapBuffer,0);
	ldr	r3, .L65+4	@ tmp117,
	movs	r1, #0	@,
	movs	r0, r3	@, tmp117
	ldr	r3, .L65+8	@ tmp118,
	bl	.L13		@
@ Pokedex.c:414: 	FillBgMap(gBg1MapBuffer,0);
	ldr	r3, .L65+12	@ tmp119,
	movs	r1, #0	@,
	movs	r0, r3	@, tmp119
	ldr	r3, .L65+8	@ tmp120,
	bl	.L13		@
@ Pokedex.c:415: 	FillBgMap(gBg2MapBuffer,0);
	ldr	r3, .L65+16	@ tmp121,
	movs	r1, #0	@,
	movs	r0, r3	@, tmp121
	ldr	r3, .L65+8	@ tmp122,
	bl	.L13		@
@ Pokedex.c:416: 	EnableBgSyncByMask(1|2|4);
	movs	r0, #7	@,
	ldr	r3, .L65+20	@ tmp123,
	bl	.L13		@
@ Pokedex.c:417: 	UnpackChapterMapPalette(gChapterData.chapterIndex); 
	ldr	r3, .L65+24	@ tmp124,
	ldrb	r3, [r3, #14]	@ _1,
@ Pokedex.c:417: 	UnpackChapterMapPalette(gChapterData.chapterIndex); 
	movs	r0, r3	@, _2
	ldr	r3, .L65+28	@ tmp125,
	bl	.L13		@
@ Pokedex.c:418: 	UnpackChapterMapGraphics(gChapterData.chapterIndex); // 1 frame of messed up graphics 
	ldr	r3, .L65+24	@ tmp126,
	ldrb	r3, [r3, #14]	@ _3,
	movs	r0, r3	@, _3
	ldr	r3, .L65+32	@ tmp127,
	bl	.L13		@
@ Pokedex.c:425:     return;
	nop	
@ Pokedex.c:426: }
	mov	sp, r7	@,
	add	sp, sp, #8	@,,
	@ sp needed	@
	pop	{r7}
	pop	{r0}
	bx	r0
.L66:
	.align	2
.L65:
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
@ Pokedex.c:453: 	for (u16 i = 0 ; i <= 0x80 ; i++) 
	movs	r3, #22	@ tmp257,
	adds	r3, r7, r3	@ tmp149,, tmp257
	movs	r2, #0	@ tmp150,
	strh	r2, [r3]	@ tmp151, i
@ Pokedex.c:453: 	for (u16 i = 0 ; i <= 0x80 ; i++) 
	b	.L68		@
.L71:
@ Pokedex.c:455: 		u8 Chapter = MonsterSpawnTable[i].ChID;
	movs	r4, #22	@ tmp258,
	adds	r3, r7, r4	@ tmp152,, tmp258
	ldrh	r2, [r3]	@ _1, i
@ Pokedex.c:455: 		u8 Chapter = MonsterSpawnTable[i].ChID;
	movs	r6, #21	@ tmp259,
	adds	r1, r7, r6	@ tmp153,, tmp259
	ldr	r0, .L73	@ tmp154,
	movs	r3, r2	@ tmp155, _1
	lsls	r3, r3, #1	@ tmp155, tmp155,
	adds	r3, r3, r2	@ tmp155, tmp155, _1
	lsls	r3, r3, #2	@ tmp156, tmp155,
	adds	r3, r0, r3	@ tmp157, tmp154, tmp155
	adds	r3, r3, #10	@ tmp158,
	ldrb	r3, [r3]	@ tmp159, MonsterSpawnTable
	strb	r3, [r1]	@ tmp159, Chapter
@ Pokedex.c:456: 		if (Chapter)
	adds	r3, r7, r6	@ tmp160,, tmp260
	ldrb	r3, [r3]	@ tmp161, Chapter
	cmp	r3, #0	@ tmp161,
	bne	.LCB1572	@
	b	.L69	@long jump	@
.LCB1572:
@ Pokedex.c:459: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	adds	r3, r7, r4	@ tmp162,, tmp261
	ldrh	r2, [r3]	@ _2, i
	ldr	r1, .L73	@ tmp163,
	movs	r3, r2	@ tmp164, _2
	lsls	r3, r3, #1	@ tmp164, tmp164,
	adds	r3, r3, r2	@ tmp164, tmp164, _2
	lsls	r3, r3, #2	@ tmp165, tmp164,
	ldrb	r3, [r3, r1]	@ _3, MonsterSpawnTable
@ Pokedex.c:459: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	movs	r5, #15	@ tmp262,
	adds	r2, r7, r5	@ tmp166,, tmp262
	ldrb	r2, [r2]	@ tmp168, classID
	subs	r3, r2, r3	@ tmp170, tmp168, _3
	rsbs	r2, r3, #0	@ tmp171, tmp170
	adcs	r3, r3, r2	@ tmp169, tmp170, tmp171
	lsls	r3, r3, #24	@ tmp172, tmp167,
	lsrs	r1, r3, #24	@ _4, tmp172,
@ Pokedex.c:459: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	adds	r3, r7, r4	@ tmp173,, tmp263
	ldrh	r2, [r3]	@ _5, i
	ldr	r0, .L73	@ tmp174,
	movs	r3, r2	@ tmp175, _5
	lsls	r3, r3, #1	@ tmp175, tmp175,
	adds	r3, r3, r2	@ tmp175, tmp175, _5
	lsls	r3, r3, #2	@ tmp176, tmp175,
	adds	r3, r0, r3	@ tmp177, tmp174, tmp175
	adds	r3, r3, #1	@ tmp178,
	ldrb	r3, [r3]	@ _6, MonsterSpawnTable
@ Pokedex.c:459: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
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
@ Pokedex.c:459: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	adds	r3, r7, r4	@ tmp188,, tmp265
	ldrh	r2, [r3]	@ _10, i
	ldr	r1, .L73	@ tmp189,
	movs	r3, r2	@ tmp190, _10
	lsls	r3, r3, #1	@ tmp190, tmp190,
	adds	r3, r3, r2	@ tmp190, tmp190, _10
	lsls	r3, r3, #2	@ tmp191, tmp190,
	adds	r3, r1, r3	@ tmp192, tmp189, tmp190
	adds	r3, r3, #2	@ tmp193,
	ldrb	r3, [r3]	@ _11, MonsterSpawnTable
@ Pokedex.c:459: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	adds	r2, r7, r5	@ tmp194,, tmp266
	ldrb	r2, [r2]	@ tmp196, classID
	subs	r3, r2, r3	@ tmp198, tmp196, _11
	rsbs	r2, r3, #0	@ tmp199, tmp198
	adcs	r3, r3, r2	@ tmp197, tmp198, tmp199
	lsls	r3, r3, #24	@ tmp200, tmp195,
	lsrs	r3, r3, #24	@ _12, tmp200,
@ Pokedex.c:459: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	movs	r1, r0	@ _9, _9
	orrs	r1, r3	@ _9, _13
@ Pokedex.c:459: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	adds	r3, r7, r4	@ tmp201,, tmp268
	ldrh	r2, [r3]	@ _15, i
	ldr	r0, .L73	@ tmp202,
	movs	r3, r2	@ tmp203, _15
	lsls	r3, r3, #1	@ tmp203, tmp203,
	adds	r3, r3, r2	@ tmp203, tmp203, _15
	lsls	r3, r3, #2	@ tmp204, tmp203,
	adds	r3, r0, r3	@ tmp205, tmp202, tmp203
	adds	r3, r3, #3	@ tmp206,
	ldrb	r3, [r3]	@ _16, MonsterSpawnTable
@ Pokedex.c:459: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	adds	r2, r7, r5	@ tmp207,, tmp269
	ldrb	r2, [r2]	@ tmp209, classID
	subs	r3, r2, r3	@ tmp211, tmp209, _16
	rsbs	r2, r3, #0	@ tmp212, tmp211
	adcs	r3, r3, r2	@ tmp210, tmp211, tmp212
	lsls	r3, r3, #24	@ tmp213, tmp208,
	lsrs	r3, r3, #24	@ _17, tmp213,
@ Pokedex.c:459: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	orrs	r1, r3	@ _19, _18
@ Pokedex.c:459: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	adds	r3, r7, r4	@ tmp214,, tmp270
	ldrh	r2, [r3]	@ _20, i
	ldr	r0, .L73	@ tmp215,
	movs	r3, r2	@ tmp216, _20
	lsls	r3, r3, #1	@ tmp216, tmp216,
	adds	r3, r3, r2	@ tmp216, tmp216, _20
	lsls	r3, r3, #2	@ tmp217, tmp216,
	adds	r3, r0, r3	@ tmp218, tmp215, tmp216
	adds	r3, r3, #4	@ tmp219,
	ldrb	r3, [r3]	@ _21, MonsterSpawnTable
@ Pokedex.c:459: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	adds	r2, r7, r5	@ tmp220,, tmp271
	ldrb	r2, [r2]	@ tmp222, classID
	subs	r3, r2, r3	@ tmp224, tmp222, _21
	rsbs	r2, r3, #0	@ tmp225, tmp224
	adcs	r3, r3, r2	@ tmp223, tmp224, tmp225
	lsls	r3, r3, #24	@ tmp226, tmp221,
	lsrs	r3, r3, #24	@ _22, tmp226,
@ Pokedex.c:459: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	orrs	r3, r1	@ _24, _19
@ Pokedex.c:459: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	beq	.L69		@,
@ Pokedex.c:461: 				if (Chapter <= 63)
	adds	r3, r7, r6	@ tmp227,, tmp272
	ldrb	r3, [r3]	@ tmp230, Chapter
	cmp	r3, #63	@ tmp230,
	bhi	.L70		@,
@ Pokedex.c:465: 					*areaBitfield_A = *areaBitfield_A | 1<<Chapter;
	ldr	r3, [r7, #8]	@ tmp231, areaBitfield_A
	ldr	r2, [r3]	@ _25, *areaBitfield_A_42(D)
@ Pokedex.c:465: 					*areaBitfield_A = *areaBitfield_A | 1<<Chapter;
	adds	r3, r7, r6	@ tmp232,, tmp273
	ldrb	r3, [r3]	@ _26, Chapter
	movs	r1, #1	@ tmp233,
	lsls	r1, r1, r3	@ tmp233, tmp233, _26
	movs	r3, r1	@ _27, tmp233
@ Pokedex.c:465: 					*areaBitfield_A = *areaBitfield_A | 1<<Chapter;
	orrs	r2, r3	@ _28, _27
@ Pokedex.c:465: 					*areaBitfield_A = *areaBitfield_A | 1<<Chapter;
	ldr	r3, [r7, #8]	@ tmp234, areaBitfield_A
	str	r2, [r3]	@ _28, *areaBitfield_A_42(D)
.L70:
@ Pokedex.c:467: 				if ((Chapter > 63) && (Chapter < 127))
	movs	r1, #21	@ tmp275,
	adds	r3, r7, r1	@ tmp235,, tmp275
	ldrb	r3, [r3]	@ tmp238, Chapter
	cmp	r3, #63	@ tmp238,
	bls	.L69		@,
@ Pokedex.c:467: 				if ((Chapter > 63) && (Chapter < 127))
	adds	r3, r7, r1	@ tmp239,, tmp276
	ldrb	r3, [r3]	@ tmp242, Chapter
	cmp	r3, #126	@ tmp242,
	bhi	.L69		@,
@ Pokedex.c:469: 					*areaBitfield_B = *areaBitfield_B | 1<<Chapter;
	ldr	r3, [r7, #4]	@ tmp243, areaBitfield_B
	ldr	r2, [r3]	@ _29, *areaBitfield_B_44(D)
@ Pokedex.c:469: 					*areaBitfield_B = *areaBitfield_B | 1<<Chapter;
	adds	r3, r7, r1	@ tmp244,, tmp277
	ldrb	r3, [r3]	@ _30, Chapter
	movs	r1, #1	@ tmp245,
	lsls	r1, r1, r3	@ tmp245, tmp245, _30
	movs	r3, r1	@ _31, tmp245
@ Pokedex.c:469: 					*areaBitfield_B = *areaBitfield_B | 1<<Chapter;
	orrs	r2, r3	@ _32, _31
@ Pokedex.c:469: 					*areaBitfield_B = *areaBitfield_B | 1<<Chapter;
	ldr	r3, [r7, #4]	@ tmp246, areaBitfield_B
	str	r2, [r3]	@ _32, *areaBitfield_B_44(D)
.L69:
@ Pokedex.c:453: 	for (u16 i = 0 ; i <= 0x80 ; i++) 
	movs	r1, #22	@ tmp279,
	adds	r3, r7, r1	@ tmp247,, tmp279
	ldrh	r2, [r3]	@ i.17_33, i
	adds	r3, r7, r1	@ tmp248,, tmp280
	adds	r2, r2, #1	@ tmp249,
	strh	r2, [r3]	@ tmp250, i
.L68:
@ Pokedex.c:453: 	for (u16 i = 0 ; i <= 0x80 ; i++) 
	movs	r3, #22	@ tmp281,
	adds	r3, r7, r3	@ tmp251,, tmp281
	ldrh	r3, [r3]	@ tmp254, i
	cmp	r3, #128	@ tmp254,
	bhi	.LCB1725	@
	b	.L71	@long jump	@
.LCB1725:
@ Pokedex.c:474: 	return;
	nop	
@ Pokedex.c:475: }
	mov	sp, r7	@,
	add	sp, sp, #28	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L74:
	.align	2
.L73:
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
@ Pokedex.c:480: 	int sum = 1;
	movs	r3, #1	@ tmp121,
	str	r3, [r7, #12]	@ tmp121, sum
@ Pokedex.c:481: 	for ( int i = 0 ; string[i] ; i++ )
	movs	r3, #0	@ tmp122,
	str	r3, [r7, #8]	@ tmp122, i
@ Pokedex.c:481: 	for ( int i = 0 ; string[i] ; i++ )
	b	.L76		@
.L78:
@ Pokedex.c:483: 		if ( string[i] == NL ) { sum++; }
	ldr	r3, [r7, #8]	@ i.18_1, i
	ldr	r2, [r7, #4]	@ tmp123, string
	adds	r3, r2, r3	@ _2, tmp123, i.18_1
	ldrb	r3, [r3]	@ _3, *_2
@ Pokedex.c:483: 		if ( string[i] == NL ) { sum++; }
	cmp	r3, #1	@ _3,
	bne	.L77		@,
@ Pokedex.c:483: 		if ( string[i] == NL ) { sum++; }
	ldr	r3, [r7, #12]	@ tmp125, sum
	adds	r3, r3, #1	@ tmp124,
	str	r3, [r7, #12]	@ tmp124, sum
.L77:
@ Pokedex.c:481: 	for ( int i = 0 ; string[i] ; i++ )
	ldr	r3, [r7, #8]	@ tmp127, i
	adds	r3, r3, #1	@ tmp126,
	str	r3, [r7, #8]	@ tmp126, i
.L76:
@ Pokedex.c:481: 	for ( int i = 0 ; string[i] ; i++ )
	ldr	r3, [r7, #8]	@ i.19_4, i
	ldr	r2, [r7, #4]	@ tmp128, string
	adds	r3, r2, r3	@ _5, tmp128, i.19_4
	ldrb	r3, [r3]	@ _6, *_5
@ Pokedex.c:481: 	for ( int i = 0 ; string[i] ; i++ )
	cmp	r3, #0	@ _6,
	bne	.L78		@,
@ Pokedex.c:485: 	return sum;
	ldr	r3, [r7, #12]	@ _14, sum
@ Pokedex.c:486: }
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
.L13:
	bx	r3
.L40:
	bx	r4
