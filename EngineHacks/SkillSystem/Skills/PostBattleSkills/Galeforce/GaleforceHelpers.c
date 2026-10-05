#include "global.h"
#include "types.h"
#include "bmunit.h"

extern bool CheckBit(u32* address, u8 bitOffset);
extern void SetBit(u32* address, u8 bitOffset);
extern void UnsetBit(u32* address, u8 bitOffset);
extern u32* GetUnitDebuffEntry(struct Unit* unit);
extern int GaleforceBitOffset_Link;

int CheckGaleforceBit(struct Unit* unit);
void SetGaleforceBit(struct Unit* unit);
void UnsetGaleforceBit(struct Unit* unit);
void Turn_ClearGaleforceBits();

int CheckGaleforceBit(struct Unit* unit) {
	return CheckBit(GetUnitDebuffEntry(unit), GaleforceBitOffset_Link);
}

void SetGaleforceBit(struct Unit* unit) {
	SetBit(GetUnitDebuffEntry(unit), GaleforceBitOffset_Link);
}

void UnsetGaleforceBit(struct Unit* unit) {
	UnsetBit(GetUnitDebuffEntry(unit), GaleforceBitOffset_Link);
}

void Turn_ClearGaleforceBits() {
	int faction = gPlaySt.faction;
	int unitID = faction+1;
	int maxCount = 0;
	
	switch (faction) {
		case FACTION_BLUE:
		maxCount = 62;
		break;
		
		case FACTION_RED:
		maxCount = 50;
		break;
		
		case FACTION_GREEN:
		maxCount = 20;
		break;
		
		case FACTION_PURPLE:
		maxCount = 5;
		break;
	}
	
	while ((unitID - faction) < maxCount) {
		//get the unit unitID
		struct Unit* curUnit = GetUnit(unitID);
	
		//clear the bit
		UnsetBit(GetUnitDebuffEntry(curUnit), GaleforceBitOffset_Link);
		unitID++;
	}
}



