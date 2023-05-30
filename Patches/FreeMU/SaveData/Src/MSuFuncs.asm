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
	.file	"MSuFuncs.c"
@ GNU C17 (devkitARM release 56) version 11.1.0 (arm-none-eabi)
@	compiled by GNU C version 10.3.0, GMP version 6.2.1, MPFR version 4.1.0, MPC version 1.2.1, isl version isl-0.18-GMP

@ GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
@ options passed: -mcpu=arm7tdmi -mthumb -mthumb-interwork -mtune=arm7tdmi -mlong-calls -march=armv4t -Os -ffreestanding
	.text
	.align	1
	.global	MSu_SaveActionState
	.arch armv4t
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	MSu_SaveActionState, %function
MSu_SaveActionState:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:7: void MSu_SaveActionState(void* target, unsigned size) {
	movs	r5, r1	@ size, tmp119
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:10: }
	@ sp needed	@
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:7: void MSu_SaveActionState(void* target, unsigned size) {
	movs	r4, r0	@ target, tmp118
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:8: 	StoreRNStateToActionStruct();
	ldr	r3, .L2	@ tmp115,
	bl	.L4		@
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:9: 	WriteAndVerifySramFast(&gActionData, target, size);
	movs	r2, r5	@, size
	movs	r1, r4	@, target
	ldr	r3, .L2+4	@ tmp117,
	ldr	r0, .L2+8	@ tmp116,
	bl	.L4		@
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:10: }
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L3:
	.align	2
.L2:
	.word	StoreRNStateToActionStruct
	.word	WriteAndVerifySramFast
	.word	gActionData
	.size	MSu_SaveActionState, .-MSu_SaveActionState
	.align	1
	.global	MSu_LoadActionState
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	MSu_LoadActionState, %function
MSu_LoadActionState:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:13: 	gpReadSramFast(source, &gActionData, size);
	ldr	r3, .L6	@ tmp115,
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:15: }
	@ sp needed	@
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:12: void MSu_LoadActionState(void* source, unsigned size) {
	movs	r2, r1	@ size, tmp119
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:13: 	gpReadSramFast(source, &gActionData, size);
	movs	r1, r3	@ tmp115, tmp115
	ldr	r3, .L6+4	@ tmp116,
	bl	.L4		@
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:14: 	LoadRNStateFromActionStruct();
	ldr	r3, .L6+8	@ tmp117,
	bl	.L4		@
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:15: }
	pop	{r4}
	pop	{r0}
	bx	r0
.L7:
	.align	2
.L6:
	.word	gActionData
	.word	gpReadSramFast
	.word	LoadRNStateFromActionStruct
	.size	MSu_LoadActionState, .-MSu_LoadActionState
	.align	1
	.global	MSu_SavePlayerUnits
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	MSu_SavePlayerUnits, %function
MSu_SavePlayerUnits:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:17: void MSu_SavePlayerUnits(void* target, unsigned size) {
	movs	r4, r0	@ ivtmp.33, tmp127
	movs	r5, #1	@ ivtmp.30,
.L9:
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:19: 		PackUnitStructForSuspend(GetUnit(i+1), gGenericBuffer);
	lsls	r0, r5, #24	@ tmp120, ivtmp.30,
	ldr	r3, .L11	@ tmp122,
	lsrs	r0, r0, #24	@ tmp120, tmp120,
	bl	.L4		@
	ldr	r6, .L11+4	@ tmp123,
	ldr	r3, .L11+8	@ tmp124,
	movs	r1, r6	@, tmp123
	bl	.L4		@
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:18: 	for (unsigned i = 0; i < 51; ++i) {
	adds	r5, r5, #1	@ ivtmp.30,
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:20: 		WriteAndVerifySramFast(gGenericBuffer, target + 0x34*i, 0x34);
	movs	r1, r4	@, ivtmp.33
	movs	r2, #52	@,
	movs	r0, r6	@, tmp123
	ldr	r3, .L11+12	@ tmp126,
	bl	.L4		@
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:18: 	for (unsigned i = 0; i < 51; ++i) {
	adds	r4, r4, #52	@ ivtmp.33,
	cmp	r5, #52	@ ivtmp.30,
	bne	.L9		@,
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:22: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L12:
	.align	2
.L11:
	.word	GetUnit
	.word	gGenericBuffer
	.word	PackUnitStructForSuspend
	.word	WriteAndVerifySramFast
	.size	MSu_SavePlayerUnits, .-MSu_SavePlayerUnits
	.align	1
	.global	MSu_LoadPlayerUnits
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	MSu_LoadPlayerUnits, %function
MSu_LoadPlayerUnits:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:24: void MSu_LoadPlayerUnits(void* source, unsigned size) {
	movs	r4, r0	@ ivtmp.45, tmp124
	movs	r5, #1	@ ivtmp.42,
.L14:
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:26: 		UnpackUnitStructFromSuspend(source + 0x34*i, GetUnit(i+1));
	lsls	r0, r5, #24	@ tmp120, ivtmp.42,
	ldr	r3, .L16	@ tmp122,
	lsrs	r0, r0, #24	@ tmp120, tmp120,
	bl	.L4		@
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:25: 	for (unsigned i = 0; i < 51; ++i)
	adds	r5, r5, #1	@ ivtmp.42,
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:26: 		UnpackUnitStructFromSuspend(source + 0x34*i, GetUnit(i+1));
	movs	r1, r0	@ _5, tmp125
	ldr	r3, .L16+4	@ tmp123,
	movs	r0, r4	@, ivtmp.45
	bl	.L4		@
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:25: 	for (unsigned i = 0; i < 51; ++i)
	adds	r4, r4, #52	@ ivtmp.45,
	cmp	r5, #52	@ ivtmp.42,
	bne	.L14		@,
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:27: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L17:
	.align	2
.L16:
	.word	GetUnit
	.word	UnpackUnitStructFromSuspend
	.size	MSu_LoadPlayerUnits, .-MSu_LoadPlayerUnits
	.align	1
	.global	MSu_SaveOtherUnits
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	MSu_SaveOtherUnits, %function
MSu_SaveOtherUnits:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r0, r1, r2, r4, r5, r6, r7, lr}	@
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:29: void MSu_SaveOtherUnits(void* target, unsigned size) {
	movs	r4, r0	@ target, tmp141
	movs	r7, r0	@ ivtmp.66, target
	movs	r5, #129	@ ivtmp.64,
.L19:
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:32: 		PackUnitStructForSuspend(GetUnit(0x81+i), gGenericBuffer);
	ldr	r3, .L23	@ tmp124,
	movs	r0, r5	@, ivtmp.64
	str	r3, [sp]	@ tmp124, %sfp
	bl	.L4		@
	ldr	r6, .L23+4	@ tmp125,
	ldr	r3, .L23+8	@ tmp126,
	movs	r1, r6	@, tmp125
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:31: 	for (unsigned i = 0; i < 50; ++i) {
	adds	r5, r5, #1	@ tmp129,
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:32: 		PackUnitStructForSuspend(GetUnit(0x81+i), gGenericBuffer);
	str	r3, [sp, #4]	@ tmp126, %sfp
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:31: 	for (unsigned i = 0; i < 50; ++i) {
	lsls	r5, r5, #24	@ ivtmp.64, tmp129,
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:32: 		PackUnitStructForSuspend(GetUnit(0x81+i), gGenericBuffer);
	bl	.L4		@
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:33: 		WriteAndVerifySramFast(gGenericBuffer, target + 0x34*i, 0x34);
	movs	r1, r7	@, ivtmp.66
	movs	r2, #52	@,
	movs	r0, r6	@, tmp125
	ldr	r3, .L23+12	@ tmp128,
	bl	.L4		@
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:31: 	for (unsigned i = 0; i < 50; ++i) {
	lsrs	r5, r5, #24	@ ivtmp.64, ivtmp.64,
	adds	r7, r7, #52	@ ivtmp.66,
	cmp	r5, #179	@ ivtmp.64,
	bne	.L19		@,
	ldr	r3, .L23+16	@ tmp149,
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:31: 	for (unsigned i = 0; i < 50; ++i) {
	subs	r5, r5, #114	@ ivtmp.54,
	adds	r4, r4, r3	@ ivtmp.56, target, tmp149
.L20:
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:38: 		PackUnitStructForSuspend(GetUnit(0x41+i), gGenericBuffer);
	movs	r0, r5	@, ivtmp.54
	ldr	r3, [sp]	@ tmp124, %sfp
	bl	.L4		@
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:37: 	for (unsigned i = 0; i < 10; ++i) {
	adds	r5, r5, #1	@ tmp136,
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:38: 		PackUnitStructForSuspend(GetUnit(0x41+i), gGenericBuffer);
	movs	r1, r6	@, tmp125
	ldr	r3, [sp, #4]	@ tmp126, %sfp
	bl	.L4		@
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:37: 	for (unsigned i = 0; i < 10; ++i) {
	lsls	r5, r5, #24	@ ivtmp.54, tmp136,
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:39: 		WriteAndVerifySramFast(gGenericBuffer, target + 0x34*(50+i), 0x34);
	movs	r1, r4	@, ivtmp.56
	movs	r2, #52	@,
	movs	r0, r6	@, tmp125
	ldr	r3, .L23+12	@ tmp135,
	bl	.L4		@
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:37: 	for (unsigned i = 0; i < 10; ++i) {
	lsrs	r5, r5, #24	@ ivtmp.54, ivtmp.54,
	adds	r4, r4, #52	@ ivtmp.56,
	cmp	r5, #75	@ ivtmp.54,
	bne	.L20		@,
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:41: }
	@ sp needed	@
	pop	{r0, r1, r2, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L24:
	.align	2
.L23:
	.word	GetUnit
	.word	gGenericBuffer
	.word	PackUnitStructForSuspend
	.word	WriteAndVerifySramFast
	.word	2600
	.size	MSu_SaveOtherUnits, .-MSu_SaveOtherUnits
	.align	1
	.global	MSu_LoadOtherUnits
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	MSu_LoadOtherUnits, %function
MSu_LoadOtherUnits:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r0, r1, r2, r4, r5, r6, r7, lr}	@
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:43: void MSu_LoadOtherUnits(void* source, unsigned size) {
	movs	r4, r0	@ source, tmp134
	movs	r6, r0	@ ivtmp.87, source
	movs	r5, #129	@ ivtmp.85,
.L26:
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:46: 		UnpackUnitStructFromSuspend(source + 0x34*i, GetUnit(0x81+i));
	movs	r0, r5	@, ivtmp.85
	ldr	r7, .L30	@ tmp124,
	bl	.L32		@
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:45: 	for (unsigned i = 0; i < 50; ++i)
	adds	r5, r5, #1	@ tmp126,
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:46: 		UnpackUnitStructFromSuspend(source + 0x34*i, GetUnit(0x81+i));
	ldr	r3, .L30+4	@ tmp125,
	movs	r1, r0	@ _5, tmp135
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:45: 	for (unsigned i = 0; i < 50; ++i)
	lsls	r5, r5, #24	@ ivtmp.85, tmp126,
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:46: 		UnpackUnitStructFromSuspend(source + 0x34*i, GetUnit(0x81+i));
	movs	r0, r6	@, ivtmp.87
	str	r3, [sp, #4]	@ tmp125, %sfp
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:45: 	for (unsigned i = 0; i < 50; ++i)
	lsrs	r5, r5, #24	@ ivtmp.85, ivtmp.85,
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:46: 		UnpackUnitStructFromSuspend(source + 0x34*i, GetUnit(0x81+i));
	bl	.L4		@
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:45: 	for (unsigned i = 0; i < 50; ++i)
	adds	r6, r6, #52	@ ivtmp.87,
	cmp	r5, #179	@ ivtmp.85,
	bne	.L26		@,
	ldr	r3, .L30+8	@ tmp140,
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:45: 	for (unsigned i = 0; i < 50; ++i)
	subs	r5, r5, #114	@ ivtmp.75,
	adds	r4, r4, r3	@ ivtmp.77, source, tmp140
.L27:
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:50: 		UnpackUnitStructFromSuspend(source + 0x34*(50+i), GetUnit(0x41+i));
	movs	r0, r5	@, ivtmp.75
	bl	.L32		@
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:49: 	for (unsigned i = 0; i < 10; ++i)
	adds	r5, r5, #1	@ tmp130,
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:50: 		UnpackUnitStructFromSuspend(source + 0x34*(50+i), GetUnit(0x41+i));
	movs	r1, r0	@ _11, tmp136
	ldr	r3, [sp, #4]	@ tmp125, %sfp
	movs	r0, r4	@, ivtmp.77
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:49: 	for (unsigned i = 0; i < 10; ++i)
	lsls	r5, r5, #24	@ ivtmp.75, tmp130,
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:50: 		UnpackUnitStructFromSuspend(source + 0x34*(50+i), GetUnit(0x41+i));
	bl	.L4		@
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:49: 	for (unsigned i = 0; i < 10; ++i)
	lsrs	r5, r5, #24	@ ivtmp.75, ivtmp.75,
	adds	r4, r4, #52	@ ivtmp.77,
	cmp	r5, #75	@ ivtmp.75,
	bne	.L27		@,
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:51: }
	@ sp needed	@
	pop	{r0, r1, r2, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L31:
	.align	2
.L30:
	.word	GetUnit
	.word	UnpackUnitStructFromSuspend
	.word	2600
	.size	MSu_LoadOtherUnits, .-MSu_LoadOtherUnits
	.align	1
	.global	MSu_SaveMenuRelated
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	MSu_SaveMenuRelated, %function
MSu_SaveMenuRelated:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, lr}	@
	movs	r5, r1	@ size, tmp120
	movs	r4, r0	@ target, tmp119
	sub	sp, sp, #20	@,,
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:58: 	PackMenuRelatedSaveStruct(buf);
	mov	r0, sp	@,
	ldr	r3, .L34	@ tmp116,
	bl	.L4		@
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:59: 	WriteAndVerifySramFast(buf, target, size);
	movs	r2, r5	@, size
	movs	r1, r4	@, target
	mov	r0, sp	@,
	ldr	r3, .L34+4	@ tmp118,
	bl	.L4		@
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:60: }
	add	sp, sp, #20	@,,
	@ sp needed	@
	pop	{r4, r5}
	pop	{r0}
	bx	r0
.L35:
	.align	2
.L34:
	.word	134543125
	.word	WriteAndVerifySramFast
	.size	MSu_SaveMenuRelated, .-MSu_SaveMenuRelated
	.align	1
	.global	MSu_LoadMenuRelated
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	MSu_LoadMenuRelated, %function
MSu_LoadMenuRelated:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r0, r1, r2, r3, r4, lr}	@
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:62: void MSu_LoadMenuRelated(void* source, unsigned size) {
	movs	r2, r1	@ size, tmp120
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:67: 	gpReadSramFast(source, buf, size);
	ldr	r3, .L37	@ tmp116,
	mov	r1, sp	@,
	bl	.L4		@
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:68: 	UnpackMenuRelatedSaveStruct(buf);
	mov	r0, sp	@,
	ldr	r3, .L37+4	@ tmp118,
	bl	.L4		@
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:69: }
	add	sp, sp, #20	@,,
	@ sp needed	@
	pop	{r0}
	bx	r0
.L38:
	.align	2
.L37:
	.word	gpReadSramFast
	.word	134543189
	.size	MSu_LoadMenuRelated, .-MSu_LoadMenuRelated
	.align	1
	.global	MSu_SaveDungeonState
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	MSu_SaveDungeonState, %function
MSu_SaveDungeonState:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, lr}	@
	movs	r5, r1	@ size, tmp120
	movs	r4, r0	@ target, tmp119
	sub	sp, sp, #20	@,,
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:76: 	PackIdk(buf);
	add	r0, sp, #4	@ tmp122,,
	ldr	r3, .L40	@ tmp116,
	bl	.L4		@
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:77: 	WriteAndVerifySramFast(buf, target, size);
	movs	r2, r5	@, size
	movs	r1, r4	@, target
	ldr	r3, .L40+4	@ tmp118,
	add	r0, sp, #4	@ tmp123,,
	bl	.L4		@
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:78: }
	add	sp, sp, #20	@,,
	@ sp needed	@
	pop	{r4, r5}
	pop	{r0}
	bx	r0
.L41:
	.align	2
.L40:
	.word	134446601
	.word	WriteAndVerifySramFast
	.size	MSu_SaveDungeonState, .-MSu_SaveDungeonState
	.align	1
	.global	MSu_LoadDungeonState
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	MSu_LoadDungeonState, %function
MSu_LoadDungeonState:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r0, r1, r2, r3, r4, lr}	@
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:80: void MSu_LoadDungeonState(void* source, unsigned size) {
	movs	r2, r1	@ size, tmp120
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:85: 	gpReadSramFast(source, buf, size);
	ldr	r3, .L43	@ tmp116,
	add	r1, sp, #4	@ tmp122,,
	bl	.L4		@
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:86: 	UnpackIdk(buf);
	ldr	r3, .L43+4	@ tmp118,
	add	r0, sp, #4	@ tmp123,,
	bl	.L4		@
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:87: }
	add	sp, sp, #20	@,,
	@ sp needed	@
	pop	{r0}
	bx	r0
.L44:
	.align	2
.L43:
	.word	gpReadSramFast
	.word	134446641
	.size	MSu_LoadDungeonState, .-MSu_LoadDungeonState
	.align	1
	.global	MSu_SaveEventCounter
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	MSu_SaveEventCounter, %function
MSu_SaveEventCounter:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r0, r1, r2, r4, r5, lr}	@
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:90: 	unsigned counter = GetEventCounter();
	ldr	r3, .L46	@ tmp116,
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:92: }
	@ sp needed	@
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:89: void MSu_SaveEventCounter(void* target, unsigned size) {
	movs	r5, r1	@ size, tmp120
	movs	r4, r0	@ target, tmp119
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:90: 	unsigned counter = GetEventCounter();
	bl	.L4		@
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:91: 	WriteAndVerifySramFast(&counter, target, size);
	movs	r2, r5	@, size
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:90: 	unsigned counter = GetEventCounter();
	str	r0, [sp, #4]	@ tmp121, counter
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:91: 	WriteAndVerifySramFast(&counter, target, size);
	movs	r1, r4	@, target
	ldr	r3, .L46+4	@ tmp118,
	add	r0, sp, #4	@,,
	bl	.L4		@
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:92: }
	pop	{r0, r1, r2, r4, r5}
	pop	{r0}
	bx	r0
.L47:
	.align	2
.L46:
	.word	GetEventCounter
	.word	WriteAndVerifySramFast
	.size	MSu_SaveEventCounter, .-MSu_SaveEventCounter
	.align	1
	.global	MSu_LoadEventCounter
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	MSu_LoadEventCounter, %function
MSu_LoadEventCounter:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r0, r1, r2, lr}	@
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:97: 	gpReadSramFast(source, &counter, size);
	ldr	r3, .L49	@ tmp117,
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:94: void MSu_LoadEventCounter(void* source, unsigned size) {
	movs	r2, r1	@ size, tmp120
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:97: 	gpReadSramFast(source, &counter, size);
	add	r1, sp, #4	@,,
	bl	.L4		@
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:98: 	SetEventCounter(counter);
	ldr	r0, [sp, #4]	@, counter
	ldr	r3, .L49+4	@ tmp118,
	bl	.L4		@
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:99: }
	add	sp, sp, #12	@,,
	@ sp needed	@
	pop	{r0}
	bx	r0
.L50:
	.align	2
.L49:
	.word	gpReadSramFast
	.word	SetEventCounter
	.size	MSu_LoadEventCounter, .-MSu_LoadEventCounter
	.align	1
	.global	MSu_LoadClaimFlagsFromParentSave
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	MSu_LoadClaimFlagsFromParentSave, %function
MSu_LoadClaimFlagsFromParentSave:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:103: 	Set0203EDB4(MS_GetClaimFlagsFromGameSave(gChapterData.saveSlotIndex));
	ldr	r3, .L52	@ tmp118,
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:104: }
	@ sp needed	@
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:103: 	Set0203EDB4(MS_GetClaimFlagsFromGameSave(gChapterData.saveSlotIndex));
	ldrb	r0, [r3, #12]	@ tmp119,
	ldr	r3, .L52+4	@ tmp120,
	bl	.L4		@
	ldr	r3, .L52+8	@ tmp121,
	bl	.L4		@
@ CoreSupport/ExpandedModularSave/Src/MSuFuncs.c:104: }
	pop	{r4}
	pop	{r0}
	bx	r0
.L53:
	.align	2
.L52:
	.word	gChapterData
	.word	MS_GetClaimFlagsFromGameSave
	.word	Set0203EDB4
	.size	MSu_LoadClaimFlagsFromParentSave, .-MSu_LoadClaimFlagsFromParentSave
	.ident	"GCC: (devkitARM release 56) 11.1.0"
	.code 16
	.align	1
.L4:
	bx	r3
.L32:
	bx	r7
