
#include <stddef.h>
#include "FE-CLib-master/include/gbafe.h"

typedef struct TerrainUse TerrainUse;

struct TerrainUse
{
	u8 terrainID, itemID;
	int (*usability)(Unit* unit);
};

extern TerrainUse gTerrainUses[];

int GetOpenTerrainItemSlot(Unit* unit, int terrainID) // Autohook to 0x08018A9C. Return the item slot of the item that can open this terrain. 0 otherwise.
{
	for ( int i = 0 ; gTerrainUses[i].terrainID ; i++ )
	{
		if ( terrainID == gTerrainUses[i].terrainID )
		{
			if ( gTerrainUses[i].usability && !gTerrainUses[i].usability(unit) ) { continue; }
			int slot = GetUnitItemSlot(unit,gTerrainUses[i].itemID);
			if ( slot != -1 ) { return slot; }
		}
	}
	return -1;
}

int DoorsAndChestsIsThief(Unit* unit)
{
	return UNIT_CATTRIBUTES(unit) & CA_LOCKPICK ? 1 : 0;
}
