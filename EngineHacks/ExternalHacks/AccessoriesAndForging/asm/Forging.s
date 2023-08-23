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
@ GNU C17 (devkitARM release 56) version 11.1.0 (arm-none-eabi)
@	compiled by GNU C version 10.3.0, GMP version 6.2.1, MPFR version 4.1.0, MPC version 1.2.1, isl version isl-0.18-GMP

@ GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
@ options passed: -mcpu=arm7tdmi -mthumb -mthumb-interwork -mtune=arm7tdmi -mlong-calls -march=armv4t -Os
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
	movs	r6, r0	@ text, tmp200
	movs	r5, r3	@ mapOut, tmp203
@ Forging.c:69: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	movs	r0, r1	@, item
	ldr	r3, .L29	@ tmp145,
@ Forging.c:69: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	movs	r7, #128	@ tmp146,
@ Forging.c:67: void DrawItemMenuLine(struct TextHandle* text, int item, s8 isUsable, u16* mapOut) {
	movs	r4, r1	@ item, tmp201
	str	r2, [sp]	@ tmp202, %sfp
@ Forging.c:69: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	bl	.L31		@
@ Forging.c:72: 	if(!isUsable & !isItemAnAccessory) textColor = TEXT_COLOR_GRAY;
	ldr	r3, [sp]	@ isUsable, %sfp
@ Forging.c:69: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	lsls	r7, r7, #15	@ tmp146, tmp146,
	ands	r7, r0	@ isItemAnAccessory, tmp204
@ Forging.c:72: 	if(!isUsable & !isItemAnAccessory) textColor = TEXT_COLOR_GRAY;
	cmp	r3, #0	@ isUsable,
	bne	.L17		@,
@ Forging.c:72: 	if(!isUsable & !isItemAnAccessory) textColor = TEXT_COLOR_GRAY;
	movs	r2, #1	@ textColor,
@ Forging.c:72: 	if(!isUsable & !isItemAnAccessory) textColor = TEXT_COLOR_GRAY;
	cmp	r7, #0	@ isItemAnAccessory,
	beq	.L2		@,
.L17:
@ Forging.c:70: 	int textColor = TEXT_COLOR_NORMAL;
	subs	r2, r7, #0	@ textColor, isItemAnAccessory,
@ Forging.c:74: 	if (isItemAnAccessory) { // Vesly added 
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
	movs	r0, r6	@, text
	ldr	r3, .L29+4	@ tmp157,
	bl	.L31		@
@ Forging.c:84: 	Text_DrawString(text, GetItemName(item));
	ldr	r3, .L29+8	@ tmp158,
	movs	r0, r4	@, item
	bl	.L31		@
@ Forging.c:84: 	Text_DrawString(text, GetItemName(item));
	ldr	r3, .L29+12	@ tmp159,
@ Forging.c:84: 	Text_DrawString(text, GetItemName(item));
	movs	r1, r0	@ _7, tmp205
@ Forging.c:84: 	Text_DrawString(text, GetItemName(item));
	movs	r0, r6	@, text
	bl	.L31		@
@ Forging.c:87: 	Text_Display(text, mapOut + 2);
	movs	r0, r6	@, text
	ldr	r3, .L29+16	@ tmp161,
	adds	r1, r5, #4	@ tmp160, mapOut,
	bl	.L31		@
	ldr	r6, .L29+20	@ tmp194,
@ Forging.c:90: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, (GetItemUses(item)&0x3F));
	cmp	r7, #0	@ isItemAnAccessory,
	beq	.L5		@,
@ Forging.c:90: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, (GetItemUses(item)&0x3F));
	movs	r0, r4	@, item
	bl	.L32		@
@ Forging.c:90: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, (GetItemUses(item)&0x3F));
	cmp	r0, #254	@ tmp206,
	bne	.L5		@,
@ Forging.c:90: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, (GetItemUses(item)&0x3F));
	ldr	r7, [sp]	@ tmp196, %sfp
@ Forging.c:90: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, (GetItemUses(item)&0x3F));
	movs	r0, r4	@, item
@ Forging.c:90: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, (GetItemUses(item)&0x3F));
	subs	r3, r7, #1	@ tmp197, tmp196
	sbcs	r7, r7, r3	@ tmp196, tmp196, tmp197
@ Forging.c:90: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, (GetItemUses(item)&0x3F));
	ldr	r3, .L29+24	@ tmp163,
	bl	.L31		@
@ Forging.c:90: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, (GetItemUses(item)&0x3F));
	movs	r2, #63	@ tmp165,
	ands	r2, r0	@ tmp164, tmp207
	movs	r0, r5	@ _10, mapOut
	adds	r7, r7, #1	@ iftmp.0_26,
	movs	r1, r7	@, iftmp.0_26
	ldr	r3, .L29+28	@ tmp166,
	adds	r0, r0, #22	@ _10,
	bl	.L31		@
.L5:
@ Forging.c:93: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	movs	r0, r4	@, item
	ldr	r7, .L29	@ tmp167,
	bl	.L33		@
@ Forging.c:93: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	movs	r3, #1	@ iftmp.1_27,
	str	r3, [sp, #4]	@ iftmp.1_27, %sfp
	lsls	r0, r0, #9	@ tmp216, tmp208,
	bpl	.L8		@,
@ Forging.c:93: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	movs	r0, r4	@, item
	bl	.L33		@
@ Forging.c:93: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	movs	r3, #192	@ tmp172,
	lsls	r3, r3, #17	@ tmp172, tmp172,
	ands	r0, r3	@ tmp171, tmp172
@ Forging.c:93: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	subs	r3, r0, #1	@ tmp175, tmp171
	sbcs	r0, r0, r3	@ tmp171, tmp171, tmp175
	str	r0, [sp, #4]	@ tmp171, %sfp
.L8:
@ Forging.c:93: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	movs	r0, r4	@, item
	bl	.L32		@
@ Forging.c:93: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	cmp	r0, #254	@ tmp210,
	beq	.L9		@,
	ldr	r3, [sp, #4]	@ iftmp.1_27, %sfp
	cmp	r3, #0	@ iftmp.1_27,
	beq	.L9		@,
@ Forging.c:93: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) DrawUiNumberOrDoubleDashes(mapOut + 11, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	ldr	r6, [sp]	@ isUsable, %sfp
	movs	r0, r4	@, item
	subs	r3, r6, #1	@ tmp199, isUsable
	sbcs	r6, r6, r3	@ isUsable, isUsable, tmp199
	ldr	r3, .L29+24	@ tmp189,
	bl	.L31		@
	movs	r2, r0	@ _22, tmp211
	movs	r0, r5	@ _21, mapOut
	adds	r6, r6, #1	@ iftmp.2_28,
	movs	r1, r6	@, iftmp.2_28
	ldr	r3, .L29+28	@ tmp190,
	adds	r0, r0, #22	@ _21,
	bl	.L31		@
.L9:
@ Forging.c:97: }
	@ sp needed	@
@ Forging.c:95: 	DrawIcon(mapOut, GetItemIconId(item), 0x4000);
	movs	r0, r4	@, item
	ldr	r3, .L29+32	@ tmp191,
	bl	.L31		@
	movs	r2, #128	@,
	movs	r1, r0	@ _23, tmp212
	ldr	r3, .L29+36	@ tmp193,
	movs	r0, r5	@, mapOut
	lsls	r2, r2, #7	@,,
	bl	.L31		@
@ Forging.c:97: }
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
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}	@
	movs	r6, r0	@ text, tmp212
	sub	sp, sp, #20	@,,
@ Forging.c:101: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	movs	r0, r1	@, item
@ Forging.c:99: void DrawItemMenuLineLong(struct TextHandle* text, int item, s8 isUsable, u16* mapOut) { // What is this for? 
	movs	r5, r3	@ mapOut, tmp215
@ Forging.c:101: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	ldr	r3, .L58	@ tmp152,
@ Forging.c:99: void DrawItemMenuLineLong(struct TextHandle* text, int item, s8 isUsable, u16* mapOut) { // What is this for? 
	movs	r4, r1	@ item, tmp213
	str	r2, [sp, #4]	@ tmp214, %sfp
@ Forging.c:101: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	bl	.L31		@
@ Forging.c:119: 	if(!isUsable) textColor = TEXT_COLOR_GRAY;
	ldr	r2, [sp, #4]	@ isUsable, %sfp
@ Forging.c:101: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	movs	r3, #128	@ tmp153,
@ Forging.c:119: 	if(!isUsable) textColor = TEXT_COLOR_GRAY;
	rsbs	r1, r2, #0	@ tmp155, isUsable
	adcs	r1, r1, r2	@ tmp155, isUsable
@ Forging.c:101: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	movs	r7, r0	@ isItemAnAccessory, tmp216
	lsls	r3, r3, #15	@ tmp153, tmp153,
	movs	r2, r1	@ textColor, tmp155
@ Forging.c:119: 	if(!isUsable) textColor = TEXT_COLOR_GRAY;
	str	r1, [sp, #8]	@ tmp155, %sfp
@ Forging.c:101: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	ands	r7, r3	@ isItemAnAccessory, tmp153
@ Forging.c:122: 	if (isItemAnAccessory) { // Vesly added 
	tst	r0, r3	@ tmp216, tmp153
	beq	.L35		@,
@ Forging.c:124: 		if(ITEM_EQUIPPED(item)) textColor = TEXT_COLOR_GOLD;
	asrs	r3, r4, #15	@ tmp157, item,
@ Forging.c:124: 		if(ITEM_EQUIPPED(item)) textColor = TEXT_COLOR_GOLD;
	beq	.L35		@,
@ Forging.c:124: 		if(ITEM_EQUIPPED(item)) textColor = TEXT_COLOR_GOLD;
	movs	r2, #3	@ textColor,
.L35:
@ Forging.c:126: 	Text_SetParameters(text, 0, textColor);
	movs	r1, #0	@,
	ldr	r3, .L58+4	@ tmp158,
	movs	r0, r6	@, text
	bl	.L31		@
@ Forging.c:128: 	Text_DrawString(text, GetItemName(item));
	ldr	r3, .L58+8	@ tmp159,
	movs	r0, r4	@, item
	bl	.L31		@
@ Forging.c:128: 	Text_DrawString(text, GetItemName(item));
	ldr	r3, .L58+12	@ tmp160,
@ Forging.c:128: 	Text_DrawString(text, GetItemName(item));
	movs	r1, r0	@ _4, tmp217
@ Forging.c:128: 	Text_DrawString(text, GetItemName(item));
	movs	r0, r6	@, text
	bl	.L31		@
@ Forging.c:132: 	Text_Display(text, mapOut + 2);
	movs	r0, r6	@, text
	ldr	r3, .L58+16	@ tmp162,
	adds	r1, r5, #4	@ tmp161, mapOut,
	bl	.L31		@
@ Forging.c:134: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) { // Vesly 
	cmp	r7, #0	@ isItemAnAccessory,
	beq	.L37		@,
@ Forging.c:134: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) { // Vesly 
	movs	r0, r4	@, item
	ldr	r3, .L58+20	@ tmp163,
	bl	.L31		@
@ Forging.c:134: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) { // Vesly 
	cmp	r0, #254	@ tmp218,
	bne	.L37		@,
@ Forging.c:136: 		DrawUiNumberOrDoubleDashes(mapOut + 10, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, (GetItemUses(item)&0x3F));
	ldr	r6, [sp, #4]	@ tmp208, %sfp
@ Forging.c:136: 		DrawUiNumberOrDoubleDashes(mapOut + 10, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, (GetItemUses(item)&0x3F));
	movs	r0, r4	@, item
@ Forging.c:136: 		DrawUiNumberOrDoubleDashes(mapOut + 10, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, (GetItemUses(item)&0x3F));
	subs	r3, r6, #1	@ tmp209, tmp208
	sbcs	r6, r6, r3	@ tmp208, tmp208, tmp209
@ Forging.c:136: 		DrawUiNumberOrDoubleDashes(mapOut + 10, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, (GetItemUses(item)&0x3F));
	ldr	r3, .L58+24	@ tmp164,
	bl	.L31		@
@ Forging.c:136: 		DrawUiNumberOrDoubleDashes(mapOut + 10, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, (GetItemUses(item)&0x3F));
	movs	r7, #63	@ tmp166,
	movs	r2, r0	@ tmp219, tmp219
	movs	r0, r5	@ _7, mapOut
	ldr	r3, .L58+28	@ tmp167,
	adds	r6, r6, #1	@ iftmp.3_34,
	movs	r1, r6	@, iftmp.3_34
	ands	r2, r7	@ tmp219, tmp166
	adds	r0, r0, #20	@ _7,
	str	r3, [sp, #12]	@ tmp167, %sfp
	bl	.L31		@
@ Forging.c:137: 		DrawUiNumberOrDoubleDashes(mapOut + 13, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, (GetItemMaxUses(item)&0x3F));
	ldr	r3, .L58+32	@ tmp168,
	movs	r0, r4	@, item
	bl	.L31		@
@ Forging.c:137: 		DrawUiNumberOrDoubleDashes(mapOut + 13, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, (GetItemMaxUses(item)&0x3F));
	movs	r2, r0	@ tmp220, tmp220
	movs	r0, r5	@ tmp171, mapOut
	movs	r1, r6	@, iftmp.3_34
	ldr	r3, [sp, #12]	@ tmp167, %sfp
	ands	r2, r7	@ tmp220, tmp166
	adds	r0, r0, #26	@ tmp171,
	bl	.L31		@
@ Forging.c:138: 		DrawSpecialUiChar(mapOut + 11, isUsable ? TEXT_COLOR_NORMAL : TEXT_COLOR_GRAY, 0x16); // draw special character?
	movs	r2, #22	@,
	ldr	r1, [sp, #8]	@, %sfp
	ldr	r3, .L58+36	@ tmp174,
	adds	r0, r5, r2	@ tmp173, tmp173,
	bl	.L31		@
.L37:
@ Forging.c:142: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r0, r4	@, item
	ldr	r7, .L58	@ tmp175,
	bl	.L33		@
@ Forging.c:142: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r6, #1	@ iftmp.5_35,
	lsls	r0, r0, #9	@ tmp230, tmp221,
	bpl	.L40		@,
@ Forging.c:142: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r0, r4	@, item
@ Forging.c:142: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r6, #192	@ tmp180,
@ Forging.c:142: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	bl	.L33		@
@ Forging.c:142: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	lsls	r6, r6, #17	@ tmp180, tmp180,
	ands	r6, r0	@ tmp179, tmp222
@ Forging.c:142: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	subs	r3, r6, #1	@ tmp183, tmp179
	sbcs	r6, r6, r3	@ iftmp.5_35, tmp179, tmp183
.L40:
@ Forging.c:142: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	movs	r0, r4	@, item
	ldr	r3, .L58+20	@ tmp184,
	bl	.L31		@
@ Forging.c:142: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) & (GetItemMight(item) != 0xFE)) {
	cmp	r0, #254	@ tmp223,
	beq	.L41		@,
	cmp	r6, #0	@ iftmp.5_35,
	beq	.L41		@,
@ Forging.c:143: 		DrawUiNumberOrDoubleDashes(mapOut + 10, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemUses(item));
	ldr	r6, [sp, #4]	@ isUsable, %sfp
	movs	r0, r4	@, item
	subs	r3, r6, #1	@ tmp211, isUsable
	sbcs	r6, r6, r3	@ isUsable, isUsable, tmp211
	ldr	r3, .L58+24	@ tmp197,
	bl	.L31		@
	movs	r2, r0	@ _25, tmp224
	movs	r0, r5	@ _24, mapOut
	adds	r6, r6, #1	@ iftmp.6_36,
	movs	r1, r6	@, iftmp.6_36
	ldr	r7, .L58+28	@ tmp198,
	adds	r0, r0, #20	@ _24,
	bl	.L33		@
@ Forging.c:144: 		DrawUiNumberOrDoubleDashes(mapOut + 13, isUsable ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY, GetItemMaxUses(item));
	ldr	r3, .L58+32	@ tmp199,
	movs	r0, r4	@, item
	bl	.L31		@
	movs	r2, r0	@ _27, tmp225
	movs	r0, r5	@ tmp200, mapOut
	movs	r1, r6	@, iftmp.6_36
	adds	r0, r0, #26	@ tmp200,
	bl	.L33		@
@ Forging.c:145: 		DrawSpecialUiChar(mapOut + 11, isUsable ? TEXT_COLOR_NORMAL : TEXT_COLOR_GRAY, 0x16); // draw special character?
	movs	r2, #22	@,
	ldr	r1, [sp, #8]	@, %sfp
	ldr	r3, .L58+36	@ tmp203,
	adds	r0, r5, r2	@ tmp202, tmp202,
	bl	.L31		@
.L41:
@ Forging.c:150:     DrawIcon(mapOut, GetItemIconId(item), 0x4000);
	movs	r0, r4	@, item
	ldr	r3, .L58+40	@ tmp204,
	bl	.L31		@
	movs	r2, #128	@,
	movs	r1, r0	@ _31, tmp226
	ldr	r3, .L58+44	@ tmp206,
	movs	r0, r5	@, mapOut
	lsls	r2, r2, #7	@,,
	bl	.L31		@
@ Forging.c:151: }
	add	sp, sp, #20	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L59:
	.align	2
.L58:
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
@ Forging.c:153: void DrawItemMenuLineNoColor(struct TextHandle* text, int item, u16* mapOut) {
	movs	r4, r1	@ item, tmp166
@ Forging.c:154:     Text_SetXCursor(text, 0);
	ldr	r3, .L70	@ tmp134,
	movs	r1, #0	@,
@ Forging.c:153: void DrawItemMenuLineNoColor(struct TextHandle* text, int item, u16* mapOut) {
	movs	r6, r2	@ mapOut, tmp167
	movs	r5, r0	@ text, tmp165
@ Forging.c:154:     Text_SetXCursor(text, 0);
	bl	.L31		@
@ Forging.c:155:     Text_DrawString(text, GetItemName(item));
	ldr	r3, .L70+4	@ tmp135,
	movs	r0, r4	@, item
	bl	.L31		@
@ Forging.c:155:     Text_DrawString(text, GetItemName(item));
	ldr	r3, .L70+8	@ tmp136,
@ Forging.c:155:     Text_DrawString(text, GetItemName(item));
	movs	r1, r0	@ _1, tmp168
@ Forging.c:155:     Text_DrawString(text, GetItemName(item));
	movs	r0, r5	@, text
	bl	.L31		@
@ Forging.c:156: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	movs	r0, r4	@, item
	ldr	r7, .L70+12	@ tmp137,
	bl	.L33		@
@ Forging.c:157:     Text_Display(text, mapOut + 2);
	movs	r0, r5	@, text
	ldr	r3, .L70+16	@ tmp139,
	adds	r1, r6, #4	@ tmp138, mapOut,
	bl	.L31		@
@ Forging.c:160: 	if ((GetItemAttributes(item) & IA_ACCESSORY) && (GetItemMight(item) == 0xFE)) { // Vesly - berries 
	movs	r0, r4	@, item
	bl	.L33		@
@ Forging.c:160: 	if ((GetItemAttributes(item) & IA_ACCESSORY) && (GetItemMight(item) == 0xFE)) { // Vesly - berries 
	lsls	r0, r0, #9	@ tmp181, tmp169,
	bpl	.L62		@,
@ Forging.c:160: 	if ((GetItemAttributes(item) & IA_ACCESSORY) && (GetItemMight(item) == 0xFE)) { // Vesly - berries 
	movs	r0, r4	@, item
	ldr	r3, .L70+20	@ tmp143,
	bl	.L31		@
@ Forging.c:160: 	if ((GetItemAttributes(item) & IA_ACCESSORY) && (GetItemMight(item) == 0xFE)) { // Vesly - berries 
	cmp	r0, #254	@ tmp170,
	bne	.L62		@,
@ Forging.c:161: 		DrawSpecialUiChar(mapOut + 11, Text_GetColorId(text), (GetItemUses(item)&0x3F));
	ldr	r3, .L70+24	@ tmp144,
	movs	r0, r5	@, text
	bl	.L31		@
@ Forging.c:161: 		DrawSpecialUiChar(mapOut + 11, Text_GetColorId(text), (GetItemUses(item)&0x3F));
	ldr	r3, .L70+28	@ tmp145,
@ Forging.c:161: 		DrawSpecialUiChar(mapOut + 11, Text_GetColorId(text), (GetItemUses(item)&0x3F));
	str	r0, [sp, #4]	@ tmp171, %sfp
@ Forging.c:161: 		DrawSpecialUiChar(mapOut + 11, Text_GetColorId(text), (GetItemUses(item)&0x3F));
	movs	r0, r4	@, item
	bl	.L31		@
@ Forging.c:161: 		DrawSpecialUiChar(mapOut + 11, Text_GetColorId(text), (GetItemUses(item)&0x3F));
	movs	r2, #63	@ tmp147,
	ands	r2, r0	@ tmp146, tmp172
	movs	r0, r6	@ tmp148, mapOut
	ldr	r1, [sp, #4]	@, %sfp
	ldr	r3, .L70+32	@ tmp149,
	adds	r0, r0, #22	@ tmp148,
	bl	.L31		@
.L62:
@ Forging.c:165: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) && (GetItemMight(item) != 0xFE)) {
	movs	r0, r4	@, item
	bl	.L33		@
@ Forging.c:165: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) && (GetItemMight(item) != 0xFE)) {
	lsls	r0, r0, #9	@ tmp182, tmp173,
	bmi	.L64		@,
.L67:
@ Forging.c:165: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) && (GetItemMight(item) != 0xFE)) {
	movs	r0, r4	@, item
	ldr	r3, .L70+20	@ tmp153,
	bl	.L31		@
@ Forging.c:165: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) && (GetItemMight(item) != 0xFE)) {
	cmp	r0, #254	@ tmp174,
	beq	.L68		@,
@ Forging.c:166: 		DrawSpecialUiChar(mapOut + 11, Text_GetColorId(text), GetItemUses(item));
	movs	r0, r5	@, text
	ldr	r3, .L70+24	@ tmp157,
	bl	.L31		@
	ldr	r3, .L70+28	@ tmp158,
	movs	r5, r0	@ _16, tmp176
	movs	r0, r4	@, item
	bl	.L31		@
	movs	r2, r0	@ _17, tmp177
	movs	r0, r6	@ tmp159, mapOut
	movs	r1, r5	@, _16
	ldr	r3, .L70+32	@ tmp160,
	adds	r0, r0, #22	@ tmp159,
	bl	.L31		@
	b	.L68		@
.L64:
@ Forging.c:165: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) && (GetItemMight(item) != 0xFE)) {
	movs	r0, r4	@, item
	bl	.L33		@
@ Forging.c:165: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) && (GetItemMight(item) != 0xFE)) {
	movs	r3, #192	@ tmp156,
	lsls	r3, r3, #17	@ tmp156, tmp156,
@ Forging.c:165: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) && (GetItemMight(item) != 0xFE)) {
	tst	r0, r3	@ tmp175, tmp156
	bne	.L67		@,
.L68:
@ Forging.c:170: }
	@ sp needed	@
@ Forging.c:169:     DrawIcon(mapOut, GetItemIconId(item), 0x4000);
	movs	r0, r4	@, item
	ldr	r3, .L70+36	@ tmp161,
	bl	.L31		@
	movs	r2, #128	@,
	movs	r1, r0	@ _18, tmp178
	ldr	r3, .L70+40	@ tmp163,
	movs	r0, r6	@, mapOut
	lsls	r2, r2, #7	@,,
	bl	.L31		@
@ Forging.c:170: }
	pop	{r0, r1, r2, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L71:
	.align	2
.L70:
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
@ Forging.c:172: void DrawItemStatScreenLine(struct TextHandle* text, int item, int nameColor, u16* mapOut) {
	movs	r6, r3	@ mapOut, tmp210
	str	r0, [sp]	@ tmp207, %sfp
@ Forging.c:174: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	ldr	r3, .L89	@ tmp151,
	movs	r0, r1	@, item
@ Forging.c:174: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	movs	r7, #128	@ tmp152,
@ Forging.c:172: void DrawItemStatScreenLine(struct TextHandle* text, int item, int nameColor, u16* mapOut) {
	movs	r4, r1	@ item, tmp208
	movs	r5, r2	@ nameColor, tmp209
@ Forging.c:174: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	bl	.L31		@
@ Forging.c:174: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	lsls	r7, r7, #15	@ tmp152, tmp152,
@ Forging.c:176:     Text_Clear(text);
	ldr	r3, .L89+4	@ tmp153,
@ Forging.c:174: 	int isItemAnAccessory = GetItemAttributes(item) & IA_ACCESSORY;
	ands	r7, r0	@ isItemAnAccessory, tmp211
@ Forging.c:176:     Text_Clear(text);
	ldr	r0, [sp]	@, %sfp
	bl	.L31		@
	movs	r1, r5	@ color, nameColor
@ Forging.c:196: 	if (isItemAnAccessory) { // Vesly 
	cmp	r7, #0	@ isItemAnAccessory,
	beq	.L73		@,
@ Forging.c:197: 		if(ITEM_EQUIPPED(item) & (nameColor != TEXT_COLOR_GREEN)) color = TEXT_COLOR_GOLD;
	subs	r2, r5, #4	@ tmp157, nameColor,
	subs	r1, r2, #1	@ tmp158, tmp157
	sbcs	r2, r2, r1	@ tmp156, tmp157, tmp158
@ Forging.c:197: 		if(ITEM_EQUIPPED(item) & (nameColor != TEXT_COLOR_GREEN)) color = TEXT_COLOR_GOLD;
	asrs	r3, r4, #15	@ tmp154, item,
@ Forging.c:197: 		if(ITEM_EQUIPPED(item) & (nameColor != TEXT_COLOR_GREEN)) color = TEXT_COLOR_GOLD;
	movs	r1, #3	@ color,
@ Forging.c:197: 		if(ITEM_EQUIPPED(item) & (nameColor != TEXT_COLOR_GREEN)) color = TEXT_COLOR_GOLD;
	tst	r2, r3	@ tmp156, tmp154
	bne	.L73		@,
	movs	r1, r5	@ color, nameColor
.L73:
@ Forging.c:199:     Text_SetColorId(text, color);
	ldr	r3, .L89+8	@ tmp160,
	ldr	r0, [sp]	@, %sfp
	bl	.L31		@
@ Forging.c:201:     Text_DrawString(text, GetItemName(item));
	ldr	r3, .L89+12	@ tmp161,
	movs	r0, r4	@, item
	bl	.L31		@
@ Forging.c:201:     Text_DrawString(text, GetItemName(item));
	ldr	r3, .L89+16	@ tmp162,
@ Forging.c:201:     Text_DrawString(text, GetItemName(item));
	movs	r1, r0	@ _7, tmp212
@ Forging.c:201:     Text_DrawString(text, GetItemName(item));
	ldr	r0, [sp]	@, %sfp
	bl	.L31		@
@ Forging.c:206: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) { // Vesly - berries 
	cmp	r7, #0	@ isItemAnAccessory,
	beq	.L75		@,
@ Forging.c:206: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) { // Vesly - berries 
	movs	r0, r4	@, item
	ldr	r3, .L89+20	@ tmp163,
	bl	.L31		@
@ Forging.c:206: 	if ((isItemAnAccessory) && ((GetItemMight(item) == 0xFE))) { // Vesly - berries 
	cmp	r0, #254	@ tmp213,
	bne	.L75		@,
@ Forging.c:208: 		DrawSpecialUiChar(mapOut + 12, color, 0x16);
	movs	r0, r6	@ tmp168, mapOut
@ Forging.c:207: 		color = (nameColor == TEXT_COLOR_GRAY) ? TEXT_COLOR_GRAY : TEXT_COLOR_NORMAL;
	subs	r7, r5, #1	@ tmp166, nameColor,
	rsbs	r1, r7, #0	@ color, tmp166
	adcs	r1, r1, r7	@ color, tmp166
@ Forging.c:208: 		DrawSpecialUiChar(mapOut + 12, color, 0x16);
	movs	r2, #22	@,
	ldr	r3, .L89+24	@ tmp169,
	adds	r0, r0, #24	@ tmp168,
	bl	.L31		@
@ Forging.c:210: 		color = (nameColor != TEXT_COLOR_GRAY) ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY;
	subs	r3, r7, #1	@ tmp206, tmp166
	sbcs	r7, r7, r3	@ tmp204, tmp166, tmp206
@ Forging.c:211: 		DrawUiNumberOrDoubleDashes(mapOut + 11, color, (GetItemUses(item)&0x3F));
	movs	r0, r4	@, item
	ldr	r3, .L89+28	@ tmp170,
	bl	.L31		@
@ Forging.c:211: 		DrawUiNumberOrDoubleDashes(mapOut + 11, color, (GetItemUses(item)&0x3F));
	movs	r2, #63	@ tmp171,
	ands	r2, r0	@ tmp171, tmp214
	movs	r0, r6	@ tmp173, mapOut
	ldr	r3, .L89+32	@ tmp174,
@ Forging.c:210: 		color = (nameColor != TEXT_COLOR_GRAY) ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY;
	adds	r7, r7, #1	@ iftmp.8_31,
@ Forging.c:211: 		DrawUiNumberOrDoubleDashes(mapOut + 11, color, (GetItemUses(item)&0x3F));
	movs	r1, r7	@, iftmp.8_31
	adds	r0, r0, #22	@ tmp173,
	str	r3, [sp, #4]	@ tmp174, %sfp
	bl	.L31		@
@ Forging.c:212: 		DrawUiNumberOrDoubleDashes(mapOut + 14, color, (GetItemMaxUses(item)&0x3F));
	ldr	r3, .L89+36	@ tmp175,
	movs	r0, r4	@, item
	bl	.L31		@
@ Forging.c:212: 		DrawUiNumberOrDoubleDashes(mapOut + 14, color, (GetItemMaxUses(item)&0x3F));
	movs	r2, #63	@ tmp176,
	ands	r2, r0	@ tmp176, tmp215
	movs	r0, r6	@ tmp178, mapOut
	movs	r1, r7	@, iftmp.8_31
	ldr	r3, [sp, #4]	@ tmp174, %sfp
	adds	r0, r0, #28	@ tmp178,
	bl	.L31		@
.L75:
@ Forging.c:217: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) && (GetItemMight(item) != 0xFE)) {
	movs	r0, r4	@, item
	ldr	r7, .L89	@ tmp180,
	bl	.L33		@
@ Forging.c:217: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) && (GetItemMight(item) != 0xFE)) {
	lsls	r0, r0, #9	@ tmp225, tmp216,
	bmi	.L78		@,
.L81:
@ Forging.c:217: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) && (GetItemMight(item) != 0xFE)) {
	movs	r0, r4	@, item
	ldr	r3, .L89+20	@ tmp183,
	bl	.L31		@
@ Forging.c:217: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) && (GetItemMight(item) != 0xFE)) {
	cmp	r0, #254	@ tmp217,
	beq	.L82		@,
@ Forging.c:219: 		DrawSpecialUiChar(mapOut + 12, color, 0x16);
	movs	r0, r6	@ tmp191, mapOut
@ Forging.c:218: 		color = (nameColor == TEXT_COLOR_GRAY) ? TEXT_COLOR_GRAY : TEXT_COLOR_NORMAL;
	subs	r1, r5, #1	@ tmp189, nameColor,
	rsbs	r3, r1, #0	@ tmp190, tmp189
	adcs	r1, r1, r3	@ color, tmp189, tmp190
@ Forging.c:219: 		DrawSpecialUiChar(mapOut + 12, color, 0x16);
	movs	r2, #22	@,
	ldr	r3, .L89+24	@ tmp192,
	adds	r0, r0, #24	@ tmp191,
	bl	.L31		@
@ Forging.c:221: 		color = (nameColor != TEXT_COLOR_GRAY) ? TEXT_COLOR_BLUE : TEXT_COLOR_GRAY;
	cmp	r5, #1	@ nameColor,
	beq	.L83		@,
	movs	r5, #2	@ nameColor,
.L83:
@ Forging.c:222: 		DrawUiNumberOrDoubleDashes(mapOut + 11, color, GetItemUses(item));
	ldr	r3, .L89+28	@ tmp193,
	movs	r0, r4	@, item
	bl	.L31		@
	movs	r2, r0	@ _25, tmp219
	movs	r0, r6	@ tmp194, mapOut
	movs	r1, r5	@, nameColor
	ldr	r7, .L89+32	@ tmp195,
	adds	r0, r0, #22	@ tmp194,
	bl	.L33		@
@ Forging.c:223: 		DrawUiNumberOrDoubleDashes(mapOut + 14, color, GetItemMaxUses(item));
	movs	r0, r4	@, item
	ldr	r3, .L89+36	@ tmp196,
	bl	.L31		@
	movs	r2, r0	@ _27, tmp220
	movs	r0, r6	@ tmp197, mapOut
	movs	r1, r5	@, nameColor
	adds	r0, r0, #28	@ tmp197,
	bl	.L33		@
	b	.L82		@
.L78:
@ Forging.c:217: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) && (GetItemMight(item) != 0xFE)) {
	movs	r0, r4	@, item
	bl	.L33		@
@ Forging.c:217: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) && (GetItemMight(item) != 0xFE)) {
	movs	r3, #192	@ tmp186,
	lsls	r3, r3, #17	@ tmp186, tmp186,
@ Forging.c:217: 	if ((!(GetItemAttributes(item) & IA_ACCESSORY) || (GetItemAttributes(item) & (IA_DEPLETEUSESONDEFENSE | IA_DEPLETEUSESONATTACK))) && (GetItemMight(item) != 0xFE)) {
	tst	r0, r3	@ tmp218, tmp186
	bne	.L81		@,
.L82:
@ Forging.c:231: }
	@ sp needed	@
@ Forging.c:228:     Text_Display(text, mapOut + 2);
	adds	r1, r6, #4	@ tmp199, mapOut,
	ldr	r0, [sp]	@, %sfp
	ldr	r3, .L89+40	@ tmp200,
	bl	.L31		@
@ Forging.c:230:     DrawIcon(mapOut, GetItemIconId(item), 0x4000);
	movs	r0, r4	@, item
	ldr	r3, .L89+44	@ tmp201,
	bl	.L31		@
	movs	r2, #128	@,
	movs	r1, r0	@ _29, tmp221
	ldr	r3, .L89+48	@ tmp203,
	movs	r0, r6	@, mapOut
	lsls	r2, r2, #7	@,,
	bl	.L31		@
@ Forging.c:231: }
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
@ Forging.c:235:     if (GetItemAttributes(item) & IA_UNBREAKABLE) {
	ldr	r3, .L96	@ tmp120,
@ Forging.c:234: u16 GetItemAfterUse(int item) {
	movs	r4, r0	@ item, tmp129
@ Forging.c:235:     if (GetItemAttributes(item) & IA_UNBREAKABLE) {
	bl	.L31		@
@ Forging.c:235:     if (GetItemAttributes(item) & IA_UNBREAKABLE) {
	lsls	r0, r0, #28	@ tmp131, tmp130,
	bpl	.L92		@,
.L95:
@ Forging.c:246:     return item; // return used item
	lsls	r0, r4, #16	@ <retval>, item,
	lsrs	r0, r0, #16	@ <retval>, <retval>,
	b	.L93		@
.L92:
@ Forging.c:241:     item -= (1 << 8); // lose one use
	subs	r4, r4, #1	@ item,
	subs	r4, r4, #255	@ item,
@ Forging.c:243:     if (ITEM_USES(item) < 1)
	lsls	r3, r4, #18	@ tmp126, item,
	lsrs	r3, r3, #26	@ tmp125, tmp126,
@ Forging.c:244:         return 0; // return no item if uses < 0
	subs	r0, r3, #0	@ <retval>, tmp125,
@ Forging.c:243:     if (ITEM_USES(item) < 1)
	bne	.L95		@,
.L93:
@ Forging.c:247: }
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L97:
	.align	2
.L96:
	.word	GetItemAttributes
	.size	GetItemAfterUse, .-GetItemAfterUse
	.ident	"GCC: (devkitARM release 56) 11.1.0"
	.code 16
	.align	1
.L31:
	bx	r3
.L32:
	bx	r6
.L33:
	bx	r7
