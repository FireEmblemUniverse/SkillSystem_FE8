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
	.file	"Accessories.c"
@ GNU C17 (devkitARM release 59) version 12.2.0 (arm-none-eabi)
@	compiled by GNU C version 10.3.0, GMP version 6.2.1, MPFR version 4.1.0, MPC version 1.2.1, isl version isl-0.18-GMP

@ GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
@ options passed: -mcpu=arm7tdmi -mthumb -mthumb-interwork -mtune=arm7tdmi -mlong-calls -march=armv4t -Os
	.text
	.align	1
	.global	CanUnitUseAccessory
	.syntax unified
	.code	16
	.thumb_func
	.type	CanUnitUseAccessory, %function
CanUnitUseAccessory:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
@ Accessories.c:58: }
	movs	r0, #1	@,
	@ sp needed	@
	bx	lr
	.size	CanUnitUseAccessory, .-CanUnitUseAccessory
	.align	1
	.global	EquipAccessoryUsability
	.syntax unified
	.code	16
	.thumb_func
	.type	EquipAccessoryUsability, %function
EquipAccessoryUsability:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ Accessories.c:62: 	if ((GetItemAttributes(gActiveUnit->items[gActionData.itemSlotIndex]) & IA_ACCESSORY) && !(ITEM_EQUIPPED(gActiveUnit->items[gActionData.itemSlotIndex]))) {
	ldr	r4, .L7	@ tmp128,
@ Accessories.c:62: 	if ((GetItemAttributes(gActiveUnit->items[gActionData.itemSlotIndex]) & IA_ACCESSORY) && !(ITEM_EQUIPPED(gActiveUnit->items[gActionData.itemSlotIndex]))) {
	ldr	r5, .L7+4	@ tmp127,
@ Accessories.c:62: 	if ((GetItemAttributes(gActiveUnit->items[gActionData.itemSlotIndex]) & IA_ACCESSORY) && !(ITEM_EQUIPPED(gActiveUnit->items[gActionData.itemSlotIndex]))) {
	ldrb	r3, [r4, #18]	@ tmp129,
@ Accessories.c:62: 	if ((GetItemAttributes(gActiveUnit->items[gActionData.itemSlotIndex]) & IA_ACCESSORY) && !(ITEM_EQUIPPED(gActiveUnit->items[gActionData.itemSlotIndex]))) {
	ldr	r2, [r5]	@ gActiveUnit, gActiveUnit
	adds	r3, r3, #12	@ tmp130,
	lsls	r3, r3, #1	@ tmp131, tmp130,
	adds	r3, r2, r3	@ tmp132, gActiveUnit, tmp131
@ Accessories.c:62: 	if ((GetItemAttributes(gActiveUnit->items[gActionData.itemSlotIndex]) & IA_ACCESSORY) && !(ITEM_EQUIPPED(gActiveUnit->items[gActionData.itemSlotIndex]))) {
	ldrh	r0, [r3, #6]	@ tmp134, *gActiveUnit.0_1
	ldr	r3, .L7+8	@ tmp135,
	bl	.L9		@
@ Accessories.c:65: 	else return 3;
	movs	r3, #3	@ <retval>,
@ Accessories.c:62: 	if ((GetItemAttributes(gActiveUnit->items[gActionData.itemSlotIndex]) & IA_ACCESSORY) && !(ITEM_EQUIPPED(gActiveUnit->items[gActionData.itemSlotIndex]))) {
	lsls	r0, r0, #9	@ tmp160, tmp153,
	bpl	.L2		@,
@ Accessories.c:62: 	if ((GetItemAttributes(gActiveUnit->items[gActionData.itemSlotIndex]) & IA_ACCESSORY) && !(ITEM_EQUIPPED(gActiveUnit->items[gActionData.itemSlotIndex]))) {
	ldrb	r3, [r4, #18]	@ tmp141,
	ldr	r2, [r5]	@ gActiveUnit, gActiveUnit
	adds	r3, r3, #12	@ tmp142,
	lsls	r3, r3, #1	@ tmp143, tmp142,
	adds	r3, r2, r3	@ tmp144, gActiveUnit, tmp143
@ Accessories.c:62: 	if ((GetItemAttributes(gActiveUnit->items[gActionData.itemSlotIndex]) & IA_ACCESSORY) && !(ITEM_EQUIPPED(gActiveUnit->items[gActionData.itemSlotIndex]))) {
	movs	r2, #6	@ tmp148,
	ldrsh	r2, [r3, r2]	@ tmp148, tmp144, tmp148
@ Accessories.c:65: 	else return 3;
	movs	r3, #3	@ <retval>,
@ Accessories.c:62: 	if ((GetItemAttributes(gActiveUnit->items[gActionData.itemSlotIndex]) & IA_ACCESSORY) && !(ITEM_EQUIPPED(gActiveUnit->items[gActionData.itemSlotIndex]))) {
	cmp	r2, #0	@ tmp148,
	blt	.L2		@,
@ Accessories.c:63: 		if(CanUnitUseAccessory(gActiveUnit->items[gActionData.itemSlotIndex], gActiveUnit)) return 1; else return 2;
	subs	r3, r3, #2	@ <retval>,
.L2:
@ Accessories.c:66: }
	movs	r0, r3	@, <retval>
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L8:
	.align	2
.L7:
	.word	gActionData
	.word	gActiveUnit
	.word	GetItemAttributes
	.size	EquipAccessoryUsability, .-EquipAccessoryUsability
	.align	1
	.global	UnequipAccessoryUsability
	.syntax unified
	.code	16
	.thumb_func
	.type	UnequipAccessoryUsability, %function
UnequipAccessoryUsability:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ Accessories.c:69: 	int isItemAnAccessory = (GetItemAttributes(gActiveUnit->items[gActionData.itemSlotIndex]) & IA_ACCESSORY);
	ldr	r4, .L15	@ tmp128,
@ Accessories.c:69: 	int isItemAnAccessory = (GetItemAttributes(gActiveUnit->items[gActionData.itemSlotIndex]) & IA_ACCESSORY);
	ldr	r5, .L15+4	@ tmp127,
@ Accessories.c:69: 	int isItemAnAccessory = (GetItemAttributes(gActiveUnit->items[gActionData.itemSlotIndex]) & IA_ACCESSORY);
	ldrb	r3, [r4, #18]	@ tmp129,
@ Accessories.c:69: 	int isItemAnAccessory = (GetItemAttributes(gActiveUnit->items[gActionData.itemSlotIndex]) & IA_ACCESSORY);
	ldr	r2, [r5]	@ gActiveUnit, gActiveUnit
	adds	r3, r3, #12	@ tmp130,
	lsls	r3, r3, #1	@ tmp131, tmp130,
	adds	r3, r2, r3	@ tmp132, gActiveUnit, tmp131
@ Accessories.c:69: 	int isItemAnAccessory = (GetItemAttributes(gActiveUnit->items[gActionData.itemSlotIndex]) & IA_ACCESSORY);
	ldrh	r0, [r3, #6]	@ tmp134, *gActiveUnit.4_1
	ldr	r3, .L15+8	@ tmp135,
	bl	.L9		@
@ Accessories.c:73: 	return 3;
	movs	r3, #3	@ <retval>,
@ Accessories.c:70: 	if (isItemAnAccessory) {
	lsls	r0, r0, #9	@ tmp163, tmp158,
	bpl	.L10		@,
@ Accessories.c:71: 		if(ITEM_EQUIPPED(gActiveUnit->items[gActionData.itemSlotIndex])) return 1;
	ldrb	r3, [r4, #18]	@ tmp141,
	ldr	r2, [r5]	@ gActiveUnit, gActiveUnit
	adds	r3, r3, #12	@ tmp142,
	lsls	r3, r3, #1	@ tmp143, tmp142,
	adds	r3, r2, r3	@ tmp144, gActiveUnit, tmp143
@ Accessories.c:71: 		if(ITEM_EQUIPPED(gActiveUnit->items[gActionData.itemSlotIndex])) return 1;
	movs	r2, #6	@ tmp148,
	ldrsh	r2, [r3, r2]	@ tmp148, tmp144, tmp148
@ Accessories.c:73: 	return 3;
	movs	r3, #3	@ <retval>,
@ Accessories.c:71: 		if(ITEM_EQUIPPED(gActiveUnit->items[gActionData.itemSlotIndex])) return 1;
	cmp	r2, #0	@ tmp148,
	bge	.L10		@,
@ Accessories.c:71: 		if(ITEM_EQUIPPED(gActiveUnit->items[gActionData.itemSlotIndex])) return 1;
	subs	r3, r3, #2	@ <retval>,
.L10:
@ Accessories.c:74: }
	movs	r0, r3	@, <retval>
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L16:
	.align	2
.L15:
	.word	gActionData
	.word	gActiveUnit
	.word	GetItemAttributes
	.size	UnequipAccessoryUsability, .-UnequipAccessoryUsability
	.align	1
	.global	EquipAccessoryEffect
	.syntax unified
	.code	16
	.thumb_func
	.type	EquipAccessoryEffect, %function
EquipAccessoryEffect:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, lr}	@
@ Accessories.c:84: 		if (isItemAnAccessory) { 
	movs	r7, #128	@ tmp150,
@ Accessories.c:76: int EquipAccessoryEffect(void *CurrentMenuProc) {
	movs	r5, r0	@ CurrentMenuProc, tmp187
@ Accessories.c:82: 	for(int i = 0; i < 4; i++) {
	movs	r4, #0	@ i,
@ Accessories.c:84: 		if (isItemAnAccessory) { 
	lsls	r7, r7, #15	@ tmp150, tmp150,
.L19:
@ Accessories.c:83: 		int isItemAnAccessory = GetItemAttributes(gActiveUnit->items[i]) & IA_ACCESSORY;
	movs	r2, r4	@ tmp143, i
	ldr	r6, .L34	@ tmp142,
	adds	r2, r2, #12	@ tmp143,
	ldr	r3, [r6]	@ gActiveUnit, gActiveUnit
	lsls	r2, r2, #1	@ tmp144, tmp143,
	adds	r3, r3, r2	@ tmp145, gActiveUnit, tmp144
@ Accessories.c:83: 		int isItemAnAccessory = GetItemAttributes(gActiveUnit->items[i]) & IA_ACCESSORY;
	ldrh	r0, [r3, #6]	@ tmp147, *gActiveUnit.9_1
	ldr	r3, .L34+4	@ tmp148,
	bl	.L9		@
@ Accessories.c:84: 		if (isItemAnAccessory) { 
	tst	r0, r7	@ tmp188, tmp150
	beq	.L18		@,
	ldr	r3, [r6]	@ gActiveUnit, gActiveUnit
	lsls	r2, r4, #1	@ tmp152, i,
	adds	r3, r3, r2	@ _50, gActiveUnit, tmp152
@ Accessories.c:85: 			if(ITEM_EQUIPPED(gActiveUnit->items[i])) { // Unequip accessories 
	movs	r0, #30	@ tmp196,
	ldrsh	r1, [r3, r0]	@ _6, _50, tmp196
@ Accessories.c:85: 			if(ITEM_EQUIPPED(gActiveUnit->items[i])) { // Unequip accessories 
	ldrh	r2, [r3, #30]	@ _6, MEM <u16> [(struct Unit *)_50 + 30B]
@ Accessories.c:85: 			if(ITEM_EQUIPPED(gActiveUnit->items[i])) { // Unequip accessories 
	cmp	r1, #0	@ _6,
	bge	.L18		@,
@ Accessories.c:86: 			gActiveUnit->items[i] &= 0x7FFF; // Unequip current accessory 
	lsls	r2, r2, #17	@ tmp158, _6,
	lsrs	r2, r2, #17	@ tmp157, tmp158,
	strh	r2, [r3, #30]	@ tmp157, MEM <u16> [(struct Unit *)_50 + 30B]
.L18:
@ Accessories.c:82: 	for(int i = 0; i < 4; i++) {
	adds	r4, r4, #1	@ i,
@ Accessories.c:82: 	for(int i = 0; i < 4; i++) {
	cmp	r4, #4	@ i,
	bne	.L19		@,
@ Accessories.c:94: 	gActiveUnit->items[gActionData.itemSlotIndex] |= (1 << 15);
	movs	r4, #128	@ tmp165,
@ Accessories.c:94: 	gActiveUnit->items[gActionData.itemSlotIndex] |= (1 << 15);
	ldr	r2, .L34+8	@ tmp161,
	ldrb	r2, [r2, #18]	@ _10,
@ Accessories.c:94: 	gActiveUnit->items[gActionData.itemSlotIndex] |= (1 << 15);
	ldr	r3, [r6]	@ gActiveUnit.13_9, gActiveUnit
	lsls	r0, r2, #1	@ tmp162, _10,
	adds	r0, r3, r0	@ _52, gActiveUnit.13_9, tmp162
@ Accessories.c:94: 	gActiveUnit->items[gActionData.itemSlotIndex] |= (1 << 15);
	ldrh	r1, [r0, #30]	@ MEM <u16> [(struct Unit *)_52 + 30B], MEM <u16> [(struct Unit *)_52 + 30B]
	lsls	r4, r4, #8	@ tmp165, tmp165,
	orrs	r1, r4	@ _13, tmp165
	strh	r1, [r0, #30]	@ _13, MEM <u16> [(struct Unit *)_52 + 30B]
@ Accessories.c:99: 	if (gActionData.itemSlotIndex == 4) gActiveUnit->items[4] = gActiveUnit->items[3];
	cmp	r2, #4	@ _10,
	bne	.L20		@,
@ Accessories.c:99: 	if (gActionData.itemSlotIndex == 4) gActiveUnit->items[4] = gActiveUnit->items[3];
	ldrh	r2, [r3, #36]	@ tmp169,
	strh	r2, [r3, #38]	@ tmp169, gActiveUnit.13_9->items[4]
.L21:
@ Accessories.c:100: 	if (gActionData.itemSlotIndex >= 3) gActiveUnit->items[3] = gActiveUnit->items[2];
	ldrh	r2, [r3, #34]	@ tmp173,
	strh	r2, [r3, #36]	@ tmp173, gActiveUnit.13_9->items[3]
.L23:
@ Accessories.c:101: 	if (gActionData.itemSlotIndex >= 2) gActiveUnit->items[2] = gActiveUnit->items[1];
	ldrh	r2, [r3, #32]	@ tmp175,
	strh	r2, [r3, #34]	@ tmp175, gActiveUnit.13_9->items[2]
.L25:
@ Accessories.c:102: 	if (gActionData.itemSlotIndex >= 1) gActiveUnit->items[1] = gActiveUnit->items[0];
	ldrh	r2, [r3, #30]	@ tmp177,
	strh	r2, [r3, #32]	@ tmp177, gActiveUnit.13_9->items[1]
	b	.L26		@
.L20:
@ Accessories.c:100: 	if (gActionData.itemSlotIndex >= 3) gActiveUnit->items[3] = gActiveUnit->items[2];
	cmp	r2, #2	@ _10,
	bhi	.L21		@,
@ Accessories.c:101: 	if (gActionData.itemSlotIndex >= 2) gActiveUnit->items[2] = gActiveUnit->items[1];
	beq	.L23		@,
@ Accessories.c:102: 	if (gActionData.itemSlotIndex >= 1) gActiveUnit->items[1] = gActiveUnit->items[0];
	cmp	r2, #0	@ _10,
	bne	.L25		@,
.L26:
@ Accessories.c:108: }
	@ sp needed	@
@ Accessories.c:104: 	gActiveUnit->state |= 0x400; // used galeforce this turn 
	movs	r2, #128	@ tmp182,
@ Accessories.c:103: 	gActiveUnit->items[0] = newItemZero;
	strh	r1, [r3, #30]	@ _13, gActiveUnit.13_9->items[0]
@ Accessories.c:104: 	gActiveUnit->state |= 0x400; // used galeforce this turn 
	ldr	r1, [r3, #12]	@ gActiveUnit.13_9->state, gActiveUnit.13_9->state
	lsls	r2, r2, #3	@ tmp182, tmp182,
	orrs	r2, r1	@ tmp180, gActiveUnit.13_9->state
@ Accessories.c:107: 	return CancelMenu(CurrentMenuProc);
	movs	r0, r5	@, CurrentMenuProc
@ Accessories.c:104: 	gActiveUnit->state |= 0x400; // used galeforce this turn 
	str	r2, [r3, #12]	@ tmp180, gActiveUnit.13_9->state
@ Accessories.c:107: 	return CancelMenu(CurrentMenuProc);
	ldr	r3, .L34+12	@ tmp183,
	bl	.L9		@
@ Accessories.c:108: }
	pop	{r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L35:
	.align	2
.L34:
	.word	gActiveUnit
	.word	GetItemAttributes
	.word	gActionData
	.word	CancelMenu
	.size	EquipAccessoryEffect, .-EquipAccessoryEffect
	.align	1
	.global	UnequipAccessoryEffect
	.syntax unified
	.code	16
	.thumb_func
	.type	UnequipAccessoryEffect, %function
UnequipAccessoryEffect:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, lr}	@
@ Accessories.c:113: 		if (isItemAnAccessory) { 
	movs	r6, #128	@ tmp137,
@ Accessories.c:110: int UnequipAccessoryEffect(void *CurrentMenuProc) {
	movs	r5, r0	@ CurrentMenuProc, tmp150
@ Accessories.c:111: 	for(int i = 0; i < 5; i++) {
	movs	r4, #0	@ i,
@ Accessories.c:113: 		if (isItemAnAccessory) { 
	lsls	r6, r6, #15	@ tmp137, tmp137,
.L38:
@ Accessories.c:112: 		int isItemAnAccessory = GetItemAttributes(gActiveUnit->items[i]) & IA_ACCESSORY;
	movs	r2, r4	@ tmp130, i
	ldr	r7, .L43	@ tmp129,
	adds	r2, r2, #12	@ tmp130,
	ldr	r3, [r7]	@ gActiveUnit, gActiveUnit
	lsls	r2, r2, #1	@ tmp131, tmp130,
	adds	r3, r3, r2	@ tmp132, gActiveUnit, tmp131
@ Accessories.c:112: 		int isItemAnAccessory = GetItemAttributes(gActiveUnit->items[i]) & IA_ACCESSORY;
	ldrh	r0, [r3, #6]	@ tmp134, *gActiveUnit.27_1
	ldr	r3, .L43+4	@ tmp135,
	bl	.L9		@
@ Accessories.c:113: 		if (isItemAnAccessory) { 
	tst	r0, r6	@ tmp151, tmp137
	beq	.L37		@,
	ldr	r3, [r7]	@ gActiveUnit, gActiveUnit
	lsls	r2, r4, #1	@ tmp139, i,
	adds	r3, r3, r2	@ _9, gActiveUnit, tmp139
@ Accessories.c:114: 			if(ITEM_EQUIPPED(gActiveUnit->items[i])) gActiveUnit->items[i] &= 0x7FFF; // & isItemAnAccessory
	movs	r0, #30	@ tmp157,
	ldrsh	r1, [r3, r0]	@ _6, _9, tmp157
@ Accessories.c:114: 			if(ITEM_EQUIPPED(gActiveUnit->items[i])) gActiveUnit->items[i] &= 0x7FFF; // & isItemAnAccessory
	ldrh	r2, [r3, #30]	@ _6, MEM <u16> [(struct Unit *)_9 + 30B]
@ Accessories.c:114: 			if(ITEM_EQUIPPED(gActiveUnit->items[i])) gActiveUnit->items[i] &= 0x7FFF; // & isItemAnAccessory
	cmp	r1, #0	@ _6,
	bge	.L37		@,
@ Accessories.c:114: 			if(ITEM_EQUIPPED(gActiveUnit->items[i])) gActiveUnit->items[i] &= 0x7FFF; // & isItemAnAccessory
	lsls	r2, r2, #17	@ tmp145, _6,
	lsrs	r2, r2, #17	@ tmp144, tmp145,
	strh	r2, [r3, #30]	@ tmp144, MEM <u16> [(struct Unit *)_9 + 30B]
.L37:
@ Accessories.c:111: 	for(int i = 0; i < 5; i++) {
	adds	r4, r4, #1	@ i,
@ Accessories.c:111: 	for(int i = 0; i < 5; i++) {
	cmp	r4, #5	@ i,
	bne	.L38		@,
@ Accessories.c:118: }
	@ sp needed	@
@ Accessories.c:117: 	return CancelMenu(CurrentMenuProc);
	movs	r0, r5	@, CurrentMenuProc
	ldr	r3, .L43+8	@ tmp147,
	bl	.L9		@
@ Accessories.c:118: }
	pop	{r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L44:
	.align	2
.L43:
	.word	gActiveUnit
	.word	GetItemAttributes
	.word	CancelMenu
	.size	UnequipAccessoryEffect, .-UnequipAccessoryEffect
	.align	1
	.global	EquippedAccessoryGetter
	.syntax unified
	.code	16
	.thumb_func
	.type	EquippedAccessoryGetter, %function
EquippedAccessoryGetter:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ Accessories.c:123: 	if(!unit) return 0; // if no unit return no accessory effect
	cmp	r0, #0	@ unit,
	beq	.L46		@,
	movs	r5, r0	@ ivtmp.86, unit
@ Accessories.c:126: 		if (isItemAnAccessory) {
	movs	r6, #128	@ tmp130,
	adds	r0, r0, #40	@ unit,
	movs	r4, r0	@ _28, unit
	adds	r5, r5, #30	@ ivtmp.86,
	lsls	r6, r6, #15	@ tmp130, tmp130,
.L49:
@ Accessories.c:125: 		int isItemAnAccessory = GetItemAttributes(unit->items[i]) & IA_ACCESSORY;
	ldrh	r0, [r5]	@ MEM[(short unsigned int *)_25], MEM[(short unsigned int *)_25]
	ldr	r3, .L57	@ tmp128,
	bl	.L9		@
@ Accessories.c:126: 		if (isItemAnAccessory) {
	tst	r0, r6	@ tmp139, tmp130
	beq	.L47		@,
@ Accessories.c:127: 			if(ITEM_EQUIPPED(unit->items[i])) return ITEM_INDEX(unit->items[i]); // & isItemAnAccessory
	movs	r2, #0	@ tmp142,
	ldrsh	r3, [r5, r2]	@ _5, ivtmp.86, tmp142
@ Accessories.c:127: 			if(ITEM_EQUIPPED(unit->items[i])) return ITEM_INDEX(unit->items[i]); // & isItemAnAccessory
	ldrh	r0, [r5]	@ _5, MEM[(short unsigned int *)_25]
@ Accessories.c:127: 			if(ITEM_EQUIPPED(unit->items[i])) return ITEM_INDEX(unit->items[i]); // & isItemAnAccessory
	cmp	r3, #0	@ _5,
	bge	.L47		@,
@ Accessories.c:127: 			if(ITEM_EQUIPPED(unit->items[i])) return ITEM_INDEX(unit->items[i]); // & isItemAnAccessory
	lsls	r0, r0, #24	@ <retval>, _5,
	lsrs	r0, r0, #24	@ <retval>, <retval>,
.L45:
@ Accessories.c:131: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L47:
@ Accessories.c:124: 	for(int i = 0; i < 5; i++) {
	adds	r5, r5, #2	@ ivtmp.86,
	cmp	r5, r4	@ ivtmp.86, _28
	bne	.L49		@,
.L46:
@ Accessories.c:123: 	if(!unit) return 0; // if no unit return no accessory effect
	movs	r0, #0	@ <retval>,
	b	.L45		@
.L58:
	.align	2
.L57:
	.word	GetItemAttributes
	.size	EquippedAccessoryGetter, .-EquippedAccessoryGetter
	.align	1
	.global	EquippedAccessoryDurabilityGetter
	.syntax unified
	.code	16
	.thumb_func
	.type	EquippedAccessoryDurabilityGetter, %function
EquippedAccessoryDurabilityGetter:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ Accessories.c:136: 	if(!unit) return 0; // if no unit return no accessory effect
	cmp	r0, #0	@ unit,
	beq	.L60		@,
	movs	r5, r0	@ ivtmp.98, unit
@ Accessories.c:139: 		if (isItemAnAccessory) {
	movs	r6, #128	@ tmp131,
	adds	r0, r0, #40	@ unit,
	movs	r4, r0	@ _29, unit
	adds	r5, r5, #30	@ ivtmp.98,
	lsls	r6, r6, #15	@ tmp131, tmp131,
.L63:
@ Accessories.c:138: 		int isItemAnAccessory = GetItemAttributes(unit->items[i]) & IA_ACCESSORY;
	ldrh	r0, [r5]	@ MEM[(short unsigned int *)_26], MEM[(short unsigned int *)_26]
	ldr	r3, .L71	@ tmp129,
	bl	.L9		@
@ Accessories.c:139: 		if (isItemAnAccessory) {
	tst	r0, r6	@ tmp142, tmp131
	beq	.L61		@,
@ Accessories.c:140: 			if(ITEM_EQUIPPED(unit->items[i])) return ITEM_USES(unit->items[i]); // & isItemAnAccessory
	movs	r2, #0	@ tmp145,
	ldrsh	r3, [r5, r2]	@ _5, ivtmp.98, tmp145
@ Accessories.c:140: 			if(ITEM_EQUIPPED(unit->items[i])) return ITEM_USES(unit->items[i]); // & isItemAnAccessory
	ldrh	r0, [r5]	@ _5, MEM[(short unsigned int *)_26]
@ Accessories.c:140: 			if(ITEM_EQUIPPED(unit->items[i])) return ITEM_USES(unit->items[i]); // & isItemAnAccessory
	cmp	r3, #0	@ _5,
	bge	.L61		@,
@ Accessories.c:140: 			if(ITEM_EQUIPPED(unit->items[i])) return ITEM_USES(unit->items[i]); // & isItemAnAccessory
	lsls	r0, r0, #18	@ tmp138, _5,
	lsrs	r0, r0, #26	@ <retval>, tmp138,
.L59:
@ Accessories.c:144: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L61:
@ Accessories.c:137: 	for(int i = 0; i < 5; i++) {
	adds	r5, r5, #2	@ ivtmp.98,
	cmp	r5, r4	@ ivtmp.98, _29
	bne	.L63		@,
.L60:
@ Accessories.c:136: 	if(!unit) return 0; // if no unit return no accessory effect
	movs	r0, #0	@ <retval>,
	b	.L59		@
.L72:
	.align	2
.L71:
	.word	GetItemAttributes
	.size	EquippedAccessoryDurabilityGetter, .-EquippedAccessoryDurabilityGetter
	.align	1
	.global	EquippedShieldAccessoryDurabilityGetter
	.syntax unified
	.code	16
	.thumb_func
	.type	EquippedShieldAccessoryDurabilityGetter, %function
EquippedShieldAccessoryDurabilityGetter:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, lr}	@
@ Accessories.c:149: 	if(!unit) return 0; // if no unit return no accessory effect
	cmp	r0, #0	@ unit,
	beq	.L74		@,
	movs	r5, r0	@ ivtmp.110, unit
@ Accessories.c:153: 			if (isItemAnAccessory) {
	movs	r6, #128	@ tmp150,
	adds	r0, r0, #40	@ unit,
	movs	r4, r0	@ _36, unit
	adds	r5, r5, #30	@ ivtmp.110,
	lsls	r6, r6, #15	@ tmp150, tmp150,
.L77:
@ Accessories.c:151: 		int isItemAnAccessory = GetItemAttributes(unit->items[i]) & IA_ACCESSORY;
	ldr	r3, .L85	@ tmp134,
	ldrh	r0, [r5]	@ MEM[(short unsigned int *)_32], MEM[(short unsigned int *)_32]
	bl	.L9		@
@ Accessories.c:152: 		if (GetItemMight(unit->items[i]) == AE_NormalShield_Link) { 
	ldr	r3, .L85+4	@ tmp136,
@ Accessories.c:151: 		int isItemAnAccessory = GetItemAttributes(unit->items[i]) & IA_ACCESSORY;
	movs	r7, r0	@ _3, tmp152
@ Accessories.c:152: 		if (GetItemMight(unit->items[i]) == AE_NormalShield_Link) { 
	ldrh	r0, [r5]	@ MEM[(short unsigned int *)_32], MEM[(short unsigned int *)_32]
	bl	.L9		@
@ Accessories.c:152: 		if (GetItemMight(unit->items[i]) == AE_NormalShield_Link) { 
	ldr	r3, .L85+8	@ tmp137,
	ldrb	r3, [r3]	@ AE_NormalShield_Link, AE_NormalShield_Link
@ Accessories.c:152: 		if (GetItemMight(unit->items[i]) == AE_NormalShield_Link) { 
	cmp	r0, r3	@ tmp153, AE_NormalShield_Link
	bne	.L75		@,
@ Accessories.c:153: 			if (isItemAnAccessory) {
	tst	r7, r6	@ _3, tmp150
	beq	.L75		@,
@ Accessories.c:154: 				if(ITEM_EQUIPPED(unit->items[i])) return ITEM_USES(unit->items[i]); // & isItemAnAccessory
	movs	r2, #0	@ tmp156,
	ldrsh	r3, [r5, r2]	@ _10, ivtmp.110, tmp156
@ Accessories.c:154: 				if(ITEM_EQUIPPED(unit->items[i])) return ITEM_USES(unit->items[i]); // & isItemAnAccessory
	ldrh	r0, [r5]	@ _10, MEM[(short unsigned int *)_32]
@ Accessories.c:154: 				if(ITEM_EQUIPPED(unit->items[i])) return ITEM_USES(unit->items[i]); // & isItemAnAccessory
	cmp	r3, #0	@ _10,
	bge	.L75		@,
@ Accessories.c:154: 				if(ITEM_EQUIPPED(unit->items[i])) return ITEM_USES(unit->items[i]); // & isItemAnAccessory
	lsls	r0, r0, #18	@ tmp147, _10,
	lsrs	r0, r0, #26	@ <retval>, tmp147,
.L73:
@ Accessories.c:159: }
	@ sp needed	@
	pop	{r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L75:
@ Accessories.c:150: 	for(int i = 0; i < 5; i++) {
	adds	r5, r5, #2	@ ivtmp.110,
	cmp	r5, r4	@ ivtmp.110, _36
	bne	.L77		@,
.L74:
@ Accessories.c:149: 	if(!unit) return 0; // if no unit return no accessory effect
	movs	r0, #0	@ <retval>,
	b	.L73		@
.L86:
	.align	2
.L85:
	.word	GetItemAttributes
	.word	GetItemMight
	.word	AE_NormalShield_Link
	.size	EquippedShieldAccessoryDurabilityGetter, .-EquippedShieldAccessoryDurabilityGetter
	.align	1
	.global	DepleteEquippedAccessoryUse
	.syntax unified
	.code	16
	.thumb_func
	.type	DepleteEquippedAccessoryUse, %function
DepleteEquippedAccessoryUse:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
	movs	r5, r0	@ ivtmp.122, unit
	adds	r0, r0, #40	@ unit,
	movs	r4, r0	@ _17, unit
	adds	r5, r5, #30	@ ivtmp.122,
.L88:
@ Accessories.c:163: 		int isItemAnAccessory = GetItemAttributes(unit->items[i]) & IA_ACCESSORY;
	ldrh	r0, [r5]	@ MEM[(short unsigned int *)_15], MEM[(short unsigned int *)_15]
	ldr	r3, .L90	@ tmp122,
@ Accessories.c:162: 	for(int i = 0; i < 5; i++) {
	adds	r5, r5, #2	@ ivtmp.122,
@ Accessories.c:163: 		int isItemAnAccessory = GetItemAttributes(unit->items[i]) & IA_ACCESSORY;
	bl	.L9		@
@ Accessories.c:162: 	for(int i = 0; i < 5; i++) {
	cmp	r5, r4	@ ivtmp.122, _17
	bne	.L88		@,
@ Accessories.c:179: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L91:
	.align	2
.L90:
	.word	GetItemAttributes
	.size	DepleteEquippedAccessoryUse, .-DepleteEquippedAccessoryUse
	.align	1
	.global	AccessoryEffectGetter
	.syntax unified
	.code	16
	.thumb_func
	.type	AccessoryEffectGetter, %function
AccessoryEffectGetter:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ Accessories.c:183: 	int item = EquippedAccessoryGetter(unit);
	bl	EquippedAccessoryGetter		@
@ Accessories.c:184: 	if (!item) return 0;
	cmp	r0, #0	@ <retval>,
	beq	.L92		@,
@ Accessories.c:185: 	return GetItemMight(item);// item effect id uses the might byte
	ldr	r3, .L97	@ tmp115,
	bl	.L9		@
.L92:
@ Accessories.c:188: }
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L98:
	.align	2
.L97:
	.word	GetItemMight
	.size	AccessoryEffectGetter, .-AccessoryEffectGetter
	.align	1
	.global	AccessoryEffectTester
	.syntax unified
	.code	16
	.thumb_func
	.type	AccessoryEffectTester, %function
AccessoryEffectTester:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ Accessories.c:190: int AccessoryEffectTester(struct Unit *unit, int AccessoryEffectID) {
	movs	r4, r1	@ AccessoryEffectID, tmp124
@ Accessories.c:193: }
	@ sp needed	@
@ Accessories.c:191: 	if (AccessoryEffectGetter(unit) == AccessoryEffectID) return 1;
	bl	AccessoryEffectGetter		@
@ Accessories.c:191: 	if (AccessoryEffectGetter(unit) == AccessoryEffectID) return 1;
	subs	r0, r0, r4	@ tmp121, tmp125, AccessoryEffectID
	rsbs	r3, r0, #0	@ tmp122, tmp121
	adcs	r0, r0, r3	@ tmp120, tmp121, tmp122
@ Accessories.c:193: }
	pop	{r4}
	pop	{r1}
	bx	r1
	.size	AccessoryEffectTester, .-AccessoryEffectTester
	.align	1
	.global	AccessorySkillGetter
	.syntax unified
	.code	16
	.thumb_func
	.type	AccessorySkillGetter, %function
AccessorySkillGetter:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ Accessories.c:195: int AccessorySkillGetter(struct Unit *unit) {
	movs	r5, r0	@ unit, tmp134
@ Accessories.c:196: 	int item = EquippedAccessoryGetter(unit); // this returns ITEM_INDEX(unit->items[i]); // & isItemAnAccessory
	bl	EquippedAccessoryGetter		@
	subs	r4, r0, #0	@ item, tmp135,
@ Accessories.c:197: 	if(!item) return 0;
	bne	.L101		@,
.L103:
@ Accessories.c:197: 	if(!item) return 0;
	movs	r0, #0	@ <retval>,
.L100:
@ Accessories.c:210: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L101:
@ Accessories.c:198: 	if (AccessoryEffectTester(unit, 1)) { // Test if Accessory has the Skill effect
	movs	r1, #1	@,
	movs	r0, r5	@, unit
	bl	AccessoryEffectTester		@
@ Accessories.c:198: 	if (AccessoryEffectTester(unit, 1)) { // Test if Accessory has the Skill effect
	cmp	r0, #0	@ tmp136,
	beq	.L103		@,
@ Accessories.c:199: 		int itemUses = EquippedAccessoryDurabilityGetter(unit);
	movs	r0, r5	@, unit
	bl	EquippedAccessoryDurabilityGetter		@
@ Accessories.c:201: 		if (item == Ves_SkillBlockOne_Link) { return 	((itemUses) + 0); } 
	ldr	r3, .L109	@ tmp125,
	ldrb	r3, [r3]	@ Ves_SkillBlockOne_Link, Ves_SkillBlockOne_Link
@ Accessories.c:201: 		if (item == Ves_SkillBlockOne_Link) { return 	((itemUses) + 0); } 
	cmp	r3, r4	@ Ves_SkillBlockOne_Link, item
	beq	.L100		@,
@ Accessories.c:202: 		if (item == Ves_SkillBlockTwo_Link) { return 	((itemUses) + 64); } 
	ldr	r3, .L109+4	@ tmp127,
	ldrb	r3, [r3]	@ Ves_SkillBlockTwo_Link, Ves_SkillBlockTwo_Link
@ Accessories.c:202: 		if (item == Ves_SkillBlockTwo_Link) { return 	((itemUses) + 64); } 
	cmp	r3, r4	@ Ves_SkillBlockTwo_Link, item
	bne	.L104		@,
@ Accessories.c:202: 		if (item == Ves_SkillBlockTwo_Link) { return 	((itemUses) + 64); } 
	adds	r0, r0, #64	@ <retval>,
	b	.L100		@
.L104:
@ Accessories.c:203: 		if (item == Ves_SkillBlockThree_Link) { return 	((itemUses) + 128); } 
	ldr	r3, .L109+8	@ tmp129,
	ldrb	r3, [r3]	@ Ves_SkillBlockThree_Link, Ves_SkillBlockThree_Link
@ Accessories.c:203: 		if (item == Ves_SkillBlockThree_Link) { return 	((itemUses) + 128); } 
	cmp	r3, r4	@ Ves_SkillBlockThree_Link, item
	bne	.L105		@,
@ Accessories.c:203: 		if (item == Ves_SkillBlockThree_Link) { return 	((itemUses) + 128); } 
	adds	r0, r0, #128	@ <retval>,
	b	.L100		@
.L105:
@ Accessories.c:204: 		if (item == Ves_SkillBlockFour_Link) { return 	((itemUses) + 192); } 
	ldr	r3, .L109+12	@ tmp131,
	ldrb	r3, [r3]	@ Ves_SkillBlockFour_Link, Ves_SkillBlockFour_Link
@ Accessories.c:204: 		if (item == Ves_SkillBlockFour_Link) { return 	((itemUses) + 192); } 
	cmp	r3, r4	@ Ves_SkillBlockFour_Link, item
	bne	.L103		@,
@ Accessories.c:204: 		if (item == Ves_SkillBlockFour_Link) { return 	((itemUses) + 192); } 
	adds	r0, r0, #192	@ <retval>,
	b	.L100		@
.L110:
	.align	2
.L109:
	.word	Ves_SkillBlockOne_Link
	.word	Ves_SkillBlockTwo_Link
	.word	Ves_SkillBlockThree_Link
	.word	Ves_SkillBlockFour_Link
	.size	AccessorySkillGetter, .-AccessorySkillGetter
	.align	1
	.global	Proc_CheckForAccessory
	.syntax unified
	.code	16
	.thumb_func
	.type	Proc_CheckForAccessory, %function
Proc_CheckForAccessory:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
@ Accessories.c:315: 	if (!(roundData->attributes & BATTLE_HIT_ATTR_MISS)) { // if attack didn't miss 
	ldr	r3, [r2]	@ *roundData_7(D), *roundData_7(D)
@ Accessories.c:314: void Proc_CheckForAccessory(struct BattleUnit* attacker, struct BattleUnit* defender, struct BattleHit* roundData) {
	push	{r4, lr}	@
@ Accessories.c:314: void Proc_CheckForAccessory(struct BattleUnit* attacker, struct BattleUnit* defender, struct BattleHit* roundData) {
	movs	r4, r1	@ defender, tmp131
@ Accessories.c:315: 	if (!(roundData->attributes & BATTLE_HIT_ATTR_MISS)) { // if attack didn't miss 
	lsls	r3, r3, #30	@ tmp135, *roundData_7(D),
	bmi	.L111		@,
@ Accessories.c:316: 		int accessory = EquippedAccessoryGetter(&defender->unit);
	movs	r0, r1	@, defender
	bl	EquippedAccessoryGetter		@
@ Accessories.c:317: 		if(accessory) { // if the defender has an accessory equipped
	cmp	r0, #0	@ accessory,
	beq	.L111		@,
@ Accessories.c:318: 			if (GetItemAttributes(accessory) & IA_DEPLETEUSESONDEFENSE) {
	ldr	r3, .L123	@ tmp128,
	bl	.L9		@
@ Accessories.c:318: 			if (GetItemAttributes(accessory) & IA_DEPLETEUSESONDEFENSE) {
	lsls	r0, r0, #8	@ tmp136, tmp134,
	bpl	.L111		@,
@ Accessories.c:319: 				DepleteEquippedAccessoryUse(&defender->unit);
	movs	r0, r4	@, defender
	bl	DepleteEquippedAccessoryUse		@
.L111:
@ Accessories.c:323: }
	@ sp needed	@
	pop	{r4}
	pop	{r0}
	bx	r0
.L124:
	.align	2
.L123:
	.word	GetItemAttributes
	.size	Proc_CheckForAccessory, .-Proc_CheckForAccessory
	.align	1
	.global	UnitAddItem
	.syntax unified
	.code	16
	.thumb_func
	.type	UnitAddItem, %function
UnitAddItem:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ Accessories.c:326: int UnitAddItem(struct Unit* unit, u16 item) {
	movs	r5, r0	@ unit, tmp150
@ Accessories.c:329: 	if ((GetItemAttributes(ITEM_INDEX(item)) & IA_ACCESSORY) && !(EquippedAccessoryGetter(unit))) item |= 0x8000; // Auto-Equip accessory if there is none currently equipped
	lsls	r0, r1, #24	@ tmp130, item,
	ldr	r3, .L134	@ tmp132,
	lsrs	r0, r0, #24	@ tmp130, tmp130,
@ Accessories.c:326: int UnitAddItem(struct Unit* unit, u16 item) {
	movs	r4, r1	@ item, tmp151
@ Accessories.c:329: 	if ((GetItemAttributes(ITEM_INDEX(item)) & IA_ACCESSORY) && !(EquippedAccessoryGetter(unit))) item |= 0x8000; // Auto-Equip accessory if there is none currently equipped
	bl	.L9		@
@ Accessories.c:329: 	if ((GetItemAttributes(ITEM_INDEX(item)) & IA_ACCESSORY) && !(EquippedAccessoryGetter(unit))) item |= 0x8000; // Auto-Equip accessory if there is none currently equipped
	lsls	r0, r0, #9	@ tmp156, tmp152,
	bpl	.L127		@,
@ Accessories.c:329: 	if ((GetItemAttributes(ITEM_INDEX(item)) & IA_ACCESSORY) && !(EquippedAccessoryGetter(unit))) item |= 0x8000; // Auto-Equip accessory if there is none currently equipped
	movs	r0, r5	@, unit
	bl	EquippedAccessoryGetter		@
@ Accessories.c:329: 	if ((GetItemAttributes(ITEM_INDEX(item)) & IA_ACCESSORY) && !(EquippedAccessoryGetter(unit))) item |= 0x8000; // Auto-Equip accessory if there is none currently equipped
	cmp	r0, #0	@ tmp153,
	bne	.L127		@,
@ Accessories.c:329: 	if ((GetItemAttributes(ITEM_INDEX(item)) & IA_ACCESSORY) && !(EquippedAccessoryGetter(unit))) item |= 0x8000; // Auto-Equip accessory if there is none currently equipped
	movs	r3, #128	@ tmp135,
	lsls	r3, r3, #8	@ tmp135, tmp135,
	orrs	r4, r3	@ item, tmp135
.L127:
@ Accessories.c:330: 	unit->state |= 0x400; // used galeforce this turn 
	movs	r3, #128	@ tmp140,
	ldr	r2, [r5, #12]	@ unit_17(D)->state, unit_17(D)->state
	lsls	r3, r3, #3	@ tmp140, tmp140,
	orrs	r3, r2	@ tmp138, unit_17(D)->state
@ Accessories.c:332:         if (unit->items[i] == 0) {
	movs	r2, r5	@ tmp141, unit
@ Accessories.c:330: 	unit->state |= 0x400; // used galeforce this turn 
	str	r3, [r5, #12]	@ tmp138, unit_17(D)->state
@ Accessories.c:331:     for (i = 0; i < 5; ++i) {
	movs	r3, #0	@ i,
@ Accessories.c:332:         if (unit->items[i] == 0) {
	adds	r2, r2, #30	@ tmp141,
.L131:
	lsls	r1, r3, #1	@ tmp142, i,
@ Accessories.c:332:         if (unit->items[i] == 0) {
	ldrh	r1, [r2, r1]	@ MEM[(short unsigned int *)_29 + _28 * 1], MEM[(short unsigned int *)_29 + _28 * 1]
	cmp	r1, #0	@ MEM[(short unsigned int *)_29 + _28 * 1],
	bne	.L129		@,
@ Accessories.c:334:             return TRUE;
	movs	r0, #1	@ <retval>,
@ Accessories.c:333:             unit->items[i] = item;
	adds	r3, r3, #12	@ tmp144,
	lsls	r3, r3, #1	@ tmp145, tmp144,
	adds	r3, r5, r3	@ tmp146, unit, tmp145
	strh	r4, [r3, #6]	@ item, unit_17(D)->items[i_22]
.L125:
@ Accessories.c:340: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L129:
@ Accessories.c:331:     for (i = 0; i < 5; ++i) {
	adds	r3, r3, #1	@ i,
@ Accessories.c:331:     for (i = 0; i < 5; ++i) {
	cmp	r3, #5	@ i,
	bne	.L131		@,
@ Accessories.c:339:     return FALSE;
	movs	r0, #0	@ <retval>,
	b	.L125		@
.L135:
	.align	2
.L134:
	.word	GetItemAttributes
	.size	UnitAddItem, .-UnitAddItem
	.ident	"GCC: (devkitARM release 59) 12.2.0"
	.code 16
	.align	1
.L9:
	bx	r3
