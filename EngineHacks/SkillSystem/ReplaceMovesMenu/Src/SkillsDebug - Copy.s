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
	.file	"SkillsDebug.c"
@ GNU C17 (devkitARM release 54) version 10.1.0 (arm-none-eabi)
@	compiled by GNU C version 6.4.0, GMP version 6.0.0, MPFR version 3.1.2, MPC version 1.0.2, isl version none
@ GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
@ options passed:  -imultilib thumb
@ -iprefix c:\devkitpro\devkitarm\bin\../lib/gcc/arm-none-eabi/10.1.0/
@ -D__USES_INITFINI__ SkillsDebug.c -mcpu=arm7tdmi -mthumb
@ -mthumb-interwork -mtune=arm7tdmi -mlong-calls -march=armv4t
@ -auxbase-strip SkillsDebug.s -Os -Wall -fverbose-asm
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
	.type	List_1_Idle, %function
List_1_Idle:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
@ SkillsDebug.c:441:     struct SkillDebugProc* const proc = (void*) menu->parent;
	ldr	r3, [r0, #20]	@ proc, menu_4(D)->parent
@ SkillsDebug.c:443: 	if (proc->move_hovering != 0)
	ldr	r2, [r3, #68]	@ tmp123, proc_5->move_hovering
	cmp	r2, #0	@ tmp123,
	beq	.L2		@,
@ SkillsDebug.c:445: 		proc->hover_move_Updated = TRUE;
	movs	r2, #1	@ tmp119,
	str	r2, [r3, #64]	@ tmp119, proc_5->hover_move_Updated
@ SkillsDebug.c:446: 		proc->move_hovering = 0;
	movs	r2, #0	@ tmp120,
	str	r2, [r3, #68]	@ tmp120, proc_5->move_hovering
.L2:
@ SkillsDebug.c:450: }
	@ sp needed	@
	movs	r0, #0	@,
	bx	lr
	.size	List_1_Idle, .-List_1_Idle
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
	@ link register save eliminated.
@ SkillsDebug.c:455:     struct SkillDebugProc* const proc = (void*) menu->parent;
	ldr	r3, [r0, #20]	@ proc, menu_4(D)->parent
@ SkillsDebug.c:457: 	if (proc->move_hovering != 1)
	ldr	r2, [r3, #68]	@ tmp123, proc_5->move_hovering
	cmp	r2, #1	@ tmp123,
	beq	.L7		@,
@ SkillsDebug.c:459: 		proc->hover_move_Updated = TRUE;
	movs	r2, #1	@ tmp119,
	str	r2, [r3, #64]	@ tmp119, proc_5->hover_move_Updated
@ SkillsDebug.c:460: 		proc->move_hovering = 1;
	str	r2, [r3, #68]	@ tmp119, proc_5->move_hovering
.L7:
@ SkillsDebug.c:464: }
	@ sp needed	@
	movs	r0, #0	@,
	bx	lr
	.size	List_2_Idle, .-List_2_Idle
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
	@ link register save eliminated.
@ SkillsDebug.c:468:     struct SkillDebugProc* const proc = (void*) menu->parent;
	ldr	r3, [r0, #20]	@ proc, menu_4(D)->parent
@ SkillsDebug.c:470: 	if (proc->move_hovering != 2)
	ldr	r2, [r3, #68]	@ tmp123, proc_5->move_hovering
	cmp	r2, #2	@ tmp123,
	beq	.L12		@,
@ SkillsDebug.c:472: 		proc->hover_move_Updated = TRUE;
	movs	r2, #1	@ tmp119,
	str	r2, [r3, #64]	@ tmp119, proc_5->hover_move_Updated
@ SkillsDebug.c:473: 		proc->move_hovering = 2;
	adds	r2, r2, r2	@ tmp120, tmp120,
	str	r2, [r3, #68]	@ tmp120, proc_5->move_hovering
.L12:
@ SkillsDebug.c:480: }
	@ sp needed	@
	movs	r0, #0	@,
	bx	lr
	.size	List_3_Idle, .-List_3_Idle
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
	@ link register save eliminated.
@ SkillsDebug.c:484:     struct SkillDebugProc* const proc = (void*) menu->parent;
	ldr	r3, [r0, #20]	@ proc, menu_4(D)->parent
@ SkillsDebug.c:486: 	if (proc->move_hovering != 3)
	ldr	r2, [r3, #68]	@ tmp123, proc_5->move_hovering
	cmp	r2, #3	@ tmp123,
	beq	.L17		@,
@ SkillsDebug.c:488: 		proc->hover_move_Updated = TRUE;
	movs	r2, #1	@ tmp119,
	str	r2, [r3, #64]	@ tmp119, proc_5->hover_move_Updated
@ SkillsDebug.c:489: 		proc->move_hovering = 3;
	adds	r2, r2, #2	@ tmp120,
	str	r2, [r3, #68]	@ tmp120, proc_5->move_hovering
.L17:
@ SkillsDebug.c:493: }
	@ sp needed	@
	movs	r0, #0	@,
	bx	lr
	.size	List_4_Idle, .-List_4_Idle
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
	@ link register save eliminated.
@ SkillsDebug.c:497:     struct SkillDebugProc* const proc = (void*) menu->parent;
	ldr	r3, [r0, #20]	@ proc, menu_4(D)->parent
@ SkillsDebug.c:499: 	if (proc->move_hovering != 4)
	ldr	r2, [r3, #68]	@ tmp123, proc_5->move_hovering
	cmp	r2, #4	@ tmp123,
	beq	.L22		@,
@ SkillsDebug.c:501: 		proc->hover_move_Updated = TRUE;
	movs	r2, #1	@ tmp119,
	str	r2, [r3, #64]	@ tmp119, proc_5->hover_move_Updated
@ SkillsDebug.c:502: 		proc->move_hovering = 4;
	adds	r2, r2, #3	@ tmp120,
	str	r2, [r3, #68]	@ tmp120, proc_5->move_hovering
.L22:
@ SkillsDebug.c:506: }
	@ sp needed	@
	movs	r0, #0	@,
	bx	lr
	.size	List_5_Idle, .-List_5_Idle
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	List_6_Idle, %function
List_6_Idle:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
@ SkillsDebug.c:510:     struct SkillDebugProc* const proc = (void*) menu->parent;
	ldr	r3, [r0, #20]	@ proc, menu_4(D)->parent
@ SkillsDebug.c:512: 	if (proc->move_hovering != 5)
	ldr	r2, [r3, #68]	@ tmp123, proc_5->move_hovering
	cmp	r2, #5	@ tmp123,
	beq	.L27		@,
@ SkillsDebug.c:514: 		proc->hover_move_Updated = TRUE;
	movs	r2, #1	@ tmp119,
	str	r2, [r3, #64]	@ tmp119, proc_5->hover_move_Updated
@ SkillsDebug.c:515: 		proc->move_hovering = 5;
	adds	r2, r2, #4	@ tmp120,
	str	r2, [r3, #68]	@ tmp120, proc_5->move_hovering
.L27:
@ SkillsDebug.c:519: }
	@ sp needed	@
	movs	r0, #0	@,
	bx	lr
	.size	List_6_Idle, .-List_6_Idle
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	List_7_Idle, %function
List_7_Idle:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
@ SkillsDebug.c:524:     struct SkillDebugProc* const proc = (void*) menu->parent;
	ldr	r3, [r0, #20]	@ proc, menu_4(D)->parent
@ SkillsDebug.c:526: 	if (proc->move_hovering != 6)
	ldr	r2, [r3, #68]	@ tmp123, proc_5->move_hovering
	cmp	r2, #6	@ tmp123,
	beq	.L32		@,
@ SkillsDebug.c:528: 		proc->hover_move_Updated = TRUE;
	movs	r2, #1	@ tmp119,
	str	r2, [r3, #64]	@ tmp119, proc_5->hover_move_Updated
@ SkillsDebug.c:529: 		proc->move_hovering = 6;
	adds	r2, r2, #5	@ tmp120,
	str	r2, [r3, #68]	@ tmp120, proc_5->move_hovering
.L32:
@ SkillsDebug.c:532: }
	@ sp needed	@
	movs	r0, #0	@,
	bx	lr
	.size	List_7_Idle, .-List_7_Idle
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	List_8_Idle, %function
List_8_Idle:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
@ SkillsDebug.c:536:     struct SkillDebugProc* const proc = (void*) menu->parent;
	ldr	r3, [r0, #20]	@ proc, menu_4(D)->parent
@ SkillsDebug.c:538: 	if (proc->move_hovering != 7)
	ldr	r2, [r3, #68]	@ tmp123, proc_5->move_hovering
	cmp	r2, #7	@ tmp123,
	beq	.L37		@,
@ SkillsDebug.c:540: 		proc->hover_move_Updated = TRUE;
	movs	r2, #1	@ tmp119,
	str	r2, [r3, #64]	@ tmp119, proc_5->hover_move_Updated
@ SkillsDebug.c:541: 		proc->move_hovering = 7;
	adds	r2, r2, #6	@ tmp120,
	str	r2, [r3, #68]	@ tmp120, proc_5->move_hovering
.L37:
@ SkillsDebug.c:544: }
	@ sp needed	@
	movs	r0, #0	@,
	bx	lr
	.size	List_8_Idle, .-List_8_Idle
	.align	1
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
@ SkillsDebug.c:863: }
	movs	r0, #0	@,
	@ sp needed	@
	bx	lr
	.size	SkillListCommandSelect, .-SkillListCommandSelect
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
@ SkillsDebug.c:1040:     EndFaceById(0);
	movs	r0, #0	@,
@ SkillsDebug.c:1041: }
	@ sp needed	@
@ SkillsDebug.c:1040:     EndFaceById(0);
	ldr	r3, .L43	@ tmp114,
	bl	.L45		@
@ SkillsDebug.c:1041: }
	pop	{r4}
	pop	{r0}
	bx	r0
.L44:
	.align	2
.L43:
	.word	EndFaceById
	.size	SkillDebugMenuEnd, .-SkillDebugMenuEnd
	.section	.rodata.str1.1,"aMS",%progbits,1
.LC5:
	.ascii	"Learn \000"
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
	push	{r3, r4, r5, r6, r7, lr}	@
@ SkillsDebug.c:938:     struct SkillDebugProc* const proc = (void*) menu->parent;
	ldr	r6, [r0, #20]	@ proc, menu_16(D)->parent
@ SkillsDebug.c:971: }
	@ sp needed	@
@ SkillsDebug.c:940:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldrh	r0, [r1, #42]	@ tmp133,
	ldrh	r5, [r1, #44]	@ tmp131,
@ SkillsDebug.c:942:     Text_Clear(&command->text);
	adds	r1, r1, #52	@ command,
	movs	r4, r1	@ _9, command
@ SkillsDebug.c:940:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #5	@ tmp132, tmp131,
	adds	r5, r5, r0	@ tmp134, tmp132, tmp133
@ SkillsDebug.c:940:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldr	r0, .L47	@ tmp136,
@ SkillsDebug.c:940:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #1	@ tmp135, tmp134,
@ SkillsDebug.c:940:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	adds	r5, r5, r0	@ out, tmp135, tmp136
@ SkillsDebug.c:942:     Text_Clear(&command->text);
	ldr	r3, .L47+4	@ tmp137,
	movs	r0, r1	@, _9
	bl	.L45		@
@ SkillsDebug.c:944: 	Text_SetXCursor(&command->text, new_item_desc_offset);
	ldr	r7, .L47+8	@ tmp138,
	movs	r1, #72	@,
	movs	r0, r4	@, _9
	bl	.L49		@
@ SkillsDebug.c:945: 	Text_SetColorId(&command->text, TEXT_COLOR_GREEN);
	movs	r1, #4	@,
	movs	r0, r4	@, _9
	ldr	r3, .L47+12	@ tmp159,
	bl	.L45		@
@ SkillsDebug.c:946:     Text_DrawString(&command->text, "Learn ");
	movs	r0, r4	@, _9
	ldr	r1, .L47+16	@,
	ldr	r3, .L47+20	@ tmp161,
	bl	.L45		@
@ SkillsDebug.c:947: 	Text_Display(&command->text, out); 
	movs	r1, r5	@, out
	movs	r0, r4	@, _9
	ldr	r3, .L47+24	@ tmp163,
	bl	.L45		@
@ SkillsDebug.c:949: 	Text_SetXCursor(&command->text, new_item_desc_offset+new_item_name_offset);
	movs	r1, #120	@,
	movs	r0, r4	@, _9
	bl	.L49		@
@ SkillsDebug.c:950:     Text_SetColorId(&command->text, TEXT_COLOR_BLUE);
	movs	r1, #2	@,
	movs	r0, r4	@, _9
	ldr	r3, .L47+12	@ tmp165,
	bl	.L45		@
@ SkillsDebug.c:951:     Text_DrawString(&command->text, GetItemName(proc->skillReplacement)); 
	ldr	r0, [r6, #52]	@, proc_17->skillReplacement
	ldr	r3, .L47+28	@ tmp145,
	bl	.L45		@
@ SkillsDebug.c:951:     Text_DrawString(&command->text, GetItemName(proc->skillReplacement)); 
	ldr	r3, .L47+20	@ tmp167,
@ SkillsDebug.c:951:     Text_DrawString(&command->text, GetItemName(proc->skillReplacement)); 
	movs	r1, r0	@ _11, tmp155
@ SkillsDebug.c:951:     Text_DrawString(&command->text, GetItemName(proc->skillReplacement)); 
	movs	r0, r4	@, _9
	bl	.L45		@
@ SkillsDebug.c:952: 	Text_Display(&command->text, out); 
	movs	r1, r5	@, out
	movs	r0, r4	@, _9
	ldr	r3, .L47+24	@ tmp169,
	bl	.L45		@
@ SkillsDebug.c:964: 	LoadIconPalettes(4); 
	movs	r0, #4	@,
	ldr	r3, .L47+32	@ tmp148,
	bl	.L45		@
@ SkillsDebug.c:965:     DrawIcon(
	ldr	r0, [r6, #52]	@, proc_17->skillReplacement
	ldr	r3, .L47+36	@ tmp149,
	bl	.L45		@
	movs	r2, #128	@ tmp157,
	movs	r1, r0	@ _14, tmp156
	movs	r0, r5	@ out, out
	ldr	r3, .L47+40	@ tmp152,
	adds	r0, r0, #26	@ out,
	lsls	r2, r2, #7	@, tmp157,
	bl	.L45		@
@ SkillsDebug.c:971: }
	pop	{r3, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L48:
	.align	2
.L47:
	.word	gBg0MapBuffer
	.word	Text_Clear
	.word	Text_SetXCursor
	.word	Text_SetColorId
	.word	.LC5
	.word	Text_DrawString
	.word	Text_Display
	.word	GetItemName
	.word	LoadIconPalettes
	.word	GetItemIconId
	.word	DrawIcon
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
@ SkillsDebug.c:84:     if (moveId == 0)
	cmp	r0, #0	@ moveId,
	beq	.L51		@,
@ SkillsDebug.c:87:     if (moveId == 255)
	cmp	r0, #255	@ moveId,
	beq	.L52		@,
@ SkillsDebug.c:90:     return !!GetItemDescId(moveId); /* GetItemDescId() */ 
	ldr	r3, .L56	@ tmp117,
	bl	.L45		@
@ SkillsDebug.c:90:     return !!GetItemDescId(moveId); /* GetItemDescId() */ 
	subs	r3, r0, #1	@ tmp120, tmp123
	sbcs	r0, r0, r3	@ moveId, tmp123, tmp120
.L51:
@ SkillsDebug.c:91: }
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L52:
@ SkillsDebug.c:85:         return FALSE;
	movs	r0, #0	@ moveId,
	b	.L51		@
.L57:
	.align	2
.L56:
	.word	GetItemDescId
	.size	IsMove, .-IsMove
	.section	.rodata.str1.1
.LC26:
	.ascii	" No Move\000"
	.text
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	SkillListCommandDraw_8, %function
SkillListCommandDraw_8:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, lr}	@
@ SkillsDebug.c:804:     u8* const moves = UnitGetMoveList(proc->unit);
	ldr	r3, [r0, #20]	@ menu_26(D)->parent, menu_26(D)->parent
@ SkillsDebug.c:806:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldrh	r5, [r1, #44]	@ tmp141,
@ SkillsDebug.c:804:     u8* const moves = UnitGetMoveList(proc->unit);
	ldr	r6, [r3, #48]	@ _1, proc_27->unit
@ SkillsDebug.c:806:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldrh	r3, [r1, #42]	@ tmp143,
@ SkillsDebug.c:809:     Text_Clear(&command->text);
	adds	r1, r1, #52	@ command,
	movs	r4, r1	@ _10, command
@ SkillsDebug.c:806:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #5	@ tmp142, tmp141,
	adds	r5, r5, r3	@ tmp144, tmp142, tmp143
@ SkillsDebug.c:806:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldr	r3, .L62	@ tmp146,
@ SkillsDebug.c:806:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #1	@ tmp145, tmp144,
@ SkillsDebug.c:809:     Text_Clear(&command->text);
	movs	r0, r1	@, _10
@ SkillsDebug.c:806:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	adds	r5, r5, r3	@ out, tmp145, tmp146
@ SkillsDebug.c:809:     Text_Clear(&command->text);
	ldr	r3, .L62+4	@ tmp147,
	bl	.L45		@
@ SkillsDebug.c:811: 	Text_SetXCursor(&command->text, new_item_desc_offset);
	movs	r1, #72	@,
	ldr	r7, .L62+8	@ tmp148,
	movs	r0, r4	@, _10
	bl	.L49		@
@ SkillsDebug.c:813:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	adds	r6, r6, #47	@ tmp152,
@ SkillsDebug.c:812:     Text_SetColorId(&command->text, TEXT_COLOR_BLUE);
	movs	r1, #2	@,
	ldr	r3, .L62+12	@ tmp191,
	movs	r0, r4	@, _10
	bl	.L45		@
@ SkillsDebug.c:813:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	ldr	r3, .L62+16	@ tmp154,
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 47B], MEM[(u8 *)_1 + 47B]
	bl	.L45		@
	ldr	r3, .L62+20	@ tmp155,
	bl	.L45		@
@ SkillsDebug.c:813:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	ldr	r3, .L62+24	@ tmp193,
@ SkillsDebug.c:813:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	movs	r1, r0	@ _14, tmp185
@ SkillsDebug.c:813:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	movs	r0, r4	@, _10
	bl	.L45		@
@ SkillsDebug.c:814: 	Text_Display(&command->text, out); 
	ldr	r3, .L62+28	@ tmp157,
	movs	r1, r5	@, out
	movs	r0, r4	@, _10
	bl	.L45		@
@ SkillsDebug.c:815: 	Text_SetXCursor(&command->text, 0);
	movs	r1, #0	@,
	movs	r0, r4	@, _10
	bl	.L49		@
@ SkillsDebug.c:816:     LoadIconPalettes(4); /* Icon palette */
	movs	r0, #4	@,
	ldr	r3, .L62+32	@ tmp159,
	bl	.L45		@
@ SkillsDebug.c:819: 	if (IsMove(moves[i])) {
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 47B], MEM[(u8 *)_1 + 47B]
	bl	IsMove		@
@ SkillsDebug.c:819: 	if (IsMove(moves[i])) {
	cmp	r0, #0	@ tmp186,
	beq	.L59		@,
@ SkillsDebug.c:820: 		DrawIcon(out + TILEMAP_INDEX(0, 0), GetItemIconId(moves[i]), TILEREF(0, 4)); 
	ldr	r3, .L62+36	@ tmp168,
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 47B], MEM[(u8 *)_1 + 47B]
	bl	.L45		@
	movs	r2, #128	@,
	movs	r1, r0	@ _20, tmp187
	lsls	r2, r2, #7	@,,
	ldr	r3, .L62+40	@ tmp170,
	movs	r0, r5	@, out
	bl	.L45		@
@ SkillsDebug.c:821: 		Text_SetXCursor(&command->text, item_name_offset);
	movs	r1, #16	@,
	movs	r0, r4	@, _10
	bl	.L49		@
@ SkillsDebug.c:822: 		Text_SetColorId(&command->text, TEXT_COLOR_BLUE);
	movs	r1, #2	@,
	ldr	r3, .L62+12	@ tmp195,
	movs	r0, r4	@, _10
	bl	.L45		@
@ SkillsDebug.c:823: 		Text_DrawString(&command->text, GetItemName(moves[i])); 
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 47B], MEM[(u8 *)_1 + 47B]
	ldr	r3, .L62+44	@ tmp177,
	bl	.L45		@
	movs	r1, r0	@ _23, tmp188
.L61:
@ SkillsDebug.c:829: }
	@ sp needed	@
@ SkillsDebug.c:827: 		Text_DrawString(&command->text, " No Move");
	movs	r0, r4	@, _10
	ldr	r3, .L62+24	@ tmp201,
	bl	.L45		@
@ SkillsDebug.c:829: }
	pop	{r3, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L59:
@ SkillsDebug.c:826: 		Text_SetColorId(&command->text, TEXT_COLOR_GRAY);
	movs	r1, #1	@,
	movs	r0, r4	@, _10
	ldr	r3, .L62+12	@ tmp199,
	bl	.L45		@
@ SkillsDebug.c:827: 		Text_DrawString(&command->text, " No Move");
	ldr	r1, .L62+48	@,
	b	.L61		@
.L63:
	.align	2
.L62:
	.word	gBg0MapBuffer
	.word	Text_Clear
	.word	Text_SetXCursor
	.word	Text_SetColorId
	.word	GetItemDescId
	.word	GetStringFromIndex
	.word	Text_DrawString
	.word	Text_Display
	.word	LoadIconPalettes
	.word	GetItemIconId
	.word	DrawIcon
	.word	GetItemName
	.word	.LC26
	.size	SkillListCommandDraw_8, .-SkillListCommandDraw_8
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	SkillListCommandDraw_7, %function
SkillListCommandDraw_7:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, lr}	@
@ SkillsDebug.c:773:     u8* const moves = UnitGetMoveList(proc->unit);
	ldr	r3, [r0, #20]	@ menu_26(D)->parent, menu_26(D)->parent
@ SkillsDebug.c:775:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldrh	r5, [r1, #44]	@ tmp141,
@ SkillsDebug.c:773:     u8* const moves = UnitGetMoveList(proc->unit);
	ldr	r6, [r3, #48]	@ _1, proc_27->unit
@ SkillsDebug.c:775:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldrh	r3, [r1, #42]	@ tmp143,
@ SkillsDebug.c:778:     Text_Clear(&command->text);
	adds	r1, r1, #52	@ command,
	movs	r4, r1	@ _10, command
@ SkillsDebug.c:775:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #5	@ tmp142, tmp141,
	adds	r5, r5, r3	@ tmp144, tmp142, tmp143
@ SkillsDebug.c:775:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldr	r3, .L68	@ tmp146,
@ SkillsDebug.c:775:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #1	@ tmp145, tmp144,
@ SkillsDebug.c:778:     Text_Clear(&command->text);
	movs	r0, r1	@, _10
@ SkillsDebug.c:775:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	adds	r5, r5, r3	@ out, tmp145, tmp146
@ SkillsDebug.c:778:     Text_Clear(&command->text);
	ldr	r3, .L68+4	@ tmp147,
	bl	.L45		@
@ SkillsDebug.c:779: 	Text_SetXCursor(&command->text, new_item_desc_offset);
	movs	r1, #72	@,
	ldr	r7, .L68+8	@ tmp148,
	movs	r0, r4	@, _10
	bl	.L49		@
@ SkillsDebug.c:781:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	adds	r6, r6, #46	@ tmp152,
@ SkillsDebug.c:780:     Text_SetColorId(&command->text, TEXT_COLOR_BLUE);
	movs	r1, #2	@,
	ldr	r3, .L68+12	@ tmp191,
	movs	r0, r4	@, _10
	bl	.L45		@
@ SkillsDebug.c:781:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	ldr	r3, .L68+16	@ tmp154,
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 46B], MEM[(u8 *)_1 + 46B]
	bl	.L45		@
	ldr	r3, .L68+20	@ tmp155,
	bl	.L45		@
@ SkillsDebug.c:781:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	ldr	r3, .L68+24	@ tmp193,
@ SkillsDebug.c:781:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	movs	r1, r0	@ _14, tmp185
@ SkillsDebug.c:781:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	movs	r0, r4	@, _10
	bl	.L45		@
@ SkillsDebug.c:782: 	Text_Display(&command->text, out); 
	ldr	r3, .L68+28	@ tmp157,
	movs	r1, r5	@, out
	movs	r0, r4	@, _10
	bl	.L45		@
@ SkillsDebug.c:783: 	Text_SetXCursor(&command->text, 0);
	movs	r1, #0	@,
	movs	r0, r4	@, _10
	bl	.L49		@
@ SkillsDebug.c:785:     LoadIconPalettes(4); /* Icon palette */
	movs	r0, #4	@,
	ldr	r3, .L68+32	@ tmp159,
	bl	.L45		@
@ SkillsDebug.c:788: 	if (IsMove(moves[i])) {
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 46B], MEM[(u8 *)_1 + 46B]
	bl	IsMove		@
@ SkillsDebug.c:788: 	if (IsMove(moves[i])) {
	cmp	r0, #0	@ tmp186,
	beq	.L65		@,
@ SkillsDebug.c:789: 		DrawIcon(out + TILEMAP_INDEX(0, 0), GetItemIconId(moves[i]), TILEREF(0, 4)); 
	ldr	r3, .L68+36	@ tmp168,
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 46B], MEM[(u8 *)_1 + 46B]
	bl	.L45		@
	movs	r2, #128	@,
	movs	r1, r0	@ _20, tmp187
	lsls	r2, r2, #7	@,,
	ldr	r3, .L68+40	@ tmp170,
	movs	r0, r5	@, out
	bl	.L45		@
@ SkillsDebug.c:790: 		Text_SetXCursor(&command->text, item_name_offset);
	movs	r1, #16	@,
	movs	r0, r4	@, _10
	bl	.L49		@
@ SkillsDebug.c:791: 		Text_SetColorId(&command->text, TEXT_COLOR_BLUE);
	movs	r1, #2	@,
	ldr	r3, .L68+12	@ tmp195,
	movs	r0, r4	@, _10
	bl	.L45		@
@ SkillsDebug.c:792: 		Text_DrawString(&command->text, GetItemName(moves[i])); 
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 46B], MEM[(u8 *)_1 + 46B]
	ldr	r3, .L68+44	@ tmp177,
	bl	.L45		@
	movs	r1, r0	@ _23, tmp188
.L67:
@ SkillsDebug.c:798: }
	@ sp needed	@
@ SkillsDebug.c:796: 		Text_DrawString(&command->text, " No Move");
	movs	r0, r4	@, _10
	ldr	r3, .L68+24	@ tmp201,
	bl	.L45		@
@ SkillsDebug.c:798: }
	pop	{r3, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L65:
@ SkillsDebug.c:795: 		Text_SetColorId(&command->text, TEXT_COLOR_GRAY);
	movs	r1, #1	@,
	movs	r0, r4	@, _10
	ldr	r3, .L68+12	@ tmp199,
	bl	.L45		@
@ SkillsDebug.c:796: 		Text_DrawString(&command->text, " No Move");
	ldr	r1, .L68+48	@,
	b	.L67		@
.L69:
	.align	2
.L68:
	.word	gBg0MapBuffer
	.word	Text_Clear
	.word	Text_SetXCursor
	.word	Text_SetColorId
	.word	GetItemDescId
	.word	GetStringFromIndex
	.word	Text_DrawString
	.word	Text_Display
	.word	LoadIconPalettes
	.word	GetItemIconId
	.word	DrawIcon
	.word	GetItemName
	.word	.LC26
	.size	SkillListCommandDraw_7, .-SkillListCommandDraw_7
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	SkillListCommandDraw_6, %function
SkillListCommandDraw_6:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, lr}	@
@ SkillsDebug.c:742:     u8* const moves = UnitGetMoveList(proc->unit);
	ldr	r3, [r0, #20]	@ menu_26(D)->parent, menu_26(D)->parent
@ SkillsDebug.c:744:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldrh	r5, [r1, #44]	@ tmp141,
@ SkillsDebug.c:742:     u8* const moves = UnitGetMoveList(proc->unit);
	ldr	r6, [r3, #48]	@ _1, proc_27->unit
@ SkillsDebug.c:744:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldrh	r3, [r1, #42]	@ tmp143,
@ SkillsDebug.c:747:     Text_Clear(&command->text);
	adds	r1, r1, #52	@ command,
	movs	r4, r1	@ _10, command
@ SkillsDebug.c:744:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #5	@ tmp142, tmp141,
	adds	r5, r5, r3	@ tmp144, tmp142, tmp143
@ SkillsDebug.c:744:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldr	r3, .L74	@ tmp146,
@ SkillsDebug.c:744:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #1	@ tmp145, tmp144,
@ SkillsDebug.c:747:     Text_Clear(&command->text);
	movs	r0, r1	@, _10
@ SkillsDebug.c:744:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	adds	r5, r5, r3	@ out, tmp145, tmp146
@ SkillsDebug.c:747:     Text_Clear(&command->text);
	ldr	r3, .L74+4	@ tmp147,
	bl	.L45		@
@ SkillsDebug.c:748: 	Text_SetXCursor(&command->text, new_item_desc_offset);
	movs	r1, #72	@,
	ldr	r7, .L74+8	@ tmp148,
	movs	r0, r4	@, _10
	bl	.L49		@
@ SkillsDebug.c:750:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	adds	r6, r6, #45	@ tmp152,
@ SkillsDebug.c:749:     Text_SetColorId(&command->text, TEXT_COLOR_BLUE);
	movs	r1, #2	@,
	ldr	r3, .L74+12	@ tmp191,
	movs	r0, r4	@, _10
	bl	.L45		@
@ SkillsDebug.c:750:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	ldr	r3, .L74+16	@ tmp154,
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 45B], MEM[(u8 *)_1 + 45B]
	bl	.L45		@
	ldr	r3, .L74+20	@ tmp155,
	bl	.L45		@
@ SkillsDebug.c:750:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	ldr	r3, .L74+24	@ tmp193,
@ SkillsDebug.c:750:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	movs	r1, r0	@ _14, tmp185
@ SkillsDebug.c:750:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	movs	r0, r4	@, _10
	bl	.L45		@
@ SkillsDebug.c:751: 	Text_Display(&command->text, out); 
	ldr	r3, .L74+28	@ tmp157,
	movs	r1, r5	@, out
	movs	r0, r4	@, _10
	bl	.L45		@
@ SkillsDebug.c:752: 	Text_SetXCursor(&command->text, 0);
	movs	r1, #0	@,
	movs	r0, r4	@, _10
	bl	.L49		@
@ SkillsDebug.c:754:     LoadIconPalettes(4); /* Icon palette */
	movs	r0, #4	@,
	ldr	r3, .L74+32	@ tmp159,
	bl	.L45		@
@ SkillsDebug.c:757: 	if (IsMove(moves[i])) {
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 45B], MEM[(u8 *)_1 + 45B]
	bl	IsMove		@
@ SkillsDebug.c:757: 	if (IsMove(moves[i])) {
	cmp	r0, #0	@ tmp186,
	beq	.L71		@,
@ SkillsDebug.c:758: 		DrawIcon(out + TILEMAP_INDEX(0, 0), GetItemIconId(moves[i]), TILEREF(0, 4)); 
	ldr	r3, .L74+36	@ tmp168,
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 45B], MEM[(u8 *)_1 + 45B]
	bl	.L45		@
	movs	r2, #128	@,
	movs	r1, r0	@ _20, tmp187
	lsls	r2, r2, #7	@,,
	ldr	r3, .L74+40	@ tmp170,
	movs	r0, r5	@, out
	bl	.L45		@
@ SkillsDebug.c:759: 		Text_SetXCursor(&command->text, item_name_offset);
	movs	r1, #16	@,
	movs	r0, r4	@, _10
	bl	.L49		@
@ SkillsDebug.c:760: 		Text_SetColorId(&command->text, TEXT_COLOR_BLUE);
	movs	r1, #2	@,
	ldr	r3, .L74+12	@ tmp195,
	movs	r0, r4	@, _10
	bl	.L45		@
@ SkillsDebug.c:761: 		Text_DrawString(&command->text, GetItemName(moves[i])); 
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 45B], MEM[(u8 *)_1 + 45B]
	ldr	r3, .L74+44	@ tmp177,
	bl	.L45		@
	movs	r1, r0	@ _23, tmp188
.L73:
@ SkillsDebug.c:767: }
	@ sp needed	@
@ SkillsDebug.c:765: 		Text_DrawString(&command->text, " No Move");
	movs	r0, r4	@, _10
	ldr	r3, .L74+24	@ tmp201,
	bl	.L45		@
@ SkillsDebug.c:767: }
	pop	{r3, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L71:
@ SkillsDebug.c:764: 		Text_SetColorId(&command->text, TEXT_COLOR_GRAY);
	movs	r1, #1	@,
	movs	r0, r4	@, _10
	ldr	r3, .L74+12	@ tmp199,
	bl	.L45		@
@ SkillsDebug.c:765: 		Text_DrawString(&command->text, " No Move");
	ldr	r1, .L74+48	@,
	b	.L73		@
.L75:
	.align	2
.L74:
	.word	gBg0MapBuffer
	.word	Text_Clear
	.word	Text_SetXCursor
	.word	Text_SetColorId
	.word	GetItemDescId
	.word	GetStringFromIndex
	.word	Text_DrawString
	.word	Text_Display
	.word	LoadIconPalettes
	.word	GetItemIconId
	.word	DrawIcon
	.word	GetItemName
	.word	.LC26
	.size	SkillListCommandDraw_6, .-SkillListCommandDraw_6
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
@ SkillsDebug.c:710:     u8* const moves = UnitGetMoveList(proc->unit);
	ldr	r3, [r0, #20]	@ menu_26(D)->parent, menu_26(D)->parent
@ SkillsDebug.c:712:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldrh	r5, [r1, #44]	@ tmp141,
@ SkillsDebug.c:710:     u8* const moves = UnitGetMoveList(proc->unit);
	ldr	r6, [r3, #48]	@ _1, proc_27->unit
@ SkillsDebug.c:712:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldrh	r3, [r1, #42]	@ tmp143,
@ SkillsDebug.c:715:     Text_Clear(&command->text);
	adds	r1, r1, #52	@ command,
	movs	r4, r1	@ _10, command
@ SkillsDebug.c:712:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #5	@ tmp142, tmp141,
	adds	r5, r5, r3	@ tmp144, tmp142, tmp143
@ SkillsDebug.c:712:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldr	r3, .L80	@ tmp146,
@ SkillsDebug.c:712:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #1	@ tmp145, tmp144,
@ SkillsDebug.c:715:     Text_Clear(&command->text);
	movs	r0, r1	@, _10
@ SkillsDebug.c:712:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	adds	r5, r5, r3	@ out, tmp145, tmp146
@ SkillsDebug.c:715:     Text_Clear(&command->text);
	ldr	r3, .L80+4	@ tmp147,
	bl	.L45		@
@ SkillsDebug.c:716: 	Text_SetXCursor(&command->text, new_item_desc_offset);
	movs	r1, #72	@,
	ldr	r7, .L80+8	@ tmp148,
	movs	r0, r4	@, _10
	bl	.L49		@
@ SkillsDebug.c:718:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	adds	r6, r6, #44	@ tmp152,
@ SkillsDebug.c:717:     Text_SetColorId(&command->text, TEXT_COLOR_BLUE);
	movs	r1, #2	@,
	ldr	r3, .L80+12	@ tmp191,
	movs	r0, r4	@, _10
	bl	.L45		@
@ SkillsDebug.c:718:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	ldr	r3, .L80+16	@ tmp154,
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 44B], MEM[(u8 *)_1 + 44B]
	bl	.L45		@
	ldr	r3, .L80+20	@ tmp155,
	bl	.L45		@
@ SkillsDebug.c:718:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	ldr	r3, .L80+24	@ tmp193,
@ SkillsDebug.c:718:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	movs	r1, r0	@ _14, tmp185
@ SkillsDebug.c:718:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	movs	r0, r4	@, _10
	bl	.L45		@
@ SkillsDebug.c:719: 	Text_Display(&command->text, out); 
	ldr	r3, .L80+28	@ tmp157,
	movs	r1, r5	@, out
	movs	r0, r4	@, _10
	bl	.L45		@
@ SkillsDebug.c:720: 	Text_SetXCursor(&command->text, 0);
	movs	r1, #0	@,
	movs	r0, r4	@, _10
	bl	.L49		@
@ SkillsDebug.c:722:     LoadIconPalettes(4); /* Icon palette */
	movs	r0, #4	@,
	ldr	r3, .L80+32	@ tmp159,
	bl	.L45		@
@ SkillsDebug.c:725: 	if (IsMove(moves[i])) {
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 44B], MEM[(u8 *)_1 + 44B]
	bl	IsMove		@
@ SkillsDebug.c:725: 	if (IsMove(moves[i])) {
	cmp	r0, #0	@ tmp186,
	beq	.L77		@,
@ SkillsDebug.c:726: 		DrawIcon(out + TILEMAP_INDEX(0, 0), GetItemIconId(moves[i]), TILEREF(0, 4)); 
	ldr	r3, .L80+36	@ tmp168,
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 44B], MEM[(u8 *)_1 + 44B]
	bl	.L45		@
	movs	r2, #128	@,
	movs	r1, r0	@ _20, tmp187
	lsls	r2, r2, #7	@,,
	ldr	r3, .L80+40	@ tmp170,
	movs	r0, r5	@, out
	bl	.L45		@
@ SkillsDebug.c:727: 		Text_SetXCursor(&command->text, item_name_offset);
	movs	r1, #16	@,
	movs	r0, r4	@, _10
	bl	.L49		@
@ SkillsDebug.c:728: 		Text_SetColorId(&command->text, TEXT_COLOR_BLUE);
	movs	r1, #2	@,
	ldr	r3, .L80+12	@ tmp195,
	movs	r0, r4	@, _10
	bl	.L45		@
@ SkillsDebug.c:729: 		Text_DrawString(&command->text, GetItemName(moves[i])); 
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 44B], MEM[(u8 *)_1 + 44B]
	ldr	r3, .L80+44	@ tmp177,
	bl	.L45		@
	movs	r1, r0	@ _23, tmp188
.L79:
@ SkillsDebug.c:736: }
	@ sp needed	@
@ SkillsDebug.c:733: 		Text_DrawString(&command->text, " No Move");
	movs	r0, r4	@, _10
	ldr	r3, .L80+24	@ tmp201,
	bl	.L45		@
@ SkillsDebug.c:736: }
	pop	{r3, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L77:
@ SkillsDebug.c:732: 		Text_SetColorId(&command->text, TEXT_COLOR_GRAY);
	movs	r1, #1	@,
	movs	r0, r4	@, _10
	ldr	r3, .L80+12	@ tmp199,
	bl	.L45		@
@ SkillsDebug.c:733: 		Text_DrawString(&command->text, " No Move");
	ldr	r1, .L80+48	@,
	b	.L79		@
.L81:
	.align	2
.L80:
	.word	gBg0MapBuffer
	.word	Text_Clear
	.word	Text_SetXCursor
	.word	Text_SetColorId
	.word	GetItemDescId
	.word	GetStringFromIndex
	.word	Text_DrawString
	.word	Text_Display
	.word	LoadIconPalettes
	.word	GetItemIconId
	.word	DrawIcon
	.word	GetItemName
	.word	.LC26
	.size	SkillListCommandDraw_5, .-SkillListCommandDraw_5
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
@ SkillsDebug.c:673:     u8* const moves = UnitGetMoveList(proc->unit);
	ldr	r3, [r0, #20]	@ menu_26(D)->parent, menu_26(D)->parent
@ SkillsDebug.c:675:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldrh	r5, [r1, #44]	@ tmp141,
@ SkillsDebug.c:673:     u8* const moves = UnitGetMoveList(proc->unit);
	ldr	r6, [r3, #48]	@ _1, proc_27->unit
@ SkillsDebug.c:675:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldrh	r3, [r1, #42]	@ tmp143,
@ SkillsDebug.c:678:     Text_Clear(&command->text);
	adds	r1, r1, #52	@ command,
	movs	r4, r1	@ _10, command
@ SkillsDebug.c:675:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #5	@ tmp142, tmp141,
	adds	r5, r5, r3	@ tmp144, tmp142, tmp143
@ SkillsDebug.c:675:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldr	r3, .L86	@ tmp146,
@ SkillsDebug.c:675:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #1	@ tmp145, tmp144,
@ SkillsDebug.c:678:     Text_Clear(&command->text);
	movs	r0, r1	@, _10
@ SkillsDebug.c:675:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	adds	r5, r5, r3	@ out, tmp145, tmp146
@ SkillsDebug.c:678:     Text_Clear(&command->text);
	ldr	r3, .L86+4	@ tmp147,
	bl	.L45		@
@ SkillsDebug.c:679: 	Text_SetXCursor(&command->text, new_item_desc_offset);
	movs	r1, #72	@,
	ldr	r7, .L86+8	@ tmp148,
	movs	r0, r4	@, _10
	bl	.L49		@
@ SkillsDebug.c:681:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	adds	r6, r6, #43	@ tmp152,
@ SkillsDebug.c:680:     Text_SetColorId(&command->text, TEXT_COLOR_BLUE);
	movs	r1, #2	@,
	ldr	r3, .L86+12	@ tmp191,
	movs	r0, r4	@, _10
	bl	.L45		@
@ SkillsDebug.c:681:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	ldr	r3, .L86+16	@ tmp154,
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 43B], MEM[(u8 *)_1 + 43B]
	bl	.L45		@
	ldr	r3, .L86+20	@ tmp155,
	bl	.L45		@
@ SkillsDebug.c:681:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	ldr	r3, .L86+24	@ tmp193,
@ SkillsDebug.c:681:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	movs	r1, r0	@ _14, tmp185
@ SkillsDebug.c:681:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	movs	r0, r4	@, _10
	bl	.L45		@
@ SkillsDebug.c:682: 	Text_Display(&command->text, out); 
	ldr	r3, .L86+28	@ tmp157,
	movs	r1, r5	@, out
	movs	r0, r4	@, _10
	bl	.L45		@
@ SkillsDebug.c:683: 	Text_SetXCursor(&command->text, 0);
	movs	r1, #0	@,
	movs	r0, r4	@, _10
	bl	.L49		@
@ SkillsDebug.c:685:     LoadIconPalettes(4); /* Icon palette */
	movs	r0, #4	@,
	ldr	r3, .L86+32	@ tmp159,
	bl	.L45		@
@ SkillsDebug.c:688: 	if (IsMove(moves[i])) {
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 43B], MEM[(u8 *)_1 + 43B]
	bl	IsMove		@
@ SkillsDebug.c:688: 	if (IsMove(moves[i])) {
	cmp	r0, #0	@ tmp186,
	beq	.L83		@,
@ SkillsDebug.c:689: 		DrawIcon(out + TILEMAP_INDEX(0, 0), GetItemIconId(moves[i]), TILEREF(0, 4)); 
	ldr	r3, .L86+36	@ tmp168,
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 43B], MEM[(u8 *)_1 + 43B]
	bl	.L45		@
	movs	r2, #128	@,
	movs	r1, r0	@ _20, tmp187
	lsls	r2, r2, #7	@,,
	ldr	r3, .L86+40	@ tmp170,
	movs	r0, r5	@, out
	bl	.L45		@
@ SkillsDebug.c:690: 		Text_SetXCursor(&command->text, item_name_offset);
	movs	r1, #16	@,
	movs	r0, r4	@, _10
	bl	.L49		@
@ SkillsDebug.c:691: 		Text_SetColorId(&command->text, TEXT_COLOR_BLUE);
	movs	r1, #2	@,
	ldr	r3, .L86+12	@ tmp195,
	movs	r0, r4	@, _10
	bl	.L45		@
@ SkillsDebug.c:692: 		Text_DrawString(&command->text, GetItemName(moves[i])); 
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 43B], MEM[(u8 *)_1 + 43B]
	ldr	r3, .L86+44	@ tmp177,
	bl	.L45		@
	movs	r1, r0	@ _23, tmp188
.L85:
@ SkillsDebug.c:699: }
	@ sp needed	@
@ SkillsDebug.c:696: 		Text_DrawString(&command->text, " No Move");
	movs	r0, r4	@, _10
	ldr	r3, .L86+24	@ tmp201,
	bl	.L45		@
@ SkillsDebug.c:699: }
	pop	{r3, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L83:
@ SkillsDebug.c:695: 		Text_SetColorId(&command->text, TEXT_COLOR_GRAY);
	movs	r1, #1	@,
	movs	r0, r4	@, _10
	ldr	r3, .L86+12	@ tmp199,
	bl	.L45		@
@ SkillsDebug.c:696: 		Text_DrawString(&command->text, " No Move");
	ldr	r1, .L86+48	@,
	b	.L85		@
.L87:
	.align	2
.L86:
	.word	gBg0MapBuffer
	.word	Text_Clear
	.word	Text_SetXCursor
	.word	Text_SetColorId
	.word	GetItemDescId
	.word	GetStringFromIndex
	.word	Text_DrawString
	.word	Text_Display
	.word	LoadIconPalettes
	.word	GetItemIconId
	.word	DrawIcon
	.word	GetItemName
	.word	.LC26
	.size	SkillListCommandDraw_4, .-SkillListCommandDraw_4
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
@ SkillsDebug.c:642:     u8* const moves = UnitGetMoveList(proc->unit);
	ldr	r3, [r0, #20]	@ menu_26(D)->parent, menu_26(D)->parent
@ SkillsDebug.c:644:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldrh	r5, [r1, #44]	@ tmp141,
@ SkillsDebug.c:642:     u8* const moves = UnitGetMoveList(proc->unit);
	ldr	r6, [r3, #48]	@ _1, proc_27->unit
@ SkillsDebug.c:644:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldrh	r3, [r1, #42]	@ tmp143,
@ SkillsDebug.c:646:     Text_Clear(&command->text);
	adds	r1, r1, #52	@ command,
	movs	r4, r1	@ _10, command
@ SkillsDebug.c:644:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #5	@ tmp142, tmp141,
	adds	r5, r5, r3	@ tmp144, tmp142, tmp143
@ SkillsDebug.c:644:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldr	r3, .L92	@ tmp146,
@ SkillsDebug.c:644:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #1	@ tmp145, tmp144,
@ SkillsDebug.c:646:     Text_Clear(&command->text);
	movs	r0, r1	@, _10
@ SkillsDebug.c:644:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	adds	r5, r5, r3	@ out, tmp145, tmp146
@ SkillsDebug.c:646:     Text_Clear(&command->text);
	ldr	r3, .L92+4	@ tmp147,
	bl	.L45		@
@ SkillsDebug.c:647: 	Text_SetXCursor(&command->text, new_item_desc_offset);
	movs	r1, #72	@,
	ldr	r7, .L92+8	@ tmp148,
	movs	r0, r4	@, _10
	bl	.L49		@
@ SkillsDebug.c:649:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	adds	r6, r6, #42	@ tmp152,
@ SkillsDebug.c:648:     Text_SetColorId(&command->text, TEXT_COLOR_BLUE);
	movs	r1, #2	@,
	ldr	r3, .L92+12	@ tmp191,
	movs	r0, r4	@, _10
	bl	.L45		@
@ SkillsDebug.c:649:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	ldr	r3, .L92+16	@ tmp154,
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 42B], MEM[(u8 *)_1 + 42B]
	bl	.L45		@
	ldr	r3, .L92+20	@ tmp155,
	bl	.L45		@
@ SkillsDebug.c:649:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	ldr	r3, .L92+24	@ tmp193,
@ SkillsDebug.c:649:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	movs	r1, r0	@ _14, tmp185
@ SkillsDebug.c:649:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	movs	r0, r4	@, _10
	bl	.L45		@
@ SkillsDebug.c:650: 	Text_Display(&command->text, out); 
	ldr	r3, .L92+28	@ tmp157,
	movs	r1, r5	@, out
	movs	r0, r4	@, _10
	bl	.L45		@
@ SkillsDebug.c:651: 	Text_SetXCursor(&command->text, 0);
	movs	r1, #0	@,
	movs	r0, r4	@, _10
	bl	.L49		@
@ SkillsDebug.c:653:     LoadIconPalettes(4); /* Icon palette */
	movs	r0, #4	@,
	ldr	r3, .L92+32	@ tmp159,
	bl	.L45		@
@ SkillsDebug.c:656: 	if (IsMove(moves[i])) {
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 42B], MEM[(u8 *)_1 + 42B]
	bl	IsMove		@
@ SkillsDebug.c:656: 	if (IsMove(moves[i])) {
	cmp	r0, #0	@ tmp186,
	beq	.L89		@,
@ SkillsDebug.c:657: 		DrawIcon(out + TILEMAP_INDEX(0, 0), GetItemIconId(moves[i]), TILEREF(0, 4)); 
	ldr	r3, .L92+36	@ tmp168,
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 42B], MEM[(u8 *)_1 + 42B]
	bl	.L45		@
	movs	r2, #128	@,
	movs	r1, r0	@ _20, tmp187
	lsls	r2, r2, #7	@,,
	ldr	r3, .L92+40	@ tmp170,
	movs	r0, r5	@, out
	bl	.L45		@
@ SkillsDebug.c:658: 		Text_SetXCursor(&command->text, item_name_offset);
	movs	r1, #16	@,
	movs	r0, r4	@, _10
	bl	.L49		@
@ SkillsDebug.c:659: 		Text_SetColorId(&command->text, TEXT_COLOR_BLUE);
	movs	r1, #2	@,
	ldr	r3, .L92+12	@ tmp195,
	movs	r0, r4	@, _10
	bl	.L45		@
@ SkillsDebug.c:660: 		Text_DrawString(&command->text, GetItemName(moves[i])); 
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 42B], MEM[(u8 *)_1 + 42B]
	ldr	r3, .L92+44	@ tmp177,
	bl	.L45		@
	movs	r1, r0	@ _23, tmp188
.L91:
@ SkillsDebug.c:667: }
	@ sp needed	@
@ SkillsDebug.c:664: 		Text_DrawString(&command->text, " No Move");
	movs	r0, r4	@, _10
	ldr	r3, .L92+24	@ tmp201,
	bl	.L45		@
@ SkillsDebug.c:667: }
	pop	{r3, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L89:
@ SkillsDebug.c:663: 		Text_SetColorId(&command->text, TEXT_COLOR_GRAY);
	movs	r1, #1	@,
	movs	r0, r4	@, _10
	ldr	r3, .L92+12	@ tmp199,
	bl	.L45		@
@ SkillsDebug.c:664: 		Text_DrawString(&command->text, " No Move");
	ldr	r1, .L92+48	@,
	b	.L91		@
.L93:
	.align	2
.L92:
	.word	gBg0MapBuffer
	.word	Text_Clear
	.word	Text_SetXCursor
	.word	Text_SetColorId
	.word	GetItemDescId
	.word	GetStringFromIndex
	.word	Text_DrawString
	.word	Text_Display
	.word	LoadIconPalettes
	.word	GetItemIconId
	.word	DrawIcon
	.word	GetItemName
	.word	.LC26
	.size	SkillListCommandDraw_3, .-SkillListCommandDraw_3
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
@ SkillsDebug.c:611:     u8* const moves = UnitGetMoveList(proc->unit);
	ldr	r3, [r0, #20]	@ menu_26(D)->parent, menu_26(D)->parent
@ SkillsDebug.c:613:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldrh	r5, [r1, #44]	@ tmp141,
@ SkillsDebug.c:611:     u8* const moves = UnitGetMoveList(proc->unit);
	ldr	r6, [r3, #48]	@ _1, proc_27->unit
@ SkillsDebug.c:613:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldrh	r3, [r1, #42]	@ tmp143,
@ SkillsDebug.c:615:     Text_Clear(&command->text);
	adds	r1, r1, #52	@ command,
	movs	r4, r1	@ _10, command
@ SkillsDebug.c:613:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #5	@ tmp142, tmp141,
	adds	r5, r5, r3	@ tmp144, tmp142, tmp143
@ SkillsDebug.c:613:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldr	r3, .L98	@ tmp146,
@ SkillsDebug.c:613:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #1	@ tmp145, tmp144,
@ SkillsDebug.c:615:     Text_Clear(&command->text);
	movs	r0, r1	@, _10
@ SkillsDebug.c:613:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	adds	r5, r5, r3	@ out, tmp145, tmp146
@ SkillsDebug.c:615:     Text_Clear(&command->text);
	ldr	r3, .L98+4	@ tmp147,
	bl	.L45		@
@ SkillsDebug.c:616: 	Text_SetXCursor(&command->text, new_item_desc_offset);
	movs	r1, #72	@,
	ldr	r7, .L98+8	@ tmp148,
	movs	r0, r4	@, _10
	bl	.L49		@
@ SkillsDebug.c:618:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	adds	r6, r6, #41	@ tmp152,
@ SkillsDebug.c:617:     Text_SetColorId(&command->text, TEXT_COLOR_BLUE);
	movs	r1, #2	@,
	ldr	r3, .L98+12	@ tmp191,
	movs	r0, r4	@, _10
	bl	.L45		@
@ SkillsDebug.c:618:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	ldr	r3, .L98+16	@ tmp154,
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 41B], MEM[(u8 *)_1 + 41B]
	bl	.L45		@
	ldr	r3, .L98+20	@ tmp155,
	bl	.L45		@
@ SkillsDebug.c:618:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	ldr	r3, .L98+24	@ tmp193,
@ SkillsDebug.c:618:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	movs	r1, r0	@ _14, tmp185
@ SkillsDebug.c:618:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	movs	r0, r4	@, _10
	bl	.L45		@
@ SkillsDebug.c:619: 	Text_Display(&command->text, out); 
	ldr	r3, .L98+28	@ tmp157,
	movs	r1, r5	@, out
	movs	r0, r4	@, _10
	bl	.L45		@
@ SkillsDebug.c:620: 	Text_SetXCursor(&command->text, 0);
	movs	r1, #0	@,
	movs	r0, r4	@, _10
	bl	.L49		@
@ SkillsDebug.c:622:     LoadIconPalettes(4); /* Icon palette */
	movs	r0, #4	@,
	ldr	r3, .L98+32	@ tmp159,
	bl	.L45		@
@ SkillsDebug.c:625: 	if (IsMove(moves[i])) {
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 41B], MEM[(u8 *)_1 + 41B]
	bl	IsMove		@
@ SkillsDebug.c:625: 	if (IsMove(moves[i])) {
	cmp	r0, #0	@ tmp186,
	beq	.L95		@,
@ SkillsDebug.c:626: 		DrawIcon(out + TILEMAP_INDEX(0, 0), GetItemIconId(moves[i]), TILEREF(0, 4)); 
	ldr	r3, .L98+36	@ tmp168,
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 41B], MEM[(u8 *)_1 + 41B]
	bl	.L45		@
	movs	r2, #128	@,
	movs	r1, r0	@ _20, tmp187
	lsls	r2, r2, #7	@,,
	ldr	r3, .L98+40	@ tmp170,
	movs	r0, r5	@, out
	bl	.L45		@
@ SkillsDebug.c:627: 		Text_SetXCursor(&command->text, item_name_offset);
	movs	r1, #16	@,
	movs	r0, r4	@, _10
	bl	.L49		@
@ SkillsDebug.c:628: 		Text_SetColorId(&command->text, TEXT_COLOR_BLUE);
	movs	r1, #2	@,
	ldr	r3, .L98+12	@ tmp195,
	movs	r0, r4	@, _10
	bl	.L45		@
@ SkillsDebug.c:629: 		Text_DrawString(&command->text, GetItemName(moves[i])); 
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 41B], MEM[(u8 *)_1 + 41B]
	ldr	r3, .L98+44	@ tmp177,
	bl	.L45		@
	movs	r1, r0	@ _23, tmp188
.L97:
@ SkillsDebug.c:636: }
	@ sp needed	@
@ SkillsDebug.c:633: 		Text_DrawString(&command->text, " No Move");
	movs	r0, r4	@, _10
	ldr	r3, .L98+24	@ tmp201,
	bl	.L45		@
@ SkillsDebug.c:636: }
	pop	{r3, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L95:
@ SkillsDebug.c:632: 		Text_SetColorId(&command->text, TEXT_COLOR_GRAY);
	movs	r1, #1	@,
	movs	r0, r4	@, _10
	ldr	r3, .L98+12	@ tmp199,
	bl	.L45		@
@ SkillsDebug.c:633: 		Text_DrawString(&command->text, " No Move");
	ldr	r1, .L98+48	@,
	b	.L97		@
.L99:
	.align	2
.L98:
	.word	gBg0MapBuffer
	.word	Text_Clear
	.word	Text_SetXCursor
	.word	Text_SetColorId
	.word	GetItemDescId
	.word	GetStringFromIndex
	.word	Text_DrawString
	.word	Text_Display
	.word	LoadIconPalettes
	.word	GetItemIconId
	.word	DrawIcon
	.word	GetItemName
	.word	.LC26
	.size	SkillListCommandDraw_2, .-SkillListCommandDraw_2
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
@ SkillsDebug.c:581:     u8* const moves = UnitGetMoveList(proc->unit);
	ldr	r3, [r0, #20]	@ menu_26(D)->parent, menu_26(D)->parent
@ SkillsDebug.c:583:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldrh	r5, [r1, #44]	@ tmp141,
@ SkillsDebug.c:581:     u8* const moves = UnitGetMoveList(proc->unit);
	ldr	r6, [r3, #48]	@ _1, proc_27->unit
@ SkillsDebug.c:583:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldrh	r3, [r1, #42]	@ tmp143,
@ SkillsDebug.c:585:     Text_Clear(&command->text);
	adds	r1, r1, #52	@ command,
	movs	r4, r1	@ _10, command
@ SkillsDebug.c:583:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #5	@ tmp142, tmp141,
	adds	r5, r5, r3	@ tmp144, tmp142, tmp143
@ SkillsDebug.c:583:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldr	r3, .L104	@ tmp146,
@ SkillsDebug.c:583:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #1	@ tmp145, tmp144,
@ SkillsDebug.c:585:     Text_Clear(&command->text);
	movs	r0, r1	@, _10
@ SkillsDebug.c:583:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	adds	r5, r5, r3	@ out, tmp145, tmp146
@ SkillsDebug.c:585:     Text_Clear(&command->text);
	ldr	r3, .L104+4	@ tmp147,
	bl	.L45		@
@ SkillsDebug.c:586: 	Text_SetXCursor(&command->text, new_item_desc_offset);
	movs	r1, #72	@,
	ldr	r7, .L104+8	@ tmp148,
	movs	r0, r4	@, _10
	bl	.L49		@
@ SkillsDebug.c:588:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	adds	r6, r6, #40	@ tmp152,
@ SkillsDebug.c:587:     Text_SetColorId(&command->text, TEXT_COLOR_BLUE);
	movs	r1, #2	@,
	ldr	r3, .L104+12	@ tmp191,
	movs	r0, r4	@, _10
	bl	.L45		@
@ SkillsDebug.c:588:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	ldr	r3, .L104+16	@ tmp154,
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 40B], MEM[(u8 *)_1 + 40B]
	bl	.L45		@
	ldr	r3, .L104+20	@ tmp155,
	bl	.L45		@
@ SkillsDebug.c:588:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	ldr	r3, .L104+24	@ tmp193,
@ SkillsDebug.c:588:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	movs	r1, r0	@ _14, tmp185
@ SkillsDebug.c:588:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	movs	r0, r4	@, _10
	bl	.L45		@
@ SkillsDebug.c:589: 	Text_Display(&command->text, out); 
	ldr	r3, .L104+28	@ tmp157,
	movs	r1, r5	@, out
	movs	r0, r4	@, _10
	bl	.L45		@
@ SkillsDebug.c:590: 	Text_SetXCursor(&command->text, 0);
	movs	r1, #0	@,
	movs	r0, r4	@, _10
	bl	.L49		@
@ SkillsDebug.c:592:     LoadIconPalettes(4); /* Icon palette */
	movs	r0, #4	@,
	ldr	r3, .L104+32	@ tmp159,
	bl	.L45		@
@ SkillsDebug.c:594: 	if (IsMove(moves[i])) {
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 40B], MEM[(u8 *)_1 + 40B]
	bl	IsMove		@
@ SkillsDebug.c:594: 	if (IsMove(moves[i])) {
	cmp	r0, #0	@ tmp186,
	beq	.L101		@,
@ SkillsDebug.c:595: 		DrawIcon(out + TILEMAP_INDEX(0, 0), GetItemIconId(moves[i]), TILEREF(0, 4)); 
	ldr	r3, .L104+36	@ tmp168,
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 40B], MEM[(u8 *)_1 + 40B]
	bl	.L45		@
	movs	r2, #128	@,
	movs	r1, r0	@ _20, tmp187
	lsls	r2, r2, #7	@,,
	ldr	r3, .L104+40	@ tmp170,
	movs	r0, r5	@, out
	bl	.L45		@
@ SkillsDebug.c:596: 		Text_SetXCursor(&command->text, item_name_offset);
	movs	r1, #16	@,
	movs	r0, r4	@, _10
	bl	.L49		@
@ SkillsDebug.c:597: 		Text_SetColorId(&command->text, TEXT_COLOR_BLUE);
	movs	r1, #2	@,
	ldr	r3, .L104+12	@ tmp195,
	movs	r0, r4	@, _10
	bl	.L45		@
@ SkillsDebug.c:598: 		Text_DrawString(&command->text, GetItemName(moves[i])); 
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 40B], MEM[(u8 *)_1 + 40B]
	ldr	r3, .L104+44	@ tmp177,
	bl	.L45		@
	movs	r1, r0	@ _23, tmp188
.L103:
@ SkillsDebug.c:605: }
	@ sp needed	@
@ SkillsDebug.c:602: 		Text_DrawString(&command->text, " No Move");
	movs	r0, r4	@, _10
	ldr	r3, .L104+24	@ tmp201,
	bl	.L45		@
@ SkillsDebug.c:605: }
	pop	{r3, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L101:
@ SkillsDebug.c:601: 		Text_SetColorId(&command->text, TEXT_COLOR_GRAY);
	movs	r1, #1	@,
	movs	r0, r4	@, _10
	ldr	r3, .L104+12	@ tmp199,
	bl	.L45		@
@ SkillsDebug.c:602: 		Text_DrawString(&command->text, " No Move");
	ldr	r1, .L104+48	@,
	b	.L103		@
.L105:
	.align	2
.L104:
	.word	gBg0MapBuffer
	.word	Text_Clear
	.word	Text_SetXCursor
	.word	Text_SetColorId
	.word	GetItemDescId
	.word	GetStringFromIndex
	.word	Text_DrawString
	.word	Text_Display
	.word	LoadIconPalettes
	.word	GetItemIconId
	.word	DrawIcon
	.word	GetItemName
	.word	.LC26
	.size	SkillListCommandDraw_1, .-SkillListCommandDraw_1
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	MoveCommandSelect, %function
MoveCommandSelect:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r0, r1, r2, r4, r5, r6, r7, lr}	@
@ SkillsDebug.c:869:     struct SkillDebugProc* const proc = (void*) menu->parent;
	ldr	r5, [r0, #20]	@ proc, menu_8(D)->parent
@ SkillsDebug.c:876:     UnitGetMoveList(proc->unit)[proc->move_hovering] = proc->skillReplacement;
	ldr	r2, [r5, #68]	@ tmp203, proc_9->move_hovering
	ldr	r3, [r5, #48]	@ tmp202, proc_9->unit
	adds	r3, r3, r2	@ tmp155, tmp202, tmp203
	ldr	r2, [r5, #52]	@ tmp204, proc_9->skillReplacement
	adds	r3, r3, #40	@ tmp158,
	strb	r2, [r3]	@ tmp205, *_5
@ SkillsDebug.c:877: 	proc->movesUpdated = TRUE;
	movs	r3, #1	@ tmp206,
	str	r3, [r5, #56]	@ tmp206, proc_9->movesUpdated
	ldr	r3, [r0, #20]	@ _16, MEM[(struct Proc * *)menu_8(D) + 20B]
@ SkillsDebug.c:78: 	return unit->ranks; 
	ldr	r6, [r3, #48]	@ _19, MEM[(struct SkillDebugProc *)_16].unit
@ SkillsDebug.c:552: 	int i = proc->move_hovering;
	ldr	r3, [r3, #68]	@ i, MEM[(struct SkillDebugProc *)_16].move_hovering
	str	r3, [sp, #4]	@ i, %sfp
@ SkillsDebug.c:553:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldrh	r2, [r1, #42]	@ tmp165,
	ldrh	r3, [r1, #44]	@ tmp163,
@ SkillsDebug.c:555:     Text_Clear(&command->text);
	adds	r1, r1, #52	@ command,
	movs	r4, r1	@ _30, command
@ SkillsDebug.c:553:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r3, r3, #5	@ tmp164, tmp163,
	adds	r3, r3, r2	@ tmp166, tmp164, tmp165
@ SkillsDebug.c:553:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldr	r7, .L110	@ tmp168,
@ SkillsDebug.c:553:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r3, r3, #1	@ tmp167, tmp166,
@ SkillsDebug.c:555:     Text_Clear(&command->text);
	movs	r0, r1	@, _30
@ SkillsDebug.c:553:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	adds	r7, r3, r7	@ out, tmp167, tmp168
@ SkillsDebug.c:555:     Text_Clear(&command->text);
	ldr	r3, .L110+4	@ tmp169,
	bl	.L45		@
@ SkillsDebug.c:556: 	Text_SetXCursor(&command->text, new_item_desc_offset);
	movs	r1, #72	@,
	ldr	r3, .L110+8	@ tmp210,
	movs	r0, r4	@, _30
	bl	.L45		@
@ SkillsDebug.c:557:     Text_SetColorId(&command->text, TEXT_COLOR_BLUE);
	movs	r1, #2	@,
	ldr	r3, .L110+12	@ tmp212,
	movs	r0, r4	@, _30
	bl	.L45		@
@ SkillsDebug.c:558:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	ldr	r3, [sp, #4]	@ i, %sfp
@ SkillsDebug.c:78: 	return unit->ranks; 
	adds	r6, r6, #40	@ _19,
@ SkillsDebug.c:558:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	adds	r3, r6, r3	@ _32, _19, i
	str	r3, [sp]	@ _32, %sfp
@ SkillsDebug.c:558:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	ldr	r3, [sp, #4]	@ i, %sfp
	ldrb	r0, [r6, r3]	@ *_32, *_32
	ldr	r3, .L110+16	@ tmp173,
	bl	.L45		@
	ldr	r3, .L110+20	@ tmp174,
	bl	.L45		@
@ SkillsDebug.c:558:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	ldr	r6, .L110+24	@ tmp175,
@ SkillsDebug.c:558:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	movs	r1, r0	@ _36, tmp197
@ SkillsDebug.c:558:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	movs	r0, r4	@, _30
	bl	.L112		@
@ SkillsDebug.c:559: 	Text_Display(&command->text, out); 
	movs	r1, r7	@, out
	movs	r0, r4	@, _30
	ldr	r3, .L110+28	@ tmp176,
	bl	.L45		@
@ SkillsDebug.c:560: 	Text_SetXCursor(&command->text, 0);
	movs	r1, #0	@,
	ldr	r3, .L110+8	@ tmp217,
	movs	r0, r4	@, _30
	bl	.L45		@
@ SkillsDebug.c:562:     LoadIconPalettes(4); /* Icon palette */
	movs	r0, #4	@,
	ldr	r3, .L110+32	@ tmp178,
	bl	.L45		@
@ SkillsDebug.c:564: 	if (IsMove(moves[i])) {
	ldr	r3, [sp]	@ _32, %sfp
	ldrb	r0, [r3]	@ *_32, *_32
	bl	IsMove		@
@ SkillsDebug.c:564: 	if (IsMove(moves[i])) {
	cmp	r0, #0	@ tmp198,
	beq	.L107		@,
@ SkillsDebug.c:565: 		DrawIcon(out + TILEMAP_INDEX(0, 0), GetItemIconId(moves[i]), TILEREF(0, 4)); 
	ldr	r3, [sp]	@ _32, %sfp
	ldrb	r0, [r3]	@ *_32, *_32
	ldr	r3, .L110+36	@ tmp181,
	bl	.L45		@
	movs	r2, #128	@,
	movs	r1, r0	@ _42, tmp199
	lsls	r2, r2, #7	@,,
	movs	r0, r7	@, out
	ldr	r3, .L110+40	@ tmp183,
	bl	.L45		@
@ SkillsDebug.c:566: 		Text_SetXCursor(&command->text, item_name_offset);
	movs	r1, #16	@,
	ldr	r3, .L110+8	@ tmp221,
	movs	r0, r4	@, _30
	bl	.L45		@
@ SkillsDebug.c:567: 		Text_SetColorId(&command->text, TEXT_COLOR_BLUE);
	movs	r1, #2	@,
	ldr	r3, .L110+12	@ tmp223,
	movs	r0, r4	@, _30
	bl	.L45		@
@ SkillsDebug.c:568: 		Text_DrawString(&command->text, GetItemName(moves[i])); 
	ldr	r3, [sp]	@ _32, %sfp
	ldrb	r0, [r3]	@ *_32, *_32
	ldr	r3, .L110+44	@ tmp187,
	bl	.L45		@
	movs	r1, r0	@ _45, tmp200
.L109:
@ SkillsDebug.c:922: }
	@ sp needed	@
@ SkillsDebug.c:572: 		Text_DrawString(&command->text, " No Move");
	movs	r0, r4	@, _30
	bl	.L112		@
@ SkillsDebug.c:888:         proc->movesUpdated = FALSE;
	movs	r3, #0	@ tmp192,
@ SkillsDebug.c:922: }
	movs	r0, #4	@,
@ SkillsDebug.c:888:         proc->movesUpdated = FALSE;
	str	r3, [r5, #56]	@ tmp192, proc_9->movesUpdated
@ SkillsDebug.c:922: }
	pop	{r1, r2, r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L107:
@ SkillsDebug.c:571: 		Text_SetColorId(&command->text, TEXT_COLOR_GRAY);
	movs	r1, #1	@,
	movs	r0, r4	@, _30
	ldr	r3, .L110+12	@ tmp226,
	bl	.L45		@
@ SkillsDebug.c:572: 		Text_DrawString(&command->text, " No Move");
	ldr	r1, .L110+48	@,
	b	.L109		@
.L111:
	.align	2
.L110:
	.word	gBg0MapBuffer
	.word	Text_Clear
	.word	Text_SetXCursor
	.word	Text_SetColorId
	.word	GetItemDescId
	.word	GetStringFromIndex
	.word	Text_DrawString
	.word	Text_Display
	.word	LoadIconPalettes
	.word	GetItemIconId
	.word	DrawIcon
	.word	GetItemName
	.word	.LC26
	.size	MoveCommandSelect, .-MoveCommandSelect
	.align	1
	.global	SkillDebugCommand_OnSelect
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	SkillDebugCommand_OnSelect, %function
SkillDebugCommand_OnSelect:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ SkillsDebug.c:364:     struct SkillDebugProc* proc = (void*) ProcStart(Proc_SkillDebug, ROOT_PROC_3);
	ldr	r4, .L114	@ tmp120,
@ SkillsDebug.c:402: }
	@ sp needed	@
@ SkillsDebug.c:364:     struct SkillDebugProc* proc = (void*) ProcStart(Proc_SkillDebug, ROOT_PROC_3);
	movs	r1, #3	@,
	movs	r0, r4	@, tmp120
	ldr	r3, .L114+4	@ tmp121,
	bl	.L45		@
@ SkillsDebug.c:384:     proc->skillReplacement = proc->skillReplacement_u32;
	ldr r2, =0x0202BCDE
	ldrh r2, [r2]
	ldr	r3, [r0, #44]	@ tmp134, proc_6->skillReplacement_u32
	strh	r2, [r0, #52]	@ tmp134, proc_6->skillReplacement
@ SkillsDebug.c:387:     proc->unit = gActiveUnit;
	ldr	r3, =0x30017BC @ tmp123,              [0x30017BA]?!!
	ldr	r3, [r3]	@ tmp135, gActiveUnit
	str	r3, [r0, #48]	@ tmp135, proc_6->unit
@ SkillsDebug.c:389:     proc->movesUpdated = FALSE;
	movs	r3, #0	@ tmp125,
@ SkillsDebug.c:364:     struct SkillDebugProc* proc = (void*) ProcStart(Proc_SkillDebug, ROOT_PROC_3);
	movs	r1, r0	@ proc, tmp133
@ SkillsDebug.c:389:     proc->movesUpdated = FALSE;
	str	r3, [r0, #56]	@ tmp125, proc_6->movesUpdated
@ SkillsDebug.c:390:     proc->skillSelected = 0;
	str	r3, [r0, #60]	@ tmp125, proc_6->skillSelected
@ SkillsDebug.c:393: 	proc->hover_move_Updated = FALSE; 
	str	r3, [r0, #64]	@ tmp125, proc_6->hover_move_Updated
@ SkillsDebug.c:394: 	proc->move_hovering = 0;
	str	r3, [r0, #68]	@ tmp125, proc_6->move_hovering
@ SkillsDebug.c:395:     StartMenuChild(&Menu_SkillDebug, (void*) proc);
	movs	r0, r4	@ tmp120, tmp120
	ldr	r3, .L114+12	@ tmp131,
	adds	r0, r0, #32	@ tmp120,
	bl	.L45		@
@ SkillsDebug.c:402: }
	movs	r0, #23	@,
	pop	{r4}
	pop	{r1}
	bx	r1

.L115:
	.align	2
.L114:
	.word	.LANCHOR0
	.word	ProcStart
	.word	gActiveUnit
	.word	StartMenuChild
	.size	SkillDebugCommand_OnSelect, .-SkillDebugCommand_OnSelect
	.section	.rodata
	.align	2
	.set	.LANCHOR0,. + 0
	.type	Proc_SkillDebug, %object
	.size	Proc_SkillDebug, 32
	.global Proc_SkillDebug
Proc_SkillDebug:
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
	.byte	29
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
	.size	MenuCommands_SkillDebug, 360
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
@ isAvailable:
	.space	12
	.word	MenuCommandAlwaysUsable
@ onDraw:
	.word	SkillListCommandDraw_6
@ onEffect:
	.word	MoveCommandSelect
@ onIdle:
	.word	List_6_Idle
	.space	8
@ isAvailable:
	.space	12
	.word	MenuCommandAlwaysUsable
@ onDraw:
	.word	SkillListCommandDraw_7
@ onEffect:
	.word	MoveCommandSelect
@ onIdle:
	.word	List_7_Idle
	.space	8
@ isAvailable:
	.space	12
	.word	MenuCommandAlwaysUsable
@ onDraw:
	.word	SkillListCommandDraw_8
@ onEffect:
	.word	MoveCommandSelect
@ onIdle:
	.word	List_8_Idle
	.space	8
	.space	36
	.ident	"GCC: (devkitARM release 54) 10.1.0"
	.text
	.code 16
	.align	1
.L45:
	bx	r3
.L112:
	bx	r6
.L49:
	bx	r7
