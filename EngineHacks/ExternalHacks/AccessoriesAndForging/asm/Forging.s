	.cpu arm7tdmi
	.arch armv4t
	.fpu softvfp
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
@ GNU C17 (devkitARM release 59) version 12.2.0 (arm-none-eabi)
@	compiled by GNU C version 10.3.0, GMP version 6.2.1, MPFR version 4.1.0, MPC version 1.2.1, isl version isl-0.18-GMP

@ GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
@ options passed: -mcpu=arm7tdmi -mthumb -mthumb-interwork -mtune=arm7tdmi -mlong-calls -march=armv4t -Os
	.text
	.align	1
	.global	DrawItemMenuLine
	.syntax unified
	.code	16
	.thumb_func
	.type	DrawItemMenuLine, %function
DrawItemMenuLine:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r0, r1, r2, r4, r5, r6, r7, lr}	@
@ Forging.c:67: void DrawItemMenuLine(struct TextHandle* text, int item, s8 isUsable, u16* mapOut) {
	movs	r7, r0	@ text, tmp179
	movs	r5, r3	@ mapOut, tmp182
@ Forging.c:69: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	movs	r0, r1	@, item
	ldr	r3, .L30	@ tmp139,
	movs	r6, #128	@ tmp140,
@ Forging.c:67: void DrawItemMenuLine(struct TextHandle* text, int item, s8 isUsable, u16* mapOut) {
	movs	r4, r1	@ item, tmp180
	str	r2, [sp, #4]	@ tmp181, %sfp
@ Forging.c:69: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	bl	.L32		@
@ Forging.c:72: 	if(!isUsable & !isItemAnAccessory) textColor = TEXT_COLOR_GRAY;
	ldr	r3, [sp, #4]	@ isUsable, %sfp
	lsls	r6, r6, #15	@ tmp140, tmp140,
	ands	r6, r0	@ _35, tmp183
	cmp	r3, #0	@ isUsable,
	bne	.L15		@,
@ Forging.c:72: 	if(!isUsable & !isItemAnAccessory) textColor = TEXT_COLOR_GRAY;
	movs	r2, #1	@ textColor,
@ Forging.c:72: 	if(!isUsable & !isItemAnAccessory) textColor = TEXT_COLOR_GRAY;
	cmp	r6, #0	@ _35,
	beq	.L2		@,
.L15:
@ Forging.c:70: 	int textColor = TEXT_COLOR_NORMAL;
	movs	r2, #0	@ textColor,
@ Forging.c:74: 	if (isItemAnAccessory) { // Vesly added 
	cmp	r6, r2	@ _35,
	beq	.L2		@,
@ Forging.c:78: 		if(ITEM_EQUIPPED(item)) textColor = TEXT_COLOR_GOLD;
	asrs	r2, r4, #15	@ textColor, item,
@ Forging.c:78: 		if(ITEM_EQUIPPED(item)) textColor = TEXT_COLOR_GOLD;
	beq	.L2		@,
@ Forging.c:78: 		if(ITEM_EQUIPPED(item)) textColor = TEXT_COLOR_GOLD;
	movs	r2, #3	@ textColor,
.L2:
@ Forging.c:81: 	Text_SetParameters(text, 0, textColor);
	movs	r1, #0	@,
	movs	r0, r7	@, text
	ldr	r3, .L30+4	@ tmp151,
	bl	.L32		@
@ Forging.c:84: 	Text_DrawString(text, GetItemName(item));
	ldr	r3, .L30+8	@ tmp152,
	movs	r0, r4	@, item
	bl	.L32		@
@ Forging.c:84: 	Text_DrawString(text, GetItemName(item));
	ldr	r3, .L30+12	@ tmp153,
@ Forging.c:84: 	Text_DrawString(text, GetItemName(item));
	movs	r1, r0	@ _7, tmp184
@ Forging.c:84: 	Text_DrawString(text, GetItemName(item));
	movs	r0, r7	@, text
	bl	.L32		@
@ Forging.c:87: 	Text_Display(text, mapOut + 2);
	movs	r0, r7	@, text
	ldr	r3, .L30+16	@ tmp155,
	adds	r1, r5, #4	@ tmp154, mapOut,
	bl	.L32		@
	ldr	r7, .L30+20	@ tmp174,
@ Forging.c:90: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, (GetItemUses(item)&0x3F));
	cmp	r6, #0	@ _35,
	beq	.L5		@,
@ Forging.c:90: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, (GetItemUses(item)&0x3F));
	movs	r0, r4	@, item
	bl	.L33		@
@ Forging.c:90: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, (GetItemUses(item)&0x3F));
	cmp	r0, #254	@ tmp185,
	bne	.L5		@,
@ Forging.c:90: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, (GetItemUses(item)&0x3F));
	ldr	r6, [sp, #4]	@ tmp175, %sfp
@ Forging.c:90: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, (GetItemUses(item)&0x3F));
	ldr	r3, .L30+24	@ tmp157,
	movs	r0, r4	@, item
	bl	.L32		@
@ Forging.c:90: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, (GetItemUses(item)&0x3F));
	subs	r2, r6, #1	@ tmp176, tmp175
	sbcs	r6, r6, r2	@ tmp175, tmp175, tmp176
	movs	r2, #63	@ tmp159,
	ands	r2, r0	@ tmp158, tmp186
	movs	r0, r5	@ _10, mapOut
	adds	r6, r6, #1	@ iftmp.0_25,
	movs	r1, r6	@, iftmp.0_25
	ldr	r3, .L30+28	@ tmp160,
	adds	r0, r0, #22	@ _10,
	bl	.L32		@
.L5:
@ Forging.c:93: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	movs	r0, r4	@, item
	ldr	r6, .L30	@ tmp161,
	bl	.L34		@
@ Forging.c:93: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	lsls	r0, r0, #9	@ tmp195, tmp187,
	bpl	.L8		@,
@ Forging.c:93: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	movs	r0, r4	@, item
	bl	.L34		@
@ Forging.c:93: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	movs	r3, #192	@ tmp166,
	lsls	r3, r3, #17	@ tmp166, tmp166,
@ Forging.c:93: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	tst	r0, r3	@ tmp188, tmp166
	bne	.L8		@,
@ Forging.c:93: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	movs	r0, r4	@, item
	bl	.L33		@
.L9:
@ Forging.c:97: }
	@ sp needed	@
@ Forging.c:95: 	DrawIcon(mapOut, GetItemIconId(item), 0x4000);
	movs	r0, r4	@, item
	ldr	r3, .L30+32	@ tmp171,
	bl	.L32		@
	movs	r2, #128	@,
	movs	r1, r0	@ _23, tmp191
	ldr	r3, .L30+36	@ tmp173,
	movs	r0, r5	@, mapOut
	lsls	r2, r2, #7	@,,
	bl	.L32		@
@ Forging.c:97: }
	pop	{r0, r1, r2, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L8:
@ Forging.c:93: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	movs	r0, r4	@, item
	bl	.L33		@
@ Forging.c:93: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	cmp	r0, #254	@ tmp189,
	beq	.L9		@,
@ Forging.c:93: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	ldr	r6, [sp, #4]	@ isUsable, %sfp
	movs	r0, r4	@, item
	subs	r3, r6, #1	@ tmp178, isUsable
	sbcs	r6, r6, r3	@ isUsable, isUsable, tmp178
	ldr	r3, .L30+24	@ tmp169,
	bl	.L32		@
	movs	r2, r0	@ _22, tmp190
	movs	r0, r5	@ _21, mapOut
	adds	r6, r6, #1	@ iftmp.2_27,
	movs	r1, r6	@, iftmp.2_27
	ldr	r3, .L30+28	@ tmp170,
	adds	r0, r0, #22	@ _21,
	bl	.L32		@
	b	.L9		@
.L31:
	.align	2
.L30:
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
	.type	DrawItemMenuLineLong, %function
DrawItemMenuLineLong:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}	@
	movs	r6, r0	@ text, tmp192
	sub	sp, sp, #20	@,,
@ Forging.c:101: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	movs	r0, r1	@, item
@ Forging.c:99: void DrawItemMenuLineLong(struct TextHandle* text, int item, s8 isUsable, u16* mapOut) { // What is this for? 
	movs	r5, r3	@ mapOut, tmp195
@ Forging.c:101: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	ldr	r3, .L57	@ tmp146,
@ Forging.c:99: void DrawItemMenuLineLong(struct TextHandle* text, int item, s8 isUsable, u16* mapOut) { // What is this for? 
	movs	r4, r1	@ item, tmp193
	str	r2, [sp, #4]	@ tmp194, %sfp
@ Forging.c:101: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	bl	.L32		@
@ Forging.c:119: 	if(!isUsable) textColor = TEXT_COLOR_GRAY;
	ldr	r2, [sp, #4]	@ isUsable, %sfp
	movs	r3, #128	@ tmp147,
	rsbs	r1, r2, #0	@ tmp149, isUsable
	adcs	r1, r1, r2	@ tmp149, isUsable
	movs	r7, r0	@ _43, tmp196
	lsls	r3, r3, #15	@ tmp147, tmp147,
	movs	r2, r1	@ textColor, tmp149
	str	r1, [sp, #8]	@ tmp149, %sfp
	ands	r7, r3	@ _43, tmp147
@ Forging.c:122: 	if (isItemAnAccessory) { // Vesly added 
	tst	r0, r3	@ tmp196, tmp147
	beq	.L36		@,
@ Forging.c:124: 		if(ITEM_EQUIPPED(item)) textColor = TEXT_COLOR_GOLD;
	asrs	r3, r4, #15	@ tmp151, item,
@ Forging.c:124: 		if(ITEM_EQUIPPED(item)) textColor = TEXT_COLOR_GOLD;
	beq	.L36		@,
@ Forging.c:124: 		if(ITEM_EQUIPPED(item)) textColor = TEXT_COLOR_GOLD;
	movs	r2, #3	@ textColor,
.L36:
@ Forging.c:126: 	Text_SetParameters(text, 0, textColor);
	movs	r1, #0	@,
	ldr	r3, .L57+4	@ tmp152,
	movs	r0, r6	@, text
	bl	.L32		@
@ Forging.c:128: 	Text_DrawString(text, GetItemName(item));
	ldr	r3, .L57+8	@ tmp153,
	movs	r0, r4	@, item
	bl	.L32		@
@ Forging.c:128: 	Text_DrawString(text, GetItemName(item));
	ldr	r3, .L57+12	@ tmp154,
@ Forging.c:128: 	Text_DrawString(text, GetItemName(item));
	movs	r1, r0	@ _4, tmp197
@ Forging.c:128: 	Text_DrawString(text, GetItemName(item));
	movs	r0, r6	@, text
	bl	.L32		@
@ Forging.c:132: 	Text_Display(text, mapOut + 2);
	movs	r0, r6	@, text
	ldr	r3, .L57+16	@ tmp156,
	adds	r1, r5, #4	@ tmp155, mapOut,
	bl	.L32		@
@ Forging.c:134: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) { // Vesly 
	cmp	r7, #0	@ _43,
	beq	.L38		@,
@ Forging.c:134: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) { // Vesly 
	movs	r0, r4	@, item
	ldr	r3, .L57+20	@ tmp157,
	bl	.L32		@
@ Forging.c:134: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) { // Vesly 
	cmp	r0, #254	@ tmp198,
	bne	.L38		@,
@ Forging.c:136: 		DrawUiNumberOrDoubleDashes(mapOut + 10, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, (GetItemUses(item)&0x3F));
	ldr	r3, [sp, #4]	@ tmp188, %sfp
	subs	r2, r3, #1	@ tmp189, tmp188
	sbcs	r3, r3, r2	@ tmp188, tmp188, tmp189
	adds	r3, r3, #1	@ iftmp.3_34,
	str	r3, [sp, #12]	@ iftmp.3_34, %sfp
@ Forging.c:136: 		DrawUiNumberOrDoubleDashes(mapOut + 10, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, (GetItemUses(item)&0x3F));
	movs	r0, r4	@, item
	ldr	r3, .L57+24	@ tmp158,
	bl	.L32		@
@ Forging.c:136: 		DrawUiNumberOrDoubleDashes(mapOut + 10, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, (GetItemUses(item)&0x3F));
	movs	r7, #63	@ tmp160,
	movs	r2, r0	@ tmp199, tmp199
	movs	r0, r5	@ _7, mapOut
	ldr	r1, [sp, #12]	@, %sfp
	ands	r2, r7	@ tmp199, tmp160
	ldr	r6, .L57+28	@ tmp161,
	adds	r0, r0, #20	@ _7,
	bl	.L34		@
@ Forging.c:137: 		DrawUiNumberOrDoubleDashes(mapOut + 13, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, (GetItemMaxUses(item)&0x3F));
	ldr	r3, .L57+32	@ tmp162,
	movs	r0, r4	@, item
	bl	.L32		@
@ Forging.c:137: 		DrawUiNumberOrDoubleDashes(mapOut + 13, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, (GetItemMaxUses(item)&0x3F));
	movs	r2, r0	@ tmp200, tmp200
	movs	r0, r5	@ tmp165, mapOut
	ldr	r1, [sp, #12]	@, %sfp
	ands	r2, r7	@ tmp200, tmp160
	adds	r0, r0, #26	@ tmp165,
	bl	.L34		@
@ Forging.c:138: 		DrawSpecialUiChar(mapOut + 11, isUsable ? TEXT_COLOR_NORMAL : TEXT_COLOR_GRAY, 0x16); // draw special character?
	movs	r2, #22	@,
	ldr	r1, [sp, #8]	@, %sfp
	ldr	r3, .L57+36	@ tmp168,
	adds	r0, r5, r2	@ tmp167, tmp167,
	bl	.L32		@
.L38:
@ Forging.c:142: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r0, r4	@, item
	ldr	r7, .L57	@ tmp169,
	bl	.L33		@
	ldr	r6, .L57+20	@ tmp187,
@ Forging.c:142: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	lsls	r0, r0, #9	@ tmp210, tmp201,
	bpl	.L41		@,
@ Forging.c:142: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r0, r4	@, item
	bl	.L33		@
@ Forging.c:142: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r3, #192	@ tmp174,
	lsls	r3, r3, #17	@ tmp174, tmp174,
@ Forging.c:142: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	tst	r0, r3	@ tmp202, tmp174
	bne	.L41		@,
@ Forging.c:142: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r0, r4	@, item
	bl	.L34		@
.L42:
@ Forging.c:150:     DrawIcon(mapOut, GetItemIconId(item), 0x4000);
	movs	r0, r4	@, item
	ldr	r3, .L57+40	@ tmp184,
	bl	.L32		@
	movs	r2, #128	@,
	movs	r1, r0	@ _31, tmp206
	ldr	r3, .L57+44	@ tmp186,
	movs	r0, r5	@, mapOut
	lsls	r2, r2, #7	@,,
	bl	.L32		@
@ Forging.c:151: }
	add	sp, sp, #20	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L41:
@ Forging.c:142: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r0, r4	@, item
	bl	.L34		@
@ Forging.c:142: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	cmp	r0, #254	@ tmp203,
	beq	.L42		@,
@ Forging.c:143: 		DrawUiNumberOrDoubleDashes(mapOut + 10, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	ldr	r6, [sp, #4]	@ isUsable, %sfp
	movs	r0, r4	@, item
	subs	r3, r6, #1	@ tmp191, isUsable
	sbcs	r6, r6, r3	@ isUsable, isUsable, tmp191
	ldr	r3, .L57+24	@ tmp177,
	bl	.L32		@
	movs	r2, r0	@ _25, tmp204
	movs	r0, r5	@ _24, mapOut
	adds	r6, r6, #1	@ iftmp.6_36,
	movs	r1, r6	@, iftmp.6_36
	ldr	r7, .L57+28	@ tmp178,
	adds	r0, r0, #20	@ _24,
	bl	.L33		@
@ Forging.c:144: 		DrawUiNumberOrDoubleDashes(mapOut + 13, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemMaxUses(item));
	ldr	r3, .L57+32	@ tmp179,
	movs	r0, r4	@, item
	bl	.L32		@
	movs	r2, r0	@ _27, tmp205
	movs	r0, r5	@ tmp180, mapOut
	movs	r1, r6	@, iftmp.6_36
	adds	r0, r0, #26	@ tmp180,
	bl	.L33		@
@ Forging.c:145: 		DrawSpecialUiChar(mapOut + 11, isUsable ? TEXT_COLOR_NORMAL : TEXT_COLOR_GRAY, 0x16); // draw special character?
	movs	r2, #22	@,
	ldr	r1, [sp, #8]	@, %sfp
	ldr	r3, .L57+36	@ tmp183,
	adds	r0, r5, r2	@ tmp182, tmp182,
	bl	.L32		@
	b	.L42		@
.L58:
	.align	2
.L57:
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
	.type	DrawItemMenuLineNoColor, %function
DrawItemMenuLineNoColor:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r0, r1, r2, r4, r5, r6, r7, lr}	@
@ Forging.c:153: void DrawItemMenuLineNoColor(struct TextHandle* text, int item, u16* mapOut) {
	movs	r4, r1	@ item, tmp166
@ Forging.c:154:     Text_SetXCursor(text, 0);
	ldr	r3, .L69	@ tmp134,
	movs	r1, #0	@,
@ Forging.c:153: void DrawItemMenuLineNoColor(struct TextHandle* text, int item, u16* mapOut) {
	movs	r6, r2	@ mapOut, tmp167
	movs	r5, r0	@ text, tmp165
@ Forging.c:154:     Text_SetXCursor(text, 0);
	bl	.L32		@
@ Forging.c:155:     Text_DrawString(text, GetItemName(item));
	ldr	r3, .L69+4	@ tmp135,
	movs	r0, r4	@, item
	bl	.L32		@
@ Forging.c:155:     Text_DrawString(text, GetItemName(item));
	ldr	r3, .L69+8	@ tmp136,
@ Forging.c:155:     Text_DrawString(text, GetItemName(item));
	movs	r1, r0	@ _1, tmp168
@ Forging.c:155:     Text_DrawString(text, GetItemName(item));
	movs	r0, r5	@, text
	bl	.L32		@
@ Forging.c:156: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	movs	r0, r4	@, item
	ldr	r7, .L69+12	@ tmp137,
	bl	.L33		@
@ Forging.c:157:     Text_Display(text, mapOut + 2);
	movs	r0, r5	@, text
	ldr	r3, .L69+16	@ tmp139,
	adds	r1, r6, #4	@ tmp138, mapOut,
	bl	.L32		@
@ Forging.c:160: 	if ((GetItemAttributes(item) & IA_ACCESSORY) && (GetItemMight(item) == 0xFE)) { // Vesly - berries 
	movs	r0, r4	@, item
	bl	.L33		@
@ Forging.c:160: 	if ((GetItemAttributes(item) & IA_ACCESSORY) && (GetItemMight(item) == 0xFE)) { // Vesly - berries 
	lsls	r0, r0, #9	@ tmp181, tmp169,
	bpl	.L61		@,
@ Forging.c:160: 	if ((GetItemAttributes(item) & IA_ACCESSORY) && (GetItemMight(item) == 0xFE)) { // Vesly - berries 
	movs	r0, r4	@, item
	ldr	r3, .L69+20	@ tmp143,
	bl	.L32		@
@ Forging.c:160: 	if ((GetItemAttributes(item) & IA_ACCESSORY) && (GetItemMight(item) == 0xFE)) { // Vesly - berries 
	cmp	r0, #254	@ tmp170,
	bne	.L61		@,
@ Forging.c:161: 		DrawSpecialUiChar(mapOut + 11, Text_GetColorId(text), (GetItemUses(item)&0x3F));
	ldr	r3, .L69+24	@ tmp144,
	movs	r0, r5	@, text
	bl	.L32		@
@ Forging.c:161: 		DrawSpecialUiChar(mapOut + 11, Text_GetColorId(text), (GetItemUses(item)&0x3F));
	ldr	r3, .L69+28	@ tmp145,
@ Forging.c:161: 		DrawSpecialUiChar(mapOut + 11, Text_GetColorId(text), (GetItemUses(item)&0x3F));
	str	r0, [sp, #4]	@ tmp171, %sfp
@ Forging.c:161: 		DrawSpecialUiChar(mapOut + 11, Text_GetColorId(text), (GetItemUses(item)&0x3F));
	movs	r0, r4	@, item
	bl	.L32		@
@ Forging.c:161: 		DrawSpecialUiChar(mapOut + 11, Text_GetColorId(text), (GetItemUses(item)&0x3F));
	movs	r2, #63	@ tmp147,
	ands	r2, r0	@ tmp146, tmp172
	movs	r0, r6	@ tmp148, mapOut
	ldr	r1, [sp, #4]	@, %sfp
	ldr	r3, .L69+32	@ tmp149,
	adds	r0, r0, #22	@ tmp148,
	bl	.L32		@
.L61:
@ Forging.c:165: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) && (GetItemMight(item) != 0xFE)) {
	movs	r0, r4	@, item
	bl	.L33		@
@ Forging.c:165: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) && (GetItemMight(item) != 0xFE)) {
	lsls	r0, r0, #9	@ tmp182, tmp173,
	bmi	.L63		@,
.L66:
@ Forging.c:165: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) && (GetItemMight(item) != 0xFE)) {
	movs	r0, r4	@, item
	ldr	r3, .L69+20	@ tmp153,
	bl	.L32		@
@ Forging.c:165: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) && (GetItemMight(item) != 0xFE)) {
	cmp	r0, #254	@ tmp174,
	beq	.L67		@,
@ Forging.c:166: 		DrawSpecialUiChar(mapOut + 11, Text_GetColorId(text), GetItemUses(item));
	movs	r0, r5	@, text
	ldr	r3, .L69+24	@ tmp157,
	bl	.L32		@
	ldr	r3, .L69+28	@ tmp158,
	movs	r5, r0	@ _16, tmp176
	movs	r0, r4	@, item
	bl	.L32		@
	movs	r2, r0	@ _17, tmp177
	movs	r0, r6	@ tmp159, mapOut
	movs	r1, r5	@, _16
	ldr	r3, .L69+32	@ tmp160,
	adds	r0, r0, #22	@ tmp159,
	bl	.L32		@
	b	.L67		@
.L63:
@ Forging.c:165: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) && (GetItemMight(item) != 0xFE)) {
	movs	r0, r4	@, item
	bl	.L33		@
@ Forging.c:165: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) && (GetItemMight(item) != 0xFE)) {
	movs	r3, #192	@ tmp156,
	lsls	r3, r3, #17	@ tmp156, tmp156,
@ Forging.c:165: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) && (GetItemMight(item) != 0xFE)) {
	tst	r0, r3	@ tmp175, tmp156
	bne	.L66		@,
.L67:
@ Forging.c:170: }
	@ sp needed	@
@ Forging.c:169:     DrawIcon(mapOut, GetItemIconId(item), 0x4000);
	movs	r0, r4	@, item
	ldr	r3, .L69+36	@ tmp161,
	bl	.L32		@
	movs	r2, #128	@,
	movs	r1, r0	@ _18, tmp178
	ldr	r3, .L69+40	@ tmp163,
	movs	r0, r6	@, mapOut
	lsls	r2, r2, #7	@,,
	bl	.L32		@
@ Forging.c:170: }
	pop	{r0, r1, r2, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L70:
	.align	2
.L69:
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
	.type	DrawItemStatScreenLine, %function
DrawItemStatScreenLine:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}	@
	sub	sp, sp, #20	@,,
@ Forging.c:172: void DrawItemStatScreenLine(struct TextHandle* text, int item, int nameColor, u16* mapOut) {
	str	r0, [sp, #4]	@ tmp206, %sfp
	movs	r5, r3	@ mapOut, tmp209
@ Forging.c:174: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	movs	r0, r1	@, item
	ldr	r3, .L91	@ tmp150,
	movs	r7, #128	@ tmp151,
@ Forging.c:172: void DrawItemStatScreenLine(struct TextHandle* text, int item, int nameColor, u16* mapOut) {
	movs	r4, r1	@ item, tmp207
	movs	r6, r2	@ nameColor, tmp208
@ Forging.c:174: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	bl	.L32		@
	lsls	r7, r7, #15	@ tmp151, tmp151,
@ Forging.c:176:     Text_Clear(text);
	ldr	r3, .L91+4	@ tmp152,
	ands	r7, r0	@ _41, tmp210
	ldr	r0, [sp, #4]	@, %sfp
	bl	.L32		@
	movs	r1, r6	@ color, nameColor
@ Forging.c:196: 	if (isItemAnAccessory) { // Vesly 
	cmp	r7, #0	@ _41,
	beq	.L72		@,
@ Forging.c:197: 		if(ITEM_EQUIPPED(item) & (nameColor != TEXT_COLOR_GREEN)) color = TEXT_COLOR_GOLD;
	subs	r2, r6, #4	@ tmp156, nameColor,
	subs	r0, r2, #1	@ tmp157, tmp156
	sbcs	r2, r2, r0	@ tmp155, tmp156, tmp157
@ Forging.c:197: 		if(ITEM_EQUIPPED(item) & (nameColor != TEXT_COLOR_GREEN)) color = TEXT_COLOR_GOLD;
	asrs	r3, r4, #15	@ tmp153, item,
@ Forging.c:197: 		if(ITEM_EQUIPPED(item) & (nameColor != TEXT_COLOR_GREEN)) color = TEXT_COLOR_GOLD;
	tst	r2, r3	@ tmp155, tmp153
	beq	.L72		@,
@ Forging.c:197: 		if(ITEM_EQUIPPED(item) & (nameColor != TEXT_COLOR_GREEN)) color = TEXT_COLOR_GOLD;
	movs	r1, #3	@ color,
.L72:
@ Forging.c:199:     Text_SetColorId(text, color);
	ldr	r3, .L91+8	@ tmp159,
	ldr	r0, [sp, #4]	@, %sfp
	bl	.L32		@
@ Forging.c:201:     Text_DrawString(text, GetItemName(item));
	ldr	r3, .L91+12	@ tmp160,
	movs	r0, r4	@, item
	bl	.L32		@
@ Forging.c:201:     Text_DrawString(text, GetItemName(item));
	ldr	r3, .L91+16	@ tmp161,
@ Forging.c:201:     Text_DrawString(text, GetItemName(item));
	movs	r1, r0	@ _6, tmp211
@ Forging.c:201:     Text_DrawString(text, GetItemName(item));
	ldr	r0, [sp, #4]	@, %sfp
	bl	.L32		@
@ Forging.c:206: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) { // Vesly - berries 
	cmp	r7, #0	@ _41,
	beq	.L74		@,
@ Forging.c:206: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) { // Vesly - berries 
	movs	r0, r4	@, item
	ldr	r3, .L91+20	@ tmp162,
	bl	.L32		@
@ Forging.c:206: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) { // Vesly - berries 
	cmp	r0, #254	@ tmp212,
	bne	.L74		@,
@ Forging.c:208: 		DrawSpecialUiChar(mapOut + 12, color, 0x16);
	movs	r0, r5	@ tmp167, mapOut
@ Forging.c:207: 		color = (nameColor == TEXT_COLOR_GRAY) ? TEXT_COLOR_GRAY : TEXT_COLOR_NORMAL;
	subs	r7, r6, #1	@ tmp165, nameColor,
	rsbs	r1, r7, #0	@ color, tmp165
	adcs	r1, r1, r7	@ color, tmp165
@ Forging.c:208: 		DrawSpecialUiChar(mapOut + 12, color, 0x16);
	movs	r2, #22	@,
	ldr	r3, .L91+24	@ tmp168,
	adds	r0, r0, #24	@ tmp167,
	bl	.L32		@
@ Forging.c:210: 		color = (nameColor != TEXT_COLOR_GRAY) ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY;
	subs	r3, r7, #1	@ tmp205, tmp165
	sbcs	r7, r7, r3	@ tmp203, tmp165, tmp205
	adds	r3, r7, #1	@ iftmp.8_30, tmp203,
	str	r3, [sp, #8]	@ iftmp.8_30, %sfp
@ Forging.c:211: 		DrawUiNumberOrDoubleDashes(mapOut + 11, color, (GetItemUses(item)&0x3F));
	movs	r0, r4	@, item
	ldr	r3, .L91+28	@ tmp169,
	bl	.L32		@
@ Forging.c:211: 		DrawUiNumberOrDoubleDashes(mapOut + 11, color, (GetItemUses(item)&0x3F));
	movs	r7, #63	@ tmp171,
	movs	r2, r0	@ tmp213, tmp213
	movs	r0, r5	@ tmp172, mapOut
	ldr	r3, .L91+32	@ tmp173,
	ldr	r1, [sp, #8]	@, %sfp
	ands	r2, r7	@ tmp213, tmp171
	adds	r0, r0, #22	@ tmp172,
	str	r3, [sp, #12]	@ tmp173, %sfp
	bl	.L32		@
@ Forging.c:212: 		DrawUiNumberOrDoubleDashes(mapOut + 14, color, (GetItemMaxUses(item)&0x3F));
	ldr	r3, .L91+36	@ tmp174,
	movs	r0, r4	@, item
	bl	.L32		@
@ Forging.c:212: 		DrawUiNumberOrDoubleDashes(mapOut + 14, color, (GetItemMaxUses(item)&0x3F));
	movs	r2, r0	@ tmp214, tmp214
	movs	r0, r5	@ tmp177, mapOut
	ldr	r1, [sp, #8]	@, %sfp
	ldr	r3, [sp, #12]	@ tmp173, %sfp
	ands	r2, r7	@ tmp214, tmp171
	adds	r0, r0, #28	@ tmp177,
	bl	.L32		@
.L74:
@ Forging.c:217: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) && (GetItemMight(item) != 0xFE)) {
	movs	r0, r4	@, item
	ldr	r7, .L91	@ tmp179,
	bl	.L33		@
@ Forging.c:217: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) && (GetItemMight(item) != 0xFE)) {
	lsls	r0, r0, #9	@ tmp224, tmp215,
	bmi	.L77		@,
.L80:
@ Forging.c:217: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) && (GetItemMight(item) != 0xFE)) {
	movs	r0, r4	@, item
	ldr	r3, .L91+20	@ tmp182,
	bl	.L32		@
@ Forging.c:217: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) && (GetItemMight(item) != 0xFE)) {
	cmp	r0, #254	@ tmp216,
	beq	.L81		@,
@ Forging.c:219: 		DrawSpecialUiChar(mapOut + 12, color, 0x16);
	movs	r0, r5	@ tmp190, mapOut
@ Forging.c:218: 		color = (nameColor == TEXT_COLOR_GRAY) ? TEXT_COLOR_GRAY : TEXT_COLOR_NORMAL;
	subs	r1, r6, #1	@ tmp188, nameColor,
	rsbs	r3, r1, #0	@ tmp189, tmp188
	adcs	r1, r1, r3	@ color, tmp188, tmp189
@ Forging.c:219: 		DrawSpecialUiChar(mapOut + 12, color, 0x16);
	movs	r2, #22	@,
	ldr	r3, .L91+24	@ tmp191,
	adds	r0, r0, #24	@ tmp190,
	bl	.L32		@
@ Forging.c:221: 		color = (nameColor != TEXT_COLOR_GRAY) ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY;
	cmp	r6, #1	@ nameColor,
	beq	.L82		@,
	movs	r6, #2	@ nameColor,
.L82:
@ Forging.c:222: 		DrawUiNumberOrDoubleDashes(mapOut + 11, color, GetItemUses(item));
	ldr	r3, .L91+28	@ tmp192,
	movs	r0, r4	@, item
	bl	.L32		@
	movs	r2, r0	@ _24, tmp218
	movs	r0, r5	@ tmp193, mapOut
	movs	r1, r6	@, nameColor
	ldr	r7, .L91+32	@ tmp194,
	adds	r0, r0, #22	@ tmp193,
	bl	.L33		@
@ Forging.c:223: 		DrawUiNumberOrDoubleDashes(mapOut + 14, color, GetItemMaxUses(item));
	movs	r0, r4	@, item
	ldr	r3, .L91+36	@ tmp195,
	bl	.L32		@
	movs	r2, r0	@ _26, tmp219
	movs	r0, r5	@ tmp196, mapOut
	movs	r1, r6	@, nameColor
	adds	r0, r0, #28	@ tmp196,
	bl	.L33		@
	b	.L81		@
.L77:
@ Forging.c:217: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) && (GetItemMight(item) != 0xFE)) {
	movs	r0, r4	@, item
	bl	.L33		@
@ Forging.c:217: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) && (GetItemMight(item) != 0xFE)) {
	movs	r3, #192	@ tmp185,
	lsls	r3, r3, #17	@ tmp185, tmp185,
@ Forging.c:217: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) && (GetItemMight(item) != 0xFE)) {
	tst	r0, r3	@ tmp217, tmp185
	bne	.L80		@,
.L81:
@ Forging.c:228:     Text_Display(text, mapOut + 2);
	adds	r1, r5, #4	@ tmp198, mapOut,
	ldr	r0, [sp, #4]	@, %sfp
	ldr	r3, .L91+40	@ tmp199,
	bl	.L32		@
@ Forging.c:230:     DrawIcon(mapOut, GetItemIconId(item), 0x4000);
	movs	r0, r4	@, item
	ldr	r3, .L91+44	@ tmp200,
	bl	.L32		@
	movs	r2, #128	@,
	movs	r1, r0	@ _28, tmp220
	ldr	r3, .L91+48	@ tmp202,
	movs	r0, r5	@, mapOut
	lsls	r2, r2, #7	@,,
	bl	.L32		@
@ Forging.c:231: }
	add	sp, sp, #20	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L92:
	.align	2
.L91:
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
	.type	GetItemAfterUse, %function
GetItemAfterUse:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ Forging.c:235:     if (GetItemAttributes(item) & IA_UNBREAKABLE) {
	ldr	r3, .L98	@ tmp120,
@ Forging.c:234: u16 GetItemAfterUse(int item) {
	movs	r4, r0	@ item, tmp129
@ Forging.c:235:     if (GetItemAttributes(item) & IA_UNBREAKABLE) {
	bl	.L32		@
@ Forging.c:235:     if (GetItemAttributes(item) & IA_UNBREAKABLE) {
	lsls	r0, r0, #28	@ tmp131, tmp130,
	bpl	.L94		@,
.L97:
@ Forging.c:246:     return item; // return used item
	lsls	r0, r4, #16	@ <retval>, item,
	lsrs	r0, r0, #16	@ <retval>, <retval>,
	b	.L95		@
.L94:
@ Forging.c:241:     item -= (1 << 8); // lose one use
	subs	r4, r4, #1	@ item,
	subs	r4, r4, #255	@ item,
@ Forging.c:243:     if (ITEM_USES(item) < 1)
	lsls	r3, r4, #18	@ tmp126, item,
	lsrs	r3, r3, #26	@ tmp125, tmp126,
@ Forging.c:244:         return 0; // return no item if uses < 0
	subs	r0, r3, #0	@ <retval>, tmp125,
@ Forging.c:243:     if (ITEM_USES(item) < 1)
	bne	.L97		@,
.L95:
@ Forging.c:247: }
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L99:
	.align	2
.L98:
	.word	GetItemAttributes
	.size	GetItemAfterUse, .-GetItemAfterUse
	.ident	"GCC: (devkitARM release 59) 12.2.0"
	.code 16
	.align	1
.L32:
	bx	r3
.L34:
	bx	r6
.L33:
	bx	r7
