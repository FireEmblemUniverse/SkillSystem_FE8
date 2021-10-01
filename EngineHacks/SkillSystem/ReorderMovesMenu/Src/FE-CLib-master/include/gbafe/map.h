#ifndef GBAFE_MAP_H
#define GBAFE_MAP_H

// Rename to bmmap.h? Since it corresponds to bmmap.c from the proto

#include "common.h"
#include "unit.h"

typedef u8** MapData;

extern struct Vec2u gMapSize; //! FE8U = (0x0202E4D4)

extern MapData gMapUnit; //! FE8U = (0x0202E4D8)
extern MapData gMapTerrain; //! FE8U = (0x0202E4DC)
extern MapData gMapMovement; //! FE8U = (0x0202E4E0)
extern MapData gMapRange; //! FE8U = (0x0202E4E4)
extern MapData gMapFog; //! FE8U = (0x0202E4E8)
extern MapData gMapHidden; //! FE8U = (0x0202E4EC)
extern MapData gMapMovement2; //! FE8U = (0x0202E4F0)

extern u16** const gMapRawTiles; //! FE8U = (0x0859A9D4)

enum {
	// for use with gMapHidden

	HIDDEN_BIT_UNIT = (1 << 0),
	HIDDEN_BIT_TRAP = (1 << 1),
};

void InitChapterMap(u8 chapterIndex); //! FE8U = 0x80194BD
void BmMapInit(void* pool, MapData* target, int width, int height); //! FE8U = 0x80197A5

void BmMapFill(MapData, u8 value); //! FE8U = 0x80197E5

void UnpackChapterMap(void* buffer, u8 chapterIndex); //! FE8U = 0x80198AD
void UnpackChapterMapGraphics(u8 chapterIndex); //! FE8U = 0x801990D
void InitBaseTilesBmMap(void); //! FE8U = 0x80199A5

void RefreshTerrainBmMap(void); //! FE8U = 0x8019A65

u8 GetTrueTerrainAt(int x, int y); //! FE8U = 0x8019AF5

void DisplayBmTile(u16* bg, int x, int y, int xTile, int yTile); //! FE8U = 0x8019B19
void RenderBmMap(void); //! FE8U = 0x8019C3D

void RenderBmMapOnBg2(void); //! FE8U = 0x8019CBD

void RefreshUnitsOnBmMap(void); //! FE8U = 0x8019FA1
void RefreshTorchlightsOnBmMap(void); //! FE8U = 0x801A175
void RefreshMinesOnBmMap(void); //! FE8U = 0x801A1A1
void RefreshEntityBmMaps(void); //! FE8U = 0x801A1F4

char* GetTerrainName(u8); //! FE8U = 0x801A241
int GetTerrainHealAmount(u8); //! FE8U = 0x801A259
int GetTerrainUnk(u8); //! FE8U = 0x801A269

void RevertMapChange(int id); //! FE8U = 0x801A2ED

void FillMovementMapForUnit(const struct Unit*); //! FE8U = 0x801A38D
void FillMovementMapForUnitAndMovement(const struct Unit*, int movement); //! FE8U = 0x801A3CD
void MapMovementFillMovementFromUnit(const struct Unit*); //! FE8U = 0x801A409
void MapRangeFillMovementFromPosition(int x, int y, const u8 costTable[]); //! FE8U = 0x801A43D
void MapMovementFillMovementFromPosition(int x, int y, const u8 costTable[]); //! FE8U = 0x801A46D
void MapFillMovementFromUnitAt(const struct Unit*, int x, int y, int movement); //! FE8U = 0x801A49D
void SetMovCostTable(const u8 table[]); //! FE8U = 0x801A4CD
void MapFillMovement(int x, int y, int movement, u8 unitIndex); //! FE8U = 0x801A4ED

void ProcessUnitMovement(struct Unit*, int xStart, int yStart); //! FE8U = 0x801A82D

void MapAddInRange(int x, int y, int range, int value); //! FE8U = 0x801AABD
void MapSetInRange(int x, int y, int range, int value); //! FE8U = 0x801ABC1

void FillMapAttackRangeForUnit(const struct Unit*); //! FE8U = 0x801ACBD
void FillRangeMapByRangeMask(const struct Unit*, u32 mask); //! FE8U = 0x801B461
void FillMapStaffRangeForUnit(const struct Unit*); //! FE8U = 0x801B619
void FillRangeMapForDangerZone(int boolStaff); //! FE8U = 0x801B811
void SetSubjectMap(MapData); //! FE8U = 0x801B999
void MapIncInBoundedRange(int x, int y, int minRange, int maxRange); //! FE8U = 0x801B9A5

u8 GetCurrentMovCostTable(void); //! FE8U = 0x801B9E5

#endif // GBAFE_MAP_H
