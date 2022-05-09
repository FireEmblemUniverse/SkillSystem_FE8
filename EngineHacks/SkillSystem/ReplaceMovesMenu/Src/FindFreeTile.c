#include "FE-CLib-master/include/gbafe.h"

//void FindFreeTile(struct Unit *unit, struct Unit *rescuee, int* xOut, int* yOut)
void FindFreeTile(struct Unit *unit, int* xOut, int* yOut)
{
    int iy, ix, minDistance = 9999;


	
	
    // Put the active unit on the unit map (kinda, just marking its spot)
    gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0xFF;


	// idk
	FillMovementMapForUnit(unit); // fill with flier movement & own movement 
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

	if (*xOut == 0xFFFFFFFF) { 


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




    // Remove the active unit from the unit map again
    gMapUnit[gActiveUnit->yPos][gActiveUnit->xPos] = 0;
}
