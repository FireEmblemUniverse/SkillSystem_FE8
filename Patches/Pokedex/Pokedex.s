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
.LC18:
	.ascii	"???\000"
	.align	2
.LC22:
	.ascii	" Seen\000"
	.align	2
.LC24:
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
	@ args = 0, pretend = 0, frame = 64
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r7, lr}	@
	sub	sp, sp, #76	@,,
	add	r7, sp, #8	@,,
	str	r0, [r7, #4]	@ menu, menu
	str	r1, [r7]	@ command, command
@ Pokedex.c:161:     struct PokedexProc* const proc = (void*) menu->parent;
	ldr	r3, [r7, #4]	@ tmp164, menu
	ldr	r3, [r3, #20]	@ tmp165, menu_56(D)->parent
	str	r3, [r7, #56]	@ tmp165, proc
@ Pokedex.c:162:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldr	r3, [r7]	@ tmp166, command
	ldrh	r3, [r3, #44]	@ _1,
	lsls	r3, r3, #5	@ _3, _2,
	ldr	r2, [r7]	@ tmp167, command
	ldrh	r2, [r2, #42]	@ _4,
	adds	r3, r3, r2	@ _6, _3, _5
@ Pokedex.c:162:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r2, r3, #1	@ _8, _7,
@ Pokedex.c:162:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldr	r3, .L24	@ tmp169,
	adds	r3, r2, r3	@ tmp168, _8, tmp169
	str	r3, [r7, #52]	@ tmp168, out
@ Pokedex.c:164: 	int* areaBitfield_A = &proc->areaBitfield_A;
	ldr	r3, [r7, #56]	@ tmp171, proc
	adds	r3, r3, #52	@ tmp170,
	str	r3, [r7, #48]	@ tmp170, areaBitfield_A
@ Pokedex.c:165: 	int* areaBitfield_B = &proc->areaBitfield_B;
	ldr	r3, [r7, #56]	@ tmp173, proc
	adds	r3, r3, #56	@ tmp172,
	str	r3, [r7, #44]	@ tmp172, areaBitfield_B
@ Pokedex.c:166: 	*areaBitfield_A = 0;
	ldr	r3, [r7, #48]	@ tmp174, areaBitfield_A
	movs	r2, #0	@ tmp175,
	str	r2, [r3]	@ tmp175, *areaBitfield_A_60
@ Pokedex.c:167: 	*areaBitfield_B = 0;
	ldr	r3, [r7, #44]	@ tmp176, areaBitfield_B
	movs	r2, #0	@ tmp177,
	str	r2, [r3]	@ tmp177, *areaBitfield_B_61
@ Pokedex.c:168: 	proc->areaBitfield_A = 0;
	ldr	r3, [r7, #56]	@ tmp178, proc
	movs	r2, #0	@ tmp179,
	str	r2, [r3, #52]	@ tmp179, proc_57->areaBitfield_A
@ Pokedex.c:169: 	proc->areaBitfield_B = 0;
	ldr	r3, [r7, #56]	@ tmp180, proc
	movs	r2, #0	@ tmp181,
	str	r2, [r3, #56]	@ tmp181, proc_57->areaBitfield_B
@ Pokedex.c:172: 	const struct ClassData* ClassData = GetClassData(proc->menuIndex);
	ldr	r3, [r7, #56]	@ tmp182, proc
	movs	r2, #48	@ tmp183,
	ldrb	r3, [r3, r2]	@ _9,
	movs	r0, r3	@, _9
	ldr	r3, .L24+4	@ tmp184,
	bl	.L13		@
	movs	r3, r0	@ tmp185,
	str	r3, [r7, #40]	@ tmp185, ClassData
@ Pokedex.c:173: 	u16 title = 0;
	movs	r4, #62	@ tmp328,
	adds	r3, r7, r4	@ tmp186,, tmp328
	movs	r2, #0	@ tmp187,
	strh	r2, [r3]	@ tmp188, title
@ Pokedex.c:174:     Text_Clear(&command->text);
	ldr	r3, [r7]	@ tmp189, command
	adds	r3, r3, #52	@ _10,
	movs	r0, r3	@, _10
	ldr	r3, .L24+8	@ tmp190,
	bl	.L13		@
@ Pokedex.c:175: 	Text_ResetTileAllocation(); // 0x08003D20
	ldr	r3, .L24+12	@ tmp191,
	bl	.L13		@
@ Pokedex.c:178: 	Pokedex_RetrieveAreasFound(proc->menuIndex, areaBitfield_A, areaBitfield_B);
	ldr	r3, [r7, #56]	@ tmp192, proc
	movs	r2, #48	@ tmp193,
	ldrb	r3, [r3, r2]	@ _11,
	ldr	r2, [r7, #44]	@ tmp194, areaBitfield_B
	ldr	r1, [r7, #48]	@ tmp195, areaBitfield_A
	movs	r0, r3	@, _11
	bl	Pokedex_RetrieveAreasFound		@
@ Pokedex.c:182: 	if (proc->menuIndex)
	ldr	r3, [r7, #56]	@ tmp196, proc
	movs	r2, #48	@ tmp197,
	ldrb	r3, [r3, r2]	@ _12,
@ Pokedex.c:182: 	if (proc->menuIndex)
	cmp	r3, #0	@ _12,
	beq	.L18		@,
@ Pokedex.c:184: 		if (proc->areaBitfield_A)
	ldr	r3, [r7, #56]	@ tmp198, proc
	ldr	r3, [r3, #52]	@ _13, proc_57->areaBitfield_A
@ Pokedex.c:184: 		if (proc->areaBitfield_A)
	cmp	r3, #0	@ _13,
	beq	.L18		@,
@ Pokedex.c:186: 			title = ClassData->nameTextId;
	movs	r1, r4	@ tmp329, tmp328
	adds	r3, r7, r1	@ tmp199,, tmp329
	ldr	r2, [r7, #40]	@ tmp200, ClassData
	ldrh	r2, [r2]	@ tmp201, *ClassData_67
	strh	r2, [r3]	@ tmp201, title
@ Pokedex.c:187: 			Text_DrawString(&command->text, GetStringFromIndex(title));
	ldr	r3, [r7]	@ tmp202, command
	adds	r3, r3, #52	@ tmp202,
	movs	r4, r3	@ _14, tmp202
@ Pokedex.c:187: 			Text_DrawString(&command->text, GetStringFromIndex(title));
	adds	r3, r7, r1	@ tmp203,, tmp331
	ldrh	r3, [r3]	@ _15, title
	movs	r0, r3	@, _15
	ldr	r3, .L24+16	@ tmp204,
	bl	.L13		@
	movs	r3, r0	@ _16,
@ Pokedex.c:187: 			Text_DrawString(&command->text, GetStringFromIndex(title));
	movs	r1, r3	@, _16
	movs	r0, r4	@, _14
	ldr	r3, .L24+20	@ tmp205,
	bl	.L13		@
@ Pokedex.c:188: 			Text_Display(&command->text, out); // Class name 
	ldr	r3, [r7]	@ tmp206, command
	adds	r3, r3, #52	@ _17,
	ldr	r2, [r7, #52]	@ tmp207, out
	movs	r1, r2	@, tmp207
	movs	r0, r3	@, _17
	ldr	r3, .L24+24	@ tmp208,
	bl	.L13		@
.L18:
@ Pokedex.c:193:     Text_SetColorId(&command->text, TEXT_COLOR_NORMAL);
	ldr	r3, [r7]	@ tmp209, command
	adds	r3, r3, #52	@ _18,
	movs	r1, #0	@,
	movs	r0, r3	@, _18
	ldr	r3, .L24+28	@ tmp210,
	bl	.L13		@
@ Pokedex.c:194:     if (!title) {
	movs	r3, #62	@ tmp332,
	adds	r3, r7, r3	@ tmp211,, tmp332
	ldrh	r3, [r3]	@ tmp212, title
	cmp	r3, #0	@ tmp212,
	bne	.L19		@,
@ Pokedex.c:195: 		Text_SetXCursor(&command->text, 0xC);
	ldr	r3, [r7]	@ tmp213, command
	adds	r3, r3, #52	@ _19,
	movs	r1, #12	@,
	movs	r0, r3	@, _19
	ldr	r3, .L24+32	@ tmp214,
	bl	.L13		@
@ Pokedex.c:196: 		Text_DrawString(&command->text, "???");
	ldr	r3, [r7]	@ tmp215, command
	adds	r3, r3, #52	@ _20,
	ldr	r2, .L24+36	@ tmp216,
	movs	r1, r2	@, tmp216
	movs	r0, r3	@, _20
	ldr	r3, .L24+20	@ tmp217,
	bl	.L13		@
@ Pokedex.c:198: 		Text_Display(&command->text, out); // Class name 
	ldr	r3, [r7]	@ tmp218, command
	adds	r3, r3, #52	@ _21,
	ldr	r2, [r7, #52]	@ tmp219, out
	movs	r1, r2	@, tmp219
	movs	r0, r3	@, _21
	ldr	r3, .L24+24	@ tmp220,
	bl	.L13		@
.L19:
@ Pokedex.c:205: 	int tile = 40;
	movs	r3, #40	@ tmp221,
	str	r3, [r7, #36]	@ tmp221, tile
@ Pokedex.c:207: 	TextHandle caughtNameHandle = {
	movs	r4, #16	@ tmp333,
	adds	r3, r7, r4	@ tmp222,, tmp333
	movs	r0, r3	@ tmp223, tmp222
	movs	r3, #8	@ tmp224,
	movs	r2, r3	@, tmp224
	movs	r1, #0	@,
	ldr	r3, .L24+40	@ tmp225,
	bl	.L13		@
@ Pokedex.c:208: 		.tileIndexOffset = gpCurrentFont->tileNext+tile,
	ldr	r3, .L24+44	@ tmp228,
	ldr	r3, [r3]	@ gpCurrentFont.0_22, gpCurrentFont
	ldrh	r2, [r3, #18]	@ _23,
@ Pokedex.c:208: 		.tileIndexOffset = gpCurrentFont->tileNext+tile,
	ldr	r3, [r7, #36]	@ tmp230, tile
	lsls	r3, r3, #16	@ tmp231, tmp229,
	lsrs	r3, r3, #16	@ _24, tmp231,
	adds	r3, r2, r3	@ tmp232, _23, _24
	lsls	r3, r3, #16	@ tmp233, tmp232,
	lsrs	r2, r3, #16	@ _25, tmp233,
@ Pokedex.c:207: 	TextHandle caughtNameHandle = {
	adds	r3, r7, r4	@ tmp234,, tmp334
	strh	r2, [r3]	@ tmp235, caughtNameHandle.tileIndexOffset
	adds	r3, r7, r4	@ tmp236,, tmp335
	movs	r2, #4	@ tmp237,
	strb	r2, [r3, #4]	@ tmp238, caughtNameHandle.tileWidth
@ Pokedex.c:211: 	tile += 4;
	ldr	r3, [r7, #36]	@ tmp240, tile
	adds	r3, r3, #4	@ tmp239,
	str	r3, [r7, #36]	@ tmp239, tile
@ Pokedex.c:212: 	DrawRawText(caughtNameHandle," Seen",1,1);
	ldr	r2, .L24+48	@ tmp241,
	adds	r1, r7, r4	@ tmp242,, tmp336
	movs	r3, #1	@ tmp243,
	str	r3, [sp]	@ tmp243,
	movs	r3, #1	@,
	ldr	r0, [r1]	@, caughtNameHandle
	ldr	r1, [r1, #4]	@, caughtNameHandle
	bl	DrawRawText		@
@ Pokedex.c:214: 	TextHandle seenNameHandle = {
	movs	r4, #8	@ tmp337,
	adds	r3, r7, r4	@ tmp244,, tmp337
	movs	r0, r3	@ tmp245, tmp244
	movs	r3, #8	@ tmp246,
	movs	r2, r3	@, tmp246
	movs	r1, #0	@,
	ldr	r3, .L24+40	@ tmp247,
	bl	.L13		@
@ Pokedex.c:215: 		.tileIndexOffset = gpCurrentFont->tileNext+tile,
	ldr	r3, .L24+44	@ tmp250,
	ldr	r3, [r3]	@ gpCurrentFont.1_26, gpCurrentFont
	ldrh	r2, [r3, #18]	@ _27,
@ Pokedex.c:215: 		.tileIndexOffset = gpCurrentFont->tileNext+tile,
	ldr	r3, [r7, #36]	@ tmp252, tile
	lsls	r3, r3, #16	@ tmp253, tmp251,
	lsrs	r3, r3, #16	@ _28, tmp253,
	adds	r3, r2, r3	@ tmp254, _27, _28
	lsls	r3, r3, #16	@ tmp255, tmp254,
	lsrs	r2, r3, #16	@ _29, tmp255,
@ Pokedex.c:214: 	TextHandle seenNameHandle = {
	adds	r3, r7, r4	@ tmp256,, tmp338
	strh	r2, [r3]	@ tmp257, seenNameHandle.tileIndexOffset
	adds	r3, r7, r4	@ tmp258,, tmp339
	movs	r2, #5	@ tmp259,
	strb	r2, [r3, #4]	@ tmp260, seenNameHandle.tileWidth
@ Pokedex.c:218: 	tile += 5;
	ldr	r3, [r7, #36]	@ tmp262, tile
	adds	r3, r3, #5	@ tmp261,
	str	r3, [r7, #36]	@ tmp261, tile
@ Pokedex.c:219: 	DrawRawText(seenNameHandle," Caught",1,3);
	ldr	r2, .L24+52	@ tmp263,
	adds	r1, r7, r4	@ tmp264,, tmp340
	movs	r3, #3	@ tmp265,
	str	r3, [sp]	@ tmp265,
	movs	r3, #1	@,
	ldr	r0, [r1]	@, seenNameHandle
	ldr	r1, [r1, #4]	@, seenNameHandle
	bl	DrawRawText		@
@ Pokedex.c:222: 	DrawUiNumber(&gBG0MapBuffer[1][7],TEXT_COLOR_GOLD,  proc->TotalSeen); 
	ldr	r3, [r7, #56]	@ tmp266, proc
	movs	r2, #49	@ tmp267,
	ldrb	r3, [r3, r2]	@ _30,
@ Pokedex.c:222: 	DrawUiNumber(&gBG0MapBuffer[1][7],TEXT_COLOR_GOLD,  proc->TotalSeen); 
	movs	r2, r3	@ _31, _30
	ldr	r3, .L24+56	@ tmp268,
	movs	r1, #3	@,
	movs	r0, r3	@, tmp268
	ldr	r3, .L24+60	@ tmp269,
	bl	.L13		@
@ Pokedex.c:224: 	DrawUiNumber(&gBG0MapBuffer[3][7],TEXT_COLOR_GOLD,  proc->TotalCaught);
	ldr	r3, [r7, #56]	@ tmp270, proc
	movs	r2, #50	@ tmp271,
	ldrb	r3, [r3, r2]	@ _32,
@ Pokedex.c:224: 	DrawUiNumber(&gBG0MapBuffer[3][7],TEXT_COLOR_GOLD,  proc->TotalCaught);
	movs	r2, r3	@ _33, _32
	ldr	r3, .L24+64	@ tmp272,
	movs	r1, #3	@,
	movs	r0, r3	@, tmp272
	ldr	r3, .L24+60	@ tmp273,
	bl	.L13		@
@ Pokedex.c:225: 	Text_Display(&command->text,out);
	ldr	r3, [r7]	@ tmp274, command
	adds	r3, r3, #52	@ _34,
	ldr	r2, [r7, #52]	@ tmp275, out
	movs	r1, r2	@, tmp275
	movs	r0, r3	@, _34
	ldr	r3, .L24+24	@ tmp276,
	bl	.L13		@
@ Pokedex.c:226: 	Text_Display(&command->text,out);
	ldr	r3, [r7]	@ tmp277, command
	adds	r3, r3, #52	@ _35,
	ldr	r2, [r7, #52]	@ tmp278, out
	movs	r1, r2	@, tmp278
	movs	r0, r3	@, _35
	ldr	r3, .L24+24	@ tmp279,
	bl	.L13		@
@ Pokedex.c:228: 	BgMap_ApplyTsa(&gBG1MapBuffer[0][0], &PokedexSeenCaughtBox, 0);
	ldr	r1, .L24+68	@ tmp280,
	ldr	r3, .L24+72	@ tmp281,
	movs	r2, #0	@,
	movs	r0, r3	@, tmp281
	ldr	r3, .L24+76	@ tmp282,
	bl	.L13		@
@ Pokedex.c:229: 	EndFaceById(0);
	movs	r0, #0	@,
	ldr	r3, .L24+80	@ tmp283,
	bl	.L13		@
@ Pokedex.c:230: 	struct FaceProc* FaceProc = StartFace(0, ClassData->defaultPortraitId, 200, 4, 3);
	ldr	r3, [r7, #40]	@ tmp284, ClassData
	ldrh	r3, [r3, #8]	@ _36,
@ Pokedex.c:230: 	struct FaceProc* FaceProc = StartFace(0, ClassData->defaultPortraitId, 200, 4, 3);
	movs	r1, r3	@ _37, _36
	movs	r3, #3	@ tmp285,
	str	r3, [sp]	@ tmp285,
	movs	r3, #4	@,
	movs	r2, #200	@,
	movs	r0, #0	@,
	ldr	r4, .L24+84	@ tmp286,
	bl	.L26		@
	movs	r3, r0	@ tmp287,
	str	r3, [r7, #32]	@ tmp287, FaceProc
@ Pokedex.c:231: 	FaceProc->tileData &= ~(3 << 10); // Clear bits 10 and 11 (priority) such that they are 0 (highest priority) and appear above the background 
	ldr	r3, [r7, #32]	@ tmp288, FaceProc
	ldrh	r3, [r3, #60]	@ _38,
	ldr	r2, .L24+88	@ tmp290,
	ands	r3, r2	@ tmp289, tmp290
	lsls	r3, r3, #16	@ tmp291, tmp289,
	lsrs	r2, r3, #16	@ _39, tmp291,
	ldr	r3, [r7, #32]	@ tmp292, FaceProc
	strh	r2, [r3, #60]	@ tmp293, FaceProc_98->tileData
@ Pokedex.c:233: 	BgMap_ApplyTsa(&gBG1MapBuffer[0][20], &PokedexPortraitBox, 0);
	ldr	r1, .L24+92	@ tmp294,
	ldr	r3, .L24+96	@ tmp295,
	movs	r2, #0	@,
	movs	r0, r3	@, tmp295
	ldr	r3, .L24+76	@ tmp296,
	bl	.L13		@
@ Pokedex.c:235: 	if (!CheckIfSeen(proc->menuIndex))
	ldr	r3, [r7, #56]	@ tmp297, proc
	movs	r2, #48	@ tmp298,
	ldrb	r3, [r3, r2]	@ _40,
	movs	r0, r3	@, _40
	ldr	r3, .L24+100	@ tmp299,
	bl	.L13		@
	subs	r3, r0, #0	@ _41,,
@ Pokedex.c:235: 	if (!CheckIfSeen(proc->menuIndex))
	bne	.L20		@,
@ Pokedex.c:238: 		int paletteID = 22*32;
	movs	r3, #176	@ tmp326,
	lsls	r3, r3, #2	@ tmp300, tmp326,
	str	r3, [r7, #28]	@ tmp300, paletteID
@ Pokedex.c:239: 		int paletteSize = 32; 
	movs	r3, #32	@ tmp301,
	str	r3, [r7, #24]	@ tmp301, paletteSize
@ Pokedex.c:240: 		CopyToPaletteBuffer(MyPalette, paletteID, paletteSize); // source pointer, palette offset, size 
	ldr	r1, [r7, #28]	@ paletteID.2_42, paletteID
	ldr	r2, [r7, #24]	@ paletteSize.3_43, paletteSize
	ldr	r3, .L24+104	@ tmp302,
	movs	r0, r3	@, tmp302
	ldr	r3, .L24+108	@ tmp303,
	bl	.L13		@
@ Pokedex.c:241: 		gPaletteSyncFlag = 1;
	ldr	r3, .L24+112	@ tmp304,
	movs	r2, #1	@ tmp305,
	strb	r2, [r3]	@ tmp306, gPaletteSyncFlag
.L20:
@ Pokedex.c:244: 	LoadIconPalettes(4);
	movs	r0, #4	@,
	ldr	r3, .L24+116	@ tmp307,
	bl	.L13		@
@ Pokedex.c:245: 	ClearIcons();
	ldr	r3, .L24+120	@ tmp308,
	bl	.L13		@
@ Pokedex.c:246: 	EnableBgSyncByMask(BG0_SYNC_BIT);
	movs	r0, #1	@,
	ldr	r3, .L24+124	@ tmp309,
	bl	.L13		@
@ Pokedex.c:247: 	if (CheckIfCaught(proc->menuIndex))
	ldr	r3, [r7, #56]	@ tmp310, proc
	movs	r2, #48	@ tmp311,
	ldrb	r3, [r3, r2]	@ _44,
	movs	r0, r3	@, _44
	ldr	r3, .L24+128	@ tmp312,
	bl	.L13		@
	subs	r3, r0, #0	@ _45,,
@ Pokedex.c:247: 	if (CheckIfCaught(proc->menuIndex))
	beq	.L21		@,
@ Pokedex.c:249: 		DrawIcon(
	ldr	r3, [r7, #52]	@ tmp313, out
	adds	r3, r3, #14	@ _46,
	movs	r2, #128	@ tmp325,
	lsls	r2, r2, #7	@ tmp314, tmp325,
	movs	r1, #171	@,
	movs	r0, r3	@, _46
	ldr	r3, .L24+132	@ tmp315,
	bl	.L13		@
	b	.L22		@
.L21:
@ Pokedex.c:255: 		if (CheckIfSeen(proc->menuIndex))
	ldr	r3, [r7, #56]	@ tmp316, proc
	movs	r2, #48	@ tmp317,
	ldrb	r3, [r3, r2]	@ _47,
	movs	r0, r3	@, _47
	ldr	r3, .L24+100	@ tmp318,
	bl	.L13		@
	subs	r3, r0, #0	@ _48,,
@ Pokedex.c:255: 		if (CheckIfSeen(proc->menuIndex))
	beq	.L22		@,
@ Pokedex.c:257: 			DrawIcon(
	ldr	r3, [r7, #52]	@ tmp319, out
	adds	r3, r3, #14	@ _49,
	movs	r2, #128	@ tmp324,
	lsls	r2, r2, #7	@ tmp320, tmp324,
	movs	r1, #170	@,
	movs	r0, r3	@, _49
	ldr	r3, .L24+132	@ tmp321,
	bl	.L13		@
.L22:
@ Pokedex.c:266: 	EnableBgSyncByMask(1);
	movs	r0, #1	@,
	ldr	r3, .L24+124	@ tmp322,
	bl	.L13		@
@ Pokedex.c:270:     return ME_NONE;
	movs	r3, #0	@ _114,
@ Pokedex.c:271: }
	movs	r0, r3	@, <retval>
	mov	sp, r7	@,
	add	sp, sp, #68	@,,
	@ sp needed	@
	pop	{r4, r7}
	pop	{r1}
	bx	r1
.L25:
	.align	2
.L24:
	.word	gBg0MapBuffer
	.word	GetClassData
	.word	Text_Clear
	.word	Text_ResetTileAllocation
	.word	GetStringFromIndex
	.word	Text_DrawString
	.word	Text_Display
	.word	Text_SetColorId
	.word	Text_SetXCursor
	.word	.LC18
	.word	memset
	.word	gpCurrentFont
	.word	.LC22
	.word	.LC24
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
	.word	CheckIfSeen
	.word	MyPalette
	.word	CopyToPaletteBuffer
	.word	gPaletteSyncFlag
	.word	LoadIconPalettes
	.word	ClearIcons
	.word	EnableBgSyncByMask
	.word	CheckIfCaught
	.word	DrawIcon
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
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}	@
	sub	sp, sp, #24	@,,
	add	r7, sp, #0	@,,
	str	r0, [r7, #4]	@ menu, menu
	str	r1, [r7]	@ command, command
@ Pokedex.c:280:     struct PokedexProc* proc = (void*) ProcStart(Proc_ChapterPokedex, ROOT_PROC_3);
	ldr	r3, .L34	@ tmp147,
	movs	r1, #3	@,
	movs	r0, r3	@, tmp147
	ldr	r3, .L34+4	@ tmp148,
	bl	.L13		@
	movs	r3, r0	@ tmp149,
	str	r3, [r7, #12]	@ tmp149, proc
@ Pokedex.c:282:     proc->menuIndex = 1;
	ldr	r3, [r7, #12]	@ tmp150, proc
	movs	r2, #48	@ tmp151,
	movs	r1, #1	@ tmp152,
	strb	r1, [r3, r2]	@ tmp153, proc_41->menuIndex
@ Pokedex.c:283: 	proc->TotalCaught = CountCaught();
	ldr	r3, .L34+8	@ tmp154,
	bl	.L13		@
	movs	r3, r0	@ _1,
@ Pokedex.c:283: 	proc->TotalCaught = CountCaught();
	lsls	r3, r3, #24	@ tmp155, _1,
	lsrs	r1, r3, #24	@ _2, tmp155,
	ldr	r3, [r7, #12]	@ tmp156, proc
	movs	r2, #50	@ tmp157,
	strb	r1, [r3, r2]	@ tmp158, proc_41->TotalCaught
@ Pokedex.c:284: 	proc->TotalSeen = CountSeen();
	ldr	r3, .L34+12	@ tmp159,
	bl	.L13		@
	movs	r3, r0	@ _3,
@ Pokedex.c:284: 	proc->TotalSeen = CountSeen();
	lsls	r3, r3, #24	@ tmp160, _3,
	lsrs	r1, r3, #24	@ _4, tmp160,
	ldr	r3, [r7, #12]	@ tmp161, proc
	movs	r2, #49	@ tmp162,
	strb	r1, [r3, r2]	@ tmp163, proc_41->TotalSeen
@ Pokedex.c:286: 	Decompress(WorldMap_img,(void*)0x6008000);
	ldr	r2, .L34+16	@ tmp164,
	ldr	r3, .L34+20	@ tmp165,
	movs	r1, r2	@, tmp164
	movs	r0, r3	@, tmp165
	ldr	r3, .L34+24	@ tmp166,
	bl	.L13		@
@ Pokedex.c:288: 	CopyToPaletteBuffer(WorldMap_pal,0x20*6,(gWorldMapPaletteCount-2)*32);
	ldr	r3, .L34+28	@ tmp167,
	ldrb	r3, [r3]	@ gWorldMapPaletteCount.4_5, gWorldMapPaletteCount
	subs	r3, r3, #2	@ _7,
@ Pokedex.c:288: 	CopyToPaletteBuffer(WorldMap_pal,0x20*6,(gWorldMapPaletteCount-2)*32);
	lsls	r3, r3, #5	@ _8, _7,
@ Pokedex.c:288: 	CopyToPaletteBuffer(WorldMap_pal,0x20*6,(gWorldMapPaletteCount-2)*32);
	movs	r2, r3	@ _9, _8
	ldr	r3, .L34+32	@ tmp168,
	movs	r1, #192	@,
	movs	r0, r3	@, tmp168
	ldr	r3, .L34+36	@ tmp169,
	bl	.L13		@
@ Pokedex.c:289: 	CopyToPaletteBuffer(WorldMap_pal+(gWorldMapPaletteCount-1)*16,0x20*15,32);
	ldr	r3, .L34+28	@ tmp170,
	ldrb	r3, [r3]	@ gWorldMapPaletteCount.5_10, gWorldMapPaletteCount
	subs	r3, r3, #1	@ _12,
@ Pokedex.c:289: 	CopyToPaletteBuffer(WorldMap_pal+(gWorldMapPaletteCount-1)*16,0x20*15,32);
	lsls	r2, r3, #5	@ _14, _13,
@ Pokedex.c:289: 	CopyToPaletteBuffer(WorldMap_pal+(gWorldMapPaletteCount-1)*16,0x20*15,32);
	ldr	r3, .L34+32	@ tmp171,
	adds	r3, r2, r3	@ _15, _14, tmp171
	movs	r2, #240	@ tmp245,
	lsls	r1, r2, #1	@ tmp172, tmp245,
	movs	r2, #32	@,
	movs	r0, r3	@, _15
	ldr	r3, .L34+36	@ tmp173,
	bl	.L13		@
@ Pokedex.c:291: 	memcpy(gGenericBuffer, WorldMap_tsa, 0x4B2);
	ldr	r2, .L34+40	@ tmp174,
	ldr	r1, .L34+44	@ tmp175,
	ldr	r3, .L34+48	@ tmp176,
	movs	r0, r3	@, tmp176
	ldr	r3, .L34+52	@ tmp177,
	bl	.L13		@
@ Pokedex.c:293: 	TSA* tsaBuffer = (TSA*)gGenericBuffer;
	ldr	r3, .L34+48	@ tmp178,
	str	r3, [r7, #8]	@ tmp178, tsaBuffer
@ Pokedex.c:294: 	for ( int i = 0 ; i < tsaBuffer->height+1 ; i++ )
	movs	r3, #0	@ tmp179,
	str	r3, [r7, #20]	@ tmp179, i
@ Pokedex.c:294: 	for ( int i = 0 ; i < tsaBuffer->height+1 ; i++ )
	b	.L28		@
.L32:
@ Pokedex.c:296: 		for ( int j = 0 ; j < tsaBuffer->width+1 ; j++ )
	movs	r3, #0	@ tmp180,
	str	r3, [r7, #16]	@ tmp180, j
@ Pokedex.c:296: 		for ( int j = 0 ; j < tsaBuffer->width+1 ; j++ )
	b	.L29		@
.L31:
@ Pokedex.c:298: 			if ( tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID == 16-6 )
	ldr	r3, [r7, #8]	@ tmp181, tsaBuffer
	ldrb	r3, [r3]	@ _16, *tsaBuffer_51
@ Pokedex.c:298: 			if ( tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID == 16-6 )
	adds	r3, r3, #1	@ _18,
@ Pokedex.c:298: 			if ( tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID == 16-6 )
	ldr	r2, [r7, #20]	@ tmp182, i
	muls	r2, r3	@ _19, _18
@ Pokedex.c:298: 			if ( tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID == 16-6 )
	ldr	r3, [r7, #16]	@ tmp183, j
	adds	r3, r2, r3	@ _20, _19, tmp183
@ Pokedex.c:298: 			if ( tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID == 16-6 )
	ldr	r2, [r7, #8]	@ tmp184, tsaBuffer
	lsls	r3, r3, #1	@ tmp185, _20,
	adds	r3, r2, r3	@ tmp188, tmp184, tmp185
	ldrb	r3, [r3, #3]	@ tmp189,
	lsls	r3, r3, #24	@ tmp191, tmp189,
	lsrs	r3, r3, #28	@ tmp190, tmp191,
	lsls	r3, r3, #24	@ tmp192, tmp190,
	lsrs	r3, r3, #24	@ _21, tmp192,
@ Pokedex.c:298: 			if ( tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID == 16-6 )
	cmp	r3, #10	@ _21,
	bne	.L30		@,
@ Pokedex.c:300: 				tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID--;
	ldr	r3, [r7, #8]	@ tmp193, tsaBuffer
	ldrb	r3, [r3]	@ _22, *tsaBuffer_51
@ Pokedex.c:300: 				tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID--;
	adds	r3, r3, #1	@ _24,
@ Pokedex.c:300: 				tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID--;
	ldr	r2, [r7, #20]	@ tmp194, i
	muls	r2, r3	@ _25, _24
@ Pokedex.c:300: 				tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID--;
	ldr	r3, [r7, #16]	@ tmp195, j
	adds	r3, r2, r3	@ _26, _25, tmp195
@ Pokedex.c:300: 				tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID--;
	ldr	r1, [r7, #8]	@ tmp196, tsaBuffer
	lsls	r2, r3, #1	@ tmp197, _26,
	adds	r2, r1, r2	@ tmp200, tmp196, tmp197
	ldrb	r2, [r2, #3]	@ tmp201,
	lsls	r2, r2, #24	@ tmp203, tmp201,
	lsrs	r2, r2, #28	@ tmp202, tmp203,
	lsls	r2, r2, #24	@ tmp204, tmp202,
	lsrs	r2, r2, #24	@ _27, tmp204,
@ Pokedex.c:300: 				tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID--;
	adds	r2, r2, #15	@ tmp205,
	adds	r1, r2, #0	@ tmp206, tmp205
	movs	r2, #15	@ tmp208,
	ands	r2, r1	@ tmp207, tmp206
	lsls	r2, r2, #24	@ tmp209, tmp207,
	lsrs	r2, r2, #24	@ _29, tmp209,
	ldr	r1, [r7, #8]	@ tmp210, tsaBuffer
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
@ Pokedex.c:296: 		for ( int j = 0 ; j < tsaBuffer->width+1 ; j++ )
	ldr	r3, [r7, #16]	@ tmp223, j
	adds	r3, r3, #1	@ tmp222,
	str	r3, [r7, #16]	@ tmp222, j
.L29:
@ Pokedex.c:296: 		for ( int j = 0 ; j < tsaBuffer->width+1 ; j++ )
	ldr	r3, [r7, #8]	@ tmp224, tsaBuffer
	ldrb	r3, [r3]	@ _30, *tsaBuffer_51
	movs	r2, r3	@ _31, _30
@ Pokedex.c:296: 		for ( int j = 0 ; j < tsaBuffer->width+1 ; j++ )
	ldr	r3, [r7, #16]	@ tmp225, j
	cmp	r3, r2	@ tmp225, _31
	ble	.L31		@,
@ Pokedex.c:294: 	for ( int i = 0 ; i < tsaBuffer->height+1 ; i++ )
	ldr	r3, [r7, #20]	@ tmp227, i
	adds	r3, r3, #1	@ tmp226,
	str	r3, [r7, #20]	@ tmp226, i
.L28:
@ Pokedex.c:294: 	for ( int i = 0 ; i < tsaBuffer->height+1 ; i++ )
	ldr	r3, [r7, #8]	@ tmp228, tsaBuffer
	ldrb	r3, [r3, #1]	@ _32,
	movs	r2, r3	@ _33, _32
@ Pokedex.c:294: 	for ( int i = 0 ; i < tsaBuffer->height+1 ; i++ )
	ldr	r3, [r7, #20]	@ tmp229, i
	cmp	r3, r2	@ tmp229, _33
	ble	.L32		@,
@ Pokedex.c:304: 	BgMap_ApplyTsa(gBg3MapBuffer,gGenericBuffer, 6<<12);
	movs	r3, #192	@ tmp243,
	lsls	r2, r3, #7	@ tmp230, tmp243,
	ldr	r1, .L34+48	@ tmp231,
	ldr	r3, .L34+56	@ tmp232,
	movs	r0, r3	@, tmp232
	ldr	r3, .L34+60	@ tmp233,
	bl	.L13		@
@ Pokedex.c:305: 	SetBgTileDataOffset(2,0x8000);
	movs	r3, #128	@ tmp244,
	lsls	r3, r3, #8	@ tmp234, tmp244,
	movs	r1, r3	@, tmp234
	movs	r0, #2	@,
	ldr	r3, .L34+64	@ tmp235,
	bl	.L13		@
@ Pokedex.c:307: 	LoadIconPalettes(4);
	movs	r0, #4	@,
	ldr	r3, .L34+68	@ tmp236,
	bl	.L13		@
@ Pokedex.c:308: 	EnableBgSyncByMask(BG_SYNC_BIT(3)); // sync bg 3 
	movs	r0, #8	@,
	ldr	r3, .L34+72	@ tmp237,
	bl	.L13		@
@ Pokedex.c:309: 	EnablePaletteSync();
	ldr	r3, .L34+76	@ tmp238,
	bl	.L13		@
@ Pokedex.c:312:     StartMenuChild(&Menu_Pokedex, (void*) proc);
	ldr	r2, [r7, #12]	@ tmp239, proc
	ldr	r3, .L34+80	@ tmp240,
	movs	r1, r2	@, tmp239
	movs	r0, r3	@, tmp240
	ldr	r3, .L34+84	@ tmp241,
	bl	.L13		@
@ Pokedex.c:314:     return ME_DISABLE | ME_END | ME_PLAY_BEEP | ME_CLEAR_GFX;
	movs	r3, #23	@ _59,
@ Pokedex.c:315: }
	movs	r0, r3	@, <retval>
	mov	sp, r7	@,
	add	sp, sp, #24	@,,
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
@ Pokedex.c:319:     command->onCycle = (void*) PokedexDrawIdle(menu, command);
	ldr	r2, [r7]	@ tmp115, command
	ldr	r3, [r7, #4]	@ tmp116, menu
	movs	r1, r2	@, tmp115
	movs	r0, r3	@, tmp116
	bl	PokedexDrawIdle		@
	movs	r3, r0	@ _1,
@ Pokedex.c:319:     command->onCycle = (void*) PokedexDrawIdle(menu, command);
	movs	r2, r3	@ _2, _1
@ Pokedex.c:319:     command->onCycle = (void*) PokedexDrawIdle(menu, command);
	ldr	r3, [r7]	@ tmp117, command
	str	r2, [r3, #12]	@ _2, command_5(D)->onCycle
@ Pokedex.c:320: }
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
@ Pokedex.c:324: 	EndFaceById(0);
	movs	r0, #0	@,
	ldr	r3, .L39	@ tmp113,
	bl	.L13		@
@ Pokedex.c:325:     return;
	nop	
@ Pokedex.c:326: }
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
@ Pokedex.c:353: 	for (u16 i = 0 ; i <= 0x80 ; i++) 
	movs	r3, #22	@ tmp257,
	adds	r3, r7, r3	@ tmp149,, tmp257
	movs	r2, #0	@ tmp150,
	strh	r2, [r3]	@ tmp151, i
@ Pokedex.c:353: 	for (u16 i = 0 ; i <= 0x80 ; i++) 
	b	.L42		@
.L45:
@ Pokedex.c:355: 		u8 Chapter = MonsterSpawnTable[i].ChID;
	movs	r4, #22	@ tmp258,
	adds	r3, r7, r4	@ tmp152,, tmp258
	ldrh	r2, [r3]	@ _1, i
@ Pokedex.c:355: 		u8 Chapter = MonsterSpawnTable[i].ChID;
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
@ Pokedex.c:356: 		if (Chapter)
	adds	r3, r7, r6	@ tmp160,, tmp260
	ldrb	r3, [r3]	@ tmp161, Chapter
	cmp	r3, #0	@ tmp161,
	bne	.LCB978	@
	b	.L43	@long jump	@
.LCB978:
@ Pokedex.c:359: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	adds	r3, r7, r4	@ tmp162,, tmp261
	ldrh	r2, [r3]	@ _2, i
	ldr	r1, .L47	@ tmp163,
	movs	r3, r2	@ tmp164, _2
	lsls	r3, r3, #1	@ tmp164, tmp164,
	adds	r3, r3, r2	@ tmp164, tmp164, _2
	lsls	r3, r3, #2	@ tmp165, tmp164,
	ldrb	r3, [r3, r1]	@ _3, MonsterSpawnTable
@ Pokedex.c:359: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	movs	r5, #15	@ tmp262,
	adds	r2, r7, r5	@ tmp166,, tmp262
	ldrb	r2, [r2]	@ tmp168, classID
	subs	r3, r2, r3	@ tmp170, tmp168, _3
	rsbs	r2, r3, #0	@ tmp171, tmp170
	adcs	r3, r3, r2	@ tmp169, tmp170, tmp171
	lsls	r3, r3, #24	@ tmp172, tmp167,
	lsrs	r1, r3, #24	@ _4, tmp172,
@ Pokedex.c:359: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
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
@ Pokedex.c:359: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
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
@ Pokedex.c:359: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
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
@ Pokedex.c:359: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	adds	r2, r7, r5	@ tmp194,, tmp266
	ldrb	r2, [r2]	@ tmp196, classID
	subs	r3, r2, r3	@ tmp198, tmp196, _11
	rsbs	r2, r3, #0	@ tmp199, tmp198
	adcs	r3, r3, r2	@ tmp197, tmp198, tmp199
	lsls	r3, r3, #24	@ tmp200, tmp195,
	lsrs	r3, r3, #24	@ _12, tmp200,
@ Pokedex.c:359: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	movs	r1, r0	@ _9, _9
	orrs	r1, r3	@ _9, _13
@ Pokedex.c:359: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
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
@ Pokedex.c:359: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	adds	r2, r7, r5	@ tmp207,, tmp269
	ldrb	r2, [r2]	@ tmp209, classID
	subs	r3, r2, r3	@ tmp211, tmp209, _16
	rsbs	r2, r3, #0	@ tmp212, tmp211
	adcs	r3, r3, r2	@ tmp210, tmp211, tmp212
	lsls	r3, r3, #24	@ tmp213, tmp208,
	lsrs	r3, r3, #24	@ _17, tmp213,
@ Pokedex.c:359: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	orrs	r1, r3	@ _19, _18
@ Pokedex.c:359: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
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
@ Pokedex.c:359: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	adds	r2, r7, r5	@ tmp220,, tmp271
	ldrb	r2, [r2]	@ tmp222, classID
	subs	r3, r2, r3	@ tmp224, tmp222, _21
	rsbs	r2, r3, #0	@ tmp225, tmp224
	adcs	r3, r3, r2	@ tmp223, tmp224, tmp225
	lsls	r3, r3, #24	@ tmp226, tmp221,
	lsrs	r3, r3, #24	@ _22, tmp226,
@ Pokedex.c:359: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	orrs	r3, r1	@ _24, _19
@ Pokedex.c:359: 			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
	beq	.L43		@,
@ Pokedex.c:361: 				if (Chapter <= 63)
	adds	r3, r7, r6	@ tmp227,, tmp272
	ldrb	r3, [r3]	@ tmp230, Chapter
	cmp	r3, #63	@ tmp230,
	bhi	.L44		@,
@ Pokedex.c:365: 					*areaBitfield_A = *areaBitfield_A | 1<<Chapter;
	ldr	r3, [r7, #8]	@ tmp231, areaBitfield_A
	ldr	r2, [r3]	@ _25, *areaBitfield_A_42(D)
@ Pokedex.c:365: 					*areaBitfield_A = *areaBitfield_A | 1<<Chapter;
	adds	r3, r7, r6	@ tmp232,, tmp273
	ldrb	r3, [r3]	@ _26, Chapter
	movs	r1, #1	@ tmp233,
	lsls	r1, r1, r3	@ tmp233, tmp233, _26
	movs	r3, r1	@ _27, tmp233
@ Pokedex.c:365: 					*areaBitfield_A = *areaBitfield_A | 1<<Chapter;
	orrs	r2, r3	@ _28, _27
@ Pokedex.c:365: 					*areaBitfield_A = *areaBitfield_A | 1<<Chapter;
	ldr	r3, [r7, #8]	@ tmp234, areaBitfield_A
	str	r2, [r3]	@ _28, *areaBitfield_A_42(D)
.L44:
@ Pokedex.c:367: 				if ((Chapter > 63) && (Chapter < 127))
	movs	r1, #21	@ tmp275,
	adds	r3, r7, r1	@ tmp235,, tmp275
	ldrb	r3, [r3]	@ tmp238, Chapter
	cmp	r3, #63	@ tmp238,
	bls	.L43		@,
@ Pokedex.c:367: 				if ((Chapter > 63) && (Chapter < 127))
	adds	r3, r7, r1	@ tmp239,, tmp276
	ldrb	r3, [r3]	@ tmp242, Chapter
	cmp	r3, #126	@ tmp242,
	bhi	.L43		@,
@ Pokedex.c:369: 					*areaBitfield_B = *areaBitfield_B | 1<<Chapter;
	ldr	r3, [r7, #4]	@ tmp243, areaBitfield_B
	ldr	r2, [r3]	@ _29, *areaBitfield_B_44(D)
@ Pokedex.c:369: 					*areaBitfield_B = *areaBitfield_B | 1<<Chapter;
	adds	r3, r7, r1	@ tmp244,, tmp277
	ldrb	r3, [r3]	@ _30, Chapter
	movs	r1, #1	@ tmp245,
	lsls	r1, r1, r3	@ tmp245, tmp245, _30
	movs	r3, r1	@ _31, tmp245
@ Pokedex.c:369: 					*areaBitfield_B = *areaBitfield_B | 1<<Chapter;
	orrs	r2, r3	@ _32, _31
@ Pokedex.c:369: 					*areaBitfield_B = *areaBitfield_B | 1<<Chapter;
	ldr	r3, [r7, #4]	@ tmp246, areaBitfield_B
	str	r2, [r3]	@ _32, *areaBitfield_B_44(D)
.L43:
@ Pokedex.c:353: 	for (u16 i = 0 ; i <= 0x80 ; i++) 
	movs	r1, #22	@ tmp279,
	adds	r3, r7, r1	@ tmp247,, tmp279
	ldrh	r2, [r3]	@ i.6_33, i
	adds	r3, r7, r1	@ tmp248,, tmp280
	adds	r2, r2, #1	@ tmp249,
	strh	r2, [r3]	@ tmp250, i
.L42:
@ Pokedex.c:353: 	for (u16 i = 0 ; i <= 0x80 ; i++) 
	movs	r3, #22	@ tmp281,
	adds	r3, r7, r3	@ tmp251,, tmp281
	ldrh	r3, [r3]	@ tmp254, i
	cmp	r3, #128	@ tmp254,
	bhi	.LCB1131	@
	b	.L45	@long jump	@
.LCB1131:
@ Pokedex.c:374: 	return;
	nop	
@ Pokedex.c:375: }
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
