#include "RangeStuff.h" 
//#include "NewMapAddInRange.c"
#define POKEMBLEM_VERSION 



#ifdef POKEMBLEM_VERSION 
void PokemblemGenerateDangerZoneRange(void)
#endif 
#ifndef POKEMBLEM_VERSION
void PokemblemGenerateDangerZoneRange(s8 boolDisplayStaffRange)
#endif 
{
	asm("mov r11, r11"); 
		//copy render code into IWRAM
	//CpuFastCopy(NewWMLoop, IRAM_NewWMLoop, SIZEOF_NewWMLoop);
	
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
					PokemblemMapAddInBoundedRange(ix, iy, minRange, maxRange);
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
            PokemblemMapAddInBoundedRange(ix, iy, 1, 1);
        })

        break;

    case REACH_RANGE1 | REACH_RANGE2:
        FOR_EACH_IN_MOVEMENT_RANGE({
            PokemblemMapAddInBoundedRange(ix, iy, 1, 2);
        })

        break;

    case REACH_RANGE1 | REACH_RANGE2 | REACH_RANGE3:
        FOR_EACH_IN_MOVEMENT_RANGE({
            PokemblemMapAddInBoundedRange(ix, iy, 1, 3);
        })

        break;

    case REACH_RANGE2:
        FOR_EACH_IN_MOVEMENT_RANGE({
            PokemblemMapAddInBoundedRange(ix, iy, 2, 2);
        })

        break;

    case REACH_RANGE2 | REACH_RANGE3:
        FOR_EACH_IN_MOVEMENT_RANGE({
            PokemblemMapAddInBoundedRange(ix, iy, 2, 3);
        })

        break;

    case REACH_RANGE3:
        FOR_EACH_IN_MOVEMENT_RANGE({
            PokemblemMapAddInBoundedRange(ix, iy, 3, 3);
        })

        break;

    case REACH_RANGE3 | REACH_TO10:
        FOR_EACH_IN_MOVEMENT_RANGE({
            PokemblemMapAddInBoundedRange(ix, iy, 3, 10);
        })

        break;

    case REACH_RANGE1 | REACH_RANGE3:
        FOR_EACH_IN_MOVEMENT_RANGE({
            PokemblemMapAddInBoundedRange(ix, iy, 1, 1);
            PokemblemMapAddInBoundedRange(ix, iy, 3, 3);
        })

        break;

    case REACH_RANGE1 | REACH_RANGE3 | REACH_TO10:
        FOR_EACH_IN_MOVEMENT_RANGE({
            PokemblemMapAddInBoundedRange(ix, iy, 1, 1);
            PokemblemMapAddInBoundedRange(ix, iy, 3, 10);
        })

        break;

    case REACH_RANGE1 | REACH_RANGE2 | REACH_RANGE3 | REACH_TO10:
        FOR_EACH_IN_MOVEMENT_RANGE({
            PokemblemMapAddInBoundedRange(ix, iy, 1, 10);
        })

        break;

    case REACH_RANGE1 | REACH_TO10:
        FOR_EACH_IN_MOVEMENT_RANGE({
            PokemblemMapAddInBoundedRange(ix, iy, 1, 4);
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
                MapAddInBoundedRange(ix, iy, // not the new one because item range fix does something to the function for ballistas idk 
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
	u32 result = PokemblemGetItemEncodedRange(item);
    switch (result) {

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
        return result; // return item encoded range if not one of these cases. 0 if no range 

    } // switch (GetItemEncodedRange(item))
}

extern void PokemblemMapAddInRange(int x, int y, int range, int value); 

void PokemblemMapAddInBoundedRange(short x, short y, short minRange, short maxRange)
{
    PokemblemMapAddInRange(x, y, maxRange,     +1);
    PokemblemMapAddInRange(x, y, minRange - 1, -1);
}
