
#include <stddef.h>
#include "FE-CLib-master/include/gbafe.h"

typedef const struct EventParameterEntry EventParameterEntry;

struct EventParameterEntry
{
	int key;
	Unit* (*getter)(int key);
};

extern EventParameterEntry EventParameterTable[0xFF];
extern u32 gMemorySlot[15]; // 0x030004B8.

extern int GetPlayerLeaderUnitId(void); // 0x08033258

// We're going to rewrite GetUnitStructFromEventParameter (0x0800BC50) to read key codes from a table and run a routine from there.
	// If none is found, try to get the unit pointer from the character ID.

Unit* EventParameters(int charID) // Autohook to 0x0800BC50.
{
	for ( int i = 0 ; EventParameterTable[i].getter ; i++ )
	{
		if ( EventParameterTable[i].key == charID )
		{
			// This key matches the "character ID" passed in. Run its getter function.
			return EventParameterTable[i].getter(EventParameterTable[i].key);
		}
	}
	// No match to any key. Let's just get the unit pointer treating charID as a... well... character ID.
	return GetUnitByCharId(charID);
}

Unit* EventParameterGetActive(int key) // These are in the table by default to support vanilla implementation.
{
	return gActiveUnit;
}

Unit* EventParameterGetCoordsInSlotB(int key)
{
	int x = gMemorySlot[0xB] & 0xFFFF;
	int y = gMemorySlot[0xB] >> 0x10;
	return GetUnit(gMapUnit[y][x]);
}

Unit* EventParameterGetUnitInSlot2(int key)
{
	if ( gMemorySlot[0x2] == key ) { return NULL; } // We're gonna support recursive calls with this, but let's maybe try to avoid infinite loops.
	return EventParameters(gMemorySlot[0x2]);
}

Unit* EventParameterGetUnit(int key)
{
	if ( gMemorySlot[0x2] == key ) { return NULL; }
	return GetUnit(gMemorySlot[0x2]);
}

Unit* EventParametersGetLeader(int key)
{
	return GetUnitByCharId(GetPlayerLeaderUnitId());
}
