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
	movs	r6, r0	@ text, tmp187
	movs	r5, r3	@ mapOut, tmp190
@ Forging.c:69: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	movs	r0, r1	@, item
	ldr	r3, .L23	@ tmp142,
@ Forging.c:67: void DrawItemMenuLine(struct TextHandle* text, int item, s8 isUsable, u16* mapOut) {
	str	r2, [sp, #4]	@ tmp189, %sfp
	movs	r4, r1	@ item, tmp188
@ Forging.c:69: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	bl	.L25		@
@ Forging.c:69: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	movs	r3, #128	@ tmp143,
	movs	r7, r0	@ isItemAnAccessory, tmp191
	lsls	r3, r3, #15	@ tmp143, tmp143,
	movs	r2, #0	@ textColor,
	ands	r7, r3	@ isItemAnAccessory, tmp143
@ Forging.c:73: 	if (isItemAnAccessory) { // Vesly added 
	tst	r0, r3	@ tmp191, tmp143
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
	ldr	r3, .L23+4	@ tmp144,
	bl	.L25		@
@ Forging.c:83: 	Text_DrawString(text, GetItemName(item));
	ldr	r3, .L23+8	@ tmp145,
	movs	r0, r4	@, item
	bl	.L25		@
@ Forging.c:83: 	Text_DrawString(text, GetItemName(item));
	ldr	r3, .L23+12	@ tmp146,
@ Forging.c:83: 	Text_DrawString(text, GetItemName(item));
	movs	r1, r0	@ _4, tmp192
@ Forging.c:83: 	Text_DrawString(text, GetItemName(item));
	movs	r0, r6	@, text
	bl	.L25		@
@ Forging.c:86: 	Text_Display(text, mapOut + 2);
	movs	r0, r6	@, text
	ldr	r3, .L23+16	@ tmp148,
	adds	r1, r5, #4	@ tmp147, mapOut,
	bl	.L25		@
	ldr	r6, .L23+20	@ tmp181,
@ Forging.c:89: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, (GetItemUses(item)&0x3F));
	cmp	r7, #0	@ isItemAnAccessory,
	beq	.L4		@,
@ Forging.c:89: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, (GetItemUses(item)&0x3F));
	movs	r0, r4	@, item
	bl	.L26		@
@ Forging.c:89: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, (GetItemUses(item)&0x3F));
	cmp	r0, #254	@ tmp193,
	bne	.L4		@,
@ Forging.c:89: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, (GetItemUses(item)&0x3F));
	ldr	r7, [sp, #4]	@ tmp183, %sfp
@ Forging.c:89: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, (GetItemUses(item)&0x3F));
	movs	r0, r4	@, item
@ Forging.c:89: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, (GetItemUses(item)&0x3F));
	subs	r3, r7, #1	@ tmp184, tmp183
	sbcs	r7, r7, r3	@ tmp183, tmp183, tmp184
@ Forging.c:89: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, (GetItemUses(item)&0x3F));
	ldr	r3, .L23+24	@ tmp150,
	bl	.L25		@
@ Forging.c:89: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, (GetItemUses(item)&0x3F));
	movs	r2, #63	@ tmp152,
	ands	r2, r0	@ tmp151, tmp194
	movs	r0, r5	@ _7, mapOut
	adds	r7, r7, #1	@ iftmp.0_22,
	movs	r1, r7	@, iftmp.0_22
	ldr	r3, .L23+28	@ tmp153,
	adds	r0, r0, #22	@ _7,
	bl	.L25		@
.L4:
@ Forging.c:92: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	movs	r0, r4	@, item
	ldr	r7, .L23	@ tmp154,
	bl	.L27		@
@ Forging.c:92: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	movs	r3, #1	@ iftmp.1_23,
	str	r3, [sp]	@ iftmp.1_23, %sfp
	lsls	r3, r0, #9	@ tmp205, tmp195,
	bpl	.L7		@,
@ Forging.c:92: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	movs	r0, r4	@, item
	bl	.L27		@
@ Forging.c:92: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	movs	r3, #192	@ tmp159,
	lsls	r3, r3, #17	@ tmp159, tmp159,
	ands	r0, r3	@ tmp158, tmp159
@ Forging.c:92: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	subs	r3, r0, #1	@ tmp162, tmp158
	sbcs	r0, r0, r3	@ tmp158, tmp158, tmp162
	str	r0, [sp]	@ tmp158, %sfp
.L7:
@ Forging.c:92: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	movs	r0, r4	@, item
	bl	.L26		@
@ Forging.c:92: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	cmp	r0, #254	@ tmp197,
	beq	.L8		@,
	ldr	r3, [sp]	@ iftmp.1_23, %sfp
	cmp	r3, #0	@ iftmp.1_23,
	beq	.L8		@,
@ Forging.c:92: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	ldr	r6, [sp, #4]	@ isUsable, %sfp
	movs	r0, r4	@, item
	subs	r3, r6, #1	@ tmp186, isUsable
	sbcs	r6, r6, r3	@ isUsable, isUsable, tmp186
	ldr	r3, .L23+24	@ tmp176,
	bl	.L25		@
	movs	r2, r0	@ _19, tmp198
	movs	r0, r5	@ _18, mapOut
	adds	r6, r6, #1	@ iftmp.2_24,
	movs	r1, r6	@, iftmp.2_24
	ldr	r3, .L23+28	@ tmp177,
	adds	r0, r0, #22	@ _18,
	bl	.L25		@
.L8:
@ Forging.c:96: }
	@ sp needed	@
@ Forging.c:94: 	DrawIcon(mapOut, GetItemIconId(item), 0x4000);
	movs	r0, r4	@, item
	ldr	r3, .L23+32	@ tmp178,
	bl	.L25		@
	movs	r2, #128	@,
	movs	r1, r0	@ _20, tmp199
	ldr	r3, .L23+36	@ tmp180,
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
	movs	r6, r0	@ text, tmp221
	movs	r5, r3	@ mapOut, tmp224
@ Forging.c:100: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	movs	r0, r1	@, item
	ldr	r3, .L50	@ tmp155,
@ Forging.c:98: void DrawItemMenuLineLong(struct TextHandle* text, int item, s8 isUsable, u16* mapOut) {
	str	r2, [sp, #4]	@ tmp223, %sfp
	movs	r4, r1	@ item, tmp222
@ Forging.c:100: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	bl	.L25		@
@ Forging.c:100: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	movs	r3, #128	@ tmp156,
	movs	r7, r0	@ isItemAnAccessory, tmp225
	lsls	r3, r3, #15	@ tmp156, tmp156,
@ Forging.c:102: 	int textColor = TEXT_COLOR_NORMAL;
	movs	r2, #0	@ textColor,
@ Forging.c:100: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	ands	r7, r3	@ isItemAnAccessory, tmp156
@ Forging.c:104: 	if (isItemAnAccessory) { // Vesly added 
	tst	r0, r3	@ tmp225, tmp156
	beq	.L29		@,
@ Forging.c:106: 		if(ITEM_EQUIPPED(item)) textColor = TEXT_COLOR_GOLD;
	asrs	r3, r4, #15	@ tmp157, item,
@ Forging.c:106: 		if(ITEM_EQUIPPED(item)) textColor = TEXT_COLOR_GOLD;
	adds	r2, r2, #3	@ textColor,
@ Forging.c:106: 		if(ITEM_EQUIPPED(item)) textColor = TEXT_COLOR_GOLD;
	cmp	r3, #0	@ tmp157,
	bne	.L29		@,
@ Forging.c:105: 		if(!isUsable) textColor = TEXT_COLOR_GRAY;
	ldr	r3, [sp, #4]	@ isUsable, %sfp
	rsbs	r2, r3, #0	@ textColor, isUsable
	adcs	r2, r2, r3	@ textColor, isUsable
.L29:
@ Forging.c:108: 	Text_SetParameters(text, 0, textColor);
	movs	r1, #0	@,
	ldr	r3, .L50+4	@ tmp161,
	movs	r0, r6	@, text
	bl	.L25		@
@ Forging.c:110: 	Text_DrawString(text, GetItemName(item));
	ldr	r3, .L50+8	@ tmp162,
	movs	r0, r4	@, item
	bl	.L25		@
@ Forging.c:110: 	Text_DrawString(text, GetItemName(item));
	ldr	r3, .L50+12	@ tmp163,
@ Forging.c:110: 	Text_DrawString(text, GetItemName(item));
	movs	r1, r0	@ _4, tmp226
@ Forging.c:110: 	Text_DrawString(text, GetItemName(item));
	movs	r0, r6	@, text
	bl	.L25		@
@ Forging.c:113: 	Text_Display(text, mapOut + 2);
	movs	r0, r6	@, text
	ldr	r3, .L50+16	@ tmp165,
	adds	r1, r5, #4	@ tmp164, mapOut,
	bl	.L25		@
@ Forging.c:115: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) { // Vesly 
	cmp	r7, #0	@ isItemAnAccessory,
	beq	.L31		@,
@ Forging.c:115: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) { // Vesly 
	movs	r0, r4	@, item
	ldr	r3, .L50+20	@ tmp166,
	bl	.L25		@
@ Forging.c:115: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) { // Vesly 
	cmp	r0, #254	@ tmp227,
	bne	.L31		@,
@ Forging.c:117: 		DrawUiNumberOrDoubleDashes(mapOut + 10, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, (GetItemUses(item)&0x3F));
	ldr	r6, [sp, #4]	@ tmp217, %sfp
@ Forging.c:117: 		DrawUiNumberOrDoubleDashes(mapOut + 10, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, (GetItemUses(item)&0x3F));
	movs	r0, r4	@, item
@ Forging.c:117: 		DrawUiNumberOrDoubleDashes(mapOut + 10, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, (GetItemUses(item)&0x3F));
	subs	r3, r6, #1	@ tmp218, tmp217
	sbcs	r6, r6, r3	@ tmp217, tmp217, tmp218
@ Forging.c:117: 		DrawUiNumberOrDoubleDashes(mapOut + 10, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, (GetItemUses(item)&0x3F));
	ldr	r3, .L50+24	@ tmp167,
	bl	.L25		@
@ Forging.c:117: 		DrawUiNumberOrDoubleDashes(mapOut + 10, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, (GetItemUses(item)&0x3F));
	movs	r7, #63	@ tmp169,
	movs	r2, r0	@ tmp228, tmp228
	movs	r0, r5	@ _7, mapOut
	adds	r6, r6, #1	@ iftmp.3_34,
	movs	r1, r6	@, iftmp.3_34
	ands	r2, r7	@ tmp228, tmp169
	ldr	r3, .L50+28	@ tmp252,
	adds	r0, r0, #20	@ _7,
	bl	.L25		@
@ Forging.c:118: 		DrawUiNumberOrDoubleDashes(mapOut + 13, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, (GetItemMaxUses(item)&0x3F));
	ldr	r3, .L50+32	@ tmp171,
	movs	r0, r4	@, item
	bl	.L25		@
@ Forging.c:118: 		DrawUiNumberOrDoubleDashes(mapOut + 13, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, (GetItemMaxUses(item)&0x3F));
	movs	r2, r0	@ tmp229, tmp229
	movs	r0, r5	@ tmp174, mapOut
	movs	r1, r6	@, iftmp.3_34
	ldr	r3, .L50+28	@ tmp256,
	ands	r2, r7	@ tmp229, tmp169
	adds	r0, r0, #26	@ tmp174,
	bl	.L25		@
@ Forging.c:119: 		DrawSpecialUiChar(mapOut + 11, isUsable ? TEXT_COLOR_NORMAL : TEXT_COLOR_GRAY, 0x16); // draw special character?
	movs	r2, #22	@,
	ldr	r3, [sp, #4]	@ isUsable, %sfp
	adds	r0, r5, r2	@ tmp179, tmp179,
	rsbs	r1, r3, #0	@ tmp177, isUsable
	adcs	r1, r1, r3	@ tmp177, isUsable
	ldr	r3, .L50+36	@ tmp180,
	bl	.L25		@
.L31:
@ Forging.c:123: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r0, r4	@, item
	ldr	r7, .L50	@ tmp181,
	bl	.L27		@
@ Forging.c:123: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r6, #1	@ iftmp.5_35,
	lsls	r3, r0, #9	@ tmp246, tmp230,
	bpl	.L34		@,
@ Forging.c:123: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r0, r4	@, item
@ Forging.c:123: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r6, #192	@ tmp186,
@ Forging.c:123: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	bl	.L27		@
@ Forging.c:123: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	lsls	r6, r6, #17	@ tmp186, tmp186,
	ands	r6, r0	@ tmp185, tmp231
@ Forging.c:123: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	subs	r3, r6, #1	@ tmp189, tmp185
	sbcs	r6, r6, r3	@ iftmp.5_35, tmp185, tmp189
.L34:
@ Forging.c:123: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r0, r4	@, item
	ldr	r3, .L50+20	@ tmp190,
	bl	.L25		@
@ Forging.c:123: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	cmp	r0, #254	@ tmp232,
	beq	.L35		@,
	cmp	r6, #0	@ iftmp.5_35,
	beq	.L35		@,
@ Forging.c:124: 		DrawUiNumberOrDoubleDashes(mapOut + 10, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	ldr	r6, [sp, #4]	@ tmp219, %sfp
	movs	r0, r4	@, item
	subs	r3, r6, #1	@ tmp220, tmp219
	sbcs	r6, r6, r3	@ tmp219, tmp219, tmp220
	ldr	r3, .L50+24	@ tmp203,
	bl	.L25		@
	movs	r2, r0	@ _25, tmp233
	movs	r0, r5	@ _24, mapOut
	adds	r6, r6, #1	@ iftmp.6_36,
	movs	r1, r6	@, iftmp.6_36
	ldr	r7, .L50+28	@ tmp204,
	adds	r0, r0, #20	@ _24,
	bl	.L27		@
@ Forging.c:125: 		DrawUiNumberOrDoubleDashes(mapOut + 13, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemMaxUses(item));
	ldr	r3, .L50+32	@ tmp205,
	movs	r0, r4	@, item
	bl	.L25		@
	movs	r2, r0	@ _27, tmp234
	movs	r0, r5	@ tmp206, mapOut
	movs	r1, r6	@, iftmp.6_36
	adds	r0, r0, #26	@ tmp206,
	bl	.L27		@
@ Forging.c:126: 		DrawSpecialUiChar(mapOut + 11, isUsable ? TEXT_COLOR_NORMAL : TEXT_COLOR_GRAY, 0x16); // draw special character?
	movs	r2, #22	@,
	ldr	r1, [sp, #4]	@ isUsable, %sfp
	adds	r0, r5, r2	@ tmp211, tmp211,
	rsbs	r3, r1, #0	@ tmp210, isUsable
	adcs	r1, r1, r3	@ isUsable, isUsable, tmp210
	ldr	r3, .L50+36	@ tmp212,
	bl	.L25		@
.L35:
@ Forging.c:132: }
	@ sp needed	@
@ Forging.c:131:     DrawIcon(mapOut, GetItemIconId(item), 0x4000);
	movs	r0, r4	@, item
	ldr	r3, .L50+40	@ tmp213,
	bl	.L25		@
	movs	r2, #128	@,
	movs	r1, r0	@ _31, tmp235
	ldr	r3, .L50+44	@ tmp215,
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
	movs	r4, r1	@ item, tmp166
@ Forging.c:135:     Text_SetXCursor(text, 0);
	ldr	r3, .L61	@ tmp134,
	movs	r1, #0	@,
@ Forging.c:134: void DrawItemMenuLineNoColor(struct TextHandle* text, int item, u16* mapOut) {
	movs	r6, r2	@ mapOut, tmp167
	movs	r5, r0	@ text, tmp165
@ Forging.c:135:     Text_SetXCursor(text, 0);
	bl	.L25		@
@ Forging.c:136:     Text_DrawString(text, GetItemName(item));
	ldr	r3, .L61+4	@ tmp135,
	movs	r0, r4	@, item
	bl	.L25		@
@ Forging.c:136:     Text_DrawString(text, GetItemName(item));
	ldr	r3, .L61+8	@ tmp136,
@ Forging.c:136:     Text_DrawString(text, GetItemName(item));
	movs	r1, r0	@ _1, tmp168
@ Forging.c:136:     Text_DrawString(text, GetItemName(item));
	movs	r0, r5	@, text
	bl	.L25		@
@ Forging.c:137: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	movs	r0, r4	@, item
	ldr	r7, .L61+12	@ tmp137,
	bl	.L27		@
@ Forging.c:138:     Text_Display(text, mapOut + 2);
	movs	r0, r5	@, text
	ldr	r3, .L61+16	@ tmp139,
	adds	r1, r6, #4	@ tmp138, mapOut,
	bl	.L25		@
@ Forging.c:141: 	if ((GetItemAttributes(item) & IA_ACCESSORY) && (GetItemMight(item) == 0xFE)) { // Vesly - berries 
	movs	r0, r4	@, item
	bl	.L27		@
@ Forging.c:141: 	if ((GetItemAttributes(item) & IA_ACCESSORY) && (GetItemMight(item) == 0xFE)) { // Vesly - berries 
	lsls	r3, r0, #9	@ tmp183, tmp169,
	bpl	.L54		@,
@ Forging.c:141: 	if ((GetItemAttributes(item) & IA_ACCESSORY) && (GetItemMight(item) == 0xFE)) { // Vesly - berries 
	movs	r0, r4	@, item
	ldr	r3, .L61+20	@ tmp143,
	bl	.L25		@
@ Forging.c:141: 	if ((GetItemAttributes(item) & IA_ACCESSORY) && (GetItemMight(item) == 0xFE)) { // Vesly - berries 
	cmp	r0, #254	@ tmp170,
	bne	.L54		@,
@ Forging.c:142: 		DrawSpecialUiChar(mapOut + 11, Text_GetColorId(text), (GetItemUses(item)&0x3F));
	ldr	r3, .L61+24	@ tmp144,
	movs	r0, r5	@, text
	bl	.L25		@
@ Forging.c:142: 		DrawSpecialUiChar(mapOut + 11, Text_GetColorId(text), (GetItemUses(item)&0x3F));
	ldr	r3, .L61+28	@ tmp145,
@ Forging.c:142: 		DrawSpecialUiChar(mapOut + 11, Text_GetColorId(text), (GetItemUses(item)&0x3F));
	str	r0, [sp, #4]	@ tmp171, %sfp
@ Forging.c:142: 		DrawSpecialUiChar(mapOut + 11, Text_GetColorId(text), (GetItemUses(item)&0x3F));
	movs	r0, r4	@, item
	bl	.L25		@
@ Forging.c:142: 		DrawSpecialUiChar(mapOut + 11, Text_GetColorId(text), (GetItemUses(item)&0x3F));
	movs	r2, #63	@ tmp147,
	ands	r2, r0	@ tmp146, tmp172
	movs	r0, r6	@ tmp148, mapOut
	ldr	r1, [sp, #4]	@, %sfp
	ldr	r3, .L61+32	@ tmp149,
	adds	r0, r0, #22	@ tmp148,
	bl	.L25		@
.L54:
@ Forging.c:146: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) && (GetItemMight(item) != 0xFE)) {
	movs	r0, r4	@, item
	bl	.L27		@
@ Forging.c:146: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) && (GetItemMight(item) != 0xFE)) {
	lsls	r3, r0, #9	@ tmp184, tmp173,
	bmi	.L56		@,
.L59:
@ Forging.c:146: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) && (GetItemMight(item) != 0xFE)) {
	movs	r0, r4	@, item
	ldr	r3, .L61+20	@ tmp153,
	bl	.L25		@
@ Forging.c:146: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) && (GetItemMight(item) != 0xFE)) {
	cmp	r0, #254	@ tmp174,
	beq	.L60		@,
@ Forging.c:147: 		DrawSpecialUiChar(mapOut + 11, Text_GetColorId(text), GetItemUses(item));
	movs	r0, r5	@, text
	ldr	r3, .L61+24	@ tmp157,
	bl	.L25		@
	ldr	r3, .L61+28	@ tmp158,
	movs	r5, r0	@ _16, tmp176
	movs	r0, r4	@, item
	bl	.L25		@
	movs	r2, r0	@ _17, tmp177
	movs	r0, r6	@ tmp159, mapOut
	movs	r1, r5	@, _16
	ldr	r3, .L61+32	@ tmp160,
	adds	r0, r0, #22	@ tmp159,
	bl	.L25		@
	b	.L60		@
.L56:
@ Forging.c:146: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) && (GetItemMight(item) != 0xFE)) {
	movs	r0, r4	@, item
	bl	.L27		@
@ Forging.c:146: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) && (GetItemMight(item) != 0xFE)) {
	movs	r3, #192	@ tmp156,
	lsls	r3, r3, #17	@ tmp156, tmp156,
@ Forging.c:146: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) && (GetItemMight(item) != 0xFE)) {
	tst	r0, r3	@ tmp175, tmp156
	bne	.L59		@,
.L60:
@ Forging.c:151: }
	@ sp needed	@
@ Forging.c:150:     DrawIcon(mapOut, GetItemIconId(item), 0x4000);
	movs	r0, r4	@, item
	ldr	r3, .L61+36	@ tmp161,
	bl	.L25		@
	movs	r2, #128	@,
	movs	r1, r0	@ _18, tmp178
	ldr	r3, .L61+40	@ tmp163,
	movs	r0, r6	@, mapOut
	lsls	r2, r2, #7	@,,
	bl	.L25		@
@ Forging.c:151: }
	pop	{r0, r1, r2, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L62:
	.align	2
.L61:
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
@ Forging.c:153: void DrawItemStatScreenLine(struct TextHandle* text, int item, int nameColor, u16* mapOut) {
	movs	r6, r3	@ mapOut, tmp210
	str	r0, [sp, #4]	@ tmp207, %sfp
@ Forging.c:155: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	ldr	r3, .L80	@ tmp151,
	movs	r0, r1	@, item
@ Forging.c:155: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	movs	r7, #128	@ tmp152,
@ Forging.c:153: void DrawItemStatScreenLine(struct TextHandle* text, int item, int nameColor, u16* mapOut) {
	movs	r4, r1	@ item, tmp208
	movs	r5, r2	@ nameColor, tmp209
@ Forging.c:155: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	bl	.L25		@
@ Forging.c:155: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	lsls	r7, r7, #15	@ tmp152, tmp152,
@ Forging.c:157:     Text_Clear(text);
	ldr	r3, .L80+4	@ tmp153,
@ Forging.c:155: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	ands	r7, r0	@ isItemAnAccessory, tmp211
@ Forging.c:157:     Text_Clear(text);
	ldr	r0, [sp, #4]	@, %sfp
	bl	.L25		@
	movs	r1, r5	@ color, nameColor
@ Forging.c:161: 	if (isItemAnAccessory) { // Vesly 
	cmp	r7, #0	@ isItemAnAccessory,
	beq	.L64		@,
@ Forging.c:162: 		if(ITEM_EQUIPPED(item) & (nameColor != TEXT_COLOR_GREEN)) color = TEXT_COLOR_GOLD;
	subs	r2, r5, #4	@ tmp157, nameColor,
	subs	r1, r2, #1	@ tmp158, tmp157
	sbcs	r2, r2, r1	@ tmp156, tmp157, tmp158
@ Forging.c:162: 		if(ITEM_EQUIPPED(item) & (nameColor != TEXT_COLOR_GREEN)) color = TEXT_COLOR_GOLD;
	asrs	r3, r4, #15	@ tmp154, item,
@ Forging.c:162: 		if(ITEM_EQUIPPED(item) & (nameColor != TEXT_COLOR_GREEN)) color = TEXT_COLOR_GOLD;
	movs	r1, #3	@ color,
@ Forging.c:162: 		if(ITEM_EQUIPPED(item) & (nameColor != TEXT_COLOR_GREEN)) color = TEXT_COLOR_GOLD;
	tst	r2, r3	@ tmp156, tmp154
	bne	.L64		@,
	movs	r1, r5	@ color, nameColor
.L64:
@ Forging.c:164:     Text_SetColorId(text, color);
	ldr	r3, .L80+8	@ tmp160,
	ldr	r0, [sp, #4]	@, %sfp
	bl	.L25		@
@ Forging.c:166:     Text_DrawString(text, GetItemName(item));
	ldr	r3, .L80+12	@ tmp161,
	movs	r0, r4	@, item
	bl	.L25		@
@ Forging.c:166:     Text_DrawString(text, GetItemName(item));
	ldr	r3, .L80+16	@ tmp162,
@ Forging.c:166:     Text_DrawString(text, GetItemName(item));
	movs	r1, r0	@ _7, tmp212
@ Forging.c:166:     Text_DrawString(text, GetItemName(item));
	ldr	r0, [sp, #4]	@, %sfp
	bl	.L25		@
@ Forging.c:169: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) { // Vesly - berries 
	cmp	r7, #0	@ isItemAnAccessory,
	beq	.L66		@,
@ Forging.c:169: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) { // Vesly - berries 
	movs	r0, r4	@, item
	ldr	r3, .L80+20	@ tmp163,
	bl	.L25		@
@ Forging.c:169: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) { // Vesly - berries 
	cmp	r0, #254	@ tmp213,
	bne	.L66		@,
@ Forging.c:171: 		DrawSpecialUiChar(mapOut + 12, color, 0x16);
	movs	r0, r6	@ tmp168, mapOut
@ Forging.c:170: 		color = (nameColor == TEXT_COLOR_GRAY) ? TEXT_COLOR_GRAY : TEXT_COLOR_NORMAL;
	subs	r7, r5, #1	@ tmp166, nameColor,
	rsbs	r1, r7, #0	@ color, tmp166
	adcs	r1, r1, r7	@ color, tmp166
@ Forging.c:171: 		DrawSpecialUiChar(mapOut + 12, color, 0x16);
	movs	r2, #22	@,
	ldr	r3, .L80+24	@ tmp169,
	adds	r0, r0, #24	@ tmp168,
	bl	.L25		@
@ Forging.c:173: 		color = (nameColor != TEXT_COLOR_GRAY) ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY;
	subs	r3, r7, #1	@ tmp206, tmp166
	sbcs	r7, r7, r3	@ tmp204, tmp166, tmp206
@ Forging.c:174: 		DrawUiNumberOrDoubleDashes(mapOut + 11, color, (GetItemUses(item)&0x3F));
	movs	r0, r4	@, item
	ldr	r3, .L80+28	@ tmp170,
	bl	.L25		@
@ Forging.c:174: 		DrawUiNumberOrDoubleDashes(mapOut + 11, color, (GetItemUses(item)&0x3F));
	movs	r2, #63	@ tmp171,
	ands	r2, r0	@ tmp171, tmp214
	movs	r0, r6	@ tmp173, mapOut
@ Forging.c:173: 		color = (nameColor != TEXT_COLOR_GRAY) ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY;
	adds	r7, r7, #1	@ iftmp.8_31,
@ Forging.c:174: 		DrawUiNumberOrDoubleDashes(mapOut + 11, color, (GetItemUses(item)&0x3F));
	movs	r1, r7	@, iftmp.8_31
	ldr	r3, .L80+32	@ tmp236,
	adds	r0, r0, #22	@ tmp173,
	bl	.L25		@
@ Forging.c:175: 		DrawUiNumberOrDoubleDashes(mapOut + 14, color, (GetItemMaxUses(item)&0x3F));
	ldr	r3, .L80+36	@ tmp175,
	movs	r0, r4	@, item
	bl	.L25		@
@ Forging.c:175: 		DrawUiNumberOrDoubleDashes(mapOut + 14, color, (GetItemMaxUses(item)&0x3F));
	movs	r2, #63	@ tmp176,
	ands	r2, r0	@ tmp176, tmp215
	movs	r0, r6	@ tmp178, mapOut
	movs	r1, r7	@, iftmp.8_31
	ldr	r3, .L80+32	@ tmp240,
	adds	r0, r0, #28	@ tmp178,
	bl	.L25		@
.L66:
@ Forging.c:180: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) && (GetItemMight(item) != 0xFE)) {
	movs	r0, r4	@, item
	ldr	r7, .L80	@ tmp180,
	bl	.L27		@
@ Forging.c:180: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) && (GetItemMight(item) != 0xFE)) {
	lsls	r3, r0, #9	@ tmp232, tmp216,
	bmi	.L69		@,
.L72:
@ Forging.c:180: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) && (GetItemMight(item) != 0xFE)) {
	movs	r0, r4	@, item
	ldr	r3, .L80+20	@ tmp183,
	bl	.L25		@
@ Forging.c:180: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) && (GetItemMight(item) != 0xFE)) {
	cmp	r0, #254	@ tmp217,
	beq	.L73		@,
@ Forging.c:182: 		DrawSpecialUiChar(mapOut + 12, color, 0x16);
	movs	r0, r6	@ tmp191, mapOut
@ Forging.c:181: 		color = (nameColor == TEXT_COLOR_GRAY) ? TEXT_COLOR_GRAY : TEXT_COLOR_NORMAL;
	subs	r1, r5, #1	@ tmp189, nameColor,
	rsbs	r3, r1, #0	@ tmp190, tmp189
	adcs	r1, r1, r3	@ color, tmp189, tmp190
@ Forging.c:182: 		DrawSpecialUiChar(mapOut + 12, color, 0x16);
	movs	r2, #22	@,
	ldr	r3, .L80+24	@ tmp192,
	adds	r0, r0, #24	@ tmp191,
	bl	.L25		@
@ Forging.c:184: 		color = (nameColor != TEXT_COLOR_GRAY) ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY;
	cmp	r5, #1	@ nameColor,
	beq	.L74		@,
	movs	r5, #2	@ nameColor,
.L74:
@ Forging.c:185: 		DrawUiNumberOrDoubleDashes(mapOut + 11, color, GetItemUses(item));
	ldr	r3, .L80+28	@ tmp193,
	movs	r0, r4	@, item
	bl	.L25		@
	movs	r2, r0	@ _25, tmp219
	movs	r0, r6	@ tmp194, mapOut
	movs	r1, r5	@, nameColor
	ldr	r7, .L80+32	@ tmp195,
	adds	r0, r0, #22	@ tmp194,
	bl	.L27		@
@ Forging.c:186: 		DrawUiNumberOrDoubleDashes(mapOut + 14, color, GetItemMaxUses(item));
	movs	r0, r4	@, item
	ldr	r3, .L80+36	@ tmp196,
	bl	.L25		@
	movs	r2, r0	@ _27, tmp220
	movs	r0, r6	@ tmp197, mapOut
	movs	r1, r5	@, nameColor
	adds	r0, r0, #28	@ tmp197,
	bl	.L27		@
	b	.L73		@
.L69:
@ Forging.c:180: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) && (GetItemMight(item) != 0xFE)) {
	movs	r0, r4	@, item
	bl	.L27		@
@ Forging.c:180: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) && (GetItemMight(item) != 0xFE)) {
	movs	r3, #192	@ tmp186,
	lsls	r3, r3, #17	@ tmp186, tmp186,
@ Forging.c:180: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) && (GetItemMight(item) != 0xFE)) {
	tst	r0, r3	@ tmp218, tmp186
	bne	.L72		@,
.L73:
@ Forging.c:191: }
	@ sp needed	@
@ Forging.c:188:     Text_Display(text, mapOut + 2);
	adds	r1, r6, #4	@ tmp199, mapOut,
	ldr	r0, [sp, #4]	@, %sfp
	ldr	r3, .L80+40	@ tmp200,
	bl	.L25		@
@ Forging.c:190:     DrawIcon(mapOut, GetItemIconId(item), 0x4000);
	movs	r0, r4	@, item
	ldr	r3, .L80+44	@ tmp201,
	bl	.L25		@
	movs	r2, #128	@,
	movs	r1, r0	@ _29, tmp221
	ldr	r3, .L80+48	@ tmp203,
	movs	r0, r6	@, mapOut
	lsls	r2, r2, #7	@,,
	bl	.L25		@
@ Forging.c:191: }
	pop	{r0, r1, r2, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L81:
	.align	2
.L80:
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
@ Forging.c:195:     if (GetItemAttributes(item) & IA_UNBREAKABLE) {
	ldr	r3, .L87	@ tmp120,
@ Forging.c:194: u16 GetItemAfterUse(int item) {
	movs	r4, r0	@ item, tmp129
@ Forging.c:195:     if (GetItemAttributes(item) & IA_UNBREAKABLE) {
	bl	.L25		@
@ Forging.c:195:     if (GetItemAttributes(item) & IA_UNBREAKABLE) {
	lsls	r3, r0, #28	@ tmp131, tmp130,
	bpl	.L83		@,
.L86:
@ Forging.c:206:     return item; // return used item
	lsls	r0, r4, #16	@ <retval>, item,
	lsrs	r0, r0, #16	@ <retval>, <retval>,
	b	.L84		@
.L83:
@ Forging.c:201:     item -= (1 << 8); // lose one use
	subs	r4, r4, #1	@ item,
	subs	r4, r4, #255	@ item,
@ Forging.c:203:     if (ITEM_USES(item) < 1)
	lsls	r3, r4, #18	@ tmp126, item,
	lsrs	r3, r3, #26	@ tmp125, tmp126,
@ Forging.c:204:         return 0; // return no item if uses < 0
	subs	r0, r3, #0	@ <retval>, tmp125,
@ Forging.c:203:     if (ITEM_USES(item) < 1)
	bne	.L86		@,
.L84:
@ Forging.c:207: }
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L88:
	.align	2
.L87:
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
