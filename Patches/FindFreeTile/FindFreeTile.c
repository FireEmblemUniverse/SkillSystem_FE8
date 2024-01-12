#include "gbafe.h"

#define ABS(aValue) ((aValue) >= 0 ? (aValue) : -(aValue))
#define RECT_DISTANCE(aXA, aYA, aXB, aYB) (ABS((aXA) - (aXB)) + ABS((aYA) - (aYB)))

void FindFreeTile(struct Unit *unit, int* xOut, int* yOut);

extern struct Unit* GetUnitStructFromEventParameter(int ID); 


//void FindFreeTile(struct Unit *unit, struct Unit *rescuee, int* xOut, int* yOut)
void const ASMC_FindFreeTile(void) 
{ 
	int result = false; // default 
	int unitID = gEventSlot[1]; 
	struct Unit* unit = GetUnitStructFromEventParameter(unitID); 
	if ((unit != 0) & (unit->pCharacterData != 0)) { 
		result = unit->yPos << 16 | unit->xPos; 
		int xOut; 
		xOut = gEventSlot[0xB] & 0xFFFF; 
		int yOut; 
		yOut = (gEventSlot[0xB] & 0xFFFF0000) >> 16;
		unit->xPos = xOut; 
		unit->yPos = yOut; 
		FindFreeTile(unit, &xOut, &yOut); 
		unit->xPos = result & 0xFFFF; 
		unit->yPos = (result & 0xFFFF0000) >> 16; 
		
		if ((xOut != 9999) & (yOut != 9999)) {
			result = (yOut << 16) | xOut; 
		}
	} 
	gEventSlot[0xC] = result; // if no unit, return 0 as coord 
	ClearMenuCommandOverride();
} 

void const FindFreeTile(struct Unit *unit, int* xOut, int* yOut)
{
    int iy, ix, minDistance = 9999;


	
	
    // Put the active unit on the unit map (kinda, just marking its spot)
	if (gActiveUnit) { 
    gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0xFF; } 


	// idk
	FillMovementMapForUnitAndMovement(unit, 15); // fill with flier movement & own movement 
	// Find "nearest" free tile based on movement costs provided 
    for (iy = gMapSize.y - 1; iy >= 0; --iy)
    {
        for (ix = gMapSize.x - 1; ix >= 0; --ix)
        {
            int distance;

            if (gMapMovement[iy][ix] > 14) // I think high movement costs might cause an overflow issue here? So I'm using 1, 2, 15, 255 cost. 
                continue;

            if (gMapUnit[iy][ix] != 0)
                continue;

            if (gMapHidden[iy][ix] & HIDDEN_BIT_UNIT)
                continue;

            if (!CanUnitCrossTerrain(unit, gMapTerrain[iy][ix])) // movement costs that are 0x80 or higher won't be accepted 
                continue;

            distance = RECT_DISTANCE(ix, iy, unit->xPos, unit->yPos);

            if (minDistance >= distance)
            {
                minDistance = distance;

                *xOut = ix;
                *yOut = iy;
            }
        }
    }

	if (*xOut == (-1)) { 

		// Fill the movement map
		extern const u8 GenericMovCost[];
		MapMovementFillMovementFromPosition(unit->xPos, unit->yPos, GenericMovCost); // void MapFloodExtended(int x, int y, i8 const move_table[]);
		

		// Find "nearest" free tile based on movement costs provided 
		for (iy = gMapSize.y - 1; iy >= 0; --iy)
		{
			for (ix = gMapSize.x - 1; ix >= 0; --ix)
			{
				int distance;

				if (gMapMovement[iy][ix] > 14) // I think high movement costs might cause an overflow issue here? So I'm using 1, 2, 15, 255 cost. 
					continue;

				if (gMapUnit[iy][ix] != 0)
					continue;

				if (gMapHidden[iy][ix] & HIDDEN_BIT_UNIT)
					continue;

				if (!CanUnitCrossTerrain(unit, gMapTerrain[iy][ix]))
					continue;

				distance = RECT_DISTANCE(ix, iy, unit->xPos, unit->yPos);

				if (minDistance >= distance)
				{
					minDistance = distance;

					*xOut = ix;
					*yOut = iy;
				}
			}
		}
	}



	if (gActiveUnit) { 
    // Remove the active unit from the unit map again
    gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0;
	}
}
