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
	.file	"BaseConvos.c"
@ GNU C17 (devkitARM release 53) version 9.1.0 (arm-none-eabi)
@	compiled by GNU C version 6.4.0, GMP version 6.0.0, MPFR version 3.1.2, MPC version 1.0.2, isl version none
@ GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
@ options passed:  -imultilib thumb
@ -iprefix c:\devkitpro\devkitarm\bin\../lib/gcc/arm-none-eabi/9.1.0/
@ -D__USES_INITFINI__ CBaseConvos/BaseConvos.c -mcpu=arm7tdmi -mthumb
@ -mthumb-interwork -mtune=arm7tdmi -mlong-calls -march=armv4t
@ -auxbase-strip CBaseConvos/BaseConvos.s -Os -Wall -fverbose-asm
@ options enabled:  -faggressive-loop-optimizations -fassume-phsa
@ -fauto-inc-dec -fbranch-count-reg -fcaller-saves -fcode-hoisting
@ -fcombine-stack-adjustments -fcommon -fcompare-elim -fcprop-registers
@ -fcrossjumping -fcse-follow-jumps -fdefer-pop
@ -fdelete-null-pointer-checks -fdevirtualize -fdevirtualize-speculatively
@ -fdwarf2-cfi-asm -fearly-inlining -feliminate-unused-debug-types
@ -fexpensive-optimizations -fforward-propagate -ffp-int-builtin-inexact
@ -ffunction-cse -fgcse -fgcse-lm -fgnu-runtime -fgnu-unique
@ -fguess-branch-probability -fhoist-adjacent-loads -fident -fif-conversion
@ -fif-conversion2 -findirect-inlining -finline -finline-atomics
@ -finline-functions -finline-functions-called-once
@ -finline-small-functions -fipa-bit-cp -fipa-cp -fipa-icf
@ -fipa-icf-functions -fipa-icf-variables -fipa-profile -fipa-pure-const
@ -fipa-reference -fipa-reference-addressable -fipa-sra
@ -fipa-stack-alignment -fipa-vrp -fira-hoist-pressure
@ -fira-share-save-slots -fira-share-spill-slots
@ -fisolate-erroneous-paths-dereference -fivopts -fkeep-static-consts
@ -fleading-underscore -flifetime-dse -flra-remat -flto-odr-type-merging
@ -fmath-errno -fmerge-constants -fmerge-debug-strings
@ -fmove-loop-invariants -fomit-frame-pointer -foptimize-sibling-calls
@ -fpartial-inlining -fpeephole -fpeephole2 -fplt -fprefetch-loop-arrays
@ -freg-struct-return -freorder-blocks -freorder-functions
@ -frerun-cse-after-loop -fsched-critical-path-heuristic
@ -fsched-dep-count-heuristic -fsched-group-heuristic -fsched-interblock
@ -fsched-last-insn-heuristic -fsched-pressure -fsched-rank-heuristic
@ -fsched-spec -fsched-spec-insn-heuristic -fsched-stalled-insns-dep
@ -fschedule-insns2 -fsection-anchors -fsemantic-interposition
@ -fshow-column -fshrink-wrap -fshrink-wrap-separate -fsigned-zeros
@ -fsplit-ivs-in-unroller -fsplit-wide-types -fssa-backprop -fssa-phiopt
@ -fstdarg-opt -fstore-merging -fstrict-aliasing
@ -fstrict-volatile-bitfields -fsync-libcalls -fthread-jumps
@ -ftoplevel-reorder -ftrapping-math -ftree-bit-ccp -ftree-builtin-call-dce
@ -ftree-ccp -ftree-ch -ftree-coalesce-vars -ftree-copy-prop -ftree-cselim
@ -ftree-dce -ftree-dominator-opts -ftree-dse -ftree-forwprop -ftree-fre
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
	.type	CopyString, %function
CopyString:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
@ CBaseConvos/Functions.c:31: {
	movs	r3, r0	@ origin, tmp125
@ CBaseConvos/Functions.c:33: 	if ( *origin == 0 )
	ldrb	r0, [r0]	@ *origin_14(D), *origin_14(D)
	cmp	r0, #0	@ *origin_14(D),
	bne	.L4		@,
@ CBaseConvos/Functions.c:35: 		*dest = 0;
	strb	r0, [r1]	@ *origin_14(D), *dest_15(D)
.L1:
@ CBaseConvos/Functions.c:46: }
	@ sp needed	@
	bx	lr
.L4:
@ CBaseConvos/Functions.c:32: 	int l = 0;
	movs	r0, #0	@ <retval>,
.L2:
@ CBaseConvos/Functions.c:41: 			*(dest+l) = *(origin+l);
	ldrb	r2, [r3, r0]	@ _5, MEM[base: origin_14(D), index: _19, offset: 0B]
@ CBaseConvos/Functions.c:41: 			*(dest+l) = *(origin+l);
	strb	r2, [r1, r0]	@ _5, MEM[base: dest_15(D), index: _19, offset: 0B]
@ CBaseConvos/Functions.c:42: 			l++;
	adds	r0, r0, #1	@ <retval>,
@ CBaseConvos/Functions.c:43: 		} while ( *(origin+l) != 0 );
	ldrb	r2, [r3, r0]	@ MEM[base: origin_14(D), index: _22, offset: 0B], MEM[base: origin_14(D), index: _22, offset: 0B]
	cmp	r2, #0	@ MEM[base: origin_14(D), index: _22, offset: 0B],
	bne	.L2		@,
	b	.L1		@
	.size	CopyString, .-CopyString
	.align	1
	.global	MenuBPress
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	MenuBPress, %function
MenuBPress:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ CBaseConvos/BaseConvos.c:167: 	BaseConvoProc* baseProc = (BaseConvoProc*)ProcFind(&BaseConvoProcMenu);
	ldr	r3, .L7	@ tmp114,
	ldr	r0, .L7+4	@,
	bl	.L9		@
	movs	r4, r0	@ baseProc, tmp122
@ CBaseConvos/BaseConvos.c:168: 	StartFadeInBlackMedium();
	ldr	r3, .L7+8	@ tmp115,
	bl	.L9		@
@ CBaseConvos/BaseConvos.c:169: 	ProcGoto((Proc*)baseProc,1);
	movs	r0, r4	@, baseProc
	movs	r1, #1	@,
	ldr	r3, .L7+12	@ tmp116,
	bl	.L9		@
@ CBaseConvos/BaseConvos.c:170: 	baseProc->wasBPressed = 1;
	movs	r3, #1	@ tmp120,
	adds	r4, r4, #42	@ tmp119,
@ CBaseConvos/BaseConvos.c:171: }
	@ sp needed	@
@ CBaseConvos/BaseConvos.c:170: 	baseProc->wasBPressed = 1;
	strb	r3, [r4]	@ tmp120, baseProc_3->wasBPressed
@ CBaseConvos/BaseConvos.c:171: }
	pop	{r4}
	pop	{r0}
	bx	r0
.L8:
	.align	2
.L7:
	.word	ProcFind
	.word	BaseConvoProcMenu
	.word	StartFadeInBlackMedium
	.word	ProcGoto
	.size	MenuBPress, .-MenuBPress
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	IsConvoViewable, %function
IsConvoViewable:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ CBaseConvos/Functions.c:5: 	if ( !entry->exists ) { return 0;}
	ldrb	r3, [r0, #31]	@ tmp117,
@ CBaseConvos/Functions.c:4: {
	movs	r4, r0	@ entry, tmp121
@ CBaseConvos/Functions.c:5: 	if ( !entry->exists ) { return 0;}
	cmp	r3, #0	@ tmp117,
	bne	.L11		@,
.L13:
@ CBaseConvos/Functions.c:5: 	if ( !entry->exists ) { return 0;}
	movs	r0, #0	@ <retval>,
.L10:
@ CBaseConvos/Functions.c:9: }
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L11:
@ CBaseConvos/Functions.c:6: 	if ( CheckEventId(entry->eventID) ) { return 0; }
	ldrh	r0, [r0, #28]	@ tmp118,
	ldr	r3, .L15	@ tmp119,
	bl	.L9		@
@ CBaseConvos/Functions.c:6: 	if ( CheckEventId(entry->eventID) ) { return 0; }
	cmp	r0, #0	@ tmp122,
	bne	.L13		@,
@ CBaseConvos/Functions.c:7: 	if ( !entry->usability ) { return 1; }
	ldr	r3, [r4, #4]	@ _12, entry_8(D)->usability
@ CBaseConvos/Functions.c:7: 	if ( !entry->usability ) { return 1; }
	adds	r0, r0, #1	@ <retval>,
@ CBaseConvos/Functions.c:7: 	if ( !entry->usability ) { return 1; }
	cmp	r3, #0	@ _12,
	beq	.L10		@,
@ CBaseConvos/Functions.c:8: 	else { return entry->usability(entry); }
	movs	r0, r4	@, entry
	bl	.L9		@
	b	.L10		@
.L16:
	.align	2
.L15:
	.word	CheckEventId
	.size	IsConvoViewable, .-IsConvoViewable
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	HandleText.isra.0.part.0, %function
HandleText.isra.0.part.0:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, lr}	@
@ CBaseConvos/Functions.c:48: static void HandleText(char* origin, char* dest, BaseConvoEntry* entry) // Handles appending importance to the right end of the title as well as copying the string to RAM.
	movs	r4, r0	@ dest, tmp141
	movs	r5, r1	@ ISRA.16, tmp142
@ CBaseConvos/Functions.c:67: 	int l = 0;
	movs	r6, #0	@ l,
.L18:
@ CBaseConvos/Functions.c:68: 	for ( ; *(string+l) ; l++ ) {}
	ldrb	r2, [r4, r6]	@ MEM[base: dest_1(D), index: _38, offset: 0B], MEM[base: dest_1(D), index: _38, offset: 0B]
	cmp	r2, #0	@ MEM[base: dest_1(D), index: _38, offset: 0B],
	bne	.L19		@,
@ CBaseConvos/Functions.c:56: 			*(dest+i) = ' ';
	movs	r7, #32	@ tmp140,
	adds	r6, r4, r6	@ ivtmp.51, dest, l
.L20:
@ CBaseConvos/Functions.c:54: 		for ( int i = GetStringLength(dest) ; GetStringTextWidthAscii(dest) < 0x78 ; i++ )
	movs	r0, r4	@, dest
	ldr	r3, .L26	@ tmp133,
	bl	.L9		@
@ CBaseConvos/Functions.c:54: 		for ( int i = GetStringLength(dest) ; GetStringTextWidthAscii(dest) < 0x78 ; i++ )
	cmp	r0, #119	@ tmp143,
	bls	.L21		@,
@ CBaseConvos/Functions.c:58: 		for ( int i = 0 ; i <= entry->importance ; i++ )
	movs	r2, #0	@ i,
@ CBaseConvos/Functions.c:60: 			*(dest+GetStringLength(dest)-i) = '!';
	movs	r6, #33	@ tmp139,
@ CBaseConvos/Functions.c:67: 	int l = 0;
	movs	r3, r2	@ l, i
.L22:
@ CBaseConvos/Functions.c:68: 	for ( ; *(string+l) ; l++ ) {}
	ldrb	r0, [r4, r3]	@ *_33, *_33
	cmp	r0, #0	@ *_33,
	bne	.L23		@,
@ CBaseConvos/Functions.c:60: 			*(dest+GetStringLength(dest)-i) = '!';
	subs	r3, r3, r2	@ tmp135, l, i
@ CBaseConvos/Functions.c:60: 			*(dest+GetStringLength(dest)-i) = '!';
	strb	r6, [r4, r3]	@ tmp139, *_13
@ CBaseConvos/Functions.c:58: 		for ( int i = 0 ; i <= entry->importance ; i++ )
	ldrb	r3, [r5]	@ *ISRA.16_15(D), *ISRA.16_15(D)
	adds	r1, r2, #1	@ i, i,
@ CBaseConvos/Functions.c:58: 		for ( int i = 0 ; i <= entry->importance ; i++ )
	cmp	r3, r1	@ *ISRA.16_15(D), i
	bge	.L25		@,
@ CBaseConvos/Functions.c:63: }
	@ sp needed	@
	pop	{r3, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L19:
@ CBaseConvos/Functions.c:68: 	for ( ; *(string+l) ; l++ ) {}
	adds	r6, r6, #1	@ l,
	b	.L18		@
.L21:
@ CBaseConvos/Functions.c:56: 			*(dest+i) = ' ';
	strb	r7, [r6]	@ tmp140, MEM[base: _39, offset: 0B]
	adds	r6, r6, #1	@ ivtmp.51,
	b	.L20		@
.L23:
@ CBaseConvos/Functions.c:68: 	for ( ; *(string+l) ; l++ ) {}
	movs	r1, r2	@ i, i
	adds	r3, r3, #1	@ l,
.L24:
@ CBaseConvos/Functions.c:67: 	int l = 0;
	movs	r2, r1	@ i, i
	b	.L22		@
.L25:
	movs	r3, r0	@ l, *_33
	b	.L24		@
.L27:
	.align	2
.L26:
	.word	GetStringTextWidthAscii
	.size	HandleText.isra.0.part.0, .-HandleText.isra.0.part.0
	.align	1
	.global	BaseConvoUsability
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	BaseConvoUsability, %function
BaseConvoUsability:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ CBaseConvos/BaseConvos.c:93: 	for ( int i = 0 ; i < 8 ; i++ )
	movs	r4, #0	@ i,
.L30:
@ CBaseConvos/BaseConvos.c:95: 		if ( IsConvoViewable(GetEntry(gChapterData.chapterIndex,i)) ) { return 1; }
	ldr	r3, .L33	@ tmp119,
@ CBaseConvos/BaseConvos.c:95: 		if ( IsConvoViewable(GetEntry(gChapterData.chapterIndex,i)) ) { return 1; }
	ldrb	r0, [r3, #14]	@ tmp120,
	lsls	r0, r0, #3	@ tmp121, tmp120,
	ldr	r3, .L33+4	@ tmp125,
	adds	r0, r0, r4	@ tmp122, tmp121, i
	lsls	r0, r0, #5	@ tmp123, tmp122,
	adds	r0, r0, r3	@ tmp124, tmp123, tmp125
	bl	IsConvoViewable		@
@ CBaseConvos/BaseConvos.c:95: 		if ( IsConvoViewable(GetEntry(gChapterData.chapterIndex,i)) ) { return 1; }
	cmp	r0, #0	@ <retval>,
	bne	.L31		@,
@ CBaseConvos/BaseConvos.c:93: 	for ( int i = 0 ; i < 8 ; i++ )
	adds	r4, r4, #1	@ i,
@ CBaseConvos/BaseConvos.c:93: 	for ( int i = 0 ; i < 8 ; i++ )
	cmp	r4, #8	@ i,
	bne	.L30		@,
.L28:
@ CBaseConvos/BaseConvos.c:98: }
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L31:
@ CBaseConvos/BaseConvos.c:95: 		if ( IsConvoViewable(GetEntry(gChapterData.chapterIndex,i)) ) { return 1; }
	movs	r0, #1	@ <retval>,
	b	.L28		@
.L34:
	.align	2
.L33:
	.word	gChapterData
	.word	BaseConvoTable
	.size	BaseConvoUsability, .-BaseConvoUsability
	.align	1
	.global	BaseConvoMenuUsability
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	BaseConvoMenuUsability, %function
BaseConvoMenuUsability:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ CBaseConvos/BaseConvos.c:103: 	return ( IsConvoViewable(GetEntry(gChapterData.chapterIndex,index)) ? 1 : 3);
	ldr	r3, .L38	@ tmp122,
@ CBaseConvos/BaseConvos.c:103: 	return ( IsConvoViewable(GetEntry(gChapterData.chapterIndex,index)) ? 1 : 3);
	ldrb	r0, [r3, #14]	@ tmp123,
	lsls	r0, r0, #3	@ tmp124, tmp123,
	adds	r0, r0, r1	@ tmp125, tmp124, tmp138
	ldr	r1, .L38+4	@ tmp128,
	lsls	r0, r0, #5	@ tmp126, tmp125,
	adds	r0, r0, r1	@ tmp127, tmp126, tmp128
	bl	IsConvoViewable		@
@ CBaseConvos/BaseConvos.c:103: 	return ( IsConvoViewable(GetEntry(gChapterData.chapterIndex,index)) ? 1 : 3);
	movs	r3, #1	@ <retval>,
	cmp	r0, #0	@ tmp139,
	bne	.L35		@,
	adds	r3, r3, #2	@ <retval>,
.L35:
@ CBaseConvos/BaseConvos.c:104: }
	movs	r0, r3	@, <retval>
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L39:
	.align	2
.L38:
	.word	gChapterData
	.word	BaseConvoTable
	.size	BaseConvoMenuUsability, .-BaseConvoMenuUsability
	.align	1
	.global	BaseConvoMenuEffect
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	BaseConvoMenuEffect, %function
BaseConvoMenuEffect:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
@ CBaseConvos/BaseConvos.c:109: 	((BaseConvoProc*)menu->parent)->viewingEntry = menuCommand->commandDefinitionIndex;
	ldr	r3, [r0, #20]	@ menu_4(D)->parent, menu_4(D)->parent
@ CBaseConvos/BaseConvos.c:109: 	((BaseConvoProc*)menu->parent)->viewingEntry = menuCommand->commandDefinitionIndex;
	adds	r1, r1, #60	@ tmp118,
@ CBaseConvos/BaseConvos.c:109: 	((BaseConvoProc*)menu->parent)->viewingEntry = menuCommand->commandDefinitionIndex;
	ldrb	r2, [r1]	@ tmp122,
	adds	r3, r3, #41	@ tmp121,
@ CBaseConvos/BaseConvos.c:114: }
	movs	r0, #2	@,
	@ sp needed	@
@ CBaseConvos/BaseConvos.c:109: 	((BaseConvoProc*)menu->parent)->viewingEntry = menuCommand->commandDefinitionIndex;
	strb	r2, [r3]	@ tmp122, MEM[(struct BaseConvoProc *)_1].viewingEntry
@ CBaseConvos/BaseConvos.c:114: }
	bx	lr
	.size	BaseConvoMenuEffect, .-BaseConvoMenuEffect
	.align	1
	.global	SetScrollingBackground
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	SetScrollingBackground, %function
SetScrollingBackground:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r0, r1, r2, r4, r5, lr}	@
@ CBaseConvos/BaseConvos.c:122: 	SetBeigeBackground((Proc*)proc,0,0x12,2,0);
	movs	r4, #0	@ tmp117,
@ CBaseConvos/BaseConvos.c:117: {
	movs	r5, r0	@ proc, tmp120
@ CBaseConvos/BaseConvos.c:118: 	LoadBgConfig(NULL);
	ldr	r3, .L42	@ tmp112,
	movs	r0, #0	@,
	bl	.L9		@
@ CBaseConvos/BaseConvos.c:119: 	FillBgMap(GetBgMapBuffer(0),0);
	ldr	r3, .L42+4	@ tmp113,
	movs	r0, #0	@,
	bl	.L9		@
	movs	r1, #0	@,
	ldr	r3, .L42+8	@ tmp114,
	bl	.L9		@
@ CBaseConvos/BaseConvos.c:120: 	Text_InitFont(); // Set up text font etc.
	ldr	r3, .L42+12	@ tmp115,
	bl	.L9		@
@ CBaseConvos/BaseConvos.c:121: 	LoadObjUIGfx(); // Sets up the glove.
	ldr	r3, .L42+16	@ tmp116,
	bl	.L9		@
@ CBaseConvos/BaseConvos.c:122: 	SetBeigeBackground((Proc*)proc,0,0x12,2,0);
	movs	r1, r4	@, tmp117
	movs	r0, r5	@, proc
	str	r4, [sp]	@ tmp117,
	ldr	r5, .L42+20	@ tmp118,
	movs	r3, #2	@,
	movs	r2, #18	@,
	bl	.L44		@
@ CBaseConvos/BaseConvos.c:123: 	SetColorEffectsParameters(3,0,0,0x10);
	movs	r2, r4	@, tmp117
	movs	r1, r4	@, tmp117
	movs	r3, #16	@,
	movs	r0, #3	@,
	ldr	r4, .L42+24	@ tmp119,
	bl	.L45		@
@ CBaseConvos/BaseConvos.c:124: }
	@ sp needed	@
	pop	{r0, r1, r2, r4, r5}
	pop	{r0}
	bx	r0
.L43:
	.align	2
.L42:
	.word	LoadBgConfig
	.word	GetBgMapBuffer
	.word	FillBgMap
	.word	Text_InitFont
	.word	LoadObjUIGfx
	.word	SetBeigeBackground
	.word	SetColorEffectsParameters
	.size	SetScrollingBackground, .-SetScrollingBackground
	.align	1
	.global	DisplayBottomText
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	DisplayBottomText, %function
DisplayBottomText:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ CBaseConvos/BaseConvos.c:128: 	Text_InitClear((TextHandle*)((char*)&TextHandleStruct-8),0x10);
	ldr	r4, .L47	@ tmp116,
	ldr	r5, .L47+4	@ tmp117,
	movs	r0, r4	@, tmp116
	movs	r1, #16	@,
	bl	.L44		@
@ CBaseConvos/BaseConvos.c:129: 	Text_InitClear(&TextHandleStruct,0x09);
	movs	r1, #9	@,
	ldr	r0, .L47+8	@,
	bl	.L44		@
@ CBaseConvos/BaseConvos.c:130: 	Text_Clear((TextHandle*)((char*)&TextHandleStruct-8));
	movs	r0, r4	@, tmp116
	ldr	r3, .L47+12	@ tmp121,
	bl	.L9		@
@ CBaseConvos/BaseConvos.c:131: 	char* String = GetStringFromIndex(gBaseConvoSelectConvoText);
	ldr	r3, .L47+16	@ tmp122,
	ldrh	r0, [r3]	@ gBaseConvoSelectConvoText, gBaseConvoSelectConvoText
	ldr	r3, .L47+20	@ tmp124,
	bl	.L9		@
@ CBaseConvos/BaseConvos.c:132: 	Text_InsertString((TextHandle*)((char*)&TextHandleStruct-8),Text_GetStringTextCenteredPos(0x80,String),0,String);
	ldr	r3, .L47+24	@ tmp125,
@ CBaseConvos/BaseConvos.c:131: 	char* String = GetStringFromIndex(gBaseConvoSelectConvoText);
	movs	r5, r0	@ String, tmp131
@ CBaseConvos/BaseConvos.c:132: 	Text_InsertString((TextHandle*)((char*)&TextHandleStruct-8),Text_GetStringTextCenteredPos(0x80,String),0,String);
	movs	r1, r0	@, String
	movs	r0, #128	@,
	bl	.L9		@
@ CBaseConvos/BaseConvos.c:132: 	Text_InsertString((TextHandle*)((char*)&TextHandleStruct-8),Text_GetStringTextCenteredPos(0x80,String),0,String);
	movs	r3, r5	@, String
@ CBaseConvos/BaseConvos.c:132: 	Text_InsertString((TextHandle*)((char*)&TextHandleStruct-8),Text_GetStringTextCenteredPos(0x80,String),0,String);
	movs	r1, r0	@ _3, tmp132
@ CBaseConvos/BaseConvos.c:132: 	Text_InsertString((TextHandle*)((char*)&TextHandleStruct-8),Text_GetStringTextCenteredPos(0x80,String),0,String);
	movs	r2, #0	@,
	movs	r0, r4	@, tmp116
	ldr	r5, .L47+28	@ tmp127,
	bl	.L44		@
@ CBaseConvos/BaseConvos.c:133: 	Text_Display((TextHandle*)((char*)&TextHandleStruct-8),&SomeBgMap);
	movs	r0, r4	@, tmp116
	ldr	r1, .L47+32	@,
	ldr	r3, .L47+36	@ tmp130,
	bl	.L9		@
@ CBaseConvos/BaseConvos.c:134: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L48:
	.align	2
.L47:
	.word	TextHandleStruct-8
	.word	Text_InitClear
	.word	TextHandleStruct
	.word	Text_Clear
	.word	gBaseConvoSelectConvoText
	.word	GetStringFromIndex
	.word	Text_GetStringTextCenteredPos
	.word	Text_InsertString
	.word	SomeBgMap
	.word	Text_Display
	.size	DisplayBottomText, .-DisplayBottomText
	.align	1
	.global	BuildBaseConvoMenuGeometry
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	BuildBaseConvoMenuGeometry, %function
BuildBaseConvoMenuGeometry:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, lr}	@
@ CBaseConvos/Functions.c:14: 	int sum = 0;
	movs	r5, #0	@ sum,
@ CBaseConvos/BaseConvos.c:138: {
	movs	r4, r0	@ proc, tmp166
@ CBaseConvos/Functions.c:15: 	for ( int i = 0 ; i < 8 ; i++ )
	movs	r7, r5	@ i, sum
@ CBaseConvos/BaseConvos.c:140: 	int NumConvos = GetNumViewable(gChapterData.chapterIndex);
	ldr	r3, .L57	@ tmp123,
	ldrb	r6, [r3, #14]	@ tmp124,
	ldr	r3, .L57+4	@ tmp126,
	lsls	r6, r6, #8	@ tmp125, tmp124,
	adds	r6, r6, r3	@ ivtmp.80, tmp125, tmp126
.L51:
@ CBaseConvos/Functions.c:17: 		if ( IsConvoViewable(GetEntry(c,i)) ) { sum++; }
	movs	r0, r6	@, ivtmp.80
	bl	IsConvoViewable		@
@ CBaseConvos/Functions.c:17: 		if ( IsConvoViewable(GetEntry(c,i)) ) { sum++; }
	subs	r3, r0, #1	@ tmp165, tmp167
	sbcs	r0, r0, r3	@ tmp164, tmp167, tmp165
@ CBaseConvos/Functions.c:15: 	for ( int i = 0 ; i < 8 ; i++ )
	adds	r7, r7, #1	@ i,
@ CBaseConvos/Functions.c:17: 		if ( IsConvoViewable(GetEntry(c,i)) ) { sum++; }
	adds	r5, r5, r0	@ sum, sum, tmp164
	adds	r6, r6, #32	@ ivtmp.80,
@ CBaseConvos/Functions.c:15: 	for ( int i = 0 ; i < 8 ; i++ )
	cmp	r7, #8	@ i,
	bne	.L51		@,
@ CBaseConvos/BaseConvos.c:141: 	baseProc->menuData.geometry.x = 6;
	movs	r3, r4	@ tmp129, proc
	movs	r2, #6	@ tmp130,
	adds	r3, r3, #68	@ tmp129,
	strb	r2, [r3]	@ tmp130, proc_7(D)->menuData.geometry.x
@ CBaseConvos/BaseConvos.c:148: 		baseProc->menuData.geometry.y = 0;
	movs	r3, #0	@ cstore_33,
@ CBaseConvos/BaseConvos.c:142: 	if ( NumConvos != 8 )
	cmp	r5, #8	@ sum,
	beq	.L52		@,
@ CBaseConvos/BaseConvos.c:144: 		baseProc->menuData.geometry.y = 5 - NumConvos / 2;
	lsrs	r3, r5, #31	@ tmp133, sum,
	adds	r3, r3, r5	@ tmp134, tmp133, sum
	asrs	r3, r3, #1	@ tmp135, tmp134,
	rsbs	r3, r3, #0	@ tmp135, tmp135
@ CBaseConvos/BaseConvos.c:144: 		baseProc->menuData.geometry.y = 5 - NumConvos / 2;
	adds	r3, r3, #5	@ tmp137,
	lsls	r3, r3, #24	@ cstore_33, tmp137,
	lsrs	r3, r3, #24	@ cstore_33, cstore_33,
.L52:
	movs	r2, r4	@ tmp141, proc
	adds	r2, r2, #69	@ tmp141,
	strb	r3, [r2]	@ cstore_33, proc_7(D)->menuData.geometry.y
@ CBaseConvos/BaseConvos.c:150: 	baseProc->menuData.geometry.h = 18; // I honestly have no idea why these are swapped now. They didn't use to be this way I swear.
	movs	r3, r4	@ tmp143, proc
	movs	r2, #18	@ tmp144,
	adds	r3, r3, #8	@ tmp143,
	strh	r2, [r3, #62]	@ tmp144, MEM[(unsigned char *)proc_7(D) + 70B]
@ CBaseConvos/BaseConvos.c:152: 	baseProc->menuData.style = 1;
	adds	r3, r3, #64	@ tmp148,
	subs	r2, r2, #17	@ tmp149,
	strb	r2, [r3]	@ tmp149, proc_7(D)->menuData.style
@ CBaseConvos/BaseConvos.c:153: 	baseProc->menuData.commandList = &BaseConvoMenuCommands;
	ldr	r3, .L57+8	@ tmp151,
	str	r3, [r4, #76]	@ tmp151, proc_7(D)->menuData.commandList
@ CBaseConvos/BaseConvos.c:154: 	baseProc->menuData.onInit = NULL;
	movs	r3, #0	@ tmp152,
@ CBaseConvos/BaseConvos.c:157: 	baseProc->menuData.onBPress = &MenuBPress;
	ldr	r2, .L57+12	@ tmp155,
@ CBaseConvos/BaseConvos.c:154: 	baseProc->menuData.onInit = NULL;
	str	r3, [r4, #84]	@ tmp152, proc_7(D)->menuData.onInit
@ CBaseConvos/BaseConvos.c:155: 	baseProc->menuData.onEnd = NULL;
	str	r3, [r4, #80]	@ tmp152, proc_7(D)->menuData.onEnd
@ CBaseConvos/BaseConvos.c:156: 	baseProc->menuData._u14 = NULL;
	str	r3, [r4, #88]	@ tmp152, proc_7(D)->menuData._u14
@ CBaseConvos/BaseConvos.c:158: 	baseProc->menuData.onRPress = NULL;
	str	r3, [r4, #96]	@ tmp152, proc_7(D)->menuData.onRPress
@ CBaseConvos/BaseConvos.c:159: 	baseProc->menuData.onHelpBox = NULL;
	str	r3, [r4, #100]	@ tmp152, proc_7(D)->menuData.onHelpBox
@ CBaseConvos/BaseConvos.c:157: 	baseProc->menuData.onBPress = &MenuBPress;
	str	r2, [r4, #92]	@ tmp155, proc_7(D)->menuData.onBPress
@ CBaseConvos/BaseConvos.c:161: 	baseProc->viewingEntry = 0xFF;
	adds	r3, r3, #255	@ tmp161,
	adds	r4, r4, #41	@ tmp160,
@ CBaseConvos/BaseConvos.c:162: }
	@ sp needed	@
@ CBaseConvos/BaseConvos.c:161: 	baseProc->viewingEntry = 0xFF;
	strb	r3, [r4]	@ tmp161, proc_7(D)->viewingEntry
@ CBaseConvos/BaseConvos.c:162: }
	pop	{r3, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L58:
	.align	2
.L57:
	.word	gChapterData
	.word	BaseConvoTable
	.word	BaseConvoMenuCommands
	.word	MenuBPress
	.size	BuildBaseConvoMenuGeometry, .-BuildBaseConvoMenuGeometry
	.align	1
	.global	BuildBaseConvoMenuText
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	BuildBaseConvoMenuText, %function
BuildBaseConvoMenuText:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
@ CBaseConvos/Functions.c:24: 	for ( int i = 0 ; i < size ; i++ )
	movs	r3, #0	@ i,
@ CBaseConvos/Functions.c:24: 	for ( int i = 0 ; i < size ; i++ )
	movs	r2, #160	@ tmp137,
@ CBaseConvos/Functions.c:26: 		*(offset + i) = 0;
	movs	r0, r3	@ tmp135, i
@ CBaseConvos/BaseConvos.c:178: {
	push	{r4, r5, r6, lr}	@
@ CBaseConvos/Functions.c:26: 		*(offset + i) = 0;
	ldr	r5, .L75	@ tmp134,
@ CBaseConvos/Functions.c:24: 	for ( int i = 0 ; i < size ; i++ )
	lsls	r2, r2, #1	@ tmp137, tmp137,
.L60:
@ CBaseConvos/Functions.c:26: 		*(offset + i) = 0;
	adds	r1, r3, r5	@ tmp133, i, tmp134
@ CBaseConvos/Functions.c:24: 	for ( int i = 0 ; i < size ; i++ )
	adds	r3, r3, #1	@ i,
@ CBaseConvos/Functions.c:26: 		*(offset + i) = 0;
	strb	r0, [r1]	@ tmp135, MEM[symbol: WriteTextTo, index: _47, offset: 0B]
@ CBaseConvos/Functions.c:24: 	for ( int i = 0 ; i < size ; i++ )
	cmp	r3, r2	@ i, tmp137
	bne	.L60		@,
@ CBaseConvos/BaseConvos.c:180: 	for ( int i = 0 ; i < 8 ; i++ )
	movs	r6, #0	@ i,
.L66:
@ CBaseConvos/BaseConvos.c:182: 		BaseConvoEntry* entry = GetEntry(gChapterData.chapterIndex,i);
	ldr	r3, .L75+4	@ tmp138,
	ldrb	r4, [r3, #14]	@ _1,
@ CBaseConvos/BaseConvos.c:182: 		BaseConvoEntry* entry = GetEntry(gChapterData.chapterIndex,i);
	lsls	r4, r4, #3	@ tmp139, _1,
	ldr	r1, .L75+8	@ tmp142,
	adds	r4, r4, r6	@ tmp140, tmp139, i
	lsls	r4, r4, #5	@ tmp141, tmp140,
	adds	r4, r4, r1	@ entry, tmp141, tmp142
@ CBaseConvos/BaseConvos.c:183: 		if ( entry->title != 0 )
	ldrh	r0, [r4, #12]	@ _3, BaseConvoTable
@ CBaseConvos/BaseConvos.c:186: 			HandleText(GetStringFromIndex(entry->title),&WriteTextTo+40*i,entry);
	ldr	r3, .L75+12	@ tmp149,
@ CBaseConvos/BaseConvos.c:183: 		if ( entry->title != 0 )
	cmp	r0, #0	@ _3,
	bne	.L74		@,
@ CBaseConvos/BaseConvos.c:188: 		else if ( entry->textGetter != NULL )
	ldr	r3, [r4, #16]	@ _9, MEM[(struct BaseConvoEntry *)&BaseConvoTable][_2][i_48].textGetter
@ CBaseConvos/BaseConvos.c:188: 		else if ( entry->textGetter != NULL )
	cmp	r3, #0	@ _9,
	beq	.L64		@,
@ CBaseConvos/BaseConvos.c:191: 			HandleText(entry->textGetter(entry),&WriteTextTo+40*i,entry);
	movs	r0, r4	@, entry
.L74:
	bl	.L9		@
@ CBaseConvos/Functions.c:51: 	CopyString(origin,dest);
	movs	r1, r5	@, ivtmp.88
	bl	CopyString		@
@ CBaseConvos/Functions.c:52: 	if ( entry->importance != 0 )
	ldrb	r3, [r4, #30]	@ MEM[(u8 *)entry_22 + 30B], MEM[(u8 *)entry_22 + 30B]
	cmp	r3, #0	@ MEM[(u8 *)entry_22 + 30B],
	beq	.L63		@,
	movs	r1, r4	@ entry, entry
	movs	r0, r5	@, ivtmp.88
	adds	r1, r1, #30	@ entry,
	bl	HandleText.isra.0.part.0		@
.L63:
@ CBaseConvos/BaseConvos.c:180: 	for ( int i = 0 ; i < 8 ; i++ )
	adds	r6, r6, #1	@ i,
	adds	r5, r5, #40	@ ivtmp.88,
@ CBaseConvos/BaseConvos.c:180: 	for ( int i = 0 ; i < 8 ; i++ )
	cmp	r6, #8	@ i,
	bne	.L66		@,
@ CBaseConvos/BaseConvos.c:199: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L64:
@ CBaseConvos/BaseConvos.c:196: 			*(&WriteTextTo+40*i) = 0;
	strb	r3, [r5]	@ _9, MEM[base: _63, offset: 0B]
	b	.L63		@
.L76:
	.align	2
.L75:
	.word	WriteTextTo
	.word	gChapterData
	.word	BaseConvoTable
	.word	GetStringFromIndex
	.size	BuildBaseConvoMenuText, .-BuildBaseConvoMenuText
	.align	1
	.global	CallBaseSupportMenu
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	CallBaseSupportMenu, %function
CallBaseSupportMenu:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
@ CBaseConvos/BaseConvos.c:205: 	disp->enableBg0 = 1;
	movs	r3, #31	@ tmp120,
@ CBaseConvos/BaseConvos.c:203: {
	push	{r4, lr}	@
@ CBaseConvos/BaseConvos.c:203: {
	movs	r4, r0	@ proc, tmp130
@ CBaseConvos/BaseConvos.c:205: 	disp->enableBg0 = 1;
	ldr	r1, .L78	@ tmp115,
	ldrb	r2, [r1, #1]	@ MEM[(struct DispControl *)&gLCDIOBuffer + 1B], MEM[(struct DispControl *)&gLCDIOBuffer + 1B]
	bics	r2, r3	@ tmp119, tmp120
	orrs	r3, r2	@ tmp122, tmp119
	strb	r3, [r1, #1]	@ tmp122, MEM[(struct DispControl *)&gLCDIOBuffer + 1B]
@ CBaseConvos/BaseConvos.c:210: 	Text_SetFont(NULL);
	movs	r0, #0	@,
	ldr	r3, .L78+4	@ tmp125,
	bl	.L9		@
@ CBaseConvos/BaseConvos.c:211: 	Font_LoadForUI();
	ldr	r3, .L78+8	@ tmp126,
	bl	.L9		@
@ CBaseConvos/BaseConvos.c:212: 	LoadNewUIGraphics();
	ldr	r3, .L78+12	@ tmp127,
	bl	.L9		@
@ CBaseConvos/BaseConvos.c:213: 	StartMenuChild(&proc->menuData,(Proc*)proc);
	movs	r0, r4	@ tmp128, proc
@ CBaseConvos/BaseConvos.c:213: 	StartMenuChild(&proc->menuData,(Proc*)proc);
	movs	r1, r4	@, proc
	ldr	r3, .L78+16	@ tmp129,
@ CBaseConvos/BaseConvos.c:213: 	StartMenuChild(&proc->menuData,(Proc*)proc);
	adds	r0, r0, #68	@ tmp128,
@ CBaseConvos/BaseConvos.c:213: 	StartMenuChild(&proc->menuData,(Proc*)proc);
	bl	.L9		@
@ CBaseConvos/BaseConvos.c:214: }
	@ sp needed	@
	pop	{r4}
	pop	{r0}
	bx	r0
.L79:
	.align	2
.L78:
	.word	gLCDIOBuffer
	.word	Text_SetFont
	.word	Font_LoadForUI
	.word	LoadNewUIGraphics
	.word	StartMenuChild
	.size	CallBaseSupportMenu, .-CallBaseSupportMenu
	.align	1
	.global	EnsureSelection
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	EnsureSelection, %function
EnsureSelection:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
@ CBaseConvos/BaseConvos.c:218: 	return proc->viewingEntry == 0xFF; // Advance the proc is 0x2 is not 0xFF.
	adds	r0, r0, #41	@ tmp117,
@ CBaseConvos/BaseConvos.c:218: 	return proc->viewingEntry == 0xFF; // Advance the proc is 0x2 is not 0xFF.
	ldrb	r0, [r0]	@ tmp119,
	subs	r0, r0, #255	@ tmp121,
	rsbs	r3, r0, #0	@ tmp122, tmp121
	adcs	r0, r0, r3	@ tmp120, tmp121, tmp122
@ CBaseConvos/BaseConvos.c:219: }
	@ sp needed	@
	bx	lr
	.size	EnsureSelection, .-EnsureSelection
	.align	1
	.global	SetUpConvo
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	SetUpConvo, %function
SetUpConvo:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, lr}	@
@ CBaseConvos/BaseConvos.c:237: 	EndBG3Slider();
	ldr	r3, .L87	@ tmp140,
@ CBaseConvos/BaseConvos.c:236: {
	movs	r4, r0	@ proc, tmp228
@ CBaseConvos/BaseConvos.c:237: 	EndBG3Slider();
	bl	.L9		@
@ CBaseConvos/Functions.c:24: 	for ( int i = 0 ; i < size ; i++ )
	movs	r3, #0	@ i,
@ CBaseConvos/Functions.c:24: 	for ( int i = 0 ; i < size ; i++ )
	movs	r2, #160	@ tmp145,
@ CBaseConvos/Functions.c:26: 		*(offset + i) = 0;
	movs	r0, r3	@ tmp143, i
	ldr	r5, .L87+4	@ tmp142,
@ CBaseConvos/Functions.c:24: 	for ( int i = 0 ; i < size ; i++ )
	lsls	r2, r2, #1	@ tmp145, tmp145,
.L82:
@ CBaseConvos/Functions.c:26: 		*(offset + i) = 0;
	adds	r1, r3, r5	@ tmp141, i, tmp142
@ CBaseConvos/Functions.c:24: 	for ( int i = 0 ; i < size ; i++ )
	adds	r3, r3, #1	@ i,
@ CBaseConvos/Functions.c:26: 		*(offset + i) = 0;
	strb	r0, [r1]	@ tmp143, MEM[symbol: WriteTextTo, index: _57, offset: 0B]
@ CBaseConvos/Functions.c:24: 	for ( int i = 0 ; i < size ; i++ )
	cmp	r3, r2	@ i, tmp145
	bne	.L82		@,
@ CBaseConvos/BaseConvos.c:239: 	BaseConvoEntry* entry = GetEntry(gChapterData.chapterIndex,proc->viewingEntry);
	ldr	r3, .L87+8	@ tmp146,
	adds	r4, r4, #41	@ tmp149,
	ldrb	r5, [r3, #14]	@ _2,
	ldrb	r7, [r4]	@ _4,
@ CBaseConvos/BaseConvos.c:240: 	gMemorySlot[0x2] = entry->background;
	lsls	r5, r5, #3	@ tmp152, _2,
	ldr	r6, .L87+12	@ tmp151,
	adds	r3, r5, r7	@ tmp153, tmp152, _4
	lsls	r3, r3, #5	@ tmp154, tmp153,
	adds	r3, r6, r3	@ tmp155, tmp151, tmp154
@ CBaseConvos/BaseConvos.c:240: 	gMemorySlot[0x2] = entry->background;
	ldr	r4, .L87+16	@ tmp150,
@ CBaseConvos/BaseConvos.c:240: 	gMemorySlot[0x2] = entry->background;
	ldrb	r2, [r3, #2]	@ tmp157, BaseConvoTable
	str	r2, [r4, #8]	@ tmp157, gMemorySlot
@ CBaseConvos/BaseConvos.c:241: 	gMemorySlot[0x3] = entry->textID;
	ldrh	r2, [r3, #20]	@ tmp165, BaseConvoTable
	str	r2, [r4, #12]	@ tmp165, gMemorySlot
@ CBaseConvos/BaseConvos.c:242: 	gMemorySlot[0x4] = entry->music;
	ldrh	r2, [r3, #14]	@ tmp173, BaseConvoTable
	str	r2, [r4, #16]	@ tmp173, gMemorySlot
@ CBaseConvos/BaseConvos.c:243: 	gMemorySlot[0x5] = entry->item;
	ldrb	r2, [r3, #22]	@ tmp181, BaseConvoTable
@ CBaseConvos/BaseConvos.c:244: 	if ( entry->giveTo != 0xFF )
	ldrb	r3, [r3, #23]	@ _13, BaseConvoTable
@ CBaseConvos/BaseConvos.c:243: 	gMemorySlot[0x5] = entry->item;
	str	r2, [r4, #20]	@ tmp181, gMemorySlot
@ CBaseConvos/BaseConvos.c:244: 	if ( entry->giveTo != 0xFF )
	cmp	r3, #255	@ _13,
	beq	.L83		@,
.L86:
@ CBaseConvos/BaseConvos.c:252: 	gMemorySlot[0x7] = (u32)(entry->unit);
	adds	r5, r5, r7	@ tmp196, tmp152, _4
	lsls	r5, r5, #5	@ tmp197, tmp196,
@ CBaseConvos/BaseConvos.c:250: 		gMemorySlot[0x6] = GetUnit(1)->pCharacterData->number; // 0xFF = give to character in first 
	str	r3, [r4, #24]	@ tmp192, gMemorySlot
@ CBaseConvos/BaseConvos.c:252: 	gMemorySlot[0x7] = (u32)(entry->unit);
	adds	r3, r6, r5	@ tmp198, tmp151, tmp197
@ CBaseConvos/BaseConvos.c:252: 	gMemorySlot[0x7] = (u32)(entry->unit);
	ldr	r2, [r3, #24]	@ tmp231, MEM[(struct BaseConvoEntry *)&BaseConvoTable][_2][_4].unit
	str	r2, [r4, #28]	@ tmp231, gMemorySlot
@ CBaseConvos/BaseConvos.c:253: 	gMemorySlot[0x8] = entry->character1;
	ldrb	r2, [r6, r5]	@ tmp206, BaseConvoTable
@ CBaseConvos/BaseConvos.c:255: 	gMemorySlot[0xA] = entry->eventID;
	ldrh	r0, [r3, #28]	@ _25, BaseConvoTable
@ CBaseConvos/BaseConvos.c:253: 	gMemorySlot[0x8] = entry->character1;
	str	r2, [r4, #32]	@ tmp206, gMemorySlot
@ CBaseConvos/BaseConvos.c:254: 	gMemorySlot[0x9] = entry->character2;
	ldrb	r2, [r3, #1]	@ tmp214, BaseConvoTable
@ CBaseConvos/BaseConvos.c:256: 	gMemorySlot[0xB] = 0;
	movs	r3, #0	@ tmp223,
	str	r3, [r4, #44]	@ tmp223, gMemorySlot
@ CBaseConvos/BaseConvos.c:258: 	SetEventId(entry->eventID);
	ldr	r3, .L87+20	@ tmp224,
@ CBaseConvos/BaseConvos.c:254: 	gMemorySlot[0x9] = entry->character2;
	str	r2, [r4, #36]	@ tmp214, gMemorySlot
@ CBaseConvos/BaseConvos.c:255: 	gMemorySlot[0xA] = entry->eventID;
	str	r0, [r4, #40]	@ _25, gMemorySlot
@ CBaseConvos/BaseConvos.c:259: }
	@ sp needed	@
@ CBaseConvos/BaseConvos.c:258: 	SetEventId(entry->eventID);
	bl	.L9		@
@ CBaseConvos/BaseConvos.c:259: }
	pop	{r3, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L83:
@ CBaseConvos/BaseConvos.c:250: 		gMemorySlot[0x6] = GetUnit(1)->pCharacterData->number; // 0xFF = give to character in first 
	ldr	r3, .L87+24	@ tmp189,
	movs	r0, #1	@,
	bl	.L9		@
@ CBaseConvos/BaseConvos.c:250: 		gMemorySlot[0x6] = GetUnit(1)->pCharacterData->number; // 0xFF = give to character in first 
	ldr	r3, [r0]	@ _15->pCharacterData, _15->pCharacterData
	ldrb	r3, [r3, #4]	@ tmp192,
	b	.L86		@
.L88:
	.align	2
.L87:
	.word	EndBG3Slider
	.word	WriteTextTo
	.word	gChapterData
	.word	BaseConvoTable
	.word	gMemorySlot
	.word	SetEventId
	.word	GetUnit
	.size	SetUpConvo, .-SetUpConvo
	.align	1
	.global	CallConversation
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	CallConversation, %function
CallConversation:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ CBaseConvos/BaseConvos.c:263: 	BaseConvoEntry* entry = GetEntry(gChapterData.chapterIndex,proc->viewingEntry);
	ldr	r3, .L92	@ tmp117,
	adds	r0, r0, #41	@ tmp121,
	ldrb	r3, [r3, #14]	@ tmp118,
	ldrb	r2, [r0]	@ tmp122,
@ CBaseConvos/BaseConvos.c:264: 	if ( entry->event == NULL )
	lsls	r3, r3, #3	@ tmp123, tmp118,
	adds	r3, r3, r2	@ tmp124, tmp123, tmp122
	ldr	r2, .L92+4	@ tmp116,
	lsls	r3, r3, #5	@ tmp125, tmp124,
	adds	r3, r2, r3	@ tmp126, tmp116, tmp125
	ldr	r0, [r3, #8]	@ _5, MEM[(struct BaseConvoEntry *)&BaseConvoTable][_2][_4].event
@ CBaseConvos/BaseConvos.c:266: 		StartMapEventEngine(&CallBaseConvoEvents,2);
	movs	r1, #2	@,
	ldr	r3, .L92+8	@ tmp131,
@ CBaseConvos/BaseConvos.c:264: 	if ( entry->event == NULL )
	cmp	r0, #0	@ _5,
	bne	.L90		@,
@ CBaseConvos/BaseConvos.c:266: 		StartMapEventEngine(&CallBaseConvoEvents,2);
	ldr	r0, .L92+12	@,
.L90:
@ CBaseConvos/BaseConvos.c:270: 		StartMapEventEngine(entry->event,2);
	bl	.L9		@
@ CBaseConvos/BaseConvos.c:272: }
	@ sp needed	@
	pop	{r4}
	pop	{r0}
	bx	r0
.L93:
	.align	2
.L92:
	.word	gChapterData
	.word	BaseConvoTable
	.word	StartMapEventEngine
	.word	CallBaseConvoEvents
	.size	CallConversation, .-CallConversation
	.align	1
	.global	CheckToEnd
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	CheckToEnd, %function
CheckToEnd:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ CBaseConvos/BaseConvos.c:276: 	if ( !proc->wasBPressed )
	adds	r0, r0, #42	@ tmp117,
@ CBaseConvos/BaseConvos.c:276: 	if ( !proc->wasBPressed )
	ldrb	r3, [r0]	@ tmp118,
	cmp	r3, #0	@ tmp118,
	bne	.L95		@,
@ CBaseConvos/BaseConvos.c:279: 		return !gMemorySlot[0xB]; // Keep the proc running if the event's aren't finished running.
	ldr	r3, .L97	@ tmp119,
@ CBaseConvos/BaseConvos.c:279: 		return !gMemorySlot[0xB]; // Keep the proc running if the event's aren't finished running.
	ldr	r0, [r3, #44]	@ gMemorySlot, gMemorySlot
	rsbs	r3, r0, #0	@ tmp123, gMemorySlot
	adcs	r0, r0, r3	@ <retval>, gMemorySlot, tmp123
.L94:
@ CBaseConvos/BaseConvos.c:286: }
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L95:
@ CBaseConvos/BaseConvos.c:284: 		return IsFadeActive(); // If the fade is still active, keep the proc running.
	ldr	r3, .L97+4	@ tmp124,
	bl	.L9		@
	b	.L94		@
.L98:
	.align	2
.L97:
	.word	gMemorySlot
	.word	IsFadeActive
	.size	CheckToEnd, .-CheckToEnd
	.align	1
	.global	BaseConvoProcDestructor
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	BaseConvoProcDestructor, %function
BaseConvoProcDestructor:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
@ CBaseConvos/BaseConvos.c:290: 	*(char*)(0x0203EFC0) = 0;
	movs	r2, #0	@ tmp112,
	ldr	r3, .L100	@ tmp111,
@ CBaseConvos/BaseConvos.c:289: {
	push	{r4, lr}	@
@ CBaseConvos/BaseConvos.c:290: 	*(char*)(0x0203EFC0) = 0;
	strb	r2, [r3]	@ tmp112, MEM[(char *)33812416B]
@ CBaseConvos/BaseConvos.c:292: 	proc->prepThemeThing = 1;
	movs	r3, r0	@ tmp116, proc
	adds	r2, r2, #1	@ tmp117,
	adds	r3, r3, #66	@ tmp116,
	strb	r2, [r3]	@ tmp117, proc_3(D)->prepThemeThing
@ CBaseConvos/BaseConvos.c:293: 	ReturnToPrepScreenTheme((Proc*)proc);
	ldr	r3, .L100+4	@ tmp119,
	bl	.L9		@
@ CBaseConvos/BaseConvos.c:294: }
	@ sp needed	@
	pop	{r4}
	pop	{r0}
	bx	r0
.L101:
	.align	2
.L100:
	.word	33812416
	.word	ReturnToPrepScreenTheme
	.size	BaseConvoProcDestructor, .-BaseConvoProcDestructor
	.ident	"GCC: (devkitARM release 53) 9.1.0"
	.code 16
	.align	1
.L9:
	bx	r3
.L45:
	bx	r4
.L44:
	bx	r5
