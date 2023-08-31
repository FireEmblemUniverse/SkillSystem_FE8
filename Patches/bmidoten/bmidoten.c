#include "include/global.h"

#include "include/constants/terrains.h"

#include "include/bmitem.h"
#include "include/bmmap.h"
#include "include/bmphase.h"
#include "include/bmunit.h"
#include "include/mu.h"
#include "include/proc.h"
#include "include/rng.h"
#include "include/bmarch.h"
#include "include/bmidoten.h"

void NewGenerateUnitStandingReachRange(struct Unit* unit, int reach); 

/*
enum {
    // Unit ranges are a (sometimes) weirdly hardcoded.
    // A flagset value is used to represent the combined ranges of a unit's usable items
    // That's what those "reaches" bits are for.

    REACH_NONE   = 0,

    REACH_RANGE1 = (1 << 0),
    REACH_RANGE2 = (1 << 1),
    REACH_RANGE3 = (1 << 2),
    REACH_TO10   = (1 << 3),
    REACH_TO15   = (1 << 4),
    REACH_MAGBY2 = (1 << 5),
}; */ 

int NewGetUnitWeaponReachBits(struct Unit* unit, int itemSlot) {
    int i, item, result = 0;

    if (itemSlot >= 0) { 
	return GetItemReachBits(unit->items[itemSlot]); } 

	if (unit->index > 0x3F) { 
    for (i = 0; (i < UNIT_ITEM_COUNT) && (item = unit->items[i]); ++i)
        if (CanUnitUseWeapon(unit, item))
            result |= GetItemReachBits(item);
	}
	else { 
    for (i = 0; (i < 5) && (item = unit->ranks[i] | 0xA00); ++i)
        if (CanUnitUseWeapon(unit, item))
            result |= GetItemReachBits(item);
	
	} 

    return result;
}


void NewAllWepsOneSquare(struct Unit* unit, int slot) { // -1 slot is all weps 

    int reach = NewGetUnitWeaponReachBits(unit, -1);
    NewGenerateUnitStandingReachRange(unit, reach);

} 

void NewMapAddInRange(int x, int y, int range, int value)
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

void NewMapAddInBoundedRange(short x, short y, short minRange, short maxRange)
{
    NewMapAddInRange(x, y, maxRange,     +1);
    NewMapAddInRange(x, y, minRange - 1, -1);
}

void NewGenerateUnitStandingReachRange(struct Unit* unit, int reach)
{
    int x = unit->xPos;
    int y = unit->yPos;

    switch (reach)
    {

    case REACH_RANGE1:
        NewMapAddInBoundedRange(x, y, 1, 1);
        break;

    case REACH_RANGE1 | REACH_RANGE2:
        NewMapAddInBoundedRange(x, y, 1, 2);
        break;

    case REACH_RANGE1 | REACH_RANGE2 | REACH_RANGE3:
        NewMapAddInBoundedRange(x, y, 1, 3);
        break;

    case REACH_RANGE2:
        NewMapAddInBoundedRange(x, y, 2, 2);
        break;

    case REACH_RANGE2 | REACH_RANGE3:
        NewMapAddInBoundedRange(x, y, 2, 3);
        break;

    case REACH_RANGE3:
        NewMapAddInBoundedRange(x, y, 3, 3);
        break;

    case REACH_RANGE3 | REACH_TO10:
        NewMapAddInBoundedRange(x, y, 3, 10);
        break;

    case REACH_RANGE1 | REACH_RANGE3:
        NewMapAddInBoundedRange(x, y, 1, 1);
        NewMapAddInBoundedRange(x, y, 3, 3);
        break;

    case REACH_RANGE1 | REACH_RANGE3 | REACH_TO10:
        NewMapAddInBoundedRange(x, y, 1, 1);
        NewMapAddInBoundedRange(x, y, 3, 10);
        break;

    case REACH_RANGE1 | REACH_RANGE2 | REACH_RANGE3 | REACH_TO10:
        NewMapAddInBoundedRange(x, y, 1, 10);
        break;

    case REACH_RANGE1 | REACH_TO10:
        NewMapAddInBoundedRange(x, y, 1, 4);
        break;

    case REACH_MAGBY2:
        NewMapAddInBoundedRange(x, y, 1, 2);
        //NewMapAddInBoundedRange(x, y, 1, GetUnitMagBy2Range(unit));
        break;

    } // switch (reach)
}


/*
void MapAddInRange(int x, int y, int range, int value)
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
*/ 






