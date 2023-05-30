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
	.file	"MSCore.c"
@ GNU C17 (devkitARM release 56) version 11.1.0 (arm-none-eabi)
@	compiled by GNU C version 10.3.0, GMP version 6.2.1, MPFR version 4.1.0, MPC version 1.2.1, isl version isl-0.18-GMP

@ GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
@ options passed: -mcpu=arm7tdmi -mthumb -mthumb-interwork -mtune=arm7tdmi -mlong-calls -march=armv4t -Os -ffreestanding
	.text
	.align	1
	.global	MS_GetSaveAddressBySlot
	.arch armv4t
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	MS_GetSaveAddressBySlot, %function
MS_GetSaveAddressBySlot:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:3: void* MS_GetSaveAddressBySlot(unsigned slot) {
	movs	r3, r0	@ slot, tmp121
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:5: 		return NULL;
	movs	r0, #0	@ <retval>,
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:4: 	if (slot > SAVE_BLOCK_UNK6)
	cmp	r3, #6	@ slot,
	bhi	.L1		@,
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:7: 	return (void*)(0xE000000) + gSaveBlockDecl[slot].offset;
	ldr	r2, .L4	@ tmp117,
	lsls	r3, r3, #2	@ tmp118, slot,
	ldrh	r0, [r3, r2]	@ tmp119, gSaveBlockDecl
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:7: 	return (void*)(0xE000000) + gSaveBlockDecl[slot].offset;
	movs	r3, #224	@ tmp124,
	lsls	r3, r3, #20	@ tmp124, tmp124,
	adds	r0, r0, r3	@ <retval>, tmp119, tmp124
.L1:
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:8: }
	@ sp needed	@
	bx	lr
.L5:
	.align	2
.L4:
	.word	gSaveBlockDecl
	.size	MS_GetSaveAddressBySlot, .-MS_GetSaveAddressBySlot
	.align	1
	.global	MS_FindGameSaveChunk
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	MS_FindGameSaveChunk, %function
MS_FindGameSaveChunk:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:10: const struct SaveChunkDecl* MS_FindGameSaveChunk(unsigned chunkId) {
	movs	r3, r0	@ chunkId, tmp122
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:11: 	for (const struct SaveChunkDecl* chunk = gGameSaveChunks; chunk->offset != 0xFFFF; ++chunk)
	ldr	r2, .L10	@ tmp120,
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:11: 	for (const struct SaveChunkDecl* chunk = gGameSaveChunks; chunk->offset != 0xFFFF; ++chunk)
	ldr	r0, .L10+4	@ <retval>,
.L7:
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:11: 	for (const struct SaveChunkDecl* chunk = gGameSaveChunks; chunk->offset != 0xFFFF; ++chunk)
	ldrh	r1, [r0]	@ MEM[(short unsigned int *)chunk_4], MEM[(short unsigned int *)chunk_4]
	cmp	r1, r2	@ MEM[(short unsigned int *)chunk_4], tmp120
	bne	.L9		@,
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:15: 	return NULL;
	movs	r0, #0	@ <retval>,
.L6:
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:16: }
	@ sp needed	@
	bx	lr
.L9:
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:12: 		if (chunk->identifier == chunkId)
	ldrh	r1, [r0, #12]	@ MEM[(short unsigned int *)chunk_4 + 12B], MEM[(short unsigned int *)chunk_4 + 12B]
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:12: 		if (chunk->identifier == chunkId)
	cmp	r1, r3	@ MEM[(short unsigned int *)chunk_4 + 12B], chunkId
	beq	.L6		@,
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:11: 	for (const struct SaveChunkDecl* chunk = gGameSaveChunks; chunk->offset != 0xFFFF; ++chunk)
	adds	r0, r0, #16	@ <retval>,
	b	.L7		@
.L11:
	.align	2
.L10:
	.word	65535
	.word	gGameSaveChunks
	.size	MS_FindGameSaveChunk, .-MS_FindGameSaveChunk
	.align	1
	.global	MS_FindSuspendSaveChunk
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	MS_FindSuspendSaveChunk, %function
MS_FindSuspendSaveChunk:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:18: const struct SaveChunkDecl* MS_FindSuspendSaveChunk(unsigned chunkId) {
	movs	r3, r0	@ chunkId, tmp122
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:19: 	for (const struct SaveChunkDecl* chunk = gSuspendSaveChunks; chunk->offset != 0xFFFF; ++chunk)
	ldr	r2, .L16	@ tmp120,
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:19: 	for (const struct SaveChunkDecl* chunk = gSuspendSaveChunks; chunk->offset != 0xFFFF; ++chunk)
	ldr	r0, .L16+4	@ <retval>,
.L13:
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:19: 	for (const struct SaveChunkDecl* chunk = gSuspendSaveChunks; chunk->offset != 0xFFFF; ++chunk)
	ldrh	r1, [r0]	@ MEM[(short unsigned int *)chunk_4], MEM[(short unsigned int *)chunk_4]
	cmp	r1, r2	@ MEM[(short unsigned int *)chunk_4], tmp120
	bne	.L15		@,
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:23: 	return NULL;
	movs	r0, #0	@ <retval>,
.L12:
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:24: }
	@ sp needed	@
	bx	lr
.L15:
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:20: 		if (chunk->identifier == chunkId)
	ldrh	r1, [r0, #12]	@ MEM[(short unsigned int *)chunk_4 + 12B], MEM[(short unsigned int *)chunk_4 + 12B]
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:20: 		if (chunk->identifier == chunkId)
	cmp	r1, r3	@ MEM[(short unsigned int *)chunk_4 + 12B], chunkId
	beq	.L12		@,
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:19: 	for (const struct SaveChunkDecl* chunk = gSuspendSaveChunks; chunk->offset != 0xFFFF; ++chunk)
	adds	r0, r0, #16	@ <retval>,
	b	.L13		@
.L17:
	.align	2
.L16:
	.word	65535
	.word	gSuspendSaveChunks
	.size	MS_FindSuspendSaveChunk, .-MS_FindSuspendSaveChunk
	.align	1
	.global	MS_LoadChapterStateFromGameSave
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	MS_LoadChapterStateFromGameSave, %function
MS_LoadChapterStateFromGameSave:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:27: 	void* const source = GetSaveSourceAddress(slot);
	ldr	r3, .L19	@ tmp125,
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:31: }
	@ sp needed	@
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:26: void MS_LoadChapterStateFromGameSave(unsigned slot, struct ChapterState* target) {
	movs	r5, r1	@ target, tmp133
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:27: 	void* const source = GetSaveSourceAddress(slot);
	bl	.L21		@
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:28: 	const struct SaveChunkDecl* const chunk = MS_FindGameSaveChunk(gMS_ChapterStateChunkId);
	ldr	r3, .L19+4	@ tmp126,
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:27: 	void* const source = GetSaveSourceAddress(slot);
	movs	r4, r0	@ source, tmp134
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:28: 	const struct SaveChunkDecl* const chunk = MS_FindGameSaveChunk(gMS_ChapterStateChunkId);
	ldrb	r0, [r3]	@ gMS_ChapterStateChunkId, gMS_ChapterStateChunkId
	bl	MS_FindGameSaveChunk		@
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:30: 	gpReadSramFast(source + chunk->offset, target, chunk->size);
	ldrh	r2, [r0, #2]	@ tmp128,
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:30: 	gpReadSramFast(source + chunk->offset, target, chunk->size);
	ldrh	r0, [r0]	@ *chunk_13, *chunk_13
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:30: 	gpReadSramFast(source + chunk->offset, target, chunk->size);
	movs	r1, r5	@, target
	ldr	r3, .L19+8	@ tmp131,
	adds	r0, r4, r0	@ tmp130, source, *chunk_13
	bl	.L21		@
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:31: }
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L20:
	.align	2
.L19:
	.word	GetSaveSourceAddress
	.word	gMS_ChapterStateChunkId
	.word	gpReadSramFast
	.size	MS_LoadChapterStateFromGameSave, .-MS_LoadChapterStateFromGameSave
	.align	1
	.global	MS_LoadChapterStateFromSuspendSave
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	MS_LoadChapterStateFromSuspendSave, %function
MS_LoadChapterStateFromSuspendSave:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:34: 	void* const source = GetSaveSourceAddress(slot);
	ldr	r3, .L23	@ tmp125,
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:38: }
	@ sp needed	@
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:33: void MS_LoadChapterStateFromSuspendSave(unsigned slot, struct ChapterState* target) {
	movs	r5, r1	@ target, tmp133
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:34: 	void* const source = GetSaveSourceAddress(slot);
	bl	.L21		@
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:35: 	const struct SaveChunkDecl* const chunk = MS_FindSuspendSaveChunk(gMS_ChapterStateChunkId);
	ldr	r3, .L23+4	@ tmp126,
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:34: 	void* const source = GetSaveSourceAddress(slot);
	movs	r4, r0	@ source, tmp134
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:35: 	const struct SaveChunkDecl* const chunk = MS_FindSuspendSaveChunk(gMS_ChapterStateChunkId);
	ldrb	r0, [r3]	@ gMS_ChapterStateChunkId, gMS_ChapterStateChunkId
	bl	MS_FindSuspendSaveChunk		@
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:37: 	gpReadSramFast(source + chunk->offset, target, chunk->size);
	ldrh	r2, [r0, #2]	@ tmp128,
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:37: 	gpReadSramFast(source + chunk->offset, target, chunk->size);
	ldrh	r0, [r0]	@ *chunk_13, *chunk_13
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:37: 	gpReadSramFast(source + chunk->offset, target, chunk->size);
	movs	r1, r5	@, target
	ldr	r3, .L23+8	@ tmp131,
	adds	r0, r4, r0	@ tmp130, source, *chunk_13
	bl	.L21		@
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:38: }
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L24:
	.align	2
.L23:
	.word	GetSaveSourceAddress
	.word	gMS_ChapterStateChunkId
	.word	gpReadSramFast
	.size	MS_LoadChapterStateFromSuspendSave, .-MS_LoadChapterStateFromSuspendSave
	.align	1
	.global	MS_GetClaimFlagsFromGameSave
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	MS_GetClaimFlagsFromGameSave, %function
MS_GetClaimFlagsFromGameSave:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r0, r1, r4, lr}	@
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:43: 	void* const source = GetSaveSourceAddress(slot);
	ldr	r3, .L26	@ tmp123,
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:49: }
	@ sp needed	@
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:43: 	void* const source = GetSaveSourceAddress(slot);
	bl	.L21		@
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:44: 	const struct SaveChunkDecl* const chunk = MS_FindGameSaveChunk(gMS_ClaimFlagsChunkId);
	ldr	r3, .L26+4	@ tmp124,
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:43: 	void* const source = GetSaveSourceAddress(slot);
	movs	r4, r0	@ source, tmp132
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:44: 	const struct SaveChunkDecl* const chunk = MS_FindGameSaveChunk(gMS_ClaimFlagsChunkId);
	ldrb	r0, [r3]	@ gMS_ClaimFlagsChunkId, gMS_ClaimFlagsChunkId
	bl	MS_FindGameSaveChunk		@
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:46: 	gpReadSramFast(source + chunk->offset, &buf, 4);
	ldrh	r0, [r0]	@ *chunk_11, *chunk_11
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:46: 	gpReadSramFast(source + chunk->offset, &buf, 4);
	movs	r2, #4	@,
	ldr	r3, .L26+8	@ tmp129,
	adds	r0, r4, r0	@ tmp128, source, *chunk_11
	add	r1, sp, #4	@,,
	bl	.L21		@
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:48: 	return buf;
	ldr	r0, [sp, #4]	@ <retval>, buf
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:49: }
	pop	{r1, r2, r4}
	pop	{r1}
	bx	r1
.L27:
	.align	2
.L26:
	.word	GetSaveSourceAddress
	.word	gMS_ClaimFlagsChunkId
	.word	gpReadSramFast
	.size	MS_GetClaimFlagsFromGameSave, .-MS_GetClaimFlagsFromGameSave
	.align	1
	.global	MS_LoadWMDataFromGameSave
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	MS_LoadWMDataFromGameSave, %function
MS_LoadWMDataFromGameSave:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:53: 	void* const source = GetSaveSourceAddress(slot);
	ldr	r3, .L29	@ tmp123,
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:57: }
	@ sp needed	@
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:52: void MS_LoadWMDataFromGameSave(unsigned slot, void* target) {
	movs	r5, r1	@ target, tmp130
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:53: 	void* const source = GetSaveSourceAddress(slot);
	bl	.L21		@
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:54: 	const struct SaveChunkDecl* const chunk = MS_FindGameSaveChunk(gMS_WMDataChunkId);
	ldr	r3, .L29+4	@ tmp124,
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:53: 	void* const source = GetSaveSourceAddress(slot);
	movs	r4, r0	@ source, tmp131
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:54: 	const struct SaveChunkDecl* const chunk = MS_FindGameSaveChunk(gMS_WMDataChunkId);
	ldrb	r0, [r3]	@ gMS_WMDataChunkId, gMS_WMDataChunkId
	bl	MS_FindGameSaveChunk		@
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:56: 	LoadWMStuff(source + chunk->offset, target);
	ldrh	r0, [r0]	@ *chunk_11, *chunk_11
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:56: 	LoadWMStuff(source + chunk->offset, target);
	movs	r1, r5	@, target
	ldr	r3, .L29+8	@ tmp128,
	adds	r0, r4, r0	@ tmp127, source, *chunk_11
	bl	.L21		@
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:57: }
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L30:
	.align	2
.L29:
	.word	GetSaveSourceAddress
	.word	gMS_WMDataChunkId
	.word	LoadWMStuff
	.size	MS_LoadWMDataFromGameSave, .-MS_LoadWMDataFromGameSave
	.align	1
	.global	MS_CheckEid8AFromGameSave
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	MS_CheckEid8AFromGameSave, %function
MS_CheckEid8AFromGameSave:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:60: 	void* const source = GetSaveSourceAddress(slot);
	ldr	r3, .L32	@ tmp126,
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:66: }
	@ sp needed	@
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:60: 	void* const source = GetSaveSourceAddress(slot);
	bl	.L21		@
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:61: 	const struct SaveChunkDecl* const chunk = MS_FindGameSaveChunk(gMS_PermanentEidsChunkId);
	ldr	r3, .L32+4	@ tmp127,
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:60: 	void* const source = GetSaveSourceAddress(slot);
	movs	r4, r0	@ source, tmp140
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:61: 	const struct SaveChunkDecl* const chunk = MS_FindGameSaveChunk(gMS_PermanentEidsChunkId);
	ldrb	r0, [r3]	@ gMS_PermanentEidsChunkId, gMS_PermanentEidsChunkId
	bl	MS_FindGameSaveChunk		@
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:64: 	gpReadSramFast(source + chunk->offset, gGenericBuffer, chunk->size);
	ldr	r5, .L32+8	@ tmp130,
	ldrh	r2, [r0, #2]	@ tmp129,
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:64: 	gpReadSramFast(source + chunk->offset, gGenericBuffer, chunk->size);
	ldrh	r0, [r0]	@ *chunk_14, *chunk_14
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:64: 	gpReadSramFast(source + chunk->offset, gGenericBuffer, chunk->size);
	movs	r1, r5	@, tmp130
	ldr	r3, .L32+12	@ tmp133,
	adds	r0, r4, r0	@ tmp132, source, *chunk_14
	bl	.L21		@
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:65: 	return ((u8(*)(unsigned eid, void* buf))(0x08083D34+1))(0x8A, gGenericBuffer);
	movs	r1, r5	@, tmp130
	ldr	r3, .L32+16	@ tmp135,
	movs	r0, #138	@,
	bl	.L21		@
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:66: }
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
.L33:
	.align	2
.L32:
	.word	GetSaveSourceAddress
	.word	gMS_PermanentEidsChunkId
	.word	gGenericBuffer
	.word	gpReadSramFast
	.word	134757685
	.size	MS_CheckEid8AFromGameSave, .-MS_CheckEid8AFromGameSave
	.align	1
	.global	MS_CopyGameSave
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	MS_CopyGameSave, %function
MS_CopyGameSave:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}	@
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:69: 	void* const source = GetSaveSourceAddress(sourceSlot);
	ldr	r3, .L35	@ tmp119,
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:68: void MS_CopyGameSave(int sourceSlot, int targetSlot) {
	sub	sp, sp, #28	@,,
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:68: void MS_CopyGameSave(int sourceSlot, int targetSlot) {
	movs	r4, r1	@ targetSlot, tmp134
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:69: 	void* const source = GetSaveSourceAddress(sourceSlot);
	bl	.L21		@
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:70: 	void* const target = GetSaveTargetAddress(targetSlot);
	ldr	r3, .L35+4	@ tmp120,
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:69: 	void* const source = GetSaveSourceAddress(sourceSlot);
	movs	r6, r0	@ source, tmp135
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:70: 	void* const target = GetSaveTargetAddress(targetSlot);
	movs	r0, r4	@, targetSlot
	bl	.L21		@
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:72: 	unsigned size = gSaveBlockTypeSizeLookup[SAVE_TYPE_GAME];
	ldr	r3, .L35+8	@ tmp121,
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:74: 	gpReadSramFast(source, gGenericBuffer, size);
	ldr	r5, .L35+12	@ tmp122,
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:72: 	unsigned size = gSaveBlockTypeSizeLookup[SAVE_TYPE_GAME];
	ldrh	r7, [r3]	@ size, gSaveBlockTypeSizeLookup
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:74: 	gpReadSramFast(source, gGenericBuffer, size);
	movs	r1, r5	@, tmp122
	movs	r2, r7	@, size
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:70: 	void* const target = GetSaveTargetAddress(targetSlot);
	str	r0, [sp, #4]	@ tmp136, %sfp
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:74: 	gpReadSramFast(source, gGenericBuffer, size);
	ldr	r3, .L35+16	@ tmp123,
	movs	r0, r6	@, source
	bl	.L21		@
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:75: 	WriteAndVerifySramFast(gGenericBuffer, target, size);
	movs	r2, r7	@, size
	ldr	r1, [sp, #4]	@, %sfp
	movs	r0, r5	@, tmp122
	ldr	r3, .L35+20	@ tmp125,
	bl	.L21		@
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:79: 	sbm.magic1 = SBM_MAGIC1_GAME;
	ldr	r3, .L35+24	@ tmp127,
	str	r3, [sp, #8]	@ tmp127, sbm.magic1
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:80: 	sbm.type   = SAVE_TYPE_GAME;
	movs	r3, #0	@ tmp129,
	add	r2, sp, #8	@ tmp139,,
	strb	r3, [r2, #6]	@ tmp129, sbm.type
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:82: 	SaveMetadata_Save(&sbm, targetSlot);
	movs	r1, r4	@, targetSlot
	movs	r0, r2	@, tmp139
	ldr	r3, .L35+28	@ tmp132,
	bl	.L21		@
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:83: }
	add	sp, sp, #28	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L36:
	.align	2
.L35:
	.word	GetSaveSourceAddress
	.word	GetSaveTargetAddress
	.word	gSaveBlockTypeSizeLookup
	.word	gGenericBuffer
	.word	gpReadSramFast
	.word	WriteAndVerifySramFast
	.word	263716
	.word	SaveMetadata_Save
	.size	MS_CopyGameSave, .-MS_CopyGameSave
	.align	1
	.global	MS_SaveGame
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	MS_SaveGame, %function
MS_SaveGame:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r0, r1, r2, r3, r4, r5, r6, lr}	@
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:86: 	void* const base = GetSaveTargetAddress(slot);
	ldr	r3, .L44	@ tmp124,
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:85: void MS_SaveGame(unsigned slot) {
	movs	r4, r0	@ slot.10_1, tmp139
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:86: 	void* const base = GetSaveTargetAddress(slot);
	bl	.L21		@
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:89: 	ClearSaveBlock(SAVE_BLOCK_SUSPEND);
	ldr	r3, .L44+4	@ tmp125,
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:86: 	void* const base = GetSaveTargetAddress(slot);
	movs	r6, r0	@ base, tmp140
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:89: 	ClearSaveBlock(SAVE_BLOCK_SUSPEND);
	movs	r0, #3	@,
	bl	.L21		@
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:92: 	gChapterData.saveSlotIndex = slot;
	ldr	r3, .L44+8	@ tmp126,
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:95: 	for (const struct SaveChunkDecl* chunk = gGameSaveChunks; chunk->offset != 0xFFFF; ++chunk)
	ldr	r5, .L44+12	@ chunk,
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:92: 	gChapterData.saveSlotIndex = slot;
	strb	r4, [r3, #12]	@ slot.10_1, gChapterData.saveSlotIndex
.L38:
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:95: 	for (const struct SaveChunkDecl* chunk = gGameSaveChunks; chunk->offset != 0xFFFF; ++chunk)
	ldrh	r0, [r5]	@ _8, MEM[(short unsigned int *)chunk_9]
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:95: 	for (const struct SaveChunkDecl* chunk = gGameSaveChunks; chunk->offset != 0xFFFF; ++chunk)
	ldr	r3, .L44+16	@ tmp130,
	cmp	r0, r3	@ _8, tmp130
	bne	.L40		@,
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:110: }
	@ sp needed	@
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:103: 	sbm.magic1 = SBM_MAGIC1_GAME;
	ldr	r3, .L44+20	@ tmp132,
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:104: 	sbm.type   = SAVE_TYPE_GAME;
	mov	r2, sp	@ tmp142,
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:103: 	sbm.magic1 = SBM_MAGIC1_GAME;
	str	r3, [sp]	@ tmp132, sbm.magic1
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:104: 	sbm.type   = SAVE_TYPE_GAME;
	movs	r3, #0	@ tmp134,
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:106: 	SaveMetadata_Save(&sbm, slot);
	movs	r1, r4	@, slot.10_1
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:104: 	sbm.type   = SAVE_TYPE_GAME;
	strb	r3, [r2, #6]	@ tmp134, sbm.type
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:106: 	SaveMetadata_Save(&sbm, slot);
	mov	r0, sp	@,
	ldr	r3, .L44+24	@ tmp137,
	bl	.L21		@
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:109: 	UpdateLastUsedGameSaveSlot(slot);
	movs	r0, r4	@, slot.10_1
	ldr	r3, .L44+28	@ tmp138,
	bl	.L21		@
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:110: }
	pop	{r0, r1, r2, r3, r4, r5, r6}
	pop	{r0}
	bx	r0
.L40:
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:96: 		if (chunk->save)
	ldr	r3, [r5, #4]	@ _3, MEM[(void (*<T5d9>) (void *, unsigned int) *)chunk_9 + 4B]
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:96: 		if (chunk->save)
	cmp	r3, #0	@ _3,
	beq	.L39		@,
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:97: 			chunk->save(base + chunk->offset, chunk->size);
	ldrh	r1, [r5, #2]	@ MEM[(short unsigned int *)chunk_9 + 2B], MEM[(short unsigned int *)chunk_9 + 2B]
	adds	r0, r6, r0	@ tmp129, base, _8
	bl	.L21		@
.L39:
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:95: 	for (const struct SaveChunkDecl* chunk = gGameSaveChunks; chunk->offset != 0xFFFF; ++chunk)
	adds	r5, r5, #16	@ chunk,
	b	.L38		@
.L45:
	.align	2
.L44:
	.word	GetSaveTargetAddress
	.word	ClearSaveBlock
	.word	gChapterData
	.word	gGameSaveChunks
	.word	65535
	.word	263716
	.word	SaveMetadata_Save
	.word	UpdateLastUsedGameSaveSlot
	.size	MS_SaveGame, .-MS_SaveGame
	.align	1
	.global	MS_LoadGame
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	MS_LoadGame, %function
MS_LoadGame:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:113: 	void* const base = GetSaveSourceAddress(slot);
	ldr	r3, .L55	@ tmp125,
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:112: void MS_LoadGame(unsigned slot) {
	movs	r5, r0	@ slot.13_1, tmp139
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:113: 	void* const base = GetSaveSourceAddress(slot);
	bl	.L21		@
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:115: 	if (!(gChapterData.chapterStateBits & 0x40))
	ldr	r3, .L55+4	@ tmp126,
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:115: 	if (!(gChapterData.chapterStateBits & 0x40))
	ldrb	r3, [r3, #20]	@ tmp128,
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:113: 	void* const base = GetSaveSourceAddress(slot);
	movs	r6, r0	@ base, tmp140
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:115: 	if (!(gChapterData.chapterStateBits & 0x40))
	lsls	r3, r3, #25	@ tmp141, tmp128,
	bmi	.L47		@,
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:117: 		ClearSaveBlock(SAVE_BLOCK_SUSPEND);
	movs	r0, #3	@,
	ldr	r3, .L55+8	@ tmp134,
	bl	.L21		@
.L47:
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:112: void MS_LoadGame(unsigned slot) {
	ldr	r4, .L55+12	@ chunk,
.L48:
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:120: 	for (const struct SaveChunkDecl* chunk = gGameSaveChunks; chunk->offset != 0xFFFF; ++chunk)
	ldrh	r0, [r4]	@ _8, MEM[(short unsigned int *)chunk_10]
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:120: 	for (const struct SaveChunkDecl* chunk = gGameSaveChunks; chunk->offset != 0xFFFF; ++chunk)
	ldr	r3, .L55+16	@ tmp137,
	cmp	r0, r3	@ _8, tmp137
	bne	.L50		@,
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:126: }
	@ sp needed	@
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:125: 	UpdateLastUsedGameSaveSlot(slot);
	movs	r0, r5	@, slot.13_1
	ldr	r3, .L55+20	@ tmp138,
	bl	.L21		@
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:126: }
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L50:
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:121: 		if (chunk->load)
	ldr	r3, [r4, #8]	@ _3, MEM[(void (*<T5d9>) (void *, unsigned int) *)chunk_10 + 8B]
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:121: 		if (chunk->load)
	cmp	r3, #0	@ _3,
	beq	.L49		@,
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:122: 			chunk->load(base + chunk->offset, chunk->size);
	ldrh	r1, [r4, #2]	@ MEM[(short unsigned int *)chunk_10 + 2B], MEM[(short unsigned int *)chunk_10 + 2B]
	adds	r0, r6, r0	@ tmp136, base, _8
	bl	.L21		@
.L49:
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:120: 	for (const struct SaveChunkDecl* chunk = gGameSaveChunks; chunk->offset != 0xFFFF; ++chunk)
	adds	r4, r4, #16	@ chunk,
	b	.L48		@
.L56:
	.align	2
.L55:
	.word	GetSaveSourceAddress
	.word	gChapterData
	.word	ClearSaveBlock
	.word	gGameSaveChunks
	.word	65535
	.word	UpdateLastUsedGameSaveSlot
	.size	MS_LoadGame, .-MS_LoadGame
	.align	1
	.global	MS_SaveSuspend
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	MS_SaveSuspend, %function
MS_SaveSuspend:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r0, r1, r2, r3, r4, r5, r6, lr}	@
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:129: 	if (gChapterData.chapterStateBits & 8)
	ldr	r3, .L70	@ tmp126,
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:129: 	if (gChapterData.chapterStateBits & 8)
	ldrb	r3, [r3, #20]	@ tmp128,
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:128: void MS_SaveSuspend(unsigned slot) {
	movs	r5, r0	@ slot, tmp146
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:129: 	if (gChapterData.chapterStateBits & 8)
	lsls	r3, r3, #28	@ tmp149, tmp128,
	bmi	.L57		@,
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:132: 	if (!IsSramWorking())
	ldr	r3, .L70+4	@ tmp134,
	bl	.L21		@
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:132: 	if (!IsSramWorking())
	cmp	r0, #0	@ tmp147,
	beq	.L57		@,
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:135: 	void* const base = GetSaveTargetAddress(slot);
	movs	r0, r5	@, slot
	ldr	r3, .L70+8	@ tmp135,
	bl	.L21		@
	movs	r6, r0	@ base, tmp148
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:138: 	for (const struct SaveChunkDecl* chunk = gSuspendSaveChunks; chunk->offset != 0xFFFF; ++chunk)
	ldr	r4, .L70+12	@ chunk,
.L59:
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:138: 	for (const struct SaveChunkDecl* chunk = gSuspendSaveChunks; chunk->offset != 0xFFFF; ++chunk)
	ldrh	r0, [r4]	@ _9, MEM[(short unsigned int *)chunk_10]
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:138: 	for (const struct SaveChunkDecl* chunk = gSuspendSaveChunks; chunk->offset != 0xFFFF; ++chunk)
	ldr	r3, .L70+16	@ tmp138,
	cmp	r0, r3	@ _9, tmp138
	bne	.L61		@,
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:146: 	sbm.magic1 = SBM_MAGIC1_GAME;
	ldr	r3, .L70+20	@ tmp140,
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:147: 	sbm.type   = SAVE_TYPE_SUSPEND;
	mov	r2, sp	@ tmp151,
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:146: 	sbm.magic1 = SBM_MAGIC1_GAME;
	str	r3, [sp]	@ tmp140, sbm.magic1
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:147: 	sbm.type   = SAVE_TYPE_SUSPEND;
	movs	r3, #1	@ tmp142,
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:149: 	SaveMetadata_Save(&sbm, slot);
	movs	r1, r5	@, slot
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:147: 	sbm.type   = SAVE_TYPE_SUSPEND;
	strb	r3, [r2, #6]	@ tmp142, sbm.type
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:149: 	SaveMetadata_Save(&sbm, slot);
	mov	r0, sp	@,
	ldr	r3, .L70+24	@ tmp145,
	bl	.L21		@
.L57:
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:150: }
	@ sp needed	@
	pop	{r0, r1, r2, r3, r4, r5, r6}
	pop	{r0}
	bx	r0
.L61:
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:139: 		if (chunk->save)
	ldr	r3, [r4, #4]	@ _4, MEM[(void (*<T5d9>) (void *, unsigned int) *)chunk_10 + 4B]
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:139: 		if (chunk->save)
	cmp	r3, #0	@ _4,
	beq	.L60		@,
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:140: 			chunk->save(base + chunk->offset, chunk->size);
	ldrh	r1, [r4, #2]	@ MEM[(short unsigned int *)chunk_10 + 2B], MEM[(short unsigned int *)chunk_10 + 2B]
	adds	r0, r6, r0	@ tmp137, base, _9
	bl	.L21		@
.L60:
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:138: 	for (const struct SaveChunkDecl* chunk = gSuspendSaveChunks; chunk->offset != 0xFFFF; ++chunk)
	adds	r4, r4, #16	@ chunk,
	b	.L59		@
.L71:
	.align	2
.L70:
	.word	gChapterData
	.word	IsSramWorking
	.word	GetSaveTargetAddress
	.word	gSuspendSaveChunks
	.word	65535
	.word	263716
	.word	SaveMetadata_Save
	.size	MS_SaveSuspend, .-MS_SaveSuspend
	.align	1
	.global	MS_LoadSuspend
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	MS_LoadSuspend, %function
MS_LoadSuspend:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}	@
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:153: 	void* const base = GetSaveSourceAddress(slot);
	ldr	r3, .L79	@ tmp123,
	bl	.L21		@
	movs	r5, r0	@ base, tmp128
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:155: 	for (const struct SaveChunkDecl* chunk = gSuspendSaveChunks; chunk->offset != 0xFFFF; ++chunk)
	ldr	r4, .L79+4	@ chunk,
.L73:
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:155: 	for (const struct SaveChunkDecl* chunk = gSuspendSaveChunks; chunk->offset != 0xFFFF; ++chunk)
	ldrh	r0, [r4]	@ _7, MEM[(short unsigned int *)chunk_8]
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:155: 	for (const struct SaveChunkDecl* chunk = gSuspendSaveChunks; chunk->offset != 0xFFFF; ++chunk)
	ldr	r3, .L79+8	@ tmp126,
	cmp	r0, r3	@ _7, tmp126
	bne	.L75		@,
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:158: }
	@ sp needed	@
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L75:
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:156: 		if (chunk->load)
	ldr	r3, [r4, #8]	@ _2, MEM[(void (*<T5d9>) (void *, unsigned int) *)chunk_8 + 8B]
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:156: 		if (chunk->load)
	cmp	r3, #0	@ _2,
	beq	.L74		@,
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:157: 			chunk->load(base + chunk->offset, chunk->size);
	ldrh	r1, [r4, #2]	@ MEM[(short unsigned int *)chunk_8 + 2B], MEM[(short unsigned int *)chunk_8 + 2B]
	adds	r0, r5, r0	@ tmp125, base, _7
	bl	.L21		@
.L74:
@ CoreSupport/ExpandedModularSave/Src/MSCore.c:155: 	for (const struct SaveChunkDecl* chunk = gSuspendSaveChunks; chunk->offset != 0xFFFF; ++chunk)
	adds	r4, r4, #16	@ chunk,
	b	.L73		@
.L80:
	.align	2
.L79:
	.word	GetSaveSourceAddress
	.word	gSuspendSaveChunks
	.word	65535
	.size	MS_LoadSuspend, .-MS_LoadSuspend
	.ident	"GCC: (devkitARM release 56) 11.1.0"
	.code 16
	.align	1
.L21:
	bx	r3
