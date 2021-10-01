	.cpu arm7tdmi
	.eabi_attribute 20, 1	@ Tag_ABI_FP_denormal
	.eabi_attribute 21, 1	@ Tag_ABI_FP_exceptions
	.eabi_attribute 23, 3	@ Tag_ABI_FP_number_model
	.eabi_attribute 24, 1	@ Tag_ABI_align8_needed
	.eabi_attribute 25, 1	@ Tag_ABI_align8_preserved
	.eabi_attribute 26, 1	@ Tag_ABI_enum_size
	.eabi_attribute 30, 4	@ Tag_ABI_optimization_goals
	.eabi_attribute 34, 0	@ Tag_CPU_unaligned_access
	.eabi_attribute 18, 4	@ Tag_ABI_PCS_wchar_t
	.file	"ReorderMoves.c"
@ GNU C17 (devkitARM release 54) version 10.1.0 (arm-none-eabi)
@	compiled by GNU C version 6.4.0, GMP version 6.0.0, MPFR version 3.1.2, MPC version 1.0.2, isl version none
@ GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
@ options passed:  -imultilib thumb
@ -iprefix c:\devkitpro\devkitarm\bin\../lib/gcc/arm-none-eabi/10.1.0/
@ -D__USES_INITFINI__ ReorderMoves.c -mcpu=arm7tdmi -mthumb
@ -mthumb-interwork -mtune=arm7tdmi -mlong-calls -march=armv4t
@ -auxbase-strip ReorderMoves.s -Os -Wall -fverbose-asm
@ options enabled:  -faggressive-loop-optimizations -fallocation-dce
@ -fauto-inc-dec -fbranch-count-reg -fcaller-saves -fcode-hoisting
@ -fcombine-stack-adjustments -fcompare-elim -fcprop-registers
@ -fcrossjumping -fcse-follow-jumps -fdefer-pop
@ -fdelete-null-pointer-checks -fdevirtualize -fdevirtualize-speculatively
@ -fdwarf2-cfi-asm -fearly-inlining -feliminate-unused-debug-symbols
@ -feliminate-unused-debug-types -fexpensive-optimizations
@ -fforward-propagate -ffp-int-builtin-inexact -ffunction-cse -fgcse
@ -fgcse-lm -fgnu-unique -fguess-branch-probability -fhoist-adjacent-loads
@ -fident -fif-conversion -fif-conversion2 -findirect-inlining -finline
@ -finline-atomics -finline-functions -finline-functions-called-once
@ -finline-small-functions -fipa-bit-cp -fipa-cp -fipa-icf
@ -fipa-icf-functions -fipa-icf-variables -fipa-profile -fipa-pure-const
@ -fipa-reference -fipa-reference-addressable -fipa-sra
@ -fipa-stack-alignment -fipa-vrp -fira-hoist-pressure
@ -fira-share-save-slots -fira-share-spill-slots
@ -fisolate-erroneous-paths-dereference -fivopts -fkeep-static-consts
@ -fleading-underscore -flifetime-dse -flra-remat -fmath-errno
@ -fmerge-constants -fmerge-debug-strings -fmove-loop-invariants
@ -fomit-frame-pointer -foptimize-sibling-calls -fpartial-inlining
@ -fpeephole -fpeephole2 -fplt -fprefetch-loop-arrays -freg-struct-return
@ -freorder-blocks -freorder-functions -frerun-cse-after-loop
@ -fsched-critical-path-heuristic -fsched-dep-count-heuristic
@ -fsched-group-heuristic -fsched-interblock -fsched-last-insn-heuristic
@ -fsched-pressure -fsched-rank-heuristic -fsched-spec
@ -fsched-spec-insn-heuristic -fsched-stalled-insns-dep -fschedule-insns2
@ -fsection-anchors -fsemantic-interposition -fshow-column -fshrink-wrap
@ -fshrink-wrap-separate -fsigned-zeros -fsplit-ivs-in-unroller
@ -fsplit-wide-types -fssa-backprop -fssa-phiopt -fstdarg-opt
@ -fstore-merging -fstrict-aliasing -fstrict-volatile-bitfields
@ -fsync-libcalls -fthread-jumps -ftoplevel-reorder -ftrapping-math
@ -ftree-bit-ccp -ftree-builtin-call-dce -ftree-ccp -ftree-ch
@ -ftree-coalesce-vars -ftree-copy-prop -ftree-cselim -ftree-dce
@ -ftree-dominator-opts -ftree-dse -ftree-forwprop -ftree-fre
@ -ftree-loop-distribute-patterns -ftree-loop-if-convert -ftree-loop-im
@ -ftree-loop-ivcanon -ftree-loop-optimize -ftree-parallelize-loops=
@ -ftree-phiprop -ftree-pre -ftree-pta -ftree-reassoc -ftree-scev-cprop
@ -ftree-sink -ftree-slsr -ftree-sra -ftree-switch-conversion
@ -ftree-tail-merge -ftree-ter -ftree-vrp -funit-at-a-time -fverbose-asm
@ -fzero-initialized-in-bss -mbe32 -mlittle-endian -mlong-calls
@ -mpic-data-is-text-relative -msched-prolog -mthumb -mthumb-interwork
@ -mvectorize-with-neon-quad

	.text
	.align	1
	.arch armv4t
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	SkillListCommandSelect, %function
SkillListCommandSelect:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
@ ReorderMoves.c:563: }
	movs	r0, #0	@,
	@ sp needed	@
	bx	lr
	.size	SkillListCommandSelect, .-SkillListCommandSelect
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	MoveCommandSelect, %function
MoveCommandSelect:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ ReorderMoves.c:588:     struct ReorderMovesProc* const proc = (void*) menu->parent;
	ldr	r4, [r0, #20]	@ proc, menu_18(D)->parent
@ ReorderMoves.c:592: 	if (proc->SelectedMoveIndex != 255) { 
	ldr	r1, [r4, #52]	@ _2, proc_19->SelectedMoveIndex
@ ReorderMoves.c:594: 		unsigned new_move = moves[proc->move_hovering];
	ldr	r2, [r4, #60]	@ pretmp_33, proc_19->move_hovering
@ ReorderMoves.c:592: 	if (proc->SelectedMoveIndex != 255) { 
	cmp	r1, #255	@ _2,
	beq	.L3		@,
@ ReorderMoves.c:31: 	return unit->ranks; 
	ldr	r3, [r4, #44]	@ _20, proc_19->unit
	adds	r3, r3, #40	@ _20,
@ ReorderMoves.c:596: 		moves[proc->move_hovering] = moves[proc->SelectedMoveIndex];
	ldrb	r1, [r3, r1]	@ _9, *_8
@ ReorderMoves.c:594: 		unsigned new_move = moves[proc->move_hovering];
	ldrb	r0, [r3, r2]	@ _6, *_5
@ ReorderMoves.c:596: 		moves[proc->move_hovering] = moves[proc->SelectedMoveIndex];
	strb	r1, [r3, r2]	@ _9, *_5
@ ReorderMoves.c:597: 		moves[proc->SelectedMoveIndex] = new_move;
	ldr	r2, [r4, #52]	@ tmp165, proc_19->SelectedMoveIndex
	strb	r0, [r3, r2]	@ _6, *_12
@ ReorderMoves.c:600: 		UnitClearBlankSkills(proc->unit);
	ldr	r2, [r4, #44]	@ _13, proc_19->unit
@ ReorderMoves.c:31: 	return unit->ranks; 
	movs	r3, r2	@ _28, _13
	adds	r3, r3, #40	@ _28,
	movs	r1, r3	@ ivtmp.49, _28
@ ReorderMoves.c:70:     int iIn = 0, iOut = 0;
	movs	r0, #0	@ iOut,
	adds	r2, r2, #48	@ _54,
.L5:
@ ReorderMoves.c:74:         if (moves[iIn])
	ldrb	r5, [r1]	@ _32, MEM[base: _46, offset: 0B]
@ ReorderMoves.c:74:         if (moves[iIn])
	cmp	r5, #0	@ _32,
	beq	.L4		@,
@ ReorderMoves.c:75:             moves[iOut++] = moves[iIn];
	strb	r5, [r3, r0]	@ _32, *_36
@ ReorderMoves.c:75:             moves[iOut++] = moves[iIn];
	adds	r0, r0, #1	@ iOut,
.L4:
@ ReorderMoves.c:72:     for (; iIn < UNIT_SKILL_COUNT; ++iIn)
	adds	r1, r1, #1	@ ivtmp.49,
	cmp	r1, r2	@ ivtmp.49, _54
	bne	.L5		@,
@ ReorderMoves.c:79:         moves[iOut] = 0;
	movs	r2, #0	@ tmp151,
	cmp	r0, #8	@ iOut,
	bgt	.L7		@,
	adds	r2, r2, #8	@ tmp152,
	subs	r2, r2, r0	@ tmp151, tmp152, iOut
.L7:
	adds	r0, r3, r0	@ tmp153, _28, iOut
	movs	r1, #0	@,
	ldr	r3, .L13	@ tmp156,
	bl	.L15		@
@ ReorderMoves.c:602: 		proc->movesUpdated = TRUE;
	movs	r3, #1	@ tmp159,
@ ReorderMoves.c:605: 		return ME_DISABLE | ME_END | ME_PLAY_BEEP | ME_CLEAR_GFX;
	movs	r0, #23	@ <retval>,
@ ReorderMoves.c:602: 		proc->movesUpdated = TRUE;
	str	r3, [r4, #48]	@ tmp159, proc_19->movesUpdated
@ ReorderMoves.c:603: 		proc->SelectedMoveIndex = 255;
	adds	r3, r3, #254	@ tmp160,
	str	r3, [r4, #52]	@ tmp160, proc_19->SelectedMoveIndex
.L2:
@ ReorderMoves.c:612: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L3:
@ ReorderMoves.c:608: 		proc->movesUpdated = TRUE; 
	movs	r3, #1	@ tmp161,
@ ReorderMoves.c:611:     return ME_PLAY_BEEP;
	movs	r0, #4	@ <retval>,
@ ReorderMoves.c:607: 	else { proc->SelectedMoveIndex = proc->move_hovering; 
	str	r2, [r4, #52]	@ pretmp_33, proc_19->SelectedMoveIndex
@ ReorderMoves.c:608: 		proc->movesUpdated = TRUE; 
	str	r3, [r4, #48]	@ tmp161, proc_19->movesUpdated
@ ReorderMoves.c:611:     return ME_PLAY_BEEP;
	b	.L2		@
.L14:
	.align	2
.L13:
	.word	memset
	.size	MoveCommandSelect, .-MoveCommandSelect
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	SkillDebugMenuEnd, %function
SkillDebugMenuEnd:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ ReorderMoves.c:639:     EndFaceById(0);
	movs	r0, #0	@,
@ ReorderMoves.c:640: }
	@ sp needed	@
@ ReorderMoves.c:639:     EndFaceById(0);
	ldr	r3, .L17	@ tmp114,
	bl	.L15		@
@ ReorderMoves.c:640: }
	pop	{r4}
	pop	{r0}
	bx	r0
.L18:
	.align	2
.L17:
	.word	EndFaceById
	.size	SkillDebugMenuEnd, .-SkillDebugMenuEnd
	.section	.rodata.str1.1,"aMS",%progbits,1
.LC6:
	.ascii	"Order Moves\000"
	.text
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	ReplaceSkillCommandDraw, %function
ReplaceSkillCommandDraw:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ ReorderMoves.c:621:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldrh	r2, [r1, #42]	@ tmp127,
@ ReorderMoves.c:632: }
	@ sp needed	@
@ ReorderMoves.c:621:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldrh	r3, [r1, #44]	@ tmp125,
@ ReorderMoves.c:623:     Text_Clear(&command->text);
	adds	r1, r1, #52	@ command,
	movs	r4, r1	@ _9, command
@ ReorderMoves.c:621:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r3, r3, #5	@ tmp126, tmp125,
	adds	r3, r3, r2	@ tmp128, tmp126, tmp127
@ ReorderMoves.c:621:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldr	r5, .L20	@ tmp130,
@ ReorderMoves.c:621:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r3, r3, #1	@ tmp129, tmp128,
@ ReorderMoves.c:621:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	adds	r5, r3, r5	@ out, tmp129, tmp130
@ ReorderMoves.c:623:     Text_Clear(&command->text);
	movs	r0, r1	@, _9
	ldr	r3, .L20+4	@ tmp131,
	bl	.L15		@
@ ReorderMoves.c:625: 	Text_SetXCursor(&command->text, title_offset);
	movs	r1, #8	@,
	movs	r0, r4	@, _9
	ldr	r3, .L20+8	@ tmp132,
	bl	.L15		@
@ ReorderMoves.c:626: 	Text_SetColorId(&command->text, TEXT_COLOR_BLUE);
	movs	r1, #2	@,
	movs	r0, r4	@, _9
	ldr	r3, .L20+12	@ tmp133,
	bl	.L15		@
@ ReorderMoves.c:627:     Text_DrawString(&command->text, "Order Moves");
	movs	r0, r4	@, _9
	ldr	r1, .L20+16	@,
	ldr	r3, .L20+20	@ tmp135,
	bl	.L15		@
@ ReorderMoves.c:628: 	Text_Display(&command->text, out); 
	movs	r1, r5	@, out
	movs	r0, r4	@, _9
	ldr	r3, .L20+24	@ tmp136,
	bl	.L15		@
@ ReorderMoves.c:632: }
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L21:
	.align	2
.L20:
	.word	gBg0MapBuffer
	.word	Text_Clear
	.word	Text_SetXCursor
	.word	Text_SetColorId
	.word	.LC6
	.word	Text_DrawString
	.word	Text_Display
	.size	ReplaceSkillCommandDraw, .-ReplaceSkillCommandDraw
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	IsMove, %function
IsMove:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ ReorderMoves.c:37:     if (moveId == 0)
	cmp	r0, #0	@ moveId,
	beq	.L23		@,
@ ReorderMoves.c:40:     if (moveId == 255)
	cmp	r0, #255	@ moveId,
	beq	.L24		@,
@ ReorderMoves.c:43:     return GetItemDescId(moveId);
	ldr	r3, .L28	@ tmp115,
	bl	.L15		@
.L23:
@ ReorderMoves.c:44: }
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L24:
@ ReorderMoves.c:38:         return FALSE;
	movs	r0, #0	@ moveId,
	b	.L23		@
.L29:
	.align	2
.L28:
	.word	GetItemDescId
	.size	IsMove, .-IsMove
	.section	.rodata.str1.1
.LC21:
	.ascii	" No Move\000"
	.text
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	SkillListCommandDraw_5, %function
SkillListCommandDraw_5:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, lr}	@
@ ReorderMoves.c:531:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldrh	r3, [r1, #42]	@ tmp139,
	ldrh	r5, [r1, #44]	@ tmp137,
@ ReorderMoves.c:534:     Text_Clear(&command->text);
	adds	r1, r1, #52	@ command,
	movs	r4, r1	@ _10, command
@ ReorderMoves.c:531:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #5	@ tmp138, tmp137,
	adds	r5, r5, r3	@ tmp140, tmp138, tmp139
@ ReorderMoves.c:531:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldr	r3, .L37	@ tmp142,
@ ReorderMoves.c:527:     struct ReorderMovesProc* const proc = (void*) menu->parent;
	ldr	r7, [r0, #20]	@ proc, menu_24(D)->parent
@ ReorderMoves.c:531:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #1	@ tmp141, tmp140,
@ ReorderMoves.c:534:     Text_Clear(&command->text);
	movs	r0, r1	@, _10
@ ReorderMoves.c:531:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	adds	r5, r5, r3	@ out, tmp141, tmp142
@ ReorderMoves.c:534:     Text_Clear(&command->text);
	ldr	r3, .L37+4	@ tmp143,
@ ReorderMoves.c:529:     u8* const moves = UnitGetMoveList(proc->unit);
	ldr	r6, [r7, #44]	@ _1, proc_25->unit
@ ReorderMoves.c:534:     Text_Clear(&command->text);
	bl	.L15		@
@ ReorderMoves.c:535: 	Text_SetXCursor(&command->text, 0);
	movs	r1, #0	@,
	ldr	r3, .L37+8	@ tmp180,
	movs	r0, r4	@, _10
	bl	.L15		@
@ ReorderMoves.c:536: 	Text_Display(&command->text, out); 
	movs	r1, r5	@, out
	movs	r0, r4	@, _10
	ldr	r3, .L37+12	@ tmp145,
	bl	.L15		@
@ ReorderMoves.c:540: 	if (IsMove(moves[i])) {
	adds	r6, r6, #44	@ tmp149,
@ ReorderMoves.c:537:     LoadIconPalettes(4); /* Icon palette */
	movs	r0, #4	@,
	ldr	r3, .L37+16	@ tmp146,
	bl	.L15		@
@ ReorderMoves.c:540: 	if (IsMove(moves[i])) {
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 44B], MEM[(u8 *)_1 + 44B]
	bl	IsMove		@
@ ReorderMoves.c:540: 	if (IsMove(moves[i])) {
	cmp	r0, #0	@ tmp175,
	beq	.L31		@,
@ ReorderMoves.c:541: 		DrawIcon(out + TILEMAP_INDEX(0, 0), GetItemIconId(moves[i]), TILEREF(0, 4)); 
	ldr	r3, .L37+20	@ tmp155,
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 44B], MEM[(u8 *)_1 + 44B]
	bl	.L15		@
	movs	r2, #128	@,
	movs	r1, r0	@ _16, tmp176
	ldr	r3, .L37+24	@ tmp157,
	movs	r0, r5	@, out
	lsls	r2, r2, #7	@,,
	bl	.L15		@
@ ReorderMoves.c:542: 		Text_SetXCursor(&command->text, item_name_offset);
	movs	r1, #16	@,
	ldr	r3, .L37+8	@ tmp182,
	movs	r0, r4	@, _10
	bl	.L15		@
@ ReorderMoves.c:543: 		if (i == proc->SelectedMoveIndex) {
	ldr	r1, [r7, #52]	@ proc_25->SelectedMoveIndex, proc_25->SelectedMoveIndex
	ldr	r3, .L37+28	@ tmp172,
	cmp	r1, #4	@ proc_25->SelectedMoveIndex,
	bne	.L32		@,
.L35:
@ ReorderMoves.c:546: 		else { Text_SetColorId(&command->text, TEXT_COLOR_NORMAL); }
	movs	r0, r4	@, _10
	bl	.L15		@
@ ReorderMoves.c:547: 		Text_DrawString(&command->text, GetItemName(moves[i])); 
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 44B], MEM[(u8 *)_1 + 44B]
	ldr	r3, .L37+32	@ tmp166,
	bl	.L15		@
	movs	r1, r0	@ _20, tmp177
.L36:
@ ReorderMoves.c:554: }
	@ sp needed	@
@ ReorderMoves.c:551: 		Text_DrawString(&command->text, " No Move");
	movs	r0, r4	@, _10
	ldr	r3, .L37+36	@ tmp170,
	bl	.L15		@
@ ReorderMoves.c:554: }
	pop	{r3, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L32:
@ ReorderMoves.c:546: 		else { Text_SetColorId(&command->text, TEXT_COLOR_NORMAL); }
	movs	r1, #0	@,
	b	.L35		@
.L31:
@ ReorderMoves.c:550: 		Text_SetColorId(&command->text, TEXT_COLOR_GRAY);
	movs	r1, #1	@,
	movs	r0, r4	@, _10
	ldr	r3, .L37+28	@ tmp168,
	bl	.L15		@
@ ReorderMoves.c:551: 		Text_DrawString(&command->text, " No Move");
	ldr	r1, .L37+40	@,
	b	.L36		@
.L38:
	.align	2
.L37:
	.word	gBg0MapBuffer
	.word	Text_Clear
	.word	Text_SetXCursor
	.word	Text_Display
	.word	LoadIconPalettes
	.word	GetItemIconId
	.word	DrawIcon
	.word	Text_SetColorId
	.word	GetItemName
	.word	Text_DrawString
	.word	.LC21
	.size	SkillListCommandDraw_5, .-SkillListCommandDraw_5
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	List_5_Idle, %function
List_5_Idle:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ ReorderMoves.c:341:     struct ReorderMovesProc* const proc = (void*) menu->parent;
	ldr	r4, [r0, #20]	@ proc, menu_15(D)->parent
@ ReorderMoves.c:345:     if (updated)
	ldr	r3, [r4, #48]	@ tmp159, proc_16->movesUpdated
@ ReorderMoves.c:340: {
	movs	r5, r0	@ menu, tmp155
@ ReorderMoves.c:342:     u8* const moves = UnitGetMoveList(proc->unit);	
	ldr	r6, [r4, #44]	@ _1, proc_16->unit
@ ReorderMoves.c:345:     if (updated)
	cmp	r3, #0	@ tmp159,
	beq	.L40		@,
@ ReorderMoves.c:347: 		SkillListCommandDraw_5(menu, command);
	bl	SkillListCommandDraw_5		@
@ ReorderMoves.c:348:         EnableBgSyncByMask(BG0_SYNC_BIT);
	movs	r0, #1	@,
	ldr	r3, .L52	@ tmp131,
	bl	.L15		@
.L40:
@ ReorderMoves.c:353: 	if (proc->move_hovering != 4)
	ldr	r3, [r4, #60]	@ tmp160, proc_16->move_hovering
	cmp	r3, #4	@ tmp160,
	beq	.L41		@,
@ ReorderMoves.c:355: 		proc->hover_move_Updated = TRUE;
	movs	r3, #1	@ tmp133,
	str	r3, [r4, #56]	@ tmp133, proc_16->hover_move_Updated
@ ReorderMoves.c:356: 		proc->move_hovering = 4;
	adds	r3, r3, #3	@ tmp134,
	str	r3, [r4, #60]	@ tmp134, proc_16->move_hovering
@ ReorderMoves.c:357: 		proc->movesUpdated = FALSE;
	movs	r3, #0	@ tmp135,
	str	r3, [r4, #48]	@ tmp135, proc_16->movesUpdated
.L41:
@ ReorderMoves.c:359: 	if (gKeyState.repeatedKeys & KEY_BUTTON_R) { 
	ldr	r3, .L52+4	@ tmp136,
@ ReorderMoves.c:359: 	if (gKeyState.repeatedKeys & KEY_BUTTON_R) { 
	ldrh	r3, [r3, #6]	@ tmp138,
	lsls	r3, r3, #23	@ tmp158, tmp138,
	bpl	.L42		@,
@ ReorderMoves.c:360: 		MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering]));
	ldr	r3, [r4, #60]	@ proc_16->move_hovering, proc_16->move_hovering
	adds	r6, r6, r3	@ tmp145, _1, proc_16->move_hovering
	adds	r6, r6, #40	@ tmp148,
@ ReorderMoves.c:360: 		MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering]));
	ldr	r3, .L52+8	@ tmp150,
	ldrb	r0, [r6]	@ *_6, *_6
	bl	.L15		@
@ ReorderMoves.c:360: 		MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering]));
	lsls	r1, r0, #16	@ tmp151, tmp157,
	ldr	r3, .L52+12	@ tmp153,
	movs	r0, r5	@, menu
	lsrs	r1, r1, #16	@ tmp151, tmp151,
	bl	.L15		@
.L42:
@ ReorderMoves.c:364: }
	@ sp needed	@
	movs	r0, #0	@,
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L53:
	.align	2
.L52:
	.word	EnableBgSyncByMask
	.word	gKeyState
	.word	GetItemDescId
	.word	MenuCallHelpBox
	.size	List_5_Idle, .-List_5_Idle
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	SkillListCommandDraw_4, %function
SkillListCommandDraw_4:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, lr}	@
@ ReorderMoves.c:495:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldrh	r3, [r1, #42]	@ tmp139,
	ldrh	r5, [r1, #44]	@ tmp137,
@ ReorderMoves.c:498:     Text_Clear(&command->text);
	adds	r1, r1, #52	@ command,
	movs	r4, r1	@ _10, command
@ ReorderMoves.c:495:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #5	@ tmp138, tmp137,
	adds	r5, r5, r3	@ tmp140, tmp138, tmp139
@ ReorderMoves.c:495:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldr	r3, .L61	@ tmp142,
@ ReorderMoves.c:491:     struct ReorderMovesProc* const proc = (void*) menu->parent;
	ldr	r7, [r0, #20]	@ proc, menu_24(D)->parent
@ ReorderMoves.c:495:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #1	@ tmp141, tmp140,
@ ReorderMoves.c:498:     Text_Clear(&command->text);
	movs	r0, r1	@, _10
@ ReorderMoves.c:495:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	adds	r5, r5, r3	@ out, tmp141, tmp142
@ ReorderMoves.c:498:     Text_Clear(&command->text);
	ldr	r3, .L61+4	@ tmp143,
@ ReorderMoves.c:493:     u8* const moves = UnitGetMoveList(proc->unit);
	ldr	r6, [r7, #44]	@ _1, proc_25->unit
@ ReorderMoves.c:498:     Text_Clear(&command->text);
	bl	.L15		@
@ ReorderMoves.c:499: 	Text_SetXCursor(&command->text, 0);
	movs	r1, #0	@,
	ldr	r3, .L61+8	@ tmp180,
	movs	r0, r4	@, _10
	bl	.L15		@
@ ReorderMoves.c:500: 	Text_Display(&command->text, out); 
	movs	r1, r5	@, out
	movs	r0, r4	@, _10
	ldr	r3, .L61+12	@ tmp145,
	bl	.L15		@
@ ReorderMoves.c:504: 	if (IsMove(moves[i])) {
	adds	r6, r6, #43	@ tmp149,
@ ReorderMoves.c:501:     LoadIconPalettes(4); /* Icon palette */
	movs	r0, #4	@,
	ldr	r3, .L61+16	@ tmp146,
	bl	.L15		@
@ ReorderMoves.c:504: 	if (IsMove(moves[i])) {
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 43B], MEM[(u8 *)_1 + 43B]
	bl	IsMove		@
@ ReorderMoves.c:504: 	if (IsMove(moves[i])) {
	cmp	r0, #0	@ tmp175,
	beq	.L55		@,
@ ReorderMoves.c:505: 		DrawIcon(out + TILEMAP_INDEX(0, 0), GetItemIconId(moves[i]), TILEREF(0, 4)); 
	ldr	r3, .L61+20	@ tmp155,
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 43B], MEM[(u8 *)_1 + 43B]
	bl	.L15		@
	movs	r2, #128	@,
	movs	r1, r0	@ _16, tmp176
	lsls	r2, r2, #7	@,,
	movs	r0, r5	@, out
	ldr	r3, .L61+24	@ tmp157,
	bl	.L15		@
@ ReorderMoves.c:506: 		Text_SetXCursor(&command->text, item_name_offset);
	movs	r1, #16	@,
	ldr	r3, .L61+8	@ tmp182,
	movs	r0, r4	@, _10
	bl	.L15		@
@ ReorderMoves.c:507: 		if (i == proc->SelectedMoveIndex) {
	ldr	r2, [r7, #52]	@ proc_25->SelectedMoveIndex, proc_25->SelectedMoveIndex
@ ReorderMoves.c:508: 			Text_SetColorId(&command->text, TEXT_COLOR_GREEN);
	movs	r1, #4	@,
	ldr	r3, .L61+28	@ tmp172,
@ ReorderMoves.c:507: 		if (i == proc->SelectedMoveIndex) {
	cmp	r2, #3	@ proc_25->SelectedMoveIndex,
	beq	.L59		@,
@ ReorderMoves.c:510: 		else { Text_SetColorId(&command->text, TEXT_COLOR_NORMAL); }
	movs	r1, #0	@,
.L59:
	movs	r0, r4	@, _10
	bl	.L15		@
@ ReorderMoves.c:511: 		Text_DrawString(&command->text, GetItemName(moves[i])); 
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 43B], MEM[(u8 *)_1 + 43B]
	ldr	r3, .L61+32	@ tmp166,
	bl	.L15		@
	movs	r1, r0	@ _20, tmp177
.L60:
@ ReorderMoves.c:518: }
	@ sp needed	@
@ ReorderMoves.c:515: 		Text_DrawString(&command->text, " No Move");
	movs	r0, r4	@, _10
	ldr	r3, .L61+36	@ tmp170,
	bl	.L15		@
@ ReorderMoves.c:518: }
	pop	{r3, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L55:
@ ReorderMoves.c:514: 		Text_SetColorId(&command->text, TEXT_COLOR_GRAY);
	movs	r1, #1	@,
	movs	r0, r4	@, _10
	ldr	r3, .L61+28	@ tmp168,
	bl	.L15		@
@ ReorderMoves.c:515: 		Text_DrawString(&command->text, " No Move");
	ldr	r1, .L61+40	@,
	b	.L60		@
.L62:
	.align	2
.L61:
	.word	gBg0MapBuffer
	.word	Text_Clear
	.word	Text_SetXCursor
	.word	Text_Display
	.word	LoadIconPalettes
	.word	GetItemIconId
	.word	DrawIcon
	.word	Text_SetColorId
	.word	GetItemName
	.word	Text_DrawString
	.word	.LC21
	.size	SkillListCommandDraw_4, .-SkillListCommandDraw_4
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	List_4_Idle, %function
List_4_Idle:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ ReorderMoves.c:314:     struct ReorderMovesProc* const proc = (void*) menu->parent;
	ldr	r4, [r0, #20]	@ proc, menu_15(D)->parent
@ ReorderMoves.c:318:     if (updated)
	ldr	r3, [r4, #48]	@ tmp159, proc_16->movesUpdated
@ ReorderMoves.c:313: {
	movs	r5, r0	@ menu, tmp155
@ ReorderMoves.c:315:     u8* const moves = UnitGetMoveList(proc->unit);		
	ldr	r6, [r4, #44]	@ _1, proc_16->unit
@ ReorderMoves.c:318:     if (updated)
	cmp	r3, #0	@ tmp159,
	beq	.L64		@,
@ ReorderMoves.c:320: 		SkillListCommandDraw_4(menu, command);
	bl	SkillListCommandDraw_4		@
@ ReorderMoves.c:321:         EnableBgSyncByMask(BG0_SYNC_BIT);
	movs	r0, #1	@,
	ldr	r3, .L76	@ tmp131,
	bl	.L15		@
.L64:
@ ReorderMoves.c:326: 	if (proc->move_hovering != 3)
	ldr	r3, [r4, #60]	@ tmp160, proc_16->move_hovering
	cmp	r3, #3	@ tmp160,
	beq	.L65		@,
@ ReorderMoves.c:328: 		proc->hover_move_Updated = TRUE;
	movs	r3, #1	@ tmp133,
	str	r3, [r4, #56]	@ tmp133, proc_16->hover_move_Updated
@ ReorderMoves.c:329: 		proc->move_hovering = 3;
	adds	r3, r3, #2	@ tmp134,
	str	r3, [r4, #60]	@ tmp134, proc_16->move_hovering
@ ReorderMoves.c:330: 		proc->movesUpdated = FALSE;
	movs	r3, #0	@ tmp135,
	str	r3, [r4, #48]	@ tmp135, proc_16->movesUpdated
.L65:
@ ReorderMoves.c:332: 	if (gKeyState.repeatedKeys & KEY_BUTTON_R) { 
	ldr	r3, .L76+4	@ tmp136,
@ ReorderMoves.c:332: 	if (gKeyState.repeatedKeys & KEY_BUTTON_R) { 
	ldrh	r3, [r3, #6]	@ tmp138,
	lsls	r3, r3, #23	@ tmp158, tmp138,
	bpl	.L66		@,
@ ReorderMoves.c:333: 		MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering]));
	ldr	r3, [r4, #60]	@ proc_16->move_hovering, proc_16->move_hovering
	adds	r6, r6, r3	@ tmp145, _1, proc_16->move_hovering
	adds	r6, r6, #40	@ tmp148,
@ ReorderMoves.c:333: 		MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering]));
	ldr	r3, .L76+8	@ tmp150,
	ldrb	r0, [r6]	@ *_6, *_6
	bl	.L15		@
@ ReorderMoves.c:333: 		MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering]));
	lsls	r1, r0, #16	@ tmp151, tmp157,
	ldr	r3, .L76+12	@ tmp153,
	movs	r0, r5	@, menu
	lsrs	r1, r1, #16	@ tmp151, tmp151,
	bl	.L15		@
.L66:
@ ReorderMoves.c:337: }
	@ sp needed	@
	movs	r0, #0	@,
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L77:
	.align	2
.L76:
	.word	EnableBgSyncByMask
	.word	gKeyState
	.word	GetItemDescId
	.word	MenuCallHelpBox
	.size	List_4_Idle, .-List_4_Idle
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	SkillListCommandDraw_3, %function
SkillListCommandDraw_3:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, lr}	@
@ ReorderMoves.c:465:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldrh	r3, [r1, #42]	@ tmp139,
	ldrh	r5, [r1, #44]	@ tmp137,
@ ReorderMoves.c:467:     Text_Clear(&command->text);
	adds	r1, r1, #52	@ command,
	movs	r4, r1	@ _10, command
@ ReorderMoves.c:465:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #5	@ tmp138, tmp137,
	adds	r5, r5, r3	@ tmp140, tmp138, tmp139
@ ReorderMoves.c:465:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldr	r3, .L85	@ tmp142,
@ ReorderMoves.c:461:     struct ReorderMovesProc* const proc = (void*) menu->parent;
	ldr	r7, [r0, #20]	@ proc, menu_24(D)->parent
@ ReorderMoves.c:465:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #1	@ tmp141, tmp140,
@ ReorderMoves.c:467:     Text_Clear(&command->text);
	movs	r0, r1	@, _10
@ ReorderMoves.c:465:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	adds	r5, r5, r3	@ out, tmp141, tmp142
@ ReorderMoves.c:467:     Text_Clear(&command->text);
	ldr	r3, .L85+4	@ tmp143,
@ ReorderMoves.c:463:     u8* const moves = UnitGetMoveList(proc->unit);
	ldr	r6, [r7, #44]	@ _1, proc_25->unit
@ ReorderMoves.c:467:     Text_Clear(&command->text);
	bl	.L15		@
@ ReorderMoves.c:468: 	Text_SetXCursor(&command->text, 0);
	movs	r1, #0	@,
	ldr	r3, .L85+8	@ tmp180,
	movs	r0, r4	@, _10
	bl	.L15		@
@ ReorderMoves.c:469: 	Text_Display(&command->text, out); 
	movs	r1, r5	@, out
	movs	r0, r4	@, _10
	ldr	r3, .L85+12	@ tmp145,
	bl	.L15		@
@ ReorderMoves.c:473: 	if (IsMove(moves[i])) {
	adds	r6, r6, #42	@ tmp149,
@ ReorderMoves.c:470:     LoadIconPalettes(4); /* Icon palette */
	movs	r0, #4	@,
	ldr	r3, .L85+16	@ tmp146,
	bl	.L15		@
@ ReorderMoves.c:473: 	if (IsMove(moves[i])) {
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 42B], MEM[(u8 *)_1 + 42B]
	bl	IsMove		@
@ ReorderMoves.c:473: 	if (IsMove(moves[i])) {
	cmp	r0, #0	@ tmp175,
	beq	.L79		@,
@ ReorderMoves.c:474: 		DrawIcon(out + TILEMAP_INDEX(0, 0), GetItemIconId(moves[i]), TILEREF(0, 4)); 
	ldr	r3, .L85+20	@ tmp155,
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 42B], MEM[(u8 *)_1 + 42B]
	bl	.L15		@
	movs	r2, #128	@,
	movs	r1, r0	@ _16, tmp176
	lsls	r2, r2, #7	@,,
	movs	r0, r5	@, out
	ldr	r3, .L85+24	@ tmp157,
	bl	.L15		@
@ ReorderMoves.c:475: 		Text_SetXCursor(&command->text, item_name_offset);
	movs	r1, #16	@,
	ldr	r3, .L85+8	@ tmp182,
	movs	r0, r4	@, _10
	bl	.L15		@
@ ReorderMoves.c:476: 		if (i == proc->SelectedMoveIndex) {
	ldr	r2, [r7, #52]	@ proc_25->SelectedMoveIndex, proc_25->SelectedMoveIndex
@ ReorderMoves.c:477: 			Text_SetColorId(&command->text, TEXT_COLOR_GREEN);
	movs	r1, #4	@,
	ldr	r3, .L85+28	@ tmp172,
@ ReorderMoves.c:476: 		if (i == proc->SelectedMoveIndex) {
	cmp	r2, #2	@ proc_25->SelectedMoveIndex,
	beq	.L83		@,
@ ReorderMoves.c:479: 		else { Text_SetColorId(&command->text, TEXT_COLOR_NORMAL); }
	movs	r1, #0	@,
.L83:
	movs	r0, r4	@, _10
	bl	.L15		@
@ ReorderMoves.c:480: 		Text_DrawString(&command->text, GetItemName(moves[i])); 
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 42B], MEM[(u8 *)_1 + 42B]
	ldr	r3, .L85+32	@ tmp166,
	bl	.L15		@
	movs	r1, r0	@ _20, tmp177
.L84:
@ ReorderMoves.c:487: }
	@ sp needed	@
@ ReorderMoves.c:484: 		Text_DrawString(&command->text, " No Move");
	movs	r0, r4	@, _10
	ldr	r3, .L85+36	@ tmp170,
	bl	.L15		@
@ ReorderMoves.c:487: }
	pop	{r3, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L79:
@ ReorderMoves.c:483: 		Text_SetColorId(&command->text, TEXT_COLOR_GRAY);
	movs	r1, #1	@,
	movs	r0, r4	@, _10
	ldr	r3, .L85+28	@ tmp168,
	bl	.L15		@
@ ReorderMoves.c:484: 		Text_DrawString(&command->text, " No Move");
	ldr	r1, .L85+40	@,
	b	.L84		@
.L86:
	.align	2
.L85:
	.word	gBg0MapBuffer
	.word	Text_Clear
	.word	Text_SetXCursor
	.word	Text_Display
	.word	LoadIconPalettes
	.word	GetItemIconId
	.word	DrawIcon
	.word	Text_SetColorId
	.word	GetItemName
	.word	Text_DrawString
	.word	.LC21
	.size	SkillListCommandDraw_3, .-SkillListCommandDraw_3
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	List_3_Idle, %function
List_3_Idle:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ ReorderMoves.c:287:     struct ReorderMovesProc* const proc = (void*) menu->parent;
	ldr	r4, [r0, #20]	@ proc, menu_15(D)->parent
@ ReorderMoves.c:291:     if (updated)
	ldr	r3, [r4, #48]	@ tmp159, proc_16->movesUpdated
@ ReorderMoves.c:286: {
	movs	r5, r0	@ menu, tmp155
@ ReorderMoves.c:288:     u8* const moves = UnitGetMoveList(proc->unit);		
	ldr	r6, [r4, #44]	@ _1, proc_16->unit
@ ReorderMoves.c:291:     if (updated)
	cmp	r3, #0	@ tmp159,
	beq	.L88		@,
@ ReorderMoves.c:293: 		SkillListCommandDraw_3(menu, command);
	bl	SkillListCommandDraw_3		@
@ ReorderMoves.c:294:         EnableBgSyncByMask(BG0_SYNC_BIT);
	movs	r0, #1	@,
	ldr	r3, .L100	@ tmp131,
	bl	.L15		@
.L88:
@ ReorderMoves.c:298: 	if (proc->move_hovering != 2)
	ldr	r3, [r4, #60]	@ tmp160, proc_16->move_hovering
	cmp	r3, #2	@ tmp160,
	beq	.L89		@,
@ ReorderMoves.c:300: 		proc->hover_move_Updated = TRUE;
	movs	r3, #1	@ tmp133,
	str	r3, [r4, #56]	@ tmp133, proc_16->hover_move_Updated
@ ReorderMoves.c:301: 		proc->move_hovering = 2;
	adds	r3, r3, r3	@ tmp134, tmp134,
	str	r3, [r4, #60]	@ tmp134, proc_16->move_hovering
@ ReorderMoves.c:302: 		proc->movesUpdated = FALSE;
	movs	r3, #0	@ tmp135,
	str	r3, [r4, #48]	@ tmp135, proc_16->movesUpdated
.L89:
@ ReorderMoves.c:304: 	if (gKeyState.repeatedKeys & KEY_BUTTON_R) { 
	ldr	r3, .L100+4	@ tmp136,
@ ReorderMoves.c:304: 	if (gKeyState.repeatedKeys & KEY_BUTTON_R) { 
	ldrh	r3, [r3, #6]	@ tmp138,
	lsls	r3, r3, #23	@ tmp158, tmp138,
	bpl	.L90		@,
@ ReorderMoves.c:305: 		MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering]));
	ldr	r3, [r4, #60]	@ proc_16->move_hovering, proc_16->move_hovering
	adds	r6, r6, r3	@ tmp145, _1, proc_16->move_hovering
	adds	r6, r6, #40	@ tmp148,
@ ReorderMoves.c:305: 		MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering]));
	ldr	r3, .L100+8	@ tmp150,
	ldrb	r0, [r6]	@ *_6, *_6
	bl	.L15		@
@ ReorderMoves.c:305: 		MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering]));
	lsls	r1, r0, #16	@ tmp151, tmp157,
	ldr	r3, .L100+12	@ tmp153,
	movs	r0, r5	@, menu
	lsrs	r1, r1, #16	@ tmp151, tmp151,
	bl	.L15		@
.L90:
@ ReorderMoves.c:310: }
	@ sp needed	@
	movs	r0, #0	@,
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L101:
	.align	2
.L100:
	.word	EnableBgSyncByMask
	.word	gKeyState
	.word	GetItemDescId
	.word	MenuCallHelpBox
	.size	List_3_Idle, .-List_3_Idle
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	SkillListCommandDraw_2, %function
SkillListCommandDraw_2:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, lr}	@
@ ReorderMoves.c:435:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldrh	r3, [r1, #42]	@ tmp139,
	ldrh	r5, [r1, #44]	@ tmp137,
@ ReorderMoves.c:437:     Text_Clear(&command->text);
	adds	r1, r1, #52	@ command,
	movs	r4, r1	@ _10, command
@ ReorderMoves.c:435:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #5	@ tmp138, tmp137,
	adds	r5, r5, r3	@ tmp140, tmp138, tmp139
@ ReorderMoves.c:435:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldr	r3, .L109	@ tmp142,
@ ReorderMoves.c:431:     struct ReorderMovesProc* const proc = (void*) menu->parent;
	ldr	r7, [r0, #20]	@ proc, menu_24(D)->parent
@ ReorderMoves.c:435:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #1	@ tmp141, tmp140,
@ ReorderMoves.c:437:     Text_Clear(&command->text);
	movs	r0, r1	@, _10
@ ReorderMoves.c:435:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	adds	r5, r5, r3	@ out, tmp141, tmp142
@ ReorderMoves.c:437:     Text_Clear(&command->text);
	ldr	r3, .L109+4	@ tmp143,
@ ReorderMoves.c:433:     u8* const moves = UnitGetMoveList(proc->unit);
	ldr	r6, [r7, #44]	@ _1, proc_25->unit
@ ReorderMoves.c:437:     Text_Clear(&command->text);
	bl	.L15		@
@ ReorderMoves.c:438: 	Text_SetXCursor(&command->text, 0);
	movs	r1, #0	@,
	ldr	r3, .L109+8	@ tmp180,
	movs	r0, r4	@, _10
	bl	.L15		@
@ ReorderMoves.c:439: 	Text_Display(&command->text, out); 
	movs	r1, r5	@, out
	movs	r0, r4	@, _10
	ldr	r3, .L109+12	@ tmp145,
	bl	.L15		@
@ ReorderMoves.c:443: 	if (IsMove(moves[i])) {
	adds	r6, r6, #41	@ tmp149,
@ ReorderMoves.c:440:     LoadIconPalettes(4); /* Icon palette */
	movs	r0, #4	@,
	ldr	r3, .L109+16	@ tmp146,
	bl	.L15		@
@ ReorderMoves.c:443: 	if (IsMove(moves[i])) {
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 41B], MEM[(u8 *)_1 + 41B]
	bl	IsMove		@
@ ReorderMoves.c:443: 	if (IsMove(moves[i])) {
	cmp	r0, #0	@ tmp175,
	beq	.L103		@,
@ ReorderMoves.c:444: 		DrawIcon(out + TILEMAP_INDEX(0, 0), GetItemIconId(moves[i]), TILEREF(0, 4)); 
	ldr	r3, .L109+20	@ tmp155,
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 41B], MEM[(u8 *)_1 + 41B]
	bl	.L15		@
	movs	r2, #128	@,
	movs	r1, r0	@ _16, tmp176
	lsls	r2, r2, #7	@,,
	movs	r0, r5	@, out
	ldr	r3, .L109+24	@ tmp157,
	bl	.L15		@
@ ReorderMoves.c:445: 		Text_SetXCursor(&command->text, item_name_offset);
	movs	r1, #16	@,
	ldr	r3, .L109+8	@ tmp182,
	movs	r0, r4	@, _10
	bl	.L15		@
@ ReorderMoves.c:446: 		if (i == proc->SelectedMoveIndex) {
	ldr	r2, [r7, #52]	@ proc_25->SelectedMoveIndex, proc_25->SelectedMoveIndex
@ ReorderMoves.c:447: 			Text_SetColorId(&command->text, TEXT_COLOR_GREEN);
	movs	r1, #4	@,
	ldr	r3, .L109+28	@ tmp172,
@ ReorderMoves.c:446: 		if (i == proc->SelectedMoveIndex) {
	cmp	r2, #1	@ proc_25->SelectedMoveIndex,
	beq	.L107		@,
@ ReorderMoves.c:449: 		else { Text_SetColorId(&command->text, TEXT_COLOR_NORMAL); }
	movs	r1, #0	@,
.L107:
	movs	r0, r4	@, _10
	bl	.L15		@
@ ReorderMoves.c:450: 		Text_DrawString(&command->text, GetItemName(moves[i])); 
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 41B], MEM[(u8 *)_1 + 41B]
	ldr	r3, .L109+32	@ tmp166,
	bl	.L15		@
	movs	r1, r0	@ _20, tmp177
.L108:
@ ReorderMoves.c:457: }
	@ sp needed	@
@ ReorderMoves.c:454: 		Text_DrawString(&command->text, " No Move");
	movs	r0, r4	@, _10
	ldr	r3, .L109+36	@ tmp170,
	bl	.L15		@
@ ReorderMoves.c:457: }
	pop	{r3, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L103:
@ ReorderMoves.c:453: 		Text_SetColorId(&command->text, TEXT_COLOR_GRAY);
	movs	r1, #1	@,
	movs	r0, r4	@, _10
	ldr	r3, .L109+28	@ tmp168,
	bl	.L15		@
@ ReorderMoves.c:454: 		Text_DrawString(&command->text, " No Move");
	ldr	r1, .L109+40	@,
	b	.L108		@
.L110:
	.align	2
.L109:
	.word	gBg0MapBuffer
	.word	Text_Clear
	.word	Text_SetXCursor
	.word	Text_Display
	.word	LoadIconPalettes
	.word	GetItemIconId
	.word	DrawIcon
	.word	Text_SetColorId
	.word	GetItemName
	.word	Text_DrawString
	.word	.LC21
	.size	SkillListCommandDraw_2, .-SkillListCommandDraw_2
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	List_2_Idle, %function
List_2_Idle:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ ReorderMoves.c:261:     struct ReorderMovesProc* const proc = (void*) menu->parent;
	ldr	r4, [r0, #20]	@ proc, menu_15(D)->parent
@ ReorderMoves.c:264:     if (updated)
	ldr	r3, [r4, #48]	@ tmp159, proc_16->movesUpdated
@ ReorderMoves.c:260: {
	movs	r5, r0	@ menu, tmp155
@ ReorderMoves.c:264:     if (updated)
	cmp	r3, #0	@ tmp159,
	beq	.L112		@,
@ ReorderMoves.c:266: 		SkillListCommandDraw_2(menu, command);
	bl	SkillListCommandDraw_2		@
@ ReorderMoves.c:267:         EnableBgSyncByMask(BG0_SYNC_BIT);
	movs	r0, #1	@,
	ldr	r3, .L124	@ tmp131,
	bl	.L15		@
.L112:
@ ReorderMoves.c:272: 	if (proc->move_hovering != 1)
	ldr	r2, [r4, #60]	@ tmp160, proc_16->move_hovering
@ ReorderMoves.c:271:     u8* const moves = UnitGetMoveList(proc->unit);		
	ldr	r3, [r4, #44]	@ _1, proc_16->unit
@ ReorderMoves.c:272: 	if (proc->move_hovering != 1)
	cmp	r2, #1	@ tmp160,
	beq	.L113		@,
@ ReorderMoves.c:274: 		proc->hover_move_Updated = TRUE;
	movs	r2, #1	@ tmp133,
	str	r2, [r4, #56]	@ tmp133, proc_16->hover_move_Updated
@ ReorderMoves.c:275: 		proc->move_hovering = 1;
	str	r2, [r4, #60]	@ tmp133, proc_16->move_hovering
@ ReorderMoves.c:276: 		proc->movesUpdated = FALSE;
	movs	r2, #0	@ tmp135,
	str	r2, [r4, #48]	@ tmp135, proc_16->movesUpdated
.L113:
@ ReorderMoves.c:278: 	if (gKeyState.repeatedKeys & KEY_BUTTON_R) { 
	ldr	r2, .L124+4	@ tmp136,
@ ReorderMoves.c:278: 	if (gKeyState.repeatedKeys & KEY_BUTTON_R) { 
	ldrh	r2, [r2, #6]	@ tmp138,
	lsls	r2, r2, #23	@ tmp158, tmp138,
	bpl	.L114		@,
@ ReorderMoves.c:279: 		MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering]));
	ldr	r2, [r4, #60]	@ proc_16->move_hovering, proc_16->move_hovering
	adds	r3, r3, r2	@ tmp145, _1, proc_16->move_hovering
	adds	r3, r3, #40	@ tmp148,
@ ReorderMoves.c:279: 		MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering]));
	ldrb	r0, [r3]	@ *_6, *_6
	ldr	r3, .L124+8	@ tmp150,
	bl	.L15		@
@ ReorderMoves.c:279: 		MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering]));
	lsls	r1, r0, #16	@ tmp151, tmp157,
	ldr	r3, .L124+12	@ tmp153,
	movs	r0, r5	@, menu
	lsrs	r1, r1, #16	@ tmp151, tmp151,
	bl	.L15		@
.L114:
@ ReorderMoves.c:283: }
	@ sp needed	@
	movs	r0, #0	@,
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L125:
	.align	2
.L124:
	.word	EnableBgSyncByMask
	.word	gKeyState
	.word	GetItemDescId
	.word	MenuCallHelpBox
	.size	List_2_Idle, .-List_2_Idle
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	SkillListCommandDraw_1, %function
SkillListCommandDraw_1:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, lr}	@
@ ReorderMoves.c:406:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldrh	r3, [r1, #42]	@ tmp139,
	ldrh	r5, [r1, #44]	@ tmp137,
@ ReorderMoves.c:408:     Text_Clear(&command->text);
	adds	r1, r1, #52	@ command,
	movs	r4, r1	@ _10, command
@ ReorderMoves.c:406:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #5	@ tmp138, tmp137,
	adds	r5, r5, r3	@ tmp140, tmp138, tmp139
@ ReorderMoves.c:406:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldr	r3, .L133	@ tmp142,
@ ReorderMoves.c:402:     struct ReorderMovesProc* const proc = (void*) menu->parent;
	ldr	r7, [r0, #20]	@ proc, menu_24(D)->parent
@ ReorderMoves.c:406:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #1	@ tmp141, tmp140,
@ ReorderMoves.c:408:     Text_Clear(&command->text);
	movs	r0, r1	@, _10
@ ReorderMoves.c:406:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	adds	r5, r5, r3	@ out, tmp141, tmp142
@ ReorderMoves.c:408:     Text_Clear(&command->text);
	ldr	r3, .L133+4	@ tmp143,
@ ReorderMoves.c:404:     u8* const moves = UnitGetMoveList(proc->unit);
	ldr	r6, [r7, #44]	@ _1, proc_25->unit
@ ReorderMoves.c:408:     Text_Clear(&command->text);
	bl	.L15		@
@ ReorderMoves.c:409: 	Text_SetXCursor(&command->text, 0);
	movs	r1, #0	@,
	ldr	r3, .L133+8	@ tmp180,
	movs	r0, r4	@, _10
	bl	.L15		@
@ ReorderMoves.c:410: 	Text_Display(&command->text, out); 
	movs	r1, r5	@, out
	movs	r0, r4	@, _10
	ldr	r3, .L133+12	@ tmp145,
	bl	.L15		@
@ ReorderMoves.c:413: 	if (IsMove(moves[i])) {
	adds	r6, r6, #40	@ tmp149,
@ ReorderMoves.c:411:     LoadIconPalettes(4); /* Icon palette */
	movs	r0, #4	@,
	ldr	r3, .L133+16	@ tmp146,
	bl	.L15		@
@ ReorderMoves.c:413: 	if (IsMove(moves[i])) {
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 40B], MEM[(u8 *)_1 + 40B]
	bl	IsMove		@
@ ReorderMoves.c:413: 	if (IsMove(moves[i])) {
	cmp	r0, #0	@ tmp175,
	beq	.L127		@,
@ ReorderMoves.c:414: 		DrawIcon(out + TILEMAP_INDEX(0, 0), GetItemIconId(moves[i]), TILEREF(0, 4)); 
	ldr	r3, .L133+20	@ tmp155,
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 40B], MEM[(u8 *)_1 + 40B]
	bl	.L15		@
	movs	r2, #128	@,
	movs	r1, r0	@ _16, tmp176
	lsls	r2, r2, #7	@,,
	movs	r0, r5	@, out
	ldr	r3, .L133+24	@ tmp157,
	bl	.L15		@
@ ReorderMoves.c:415: 		Text_SetXCursor(&command->text, item_name_offset);
	movs	r1, #16	@,
	ldr	r3, .L133+8	@ tmp182,
	movs	r0, r4	@, _10
	bl	.L15		@
@ ReorderMoves.c:416: 		if (i == proc->SelectedMoveIndex) {
	ldr	r2, [r7, #52]	@ proc_25->SelectedMoveIndex, proc_25->SelectedMoveIndex
@ ReorderMoves.c:417: 			Text_SetColorId(&command->text, TEXT_COLOR_GREEN);
	movs	r1, #4	@,
	ldr	r3, .L133+28	@ tmp172,
@ ReorderMoves.c:416: 		if (i == proc->SelectedMoveIndex) {
	cmp	r2, #0	@ proc_25->SelectedMoveIndex,
	beq	.L131		@,
@ ReorderMoves.c:419: 		else { Text_SetColorId(&command->text, TEXT_COLOR_NORMAL); }
	movs	r1, #0	@,
.L131:
	movs	r0, r4	@, _10
	bl	.L15		@
@ ReorderMoves.c:420: 		Text_DrawString(&command->text, GetItemName(moves[i])); 
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 40B], MEM[(u8 *)_1 + 40B]
	ldr	r3, .L133+32	@ tmp166,
	bl	.L15		@
	movs	r1, r0	@ _20, tmp177
.L132:
@ ReorderMoves.c:427: }
	@ sp needed	@
@ ReorderMoves.c:424: 		Text_DrawString(&command->text, " No Move");
	movs	r0, r4	@, _10
	ldr	r3, .L133+36	@ tmp170,
	bl	.L15		@
@ ReorderMoves.c:427: }
	pop	{r3, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L127:
@ ReorderMoves.c:423: 		Text_SetColorId(&command->text, TEXT_COLOR_GRAY);
	movs	r1, #1	@,
	movs	r0, r4	@, _10
	ldr	r3, .L133+28	@ tmp168,
	bl	.L15		@
@ ReorderMoves.c:424: 		Text_DrawString(&command->text, " No Move");
	ldr	r1, .L133+40	@,
	b	.L132		@
.L134:
	.align	2
.L133:
	.word	gBg0MapBuffer
	.word	Text_Clear
	.word	Text_SetXCursor
	.word	Text_Display
	.word	LoadIconPalettes
	.word	GetItemIconId
	.word	DrawIcon
	.word	Text_SetColorId
	.word	GetItemName
	.word	Text_DrawString
	.word	.LC21
	.size	SkillListCommandDraw_1, .-SkillListCommandDraw_1
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	List_1_Idle, %function
List_1_Idle:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ ReorderMoves.c:233:     struct ReorderMovesProc* const proc = (void*) menu->parent;
	ldr	r4, [r0, #20]	@ proc, menu_15(D)->parent
@ ReorderMoves.c:237:     if (updated)
	ldr	r3, [r4, #48]	@ tmp159, proc_16->movesUpdated
@ ReorderMoves.c:232: {
	movs	r5, r0	@ menu, tmp155
@ ReorderMoves.c:234:     u8* const moves = UnitGetMoveList(proc->unit);		
	ldr	r6, [r4, #44]	@ _1, proc_16->unit
@ ReorderMoves.c:237:     if (updated)
	cmp	r3, #0	@ tmp159,
	beq	.L136		@,
@ ReorderMoves.c:239: 		SkillListCommandDraw_1(menu, command);
	bl	SkillListCommandDraw_1		@
@ ReorderMoves.c:240:         EnableBgSyncByMask(BG0_SYNC_BIT);
	movs	r0, #1	@,
	ldr	r3, .L148	@ tmp131,
	bl	.L15		@
.L136:
@ ReorderMoves.c:244: 	if (proc->move_hovering != 0)
	ldr	r3, [r4, #60]	@ tmp160, proc_16->move_hovering
	cmp	r3, #0	@ tmp160,
	beq	.L137		@,
@ ReorderMoves.c:246: 		proc->hover_move_Updated = TRUE;
	movs	r3, #1	@ tmp133,
	str	r3, [r4, #56]	@ tmp133, proc_16->hover_move_Updated
@ ReorderMoves.c:247: 		proc->move_hovering = 0;
	movs	r3, #0	@ tmp134,
	str	r3, [r4, #60]	@ tmp134, proc_16->move_hovering
@ ReorderMoves.c:248: 		proc->movesUpdated = FALSE;
	str	r3, [r4, #48]	@ tmp134, proc_16->movesUpdated
.L137:
@ ReorderMoves.c:250: 	if (gKeyState.repeatedKeys & KEY_BUTTON_R) { 
	ldr	r3, .L148+4	@ tmp136,
@ ReorderMoves.c:250: 	if (gKeyState.repeatedKeys & KEY_BUTTON_R) { 
	ldrh	r3, [r3, #6]	@ tmp138,
	lsls	r3, r3, #23	@ tmp158, tmp138,
	bpl	.L138		@,
@ ReorderMoves.c:251: 		MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering]));
	ldr	r3, [r4, #60]	@ proc_16->move_hovering, proc_16->move_hovering
	adds	r6, r6, r3	@ tmp145, _1, proc_16->move_hovering
	adds	r6, r6, #40	@ tmp148,
@ ReorderMoves.c:251: 		MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering]));
	ldr	r3, .L148+8	@ tmp150,
	ldrb	r0, [r6]	@ *_6, *_6
	bl	.L15		@
@ ReorderMoves.c:251: 		MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering]));
	lsls	r1, r0, #16	@ tmp151, tmp157,
	ldr	r3, .L148+12	@ tmp153,
	movs	r0, r5	@, menu
	lsrs	r1, r1, #16	@ tmp151, tmp151,
	bl	.L15		@
.L138:
@ ReorderMoves.c:256: }
	@ sp needed	@
	movs	r0, #0	@,
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L149:
	.align	2
.L148:
	.word	EnableBgSyncByMask
	.word	gKeyState
	.word	GetItemDescId
	.word	MenuCallHelpBox
	.size	List_1_Idle, .-List_1_Idle
	.align	1
	.global	ReorderMovesEffect
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	ReorderMovesEffect, %function
ReorderMovesEffect:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r0, r1, r4, r5, r6, lr}	@
@ ReorderMoves.c:213:     struct ReorderMovesProc* proc = (void*) ProcStart(Proc_ReorderMoves, ROOT_PROC_3);
	ldr	r6, .L151	@ tmp120,
@ ReorderMoves.c:226: }
	@ sp needed	@
@ ReorderMoves.c:213:     struct ReorderMovesProc* proc = (void*) ProcStart(Proc_ReorderMoves, ROOT_PROC_3);
	movs	r0, r6	@, tmp120
	movs	r1, #3	@,
	ldr	r3, .L151+4	@ tmp121,
	bl	.L15		@
@ ReorderMoves.c:215:     proc->unit = gActiveUnit;
	ldr	r3, .L151+8	@ tmp122,
	ldr	r3, [r3]	@ tmp137, gActiveUnit
@ ReorderMoves.c:217:     proc->movesUpdated = FALSE;
	movs	r5, #0	@ tmp124,
@ ReorderMoves.c:215:     proc->unit = gActiveUnit;
	str	r3, [r0, #44]	@ tmp137, proc_6->unit
@ ReorderMoves.c:218:     proc->SelectedMoveIndex = 255;
	movs	r3, #255	@ tmp125,
@ ReorderMoves.c:213:     struct ReorderMovesProc* proc = (void*) ProcStart(Proc_ReorderMoves, ROOT_PROC_3);
	movs	r4, r0	@ proc, tmp135
@ ReorderMoves.c:217:     proc->movesUpdated = FALSE;
	str	r5, [r0, #48]	@ tmp124, proc_6->movesUpdated
@ ReorderMoves.c:221: 	proc->hover_move_Updated = FALSE; 
	str	r5, [r0, #56]	@ tmp124, proc_6->hover_move_Updated
@ ReorderMoves.c:222: 	proc->move_hovering = 0;
	str	r5, [r0, #60]	@ tmp124, proc_6->move_hovering
@ ReorderMoves.c:218:     proc->SelectedMoveIndex = 255;
	str	r3, [r0, #52]	@ tmp125, proc_6->SelectedMoveIndex
@ ReorderMoves.c:223:     StartMenuChild(&Menu_SkillDebug, (void*) proc);
	movs	r0, r6	@ tmp120, tmp120
	movs	r1, r4	@, proc
	ldr	r3, .L151+12	@ tmp130,
	adds	r0, r0, #32	@ tmp120,
	bl	.L15		@
@ ReorderMoves.c:224: 	StartFace(0, GetUnitPortraitId(proc->unit), 72, 16, 3);
	ldr	r0, [r4, #44]	@, proc_6->unit
	ldr	r3, .L151+16	@ tmp131,
	bl	.L15		@
	movs	r3, #3	@ tmp132,
	movs	r1, r0	@ _3, tmp136
	str	r3, [sp]	@ tmp132,
	movs	r0, r5	@, tmp124
	movs	r2, #72	@,
	ldr	r4, .L151+20	@ tmp133,
	adds	r3, r3, #13	@,
	bl	.L153		@
@ ReorderMoves.c:226: }
	movs	r0, #23	@,
	pop	{r1, r2, r4, r5, r6}
	pop	{r1}
	bx	r1
.L152:
	.align	2
.L151:
	.word	.LANCHOR0
	.word	ProcStart
	.word	gActiveUnit
	.word	StartMenuChild
	.word	GetUnitPortraitId
	.word	StartFace
	.size	ReorderMovesEffect, .-ReorderMovesEffect
	.section	.rodata
	.align	2
	.set	.LANCHOR0,. + 0
	.type	Proc_ReorderMoves, %object
	.size	Proc_ReorderMoves, 32
Proc_ReorderMoves:
@ type:
	.short	2
@ sArg:
	.short	0
@ lArg:
	.word	LockGameLogic
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
	.short	0
@ sArg:
	.short	0
@ lArg:
	.word	0
	.type	Menu_SkillDebug, %object
	.size	Menu_SkillDebug, 36
Menu_SkillDebug:
@ geometry:
@ x:
	.byte	1
@ y:
	.byte	0
@ h:
	.byte	12
	.space	1
@ commandList:
	.space	4
	.word	MenuCommands_SkillDebug
@ onEnd:
	.word	SkillDebugMenuEnd
@ onBPress:
	.space	8
	.word	134359137
	.space	8
	.type	MenuCommands_SkillDebug, %object
	.size	MenuCommands_SkillDebug, 252
MenuCommands_SkillDebug:
@ isAvailable:
	.space	12
	.word	MenuCommandAlwaysUsable
@ onDraw:
	.word	ReplaceSkillCommandDraw
@ onEffect:
	.word	SkillListCommandSelect
	.space	12
@ isAvailable:
	.space	12
	.word	MenuCommandAlwaysUsable
@ onDraw:
	.word	SkillListCommandDraw_1
@ onEffect:
	.word	MoveCommandSelect
@ onIdle:
	.word	List_1_Idle
	.space	8
@ isAvailable:
	.space	12
	.word	MenuCommandAlwaysUsable
@ onDraw:
	.word	SkillListCommandDraw_2
@ onEffect:
	.word	MoveCommandSelect
@ onIdle:
	.word	List_2_Idle
	.space	8
@ isAvailable:
	.space	12
	.word	MenuCommandAlwaysUsable
@ onDraw:
	.word	SkillListCommandDraw_3
@ onEffect:
	.word	MoveCommandSelect
@ onIdle:
	.word	List_3_Idle
	.space	8
@ isAvailable:
	.space	12
	.word	MenuCommandAlwaysUsable
@ onDraw:
	.word	SkillListCommandDraw_4
@ onEffect:
	.word	MoveCommandSelect
@ onIdle:
	.word	List_4_Idle
	.space	8
@ isAvailable:
	.space	12
	.word	MenuCommandAlwaysUsable
@ onDraw:
	.word	SkillListCommandDraw_5
@ onEffect:
	.word	MoveCommandSelect
@ onIdle:
	.word	List_5_Idle
	.space	8
	.space	36
	.ident	"GCC: (devkitARM release 54) 10.1.0"
	.text
	.code 16
	.align	1
.L15:
	bx	r3
.L153:
	bx	r4
