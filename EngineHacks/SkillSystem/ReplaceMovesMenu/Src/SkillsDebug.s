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
@ SkillsDebug.c:851: }
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
@ SkillsDebug.c:920: 	*MemorySlot5 = proc->move_hovering; 
	ldr	r3, [r0, #20]	@ menu_3(D)->parent, menu_3(D)->parent
@ SkillsDebug.c:952: }
	@ sp needed	@
@ SkillsDebug.c:920: 	*MemorySlot5 = proc->move_hovering; 
	ldr	r2, [r3, #60]	@ _1, proc_4->move_hovering
@ SkillsDebug.c:920: 	*MemorySlot5 = proc->move_hovering; 
	ldr	r3, .L3	@ tmp119,
	str	r2, [r3]	@ _1, MEM[(int *)50332876B]
@ SkillsDebug.c:924: 	*MemorySlot6 = 1; // TRUE 
	movs	r2, #1	@ tmp121,
	ldr	r3, .L3+4	@ tmp120,
@ SkillsDebug.c:952: }
	movs	r0, #23	@,
@ SkillsDebug.c:924: 	*MemorySlot6 = 1; // TRUE 
	str	r2, [r3]	@ tmp121, MEM[(int *)50332880B]
@ SkillsDebug.c:952: }
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
@ SkillsDebug.c:1107:     EndFaceById(0);
	movs	r0, #0	@,
@ SkillsDebug.c:1108: }
	@ sp needed	@
@ SkillsDebug.c:1107:     EndFaceById(0);
	ldr	r3, .L6	@ tmp114,
	bl	.L8		@
@ SkillsDebug.c:1108: }
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
	.type	List_8_Idle, %function
List_8_Idle:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
@ SkillsDebug.c:521:     struct SkillDebugProc* const proc = (void*) menu->parent;
	ldr	r2, [r0, #20]	@ proc, menu_14(D)->parent
@ SkillsDebug.c:523: 	if (proc->move_hovering != 7)
	ldr	r1, [r2, #60]	@ tmp154, proc_15->move_hovering
@ SkillsDebug.c:520: {
	push	{r4, lr}	@
@ SkillsDebug.c:522:     u8* const moves = UnitGetMoveList(proc->unit);	
	ldr	r3, [r2, #44]	@ _1, proc_15->unit
@ SkillsDebug.c:520: {
	movs	r4, r0	@ menu, tmp151
@ SkillsDebug.c:523: 	if (proc->move_hovering != 7)
	cmp	r1, #7	@ tmp154,
	beq	.L10		@,
@ SkillsDebug.c:525: 		proc->hover_move_Updated = TRUE;
	movs	r1, #1	@ tmp130,
	str	r1, [r2, #56]	@ tmp130, proc_15->hover_move_Updated
@ SkillsDebug.c:526: 		proc->move_hovering = 7;
	adds	r1, r1, #6	@ tmp131,
	str	r1, [r2, #60]	@ tmp131, proc_15->move_hovering
.L10:
@ SkillsDebug.c:528: 	if (gKeyState.repeatedKeys & KEY_BUTTON_R) { 
	ldr	r1, .L18	@ tmp132,
@ SkillsDebug.c:528: 	if (gKeyState.repeatedKeys & KEY_BUTTON_R) { 
	ldrh	r1, [r1, #6]	@ tmp134,
	lsls	r1, r1, #23	@ tmp153, tmp134,
	bpl	.L11		@,
@ SkillsDebug.c:529: 		MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering]));
	ldr	r2, [r2, #60]	@ proc_15->move_hovering, proc_15->move_hovering
	adds	r3, r3, r2	@ tmp141, _1, proc_15->move_hovering
	adds	r3, r3, #40	@ tmp144,
@ SkillsDebug.c:529: 		MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering]));
	ldrb	r0, [r3]	@ *_6, *_6
	ldr	r3, .L18+4	@ tmp146,
	bl	.L8		@
@ SkillsDebug.c:529: 		MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering]));
	lsls	r1, r0, #16	@ tmp147, tmp152,
	ldr	r3, .L18+8	@ tmp149,
	movs	r0, r4	@, menu
	lsrs	r1, r1, #16	@ tmp147, tmp147,
	bl	.L8		@
.L11:
@ SkillsDebug.c:532: }
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
	.size	List_8_Idle, .-List_8_Idle
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
@ SkillsDebug.c:506:     struct SkillDebugProc* const proc = (void*) menu->parent;
	ldr	r2, [r0, #20]	@ proc, menu_14(D)->parent
@ SkillsDebug.c:508: 	if (proc->move_hovering != 6)
	ldr	r1, [r2, #60]	@ tmp154, proc_15->move_hovering
@ SkillsDebug.c:505: {
	push	{r4, lr}	@
@ SkillsDebug.c:507:     u8* const moves = UnitGetMoveList(proc->unit);	
	ldr	r3, [r2, #44]	@ _1, proc_15->unit
@ SkillsDebug.c:505: {
	movs	r4, r0	@ menu, tmp151
@ SkillsDebug.c:508: 	if (proc->move_hovering != 6)
	cmp	r1, #6	@ tmp154,
	beq	.L21		@,
@ SkillsDebug.c:510: 		proc->hover_move_Updated = TRUE;
	movs	r1, #1	@ tmp130,
	str	r1, [r2, #56]	@ tmp130, proc_15->hover_move_Updated
@ SkillsDebug.c:511: 		proc->move_hovering = 6;
	adds	r1, r1, #5	@ tmp131,
	str	r1, [r2, #60]	@ tmp131, proc_15->move_hovering
.L21:
@ SkillsDebug.c:513: 	if (gKeyState.repeatedKeys & KEY_BUTTON_R) { 
	ldr	r1, .L29	@ tmp132,
@ SkillsDebug.c:513: 	if (gKeyState.repeatedKeys & KEY_BUTTON_R) { 
	ldrh	r1, [r1, #6]	@ tmp134,
	lsls	r1, r1, #23	@ tmp153, tmp134,
	bpl	.L22		@,
@ SkillsDebug.c:514: 		MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering]));
	ldr	r2, [r2, #60]	@ proc_15->move_hovering, proc_15->move_hovering
	adds	r3, r3, r2	@ tmp141, _1, proc_15->move_hovering
	adds	r3, r3, #40	@ tmp144,
@ SkillsDebug.c:514: 		MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering]));
	ldrb	r0, [r3]	@ *_6, *_6
	ldr	r3, .L29+4	@ tmp146,
	bl	.L8		@
@ SkillsDebug.c:514: 		MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering]));
	lsls	r1, r0, #16	@ tmp147, tmp152,
	ldr	r3, .L29+8	@ tmp149,
	movs	r0, r4	@, menu
	lsrs	r1, r1, #16	@ tmp147, tmp147,
	bl	.L8		@
.L22:
@ SkillsDebug.c:517: }
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
	.size	List_7_Idle, .-List_7_Idle
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
@ SkillsDebug.c:487:     struct SkillDebugProc* const proc = (void*) menu->parent;
	ldr	r2, [r0, #20]	@ proc, menu_14(D)->parent
@ SkillsDebug.c:489: 	if (proc->move_hovering != 5)
	ldr	r1, [r2, #60]	@ tmp154, proc_15->move_hovering
@ SkillsDebug.c:486: {
	push	{r4, lr}	@
@ SkillsDebug.c:488:     u8* const moves = UnitGetMoveList(proc->unit);	
	ldr	r3, [r2, #44]	@ _1, proc_15->unit
@ SkillsDebug.c:486: {
	movs	r4, r0	@ menu, tmp151
@ SkillsDebug.c:489: 	if (proc->move_hovering != 5)
	cmp	r1, #5	@ tmp154,
	beq	.L32		@,
@ SkillsDebug.c:491: 		proc->hover_move_Updated = TRUE;
	movs	r1, #1	@ tmp130,
	str	r1, [r2, #56]	@ tmp130, proc_15->hover_move_Updated
@ SkillsDebug.c:492: 		proc->move_hovering = 5;
	adds	r1, r1, #4	@ tmp131,
	str	r1, [r2, #60]	@ tmp131, proc_15->move_hovering
.L32:
@ SkillsDebug.c:495: 	if (gKeyState.repeatedKeys & KEY_BUTTON_R) { 
	ldr	r1, .L40	@ tmp132,
@ SkillsDebug.c:495: 	if (gKeyState.repeatedKeys & KEY_BUTTON_R) { 
	ldrh	r1, [r1, #6]	@ tmp134,
	lsls	r1, r1, #23	@ tmp153, tmp134,
	bpl	.L33		@,
@ SkillsDebug.c:496: 		MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering]));
	ldr	r2, [r2, #60]	@ proc_15->move_hovering, proc_15->move_hovering
	adds	r3, r3, r2	@ tmp141, _1, proc_15->move_hovering
	adds	r3, r3, #40	@ tmp144,
@ SkillsDebug.c:496: 		MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering]));
	ldrb	r0, [r3]	@ *_6, *_6
	ldr	r3, .L40+4	@ tmp146,
	bl	.L8		@
@ SkillsDebug.c:496: 		MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering]));
	lsls	r1, r0, #16	@ tmp147, tmp152,
	ldr	r3, .L40+8	@ tmp149,
	movs	r0, r4	@, menu
	lsrs	r1, r1, #16	@ tmp147, tmp147,
	bl	.L8		@
.L33:
@ SkillsDebug.c:501: }
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
	.size	List_6_Idle, .-List_6_Idle
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
@ SkillsDebug.c:472:     struct SkillDebugProc* const proc = (void*) menu->parent;
	ldr	r2, [r0, #20]	@ proc, menu_14(D)->parent
@ SkillsDebug.c:474: 	if (proc->move_hovering != 4)
	ldr	r1, [r2, #60]	@ tmp154, proc_15->move_hovering
@ SkillsDebug.c:471: {
	push	{r4, lr}	@
@ SkillsDebug.c:473:     u8* const moves = UnitGetMoveList(proc->unit);		
	ldr	r3, [r2, #44]	@ _1, proc_15->unit
@ SkillsDebug.c:471: {
	movs	r4, r0	@ menu, tmp151
@ SkillsDebug.c:474: 	if (proc->move_hovering != 4)
	cmp	r1, #4	@ tmp154,
	beq	.L43		@,
@ SkillsDebug.c:476: 		proc->hover_move_Updated = TRUE;
	movs	r1, #1	@ tmp130,
	str	r1, [r2, #56]	@ tmp130, proc_15->hover_move_Updated
@ SkillsDebug.c:477: 		proc->move_hovering = 4;
	adds	r1, r1, #3	@ tmp131,
	str	r1, [r2, #60]	@ tmp131, proc_15->move_hovering
.L43:
@ SkillsDebug.c:479: 	if (gKeyState.repeatedKeys & KEY_BUTTON_R) { 
	ldr	r1, .L51	@ tmp132,
@ SkillsDebug.c:479: 	if (gKeyState.repeatedKeys & KEY_BUTTON_R) { 
	ldrh	r1, [r1, #6]	@ tmp134,
	lsls	r1, r1, #23	@ tmp153, tmp134,
	bpl	.L44		@,
@ SkillsDebug.c:480: 		MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering]));
	ldr	r2, [r2, #60]	@ proc_15->move_hovering, proc_15->move_hovering
	adds	r3, r3, r2	@ tmp141, _1, proc_15->move_hovering
	adds	r3, r3, #40	@ tmp144,
@ SkillsDebug.c:480: 		MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering]));
	ldrb	r0, [r3]	@ *_6, *_6
	ldr	r3, .L51+4	@ tmp146,
	bl	.L8		@
@ SkillsDebug.c:480: 		MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering]));
	lsls	r1, r0, #16	@ tmp147, tmp152,
	ldr	r3, .L51+8	@ tmp149,
	movs	r0, r4	@, menu
	lsrs	r1, r1, #16	@ tmp147, tmp147,
	bl	.L8		@
.L44:
@ SkillsDebug.c:483: }
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
@ SkillsDebug.c:456:     struct SkillDebugProc* const proc = (void*) menu->parent;
	ldr	r2, [r0, #20]	@ proc, menu_14(D)->parent
@ SkillsDebug.c:458: 	if (proc->move_hovering != 3)
	ldr	r1, [r2, #60]	@ tmp154, proc_15->move_hovering
@ SkillsDebug.c:455: {
	push	{r4, lr}	@
@ SkillsDebug.c:457:     u8* const moves = UnitGetMoveList(proc->unit);		
	ldr	r3, [r2, #44]	@ _1, proc_15->unit
@ SkillsDebug.c:455: {
	movs	r4, r0	@ menu, tmp151
@ SkillsDebug.c:458: 	if (proc->move_hovering != 3)
	cmp	r1, #3	@ tmp154,
	beq	.L54		@,
@ SkillsDebug.c:460: 		proc->hover_move_Updated = TRUE;
	movs	r1, #1	@ tmp130,
	str	r1, [r2, #56]	@ tmp130, proc_15->hover_move_Updated
@ SkillsDebug.c:461: 		proc->move_hovering = 3;
	adds	r1, r1, #2	@ tmp131,
	str	r1, [r2, #60]	@ tmp131, proc_15->move_hovering
.L54:
@ SkillsDebug.c:464: 	if (gKeyState.repeatedKeys & KEY_BUTTON_R) { 
	ldr	r1, .L62	@ tmp132,
@ SkillsDebug.c:464: 	if (gKeyState.repeatedKeys & KEY_BUTTON_R) { 
	ldrh	r1, [r1, #6]	@ tmp134,
	lsls	r1, r1, #23	@ tmp153, tmp134,
	bpl	.L55		@,
@ SkillsDebug.c:465: 		MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering]));
	ldr	r2, [r2, #60]	@ proc_15->move_hovering, proc_15->move_hovering
	adds	r3, r3, r2	@ tmp141, _1, proc_15->move_hovering
	adds	r3, r3, #40	@ tmp144,
@ SkillsDebug.c:465: 		MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering]));
	ldrb	r0, [r3]	@ *_6, *_6
	ldr	r3, .L62+4	@ tmp146,
	bl	.L8		@
@ SkillsDebug.c:465: 		MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering]));
	lsls	r1, r0, #16	@ tmp147, tmp152,
	ldr	r3, .L62+8	@ tmp149,
	movs	r0, r4	@, menu
	lsrs	r1, r1, #16	@ tmp147, tmp147,
	bl	.L8		@
.L55:
@ SkillsDebug.c:468: }
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
@ SkillsDebug.c:438:     struct SkillDebugProc* const proc = (void*) menu->parent;
	ldr	r2, [r0, #20]	@ proc, menu_14(D)->parent
@ SkillsDebug.c:440: 	if (proc->move_hovering != 2)
	ldr	r1, [r2, #60]	@ tmp154, proc_15->move_hovering
@ SkillsDebug.c:437: {
	push	{r4, lr}	@
@ SkillsDebug.c:439:     u8* const moves = UnitGetMoveList(proc->unit);		
	ldr	r3, [r2, #44]	@ _1, proc_15->unit
@ SkillsDebug.c:437: {
	movs	r4, r0	@ menu, tmp151
@ SkillsDebug.c:440: 	if (proc->move_hovering != 2)
	cmp	r1, #2	@ tmp154,
	beq	.L65		@,
@ SkillsDebug.c:442: 		proc->hover_move_Updated = TRUE;
	movs	r1, #1	@ tmp130,
	str	r1, [r2, #56]	@ tmp130, proc_15->hover_move_Updated
@ SkillsDebug.c:443: 		proc->move_hovering = 2;
	adds	r1, r1, r1	@ tmp131, tmp131,
	str	r1, [r2, #60]	@ tmp131, proc_15->move_hovering
.L65:
@ SkillsDebug.c:445: 	if (gKeyState.repeatedKeys & KEY_BUTTON_R) { 
	ldr	r1, .L73	@ tmp132,
@ SkillsDebug.c:445: 	if (gKeyState.repeatedKeys & KEY_BUTTON_R) { 
	ldrh	r1, [r1, #6]	@ tmp134,
	lsls	r1, r1, #23	@ tmp153, tmp134,
	bpl	.L66		@,
@ SkillsDebug.c:446: 		MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering]));
	ldr	r2, [r2, #60]	@ proc_15->move_hovering, proc_15->move_hovering
	adds	r3, r3, r2	@ tmp141, _1, proc_15->move_hovering
	adds	r3, r3, #40	@ tmp144,
@ SkillsDebug.c:446: 		MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering]));
	ldrb	r0, [r3]	@ *_6, *_6
	ldr	r3, .L73+4	@ tmp146,
	bl	.L8		@
@ SkillsDebug.c:446: 		MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering]));
	lsls	r1, r0, #16	@ tmp147, tmp152,
	ldr	r3, .L73+8	@ tmp149,
	movs	r0, r4	@, menu
	lsrs	r1, r1, #16	@ tmp147, tmp147,
	bl	.L8		@
.L66:
@ SkillsDebug.c:452: }
	@ sp needed	@
	movs	r0, #0	@,
	pop	{r4}
	pop	{r1}
	bx	r1
.L74:
	.align	2
.L73:
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
@ SkillsDebug.c:422:     struct SkillDebugProc* const proc = (void*) menu->parent;
	ldr	r2, [r0, #20]	@ proc, menu_14(D)->parent
@ SkillsDebug.c:424: 	if (proc->move_hovering != 1)
	ldr	r1, [r2, #60]	@ tmp154, proc_15->move_hovering
@ SkillsDebug.c:421: {
	push	{r4, lr}	@
@ SkillsDebug.c:423:     u8* const moves = UnitGetMoveList(proc->unit);		
	ldr	r3, [r2, #44]	@ _1, proc_15->unit
@ SkillsDebug.c:421: {
	movs	r4, r0	@ menu, tmp151
@ SkillsDebug.c:424: 	if (proc->move_hovering != 1)
	cmp	r1, #1	@ tmp154,
	beq	.L76		@,
@ SkillsDebug.c:426: 		proc->hover_move_Updated = TRUE;
	movs	r1, #1	@ tmp130,
	str	r1, [r2, #56]	@ tmp130, proc_15->hover_move_Updated
@ SkillsDebug.c:427: 		proc->move_hovering = 1;
	str	r1, [r2, #60]	@ tmp130, proc_15->move_hovering
.L76:
@ SkillsDebug.c:430: 	if (gKeyState.repeatedKeys & KEY_BUTTON_R) { 
	ldr	r1, .L84	@ tmp132,
@ SkillsDebug.c:430: 	if (gKeyState.repeatedKeys & KEY_BUTTON_R) { 
	ldrh	r1, [r1, #6]	@ tmp134,
	lsls	r1, r1, #23	@ tmp153, tmp134,
	bpl	.L77		@,
@ SkillsDebug.c:431: 		MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering]));
	ldr	r2, [r2, #60]	@ proc_15->move_hovering, proc_15->move_hovering
	adds	r3, r3, r2	@ tmp141, _1, proc_15->move_hovering
	adds	r3, r3, #40	@ tmp144,
@ SkillsDebug.c:431: 		MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering]));
	ldrb	r0, [r3]	@ *_6, *_6
	ldr	r3, .L84+4	@ tmp146,
	bl	.L8		@
@ SkillsDebug.c:431: 		MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering]));
	lsls	r1, r0, #16	@ tmp147, tmp152,
	ldr	r3, .L84+8	@ tmp149,
	movs	r0, r4	@, menu
	lsrs	r1, r1, #16	@ tmp147, tmp147,
	bl	.L8		@
.L77:
@ SkillsDebug.c:434: }
	@ sp needed	@
	movs	r0, #0	@,
	pop	{r4}
	pop	{r1}
	bx	r1
.L85:
	.align	2
.L84:
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
@ SkillsDebug.c:405:     struct SkillDebugProc* const proc = (void*) menu->parent;
	ldr	r2, [r0, #20]	@ proc, menu_14(D)->parent
@ SkillsDebug.c:407: 	if (proc->move_hovering != 0)
	ldr	r1, [r2, #60]	@ tmp154, proc_15->move_hovering
@ SkillsDebug.c:404: {
	push	{r4, lr}	@
@ SkillsDebug.c:406:     u8* const moves = UnitGetMoveList(proc->unit);		
	ldr	r3, [r2, #44]	@ _1, proc_15->unit
@ SkillsDebug.c:404: {
	movs	r4, r0	@ menu, tmp151
@ SkillsDebug.c:407: 	if (proc->move_hovering != 0)
	cmp	r1, #0	@ tmp154,
	beq	.L87		@,
@ SkillsDebug.c:409: 		proc->hover_move_Updated = TRUE;
	movs	r1, #1	@ tmp130,
	str	r1, [r2, #56]	@ tmp130, proc_15->hover_move_Updated
@ SkillsDebug.c:410: 		proc->move_hovering = 0;
	movs	r1, #0	@ tmp131,
	str	r1, [r2, #60]	@ tmp131, proc_15->move_hovering
.L87:
@ SkillsDebug.c:413: 	if (gKeyState.repeatedKeys & KEY_BUTTON_R) { 
	ldr	r1, .L95	@ tmp132,
@ SkillsDebug.c:413: 	if (gKeyState.repeatedKeys & KEY_BUTTON_R) { 
	ldrh	r1, [r1, #6]	@ tmp134,
	lsls	r1, r1, #23	@ tmp153, tmp134,
	bpl	.L88		@,
@ SkillsDebug.c:414: 		MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering]));
	ldr	r2, [r2, #60]	@ proc_15->move_hovering, proc_15->move_hovering
	adds	r3, r3, r2	@ tmp141, _1, proc_15->move_hovering
	adds	r3, r3, #40	@ tmp144,
@ SkillsDebug.c:414: 		MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering]));
	ldrb	r0, [r3]	@ *_6, *_6
	ldr	r3, .L95+4	@ tmp146,
	bl	.L8		@
@ SkillsDebug.c:414: 		MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering]));
	lsls	r1, r0, #16	@ tmp147, tmp152,
	ldr	r3, .L95+8	@ tmp149,
	movs	r0, r4	@, menu
	lsrs	r1, r1, #16	@ tmp147, tmp147,
	bl	.L8		@
.L88:
@ SkillsDebug.c:417: }
	@ sp needed	@
	movs	r0, #0	@,
	pop	{r4}
	pop	{r1}
	bx	r1
.L96:
	.align	2
.L95:
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
@ SkillsDebug.c:396: 	if (gKeyState.repeatedKeys & KEY_BUTTON_R) { 
	ldr	r3, .L102	@ tmp123,
@ SkillsDebug.c:396: 	if (gKeyState.repeatedKeys & KEY_BUTTON_R) { 
	ldrh	r3, [r3, #6]	@ tmp125,
@ SkillsDebug.c:393: {
	movs	r4, r0	@ menu, tmp138
@ SkillsDebug.c:396: 	if (gKeyState.repeatedKeys & KEY_BUTTON_R) { 
	lsls	r3, r3, #23	@ tmp140, tmp125,
	bpl	.L98		@,
@ SkillsDebug.c:397: 		MenuCallHelpBox(menu, GetItemDescId(proc->skillReplacement));
	ldr	r3, [r0, #20]	@ tmp142, menu_8(D)->parent
	movs	r0, #42	@ tmp132,
	ldrsh	r0, [r3, r0]	@ tmp132, tmp142, tmp132
	ldr	r3, .L102+4	@ tmp133,
	bl	.L8		@
@ SkillsDebug.c:397: 		MenuCallHelpBox(menu, GetItemDescId(proc->skillReplacement));
	lsls	r1, r0, #16	@ tmp134, tmp139,
	ldr	r3, .L102+8	@ tmp136,
	movs	r0, r4	@, menu
	lsrs	r1, r1, #16	@ tmp134, tmp134,
	bl	.L8		@
.L98:
@ SkillsDebug.c:400: }
	@ sp needed	@
	movs	r0, #0	@,
	pop	{r4}
	pop	{r1}
	bx	r1
.L103:
	.align	2
.L102:
	.word	gKeyState
	.word	GetItemDescId
	.word	MenuCallHelpBox
	.size	List_0_Idle, .-List_0_Idle
	.section	.rodata.str1.1,"aMS",%progbits,1
.LC32:
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
@ SkillsDebug.c:1002:     struct SkillDebugProc* const proc = (void*) menu->parent;
	ldr	r3, [r0, #20]	@ proc, menu_18(D)->parent
@ SkillsDebug.c:1035: }
	@ sp needed	@
@ SkillsDebug.c:1002:     struct SkillDebugProc* const proc = (void*) menu->parent;
	str	r3, [sp, #4]	@ proc, %sfp
@ SkillsDebug.c:1004:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldrh	r0, [r1, #42]	@ tmp135,
	ldrh	r5, [r1, #44]	@ tmp133,
@ SkillsDebug.c:1006:     Text_Clear(&command->text);
	adds	r1, r1, #52	@ command,
	movs	r4, r1	@ _9, command
@ SkillsDebug.c:1004:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #5	@ tmp134, tmp133,
	adds	r5, r5, r0	@ tmp136, tmp134, tmp135
@ SkillsDebug.c:1004:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldr	r0, .L105	@ tmp138,
@ SkillsDebug.c:1004:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #1	@ tmp137, tmp136,
@ SkillsDebug.c:1004:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	adds	r5, r5, r0	@ out, tmp137, tmp138
@ SkillsDebug.c:1006:     Text_Clear(&command->text);
	ldr	r3, .L105+4	@ tmp139,
	movs	r0, r1	@, _9
	bl	.L8		@
@ SkillsDebug.c:1008: 	Text_SetXCursor(&command->text, new_item_desc_offset);
	ldr	r7, .L105+8	@ tmp140,
	movs	r1, #72	@,
	movs	r0, r4	@, _9
	bl	.L107		@
@ SkillsDebug.c:1009: 	Text_SetColorId(&command->text, TEXT_COLOR_GREEN);
	ldr	r6, .L105+12	@ tmp141,
	movs	r1, #4	@,
	movs	r0, r4	@, _9
	bl	.L108		@
@ SkillsDebug.c:1010:     Text_DrawString(&command->text, "Learn ");
	movs	r0, r4	@, _9
	ldr	r1, .L105+16	@,
	ldr	r3, .L105+20	@ tmp166,
	bl	.L8		@
@ SkillsDebug.c:1011: 	Text_Display(&command->text, out); 
	movs	r1, r5	@, out
	ldr	r3, .L105+24	@ tmp168,
	movs	r0, r4	@, _9
	bl	.L8		@
@ SkillsDebug.c:1013: 	Text_SetXCursor(&command->text, new_item_desc_offset+new_item_name_offset);
	movs	r1, #120	@,
	movs	r0, r4	@, _9
	bl	.L107		@
@ SkillsDebug.c:1014:     Text_SetColorId(&command->text, TEXT_COLOR_BLUE);
	movs	r1, #2	@,
	movs	r0, r4	@, _9
	bl	.L108		@
@ SkillsDebug.c:1015:     Text_DrawString(&command->text, GetItemName(proc->skillReplacement)); 
	ldr	r3, [sp, #4]	@ proc, %sfp
	movs	r0, #42	@ tmp147,
	ldrsh	r0, [r3, r0]	@ tmp147, proc, tmp147
	ldr	r3, .L105+28	@ tmp148,
	bl	.L8		@
@ SkillsDebug.c:1015:     Text_DrawString(&command->text, GetItemName(proc->skillReplacement)); 
	ldr	r3, .L105+20	@ tmp171,
@ SkillsDebug.c:1015:     Text_DrawString(&command->text, GetItemName(proc->skillReplacement)); 
	movs	r1, r0	@ _12, tmp159
@ SkillsDebug.c:1015:     Text_DrawString(&command->text, GetItemName(proc->skillReplacement)); 
	movs	r0, r4	@, _9
	bl	.L8		@
@ SkillsDebug.c:1016: 	Text_Display(&command->text, out); 
	movs	r1, r5	@, out
	movs	r0, r4	@, _9
	ldr	r3, .L105+24	@ tmp173,
	bl	.L8		@
@ SkillsDebug.c:1028: 	LoadIconPalettes(4); 
	movs	r0, #4	@,
	ldr	r3, .L105+32	@ tmp151,
	bl	.L8		@
@ SkillsDebug.c:1029:     DrawIcon(
	ldr	r3, [sp, #4]	@ proc, %sfp
	movs	r0, #42	@ tmp152,
	ldrsh	r0, [r3, r0]	@ tmp152, proc, tmp152
	ldr	r3, .L105+36	@ tmp153,
	bl	.L8		@
	movs	r2, #128	@ tmp161,
	movs	r1, r0	@ _16, tmp160
	movs	r0, r5	@ out, out
	ldr	r3, .L105+40	@ tmp156,
	adds	r0, r0, #26	@ out,
	lsls	r2, r2, #7	@, tmp161,
	bl	.L8		@
@ SkillsDebug.c:1035: }
	pop	{r0, r1, r2, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L106:
	.align	2
.L105:
	.word	gBg0MapBuffer
	.word	Text_Clear
	.word	Text_SetXCursor
	.word	Text_SetColorId
	.word	.LC32
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
	beq	.L110		@,
@ SkillsDebug.c:90:     if (moveId == 255)
	cmp	r0, #255	@ moveId,
	beq	.L111		@,
@ SkillsDebug.c:93:     return GetItemDescId(moveId);
	ldr	r3, .L115	@ tmp115,
	bl	.L8		@
.L110:
@ SkillsDebug.c:94: }
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L111:
@ SkillsDebug.c:88:         return FALSE;
	movs	r0, #0	@ moveId,
	b	.L110		@
.L116:
	.align	2
.L115:
	.word	GetItemDescId
	.size	IsMove, .-IsMove
	.section	.rodata.str1.1
.LC53:
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
@ SkillsDebug.c:792:     u8* const moves = UnitGetMoveList(proc->unit);
	ldr	r3, [r0, #20]	@ menu_26(D)->parent, menu_26(D)->parent
@ SkillsDebug.c:794:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldrh	r5, [r1, #44]	@ tmp141,
@ SkillsDebug.c:792:     u8* const moves = UnitGetMoveList(proc->unit);
	ldr	r6, [r3, #44]	@ _1, proc_27->unit
@ SkillsDebug.c:794:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldrh	r3, [r1, #42]	@ tmp143,
@ SkillsDebug.c:797:     Text_Clear(&command->text);
	adds	r1, r1, #52	@ command,
	movs	r4, r1	@ _10, command
@ SkillsDebug.c:794:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #5	@ tmp142, tmp141,
	adds	r5, r5, r3	@ tmp144, tmp142, tmp143
@ SkillsDebug.c:794:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldr	r3, .L121	@ tmp146,
@ SkillsDebug.c:794:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #1	@ tmp145, tmp144,
@ SkillsDebug.c:797:     Text_Clear(&command->text);
	movs	r0, r1	@, _10
@ SkillsDebug.c:794:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	adds	r5, r5, r3	@ out, tmp145, tmp146
@ SkillsDebug.c:797:     Text_Clear(&command->text);
	ldr	r3, .L121+4	@ tmp147,
	bl	.L8		@
@ SkillsDebug.c:799: 	Text_SetXCursor(&command->text, new_item_desc_offset);
	movs	r1, #72	@,
	ldr	r7, .L121+8	@ tmp148,
	movs	r0, r4	@, _10
	bl	.L107		@
@ SkillsDebug.c:801:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	adds	r6, r6, #47	@ tmp152,
@ SkillsDebug.c:800:     Text_SetColorId(&command->text, TEXT_COLOR_BLUE);
	movs	r1, #2	@,
	ldr	r3, .L121+12	@ tmp191,
	movs	r0, r4	@, _10
	bl	.L8		@
@ SkillsDebug.c:801:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	ldr	r3, .L121+16	@ tmp154,
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 47B], MEM[(u8 *)_1 + 47B]
	bl	.L8		@
	ldr	r3, .L121+20	@ tmp155,
	bl	.L8		@
@ SkillsDebug.c:801:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	ldr	r3, .L121+24	@ tmp193,
@ SkillsDebug.c:801:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	movs	r1, r0	@ _14, tmp185
@ SkillsDebug.c:801:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	movs	r0, r4	@, _10
	bl	.L8		@
@ SkillsDebug.c:802: 	Text_Display(&command->text, out); 
	ldr	r3, .L121+28	@ tmp157,
	movs	r1, r5	@, out
	movs	r0, r4	@, _10
	bl	.L8		@
@ SkillsDebug.c:803: 	Text_SetXCursor(&command->text, 0);
	movs	r1, #0	@,
	movs	r0, r4	@, _10
	bl	.L107		@
@ SkillsDebug.c:804:     LoadIconPalettes(4); /* Icon palette */
	movs	r0, #4	@,
	ldr	r3, .L121+32	@ tmp159,
	bl	.L8		@
@ SkillsDebug.c:807: 	if (IsMove(moves[i])) {
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 47B], MEM[(u8 *)_1 + 47B]
	bl	IsMove		@
@ SkillsDebug.c:807: 	if (IsMove(moves[i])) {
	cmp	r0, #0	@ tmp186,
	beq	.L118		@,
@ SkillsDebug.c:808: 		DrawIcon(out + TILEMAP_INDEX(0, 0), GetItemIconId(moves[i]), TILEREF(0, 4)); 
	ldr	r3, .L121+36	@ tmp168,
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 47B], MEM[(u8 *)_1 + 47B]
	bl	.L8		@
	movs	r2, #128	@,
	movs	r1, r0	@ _20, tmp187
	lsls	r2, r2, #7	@,,
	ldr	r3, .L121+40	@ tmp170,
	movs	r0, r5	@, out
	bl	.L8		@
@ SkillsDebug.c:809: 		Text_SetXCursor(&command->text, item_name_offset);
	movs	r1, #16	@,
	movs	r0, r4	@, _10
	bl	.L107		@
@ SkillsDebug.c:810: 		Text_SetColorId(&command->text, TEXT_COLOR_BLUE);
	movs	r1, #2	@,
	ldr	r3, .L121+12	@ tmp195,
	movs	r0, r4	@, _10
	bl	.L8		@
@ SkillsDebug.c:811: 		Text_DrawString(&command->text, GetItemName(moves[i])); 
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 47B], MEM[(u8 *)_1 + 47B]
	ldr	r3, .L121+44	@ tmp177,
	bl	.L8		@
	movs	r1, r0	@ _23, tmp188
.L120:
@ SkillsDebug.c:817: }
	@ sp needed	@
@ SkillsDebug.c:815: 		Text_DrawString(&command->text, " No Move");
	movs	r0, r4	@, _10
	ldr	r3, .L121+24	@ tmp201,
	bl	.L8		@
@ SkillsDebug.c:817: }
	pop	{r3, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L118:
@ SkillsDebug.c:814: 		Text_SetColorId(&command->text, TEXT_COLOR_GRAY);
	movs	r1, #1	@,
	movs	r0, r4	@, _10
	ldr	r3, .L121+12	@ tmp199,
	bl	.L8		@
@ SkillsDebug.c:815: 		Text_DrawString(&command->text, " No Move");
	ldr	r1, .L121+48	@,
	b	.L120		@
.L122:
	.align	2
.L121:
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
	.word	.LC53
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
@ SkillsDebug.c:761:     u8* const moves = UnitGetMoveList(proc->unit);
	ldr	r3, [r0, #20]	@ menu_26(D)->parent, menu_26(D)->parent
@ SkillsDebug.c:763:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldrh	r5, [r1, #44]	@ tmp141,
@ SkillsDebug.c:761:     u8* const moves = UnitGetMoveList(proc->unit);
	ldr	r6, [r3, #44]	@ _1, proc_27->unit
@ SkillsDebug.c:763:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldrh	r3, [r1, #42]	@ tmp143,
@ SkillsDebug.c:766:     Text_Clear(&command->text);
	adds	r1, r1, #52	@ command,
	movs	r4, r1	@ _10, command
@ SkillsDebug.c:763:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #5	@ tmp142, tmp141,
	adds	r5, r5, r3	@ tmp144, tmp142, tmp143
@ SkillsDebug.c:763:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldr	r3, .L127	@ tmp146,
@ SkillsDebug.c:763:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #1	@ tmp145, tmp144,
@ SkillsDebug.c:766:     Text_Clear(&command->text);
	movs	r0, r1	@, _10
@ SkillsDebug.c:763:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	adds	r5, r5, r3	@ out, tmp145, tmp146
@ SkillsDebug.c:766:     Text_Clear(&command->text);
	ldr	r3, .L127+4	@ tmp147,
	bl	.L8		@
@ SkillsDebug.c:767: 	Text_SetXCursor(&command->text, new_item_desc_offset);
	movs	r1, #72	@,
	ldr	r7, .L127+8	@ tmp148,
	movs	r0, r4	@, _10
	bl	.L107		@
@ SkillsDebug.c:769:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	adds	r6, r6, #46	@ tmp152,
@ SkillsDebug.c:768:     Text_SetColorId(&command->text, TEXT_COLOR_BLUE);
	movs	r1, #2	@,
	ldr	r3, .L127+12	@ tmp191,
	movs	r0, r4	@, _10
	bl	.L8		@
@ SkillsDebug.c:769:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	ldr	r3, .L127+16	@ tmp154,
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 46B], MEM[(u8 *)_1 + 46B]
	bl	.L8		@
	ldr	r3, .L127+20	@ tmp155,
	bl	.L8		@
@ SkillsDebug.c:769:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	ldr	r3, .L127+24	@ tmp193,
@ SkillsDebug.c:769:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	movs	r1, r0	@ _14, tmp185
@ SkillsDebug.c:769:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	movs	r0, r4	@, _10
	bl	.L8		@
@ SkillsDebug.c:770: 	Text_Display(&command->text, out); 
	ldr	r3, .L127+28	@ tmp157,
	movs	r1, r5	@, out
	movs	r0, r4	@, _10
	bl	.L8		@
@ SkillsDebug.c:771: 	Text_SetXCursor(&command->text, 0);
	movs	r1, #0	@,
	movs	r0, r4	@, _10
	bl	.L107		@
@ SkillsDebug.c:773:     LoadIconPalettes(4); /* Icon palette */
	movs	r0, #4	@,
	ldr	r3, .L127+32	@ tmp159,
	bl	.L8		@
@ SkillsDebug.c:776: 	if (IsMove(moves[i])) {
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 46B], MEM[(u8 *)_1 + 46B]
	bl	IsMove		@
@ SkillsDebug.c:776: 	if (IsMove(moves[i])) {
	cmp	r0, #0	@ tmp186,
	beq	.L124		@,
@ SkillsDebug.c:777: 		DrawIcon(out + TILEMAP_INDEX(0, 0), GetItemIconId(moves[i]), TILEREF(0, 4)); 
	ldr	r3, .L127+36	@ tmp168,
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 46B], MEM[(u8 *)_1 + 46B]
	bl	.L8		@
	movs	r2, #128	@,
	movs	r1, r0	@ _20, tmp187
	lsls	r2, r2, #7	@,,
	ldr	r3, .L127+40	@ tmp170,
	movs	r0, r5	@, out
	bl	.L8		@
@ SkillsDebug.c:778: 		Text_SetXCursor(&command->text, item_name_offset);
	movs	r1, #16	@,
	movs	r0, r4	@, _10
	bl	.L107		@
@ SkillsDebug.c:779: 		Text_SetColorId(&command->text, TEXT_COLOR_BLUE);
	movs	r1, #2	@,
	ldr	r3, .L127+12	@ tmp195,
	movs	r0, r4	@, _10
	bl	.L8		@
@ SkillsDebug.c:780: 		Text_DrawString(&command->text, GetItemName(moves[i])); 
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 46B], MEM[(u8 *)_1 + 46B]
	ldr	r3, .L127+44	@ tmp177,
	bl	.L8		@
	movs	r1, r0	@ _23, tmp188
.L126:
@ SkillsDebug.c:786: }
	@ sp needed	@
@ SkillsDebug.c:784: 		Text_DrawString(&command->text, " No Move");
	movs	r0, r4	@, _10
	ldr	r3, .L127+24	@ tmp201,
	bl	.L8		@
@ SkillsDebug.c:786: }
	pop	{r3, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L124:
@ SkillsDebug.c:783: 		Text_SetColorId(&command->text, TEXT_COLOR_GRAY);
	movs	r1, #1	@,
	movs	r0, r4	@, _10
	ldr	r3, .L127+12	@ tmp199,
	bl	.L8		@
@ SkillsDebug.c:784: 		Text_DrawString(&command->text, " No Move");
	ldr	r1, .L127+48	@,
	b	.L126		@
.L128:
	.align	2
.L127:
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
	.word	.LC53
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
@ SkillsDebug.c:730:     u8* const moves = UnitGetMoveList(proc->unit);
	ldr	r3, [r0, #20]	@ menu_26(D)->parent, menu_26(D)->parent
@ SkillsDebug.c:732:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldrh	r5, [r1, #44]	@ tmp141,
@ SkillsDebug.c:730:     u8* const moves = UnitGetMoveList(proc->unit);
	ldr	r6, [r3, #44]	@ _1, proc_27->unit
@ SkillsDebug.c:732:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldrh	r3, [r1, #42]	@ tmp143,
@ SkillsDebug.c:735:     Text_Clear(&command->text);
	adds	r1, r1, #52	@ command,
	movs	r4, r1	@ _10, command
@ SkillsDebug.c:732:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #5	@ tmp142, tmp141,
	adds	r5, r5, r3	@ tmp144, tmp142, tmp143
@ SkillsDebug.c:732:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldr	r3, .L133	@ tmp146,
@ SkillsDebug.c:732:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #1	@ tmp145, tmp144,
@ SkillsDebug.c:735:     Text_Clear(&command->text);
	movs	r0, r1	@, _10
@ SkillsDebug.c:732:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	adds	r5, r5, r3	@ out, tmp145, tmp146
@ SkillsDebug.c:735:     Text_Clear(&command->text);
	ldr	r3, .L133+4	@ tmp147,
	bl	.L8		@
@ SkillsDebug.c:736: 	Text_SetXCursor(&command->text, new_item_desc_offset);
	movs	r1, #72	@,
	ldr	r7, .L133+8	@ tmp148,
	movs	r0, r4	@, _10
	bl	.L107		@
@ SkillsDebug.c:738:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	adds	r6, r6, #45	@ tmp152,
@ SkillsDebug.c:737:     Text_SetColorId(&command->text, TEXT_COLOR_BLUE);
	movs	r1, #2	@,
	ldr	r3, .L133+12	@ tmp191,
	movs	r0, r4	@, _10
	bl	.L8		@
@ SkillsDebug.c:738:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	ldr	r3, .L133+16	@ tmp154,
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 45B], MEM[(u8 *)_1 + 45B]
	bl	.L8		@
	ldr	r3, .L133+20	@ tmp155,
	bl	.L8		@
@ SkillsDebug.c:738:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	ldr	r3, .L133+24	@ tmp193,
@ SkillsDebug.c:738:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	movs	r1, r0	@ _14, tmp185
@ SkillsDebug.c:738:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	movs	r0, r4	@, _10
	bl	.L8		@
@ SkillsDebug.c:739: 	Text_Display(&command->text, out); 
	ldr	r3, .L133+28	@ tmp157,
	movs	r1, r5	@, out
	movs	r0, r4	@, _10
	bl	.L8		@
@ SkillsDebug.c:740: 	Text_SetXCursor(&command->text, 0);
	movs	r1, #0	@,
	movs	r0, r4	@, _10
	bl	.L107		@
@ SkillsDebug.c:742:     LoadIconPalettes(4); /* Icon palette */
	movs	r0, #4	@,
	ldr	r3, .L133+32	@ tmp159,
	bl	.L8		@
@ SkillsDebug.c:745: 	if (IsMove(moves[i])) {
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 45B], MEM[(u8 *)_1 + 45B]
	bl	IsMove		@
@ SkillsDebug.c:745: 	if (IsMove(moves[i])) {
	cmp	r0, #0	@ tmp186,
	beq	.L130		@,
@ SkillsDebug.c:746: 		DrawIcon(out + TILEMAP_INDEX(0, 0), GetItemIconId(moves[i]), TILEREF(0, 4)); 
	ldr	r3, .L133+36	@ tmp168,
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 45B], MEM[(u8 *)_1 + 45B]
	bl	.L8		@
	movs	r2, #128	@,
	movs	r1, r0	@ _20, tmp187
	lsls	r2, r2, #7	@,,
	ldr	r3, .L133+40	@ tmp170,
	movs	r0, r5	@, out
	bl	.L8		@
@ SkillsDebug.c:747: 		Text_SetXCursor(&command->text, item_name_offset);
	movs	r1, #16	@,
	movs	r0, r4	@, _10
	bl	.L107		@
@ SkillsDebug.c:748: 		Text_SetColorId(&command->text, TEXT_COLOR_BLUE);
	movs	r1, #2	@,
	ldr	r3, .L133+12	@ tmp195,
	movs	r0, r4	@, _10
	bl	.L8		@
@ SkillsDebug.c:749: 		Text_DrawString(&command->text, GetItemName(moves[i])); 
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 45B], MEM[(u8 *)_1 + 45B]
	ldr	r3, .L133+44	@ tmp177,
	bl	.L8		@
	movs	r1, r0	@ _23, tmp188
.L132:
@ SkillsDebug.c:755: }
	@ sp needed	@
@ SkillsDebug.c:753: 		Text_DrawString(&command->text, " No Move");
	movs	r0, r4	@, _10
	ldr	r3, .L133+24	@ tmp201,
	bl	.L8		@
@ SkillsDebug.c:755: }
	pop	{r3, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L130:
@ SkillsDebug.c:752: 		Text_SetColorId(&command->text, TEXT_COLOR_GRAY);
	movs	r1, #1	@,
	movs	r0, r4	@, _10
	ldr	r3, .L133+12	@ tmp199,
	bl	.L8		@
@ SkillsDebug.c:753: 		Text_DrawString(&command->text, " No Move");
	ldr	r1, .L133+48	@,
	b	.L132		@
.L134:
	.align	2
.L133:
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
	.word	.LC53
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
@ SkillsDebug.c:698:     u8* const moves = UnitGetMoveList(proc->unit);
	ldr	r3, [r0, #20]	@ menu_26(D)->parent, menu_26(D)->parent
@ SkillsDebug.c:700:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldrh	r5, [r1, #44]	@ tmp141,
@ SkillsDebug.c:698:     u8* const moves = UnitGetMoveList(proc->unit);
	ldr	r6, [r3, #44]	@ _1, proc_27->unit
@ SkillsDebug.c:700:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldrh	r3, [r1, #42]	@ tmp143,
@ SkillsDebug.c:703:     Text_Clear(&command->text);
	adds	r1, r1, #52	@ command,
	movs	r4, r1	@ _10, command
@ SkillsDebug.c:700:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #5	@ tmp142, tmp141,
	adds	r5, r5, r3	@ tmp144, tmp142, tmp143
@ SkillsDebug.c:700:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldr	r3, .L139	@ tmp146,
@ SkillsDebug.c:700:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #1	@ tmp145, tmp144,
@ SkillsDebug.c:703:     Text_Clear(&command->text);
	movs	r0, r1	@, _10
@ SkillsDebug.c:700:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	adds	r5, r5, r3	@ out, tmp145, tmp146
@ SkillsDebug.c:703:     Text_Clear(&command->text);
	ldr	r3, .L139+4	@ tmp147,
	bl	.L8		@
@ SkillsDebug.c:704: 	Text_SetXCursor(&command->text, new_item_desc_offset);
	movs	r1, #72	@,
	ldr	r7, .L139+8	@ tmp148,
	movs	r0, r4	@, _10
	bl	.L107		@
@ SkillsDebug.c:706:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	adds	r6, r6, #44	@ tmp152,
@ SkillsDebug.c:705:     Text_SetColorId(&command->text, TEXT_COLOR_BLUE);
	movs	r1, #2	@,
	ldr	r3, .L139+12	@ tmp191,
	movs	r0, r4	@, _10
	bl	.L8		@
@ SkillsDebug.c:706:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	ldr	r3, .L139+16	@ tmp154,
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 44B], MEM[(u8 *)_1 + 44B]
	bl	.L8		@
	ldr	r3, .L139+20	@ tmp155,
	bl	.L8		@
@ SkillsDebug.c:706:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	ldr	r3, .L139+24	@ tmp193,
@ SkillsDebug.c:706:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	movs	r1, r0	@ _14, tmp185
@ SkillsDebug.c:706:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	movs	r0, r4	@, _10
	bl	.L8		@
@ SkillsDebug.c:707: 	Text_Display(&command->text, out); 
	ldr	r3, .L139+28	@ tmp157,
	movs	r1, r5	@, out
	movs	r0, r4	@, _10
	bl	.L8		@
@ SkillsDebug.c:708: 	Text_SetXCursor(&command->text, 0);
	movs	r1, #0	@,
	movs	r0, r4	@, _10
	bl	.L107		@
@ SkillsDebug.c:710:     LoadIconPalettes(4); /* Icon palette */
	movs	r0, #4	@,
	ldr	r3, .L139+32	@ tmp159,
	bl	.L8		@
@ SkillsDebug.c:713: 	if (IsMove(moves[i])) {
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 44B], MEM[(u8 *)_1 + 44B]
	bl	IsMove		@
@ SkillsDebug.c:713: 	if (IsMove(moves[i])) {
	cmp	r0, #0	@ tmp186,
	beq	.L136		@,
@ SkillsDebug.c:714: 		DrawIcon(out + TILEMAP_INDEX(0, 0), GetItemIconId(moves[i]), TILEREF(0, 4)); 
	ldr	r3, .L139+36	@ tmp168,
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 44B], MEM[(u8 *)_1 + 44B]
	bl	.L8		@
	movs	r2, #128	@,
	movs	r1, r0	@ _20, tmp187
	lsls	r2, r2, #7	@,,
	ldr	r3, .L139+40	@ tmp170,
	movs	r0, r5	@, out
	bl	.L8		@
@ SkillsDebug.c:715: 		Text_SetXCursor(&command->text, item_name_offset);
	movs	r1, #16	@,
	movs	r0, r4	@, _10
	bl	.L107		@
@ SkillsDebug.c:716: 		Text_SetColorId(&command->text, TEXT_COLOR_BLUE);
	movs	r1, #2	@,
	ldr	r3, .L139+12	@ tmp195,
	movs	r0, r4	@, _10
	bl	.L8		@
@ SkillsDebug.c:717: 		Text_DrawString(&command->text, GetItemName(moves[i])); 
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 44B], MEM[(u8 *)_1 + 44B]
	ldr	r3, .L139+44	@ tmp177,
	bl	.L8		@
	movs	r1, r0	@ _23, tmp188
.L138:
@ SkillsDebug.c:724: }
	@ sp needed	@
@ SkillsDebug.c:721: 		Text_DrawString(&command->text, " No Move");
	movs	r0, r4	@, _10
	ldr	r3, .L139+24	@ tmp201,
	bl	.L8		@
@ SkillsDebug.c:724: }
	pop	{r3, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L136:
@ SkillsDebug.c:720: 		Text_SetColorId(&command->text, TEXT_COLOR_GRAY);
	movs	r1, #1	@,
	movs	r0, r4	@, _10
	ldr	r3, .L139+12	@ tmp199,
	bl	.L8		@
@ SkillsDebug.c:721: 		Text_DrawString(&command->text, " No Move");
	ldr	r1, .L139+48	@,
	b	.L138		@
.L140:
	.align	2
.L139:
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
	.word	.LC53
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
@ SkillsDebug.c:661:     u8* const moves = UnitGetMoveList(proc->unit);
	ldr	r3, [r0, #20]	@ menu_26(D)->parent, menu_26(D)->parent
@ SkillsDebug.c:663:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldrh	r5, [r1, #44]	@ tmp141,
@ SkillsDebug.c:661:     u8* const moves = UnitGetMoveList(proc->unit);
	ldr	r6, [r3, #44]	@ _1, proc_27->unit
@ SkillsDebug.c:663:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldrh	r3, [r1, #42]	@ tmp143,
@ SkillsDebug.c:666:     Text_Clear(&command->text);
	adds	r1, r1, #52	@ command,
	movs	r4, r1	@ _10, command
@ SkillsDebug.c:663:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #5	@ tmp142, tmp141,
	adds	r5, r5, r3	@ tmp144, tmp142, tmp143
@ SkillsDebug.c:663:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldr	r3, .L145	@ tmp146,
@ SkillsDebug.c:663:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #1	@ tmp145, tmp144,
@ SkillsDebug.c:666:     Text_Clear(&command->text);
	movs	r0, r1	@, _10
@ SkillsDebug.c:663:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	adds	r5, r5, r3	@ out, tmp145, tmp146
@ SkillsDebug.c:666:     Text_Clear(&command->text);
	ldr	r3, .L145+4	@ tmp147,
	bl	.L8		@
@ SkillsDebug.c:667: 	Text_SetXCursor(&command->text, new_item_desc_offset);
	movs	r1, #72	@,
	ldr	r7, .L145+8	@ tmp148,
	movs	r0, r4	@, _10
	bl	.L107		@
@ SkillsDebug.c:669:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	adds	r6, r6, #43	@ tmp152,
@ SkillsDebug.c:668:     Text_SetColorId(&command->text, TEXT_COLOR_BLUE);
	movs	r1, #2	@,
	ldr	r3, .L145+12	@ tmp191,
	movs	r0, r4	@, _10
	bl	.L8		@
@ SkillsDebug.c:669:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	ldr	r3, .L145+16	@ tmp154,
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 43B], MEM[(u8 *)_1 + 43B]
	bl	.L8		@
	ldr	r3, .L145+20	@ tmp155,
	bl	.L8		@
@ SkillsDebug.c:669:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	ldr	r3, .L145+24	@ tmp193,
@ SkillsDebug.c:669:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	movs	r1, r0	@ _14, tmp185
@ SkillsDebug.c:669:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	movs	r0, r4	@, _10
	bl	.L8		@
@ SkillsDebug.c:670: 	Text_Display(&command->text, out); 
	ldr	r3, .L145+28	@ tmp157,
	movs	r1, r5	@, out
	movs	r0, r4	@, _10
	bl	.L8		@
@ SkillsDebug.c:671: 	Text_SetXCursor(&command->text, 0);
	movs	r1, #0	@,
	movs	r0, r4	@, _10
	bl	.L107		@
@ SkillsDebug.c:673:     LoadIconPalettes(4); /* Icon palette */
	movs	r0, #4	@,
	ldr	r3, .L145+32	@ tmp159,
	bl	.L8		@
@ SkillsDebug.c:676: 	if (IsMove(moves[i])) {
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 43B], MEM[(u8 *)_1 + 43B]
	bl	IsMove		@
@ SkillsDebug.c:676: 	if (IsMove(moves[i])) {
	cmp	r0, #0	@ tmp186,
	beq	.L142		@,
@ SkillsDebug.c:677: 		DrawIcon(out + TILEMAP_INDEX(0, 0), GetItemIconId(moves[i]), TILEREF(0, 4)); 
	ldr	r3, .L145+36	@ tmp168,
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 43B], MEM[(u8 *)_1 + 43B]
	bl	.L8		@
	movs	r2, #128	@,
	movs	r1, r0	@ _20, tmp187
	lsls	r2, r2, #7	@,,
	ldr	r3, .L145+40	@ tmp170,
	movs	r0, r5	@, out
	bl	.L8		@
@ SkillsDebug.c:678: 		Text_SetXCursor(&command->text, item_name_offset);
	movs	r1, #16	@,
	movs	r0, r4	@, _10
	bl	.L107		@
@ SkillsDebug.c:679: 		Text_SetColorId(&command->text, TEXT_COLOR_BLUE);
	movs	r1, #2	@,
	ldr	r3, .L145+12	@ tmp195,
	movs	r0, r4	@, _10
	bl	.L8		@
@ SkillsDebug.c:680: 		Text_DrawString(&command->text, GetItemName(moves[i])); 
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 43B], MEM[(u8 *)_1 + 43B]
	ldr	r3, .L145+44	@ tmp177,
	bl	.L8		@
	movs	r1, r0	@ _23, tmp188
.L144:
@ SkillsDebug.c:687: }
	@ sp needed	@
@ SkillsDebug.c:684: 		Text_DrawString(&command->text, " No Move");
	movs	r0, r4	@, _10
	ldr	r3, .L145+24	@ tmp201,
	bl	.L8		@
@ SkillsDebug.c:687: }
	pop	{r3, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L142:
@ SkillsDebug.c:683: 		Text_SetColorId(&command->text, TEXT_COLOR_GRAY);
	movs	r1, #1	@,
	movs	r0, r4	@, _10
	ldr	r3, .L145+12	@ tmp199,
	bl	.L8		@
@ SkillsDebug.c:684: 		Text_DrawString(&command->text, " No Move");
	ldr	r1, .L145+48	@,
	b	.L144		@
.L146:
	.align	2
.L145:
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
	.word	.LC53
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
@ SkillsDebug.c:630:     u8* const moves = UnitGetMoveList(proc->unit);
	ldr	r3, [r0, #20]	@ menu_26(D)->parent, menu_26(D)->parent
@ SkillsDebug.c:632:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldrh	r5, [r1, #44]	@ tmp141,
@ SkillsDebug.c:630:     u8* const moves = UnitGetMoveList(proc->unit);
	ldr	r6, [r3, #44]	@ _1, proc_27->unit
@ SkillsDebug.c:632:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldrh	r3, [r1, #42]	@ tmp143,
@ SkillsDebug.c:634:     Text_Clear(&command->text);
	adds	r1, r1, #52	@ command,
	movs	r4, r1	@ _10, command
@ SkillsDebug.c:632:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #5	@ tmp142, tmp141,
	adds	r5, r5, r3	@ tmp144, tmp142, tmp143
@ SkillsDebug.c:632:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldr	r3, .L151	@ tmp146,
@ SkillsDebug.c:632:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #1	@ tmp145, tmp144,
@ SkillsDebug.c:634:     Text_Clear(&command->text);
	movs	r0, r1	@, _10
@ SkillsDebug.c:632:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	adds	r5, r5, r3	@ out, tmp145, tmp146
@ SkillsDebug.c:634:     Text_Clear(&command->text);
	ldr	r3, .L151+4	@ tmp147,
	bl	.L8		@
@ SkillsDebug.c:635: 	Text_SetXCursor(&command->text, new_item_desc_offset);
	movs	r1, #72	@,
	ldr	r7, .L151+8	@ tmp148,
	movs	r0, r4	@, _10
	bl	.L107		@
@ SkillsDebug.c:637:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	adds	r6, r6, #42	@ tmp152,
@ SkillsDebug.c:636:     Text_SetColorId(&command->text, TEXT_COLOR_BLUE);
	movs	r1, #2	@,
	ldr	r3, .L151+12	@ tmp191,
	movs	r0, r4	@, _10
	bl	.L8		@
@ SkillsDebug.c:637:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	ldr	r3, .L151+16	@ tmp154,
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 42B], MEM[(u8 *)_1 + 42B]
	bl	.L8		@
	ldr	r3, .L151+20	@ tmp155,
	bl	.L8		@
@ SkillsDebug.c:637:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	ldr	r3, .L151+24	@ tmp193,
@ SkillsDebug.c:637:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	movs	r1, r0	@ _14, tmp185
@ SkillsDebug.c:637:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	movs	r0, r4	@, _10
	bl	.L8		@
@ SkillsDebug.c:638: 	Text_Display(&command->text, out); 
	ldr	r3, .L151+28	@ tmp157,
	movs	r1, r5	@, out
	movs	r0, r4	@, _10
	bl	.L8		@
@ SkillsDebug.c:639: 	Text_SetXCursor(&command->text, 0);
	movs	r1, #0	@,
	movs	r0, r4	@, _10
	bl	.L107		@
@ SkillsDebug.c:641:     LoadIconPalettes(4); /* Icon palette */
	movs	r0, #4	@,
	ldr	r3, .L151+32	@ tmp159,
	bl	.L8		@
@ SkillsDebug.c:644: 	if (IsMove(moves[i])) {
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 42B], MEM[(u8 *)_1 + 42B]
	bl	IsMove		@
@ SkillsDebug.c:644: 	if (IsMove(moves[i])) {
	cmp	r0, #0	@ tmp186,
	beq	.L148		@,
@ SkillsDebug.c:645: 		DrawIcon(out + TILEMAP_INDEX(0, 0), GetItemIconId(moves[i]), TILEREF(0, 4)); 
	ldr	r3, .L151+36	@ tmp168,
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 42B], MEM[(u8 *)_1 + 42B]
	bl	.L8		@
	movs	r2, #128	@,
	movs	r1, r0	@ _20, tmp187
	lsls	r2, r2, #7	@,,
	ldr	r3, .L151+40	@ tmp170,
	movs	r0, r5	@, out
	bl	.L8		@
@ SkillsDebug.c:646: 		Text_SetXCursor(&command->text, item_name_offset);
	movs	r1, #16	@,
	movs	r0, r4	@, _10
	bl	.L107		@
@ SkillsDebug.c:647: 		Text_SetColorId(&command->text, TEXT_COLOR_BLUE);
	movs	r1, #2	@,
	ldr	r3, .L151+12	@ tmp195,
	movs	r0, r4	@, _10
	bl	.L8		@
@ SkillsDebug.c:648: 		Text_DrawString(&command->text, GetItemName(moves[i])); 
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 42B], MEM[(u8 *)_1 + 42B]
	ldr	r3, .L151+44	@ tmp177,
	bl	.L8		@
	movs	r1, r0	@ _23, tmp188
.L150:
@ SkillsDebug.c:655: }
	@ sp needed	@
@ SkillsDebug.c:652: 		Text_DrawString(&command->text, " No Move");
	movs	r0, r4	@, _10
	ldr	r3, .L151+24	@ tmp201,
	bl	.L8		@
@ SkillsDebug.c:655: }
	pop	{r3, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L148:
@ SkillsDebug.c:651: 		Text_SetColorId(&command->text, TEXT_COLOR_GRAY);
	movs	r1, #1	@,
	movs	r0, r4	@, _10
	ldr	r3, .L151+12	@ tmp199,
	bl	.L8		@
@ SkillsDebug.c:652: 		Text_DrawString(&command->text, " No Move");
	ldr	r1, .L151+48	@,
	b	.L150		@
.L152:
	.align	2
.L151:
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
	.word	.LC53
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
@ SkillsDebug.c:599:     u8* const moves = UnitGetMoveList(proc->unit);
	ldr	r3, [r0, #20]	@ menu_26(D)->parent, menu_26(D)->parent
@ SkillsDebug.c:601:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldrh	r5, [r1, #44]	@ tmp141,
@ SkillsDebug.c:599:     u8* const moves = UnitGetMoveList(proc->unit);
	ldr	r6, [r3, #44]	@ _1, proc_27->unit
@ SkillsDebug.c:601:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldrh	r3, [r1, #42]	@ tmp143,
@ SkillsDebug.c:603:     Text_Clear(&command->text);
	adds	r1, r1, #52	@ command,
	movs	r4, r1	@ _10, command
@ SkillsDebug.c:601:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #5	@ tmp142, tmp141,
	adds	r5, r5, r3	@ tmp144, tmp142, tmp143
@ SkillsDebug.c:601:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldr	r3, .L157	@ tmp146,
@ SkillsDebug.c:601:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #1	@ tmp145, tmp144,
@ SkillsDebug.c:603:     Text_Clear(&command->text);
	movs	r0, r1	@, _10
@ SkillsDebug.c:601:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	adds	r5, r5, r3	@ out, tmp145, tmp146
@ SkillsDebug.c:603:     Text_Clear(&command->text);
	ldr	r3, .L157+4	@ tmp147,
	bl	.L8		@
@ SkillsDebug.c:604: 	Text_SetXCursor(&command->text, new_item_desc_offset);
	movs	r1, #72	@,
	ldr	r7, .L157+8	@ tmp148,
	movs	r0, r4	@, _10
	bl	.L107		@
@ SkillsDebug.c:606:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	adds	r6, r6, #41	@ tmp152,
@ SkillsDebug.c:605:     Text_SetColorId(&command->text, TEXT_COLOR_BLUE);
	movs	r1, #2	@,
	ldr	r3, .L157+12	@ tmp191,
	movs	r0, r4	@, _10
	bl	.L8		@
@ SkillsDebug.c:606:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	ldr	r3, .L157+16	@ tmp154,
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 41B], MEM[(u8 *)_1 + 41B]
	bl	.L8		@
	ldr	r3, .L157+20	@ tmp155,
	bl	.L8		@
@ SkillsDebug.c:606:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	ldr	r3, .L157+24	@ tmp193,
@ SkillsDebug.c:606:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	movs	r1, r0	@ _14, tmp185
@ SkillsDebug.c:606:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	movs	r0, r4	@, _10
	bl	.L8		@
@ SkillsDebug.c:607: 	Text_Display(&command->text, out); 
	ldr	r3, .L157+28	@ tmp157,
	movs	r1, r5	@, out
	movs	r0, r4	@, _10
	bl	.L8		@
@ SkillsDebug.c:608: 	Text_SetXCursor(&command->text, 0);
	movs	r1, #0	@,
	movs	r0, r4	@, _10
	bl	.L107		@
@ SkillsDebug.c:610:     LoadIconPalettes(4); /* Icon palette */
	movs	r0, #4	@,
	ldr	r3, .L157+32	@ tmp159,
	bl	.L8		@
@ SkillsDebug.c:613: 	if (IsMove(moves[i])) {
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 41B], MEM[(u8 *)_1 + 41B]
	bl	IsMove		@
@ SkillsDebug.c:613: 	if (IsMove(moves[i])) {
	cmp	r0, #0	@ tmp186,
	beq	.L154		@,
@ SkillsDebug.c:614: 		DrawIcon(out + TILEMAP_INDEX(0, 0), GetItemIconId(moves[i]), TILEREF(0, 4)); 
	ldr	r3, .L157+36	@ tmp168,
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 41B], MEM[(u8 *)_1 + 41B]
	bl	.L8		@
	movs	r2, #128	@,
	movs	r1, r0	@ _20, tmp187
	lsls	r2, r2, #7	@,,
	ldr	r3, .L157+40	@ tmp170,
	movs	r0, r5	@, out
	bl	.L8		@
@ SkillsDebug.c:615: 		Text_SetXCursor(&command->text, item_name_offset);
	movs	r1, #16	@,
	movs	r0, r4	@, _10
	bl	.L107		@
@ SkillsDebug.c:616: 		Text_SetColorId(&command->text, TEXT_COLOR_BLUE);
	movs	r1, #2	@,
	ldr	r3, .L157+12	@ tmp195,
	movs	r0, r4	@, _10
	bl	.L8		@
@ SkillsDebug.c:617: 		Text_DrawString(&command->text, GetItemName(moves[i])); 
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 41B], MEM[(u8 *)_1 + 41B]
	ldr	r3, .L157+44	@ tmp177,
	bl	.L8		@
	movs	r1, r0	@ _23, tmp188
.L156:
@ SkillsDebug.c:624: }
	@ sp needed	@
@ SkillsDebug.c:621: 		Text_DrawString(&command->text, " No Move");
	movs	r0, r4	@, _10
	ldr	r3, .L157+24	@ tmp201,
	bl	.L8		@
@ SkillsDebug.c:624: }
	pop	{r3, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L154:
@ SkillsDebug.c:620: 		Text_SetColorId(&command->text, TEXT_COLOR_GRAY);
	movs	r1, #1	@,
	movs	r0, r4	@, _10
	ldr	r3, .L157+12	@ tmp199,
	bl	.L8		@
@ SkillsDebug.c:621: 		Text_DrawString(&command->text, " No Move");
	ldr	r1, .L157+48	@,
	b	.L156		@
.L158:
	.align	2
.L157:
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
	.word	.LC53
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
@ SkillsDebug.c:569:     u8* const moves = UnitGetMoveList(proc->unit);
	ldr	r3, [r0, #20]	@ menu_26(D)->parent, menu_26(D)->parent
@ SkillsDebug.c:571:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldrh	r5, [r1, #44]	@ tmp141,
@ SkillsDebug.c:569:     u8* const moves = UnitGetMoveList(proc->unit);
	ldr	r6, [r3, #44]	@ _1, proc_27->unit
@ SkillsDebug.c:571:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldrh	r3, [r1, #42]	@ tmp143,
@ SkillsDebug.c:573:     Text_Clear(&command->text);
	adds	r1, r1, #52	@ command,
	movs	r4, r1	@ _10, command
@ SkillsDebug.c:571:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #5	@ tmp142, tmp141,
	adds	r5, r5, r3	@ tmp144, tmp142, tmp143
@ SkillsDebug.c:571:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldr	r3, .L163	@ tmp146,
@ SkillsDebug.c:571:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r5, r5, #1	@ tmp145, tmp144,
@ SkillsDebug.c:573:     Text_Clear(&command->text);
	movs	r0, r1	@, _10
@ SkillsDebug.c:571:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	adds	r5, r5, r3	@ out, tmp145, tmp146
@ SkillsDebug.c:573:     Text_Clear(&command->text);
	ldr	r3, .L163+4	@ tmp147,
	bl	.L8		@
@ SkillsDebug.c:574: 	Text_SetXCursor(&command->text, new_item_desc_offset);
	movs	r1, #72	@,
	ldr	r7, .L163+8	@ tmp148,
	movs	r0, r4	@, _10
	bl	.L107		@
@ SkillsDebug.c:576:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	adds	r6, r6, #40	@ tmp152,
@ SkillsDebug.c:575:     Text_SetColorId(&command->text, TEXT_COLOR_BLUE);
	movs	r1, #2	@,
	ldr	r3, .L163+12	@ tmp191,
	movs	r0, r4	@, _10
	bl	.L8		@
@ SkillsDebug.c:576:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	ldr	r3, .L163+16	@ tmp154,
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 40B], MEM[(u8 *)_1 + 40B]
	bl	.L8		@
	ldr	r3, .L163+20	@ tmp155,
	bl	.L8		@
@ SkillsDebug.c:576:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	ldr	r3, .L163+24	@ tmp193,
@ SkillsDebug.c:576:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	movs	r1, r0	@ _14, tmp185
@ SkillsDebug.c:576:     Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	movs	r0, r4	@, _10
	bl	.L8		@
@ SkillsDebug.c:577: 	Text_Display(&command->text, out); 
	ldr	r3, .L163+28	@ tmp157,
	movs	r1, r5	@, out
	movs	r0, r4	@, _10
	bl	.L8		@
@ SkillsDebug.c:578: 	Text_SetXCursor(&command->text, 0);
	movs	r1, #0	@,
	movs	r0, r4	@, _10
	bl	.L107		@
@ SkillsDebug.c:580:     LoadIconPalettes(4); /* Icon palette */
	movs	r0, #4	@,
	ldr	r3, .L163+32	@ tmp159,
	bl	.L8		@
@ SkillsDebug.c:582: 	if (IsMove(moves[i])) {
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 40B], MEM[(u8 *)_1 + 40B]
	bl	IsMove		@
@ SkillsDebug.c:582: 	if (IsMove(moves[i])) {
	cmp	r0, #0	@ tmp186,
	beq	.L160		@,
@ SkillsDebug.c:583: 		DrawIcon(out + TILEMAP_INDEX(0, 0), GetItemIconId(moves[i]), TILEREF(0, 4)); 
	ldr	r3, .L163+36	@ tmp168,
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 40B], MEM[(u8 *)_1 + 40B]
	bl	.L8		@
	movs	r2, #128	@,
	movs	r1, r0	@ _20, tmp187
	lsls	r2, r2, #7	@,,
	ldr	r3, .L163+40	@ tmp170,
	movs	r0, r5	@, out
	bl	.L8		@
@ SkillsDebug.c:584: 		Text_SetXCursor(&command->text, item_name_offset);
	movs	r1, #16	@,
	movs	r0, r4	@, _10
	bl	.L107		@
@ SkillsDebug.c:585: 		Text_SetColorId(&command->text, TEXT_COLOR_BLUE);
	movs	r1, #2	@,
	ldr	r3, .L163+12	@ tmp195,
	movs	r0, r4	@, _10
	bl	.L8		@
@ SkillsDebug.c:586: 		Text_DrawString(&command->text, GetItemName(moves[i])); 
	ldrb	r0, [r6]	@ MEM[(u8 *)_1 + 40B], MEM[(u8 *)_1 + 40B]
	ldr	r3, .L163+44	@ tmp177,
	bl	.L8		@
	movs	r1, r0	@ _23, tmp188
.L162:
@ SkillsDebug.c:593: }
	@ sp needed	@
@ SkillsDebug.c:590: 		Text_DrawString(&command->text, " No Move");
	movs	r0, r4	@, _10
	ldr	r3, .L163+24	@ tmp201,
	bl	.L8		@
@ SkillsDebug.c:593: }
	pop	{r3, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L160:
@ SkillsDebug.c:589: 		Text_SetColorId(&command->text, TEXT_COLOR_GRAY);
	movs	r1, #1	@,
	movs	r0, r4	@, _10
	ldr	r3, .L163+12	@ tmp199,
	bl	.L8		@
@ SkillsDebug.c:590: 		Text_DrawString(&command->text, " No Move");
	ldr	r1, .L163+48	@,
	b	.L162		@
.L164:
	.align	2
.L163:
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
	.word	.LC53
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
@ SkillsDebug.c:361:     struct SkillDebugProc* proc = (void*) ProcStart(Proc_SkillDebug, ROOT_PROC_3);
	ldr	r4, .L166	@ tmp122,
@ SkillsDebug.c:390: }
	@ sp needed	@
@ SkillsDebug.c:361:     struct SkillDebugProc* proc = (void*) ProcStart(Proc_SkillDebug, ROOT_PROC_3);
	movs	r1, #3	@,
	movs	r0, r4	@, tmp122
	ldr	r3, .L166+4	@ tmp123,
	bl	.L8		@
@ SkillsDebug.c:366: 	proc->skillReplacement = *gVeslySkill; // Short 
	ldr	r3, .L166+8	@ tmp124,
	movs	r2, #0	@ tmp146,
	ldrsh	r3, [r3, r2]	@ _2, tmp124, tmp146
@ SkillsDebug.c:367:     proc->unit = (struct Unit*) *gVeslyUnit; // Struct UnitRamPointer 
	ldr	r2, .L166+12	@ tmp130,
	ldr	r2, [r2]	@ _3, MEM[(int *)50337724B]
@ SkillsDebug.c:366: 	proc->skillReplacement = *gVeslySkill; // Short 
	strh	r3, [r0, #42]	@ _2, proc_8->skillReplacement
@ SkillsDebug.c:367:     proc->unit = (struct Unit*) *gVeslyUnit; // Struct UnitRamPointer 
	str	r2, [r0, #44]	@ _3, proc_8->unit
@ SkillsDebug.c:361:     struct SkillDebugProc* proc = (void*) ProcStart(Proc_SkillDebug, ROOT_PROC_3);
	movs	r1, r0	@ proc, tmp145
@ SkillsDebug.c:374: 	*MemorySlot1 = proc->unit; 
	ldr	r0, .L166+16	@ tmp131,
	str	r2, [r0]	@ _3, MEM[(int *)50332860B]
@ SkillsDebug.c:375: 	*MemorySlot3 = 0xF8;
	movs	r0, #248	@ tmp133,
	ldr	r2, .L166+20	@ tmp132,
	str	r0, [r2]	@ tmp133, MEM[(int *)50332868B]
@ SkillsDebug.c:376: 	*MemorySlot4 = proc->skillReplacement; 
	ldr	r2, .L166+24	@ tmp134,
@ SkillsDebug.c:388:     StartMenuChild(&Menu_SkillDebug, (void*) proc);
	movs	r0, r4	@ tmp122, tmp122
@ SkillsDebug.c:376: 	*MemorySlot4 = proc->skillReplacement; 
	str	r3, [r2]	@ _2, MEM[(int *)50332872B]
@ SkillsDebug.c:379: 	*MemorySlot6 = 0; // TRUE 
	movs	r3, #0	@ tmp136,
	ldr	r2, .L166+28	@ tmp135,
@ SkillsDebug.c:388:     StartMenuChild(&Menu_SkillDebug, (void*) proc);
	adds	r0, r0, #40	@ tmp122,
@ SkillsDebug.c:379: 	*MemorySlot6 = 0; // TRUE 
	str	r3, [r2]	@ tmp136, MEM[(int *)50332880B]
@ SkillsDebug.c:382:     proc->movesUpdated = FALSE;
	str	r3, [r1, #48]	@ tmp136, proc_8->movesUpdated
@ SkillsDebug.c:383:     proc->skillSelected = 0;
	str	r3, [r1, #52]	@ tmp136, proc_8->skillSelected
@ SkillsDebug.c:386: 	proc->hover_move_Updated = FALSE; 
	str	r3, [r1, #56]	@ tmp136, proc_8->hover_move_Updated
@ SkillsDebug.c:387: 	proc->move_hovering = 0;
	str	r3, [r1, #60]	@ tmp136, proc_8->move_hovering
@ SkillsDebug.c:388:     StartMenuChild(&Menu_SkillDebug, (void*) proc);
	ldr	r3, .L166+32	@ tmp143,
	bl	.L8		@
@ SkillsDebug.c:390: }
	movs	r0, #23	@,
	pop	{r4}
	pop	{r1}
	bx	r1
.L167:
	.align	2
.L166:
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
	.size	MenuCommands_SkillDebug, 360
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
.L8:
	bx	r3
.L108:
	bx	r6
.L107:
	bx	r7
