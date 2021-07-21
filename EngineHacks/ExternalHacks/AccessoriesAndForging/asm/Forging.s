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
	.global	GetItemForgeBonuses
	.arch armv4t
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	GetItemForgeBonuses, %function
GetItemForgeBonuses:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
@ Forging.c:10: 	for(int i = 0; gForgeBonusLookupTable[i].itemId != 0; i++) {
	movs	r2, #0	@ i,
@ Forging.c:9: const ItemForgeBonuses *GetItemForgeBonuses(int itemIndex) {
	push	{r4, r5, lr}	@
@ Forging.c:11: 		if(gForgeBonusLookupTable[i].itemId == ITEM_INDEX(itemIndex)) return gForgeBonusLookupTable + i;
	lsls	r3, r0, #24	@ tmp128, tmp129,
@ Forging.c:10: 	for(int i = 0; gForgeBonusLookupTable[i].itemId != 0; i++) {
	ldr	r4, .L6	@ tmp125,
@ Forging.c:11: 		if(gForgeBonusLookupTable[i].itemId == ITEM_INDEX(itemIndex)) return gForgeBonusLookupTable + i;
	lsrs	r3, r3, #24	@ tmp128, tmp128,
.L2:
	lsls	r1, r2, #2	@ _14, i,
@ Forging.c:10: 	for(int i = 0; gForgeBonusLookupTable[i].itemId != 0; i++) {
	ldrb	r0, [r4, r1]	@ _6, MEM[symbol: gForgeBonusLookupTable, index: _14, offset: 0B]
	adds	r5, r1, r4	@ tmp124, _14, tmp125
@ Forging.c:10: 	for(int i = 0; gForgeBonusLookupTable[i].itemId != 0; i++) {
	cmp	r0, #0	@ _6,
	beq	.L1		@,
@ Forging.c:11: 		if(gForgeBonusLookupTable[i].itemId == ITEM_INDEX(itemIndex)) return gForgeBonusLookupTable + i;
	cmp	r0, r3	@ _6, tmp128
	bne	.L3		@,
@ Forging.c:11: 		if(gForgeBonusLookupTable[i].itemId == ITEM_INDEX(itemIndex)) return gForgeBonusLookupTable + i;
	movs	r0, r5	@ <retval>, tmp124
.L1:
@ Forging.c:14: }
	@ sp needed	@
	pop	{r4, r5}
	pop	{r1}
	bx	r1
.L3:
@ Forging.c:10: 	for(int i = 0; gForgeBonusLookupTable[i].itemId != 0; i++) {
	adds	r2, r2, #1	@ i,
	b	.L2		@
.L7:
	.align	2
.L6:
	.word	gForgeBonusLookupTable
	.size	GetItemForgeBonuses, .-GetItemForgeBonuses
	.align	1
	.global	GetItemUses
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
@ Forging.c:23:     if (GetItemAttributes(item) & IA_UNBREAKABLE)
	ldr	r3, .L11	@ tmp118,
@ Forging.c:22: int GetItemUses(int item) {
	movs	r4, r0	@ item, tmp124
@ Forging.c:23:     if (GetItemAttributes(item) & IA_UNBREAKABLE)
	bl	.L13		@
	movs	r3, r0	@ tmp125,
@ Forging.c:24:         return 0xFF;
	movs	r0, #255	@ <retval>,
@ Forging.c:23:     if (GetItemAttributes(item) & IA_UNBREAKABLE)
	lsls	r3, r3, #28	@ tmp126, tmp125,
	bmi	.L8		@,
@ Forging.c:26:         return ITEM_USES(item);
	lsls	r4, r4, #18	@ tmp122, item,
	lsrs	r0, r4, #26	@ <retval>, tmp122,
.L8:
@ Forging.c:27: }
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L12:
	.align	2
.L11:
	.word	GetItemAttributes
	.size	GetItemUses, .-GetItemUses
	.section	.rodata.str1.1,"aMS",%progbits,1
.LC6:
	.ascii	"+\000"
	.text
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
@ Forging.c:61: void DrawItemMenuLine(struct TextHandle* text, int item, s8 isUsable, u16* mapOut) {
	movs	r5, r0	@ text, tmp160
@ Forging.c:63: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	ldr	r7, .L35	@ tmp133,
	movs	r0, r1	@, item
@ Forging.c:61: void DrawItemMenuLine(struct TextHandle* text, int item, s8 isUsable, u16* mapOut) {
	movs	r6, r3	@ mapOut, tmp163
	movs	r4, r1	@ item, tmp161
	str	r2, [sp, #4]	@ tmp162, %sfp
@ Forging.c:63: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	bl	.L37		@
@ Forging.c:66: 	if(!isUsable && !isItemAnAccessory) textColor = TEXT_COLOR_GRAY;
	ldr	r3, [sp, #4]	@ isUsable, %sfp
	cmp	r3, #0	@ isUsable,
	bne	.L15		@,
@ Forging.c:66: 	if(!isUsable && !isItemAnAccessory) textColor = TEXT_COLOR_GRAY;
	movs	r2, #1	@ textColor,
@ Forging.c:66: 	if(!isUsable && !isItemAnAccessory) textColor = TEXT_COLOR_GRAY;
	lsls	r3, r0, #9	@ tmp174, _1,
	bpl	.L16		@,
.L15:
@ Forging.c:67: 	else if(ITEM_FORGED(item)) textColor = TEXT_COLOR_BLUE;
	movs	r3, #128	@ tmp136,
	movs	r2, r4	@ textColor, item
	lsls	r3, r3, #7	@ tmp136, tmp136,
	ands	r2, r3	@ textColor, tmp136
@ Forging.c:67: 	else if(ITEM_FORGED(item)) textColor = TEXT_COLOR_BLUE;
	tst	r4, r3	@ item, tmp136
	beq	.L16		@,
@ Forging.c:67: 	else if(ITEM_FORGED(item)) textColor = TEXT_COLOR_BLUE;
	movs	r2, #2	@ textColor,
.L16:
@ Forging.c:68: 	if(ITEM_EQUIPPED(item)) textColor = TEXT_COLOR_GOLD;
	asrs	r3, r4, #15	@ tmp137, item,
@ Forging.c:68: 	if(ITEM_EQUIPPED(item)) textColor = TEXT_COLOR_GOLD;
	beq	.L17		@,
@ Forging.c:68: 	if(ITEM_EQUIPPED(item)) textColor = TEXT_COLOR_GOLD;
	movs	r2, #3	@ textColor,
.L17:
@ Forging.c:70: 	Text_SetParameters(text, 0, textColor);
	movs	r1, #0	@,
	ldr	r3, .L35+4	@ tmp138,
	movs	r0, r5	@, text
	bl	.L13		@
@ Forging.c:73:     Text_DrawString(text, GetItemName(item));
	ldr	r3, .L35+8	@ tmp139,
	movs	r0, r4	@, item
	bl	.L13		@
@ Forging.c:73:     Text_DrawString(text, GetItemName(item));
	ldr	r3, .L35+12	@ tmp179,
@ Forging.c:73:     Text_DrawString(text, GetItemName(item));
	movs	r1, r0	@ _5, tmp165
@ Forging.c:73:     Text_DrawString(text, GetItemName(item));
	movs	r0, r5	@, text
	bl	.L13		@
@ Forging.c:74: 	if(ITEM_FORGED(item)) Text_DrawString(text, "+");
	lsls	r3, r4, #17	@ tmp175, item,
	bpl	.L18		@,
@ Forging.c:74: 	if(ITEM_FORGED(item)) Text_DrawString(text, "+");
	movs	r0, r5	@, text
	ldr	r1, .L35+16	@,
	ldr	r3, .L35+12	@ tmp181,
	bl	.L13		@
.L18:
@ Forging.c:76:     Text_Display(text, mapOut + 2);
	movs	r0, r5	@, text
	ldr	r3, .L35+20	@ tmp146,
	adds	r1, r6, #4	@ tmp145, mapOut,
	bl	.L13		@
@ Forging.c:78: 	if (!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	movs	r0, r4	@, item
	bl	.L37		@
@ Forging.c:78: 	if (!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	lsls	r3, r0, #9	@ tmp176, tmp166,
	bmi	.L19		@,
.L21:
@ Forging.c:78: 	if (!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	movs	r0, r4	@, item
	ldr	r5, [sp, #4]	@ isUsable, %sfp
	bl	GetItemUses		@
	subs	r3, r5, #1	@ tmp159, isUsable
	sbcs	r5, r5, r3	@ isUsable, isUsable, tmp159
	movs	r2, r0	@ _13, tmp167
	movs	r0, r6	@ _12, mapOut
	adds	r5, r5, #1	@ iftmp.1_17,
	movs	r1, r5	@, iftmp.1_17
	ldr	r3, .L35+24	@ tmp153,
	adds	r0, r0, #22	@ _12,
	bl	.L13		@
.L22:
@ Forging.c:81: }
	@ sp needed	@
@ Forging.c:80:     DrawIcon(mapOut, GetItemIconId(item), 0x4000);
	movs	r0, r4	@, item
	ldr	r3, .L35+28	@ tmp154,
	bl	.L13		@
	movs	r2, #128	@,
	movs	r1, r0	@ _14, tmp169
	ldr	r3, .L35+32	@ tmp156,
	movs	r0, r6	@, mapOut
	lsls	r2, r2, #7	@,,
	bl	.L13		@
@ Forging.c:81: }
	pop	{r0, r1, r2, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L19:
@ Forging.c:78: 	if (!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	movs	r0, r4	@, item
	bl	.L37		@
@ Forging.c:78: 	if (!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	movs	r3, #192	@ tmp152,
	lsls	r3, r3, #17	@ tmp152, tmp152,
@ Forging.c:78: 	if (!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	tst	r0, r3	@ tmp168, tmp152
	bne	.L21		@,
	b	.L22		@
.L36:
	.align	2
.L35:
	.word	GetItemAttributes
	.word	Text_SetParameters
	.word	GetItemName
	.word	Text_DrawString
	.word	.LC6
	.word	Text_Display
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
@ Forging.c:83: void DrawItemMenuLineLong(struct TextHandle* text, int item, s8 isUsable, u16* mapOut) {
	movs	r6, r0	@ text, tmp173
@ Forging.c:85: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	ldr	r7, .L60	@ tmp138,
	movs	r0, r1	@, item
@ Forging.c:83: void DrawItemMenuLineLong(struct TextHandle* text, int item, s8 isUsable, u16* mapOut) {
	movs	r5, r3	@ mapOut, tmp176
	movs	r4, r1	@ item, tmp174
	str	r2, [sp, #4]	@ tmp175, %sfp
@ Forging.c:85: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	bl	.L37		@
@ Forging.c:88: 	if(!isUsable && !isItemAnAccessory) textColor = TEXT_COLOR_GRAY;
	ldr	r3, [sp, #4]	@ isUsable, %sfp
	cmp	r3, #0	@ isUsable,
	bne	.L39		@,
@ Forging.c:88: 	if(!isUsable && !isItemAnAccessory) textColor = TEXT_COLOR_GRAY;
	movs	r2, #1	@ textColor,
@ Forging.c:88: 	if(!isUsable && !isItemAnAccessory) textColor = TEXT_COLOR_GRAY;
	lsls	r3, r0, #9	@ tmp190, _1,
	bpl	.L40		@,
.L39:
@ Forging.c:89: 	else if(ITEM_FORGED(item)) textColor = TEXT_COLOR_BLUE;
	movs	r3, #128	@ tmp141,
	movs	r2, r4	@ textColor, item
	lsls	r3, r3, #7	@ tmp141, tmp141,
	ands	r2, r3	@ textColor, tmp141
@ Forging.c:89: 	else if(ITEM_FORGED(item)) textColor = TEXT_COLOR_BLUE;
	tst	r4, r3	@ item, tmp141
	beq	.L40		@,
@ Forging.c:89: 	else if(ITEM_FORGED(item)) textColor = TEXT_COLOR_BLUE;
	movs	r2, #2	@ textColor,
.L40:
@ Forging.c:90: 	if(ITEM_EQUIPPED(item)) textColor = TEXT_COLOR_GOLD;
	asrs	r3, r4, #15	@ tmp142, item,
@ Forging.c:90: 	if(ITEM_EQUIPPED(item)) textColor = TEXT_COLOR_GOLD;
	beq	.L41		@,
@ Forging.c:90: 	if(ITEM_EQUIPPED(item)) textColor = TEXT_COLOR_GOLD;
	movs	r2, #3	@ textColor,
.L41:
@ Forging.c:92:     Text_SetParameters(text, 0, textColor);
	movs	r1, #0	@,
	ldr	r3, .L60+4	@ tmp143,
	movs	r0, r6	@, text
	bl	.L13		@
@ Forging.c:94:     Text_DrawString(text, GetItemName(item));
	ldr	r3, .L60+8	@ tmp144,
	movs	r0, r4	@, item
	bl	.L13		@
@ Forging.c:94:     Text_DrawString(text, GetItemName(item));
	ldr	r3, .L60+12	@ tmp195,
@ Forging.c:94:     Text_DrawString(text, GetItemName(item));
	movs	r1, r0	@ _5, tmp178
@ Forging.c:94:     Text_DrawString(text, GetItemName(item));
	movs	r0, r6	@, text
	bl	.L13		@
@ Forging.c:95: 	if(ITEM_FORGED(item)) Text_DrawString(text, "+");
	lsls	r3, r4, #17	@ tmp191, item,
	bpl	.L42		@,
@ Forging.c:95: 	if(ITEM_FORGED(item)) Text_DrawString(text, "+");
	movs	r0, r6	@, text
	ldr	r1, .L60+16	@,
	ldr	r3, .L60+12	@ tmp197,
	bl	.L13		@
.L42:
@ Forging.c:97:     Text_Display(text, mapOut + 2);
	movs	r0, r6	@, text
	ldr	r3, .L60+20	@ tmp151,
	adds	r1, r5, #4	@ tmp150, mapOut,
	bl	.L13		@
@ Forging.c:99: 	if (!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) {
	movs	r0, r4	@, item
	bl	.L37		@
@ Forging.c:99: 	if (!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) {
	lsls	r3, r0, #9	@ tmp192, tmp179,
	bmi	.L43		@,
.L46:
@ Forging.c:100: 		DrawUiNumberOrDoubleDashes(mapOut + 10, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	movs	r0, r4	@, item
	ldr	r6, [sp, #4]	@ tmp171, %sfp
	bl	GetItemUses		@
	subs	r3, r6, #1	@ tmp172, tmp171
	sbcs	r6, r6, r3	@ tmp171, tmp171, tmp172
	movs	r2, r0	@ _13, tmp180
	movs	r0, r5	@ _12, mapOut
	adds	r6, r6, #1	@ iftmp.2_22,
	movs	r1, r6	@, iftmp.2_22
	ldr	r7, .L60+24	@ tmp158,
	adds	r0, r0, #20	@ _12,
	bl	.L37		@
@ Forging.c:101: 		DrawUiNumberOrDoubleDashes(mapOut + 13, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemMaxUses(item));
	ldr	r3, .L60+28	@ tmp159,
	movs	r0, r4	@, item
	bl	.L13		@
	movs	r2, r0	@ _15, tmp181
	movs	r0, r5	@ tmp160, mapOut
	movs	r1, r6	@, iftmp.2_22
	adds	r0, r0, #26	@ tmp160,
	bl	.L37		@
@ Forging.c:102: 		DrawSpecialUiChar(mapOut + 11, isUsable ? TEXT_COLOR_NORMAL : TEXT_COLOR_GRAY, 0x16); // draw special character?
	movs	r2, #22	@,
	ldr	r1, [sp, #4]	@ isUsable, %sfp
	adds	r0, r5, r2	@ tmp165, tmp165,
	rsbs	r3, r1, #0	@ tmp164, isUsable
	adcs	r1, r1, r3	@ isUsable, isUsable, tmp164
	ldr	r3, .L60+32	@ tmp166,
	bl	.L13		@
.L47:
@ Forging.c:106: }
	@ sp needed	@
@ Forging.c:105:     DrawIcon(mapOut, GetItemIconId(item), 0x4000);
	movs	r0, r4	@, item
	ldr	r3, .L60+36	@ tmp167,
	bl	.L13		@
	movs	r2, #128	@,
	movs	r1, r0	@ _19, tmp183
	ldr	r3, .L60+40	@ tmp169,
	movs	r0, r5	@, mapOut
	lsls	r2, r2, #7	@,,
	bl	.L13		@
@ Forging.c:106: }
	pop	{r0, r1, r2, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L43:
@ Forging.c:99: 	if (!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) {
	movs	r0, r4	@, item
	bl	.L37		@
@ Forging.c:99: 	if (!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) {
	movs	r3, #192	@ tmp157,
	lsls	r3, r3, #17	@ tmp157, tmp157,
@ Forging.c:99: 	if (!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) {
	tst	r0, r3	@ tmp182, tmp157
	bne	.L46		@,
	b	.L47		@
.L61:
	.align	2
.L60:
	.word	GetItemAttributes
	.word	Text_SetParameters
	.word	GetItemName
	.word	Text_DrawString
	.word	.LC6
	.word	Text_Display
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
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, lr}	@
@ Forging.c:108: void DrawItemMenuLineNoColor(struct TextHandle* text, int item, u16* mapOut) {
	movs	r4, r1	@ item, tmp149
@ Forging.c:109:     Text_SetXCursor(text, 0);
	ldr	r3, .L70	@ tmp127,
	movs	r1, #0	@,
@ Forging.c:108: void DrawItemMenuLineNoColor(struct TextHandle* text, int item, u16* mapOut) {
	movs	r5, r0	@ text, tmp148
	movs	r6, r2	@ mapOut, tmp150
@ Forging.c:109:     Text_SetXCursor(text, 0);
	bl	.L13		@
@ Forging.c:110:     Text_DrawString(text, GetItemName(item));
	ldr	r3, .L70+4	@ tmp128,
	movs	r0, r4	@, item
	bl	.L13		@
@ Forging.c:110:     Text_DrawString(text, GetItemName(item));
	ldr	r7, .L70+8	@ tmp129,
@ Forging.c:110:     Text_DrawString(text, GetItemName(item));
	movs	r1, r0	@ _1, tmp151
@ Forging.c:110:     Text_DrawString(text, GetItemName(item));
	movs	r0, r5	@, text
	bl	.L37		@
@ Forging.c:111: 	if(ITEM_FORGED(item)) Text_DrawString(text, "+");
	lsls	r3, r4, #17	@ tmp160, item,
	bpl	.L63		@,
@ Forging.c:111: 	if(ITEM_FORGED(item)) Text_DrawString(text, "+");
	movs	r0, r5	@, text
	ldr	r1, .L70+12	@,
	bl	.L37		@
.L63:
@ Forging.c:113:     Text_Display(text, mapOut + 2);
	movs	r0, r5	@, text
	ldr	r3, .L70+16	@ tmp135,
	adds	r1, r6, #4	@ tmp134, mapOut,
	bl	.L13		@
@ Forging.c:115: 	if (!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) {
	movs	r0, r4	@, item
	ldr	r7, .L70+20	@ tmp136,
	bl	.L37		@
@ Forging.c:115: 	if (!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) {
	lsls	r3, r0, #9	@ tmp161, tmp152,
	bmi	.L64		@,
.L66:
@ Forging.c:116: 		DrawSpecialUiChar(mapOut + 11, Text_GetColorId(text), GetItemUses(item));
	ldr	r3, .L70+24	@ tmp139,
	movs	r0, r5	@, text
	bl	.L13		@
	movs	r5, r0	@ _9, tmp153
	movs	r0, r4	@, item
	bl	GetItemUses		@
	movs	r2, r0	@ _10, tmp154
	movs	r0, r6	@ tmp140, mapOut
	movs	r1, r5	@, _9
	ldr	r3, .L70+28	@ tmp141,
	adds	r0, r0, #22	@ tmp140,
	bl	.L13		@
.L65:
@ Forging.c:120: }
	@ sp needed	@
@ Forging.c:119:     DrawIcon(mapOut, GetItemIconId(item), 0x4000);
	movs	r0, r4	@, item
	ldr	r3, .L70+32	@ tmp145,
	bl	.L13		@
	movs	r2, #128	@,
	movs	r1, r0	@ _11, tmp156
	ldr	r3, .L70+36	@ tmp147,
	movs	r0, r6	@, mapOut
	lsls	r2, r2, #7	@,,
	bl	.L13		@
@ Forging.c:120: }
	pop	{r3, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L64:
@ Forging.c:115: 	if (!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) {
	movs	r0, r4	@, item
	bl	.L37		@
@ Forging.c:115: 	if (!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) {
	movs	r3, #192	@ tmp144,
	lsls	r3, r3, #17	@ tmp144, tmp144,
@ Forging.c:115: 	if (!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) {
	tst	r0, r3	@ tmp155, tmp144
	bne	.L66		@,
	b	.L65		@
.L71:
	.align	2
.L70:
	.word	Text_SetXCursor
	.word	GetItemName
	.word	Text_DrawString
	.word	.LC6
	.word	Text_Display
	.word	GetItemAttributes
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
@ Forging.c:122: void DrawItemStatScreenLine(struct TextHandle* text, int item, int nameColor, u16* mapOut) {
	movs	r6, r0	@ text, tmp171
	movs	r4, r1	@ item, tmp172
@ Forging.c:124: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	movs	r0, r1	@, item
@ Forging.c:122: void DrawItemStatScreenLine(struct TextHandle* text, int item, int nameColor, u16* mapOut) {
	movs	r7, r3	@ mapOut, tmp174
@ Forging.c:124: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	ldr	r3, .L93	@ tmp188,
@ Forging.c:122: void DrawItemStatScreenLine(struct TextHandle* text, int item, int nameColor, u16* mapOut) {
	movs	r5, r2	@ nameColor, tmp173
@ Forging.c:124: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	bl	.L13		@
@ Forging.c:126:     Text_Clear(text);
	ldr	r3, .L93+4	@ tmp135,
	movs	r0, r6	@, text
	bl	.L13		@
@ Forging.c:129: 	if(ITEM_FORGED(item) && nameColor != TEXT_COLOR_GREEN) color = TEXT_COLOR_BLUE;
	movs	r3, #128	@ tmp136,
	movs	r2, r4	@ _1, item
	lsls	r3, r3, #7	@ tmp136, tmp136,
	ands	r2, r3	@ _1, tmp136
	movs	r1, r5	@ color, nameColor
	str	r2, [sp, #4]	@ _1, %sfp
@ Forging.c:129: 	if(ITEM_FORGED(item) && nameColor != TEXT_COLOR_GREEN) color = TEXT_COLOR_BLUE;
	tst	r4, r3	@ item, tmp136
	beq	.L73		@,
@ Forging.c:129: 	if(ITEM_FORGED(item) && nameColor != TEXT_COLOR_GREEN) color = TEXT_COLOR_BLUE;
	cmp	r5, #4	@ nameColor,
	beq	.L73		@,
@ Forging.c:129: 	if(ITEM_FORGED(item) && nameColor != TEXT_COLOR_GREEN) color = TEXT_COLOR_BLUE;
	movs	r1, #2	@ color,
.L73:
@ Forging.c:130: 	if(ITEM_EQUIPPED(item) && nameColor != TEXT_COLOR_GREEN) color = TEXT_COLOR_GOLD;
	asrs	r3, r4, #15	@ tmp137, item,
@ Forging.c:130: 	if(ITEM_EQUIPPED(item) && nameColor != TEXT_COLOR_GREEN) color = TEXT_COLOR_GOLD;
	beq	.L74		@,
@ Forging.c:130: 	if(ITEM_EQUIPPED(item) && nameColor != TEXT_COLOR_GREEN) color = TEXT_COLOR_GOLD;
	cmp	r5, #4	@ nameColor,
	beq	.L74		@,
@ Forging.c:130: 	if(ITEM_EQUIPPED(item) && nameColor != TEXT_COLOR_GREEN) color = TEXT_COLOR_GOLD;
	movs	r1, #3	@ color,
.L74:
@ Forging.c:131:     Text_SetColorId(text, color);
	ldr	r3, .L93+8	@ tmp138,
	movs	r0, r6	@, text
	bl	.L13		@
@ Forging.c:133:     Text_DrawString(text, GetItemName(item));
	ldr	r3, .L93+12	@ tmp139,
	movs	r0, r4	@, item
	bl	.L13		@
@ Forging.c:133:     Text_DrawString(text, GetItemName(item));
	ldr	r3, .L93+16	@ tmp191,
@ Forging.c:133:     Text_DrawString(text, GetItemName(item));
	movs	r1, r0	@ _3, tmp175
@ Forging.c:133:     Text_DrawString(text, GetItemName(item));
	movs	r0, r6	@, text
	bl	.L13		@
@ Forging.c:134: 	if(ITEM_FORGED(item)) Text_DrawString(text, "+");
	ldr	r3, [sp, #4]	@ _1, %sfp
	cmp	r3, #0	@ _1,
	beq	.L75		@,
@ Forging.c:134: 	if(ITEM_FORGED(item)) Text_DrawString(text, "+");
	movs	r0, r6	@, text
	ldr	r1, .L93+20	@,
	ldr	r3, .L93+16	@ tmp194,
	bl	.L13		@
.L75:
@ Forging.c:136: 	if (!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) {
	ldr	r3, .L93	@ tmp196,
	movs	r0, r4	@, item
	bl	.L13		@
@ Forging.c:136: 	if (!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) {
	lsls	r3, r0, #9	@ tmp187, tmp176,
	bmi	.L76		@,
.L78:
@ Forging.c:138: 		DrawSpecialUiChar(mapOut + 12, color, 0x16);
	movs	r0, r7	@ tmp150, mapOut
@ Forging.c:137: 		color = (nameColor == TEXT_COLOR_GRAY) ? TEXT_COLOR_GRAY : TEXT_COLOR_NORMAL;
	subs	r1, r5, #1	@ tmp148, nameColor,
	rsbs	r3, r1, #0	@ tmp149, tmp148
	adcs	r1, r1, r3	@ color, tmp148, tmp149
@ Forging.c:138: 		DrawSpecialUiChar(mapOut + 12, color, 0x16);
	movs	r2, #22	@,
	ldr	r3, .L93+24	@ tmp151,
	adds	r0, r0, #24	@ tmp150,
	bl	.L13		@
@ Forging.c:140: 		color = (nameColor != TEXT_COLOR_GRAY) ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY;
	cmp	r5, #1	@ nameColor,
	bne	.L82		@,
.L77:
@ Forging.c:141: 		DrawUiNumberOrDoubleDashes(mapOut + 11, color, GetItemUses(item));
	movs	r0, r4	@, item
	bl	GetItemUses		@
	movs	r2, r0	@ _11, tmp178
	movs	r0, r7	@ tmp155, mapOut
	movs	r1, r5	@, nameColor
	ldr	r3, .L93+28	@ tmp202,
	adds	r0, r0, #22	@ tmp155,
	bl	.L13		@
@ Forging.c:142: 		DrawUiNumberOrDoubleDashes(mapOut + 14, color, GetItemMaxUses(item));
	movs	r0, r4	@, item
	ldr	r3, .L93+32	@ tmp157,
	bl	.L13		@
	movs	r2, r0	@ _13, tmp179
	movs	r0, r7	@ tmp158, mapOut
	movs	r1, r5	@, nameColor
	ldr	r3, .L93+28	@ tmp205,
	adds	r0, r0, #28	@ tmp158,
	bl	.L13		@
	b	.L79		@
.L76:
@ Forging.c:136: 	if (!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) {
	ldr	r3, .L93	@ tmp199,
	movs	r0, r4	@, item
	bl	.L13		@
@ Forging.c:136: 	if (!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) {
	movs	r3, #192	@ tmp154,
	lsls	r3, r3, #17	@ tmp154, tmp154,
@ Forging.c:136: 	if (!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) {
	tst	r0, r3	@ tmp177, tmp154
	bne	.L78		@,
.L79:
@ Forging.c:147: }
	@ sp needed	@
@ Forging.c:144:     Text_Display(text, mapOut + 2);
	adds	r1, r7, #4	@ tmp160, mapOut,
	movs	r0, r6	@, text
	ldr	r3, .L93+36	@ tmp161,
	bl	.L13		@
@ Forging.c:146:     DrawIcon(mapOut, GetItemIconId(item), 0x4000);
	movs	r0, r4	@, item
	ldr	r3, .L93+40	@ tmp162,
	bl	.L13		@
	movs	r2, #128	@,
	movs	r1, r0	@ _15, tmp180
	ldr	r3, .L93+44	@ tmp164,
	movs	r0, r7	@, mapOut
	lsls	r2, r2, #7	@,,
	bl	.L13		@
@ Forging.c:147: }
	pop	{r0, r1, r2, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L82:
@ Forging.c:140: 		color = (nameColor != TEXT_COLOR_GRAY) ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY;
	movs	r5, #2	@ nameColor,
	b	.L77		@
.L94:
	.align	2
.L93:
	.word	GetItemAttributes
	.word	Text_Clear
	.word	Text_SetColorId
	.word	GetItemName
	.word	Text_DrawString
	.word	.LC6
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
@ Forging.c:150:     if (GetItemAttributes(item) & IA_UNBREAKABLE)
	ldr	r3, .L100	@ tmp120,
@ Forging.c:149: u16 GetItemAfterUse(int item) {
	movs	r4, r0	@ item, tmp129
@ Forging.c:150:     if (GetItemAttributes(item) & IA_UNBREAKABLE)
	bl	.L13		@
@ Forging.c:150:     if (GetItemAttributes(item) & IA_UNBREAKABLE)
	lsls	r3, r0, #28	@ tmp131, tmp130,
	bpl	.L96		@,
.L99:
@ Forging.c:158:     return item; // return used item
	lsls	r0, r4, #16	@ <retval>, item,
	lsrs	r0, r0, #16	@ <retval>, <retval>,
	b	.L97		@
.L96:
@ Forging.c:153:     item -= (1 << 8); // lose one use
	subs	r4, r4, #1	@ item,
	subs	r4, r4, #255	@ item,
@ Forging.c:155:     if (ITEM_USES(item) < 1)
	lsls	r3, r4, #18	@ tmp126, item,
	lsrs	r3, r3, #26	@ tmp125, tmp126,
@ Forging.c:156:         return 0; // return no item if uses < 0
	subs	r0, r3, #0	@ <retval>, tmp125,
@ Forging.c:155:     if (ITEM_USES(item) < 1)
	bne	.L99		@,
.L97:
@ Forging.c:159: }
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L101:
	.align	2
.L100:
	.word	GetItemAttributes
	.size	GetItemAfterUse, .-GetItemAfterUse
	.align	1
	.global	ForgeActiveUnitEquippedWeaponASMC
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	ForgeActiveUnitEquippedWeaponASMC, %function
ForgeActiveUnitEquippedWeaponASMC:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ Forging.c:196: 	int item = GetUnitEquippedWeapon(gActiveUnit);
	ldr	r4, .L107	@ tmp120,
	ldr	r3, .L107+4	@ tmp121,
	ldr	r0, [r4]	@, gActiveUnit
	bl	.L13		@
	subs	r5, r0, #0	@ item, tmp132,
@ Forging.c:197: 	if(item) {
	beq	.L102		@,
@ Forging.c:198: 		gActiveUnit->items[GetUnitEquippedWeaponSlot(gActiveUnit)] = (item | 0x4000);
	ldr	r4, [r4]	@ gActiveUnit.6_4, gActiveUnit
@ Forging.c:198: 		gActiveUnit->items[GetUnitEquippedWeaponSlot(gActiveUnit)] = (item | 0x4000);
	ldr	r3, .L107+8	@ tmp123,
	movs	r0, r4	@, gActiveUnit.6_4
	bl	.L13		@
@ Forging.c:198: 		gActiveUnit->items[GetUnitEquippedWeaponSlot(gActiveUnit)] = (item | 0x4000);
	movs	r3, r0	@ tmp133, tmp133
@ Forging.c:198: 		gActiveUnit->items[GetUnitEquippedWeaponSlot(gActiveUnit)] = (item | 0x4000);
	movs	r0, #128	@ tmp130,
@ Forging.c:198: 		gActiveUnit->items[GetUnitEquippedWeaponSlot(gActiveUnit)] = (item | 0x4000);
	adds	r3, r3, #12	@ tmp133,
	lsls	r3, r3, #1	@ tmp125, tmp124,
@ Forging.c:198: 		gActiveUnit->items[GetUnitEquippedWeaponSlot(gActiveUnit)] = (item | 0x4000);
	lsls	r0, r0, #7	@ tmp130, tmp130,
@ Forging.c:198: 		gActiveUnit->items[GetUnitEquippedWeaponSlot(gActiveUnit)] = (item | 0x4000);
	adds	r3, r4, r3	@ tmp126, gActiveUnit.6_4, tmp125
@ Forging.c:198: 		gActiveUnit->items[GetUnitEquippedWeaponSlot(gActiveUnit)] = (item | 0x4000);
	orrs	r5, r0	@ tmp129, tmp130
@ Forging.c:198: 		gActiveUnit->items[GetUnitEquippedWeaponSlot(gActiveUnit)] = (item | 0x4000);
	strh	r5, [r3, #6]	@ tmp129, gActiveUnit.6_4->items
.L102:
@ Forging.c:200: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L108:
	.align	2
.L107:
	.word	gActiveUnit
	.word	GetUnitEquippedWeapon
	.word	GetUnitEquippedWeaponSlot
	.size	ForgeActiveUnitEquippedWeaponASMC, .-ForgeActiveUnitEquippedWeaponASMC
	.ident	"GCC: (devkitARM release 54) 10.1.0"
	.code 16
	.align	1
.L13:
	bx	r3
.L37:
	bx	r7
