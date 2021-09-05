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
	movs	r6, r0	@ text, tmp182
	movs	r5, r3	@ mapOut, tmp185
@ Forging.c:67: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	movs	r0, r1	@, item
	ldr	r3, .L29	@ tmp141,
@ Forging.c:65: void DrawItemMenuLine(struct TextHandle* text, int item, s8 isUsable, u16* mapOut) {
	str	r2, [sp, #4]	@ tmp184, %sfp
	movs	r4, r1	@ item, tmp183
@ Forging.c:67: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	bl	.L6		@
@ Forging.c:67: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	movs	r3, #128	@ tmp142,
	movs	r7, r0	@ isItemAnAccessory, tmp186
	lsls	r3, r3, #15	@ tmp142, tmp142,
	movs	r2, #0	@ textColor,
	ands	r7, r3	@ isItemAnAccessory, tmp142
@ Forging.c:71: 	if (isItemAnAccessory) { // Vesly added 
	tst	r0, r3	@ tmp186, tmp142
	beq	.L8		@,
@ Forging.c:75: 		if(ITEM_EQUIPPED(item)) textColor = TEXT_COLOR_GOLD;
	asrs	r2, r4, #15	@ textColor, item,
@ Forging.c:75: 		if(ITEM_EQUIPPED(item)) textColor = TEXT_COLOR_GOLD;
	beq	.L8		@,
@ Forging.c:75: 		if(ITEM_EQUIPPED(item)) textColor = TEXT_COLOR_GOLD;
	movs	r2, #3	@ textColor,
.L8:
@ Forging.c:78: 	Text_SetParameters(text, 0, textColor);
	movs	r1, #0	@,
	movs	r0, r6	@, text
	ldr	r3, .L29+4	@ tmp143,
	bl	.L6		@
@ Forging.c:81: 	Text_DrawString(text, GetItemName(item));
	ldr	r3, .L29+8	@ tmp144,
	movs	r0, r4	@, item
	bl	.L6		@
@ Forging.c:81: 	Text_DrawString(text, GetItemName(item));
	ldr	r3, .L29+12	@ tmp145,
@ Forging.c:81: 	Text_DrawString(text, GetItemName(item));
	movs	r1, r0	@ _4, tmp187
@ Forging.c:81: 	Text_DrawString(text, GetItemName(item));
	movs	r0, r6	@, text
	bl	.L6		@
@ Forging.c:84: 	Text_Display(text, mapOut + 2);
	movs	r0, r6	@, text
	ldr	r3, .L29+16	@ tmp147,
	adds	r1, r5, #4	@ tmp146, mapOut,
	bl	.L6		@
	ldr	r6, .L29+20	@ tmp176,
@ Forging.c:87: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	cmp	r7, #0	@ isItemAnAccessory,
	beq	.L10		@,
@ Forging.c:87: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	movs	r0, r4	@, item
	bl	.L31		@
@ Forging.c:87: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	cmp	r0, #254	@ tmp188,
	bne	.L10		@,
@ Forging.c:87: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	movs	r0, r4	@, item
	ldr	r7, [sp, #4]	@ tmp178, %sfp
	bl	GetItemUses		@
	subs	r3, r7, #1	@ tmp179, tmp178
	sbcs	r7, r7, r3	@ tmp178, tmp178, tmp179
	movs	r2, r0	@ _8, tmp189
	movs	r0, r5	@ _7, mapOut
	adds	r7, r7, #1	@ iftmp.0_21,
	movs	r1, r7	@, iftmp.0_21
	ldr	r3, .L29+24	@ tmp149,
	adds	r0, r0, #22	@ _7,
	bl	.L6		@
.L10:
@ Forging.c:90: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	movs	r0, r4	@, item
	ldr	r7, .L29	@ tmp150,
	bl	.L32		@
@ Forging.c:90: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	movs	r3, #1	@ iftmp.1_22,
	str	r3, [sp]	@ iftmp.1_22, %sfp
	lsls	r3, r0, #9	@ tmp200, tmp190,
	bpl	.L13		@,
@ Forging.c:90: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	movs	r0, r4	@, item
	bl	.L32		@
@ Forging.c:90: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	movs	r3, #192	@ tmp155,
	lsls	r3, r3, #17	@ tmp155, tmp155,
	ands	r0, r3	@ tmp154, tmp155
@ Forging.c:90: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	subs	r3, r0, #1	@ tmp158, tmp154
	sbcs	r0, r0, r3	@ tmp154, tmp154, tmp158
	str	r0, [sp]	@ tmp154, %sfp
.L13:
@ Forging.c:90: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	movs	r0, r4	@, item
	bl	.L31		@
@ Forging.c:90: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	cmp	r0, #254	@ tmp192,
	beq	.L14		@,
	ldr	r3, [sp]	@ iftmp.1_22, %sfp
	cmp	r3, #0	@ iftmp.1_22,
	beq	.L14		@,
@ Forging.c:90: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	movs	r0, r4	@, item
	ldr	r6, [sp, #4]	@ isUsable, %sfp
	bl	GetItemUses		@
	subs	r3, r6, #1	@ tmp181, isUsable
	sbcs	r6, r6, r3	@ isUsable, isUsable, tmp181
	movs	r2, r0	@ _18, tmp193
	movs	r0, r5	@ _17, mapOut
	adds	r6, r6, #1	@ iftmp.2_23,
	movs	r1, r6	@, iftmp.2_23
	ldr	r3, .L29+24	@ tmp172,
	adds	r0, r0, #22	@ _17,
	bl	.L6		@
.L14:
@ Forging.c:94: }
	@ sp needed	@
@ Forging.c:92: 	DrawIcon(mapOut, GetItemIconId(item), 0x4000);
	movs	r0, r4	@, item
	ldr	r3, .L29+28	@ tmp173,
	bl	.L6		@
	movs	r2, #128	@,
	movs	r1, r0	@ _19, tmp194
	ldr	r3, .L29+32	@ tmp175,
	movs	r0, r5	@, mapOut
	lsls	r2, r2, #7	@,,
	bl	.L6		@
@ Forging.c:94: }
	pop	{r0, r1, r2, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L30:
	.align	2
.L29:
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
@ Forging.c:96: void DrawItemMenuLineLong(struct TextHandle* text, int item, s8 isUsable, u16* mapOut) {
	movs	r6, r0	@ text, tmp214
	movs	r5, r3	@ mapOut, tmp217
@ Forging.c:98: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	movs	r0, r1	@, item
	ldr	r3, .L55	@ tmp153,
@ Forging.c:96: void DrawItemMenuLineLong(struct TextHandle* text, int item, s8 isUsable, u16* mapOut) {
	str	r2, [sp, #4]	@ tmp216, %sfp
	movs	r4, r1	@ item, tmp215
@ Forging.c:98: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	bl	.L6		@
@ Forging.c:98: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	movs	r3, #128	@ tmp154,
	movs	r7, r0	@ isItemAnAccessory, tmp218
	lsls	r3, r3, #15	@ tmp154, tmp154,
@ Forging.c:100: 	int textColor = TEXT_COLOR_NORMAL;
	movs	r2, #0	@ textColor,
@ Forging.c:98: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	ands	r7, r3	@ isItemAnAccessory, tmp154
@ Forging.c:102: 	if (isItemAnAccessory) { // Vesly added 
	tst	r0, r3	@ tmp218, tmp154
	beq	.L34		@,
@ Forging.c:104: 		if(ITEM_EQUIPPED(item)) textColor = TEXT_COLOR_GOLD;
	asrs	r3, r4, #15	@ tmp155, item,
@ Forging.c:104: 		if(ITEM_EQUIPPED(item)) textColor = TEXT_COLOR_GOLD;
	adds	r2, r2, #3	@ textColor,
@ Forging.c:104: 		if(ITEM_EQUIPPED(item)) textColor = TEXT_COLOR_GOLD;
	cmp	r3, #0	@ tmp155,
	bne	.L34		@,
@ Forging.c:103: 		if(!isUsable) textColor = TEXT_COLOR_GRAY;
	ldr	r3, [sp, #4]	@ isUsable, %sfp
	rsbs	r2, r3, #0	@ textColor, isUsable
	adcs	r2, r2, r3	@ textColor, isUsable
.L34:
@ Forging.c:106: 	Text_SetParameters(text, 0, textColor);
	movs	r1, #0	@,
	ldr	r3, .L55+4	@ tmp159,
	movs	r0, r6	@, text
	bl	.L6		@
@ Forging.c:108: 	Text_DrawString(text, GetItemName(item));
	ldr	r3, .L55+8	@ tmp160,
	movs	r0, r4	@, item
	bl	.L6		@
@ Forging.c:108: 	Text_DrawString(text, GetItemName(item));
	ldr	r3, .L55+12	@ tmp161,
@ Forging.c:108: 	Text_DrawString(text, GetItemName(item));
	movs	r1, r0	@ _4, tmp219
@ Forging.c:108: 	Text_DrawString(text, GetItemName(item));
	movs	r0, r6	@, text
	bl	.L6		@
@ Forging.c:111: 	Text_Display(text, mapOut + 2);
	movs	r0, r6	@, text
	ldr	r3, .L55+16	@ tmp163,
	adds	r1, r5, #4	@ tmp162, mapOut,
	bl	.L6		@
@ Forging.c:113: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) { // Vesly 
	cmp	r7, #0	@ isItemAnAccessory,
	beq	.L36		@,
@ Forging.c:113: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) { // Vesly 
	movs	r0, r4	@, item
	ldr	r3, .L55+20	@ tmp242,
	bl	.L6		@
@ Forging.c:113: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) { // Vesly 
	cmp	r0, #254	@ tmp220,
	bne	.L36		@,
@ Forging.c:115: 		DrawUiNumberOrDoubleDashes(mapOut + 10, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	movs	r0, r4	@, item
	ldr	r6, [sp, #4]	@ tmp210, %sfp
	bl	GetItemUses		@
	subs	r3, r6, #1	@ tmp211, tmp210
	sbcs	r6, r6, r3	@ tmp210, tmp210, tmp211
	movs	r2, r0	@ _8, tmp221
	movs	r0, r5	@ _7, mapOut
	adds	r6, r6, #1	@ iftmp.3_32,
	movs	r1, r6	@, iftmp.3_32
	ldr	r7, .L55+24	@ tmp165,
	adds	r0, r0, #20	@ _7,
	bl	.L32		@
@ Forging.c:116: 		DrawUiNumberOrDoubleDashes(mapOut + 13, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemMaxUses(item));
	ldr	r3, .L55+28	@ tmp166,
	movs	r0, r4	@, item
	bl	.L6		@
	movs	r2, r0	@ _10, tmp222
	movs	r0, r5	@ tmp167, mapOut
	movs	r1, r6	@, iftmp.3_32
	adds	r0, r0, #26	@ tmp167,
	bl	.L32		@
@ Forging.c:117: 		DrawSpecialUiChar(mapOut + 11, isUsable ? TEXT_COLOR_NORMAL : TEXT_COLOR_GRAY, 0x16); // draw special character?
	movs	r2, #22	@,
	ldr	r3, [sp, #4]	@ isUsable, %sfp
	adds	r0, r5, r2	@ tmp172, tmp172,
	rsbs	r1, r3, #0	@ tmp170, isUsable
	adcs	r1, r1, r3	@ tmp170, isUsable
	ldr	r3, .L55+32	@ tmp173,
	bl	.L6		@
.L36:
@ Forging.c:121: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r0, r4	@, item
	ldr	r7, .L55	@ tmp174,
	bl	.L32		@
@ Forging.c:121: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r6, #1	@ iftmp.5_33,
	lsls	r3, r0, #9	@ tmp239, tmp223,
	bpl	.L39		@,
@ Forging.c:121: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r0, r4	@, item
@ Forging.c:121: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r6, #192	@ tmp179,
@ Forging.c:121: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	bl	.L32		@
@ Forging.c:121: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	lsls	r6, r6, #17	@ tmp179, tmp179,
	ands	r6, r0	@ tmp178, tmp224
@ Forging.c:121: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	subs	r3, r6, #1	@ tmp182, tmp178
	sbcs	r6, r6, r3	@ iftmp.5_33, tmp178, tmp182
.L39:
@ Forging.c:121: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r0, r4	@, item
	ldr	r3, .L55+20	@ tmp249,
	bl	.L6		@
@ Forging.c:121: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	cmp	r0, #254	@ tmp225,
	beq	.L40		@,
	cmp	r6, #0	@ iftmp.5_33,
	beq	.L40		@,
@ Forging.c:122: 		DrawUiNumberOrDoubleDashes(mapOut + 10, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	movs	r0, r4	@, item
	ldr	r6, [sp, #4]	@ tmp212, %sfp
	bl	GetItemUses		@
	subs	r3, r6, #1	@ tmp213, tmp212
	sbcs	r6, r6, r3	@ tmp212, tmp212, tmp213
	movs	r2, r0	@ _23, tmp226
	movs	r0, r5	@ _22, mapOut
	adds	r6, r6, #1	@ iftmp.6_34,
	movs	r1, r6	@, iftmp.6_34
	ldr	r7, .L55+24	@ tmp196,
	adds	r0, r0, #20	@ _22,
	bl	.L32		@
@ Forging.c:123: 		DrawUiNumberOrDoubleDashes(mapOut + 13, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemMaxUses(item));
	ldr	r3, .L55+28	@ tmp197,
	movs	r0, r4	@, item
	bl	.L6		@
	movs	r2, r0	@ _25, tmp227
	movs	r0, r5	@ tmp198, mapOut
	movs	r1, r6	@, iftmp.6_34
	adds	r0, r0, #26	@ tmp198,
	bl	.L32		@
@ Forging.c:124: 		DrawSpecialUiChar(mapOut + 11, isUsable ? TEXT_COLOR_NORMAL : TEXT_COLOR_GRAY, 0x16); // draw special character?
	movs	r2, #22	@,
	ldr	r1, [sp, #4]	@ isUsable, %sfp
	adds	r0, r5, r2	@ tmp203, tmp203,
	rsbs	r3, r1, #0	@ tmp202, isUsable
	adcs	r1, r1, r3	@ isUsable, isUsable, tmp202
	ldr	r3, .L55+32	@ tmp204,
	bl	.L6		@
.L40:
@ Forging.c:130: }
	@ sp needed	@
@ Forging.c:129:     DrawIcon(mapOut, GetItemIconId(item), 0x4000);
	movs	r0, r4	@, item
	ldr	r3, .L55+36	@ tmp205,
	bl	.L6		@
	movs	r2, #128	@,
	movs	r1, r0	@ _29, tmp228
	ldr	r3, .L55+40	@ tmp207,
	movs	r0, r5	@, mapOut
	lsls	r2, r2, #7	@,,
	bl	.L6		@
@ Forging.c:130: }
	pop	{r0, r1, r2, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L56:
	.align	2
.L55:
	.word	GetItemAttributes
	.word	Text_SetParameters
	.word	GetItemName
	.word	Text_DrawString
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
@ Forging.c:132: void DrawItemMenuLineNoColor(struct TextHandle* text, int item, u16* mapOut) {
	movs	r4, r1	@ item, tmp167
@ Forging.c:133:     Text_SetXCursor(text, 0);
	ldr	r3, .L68	@ tmp132,
	movs	r1, #0	@,
@ Forging.c:132: void DrawItemMenuLineNoColor(struct TextHandle* text, int item, u16* mapOut) {
	movs	r6, r2	@ mapOut, tmp168
	movs	r5, r0	@ text, tmp166
@ Forging.c:133:     Text_SetXCursor(text, 0);
	bl	.L6		@
@ Forging.c:134:     Text_DrawString(text, GetItemName(item));
	ldr	r3, .L68+4	@ tmp133,
	movs	r0, r4	@, item
	bl	.L6		@
@ Forging.c:134:     Text_DrawString(text, GetItemName(item));
	ldr	r3, .L68+8	@ tmp134,
@ Forging.c:134:     Text_DrawString(text, GetItemName(item));
	movs	r1, r0	@ _1, tmp169
@ Forging.c:134:     Text_DrawString(text, GetItemName(item));
	movs	r0, r5	@, text
	bl	.L6		@
@ Forging.c:135: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	ldr	r7, .L68+12	@ tmp135,
	movs	r0, r4	@, item
	bl	.L32		@
@ Forging.c:136:     Text_Display(text, mapOut + 2);
	ldr	r3, .L68+16	@ tmp137,
	movs	r0, r5	@, text
	adds	r1, r6, #4	@ tmp136, mapOut,
	bl	.L6		@
@ Forging.c:138: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r0, r4	@, item
	bl	.L32		@
@ Forging.c:138: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r3, #1	@ iftmp.8_15,
	str	r3, [sp, #4]	@ iftmp.8_15, %sfp
	lsls	r3, r0, #9	@ tmp179, tmp170,
	bpl	.L58		@,
@ Forging.c:138: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r0, r4	@, item
	bl	.L32		@
@ Forging.c:138: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r3, #192	@ tmp143,
	lsls	r3, r3, #17	@ tmp143, tmp143,
	ands	r0, r3	@ tmp142, tmp143
@ Forging.c:138: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	subs	r3, r0, #1	@ tmp146, tmp142
	sbcs	r0, r0, r3	@ tmp142, tmp142, tmp146
	str	r0, [sp, #4]	@ tmp142, %sfp
.L58:
@ Forging.c:138: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r0, r4	@, item
	ldr	r3, .L68+20	@ tmp147,
	bl	.L6		@
@ Forging.c:138: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	cmp	r0, #254	@ tmp172,
	beq	.L59		@,
	ldr	r3, [sp, #4]	@ iftmp.8_15, %sfp
	cmp	r3, #0	@ iftmp.8_15,
	beq	.L59		@,
@ Forging.c:139: 		DrawSpecialUiChar(mapOut + 11, Text_GetColorId(text), GetItemUses(item));
	ldr	r3, .L68+24	@ tmp160,
	movs	r0, r5	@, text
	bl	.L6		@
	movs	r5, r0	@ _12, tmp173
	movs	r0, r4	@, item
	bl	GetItemUses		@
	movs	r2, r0	@ _13, tmp174
	movs	r0, r6	@ tmp161, mapOut
	movs	r1, r5	@, _12
	ldr	r3, .L68+28	@ tmp162,
	adds	r0, r0, #22	@ tmp161,
	bl	.L6		@
.L59:
@ Forging.c:143: }
	@ sp needed	@
@ Forging.c:142:     DrawIcon(mapOut, GetItemIconId(item), 0x4000);
	movs	r0, r4	@, item
	ldr	r3, .L68+32	@ tmp163,
	bl	.L6		@
	movs	r2, #128	@,
	movs	r1, r0	@ _14, tmp175
	ldr	r3, .L68+36	@ tmp165,
	movs	r0, r6	@, mapOut
	lsls	r2, r2, #7	@,,
	bl	.L6		@
@ Forging.c:143: }
	pop	{r0, r1, r2, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L69:
	.align	2
.L68:
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
@ Forging.c:145: void DrawItemStatScreenLine(struct TextHandle* text, int item, int nameColor, u16* mapOut) {
	movs	r5, r3	@ mapOut, tmp217
	str	r0, [sp]	@ tmp214, %sfp
@ Forging.c:147: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	ldr	r3, .L94	@ tmp151,
	movs	r0, r1	@, item
@ Forging.c:147: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	movs	r7, #128	@ tmp152,
@ Forging.c:145: void DrawItemStatScreenLine(struct TextHandle* text, int item, int nameColor, u16* mapOut) {
	movs	r4, r1	@ item, tmp215
	movs	r6, r2	@ nameColor, tmp216
@ Forging.c:147: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	bl	.L6		@
@ Forging.c:147: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	lsls	r7, r7, #15	@ tmp152, tmp152,
@ Forging.c:149:     Text_Clear(text);
	ldr	r3, .L94+4	@ tmp153,
@ Forging.c:147: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	ands	r7, r0	@ isItemAnAccessory, tmp218
@ Forging.c:149:     Text_Clear(text);
	ldr	r0, [sp]	@, %sfp
	bl	.L6		@
	movs	r1, r6	@ color, nameColor
@ Forging.c:153: 	if (isItemAnAccessory) { // Vesly 
	cmp	r7, #0	@ isItemAnAccessory,
	beq	.L71		@,
@ Forging.c:155: 		if(ITEM_EQUIPPED(item) && nameColor != TEXT_COLOR_GREEN) color = TEXT_COLOR_GOLD;
	asrs	r3, r4, #15	@ tmp154, item,
@ Forging.c:155: 		if(ITEM_EQUIPPED(item) && nameColor != TEXT_COLOR_GREEN) color = TEXT_COLOR_GOLD;
	beq	.L71		@,
@ Forging.c:155: 		if(ITEM_EQUIPPED(item) && nameColor != TEXT_COLOR_GREEN) color = TEXT_COLOR_GOLD;
	subs	r1, r6, #4	@ tmp209, nameColor,
	rsbs	r3, r1, #0	@ tmp210, tmp209
	adcs	r1, r1, r3	@ tmp208, tmp209, tmp210
	adds	r1, r1, #3	@ color,
.L71:
@ Forging.c:157:     Text_SetColorId(text, color);
	ldr	r3, .L94+8	@ tmp155,
	ldr	r0, [sp]	@, %sfp
	bl	.L6		@
@ Forging.c:159:     Text_DrawString(text, GetItemName(item));
	ldr	r3, .L94+12	@ tmp156,
	movs	r0, r4	@, item
	bl	.L6		@
@ Forging.c:159:     Text_DrawString(text, GetItemName(item));
	ldr	r3, .L94+16	@ tmp157,
@ Forging.c:159:     Text_DrawString(text, GetItemName(item));
	movs	r1, r0	@ _4, tmp219
@ Forging.c:159:     Text_DrawString(text, GetItemName(item));
	ldr	r0, [sp]	@, %sfp
	bl	.L6		@
@ Forging.c:162: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) { // Vesly - berries 
	cmp	r7, #0	@ isItemAnAccessory,
	beq	.L73		@,
@ Forging.c:162: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) { // Vesly - berries 
	movs	r0, r4	@, item
	ldr	r3, .L94+20	@ tmp158,
	bl	.L6		@
@ Forging.c:162: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) { // Vesly - berries 
	cmp	r0, #254	@ tmp220,
	bne	.L73		@,
@ Forging.c:164: 		DrawSpecialUiChar(mapOut + 12, color, 0x16);
	movs	r0, r5	@ tmp163, mapOut
@ Forging.c:163: 		color = (nameColor == TEXT_COLOR_GRAY) ? TEXT_COLOR_GRAY : TEXT_COLOR_NORMAL;
	subs	r7, r6, #1	@ tmp161, nameColor,
	rsbs	r1, r7, #0	@ color, tmp161
	adcs	r1, r1, r7	@ color, tmp161
@ Forging.c:164: 		DrawSpecialUiChar(mapOut + 12, color, 0x16);
	movs	r2, #22	@,
	ldr	r3, .L94+24	@ tmp164,
	adds	r0, r0, #24	@ tmp163,
	bl	.L6		@
@ Forging.c:167: 		DrawUiNumberOrDoubleDashes(mapOut + 11, color, GetItemUses(item));
	movs	r0, r4	@, item
	bl	GetItemUses		@
@ Forging.c:166: 		color = (nameColor != TEXT_COLOR_GRAY) ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY;
	subs	r3, r7, #1	@ tmp213, tmp161
	sbcs	r7, r7, r3	@ tmp211, tmp161, tmp213
@ Forging.c:167: 		DrawUiNumberOrDoubleDashes(mapOut + 11, color, GetItemUses(item));
	movs	r2, r0	@ _9, tmp221
	movs	r0, r5	@ tmp165, mapOut
@ Forging.c:166: 		color = (nameColor != TEXT_COLOR_GRAY) ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY;
	adds	r7, r7, #1	@ iftmp.9_29,
@ Forging.c:167: 		DrawUiNumberOrDoubleDashes(mapOut + 11, color, GetItemUses(item));
	movs	r1, r7	@, iftmp.9_29
	ldr	r3, .L94+28	@ tmp241,
	adds	r0, r0, #22	@ tmp165,
	bl	.L6		@
@ Forging.c:168: 		DrawUiNumberOrDoubleDashes(mapOut + 14, color, GetItemMaxUses(item));
	ldr	r3, .L94+32	@ tmp167,
	movs	r0, r4	@, item
	bl	.L6		@
	movs	r2, r0	@ _11, tmp222
	movs	r0, r5	@ tmp168, mapOut
	movs	r1, r7	@, iftmp.9_29
	ldr	r3, .L94+28	@ tmp244,
	adds	r0, r0, #28	@ tmp168,
	bl	.L6		@
.L73:
@ Forging.c:173: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r0, r4	@, item
	ldr	r7, .L94	@ tmp170,
	bl	.L32		@
@ Forging.c:173: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r3, #1	@ iftmp.10_30,
	str	r3, [sp, #4]	@ iftmp.10_30, %sfp
	lsls	r3, r0, #9	@ tmp238, tmp223,
	bpl	.L76		@,
@ Forging.c:173: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r0, r4	@, item
	bl	.L32		@
@ Forging.c:173: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r3, #192	@ tmp175,
	lsls	r3, r3, #17	@ tmp175, tmp175,
	ands	r0, r3	@ tmp174, tmp175
@ Forging.c:173: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	subs	r3, r0, #1	@ tmp178, tmp174
	sbcs	r0, r0, r3	@ tmp174, tmp174, tmp178
	str	r0, [sp, #4]	@ tmp174, %sfp
.L76:
@ Forging.c:173: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r0, r4	@, item
	ldr	r3, .L94+20	@ tmp179,
	bl	.L6		@
@ Forging.c:173: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	cmp	r0, #254	@ tmp225,
	beq	.L77		@,
	ldr	r3, [sp, #4]	@ iftmp.10_30, %sfp
	cmp	r3, #0	@ iftmp.10_30,
	beq	.L77		@,
@ Forging.c:175: 		DrawSpecialUiChar(mapOut + 12, color, 0x16);
	movs	r0, r5	@ tmp196, mapOut
@ Forging.c:174: 		color = (nameColor == TEXT_COLOR_GRAY) ? TEXT_COLOR_GRAY : TEXT_COLOR_NORMAL;
	subs	r1, r6, #1	@ tmp194, nameColor,
	rsbs	r3, r1, #0	@ tmp195, tmp194
	adcs	r1, r1, r3	@ color, tmp194, tmp195
@ Forging.c:175: 		DrawSpecialUiChar(mapOut + 12, color, 0x16);
	movs	r2, #22	@,
	ldr	r3, .L94+24	@ tmp197,
	adds	r0, r0, #24	@ tmp196,
	bl	.L6		@
@ Forging.c:177: 		color = (nameColor != TEXT_COLOR_GRAY) ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY;
	cmp	r6, #1	@ nameColor,
	beq	.L78		@,
	movs	r6, #2	@ nameColor,
.L78:
@ Forging.c:178: 		DrawUiNumberOrDoubleDashes(mapOut + 11, color, GetItemUses(item));
	movs	r0, r4	@, item
	bl	GetItemUses		@
	movs	r2, r0	@ _23, tmp226
	movs	r0, r5	@ tmp198, mapOut
	movs	r1, r6	@, nameColor
	adds	r0, r0, #22	@ tmp198,
	ldr	r7, .L94+28	@ tmp199,
	bl	.L32		@
@ Forging.c:179: 		DrawUiNumberOrDoubleDashes(mapOut + 14, color, GetItemMaxUses(item));
	movs	r0, r4	@, item
	ldr	r3, .L94+32	@ tmp200,
	bl	.L6		@
	movs	r2, r0	@ _25, tmp227
	movs	r0, r5	@ tmp201, mapOut
	movs	r1, r6	@, nameColor
	adds	r0, r0, #28	@ tmp201,
	bl	.L32		@
.L77:
@ Forging.c:184: }
	@ sp needed	@
@ Forging.c:181:     Text_Display(text, mapOut + 2);
	adds	r1, r5, #4	@ tmp203, mapOut,
	ldr	r0, [sp]	@, %sfp
	ldr	r3, .L94+36	@ tmp204,
	bl	.L6		@
@ Forging.c:183:     DrawIcon(mapOut, GetItemIconId(item), 0x4000);
	movs	r0, r4	@, item
	ldr	r3, .L94+40	@ tmp205,
	bl	.L6		@
	movs	r2, #128	@,
	movs	r1, r0	@ _27, tmp228
	ldr	r3, .L94+44	@ tmp207,
	movs	r0, r5	@, mapOut
	lsls	r2, r2, #7	@,,
	bl	.L6		@
@ Forging.c:184: }
	pop	{r0, r1, r2, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L95:
	.align	2
.L94:
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
@ Forging.c:187:     if (GetItemAttributes(item) & IA_UNBREAKABLE)
	ldr	r3, .L101	@ tmp120,
@ Forging.c:186: u16 GetItemAfterUse(int item) {
	movs	r4, r0	@ item, tmp129
@ Forging.c:187:     if (GetItemAttributes(item) & IA_UNBREAKABLE)
	bl	.L6		@
@ Forging.c:187:     if (GetItemAttributes(item) & IA_UNBREAKABLE)
	lsls	r3, r0, #28	@ tmp131, tmp130,
	bpl	.L97		@,
.L100:
@ Forging.c:195:     return item; // return used item
	lsls	r0, r4, #16	@ <retval>, item,
	lsrs	r0, r0, #16	@ <retval>, <retval>,
	b	.L98		@
.L97:
@ Forging.c:190:     item -= (1 << 8); // lose one use
	subs	r4, r4, #1	@ item,
	subs	r4, r4, #255	@ item,
@ Forging.c:192:     if (ITEM_USES(item) < 1)
	lsls	r3, r4, #18	@ tmp126, item,
	lsrs	r3, r3, #26	@ tmp125, tmp126,
@ Forging.c:193:         return 0; // return no item if uses < 0
	subs	r0, r3, #0	@ <retval>, tmp125,
@ Forging.c:192:     if (ITEM_USES(item) < 1)
	bne	.L100		@,
.L98:
@ Forging.c:196: }
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L102:
	.align	2
.L101:
	.word	GetItemAttributes
	.size	GetItemAfterUse, .-GetItemAfterUse
	.ident	"GCC: (devkitARM release 54) 10.1.0"
	.code 16
	.align	1
.L6:
	bx	r3
.L31:
	bx	r6
.L32:
	bx	r7
