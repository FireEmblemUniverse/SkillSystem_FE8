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
	.global	DrawItemMenuLine
	.arch armv4t
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
@ Forging.c:67: void DrawItemMenuLine(struct TextHandle* text, int item, s8 isUsable, u16* mapOut) {
	movs	r6, r0	@ text, tmp184
	movs	r5, r3	@ mapOut, tmp187
@ Forging.c:69: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	movs	r0, r1	@, item
	ldr	r3, .L23	@ tmp141,
@ Forging.c:67: void DrawItemMenuLine(struct TextHandle* text, int item, s8 isUsable, u16* mapOut) {
	str	r2, [sp, #4]	@ tmp186, %sfp
	movs	r4, r1	@ item, tmp185
@ Forging.c:69: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	bl	.L25		@
@ Forging.c:69: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	movs	r3, #128	@ tmp142,
	movs	r7, r0	@ isItemAnAccessory, tmp188
	lsls	r3, r3, #15	@ tmp142, tmp142,
	movs	r2, #0	@ textColor,
	ands	r7, r3	@ isItemAnAccessory, tmp142
@ Forging.c:73: 	if (isItemAnAccessory) { // Vesly added 
	tst	r0, r3	@ tmp188, tmp142
	beq	.L2		@,
@ Forging.c:77: 		if(ITEM_EQUIPPED(item)) textColor = TEXT_COLOR_GOLD;
	asrs	r2, r4, #15	@ textColor, item,
@ Forging.c:77: 		if(ITEM_EQUIPPED(item)) textColor = TEXT_COLOR_GOLD;
	beq	.L2		@,
@ Forging.c:77: 		if(ITEM_EQUIPPED(item)) textColor = TEXT_COLOR_GOLD;
	movs	r2, #3	@ textColor,
.L2:
@ Forging.c:80: 	Text_SetParameters(text, 0, textColor);
	movs	r1, #0	@,
	movs	r0, r6	@, text
	ldr	r3, .L23+4	@ tmp143,
	bl	.L25		@
@ Forging.c:83: 	Text_DrawString(text, GetItemName(item));
	ldr	r3, .L23+8	@ tmp144,
	movs	r0, r4	@, item
	bl	.L25		@
@ Forging.c:83: 	Text_DrawString(text, GetItemName(item));
	ldr	r3, .L23+12	@ tmp145,
@ Forging.c:83: 	Text_DrawString(text, GetItemName(item));
	movs	r1, r0	@ _4, tmp189
@ Forging.c:83: 	Text_DrawString(text, GetItemName(item));
	movs	r0, r6	@, text
	bl	.L25		@
@ Forging.c:86: 	Text_Display(text, mapOut + 2);
	movs	r0, r6	@, text
	ldr	r3, .L23+16	@ tmp147,
	adds	r1, r5, #4	@ tmp146, mapOut,
	bl	.L25		@
	ldr	r6, .L23+20	@ tmp178,
@ Forging.c:89: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	cmp	r7, #0	@ isItemAnAccessory,
	beq	.L4		@,
@ Forging.c:89: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	movs	r0, r4	@, item
	bl	.L26		@
@ Forging.c:89: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	cmp	r0, #254	@ tmp190,
	bne	.L4		@,
@ Forging.c:89: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	ldr	r7, [sp, #4]	@ tmp180, %sfp
	movs	r0, r4	@, item
	subs	r3, r7, #1	@ tmp181, tmp180
	sbcs	r7, r7, r3	@ tmp180, tmp180, tmp181
	ldr	r3, .L23+24	@ tmp149,
	bl	.L25		@
	movs	r2, r0	@ _8, tmp191
	movs	r0, r5	@ _7, mapOut
	adds	r7, r7, #1	@ iftmp.0_21,
	movs	r1, r7	@, iftmp.0_21
	ldr	r3, .L23+28	@ tmp150,
	adds	r0, r0, #22	@ _7,
	bl	.L25		@
.L4:
@ Forging.c:92: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	movs	r0, r4	@, item
	ldr	r7, .L23	@ tmp151,
	bl	.L27		@
@ Forging.c:92: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	movs	r3, #1	@ iftmp.1_22,
	str	r3, [sp]	@ iftmp.1_22, %sfp
	lsls	r3, r0, #9	@ tmp202, tmp192,
	bpl	.L7		@,
@ Forging.c:92: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	movs	r0, r4	@, item
	bl	.L27		@
@ Forging.c:92: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	movs	r3, #192	@ tmp156,
	lsls	r3, r3, #17	@ tmp156, tmp156,
	ands	r0, r3	@ tmp155, tmp156
@ Forging.c:92: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	subs	r3, r0, #1	@ tmp159, tmp155
	sbcs	r0, r0, r3	@ tmp155, tmp155, tmp159
	str	r0, [sp]	@ tmp155, %sfp
.L7:
@ Forging.c:92: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	movs	r0, r4	@, item
	bl	.L26		@
@ Forging.c:92: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	cmp	r0, #254	@ tmp194,
	beq	.L8		@,
	ldr	r3, [sp]	@ iftmp.1_22, %sfp
	cmp	r3, #0	@ iftmp.1_22,
	beq	.L8		@,
@ Forging.c:92: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	ldr	r6, [sp, #4]	@ isUsable, %sfp
	movs	r0, r4	@, item
	subs	r3, r6, #1	@ tmp183, isUsable
	sbcs	r6, r6, r3	@ isUsable, isUsable, tmp183
	ldr	r3, .L23+24	@ tmp173,
	bl	.L25		@
	movs	r2, r0	@ _18, tmp195
	movs	r0, r5	@ _17, mapOut
	adds	r6, r6, #1	@ iftmp.2_23,
	movs	r1, r6	@, iftmp.2_23
	ldr	r3, .L23+28	@ tmp174,
	adds	r0, r0, #22	@ _17,
	bl	.L25		@
.L8:
@ Forging.c:96: }
	@ sp needed	@
@ Forging.c:94: 	DrawIcon(mapOut, GetItemIconId(item), 0x4000);
	movs	r0, r4	@, item
	ldr	r3, .L23+32	@ tmp175,
	bl	.L25		@
	movs	r2, #128	@,
	movs	r1, r0	@ _19, tmp196
	ldr	r3, .L23+36	@ tmp177,
	movs	r0, r5	@, mapOut
	lsls	r2, r2, #7	@,,
	bl	.L25		@
@ Forging.c:96: }
	pop	{r0, r1, r2, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L24:
	.align	2
.L23:
	.word	GetItemAttributes
	.word	Text_SetParameters
	.word	GetItemName
	.word	Text_DrawString
	.word	Text_Display
	.word	GetItemMight
	.word	GetItemUses
	.word	DrawUiNumberOrDoubleDashes
	.word	GetItemIconId
	.word	DrawIcon
	.size	DrawItemMenuLine, .-DrawItemMenuLine
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
@ Forging.c:98: void DrawItemMenuLineLong(struct TextHandle* text, int item, s8 isUsable, u16* mapOut) {
	movs	r6, r0	@ text, tmp216
	movs	r5, r3	@ mapOut, tmp219
@ Forging.c:100: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	movs	r0, r1	@, item
	ldr	r3, .L50	@ tmp153,
@ Forging.c:98: void DrawItemMenuLineLong(struct TextHandle* text, int item, s8 isUsable, u16* mapOut) {
	str	r2, [sp, #4]	@ tmp218, %sfp
	movs	r4, r1	@ item, tmp217
@ Forging.c:100: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	bl	.L25		@
@ Forging.c:100: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	movs	r3, #128	@ tmp154,
	movs	r7, r0	@ isItemAnAccessory, tmp220
	lsls	r3, r3, #15	@ tmp154, tmp154,
@ Forging.c:102: 	int textColor = TEXT_COLOR_NORMAL;
	movs	r2, #0	@ textColor,
@ Forging.c:100: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	ands	r7, r3	@ isItemAnAccessory, tmp154
@ Forging.c:104: 	if (isItemAnAccessory) { // Vesly added 
	tst	r0, r3	@ tmp220, tmp154
	beq	.L29		@,
@ Forging.c:106: 		if(ITEM_EQUIPPED(item)) textColor = TEXT_COLOR_GOLD;
	asrs	r3, r4, #15	@ tmp155, item,
@ Forging.c:106: 		if(ITEM_EQUIPPED(item)) textColor = TEXT_COLOR_GOLD;
	adds	r2, r2, #3	@ textColor,
@ Forging.c:106: 		if(ITEM_EQUIPPED(item)) textColor = TEXT_COLOR_GOLD;
	cmp	r3, #0	@ tmp155,
	bne	.L29		@,
@ Forging.c:105: 		if(!isUsable) textColor = TEXT_COLOR_GRAY;
	ldr	r3, [sp, #4]	@ isUsable, %sfp
	rsbs	r2, r3, #0	@ textColor, isUsable
	adcs	r2, r2, r3	@ textColor, isUsable
.L29:
@ Forging.c:108: 	Text_SetParameters(text, 0, textColor);
	movs	r1, #0	@,
	ldr	r3, .L50+4	@ tmp159,
	movs	r0, r6	@, text
	bl	.L25		@
@ Forging.c:110: 	Text_DrawString(text, GetItemName(item));
	ldr	r3, .L50+8	@ tmp160,
	movs	r0, r4	@, item
	bl	.L25		@
@ Forging.c:110: 	Text_DrawString(text, GetItemName(item));
	ldr	r3, .L50+12	@ tmp161,
@ Forging.c:110: 	Text_DrawString(text, GetItemName(item));
	movs	r1, r0	@ _4, tmp221
@ Forging.c:110: 	Text_DrawString(text, GetItemName(item));
	movs	r0, r6	@, text
	bl	.L25		@
@ Forging.c:113: 	Text_Display(text, mapOut + 2);
	movs	r0, r6	@, text
	ldr	r3, .L50+16	@ tmp163,
	adds	r1, r5, #4	@ tmp162, mapOut,
	bl	.L25		@
@ Forging.c:115: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) { // Vesly 
	cmp	r7, #0	@ isItemAnAccessory,
	beq	.L31		@,
@ Forging.c:115: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) { // Vesly 
	movs	r0, r4	@, item
	ldr	r3, .L50+20	@ tmp244,
	bl	.L25		@
@ Forging.c:115: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) { // Vesly 
	cmp	r0, #254	@ tmp222,
	bne	.L31		@,
@ Forging.c:117: 		DrawUiNumberOrDoubleDashes(mapOut + 10, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	ldr	r6, [sp, #4]	@ tmp212, %sfp
	movs	r0, r4	@, item
	subs	r3, r6, #1	@ tmp213, tmp212
	sbcs	r6, r6, r3	@ tmp212, tmp212, tmp213
	ldr	r3, .L50+24	@ tmp165,
	bl	.L25		@
	movs	r2, r0	@ _8, tmp223
	movs	r0, r5	@ _7, mapOut
	adds	r6, r6, #1	@ iftmp.3_32,
	movs	r1, r6	@, iftmp.3_32
	ldr	r7, .L50+28	@ tmp166,
	adds	r0, r0, #20	@ _7,
	bl	.L27		@
@ Forging.c:118: 		DrawUiNumberOrDoubleDashes(mapOut + 13, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemMaxUses(item));
	ldr	r3, .L50+32	@ tmp167,
	movs	r0, r4	@, item
	bl	.L25		@
	movs	r2, r0	@ _10, tmp224
	movs	r0, r5	@ tmp168, mapOut
	movs	r1, r6	@, iftmp.3_32
	adds	r0, r0, #26	@ tmp168,
	bl	.L27		@
@ Forging.c:119: 		DrawSpecialUiChar(mapOut + 11, isUsable ? TEXT_COLOR_NORMAL : TEXT_COLOR_GRAY, 0x16); // draw special character?
	movs	r2, #22	@,
	ldr	r3, [sp, #4]	@ isUsable, %sfp
	adds	r0, r5, r2	@ tmp173, tmp173,
	rsbs	r1, r3, #0	@ tmp171, isUsable
	adcs	r1, r1, r3	@ tmp171, isUsable
	ldr	r3, .L50+36	@ tmp174,
	bl	.L25		@
.L31:
@ Forging.c:123: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r0, r4	@, item
	ldr	r7, .L50	@ tmp175,
	bl	.L27		@
@ Forging.c:123: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r6, #1	@ iftmp.5_33,
	lsls	r3, r0, #9	@ tmp241, tmp225,
	bpl	.L34		@,
@ Forging.c:123: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r0, r4	@, item
@ Forging.c:123: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r6, #192	@ tmp180,
@ Forging.c:123: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	bl	.L27		@
@ Forging.c:123: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	lsls	r6, r6, #17	@ tmp180, tmp180,
	ands	r6, r0	@ tmp179, tmp226
@ Forging.c:123: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	subs	r3, r6, #1	@ tmp183, tmp179
	sbcs	r6, r6, r3	@ iftmp.5_33, tmp179, tmp183
.L34:
@ Forging.c:123: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r0, r4	@, item
	ldr	r3, .L50+20	@ tmp251,
	bl	.L25		@
@ Forging.c:123: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	cmp	r0, #254	@ tmp227,
	beq	.L35		@,
	cmp	r6, #0	@ iftmp.5_33,
	beq	.L35		@,
@ Forging.c:124: 		DrawUiNumberOrDoubleDashes(mapOut + 10, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	ldr	r6, [sp, #4]	@ tmp214, %sfp
	movs	r0, r4	@, item
	subs	r3, r6, #1	@ tmp215, tmp214
	sbcs	r6, r6, r3	@ tmp214, tmp214, tmp215
	ldr	r3, .L50+24	@ tmp197,
	bl	.L25		@
	movs	r2, r0	@ _23, tmp228
	movs	r0, r5	@ _22, mapOut
	adds	r6, r6, #1	@ iftmp.6_34,
	movs	r1, r6	@, iftmp.6_34
	ldr	r7, .L50+28	@ tmp198,
	adds	r0, r0, #20	@ _22,
	bl	.L27		@
@ Forging.c:125: 		DrawUiNumberOrDoubleDashes(mapOut + 13, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemMaxUses(item));
	ldr	r3, .L50+32	@ tmp199,
	movs	r0, r4	@, item
	bl	.L25		@
	movs	r2, r0	@ _25, tmp229
	movs	r0, r5	@ tmp200, mapOut
	movs	r1, r6	@, iftmp.6_34
	adds	r0, r0, #26	@ tmp200,
	bl	.L27		@
@ Forging.c:126: 		DrawSpecialUiChar(mapOut + 11, isUsable ? TEXT_COLOR_NORMAL : TEXT_COLOR_GRAY, 0x16); // draw special character?
	movs	r2, #22	@,
	ldr	r1, [sp, #4]	@ isUsable, %sfp
	adds	r0, r5, r2	@ tmp205, tmp205,
	rsbs	r3, r1, #0	@ tmp204, isUsable
	adcs	r1, r1, r3	@ isUsable, isUsable, tmp204
	ldr	r3, .L50+36	@ tmp206,
	bl	.L25		@
.L35:
@ Forging.c:132: }
	@ sp needed	@
@ Forging.c:131:     DrawIcon(mapOut, GetItemIconId(item), 0x4000);
	movs	r0, r4	@, item
	ldr	r3, .L50+40	@ tmp207,
	bl	.L25		@
	movs	r2, #128	@,
	movs	r1, r0	@ _29, tmp230
	ldr	r3, .L50+44	@ tmp209,
	movs	r0, r5	@, mapOut
	lsls	r2, r2, #7	@,,
	bl	.L25		@
@ Forging.c:132: }
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
	.word	Text_Display
	.word	GetItemMight
	.word	GetItemUses
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
@ Forging.c:134: void DrawItemMenuLineNoColor(struct TextHandle* text, int item, u16* mapOut) {
	movs	r4, r1	@ item, tmp168
@ Forging.c:135:     Text_SetXCursor(text, 0);
	ldr	r3, .L63	@ tmp132,
	movs	r1, #0	@,
@ Forging.c:134: void DrawItemMenuLineNoColor(struct TextHandle* text, int item, u16* mapOut) {
	movs	r6, r2	@ mapOut, tmp169
	movs	r5, r0	@ text, tmp167
@ Forging.c:135:     Text_SetXCursor(text, 0);
	bl	.L25		@
@ Forging.c:136:     Text_DrawString(text, GetItemName(item));
	ldr	r3, .L63+4	@ tmp133,
	movs	r0, r4	@, item
	bl	.L25		@
@ Forging.c:136:     Text_DrawString(text, GetItemName(item));
	ldr	r3, .L63+8	@ tmp134,
@ Forging.c:136:     Text_DrawString(text, GetItemName(item));
	movs	r1, r0	@ _1, tmp170
@ Forging.c:136:     Text_DrawString(text, GetItemName(item));
	movs	r0, r5	@, text
	bl	.L25		@
@ Forging.c:137: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	ldr	r7, .L63+12	@ tmp135,
	movs	r0, r4	@, item
	bl	.L27		@
@ Forging.c:138:     Text_Display(text, mapOut + 2);
	ldr	r3, .L63+16	@ tmp137,
	movs	r0, r5	@, text
	adds	r1, r6, #4	@ tmp136, mapOut,
	bl	.L25		@
@ Forging.c:140: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r0, r4	@, item
	bl	.L27		@
@ Forging.c:140: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r3, #1	@ iftmp.8_15,
	str	r3, [sp, #4]	@ iftmp.8_15, %sfp
	lsls	r3, r0, #9	@ tmp180, tmp171,
	bpl	.L53		@,
@ Forging.c:140: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r0, r4	@, item
	bl	.L27		@
@ Forging.c:140: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r3, #192	@ tmp143,
	lsls	r3, r3, #17	@ tmp143, tmp143,
	ands	r0, r3	@ tmp142, tmp143
@ Forging.c:140: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	subs	r3, r0, #1	@ tmp146, tmp142
	sbcs	r0, r0, r3	@ tmp142, tmp142, tmp146
	str	r0, [sp, #4]	@ tmp142, %sfp
.L53:
@ Forging.c:140: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r0, r4	@, item
	ldr	r3, .L63+20	@ tmp147,
	bl	.L25		@
@ Forging.c:140: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	cmp	r0, #254	@ tmp173,
	beq	.L54		@,
	ldr	r3, [sp, #4]	@ iftmp.8_15, %sfp
	cmp	r3, #0	@ iftmp.8_15,
	beq	.L54		@,
@ Forging.c:141: 		DrawSpecialUiChar(mapOut + 11, Text_GetColorId(text), GetItemUses(item));
	movs	r0, r5	@, text
	ldr	r3, .L63+24	@ tmp160,
	bl	.L25		@
	ldr	r3, .L63+28	@ tmp161,
	movs	r5, r0	@ _12, tmp174
	movs	r0, r4	@, item
	bl	.L25		@
	movs	r2, r0	@ _13, tmp175
	movs	r0, r6	@ tmp162, mapOut
	movs	r1, r5	@, _12
	ldr	r3, .L63+32	@ tmp163,
	adds	r0, r0, #22	@ tmp162,
	bl	.L25		@
.L54:
@ Forging.c:145: }
	@ sp needed	@
@ Forging.c:144:     DrawIcon(mapOut, GetItemIconId(item), 0x4000);
	movs	r0, r4	@, item
	ldr	r3, .L63+36	@ tmp164,
	bl	.L25		@
	movs	r2, #128	@,
	movs	r1, r0	@ _14, tmp176
	ldr	r3, .L63+40	@ tmp166,
	movs	r0, r6	@, mapOut
	lsls	r2, r2, #7	@,,
	bl	.L25		@
@ Forging.c:145: }
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
	.word	GetItemUses
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
@ Forging.c:147: void DrawItemStatScreenLine(struct TextHandle* text, int item, int nameColor, u16* mapOut) {
	movs	r5, r3	@ mapOut, tmp219
	str	r0, [sp]	@ tmp216, %sfp
@ Forging.c:149: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	ldr	r3, .L89	@ tmp151,
	movs	r0, r1	@, item
@ Forging.c:149: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	movs	r7, #128	@ tmp152,
@ Forging.c:147: void DrawItemStatScreenLine(struct TextHandle* text, int item, int nameColor, u16* mapOut) {
	movs	r4, r1	@ item, tmp217
	movs	r6, r2	@ nameColor, tmp218
@ Forging.c:149: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	bl	.L25		@
@ Forging.c:149: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	lsls	r7, r7, #15	@ tmp152, tmp152,
@ Forging.c:151:     Text_Clear(text);
	ldr	r3, .L89+4	@ tmp153,
@ Forging.c:149: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	ands	r7, r0	@ isItemAnAccessory, tmp220
@ Forging.c:151:     Text_Clear(text);
	ldr	r0, [sp]	@, %sfp
	bl	.L25		@
	movs	r1, r6	@ color, nameColor
@ Forging.c:155: 	if (isItemAnAccessory) { // Vesly 
	cmp	r7, #0	@ isItemAnAccessory,
	beq	.L66		@,
@ Forging.c:157: 		if(ITEM_EQUIPPED(item) && nameColor != TEXT_COLOR_GREEN) color = TEXT_COLOR_GOLD;
	asrs	r3, r4, #15	@ tmp154, item,
@ Forging.c:157: 		if(ITEM_EQUIPPED(item) && nameColor != TEXT_COLOR_GREEN) color = TEXT_COLOR_GOLD;
	beq	.L66		@,
@ Forging.c:157: 		if(ITEM_EQUIPPED(item) && nameColor != TEXT_COLOR_GREEN) color = TEXT_COLOR_GOLD;
	subs	r1, r6, #4	@ tmp211, nameColor,
	rsbs	r3, r1, #0	@ tmp212, tmp211
	adcs	r1, r1, r3	@ tmp210, tmp211, tmp212
	adds	r1, r1, #3	@ color,
.L66:
@ Forging.c:159:     Text_SetColorId(text, color);
	ldr	r3, .L89+8	@ tmp155,
	ldr	r0, [sp]	@, %sfp
	bl	.L25		@
@ Forging.c:161:     Text_DrawString(text, GetItemName(item));
	ldr	r3, .L89+12	@ tmp156,
	movs	r0, r4	@, item
	bl	.L25		@
@ Forging.c:161:     Text_DrawString(text, GetItemName(item));
	ldr	r3, .L89+16	@ tmp157,
@ Forging.c:161:     Text_DrawString(text, GetItemName(item));
	movs	r1, r0	@ _4, tmp221
@ Forging.c:161:     Text_DrawString(text, GetItemName(item));
	ldr	r0, [sp]	@, %sfp
	bl	.L25		@
@ Forging.c:164: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) { // Vesly - berries 
	cmp	r7, #0	@ isItemAnAccessory,
	beq	.L68		@,
@ Forging.c:164: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) { // Vesly - berries 
	movs	r0, r4	@, item
	ldr	r3, .L89+20	@ tmp158,
	bl	.L25		@
@ Forging.c:164: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) { // Vesly - berries 
	cmp	r0, #254	@ tmp222,
	bne	.L68		@,
@ Forging.c:166: 		DrawSpecialUiChar(mapOut + 12, color, 0x16);
	movs	r0, r5	@ tmp163, mapOut
@ Forging.c:165: 		color = (nameColor == TEXT_COLOR_GRAY) ? TEXT_COLOR_GRAY : TEXT_COLOR_NORMAL;
	subs	r7, r6, #1	@ tmp161, nameColor,
	rsbs	r1, r7, #0	@ color, tmp161
	adcs	r1, r1, r7	@ color, tmp161
@ Forging.c:166: 		DrawSpecialUiChar(mapOut + 12, color, 0x16);
	movs	r2, #22	@,
	ldr	r3, .L89+24	@ tmp164,
	adds	r0, r0, #24	@ tmp163,
	bl	.L25		@
@ Forging.c:168: 		color = (nameColor != TEXT_COLOR_GRAY) ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY;
	subs	r3, r7, #1	@ tmp215, tmp161
	sbcs	r7, r7, r3	@ tmp213, tmp161, tmp215
@ Forging.c:169: 		DrawUiNumberOrDoubleDashes(mapOut + 11, color, GetItemUses(item));
	movs	r0, r4	@, item
	ldr	r3, .L89+28	@ tmp165,
	bl	.L25		@
	movs	r2, r0	@ _9, tmp223
	movs	r0, r5	@ tmp166, mapOut
@ Forging.c:168: 		color = (nameColor != TEXT_COLOR_GRAY) ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY;
	adds	r7, r7, #1	@ iftmp.9_29,
@ Forging.c:169: 		DrawUiNumberOrDoubleDashes(mapOut + 11, color, GetItemUses(item));
	movs	r1, r7	@, iftmp.9_29
	ldr	r3, .L89+32	@ tmp243,
	adds	r0, r0, #22	@ tmp166,
	bl	.L25		@
@ Forging.c:170: 		DrawUiNumberOrDoubleDashes(mapOut + 14, color, GetItemMaxUses(item));
	ldr	r3, .L89+36	@ tmp168,
	movs	r0, r4	@, item
	bl	.L25		@
	movs	r2, r0	@ _11, tmp224
	movs	r0, r5	@ tmp169, mapOut
	movs	r1, r7	@, iftmp.9_29
	ldr	r3, .L89+32	@ tmp246,
	adds	r0, r0, #28	@ tmp169,
	bl	.L25		@
.L68:
@ Forging.c:175: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r0, r4	@, item
	ldr	r7, .L89	@ tmp171,
	bl	.L27		@
@ Forging.c:175: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r3, #1	@ iftmp.10_30,
	str	r3, [sp, #4]	@ iftmp.10_30, %sfp
	lsls	r3, r0, #9	@ tmp240, tmp225,
	bpl	.L71		@,
@ Forging.c:175: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r0, r4	@, item
	bl	.L27		@
@ Forging.c:175: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r3, #192	@ tmp176,
	lsls	r3, r3, #17	@ tmp176, tmp176,
	ands	r0, r3	@ tmp175, tmp176
@ Forging.c:175: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	subs	r3, r0, #1	@ tmp179, tmp175
	sbcs	r0, r0, r3	@ tmp175, tmp175, tmp179
	str	r0, [sp, #4]	@ tmp175, %sfp
.L71:
@ Forging.c:175: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r0, r4	@, item
	ldr	r3, .L89+20	@ tmp180,
	bl	.L25		@
@ Forging.c:175: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	cmp	r0, #254	@ tmp227,
	beq	.L72		@,
	ldr	r3, [sp, #4]	@ iftmp.10_30, %sfp
	cmp	r3, #0	@ iftmp.10_30,
	beq	.L72		@,
@ Forging.c:177: 		DrawSpecialUiChar(mapOut + 12, color, 0x16);
	movs	r0, r5	@ tmp197, mapOut
@ Forging.c:176: 		color = (nameColor == TEXT_COLOR_GRAY) ? TEXT_COLOR_GRAY : TEXT_COLOR_NORMAL;
	subs	r1, r6, #1	@ tmp195, nameColor,
	rsbs	r3, r1, #0	@ tmp196, tmp195
	adcs	r1, r1, r3	@ color, tmp195, tmp196
@ Forging.c:177: 		DrawSpecialUiChar(mapOut + 12, color, 0x16);
	movs	r2, #22	@,
	ldr	r3, .L89+24	@ tmp198,
	adds	r0, r0, #24	@ tmp197,
	bl	.L25		@
@ Forging.c:179: 		color = (nameColor != TEXT_COLOR_GRAY) ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY;
	cmp	r6, #1	@ nameColor,
	beq	.L73		@,
	movs	r6, #2	@ nameColor,
.L73:
@ Forging.c:180: 		DrawUiNumberOrDoubleDashes(mapOut + 11, color, GetItemUses(item));
	ldr	r3, .L89+28	@ tmp199,
	movs	r0, r4	@, item
	bl	.L25		@
	movs	r2, r0	@ _23, tmp228
	movs	r0, r5	@ tmp200, mapOut
	movs	r1, r6	@, nameColor
	adds	r0, r0, #22	@ tmp200,
	ldr	r7, .L89+32	@ tmp201,
	bl	.L27		@
@ Forging.c:181: 		DrawUiNumberOrDoubleDashes(mapOut + 14, color, GetItemMaxUses(item));
	movs	r0, r4	@, item
	ldr	r3, .L89+36	@ tmp202,
	bl	.L25		@
	movs	r2, r0	@ _25, tmp229
	movs	r0, r5	@ tmp203, mapOut
	movs	r1, r6	@, nameColor
	adds	r0, r0, #28	@ tmp203,
	bl	.L27		@
.L72:
@ Forging.c:186: }
	@ sp needed	@
@ Forging.c:183:     Text_Display(text, mapOut + 2);
	adds	r1, r5, #4	@ tmp205, mapOut,
	ldr	r0, [sp]	@, %sfp
	ldr	r3, .L89+40	@ tmp206,
	bl	.L25		@
@ Forging.c:185:     DrawIcon(mapOut, GetItemIconId(item), 0x4000);
	movs	r0, r4	@, item
	ldr	r3, .L89+44	@ tmp207,
	bl	.L25		@
	movs	r2, #128	@,
	movs	r1, r0	@ _27, tmp230
	ldr	r3, .L89+48	@ tmp209,
	movs	r0, r5	@, mapOut
	lsls	r2, r2, #7	@,,
	bl	.L25		@
@ Forging.c:186: }
	pop	{r0, r1, r2, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L90:
	.align	2
.L89:
	.word	GetItemAttributes
	.word	Text_Clear
	.word	Text_SetColorId
	.word	GetItemName
	.word	Text_DrawString
	.word	GetItemMight
	.word	DrawSpecialUiChar
	.word	GetItemUses
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
@ Forging.c:189:     if (GetItemAttributes(item) & IA_UNBREAKABLE)
	ldr	r3, .L96	@ tmp120,
@ Forging.c:188: u16 GetItemAfterUse(int item) {
	movs	r4, r0	@ item, tmp129
@ Forging.c:189:     if (GetItemAttributes(item) & IA_UNBREAKABLE)
	bl	.L25		@
@ Forging.c:189:     if (GetItemAttributes(item) & IA_UNBREAKABLE)
	lsls	r3, r0, #28	@ tmp131, tmp130,
	bpl	.L92		@,
.L95:
@ Forging.c:197:     return item; // return used item
	lsls	r0, r4, #16	@ <retval>, item,
	lsrs	r0, r0, #16	@ <retval>, <retval>,
	b	.L93		@
.L92:
@ Forging.c:192:     item -= (1 << 8); // lose one use
	subs	r4, r4, #1	@ item,
	subs	r4, r4, #255	@ item,
@ Forging.c:194:     if (ITEM_USES(item) < 1)
	lsls	r3, r4, #18	@ tmp126, item,
	lsrs	r3, r3, #26	@ tmp125, tmp126,
@ Forging.c:195:         return 0; // return no item if uses < 0
	subs	r0, r3, #0	@ <retval>, tmp125,
@ Forging.c:194:     if (ITEM_USES(item) < 1)
	bne	.L95		@,
.L93:
@ Forging.c:198: }
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L97:
	.align	2
.L96:
	.word	GetItemAttributes
	.size	GetItemAfterUse, .-GetItemAfterUse
	.ident	"GCC: (devkitARM release 54) 10.1.0"
	.code 16
	.align	1
.L25:
	bx	r3
.L26:
	bx	r6
.L27:
	bx	r7
