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
	.file	"Accessories.c"
@ GNU C17 (devkitARM release 54) version 10.1.0 (arm-none-eabi)
@	compiled by GNU C version 6.4.0, GMP version 6.0.0, MPFR version 3.1.2, MPC version 1.0.2, isl version none
@ GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
@ options passed:  -imultilib thumb
@ -iprefix c:\devkitpro\devkitarm\bin\../lib/gcc/arm-none-eabi/10.1.0/
@ -D__USES_INITFINI__ Accessories.c -mcpu=arm7tdmi -mthumb
@ -mthumb-interwork -mtune=arm7tdmi -mlong-calls -march=armv4t
@ -auxbase-strip Accessories.s -Os -Wall -fverbose-asm
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
	.global	CanUnitUseAccessory
	.arch armv4t
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
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
	.fpu softvfp
	.type	EquipAccessoryUsability, %function
EquipAccessoryUsability:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ Accessories.c:62: 	if ((GetItemAttributes(gActiveUnit->items[gActionData.itemSlotIndex]) & IA_ACCESSORY) && !(ITEM_EQUIPPED(gActiveUnit->items[gActionData.itemSlotIndex]))) {
	ldr	r4, .L6	@ tmp128,
@ Accessories.c:62: 	if ((GetItemAttributes(gActiveUnit->items[gActionData.itemSlotIndex]) & IA_ACCESSORY) && !(ITEM_EQUIPPED(gActiveUnit->items[gActionData.itemSlotIndex]))) {
	ldr	r5, .L6+4	@ tmp127,
@ Accessories.c:62: 	if ((GetItemAttributes(gActiveUnit->items[gActionData.itemSlotIndex]) & IA_ACCESSORY) && !(ITEM_EQUIPPED(gActiveUnit->items[gActionData.itemSlotIndex]))) {
	ldrb	r3, [r4, #18]	@ tmp129,
@ Accessories.c:62: 	if ((GetItemAttributes(gActiveUnit->items[gActionData.itemSlotIndex]) & IA_ACCESSORY) && !(ITEM_EQUIPPED(gActiveUnit->items[gActionData.itemSlotIndex]))) {
	ldr	r2, [r5]	@ tmp162, gActiveUnit
	adds	r3, r3, #12	@ tmp130,
	lsls	r3, r3, #1	@ tmp131, tmp130,
	adds	r3, r2, r3	@ tmp132, tmp162, tmp131
@ Accessories.c:62: 	if ((GetItemAttributes(gActiveUnit->items[gActionData.itemSlotIndex]) & IA_ACCESSORY) && !(ITEM_EQUIPPED(gActiveUnit->items[gActionData.itemSlotIndex]))) {
	ldrh	r0, [r3, #6]	@ tmp134, *gActiveUnit.0_1
	ldr	r3, .L6+8	@ tmp135,
	bl	.L8		@
@ Accessories.c:65: 	else return 3;
	movs	r3, #3	@ <retval>,
@ Accessories.c:62: 	if ((GetItemAttributes(gActiveUnit->items[gActionData.itemSlotIndex]) & IA_ACCESSORY) && !(ITEM_EQUIPPED(gActiveUnit->items[gActionData.itemSlotIndex]))) {
	lsls	r2, r0, #9	@ tmp160, tmp153,
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
.L7:
	.align	2
.L6:
	.word	gActionData
	.word	gActiveUnit
	.word	GetItemAttributes
	.size	EquipAccessoryUsability, .-EquipAccessoryUsability
	.align	1
	.global	UnequipAccessoryUsability
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	UnequipAccessoryUsability, %function
UnequipAccessoryUsability:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ Accessories.c:69: 	int isItemAnAccessory = (GetItemAttributes(gActiveUnit->items[gActionData.itemSlotIndex]) & IA_ACCESSORY);
	ldr	r4, .L13	@ tmp129,
@ Accessories.c:69: 	int isItemAnAccessory = (GetItemAttributes(gActiveUnit->items[gActionData.itemSlotIndex]) & IA_ACCESSORY);
	ldr	r5, .L13+4	@ tmp128,
@ Accessories.c:69: 	int isItemAnAccessory = (GetItemAttributes(gActiveUnit->items[gActionData.itemSlotIndex]) & IA_ACCESSORY);
	ldrb	r3, [r4, #18]	@ tmp130,
@ Accessories.c:69: 	int isItemAnAccessory = (GetItemAttributes(gActiveUnit->items[gActionData.itemSlotIndex]) & IA_ACCESSORY);
	ldr	r2, [r5]	@ tmp166, gActiveUnit
	adds	r3, r3, #12	@ tmp131,
	lsls	r3, r3, #1	@ tmp132, tmp131,
	adds	r3, r2, r3	@ tmp133, tmp166, tmp132
@ Accessories.c:69: 	int isItemAnAccessory = (GetItemAttributes(gActiveUnit->items[gActionData.itemSlotIndex]) & IA_ACCESSORY);
	ldrh	r0, [r3, #6]	@ tmp135, *gActiveUnit.4_1
	ldr	r3, .L13+8	@ tmp136,
	bl	.L8		@
@ Accessories.c:73: 	return 3;
	movs	r3, #3	@ <retval>,
@ Accessories.c:70: 	if (isItemAnAccessory) {
	lsls	r2, r0, #9	@ tmp164, tmp159,
	bpl	.L9		@,
@ Accessories.c:71: 		if(ITEM_EQUIPPED(gActiveUnit->items[gActionData.itemSlotIndex])) return 1;
	ldrb	r3, [r4, #18]	@ tmp142,
	ldr	r2, [r5]	@ gActiveUnit, gActiveUnit
	adds	r3, r3, #12	@ tmp143,
	lsls	r3, r3, #1	@ tmp144, tmp143,
	adds	r3, r2, r3	@ tmp145, gActiveUnit, tmp144
@ Accessories.c:71: 		if(ITEM_EQUIPPED(gActiveUnit->items[gActionData.itemSlotIndex])) return 1;
	movs	r2, #6	@ tmp149,
	ldrsh	r2, [r3, r2]	@ tmp149, tmp145, tmp149
@ Accessories.c:73: 	return 3;
	movs	r3, #3	@ <retval>,
@ Accessories.c:71: 		if(ITEM_EQUIPPED(gActiveUnit->items[gActionData.itemSlotIndex])) return 1;
	cmp	r2, #0	@ tmp149,
	bge	.L9		@,
@ Accessories.c:71: 		if(ITEM_EQUIPPED(gActiveUnit->items[gActionData.itemSlotIndex])) return 1;
	subs	r3, r3, #2	@ <retval>,
.L9:
@ Accessories.c:74: }
	movs	r0, r3	@, <retval>
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L14:
	.align	2
.L13:
	.word	gActionData
	.word	gActiveUnit
	.word	GetItemAttributes
	.size	UnequipAccessoryUsability, .-UnequipAccessoryUsability
	.align	1
	.global	EquipAccessoryEffect
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	EquipAccessoryEffect, %function
EquipAccessoryEffect:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, lr}	@
@ Accessories.c:83: 		int isItemAnAccessory = GetItemAttributes(gActiveUnit->items[i]) & IA_ACCESSORY;
	movs	r7, #128	@ tmp145,
@ Accessories.c:76: int EquipAccessoryEffect(void *CurrentMenuProc) {
	movs	r5, r0	@ CurrentMenuProc, tmp169
@ Accessories.c:82: 	for(int i = 0; i < 5; i++) {
	movs	r4, #0	@ i,
@ Accessories.c:83: 		int isItemAnAccessory = GetItemAttributes(gActiveUnit->items[i]) & IA_ACCESSORY;
	lsls	r7, r7, #15	@ tmp145, tmp145,
.L17:
@ Accessories.c:83: 		int isItemAnAccessory = GetItemAttributes(gActiveUnit->items[i]) & IA_ACCESSORY;
	movs	r3, r4	@ tmp138, i
	ldr	r6, .L22	@ tmp137,
	adds	r3, r3, #12	@ tmp138,
	ldr	r2, [r6]	@ tmp177, gActiveUnit
	lsls	r3, r3, #1	@ tmp139, tmp138,
	adds	r3, r2, r3	@ tmp140, tmp177, tmp139
@ Accessories.c:83: 		int isItemAnAccessory = GetItemAttributes(gActiveUnit->items[i]) & IA_ACCESSORY;
	ldrh	r0, [r3, #6]	@ tmp142, *gActiveUnit.9_1
	ldr	r3, .L22+4	@ tmp143,
	bl	.L8		@
@ Accessories.c:84: 		if (isItemAnAccessory) { 
	tst	r0, r7	@ tmp170, tmp145
	beq	.L16		@,
	ldr	r2, [r6]	@ tmp178, gActiveUnit
	lsls	r3, r4, #1	@ tmp147, i,
	adds	r3, r2, r3	@ _29, tmp178, tmp147
@ Accessories.c:85: 			if(ITEM_EQUIPPED(gActiveUnit->items[i])) gActiveUnit->items[i] &= 0x7FFF;
	movs	r0, #30	@ tmp175,
	ldrsh	r1, [r3, r0]	@ _7, _29, tmp175
@ Accessories.c:85: 			if(ITEM_EQUIPPED(gActiveUnit->items[i])) gActiveUnit->items[i] &= 0x7FFF;
	ldrh	r2, [r3, #30]	@ _7, MEM <u16> [(struct Unit *)_29 + 30B]
@ Accessories.c:85: 			if(ITEM_EQUIPPED(gActiveUnit->items[i])) gActiveUnit->items[i] &= 0x7FFF;
	cmp	r1, #0	@ _7,
	bge	.L16		@,
@ Accessories.c:85: 			if(ITEM_EQUIPPED(gActiveUnit->items[i])) gActiveUnit->items[i] &= 0x7FFF;
	lsls	r2, r2, #17	@ tmp153, _7,
	lsrs	r2, r2, #17	@ tmp152, tmp153,
	strh	r2, [r3, #30]	@ tmp152, MEM <u16> [(struct Unit *)_29 + 30B]
.L16:
@ Accessories.c:82: 	for(int i = 0; i < 5; i++) {
	adds	r4, r4, #1	@ i,
@ Accessories.c:82: 	for(int i = 0; i < 5; i++) {
	cmp	r4, #5	@ i,
	bne	.L17		@,
@ Accessories.c:91: }
	@ sp needed	@
@ Accessories.c:89: 	gActiveUnit->items[gActionData.itemSlotIndex] |= (1 << 15);
	ldr	r3, .L22+8	@ tmp156,
	ldrb	r2, [r3, #18]	@ tmp157,
	ldr	r3, [r6]	@ gActiveUnit, gActiveUnit
	lsls	r2, r2, #1	@ tmp158, tmp157,
	adds	r3, r3, r2	@ _35, gActiveUnit, tmp158
@ Accessories.c:89: 	gActiveUnit->items[gActionData.itemSlotIndex] |= (1 << 15);
	ldrh	r1, [r3, #30]	@ MEM <u16> [(struct Unit *)_35 + 30B], MEM <u16> [(struct Unit *)_35 + 30B]
	ldr	r2, .L22+12	@ tmp163,
	orrs	r2, r1	@ tmp162, MEM <u16> [(struct Unit *)_35 + 30B]
@ Accessories.c:90: 	return CancelMenu(CurrentMenuProc);
	movs	r0, r5	@, CurrentMenuProc
@ Accessories.c:89: 	gActiveUnit->items[gActionData.itemSlotIndex] |= (1 << 15);
	strh	r2, [r3, #30]	@ tmp162, MEM <u16> [(struct Unit *)_35 + 30B]
@ Accessories.c:90: 	return CancelMenu(CurrentMenuProc);
	ldr	r3, .L22+16	@ tmp165,
	bl	.L8		@
@ Accessories.c:91: }
	pop	{r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L23:
	.align	2
.L22:
	.word	gActiveUnit
	.word	GetItemAttributes
	.word	gActionData
	.word	-32768
	.word	CancelMenu
	.size	EquipAccessoryEffect, .-EquipAccessoryEffect
	.align	1
	.global	UnequipAccessoryEffect
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	UnequipAccessoryEffect, %function
UnequipAccessoryEffect:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, lr}	@
@ Accessories.c:95: 		int isItemAnAccessory = GetItemAttributes(gActiveUnit->items[i]) & IA_ACCESSORY;
	movs	r6, #128	@ tmp138,
@ Accessories.c:93: int UnequipAccessoryEffect(void *CurrentMenuProc) {
	movs	r5, r0	@ CurrentMenuProc, tmp151
@ Accessories.c:94: 	for(int i = 0; i < 5; i++) {
	movs	r4, #0	@ i,
@ Accessories.c:95: 		int isItemAnAccessory = GetItemAttributes(gActiveUnit->items[i]) & IA_ACCESSORY;
	lsls	r6, r6, #15	@ tmp138, tmp138,
.L26:
@ Accessories.c:95: 		int isItemAnAccessory = GetItemAttributes(gActiveUnit->items[i]) & IA_ACCESSORY;
	movs	r3, r4	@ tmp131, i
	ldr	r7, .L31	@ tmp130,
	adds	r3, r3, #12	@ tmp131,
	ldr	r2, [r7]	@ tmp159, gActiveUnit
	lsls	r3, r3, #1	@ tmp132, tmp131,
	adds	r3, r2, r3	@ tmp133, tmp159, tmp132
@ Accessories.c:95: 		int isItemAnAccessory = GetItemAttributes(gActiveUnit->items[i]) & IA_ACCESSORY;
	ldrh	r0, [r3, #6]	@ tmp135, *gActiveUnit.15_1
	ldr	r3, .L31+4	@ tmp136,
	bl	.L8		@
@ Accessories.c:96: 		if (isItemAnAccessory) { 
	tst	r0, r6	@ tmp152, tmp138
	beq	.L25		@,
	ldr	r3, [r7]	@ gActiveUnit, gActiveUnit
	lsls	r2, r4, #1	@ tmp140, i,
	adds	r3, r3, r2	@ _10, gActiveUnit, tmp140
@ Accessories.c:97: 			if(ITEM_EQUIPPED(gActiveUnit->items[i])) gActiveUnit->items[i] &= 0x7FFF; // & isItemAnAccessory
	movs	r0, #30	@ tmp157,
	ldrsh	r1, [r3, r0]	@ _7, _10, tmp157
@ Accessories.c:97: 			if(ITEM_EQUIPPED(gActiveUnit->items[i])) gActiveUnit->items[i] &= 0x7FFF; // & isItemAnAccessory
	ldrh	r2, [r3, #30]	@ _7, MEM <u16> [(struct Unit *)_10 + 30B]
@ Accessories.c:97: 			if(ITEM_EQUIPPED(gActiveUnit->items[i])) gActiveUnit->items[i] &= 0x7FFF; // & isItemAnAccessory
	cmp	r1, #0	@ _7,
	bge	.L25		@,
@ Accessories.c:97: 			if(ITEM_EQUIPPED(gActiveUnit->items[i])) gActiveUnit->items[i] &= 0x7FFF; // & isItemAnAccessory
	lsls	r2, r2, #17	@ tmp146, _7,
	lsrs	r2, r2, #17	@ tmp145, tmp146,
	strh	r2, [r3, #30]	@ tmp145, MEM <u16> [(struct Unit *)_10 + 30B]
.L25:
@ Accessories.c:94: 	for(int i = 0; i < 5; i++) {
	adds	r4, r4, #1	@ i,
@ Accessories.c:94: 	for(int i = 0; i < 5; i++) {
	cmp	r4, #5	@ i,
	bne	.L26		@,
@ Accessories.c:101: }
	@ sp needed	@
@ Accessories.c:100: 	return CancelMenu(CurrentMenuProc);
	movs	r0, r5	@, CurrentMenuProc
	ldr	r3, .L31+8	@ tmp148,
	bl	.L8		@
@ Accessories.c:101: }
	pop	{r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L32:
	.align	2
.L31:
	.word	gActiveUnit
	.word	GetItemAttributes
	.word	CancelMenu
	.size	UnequipAccessoryEffect, .-UnequipAccessoryEffect
	.align	1
	.global	EquippedAccessoryGetter
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	EquippedAccessoryGetter, %function
EquippedAccessoryGetter:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ Accessories.c:106: 	if(!unit) return 0; // if no unit return no accessory effect
	cmp	r0, #0	@ unit,
	beq	.L34		@,
	movs	r5, r0	@ ivtmp.73, unit
@ Accessories.c:108: 		int isItemAnAccessory = GetItemAttributes(unit->items[i]) & IA_ACCESSORY;
	movs	r6, #128	@ tmp131,
	adds	r0, r0, #40	@ unit,
	movs	r4, r0	@ _29, unit
	adds	r5, r5, #30	@ ivtmp.73,
	lsls	r6, r6, #15	@ tmp131, tmp131,
.L37:
@ Accessories.c:108: 		int isItemAnAccessory = GetItemAttributes(unit->items[i]) & IA_ACCESSORY;
	ldrh	r0, [r5]	@ MEM[base: _26, offset: 0B], MEM[base: _26, offset: 0B]
	ldr	r3, .L45	@ tmp129,
	bl	.L8		@
@ Accessories.c:109: 		if (isItemAnAccessory) {
	tst	r0, r6	@ tmp140, tmp131
	beq	.L35		@,
@ Accessories.c:110: 			if(ITEM_EQUIPPED(unit->items[i])) return ITEM_INDEX(unit->items[i]); // & isItemAnAccessory
	movs	r2, #0	@ tmp142,
	ldrsh	r3, [r5, r2]	@ _15, ivtmp.73, tmp142
@ Accessories.c:110: 			if(ITEM_EQUIPPED(unit->items[i])) return ITEM_INDEX(unit->items[i]); // & isItemAnAccessory
	ldrh	r0, [r5]	@ _15, MEM[base: _26, offset: 0B]
@ Accessories.c:110: 			if(ITEM_EQUIPPED(unit->items[i])) return ITEM_INDEX(unit->items[i]); // & isItemAnAccessory
	cmp	r3, #0	@ _15,
	bge	.L35		@,
@ Accessories.c:110: 			if(ITEM_EQUIPPED(unit->items[i])) return ITEM_INDEX(unit->items[i]); // & isItemAnAccessory
	lsls	r0, r0, #24	@ <retval>, _15,
	lsrs	r0, r0, #24	@ <retval>, <retval>,
.L33:
@ Accessories.c:114: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L35:
@ Accessories.c:107: 	for(int i = 0; i < 5; i++) {
	adds	r5, r5, #2	@ ivtmp.73,
	cmp	r5, r4	@ ivtmp.73, _29
	bne	.L37		@,
.L34:
@ Accessories.c:106: 	if(!unit) return 0; // if no unit return no accessory effect
	movs	r0, #0	@ <retval>,
	b	.L33		@
.L46:
	.align	2
.L45:
	.word	GetItemAttributes
	.size	EquippedAccessoryGetter, .-EquippedAccessoryGetter
	.align	1
	.global	EquippedAccessoryDurabilityGetter
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	EquippedAccessoryDurabilityGetter, %function
EquippedAccessoryDurabilityGetter:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ Accessories.c:119: 	if(!unit) return 0; // if no unit return no accessory effect
	cmp	r0, #0	@ unit,
	beq	.L48		@,
	movs	r5, r0	@ ivtmp.84, unit
@ Accessories.c:121: 		int isItemAnAccessory = GetItemAttributes(unit->items[i]) & IA_ACCESSORY;
	movs	r6, #128	@ tmp132,
	adds	r0, r0, #40	@ unit,
	movs	r4, r0	@ _30, unit
	adds	r5, r5, #30	@ ivtmp.84,
	lsls	r6, r6, #15	@ tmp132, tmp132,
.L51:
@ Accessories.c:121: 		int isItemAnAccessory = GetItemAttributes(unit->items[i]) & IA_ACCESSORY;
	ldrh	r0, [r5]	@ MEM[base: _27, offset: 0B], MEM[base: _27, offset: 0B]
	ldr	r3, .L59	@ tmp130,
	bl	.L8		@
@ Accessories.c:122: 		if (isItemAnAccessory) {
	tst	r0, r6	@ tmp143, tmp132
	beq	.L49		@,
@ Accessories.c:123: 			if(ITEM_EQUIPPED(unit->items[i])) return ITEM_USES(unit->items[i]); // & isItemAnAccessory
	movs	r2, #0	@ tmp145,
	ldrsh	r3, [r5, r2]	@ _15, ivtmp.84, tmp145
@ Accessories.c:123: 			if(ITEM_EQUIPPED(unit->items[i])) return ITEM_USES(unit->items[i]); // & isItemAnAccessory
	ldrh	r0, [r5]	@ _15, MEM[base: _27, offset: 0B]
@ Accessories.c:123: 			if(ITEM_EQUIPPED(unit->items[i])) return ITEM_USES(unit->items[i]); // & isItemAnAccessory
	cmp	r3, #0	@ _15,
	bge	.L49		@,
@ Accessories.c:123: 			if(ITEM_EQUIPPED(unit->items[i])) return ITEM_USES(unit->items[i]); // & isItemAnAccessory
	lsls	r0, r0, #18	@ tmp139, _15,
	lsrs	r0, r0, #26	@ <retval>, tmp139,
.L47:
@ Accessories.c:127: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L49:
@ Accessories.c:120: 	for(int i = 0; i < 5; i++) {
	adds	r5, r5, #2	@ ivtmp.84,
	cmp	r5, r4	@ ivtmp.84, _30
	bne	.L51		@,
.L48:
@ Accessories.c:119: 	if(!unit) return 0; // if no unit return no accessory effect
	movs	r0, #0	@ <retval>,
	b	.L47		@
.L60:
	.align	2
.L59:
	.word	GetItemAttributes
	.size	EquippedAccessoryDurabilityGetter, .-EquippedAccessoryDurabilityGetter
	.align	1
	.global	EquippedShieldAccessoryDurabilityGetter
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	EquippedShieldAccessoryDurabilityGetter, %function
EquippedShieldAccessoryDurabilityGetter:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, lr}	@
@ Accessories.c:132: 	if(!unit) return 0; // if no unit return no accessory effect
	cmp	r0, #0	@ unit,
	beq	.L62		@,
	movs	r5, r0	@ ivtmp.95, unit
@ Accessories.c:134: 		int isItemAnAccessory = GetItemAttributes(unit->items[i]) & IA_ACCESSORY;
	movs	r6, #128	@ tmp151,
	adds	r0, r0, #40	@ unit,
	movs	r4, r0	@ _37, unit
	adds	r5, r5, #30	@ ivtmp.95,
	lsls	r6, r6, #15	@ tmp151, tmp151,
.L65:
@ Accessories.c:134: 		int isItemAnAccessory = GetItemAttributes(unit->items[i]) & IA_ACCESSORY;
	ldr	r3, .L73	@ tmp135,
	ldrh	r0, [r5]	@ MEM[base: _33, offset: 0B], MEM[base: _33, offset: 0B]
	bl	.L8		@
@ Accessories.c:135: 		if (GetItemMight(unit->items[i]) == AE_NormalShield_Link) { 
	ldr	r3, .L73+4	@ tmp137,
@ Accessories.c:134: 		int isItemAnAccessory = GetItemAttributes(unit->items[i]) & IA_ACCESSORY;
	movs	r7, r0	@ _3, tmp153
@ Accessories.c:135: 		if (GetItemMight(unit->items[i]) == AE_NormalShield_Link) { 
	ldrh	r0, [r5]	@ MEM[base: _33, offset: 0B], MEM[base: _33, offset: 0B]
	bl	.L8		@
@ Accessories.c:135: 		if (GetItemMight(unit->items[i]) == AE_NormalShield_Link) { 
	ldr	r3, .L73+8	@ tmp138,
	ldrb	r3, [r3]	@ AE_NormalShield_Link, AE_NormalShield_Link
@ Accessories.c:135: 		if (GetItemMight(unit->items[i]) == AE_NormalShield_Link) { 
	cmp	r0, r3	@ tmp154, AE_NormalShield_Link
	bne	.L63		@,
@ Accessories.c:136: 			if (isItemAnAccessory) {
	tst	r7, r6	@ _3, tmp151
	beq	.L63		@,
@ Accessories.c:137: 				if(ITEM_EQUIPPED(unit->items[i])) return ITEM_USES(unit->items[i]); // & isItemAnAccessory
	movs	r2, #0	@ tmp156,
	ldrsh	r3, [r5, r2]	@ _10, ivtmp.95, tmp156
@ Accessories.c:137: 				if(ITEM_EQUIPPED(unit->items[i])) return ITEM_USES(unit->items[i]); // & isItemAnAccessory
	ldrh	r0, [r5]	@ _10, MEM[base: _33, offset: 0B]
@ Accessories.c:137: 				if(ITEM_EQUIPPED(unit->items[i])) return ITEM_USES(unit->items[i]); // & isItemAnAccessory
	cmp	r3, #0	@ _10,
	bge	.L63		@,
@ Accessories.c:137: 				if(ITEM_EQUIPPED(unit->items[i])) return ITEM_USES(unit->items[i]); // & isItemAnAccessory
	lsls	r0, r0, #18	@ tmp148, _10,
	lsrs	r0, r0, #26	@ <retval>, tmp148,
.L61:
@ Accessories.c:142: }
	@ sp needed	@
	pop	{r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L63:
@ Accessories.c:133: 	for(int i = 0; i < 5; i++) {
	adds	r5, r5, #2	@ ivtmp.95,
	cmp	r5, r4	@ ivtmp.95, _37
	bne	.L65		@,
.L62:
@ Accessories.c:132: 	if(!unit) return 0; // if no unit return no accessory effect
	movs	r0, #0	@ <retval>,
	b	.L61		@
.L74:
	.align	2
.L73:
	.word	GetItemAttributes
	.word	GetItemMight
	.word	AE_NormalShield_Link
	.size	EquippedShieldAccessoryDurabilityGetter, .-EquippedShieldAccessoryDurabilityGetter
	.align	1
	.global	DepleteEquippedAccessoryUse
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	DepleteEquippedAccessoryUse, %function
DepleteEquippedAccessoryUse:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
	movs	r5, r0	@ ivtmp.106, unit
	adds	r0, r0, #40	@ unit,
	movs	r4, r0	@ _17, unit
	adds	r5, r5, #30	@ ivtmp.106,
.L76:
@ Accessories.c:146: 		int isItemAnAccessory = GetItemAttributes(unit->items[i]) & IA_ACCESSORY;
	ldrh	r0, [r5]	@ MEM[base: _15, offset: 0B], MEM[base: _15, offset: 0B]
	ldr	r3, .L78	@ tmp122,
@ Accessories.c:145: 	for(int i = 0; i < 5; i++) {
	adds	r5, r5, #2	@ ivtmp.106,
@ Accessories.c:146: 		int isItemAnAccessory = GetItemAttributes(unit->items[i]) & IA_ACCESSORY;
	bl	.L8		@
@ Accessories.c:145: 	for(int i = 0; i < 5; i++) {
	cmp	r5, r4	@ ivtmp.106, _17
	bne	.L76		@,
@ Accessories.c:162: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L79:
	.align	2
.L78:
	.word	GetItemAttributes
	.size	DepleteEquippedAccessoryUse, .-DepleteEquippedAccessoryUse
	.align	1
	.global	AccessoryEffectGetter
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	AccessoryEffectGetter, %function
AccessoryEffectGetter:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ Accessories.c:166: 	int item = EquippedAccessoryGetter(unit);
	bl	EquippedAccessoryGetter		@
@ Accessories.c:167: 	if (!item) return 0;
	cmp	r0, #0	@ <retval>,
	beq	.L80		@,
@ Accessories.c:168: 	return GetItemMight(item);// item effect id uses the might byte
	ldr	r3, .L85	@ tmp115,
	bl	.L8		@
.L80:
@ Accessories.c:171: }
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L86:
	.align	2
.L85:
	.word	GetItemMight
	.size	AccessoryEffectGetter, .-AccessoryEffectGetter
	.align	1
	.global	AccessoryEffectTester
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	AccessoryEffectTester, %function
AccessoryEffectTester:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ Accessories.c:173: int AccessoryEffectTester(struct Unit *unit, int AccessoryEffectID) {
	movs	r4, r1	@ AccessoryEffectID, tmp124
@ Accessories.c:176: }
	@ sp needed	@
@ Accessories.c:174: 	if (AccessoryEffectGetter(unit) == AccessoryEffectID) return 1;
	bl	AccessoryEffectGetter		@
@ Accessories.c:174: 	if (AccessoryEffectGetter(unit) == AccessoryEffectID) return 1;
	subs	r0, r0, r4	@ tmp121, tmp125, AccessoryEffectID
	rsbs	r3, r0, #0	@ tmp122, tmp121
	adcs	r0, r0, r3	@ tmp120, tmp121, tmp122
@ Accessories.c:176: }
	pop	{r4}
	pop	{r1}
	bx	r1
	.size	AccessoryEffectTester, .-AccessoryEffectTester
	.align	1
	.global	AccessorySkillGetter
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	AccessorySkillGetter, %function
AccessorySkillGetter:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ Accessories.c:178: int AccessorySkillGetter(struct Unit *unit) {
	movs	r5, r0	@ unit, tmp134
@ Accessories.c:179: 	int item = EquippedAccessoryGetter(unit); // this returns ITEM_INDEX(unit->items[i]); // & isItemAnAccessory
	bl	EquippedAccessoryGetter		@
	subs	r4, r0, #0	@ item, tmp135,
@ Accessories.c:180: 	if(!item) return 0;
	bne	.L89		@,
.L91:
@ Accessories.c:180: 	if(!item) return 0;
	movs	r0, #0	@ <retval>,
.L88:
@ Accessories.c:193: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L89:
@ Accessories.c:181: 	if (AccessoryEffectTester(unit, 1)) { // Test if Accessory has the Skill effect
	movs	r1, #1	@,
	movs	r0, r5	@, unit
	bl	AccessoryEffectTester		@
@ Accessories.c:181: 	if (AccessoryEffectTester(unit, 1)) { // Test if Accessory has the Skill effect
	cmp	r0, #0	@ tmp136,
	beq	.L91		@,
@ Accessories.c:182: 		int itemUses = EquippedAccessoryDurabilityGetter(unit);
	movs	r0, r5	@, unit
	bl	EquippedAccessoryDurabilityGetter		@
@ Accessories.c:184: 		if (item == Ves_SkillBlockOne_Link) { return 	((itemUses) + 0); } 
	ldr	r3, .L97	@ tmp125,
	ldrb	r3, [r3]	@ Ves_SkillBlockOne_Link, Ves_SkillBlockOne_Link
@ Accessories.c:184: 		if (item == Ves_SkillBlockOne_Link) { return 	((itemUses) + 0); } 
	cmp	r3, r4	@ Ves_SkillBlockOne_Link, item
	beq	.L88		@,
@ Accessories.c:185: 		if (item == Ves_SkillBlockTwo_Link) { return 	((itemUses) + 64); } 
	ldr	r3, .L97+4	@ tmp127,
	ldrb	r3, [r3]	@ Ves_SkillBlockTwo_Link, Ves_SkillBlockTwo_Link
@ Accessories.c:185: 		if (item == Ves_SkillBlockTwo_Link) { return 	((itemUses) + 64); } 
	cmp	r3, r4	@ Ves_SkillBlockTwo_Link, item
	bne	.L92		@,
@ Accessories.c:185: 		if (item == Ves_SkillBlockTwo_Link) { return 	((itemUses) + 64); } 
	adds	r0, r0, #64	@ <retval>,
	b	.L88		@
.L92:
@ Accessories.c:186: 		if (item == Ves_SkillBlockThree_Link) { return 	((itemUses) + 128); } 
	ldr	r3, .L97+8	@ tmp129,
	ldrb	r3, [r3]	@ Ves_SkillBlockThree_Link, Ves_SkillBlockThree_Link
@ Accessories.c:186: 		if (item == Ves_SkillBlockThree_Link) { return 	((itemUses) + 128); } 
	cmp	r3, r4	@ Ves_SkillBlockThree_Link, item
	bne	.L93		@,
@ Accessories.c:186: 		if (item == Ves_SkillBlockThree_Link) { return 	((itemUses) + 128); } 
	adds	r0, r0, #128	@ <retval>,
	b	.L88		@
.L93:
@ Accessories.c:187: 		if (item == Ves_SkillBlockFour_Link) { return 	((itemUses) + 192); } 
	ldr	r3, .L97+12	@ tmp131,
	ldrb	r3, [r3]	@ Ves_SkillBlockFour_Link, Ves_SkillBlockFour_Link
@ Accessories.c:187: 		if (item == Ves_SkillBlockFour_Link) { return 	((itemUses) + 192); } 
	cmp	r3, r4	@ Ves_SkillBlockFour_Link, item
	bne	.L91		@,
@ Accessories.c:187: 		if (item == Ves_SkillBlockFour_Link) { return 	((itemUses) + 192); } 
	adds	r0, r0, #192	@ <retval>,
	b	.L88		@
.L98:
	.align	2
.L97:
	.word	Ves_SkillBlockOne_Link
	.word	Ves_SkillBlockTwo_Link
	.word	Ves_SkillBlockThree_Link
	.word	Ves_SkillBlockFour_Link
	.size	AccessorySkillGetter, .-AccessorySkillGetter
	.align	1
	.global	GetStatIncreaseWithAngelRing
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	GetStatIncreaseWithAngelRing, %function
GetStatIncreaseWithAngelRing:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ Accessories.c:281: int GetStatIncreaseWithAngelRing(int growth, struct Unit* unit) {
	movs	r5, r1	@ unit, tmp128
@ Accessories.c:282:     int result = 0;
	movs	r4, #0	@ <retval>,
.L100:
@ Accessories.c:284:     while (growth > 100) {
	cmp	r0, #100	@ growth,
	bgt	.L101		@,
@ Accessories.c:289:     if (Roll1RN(growth)) {
	ldr	r3, .L107	@ tmp120,
	bl	.L8		@
@ Accessories.c:289:     if (Roll1RN(growth)) {
	cmp	r0, #0	@ tmp129,
	beq	.L99		@,
@ Accessories.c:291: 		if(AccessoryEffectTester(unit, AE_AngelRingID)) result++;
	ldr	r3, .L107+4	@ tmp121,
	movs	r0, r5	@, unit
	ldrb	r1, [r3]	@ AE_AngelRingID, AE_AngelRingID
	bl	AccessoryEffectTester		@
@ Accessories.c:290:         result++;
	subs	r3, r0, #1	@ tmp126, tmp130
	sbcs	r0, r0, r3	@ tmp125, tmp130, tmp126
	adds	r0, r0, r4	@ tmp125, tmp125, <retval>
	adds	r4, r0, #1	@ <retval>, tmp125,
.L99:
@ Accessories.c:294: }
	movs	r0, r4	@, <retval>
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L101:
@ Accessories.c:285:         result++;
	adds	r4, r4, #1	@ <retval>,
@ Accessories.c:286:         growth -= 100;
	subs	r0, r0, #100	@ growth,
	b	.L100		@
.L108:
	.align	2
.L107:
	.word	Roll1RN
	.word	AE_AngelRingID
	.size	GetStatIncreaseWithAngelRing, .-GetStatIncreaseWithAngelRing
	.align	1
	.global	Proc_CheckForAccessory
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	Proc_CheckForAccessory, %function
Proc_CheckForAccessory:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
@ Accessories.c:297: 	if (!(roundData->attributes & BATTLE_HIT_ATTR_MISS)) { // if attack didn't miss 
	ldr	r3, [r2]	@ *roundData_7(D), *roundData_7(D)
@ Accessories.c:296: void Proc_CheckForAccessory(struct BattleUnit* attacker, struct BattleUnit* defender, struct BattleHit* roundData) {
	push	{r4, lr}	@
@ Accessories.c:296: void Proc_CheckForAccessory(struct BattleUnit* attacker, struct BattleUnit* defender, struct BattleHit* roundData) {
	movs	r4, r1	@ defender, tmp131
@ Accessories.c:297: 	if (!(roundData->attributes & BATTLE_HIT_ATTR_MISS)) { // if attack didn't miss 
	lsls	r3, r3, #30	@ tmp135, *roundData_7(D),
	bmi	.L109		@,
@ Accessories.c:298: 		int accessory = EquippedAccessoryGetter(&defender->unit);
	movs	r0, r1	@, defender
	bl	EquippedAccessoryGetter		@
@ Accessories.c:299: 		if(accessory) { // if the defender has an accessory equipped
	cmp	r0, #0	@ accessory,
	beq	.L109		@,
@ Accessories.c:300: 			if (GetItemAttributes(accessory) & IA_DEPLETEUSESONDEFENSE) {
	ldr	r3, .L119	@ tmp128,
	bl	.L8		@
@ Accessories.c:300: 			if (GetItemAttributes(accessory) & IA_DEPLETEUSESONDEFENSE) {
	lsls	r3, r0, #8	@ tmp136, tmp134,
	bpl	.L109		@,
@ Accessories.c:301: 				DepleteEquippedAccessoryUse(&defender->unit);
	movs	r0, r4	@, defender
	bl	DepleteEquippedAccessoryUse		@
.L109:
@ Accessories.c:305: }
	@ sp needed	@
	pop	{r4}
	pop	{r0}
	bx	r0
.L120:
	.align	2
.L119:
	.word	GetItemAttributes
	.size	Proc_CheckForAccessory, .-Proc_CheckForAccessory
	.align	1
	.global	UnitAddItem
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	UnitAddItem, %function
UnitAddItem:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ Accessories.c:308: int UnitAddItem(struct Unit* unit, u16 item) {
	movs	r5, r0	@ unit, tmp145
@ Accessories.c:311: 	if ((GetItemAttributes(ITEM_INDEX(item)) & IA_ACCESSORY) && !(EquippedAccessoryGetter(unit))) item |= 0x8000; // Auto-Equip accessory if there is none currently equipped
	lsls	r0, r1, #24	@ tmp128, item,
	ldr	r3, .L129	@ tmp130,
	lsrs	r0, r0, #24	@ tmp128, tmp128,
@ Accessories.c:308: int UnitAddItem(struct Unit* unit, u16 item) {
	movs	r4, r1	@ item, tmp146
@ Accessories.c:311: 	if ((GetItemAttributes(ITEM_INDEX(item)) & IA_ACCESSORY) && !(EquippedAccessoryGetter(unit))) item |= 0x8000; // Auto-Equip accessory if there is none currently equipped
	bl	.L8		@
@ Accessories.c:311: 	if ((GetItemAttributes(ITEM_INDEX(item)) & IA_ACCESSORY) && !(EquippedAccessoryGetter(unit))) item |= 0x8000; // Auto-Equip accessory if there is none currently equipped
	lsls	r3, r0, #9	@ tmp150, tmp147,
	bpl	.L123		@,
@ Accessories.c:311: 	if ((GetItemAttributes(ITEM_INDEX(item)) & IA_ACCESSORY) && !(EquippedAccessoryGetter(unit))) item |= 0x8000; // Auto-Equip accessory if there is none currently equipped
	movs	r0, r5	@, unit
	bl	EquippedAccessoryGetter		@
@ Accessories.c:311: 	if ((GetItemAttributes(ITEM_INDEX(item)) & IA_ACCESSORY) && !(EquippedAccessoryGetter(unit))) item |= 0x8000; // Auto-Equip accessory if there is none currently equipped
	cmp	r0, #0	@ tmp148,
	bne	.L123		@,
@ Accessories.c:311: 	if ((GetItemAttributes(ITEM_INDEX(item)) & IA_ACCESSORY) && !(EquippedAccessoryGetter(unit))) item |= 0x8000; // Auto-Equip accessory if there is none currently equipped
	movs	r3, #128	@ tmp133,
	lsls	r3, r3, #8	@ tmp133, tmp133,
	orrs	r4, r3	@ item, tmp133
.L123:
@ Accessories.c:314:         if (unit->items[i] == 0) {
	movs	r2, r5	@ tmp136, unit
@ Accessories.c:313:     for (i = 0; i < 5; ++i) {
	movs	r0, #0	@ i,
@ Accessories.c:314:         if (unit->items[i] == 0) {
	adds	r2, r2, #30	@ tmp136,
.L127:
	lsls	r1, r0, #1	@ tmp137, i,
@ Accessories.c:314:         if (unit->items[i] == 0) {
	ldrh	r1, [r2, r1]	@ MEM[base: _26, index: _25, offset: 0B], MEM[base: _26, index: _25, offset: 0B]
	cmp	r1, #0	@ MEM[base: _26, index: _25, offset: 0B],
	bne	.L125		@,
@ Accessories.c:315:             unit->items[i] = item;
	adds	r0, r0, #12	@ tmp139,
	lsls	r0, r0, #1	@ tmp140, tmp139,
	adds	r0, r5, r0	@ tmp141, unit, tmp140
	strh	r4, [r0, #6]	@ item, unit_14(D)->items
@ Accessories.c:316:             return TRUE;
	movs	r0, #1	@ <retval>,
.L121:
@ Accessories.c:321: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L125:
@ Accessories.c:313:     for (i = 0; i < 5; ++i) {
	adds	r0, r0, #1	@ i,
@ Accessories.c:313:     for (i = 0; i < 5; ++i) {
	cmp	r0, #5	@ i,
	bne	.L127		@,
@ Accessories.c:320:     return FALSE;
	movs	r0, #0	@ <retval>,
	b	.L121		@
.L130:
	.align	2
.L129:
	.word	GetItemAttributes
	.size	UnitAddItem, .-UnitAddItem
	.ident	"GCC: (devkitARM release 54) 10.1.0"
	.code 16
	.align	1
.L8:
	bx	r3
