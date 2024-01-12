#ifndef GBAFE_SAVE_H
#define GBAFE_SAVE_H

#include "common.h"

struct SaveGlobalMetadata {
	/* 00 */ char magicString[8];
	/* 08 */ u32 magic1;
	/* 0C */ u16 magic2;
	/* 0E */ u8 gameCompletionBits;
	/* 0F */ u8 unk0F;
	/* 10 */ u32 unk10;
	/* 14 */ u8 completedPlaythroughIds[0x0C];
	/* 20 */ u8 unk20[0x20];
	/* 40 */ u8 knownCharacterBits[0x20];
	/* 60 */ u16 checksum;
	/* 62 */ u8 lastSaveSlot;
	/* 63 */ u8 lastSuspendSlot;
};

struct SaveBlockMetadata {
	/* 00 */ u32 magic1;
	/* 04 */ u16 magic2;
	/* 06 */ u8  type;
	/* 08 */ u16 offset;
	/* 0A */ u16 size;
	/* 0C */ u32 checksum;
};

enum {
	SAVE_BLOCK_SAVE1      = 0,
	SAVE_BLOCK_SAVE2      = 1,
	SAVE_BLOCK_SAVE3      = 2,
	SAVE_BLOCK_SUSPEND    = 3,
	SAVE_BLOCK_SUSPENDALT = 4,
	SAVE_BLOCK_LINKARENA  = 5,
	SAVE_BLOCK_UNK6       = 6,
};

enum {
	SAVE_TYPE_GAME      = 0,
	SAVE_TYPE_SUSPEND   = 1,
	SAVE_TYPE_LINKARENA = 2,
	SAVE_TYPE_BLOCK6    = 3,
};

enum {
	SBM_MAGIC1_GAME      = 0x40624,
	SBM_MAGIC1_LINKARENA = 0x20112,
	SBM_MAGIC1_SLOT6     = 0x20223,

	SBM_MAGIC2           = 0x200A,
};

void* GetSaveTargetAddress(int blockId);
void* GetSaveSourceAddress(int blockId);

int IsSramWorking(void);

void ClearSaveBlock(int blockId);

void SaveMetadata_Save(struct SaveBlockMetadata* sbm, int blockId);

void LoadGeneralGameMetadata(struct SaveGlobalMetadata* buf);
void SaveGeneralGameMetadata(struct SaveGlobalMetadata* buf);

void SGM_SetCharacterKnown(unsigned charId, struct SaveGlobalMetadata* sgm);

void UpdateLastUsedGameSaveSlot(int blockId);

#endif // GBAFE_SAVE_H
