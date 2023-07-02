#include "Boxes.h" 

//SendItemsToConvoy(unit); 

int GetFreeUnitID(void) { 
	struct Unit* unit; 
	for (int i = 0; i<0x40; i++) { // unit ID, not deployment ID 
		unit = GetUnitStructFromEventParameter(i); 
		if (unit && unit->pCharacterData) { 
			continue; 
		}
		else {
			return i; 
		}
	}
	return 0xFF; 
} 

int GetFreeDeploymentID(void) { 
	struct Unit* unit; 
	for (int i = 0; i<0x40; i++) { // deployment ID 
		unit = GetUnit(i); 
		if (unit && unit->pCharacterData) { 
			continue; 
		}
		else {
			return i; 
		}
	}
	return 0xFF; 
} 

int IsBoxFull(void) { 
	struct BoxUnit &boxUnitSaved[0] = (void*)MS_GetSaveAddressBySlot(gChapterData.saveSlotIndex+5); 
	for (int i = 0; i < BoxCapacity; i++) { 
		if (!boxUnitSaved[i].classID)
			return false; 
	} 
	return true; 
} 

struct BoxUnit GetFreeBoxSlot(void) { 
	struct BoxUnit &boxUnitSaved[0] = (void*)MS_GetSaveAddressBySlot(gChapterData.saveSlotIndex+5); 
	for (int i = 0; i < BoxCapacity; i++) { 
		if (!boxUnitSaved[i].classID)
			return boxUnitSaved[i]; 
	} 
	return 0; 
} 

struct BoxUnit GetTakenBoxSlot(void) { 
	struct BoxUnit &boxUnitSaved[0] = (void*)MS_GetSaveAddressBySlot(gChapterData.saveSlotIndex+5); 
	for (int i = 0; i < BoxCapacity; i++) { 
		if (boxUnitSaved[i].classID)
			return boxUnitSaved[i]; 
	} 
	return 0; 
} 

struct BoxUnit ClearBoxUnit(struct BoxUnit) { 
	boxRam.classID = 0; 
	boxRam.hp 	= 0; 
	boxRam.mag = 0; 
	boxRam.str = 0;
	boxRam.skl = 0;
	boxRam.spd = 0;
	boxRam.def = 0;
	boxRam.res = 0;
	boxRam.luk = 0;
	boxRam.lvl = 0; 
	boxRam.exp = 0;
	return BoxUnit; 
} 


// need to clear all from save file on new game 
// need to copy over box units when save file is copied, too 


void PackUnitIntoBox_ASMC(void) { 
	struct Unit* unit = GetUnitStructFromEventParameter(gEventSlot[1]); 
	if (unit && unit->pCharacterData) { 
		PackUnitIntoBox(GetFreeBoxSlot(), unit); 
	} 
} 
void UnpackUnitFromBox_ASMC(void) { 
	//struct Unit* unit = GetUnitStructFromEventParameter(gEventSlot[1]); 
	struct Unit* unit = GetFreeBlueUnit();
	UnpackUnitFromBox(unit, GetTakenBoxSlot()); 
} 



//  //! FE8U = 0x8017871
	
//struct BoxUnit PackUnitIntoBox(struct BoxUnit boxRam[], struct Unit* unit) { 
  struct BoxUnit PackUnitIntoBox(struct BoxUnit boxRam, struct Unit* unit) { 
	boxRam.classID = unit->pClassData->number; 
	boxRam.hp = unit->maxHP; 
	boxRam.mag = unit->unk3A; 
	boxRam.str = unit->pow; 
	boxRam.skl = unit->skl; 
	boxRam.spd = unit->spd; 
	boxRam.def = unit->def; 
	boxRam.res = unit->res; 
	boxRam.luk = unit->lck; 
	boxRam.lvl = unit->level; 
	boxRam.exp = unit->exp; 
	for (int i = 0; i<5; i++) { 
		boxRam.moves[i] = unit->ranks[i];
	} 
	//SendItemsToConvoy(unit); 
	ClearUnit(unit); // FE8U = 0x80177F5
	return boxRam; 
} 
	
struct Unit* UnpackUnitFromBox(struct Unit* unit, struct BoxUnit boxRam) { 
	unit->pClassData = &NewClassTable[boxRam.classID]; 
	unit->maxHP = 		boxRam.hp ; 
	unit->curHP = 		unit->maxHP; 
	unit->unk3A = 		boxRam.mag; 
	unit->pow = 		boxRam.str; 
	unit->skl = 		boxRam.skl; 
	unit->spd = 		boxRam.spd; 
	unit->def = 		boxRam.def; 
	unit->res = 		boxRam.res; 
	unit->lck = 		boxRam.luk; 
	unit->level = 		boxRam.lvl; 
	unit->exp = 		boxRam.exp; 
	for (int i = 0; i<5; i++) { 
		boxRam.moves[i] = unit->ranks[i];
	} 
	
	// zero things out 
	unit->aiFlag = 0; 
	unit->conBonus = 0; 
	unit->rescueOtherUnit = 0; 
	unit->ballistaIndex = 0; 
	unit->movBonus = 0; 
	for (int i = 0; i<5; i++) { 
		unit->items[i] = 0; 
	}
	for (int i = 5; i<8; i++) { 
		unit->ranks[i] = 0;
	}
	unit->statusIndex = 0; 
	unit->statusDuration = 0; 
	unit->torchDuration = 0; 
	unit->barrierDuration = 0; 
	for (int i = 0; i<6; i++) { 
		unit->supports[i] = 0; 
	}
	unit->unitLeader = 0; 
	unit->supportBits = 0; 
	unit->unk3B = 0; 
	unit->ai3And4 = 0; 
	unit->ai1 = 0; 
	unit->ai1data = 0; 
	unit->ai2 = 0; 
	unit->ai2data = 0; 
	unit->unk46_saved = 0; 
	unit->unk47 = 0; 
	
	
	unit->pMapSpriteHandle = 0; 
	unit->xPos = 63; 
	unit->yPos = 63; 
	unit->state = US_NOT_DEPLOYED; 
	unit->index = GetFreeDeploymentID(); 
	unit->pCharacterData = &gCharacterData[GetFreeUnitID()]; 
	
	SMS_UpdateFromGameData();
	ClearBoxUnit(boxRam); 


	return unit; 
} 





