
#include <stddef.h>
#include "FE-CLib-master/include/gbafe.h"

extern u8* SupplyUsabilityTable[];
extern u8 SupplyUsabilityPhantomIDLink;
extern struct Unit* gActiveUnit;

// Returns a boolean for whether the current chapter should make units drop items or send them to the supply.
// Autohook to 0x0803161C.
u8 HasConvoyAccess(void)
{
	if ( SupplyUsabilityTable[gChapterData.chapterIndex] == NULL )
	{
		return 0;
	}
	else
	{
		return 1;
	}
}

u8 DoesCharacterHaveSupply(Unit* unit, u8 supplyList[])
{
	for (u8 i = 0; supplyList[i] != 0; i++)
    {
        if ( supplyList[i] == unit->pCharacterData->number )
        {
            return 1;
        }
    }
    return 0;
}

// Unit menu usabality routine for "Supply".
// Autohook to 0x08023F64.
u8 SupplyUsability(void)
{
	int Return = 3;
	u8* supplyList = SupplyUsabilityTable[gChapterData.chapterIndex];
	if ( supplyList != NULL )
	{
		if ( gActiveUnit->pClassData->number != SupplyUsabilityPhantomIDLink )
		{
			if ( DoesCharacterHaveSupply(gActiveUnit,supplyList) )
			{
				Return = 1; // Return true if the current character has supply access.
			}
			else
			{
				// If the active unit can't use the supply, check if one adjacent can.
				for ( int i = 0 ; i < 50 ; i++ )
				{
					Unit* curr = &gUnitArrayBlue[i];
					if ( curr->pCharacterData != NULL && DoesCharacterHaveSupply(curr,supplyList) )
					{
						if ( ( gActiveUnit->xPos == curr->xPos && ( ( gActiveUnit->yPos == curr->yPos+1 || gActiveUnit->yPos == curr->yPos-1 ) ) ) /* Unit is above || below.*/
							|| ( gActiveUnit->yPos == curr->yPos && ( ( gActiveUnit->xPos == curr->xPos+1 || gActiveUnit->xPos == curr->xPos-1 ) ) ) ) /* Unit is right || left. */
						{
							return 1;
						}
					}
				}
			}
		}
	}
	return Return;
}
