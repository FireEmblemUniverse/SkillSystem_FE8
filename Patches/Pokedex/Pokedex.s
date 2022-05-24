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
@ Pokedex.c:113:     struct PokedexProc* const proc = (void*) menu->parent;
	ldr	r3, [r7, #4]	@ tmp143, menu
	ldr	r3, [r3, #20]	@ tmp144, menu_38(D)->parent
	str	r3, [r7, #12]	@ tmp144, proc
@ Pokedex.c:116:     if (gKeyState.repeatedKeys & KEY_DPAD_LEFT) {
	ldr	r3, .L11	@ tmp145,
	ldrh	r3, [r3, #6]	@ _1,
@ Pokedex.c:116:     if (gKeyState.repeatedKeys & KEY_DPAD_LEFT) {
	movs	r2, r3	@ _2, _1
	movs	r3, #32	@ tmp146,
	ands	r3, r2	@ _3, _2
@ Pokedex.c:116:     if (gKeyState.repeatedKeys & KEY_DPAD_LEFT) {
	beq	.L2		@,
@ Pokedex.c:117:         if (proc->menuIndex < 0xFF) {
	ldr	r3, [r7, #12]	@ tmp147, proc
	movs	r2, #48	@ tmp148,
	ldrb	r3, [r3, r2]	@ _4,
@ Pokedex.c:117:         if (proc->menuIndex < 0xFF) {
	cmp	r3, #255	@ _4,
	beq	.L2		@,
@ Pokedex.c:118:             proc->menuIndex--;
	ldr	r3, [r7, #12]	@ tmp149, proc
	movs	r2, #48	@ tmp150,
	ldrb	r3, [r3, r2]	@ _5,
@ Pokedex.c:118:             proc->menuIndex--;
	subs	r3, r3, #1	@ tmp151,
	lsls	r3, r3, #24	@ tmp152, tmp151,
	lsrs	r1, r3, #24	@ _7, tmp152,
	ldr	r3, [r7, #12]	@ tmp153, proc
	movs	r2, #48	@ tmp154,
	strb	r1, [r3, r2]	@ tmp155, proc_39->menuIndex
@ Pokedex.c:119: 			while (!PokedexTable[proc->menuIndex].IndexNumber)
	b	.L3		@
.L5:
@ Pokedex.c:121: 				if (proc->menuIndex > 2) 
	ldr	r3, [r7, #12]	@ tmp156, proc
	movs	r2, #48	@ tmp157,
	ldrb	r3, [r3, r2]	@ _8,
@ Pokedex.c:121: 				if (proc->menuIndex > 2) 
	cmp	r3, #2	@ _8,
	bls	.L4		@,
@ Pokedex.c:123: 					proc->menuIndex--;
	ldr	r3, [r7, #12]	@ tmp160, proc
	movs	r2, #48	@ tmp161,
	ldrb	r3, [r3, r2]	@ _9,
@ Pokedex.c:123: 					proc->menuIndex--;
	subs	r3, r3, #1	@ tmp162,
	lsls	r3, r3, #24	@ tmp163, tmp162,
	lsrs	r1, r3, #24	@ _11, tmp163,
	ldr	r3, [r7, #12]	@ tmp164, proc
	movs	r2, #48	@ tmp165,
	strb	r1, [r3, r2]	@ tmp166, proc_39->menuIndex
	b	.L3		@
.L4:
@ Pokedex.c:125: 				else { proc->menuIndex = 0xFF; }
	ldr	r3, [r7, #12]	@ tmp167, proc
	movs	r2, #48	@ tmp168,
	movs	r1, #255	@ tmp169,
	strb	r1, [r3, r2]	@ tmp170, proc_39->menuIndex
.L3:
@ Pokedex.c:119: 			while (!PokedexTable[proc->menuIndex].IndexNumber)
	ldr	r3, [r7, #12]	@ tmp171, proc
	movs	r2, #48	@ tmp172,
	ldrb	r3, [r3, r2]	@ _12,
	movs	r2, r3	@ _13, _12
@ Pokedex.c:119: 			while (!PokedexTable[proc->menuIndex].IndexNumber)
	ldr	r3, .L11+4	@ tmp173,
	lsls	r2, r2, #2	@ tmp174, _13,
	ldrb	r3, [r2, r3]	@ _14, PokedexTable
@ Pokedex.c:119: 			while (!PokedexTable[proc->menuIndex].IndexNumber)
	cmp	r3, #0	@ _14,
	beq	.L5		@,
@ Pokedex.c:127:             PokedexDraw(menu, command);
	ldr	r2, [r7]	@ tmp175, command
	ldr	r3, [r7, #4]	@ tmp176, menu
	movs	r1, r2	@, tmp175
	movs	r0, r3	@, tmp176
	bl	PokedexDraw		@
@ Pokedex.c:128:             PlaySfx(0x6B);
	ldr	r3, .L11+8	@ tmp177,
	movs	r2, #65	@ tmp178,
	ldrb	r3, [r3, r2]	@ _15, gChapterData
	movs	r2, #2	@ tmp180,
	ands	r3, r2	@ tmp179, tmp180
	lsls	r3, r3, #24	@ tmp181, tmp179,
	lsrs	r3, r3, #24	@ _16, tmp181,
	bne	.L2		@,
@ Pokedex.c:128:             PlaySfx(0x6B);
	movs	r0, #107	@,
	ldr	r3, .L11+12	@ tmp182,
	bl	.L13		@
.L2:
@ Pokedex.c:132:     if (gKeyState.repeatedKeys & KEY_DPAD_RIGHT) {
	ldr	r3, .L11	@ tmp183,
	ldrh	r3, [r3, #6]	@ _17,
@ Pokedex.c:132:     if (gKeyState.repeatedKeys & KEY_DPAD_RIGHT) {
	movs	r2, r3	@ _18, _17
	movs	r3, #16	@ tmp184,
	ands	r3, r2	@ _19, _18
@ Pokedex.c:132:     if (gKeyState.repeatedKeys & KEY_DPAD_RIGHT) {
	beq	.L6		@,
@ Pokedex.c:133:         if (proc->menuIndex < 0xFF) {
	ldr	r3, [r7, #12]	@ tmp185, proc
	movs	r2, #48	@ tmp186,
	ldrb	r3, [r3, r2]	@ _20,
@ Pokedex.c:133:         if (proc->menuIndex < 0xFF) {
	cmp	r3, #255	@ _20,
	beq	.L6		@,
@ Pokedex.c:134:             proc->menuIndex++;
	ldr	r3, [r7, #12]	@ tmp187, proc
	movs	r2, #48	@ tmp188,
	ldrb	r3, [r3, r2]	@ _21,
@ Pokedex.c:134:             proc->menuIndex++;
	adds	r3, r3, #1	@ tmp189,
	lsls	r3, r3, #24	@ tmp190, tmp189,
	lsrs	r1, r3, #24	@ _23, tmp190,
	ldr	r3, [r7, #12]	@ tmp191, proc
	movs	r2, #48	@ tmp192,
	strb	r1, [r3, r2]	@ tmp193, proc_39->menuIndex
@ Pokedex.c:135: 			while (!PokedexTable[proc->menuIndex].IndexNumber)
	b	.L7		@
.L9:
@ Pokedex.c:137: 				if (proc->menuIndex < 0xFF) 
	ldr	r3, [r7, #12]	@ tmp194, proc
	movs	r2, #48	@ tmp195,
	ldrb	r3, [r3, r2]	@ _24,
@ Pokedex.c:137: 				if (proc->menuIndex < 0xFF) 
	cmp	r3, #255	@ _24,
	beq	.L8		@,
@ Pokedex.c:139: 					proc->menuIndex++;
	ldr	r3, [r7, #12]	@ tmp196, proc
	movs	r2, #48	@ tmp197,
	ldrb	r3, [r3, r2]	@ _25,
@ Pokedex.c:139: 					proc->menuIndex++;
	adds	r3, r3, #1	@ tmp198,
	lsls	r3, r3, #24	@ tmp199, tmp198,
	lsrs	r1, r3, #24	@ _27, tmp199,
	ldr	r3, [r7, #12]	@ tmp200, proc
	movs	r2, #48	@ tmp201,
	strb	r1, [r3, r2]	@ tmp202, proc_39->menuIndex
	b	.L7		@
.L8:
@ Pokedex.c:141: 				else { proc->menuIndex = 1; }
	ldr	r3, [r7, #12]	@ tmp203, proc
	movs	r2, #48	@ tmp204,
	movs	r1, #1	@ tmp205,
	strb	r1, [r3, r2]	@ tmp206, proc_39->menuIndex
.L7:
@ Pokedex.c:135: 			while (!PokedexTable[proc->menuIndex].IndexNumber)
	ldr	r3, [r7, #12]	@ tmp207, proc
	movs	r2, #48	@ tmp208,
	ldrb	r3, [r3, r2]	@ _28,
	movs	r2, r3	@ _29, _28
@ Pokedex.c:135: 			while (!PokedexTable[proc->menuIndex].IndexNumber)
	ldr	r3, .L11+4	@ tmp209,
	lsls	r2, r2, #2	@ tmp210, _29,
	ldrb	r3, [r2, r3]	@ _30, PokedexTable
@ Pokedex.c:135: 			while (!PokedexTable[proc->menuIndex].IndexNumber)
	cmp	r3, #0	@ _30,
	beq	.L9		@,
@ Pokedex.c:143:             PokedexDraw(menu, command);
	ldr	r2, [r7]	@ tmp211, command
	ldr	r3, [r7, #4]	@ tmp212, menu
	movs	r1, r2	@, tmp211
	movs	r0, r3	@, tmp212
	bl	PokedexDraw		@
@ Pokedex.c:144:             PlaySfx(0x6B);
	ldr	r3, .L11+8	@ tmp213,
	movs	r2, #65	@ tmp214,
	ldrb	r3, [r3, r2]	@ _31, gChapterData
	movs	r2, #2	@ tmp216,
	ands	r3, r2	@ tmp215, tmp216
	lsls	r3, r3, #24	@ tmp217, tmp215,
	lsrs	r3, r3, #24	@ _32, tmp217,
	bne	.L6		@,
@ Pokedex.c:144:             PlaySfx(0x6B);
	movs	r0, #107	@,
	ldr	r3, .L11+12	@ tmp218,
	bl	.L13		@
.L6:
@ Pokedex.c:148:     return ME_NONE;
	movs	r3, #0	@ _51,
@ Pokedex.c:149: }
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
@ Pokedex.c:154: 	Text_Clear(&handle);
	movs	r4, r5	@ tmp132, tmp131
	adds	r3, r7, r4	@ tmp115,, tmp132
	movs	r0, r3	@, tmp115
	ldr	r3, .L15	@ tmp116,
	bl	.L13		@
@ Pokedex.c:155: 	Text_SetColorId(&handle,TEXT_COLOR_GOLD);
	adds	r3, r7, r4	@ tmp117,, tmp133
	movs	r1, #3	@,
	movs	r0, r3	@, tmp117
	ldr	r3, .L15+4	@ tmp118,
	bl	.L13		@
@ Pokedex.c:156: 	Text_DrawString(&handle,string);
	ldr	r2, [r7, #4]	@ tmp119, string
	adds	r3, r7, r4	@ tmp120,, tmp134
	movs	r1, r2	@, tmp119
	movs	r0, r3	@, tmp120
	ldr	r3, .L15+8	@ tmp121,
	bl	.L13		@
@ Pokedex.c:157: 	Text_Display(&handle,&gBG0MapBuffer[y][x]);
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
@ Pokedex.c:158: }
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
	@ args = 0, pretend = 0, frame = 72
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, r7, lr}	@
	sub	sp, sp, #80	@,,
	add	r7, sp, #8	@,,
	str	r0, [r7, #4]	@ menu, menu
	str	r1, [r7]	@ command, command
@ Pokedex.c:161:     struct PokedexProc* const proc = (void*) menu->parent;
	ldr	r3, [r7, #4]	@ tmp163, menu
	ldr	r3, [r3, #20]	@ tmp164, menu_55(D)->parent
	str	r3, [r7, #64]	@ tmp164, proc
@ Pokedex.c:162:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldr	r3, [r7]	@ tmp165, command
	ldrh	r3, [r3, #44]	@ _1,
	lsls	r3, r3, #5	@ _3, _2,
	ldr	r2, [r7]	@ tmp166, command
	ldrh	r2, [r2, #42]	@ _4,
	adds	r3, r3, r2	@ _6, _3, _5
@ Pokedex.c:162:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r2, r3, #1	@ _8, _7,
@ Pokedex.c:162:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldr	r3, .L24	@ tmp168,
	adds	r3, r2, r3	@ tmp167, _8, tmp168
	str	r3, [r7, #60]	@ tmp167, out
@ Pokedex.c:164: 	int* areaBitfield_A = &proc->areaBitfield_A;
	ldr	r3, [r7, #64]	@ tmp170, proc
	adds	r3, r3, #52	@ tmp169,
	str	r3, [r7, #56]	@ tmp169, areaBitfield_A
@ Pokedex.c:165: 	int* areaBitfield_B = &proc->areaBitfield_B;
	ldr	r3, [r7, #64]	@ tmp172, proc
	adds	r3, r3, #56	@ tmp171,
	str	r3, [r7, #52]	@ tmp171, areaBitfield_B
@ Pokedex.c:166: 	*areaBitfield_A = 0;
	ldr	r3, [r7, #56]	@ tmp173, areaBitfield_A
	movs	r2, #0	@ tmp174,
	str	r2, [r3]	@ tmp174, *areaBitfield_A_59
@ Pokedex.c:167: 	*areaBitfield_B = 0;
	ldr	r3, [r7, #52]	@ tmp175, areaBitfield_B
	movs	r2, #0	@ tmp176,
	str	r2, [r3]	@ tmp176, *areaBitfield_B_60
@ Pokedex.c:168: 	proc->areaBitfield_A = 0;
	ldr	r3, [r7, #64]	@ tmp177, proc
	movs	r2, #0	@ tmp178,
	str	r2, [r3, #52]	@ tmp178, proc_56->areaBitfield_A
@ Pokedex.c:169: 	proc->areaBitfield_B = 0;
	ldr	r3, [r7, #64]	@ tmp179, proc
	movs	r2, #0	@ tmp180,
	str	r2, [r3, #56]	@ tmp180, proc_56->areaBitfield_B
@ Pokedex.c:171: 	bool caught = CheckIfCaught(proc->menuIndex);
	ldr	r3, [r7, #64]	@ tmp181, proc
	movs	r2, #48	@ tmp182,
	ldrb	r3, [r3, r2]	@ _9,
	movs	r0, r3	@, _9
	ldr	r3, .L24+4	@ tmp183,
	bl	.L13		@
	movs	r2, r0	@ _10,
@ Pokedex.c:171: 	bool caught = CheckIfCaught(proc->menuIndex);
	movs	r3, #51	@ tmp345,
	adds	r3, r7, r3	@ tmp184,, tmp345
	subs	r1, r2, #1	@ tmp186, _10
	sbcs	r2, r2, r1	@ tmp185, _10, tmp186
	strb	r2, [r3]	@ tmp187, caught
@ Pokedex.c:172: 	bool seen = CheckIfSeen(proc->menuIndex);
	ldr	r3, [r7, #64]	@ tmp188, proc
	movs	r2, #48	@ tmp189,
	ldrb	r3, [r3, r2]	@ _11,
	movs	r0, r3	@, _11
	ldr	r3, .L24+8	@ tmp190,
	bl	.L13		@
	movs	r2, r0	@ _12,
@ Pokedex.c:172: 	bool seen = CheckIfSeen(proc->menuIndex);
	movs	r5, #50	@ tmp346,
	adds	r3, r7, r5	@ tmp191,, tmp346
	subs	r1, r2, #1	@ tmp193, _12
	sbcs	r2, r2, r1	@ tmp192, _12, tmp193
	strb	r2, [r3]	@ tmp194, seen
@ Pokedex.c:174: 	const struct ClassData* ClassData = GetClassData(proc->menuIndex);
	ldr	r3, [r7, #64]	@ tmp195, proc
	movs	r2, #48	@ tmp196,
	ldrb	r3, [r3, r2]	@ _13,
	movs	r0, r3	@, _13
	ldr	r3, .L24+12	@ tmp197,
	bl	.L13		@
	movs	r3, r0	@ tmp198,
	str	r3, [r7, #44]	@ tmp198, ClassData
@ Pokedex.c:175: 	u16 title = 0;
	movs	r4, #70	@ tmp347,
	adds	r3, r7, r4	@ tmp199,, tmp347
	movs	r2, #0	@ tmp200,
	strh	r2, [r3]	@ tmp201, title
@ Pokedex.c:176:     Text_Clear(&command->text);
	ldr	r3, [r7]	@ tmp202, command
	adds	r3, r3, #52	@ _14,
	movs	r0, r3	@, _14
	ldr	r3, .L24+16	@ tmp203,
	bl	.L13		@
@ Pokedex.c:177: 	Text_ResetTileAllocation(); // 0x08003D20
	ldr	r3, .L24+20	@ tmp204,
	bl	.L13		@
@ Pokedex.c:180: 	Pokedex_RetrieveAreasFound(proc->menuIndex, areaBitfield_A, areaBitfield_B);
	ldr	r3, [r7, #64]	@ tmp205, proc
	movs	r2, #48	@ tmp206,
	ldrb	r3, [r3, r2]	@ _15,
	ldr	r2, [r7, #52]	@ tmp207, areaBitfield_B
	ldr	r1, [r7, #56]	@ tmp208, areaBitfield_A
	movs	r0, r3	@, _15
	bl	Pokedex_RetrieveAreasFound		@
@ Pokedex.c:184: 	if (proc->menuIndex)
	ldr	r3, [r7, #64]	@ tmp209, proc
	movs	r2, #48	@ tmp210,
	ldrb	r3, [r3, r2]	@ _16,
@ Pokedex.c:184: 	if (proc->menuIndex)
	cmp	r3, #0	@ _16,
	beq	.L18		@,
@ Pokedex.c:186: 		if (seen)
	adds	r3, r7, r5	@ tmp211,, tmp348
	ldrb	r3, [r3]	@ tmp212, seen
	cmp	r3, #0	@ tmp212,
	beq	.L18		@,
@ Pokedex.c:188: 			title = ClassData->nameTextId;
	movs	r1, r4	@ tmp349, tmp347
	adds	r3, r7, r1	@ tmp213,, tmp349
	ldr	r2, [r7, #44]	@ tmp214, ClassData
	ldrh	r2, [r2]	@ tmp215, *ClassData_70
	strh	r2, [r3]	@ tmp215, title
@ Pokedex.c:189: 			Text_DrawString(&command->text, GetStringFromIndex(title));
	ldr	r3, [r7]	@ tmp216, command
	adds	r3, r3, #52	@ tmp216,
	movs	r4, r3	@ _17, tmp216
@ Pokedex.c:189: 			Text_DrawString(&command->text, GetStringFromIndex(title));
	adds	r3, r7, r1	@ tmp217,, tmp351
	ldrh	r3, [r3]	@ _18, title
	movs	r0, r3	@, _18
	ldr	r3, .L24+24	@ tmp218,
	bl	.L13		@
	movs	r3, r0	@ _19,
@ Pokedex.c:189: 			Text_DrawString(&command->text, GetStringFromIndex(title));
	movs	r1, r3	@, _19
	movs	r0, r4	@, _17
	ldr	r3, .L24+28	@ tmp219,
	bl	.L13		@
@ Pokedex.c:190: 			Text_Display(&command->text, out); // Class name 
	ldr	r3, [r7]	@ tmp220, command
	adds	r3, r3, #52	@ _20,
	ldr	r2, [r7, #60]	@ tmp221, out
	movs	r1, r2	@, tmp221
	movs	r0, r3	@, _20
	ldr	r3, .L24+32	@ tmp222,
	bl	.L13		@
.L18:
@ Pokedex.c:196:     Text_SetColorId(&command->text, TEXT_COLOR_NORMAL);
	ldr	r3, [r7]	@ tmp223, command
	adds	r3, r3, #52	@ _21,
	movs	r1, #0	@,
	movs	r0, r3	@, _21
	ldr	r3, .L24+36	@ tmp224,
	bl	.L13		@
@ Pokedex.c:197:     if (!title) {
	movs	r3, #70	@ tmp352,
	adds	r3, r7, r3	@ tmp225,, tmp352
	ldrh	r3, [r3]	@ tmp226, title
	cmp	r3, #0	@ tmp226,
	bne	.L19		@,
@ Pokedex.c:198: 		Text_SetXCursor(&command->text, 0xC);
	ldr	r3, [r7]	@ tmp227, command
	adds	r3, r3, #52	@ _22,
	movs	r1, #12	@,
	movs	r0, r3	@, _22
	ldr	r3, .L24+40	@ tmp228,
	bl	.L13		@
@ Pokedex.c:199: 		Text_DrawString(&command->text, "???");
	ldr	r3, [r7]	@ tmp229, command
	adds	r3, r3, #52	@ _23,
	ldr	r2, .L24+44	@ tmp230,
	movs	r1, r2	@, tmp230
	movs	r0, r3	@, _23
	ldr	r3, .L24+28	@ tmp231,
	bl	.L13		@
@ Pokedex.c:201: 		Text_Display(&command->text, out); // Class name 
	ldr	r3, [r7]	@ tmp232, command
	adds	r3, r3, #52	@ _24,
	ldr	r2, [r7, #60]	@ tmp233, out
	movs	r1, r2	@, tmp233
	movs	r0, r3	@, _24
	ldr	r3, .L24+32	@ tmp234,
	bl	.L13		@
.L19:
@ Pokedex.c:208: 	int tile = 40;
	movs	r3, #40	@ tmp235,
	str	r3, [r7, #40]	@ tmp235, tile
@ Pokedex.c:210: 	TextHandle caughtNameHandle = {
	movs	r4, #20	@ tmp353,
	adds	r3, r7, r4	@ tmp236,, tmp353
	movs	r0, r3	@ tmp237, tmp236
	movs	r3, #8	@ tmp238,
	movs	r2, r3	@, tmp238
	movs	r1, #0	@,
	ldr	r3, .L24+48	@ tmp239,
	bl	.L13		@
@ Pokedex.c:211: 		.tileIndexOffset = gpCurrentFont->tileNext+tile,
	ldr	r3, .L24+52	@ tmp242,
	ldr	r3, [r3]	@ gpCurrentFont.0_25, gpCurrentFont
	ldrh	r2, [r3, #18]	@ _26,
@ Pokedex.c:211: 		.tileIndexOffset = gpCurrentFont->tileNext+tile,
	ldr	r3, [r7, #40]	@ tmp244, tile
	lsls	r3, r3, #16	@ tmp245, tmp243,
	lsrs	r3, r3, #16	@ _27, tmp245,
	adds	r3, r2, r3	@ tmp246, _26, _27
	lsls	r3, r3, #16	@ tmp247, tmp246,
	lsrs	r2, r3, #16	@ _28, tmp247,
@ Pokedex.c:210: 	TextHandle caughtNameHandle = {
	adds	r3, r7, r4	@ tmp248,, tmp354
	strh	r2, [r3]	@ tmp249, caughtNameHandle.tileIndexOffset
	adds	r3, r7, r4	@ tmp250,, tmp355
	movs	r2, #4	@ tmp251,
	strb	r2, [r3, #4]	@ tmp252, caughtNameHandle.tileWidth
@ Pokedex.c:214: 	tile += 4;
	ldr	r3, [r7, #40]	@ tmp254, tile
	adds	r3, r3, #4	@ tmp253,
	str	r3, [r7, #40]	@ tmp253, tile
@ Pokedex.c:215: 	DrawRawText(caughtNameHandle," Seen",1,1);
	ldr	r2, .L24+56	@ tmp255,
	adds	r1, r7, r4	@ tmp256,, tmp356
	movs	r3, #1	@ tmp257,
	str	r3, [sp]	@ tmp257,
	movs	r3, #1	@,
	ldr	r0, [r1]	@, caughtNameHandle
	ldr	r1, [r1, #4]	@, caughtNameHandle
	bl	DrawRawText		@
@ Pokedex.c:217: 	TextHandle seenNameHandle = {
	movs	r4, #12	@ tmp357,
	adds	r3, r7, r4	@ tmp258,, tmp357
	movs	r0, r3	@ tmp259, tmp258
	movs	r3, #8	@ tmp260,
	movs	r2, r3	@, tmp260
	movs	r1, #0	@,
	ldr	r3, .L24+48	@ tmp261,
	bl	.L13		@
@ Pokedex.c:218: 		.tileIndexOffset = gpCurrentFont->tileNext+tile,
	ldr	r3, .L24+52	@ tmp264,
	ldr	r3, [r3]	@ gpCurrentFont.1_29, gpCurrentFont
	ldrh	r2, [r3, #18]	@ _30,
@ Pokedex.c:218: 		.tileIndexOffset = gpCurrentFont->tileNext+tile,
	ldr	r3, [r7, #40]	@ tmp266, tile
	lsls	r3, r3, #16	@ tmp267, tmp265,
	lsrs	r3, r3, #16	@ _31, tmp267,
	adds	r3, r2, r3	@ tmp268, _30, _31
	lsls	r3, r3, #16	@ tmp269, tmp268,
	lsrs	r2, r3, #16	@ _32, tmp269,
@ Pokedex.c:217: 	TextHandle seenNameHandle = {
	adds	r3, r7, r4	@ tmp270,, tmp358
	strh	r2, [r3]	@ tmp271, seenNameHandle.tileIndexOffset
	adds	r3, r7, r4	@ tmp272,, tmp359
	movs	r2, #5	@ tmp273,
	strb	r2, [r3, #4]	@ tmp274, seenNameHandle.tileWidth
@ Pokedex.c:221: 	tile += 5;
	ldr	r3, [r7, #40]	@ tmp276, tile
	adds	r3, r3, #5	@ tmp275,
	str	r3, [r7, #40]	@ tmp275, tile
@ Pokedex.c:222: 	DrawRawText(seenNameHandle," Caught",1,3);
	ldr	r2, .L24+60	@ tmp277,
	adds	r1, r7, r4	@ tmp278,, tmp360
	movs	r3, #3	@ tmp279,
	str	r3, [sp]	@ tmp279,
	movs	r3, #1	@,
	ldr	r0, [r1]	@, seenNameHandle
	ldr	r1, [r1, #4]	@, seenNameHandle
	bl	DrawRawText		@
@ Pokedex.c:225: 	DrawUiNumber(&gBG0MapBuffer[1][7],TEXT_COLOR_GOLD,  proc->TotalSeen); 
	ldr	r3, [r7, #64]	@ tmp280, proc
	movs	r2, #49	@ tmp281,
	ldrb	r3, [r3, r2]	@ _33,
@ Pokedex.c:225: 	DrawUiNumber(&gBG0MapBuffer[1][7],TEXT_COLOR_GOLD,  proc->TotalSeen); 
	movs	r2, r3	@ _34, _33
	ldr	r3, .L24+64	@ tmp282,
	movs	r1, #3	@,
	movs	r0, r3	@, tmp282
	ldr	r3, .L24+68	@ tmp283,
	bl	.L13		@
@ Pokedex.c:226: 	DrawUiNumber(&gBG0MapBuffer[3][7],TEXT_COLOR_GOLD,  proc->TotalCaught);
	ldr	r3, [r7, #64]	@ tmp284, proc
	movs	r2, #50	@ tmp285,
	ldrb	r3, [r3, r2]	@ _35,
@ Pokedex.c:226: 	DrawUiNumber(&gBG0MapBuffer[3][7],TEXT_COLOR_GOLD,  proc->TotalCaught);
	movs	r2, r3	@ _36, _35
	ldr	r3, .L24+72	@ tmp286,
	movs	r1, #3	@,
	movs	r0, r3	@, tmp286
	ldr	r3, .L24+68	@ tmp287,
	bl	.L13		@
@ Pokedex.c:227: 	Text_Display(&command->text,out);
	ldr	r3, [r7]	@ tmp288, command
	adds	r3, r3, #52	@ _37,
	ldr	r2, [r7, #60]	@ tmp289, out
	movs	r1, r2	@, tmp289
	movs	r0, r3	@, _37
	ldr	r3, .L24+32	@ tmp290,
	bl	.L13		@
@ Pokedex.c:228: 	Text_Display(&command->text,out);
	ldr	r3, [r7]	@ tmp291, command
	adds	r3, r3, #52	@ _38,
	ldr	r2, [r7, #60]	@ tmp292, out
	movs	r1, r2	@, tmp292
	movs	r0, r3	@, _38
	ldr	r3, .L24+32	@ tmp293,
	bl	.L13		@
@ Pokedex.c:230: 	BgMap_ApplyTsa(&gBG1MapBuffer[0][0], &PokedexSeenCaughtBox, 0);
	ldr	r1, .L24+76	@ tmp294,
	ldr	r3, .L24+80	@ tmp295,
	movs	r2, #0	@,
	movs	r0, r3	@, tmp295
	ldr	r3, .L24+84	@ tmp296,
	bl	.L13		@
@ Pokedex.c:231: 	EndFaceById(0);
	movs	r0, #0	@,
	ldr	r3, .L24+88	@ tmp297,
	bl	.L13		@
@ Pokedex.c:232: 	struct FaceProc* FaceProc = StartFace(0, ClassData->defaultPortraitId, 200, 4, 1);
	ldr	r3, [r7, #44]	@ tmp298, ClassData
	ldrh	r3, [r3, #8]	@ _39,
@ Pokedex.c:232: 	struct FaceProc* FaceProc = StartFace(0, ClassData->defaultPortraitId, 200, 4, 1);
	movs	r1, r3	@ _40, _39
	movs	r3, #1	@ tmp299,
	str	r3, [sp]	@ tmp299,
	movs	r3, #4	@,
	movs	r2, #200	@,
	movs	r0, #0	@,
	ldr	r4, .L24+92	@ tmp300,
	bl	.L26		@
	movs	r3, r0	@ tmp301,
	str	r3, [r7, #36]	@ tmp301, FaceProc
@ Pokedex.c:233: 	FaceProc->tileData &= ~(3 << 10); // Clear bits 10 and 11 (priority) such that they are 0 (highest priority) and appear above the background 
	ldr	r3, [r7, #36]	@ tmp302, FaceProc
	ldrh	r3, [r3, #60]	@ _41,
	ldr	r2, .L24+96	@ tmp304,
	ands	r3, r2	@ tmp303, tmp304
	lsls	r3, r3, #16	@ tmp305, tmp303,
	lsrs	r2, r3, #16	@ _42, tmp305,
	ldr	r3, [r7, #36]	@ tmp306, FaceProc
	strh	r2, [r3, #60]	@ tmp307, FaceProc_101->tileData
@ Pokedex.c:235: 	BgMap_ApplyTsa(&gBG1MapBuffer[0][20], &PokedexPortraitBox, 0);
	ldr	r1, .L24+100	@ tmp308,
	ldr	r3, .L24+104	@ tmp309,
	movs	r2, #0	@,
	movs	r0, r3	@, tmp309
	ldr	r3, .L24+84	@ tmp310,
	bl	.L13		@
@ Pokedex.c:237: 	if (!seen)
	movs	r3, #50	@ tmp361,
	adds	r3, r7, r3	@ tmp311,, tmp361
	ldrb	r3, [r3]	@ tmp312, seen
	movs	r2, #1	@ tmp314,
	eors	r3, r2	@ tmp313, tmp314
	lsls	r3, r3, #24	@ tmp315, tmp313,
	lsrs	r3, r3, #24	@ _43, tmp315,
@ Pokedex.c:237: 	if (!seen)
	beq	.L20		@,
@ Pokedex.c:240: 		int paletteID = 22*32;
	movs	r3, #176	@ tmp343,
	lsls	r3, r3, #2	@ tmp316, tmp343,
	str	r3, [r7, #32]	@ tmp316, paletteID
@ Pokedex.c:241: 		int paletteSize = 32; 
	movs	r3, #32	@ tmp317,
	str	r3, [r7, #28]	@ tmp317, paletteSize
@ Pokedex.c:242: 		CopyToPaletteBuffer(MyPalette, paletteID, paletteSize); // source pointer, palette offset, size 
	ldr	r1, [r7, #32]	@ paletteID.2_44, paletteID
	ldr	r2, [r7, #28]	@ paletteSize.3_45, paletteSize
	ldr	r3, .L24+108	@ tmp318,
	movs	r0, r3	@, tmp318
	ldr	r3, .L24+112	@ tmp319,
	bl	.L13		@
@ Pokedex.c:243: 		gPaletteSyncFlag = 1;
	ldr	r3, .L24+116	@ tmp320,
	movs	r2, #1	@ tmp321,
	strb	r2, [r3]	@ tmp322, gPaletteSyncFlag
.L20:
@ Pokedex.c:246: 	LoadIconPalettes(4);
	movs	r0, #4	@,
	ldr	r3, .L24+120	@ tmp323,
	bl	.L13		@
@ Pokedex.c:247: 	ClearIcons();
	ldr	r3, .L24+124	@ tmp324,
	bl	.L13		@
@ Pokedex.c:248: 	EnableBgSyncByMask(BG0_SYNC_BIT);
	movs	r0, #1	@,
	ldr	r3, .L24+128	@ tmp325,
	bl	.L13		@
@ Pokedex.c:250: 	if (caught)
	movs	r3, #51	@ tmp362,
	adds	r3, r7, r3	@ tmp326,, tmp362
	ldrb	r3, [r3]	@ tmp327, caught
	cmp	r3, #0	@ tmp327,
	beq	.L21		@,
@ Pokedex.c:252: 		DrawIcon(
	ldr	r3, [r7, #60]	@ tmp328, out
	adds	r3, r3, #14	@ _46,
	movs	r2, #128	@ tmp342,
	lsls	r2, r2, #7	@ tmp329, tmp342,
	movs	r1, #171	@,
	movs	r0, r3	@, _46
	ldr	r3, .L24+132	@ tmp330,
	bl	.L13		@
	b	.L22		@
.L21:
@ Pokedex.c:258: 		if (seen)
	movs	r3, #50	@ tmp363,
	adds	r3, r7, r3	@ tmp331,, tmp363
	ldrb	r3, [r3]	@ tmp332, seen
	cmp	r3, #0	@ tmp332,
	beq	.L22		@,
@ Pokedex.c:260: 			DrawIcon(
	ldr	r3, [r7, #60]	@ tmp333, out
	adds	r3, r3, #14	@ _47,
	movs	r2, #128	@ tmp341,
	lsls	r2, r2, #7	@ tmp334, tmp341,
	movs	r1, #170	@,
	movs	r0, r3	@, _47
	ldr	r3, .L24+132	@ tmp335,
	bl	.L13		@
.L22:
@ Pokedex.c:272: 	ObjInsert(0,
	ldr	r3, .L24+136	@ tmp337,
	movs	r2, #101	@ tmp338,
	str	r2, [sp]	@ tmp338,
	movs	r2, #80	@,
	movs	r1, #64	@,
	movs	r0, #0	@,
	ldr	r4, .L24+140	@ tmp339,
	bl	.L26		@
@ Pokedex.c:280:     return ME_NONE;
	movs	r3, #0	@ _114,
@ Pokedex.c:281: }
	movs	r0, r3	@, <retval>
	mov	sp, r7	@,
	add	sp, sp, #72	@,,
	@ sp needed	@
	pop	{r4, r5, r7}
	pop	{r1}
	bx	r1
.L25:
	.align	2
.L24:
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
	.word	DrawIcon
	.word	gObj_8x8
	.word	ObjInsert
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
@ Pokedex.c:290:     struct PokedexProc* proc = (void*) ProcStart(Proc_ChapterPokedex, ROOT_PROC_3);
	ldr	r3, .L34	@ tmp147,
	movs	r1, #3	@,
	movs	r0, r3	@, tmp147
	ldr	r3, .L34+4	@ tmp148,
	bl	.L13		@
	movs	r3, r0	@ tmp149,
	str	r3, [r7, #20]	@ tmp149, proc
@ Pokedex.c:292:     proc->menuIndex = 1;
	ldr	r3, [r7, #20]	@ tmp150, proc
	movs	r2, #48	@ tmp151,
	movs	r1, #1	@ tmp152,
	strb	r1, [r3, r2]	@ tmp153, proc_41->menuIndex
@ Pokedex.c:293: 	proc->TotalCaught = CountCaught();
	ldr	r3, .L34+8	@ tmp154,
	bl	.L13		@
	movs	r3, r0	@ _1,
@ Pokedex.c:293: 	proc->TotalCaught = CountCaught();
	lsls	r3, r3, #24	@ tmp155, _1,
	lsrs	r1, r3, #24	@ _2, tmp155,
	ldr	r3, [r7, #20]	@ tmp156, proc
	movs	r2, #50	@ tmp157,
	strb	r1, [r3, r2]	@ tmp158, proc_41->TotalCaught
@ Pokedex.c:294: 	proc->TotalSeen = CountSeen();
	ldr	r3, .L34+12	@ tmp159,
	bl	.L13		@
	movs	r3, r0	@ _3,
@ Pokedex.c:294: 	proc->TotalSeen = CountSeen();
	lsls	r3, r3, #24	@ tmp160, _3,
	lsrs	r1, r3, #24	@ _4, tmp160,
	ldr	r3, [r7, #20]	@ tmp161, proc
	movs	r2, #49	@ tmp162,
	strb	r1, [r3, r2]	@ tmp163, proc_41->TotalSeen
@ Pokedex.c:296: 	Decompress(WorldMap_img,(void*)0x6008000);
	ldr	r2, .L34+16	@ tmp164,
	ldr	r3, .L34+20	@ tmp165,
	movs	r1, r2	@, tmp164
	movs	r0, r3	@, tmp165
	ldr	r3, .L34+24	@ tmp166,
	bl	.L13		@
@ Pokedex.c:298: 	CopyToPaletteBuffer(WorldMap_pal,0x20*6,(gWorldMapPaletteCount-2)*32);
	ldr	r3, .L34+28	@ tmp167,
	ldrb	r3, [r3]	@ gWorldMapPaletteCount.4_5, gWorldMapPaletteCount
	subs	r3, r3, #2	@ _7,
@ Pokedex.c:298: 	CopyToPaletteBuffer(WorldMap_pal,0x20*6,(gWorldMapPaletteCount-2)*32);
	lsls	r3, r3, #5	@ _8, _7,
@ Pokedex.c:298: 	CopyToPaletteBuffer(WorldMap_pal,0x20*6,(gWorldMapPaletteCount-2)*32);
	movs	r2, r3	@ _9, _8
	ldr	r3, .L34+32	@ tmp168,
	movs	r1, #192	@,
	movs	r0, r3	@, tmp168
	ldr	r3, .L34+36	@ tmp169,
	bl	.L13		@
@ Pokedex.c:299: 	CopyToPaletteBuffer(WorldMap_pal+(gWorldMapPaletteCount-1)*16,0x20*15,32);
	ldr	r3, .L34+28	@ tmp170,
	ldrb	r3, [r3]	@ gWorldMapPaletteCount.5_10, gWorldMapPaletteCount
	subs	r3, r3, #1	@ _12,
@ Pokedex.c:299: 	CopyToPaletteBuffer(WorldMap_pal+(gWorldMapPaletteCount-1)*16,0x20*15,32);
	lsls	r2, r3, #5	@ _14, _13,
@ Pokedex.c:299: 	CopyToPaletteBuffer(WorldMap_pal+(gWorldMapPaletteCount-1)*16,0x20*15,32);
	ldr	r3, .L34+32	@ tmp171,
	adds	r3, r2, r3	@ _15, _14, tmp171
	movs	r2, #240	@ tmp252,
	lsls	r1, r2, #1	@ tmp172, tmp252,
	movs	r2, #32	@,
	movs	r0, r3	@, _15
	ldr	r3, .L34+36	@ tmp173,
	bl	.L13		@
@ Pokedex.c:301: 	memcpy(gGenericBuffer, WorldMap_tsa, 0x4B2);
	ldr	r2, .L34+40	@ tmp174,
	ldr	r1, .L34+44	@ tmp175,
	ldr	r3, .L34+48	@ tmp176,
	movs	r0, r3	@, tmp176
	ldr	r3, .L34+52	@ tmp177,
	bl	.L13		@
@ Pokedex.c:303: 	TSA* tsaBuffer = (TSA*)gGenericBuffer;
	ldr	r3, .L34+48	@ tmp178,
	str	r3, [r7, #16]	@ tmp178, tsaBuffer
@ Pokedex.c:304: 	for ( int i = 0 ; i < tsaBuffer->height+1 ; i++ )
	movs	r3, #0	@ tmp179,
	str	r3, [r7, #28]	@ tmp179, i
@ Pokedex.c:304: 	for ( int i = 0 ; i < tsaBuffer->height+1 ; i++ )
	b	.L28		@
.L32:
@ Pokedex.c:306: 		for ( int j = 0 ; j < tsaBuffer->width+1 ; j++ )
	movs	r3, #0	@ tmp180,
	str	r3, [r7, #24]	@ tmp180, j
@ Pokedex.c:306: 		for ( int j = 0 ; j < tsaBuffer->width+1 ; j++ )
	b	.L29		@
.L31:
@ Pokedex.c:308: 			if ( tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID == 16-6 )
	ldr	r3, [r7, #16]	@ tmp181, tsaBuffer
	ldrb	r3, [r3]	@ _16, *tsaBuffer_51
@ Pokedex.c:308: 			if ( tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID == 16-6 )
	adds	r3, r3, #1	@ _18,
@ Pokedex.c:308: 			if ( tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID == 16-6 )
	ldr	r2, [r7, #28]	@ tmp182, i
	muls	r2, r3	@ _19, _18
@ Pokedex.c:308: 			if ( tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID == 16-6 )
	ldr	r3, [r7, #24]	@ tmp183, j
	adds	r3, r2, r3	@ _20, _19, tmp183
@ Pokedex.c:308: 			if ( tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID == 16-6 )
	ldr	r2, [r7, #16]	@ tmp184, tsaBuffer
	lsls	r3, r3, #1	@ tmp185, _20,
	adds	r3, r2, r3	@ tmp188, tmp184, tmp185
	ldrb	r3, [r3, #3]	@ tmp189,
	lsls	r3, r3, #24	@ tmp191, tmp189,
	lsrs	r3, r3, #28	@ tmp190, tmp191,
	lsls	r3, r3, #24	@ tmp192, tmp190,
	lsrs	r3, r3, #24	@ _21, tmp192,
@ Pokedex.c:308: 			if ( tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID == 16-6 )
	cmp	r3, #10	@ _21,
	bne	.L30		@,
@ Pokedex.c:310: 				tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID--;
	ldr	r3, [r7, #16]	@ tmp193, tsaBuffer
	ldrb	r3, [r3]	@ _22, *tsaBuffer_51
@ Pokedex.c:310: 				tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID--;
	adds	r3, r3, #1	@ _24,
@ Pokedex.c:310: 				tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID--;
	ldr	r2, [r7, #28]	@ tmp194, i
	muls	r2, r3	@ _25, _24
@ Pokedex.c:310: 				tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID--;
	ldr	r3, [r7, #24]	@ tmp195, j
	adds	r3, r2, r3	@ _26, _25, tmp195
@ Pokedex.c:310: 				tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID--;
	ldr	r1, [r7, #16]	@ tmp196, tsaBuffer
	lsls	r2, r3, #1	@ tmp197, _26,
	adds	r2, r1, r2	@ tmp200, tmp196, tmp197
	ldrb	r2, [r2, #3]	@ tmp201,
	lsls	r2, r2, #24	@ tmp203, tmp201,
	lsrs	r2, r2, #28	@ tmp202, tmp203,
	lsls	r2, r2, #24	@ tmp204, tmp202,
	lsrs	r2, r2, #24	@ _27, tmp204,
@ Pokedex.c:310: 				tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID--;
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
.L30:
@ Pokedex.c:306: 		for ( int j = 0 ; j < tsaBuffer->width+1 ; j++ )
	ldr	r3, [r7, #24]	@ tmp223, j
	adds	r3, r3, #1	@ tmp222,
	str	r3, [r7, #24]	@ tmp222, j
.L29:
@ Pokedex.c:306: 		for ( int j = 0 ; j < tsaBuffer->width+1 ; j++ )
	ldr	r3, [r7, #16]	@ tmp224, tsaBuffer
	ldrb	r3, [r3]	@ _30, *tsaBuffer_51
	movs	r2, r3	@ _31, _30
@ Pokedex.c:306: 		for ( int j = 0 ; j < tsaBuffer->width+1 ; j++ )
	ldr	r3, [r7, #24]	@ tmp225, j
	cmp	r3, r2	@ tmp225, _31
	ble	.L31		@,
@ Pokedex.c:304: 	for ( int i = 0 ; i < tsaBuffer->height+1 ; i++ )
	ldr	r3, [r7, #28]	@ tmp227, i
	adds	r3, r3, #1	@ tmp226,
	str	r3, [r7, #28]	@ tmp226, i
.L28:
@ Pokedex.c:304: 	for ( int i = 0 ; i < tsaBuffer->height+1 ; i++ )
	ldr	r3, [r7, #16]	@ tmp228, tsaBuffer
	ldrb	r3, [r3, #1]	@ _32,
	movs	r2, r3	@ _33, _32
@ Pokedex.c:304: 	for ( int i = 0 ; i < tsaBuffer->height+1 ; i++ )
	ldr	r3, [r7, #28]	@ tmp229, i
	cmp	r3, r2	@ tmp229, _33
	ble	.L32		@,
@ Pokedex.c:314: 	BgMap_ApplyTsa(gBg3MapBuffer,gGenericBuffer, 6<<12);
	movs	r3, #192	@ tmp250,
	lsls	r2, r3, #7	@ tmp230, tmp250,
	ldr	r1, .L34+48	@ tmp231,
	ldr	r3, .L34+56	@ tmp232,
	movs	r0, r3	@, tmp232
	ldr	r3, .L34+60	@ tmp233,
	bl	.L13		@
@ Pokedex.c:315: 	SetBgTileDataOffset(2,0x8000);
	movs	r3, #128	@ tmp251,
	lsls	r3, r3, #8	@ tmp234, tmp251,
	movs	r1, r3	@, tmp234
	movs	r0, #2	@,
	ldr	r3, .L34+64	@ tmp235,
	bl	.L13		@
@ Pokedex.c:317: 	struct LCDIOBuffer* LCDIOBuffer = &gLCDIOBuffer;
	ldr	r3, .L34+68	@ tmp236,
	str	r3, [r7, #12]	@ tmp236, LCDIOBuffer
@ Pokedex.c:318: 	LCDIOBuffer->bgOffset[3].x = 0; // make offset as 0, rather than scrolled to the right
	ldr	r3, [r7, #12]	@ tmp237, LCDIOBuffer
	movs	r2, #0	@ tmp238,
	strh	r2, [r3, #40]	@ tmp239, LCDIOBuffer_55->bgOffset[3].x
@ Pokedex.c:319: 	LCDIOBuffer->bgOffset[3].y = 0; 
	ldr	r3, [r7, #12]	@ tmp240, LCDIOBuffer
	movs	r2, #0	@ tmp241,
	strh	r2, [r3, #42]	@ tmp242, LCDIOBuffer_55->bgOffset[3].y
@ Pokedex.c:323: 	LoadIconPalettes(4);
	movs	r0, #4	@,
	ldr	r3, .L34+72	@ tmp243,
	bl	.L13		@
@ Pokedex.c:324: 	EnableBgSyncByMask(BG_SYNC_BIT(3)); // sync bg 3 
	movs	r0, #8	@,
	ldr	r3, .L34+76	@ tmp244,
	bl	.L13		@
@ Pokedex.c:325: 	EnablePaletteSync();
	ldr	r3, .L34+80	@ tmp245,
	bl	.L13		@
@ Pokedex.c:328:     StartMenuChild(&Menu_Pokedex, (void*) proc);
	ldr	r2, [r7, #20]	@ tmp246, proc
	ldr	r3, .L34+84	@ tmp247,
	movs	r1, r2	@, tmp246
	movs	r0, r3	@, tmp247
	ldr	r3, .L34+88	@ tmp248,
	bl	.L13		@
@ Pokedex.c:330:     return ME_DISABLE | ME_END | ME_PLAY_BEEP | ME_CLEAR_GFX;
	movs	r3, #23	@ _62,
@ Pokedex.c:331: }
	movs	r0, r3	@, <retval>
	mov	sp, r7	@,
	add	sp, sp, #32	@,,
	@ sp needed	@
	pop	{r7}
	pop	{r1}
	bx	r1
.L35:
	.align	2
.L34:
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
@ Pokedex.c:335:     command->onCycle = (void*) PokedexDrawIdle(menu, command);
	ldr	r2, [r7]	@ tmp115, command
	ldr	r3, [r7, #4]	@ tmp116, menu
	movs	r1, r2	@, tmp115
	movs	r0, r3	@, tmp116
	bl	PokedexDrawIdle		@
	movs	r3, r0	@ _1,
@ Pokedex.c:335:     command->onCycle = (void*) PokedexDrawIdle(menu, command);
	movs	r2, r3	@ _2, _1
@ Pokedex.c:335:     command->onCycle = (void*) PokedexDrawIdle(menu, command);
	ldr	r3, [r7]	@ tmp117, command
	str	r2, [r3, #12]	@ _2, command_5(D)->onCycle
@ Pokedex.c:336: }
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
@ Pokedex.c:340: 	EndFaceById(0);
	movs	r0, #0	@,
	ldr	r3, .L39	@ tmp113,
	bl	.L13		@
@ Pokedex.c:341:     return;
	nop	
@ Pokedex.c:342: }
	mov	sp, r7	@,
	add	sp, sp, #8	@,,
	@ sp needed	@
	pop	{r7}
	pop	{r0}
	bx	r0
.L40:
	.align	2
.L39:
	.word	EndFaceById
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
@ Pokedex.c:369: 	for (u16 i = 0 ; i <= 0x80 ; i++) 
	movs	r3, #22	@ tmp257,
	adds	r3, r7, r3	@ tmp149,, tmp257
	movs	r2, #0	@ tmp150,
	strh	r2, [r3]	@ tmp151, i
@ Pokedex.c:369: 	for (u16 i = 0 ; i <= 0x80 ; i++) 
	b	.L42		@
.L45:
@ Pokedex.c:371: 		u8 Chapter = MonsterSpawnTable[i].ChID;
	movs	r4, #22	@ tmp258,
	adds	r3, r7, r4	@ tmp152,, tmp258
	ldrh	r2, [r3]	@ _1, i
@ Pokedex.c:371: 		u8 Chapter = MonsterSpawnTable[i].ChID;
	movs	r6, #21	@ tmp259,
	adds	r1, r7, r6	@ tmp153,, tmp259
	ldr	r0, .L47	@ tmp154,
	movs	r3, r2	@ tmp155, _1
	lsls	r3, r3, #1	@ tmp155, tmp155,
	adds	r3, r3, r2	@ tmp155, tmp155, _1
	lsls	r3, r3, #2	@ tmp156, tmp155,
	adds	r3, r0, r3	@ tmp157, tmp154, tmp155
	adds	r3, r3, #10	@ tmp158,
	ldrb	r3, [r3]	@ tmp159, MonsterSpawnTable
	strb	r3, [r1]	@ tmp159, Chapter
@ Pokedex.c:372: 		if (Chapter)
	adds	r3, r7, r6	@ tmp160,, tmp260
	ldrb	r3, [r3]	@ tmp161, Chapter
	cmp	r3, #0	@ tmp161,
	bne	.LCB1010	@
	b	.L43	@long jump	@
.LCB1010:
@ Pokedex.c:375: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	adds	r3, r7, r4	@ tmp162,, tmp261
	ldrh	r2, [r3]	@ _2, i
	ldr	r1, .L47	@ tmp163,
	movs	r3, r2	@ tmp164, _2
	lsls	r3, r3, #1	@ tmp164, tmp164,
	adds	r3, r3, r2	@ tmp164, tmp164, _2
	lsls	r3, r3, #2	@ tmp165, tmp164,
	ldrb	r3, [r3, r1]	@ _3, MonsterSpawnTable
@ Pokedex.c:375: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	movs	r5, #15	@ tmp262,
	adds	r2, r7, r5	@ tmp166,, tmp262
	ldrb	r2, [r2]	@ tmp168, classID
	subs	r3, r2, r3	@ tmp170, tmp168, _3
	rsbs	r2, r3, #0	@ tmp171, tmp170
	adcs	r3, r3, r2	@ tmp169, tmp170, tmp171
	lsls	r3, r3, #24	@ tmp172, tmp167,
	lsrs	r1, r3, #24	@ _4, tmp172,
@ Pokedex.c:375: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	adds	r3, r7, r4	@ tmp173,, tmp263
	ldrh	r2, [r3]	@ _5, i
	ldr	r0, .L47	@ tmp174,
	movs	r3, r2	@ tmp175, _5
	lsls	r3, r3, #1	@ tmp175, tmp175,
	adds	r3, r3, r2	@ tmp175, tmp175, _5
	lsls	r3, r3, #2	@ tmp176, tmp175,
	adds	r3, r0, r3	@ tmp177, tmp174, tmp175
	adds	r3, r3, #1	@ tmp178,
	ldrb	r3, [r3]	@ _6, MonsterSpawnTable
@ Pokedex.c:375: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
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
@ Pokedex.c:375: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	adds	r3, r7, r4	@ tmp188,, tmp265
	ldrh	r2, [r3]	@ _10, i
	ldr	r1, .L47	@ tmp189,
	movs	r3, r2	@ tmp190, _10
	lsls	r3, r3, #1	@ tmp190, tmp190,
	adds	r3, r3, r2	@ tmp190, tmp190, _10
	lsls	r3, r3, #2	@ tmp191, tmp190,
	adds	r3, r1, r3	@ tmp192, tmp189, tmp190
	adds	r3, r3, #2	@ tmp193,
	ldrb	r3, [r3]	@ _11, MonsterSpawnTable
@ Pokedex.c:375: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	adds	r2, r7, r5	@ tmp194,, tmp266
	ldrb	r2, [r2]	@ tmp196, classID
	subs	r3, r2, r3	@ tmp198, tmp196, _11
	rsbs	r2, r3, #0	@ tmp199, tmp198
	adcs	r3, r3, r2	@ tmp197, tmp198, tmp199
	lsls	r3, r3, #24	@ tmp200, tmp195,
	lsrs	r3, r3, #24	@ _12, tmp200,
@ Pokedex.c:375: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	movs	r1, r0	@ _9, _9
	orrs	r1, r3	@ _9, _13
@ Pokedex.c:375: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	adds	r3, r7, r4	@ tmp201,, tmp268
	ldrh	r2, [r3]	@ _15, i
	ldr	r0, .L47	@ tmp202,
	movs	r3, r2	@ tmp203, _15
	lsls	r3, r3, #1	@ tmp203, tmp203,
	adds	r3, r3, r2	@ tmp203, tmp203, _15
	lsls	r3, r3, #2	@ tmp204, tmp203,
	adds	r3, r0, r3	@ tmp205, tmp202, tmp203
	adds	r3, r3, #3	@ tmp206,
	ldrb	r3, [r3]	@ _16, MonsterSpawnTable
@ Pokedex.c:375: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	adds	r2, r7, r5	@ tmp207,, tmp269
	ldrb	r2, [r2]	@ tmp209, classID
	subs	r3, r2, r3	@ tmp211, tmp209, _16
	rsbs	r2, r3, #0	@ tmp212, tmp211
	adcs	r3, r3, r2	@ tmp210, tmp211, tmp212
	lsls	r3, r3, #24	@ tmp213, tmp208,
	lsrs	r3, r3, #24	@ _17, tmp213,
@ Pokedex.c:375: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	orrs	r1, r3	@ _19, _18
@ Pokedex.c:375: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	adds	r3, r7, r4	@ tmp214,, tmp270
	ldrh	r2, [r3]	@ _20, i
	ldr	r0, .L47	@ tmp215,
	movs	r3, r2	@ tmp216, _20
	lsls	r3, r3, #1	@ tmp216, tmp216,
	adds	r3, r3, r2	@ tmp216, tmp216, _20
	lsls	r3, r3, #2	@ tmp217, tmp216,
	adds	r3, r0, r3	@ tmp218, tmp215, tmp216
	adds	r3, r3, #4	@ tmp219,
	ldrb	r3, [r3]	@ _21, MonsterSpawnTable
@ Pokedex.c:375: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	adds	r2, r7, r5	@ tmp220,, tmp271
	ldrb	r2, [r2]	@ tmp222, classID
	subs	r3, r2, r3	@ tmp224, tmp222, _21
	rsbs	r2, r3, #0	@ tmp225, tmp224
	adcs	r3, r3, r2	@ tmp223, tmp224, tmp225
	lsls	r3, r3, #24	@ tmp226, tmp221,
	lsrs	r3, r3, #24	@ _22, tmp226,
@ Pokedex.c:375: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	orrs	r3, r1	@ _24, _19
@ Pokedex.c:375: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	beq	.L43		@,
@ Pokedex.c:377: 				if (Chapter <= 63)
	adds	r3, r7, r6	@ tmp227,, tmp272
	ldrb	r3, [r3]	@ tmp230, Chapter
	cmp	r3, #63	@ tmp230,
	bhi	.L44		@,
@ Pokedex.c:381: 					*areaBitfield_A = *areaBitfield_A | 1<<Chapter;
	ldr	r3, [r7, #8]	@ tmp231, areaBitfield_A
	ldr	r2, [r3]	@ _25, *areaBitfield_A_42(D)
@ Pokedex.c:381: 					*areaBitfield_A = *areaBitfield_A | 1<<Chapter;
	adds	r3, r7, r6	@ tmp232,, tmp273
	ldrb	r3, [r3]	@ _26, Chapter
	movs	r1, #1	@ tmp233,
	lsls	r1, r1, r3	@ tmp233, tmp233, _26
	movs	r3, r1	@ _27, tmp233
@ Pokedex.c:381: 					*areaBitfield_A = *areaBitfield_A | 1<<Chapter;
	orrs	r2, r3	@ _28, _27
@ Pokedex.c:381: 					*areaBitfield_A = *areaBitfield_A | 1<<Chapter;
	ldr	r3, [r7, #8]	@ tmp234, areaBitfield_A
	str	r2, [r3]	@ _28, *areaBitfield_A_42(D)
.L44:
@ Pokedex.c:383: 				if ((Chapter > 63) && (Chapter < 127))
	movs	r1, #21	@ tmp275,
	adds	r3, r7, r1	@ tmp235,, tmp275
	ldrb	r3, [r3]	@ tmp238, Chapter
	cmp	r3, #63	@ tmp238,
	bls	.L43		@,
@ Pokedex.c:383: 				if ((Chapter > 63) && (Chapter < 127))
	adds	r3, r7, r1	@ tmp239,, tmp276
	ldrb	r3, [r3]	@ tmp242, Chapter
	cmp	r3, #126	@ tmp242,
	bhi	.L43		@,
@ Pokedex.c:385: 					*areaBitfield_B = *areaBitfield_B | 1<<Chapter;
	ldr	r3, [r7, #4]	@ tmp243, areaBitfield_B
	ldr	r2, [r3]	@ _29, *areaBitfield_B_44(D)
@ Pokedex.c:385: 					*areaBitfield_B = *areaBitfield_B | 1<<Chapter;
	adds	r3, r7, r1	@ tmp244,, tmp277
	ldrb	r3, [r3]	@ _30, Chapter
	movs	r1, #1	@ tmp245,
	lsls	r1, r1, r3	@ tmp245, tmp245, _30
	movs	r3, r1	@ _31, tmp245
@ Pokedex.c:385: 					*areaBitfield_B = *areaBitfield_B | 1<<Chapter;
	orrs	r2, r3	@ _32, _31
@ Pokedex.c:385: 					*areaBitfield_B = *areaBitfield_B | 1<<Chapter;
	ldr	r3, [r7, #4]	@ tmp246, areaBitfield_B
	str	r2, [r3]	@ _32, *areaBitfield_B_44(D)
.L43:
@ Pokedex.c:369: 	for (u16 i = 0 ; i <= 0x80 ; i++) 
	movs	r1, #22	@ tmp279,
	adds	r3, r7, r1	@ tmp247,, tmp279
	ldrh	r2, [r3]	@ i.6_33, i
	adds	r3, r7, r1	@ tmp248,, tmp280
	adds	r2, r2, #1	@ tmp249,
	strh	r2, [r3]	@ tmp250, i
.L42:
@ Pokedex.c:369: 	for (u16 i = 0 ; i <= 0x80 ; i++) 
	movs	r3, #22	@ tmp281,
	adds	r3, r7, r3	@ tmp251,, tmp281
	ldrh	r3, [r3]	@ tmp254, i
	cmp	r3, #128	@ tmp254,
	bhi	.LCB1163	@
	b	.L45	@long jump	@
.LCB1163:
@ Pokedex.c:390: 	return;
	nop	
@ Pokedex.c:391: }
	mov	sp, r7	@,
	add	sp, sp, #28	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L48:
	.align	2
.L47:
	.word	MonsterSpawnTable
	.size	Pokedex_RetrieveAreasFound, .-Pokedex_RetrieveAreasFound
	.ident	"GCC: (devkitARM release 56) 11.1.0"
	.code 16
	.align	1
.L13:
	bx	r3
.L26:
	bx	r4
