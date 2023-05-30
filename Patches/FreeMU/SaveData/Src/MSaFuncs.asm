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
	.file	"MSaFuncs.c"
@ GNU C17 (devkitARM release 56) version 11.1.0 (arm-none-eabi)
@	compiled by GNU C version 10.3.0, GMP version 6.2.1, MPFR version 4.1.0, MPC version 1.2.1, isl version isl-0.18-GMP

@ GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
@ options passed: -mcpu=arm7tdmi -mthumb -mthumb-interwork -mtune=arm7tdmi -mlong-calls -march=armv4t -Os -ffreestanding
	.text
	.align	1
	.global	MSa_SaveChapterState
	.arch armv4t
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	MSa_SaveChapterState, %function
MSa_SaveChapterState:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ CoreSupport/ExpandedModularSave/Src/MSaFuncs.c:8: 	gChapterData._u00 = GetGameClock();
	ldr	r3, .L2	@ tmp117,
@ CoreSupport/ExpandedModularSave/Src/MSaFuncs.c:10: }
	@ sp needed	@
@ CoreSupport/ExpandedModularSave/Src/MSaFuncs.c:7: void MSa_SaveChapterState(void* target, unsigned size) {
	movs	r5, r1	@ size, tmp122
	movs	r4, r0	@ target, tmp121
@ CoreSupport/ExpandedModularSave/Src/MSaFuncs.c:8: 	gChapterData._u00 = GetGameClock();
	bl	.L4		@
@ CoreSupport/ExpandedModularSave/Src/MSaFuncs.c:8: 	gChapterData._u00 = GetGameClock();
	ldr	r3, .L2+4	@ tmp118,
@ CoreSupport/ExpandedModularSave/Src/MSaFuncs.c:9: 	WriteAndVerifySramFast(&gChapterData, target, size);
	movs	r2, r5	@, size
@ CoreSupport/ExpandedModularSave/Src/MSaFuncs.c:8: 	gChapterData._u00 = GetGameClock();
	str	r0, [r3]	@ tmp123, gChapterData._u00
@ CoreSupport/ExpandedModularSave/Src/MSaFuncs.c:9: 	WriteAndVerifySramFast(&gChapterData, target, size);
	movs	r1, r4	@, target
	movs	r0, r3	@, tmp118
	ldr	r3, .L2+8	@ tmp120,
	bl	.L4		@
@ CoreSupport/ExpandedModularSave/Src/MSaFuncs.c:10: }
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L3:
	.align	2
.L2:
	.word	GetGameClock
	.word	gChapterData
	.word	WriteAndVerifySramFast
	.size	MSa_SaveChapterState, .-MSa_SaveChapterState
	.align	1
	.global	MSa_LoadChapterState
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	MSa_LoadChapterState, %function
MSa_LoadChapterState:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ CoreSupport/ExpandedModularSave/Src/MSaFuncs.c:13: 	gpReadSramFast(source, &gChapterData, size);
	ldr	r4, .L6	@ tmp117,
@ CoreSupport/ExpandedModularSave/Src/MSaFuncs.c:15: }
	@ sp needed	@
@ CoreSupport/ExpandedModularSave/Src/MSaFuncs.c:12: void MSa_LoadChapterState(void* source, unsigned size) {
	movs	r2, r1	@ size, tmp122
@ CoreSupport/ExpandedModularSave/Src/MSaFuncs.c:13: 	gpReadSramFast(source, &gChapterData, size);
	ldr	r3, .L6+4	@ tmp118,
	movs	r1, r4	@, tmp117
	bl	.L4		@
@ CoreSupport/ExpandedModularSave/Src/MSaFuncs.c:14: 	SetGameClock(gChapterData._u00);
	ldr	r0, [r4]	@, gChapterData._u00
	ldr	r3, .L6+8	@ tmp120,
	bl	.L4		@
@ CoreSupport/ExpandedModularSave/Src/MSaFuncs.c:15: }
	pop	{r4}
	pop	{r0}
	bx	r0
.L7:
	.align	2
.L6:
	.word	gChapterData
	.word	gpReadSramFast
	.word	SetGameClock
	.size	MSa_LoadChapterState, .-MSa_LoadChapterState
	.align	1
	.global	MSa_SaveUnits
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	MSa_SaveUnits, %function
MSa_SaveUnits:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
	sub	sp, sp, #104	@,,
@ CoreSupport/ExpandedModularSave/Src/MSaFuncs.c:17: void MSa_SaveUnits(void* target, unsigned size) {
	movs	r4, r0	@ target, tmp135
@ CoreSupport/ExpandedModularSave/Src/MSaFuncs.c:19: 	LoadGeneralGameMetadata(&sgm);
	ldr	r3, .L15	@ tmp124,
	add	r0, sp, #4	@ tmp138,,
	bl	.L4		@
	movs	r5, #1	@ ivtmp.22,
.L10:
@ CoreSupport/ExpandedModularSave/Src/MSaFuncs.c:22: 		struct Unit* unit = GetUnit(i+1);
	lsls	r0, r5, #24	@ tmp125, ivtmp.22,
	ldr	r3, .L15+4	@ tmp127,
	lsrs	r0, r0, #24	@ tmp125, tmp125,
	bl	.L4		@
	movs	r6, r0	@ unit, tmp136
@ CoreSupport/ExpandedModularSave/Src/MSaFuncs.c:25: 		SaveUnit(unit, target + (0x24*i));
	ldr	r3, .L15+8	@ tmp128,
	movs	r1, r4	@, ivtmp.25
	bl	.L4		@
@ CoreSupport/ExpandedModularSave/Src/MSaFuncs.c:28: 		if (unit->pCharacterData)
	ldr	r3, [r6]	@ _5, unit_16->pCharacterData
@ CoreSupport/ExpandedModularSave/Src/MSaFuncs.c:28: 		if (unit->pCharacterData)
	cmp	r3, #0	@ _5,
	beq	.L9		@,
@ CoreSupport/ExpandedModularSave/Src/MSaFuncs.c:29: 			GGM_SetCharacterKnown(unit->pCharacterData->number, &sgm);
	ldrb	r0, [r3, #4]	@ tmp130,
	add	r1, sp, #4	@ tmp139,,
	ldr	r3, .L15+12	@ tmp131,
	bl	.L4		@
.L9:
@ CoreSupport/ExpandedModularSave/Src/MSaFuncs.c:21: 	for (unsigned i = 0; i < 51; ++i) {
	adds	r5, r5, #1	@ ivtmp.22,
	adds	r4, r4, #36	@ ivtmp.25,
	cmp	r5, #52	@ ivtmp.22,
	bne	.L10		@,
@ CoreSupport/ExpandedModularSave/Src/MSaFuncs.c:32: 	SaveGeneralGameMetadata(&sgm);
	ldr	r3, .L15+16	@ tmp133,
	add	r0, sp, #4	@ tmp140,,
	bl	.L4		@
@ CoreSupport/ExpandedModularSave/Src/MSaFuncs.c:33: }
	add	sp, sp, #104	@,,
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L16:
	.align	2
.L15:
	.word	LoadGeneralGameMetadata
	.word	GetUnit
	.word	SaveUnit
	.word	GGM_SetCharacterKnown
	.word	SaveGeneralGameMetadata
	.size	MSa_SaveUnits, .-MSa_SaveUnits
	.align	1
	.global	MSa_LoadUnits
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	MSa_LoadUnits, %function
MSa_LoadUnits:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ CoreSupport/ExpandedModularSave/Src/MSaFuncs.c:35: void MSa_LoadUnits(void* source, unsigned size) {
	movs	r4, r0	@ ivtmp.37, tmp124
	movs	r5, #1	@ ivtmp.34,
.L18:
@ CoreSupport/ExpandedModularSave/Src/MSaFuncs.c:37: 		LoadSavedUnit(source + (0x24*i), GetUnit(i+1));
	lsls	r0, r5, #24	@ tmp120, ivtmp.34,
	ldr	r3, .L20	@ tmp122,
	lsrs	r0, r0, #24	@ tmp120, tmp120,
	bl	.L4		@
@ CoreSupport/ExpandedModularSave/Src/MSaFuncs.c:36: 	for (unsigned i = 0; i < 51; ++i)
	adds	r5, r5, #1	@ ivtmp.34,
@ CoreSupport/ExpandedModularSave/Src/MSaFuncs.c:37: 		LoadSavedUnit(source + (0x24*i), GetUnit(i+1));
	movs	r1, r0	@ _5, tmp125
	ldr	r3, .L20+4	@ tmp123,
	movs	r0, r4	@, ivtmp.37
	bl	.L4		@
@ CoreSupport/ExpandedModularSave/Src/MSaFuncs.c:36: 	for (unsigned i = 0; i < 51; ++i)
	adds	r4, r4, #36	@ ivtmp.37,
	cmp	r5, #52	@ ivtmp.34,
	bne	.L18		@,
@ CoreSupport/ExpandedModularSave/Src/MSaFuncs.c:38: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L21:
	.align	2
.L20:
	.word	GetUnit
	.word	LoadSavedUnit
	.size	MSa_LoadUnits, .-MSa_LoadUnits
	.align	1
	.global	MSa_SaveBonusClaim
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	MSa_SaveBonusClaim, %function
MSa_SaveBonusClaim:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ CoreSupport/ExpandedModularSave/Src/MSaFuncs.c:40: void MSa_SaveBonusClaim(void* target, unsigned size) {
	movs	r2, r1	@ size, tmp118
@ CoreSupport/ExpandedModularSave/Src/MSaFuncs.c:42: }
	@ sp needed	@
@ CoreSupport/ExpandedModularSave/Src/MSaFuncs.c:41: 	WriteAndVerifySramFast((void*)(0x0203EDB4), target, size);
	movs	r1, r0	@, target
	ldr	r3, .L23	@ tmp116,
	ldr	r0, .L23+4	@,
	bl	.L4		@
@ CoreSupport/ExpandedModularSave/Src/MSaFuncs.c:42: }
	pop	{r4}
	pop	{r0}
	bx	r0
.L24:
	.align	2
.L23:
	.word	WriteAndVerifySramFast
	.word	33811892
	.size	MSa_SaveBonusClaim, .-MSa_SaveBonusClaim
	.align	1
	.global	MSa_LoadBonusClaim
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	MSa_LoadBonusClaim, %function
MSa_LoadBonusClaim:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ CoreSupport/ExpandedModularSave/Src/MSaFuncs.c:44: void MSa_LoadBonusClaim(void* source, unsigned size) {
	movs	r2, r1	@ size, tmp118
@ CoreSupport/ExpandedModularSave/Src/MSaFuncs.c:46: }
	@ sp needed	@
@ CoreSupport/ExpandedModularSave/Src/MSaFuncs.c:45: 	gpReadSramFast(source, (void*)(0x0203EDB4), size);
	ldr	r1, .L26	@,
	ldr	r3, .L26+4	@ tmp116,
	bl	.L4		@
@ CoreSupport/ExpandedModularSave/Src/MSaFuncs.c:46: }
	pop	{r4}
	pop	{r0}
	bx	r0
.L27:
	.align	2
.L26:
	.word	33811892
	.word	gpReadSramFast
	.size	MSa_LoadBonusClaim, .-MSa_LoadBonusClaim
	.align	1
	.global	MSa_SaveWMStuff
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	MSa_SaveWMStuff, %function
MSa_SaveWMStuff:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ CoreSupport/ExpandedModularSave/Src/MSaFuncs.c:49: 	SaveWMStuff(target, &gSomeWMEventRelatedStruct);
	ldr	r1, .L29	@ tmp115,
@ CoreSupport/ExpandedModularSave/Src/MSaFuncs.c:50: }
	@ sp needed	@
@ CoreSupport/ExpandedModularSave/Src/MSaFuncs.c:49: 	SaveWMStuff(target, &gSomeWMEventRelatedStruct);
	ldr	r3, .L29+4	@ tmp116,
	bl	.L4		@
@ CoreSupport/ExpandedModularSave/Src/MSaFuncs.c:50: }
	pop	{r4}
	pop	{r0}
	bx	r0
.L30:
	.align	2
.L29:
	.word	gSomeWMEventRelatedStruct
	.word	SaveWMStuff
	.size	MSa_SaveWMStuff, .-MSa_SaveWMStuff
	.align	1
	.global	MSa_LoadWMStuff
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	MSa_LoadWMStuff, %function
MSa_LoadWMStuff:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ CoreSupport/ExpandedModularSave/Src/MSaFuncs.c:53: 	LoadWMStuff(source, &gSomeWMEventRelatedStruct);
	ldr	r1, .L32	@ tmp115,
@ CoreSupport/ExpandedModularSave/Src/MSaFuncs.c:54: }
	@ sp needed	@
@ CoreSupport/ExpandedModularSave/Src/MSaFuncs.c:53: 	LoadWMStuff(source, &gSomeWMEventRelatedStruct);
	ldr	r3, .L32+4	@ tmp116,
	bl	.L4		@
@ CoreSupport/ExpandedModularSave/Src/MSaFuncs.c:54: }
	pop	{r4}
	pop	{r0}
	bx	r0
.L33:
	.align	2
.L32:
	.word	gSomeWMEventRelatedStruct
	.word	LoadWMStuff
	.size	MSa_LoadWMStuff, .-MSa_LoadWMStuff
	.align	1
	.global	MSa_SaveDungeonState
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	MSa_SaveDungeonState, %function
MSa_SaveDungeonState:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ CoreSupport/ExpandedModularSave/Src/MSaFuncs.c:56: void MSa_SaveDungeonState(void* target, unsigned size) {
	movs	r2, r1	@ size, tmp118
@ CoreSupport/ExpandedModularSave/Src/MSaFuncs.c:58: }
	@ sp needed	@
@ CoreSupport/ExpandedModularSave/Src/MSaFuncs.c:57: 	WriteAndVerifySramFast((void*)(0x30017AC), target, size);
	movs	r1, r0	@, target
	ldr	r3, .L35	@ tmp116,
	ldr	r0, .L35+4	@,
	bl	.L4		@
@ CoreSupport/ExpandedModularSave/Src/MSaFuncs.c:58: }
	pop	{r4}
	pop	{r0}
	bx	r0
.L36:
	.align	2
.L35:
	.word	WriteAndVerifySramFast
	.word	50337708
	.size	MSa_SaveDungeonState, .-MSa_SaveDungeonState
	.align	1
	.global	MSa_LoadDungeonState
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	MSa_LoadDungeonState, %function
MSa_LoadDungeonState:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}	@
@ CoreSupport/ExpandedModularSave/Src/MSaFuncs.c:60: void MSa_LoadDungeonState(void* source, unsigned size) {
	movs	r2, r1	@ size, tmp118
@ CoreSupport/ExpandedModularSave/Src/MSaFuncs.c:62: }
	@ sp needed	@
@ CoreSupport/ExpandedModularSave/Src/MSaFuncs.c:61: 	gpReadSramFast(source, (void*)(0x30017AC), size);
	ldr	r1, .L38	@,
	ldr	r3, .L38+4	@ tmp116,
	bl	.L4		@
@ CoreSupport/ExpandedModularSave/Src/MSaFuncs.c:62: }
	pop	{r4}
	pop	{r0}
	bx	r0
.L39:
	.align	2
.L38:
	.word	50337708
	.word	gpReadSramFast
	.size	MSa_LoadDungeonState, .-MSa_LoadDungeonState
	.ident	"GCC: (devkitARM release 56) 11.1.0"
	.code 16
	.align	1
.L4:
	bx	r3
