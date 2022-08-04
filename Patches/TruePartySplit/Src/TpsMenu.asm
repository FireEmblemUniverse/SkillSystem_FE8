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
	.file	"TpsMenu.c"
@ GNU C17 (devkitARM release 55) version 10.2.0 (arm-none-eabi)
@	compiled by GNU C version 4.9.2, GMP version 6.1.2, MPFR version 3.1.5, MPC version 1.0.3, isl version isl-0.15-GMP

@ GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
@ options passed:  -I Tools/CLib/include -I Wizardry/Include
@ -imultilib thumb
@ -iprefix /opt/devkitpro/devkitARM/bin/../lib/gcc/arm-none-eabi/10.2.0/
@ -MMD Wizardry/TruePartySplit/Src/TpsMenu.d -MF .cache_dir/TpsMenu.d -MP
@ -MT Wizardry/TruePartySplit/Src/TpsMenu.o
@ -MT Wizardry/TruePartySplit/Src/TpsMenu.asm -D__USES_INITFINI__
@ Wizardry/TruePartySplit/Src/TpsMenu.c -mcpu=arm7tdmi -mthumb
@ -mthumb-interwork -mtune=arm7tdmi -mlong-calls -march=armv4t
@ -auxbase-strip Wizardry/TruePartySplit/Src/TpsMenu.asm -Os -Wall
@ -ffreestanding -fverbose-asm
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
@ -ftree-loop-if-convert -ftree-loop-im -ftree-loop-ivcanon
@ -ftree-loop-optimize -ftree-parallelize-loops= -ftree-phiprop -ftree-pre
@ -ftree-pta -ftree-reassoc -ftree-scev-cprop -ftree-sink -ftree-slsr
@ -ftree-sra -ftree-switch-conversion -ftree-tail-merge -ftree-ter
@ -ftree-vrp -funit-at-a-time -fverbose-asm -fzero-initialized-in-bss
@ -mbe32 -mlittle-endian -mlong-calls -mpic-data-is-text-relative
@ -msched-prolog -mthumb -mthumb-interwork -mvectorize-with-neon-quad

	.text
	.align	1
	.arch armv4t
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	StartTpsMenuDrawSprites, %function
StartTpsMenuDrawSprites:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r0, r1, r2, r4, r5, r6, r7, lr}	@
@ Wizardry/TruePartySplit/Src/TpsMenu.c:193:     struct TpsMenuDrawUnitListProc* proc = (struct TpsMenuDrawUnitListProc*) ProcStart(ProcScr_TpsMenuDrawSprites, (struct Proc*) parent);
	ldr	r5, .L4	@ tmp123,
@ Wizardry/TruePartySplit/Src/TpsMenu.c:192: {
	str	r0, [sp]	@ tmp138, %sfp
	str	r1, [sp, #4]	@ tmp139, %sfp
@ Wizardry/TruePartySplit/Src/TpsMenu.c:193:     struct TpsMenuDrawUnitListProc* proc = (struct TpsMenuDrawUnitListProc*) ProcStart(ProcScr_TpsMenuDrawSprites, (struct Proc*) parent);
	movs	r0, r5	@, tmp123
	movs	r1, r2	@, parent
	ldr	r7, .L4+4	@ tmp124,
@ Wizardry/TruePartySplit/Src/TpsMenu.c:192: {
	movs	r6, r2	@ parent, tmp140
@ Wizardry/TruePartySplit/Src/TpsMenu.c:193:     struct TpsMenuDrawUnitListProc* proc = (struct TpsMenuDrawUnitListProc*) ProcStart(ProcScr_TpsMenuDrawSprites, (struct Proc*) parent);
	bl	.L6		@
@ Wizardry/TruePartySplit/Src/TpsMenu.c:195:     proc->bg = bg;
	ldr	r3, [sp]	@ bg, %sfp
	str	r3, [r0, #44]	@ bg, proc_11->bg
@ Wizardry/TruePartySplit/Src/TpsMenu.c:196:     proc->first_to_draw = 0;
	movs	r3, #0	@ tmp125,
@ Wizardry/TruePartySplit/Src/TpsMenu.c:197:     proc->uid_storage = parent->uid_storage->slaves[party];
	ldr	r1, [sp, #4]	@ party, %sfp
@ Wizardry/TruePartySplit/Src/TpsMenu.c:196:     proc->first_to_draw = 0;
	str	r3, [r0, #48]	@ tmp125, proc_11->first_to_draw
@ Wizardry/TruePartySplit/Src/TpsMenu.c:197:     proc->uid_storage = parent->uid_storage->slaves[party];
	adds	r1, r1, #10	@ party,
	ldr	r3, [r6, #44]	@ parent_9(D)->uid_storage, parent_9(D)->uid_storage
	lsls	r1, r1, #2	@ tmp128, tmp127,
	adds	r1, r3, r1	@ tmp129, parent_9(D)->uid_storage, tmp128
@ Wizardry/TruePartySplit/Src/TpsMenu.c:197:     proc->uid_storage = parent->uid_storage->slaves[party];
	ldr	r3, [r1, #4]	@ tmp145, _1->slaves[party_15(D)]
@ Wizardry/TruePartySplit/Src/TpsMenu.c:193:     struct TpsMenuDrawUnitListProc* proc = (struct TpsMenuDrawUnitListProc*) ProcStart(ProcScr_TpsMenuDrawSprites, (struct Proc*) parent);
	movs	r4, r0	@ proc, tmp141
@ Wizardry/TruePartySplit/Src/TpsMenu.c:197:     proc->uid_storage = parent->uid_storage->slaves[party];
	str	r3, [r0, #52]	@ tmp145, proc_11->uid_storage
@ Wizardry/TruePartySplit/Src/TpsMenu.c:199:     proc->text_storage = (struct TpsMenuDrawUnitListTextStorageProc*) ProcStart(ProcScr_Dummy, (struct Proc*) proc);
	movs	r0, r5	@ tmp123, tmp123
	movs	r1, r4	@, proc
	adds	r0, r0, #40	@ tmp123,
	bl	.L6		@
@ Wizardry/TruePartySplit/Src/TpsMenu.c:199:     proc->text_storage = (struct TpsMenuDrawUnitListTextStorageProc*) ProcStart(ProcScr_Dummy, (struct Proc*) proc);
	movs	r5, #42	@ ivtmp.15,
	str	r0, [r4, #56]	@ tmp142, proc_11->text_storage
.L2:
@ Wizardry/TruePartySplit/Src/TpsMenu.c:203:         Text_InitClear(&proc->text_storage->text[i], 8);
	ldr	r3, [r4, #56]	@ tmp147, proc_11->text_storage
	movs	r1, #8	@,
	adds	r0, r3, r5	@ tmp135, tmp147, ivtmp.15
	ldr	r3, .L4+8	@ tmp137,
@ Wizardry/TruePartySplit/Src/TpsMenu.c:201:     for (int i = 0; i < 8; ++i)
	adds	r5, r5, #8	@ ivtmp.15,
@ Wizardry/TruePartySplit/Src/TpsMenu.c:203:         Text_InitClear(&proc->text_storage->text[i], 8);
	bl	.L7		@
@ Wizardry/TruePartySplit/Src/TpsMenu.c:201:     for (int i = 0; i < 8; ++i)
	cmp	r5, #106	@ ivtmp.15,
	bne	.L2		@,
@ Wizardry/TruePartySplit/Src/TpsMenu.c:205: }
	@ sp needed	@
	pop	{r0, r1, r2, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L5:
	.align	2
.L4:
	.word	.LANCHOR0
	.word	ProcStart
	.word	Text_InitClear
	.size	StartTpsMenuDrawSprites, .-StartTpsMenuDrawSprites
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	TpsMenu_DrawFrames, %function
TpsMenu_DrawFrames:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
@ Wizardry/TruePartySplit/Src/TpsMenu.c:101:     gLCDIOBuffer.bgControl[0].priority = 0;
	movs	r1, #3	@ tmp120,
@ Wizardry/TruePartySplit/Src/TpsMenu.c:100: {
	push	{r4, r5, r6, r7, lr}	@
@ Wizardry/TruePartySplit/Src/TpsMenu.c:103:     gLCDIOBuffer.bgControl[2].priority = 1;
	movs	r5, #1	@ tmp139,
@ Wizardry/TruePartySplit/Src/TpsMenu.c:101:     gLCDIOBuffer.bgControl[0].priority = 0;
	ldr	r3, .L9	@ tmp114,
	ldrb	r2, [r3, #12]	@ gLCDIOBuffer.bgControl[0].priority, gLCDIOBuffer.bgControl[0].priority
	bics	r2, r1	@ tmp119, tmp120
	strb	r2, [r3, #12]	@ tmp119, gLCDIOBuffer.bgControl[0].priority
@ Wizardry/TruePartySplit/Src/TpsMenu.c:102:     gLCDIOBuffer.bgControl[1].priority = 0;
	ldrb	r2, [r3, #16]	@ gLCDIOBuffer.bgControl[1].priority, gLCDIOBuffer.bgControl[1].priority
	bics	r2, r1	@ tmp127, tmp120
	strb	r2, [r3, #16]	@ tmp127, gLCDIOBuffer.bgControl[1].priority
@ Wizardry/TruePartySplit/Src/TpsMenu.c:103:     gLCDIOBuffer.bgControl[2].priority = 1;
	ldrb	r2, [r3, #20]	@ gLCDIOBuffer.bgControl[2].priority, gLCDIOBuffer.bgControl[2].priority
	bics	r2, r1	@ tmp135, tmp120
	orrs	r2, r5	@ tmp138, tmp139
@ Wizardry/TruePartySplit/Src/TpsMenu.c:105:     WriteUIWindowTileMap(gBg2MapBuffer, LIST_PANEL_LEFT_X, LIST_PANEL_LEFT_Y, LIST_PANEL_WIDTH, 16, TILEREF(0, 0), 0);
	movs	r4, #0	@ tmp142,
@ Wizardry/TruePartySplit/Src/TpsMenu.c:103:     gLCDIOBuffer.bgControl[2].priority = 1;
	strb	r2, [r3, #20]	@ tmp138, gLCDIOBuffer.bgControl[2].priority
@ Wizardry/TruePartySplit/Src/TpsMenu.c:105:     WriteUIWindowTileMap(gBg2MapBuffer, LIST_PANEL_LEFT_X, LIST_PANEL_LEFT_Y, LIST_PANEL_WIDTH, 16, TILEREF(0, 0), 0);
	movs	r3, #16	@ tmp159,
@ Wizardry/TruePartySplit/Src/TpsMenu.c:100: {
	sub	sp, sp, #20	@,,
@ Wizardry/TruePartySplit/Src/TpsMenu.c:100: {
	movs	r6, r0	@ proc, tmp158
@ Wizardry/TruePartySplit/Src/TpsMenu.c:105:     WriteUIWindowTileMap(gBg2MapBuffer, LIST_PANEL_LEFT_X, LIST_PANEL_LEFT_Y, LIST_PANEL_WIDTH, 16, TILEREF(0, 0), 0);
	movs	r1, r5	@, tmp139
	str	r4, [sp, #8]	@ tmp142,
	str	r4, [sp, #4]	@ tmp142,
	str	r3, [sp]	@ tmp159,
	movs	r2, #4	@,
	ldr	r0, .L9+4	@,
	ldr	r7, .L9+8	@ tmp160,
	subs	r3, r3, #4	@,
	bl	.L6		@
@ Wizardry/TruePartySplit/Src/TpsMenu.c:106:     WriteUIWindowTileMap(gBg2MapBuffer, LIST_PANEL_RIGHT_X, LIST_PANEL_RIGHT_Y, LIST_PANEL_WIDTH, 16, TILEREF(0, 0), 0);
	movs	r3, #16	@ tmp162,
	movs	r2, #4	@,
	movs	r1, #17	@,
	str	r4, [sp, #8]	@ tmp142,
	str	r4, [sp, #4]	@ tmp142,
	str	r3, [sp]	@ tmp162,
	ldr	r0, .L9+4	@,
	ldr	r7, .L9+8	@ tmp163,
	subs	r3, r3, #4	@,
	bl	.L6		@
@ Wizardry/TruePartySplit/Src/TpsMenu.c:108:     EnableBgSyncByMask(BG2_SYNC_BIT);
	ldr	r3, .L9+12	@ tmp151,
@ Wizardry/TruePartySplit/Src/TpsMenu.c:111:     SetBgPosition(0, -16, -40);
	ldr	r7, .L9+16	@ tmp152,
@ Wizardry/TruePartySplit/Src/TpsMenu.c:108:     EnableBgSyncByMask(BG2_SYNC_BIT);
	movs	r0, #4	@,
	bl	.L7		@
@ Wizardry/TruePartySplit/Src/TpsMenu.c:110:     StartTpsMenuDrawSprites(0, 0, proc);
	movs	r2, r6	@, proc
	movs	r1, r4	@, tmp142
	movs	r0, r4	@, tmp142
	bl	StartTpsMenuDrawSprites		@
@ Wizardry/TruePartySplit/Src/TpsMenu.c:111:     SetBgPosition(0, -16, -40);
	movs	r2, r7	@, tmp152
	movs	r0, r4	@, tmp142
	ldr	r1, .L9+20	@,
	ldr	r4, .L9+24	@ tmp154,
	bl	.L11		@
@ Wizardry/TruePartySplit/Src/TpsMenu.c:113:     StartTpsMenuDrawSprites(1, 1, proc);
	movs	r2, r6	@, proc
	movs	r1, r5	@, tmp139
	movs	r0, r5	@, tmp139
	bl	StartTpsMenuDrawSprites		@
@ Wizardry/TruePartySplit/Src/TpsMenu.c:114:     SetBgPosition(1, -144, -40);
	movs	r2, r7	@, tmp152
	movs	r0, r5	@, tmp139
	ldr	r1, .L9+28	@,
	bl	.L11		@
@ Wizardry/TruePartySplit/Src/TpsMenu.c:115: }
	add	sp, sp, #20	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L10:
	.align	2
.L9:
	.word	gLCDIOBuffer
	.word	gBg2MapBuffer
	.word	WriteUIWindowTileMap
	.word	EnableBgSyncByMask
	.word	65496
	.word	65520
	.word	SetBgPosition
	.word	65392
	.size	TpsMenu_DrawFrames, .-TpsMenu_DrawFrames
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	TpsMenuDrawSprites_OnLoop, %function
TpsMenuDrawSprites_OnLoop:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r0, r1, r2, r4, r5, r6, r7, lr}	@
@ Wizardry/TruePartySplit/Src/TpsMenu.c:176: {
	movs	r5, r0	@ proc, tmp161
@ Wizardry/TruePartySplit/Src/TpsMenu.c:177:     for (int i = 0; i < 8; ++i)
	movs	r4, #0	@ i,
.L14:
@ Wizardry/TruePartySplit/Src/TpsMenu.c:179:         int const uid = proc->uid_storage->uids[proc->first_to_draw + i];
	ldr	r3, [r5, #52]	@ tmp166, proc_19(D)->uid_storage
	ldr	r2, [r5, #48]	@ tmp167, proc_19(D)->first_to_draw
	adds	r3, r3, r4	@ tmp136, tmp166, i
	adds	r3, r3, r2	@ tmp137, tmp136, tmp167
	adds	r3, r3, #42	@ tmp140,
	ldrb	r0, [r3]	@ _4, *_1
@ Wizardry/TruePartySplit/Src/TpsMenu.c:181:         if (uid == 0)
	cmp	r0, #0	@ _4,
	beq	.L12		@,
@ Wizardry/TruePartySplit/Src/TpsMenu.c:184:         int const x = -((short) gLCDIOBuffer.bgOffset[proc->bg].x);
	ldr	r3, [r5, #44]	@ tmp168, proc_19(D)->bg
	ldr	r2, .L19	@ tmp141,
	adds	r3, r3, #6	@ tmp142,
	lsls	r3, r3, #2	@ tmp143, tmp142,
	adds	r3, r2, r3	@ tmp144, tmp141, tmp143
@ Wizardry/TruePartySplit/Src/TpsMenu.c:184:         int const x = -((short) gLCDIOBuffer.bgOffset[proc->bg].x);
	movs	r2, #4	@ tmp164,
	ldrsh	r6, [r3, r2]	@ tmp146, tmp144, tmp164
@ Wizardry/TruePartySplit/Src/TpsMenu.c:185:         int const y = -((short) gLCDIOBuffer.bgOffset[proc->bg].y) + i*16;
	movs	r2, #6	@ tmp165,
	ldrsh	r3, [r3, r2]	@ tmp153, tmp144, tmp165
@ Wizardry/TruePartySplit/Src/TpsMenu.c:185:         int const y = -((short) gLCDIOBuffer.bgOffset[proc->bg].y) + i*16;
	lsls	r7, r4, #4	@ tmp147, i,
@ Wizardry/TruePartySplit/Src/TpsMenu.c:185:         int const y = -((short) gLCDIOBuffer.bgOffset[proc->bg].y) + i*16;
	subs	r7, r7, r3	@ y, tmp147, tmp153
@ Wizardry/TruePartySplit/Src/TpsMenu.c:187:         PutUnitSpriteExt(10-i, x, y, (1 << 10), GetUnit(uid));
	ldr	r3, .L19+4	@ tmp154,
	bl	.L7		@
	movs	r3, r0	@ tmp162,
@ Wizardry/TruePartySplit/Src/TpsMenu.c:187:         PutUnitSpriteExt(10-i, x, y, (1 << 10), GetUnit(uid));
	movs	r2, #10	@ tmp169,
	str	r3, [sp]	@ tmp162,
	movs	r3, #128	@,
@ Wizardry/TruePartySplit/Src/TpsMenu.c:184:         int const x = -((short) gLCDIOBuffer.bgOffset[proc->bg].x);
	rsbs	r6, r6, #0	@ x, tmp146
@ Wizardry/TruePartySplit/Src/TpsMenu.c:187:         PutUnitSpriteExt(10-i, x, y, (1 << 10), GetUnit(uid));
	subs	r0, r2, r4	@ tmp157, tmp169, i
	movs	r1, r6	@, x
	movs	r2, r7	@, y
	ldr	r6, .L19+8	@ tmp158,
	lsls	r3, r3, #3	@,,
@ Wizardry/TruePartySplit/Src/TpsMenu.c:177:     for (int i = 0; i < 8; ++i)
	adds	r4, r4, #1	@ i,
@ Wizardry/TruePartySplit/Src/TpsMenu.c:187:         PutUnitSpriteExt(10-i, x, y, (1 << 10), GetUnit(uid));
	bl	.L21		@
@ Wizardry/TruePartySplit/Src/TpsMenu.c:177:     for (int i = 0; i < 8; ++i)
	cmp	r4, #8	@ i,
	bne	.L14		@,
.L12:
@ Wizardry/TruePartySplit/Src/TpsMenu.c:189: }
	@ sp needed	@
	pop	{r0, r1, r2, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L20:
	.align	2
.L19:
	.word	gLCDIOBuffer
	.word	GetUnit
	.word	134381133
	.size	TpsMenuDrawSprites_OnLoop, .-TpsMenuDrawSprites_OnLoop
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	TpsMenu_InitStorage, %function
TpsMenu_InitStorage:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r0, r1, r2, r4, r5, r6, r7, lr}	@
@ Wizardry/TruePartySplit/Src/TpsMenu.c:61: {
	str	r0, [sp]	@ tmp171, %sfp
@ Wizardry/TruePartySplit/Src/TpsMenu.c:62:     struct TpsUidStorageProc* storage_proc = (struct TpsUidStorageProc*) ProcStart(ProcScr_Dummy, (struct Proc*) proc);
	ldr	r0, .L39	@ tmp140,
	ldr	r1, [sp]	@, %sfp
	ldr	r3, .L39+4	@ tmp141,
	adds	r0, r0, #40	@ tmp140,
	bl	.L7		@
@ Wizardry/TruePartySplit/Src/TpsMenu.c:64:     for (int i = 1; i < 0x40; ++i)
	movs	r6, #1	@ i,
@ Wizardry/TruePartySplit/Src/TpsMenu.c:62:     struct TpsUidStorageProc* storage_proc = (struct TpsUidStorageProc*) ProcStart(ProcScr_Dummy, (struct Proc*) proc);
	movs	r5, r0	@ storage_proc, tmp172
.L29:
	lsls	r7, r6, #24	@ _37, i,
	lsrs	r7, r7, #24	@ _37, _37,
@ Wizardry/TruePartySplit/Src/TpsMenu.c:66:         struct Unit* unit = GetUnit(i);
	movs	r0, r7	@, _37
	ldr	r3, .L39+8	@ tmp143,
	bl	.L7		@
@ Wizardry/TruePartySplit/Src/TpsMenu.c:68:         if (unit == NULL || unit->pCharacterData == NULL)
	cmp	r0, #0	@ unit,
	beq	.L27		@,
@ Wizardry/TruePartySplit/Src/TpsMenu.c:68:         if (unit == NULL || unit->pCharacterData == NULL)
	ldr	r3, [r0]	@ _2, unit_26->pCharacterData
@ Wizardry/TruePartySplit/Src/TpsMenu.c:68:         if (unit == NULL || unit->pCharacterData == NULL)
	cmp	r3, #0	@ _2,
	beq	.L27		@,
@ Wizardry/TruePartySplit/Src/TpsMenu.c:71:         if (unit->state & US_DEAD)
	movs	r1, #4	@ tmp177,
@ Wizardry/TruePartySplit/Src/TpsMenu.c:71:         if (unit->state & US_DEAD)
	ldr	r2, [r0, #12]	@ unit_26->state, unit_26->state
@ Wizardry/TruePartySplit/Src/TpsMenu.c:71:         if (unit->state & US_DEAD)
	tst	r2, r1	@ unit_26->state, tmp177
	bne	.L27		@,
@ Wizardry/TruePartySplit/Src/TpsMenu.c:74:         int const party = TpsGetPartyByPid(unit->pCharacterData->number);
	ldrb	r0, [r3, #4]	@ tmp147,
	ldr	r3, .L39+12	@ tmp148,
	bl	.L7		@
	lsls	r4, r0, #2	@ tmp149, tmp174,
	adds	r4, r5, r4	@ _51, storage_proc, tmp149
@ Wizardry/TruePartySplit/Src/TpsMenu.c:76:         if (storage_proc->slaves[party] == NULL)
	ldr	r3, [r4, #44]	@ MEM <struct TpsUidStorageSlaveProc *> [(struct TpsUidStorageProc *)_51 + 44B], MEM <struct TpsUidStorageSlaveProc *> [(struct TpsUidStorageProc *)_51 + 44B]
	str	r3, [sp, #4]	@ MEM <struct TpsUidStorageSlaveProc *> [(struct TpsUidStorageProc *)_51 + 44B], %sfp
	cmp	r3, #0	@ MEM <struct TpsUidStorageSlaveProc *> [(struct TpsUidStorageProc *)_51 + 44B],
	bne	.L24		@,
@ Wizardry/TruePartySplit/Src/TpsMenu.c:78:             storage_proc->slaves[party] = (struct TpsUidStorageSlaveProc*) ProcStart(ProcScr_Dummy, (struct Proc*) storage_proc);
	ldr	r0, .L39	@ tmp152,
	ldr	r3, .L39+4	@ tmp153,
	movs	r1, r5	@, storage_proc
	adds	r0, r0, #40	@ tmp152,
	bl	.L7		@
@ Wizardry/TruePartySplit/Src/TpsMenu.c:80:             storage_proc->slaves[party]->forced_amt = 1;
	movs	r3, r0	@ tmp156, _9
	movs	r2, #1	@ tmp183,
	adds	r3, r3, #41	@ tmp156,
@ Wizardry/TruePartySplit/Src/TpsMenu.c:78:             storage_proc->slaves[party] = (struct TpsUidStorageSlaveProc*) ProcStart(ProcScr_Dummy, (struct Proc*) storage_proc);
	str	r0, [r4, #44]	@ _9, MEM <struct TpsUidStorageSlaveProc *> [(struct TpsUidStorageProc *)_51 + 44B]
@ Wizardry/TruePartySplit/Src/TpsMenu.c:80:             storage_proc->slaves[party]->forced_amt = 1;
	strb	r2, [r3]	@ tmp182, MEM[(struct TpsUidStorageSlaveProc *)_9].forced_amt
	adds	r0, r0, #106	@ _43,
	adds	r3, r3, r2	@ ivtmp.46, ivtmp.46,
.L25:
@ Wizardry/TruePartySplit/Src/TpsMenu.c:83:                 storage_proc->slaves[party]->uids[j] = 0;
	ldr	r2, [sp, #4]	@ MEM <struct TpsUidStorageSlaveProc *> [(struct TpsUidStorageProc *)_51 + 44B], %sfp
	strb	r2, [r3]	@ MEM <struct TpsUidStorageSlaveProc *> [(struct TpsUidStorageProc *)_51 + 44B], MEM[base: _41, offset: 0B]
@ Wizardry/TruePartySplit/Src/TpsMenu.c:82:             for (int j = 0; j < 0x40; ++j)
	adds	r3, r3, #1	@ ivtmp.46,
	cmp	r0, r3	@ _43, ivtmp.46
	bne	.L25		@,
.L24:
@ Wizardry/TruePartySplit/Src/TpsMenu.c:88:             if (storage_proc->slaves[party]->uids[j] == 0)
	ldr	r3, [r4, #44]	@ _11, MEM <struct TpsUidStorageSlaveProc *> [(struct TpsUidStorageProc *)_51 + 44B]
@ Wizardry/TruePartySplit/Src/TpsMenu.c:88:             if (storage_proc->slaves[party]->uids[j] == 0)
	movs	r1, r3	@ tmp161, _11
@ Wizardry/TruePartySplit/Src/TpsMenu.c:86:         for (int j = 0; j < 0x40; ++j)
	movs	r2, #0	@ j,
@ Wizardry/TruePartySplit/Src/TpsMenu.c:88:             if (storage_proc->slaves[party]->uids[j] == 0)
	adds	r1, r1, #42	@ tmp161,
.L28:
@ Wizardry/TruePartySplit/Src/TpsMenu.c:88:             if (storage_proc->slaves[party]->uids[j] == 0)
	ldrb	r0, [r1, r2]	@ MEM[base: _46, index: _47, offset: 0B], MEM[base: _46, index: _47, offset: 0B]
	cmp	r0, #0	@ MEM[base: _46, index: _47, offset: 0B],
	bne	.L26		@,
@ Wizardry/TruePartySplit/Src/TpsMenu.c:90:                 storage_proc->slaves[party]->uids[j] = i;
	adds	r3, r3, r2	@ tmp163, _11, j
	adds	r3, r3, #42	@ tmp166,
	strb	r7, [r3]	@ _37, _11->uids[j_52]
.L27:
@ Wizardry/TruePartySplit/Src/TpsMenu.c:64:     for (int i = 1; i < 0x40; ++i)
	adds	r6, r6, #1	@ i,
@ Wizardry/TruePartySplit/Src/TpsMenu.c:64:     for (int i = 1; i < 0x40; ++i)
	cmp	r6, #64	@ i,
	bne	.L29		@,
@ Wizardry/TruePartySplit/Src/TpsMenu.c:96:     proc->uid_storage = storage_proc;
	ldr	r3, [sp]	@ proc, %sfp
@ Wizardry/TruePartySplit/Src/TpsMenu.c:97: }
	@ sp needed	@
@ Wizardry/TruePartySplit/Src/TpsMenu.c:96:     proc->uid_storage = storage_proc;
	str	r5, [r3, #44]	@ storage_proc, proc_21(D)->uid_storage
@ Wizardry/TruePartySplit/Src/TpsMenu.c:97: }
	pop	{r0, r1, r2, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L26:
@ Wizardry/TruePartySplit/Src/TpsMenu.c:86:         for (int j = 0; j < 0x40; ++j)
	adds	r2, r2, #1	@ j,
@ Wizardry/TruePartySplit/Src/TpsMenu.c:86:         for (int j = 0; j < 0x40; ++j)
	cmp	r2, #64	@ j,
	bne	.L28		@,
	b	.L27		@
.L40:
	.align	2
.L39:
	.word	.LANCHOR0
	.word	ProcStart
	.word	GetUnit
	.word	TpsGetPartyByPid
	.size	TpsMenu_InitStorage, .-TpsMenu_InitStorage
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	TpsMenuDrawSprites_DrawUnitNameText, %function
TpsMenuDrawSprites_DrawUnitNameText:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r0, r1, r2, r4, r5, r6, r7, lr}	@
@ Wizardry/TruePartySplit/Src/TpsMenu.c:148: {
	movs	r4, r0	@ proc, tmp173
@ Wizardry/TruePartySplit/Src/TpsMenu.c:149:     for (int i = 0; i < 8; ++i)
	movs	r6, #0	@ i,
.L45:
@ Wizardry/TruePartySplit/Src/TpsMenu.c:151:         int const uid = proc->uid_storage->uids[proc->first_to_draw + i];
	ldr	r2, [r4, #48]	@ tmp178, proc_25(D)->first_to_draw
@ Wizardry/TruePartySplit/Src/TpsMenu.c:151:         int const uid = proc->uid_storage->uids[proc->first_to_draw + i];
	ldr	r3, [r4, #52]	@ _1, proc_25(D)->uid_storage
@ Wizardry/TruePartySplit/Src/TpsMenu.c:151:         int const uid = proc->uid_storage->uids[proc->first_to_draw + i];
	adds	r7, r6, r2	@ _3, i, tmp178
@ Wizardry/TruePartySplit/Src/TpsMenu.c:151:         int const uid = proc->uid_storage->uids[proc->first_to_draw + i];
	adds	r2, r3, r7	@ tmp141, _1, _3
	adds	r2, r2, #42	@ tmp144,
	ldrb	r2, [r2]	@ _4, *_1
	str	r2, [sp]	@ _4, %sfp
@ Wizardry/TruePartySplit/Src/TpsMenu.c:153:         if (uid == 0)
	cmp	r2, #0	@ _4,
	beq	.L42		@,
@ Wizardry/TruePartySplit/Src/TpsMenu.c:156:         struct TextHandle* const text = &proc->text_storage->text[(proc->first_to_draw + i) % 8];
	ldr	r5, .L50	@ tmp147,
	ands	r5, r7	@ tmp146, _3
	bpl	.L43		@,
	movs	r2, #8	@ tmp181,
	subs	r5, r5, #1	@ tmp146,
	rsbs	r2, r2, #0	@ tmp181, tmp181
	orrs	r5, r2	@ tmp149, tmp181
	adds	r5, r5, #1	@ tmp146,
.L43:
@ Wizardry/TruePartySplit/Src/TpsMenu.c:156:         struct TextHandle* const text = &proc->text_storage->text[(proc->first_to_draw + i) % 8];
	ldr	r2, [r4, #56]	@ tmp182, proc_25(D)->text_storage
	lsls	r5, r5, #3	@ tmp152, tmp146,
@ Wizardry/TruePartySplit/Src/TpsMenu.c:157:         int const forced = ((proc->first_to_draw + i) < proc->uid_storage->forced_amt);
	adds	r3, r3, #41	@ tmp157,
	ldrb	r3, [r3]	@ _8,
@ Wizardry/TruePartySplit/Src/TpsMenu.c:156:         struct TextHandle* const text = &proc->text_storage->text[(proc->first_to_draw + i) % 8];
	adds	r5, r5, #42	@ tmp153,
	adds	r5, r2, r5	@ text, tmp182, tmp153
@ Wizardry/TruePartySplit/Src/TpsMenu.c:157:         int const forced = ((proc->first_to_draw + i) < proc->uid_storage->forced_amt);
	str	r3, [sp, #4]	@ _8, %sfp
@ Wizardry/TruePartySplit/Src/TpsMenu.c:159:         Text_Clear(text);
	movs	r0, r5	@, text
	ldr	r3, .L50+4	@ tmp158,
	bl	.L7		@
@ Wizardry/TruePartySplit/Src/TpsMenu.c:161:         if (forced)
	ldr	r3, [sp, #4]	@ _8, %sfp
	cmp	r7, r3	@ _3, _8
	bge	.L44		@,
@ Wizardry/TruePartySplit/Src/TpsMenu.c:162:             Text_SetColorId(text, TEXT_COLOR_GREEN);
	movs	r1, #4	@,
	movs	r0, r5	@, text
	ldr	r3, .L50+8	@ tmp159,
	bl	.L7		@
.L44:
@ Wizardry/TruePartySplit/Src/TpsMenu.c:167:         Text_Advance(text, 2);
	movs	r1, #2	@,
	ldr	r3, .L50+12	@ tmp160,
	movs	r0, r5	@, text
	bl	.L7		@
@ Wizardry/TruePartySplit/Src/TpsMenu.c:168:         Text_DrawString(text, GetStringFromIndex(GetUnit(uid)->pCharacterData->nameTextId));
	ldr	r3, .L50+16	@ tmp161,
	ldr	r0, [sp]	@, %sfp
	bl	.L7		@
@ Wizardry/TruePartySplit/Src/TpsMenu.c:168:         Text_DrawString(text, GetStringFromIndex(GetUnit(uid)->pCharacterData->nameTextId));
	ldr	r3, [r0]	@ _9->pCharacterData, _9->pCharacterData
@ Wizardry/TruePartySplit/Src/TpsMenu.c:168:         Text_DrawString(text, GetStringFromIndex(GetUnit(uid)->pCharacterData->nameTextId));
	ldrh	r0, [r3]	@ *_10, *_10
	ldr	r3, .L50+20	@ tmp164,
	bl	.L7		@
@ Wizardry/TruePartySplit/Src/TpsMenu.c:168:         Text_DrawString(text, GetStringFromIndex(GetUnit(uid)->pCharacterData->nameTextId));
	ldr	r3, .L50+24	@ tmp165,
@ Wizardry/TruePartySplit/Src/TpsMenu.c:168:         Text_DrawString(text, GetStringFromIndex(GetUnit(uid)->pCharacterData->nameTextId));
	movs	r1, r0	@ _13, tmp175
@ Wizardry/TruePartySplit/Src/TpsMenu.c:168:         Text_DrawString(text, GetStringFromIndex(GetUnit(uid)->pCharacterData->nameTextId));
	movs	r0, r5	@, text
	bl	.L7		@
@ Wizardry/TruePartySplit/Src/TpsMenu.c:169:         Text_Display(text, GetBgMapBuffer(proc->bg) + TILEMAP_INDEX(2, i*2));
	ldr	r3, .L50+28	@ tmp166,
	ldr	r0, [r4, #44]	@, proc_25(D)->bg
	bl	.L7		@
@ Wizardry/TruePartySplit/Src/TpsMenu.c:169:         Text_Display(text, GetBgMapBuffer(proc->bg) + TILEMAP_INDEX(2, i*2));
	lsls	r1, r6, #7	@ tmp167, i,
	adds	r1, r1, #4	@ tmp168,
@ Wizardry/TruePartySplit/Src/TpsMenu.c:169:         Text_Display(text, GetBgMapBuffer(proc->bg) + TILEMAP_INDEX(2, i*2));
	adds	r1, r0, r1	@ tmp169, tmp176, tmp168
	ldr	r3, .L50+32	@ tmp170,
	movs	r0, r5	@, text
@ Wizardry/TruePartySplit/Src/TpsMenu.c:149:     for (int i = 0; i < 8; ++i)
	adds	r6, r6, #1	@ i,
@ Wizardry/TruePartySplit/Src/TpsMenu.c:169:         Text_Display(text, GetBgMapBuffer(proc->bg) + TILEMAP_INDEX(2, i*2));
	bl	.L7		@
@ Wizardry/TruePartySplit/Src/TpsMenu.c:149:     for (int i = 0; i < 8; ++i)
	cmp	r6, #8	@ i,
	bne	.L45		@,
.L42:
@ Wizardry/TruePartySplit/Src/TpsMenu.c:173: }
	@ sp needed	@
@ Wizardry/TruePartySplit/Src/TpsMenu.c:172:     EnableBgSyncByIndex(proc->bg);
	ldr	r0, [r4, #44]	@, proc_25(D)->bg
	ldr	r3, .L50+36	@ tmp171,
	bl	.L7		@
@ Wizardry/TruePartySplit/Src/TpsMenu.c:173: }
	pop	{r0, r1, r2, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L51:
	.align	2
.L50:
	.word	-2147483641
	.word	Text_Clear
	.word	Text_SetColorId
	.word	Text_Advance
	.word	GetUnit
	.word	GetStringFromIndex
	.word	Text_DrawString
	.word	GetBgMapBuffer
	.word	Text_Display
	.word	EnableBgSyncByIndex
	.size	TpsMenuDrawSprites_DrawUnitNameText, .-TpsMenuDrawSprites_DrawUnitNameText
	.align	1
	.global	StartTpsMenu
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	StartTpsMenu, %function
StartTpsMenu:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	movs	r1, r0	@ parent, tmp121
	ldr	r0, .L56	@ tmp120,
	push	{r4, lr}	@
@ Wizardry/TruePartySplit/Src/TpsMenu.c:210:         ProcStartBlocking(ProcScr_TpsMenu, parent);
	ldr	r3, .L56+4	@ tmp116,
	adds	r0, r0, #48	@ tmp115,
@ Wizardry/TruePartySplit/Src/TpsMenu.c:209:     if (parent)
	cmp	r1, #0	@ parent,
	bne	.L55		@,
@ Wizardry/TruePartySplit/Src/TpsMenu.c:212:         ProcStart(ProcScr_TpsMenu, ROOT_PROC_3);
	movs	r1, #3	@,
	ldr	r3, .L56+8	@ tmp119,
.L55:
@ Wizardry/TruePartySplit/Src/TpsMenu.c:213: }
	@ sp needed	@
@ Wizardry/TruePartySplit/Src/TpsMenu.c:212:         ProcStart(ProcScr_TpsMenu, ROOT_PROC_3);
	bl	.L7		@
@ Wizardry/TruePartySplit/Src/TpsMenu.c:213: }
	pop	{r4}
	pop	{r0}
	bx	r0
.L57:
	.align	2
.L56:
	.word	.LANCHOR0
	.word	ProcStartBlocking
	.word	ProcStart
	.size	StartTpsMenu, .-StartTpsMenu
	.global	ProcScr_TpsMenuDrawSprites
	.section	.rodata.str1.1,"aMS",%progbits,1
.LC29:
	.ascii	"Stan's TPS Menu Sprite Drawer\000"
	.global	ProcScr_TpsMenu
.LC30:
	.ascii	"Stan's TPS Menu\000"
	.section	.rodata
	.align	2
	.set	.LANCHOR0,. + 0
	.type	ProcScr_TpsMenuDrawSprites, %object
	.size	ProcScr_TpsMenuDrawSprites, 40
ProcScr_TpsMenuDrawSprites:
@ type:
	.short	1
@ sArg:
	.short	0
@ lArg:
	.word	.LC29
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
	.word	TpsMenuDrawSprites_DrawUnitNameText
@ type:
	.short	3
@ sArg:
	.short	0
@ lArg:
	.word	TpsMenuDrawSprites_OnLoop
@ type:
	.short	0
@ sArg:
	.short	0
@ lArg:
	.word	0
	.type	ProcScr_Dummy, %object
	.size	ProcScr_Dummy, 8
ProcScr_Dummy:
@ type:
	.short	16
@ sArg:
	.short	0
@ lArg:
	.word	0
	.type	ProcScr_TpsMenu, %object
	.size	ProcScr_TpsMenu, 56
ProcScr_TpsMenu:
@ type:
	.short	1
@ sArg:
	.short	0
@ lArg:
	.word	.LC30
@ type:
	.short	2
@ sArg:
	.short	0
@ lArg:
	.word	NewGreenTextColorManager
@ type:
	.short	4
@ sArg:
	.short	0
@ lArg:
	.word	EndGreenTextColorManager
@ type:
	.short	2
@ sArg:
	.short	0
@ lArg:
	.word	TpsMenu_InitStorage
@ type:
	.short	2
@ sArg:
	.short	0
@ lArg:
	.word	TpsMenu_DrawFrames
@ type:
	.short	16
@ sArg:
	.short	0
@ lArg:
	.word	0
@ type:
	.short	0
@ sArg:
	.short	0
@ lArg:
	.word	0
	.ident	"GCC: (devkitARM release 55) 10.2.0"
	.text
	.code 16
	.align	1
.L7:
	bx	r3
.L11:
	bx	r4
.L21:
	bx	r6
.L6:
	bx	r7
