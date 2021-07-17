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
	.type	SkillListCommandSelect, %function
SkillListCommandSelect:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
@ SkillsDebug.c:824: }
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
	@ link register save eliminated.
@ SkillsDebug.c:893: 	*MemorySlot5 = proc->move_hovering; 
	ldr	r3, [r0, #20]	@ menu_3(D)->parent, menu_3(D)->parent
@ SkillsDebug.c:925: }
	@ sp needed	@
@ SkillsDebug.c:893: 	*MemorySlot5 = proc->move_hovering; 
	ldr	r2, [r3, #60]	@ _1, proc_4->move_hovering
@ SkillsDebug.c:893: 	*MemorySlot5 = proc->move_hovering; 
	ldr	r3, .L3	@ tmp119,
	str	r2, [r3]	@ _1, MEM[(int *)50332876B]
@ SkillsDebug.c:897: 	*MemorySlot6 = 1; // TRUE 
	movs	r2, #1	@ tmp121,
	ldr	r3, .L3+4	@ tmp120,
@ SkillsDebug.c:925: }
	movs	r0, #23	@,
@ SkillsDebug.c:897: 	*MemorySlot6 = 1; // TRUE 
	str	r2, [r3]	@ tmp121, MEM[(int *)50332880B]
@ SkillsDebug.c:925: }
	bx	lr
.L4:
	.align	2
.L3:
	.word	50332876
	.word	50332880
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
@ SkillsDebug.c:1080:     EndFaceById(0);
	movs	r0, #0	@,
@ SkillsDebug.c:1081: }
	@ sp needed	@
@ SkillsDebug.c:1080:     EndFaceById(0);
	ldr	r3, .L6	@ tmp114,
	bl	.L8		@
@ SkillsDebug.c:1081: }
	pop	{r4}
	pop	{r0}
	bx	r0
.L7:
	.align	2
.L6:
	.word	EndFaceById
	.size	SkillDebugMenuEnd, .-SkillDebugMenuEnd
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
@ SkillsDebug.c:445:     struct SkillDebugProc* const proc = (void*) menu->parent;
	ldr	r2, [r0, #20]	@ proc, menu_14(D)->parent
@ SkillsDebug.c:447: 	if (proc->move_hovering != 4)
	ldr	r1, [r2, #60]	@ tmp154, proc_15->move_hovering
@ SkillsDebug.c:444: {
	push	{r4, lr}	@
@ SkillsDebug.c:446:     u8* const moves = UnitGetMoveList(proc->unit);		
	ldr	r3, [r2, #44]	@ _1, proc_15->unit
@ SkillsDebug.c:444: {
	movs	r4, r0	@ menu, tmp151
@ SkillsDebug.c:447: 	if (proc->move_hovering != 4)
	cmp	r1, #4	@ tmp154,
	beq	.L10		@,
@ SkillsDebug.c:449: 		proc->hover_move_Updated = TRUE;
	movs	r1, #1	@ tmp130,
	str	r1, [r2, #56]	@ tmp130, proc_15->hover_move_Updated
@ SkillsDebug.c:450: 		proc->move_hovering = 4;
	adds	r1, r1, #3	@ tmp131,
	str	r1, [r2, #60]	@ tmp131, proc_15->move_hovering
.L10:
@ SkillsDebug.c:452: 	if (gKeyState.repeatedKeys & KEY_BUTTON_R) { 
	ldr	r1, .L18	@ tmp132,
@ SkillsDebug.c:452: 	if (gKeyState.repeatedKeys & KEY_BUTTON_R) { 
	ldrh	r1, [r1, #6]	@ tmp134,
	lsls	r1, r1, #23	@ tmp153, tmp134,
	bpl	.L11		@,
@ SkillsDebug.c:453: 		MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering]));
	ldr	r2, [r2, #60]	@ proc_15->move_hovering, proc_15->move_hovering
	adds	r3, r3, r2	@ tmp141, _1, proc_15->move_hovering
	adds	r3, r3, #40	@ tmp144,
@ SkillsDebug.c:453: 		MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering]));
	ldrb	r0, [r3]	@ *_6, *_6
	ldr	r3, .L18+4	@ tmp146,
	bl	.L8		@
@ SkillsDebug.c:453: 		MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering]));
	lsls	r1, r0, #16	@ tmp147, tmp152,
	ldr	r3, .L18+8	@ tmp149,
	movs	r0, r4	@, menu
	lsrs	r1, r1, #16	@ tmp147, tmp147,
	bl	.L8		@
.L11:
@ SkillsDebug.c:456: }
	@ sp needed	@
	movs	r0, #0	@,
	pop	{r4}
	pop	{r1}
	bx	r1
.L19:
	.align	2
.L18:
	.word	gKeyState
	.word	GetItemDescId
	.word	MenuCallHelpBox
	.size	List_5_Idle, .-List_5_Idle
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
@ SkillsDebug.c:429:     struct SkillDebugProc* const proc = (void*) menu->parent;
	ldr	r2, [r0, #20]	@ proc, menu_14(D)->parent
@ SkillsDebug.c:431: 	if (proc->move_hovering != 3)
	ldr	r1, [r2, #60]	@ tmp154, proc_15->move_hovering
@ SkillsDebug.c:428: {
	push	{r4, lr}	@
@ SkillsDebug.c:430:     u8* const moves = UnitGetMoveList(proc->unit);		
	ldr	r3, [r2, #44]	@ _1, proc_15->unit
@ SkillsDebug.c:428: {
	movs	r4, r0	@ menu, tmp151
@ SkillsDebug.c:431: 	if (proc->move_hovering != 3)
	cmp	r1, #3	@ tmp154,
	beq	.L21		@,
@ SkillsDebug.c:433: 		proc->hover_move_Updated = TRUE;
	movs	r1, #1	@ tmp130,
	str	r1, [r2, #56]	@ tmp130, proc_15->hover_move_Updated
@ SkillsDebug.c:434: 		proc->move_hovering = 3;
	adds	r1, r1, #2	@ tmp131,
	str	r1, [r2, #60]	@ tmp131, proc_15->move_hovering
.L21:
@ SkillsDebug.c:437: 	if (gKeyState.repeatedKeys & KEY_BUTTON_R) { 
	ldr	r1, .L29	@ tmp132,
@ SkillsDebug.c:437: 	if (gKeyState.repeatedKeys & KEY_BUTTON_R) { 
	ldrh	r1, [r1, #6]	@ tmp134,
	lsls	r1, r1, #23	@ tmp153, tmp134,
	bpl	.L22		@,
@ SkillsDebug.c:438: 		MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering]));
	ldr	r2, [r2, #60]	@ proc_15->move_hovering, proc_15->move_hovering
	adds	r3, r3, r2	@ tmp141, _1, proc_15->move_hovering
	adds	r3, r3, #40	@ tmp144,
@ SkillsDebug.c:438: 		MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering]));
	ldrb	r0, [r3]	@ *_6, *_6
	ldr	r3, .L29+4	@ tmp146,
	bl	.L8		@
@ SkillsDebug.c:438: 		MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering]));
	lsls	r1, r0, #16	@ tmp147, tmp152,
	ldr	r3, .L29+8	@ tmp149,
	movs	r0, r4	@, menu
	lsrs	r1, r1, #16	@ tmp147, tmp147,
	bl	.L8		@
.L22:
@ SkillsDebug.c:441: }
	@ sp needed	@
	movs	r0, #0	@,
	pop	{r4}
	pop	{r1}
	bx	r1
.L30:
	.align	2
.L29:
	.word	gKeyState
	.word	GetItemDescId
	.word	MenuCallHelpBox
	.size	List_4_Idle, .-List_4_Idle
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
@ SkillsDebug.c:411:     struct SkillDebugProc* const proc = (void*) menu->parent;
	ldr	r2, [r0, #20]	@ proc, menu_14(D)->parent
@ SkillsDebug.c:413: 	if (proc->move_hovering != 2)
	ldr	r1, [r2, #60]	@ tmp154, proc_15->move_hovering
@ SkillsDebug.c:410: {
	push	{r4, lr}	@
@ SkillsDebug.c:412:     u8* const moves = UnitGetMoveList(proc->unit);		
	ldr	r3, [r2, #44]	@ _1, proc_15->unit
@ SkillsDebug.c:410: {
	movs	r4, r0	@ menu, tmp151
@ SkillsDebug.c:413: 	if (proc->move_hovering != 2)
	cmp	r1, #2	@ tmp154,
	beq	.L32		@,
@ SkillsDebug.c:415: 		proc->hover_move_Updated = TRUE;
	movs	r1, #1	@ tmp130,
	str	r1, [r2, #56]	@ tmp130, proc_15->hover_move_Updated
@ SkillsDebug.c:416: 		proc->move_hovering = 2;
	adds	r1, r1, r1	@ tmp131, tmp131,
	str	r1, [r2, #60]	@ tmp131, proc_15->move_hovering
.L32:
@ SkillsDebug.c:418: 	if (gKeyState.repeatedKeys & KEY_BUTTON_R) { 
	ldr	r1, .L40	@ tmp132,
@ SkillsDebug.c:418: 	if (gKeyState.repeatedKeys & KEY_BUTTON_R) { 
	ldrh	r1, [r1, #6]	@ tmp134,
	lsls	r1, r1, #23	@ tmp153, tmp134,
	bpl	.L33		@,
@ SkillsDebug.c:419: 		MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering]));
	ldr	r2, [r2, #60]	@ proc_15->move_hovering, proc_15->move_hovering
	adds	r3, r3, r2	@ tmp141, _1, proc_15->move_hovering
	adds	r3, r3, #40	@ tmp144,
@ SkillsDebug.c:419: 		MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering]));
	ldrb	r0, [r3]	@ *_6, *_6
	ldr	r3, .L40+4	@ tmp146,
	bl	.L8		@
@ SkillsDebug.c:419: 		MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering]));
	lsls	r1, r0, #16	@ tmp147, tmp152,
	ldr	r3, .L40+8	@ tmp149,
	movs	r0, r4	@, menu
	lsrs	r1, r1, #16	@ tmp147, tmp147,
	bl	.L8		@
.L33:
@ SkillsDebug.c:425: }
	@ sp needed	@
	movs	r0, #0	@,
	pop	{r4}
	pop	{r1}
	bx	r1
.L41:
	.align	2
.L40:
	.word	gKeyState
	.word	GetItemDescId
	.word	MenuCallHelpBox
	.size	List_3_Idle, .-List_3_Idle
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
@ SkillsDebug.c:395:     struct SkillDebugProc* const proc = (void*) menu->parent;
	ldr	r2, [r0, #20]	@ proc, menu_14(D)->parent
@ SkillsDebug.c:397: 	if (proc->move_hovering != 1)
	ldr	r1, [r2, #60]	@ tmp154, proc_15->move_hovering
@ SkillsDebug.c:394: {
	push	{r4, lr}	@
@ SkillsDebug.c:396:     u8* const moves = UnitGetMoveList(proc->unit);		
	ldr	r3, [r2, #44]	@ _1, proc_15->unit
@ SkillsDebug.c:394: {
	movs	r4, r0	@ menu, tmp151
@ SkillsDebug.c:397: 	if (proc->move_hovering != 1)
	cmp	r1, #1	@ tmp154,
	beq	.L43		@,
@ SkillsDebug.c:399: 		proc->hover_move_Updated = TRUE;
	movs	r1, #1	@ tmp130,
	str	r1, [r2, #56]	@ tmp130, proc_15->hover_move_Updated
@ SkillsDebug.c:400: 		proc->move_hovering = 1;
	str	r1, [r2, #60]	@ tmp130, proc_15->move_hovering
.L43:
@ SkillsDebug.c:403: 	if (gKeyState.repeatedKeys & KEY_BUTTON_R) { 
	ldr	r1, .L51	@ tmp132,
@ SkillsDebug.c:403: 	if (gKeyState.repeatedKeys & KEY_BUTTON_R) { 
	ldrh	r1, [r1, #6]	@ tmp134,
	lsls	r1, r1, #23	@ tmp153, tmp134,
	bpl	.L44		@,
@ SkillsDebug.c:404: 		MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering]));
	ldr	r2, [r2, #60]	@ proc_15->move_hovering, proc_15->move_hovering
	adds	r3, r3, r2	@ tmp141, _1, proc_15->move_hovering
	adds	r3, r3, #40	@ tmp144,
@ SkillsDebug.c:404: 		MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering]));
	ldrb	r0, [r3]	@ *_6, *_6
	ldr	r3, .L51+4	@ tmp146,
	bl	.L8		@
@ SkillsDebug.c:404: 		MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering]));
	lsls	r1, r0, #16	@ tmp147, tmp152,
	ldr	r3, .L51+8	@ tmp149,
	movs	r0, r4	@, menu
	lsrs	r1, r1, #16	@ tmp147, tmp147,
	bl	.L8		@
.L44:
@ SkillsDebug.c:407: }
	@ sp needed	@
	movs	r0, #0	@,
	pop	{r4}
	pop	{r1}
	bx	r1
.L52:
	.align	2
.L51:
	.word	gKeyState
	.word	GetItemDescId
	.word	MenuCallHelpBox
	.size	List_2_Idle, .-List_2_Idle
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
@ SkillsDebug.c:378:     struct SkillDebugProc* const proc = (void*) menu->parent;
	ldr	r2, [r0, #20]	@ proc, menu_14(D)->parent
@ SkillsDebug.c:380: 	if (proc->move_hovering != 0)
	ldr	r1, [r2, #60]	@ tmp154, proc_15->move_hovering
@ SkillsDebug.c:377: {
	push	{r4, lr}	@
@ SkillsDebug.c:379:     u8* const moves = UnitGetMoveList(proc->unit);		
	ldr	r3, [r2, #44]	@ _1, proc_15->unit
@ SkillsDebug.c:377: {
	movs	r4, r0	@ menu, tmp151
@ SkillsDebug.c:380: 	if (proc->move_hovering != 0)
	cmp	r1, #0	@ tmp154,
	beq	.L54		@,
@ SkillsDebug.c:382: 		proc->hover_move_Updated = TRUE;
	movs	r1, #1	@ tmp130,
	str	r1, [r2, #56]	@ tmp130, proc_15->hover_move_Updated
@ SkillsDebug.c:383: 		proc->move_hovering = 0;
	movs	r1, #0	@ tmp131,
	str	r1, [r2, #60]	@ tmp131, proc_15->move_hovering
.L54:
@ SkillsDebug.c:386: 	if (gKeyState.repeatedKeys & KEY_BUTTON_R) { 
	ldr	r1, .L62	@ tmp132,
@ SkillsDebug.c:386: 	if (gKeyState.repeatedKeys & KEY_BUTTON_R) { 
	ldrh	r1, [r1, #6]	@ tmp134,
	lsls	r1, r1, #23	@ tmp153, tmp134,
	bpl	.L55		@,
@ SkillsDebug.c:387: 		MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering]));
	ldr	r2, [r2, #60]	@ proc_15->move_hovering, proc_15->move_hovering
	adds	r3, r3, r2	@ tmp141, _1, proc_15->move_hovering
	adds	r3, r3, #40	@ tmp144,
@ SkillsDebug.c:387: 		MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering]));
	ldrb	r0, [r3]	@ *_6, *_6
	ldr	r3, .L62+4	@ tmp146,
	bl	.L8		@
@ SkillsDebug.c:387: 		MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering]));
	lsls	r1, r0, #16	@ tmp147, tmp152,
	ldr	r3, .L62+8	@ tmp149,
	movs	r0, r4	@, menu
	lsrs	r1, r1, #16	@ tmp147, tmp147,
	bl	.L8		@
.L55:
@ SkillsDebug.c:390: }
	@ sp needed	@
	movs	r0, #0	@,
	pop	{r4}
	pop	{r1}
	bx	r1
.L63:
	.align	2
.L62:
	.word	gKeyState
	.word	GetItemDescId
	.word	MenuCallHelpBox
	.size	List_1_Idle, .-List_1_Idle
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	List_0_Idle, %function
List_0_Idle:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ SkillsDebug.c:369: 	if (gKeyState.repeatedKeys & KEY_BUTTON_R) { 
	ldr	r3, .L69	@ tmp123,
@ SkillsDebug.c:369: 	if (gKeyState.repeatedKeys & KEY_BUTTON_R) { 
	ldrh	r3, [r3, #6]	@ tmp125,
@ SkillsDebug.c:366: {
	movs	r4, r0	@ menu, tmp138
@ SkillsDebug.c:369: 	if (gKeyState.repeatedKeys & KEY_BUTTON_R) { 
	lsls	r3, r3, #23	@ tmp140, tmp125,
	bpl	.L65		@,
@ SkillsDebug.c:370: 		MenuCallHelpBox(menu, GetItemDescId(proc->skillReplacement));
	ldr	r3, [r0, #20]	@ tmp142, menu_8(D)->parent
	movs	r0, #42	@ tmp132,
	ldrsh	r0, [r3, r0]	@ tmp132, tmp142, tmp132
	ldr	r3, .L69+4	@ tmp133,
	bl	.L8		@
@ SkillsDebug.c:370: 		MenuCallHelpBox(menu, GetItemDescId(proc->skillReplacement));
	lsls	r1, r0, #16	@ tmp134, tmp139,
	ldr	r3, .L69+8	@ tmp136,
	movs	r0, r4	@, menu
	lsrs	r1, r1, #16	@ tmp134, tmp134,
	bl	.L8		@
.L65:
@ SkillsDebug.c:373: }
	@ sp needed	@
	movs	r0, #0	@,
	pop	{r4}
	pop	{r1}
	bx	r1
.L70:
	.align	2
.L69:
	.word	gKeyState
	.word	GetItemDescId
	.word	MenuCallHelpBox
	.size	List_0_Idle, .-List_0_Idle
	.section	.rodata.str1.1,"aMS",%progbits,1
.LC23:
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
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r0, r1, r2, r4, r5, r6, r7, lr}	@
@ SkillsDebug.c:975:     struct SkillDebugProc* const proc = (void*) menu->parent;
	ldr	r3, [r0, #20]	@ proc, menu_18(D)->parent
@ SkillsDebug.c:1008: }
	@ sp needed	@
@ SkillsDebug.c:975:     struct SkillDebugProc* const proc = (void*) menu->parent;
	str	r3, [sp, #4]	@ proc, %sfp
@ SkillsDebug.c:977:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldrh	r0, [r1, #42]	@ tmp135,
	ldrh	r5, [r1, #44]	@ tmp133,
@ SkillsDebug.c:979:     Text_Clear(&command->text);
	adds	r1, r1, #52	@ command,
	movs	r4, r1	@ _9, command
@ SkillsDebug.c:977:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #5	@ tmp134, tmp133,
	adds	r5, r5, r0	@ tmp136, tmp134, tmp135
@ SkillsDebug.c:977:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldr	r0, .L72	@ tmp138,
@ SkillsDebug.c:977:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #1	@ tmp137, tmp136,
@ SkillsDebug.c:977:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	adds	r5, r5, r0	@ out, tmp137, tmp138
@ SkillsDebug.c:979:     Text_Clear(&command->text);
	ldr	r3, .L72+4	@ tmp139,
	movs	r0, r1	@, _9
	bl	.L8		@
@ SkillsDebug.c:981: 	Text_SetXCursor(&command->text, new_item_desc_offset);
	ldr	r7, .L72+8	@ tmp140,
	movs	r1, #72	@,
	movs	r0, r4	@, _9
	bl	.L74		@
@ SkillsDebug.c:982: 	Text_SetColorId(&command->text, TEXT_COLOR_GREEN);
	ldr	r6, .L72+12	@ tmp141,
	movs	r1, #4	@,
	movs	r0, r4	@, _9
	bl	.L75		@
@ SkillsDebug.c:983:     Text_DrawString(&command->text, "Learn ");
	movs	r0, r4	@, _9
	ldr	r1, .L72+16	@,
	ldr	r3, .L72+20	@ tmp166,
	bl	.L8		@
@ SkillsDebug.c:984: 	Text_Display(&command->text, out); 
	movs	r1, r5	@, out
	ldr	r3, .L72+24	@ tmp168,
	movs	r0, r4	@, _9
	bl	.L8		@
@ SkillsDebug.c:986: 	Text_SetXCursor(&command->text, new_item_desc_offset+new_item_name_offset);
	movs	r1, #120	@,
	movs	r0, r4	@, _9
	bl	.L74		@
@ SkillsDebug.c:987:     Text_SetColorId(&command->text, TEXT_COLOR_BLUE);
	movs	r1, #2	@,
	movs	r0, r4	@, _9
	bl	.L75		@
@ SkillsDebug.c:988:     Text_DrawString(&command->text, GetItemName(proc->skillReplacement)); 
	ldr	r3, [sp, #4]	@ proc, %sfp
	movs	r0, #42	@ tmp147,
	ldrsh	r0, [r3, r0]	@ tmp147, proc, tmp147
	ldr	r3, .L72+28	@ tmp148,
	bl	.L8		@
@ SkillsDebug.c:988:     Text_DrawString(&command->text, GetItemName(proc->skillReplacement)); 
	ldr	r3, .L72+20	@ tmp171,
@ SkillsDebug.c:988:     Text_DrawString(&command->text, GetItemName(proc->skillReplacement)); 
	movs	r1, r0	@ _12, tmp159
@ SkillsDebug.c:988:     Text_DrawString(&command->text, GetItemName(proc->skillReplacement)); 
	movs	r0, r4	@, _9
	bl	.L8		@
@ SkillsDebug.c:989: 	Text_Display(&command->text, out); 
	movs	r1, r5	@, out
	movs	r0, r4	@, _9
	ldr	r3, .L72+24	@ tmp173,
	bl	.L8		@
@ SkillsDebug.c:1001: 	LoadIconPalettes(4); 
	movs	r0, #4	@,
	ldr	r3, .L72+32	@ tmp151,
	bl	.L8		@
@ SkillsDebug.c:1002:     DrawIcon(
	ldr	r3, [sp, #4]	@ proc, %sfp
	movs	r0, #42	@ tmp152,
	ldrsh	r0, [r3, r0]	@ tmp152, proc, tmp152
	ldr	r3, .L72+36	@ tmp153,
	bl	.L8		@
	movs	r2, #128	@ tmp161,
	movs	r1, r0	@ _16, tmp160
	movs	r0, r5	@ out, out
	ldr	r3, .L72+40	@ tmp156,
	adds	r0, r0, #26	@ out,
	lsls	r2, r2, #7	@, tmp161,
	bl	.L8		@
@ SkillsDebug.c:1008: }
	pop	{r0, r1, r2, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L73:
	.align	2
.L72:
	.word	gBg0MapBuffer
	.word	Text_Clear
	.word	Text_SetXCursor
	.word	Text_SetColorId
	.word	.LC23
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
@ SkillsDebug.c:87:     if (moveId == 0)
	cmp	r0, #0	@ moveId,
	beq	.L77		@,
@ SkillsDebug.c:90:     if (moveId == 255)
	cmp	r0, #255	@ moveId,
	beq	.L78		@,
@ SkillsDebug.c:93:     return GetItemDescId(moveId);
	ldr	r3, .L82	@ tmp115,
	bl	.L8		@
.L77:
@ SkillsDebug.c:94: }
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L78:
@ SkillsDebug.c:88:         return FALSE;
	movs	r0, #0	@ moveId,
	b	.L77		@
.L83:
	.align	2
.L82:
	.word	GetItemDescId
	.size	IsMove, .-IsMove
	.section	.rodata.str1.1
.LC44:
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
@ SkillsDebug.c:671:     u8* const moves = UnitGetMoveList(proc->unit);
	ldr	r3, [r0, #20]	@ menu_26(D)->parent, menu_26(D)->parent
@ SkillsDebug.c:673:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldrh	r5, [r1, #44]	@ tmp141,
@ SkillsDebug.c:671:     u8* const moves = UnitGetMoveList(proc->unit);
	ldr	r6, [r3, #44]	@ _1, proc_27->unit
@ SkillsDebug.c:673:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldrh	r3, [r1, #42]	@ tmp143,
@ SkillsDebug.c:676:     Text_Clear(&command->text);
	adds	r1, r1, #52	@ command,
	movs	r4, r1	@ _10, command
@ SkillsDebug.c:673:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #5	@ tmp142, tmp141,
	adds	r5, r5, r3	@ tmp144, tmp142, tmp143
@ SkillsDebug.c:673:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldr	r3, .L88	@ tmp146,
@ SkillsDebug.c:673:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #1	@ tmp145, tmp144,
@ SkillsDebug.c:676:     Text_Clear(&command->text);
	movs	r0, r1	@, _10
@ SkillsDebug.c:673:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	adds	r5, r5, r3	@ out, tmp145, tmp146
@ SkillsDebug.c:676:     Text_Clear(&command->text);
	ldr	r3, .L88+4	@ tmp147,
	bl	.L8		@
@ SkillsDebug.c:677: 	Text_SetXCursor(&command->text, new_item_desc_offset);
	movs	r1, #72	@,
	ldr	r7, .L88+8	@ tmp148,
	movs	r0, r4	@, _10
	bl	.L74		@
@ SkillsDebug.c:679:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	adds	r6, r6, #44	@ tmp152,
@ SkillsDebug.c:678:     Text_SetColorId(&command->text, TEXT_COLOR_BLUE);
	movs	r1, #2	@,
	ldr	r3, .L88+12	@ tmp191,
	movs	r0, r4	@, _10
	bl	.L8		@
@ SkillsDebug.c:679:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	ldr	r3, .L88+16	@ tmp154,
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 44B], MEM[(u8 *)_1 + 44B]
	bl	.L8		@
	ldr	r3, .L88+20	@ tmp155,
	bl	.L8		@
@ SkillsDebug.c:679:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	ldr	r3, .L88+24	@ tmp193,
@ SkillsDebug.c:679:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	movs	r1, r0	@ _14, tmp185
@ SkillsDebug.c:679:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	movs	r0, r4	@, _10
	bl	.L8		@
@ SkillsDebug.c:680: 	Text_Display(&command->text, out); 
	ldr	r3, .L88+28	@ tmp157,
	movs	r1, r5	@, out
	movs	r0, r4	@, _10
	bl	.L8		@
@ SkillsDebug.c:681: 	Text_SetXCursor(&command->text, 0);
	movs	r1, #0	@,
	movs	r0, r4	@, _10
	bl	.L74		@
@ SkillsDebug.c:683:     LoadIconPalettes(4); /* Icon palette */
	movs	r0, #4	@,
	ldr	r3, .L88+32	@ tmp159,
	bl	.L8		@
@ SkillsDebug.c:686: 	if (IsMove(moves[i])) {
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 44B], MEM[(u8 *)_1 + 44B]
	bl	IsMove		@
@ SkillsDebug.c:686: 	if (IsMove(moves[i])) {
	cmp	r0, #0	@ tmp186,
	beq	.L85		@,
@ SkillsDebug.c:687: 		DrawIcon(out + TILEMAP_INDEX(0, 0), GetItemIconId(moves[i]), TILEREF(0, 4)); 
	ldr	r3, .L88+36	@ tmp168,
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 44B], MEM[(u8 *)_1 + 44B]
	bl	.L8		@
	movs	r2, #128	@,
	movs	r1, r0	@ _20, tmp187
	lsls	r2, r2, #7	@,,
	ldr	r3, .L88+40	@ tmp170,
	movs	r0, r5	@, out
	bl	.L8		@
@ SkillsDebug.c:688: 		Text_SetXCursor(&command->text, item_name_offset);
	movs	r1, #16	@,
	movs	r0, r4	@, _10
	bl	.L74		@
@ SkillsDebug.c:689: 		Text_SetColorId(&command->text, TEXT_COLOR_BLUE);
	movs	r1, #2	@,
	ldr	r3, .L88+12	@ tmp195,
	movs	r0, r4	@, _10
	bl	.L8		@
@ SkillsDebug.c:690: 		Text_DrawString(&command->text, GetItemName(moves[i])); 
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 44B], MEM[(u8 *)_1 + 44B]
	ldr	r3, .L88+44	@ tmp177,
	bl	.L8		@
	movs	r1, r0	@ _23, tmp188
.L87:
@ SkillsDebug.c:697: }
	@ sp needed	@
@ SkillsDebug.c:694: 		Text_DrawString(&command->text, " No Move");
	movs	r0, r4	@, _10
	ldr	r3, .L88+24	@ tmp201,
	bl	.L8		@
@ SkillsDebug.c:697: }
	pop	{r3, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L85:
@ SkillsDebug.c:693: 		Text_SetColorId(&command->text, TEXT_COLOR_GRAY);
	movs	r1, #1	@,
	movs	r0, r4	@, _10
	ldr	r3, .L88+12	@ tmp199,
	bl	.L8		@
@ SkillsDebug.c:694: 		Text_DrawString(&command->text, " No Move");
	ldr	r1, .L88+48	@,
	b	.L87		@
.L89:
	.align	2
.L88:
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
	.word	.LC44
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
@ SkillsDebug.c:634:     u8* const moves = UnitGetMoveList(proc->unit);
	ldr	r3, [r0, #20]	@ menu_26(D)->parent, menu_26(D)->parent
@ SkillsDebug.c:636:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldrh	r5, [r1, #44]	@ tmp141,
@ SkillsDebug.c:634:     u8* const moves = UnitGetMoveList(proc->unit);
	ldr	r6, [r3, #44]	@ _1, proc_27->unit
@ SkillsDebug.c:636:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldrh	r3, [r1, #42]	@ tmp143,
@ SkillsDebug.c:639:     Text_Clear(&command->text);
	adds	r1, r1, #52	@ command,
	movs	r4, r1	@ _10, command
@ SkillsDebug.c:636:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #5	@ tmp142, tmp141,
	adds	r5, r5, r3	@ tmp144, tmp142, tmp143
@ SkillsDebug.c:636:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldr	r3, .L94	@ tmp146,
@ SkillsDebug.c:636:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #1	@ tmp145, tmp144,
@ SkillsDebug.c:639:     Text_Clear(&command->text);
	movs	r0, r1	@, _10
@ SkillsDebug.c:636:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	adds	r5, r5, r3	@ out, tmp145, tmp146
@ SkillsDebug.c:639:     Text_Clear(&command->text);
	ldr	r3, .L94+4	@ tmp147,
	bl	.L8		@
@ SkillsDebug.c:640: 	Text_SetXCursor(&command->text, new_item_desc_offset);
	movs	r1, #72	@,
	ldr	r7, .L94+8	@ tmp148,
	movs	r0, r4	@, _10
	bl	.L74		@
@ SkillsDebug.c:642:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	adds	r6, r6, #43	@ tmp152,
@ SkillsDebug.c:641:     Text_SetColorId(&command->text, TEXT_COLOR_BLUE);
	movs	r1, #2	@,
	ldr	r3, .L94+12	@ tmp191,
	movs	r0, r4	@, _10
	bl	.L8		@
@ SkillsDebug.c:642:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	ldr	r3, .L94+16	@ tmp154,
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 43B], MEM[(u8 *)_1 + 43B]
	bl	.L8		@
	ldr	r3, .L94+20	@ tmp155,
	bl	.L8		@
@ SkillsDebug.c:642:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	ldr	r3, .L94+24	@ tmp193,
@ SkillsDebug.c:642:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	movs	r1, r0	@ _14, tmp185
@ SkillsDebug.c:642:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	movs	r0, r4	@, _10
	bl	.L8		@
@ SkillsDebug.c:643: 	Text_Display(&command->text, out); 
	ldr	r3, .L94+28	@ tmp157,
	movs	r1, r5	@, out
	movs	r0, r4	@, _10
	bl	.L8		@
@ SkillsDebug.c:644: 	Text_SetXCursor(&command->text, 0);
	movs	r1, #0	@,
	movs	r0, r4	@, _10
	bl	.L74		@
@ SkillsDebug.c:646:     LoadIconPalettes(4); /* Icon palette */
	movs	r0, #4	@,
	ldr	r3, .L94+32	@ tmp159,
	bl	.L8		@
@ SkillsDebug.c:649: 	if (IsMove(moves[i])) {
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 43B], MEM[(u8 *)_1 + 43B]
	bl	IsMove		@
@ SkillsDebug.c:649: 	if (IsMove(moves[i])) {
	cmp	r0, #0	@ tmp186,
	beq	.L91		@,
@ SkillsDebug.c:650: 		DrawIcon(out + TILEMAP_INDEX(0, 0), GetItemIconId(moves[i]), TILEREF(0, 4)); 
	ldr	r3, .L94+36	@ tmp168,
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 43B], MEM[(u8 *)_1 + 43B]
	bl	.L8		@
	movs	r2, #128	@,
	movs	r1, r0	@ _20, tmp187
	lsls	r2, r2, #7	@,,
	ldr	r3, .L94+40	@ tmp170,
	movs	r0, r5	@, out
	bl	.L8		@
@ SkillsDebug.c:651: 		Text_SetXCursor(&command->text, item_name_offset);
	movs	r1, #16	@,
	movs	r0, r4	@, _10
	bl	.L74		@
@ SkillsDebug.c:652: 		Text_SetColorId(&command->text, TEXT_COLOR_BLUE);
	movs	r1, #2	@,
	ldr	r3, .L94+12	@ tmp195,
	movs	r0, r4	@, _10
	bl	.L8		@
@ SkillsDebug.c:653: 		Text_DrawString(&command->text, GetItemName(moves[i])); 
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 43B], MEM[(u8 *)_1 + 43B]
	ldr	r3, .L94+44	@ tmp177,
	bl	.L8		@
	movs	r1, r0	@ _23, tmp188
.L93:
@ SkillsDebug.c:660: }
	@ sp needed	@
@ SkillsDebug.c:657: 		Text_DrawString(&command->text, " No Move");
	movs	r0, r4	@, _10
	ldr	r3, .L94+24	@ tmp201,
	bl	.L8		@
@ SkillsDebug.c:660: }
	pop	{r3, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L91:
@ SkillsDebug.c:656: 		Text_SetColorId(&command->text, TEXT_COLOR_GRAY);
	movs	r1, #1	@,
	movs	r0, r4	@, _10
	ldr	r3, .L94+12	@ tmp199,
	bl	.L8		@
@ SkillsDebug.c:657: 		Text_DrawString(&command->text, " No Move");
	ldr	r1, .L94+48	@,
	b	.L93		@
.L95:
	.align	2
.L94:
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
	.word	.LC44
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
@ SkillsDebug.c:603:     u8* const moves = UnitGetMoveList(proc->unit);
	ldr	r3, [r0, #20]	@ menu_26(D)->parent, menu_26(D)->parent
@ SkillsDebug.c:605:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldrh	r5, [r1, #44]	@ tmp141,
@ SkillsDebug.c:603:     u8* const moves = UnitGetMoveList(proc->unit);
	ldr	r6, [r3, #44]	@ _1, proc_27->unit
@ SkillsDebug.c:605:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldrh	r3, [r1, #42]	@ tmp143,
@ SkillsDebug.c:607:     Text_Clear(&command->text);
	adds	r1, r1, #52	@ command,
	movs	r4, r1	@ _10, command
@ SkillsDebug.c:605:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #5	@ tmp142, tmp141,
	adds	r5, r5, r3	@ tmp144, tmp142, tmp143
@ SkillsDebug.c:605:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldr	r3, .L100	@ tmp146,
@ SkillsDebug.c:605:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #1	@ tmp145, tmp144,
@ SkillsDebug.c:607:     Text_Clear(&command->text);
	movs	r0, r1	@, _10
@ SkillsDebug.c:605:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	adds	r5, r5, r3	@ out, tmp145, tmp146
@ SkillsDebug.c:607:     Text_Clear(&command->text);
	ldr	r3, .L100+4	@ tmp147,
	bl	.L8		@
@ SkillsDebug.c:608: 	Text_SetXCursor(&command->text, new_item_desc_offset);
	movs	r1, #72	@,
	ldr	r7, .L100+8	@ tmp148,
	movs	r0, r4	@, _10
	bl	.L74		@
@ SkillsDebug.c:610:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	adds	r6, r6, #42	@ tmp152,
@ SkillsDebug.c:609:     Text_SetColorId(&command->text, TEXT_COLOR_BLUE);
	movs	r1, #2	@,
	ldr	r3, .L100+12	@ tmp191,
	movs	r0, r4	@, _10
	bl	.L8		@
@ SkillsDebug.c:610:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	ldr	r3, .L100+16	@ tmp154,
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 42B], MEM[(u8 *)_1 + 42B]
	bl	.L8		@
	ldr	r3, .L100+20	@ tmp155,
	bl	.L8		@
@ SkillsDebug.c:610:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	ldr	r3, .L100+24	@ tmp193,
@ SkillsDebug.c:610:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	movs	r1, r0	@ _14, tmp185
@ SkillsDebug.c:610:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	movs	r0, r4	@, _10
	bl	.L8		@
@ SkillsDebug.c:611: 	Text_Display(&command->text, out); 
	ldr	r3, .L100+28	@ tmp157,
	movs	r1, r5	@, out
	movs	r0, r4	@, _10
	bl	.L8		@
@ SkillsDebug.c:612: 	Text_SetXCursor(&command->text, 0);
	movs	r1, #0	@,
	movs	r0, r4	@, _10
	bl	.L74		@
@ SkillsDebug.c:614:     LoadIconPalettes(4); /* Icon palette */
	movs	r0, #4	@,
	ldr	r3, .L100+32	@ tmp159,
	bl	.L8		@
@ SkillsDebug.c:617: 	if (IsMove(moves[i])) {
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 42B], MEM[(u8 *)_1 + 42B]
	bl	IsMove		@
@ SkillsDebug.c:617: 	if (IsMove(moves[i])) {
	cmp	r0, #0	@ tmp186,
	beq	.L97		@,
@ SkillsDebug.c:618: 		DrawIcon(out + TILEMAP_INDEX(0, 0), GetItemIconId(moves[i]), TILEREF(0, 4)); 
	ldr	r3, .L100+36	@ tmp168,
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 42B], MEM[(u8 *)_1 + 42B]
	bl	.L8		@
	movs	r2, #128	@,
	movs	r1, r0	@ _20, tmp187
	lsls	r2, r2, #7	@,,
	ldr	r3, .L100+40	@ tmp170,
	movs	r0, r5	@, out
	bl	.L8		@
@ SkillsDebug.c:619: 		Text_SetXCursor(&command->text, item_name_offset);
	movs	r1, #16	@,
	movs	r0, r4	@, _10
	bl	.L74		@
@ SkillsDebug.c:620: 		Text_SetColorId(&command->text, TEXT_COLOR_BLUE);
	movs	r1, #2	@,
	ldr	r3, .L100+12	@ tmp195,
	movs	r0, r4	@, _10
	bl	.L8		@
@ SkillsDebug.c:621: 		Text_DrawString(&command->text, GetItemName(moves[i])); 
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 42B], MEM[(u8 *)_1 + 42B]
	ldr	r3, .L100+44	@ tmp177,
	bl	.L8		@
	movs	r1, r0	@ _23, tmp188
.L99:
@ SkillsDebug.c:628: }
	@ sp needed	@
@ SkillsDebug.c:625: 		Text_DrawString(&command->text, " No Move");
	movs	r0, r4	@, _10
	ldr	r3, .L100+24	@ tmp201,
	bl	.L8		@
@ SkillsDebug.c:628: }
	pop	{r3, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L97:
@ SkillsDebug.c:624: 		Text_SetColorId(&command->text, TEXT_COLOR_GRAY);
	movs	r1, #1	@,
	movs	r0, r4	@, _10
	ldr	r3, .L100+12	@ tmp199,
	bl	.L8		@
@ SkillsDebug.c:625: 		Text_DrawString(&command->text, " No Move");
	ldr	r1, .L100+48	@,
	b	.L99		@
.L101:
	.align	2
.L100:
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
	.word	.LC44
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
@ SkillsDebug.c:572:     u8* const moves = UnitGetMoveList(proc->unit);
	ldr	r3, [r0, #20]	@ menu_26(D)->parent, menu_26(D)->parent
@ SkillsDebug.c:574:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldrh	r5, [r1, #44]	@ tmp141,
@ SkillsDebug.c:572:     u8* const moves = UnitGetMoveList(proc->unit);
	ldr	r6, [r3, #44]	@ _1, proc_27->unit
@ SkillsDebug.c:574:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldrh	r3, [r1, #42]	@ tmp143,
@ SkillsDebug.c:576:     Text_Clear(&command->text);
	adds	r1, r1, #52	@ command,
	movs	r4, r1	@ _10, command
@ SkillsDebug.c:574:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #5	@ tmp142, tmp141,
	adds	r5, r5, r3	@ tmp144, tmp142, tmp143
@ SkillsDebug.c:574:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldr	r3, .L106	@ tmp146,
@ SkillsDebug.c:574:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #1	@ tmp145, tmp144,
@ SkillsDebug.c:576:     Text_Clear(&command->text);
	movs	r0, r1	@, _10
@ SkillsDebug.c:574:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	adds	r5, r5, r3	@ out, tmp145, tmp146
@ SkillsDebug.c:576:     Text_Clear(&command->text);
	ldr	r3, .L106+4	@ tmp147,
	bl	.L8		@
@ SkillsDebug.c:577: 	Text_SetXCursor(&command->text, new_item_desc_offset);
	movs	r1, #72	@,
	ldr	r7, .L106+8	@ tmp148,
	movs	r0, r4	@, _10
	bl	.L74		@
@ SkillsDebug.c:579:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	adds	r6, r6, #41	@ tmp152,
@ SkillsDebug.c:578:     Text_SetColorId(&command->text, TEXT_COLOR_BLUE);
	movs	r1, #2	@,
	ldr	r3, .L106+12	@ tmp191,
	movs	r0, r4	@, _10
	bl	.L8		@
@ SkillsDebug.c:579:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	ldr	r3, .L106+16	@ tmp154,
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 41B], MEM[(u8 *)_1 + 41B]
	bl	.L8		@
	ldr	r3, .L106+20	@ tmp155,
	bl	.L8		@
@ SkillsDebug.c:579:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	ldr	r3, .L106+24	@ tmp193,
@ SkillsDebug.c:579:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	movs	r1, r0	@ _14, tmp185
@ SkillsDebug.c:579:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	movs	r0, r4	@, _10
	bl	.L8		@
@ SkillsDebug.c:580: 	Text_Display(&command->text, out); 
	ldr	r3, .L106+28	@ tmp157,
	movs	r1, r5	@, out
	movs	r0, r4	@, _10
	bl	.L8		@
@ SkillsDebug.c:581: 	Text_SetXCursor(&command->text, 0);
	movs	r1, #0	@,
	movs	r0, r4	@, _10
	bl	.L74		@
@ SkillsDebug.c:583:     LoadIconPalettes(4); /* Icon palette */
	movs	r0, #4	@,
	ldr	r3, .L106+32	@ tmp159,
	bl	.L8		@
@ SkillsDebug.c:586: 	if (IsMove(moves[i])) {
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 41B], MEM[(u8 *)_1 + 41B]
	bl	IsMove		@
@ SkillsDebug.c:586: 	if (IsMove(moves[i])) {
	cmp	r0, #0	@ tmp186,
	beq	.L103		@,
@ SkillsDebug.c:587: 		DrawIcon(out + TILEMAP_INDEX(0, 0), GetItemIconId(moves[i]), TILEREF(0, 4)); 
	ldr	r3, .L106+36	@ tmp168,
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 41B], MEM[(u8 *)_1 + 41B]
	bl	.L8		@
	movs	r2, #128	@,
	movs	r1, r0	@ _20, tmp187
	lsls	r2, r2, #7	@,,
	ldr	r3, .L106+40	@ tmp170,
	movs	r0, r5	@, out
	bl	.L8		@
@ SkillsDebug.c:588: 		Text_SetXCursor(&command->text, item_name_offset);
	movs	r1, #16	@,
	movs	r0, r4	@, _10
	bl	.L74		@
@ SkillsDebug.c:589: 		Text_SetColorId(&command->text, TEXT_COLOR_BLUE);
	movs	r1, #2	@,
	ldr	r3, .L106+12	@ tmp195,
	movs	r0, r4	@, _10
	bl	.L8		@
@ SkillsDebug.c:590: 		Text_DrawString(&command->text, GetItemName(moves[i])); 
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 41B], MEM[(u8 *)_1 + 41B]
	ldr	r3, .L106+44	@ tmp177,
	bl	.L8		@
	movs	r1, r0	@ _23, tmp188
.L105:
@ SkillsDebug.c:597: }
	@ sp needed	@
@ SkillsDebug.c:594: 		Text_DrawString(&command->text, " No Move");
	movs	r0, r4	@, _10
	ldr	r3, .L106+24	@ tmp201,
	bl	.L8		@
@ SkillsDebug.c:597: }
	pop	{r3, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L103:
@ SkillsDebug.c:593: 		Text_SetColorId(&command->text, TEXT_COLOR_GRAY);
	movs	r1, #1	@,
	movs	r0, r4	@, _10
	ldr	r3, .L106+12	@ tmp199,
	bl	.L8		@
@ SkillsDebug.c:594: 		Text_DrawString(&command->text, " No Move");
	ldr	r1, .L106+48	@,
	b	.L105		@
.L107:
	.align	2
.L106:
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
	.word	.LC44
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
@ SkillsDebug.c:542:     u8* const moves = UnitGetMoveList(proc->unit);
	ldr	r3, [r0, #20]	@ menu_26(D)->parent, menu_26(D)->parent
@ SkillsDebug.c:544:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldrh	r5, [r1, #44]	@ tmp141,
@ SkillsDebug.c:542:     u8* const moves = UnitGetMoveList(proc->unit);
	ldr	r6, [r3, #44]	@ _1, proc_27->unit
@ SkillsDebug.c:544:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldrh	r3, [r1, #42]	@ tmp143,
@ SkillsDebug.c:546:     Text_Clear(&command->text);
	adds	r1, r1, #52	@ command,
	movs	r4, r1	@ _10, command
@ SkillsDebug.c:544:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #5	@ tmp142, tmp141,
	adds	r5, r5, r3	@ tmp144, tmp142, tmp143
@ SkillsDebug.c:544:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldr	r3, .L112	@ tmp146,
@ SkillsDebug.c:544:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #1	@ tmp145, tmp144,
@ SkillsDebug.c:546:     Text_Clear(&command->text);
	movs	r0, r1	@, _10
@ SkillsDebug.c:544:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	adds	r5, r5, r3	@ out, tmp145, tmp146
@ SkillsDebug.c:546:     Text_Clear(&command->text);
	ldr	r3, .L112+4	@ tmp147,
	bl	.L8		@
@ SkillsDebug.c:547: 	Text_SetXCursor(&command->text, new_item_desc_offset);
	movs	r1, #72	@,
	ldr	r7, .L112+8	@ tmp148,
	movs	r0, r4	@, _10
	bl	.L74		@
@ SkillsDebug.c:549:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	adds	r6, r6, #40	@ tmp152,
@ SkillsDebug.c:548:     Text_SetColorId(&command->text, TEXT_COLOR_BLUE);
	movs	r1, #2	@,
	ldr	r3, .L112+12	@ tmp191,
	movs	r0, r4	@, _10
	bl	.L8		@
@ SkillsDebug.c:549:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	ldr	r3, .L112+16	@ tmp154,
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 40B], MEM[(u8 *)_1 + 40B]
	bl	.L8		@
	ldr	r3, .L112+20	@ tmp155,
	bl	.L8		@
@ SkillsDebug.c:549:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	ldr	r3, .L112+24	@ tmp193,
@ SkillsDebug.c:549:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	movs	r1, r0	@ _14, tmp185
@ SkillsDebug.c:549:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	movs	r0, r4	@, _10
	bl	.L8		@
@ SkillsDebug.c:550: 	Text_Display(&command->text, out); 
	ldr	r3, .L112+28	@ tmp157,
	movs	r1, r5	@, out
	movs	r0, r4	@, _10
	bl	.L8		@
@ SkillsDebug.c:551: 	Text_SetXCursor(&command->text, 0);
	movs	r1, #0	@,
	movs	r0, r4	@, _10
	bl	.L74		@
@ SkillsDebug.c:553:     LoadIconPalettes(4); /* Icon palette */
	movs	r0, #4	@,
	ldr	r3, .L112+32	@ tmp159,
	bl	.L8		@
@ SkillsDebug.c:555: 	if (IsMove(moves[i])) {
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 40B], MEM[(u8 *)_1 + 40B]
	bl	IsMove		@
@ SkillsDebug.c:555: 	if (IsMove(moves[i])) {
	cmp	r0, #0	@ tmp186,
	beq	.L109		@,
@ SkillsDebug.c:556: 		DrawIcon(out + TILEMAP_INDEX(0, 0), GetItemIconId(moves[i]), TILEREF(0, 4)); 
	ldr	r3, .L112+36	@ tmp168,
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 40B], MEM[(u8 *)_1 + 40B]
	bl	.L8		@
	movs	r2, #128	@,
	movs	r1, r0	@ _20, tmp187
	lsls	r2, r2, #7	@,,
	ldr	r3, .L112+40	@ tmp170,
	movs	r0, r5	@, out
	bl	.L8		@
@ SkillsDebug.c:557: 		Text_SetXCursor(&command->text, item_name_offset);
	movs	r1, #16	@,
	movs	r0, r4	@, _10
	bl	.L74		@
@ SkillsDebug.c:558: 		Text_SetColorId(&command->text, TEXT_COLOR_BLUE);
	movs	r1, #2	@,
	ldr	r3, .L112+12	@ tmp195,
	movs	r0, r4	@, _10
	bl	.L8		@
@ SkillsDebug.c:559: 		Text_DrawString(&command->text, GetItemName(moves[i])); 
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 40B], MEM[(u8 *)_1 + 40B]
	ldr	r3, .L112+44	@ tmp177,
	bl	.L8		@
	movs	r1, r0	@ _23, tmp188
.L111:
@ SkillsDebug.c:566: }
	@ sp needed	@
@ SkillsDebug.c:563: 		Text_DrawString(&command->text, " No Move");
	movs	r0, r4	@, _10
	ldr	r3, .L112+24	@ tmp201,
	bl	.L8		@
@ SkillsDebug.c:566: }
	pop	{r3, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L109:
@ SkillsDebug.c:562: 		Text_SetColorId(&command->text, TEXT_COLOR_GRAY);
	movs	r1, #1	@,
	movs	r0, r4	@, _10
	ldr	r3, .L112+12	@ tmp199,
	bl	.L8		@
@ SkillsDebug.c:563: 		Text_DrawString(&command->text, " No Move");
	ldr	r1, .L112+48	@,
	b	.L111		@
.L113:
	.align	2
.L112:
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
	.word	.LC44
	.size	SkillListCommandDraw_1, .-SkillListCommandDraw_1
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
@ SkillsDebug.c:334:     struct SkillDebugProc* proc = (void*) ProcStart(Proc_SkillDebug, ROOT_PROC_3);
	ldr	r4, .L115	@ tmp122,
@ SkillsDebug.c:363: }
	@ sp needed	@
@ SkillsDebug.c:334:     struct SkillDebugProc* proc = (void*) ProcStart(Proc_SkillDebug, ROOT_PROC_3);
	movs	r1, #3	@,
	movs	r0, r4	@, tmp122
	ldr	r3, .L115+4	@ tmp123,
	bl	.L8		@
@ SkillsDebug.c:339: 	proc->skillReplacement = *gVeslySkill; // Short 
	ldr	r3, .L115+8	@ tmp124,
	movs	r2, #0	@ tmp146,
	ldrsh	r3, [r3, r2]	@ _2, tmp124, tmp146
@ SkillsDebug.c:340:     proc->unit = (struct Unit*) *gVeslyUnit; // Struct UnitRamPointer 
	ldr	r2, .L115+12	@ tmp130,
	ldr	r2, [r2]	@ _3, MEM[(int *)50337724B]
@ SkillsDebug.c:339: 	proc->skillReplacement = *gVeslySkill; // Short 
	strh	r3, [r0, #42]	@ _2, proc_8->skillReplacement
@ SkillsDebug.c:340:     proc->unit = (struct Unit*) *gVeslyUnit; // Struct UnitRamPointer 
	str	r2, [r0, #44]	@ _3, proc_8->unit
@ SkillsDebug.c:334:     struct SkillDebugProc* proc = (void*) ProcStart(Proc_SkillDebug, ROOT_PROC_3);
	movs	r1, r0	@ proc, tmp145
@ SkillsDebug.c:347: 	*MemorySlot1 = proc->unit; 
	ldr	r0, .L115+16	@ tmp131,
	str	r2, [r0]	@ _3, MEM[(int *)50332860B]
@ SkillsDebug.c:348: 	*MemorySlot3 = 0xF8;
	movs	r0, #248	@ tmp133,
	ldr	r2, .L115+20	@ tmp132,
	str	r0, [r2]	@ tmp133, MEM[(int *)50332868B]
@ SkillsDebug.c:349: 	*MemorySlot4 = proc->skillReplacement; 
	ldr	r2, .L115+24	@ tmp134,
@ SkillsDebug.c:361:     StartMenuChild(&Menu_SkillDebug, (void*) proc);
	movs	r0, r4	@ tmp122, tmp122
@ SkillsDebug.c:349: 	*MemorySlot4 = proc->skillReplacement; 
	str	r3, [r2]	@ _2, MEM[(int *)50332872B]
@ SkillsDebug.c:352: 	*MemorySlot6 = 0; // TRUE 
	movs	r3, #0	@ tmp136,
	ldr	r2, .L115+28	@ tmp135,
@ SkillsDebug.c:361:     StartMenuChild(&Menu_SkillDebug, (void*) proc);
	adds	r0, r0, #40	@ tmp122,
@ SkillsDebug.c:352: 	*MemorySlot6 = 0; // TRUE 
	str	r3, [r2]	@ tmp136, MEM[(int *)50332880B]
@ SkillsDebug.c:355:     proc->movesUpdated = FALSE;
	str	r3, [r1, #48]	@ tmp136, proc_8->movesUpdated
@ SkillsDebug.c:356:     proc->skillSelected = 0;
	str	r3, [r1, #52]	@ tmp136, proc_8->skillSelected
@ SkillsDebug.c:359: 	proc->hover_move_Updated = FALSE; 
	str	r3, [r1, #56]	@ tmp136, proc_8->hover_move_Updated
@ SkillsDebug.c:360: 	proc->move_hovering = 0;
	str	r3, [r1, #60]	@ tmp136, proc_8->move_hovering
@ SkillsDebug.c:361:     StartMenuChild(&Menu_SkillDebug, (void*) proc);
	ldr	r3, .L115+32	@ tmp143,
	bl	.L8		@
@ SkillsDebug.c:363: }
	movs	r0, #23	@,
	pop	{r4}
	pop	{r1}
	bx	r1
.L116:
	.align	2
.L115:
	.word	.LANCHOR0
	.word	ProcStart
	.word	33733854
	.word	50337724
	.word	50332860
	.word	50332868
	.word	50332872
	.word	50332880
	.word	StartMenuChild
	.size	SkillDebugCommand_OnSelect, .-SkillDebugCommand_OnSelect
	.section	.rodata
	.align	2
	.set	.LANCHOR0,. + 0
	.type	Proc_SkillDebug, %object
	.size	Proc_SkillDebug, 40
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
	.word	PostForgetOldMoveMenu
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
	.word	BPressForgetOldMoveMenu
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
@ onIdle:
	.word	List_0_Idle
	.space	8
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
.L8:
	bx	r3
.L75:
	bx	r6
.L74:
	bx	r7
