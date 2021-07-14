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
@ SkillsDebug.c:256: }
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
@ SkillsDebug.c:355:     EndFaceById(0);
	movs	r0, #0	@,
@ SkillsDebug.c:356: }
	@ sp needed	@
@ SkillsDebug.c:355:     EndFaceById(0);
	ldr	r3, .L3	@ tmp114,
	bl	.L5		@
@ SkillsDebug.c:356: }
	pop	{r4}
	pop	{r0}
	bx	r0
.L4:
	.align	2
.L3:
	.word	EndFaceById
	.size	SkillDebugMenuEnd, .-SkillDebugMenuEnd
	.section	.rodata.str1.1,"aMS",%progbits,1
.LC3:
	.ascii	" Set\000"
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
@ SkillsDebug.c:272:     struct SkillDebugProc* const proc = (void*) menu->parent;
	ldr	r6, [r0, #20]	@ proc, menu_16(D)->parent
@ SkillsDebug.c:274:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldrh	r4, [r1, #44]	@ tmp135,
	ldrh	r0, [r1, #42]	@ tmp137,
@ SkillsDebug.c:276:     Text_Clear(&command->text);
	adds	r1, r1, #52	@ command,
	movs	r5, r1	@ _9, command
@ SkillsDebug.c:274:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r4, r4, #5	@ tmp136, tmp135,
	adds	r4, r4, r0	@ tmp138, tmp136, tmp137
@ SkillsDebug.c:274:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldr	r0, .L11	@ tmp140,
@ SkillsDebug.c:274:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r4, r4, #1	@ tmp139, tmp138,
@ SkillsDebug.c:276:     Text_Clear(&command->text);
	ldr	r3, .L11+4	@ tmp141,
@ SkillsDebug.c:274:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	adds	r4, r4, r0	@ out, tmp139, tmp140
@ SkillsDebug.c:276:     Text_Clear(&command->text);
	movs	r0, r1	@, _9
	bl	.L5		@
@ SkillsDebug.c:278:     Text_DrawString(&command->text, " Set");
	movs	r0, r5	@, _9
	ldr	r1, .L11+8	@,
	ldr	r7, .L11+12	@ tmp143,
	bl	.L13		@
@ SkillsDebug.c:280:     Text_SetXCursor(&command->text, 42);
	movs	r1, #42	@,
	ldr	r3, .L11+16	@ tmp144,
	movs	r0, r5	@, _9
	bl	.L5		@
@ SkillsDebug.c:281:     Text_SetColorId(&command->text, TEXT_COLOR_BLUE);
	movs	r1, #2	@,
	ldr	r3, .L11+20	@ tmp145,
	movs	r0, r5	@, _9
	bl	.L5		@
@ SkillsDebug.c:66:     char* desc = GetStringFromIndex(SkillDescTable[skillId]);
	ldr	r3, [r6, #56]	@ tmp166, proc_17->skillReplacement
@ SkillsDebug.c:66:     char* desc = GetStringFromIndex(SkillDescTable[skillId]);
	ldr	r2, .L11+24	@ tmp146,
@ SkillsDebug.c:66:     char* desc = GetStringFromIndex(SkillDescTable[skillId]);
	lsls	r3, r3, #1	@ tmp148, tmp166,
@ SkillsDebug.c:66:     char* desc = GetStringFromIndex(SkillDescTable[skillId]);
	ldrh	r0, [r3, r2]	@ tmp149, SkillDescTable
	ldr	r3, .L11+28	@ tmp150,
	bl	.L5		@
	movs	r1, r0	@ desc, tmp163
@ SkillsDebug.c:68:     for (char* it = desc; *it; ++it)
	movs	r3, r0	@ it, desc
.L7:
@ SkillsDebug.c:68:     for (char* it = desc; *it; ++it)
	ldrb	r2, [r3]	@ _31, MEM[base: it_33, offset: 0B]
@ SkillsDebug.c:68:     for (char* it = desc; *it; ++it)
	cmp	r2, #0	@ _31,
	beq	.L9		@,
@ SkillsDebug.c:70:         if (*it == ':')
	cmp	r2, #58	@ _31,
	bne	.L8		@,
@ SkillsDebug.c:72:             *it = 0;
	movs	r2, #0	@ tmp151,
	strb	r2, [r3]	@ tmp151, *it_33
.L9:
@ SkillsDebug.c:289: }
	@ sp needed	@
@ SkillsDebug.c:282:     Text_DrawString(&command->text, GetSkillName(proc->skillReplacement));
	movs	r0, r5	@, _9
	bl	.L13		@
@ SkillsDebug.c:284:     Text_Display(&command->text, out);
	movs	r0, r5	@, _9
	movs	r1, r4	@, out
	ldr	r3, .L11+32	@ tmp154,
	bl	.L5		@
@ SkillsDebug.c:286:     DrawIcon(
	movs	r2, #128	@,
	ldr	r1, [r6, #56]	@ proc_17->skillReplacement, proc_17->skillReplacement
	adds	r1, r1, #1	@ tmp156,
	ldr	r3, .L11+36	@ tmp159,
	adds	r1, r1, #255	@ tmp156,
	adds	r0, r4, #6	@ tmp158, out,
	lsls	r2, r2, #7	@,,
	bl	.L5		@
@ SkillsDebug.c:289: }
	pop	{r3, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L8:
@ SkillsDebug.c:68:     for (char* it = desc; *it; ++it)
	adds	r3, r3, #1	@ it,
	b	.L7		@
.L12:
	.align	2
.L11:
	.word	gBg0MapBuffer
	.word	Text_Clear
	.word	.LC3
	.word	Text_DrawString
	.word	Text_SetXCursor
	.word	Text_SetColorId
	.word	SkillDescTable
	.word	GetStringFromIndex
	.word	Text_Display
	.word	DrawIcon
	.size	ReplaceSkillCommandDraw, .-ReplaceSkillCommandDraw
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	IsSkill, %function
IsSkill:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
@ SkillsDebug.c:24:     if (skillId == 0)
	cmp	r0, #0	@ skillId,
	beq	.L15		@,
@ SkillsDebug.c:27:     if (skillId == 255)
	cmp	r0, #255	@ skillId,
	beq	.L16		@,
@ SkillsDebug.c:30:     return !!SkillDescTable[skillId];
	ldr	r3, .L20	@ tmp117,
@ SkillsDebug.c:30:     return !!SkillDescTable[skillId];
	lsls	r0, r0, #1	@ tmp118, skillId,
@ SkillsDebug.c:30:     return !!SkillDescTable[skillId];
	ldrh	r0, [r0, r3]	@ tmp120, SkillDescTable
	subs	r3, r0, #1	@ tmp122, tmp120
	sbcs	r0, r0, r3	@ skillId, tmp120, tmp122
.L15:
@ SkillsDebug.c:31: }
	@ sp needed	@
	bx	lr
.L16:
@ SkillsDebug.c:25:         return FALSE;
	movs	r0, #0	@ skillId,
	b	.L15		@
.L21:
	.align	2
.L20:
	.word	SkillDescTable
	.size	IsSkill, .-IsSkill
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	ReplaceSkillCommandIdle, %function
ReplaceSkillCommandIdle:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r0, r1, r2, r4, r5, r6, r7, lr}	@
@ SkillsDebug.c:297:     if (gKeyState.repeatedKeys & KEY_DPAD_LEFT)
	ldr	r3, .L40	@ tmp203,
@ SkillsDebug.c:292: {
	str	r1, [sp, #4]	@ tmp196, %sfp
@ SkillsDebug.c:297:     if (gKeyState.repeatedKeys & KEY_DPAD_LEFT)
	ldrh	r3, [r3, #6]	@ tmp142,
@ SkillsDebug.c:292: {
	movs	r7, r0	@ menu, tmp195
@ SkillsDebug.c:295:     int updated = FALSE;
	movs	r4, #0	@ updated,
@ SkillsDebug.c:293:     struct SkillDebugProc* const proc = (void*) menu->parent;
	ldr	r6, [r0, #20]	@ proc, menu_31(D)->parent
@ SkillsDebug.c:297:     if (gKeyState.repeatedKeys & KEY_DPAD_LEFT)
	lsls	r3, r3, #26	@ tmp199, tmp142,
	bpl	.L23		@,
@ SkillsDebug.c:299:         unsigned id = proc->skillReplacement;
	ldr	r4, [r6, #56]	@ id, proc_32->skillReplacement
	movs	r5, r4	@ id, id
.L24:
@ SkillsDebug.c:303:             id = (id - 1) % 0x100;
	movs	r3, #255	@ tmp204,
@ SkillsDebug.c:303:             id = (id - 1) % 0x100;
	subs	r5, r5, #1	@ _3,
@ SkillsDebug.c:303:             id = (id - 1) % 0x100;
	ands	r5, r3	@ id, tmp204
@ SkillsDebug.c:305:         while (!IsSkill(id));
	movs	r0, r5	@, id
	bl	IsSkill		@
@ SkillsDebug.c:305:         while (!IsSkill(id));
	cmp	r0, #0	@ tmp197,
	beq	.L24		@,
@ SkillsDebug.c:307:         updated = (proc->skillReplacement != id);
	subs	r4, r4, r5	@ tmp151, id, id
@ SkillsDebug.c:307:         updated = (proc->skillReplacement != id);
	subs	r3, r4, #1	@ tmp152, tmp151
	sbcs	r4, r4, r3	@ updated, tmp151, tmp152
@ SkillsDebug.c:310:         PlaySfx(0x6B);
	ldr	r3, .L40+4	@ tmp153,
	adds	r3, r3, #65	@ tmp156,
	ldrb	r3, [r3]	@ gChapterData, gChapterData
@ SkillsDebug.c:308:         proc->skillReplacement = id;
	str	r5, [r6, #56]	@ id, proc_32->skillReplacement
@ SkillsDebug.c:310:         PlaySfx(0x6B);
	lsls	r3, r3, #30	@ tmp200, gChapterData,
	bmi	.L23		@,
@ SkillsDebug.c:310:         PlaySfx(0x6B);
	movs	r0, #107	@,
	ldr	r3, .L40+8	@ tmp164,
	bl	.L5		@
.L23:
@ SkillsDebug.c:313:     if (gKeyState.repeatedKeys & KEY_DPAD_RIGHT)
	ldr	r3, .L40	@ tmp205,
	ldrh	r3, [r3, #6]	@ tmp167,
	lsls	r3, r3, #27	@ tmp201, tmp167,
	bpl	.L25		@,
@ SkillsDebug.c:315:         unsigned id = proc->skillReplacement;
	ldr	r4, [r6, #56]	@ id, proc_32->skillReplacement
	movs	r5, r4	@ id, id
.L26:
@ SkillsDebug.c:319:             id = (id + 1) % 0x100;
	movs	r3, #255	@ tmp206,
@ SkillsDebug.c:319:             id = (id + 1) % 0x100;
	adds	r5, r5, #1	@ _14,
@ SkillsDebug.c:319:             id = (id + 1) % 0x100;
	ands	r5, r3	@ id, tmp206
@ SkillsDebug.c:321:         while (!IsSkill(id));
	movs	r0, r5	@, id
	bl	IsSkill		@
@ SkillsDebug.c:321:         while (!IsSkill(id));
	cmp	r0, #0	@ tmp198,
	beq	.L26		@,
@ SkillsDebug.c:323:         updated = (proc->skillReplacement != id);
	subs	r4, r4, r5	@ tmp176, id, id
@ SkillsDebug.c:323:         updated = (proc->skillReplacement != id);
	subs	r3, r4, #1	@ tmp177, tmp176
	sbcs	r4, r4, r3	@ updated, tmp176, tmp177
@ SkillsDebug.c:326:         PlaySfx(0x6B);
	ldr	r3, .L40+4	@ tmp178,
	adds	r3, r3, #65	@ tmp181,
	ldrb	r3, [r3]	@ gChapterData, gChapterData
@ SkillsDebug.c:324:         proc->skillReplacement = id;
	str	r5, [r6, #56]	@ id, proc_32->skillReplacement
@ SkillsDebug.c:326:         PlaySfx(0x6B);
	lsls	r3, r3, #30	@ tmp202, gChapterData,
	bmi	.L25		@,
@ SkillsDebug.c:326:         PlaySfx(0x6B);
	movs	r0, #107	@,
	ldr	r3, .L40+8	@ tmp189,
	bl	.L5		@
.L25:
@ SkillsDebug.c:329:     if (updated)
	cmp	r4, #0	@ updated,
	beq	.L27		@,
@ SkillsDebug.c:331:         ClearIcons();
	ldr	r3, .L40+12	@ tmp190,
	bl	.L5		@
@ SkillsDebug.c:333:         ReplaceSkillCommandDraw(menu, command);
	movs	r0, r7	@, menu
	ldr	r1, [sp, #4]	@, %sfp
	bl	ReplaceSkillCommandDraw		@
@ SkillsDebug.c:334:         EnableBgSyncByMask(BG0_SYNC_BIT);
	ldr	r3, .L40+16	@ tmp191,
	movs	r0, #1	@,
	bl	.L5		@
@ SkillsDebug.c:337:         proc->skillsUpdated = TRUE;
	movs	r3, #1	@ tmp192,
	str	r3, [r6, #48]	@ tmp192, proc_32->skillsUpdated
.L27:
@ SkillsDebug.c:341: }
	@ sp needed	@
	movs	r0, #0	@,
	pop	{r1, r2, r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L41:
	.align	2
.L40:
	.word	gKeyState
	.word	gChapterData
	.word	m4aSongNumStart
	.word	ClearIcons
	.word	EnableBgSyncByMask
	.size	ReplaceSkillCommandIdle, .-ReplaceSkillCommandIdle
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	UnitGetSkillList.isra.0, %function
UnitGetSkillList.isra.0:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
@ SkillsDebug.c:18:     return gBWLDataStorage + 0x10 * (unit->pCharacterData->number - 1) + 1;
	ldrb	r0, [r0, #4]	@ tmp122,
@ SkillsDebug.c:19: }
	@ sp needed	@
@ SkillsDebug.c:18:     return gBWLDataStorage + 0x10 * (unit->pCharacterData->number - 1) + 1;
	ldr	r3, .L43	@ tmp126,
@ SkillsDebug.c:18:     return gBWLDataStorage + 0x10 * (unit->pCharacterData->number - 1) + 1;
	lsls	r0, r0, #4	@ tmp124, tmp122,
@ SkillsDebug.c:18:     return gBWLDataStorage + 0x10 * (unit->pCharacterData->number - 1) + 1;
	subs	r0, r0, #15	@ tmp125,
	adds	r0, r0, r3	@ tmp121, tmp125, tmp126
@ SkillsDebug.c:19: }
	bx	lr
.L44:
	.align	2
.L43:
	.word	gBWLDataStorage
	.size	UnitGetSkillList.isra.0, .-UnitGetSkillList.isra.0
	.section	.rodata.str1.1
.LC23:
	.ascii	" No Skills\000"
	.text
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	SkillListCommandDraw, %function
SkillListCommandDraw:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r0, r1, r2, r4, r5, r6, r7, lr}	@
@ SkillsDebug.c:202: {
	movs	r5, r1	@ command, tmp168
@ SkillsDebug.c:203:     struct SkillDebugProc* const proc = (void*) menu->parent;
	ldr	r7, [r0, #20]	@ proc, menu_26(D)->parent
@ SkillsDebug.c:205:     u8* const skills = UnitGetSkillList(proc->unit);
	ldr	r3, [r7, #44]	@ proc_27->unit, proc_27->unit
@ SkillsDebug.c:209:     Text_Clear(&command->text);
	movs	r6, r5	@ _10, command
@ SkillsDebug.c:205:     u8* const skills = UnitGetSkillList(proc->unit);
	ldr	r0, [r3]	@, MEM[(const struct CharacterData * *)_1]
	bl	UnitGetSkillList.isra.0		@
@ SkillsDebug.c:207:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldrh	r4, [r5, #44]	@ tmp146,
	ldrh	r3, [r5, #42]	@ tmp148,
	lsls	r4, r4, #5	@ tmp147, tmp146,
	adds	r4, r4, r3	@ tmp149, tmp147, tmp148
@ SkillsDebug.c:207:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	ldr	r3, .L58	@ tmp151,
@ SkillsDebug.c:207:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	lsls	r4, r4, #1	@ tmp150, tmp149,
@ SkillsDebug.c:209:     Text_Clear(&command->text);
	adds	r6, r6, #52	@ _10,
@ SkillsDebug.c:205:     u8* const skills = UnitGetSkillList(proc->unit);
	str	r0, [sp, #4]	@ tmp169, %sfp
@ SkillsDebug.c:207:     u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	adds	r4, r4, r3	@ out, tmp150, tmp151
@ SkillsDebug.c:209:     Text_Clear(&command->text);
	movs	r0, r6	@, _10
	ldr	r3, .L58+4	@ tmp152,
	bl	.L5		@
	ldr	r3, [r7, #44]	@ proc_27->unit, proc_27->unit
	ldr	r0, [r3]	@, MEM[(const struct CharacterData * *)_11]
	bl	UnitGetSkillList.isra.0		@
@ SkillsDebug.c:38:     int count = 0;
	movs	r3, #0	@ count,
.L46:
@ SkillsDebug.c:40:     for (int i = 0; i < UNIT_SKILL_COUNT && skills[i]; ++i)
	ldrb	r2, [r0, r3]	@ MEM[base: skills_42, index: _41, offset: 0B], MEM[base: skills_42, index: _41, offset: 0B]
	cmp	r2, #0	@ MEM[base: skills_42, index: _41, offset: 0B],
	bne	.L48		@,
@ SkillsDebug.c:211:     if (UnitCountSkills(proc->unit) == 0)
	cmp	r3, #0	@ count,
	bne	.L47		@,
@ SkillsDebug.c:213:         Text_SetColorId(&command->text, TEXT_COLOR_GRAY);
	movs	r1, #1	@,
	movs	r0, r6	@, _10
	ldr	r3, .L58+8	@ tmp155,
	bl	.L5		@
@ SkillsDebug.c:214:         Text_DrawString(&command->text, " No Skills");
	movs	r0, r6	@, _10
	ldr	r1, .L58+12	@,
	ldr	r3, .L58+16	@ tmp157,
	bl	.L5		@
	b	.L47		@
.L48:
@ SkillsDebug.c:41:         count++;
	adds	r3, r3, #1	@ count,
@ SkillsDebug.c:40:     for (int i = 0; i < UNIT_SKILL_COUNT && skills[i]; ++i)
	cmp	r3, #4	@ count,
	bne	.L46		@,
.L47:
@ SkillsDebug.c:217:     Text_Display(&command->text, out);
	movs	r0, r6	@, _10
	movs	r1, r4	@, out
	ldr	r3, .L58+20	@ tmp158,
	bl	.L5		@
@ SkillsDebug.c:219:     LoadIconPalettes(4);
	movs	r0, #4	@,
	ldr	r3, .L58+24	@ tmp159,
	bl	.L5		@
@ SkillsDebug.c:221:     for (int i = 0; i < UNIT_SKILL_COUNT; ++i)
	movs	r6, #0	@ i,
.L50:
@ SkillsDebug.c:223:         if (IsSkill(skills[i]))
	ldr	r3, [sp, #4]	@ skills, %sfp
	ldrb	r7, [r3, r6]	@ _16, MEM[base: skills_28, index: _43, offset: 0B]
	movs	r0, r7	@, _16
	bl	IsSkill		@
@ SkillsDebug.c:223:         if (IsSkill(skills[i]))
	cmp	r0, #0	@ tmp171,
	beq	.L49		@,
@ SkillsDebug.c:224:             DrawIcon(out + TILEMAP_INDEX(2*i, 0), SKILL_ICON(skills[i]), TILEREF(0, 4));
	movs	r2, #128	@,
	adds	r1, r7, #1	@ tmp161, _16,
	lsls	r0, r6, #2	@ tmp162, i,
	ldr	r3, .L58+28	@ tmp164,
	adds	r1, r1, #255	@ tmp161,
	adds	r0, r4, r0	@ tmp163, out, tmp162
	lsls	r2, r2, #7	@,,
	bl	.L5		@
.L49:
@ SkillsDebug.c:221:     for (int i = 0; i < UNIT_SKILL_COUNT; ++i)
	adds	r6, r6, #1	@ i,
@ SkillsDebug.c:221:     for (int i = 0; i < UNIT_SKILL_COUNT; ++i)
	cmp	r6, #4	@ i,
	bne	.L50		@,
@ SkillsDebug.c:228: }
	@ sp needed	@
@ SkillsDebug.c:227:     command->onCycle = (void*) SkillListCommandDrawIdle;
	ldr	r3, .L58+32	@ tmp165,
	str	r3, [r5, #12]	@ tmp165, command_29(D)->onCycle
@ SkillsDebug.c:228: }
	pop	{r0, r1, r2, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L59:
	.align	2
.L58:
	.word	gBg0MapBuffer
	.word	Text_Clear
	.word	Text_SetColorId
	.word	.LC23
	.word	Text_DrawString
	.word	Text_Display
	.word	LoadIconPalettes
	.word	DrawIcon
	.word	SkillListCommandDrawIdle
	.size	SkillListCommandDraw, .-SkillListCommandDraw
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	SkillListCommandDrawIdle, %function
SkillListCommandDrawIdle:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r0, r1, r4, r5, r6, lr}	@
@ SkillsDebug.c:167: {
	movs	r5, r0	@ command, tmp213
@ SkillsDebug.c:168:     struct MenuProc* const menu = (void*) command->parent;
	ldr	r0, [r0, #20]	@ menu, command_33(D)->parent
@ SkillsDebug.c:169:     struct SkillDebugProc* const proc = (void*) menu->parent;
	ldr	r4, [r0, #20]	@ proc, menu_34->parent
@ SkillsDebug.c:171:     if (proc->skillsUpdated)
	ldr	r3, [r4, #48]	@ tmp221, proc_35->skillsUpdated
	cmp	r3, #0	@ tmp221,
	beq	.L61		@,
@ SkillsDebug.c:173:         SkillListCommandDraw(menu, command);
	movs	r1, r5	@, command
	bl	SkillListCommandDraw		@
@ SkillsDebug.c:174:         EnableBgSyncByMask(BG0_SYNC_BIT);
	ldr	r3, .L79	@ tmp146,
	movs	r0, #1	@,
	bl	.L5		@
@ SkillsDebug.c:176:         proc->skillsUpdated = FALSE;
	movs	r3, #0	@ tmp147,
	str	r3, [r4, #48]	@ tmp147, proc_35->skillsUpdated
.L61:
@ SkillsDebug.c:179:     if (gKeyState.repeatedKeys & KEY_BUTTON_L)
	ldr	r6, .L79+4	@ tmp148,
@ SkillsDebug.c:179:     if (gKeyState.repeatedKeys & KEY_BUTTON_L)
	ldrh	r3, [r6, #6]	@ tmp150,
	lsls	r3, r3, #22	@ tmp217, tmp150,
	bpl	.L63		@,
@ SkillsDebug.c:181:         if (proc->skillSelected != 0)
	ldr	r3, [r4, #52]	@ pretmp_74, proc_35->skillSelected
@ SkillsDebug.c:181:         if (proc->skillSelected != 0)
	cmp	r3, #0	@ pretmp_74,
	beq	.L64		@,
@ SkillsDebug.c:182:             proc->skillSelected--;
	subs	r3, r3, #1	@ tmp156,
	str	r3, [r4, #52]	@ tmp156, proc_35->skillSelected
.L64:
@ SkillsDebug.c:184:         PlaySfx(0x6B);
	ldr	r3, .L79+8	@ tmp157,
	adds	r3, r3, #65	@ tmp160,
	ldrb	r3, [r3]	@ gChapterData, gChapterData
	lsls	r3, r3, #30	@ tmp218, gChapterData,
	bmi	.L63		@,
@ SkillsDebug.c:184:         PlaySfx(0x6B);
	movs	r0, #107	@,
	ldr	r3, .L79+12	@ tmp168,
	bl	.L5		@
.L63:
@ SkillsDebug.c:187:     if (gKeyState.repeatedKeys & KEY_BUTTON_R)
	ldrh	r3, [r6, #6]	@ tmp171,
	lsls	r3, r3, #23	@ tmp219, tmp171,
	bpl	.L67		@,
@ SkillsDebug.c:189:         if (proc->skillSelected + 1 < UNIT_SKILL_COUNT && UnitGetSkillList(proc->unit)[proc->skillSelected] != 0)
	ldr	r6, [r4, #52]	@ pretmp_75, proc_35->skillSelected
@ SkillsDebug.c:189:         if (proc->skillSelected + 1 < UNIT_SKILL_COUNT && UnitGetSkillList(proc->unit)[proc->skillSelected] != 0)
	cmp	r6, #2	@ pretmp_75,
	bgt	.L68		@,
@ SkillsDebug.c:189:         if (proc->skillSelected + 1 < UNIT_SKILL_COUNT && UnitGetSkillList(proc->unit)[proc->skillSelected] != 0)
	ldr	r3, [r4, #44]	@ proc_35->unit, proc_35->unit
	ldr	r0, [r3]	@, MEM[(const struct CharacterData * *)_9]
	bl	UnitGetSkillList.isra.0		@
@ SkillsDebug.c:189:         if (proc->skillSelected + 1 < UNIT_SKILL_COUNT && UnitGetSkillList(proc->unit)[proc->skillSelected] != 0)
	ldrb	r3, [r0, r6]	@ *_12, *_12
	cmp	r3, #0	@ *_12,
	beq	.L68		@,
@ SkillsDebug.c:190:             proc->skillSelected++;
	adds	r6, r6, #1	@ tmp179,
	str	r6, [r4, #52]	@ tmp179, proc_35->skillSelected
.L68:
@ SkillsDebug.c:192:         PlaySfx(0x6B);
	ldr	r3, .L79+8	@ tmp180,
	adds	r3, r3, #65	@ tmp183,
	ldrb	r3, [r3]	@ gChapterData, gChapterData
	lsls	r3, r3, #30	@ tmp220, gChapterData,
	bmi	.L67		@,
@ SkillsDebug.c:192:         PlaySfx(0x6B);
	movs	r0, #107	@,
	ldr	r3, .L79+12	@ tmp191,
	bl	.L5		@
.L67:
@ SkillsDebug.c:199: }
	@ sp needed	@
@ SkillsDebug.c:195:     ObjInsertSafe(0,
	ldrh	r2, [r5, #44]	@ tmp194,
	ldr	r3, .L79+16	@ tmp222,
@ SkillsDebug.c:196:         command->xDrawTile*8 + 16*proc->skillSelected,
	ldr	r1, [r4, #52]	@ proc_35->skillSelected, proc_35->skillSelected
@ SkillsDebug.c:195:     ObjInsertSafe(0,
	lsls	r2, r2, #19	@ tmp197, tmp194,
	adds	r2, r2, r3	@ tmp199, tmp197, tmp222
@ SkillsDebug.c:196:         command->xDrawTile*8 + 16*proc->skillSelected,
	ldrh	r3, [r5, #42]	@ tmp202,
@ SkillsDebug.c:196:         command->xDrawTile*8 + 16*proc->skillSelected,
	lsls	r1, r1, #1	@ tmp200, proc_35->skillSelected,
	adds	r1, r1, r3	@ tmp203, tmp200, tmp202
@ SkillsDebug.c:195:     ObjInsertSafe(0,
	movs	r3, #6	@ tmp208,
	lsls	r1, r1, #19	@ tmp207, tmp203,
	str	r3, [sp]	@ tmp208,
	movs	r0, #0	@,
	ldr	r3, .L79+20	@,
	ldr	r4, .L79+24	@ tmp209,
	lsrs	r2, r2, #16	@ tmp198, tmp199,
	lsrs	r1, r1, #16	@ tmp206, tmp207,
	bl	.L81		@
@ SkillsDebug.c:199: }
	pop	{r0, r1, r4, r5, r6}
	pop	{r0}
	bx	r0
.L80:
	.align	2
.L79:
	.word	EnableBgSyncByMask
	.word	gKeyState
	.word	gChapterData
	.word	m4aSongNumStart
	.word	-786432
	.word	gObj_16x16
	.word	ObjInsertSafe
	.size	SkillListCommandDrawIdle, .-SkillListCommandDrawIdle
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	SkillListCommandIdle, %function
SkillListCommandIdle:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ SkillsDebug.c:234:     if (gKeyState.repeatedKeys & KEY_DPAD_LEFT)
	ldr	r5, .L97	@ tmp135,
@ SkillsDebug.c:234:     if (gKeyState.repeatedKeys & KEY_DPAD_LEFT)
	ldrh	r3, [r5, #6]	@ tmp137,
@ SkillsDebug.c:232:     struct SkillDebugProc* const proc = (void*) menu->parent;
	ldr	r4, [r0, #20]	@ proc, menu_21(D)->parent
@ SkillsDebug.c:234:     if (gKeyState.repeatedKeys & KEY_DPAD_LEFT)
	lsls	r3, r3, #26	@ tmp187, tmp137,
	bpl	.L84		@,
@ SkillsDebug.c:236:         if (proc->skillSelected != 0)
	ldr	r3, [r4, #52]	@ _2, proc_22->skillSelected
@ SkillsDebug.c:236:         if (proc->skillSelected != 0)
	cmp	r3, #0	@ _2,
	beq	.L85		@,
@ SkillsDebug.c:237:             proc->skillSelected--;
	subs	r3, r3, #1	@ tmp143,
	str	r3, [r4, #52]	@ tmp143, proc_22->skillSelected
.L85:
@ SkillsDebug.c:239:         PlaySfx(0x6B);
	ldr	r3, .L97+4	@ tmp144,
	adds	r3, r3, #65	@ tmp147,
	ldrb	r3, [r3]	@ gChapterData, gChapterData
	lsls	r3, r3, #30	@ tmp188, gChapterData,
	bmi	.L84		@,
@ SkillsDebug.c:239:         PlaySfx(0x6B);
	movs	r0, #107	@,
	ldr	r3, .L97+8	@ tmp155,
	bl	.L5		@
.L84:
@ SkillsDebug.c:242:     if (gKeyState.repeatedKeys & KEY_DPAD_RIGHT)
	ldrh	r3, [r5, #6]	@ tmp158,
	lsls	r3, r3, #27	@ tmp189, tmp158,
	bpl	.L88		@,
@ SkillsDebug.c:244:         if (proc->skillSelected + 1 < UNIT_SKILL_COUNT && UnitGetSkillList(proc->unit)[proc->skillSelected] != 0)
	ldr	r5, [r4, #52]	@ _7, proc_22->skillSelected
@ SkillsDebug.c:244:         if (proc->skillSelected + 1 < UNIT_SKILL_COUNT && UnitGetSkillList(proc->unit)[proc->skillSelected] != 0)
	cmp	r5, #2	@ _7,
	bgt	.L89		@,
@ SkillsDebug.c:244:         if (proc->skillSelected + 1 < UNIT_SKILL_COUNT && UnitGetSkillList(proc->unit)[proc->skillSelected] != 0)
	ldr	r3, [r4, #44]	@ proc_22->unit, proc_22->unit
	ldr	r0, [r3]	@, MEM[(const struct CharacterData * *)_8]
	bl	UnitGetSkillList.isra.0		@
@ SkillsDebug.c:244:         if (proc->skillSelected + 1 < UNIT_SKILL_COUNT && UnitGetSkillList(proc->unit)[proc->skillSelected] != 0)
	ldrb	r3, [r0, r5]	@ *_11, *_11
	cmp	r3, #0	@ *_11,
	beq	.L89		@,
@ SkillsDebug.c:245:             proc->skillSelected++;
	adds	r5, r5, #1	@ tmp166,
	str	r5, [r4, #52]	@ tmp166, proc_22->skillSelected
.L89:
@ SkillsDebug.c:247:         PlaySfx(0x6B);
	ldr	r3, .L97+4	@ tmp167,
	adds	r3, r3, #65	@ tmp170,
	ldrb	r3, [r3]	@ gChapterData, gChapterData
	lsls	r3, r3, #30	@ tmp190, gChapterData,
	bmi	.L88		@,
@ SkillsDebug.c:247:         PlaySfx(0x6B);
	movs	r0, #107	@,
	ldr	r3, .L97+8	@ tmp178,
	bl	.L5		@
.L88:
@ SkillsDebug.c:251: }
	@ sp needed	@
	movs	r0, #0	@,
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L98:
	.align	2
.L97:
	.word	gKeyState
	.word	gChapterData
	.word	m4aSongNumStart
	.size	SkillListCommandIdle, .-SkillListCommandIdle
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	ReplaceSkillCommandSelect, %function
ReplaceSkillCommandSelect:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ SkillsDebug.c:345:     struct SkillDebugProc* const proc = (void*) menu->parent;
	ldr	r4, [r0, #20]	@ proc, menu_9(D)->parent
@ SkillsDebug.c:351: }
	@ sp needed	@
@ SkillsDebug.c:347:     UnitGetSkillList(proc->unit)[proc->skillSelected] = proc->skillReplacement;
	ldr	r3, [r4, #44]	@ proc_10->unit, proc_10->unit
	ldr	r0, [r3]	@, MEM[(const struct CharacterData * *)_2]
	bl	UnitGetSkillList.isra.0		@
@ SkillsDebug.c:347:     UnitGetSkillList(proc->unit)[proc->skillSelected] = proc->skillReplacement;
	ldr	r3, [r4, #56]	@ tmp133, proc_10->skillReplacement
	ldr	r2, [r4, #52]	@ tmp135, proc_10->skillSelected
	strb	r3, [r0, r2]	@ tmp134, *_6
@ SkillsDebug.c:348:     proc->skillsUpdated = TRUE;
	movs	r3, #1	@ tmp129,
@ SkillsDebug.c:351: }
	movs	r0, #4	@,
@ SkillsDebug.c:348:     proc->skillsUpdated = TRUE;
	str	r3, [r4, #48]	@ tmp129, proc_10->skillsUpdated
@ SkillsDebug.c:351: }
	pop	{r4}
	pop	{r1}
	bx	r1
	.size	ReplaceSkillCommandSelect, .-ReplaceSkillCommandSelect
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	RemoveSkillCommandSelect, %function
RemoveSkillCommandSelect:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ SkillsDebug.c:260:     struct SkillDebugProc* const proc = (void*) menu->parent;
	ldr	r5, [r0, #20]	@ proc, menu_8(D)->parent
@ SkillsDebug.c:262:     UnitGetSkillList(proc->unit)[proc->skillSelected] = 0;
	ldr	r3, [r5, #44]	@ proc_9->unit, proc_9->unit
	ldr	r0, [r3]	@, MEM[(const struct CharacterData * *)_1]
	bl	UnitGetSkillList.isra.0		@
@ SkillsDebug.c:262:     UnitGetSkillList(proc->unit)[proc->skillSelected] = 0;
	movs	r4, #0	@ tmp140,
	ldr	r3, [r5, #52]	@ tmp157, proc_9->skillSelected
	strb	r4, [r0, r3]	@ tmp140, *_5
	ldr	r3, [r5, #44]	@ proc_9->unit, proc_9->unit
	ldr	r0, [r3]	@, MEM[(const struct CharacterData * *)_6]
	bl	UnitGetSkillList.isra.0		@
	movs	r3, r0	@ skills, tmp156
	movs	r2, r0	@ ivtmp.89, skills
	adds	r6, r0, #4	@ _29, skills,
@ SkillsDebug.c:51:     int iIn = 0, iOut = 0;
	movs	r0, r4	@ iOut, tmp140
.L102:
@ SkillsDebug.c:55:         if (skills[iIn])
	ldrb	r1, [r2]	@ _20, MEM[base: _28, offset: 0B]
@ SkillsDebug.c:55:         if (skills[iIn])
	cmp	r1, #0	@ _20,
	beq	.L101		@,
@ SkillsDebug.c:56:             skills[iOut++] = skills[iIn];
	strb	r1, [r3, r0]	@ _20, *_24
@ SkillsDebug.c:56:             skills[iOut++] = skills[iIn];
	adds	r0, r0, #1	@ iOut,
.L101:
@ SkillsDebug.c:53:     for (; iIn < UNIT_SKILL_COUNT; ++iIn)
	adds	r2, r2, #1	@ ivtmp.89,
	cmp	r2, r6	@ ivtmp.89, _29
	bne	.L102		@,
@ SkillsDebug.c:60:         skills[iOut] = 0;
	movs	r2, #0	@ tmp144,
	cmp	r0, #4	@ iOut,
	bgt	.L104		@,
	adds	r2, r2, #4	@ tmp145,
	subs	r2, r2, r0	@ tmp144, tmp145, iOut
.L104:
	movs	r1, #0	@,
@ SkillsDebug.c:268: }
	@ sp needed	@
@ SkillsDebug.c:60:         skills[iOut] = 0;
	adds	r0, r3, r0	@ tmp146, skills, iOut
	ldr	r3, .L109	@ tmp149,
	bl	.L5		@
@ SkillsDebug.c:265:     proc->skillsUpdated = TRUE;
	movs	r3, #1	@ tmp152,
@ SkillsDebug.c:268: }
	movs	r0, #4	@,
@ SkillsDebug.c:265:     proc->skillsUpdated = TRUE;
	str	r3, [r5, #48]	@ tmp152, proc_9->skillsUpdated
@ SkillsDebug.c:268: }
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L110:
	.align	2
.L109:
	.word	memset
	.size	RemoveSkillCommandSelect, .-RemoveSkillCommandSelect
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
	push	{r0, r1, r4, r5, r6, lr}	@
@ SkillsDebug.c:152:     struct SkillDebugProc* proc = (void*) ProcStart(Proc_SkillDebug, ROOT_PROC_3);
	ldr	r5, .L112	@ tmp120,
@ SkillsDebug.c:164: }
	@ sp needed	@
@ SkillsDebug.c:152:     struct SkillDebugProc* proc = (void*) ProcStart(Proc_SkillDebug, ROOT_PROC_3);
	movs	r0, r5	@, tmp120
	movs	r1, #3	@,
	ldr	r3, .L112+4	@ tmp121,
	bl	.L5		@
@ SkillsDebug.c:154:     proc->unit = gActiveUnit;
	ldr	r3, .L112+8	@ tmp122,
	ldr	r3, [r3]	@ tmp136, gActiveUnit
@ SkillsDebug.c:155:     proc->skillsUpdated = FALSE;
	movs	r6, #0	@ tmp124,
@ SkillsDebug.c:154:     proc->unit = gActiveUnit;
	str	r3, [r0, #44]	@ tmp136, proc_6->unit
@ SkillsDebug.c:157:     proc->skillReplacement = 1; // assumes skill #1 is valid
	movs	r3, #1	@ tmp126,
@ SkillsDebug.c:152:     struct SkillDebugProc* proc = (void*) ProcStart(Proc_SkillDebug, ROOT_PROC_3);
	movs	r4, r0	@ proc, tmp134
@ SkillsDebug.c:155:     proc->skillsUpdated = FALSE;
	str	r6, [r0, #48]	@ tmp124, proc_6->skillsUpdated
@ SkillsDebug.c:156:     proc->skillSelected = 0;
	str	r6, [r0, #52]	@ tmp124, proc_6->skillSelected
@ SkillsDebug.c:157:     proc->skillReplacement = 1; // assumes skill #1 is valid
	str	r3, [r0, #56]	@ tmp126, proc_6->skillReplacement
@ SkillsDebug.c:159:     StartMenuChild(&Menu_SkillDebug, (void*) proc);
	movs	r0, r5	@ tmp120, tmp120
	movs	r1, r4	@, proc
	ldr	r3, .L112+12	@ tmp129,
	adds	r0, r0, #32	@ tmp120,
	bl	.L5		@
@ SkillsDebug.c:161:     StartFace(0, GetUnitPortraitId(proc->unit), 72, 16, 3);
	ldr	r0, [r4, #44]	@, proc_6->unit
	ldr	r3, .L112+16	@ tmp130,
	bl	.L5		@
	movs	r3, #3	@ tmp131,
	movs	r1, r0	@ _3, tmp135
	str	r3, [sp]	@ tmp131,
	movs	r0, r6	@, tmp124
	movs	r2, #72	@,
	ldr	r4, .L112+20	@ tmp132,
	adds	r3, r3, #13	@,
	bl	.L81		@
@ SkillsDebug.c:164: }
	movs	r0, #23	@,
	pop	{r1, r2, r4, r5, r6}
	pop	{r1}
	bx	r1
.L113:
	.align	2
.L112:
	.word	.LANCHOR0
	.word	ProcStart
	.word	gActiveUnit
	.word	StartMenuChild
	.word	GetUnitPortraitId
	.word	StartFace
	.size	SkillDebugCommand_OnSelect, .-SkillDebugCommand_OnSelect
	.section	.rodata.str1.1
.LC49:
	.ascii	" Remove Skill\000"
	.section	.rodata
	.align	2
	.set	.LANCHOR0,. + 0
	.type	Proc_SkillDebug, %object
	.size	Proc_SkillDebug, 32
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
	.byte	11
@ h:
	.byte	16
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
	.size	MenuCommands_SkillDebug, 144
MenuCommands_SkillDebug:
@ isAvailable:
	.space	12
	.word	MenuCommandAlwaysUsable
@ onDraw:
	.word	SkillListCommandDraw
@ onEffect:
	.word	SkillListCommandSelect
@ onIdle:
	.word	SkillListCommandIdle
	.space	8
@ rawName:
	.word	.LC49
@ isAvailable:
	.space	8
	.word	MenuCommandAlwaysUsable
@ onEffect:
	.space	4
	.word	RemoveSkillCommandSelect
	.space	12
@ isAvailable:
	.space	12
	.word	MenuCommandAlwaysUsable
@ onDraw:
	.word	ReplaceSkillCommandDraw
@ onEffect:
	.word	ReplaceSkillCommandSelect
@ onIdle:
	.word	ReplaceSkillCommandIdle
	.space	8
	.space	36
	.ident	"GCC: (devkitARM release 54) 10.1.0"
	.text
	.code 16
	.align	1
.L5:
	bx	r3
.L81:
	bx	r4
.L13:
	bx	r7
