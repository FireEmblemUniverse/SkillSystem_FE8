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
@ Accessories.c:57: }
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
@ Accessories.c:60: 	if ((GetItemAttributes(gActiveUnit->items[gActionData.itemSlotIndex]) & IA_ACCESSORY) && !(ITEM_EQUIPPED(gActiveUnit->items[gActionData.itemSlotIndex]))) {
	ldr	r4, .L6	@ tmp128,
@ Accessories.c:60: 	if ((GetItemAttributes(gActiveUnit->items[gActionData.itemSlotIndex]) & IA_ACCESSORY) && !(ITEM_EQUIPPED(gActiveUnit->items[gActionData.itemSlotIndex]))) {
	ldr	r5, .L6+4	@ tmp127,
@ Accessories.c:60: 	if ((GetItemAttributes(gActiveUnit->items[gActionData.itemSlotIndex]) & IA_ACCESSORY) && !(ITEM_EQUIPPED(gActiveUnit->items[gActionData.itemSlotIndex]))) {
	ldrb	r3, [r4, #18]	@ tmp129,
@ Accessories.c:60: 	if ((GetItemAttributes(gActiveUnit->items[gActionData.itemSlotIndex]) & IA_ACCESSORY) && !(ITEM_EQUIPPED(gActiveUnit->items[gActionData.itemSlotIndex]))) {
	ldr	r2, [r5]	@ tmp162, gActiveUnit
	adds	r3, r3, #12	@ tmp130,
	lsls	r3, r3, #1	@ tmp131, tmp130,
	adds	r3, r2, r3	@ tmp132, tmp162, tmp131
@ Accessories.c:60: 	if ((GetItemAttributes(gActiveUnit->items[gActionData.itemSlotIndex]) & IA_ACCESSORY) && !(ITEM_EQUIPPED(gActiveUnit->items[gActionData.itemSlotIndex]))) {
	ldrh	r0, [r3, #6]	@ tmp134, *gActiveUnit.0_1
	ldr	r3, .L6+8	@ tmp135,
	bl	.L8		@
@ Accessories.c:63: 	else return 3;
	movs	r3, #3	@ <retval>,
@ Accessories.c:60: 	if ((GetItemAttributes(gActiveUnit->items[gActionData.itemSlotIndex]) & IA_ACCESSORY) && !(ITEM_EQUIPPED(gActiveUnit->items[gActionData.itemSlotIndex]))) {
	lsls	r2, r0, #9	@ tmp160, tmp153,
	bpl	.L2		@,
@ Accessories.c:60: 	if ((GetItemAttributes(gActiveUnit->items[gActionData.itemSlotIndex]) & IA_ACCESSORY) && !(ITEM_EQUIPPED(gActiveUnit->items[gActionData.itemSlotIndex]))) {
	ldrb	r3, [r4, #18]	@ tmp141,
	ldr	r2, [r5]	@ gActiveUnit, gActiveUnit
	adds	r3, r3, #12	@ tmp142,
	lsls	r3, r3, #1	@ tmp143, tmp142,
	adds	r3, r2, r3	@ tmp144, gActiveUnit, tmp143
@ Accessories.c:60: 	if ((GetItemAttributes(gActiveUnit->items[gActionData.itemSlotIndex]) & IA_ACCESSORY) && !(ITEM_EQUIPPED(gActiveUnit->items[gActionData.itemSlotIndex]))) {
	movs	r2, #6	@ tmp148,
	ldrsh	r2, [r3, r2]	@ tmp148, tmp144, tmp148
@ Accessories.c:63: 	else return 3;
	movs	r3, #3	@ <retval>,
@ Accessories.c:60: 	if ((GetItemAttributes(gActiveUnit->items[gActionData.itemSlotIndex]) & IA_ACCESSORY) && !(ITEM_EQUIPPED(gActiveUnit->items[gActionData.itemSlotIndex]))) {
	cmp	r2, #0	@ tmp148,
	blt	.L2		@,
@ Accessories.c:61: 		if(CanUnitUseAccessory(gActiveUnit->items[gActionData.itemSlotIndex], gActiveUnit)) return 1; else return 2;
	subs	r3, r3, #2	@ <retval>,
.L2:
@ Accessories.c:64: }
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
	@ link register save eliminated.
@ Accessories.c:67: 	if(ITEM_EQUIPPED(gActiveUnit->items[gActionData.itemSlotIndex])) return 1;
	ldr	r3, .L12	@ tmp120,
	ldr	r2, [r3]	@ gActiveUnit, gActiveUnit
	ldr	r3, .L12+4	@ tmp121,
	ldrb	r3, [r3, #18]	@ tmp122,
	adds	r3, r3, #12	@ tmp123,
	lsls	r3, r3, #1	@ tmp124, tmp123,
	adds	r3, r2, r3	@ tmp125, gActiveUnit, tmp124
@ Accessories.c:67: 	if(ITEM_EQUIPPED(gActiveUnit->items[gActionData.itemSlotIndex])) return 1;
	movs	r2, #6	@ tmp140,
	ldrsh	r3, [r3, r2]	@ tmp129, tmp125, tmp140
@ Accessories.c:67: 	if(ITEM_EQUIPPED(gActiveUnit->items[gActionData.itemSlotIndex])) return 1;
	movs	r0, #1	@ <retval>,
@ Accessories.c:67: 	if(ITEM_EQUIPPED(gActiveUnit->items[gActionData.itemSlotIndex])) return 1;
	cmp	r3, #0	@ tmp129,
	blt	.L9		@,
@ Accessories.c:68: 	else return 3;
	adds	r0, r0, #2	@ <retval>,
.L9:
@ Accessories.c:69: }
	@ sp needed	@
	bx	lr
.L13:
	.align	2
.L12:
	.word	gActiveUnit
	.word	gActionData
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
@ Accessories.c:72: 	if (!CanUnitUseAccessory(gActiveUnit->items[gActionData.itemSlotIndex], gActiveUnit)) { 
	ldr	r3, .L18	@ tmp130,
@ Accessories.c:72: 	if (!CanUnitUseAccessory(gActiveUnit->items[gActionData.itemSlotIndex], gActiveUnit)) { 
	ldr	r2, .L18+4	@ tmp131,
@ Accessories.c:72: 	if (!CanUnitUseAccessory(gActiveUnit->items[gActionData.itemSlotIndex], gActiveUnit)) { 
	ldr	r3, [r3]	@ gActiveUnit.5_1, gActiveUnit
@ Accessories.c:72: 	if (!CanUnitUseAccessory(gActiveUnit->items[gActionData.itemSlotIndex], gActiveUnit)) { 
	ldrb	r4, [r2, #18]	@ _2,
	movs	r5, r3	@ _28, gActiveUnit.5_1
	movs	r2, r3	@ ivtmp.49, gActiveUnit.5_1
	adds	r5, r5, #40	@ _28,
	adds	r2, r2, #30	@ ivtmp.49,
.L16:
@ Accessories.c:77: 		if(ITEM_EQUIPPED(gActiveUnit->items[i])) gActiveUnit->items[i] &= 0x7FFF;
	movs	r7, #0	@ tmp150,
	ldrsh	r6, [r2, r7]	@ _4, ivtmp.49, tmp150
@ Accessories.c:77: 		if(ITEM_EQUIPPED(gActiveUnit->items[i])) gActiveUnit->items[i] &= 0x7FFF;
	ldrh	r1, [r2]	@ _4, MEM[base: _19, offset: 0B]
@ Accessories.c:77: 		if(ITEM_EQUIPPED(gActiveUnit->items[i])) gActiveUnit->items[i] &= 0x7FFF;
	cmp	r6, #0	@ _4,
	bge	.L15		@,
@ Accessories.c:77: 		if(ITEM_EQUIPPED(gActiveUnit->items[i])) gActiveUnit->items[i] &= 0x7FFF;
	lsls	r1, r1, #17	@ tmp136, _4,
	lsrs	r1, r1, #17	@ tmp135, tmp136,
	strh	r1, [r2]	@ tmp135, MEM[base: _19, offset: 0B]
.L15:
@ Accessories.c:76: 	for(int i = 0; i < 5; i++) {
	adds	r2, r2, #2	@ ivtmp.49,
	cmp	r2, r5	@ ivtmp.49, _28
	bne	.L16		@,
@ Accessories.c:81: }
	@ sp needed	@
	lsls	r4, r4, #1	@ tmp138, _2,
	adds	r3, r3, r4	@ _18, gActiveUnit.5_1, tmp138
@ Accessories.c:79: 	gActiveUnit->items[gActionData.itemSlotIndex] |= (1 << 15);
	ldrh	r1, [r3, #30]	@ MEM <u16> [(struct Unit *)_18 + 30B], MEM <u16> [(struct Unit *)_18 + 30B]
	ldr	r2, .L18+8	@ tmp142,
	orrs	r2, r1	@ tmp141, MEM <u16> [(struct Unit *)_18 + 30B]
	strh	r2, [r3, #30]	@ tmp141, MEM <u16> [(struct Unit *)_18 + 30B]
@ Accessories.c:80: 	return CancelMenu(CurrentMenuProc);
	ldr	r3, .L18+12	@ tmp144,
	bl	.L8		@
@ Accessories.c:81: }
	pop	{r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L19:
	.align	2
.L18:
	.word	gActiveUnit
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
@ Accessories.c:85: 		if(ITEM_EQUIPPED(gActiveUnit->items[i])) gActiveUnit->items[i] &= 0x7FFF;
	ldr	r3, .L24	@ tmp124,
	ldr	r1, [r3]	@ gActiveUnit.13_1, gActiveUnit
	movs	r3, r1	@ ivtmp.61, gActiveUnit.13_1
@ Accessories.c:83: int UnequipAccessoryEffect(void *CurrentMenuProc) {
	push	{r4, r5, r6, lr}	@
	adds	r3, r3, #30	@ ivtmp.61,
	adds	r1, r1, #40	@ _23,
.L22:
@ Accessories.c:85: 		if(ITEM_EQUIPPED(gActiveUnit->items[i])) gActiveUnit->items[i] &= 0x7FFF;
	movs	r5, #0	@ tmp137,
	ldrsh	r4, [r3, r5]	@ _2, ivtmp.61, tmp137
@ Accessories.c:85: 		if(ITEM_EQUIPPED(gActiveUnit->items[i])) gActiveUnit->items[i] &= 0x7FFF;
	ldrh	r2, [r3]	@ _2, MEM[base: _16, offset: 0B]
@ Accessories.c:85: 		if(ITEM_EQUIPPED(gActiveUnit->items[i])) gActiveUnit->items[i] &= 0x7FFF;
	cmp	r4, #0	@ _2,
	bge	.L21		@,
@ Accessories.c:85: 		if(ITEM_EQUIPPED(gActiveUnit->items[i])) gActiveUnit->items[i] &= 0x7FFF;
	lsls	r2, r2, #17	@ tmp129, _2,
	lsrs	r2, r2, #17	@ tmp128, tmp129,
	strh	r2, [r3]	@ tmp128, MEM[base: _16, offset: 0B]
.L21:
@ Accessories.c:84: 	for(int i = 0; i < 5; i++) {
	adds	r3, r3, #2	@ ivtmp.61,
	cmp	r3, r1	@ ivtmp.61, _23
	bne	.L22		@,
@ Accessories.c:88: }
	@ sp needed	@
@ Accessories.c:87: 	return CancelMenu(CurrentMenuProc);
	ldr	r3, .L24+4	@ tmp131,
	bl	.L8		@
@ Accessories.c:88: }
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L25:
	.align	2
.L24:
	.word	gActiveUnit
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
	movs	r3, r0	@ unit, tmp130
	push	{r4, lr}	@
@ Accessories.c:92: 	if(!unit) return 0; // if no unit return no accessory effect
	cmp	r0, #0	@ unit,
	beq	.L26		@,
	movs	r2, r0	@ ivtmp.72, unit
	adds	r3, r3, #40	@ _19,
	adds	r2, r2, #30	@ ivtmp.72,
.L29:
@ Accessories.c:94: 		if(ITEM_EQUIPPED(unit->items[i])) return ITEM_INDEX(unit->items[i]);
	movs	r4, #0	@ tmp131,
	ldrsh	r1, [r2, r4]	@ _7, ivtmp.72, tmp131
@ Accessories.c:94: 		if(ITEM_EQUIPPED(unit->items[i])) return ITEM_INDEX(unit->items[i]);
	ldrh	r0, [r2]	@ _7, MEM[base: _17, offset: 0B]
@ Accessories.c:94: 		if(ITEM_EQUIPPED(unit->items[i])) return ITEM_INDEX(unit->items[i]);
	cmp	r1, #0	@ _7,
	bge	.L28		@,
@ Accessories.c:94: 		if(ITEM_EQUIPPED(unit->items[i])) return ITEM_INDEX(unit->items[i]);
	lsls	r0, r0, #24	@ <retval>, _7,
	lsrs	r0, r0, #24	@ <retval>, <retval>,
.L26:
@ Accessories.c:97: }
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L28:
@ Accessories.c:93: 	for(int i = 0; i < 5; i++) {
	adds	r2, r2, #2	@ ivtmp.72,
	cmp	r2, r3	@ ivtmp.72, _19
	bne	.L29		@,
@ Accessories.c:92: 	if(!unit) return 0; // if no unit return no accessory effect
	movs	r0, #0	@ <retval>,
	b	.L26		@
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
@ Accessories.c:100: 	for(int i = 0; i < 5; i++) {
	movs	r2, #0	@ i,
	movs	r3, #63	@ tmp147,
	movs	r1, r0	@ ivtmp.83, unit
@ Accessories.c:99: void DepleteEquippedAccessoryUse(struct Unit *unit) {
	push	{r4, r5, r6, r7, lr}	@
	mov	ip, r3	@ tmp147, tmp147
@ Accessories.c:103: 				if (i == 4) unit->items[5] = 0; // if the item is the last in inventory, clear that
	movs	r6, r2	@ tmp149, i
@ Accessories.c:113: 			else unit->items[i] = (unit->items[i] & 0xC0FF) | ((ITEM_USES(unit->items[i]) - 1) << 8);
	ldr	r5, .L37	@ tmp148,
	adds	r1, r1, #30	@ ivtmp.83,
.L35:
@ Accessories.c:101: 		if(ITEM_EQUIPPED(unit->items[i])) { // i is the id of the equipped accessory
	movs	r4, #0	@ tmp152,
	ldrsh	r7, [r1, r4]	@ _2, ivtmp.83, tmp152
	ldrh	r3, [r1]	@ _1, MEM[base: _25, offset: 0B]
@ Accessories.c:101: 		if(ITEM_EQUIPPED(unit->items[i])) { // i is the id of the equipped accessory
	cmp	r7, #0	@ _2,
	bge	.L33		@,
	mov	r4, ip	@ tmp147, tmp147
@ Accessories.c:102: 			if (ITEM_USES(unit->items[i]) - 1 == 0) {
	lsrs	r3, r3, #8	@ tmp131, _1,
	ands	r3, r4	@ _15, tmp147
@ Accessories.c:102: 			if (ITEM_USES(unit->items[i]) - 1 == 0) {
	cmp	r3, #1	@ _15,
	bne	.L34		@,
@ Accessories.c:103: 				if (i == 4) unit->items[5] = 0; // if the item is the last in inventory, clear that
	cmp	r2, #4	@ i,
	bne	.L33		@,
@ Accessories.c:103: 				if (i == 4) unit->items[5] = 0; // if the item is the last in inventory, clear that
	strh	r6, [r0, #40]	@ tmp149, unit_17(D)->items
.L33:
@ Accessories.c:100: 	for(int i = 0; i < 5; i++) {
	adds	r2, r2, #1	@ i,
@ Accessories.c:100: 	for(int i = 0; i < 5; i++) {
	adds	r1, r1, #2	@ ivtmp.83,
	cmp	r2, #5	@ i,
	bne	.L35		@,
@ Accessories.c:116: }
	@ sp needed	@
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L34:
@ Accessories.c:113: 			else unit->items[i] = (unit->items[i] & 0xC0FF) | ((ITEM_USES(unit->items[i]) - 1) << 8);
	subs	r3, r3, #1	@ tmp138,
@ Accessories.c:113: 			else unit->items[i] = (unit->items[i] & 0xC0FF) | ((ITEM_USES(unit->items[i]) - 1) << 8);
	lsls	r3, r3, #8	@ tmp139, tmp138,
@ Accessories.c:113: 			else unit->items[i] = (unit->items[i] & 0xC0FF) | ((ITEM_USES(unit->items[i]) - 1) << 8);
	ands	r7, r5	@ tmp140, tmp148
@ Accessories.c:113: 			else unit->items[i] = (unit->items[i] & 0xC0FF) | ((ITEM_USES(unit->items[i]) - 1) << 8);
	orrs	r3, r7	@ tmp144, tmp140
@ Accessories.c:113: 			else unit->items[i] = (unit->items[i] & 0xC0FF) | ((ITEM_USES(unit->items[i]) - 1) << 8);
	strh	r3, [r1]	@ tmp144, MEM[base: _25, offset: 0B]
	b	.L33		@
.L38:
	.align	2
.L37:
	.word	-16129
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
@ Accessories.c:120: 	int item = EquippedAccessoryGetter(unit);
	bl	EquippedAccessoryGetter		@
@ Accessories.c:121: 	if (!item) return 0;
	cmp	r0, #0	@ <retval>,
	beq	.L39		@,
@ Accessories.c:122: 	return GetItemMight(item);// item effect id uses the might byte
	ldr	r3, .L44	@ tmp115,
	bl	.L8		@
.L39:
@ Accessories.c:125: }
	@ sp needed	@
	pop	{r4}
	pop	{r1}
	bx	r1
.L45:
	.align	2
.L44:
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
@ Accessories.c:127: int AccessoryEffectTester(struct Unit *unit, int AccessoryEffectID) {
	movs	r4, r1	@ AccessoryEffectID, tmp124
@ Accessories.c:130: }
	@ sp needed	@
@ Accessories.c:128: 	if (AccessoryEffectGetter(unit) == AccessoryEffectID) return 1;
	bl	AccessoryEffectGetter		@
@ Accessories.c:128: 	if (AccessoryEffectGetter(unit) == AccessoryEffectID) return 1;
	subs	r0, r0, r4	@ tmp121, tmp125, AccessoryEffectID
	rsbs	r3, r0, #0	@ tmp122, tmp121
	adcs	r0, r0, r3	@ tmp120, tmp121, tmp122
@ Accessories.c:130: }
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
@ Accessories.c:132: int AccessorySkillGetter(struct Unit *unit) {
	movs	r5, r0	@ unit, tmp119
@ Accessories.c:133: 	int item = EquippedAccessoryGetter(unit);
	bl	EquippedAccessoryGetter		@
	subs	r4, r0, #0	@ item, tmp120,
@ Accessories.c:134: 	if(!item) return 0;
	bne	.L48		@,
.L50:
@ Accessories.c:134: 	if(!item) return 0;
	movs	r0, #0	@ <retval>,
.L47:
@ Accessories.c:140: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L48:
@ Accessories.c:135: 	if (AccessoryEffectTester(unit, 1)) { // Test if Accessory has the Skill effect
	movs	r1, #1	@,
	movs	r0, r5	@, unit
	bl	AccessoryEffectTester		@
@ Accessories.c:135: 	if (AccessoryEffectTester(unit, 1)) { // Test if Accessory has the Skill effect
	cmp	r0, #0	@ tmp121,
	beq	.L50		@,
@ Accessories.c:136: 		return GetItemHit(item);
	movs	r0, r4	@, item
	ldr	r3, .L54	@ tmp117,
	bl	.L8		@
	b	.L47		@
.L55:
	.align	2
.L54:
	.word	GetItemHit
	.size	AccessorySkillGetter, .-AccessorySkillGetter
	.align	1
	.global	ComputePrecisionRingHitBoost
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	ComputePrecisionRingHitBoost, %function
ComputePrecisionRingHitBoost:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ Accessories.c:197: 	if(AccessoryEffectTester(&bu->unit, 5)) 
	movs	r1, #5	@,
@ Accessories.c:196: void ComputePrecisionRingHitBoost(struct BattleUnit* bu) {
	movs	r4, r0	@ bu, tmp130
@ Accessories.c:197: 	if(AccessoryEffectTester(&bu->unit, 5)) 
	bl	AccessoryEffectTester		@
@ Accessories.c:197: 	if(AccessoryEffectTester(&bu->unit, 5)) 
	cmp	r0, #0	@ tmp131,
	beq	.L56		@,
@ Accessories.c:198: 		bu->battleHitRate += 10;
	adds	r4, r4, #96	@ tmp122,
	ldrh	r3, [r4]	@ tmp124,
	adds	r3, r3, #10	@ tmp125,
	strh	r3, [r4]	@ tmp125, bu_8(D)->battleHitRate
.L56:
@ Accessories.c:199: }
	@ sp needed	@
	pop	{r4}
	pop	{r0}
	bx	r0
	.size	ComputePrecisionRingHitBoost, .-ComputePrecisionRingHitBoost
	.align	1
	.global	ComputeArcanaShieldAttackReduction
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	ComputeArcanaShieldAttackReduction, %function
ComputeArcanaShieldAttackReduction:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
@ Accessories.c:202: 	if (IsWeaponMagic(ITEM_INDEX(attacker->weapon)) && AccessoryEffectTester(&defender->unit, AE_ArcanaShieldID)) 
	movs	r3, r0	@ tmp135, attacker
@ Accessories.c:201: void ComputeArcanaShieldAttackReduction(struct BattleUnit* attacker, struct BattleUnit* defender) {
	push	{r4, r5, r6, lr}	@
@ Accessories.c:202: 	if (IsWeaponMagic(ITEM_INDEX(attacker->weapon)) && AccessoryEffectTester(&defender->unit, AE_ArcanaShieldID)) 
	adds	r3, r3, #72	@ tmp135,
@ Accessories.c:201: void ComputeArcanaShieldAttackReduction(struct BattleUnit* attacker, struct BattleUnit* defender) {
	movs	r5, r0	@ attacker, tmp170
@ Accessories.c:202: 	if (IsWeaponMagic(ITEM_INDEX(attacker->weapon)) && AccessoryEffectTester(&defender->unit, AE_ArcanaShieldID)) 
	ldrb	r0, [r3]	@ tmp140,
	ldr	r3, .L68	@ tmp142,
@ Accessories.c:201: void ComputeArcanaShieldAttackReduction(struct BattleUnit* attacker, struct BattleUnit* defender) {
	movs	r4, r1	@ defender, tmp171
@ Accessories.c:202: 	if (IsWeaponMagic(ITEM_INDEX(attacker->weapon)) && AccessoryEffectTester(&defender->unit, AE_ArcanaShieldID)) 
	bl	.L8		@
@ Accessories.c:202: 	if (IsWeaponMagic(ITEM_INDEX(attacker->weapon)) && AccessoryEffectTester(&defender->unit, AE_ArcanaShieldID)) 
	cmp	r0, #0	@ tmp172,
	beq	.L61		@,
@ Accessories.c:202: 	if (IsWeaponMagic(ITEM_INDEX(attacker->weapon)) && AccessoryEffectTester(&defender->unit, AE_ArcanaShieldID)) 
	ldr	r3, .L68+4	@ tmp145,
	movs	r0, r4	@, defender
	ldrb	r1, [r3]	@ AE_ArcanaShieldID, AE_ArcanaShieldID
	bl	AccessoryEffectTester		@
@ Accessories.c:202: 	if (IsWeaponMagic(ITEM_INDEX(attacker->weapon)) && AccessoryEffectTester(&defender->unit, AE_ArcanaShieldID)) 
	cmp	r0, #0	@ tmp173,
	beq	.L61		@,
@ Accessories.c:203: 		attacker->battleAttack = attacker->battleAttack - ((attacker->battleAttack - defender->battleDefense)/4);
	adds	r4, r4, #92	@ tmp152,
	movs	r3, #0	@ tmp175,
	ldrsh	r1, [r4, r3]	@ tmp153, tmp152, tmp175
@ Accessories.c:203: 		attacker->battleAttack = attacker->battleAttack - ((attacker->battleAttack - defender->battleDefense)/4);
	movs	r4, #3	@ tmp160,
@ Accessories.c:203: 		attacker->battleAttack = attacker->battleAttack - ((attacker->battleAttack - defender->battleDefense)/4);
	adds	r5, r5, #90	@ tmp149,
	movs	r3, #0	@ tmp174,
	ldrsh	r2, [r5, r3]	@ _8, tmp149, tmp174
@ Accessories.c:203: 		attacker->battleAttack = attacker->battleAttack - ((attacker->battleAttack - defender->battleDefense)/4);
	subs	r1, r2, r1	@ tmp154, _8, tmp153
@ Accessories.c:203: 		attacker->battleAttack = attacker->battleAttack - ((attacker->battleAttack - defender->battleDefense)/4);
	asrs	r3, r1, #31	@ tmp158, tmp154,
	ands	r3, r4	@ tmp159, tmp160
	adds	r3, r3, r1	@ tmp161, tmp159, tmp154
	asrs	r3, r3, #2	@ tmp162, tmp161,
@ Accessories.c:203: 		attacker->battleAttack = attacker->battleAttack - ((attacker->battleAttack - defender->battleDefense)/4);
	subs	r3, r2, r3	@ tmp165, _8, tmp162
@ Accessories.c:203: 		attacker->battleAttack = attacker->battleAttack - ((attacker->battleAttack - defender->battleDefense)/4);
	strh	r3, [r5]	@ tmp165, attacker_20(D)->battleAttack
.L61:
@ Accessories.c:204: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L69:
	.align	2
.L68:
	.word	IsWeaponMagic
	.word	AE_ArcanaShieldID
	.size	ComputeArcanaShieldAttackReduction, .-ComputeArcanaShieldAttackReduction
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
@ Accessories.c:227: int GetStatIncreaseWithAngelRing(int growth, struct Unit* unit) {
	movs	r5, r1	@ unit, tmp128
@ Accessories.c:228:     int result = 0;
	movs	r4, #0	@ <retval>,
.L71:
@ Accessories.c:230:     while (growth > 100) {
	cmp	r0, #100	@ growth,
	bgt	.L72		@,
@ Accessories.c:235:     if (Roll1RN(growth)) {
	ldr	r3, .L78	@ tmp120,
	bl	.L8		@
@ Accessories.c:235:     if (Roll1RN(growth)) {
	cmp	r0, #0	@ tmp129,
	beq	.L70		@,
@ Accessories.c:237: 		if(AccessoryEffectTester(unit, AE_AngelRingID)) result++;
	ldr	r3, .L78+4	@ tmp121,
	movs	r0, r5	@, unit
	ldrb	r1, [r3]	@ AE_AngelRingID, AE_AngelRingID
	bl	AccessoryEffectTester		@
@ Accessories.c:236:         result++;
	subs	r3, r0, #1	@ tmp126, tmp130
	sbcs	r0, r0, r3	@ tmp125, tmp130, tmp126
	adds	r0, r0, r4	@ tmp125, tmp125, <retval>
	adds	r4, r0, #1	@ <retval>, tmp125,
.L70:
@ Accessories.c:240: }
	movs	r0, r4	@, <retval>
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L72:
@ Accessories.c:231:         result++;
	adds	r4, r4, #1	@ <retval>,
@ Accessories.c:232:         growth -= 100;
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
@ Accessories.c:243: 	if (!(roundData->attributes & BATTLE_HIT_ATTR_MISS)) { // if attack didn't miss 
	ldr	r3, [r2]	@ *roundData_7(D), *roundData_7(D)
@ Accessories.c:242: void Proc_CheckForAccessory(struct BattleUnit* attacker, struct BattleUnit* defender, struct BattleHit* roundData) {
	push	{r4, lr}	@
@ Accessories.c:242: void Proc_CheckForAccessory(struct BattleUnit* attacker, struct BattleUnit* defender, struct BattleHit* roundData) {
	movs	r4, r1	@ defender, tmp131
@ Accessories.c:243: 	if (!(roundData->attributes & BATTLE_HIT_ATTR_MISS)) { // if attack didn't miss 
	lsls	r3, r3, #30	@ tmp135, *roundData_7(D),
	bmi	.L80		@,
@ Accessories.c:244: 		int accessory = EquippedAccessoryGetter(&defender->unit);
	movs	r0, r1	@, defender
	bl	EquippedAccessoryGetter		@
@ Accessories.c:245: 		if(accessory) { // if the defender has an accessory equipped
	cmp	r0, #0	@ accessory,
	beq	.L80		@,
@ Accessories.c:246: 			if (GetItemAttributes(accessory) & IA_DEPLETEUSESONDEFENSE) {
	ldr	r3, .L90	@ tmp128,
	bl	.L8		@
@ Accessories.c:246: 			if (GetItemAttributes(accessory) & IA_DEPLETEUSESONDEFENSE) {
	lsls	r3, r0, #8	@ tmp136, tmp134,
	bpl	.L80		@,
@ Accessories.c:247: 				DepleteEquippedAccessoryUse(&defender->unit);
	movs	r0, r4	@, defender
	bl	DepleteEquippedAccessoryUse		@
.L80:
@ Accessories.c:251: }
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
@ Accessories.c:254: int UnitAddItem(struct Unit* unit, u16 item) {
	movs	r5, r0	@ unit, tmp145
@ Accessories.c:257: 	if ((GetItemAttributes(ITEM_INDEX(item)) & IA_ACCESSORY) && !(EquippedAccessoryGetter(unit))) item |= 0x8000; // Auto-Equip accessory if there is none currently equipped
	lsls	r0, r1, #24	@ tmp128, item,
	ldr	r3, .L101	@ tmp130,
	lsrs	r0, r0, #24	@ tmp128, tmp128,
@ Accessories.c:254: int UnitAddItem(struct Unit* unit, u16 item) {
	movs	r4, r1	@ item, tmp146
@ Accessories.c:257: 	if ((GetItemAttributes(ITEM_INDEX(item)) & IA_ACCESSORY) && !(EquippedAccessoryGetter(unit))) item |= 0x8000; // Auto-Equip accessory if there is none currently equipped
	bl	.L8		@
@ Accessories.c:257: 	if ((GetItemAttributes(ITEM_INDEX(item)) & IA_ACCESSORY) && !(EquippedAccessoryGetter(unit))) item |= 0x8000; // Auto-Equip accessory if there is none currently equipped
	lsls	r3, r0, #9	@ tmp150, tmp147,
	bpl	.L93		@,
@ Accessories.c:257: 	if ((GetItemAttributes(ITEM_INDEX(item)) & IA_ACCESSORY) && !(EquippedAccessoryGetter(unit))) item |= 0x8000; // Auto-Equip accessory if there is none currently equipped
	movs	r0, r5	@, unit
	bl	EquippedAccessoryGetter		@
@ Accessories.c:257: 	if ((GetItemAttributes(ITEM_INDEX(item)) & IA_ACCESSORY) && !(EquippedAccessoryGetter(unit))) item |= 0x8000; // Auto-Equip accessory if there is none currently equipped
	cmp	r0, #0	@ tmp148,
	bne	.L93		@,
@ Accessories.c:257: 	if ((GetItemAttributes(ITEM_INDEX(item)) & IA_ACCESSORY) && !(EquippedAccessoryGetter(unit))) item |= 0x8000; // Auto-Equip accessory if there is none currently equipped
	movs	r3, #128	@ tmp133,
	lsls	r3, r3, #8	@ tmp133, tmp133,
	orrs	r4, r3	@ item, tmp133
.L93:
@ Accessories.c:260:         if (unit->items[i] == 0) {
	movs	r2, r5	@ tmp136, unit
@ Accessories.c:259:     for (i = 0; i < 5; ++i) {
	movs	r0, #0	@ i,
@ Accessories.c:260:         if (unit->items[i] == 0) {
	adds	r2, r2, #30	@ tmp136,
.L96:
	lsls	r1, r0, #1	@ tmp137, i,
@ Accessories.c:260:         if (unit->items[i] == 0) {
	ldrh	r1, [r2, r1]	@ MEM[base: _23, index: _19, offset: 0B], MEM[base: _23, index: _19, offset: 0B]
	cmp	r1, #0	@ MEM[base: _23, index: _19, offset: 0B],
	bne	.L94		@,
@ Accessories.c:261:             unit->items[i] = item;
	adds	r0, r0, #12	@ tmp139,
	lsls	r0, r0, #1	@ tmp140, tmp139,
	adds	r0, r5, r0	@ tmp141, unit, tmp140
	strh	r4, [r0, #6]	@ item, unit_13(D)->items
@ Accessories.c:262:             return TRUE;
	movs	r0, #1	@ <retval>,
.L92:
@ Accessories.c:267: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L94:
@ Accessories.c:259:     for (i = 0; i < 5; ++i) {
	adds	r0, r0, #1	@ i,
@ Accessories.c:259:     for (i = 0; i < 5; ++i) {
	cmp	r0, #5	@ i,
	bne	.L96		@,
@ Accessories.c:266:     return FALSE;
	movs	r0, #0	@ <retval>,
	b	.L92		@
.L102:
	.align	2
.L101:
	.word	GetItemAttributes
	.size	UnitAddItem, .-UnitAddItem
	.ident	"GCC: (devkitARM release 54) 10.1.0"
	.code 16
	.align	1
.L8:
	bx	r3
