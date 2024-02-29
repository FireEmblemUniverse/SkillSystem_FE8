#include "ModularSave.h"

void* MS_GetSaveAddressBySlot(unsigned slot) {
	if (slot > SAVE_ID_XMAP)
		return NULL;

	return (void*)(0xE000000) + gSaveBlockDecl[slot].offset;
}

const struct SaveChunkDecl* MS_FindGameSaveChunk(unsigned chunkId) {
	for (const struct SaveChunkDecl* chunk = gGameSaveChunks; chunk->offset != 0xFFFF; ++chunk)
		if (chunk->identifier == chunkId)
			return chunk;

	return NULL;
}

const struct SaveChunkDecl* MS_FindSuspendSaveChunk(unsigned chunkId) {
	for (const struct SaveChunkDecl* chunk = gSuspendSaveChunks; chunk->offset != 0xFFFF; ++chunk)
		if (chunk->identifier == chunkId)
			return chunk;

	return NULL;
}

void MS_LoadChapterStateFromGameSave(unsigned slot, struct PlaySt* target) {
	void* const source = GetSaveReadAddr(slot);
	const struct SaveChunkDecl* const chunk = MS_FindGameSaveChunk(gMS_ChapterStateChunkId);

	ReadSramFast(source + chunk->offset, target, chunk->size);
}

void MS_LoadChapterStateFromSuspendSave(unsigned slot, struct PlaySt* target) {
	void* const source = GetSaveReadAddr(slot);
	const struct SaveChunkDecl* const chunk = MS_FindSuspendSaveChunk(gMS_ChapterStateChunkId);

	ReadSramFast(source + chunk->offset, target, chunk->size);
}

u32 MS_GetClaimFlagsFromGameSave(unsigned slot) {
	u32 buf;

	void* const source = GetSaveReadAddr(slot);
	const struct SaveChunkDecl* const chunk = MS_FindGameSaveChunk(gMS_ClaimFlagsChunkId);

	ReadSramFast(source + chunk->offset, &buf, 4);

	return buf;
}

// TODO: use eventual proper WMData struct definition, or something
void MS_LoadWMDataFromGameSave(unsigned slot, void* target) {
	void* const source = GetSaveReadAddr(slot);
	const struct SaveChunkDecl* const chunk = MS_FindGameSaveChunk(gMS_WMDataChunkId);

	ReadWorldMapStuff(source + chunk->offset, target);
}

int MS_CheckEid8AFromGameSave(unsigned slot) {
	void* const source = GetSaveReadAddr(slot);
	const struct SaveChunkDecl* const chunk = MS_FindGameSaveChunk(gMS_PermanentEidsChunkId);

	// TODO: fix this mess
	ReadSramFast(source + chunk->offset, gGenericBuffer, chunk->size);
	return ((u8(*)(unsigned eid, void* buf))(0x08083D34+1))(0x8A, gGenericBuffer);
}

void MS_CopyGameSave(int sourceSlot, int targetSlot) {
	void* const source = GetSaveReadAddr(sourceSlot);
	void* const target = GetSaveWriteAddr(targetSlot);

	unsigned size = gSaveBlockTypeSizeLookup[SAVEBLOCK_KIND_GAME];

	ReadSramFast(source, gGenericBuffer, size);
	WriteAndVerifySramFast(gGenericBuffer, target, size);

	struct SaveBlockInfo sbm;

	sbm.magic32 = SAVEMAGIC32;
	sbm.kind    = SAVEBLOCK_KIND_GAME;

	WriteSaveBlockInfo(&sbm, targetSlot);
}

void MS_SaveGame(unsigned slot) {
	void* const base = GetSaveWriteAddr(slot);

	// Clear suspend
	InvalidateSuspendSave(SAVE_ID_SUSPEND);

	// Update save slot index
	gPlaySt.gameSaveSlot = slot;

	// Actual save!
	for (const struct SaveChunkDecl* chunk = gGameSaveChunks; chunk->offset != 0xFFFF; ++chunk)
		if (chunk->save)
			chunk->save(base + chunk->offset, chunk->size);

	// Setup block metadata

	struct SaveBlockInfo sbm;

	sbm.magic32 = SAVEMAGIC32;
	sbm.kind    = SAVEBLOCK_KIND_GAME;

	WriteSaveBlockInfo(&sbm, slot);

	// Update save slot in global metadata
	WriteLastGameSaveId(slot);
}

void MS_LoadGame(unsigned slot) {
	void* const base = GetSaveReadAddr(slot);

	if (!(gPlaySt.chapterStateBits & 0x40))
		// Clear suspend if not loading for link arena
		InvalidateSuspendSave(SAVE_ID_SUSPEND);

	// Actual load!
	for (const struct SaveChunkDecl* chunk = gGameSaveChunks; chunk->offset != 0xFFFF; ++chunk)
		if (chunk->load)
			chunk->load(base + chunk->offset, chunk->size);

	// Update save slot in global metadata
	WriteLastGameSaveId(slot);
}

void MS_SaveSuspend(unsigned slot) {
	if (gPlaySt.chapterStateBits & 8)
		return;

	if (!IsSramWorking())
		return;

	void* const base = GetSaveWriteAddr(slot);

	// Actual save!
	for (const struct SaveChunkDecl* chunk = gSuspendSaveChunks; chunk->offset != 0xFFFF; ++chunk)
		if (chunk->save)
			chunk->save(base + chunk->offset, chunk->size);

	// Setup block metadata

	struct SaveBlockInfo sbm;

	sbm.magic32 = SAVEMAGIC32;
	sbm.kind    = SAVEBLOCK_KIND_SUSPEND;

	WriteSaveBlockInfo(&sbm, slot);

	gBmSt.just_resumed = FALSE;
}

void MS_LoadSuspend(unsigned slot) {
	void* const base = GetSaveReadAddr(slot);

	for (const struct SaveChunkDecl* chunk = gSuspendSaveChunks; chunk->offset != 0xFFFF; ++chunk)
		if (chunk->load)
			chunk->load(base + chunk->offset, chunk->size);
}
