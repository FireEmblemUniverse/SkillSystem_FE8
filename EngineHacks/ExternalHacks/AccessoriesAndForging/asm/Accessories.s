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
@ Accessories.c:61: 	int isItemAnAccessory = GetItemAttributes(gActiveUnit->items[gActionData.itemSlotIndex]) & IA_ACCESSORY;
	ldr	r4, .L6	@ tmp133,
@ Accessories.c:61: 	int isItemAnAccessory = GetItemAttributes(gActiveUnit->items[gActionData.itemSlotIndex]) & IA_ACCESSORY;
	ldr	r5, .L6+4	@ tmp132,
@ Accessories.c:61: 	int isItemAnAccessory = GetItemAttributes(gActiveUnit->items[gActionData.itemSlotIndex]) & IA_ACCESSORY;
	ldrb	r3, [r4, #18]	@ tmp134,
@ Accessories.c:61: 	int isItemAnAccessory = GetItemAttributes(gActiveUnit->items[gActionData.itemSlotIndex]) & IA_ACCESSORY;
	ldr	r2, [r5]	@ tmp177, gActiveUnit
	adds	r3, r3, #12	@ tmp135,
	lsls	r3, r3, #1	@ tmp136, tmp135,
	adds	r3, r2, r3	@ tmp137, tmp177, tmp136
@ Accessories.c:61: 	int isItemAnAccessory = GetItemAttributes(gActiveUnit->items[gActionData.itemSlotIndex]) & IA_ACCESSORY;
	ldrh	r0, [r3, #6]	@ tmp139, *gActiveUnit.0_1
	ldr	r6, .L6+8	@ tmp140,
	bl	.L8		@
@ Accessories.c:62: 	if ((GetItemAttributes(gActiveUnit->items[gActionData.itemSlotIndex]) & IA_ACCESSORY) && !(ITEM_EQUIPPED(gActiveUnit->items[gActionData.itemSlotIndex]))) {
	ldrb	r3, [r4, #18]	@ tmp144,
@ Accessories.c:62: 	if ((GetItemAttributes(gActiveUnit->items[gActionData.itemSlotIndex]) & IA_ACCESSORY) && !(ITEM_EQUIPPED(gActiveUnit->items[gActionData.itemSlotIndex]))) {
	ldr	r2, [r5]	@ tmp178, gActiveUnit
	adds	r3, r3, #12	@ tmp145,
	lsls	r3, r3, #1	@ tmp146, tmp145,
	adds	r3, r2, r3	@ tmp147, tmp178, tmp146
@ Accessories.c:62: 	if ((GetItemAttributes(gActiveUnit->items[gActionData.itemSlotIndex]) & IA_ACCESSORY) && !(ITEM_EQUIPPED(gActiveUnit->items[gActionData.itemSlotIndex]))) {
	ldrh	r0, [r3, #6]	@ tmp149, *gActiveUnit.1_6
	bl	.L8		@
@ Accessories.c:65: 	else return 3;
	movs	r3, #3	@ <retval>,
@ Accessories.c:62: 	if ((GetItemAttributes(gActiveUnit->items[gActionData.itemSlotIndex]) & IA_ACCESSORY) && !(ITEM_EQUIPPED(gActiveUnit->items[gActionData.itemSlotIndex]))) {
	lsls	r2, r0, #9	@ tmp175, tmp168,
	bpl	.L2		@,
@ Accessories.c:62: 	if ((GetItemAttributes(gActiveUnit->items[gActionData.itemSlotIndex]) & IA_ACCESSORY) && !(ITEM_EQUIPPED(gActiveUnit->items[gActionData.itemSlotIndex]))) {
	ldrb	r3, [r4, #18]	@ tmp156,
	ldr	r2, [r5]	@ gActiveUnit, gActiveUnit
	adds	r3, r3, #12	@ tmp157,
	lsls	r3, r3, #1	@ tmp158, tmp157,
	adds	r3, r2, r3	@ tmp159, gActiveUnit, tmp158
@ Accessories.c:62: 	if ((GetItemAttributes(gActiveUnit->items[gActionData.itemSlotIndex]) & IA_ACCESSORY) && !(ITEM_EQUIPPED(gActiveUnit->items[gActionData.itemSlotIndex]))) {
	movs	r2, #6	@ tmp163,
	ldrsh	r2, [r3, r2]	@ tmp163, tmp159, tmp163
@ Accessories.c:65: 	else return 3;
	movs	r3, #3	@ <retval>,
@ Accessories.c:62: 	if ((GetItemAttributes(gActiveUnit->items[gActionData.itemSlotIndex]) & IA_ACCESSORY) && !(ITEM_EQUIPPED(gActiveUnit->items[gActionData.itemSlotIndex]))) {
	cmp	r2, #0	@ tmp163,
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
	ldrh	r0, [r3, #6]	@ tmp135, *gActiveUnit.5_1
	ldr	r3, .L13+8	@ tmp136,
	bl	.L15		@
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
.L18:
@ Accessories.c:83: 		int isItemAnAccessory = GetItemAttributes(gActiveUnit->items[i]) & IA_ACCESSORY;
	movs	r3, r4	@ tmp138, i
	ldr	r6, .L23	@ tmp137,
	adds	r3, r3, #12	@ tmp138,
	ldr	r2, [r6]	@ tmp177, gActiveUnit
	lsls	r3, r3, #1	@ tmp139, tmp138,
	adds	r3, r2, r3	@ tmp140, tmp177, tmp139
@ Accessories.c:83: 		int isItemAnAccessory = GetItemAttributes(gActiveUnit->items[i]) & IA_ACCESSORY;
	ldrh	r0, [r3, #6]	@ tmp142, *gActiveUnit.10_1
	ldr	r3, .L23+4	@ tmp143,
	bl	.L15		@
@ Accessories.c:84: 		if (isItemAnAccessory) { 
	tst	r0, r7	@ tmp170, tmp145
	beq	.L17		@,
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
	bge	.L17		@,
@ Accessories.c:85: 			if(ITEM_EQUIPPED(gActiveUnit->items[i])) gActiveUnit->items[i] &= 0x7FFF;
	lsls	r2, r2, #17	@ tmp153, _7,
	lsrs	r2, r2, #17	@ tmp152, tmp153,
	strh	r2, [r3, #30]	@ tmp152, MEM <u16> [(struct Unit *)_29 + 30B]
.L17:
@ Accessories.c:82: 	for(int i = 0; i < 5; i++) {
	adds	r4, r4, #1	@ i,
@ Accessories.c:82: 	for(int i = 0; i < 5; i++) {
	cmp	r4, #5	@ i,
	bne	.L18		@,
@ Accessories.c:91: }
	@ sp needed	@
@ Accessories.c:89: 	gActiveUnit->items[gActionData.itemSlotIndex] |= (1 << 15);
	ldr	r3, .L23+8	@ tmp156,
	ldrb	r2, [r3, #18]	@ tmp157,
	ldr	r3, [r6]	@ gActiveUnit, gActiveUnit
	lsls	r2, r2, #1	@ tmp158, tmp157,
	adds	r3, r3, r2	@ _35, gActiveUnit, tmp158
@ Accessories.c:89: 	gActiveUnit->items[gActionData.itemSlotIndex] |= (1 << 15);
	ldrh	r1, [r3, #30]	@ MEM <u16> [(struct Unit *)_35 + 30B], MEM <u16> [(struct Unit *)_35 + 30B]
	ldr	r2, .L23+12	@ tmp163,
	orrs	r2, r1	@ tmp162, MEM <u16> [(struct Unit *)_35 + 30B]
@ Accessories.c:90: 	return CancelMenu(CurrentMenuProc);
	movs	r0, r5	@, CurrentMenuProc
@ Accessories.c:89: 	gActiveUnit->items[gActionData.itemSlotIndex] |= (1 << 15);
	strh	r2, [r3, #30]	@ tmp162, MEM <u16> [(struct Unit *)_35 + 30B]
@ Accessories.c:90: 	return CancelMenu(CurrentMenuProc);
	ldr	r3, .L23+16	@ tmp165,
	bl	.L15		@
@ Accessories.c:91: }
	pop	{r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L24:
	.align	2
.L23:
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
.L27:
@ Accessories.c:95: 		int isItemAnAccessory = GetItemAttributes(gActiveUnit->items[i]) & IA_ACCESSORY;
	movs	r3, r4	@ tmp131, i
	ldr	r7, .L32	@ tmp130,
	adds	r3, r3, #12	@ tmp131,
	ldr	r2, [r7]	@ tmp159, gActiveUnit
	lsls	r3, r3, #1	@ tmp132, tmp131,
	adds	r3, r2, r3	@ tmp133, tmp159, tmp132
@ Accessories.c:95: 		int isItemAnAccessory = GetItemAttributes(gActiveUnit->items[i]) & IA_ACCESSORY;
	ldrh	r0, [r3, #6]	@ tmp135, *gActiveUnit.16_1
	ldr	r3, .L32+4	@ tmp136,
	bl	.L15		@
@ Accessories.c:96: 		if (isItemAnAccessory) { 
	tst	r0, r6	@ tmp152, tmp138
	beq	.L26		@,
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
	bge	.L26		@,
@ Accessories.c:97: 			if(ITEM_EQUIPPED(gActiveUnit->items[i])) gActiveUnit->items[i] &= 0x7FFF; // & isItemAnAccessory
	lsls	r2, r2, #17	@ tmp146, _7,
	lsrs	r2, r2, #17	@ tmp145, tmp146,
	strh	r2, [r3, #30]	@ tmp145, MEM <u16> [(struct Unit *)_10 + 30B]
.L26:
@ Accessories.c:94: 	for(int i = 0; i < 5; i++) {
	adds	r4, r4, #1	@ i,
@ Accessories.c:94: 	for(int i = 0; i < 5; i++) {
	cmp	r4, #5	@ i,
	bne	.L27		@,
@ Accessories.c:101: }
	@ sp needed	@
@ Accessories.c:100: 	return CancelMenu(CurrentMenuProc);
	movs	r0, r5	@, CurrentMenuProc
	ldr	r3, .L32+8	@ tmp148,
	bl	.L15		@
@ Accessories.c:101: }
	pop	{r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L33:
	.align	2
.L32:
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
	beq	.L35		@,
	movs	r5, r0	@ ivtmp.67, unit
@ Accessories.c:108: 		int isItemAnAccessory = GetItemAttributes(unit->items[i]) & IA_ACCESSORY;
	movs	r6, #128	@ tmp131,
	adds	r0, r0, #40	@ unit,
	movs	r4, r0	@ _29, unit
	adds	r5, r5, #30	@ ivtmp.67,
	lsls	r6, r6, #15	@ tmp131, tmp131,
.L38:
@ Accessories.c:108: 		int isItemAnAccessory = GetItemAttributes(unit->items[i]) & IA_ACCESSORY;
	ldrh	r0, [r5]	@ MEM[base: _26, offset: 0B], MEM[base: _26, offset: 0B]
	ldr	r3, .L46	@ tmp129,
	bl	.L15		@
@ Accessories.c:109: 		if (isItemAnAccessory) {
	tst	r0, r6	@ tmp140, tmp131
	beq	.L36		@,
@ Accessories.c:110: 			if(ITEM_EQUIPPED(unit->items[i])) return ITEM_INDEX(unit->items[i]); // & isItemAnAccessory
	movs	r2, #0	@ tmp142,
	ldrsh	r3, [r5, r2]	@ _15, ivtmp.67, tmp142
@ Accessories.c:110: 			if(ITEM_EQUIPPED(unit->items[i])) return ITEM_INDEX(unit->items[i]); // & isItemAnAccessory
	ldrh	r0, [r5]	@ _15, MEM[base: _26, offset: 0B]
@ Accessories.c:110: 			if(ITEM_EQUIPPED(unit->items[i])) return ITEM_INDEX(unit->items[i]); // & isItemAnAccessory
	cmp	r3, #0	@ _15,
	bge	.L36		@,
@ Accessories.c:110: 			if(ITEM_EQUIPPED(unit->items[i])) return ITEM_INDEX(unit->items[i]); // & isItemAnAccessory
	lsls	r0, r0, #24	@ <retval>, _15,
	lsrs	r0, r0, #24	@ <retval>, <retval>,
.L34:
@ Accessories.c:114: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L36:
@ Accessories.c:107: 	for(int i = 0; i < 5; i++) {
	adds	r5, r5, #2	@ ivtmp.67,
	cmp	r5, r4	@ ivtmp.67, _29
	bne	.L38		@,
.L35:
@ Accessories.c:106: 	if(!unit) return 0; // if no unit return no accessory effect
	movs	r0, #0	@ <retval>,
	b	.L34		@
.L47:
	.align	2
.L46:
	.word	GetItemAttributes
	.size	EquippedAccessoryGetter, .-EquippedAccessoryGetter
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
	movs	r5, r0	@ ivtmp.78, unit
	adds	r0, r0, #40	@ unit,
	movs	r4, r0	@ _17, unit
	adds	r5, r5, #30	@ ivtmp.78,
.L49:
@ Accessories.c:118: 		int isItemAnAccessory = GetItemAttributes(unit->items[i]) & IA_ACCESSORY;
	ldrh	r0, [r5]	@ MEM[base: _15, offset: 0B], MEM[base: _15, offset: 0B]
	ldr	r3, .L51	@ tmp122,
@ Accessories.c:117: 	for(int i = 0; i < 5; i++) {
	adds	r5, r5, #2	@ ivtmp.78,
@ Accessories.c:118: 		int isItemAnAccessory = GetItemAttributes(unit->items[i]) & IA_ACCESSORY;
	bl	.L15		@
@ Accessories.c:117: 	for(int i = 0; i < 5; i++) {
	cmp	r5, r4	@ ivtmp.78, _17
	bne	.L49		@,
@ Accessories.c:134: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L52:
	.align	2
.L51:
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
@ Accessories.c:138: 	int item = EquippedAccessoryGetter(unit);
	bl	EquippedAccessoryGetter		@
@ Accessories.c:139: 	if (!item) return 0;
	cmp	r0, #0	@ <retval>,
	beq	.L53		@,
@ Accessories.c:140: 	return GetItemMight(item);// item effect id uses the might byte
	ldr	r3, .L58	@ tmp115,
	bl	.L15		@
.L53:
@ Accessories.c:143: }
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L59:
	.align	2
.L58:
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
@ Accessories.c:145: int AccessoryEffectTester(struct Unit *unit, int AccessoryEffectID) {
	movs	r4, r1	@ AccessoryEffectID, tmp124
@ Accessories.c:148: }
	@ sp needed	@
@ Accessories.c:146: 	if (AccessoryEffectGetter(unit) == AccessoryEffectID) return 1;
	bl	AccessoryEffectGetter		@
@ Accessories.c:146: 	if (AccessoryEffectGetter(unit) == AccessoryEffectID) return 1;
	subs	r0, r0, r4	@ tmp121, tmp125, AccessoryEffectID
	rsbs	r3, r0, #0	@ tmp122, tmp121
	adcs	r0, r0, r3	@ tmp120, tmp121, tmp122
@ Accessories.c:148: }
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
@ Accessories.c:150: int AccessorySkillGetter(struct Unit *unit) {
	movs	r5, r0	@ unit, tmp119
@ Accessories.c:151: 	int item = EquippedAccessoryGetter(unit);
	bl	EquippedAccessoryGetter		@
	subs	r4, r0, #0	@ item, tmp120,
@ Accessories.c:152: 	if(!item) return 0;
	bne	.L62		@,
.L64:
@ Accessories.c:152: 	if(!item) return 0;
	movs	r0, #0	@ <retval>,
.L61:
@ Accessories.c:158: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L62:
@ Accessories.c:153: 	if (AccessoryEffectTester(unit, 1)) { // Test if Accessory has the Skill effect
	movs	r1, #1	@,
	movs	r0, r5	@, unit
	bl	AccessoryEffectTester		@
@ Accessories.c:153: 	if (AccessoryEffectTester(unit, 1)) { // Test if Accessory has the Skill effect
	cmp	r0, #0	@ tmp121,
	beq	.L64		@,
@ Accessories.c:154: 		return GetItemHit(item);
	movs	r0, r4	@, item
	ldr	r3, .L68	@ tmp117,
	bl	.L15		@
	b	.L61		@
.L69:
	.align	2
.L68:
	.word	GetItemHit
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
@ Accessories.c:246: int GetStatIncreaseWithAngelRing(int growth, struct Unit* unit) {
	movs	r5, r1	@ unit, tmp128
@ Accessories.c:247:     int result = 0;
	movs	r4, #0	@ <retval>,
.L71:
@ Accessories.c:249:     while (growth > 100) {
	cmp	r0, #100	@ growth,
	bgt	.L72		@,
@ Accessories.c:254:     if (Roll1RN(growth)) {
	ldr	r3, .L78	@ tmp120,
	bl	.L15		@
@ Accessories.c:254:     if (Roll1RN(growth)) {
	cmp	r0, #0	@ tmp129,
	beq	.L70		@,
@ Accessories.c:256: 		if(AccessoryEffectTester(unit, AE_AngelRingID)) result++;
	ldr	r3, .L78+4	@ tmp121,
	movs	r0, r5	@, unit
	ldrb	r1, [r3]	@ AE_AngelRingID, AE_AngelRingID
	bl	AccessoryEffectTester		@
@ Accessories.c:255:         result++;
	subs	r3, r0, #1	@ tmp126, tmp130
	sbcs	r0, r0, r3	@ tmp125, tmp130, tmp126
	adds	r0, r0, r4	@ tmp125, tmp125, <retval>
	adds	r4, r0, #1	@ <retval>, tmp125,
.L70:
@ Accessories.c:259: }
	movs	r0, r4	@, <retval>
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L72:
@ Accessories.c:250:         result++;
	adds	r4, r4, #1	@ <retval>,
@ Accessories.c:251:         growth -= 100;
	subs	r0, r0, #100	@ growth,
	b	.L71		@
.L79:
	.align	2
.L78:
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
@ Accessories.c:262: 	if (!(roundData->attributes & BATTLE_HIT_ATTR_MISS)) { // if attack didn't miss 
	ldr	r3, [r2]	@ *roundData_7(D), *roundData_7(D)
@ Accessories.c:261: void Proc_CheckForAccessory(struct BattleUnit* attacker, struct BattleUnit* defender, struct BattleHit* roundData) {
	push	{r4, lr}	@
@ Accessories.c:261: void Proc_CheckForAccessory(struct BattleUnit* attacker, struct BattleUnit* defender, struct BattleHit* roundData) {
	movs	r4, r1	@ defender, tmp131
@ Accessories.c:262: 	if (!(roundData->attributes & BATTLE_HIT_ATTR_MISS)) { // if attack didn't miss 
	lsls	r3, r3, #30	@ tmp135, *roundData_7(D),
	bmi	.L80		@,
@ Accessories.c:263: 		int accessory = EquippedAccessoryGetter(&defender->unit);
	movs	r0, r1	@, defender
	bl	EquippedAccessoryGetter		@
@ Accessories.c:264: 		if(accessory) { // if the defender has an accessory equipped
	cmp	r0, #0	@ accessory,
	beq	.L80		@,
@ Accessories.c:265: 			if (GetItemAttributes(accessory) & IA_DEPLETEUSESONDEFENSE) {
	ldr	r3, .L90	@ tmp128,
	bl	.L15		@
@ Accessories.c:265: 			if (GetItemAttributes(accessory) & IA_DEPLETEUSESONDEFENSE) {
	lsls	r3, r0, #8	@ tmp136, tmp134,
	bpl	.L80		@,
@ Accessories.c:266: 				DepleteEquippedAccessoryUse(&defender->unit);
	movs	r0, r4	@, defender
	bl	DepleteEquippedAccessoryUse		@
.L80:
@ Accessories.c:270: }
	@ sp needed	@
	pop	{r4}
	pop	{r0}
	bx	r0
.L91:
	.align	2
.L90:
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
@ Accessories.c:273: int UnitAddItem(struct Unit* unit, u16 item) {
	movs	r5, r0	@ unit, tmp145
@ Accessories.c:276: 	if ((GetItemAttributes(ITEM_INDEX(item)) & IA_ACCESSORY) && !(EquippedAccessoryGetter(unit))) item |= 0x8000; // Auto-Equip accessory if there is none currently equipped
	lsls	r0, r1, #24	@ tmp128, item,
	ldr	r3, .L100	@ tmp130,
	lsrs	r0, r0, #24	@ tmp128, tmp128,
@ Accessories.c:273: int UnitAddItem(struct Unit* unit, u16 item) {
	movs	r4, r1	@ item, tmp146
@ Accessories.c:276: 	if ((GetItemAttributes(ITEM_INDEX(item)) & IA_ACCESSORY) && !(EquippedAccessoryGetter(unit))) item |= 0x8000; // Auto-Equip accessory if there is none currently equipped
	bl	.L15		@
@ Accessories.c:276: 	if ((GetItemAttributes(ITEM_INDEX(item)) & IA_ACCESSORY) && !(EquippedAccessoryGetter(unit))) item |= 0x8000; // Auto-Equip accessory if there is none currently equipped
	lsls	r3, r0, #9	@ tmp150, tmp147,
	bpl	.L94		@,
@ Accessories.c:276: 	if ((GetItemAttributes(ITEM_INDEX(item)) & IA_ACCESSORY) && !(EquippedAccessoryGetter(unit))) item |= 0x8000; // Auto-Equip accessory if there is none currently equipped
	movs	r0, r5	@, unit
	bl	EquippedAccessoryGetter		@
@ Accessories.c:276: 	if ((GetItemAttributes(ITEM_INDEX(item)) & IA_ACCESSORY) && !(EquippedAccessoryGetter(unit))) item |= 0x8000; // Auto-Equip accessory if there is none currently equipped
	cmp	r0, #0	@ tmp148,
	bne	.L94		@,
@ Accessories.c:276: 	if ((GetItemAttributes(ITEM_INDEX(item)) & IA_ACCESSORY) && !(EquippedAccessoryGetter(unit))) item |= 0x8000; // Auto-Equip accessory if there is none currently equipped
	movs	r3, #128	@ tmp133,
	lsls	r3, r3, #8	@ tmp133, tmp133,
	orrs	r4, r3	@ item, tmp133
.L94:
@ Accessories.c:279:         if (unit->items[i] == 0) {
	movs	r2, r5	@ tmp136, unit
@ Accessories.c:278:     for (i = 0; i < 5; ++i) {
	movs	r0, #0	@ i,
@ Accessories.c:279:         if (unit->items[i] == 0) {
	adds	r2, r2, #30	@ tmp136,
.L98:
	lsls	r1, r0, #1	@ tmp137, i,
@ Accessories.c:279:         if (unit->items[i] == 0) {
	ldrh	r1, [r2, r1]	@ MEM[base: _26, index: _25, offset: 0B], MEM[base: _26, index: _25, offset: 0B]
	cmp	r1, #0	@ MEM[base: _26, index: _25, offset: 0B],
	bne	.L96		@,
@ Accessories.c:280:             unit->items[i] = item;
	adds	r0, r0, #12	@ tmp139,
	lsls	r0, r0, #1	@ tmp140, tmp139,
	adds	r0, r5, r0	@ tmp141, unit, tmp140
	strh	r4, [r0, #6]	@ item, unit_14(D)->items
@ Accessories.c:281:             return TRUE;
	movs	r0, #1	@ <retval>,
.L92:
@ Accessories.c:286: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L96:
@ Accessories.c:278:     for (i = 0; i < 5; ++i) {
	adds	r0, r0, #1	@ i,
@ Accessories.c:278:     for (i = 0; i < 5; ++i) {
	cmp	r0, #5	@ i,
	bne	.L98		@,
@ Accessories.c:285:     return FALSE;
	movs	r0, #0	@ <retval>,
	b	.L92		@
.L101:
	.align	2
.L100:
	.word	GetItemAttributes
	.size	UnitAddItem, .-UnitAddItem
	.ident	"GCC: (devkitARM release 54) 10.1.0"
	.code 16
	.align	1
.L15:
	bx	r3
.L8:
	bx	r6
