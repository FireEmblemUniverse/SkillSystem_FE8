#ifndef GBAFE_CHAPTERDATA_H
#define GBAFE_CHAPTERDATA_H

#include "common.h"

typedef struct ChapterState ChapterState;

struct ROMChapterData {
	/* 00 */ const char* internalName;

	/* 04 */ u8  mapObj1Id;
	/* 05 */ u8  mapObj2Id;
	/* 06 */ u8  mapPaletteId;
	/* 07 */ u8  mapTileConfigId;
	/* 08 */ u8  mapMainLayerId;
	/* 09 */ u8  mapTileAnim1Id;
	/* 0A */ u8  mapTileAnim2Id;
	/* 0B */ u8  mapChangeLayerId;

	/* 0C */ u8  initialFogLevel;
	/* 0D */ u8  _unk0D;

	/* 0E */ u8 _unk10[0x12 - 0x0E];

	/* 12 */ u8 initialWeather;
	/* 13 */ u8 battleTileSet;

	// This may need a type change.
	/* 14 */ u16 easyModeLevelMalus      : 4;
	/* 14 */ u16 normalModeLevelMalus    : 4;
	/* 14 */ u16 difficultModeLevelBonus : 4;

	// 0 for blue phase, 1 for red phase, 2 for green phase, 3-5 unknown/maybe unused
	// 6 for blue/green alt, 7 for red alt
	/* 16 */ u16 mapSongIndices[8];

	/* 26 */ u8 _unk26[0x2C - 0x26];

	/* 2C */ u8 mapCrackedWallHeath;

	/* 2D */ u8 _unk2D[0x70 - 0x2D];
	/* 70 */ u32 unk70;

	/* 74 */ u8 mapEventDataId;
	/* 75 */ u8 gmapEventId;

	/* 76 */ u8 _unk76[0x80 - 0x76];

	/* 80 */ u8 prepScreenNumber;

	/* 81 */ u8 _unk81[0x86 - 0x81];

	/* 86 */ u8 victorySongEnemyThreshold;
	/* 87 */ u8 boolFadeToBlack;

	/* 88 */ u16 statusObjectiveTextId;
	/* 8A */ u16 goalWindowTextId;
	/* 8C */ u8 goalWindowDataType;
	/* 8D */ u8 goalWindowEndTurnNumber;
	/* 8E */ u8 protectCharacterIndex;

	/* 8F */ u8 xMarkedTile;
	/* 90 */ u8 yMarkedTile;

	/* 91 */ u8 _unk91[0x94 - 0x91];
};

struct ChapterState {
	/* 00 */ u32 _u00;
	/* 04 */ u32 _u04;
	/* 08 */ u32 goldAmount;
	/* 0C */ u8 saveSlotIndex;
	/* 0D */ u8 visionRange;
	/* 0E */ u8 chapterIndex;
	/* 0F */ u8 currentPhase;
	/* 10 */ u16 turnNumber;
	/* 12 */ u8 xCursorSaved;
	/* 13 */ u8 yCursorSaved;
	/* 14 */ u8 chapterStateBits;
	/* 15 */ u8 weather;
	/* 16 */ u16 supportGainTotal;
	/* 18 */ u8 playthroughId;
	/* 19 */ u8 _u19;
	/* 1A */ u8 lastUnitListSortType;
	/* 1B */ u8 mode;
	/* 1C */ u8 unk1C[4]; // Weapon type lookup by weapon specifying which character ids may bypass the unusable bit????? (see FE8U:80174AC)

	/* 20 */ char playerName[0x2B - 0x20]; // unused outside of link arena (was tactician name in FE7); Size unknown

	/* 2B */
	u32 unk2B_1:1;
	u32:0;

	/* 2C */
	u32 unk2C_1:1;
	u32 unk2C_2:3;
	u32 unk2C_5:9;
	u32 unk2D_6:10;
	u32 unk2E_8:5;

	/* 30 */ u32 fundsTotalDifference;
	/* 34 */ u32 unk34;

	/* 38 */ u8 pad38[0x40 - 0x38];

	// option byte 1 (of 3)
	u32 unk40_1:1;
	u32 terrainWindowOption:1;
	u32 unitWindowOption:2;
	u32 autocursorOption:1;
	u32 textSpeedOption:2;
	u32 gameSpeedOption:1;

	u32 unk41_1:1;
	u32 muteSfxOption:1;
	u32 unk41_3:5;
	u32 subtitleHelpOption:1;

	u32 unk42_1:1;
	u32 unk42_2:1;
	u32 unk42_3:1;
	u32 unk42_4:1;
	u32 unk42_5:1;
	u32 unk42_6:1;
	u32 unk42_7:1;
	u32 unk42_8:1;

	u32 unk43_1:8;

	u8 unk44[0x48 - 0x44];

	u16 unk48;

	u16 unk4A_1 : 1;
	u16 unk4A_2 : 3;
};

extern struct ChapterState gChapterData; //! FE8U = (0x202BCF0)

#endif // GBAFE_CHAPTERDATA_H
