#include "include/global.h"
#include "include/hardware.h"

#include "include/unit_icon_data.h"
#include "include/bmunit.h"
#include "include/bmitem.h"
#include "include/bmmap.h"
#include "include/bmtrick.h"
#include "include/chapterdata.h"
#include "include/ctc.h"
#include "include/mu.h"
#include "include/bmudisp.h"
#include "include/bmlib.h"
#include "include/terrains.h"
#include "include/proc.h"
#include "include/rng.h"
#include "include/bm.h"
#include "include/bmlib.h"
#include "include/prepscreen.h"
#include "include/constants/faces.h"
#include "include/constants/terrains.h"
#include "include/face.h"
#include "include/anime.h"



#include "include/bmphase.h"
#include "include/bmunit.h"
#include "include/proc.h"
#include "include/bmarch.h"
#include "include/bmidoten.h"

extern int prMovGetter(struct Unit* unit); // skillsys mov getter 
//inline void PokemblemGenerateUnitMovementMapExt(struct Unit* unit, s8 movement); 
//inline struct Unit* GetUnitInline(int id); 
#define POKEMBLEM_VERSION 

struct Unit* GetUnitInline(int id);
extern void AcrobatSetWorkingMoveCosts(const s8 mct[TERRAIN_COUNT], int, struct Unit*); 
void PokemblemGenerateUnitCompleteAttackRange(struct Unit* unit); 
void PokemblemSetWorkingBmMap(u8** map);
void PokemblemGenerateUnitMovementMapExt(struct Unit* unit, s8 movement);
int PokemblemGetUnitWeaponReachBits(struct Unit* unit, int itemSlot);
int PokemblemGetItemReachBits(int item);
void PokemblemMapAddInRange(int x, int y, int range, int value);
void PokemblemMapAddInBoundedRange(short x, short y, short minRange, short maxRange);

#ifdef POKEMBLEM_VERSION 
void PokemblemGenerateDangerZoneRange(void)
#endif 
#ifndef POKEMBLEM_VERSION
void PokemblemGenerateDangerZoneRange(s8 boolDisplayStaffRange)
#endif 
{
	asm("mov r11, r11"); 
	struct Unit* unit;
    int i, enemyFaction;
	#ifndef POKEMBLEM_VERSION
    int hasMagicRank, prevHasMagicRank;
	prevHasMagicRank = -1;
	#endif 
    u8 savedUnitId;

    #ifdef POKEMBLEM_VERSION
	BmMapFill(gBmMapOther, 0);
	#endif 
	
	if (!(gBmSt.gameStateBits & BM_FLAG_3)) { // @ Check if we're called by DangerRadius
		return; 
	} 

    BmMapFill(gBmMapRange, 0);

    enemyFaction = GetNonActiveFaction();


    for (i = enemyFaction + 1; i < enemyFaction + 0x33; ++i)
    {
        unit = GetUnitInline(i);

        if (!UNIT_IS_VALID(unit))
            continue; // not a unit
		
		#ifdef POKEMBLEM_VERSION
		if (unit->pCharacterData->number >= 0xF0) 
			continue; // @ Don't do DR for unit IDs greater or equal to 0xF0
		#endif 
		
		#ifndef POKEMBLEM_VERSION
		if (!(unit->supportBits & 0x80)) // DRUnitByte & DRUnitBitMask - copied from DisplayDR basically 
			continue; // not included atm because DR is always on now 
		#endif 
		
		
		#ifndef POKEMBLEM_VERSION
        if (boolDisplayStaffRange && !UnitHasMagicRank(unit))
            continue; // no magic in magic range mode

        if (gPlaySt.chapterVisionRange && (gBmMapFog[unit->yPos][unit->xPos] == 0))
            continue; // in the fog

        if (unit->state & US_UNDER_A_ROOF)
            continue; // under a roof
		#endif 
		


        // Fill movement map for unit
        PokemblemGenerateUnitMovementMapExt(unit, prMovGetter(unit));

        savedUnitId = gBmMapUnit[unit->yPos][unit->xPos];
        gBmMapUnit[unit->yPos][unit->xPos] = 0;

		#ifndef POKEMBLEM_VERSION
        hasMagicRank = UnitHasMagicRank(unit);

        if (prevHasMagicRank != hasMagicRank)
        {
            BmMapFill(gBmMapOther, 0);

            if (hasMagicRank)
                GenerateMagicSealMap(1);

            prevHasMagicRank = hasMagicRank;
        }
		#endif 

        SetWorkingBmMap(gBmMapRange);

        // Apply unit's range to range map
		#ifndef POKEMBLEM_VERSION 
        if (boolDisplayStaffRange)
            GenerateUnitCompleteStaffRange(unit);
        else
		#endif 
            PokemblemGenerateUnitCompleteAttackRange(unit);

        gBmMapUnit[unit->yPos][unit->xPos] = savedUnitId;
    }
	asm("mov r11, r11"); 
}

int doesUnitHaveSpecialRange(struct Unit* unit) { 


    int i, item, result = 0;
	//u32 range = 0; 

    for (i = 0; (i < UNIT_ITEM_COUNT) && (item = unit->items[i]); ++i)
        //if (CanUnitUseWeapon(unit, item))
            result |= PokemblemGetItemReachBits(item);

	if (result > 0x10) { 
		return true; 
	}
	return false; 
	//GetItemData(ITEM_INDEX(item))->encodedRange;


} 

#ifdef POKEMBLEM_VERSION 
extern int BuildStraightLineRangeFromUnit(struct Unit* unit); 
#endif 

void PokemblemGenerateUnitCompleteAttackRange(struct Unit* unit)
{
    int ix, iy;

#ifndef POKEMBLEM_VERSION
    #define FOR_EACH_IN_MOVEMENT_RANGE(block) \
        for (iy = gBmMapSize.y - 1; iy >= 0; --iy) \
        { \
            for (ix = gBmMapSize.x - 1; ix >= 0; --ix) \
            { \
                if (gBmMapMovement[iy][ix] > MAP_MOVEMENT_MAX) \
                    continue; \
                if (gBmMapUnit[iy][ix]) \
                    continue; \
                if (gBmMapOther[iy][ix]) \
                    continue; \
                block \
            } \
        }
#else 
    #define FOR_EACH_IN_MOVEMENT_RANGE(block) \
        for (iy = gBmMapSize.y - 1; iy >= 0; --iy) \
        { \
            for (ix = gBmMapSize.x - 1; ix >= 0; --ix) \
            { \
                if (gBmMapMovement[iy][ix] > MAP_MOVEMENT_MAX) \
                    continue; \
                if (gBmMapUnit[iy][ix]) \
                    continue; \
                block \
            } \
        }
#endif 
	#ifdef POKEMBLEM_VERSION 
	if (BuildStraightLineRangeFromUnit(unit)) { 
		SetWorkingBmMap(gBmMapMovement);
		return; 
	} 
	#endif 


	if (doesUnitHaveSpecialRange(unit)) { 
		u32 minRange; 
		u32 maxRange; 
		int i, item; 
	    for (i = 0; (i < UNIT_ITEM_COUNT) && (item = unit->items[i]); ++i) { 
			if (item) { 
				if (CanUnitUseWeapon(unit, item)) { 
					minRange = GetItemData(ITEM_INDEX(item))->encodedRange & 0xF;
					maxRange = (GetItemData(ITEM_INDEX(item))->encodedRange & 0xF0) >> 4; 
					FOR_EACH_IN_MOVEMENT_RANGE({
					MapAddInBoundedRange(ix, iy, minRange, maxRange);
					})
				}
			} 
		} 
	
	
	} 
	
	else { 
    switch (PokemblemGetUnitWeaponReachBits(unit, -1))
    {

    case REACH_RANGE1:
        FOR_EACH_IN_MOVEMENT_RANGE({
            MapAddInBoundedRange(ix, iy, 1, 1);
        })

        break;

    case REACH_RANGE1 | REACH_RANGE2:
        FOR_EACH_IN_MOVEMENT_RANGE({
            MapAddInBoundedRange(ix, iy, 1, 2);
        })

        break;

    case REACH_RANGE1 | REACH_RANGE2 | REACH_RANGE3:
        FOR_EACH_IN_MOVEMENT_RANGE({
            MapAddInBoundedRange(ix, iy, 1, 3);
        })

        break;

    case REACH_RANGE2:
        FOR_EACH_IN_MOVEMENT_RANGE({
            MapAddInBoundedRange(ix, iy, 2, 2);
        })

        break;

    case REACH_RANGE2 | REACH_RANGE3:
        FOR_EACH_IN_MOVEMENT_RANGE({
            MapAddInBoundedRange(ix, iy, 2, 3);
        })

        break;

    case REACH_RANGE3:
        FOR_EACH_IN_MOVEMENT_RANGE({
            MapAddInBoundedRange(ix, iy, 3, 3);
        })

        break;

    case REACH_RANGE3 | REACH_TO10:
        FOR_EACH_IN_MOVEMENT_RANGE({
            MapAddInBoundedRange(ix, iy, 3, 10);
        })

        break;

    case REACH_RANGE1 | REACH_RANGE3:
        FOR_EACH_IN_MOVEMENT_RANGE({
            MapAddInBoundedRange(ix, iy, 1, 1);
            MapAddInBoundedRange(ix, iy, 3, 3);
        })

        break;

    case REACH_RANGE1 | REACH_RANGE3 | REACH_TO10:
        FOR_EACH_IN_MOVEMENT_RANGE({
            MapAddInBoundedRange(ix, iy, 1, 1);
            MapAddInBoundedRange(ix, iy, 3, 10);
        })

        break;

    case REACH_RANGE1 | REACH_RANGE2 | REACH_RANGE3 | REACH_TO10:
        FOR_EACH_IN_MOVEMENT_RANGE({
            MapAddInBoundedRange(ix, iy, 1, 10);
        })

        break;

    case REACH_RANGE1 | REACH_TO10:
        FOR_EACH_IN_MOVEMENT_RANGE({
            MapAddInBoundedRange(ix, iy, 1, 4);
        })

        break;

    } // switch (GetUnitWeaponReachBits(unit, -1))
	} 
	#ifndef POKEMBLEM_VERSION
    if (UNIT_CATTRIBUTES(unit) & CA_BALLISTAE)
    {
        FOR_EACH_IN_MOVEMENT_RANGE({
            int item = GetBallistaItemAt(ix, iy);

            if (item)
            {
                MapAddInBoundedRange(ix, iy,
                    GetItemMinRange(item), GetItemMaxRange(item));
            }
        })
    }
	#endif 

    #undef FOR_EACH_IN_MOVEMENT_RANGE

    SetWorkingBmMap(gBmMapMovement);
}

void PokemblemSetWorkingBmMap(u8** map)
{
    gWorkingBmMap = map;
}

void PokemblemGenerateUnitMovementMapExt(struct Unit* unit, s8 movement)
{
    AcrobatSetWorkingMoveCosts(GetUnitMovementCost(unit), 0, unit);
    PokemblemSetWorkingBmMap(gBmMapMovement);

    GenerateMovementMap(unit->xPos, unit->yPos, movement, unit->index);
}

struct Unit* CONST_DATA gUnitLookup[0x100] = { // unit lookup
    [FACTION_BLUE + 0x01] = gUnitArrayBlue + 0,
    [FACTION_BLUE + 0x02] = gUnitArrayBlue + 1,
    [FACTION_BLUE + 0x03] = gUnitArrayBlue + 2,
    [FACTION_BLUE + 0x04] = gUnitArrayBlue + 3,
    [FACTION_BLUE + 0x05] = gUnitArrayBlue + 4,
    [FACTION_BLUE + 0x06] = gUnitArrayBlue + 5,
    [FACTION_BLUE + 0x07] = gUnitArrayBlue + 6,
    [FACTION_BLUE + 0x08] = gUnitArrayBlue + 7,
    [FACTION_BLUE + 0x09] = gUnitArrayBlue + 8,
    [FACTION_BLUE + 0x0A] = gUnitArrayBlue + 9,
    [FACTION_BLUE + 0x0B] = gUnitArrayBlue + 10,
    [FACTION_BLUE + 0x0C] = gUnitArrayBlue + 11,
    [FACTION_BLUE + 0x0D] = gUnitArrayBlue + 12,
    [FACTION_BLUE + 0x0E] = gUnitArrayBlue + 13,
    [FACTION_BLUE + 0x0F] = gUnitArrayBlue + 14,
    [FACTION_BLUE + 0x10] = gUnitArrayBlue + 15,
    [FACTION_BLUE + 0x11] = gUnitArrayBlue + 16,
    [FACTION_BLUE + 0x12] = gUnitArrayBlue + 17,
    [FACTION_BLUE + 0x13] = gUnitArrayBlue + 18,
    [FACTION_BLUE + 0x14] = gUnitArrayBlue + 19,
    [FACTION_BLUE + 0x15] = gUnitArrayBlue + 20,
    [FACTION_BLUE + 0x16] = gUnitArrayBlue + 21,
    [FACTION_BLUE + 0x17] = gUnitArrayBlue + 22,
    [FACTION_BLUE + 0x18] = gUnitArrayBlue + 23,
    [FACTION_BLUE + 0x19] = gUnitArrayBlue + 24,
    [FACTION_BLUE + 0x1A] = gUnitArrayBlue + 25,
    [FACTION_BLUE + 0x1B] = gUnitArrayBlue + 26,
    [FACTION_BLUE + 0x1C] = gUnitArrayBlue + 27,
    [FACTION_BLUE + 0x1D] = gUnitArrayBlue + 28,
    [FACTION_BLUE + 0x1E] = gUnitArrayBlue + 29,
    [FACTION_BLUE + 0x1F] = gUnitArrayBlue + 30,
    [FACTION_BLUE + 0x20] = gUnitArrayBlue + 31,
    [FACTION_BLUE + 0x21] = gUnitArrayBlue + 32,
    [FACTION_BLUE + 0x22] = gUnitArrayBlue + 33,
    [FACTION_BLUE + 0x23] = gUnitArrayBlue + 34,
    [FACTION_BLUE + 0x24] = gUnitArrayBlue + 35,
    [FACTION_BLUE + 0x25] = gUnitArrayBlue + 36,
    [FACTION_BLUE + 0x26] = gUnitArrayBlue + 37,
    [FACTION_BLUE + 0x27] = gUnitArrayBlue + 38,
    [FACTION_BLUE + 0x28] = gUnitArrayBlue + 39,
    [FACTION_BLUE + 0x29] = gUnitArrayBlue + 40,
    [FACTION_BLUE + 0x2A] = gUnitArrayBlue + 41,
    [FACTION_BLUE + 0x2B] = gUnitArrayBlue + 42,
    [FACTION_BLUE + 0x2C] = gUnitArrayBlue + 43,
    [FACTION_BLUE + 0x2D] = gUnitArrayBlue + 44,
    [FACTION_BLUE + 0x2E] = gUnitArrayBlue + 45,
    [FACTION_BLUE + 0x2F] = gUnitArrayBlue + 46,
    [FACTION_BLUE + 0x30] = gUnitArrayBlue + 47,
    [FACTION_BLUE + 0x31] = gUnitArrayBlue + 48,
    [FACTION_BLUE + 0x32] = gUnitArrayBlue + 49,
    [FACTION_BLUE + 0x33] = gUnitArrayBlue + 50,
    [FACTION_BLUE + 0x34] = gUnitArrayBlue + 51,
    [FACTION_BLUE + 0x35] = gUnitArrayBlue + 52,
    [FACTION_BLUE + 0x36] = gUnitArrayBlue + 53,
    [FACTION_BLUE + 0x37] = gUnitArrayBlue + 54,
    [FACTION_BLUE + 0x38] = gUnitArrayBlue + 55,
    [FACTION_BLUE + 0x39] = gUnitArrayBlue + 56,
    [FACTION_BLUE + 0x3A] = gUnitArrayBlue + 57,
    [FACTION_BLUE + 0x3B] = gUnitArrayBlue + 58,
    [FACTION_BLUE + 0x3C] = gUnitArrayBlue + 59,
    [FACTION_BLUE + 0x3D] = gUnitArrayBlue + 60,
    [FACTION_BLUE + 0x3E] = gUnitArrayBlue + 61,

    [FACTION_RED + 0x01] = gUnitArrayRed + 0,
    [FACTION_RED + 0x02] = gUnitArrayRed + 1,
    [FACTION_RED + 0x03] = gUnitArrayRed + 2,
    [FACTION_RED + 0x04] = gUnitArrayRed + 3,
    [FACTION_RED + 0x05] = gUnitArrayRed + 4,
    [FACTION_RED + 0x06] = gUnitArrayRed + 5,
    [FACTION_RED + 0x07] = gUnitArrayRed + 6,
    [FACTION_RED + 0x08] = gUnitArrayRed + 7,
    [FACTION_RED + 0x09] = gUnitArrayRed + 8,
    [FACTION_RED + 0x0A] = gUnitArrayRed + 9,
    [FACTION_RED + 0x0B] = gUnitArrayRed + 10,
    [FACTION_RED + 0x0C] = gUnitArrayRed + 11,
    [FACTION_RED + 0x0D] = gUnitArrayRed + 12,
    [FACTION_RED + 0x0E] = gUnitArrayRed + 13,
    [FACTION_RED + 0x0F] = gUnitArrayRed + 14,
    [FACTION_RED + 0x10] = gUnitArrayRed + 15,
    [FACTION_RED + 0x11] = gUnitArrayRed + 16,
    [FACTION_RED + 0x12] = gUnitArrayRed + 17,
    [FACTION_RED + 0x13] = gUnitArrayRed + 18,
    [FACTION_RED + 0x14] = gUnitArrayRed + 19,
    [FACTION_RED + 0x15] = gUnitArrayRed + 20,
    [FACTION_RED + 0x16] = gUnitArrayRed + 21,
    [FACTION_RED + 0x17] = gUnitArrayRed + 22,
    [FACTION_RED + 0x18] = gUnitArrayRed + 23,
    [FACTION_RED + 0x19] = gUnitArrayRed + 24,
    [FACTION_RED + 0x1A] = gUnitArrayRed + 25,
    [FACTION_RED + 0x1B] = gUnitArrayRed + 26,
    [FACTION_RED + 0x1C] = gUnitArrayRed + 27,
    [FACTION_RED + 0x1D] = gUnitArrayRed + 28,
    [FACTION_RED + 0x1E] = gUnitArrayRed + 29,
    [FACTION_RED + 0x1F] = gUnitArrayRed + 30,
    [FACTION_RED + 0x20] = gUnitArrayRed + 31,
    [FACTION_RED + 0x21] = gUnitArrayRed + 32,
    [FACTION_RED + 0x22] = gUnitArrayRed + 33,
    [FACTION_RED + 0x23] = gUnitArrayRed + 34,
    [FACTION_RED + 0x24] = gUnitArrayRed + 35,
    [FACTION_RED + 0x25] = gUnitArrayRed + 36,
    [FACTION_RED + 0x26] = gUnitArrayRed + 37,
    [FACTION_RED + 0x27] = gUnitArrayRed + 38,
    [FACTION_RED + 0x28] = gUnitArrayRed + 39,
    [FACTION_RED + 0x29] = gUnitArrayRed + 40,
    [FACTION_RED + 0x2A] = gUnitArrayRed + 41,
    [FACTION_RED + 0x2B] = gUnitArrayRed + 42,
    [FACTION_RED + 0x2C] = gUnitArrayRed + 43,
    [FACTION_RED + 0x2D] = gUnitArrayRed + 44,
    [FACTION_RED + 0x2E] = gUnitArrayRed + 45,
    [FACTION_RED + 0x2F] = gUnitArrayRed + 46,
    [FACTION_RED + 0x30] = gUnitArrayRed + 47,
    [FACTION_RED + 0x31] = gUnitArrayRed + 48,
    [FACTION_RED + 0x32] = gUnitArrayRed + 49,

    [FACTION_GREEN + 0x01] = gUnitArrayGreen + 0,
    [FACTION_GREEN + 0x02] = gUnitArrayGreen + 1,
    [FACTION_GREEN + 0x03] = gUnitArrayGreen + 2,
    [FACTION_GREEN + 0x04] = gUnitArrayGreen + 3,
    [FACTION_GREEN + 0x05] = gUnitArrayGreen + 4,
    [FACTION_GREEN + 0x06] = gUnitArrayGreen + 5,
    [FACTION_GREEN + 0x07] = gUnitArrayGreen + 6,
    [FACTION_GREEN + 0x08] = gUnitArrayGreen + 7,
    [FACTION_GREEN + 0x09] = gUnitArrayGreen + 8,
    [FACTION_GREEN + 0x0A] = gUnitArrayGreen + 9,
    [FACTION_GREEN + 0x0B] = gUnitArrayGreen + 10,
    [FACTION_GREEN + 0x0C] = gUnitArrayGreen + 11,
    [FACTION_GREEN + 0x0D] = gUnitArrayGreen + 12,
    [FACTION_GREEN + 0x0E] = gUnitArrayGreen + 13,
    [FACTION_GREEN + 0x0F] = gUnitArrayGreen + 14,
    [FACTION_GREEN + 0x10] = gUnitArrayGreen + 15,
    [FACTION_GREEN + 0x11] = gUnitArrayGreen + 16,
    [FACTION_GREEN + 0x12] = gUnitArrayGreen + 17,
    [FACTION_GREEN + 0x13] = gUnitArrayGreen + 18,
    [FACTION_GREEN + 0x14] = gUnitArrayGreen + 19,


};

struct Unit* GetUnitInline(int id) {
    return gUnitLookup[id & 0xFF];
}


int PokemblemGetUnitWeaponReachBits(struct Unit* unit, int itemSlot) {
    int i, item, result = 0;

    if (itemSlot >= 0)
        return PokemblemGetItemReachBits(unit->items[itemSlot]);

    for (i = 0; (i < UNIT_ITEM_COUNT) && (item = unit->items[i]); ++i)
        if (CanUnitUseWeapon(unit, item))
            result |= PokemblemGetItemReachBits(item);

    return result;
}
int PokemblemGetItemEncodedRange(int item) {
    return GetItemData(ITEM_INDEX(item))->encodedRange;
}
int PokemblemGetItemReachBits(int item) {
    switch (PokemblemGetItemEncodedRange(item)) {

    case 0x11:
        return REACH_RANGE1;

    case 0x12:
        return REACH_RANGE1 | REACH_RANGE2;

    case 0x13:
        return REACH_RANGE1 | REACH_RANGE2 | REACH_RANGE3;

    case 0x14:
        return REACH_RANGE1 | REACH_TO10;

    case 0x22:
        return REACH_RANGE2;

    case 0x23:
        return REACH_RANGE2 | REACH_RANGE3;

    case 0x33:
        return REACH_RANGE3;

    case 0x3A:
        return REACH_RANGE3 | REACH_TO10;

    case 0x3F:
        return REACH_RANGE3 | REACH_TO15;

    default:
        return REACH_NONE;

    } // switch (GetItemEncodedRange(item))
}


void PokemblemMapAddInRange(int x, int y, int range, int value)
{
    int ix, iy, iRange;

    // Handles rows [y, y+range]
    // For each row, decrement range
    for (iRange = range, iy = y; (iy <= y + range) && (iy < gBmMapSize.y); --iRange, ++iy)
    {
        int xMin, xMax, xRange;

        xMin = x - iRange;
        xRange = 2 * iRange + 1;

        if (xMin < 0)
        {
            xRange += xMin;
            xMin = 0;
        }

        xMax = xMin + xRange;

        if (xMax > gBmMapSize.x)
        {
            xMax -= (xMax - gBmMapSize.x);
            xMax = gBmMapSize.x;
        }

        for (ix = xMin; ix < xMax; ++ix)
        {
            gWorkingBmMap[iy][ix] += value;
        }
    }

    // Handle rows [y-range, y-1], starting from the bottom most row
    // For each row, decrement range
    for (iRange = (range - 1), iy = (y - 1); (iy >= y - range) && (iy >= 0); --iRange, --iy)
    {
        int xMin, xMax, xRange;

        xMin = x - iRange;
        xRange = 2 * iRange + 1;

        if (xMin < 0)
        {
            xRange += xMin;
            xMin = 0;
        }

        xMax = xMin + xRange;

        if (xMax > gBmMapSize.x)
        {
            xMax -= (xMax - gBmMapSize.x);
            xMax = gBmMapSize.x;
        }

        for (ix = xMin; ix < xMax; ++ix)
        {
            gWorkingBmMap[iy][ix] += value;
        }
    }
}

void PokemblemMapAddInBoundedRange(short x, short y, short minRange, short maxRange)
{
    PokemblemMapAddInRange(x, y, maxRange,     +1);
    PokemblemMapAddInRange(x, y, minRange - 1, -1);
}
