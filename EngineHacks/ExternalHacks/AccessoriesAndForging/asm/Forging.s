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
	.file	"Forging.c"
@ GNU C17 (devkitARM release 54) version 10.1.0 (arm-none-eabi)
@	compiled by GNU C version 6.4.0, GMP version 6.0.0, MPFR version 3.1.2, MPC version 1.0.2, isl version none
@ GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
@ options passed:  -imultilib thumb
@ -iprefix c:\devkitpro\devkitarm\bin\../lib/gcc/arm-none-eabi/10.1.0/
@ -D__USES_INITFINI__ Forging.c -mcpu=arm7tdmi -mthumb -mthumb-interwork
@ -mtune=arm7tdmi -mlong-calls -march=armv4t -auxbase-strip Forging.s -Os
@ -Wall -fverbose-asm
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
	.global	GetItemUses
	.arch armv4t
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	GetItemUses, %function
GetItemUses:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ Forging.c:27:     if (GetItemAttributes(item) & IA_UNBREAKABLE)
	ldr	r3, .L4	@ tmp118,
@ Forging.c:26: int GetItemUses(int item) {
	movs	r4, r0	@ item, tmp124
@ Forging.c:27:     if (GetItemAttributes(item) & IA_UNBREAKABLE)
	bl	.L6		@
	movs	r3, r0	@ tmp125,
@ Forging.c:28:         return 0xFF;
	movs	r0, #255	@ <retval>,
@ Forging.c:27:     if (GetItemAttributes(item) & IA_UNBREAKABLE)
	lsls	r3, r3, #28	@ tmp126, tmp125,
	bmi	.L1		@,
@ Forging.c:30:         return ITEM_USES(item);
	lsls	r4, r4, #18	@ tmp122, item,
	lsrs	r0, r4, #26	@ <retval>, tmp122,
.L1:
@ Forging.c:31: }
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L5:
	.align	2
.L4:
	.word	GetItemAttributes
	.size	GetItemUses, .-GetItemUses
	.align	1
	.global	DrawItemMenuLine
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	DrawItemMenuLine, %function
DrawItemMenuLine:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r0, r1, r2, r4, r5, r6, r7, lr}	@
@ Forging.c:65: void DrawItemMenuLine(struct TextHandle* text, int item, s8 isUsable, u16* mapOut) {
	movs	r5, r0	@ text, tmp173
@ Forging.c:67: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	ldr	r7, .L25	@ tmp136,
	movs	r0, r1	@, item
@ Forging.c:65: void DrawItemMenuLine(struct TextHandle* text, int item, s8 isUsable, u16* mapOut) {
	movs	r6, r3	@ mapOut, tmp176
	str	r2, [sp, #4]	@ tmp175, %sfp
	movs	r4, r1	@ item, tmp174
@ Forging.c:67: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	bl	.L27		@
@ Forging.c:67: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	movs	r3, #128	@ tmp137,
	movs	r2, r0	@ isItemAnAccessory, tmp177
	lsls	r3, r3, #15	@ tmp137, tmp137,
	ands	r2, r3	@ isItemAnAccessory, tmp137
@ Forging.c:69: 	if (isItemAnAccessory) { // Vesly added 
	tst	r0, r3	@ tmp177, tmp137
	beq	.L8		@,
@ Forging.c:74: 		if(ITEM_EQUIPPED(item)) textColor = TEXT_COLOR_GOLD;
	asrs	r2, r4, #15	@ isItemAnAccessory, item,
@ Forging.c:74: 		if(ITEM_EQUIPPED(item)) textColor = TEXT_COLOR_GOLD;
	beq	.L8		@,
@ Forging.c:74: 		if(ITEM_EQUIPPED(item)) textColor = TEXT_COLOR_GOLD;
	movs	r2, #3	@ isItemAnAccessory,
.L8:
@ Forging.c:77: 	Text_SetParameters(text, 0, textColor);
	movs	r1, #0	@,
	movs	r0, r5	@, text
	ldr	r3, .L25+4	@ tmp138,
	bl	.L6		@
@ Forging.c:80: 	Text_DrawString(text, GetItemName(item));
	ldr	r3, .L25+8	@ tmp139,
	movs	r0, r4	@, item
	bl	.L6		@
@ Forging.c:80: 	Text_DrawString(text, GetItemName(item));
	ldr	r3, .L25+12	@ tmp140,
@ Forging.c:80: 	Text_DrawString(text, GetItemName(item));
	movs	r1, r0	@ _4, tmp178
@ Forging.c:80: 	Text_DrawString(text, GetItemName(item));
	movs	r0, r5	@, text
	bl	.L6		@
@ Forging.c:83: 	Text_Display(text, mapOut + 2);
	movs	r0, r5	@, text
	ldr	r3, .L25+16	@ tmp142,
	adds	r1, r6, #4	@ tmp141, mapOut,
	bl	.L6		@
@ Forging.c:85: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	movs	r0, r4	@, item
	bl	.L27		@
@ Forging.c:85: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	movs	r5, #1	@ iftmp.0_18,
	lsls	r3, r0, #9	@ tmp188, tmp179,
	bpl	.L9		@,
@ Forging.c:85: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	movs	r0, r4	@, item
@ Forging.c:85: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	movs	r5, #192	@ tmp148,
@ Forging.c:85: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	bl	.L27		@
@ Forging.c:85: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	lsls	r5, r5, #17	@ tmp148, tmp148,
	ands	r5, r0	@ tmp147, tmp180
@ Forging.c:85: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	subs	r3, r5, #1	@ tmp151, tmp147
	sbcs	r5, r5, r3	@ iftmp.0_18, tmp147, tmp151
.L9:
@ Forging.c:85: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	movs	r0, r4	@, item
	ldr	r3, .L25+20	@ tmp152,
	bl	.L6		@
@ Forging.c:85: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	cmp	r0, #254	@ tmp181,
	beq	.L10		@,
	cmp	r5, #0	@ iftmp.0_18,
	beq	.L10		@,
@ Forging.c:85: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	movs	r0, r4	@, item
	ldr	r5, [sp, #4]	@ isUsable, %sfp
	bl	GetItemUses		@
	subs	r3, r5, #1	@ tmp172, isUsable
	sbcs	r5, r5, r3	@ isUsable, isUsable, tmp172
	movs	r2, r0	@ _15, tmp182
	movs	r0, r6	@ _14, mapOut
	adds	r5, r5, #1	@ iftmp.1_19,
	movs	r1, r5	@, iftmp.1_19
	ldr	r3, .L25+24	@ tmp165,
	adds	r0, r0, #22	@ _14,
	bl	.L6		@
.L10:
@ Forging.c:89: }
	@ sp needed	@
@ Forging.c:87: 	DrawIcon(mapOut, GetItemIconId(item), 0x4000);
	movs	r0, r4	@, item
	ldr	r3, .L25+28	@ tmp166,
	bl	.L6		@
	movs	r2, #128	@,
	movs	r1, r0	@ _16, tmp183
	ldr	r3, .L25+32	@ tmp168,
	movs	r0, r6	@, mapOut
	lsls	r2, r2, #7	@,,
	bl	.L6		@
@ Forging.c:89: }
	pop	{r0, r1, r2, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L26:
	.align	2
.L25:
	.word	GetItemAttributes
	.word	Text_SetParameters
	.word	GetItemName
	.word	Text_DrawString
	.word	Text_Display
	.word	GetItemMight
	.word	DrawUiNumberOrDoubleDashes
	.word	GetItemIconId
	.word	DrawIcon
	.size	DrawItemMenuLine, .-DrawItemMenuLine
	.section	.rodata.str1.1,"aMS",%progbits,1
.LC14:
	.ascii	"+\000"
	.text
	.align	1
	.global	DrawItemMenuLineLong
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	DrawItemMenuLineLong, %function
DrawItemMenuLineLong:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r0, r1, r2, r4, r5, r6, r7, lr}	@
@ Forging.c:91: void DrawItemMenuLineLong(struct TextHandle* text, int item, s8 isUsable, u16* mapOut) {
	movs	r6, r0	@ text, tmp191
@ Forging.c:93: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	ldr	r7, .L50	@ tmp142,
	movs	r0, r1	@, item
@ Forging.c:91: void DrawItemMenuLineLong(struct TextHandle* text, int item, s8 isUsable, u16* mapOut) {
	movs	r5, r3	@ mapOut, tmp194
	str	r2, [sp, #4]	@ tmp193, %sfp
	movs	r4, r1	@ item, tmp192
@ Forging.c:93: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	bl	.L27		@
@ Forging.c:93: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	movs	r3, #128	@ tmp143,
	movs	r2, r0	@ isItemAnAccessory, tmp195
	lsls	r3, r3, #15	@ tmp143, tmp143,
	ands	r2, r3	@ isItemAnAccessory, tmp143
@ Forging.c:97: 	if (isItemAnAccessory) { // Vesly added 
	tst	r0, r3	@ tmp195, tmp143
	beq	.L29		@,
@ Forging.c:100: 		if(ITEM_EQUIPPED(item)) textColor = TEXT_COLOR_GOLD;
	asrs	r2, r4, #15	@ isItemAnAccessory, item,
@ Forging.c:100: 		if(ITEM_EQUIPPED(item)) textColor = TEXT_COLOR_GOLD;
	beq	.L29		@,
@ Forging.c:100: 		if(ITEM_EQUIPPED(item)) textColor = TEXT_COLOR_GOLD;
	movs	r2, #3	@ isItemAnAccessory,
.L29:
@ Forging.c:102: 	Text_SetParameters(text, 0, textColor);
	movs	r1, #0	@,
	ldr	r3, .L50+4	@ tmp144,
	movs	r0, r6	@, text
	bl	.L6		@
@ Forging.c:104: 	Text_DrawString(text, GetItemName(item));
	ldr	r3, .L50+8	@ tmp145,
	movs	r0, r4	@, item
	bl	.L6		@
@ Forging.c:104: 	Text_DrawString(text, GetItemName(item));
	ldr	r3, .L50+12	@ tmp212,
@ Forging.c:104: 	Text_DrawString(text, GetItemName(item));
	movs	r1, r0	@ _4, tmp196
@ Forging.c:104: 	Text_DrawString(text, GetItemName(item));
	movs	r0, r6	@, text
	bl	.L6		@
@ Forging.c:105: 	if(ITEM_FORGED(item)) Text_DrawString(text, "+");
	lsls	r3, r4, #17	@ tmp209, item,
	bpl	.L30		@,
@ Forging.c:105: 	if(ITEM_FORGED(item)) Text_DrawString(text, "+");
	movs	r0, r6	@, text
	ldr	r1, .L50+16	@,
	ldr	r3, .L50+12	@ tmp214,
	bl	.L6		@
.L30:
@ Forging.c:107: 	Text_Display(text, mapOut + 2);
	movs	r0, r6	@, text
	ldr	r3, .L50+20	@ tmp152,
	adds	r1, r5, #4	@ tmp151, mapOut,
	bl	.L6		@
@ Forging.c:109: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r0, r4	@, item
	bl	.L27		@
@ Forging.c:109: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r6, #1	@ iftmp.2_24,
	lsls	r3, r0, #9	@ tmp210, tmp197,
	bpl	.L31		@,
@ Forging.c:109: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r0, r4	@, item
@ Forging.c:109: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r6, #192	@ tmp158,
@ Forging.c:109: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	bl	.L27		@
@ Forging.c:109: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	lsls	r6, r6, #17	@ tmp158, tmp158,
	ands	r6, r0	@ tmp157, tmp198
@ Forging.c:109: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	subs	r3, r6, #1	@ tmp161, tmp157
	sbcs	r6, r6, r3	@ iftmp.2_24, tmp157, tmp161
.L31:
@ Forging.c:109: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r0, r4	@, item
	ldr	r3, .L50+24	@ tmp162,
	bl	.L6		@
@ Forging.c:109: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	cmp	r0, #254	@ tmp199,
	beq	.L32		@,
	cmp	r6, #0	@ iftmp.2_24,
	beq	.L32		@,
@ Forging.c:110: 		DrawUiNumberOrDoubleDashes(mapOut + 10, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	movs	r0, r4	@, item
	ldr	r6, [sp, #4]	@ tmp189, %sfp
	bl	GetItemUses		@
	subs	r3, r6, #1	@ tmp190, tmp189
	sbcs	r6, r6, r3	@ tmp189, tmp189, tmp190
	movs	r2, r0	@ _16, tmp200
	movs	r0, r5	@ _15, mapOut
	adds	r6, r6, #1	@ iftmp.3_25,
	movs	r1, r6	@, iftmp.3_25
	ldr	r7, .L50+28	@ tmp175,
	adds	r0, r0, #20	@ _15,
	bl	.L27		@
@ Forging.c:111: 		DrawUiNumberOrDoubleDashes(mapOut + 13, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemMaxUses(item));
	ldr	r3, .L50+32	@ tmp176,
	movs	r0, r4	@, item
	bl	.L6		@
	movs	r2, r0	@ _18, tmp201
	movs	r0, r5	@ tmp177, mapOut
	movs	r1, r6	@, iftmp.3_25
	adds	r0, r0, #26	@ tmp177,
	bl	.L27		@
@ Forging.c:112: 		DrawSpecialUiChar(mapOut + 11, isUsable ? TEXT_COLOR_NORMAL : TEXT_COLOR_GRAY, 0x16); // draw special character?
	movs	r2, #22	@,
	ldr	r1, [sp, #4]	@ isUsable, %sfp
	adds	r0, r5, r2	@ tmp182, tmp182,
	rsbs	r3, r1, #0	@ tmp181, isUsable
	adcs	r1, r1, r3	@ isUsable, isUsable, tmp181
	ldr	r3, .L50+36	@ tmp183,
	bl	.L6		@
.L32:
@ Forging.c:118: }
	@ sp needed	@
@ Forging.c:117:     DrawIcon(mapOut, GetItemIconId(item), 0x4000);
	movs	r0, r4	@, item
	ldr	r3, .L50+40	@ tmp184,
	bl	.L6		@
	movs	r2, #128	@,
	movs	r1, r0	@ _22, tmp202
	ldr	r3, .L50+44	@ tmp186,
	movs	r0, r5	@, mapOut
	lsls	r2, r2, #7	@,,
	bl	.L6		@
@ Forging.c:118: }
	pop	{r0, r1, r2, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L51:
	.align	2
.L50:
	.word	GetItemAttributes
	.word	Text_SetParameters
	.word	GetItemName
	.word	Text_DrawString
	.word	.LC14
	.word	Text_Display
	.word	GetItemMight
	.word	DrawUiNumberOrDoubleDashes
	.word	GetItemMaxUses
	.word	DrawSpecialUiChar
	.word	GetItemIconId
	.word	DrawIcon
	.size	DrawItemMenuLineLong, .-DrawItemMenuLineLong
	.align	1
	.global	DrawItemMenuLineNoColor
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	DrawItemMenuLineNoColor, %function
DrawItemMenuLineNoColor:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r0, r1, r2, r4, r5, r6, r7, lr}	@
@ Forging.c:120: void DrawItemMenuLineNoColor(struct TextHandle* text, int item, u16* mapOut) {
	movs	r4, r1	@ item, tmp167
@ Forging.c:121:     Text_SetXCursor(text, 0);
	ldr	r3, .L63	@ tmp132,
	movs	r1, #0	@,
@ Forging.c:120: void DrawItemMenuLineNoColor(struct TextHandle* text, int item, u16* mapOut) {
	movs	r6, r2	@ mapOut, tmp168
	movs	r5, r0	@ text, tmp166
@ Forging.c:121:     Text_SetXCursor(text, 0);
	bl	.L6		@
@ Forging.c:122:     Text_DrawString(text, GetItemName(item));
	ldr	r3, .L63+4	@ tmp133,
	movs	r0, r4	@, item
	bl	.L6		@
@ Forging.c:122:     Text_DrawString(text, GetItemName(item));
	ldr	r3, .L63+8	@ tmp134,
@ Forging.c:122:     Text_DrawString(text, GetItemName(item));
	movs	r1, r0	@ _1, tmp169
@ Forging.c:122:     Text_DrawString(text, GetItemName(item));
	movs	r0, r5	@, text
	bl	.L6		@
@ Forging.c:123: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	ldr	r7, .L63+12	@ tmp135,
	movs	r0, r4	@, item
	bl	.L27		@
@ Forging.c:124:     Text_Display(text, mapOut + 2);
	ldr	r3, .L63+16	@ tmp137,
	movs	r0, r5	@, text
	adds	r1, r6, #4	@ tmp136, mapOut,
	bl	.L6		@
@ Forging.c:126: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r0, r4	@, item
	bl	.L27		@
@ Forging.c:126: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r3, #1	@ iftmp.5_15,
	str	r3, [sp, #4]	@ iftmp.5_15, %sfp
	lsls	r3, r0, #9	@ tmp179, tmp170,
	bpl	.L53		@,
@ Forging.c:126: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r0, r4	@, item
	bl	.L27		@
@ Forging.c:126: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r3, #192	@ tmp143,
	lsls	r3, r3, #17	@ tmp143, tmp143,
	ands	r0, r3	@ tmp142, tmp143
@ Forging.c:126: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	subs	r3, r0, #1	@ tmp146, tmp142
	sbcs	r0, r0, r3	@ tmp142, tmp142, tmp146
	str	r0, [sp, #4]	@ tmp142, %sfp
.L53:
@ Forging.c:126: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r0, r4	@, item
	ldr	r3, .L63+20	@ tmp147,
	bl	.L6		@
@ Forging.c:126: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	cmp	r0, #254	@ tmp172,
	beq	.L54		@,
	ldr	r3, [sp, #4]	@ iftmp.5_15, %sfp
	cmp	r3, #0	@ iftmp.5_15,
	beq	.L54		@,
@ Forging.c:127: 		DrawSpecialUiChar(mapOut + 11, Text_GetColorId(text), GetItemUses(item));
	ldr	r3, .L63+24	@ tmp160,
	movs	r0, r5	@, text
	bl	.L6		@
	movs	r5, r0	@ _12, tmp173
	movs	r0, r4	@, item
	bl	GetItemUses		@
	movs	r2, r0	@ _13, tmp174
	movs	r0, r6	@ tmp161, mapOut
	movs	r1, r5	@, _12
	ldr	r3, .L63+28	@ tmp162,
	adds	r0, r0, #22	@ tmp161,
	bl	.L6		@
.L54:
@ Forging.c:131: }
	@ sp needed	@
@ Forging.c:130:     DrawIcon(mapOut, GetItemIconId(item), 0x4000);
	movs	r0, r4	@, item
	ldr	r3, .L63+32	@ tmp163,
	bl	.L6		@
	movs	r2, #128	@,
	movs	r1, r0	@ _14, tmp175
	ldr	r3, .L63+36	@ tmp165,
	movs	r0, r6	@, mapOut
	lsls	r2, r2, #7	@,,
	bl	.L6		@
@ Forging.c:131: }
	pop	{r0, r1, r2, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L64:
	.align	2
.L63:
	.word	Text_SetXCursor
	.word	GetItemName
	.word	Text_DrawString
	.word	GetItemAttributes
	.word	Text_Display
	.word	GetItemMight
	.word	Text_GetColorId
	.word	DrawSpecialUiChar
	.word	GetItemIconId
	.word	DrawIcon
	.size	DrawItemMenuLineNoColor, .-DrawItemMenuLineNoColor
	.align	1
	.global	DrawItemStatScreenLine
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	DrawItemStatScreenLine, %function
DrawItemStatScreenLine:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r0, r1, r2, r4, r5, r6, r7, lr}	@
@ Forging.c:133: void DrawItemStatScreenLine(struct TextHandle* text, int item, int nameColor, u16* mapOut) {
	movs	r7, r0	@ text, tmp192
	movs	r6, r3	@ mapOut, tmp195
@ Forging.c:135: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	movs	r0, r1	@, item
	ldr	r3, .L84	@ tmp211,
@ Forging.c:133: void DrawItemStatScreenLine(struct TextHandle* text, int item, int nameColor, u16* mapOut) {
	movs	r4, r1	@ item, tmp193
	movs	r5, r2	@ nameColor, tmp194
@ Forging.c:135: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	bl	.L6		@
@ Forging.c:137:     Text_Clear(text);
	ldr	r3, .L84+4	@ tmp143,
@ Forging.c:135: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	str	r0, [sp, #4]	@ tmp196, %sfp
@ Forging.c:137:     Text_Clear(text);
	movs	r0, r7	@, text
	bl	.L6		@
@ Forging.c:140: 	if (isItemAnAccessory) { // Vesly 
	ldr	r3, [sp, #4]	@ _1, %sfp
	movs	r1, r5	@ color, nameColor
	lsls	r3, r3, #9	@ tmp209, _1,
	bpl	.L66		@,
@ Forging.c:142: 		if(ITEM_EQUIPPED(item) && nameColor != TEXT_COLOR_GREEN) color = TEXT_COLOR_GOLD;
	asrs	r3, r4, #15	@ tmp146, item,
@ Forging.c:142: 		if(ITEM_EQUIPPED(item) && nameColor != TEXT_COLOR_GREEN) color = TEXT_COLOR_GOLD;
	beq	.L66		@,
@ Forging.c:142: 		if(ITEM_EQUIPPED(item) && nameColor != TEXT_COLOR_GREEN) color = TEXT_COLOR_GOLD;
	subs	r1, r5, #4	@ tmp190, nameColor,
	rsbs	r3, r1, #0	@ tmp191, tmp190
	adcs	r1, r1, r3	@ tmp189, tmp190, tmp191
	adds	r1, r1, #3	@ color,
.L66:
@ Forging.c:144:     Text_SetColorId(text, color);
	ldr	r3, .L84+8	@ tmp147,
	movs	r0, r7	@, text
	bl	.L6		@
@ Forging.c:146:     Text_DrawString(text, GetItemName(item));
	ldr	r3, .L84+12	@ tmp148,
	movs	r0, r4	@, item
	bl	.L6		@
@ Forging.c:146:     Text_DrawString(text, GetItemName(item));
	ldr	r3, .L84+16	@ tmp149,
@ Forging.c:146:     Text_DrawString(text, GetItemName(item));
	movs	r1, r0	@ _4, tmp197
@ Forging.c:146:     Text_DrawString(text, GetItemName(item));
	movs	r0, r7	@, text
	bl	.L6		@
@ Forging.c:149: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	ldr	r3, .L84	@ tmp214,
	movs	r0, r4	@, item
	bl	.L6		@
@ Forging.c:149: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r3, #1	@ iftmp.6_22,
	str	r3, [sp, #4]	@ iftmp.6_22, %sfp
	lsls	r3, r0, #9	@ tmp210, tmp198,
	bpl	.L67		@,
@ Forging.c:149: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	ldr	r3, .L84	@ tmp217,
	movs	r0, r4	@, item
	bl	.L6		@
@ Forging.c:149: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r3, #192	@ tmp155,
	lsls	r3, r3, #17	@ tmp155, tmp155,
	ands	r0, r3	@ tmp154, tmp155
@ Forging.c:149: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	subs	r3, r0, #1	@ tmp158, tmp154
	sbcs	r0, r0, r3	@ tmp154, tmp154, tmp158
	str	r0, [sp, #4]	@ tmp154, %sfp
.L67:
@ Forging.c:149: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r0, r4	@, item
	ldr	r3, .L84+20	@ tmp159,
	bl	.L6		@
@ Forging.c:149: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	cmp	r0, #254	@ tmp200,
	beq	.L68		@,
	ldr	r3, [sp, #4]	@ iftmp.6_22, %sfp
	cmp	r3, #0	@ iftmp.6_22,
	beq	.L68		@,
@ Forging.c:151: 		DrawSpecialUiChar(mapOut + 12, color, 0x16);
	movs	r0, r6	@ tmp176, mapOut
@ Forging.c:150: 		color = (nameColor == TEXT_COLOR_GRAY) ? TEXT_COLOR_GRAY : TEXT_COLOR_NORMAL;
	subs	r1, r5, #1	@ tmp174, nameColor,
	rsbs	r3, r1, #0	@ tmp175, tmp174
	adcs	r1, r1, r3	@ color, tmp174, tmp175
@ Forging.c:151: 		DrawSpecialUiChar(mapOut + 12, color, 0x16);
	movs	r2, #22	@,
	ldr	r3, .L84+24	@ tmp177,
	adds	r0, r0, #24	@ tmp176,
	bl	.L6		@
@ Forging.c:153: 		color = (nameColor != TEXT_COLOR_GRAY) ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY;
	cmp	r5, #1	@ nameColor,
	beq	.L69		@,
	movs	r5, #2	@ nameColor,
.L69:
@ Forging.c:154: 		DrawUiNumberOrDoubleDashes(mapOut + 11, color, GetItemUses(item));
	movs	r0, r4	@, item
	bl	GetItemUses		@
	movs	r2, r0	@ _16, tmp201
	movs	r0, r6	@ tmp178, mapOut
	movs	r1, r5	@, nameColor
	ldr	r3, .L84+28	@ tmp223,
	adds	r0, r0, #22	@ tmp178,
	bl	.L6		@
@ Forging.c:155: 		DrawUiNumberOrDoubleDashes(mapOut + 14, color, GetItemMaxUses(item));
	ldr	r3, .L84+32	@ tmp180,
	movs	r0, r4	@, item
	bl	.L6		@
	movs	r2, r0	@ _18, tmp202
	movs	r0, r6	@ tmp181, mapOut
	movs	r1, r5	@, nameColor
	ldr	r3, .L84+28	@ tmp226,
	adds	r0, r0, #28	@ tmp181,
	bl	.L6		@
.L68:
@ Forging.c:160: }
	@ sp needed	@
@ Forging.c:157:     Text_Display(text, mapOut + 2);
	adds	r1, r6, #4	@ tmp183, mapOut,
	movs	r0, r7	@, text
	ldr	r3, .L84+36	@ tmp184,
	bl	.L6		@
@ Forging.c:159:     DrawIcon(mapOut, GetItemIconId(item), 0x4000);
	movs	r0, r4	@, item
	ldr	r3, .L84+40	@ tmp185,
	bl	.L6		@
	movs	r2, #128	@,
	movs	r1, r0	@ _20, tmp203
	ldr	r3, .L84+44	@ tmp187,
	movs	r0, r6	@, mapOut
	lsls	r2, r2, #7	@,,
	bl	.L6		@
@ Forging.c:160: }
	pop	{r0, r1, r2, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L85:
	.align	2
.L84:
	.word	GetItemAttributes
	.word	Text_Clear
	.word	Text_SetColorId
	.word	GetItemName
	.word	Text_DrawString
	.word	GetItemMight
	.word	DrawSpecialUiChar
	.word	DrawUiNumberOrDoubleDashes
	.word	GetItemMaxUses
	.word	Text_Display
	.word	GetItemIconId
	.word	DrawIcon
	.size	DrawItemStatScreenLine, .-DrawItemStatScreenLine
	.align	1
	.global	GetItemAfterUse
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	GetItemAfterUse, %function
GetItemAfterUse:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ Forging.c:163:     if (GetItemAttributes(item) & IA_UNBREAKABLE)
	ldr	r3, .L91	@ tmp120,
@ Forging.c:162: u16 GetItemAfterUse(int item) {
	movs	r4, r0	@ item, tmp129
@ Forging.c:163:     if (GetItemAttributes(item) & IA_UNBREAKABLE)
	bl	.L6		@
@ Forging.c:163:     if (GetItemAttributes(item) & IA_UNBREAKABLE)
	lsls	r3, r0, #28	@ tmp131, tmp130,
	bpl	.L87		@,
.L90:
@ Forging.c:171:     return item; // return used item
	lsls	r0, r4, #16	@ <retval>, item,
	lsrs	r0, r0, #16	@ <retval>, <retval>,
	b	.L88		@
.L87:
@ Forging.c:166:     item -= (1 << 8); // lose one use
	subs	r4, r4, #1	@ item,
	subs	r4, r4, #255	@ item,
@ Forging.c:168:     if (ITEM_USES(item) < 1)
	lsls	r3, r4, #18	@ tmp126, item,
	lsrs	r3, r3, #26	@ tmp125, tmp126,
@ Forging.c:169:         return 0; // return no item if uses < 0
	subs	r0, r3, #0	@ <retval>, tmp125,
@ Forging.c:168:     if (ITEM_USES(item) < 1)
	bne	.L90		@,
.L88:
@ Forging.c:172: }
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L92:
	.align	2
.L91:
	.word	GetItemAttributes
	.size	GetItemAfterUse, .-GetItemAfterUse
	.ident	"GCC: (devkitARM release 54) 10.1.0"
	.code 16
	.align	1
.L6:
	bx	r3
.L27:
	bx	r7
