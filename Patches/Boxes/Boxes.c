#include "Boxes.h" 

int SendItemsToConvoy(struct Unit* unit) { 
	for (int i = 0; i<5; i++) { 
		if (unit->items[i]) { 
			if (AddItemToConvoy(unit->items[i]) == (-1)) {
				return false; 
			}
			unit->items[i] = 0; 
		} 
	} 
	return true; 
} 

int IsBoxFull(void) { 
	struct BoxUnit* boxUnitSaved = (void*)PC_GetSaveAddressBySlot(gChapterData.saveSlotIndex); 
	for (int i = 0; i < BoxCapacity; i++) { 
		if (!boxUnitSaved[i].classID)
			return false; 
	} 
	return true; 
} 




struct BoxUnit* GetFreeBoxSlot(void) { 
	struct BoxUnit* boxUnitSaved = (void*)PC_GetSaveAddressBySlot(gChapterData.saveSlotIndex); 
	for (int i = 0; i < BoxCapacity; i++) { 
		if ((boxUnitSaved[i].classID == 0) || (boxUnitSaved[i].classID == 0xFF))
			return &boxUnitSaved[i]; 
	} 
	return NULL; 
} 

struct BoxUnit* GetTakenBoxSlot(void) { 
	struct BoxUnit* boxUnitSaved = (void*)PC_GetSaveAddressBySlot(gChapterData.saveSlotIndex); 
	for (int i = 0; i < BoxCapacity; i++) { 
		if (boxUnitSaved[i].classID && boxUnitSaved[i].classID != 0xFF)
			return &boxUnitSaved[i]; 
	} 
	return NULL; 
} 

struct BoxUnit* ClearBoxUnit(struct BoxUnit* boxRam) { 
	boxRam->classID = 0; 
	boxRam->hp 	= 0; 
	boxRam->mag = 0; 
	boxRam->str = 0;
	boxRam->skl = 0;
	boxRam->spd = 0;
	boxRam->def = 0;
	boxRam->res = 0;
	boxRam->luk = 0;
	boxRam->lvl = 0; 
	boxRam->exp = 0;
	return boxRam; 
} 


// need to clear all from save file on new game 
// need to copy over box units when save file is copied, too 

void ClearPCBoxUnitsBuffer(void) { 
	memset((void*)&PCBoxUnitsBuffer[0], 0, BoxBufferCapacity*0x48);
} 


void PackUnitIntoBox_ASMC(void) { 
	//struct Unit* unit = GetTakenTempUnitAddr(); 
	struct Unit* unit = GetFreeTempUnitAddr(); 
	
	if (unit) { 
	struct Unit* realUnit = GetUnitStructFromEventParameter(gEventSlot[1]);
	memcpy(unit, realUnit, 0x48);
	ClearUnit(realUnit); 
	PackUnitIntoBox(GetFreeBoxSlot(), unit); 
	} 
} 
void UnpackUnitFromBox_ASMC(void) { 
	//struct Unit* unit = GetUnitStructFromEventParameter(gEventSlot[1]); 
	struct Unit* unit = GetTakenTempUnitAddr();
	UnpackUnitFromBox(GetTakenBoxSlot(), unit); 
	memcpy(GetFreeBlueUnit(), (void*)unit, 0x48);
	
	
	//memset((void*)&unit, 0, 0x48);
	ClearUnit(unit); 
	return; 
} 


// ClearUnit(unit); // FE8U = 0x80177F5
		//SMS_UpdateFromGameData();
		//ClearBoxUnit(boxRam); 


void UnpackUnitsFromBox(void) { 
	int i; 
	struct Unit* unit; 
	struct BoxUnit* bunit;
	for (i=0; i<BoxCapacity; i++) { 
		bunit = GetTakenBoxSlot();
		if (!bunit) {
			break;
		}
		unit = GetFreeTempUnitAddr(); 
		if (!unit) { 
			break;
		}
		UnpackUnitFromBox(bunit, unit); 
	} 
	return; 
}

void PackUnitsIntoBox(void) { 
	int i; 
	struct Unit* unit; 
	struct BoxUnit* bunit;
	for (i=0; i<BoxCapacity; i++) { 
		bunit = GetFreeBoxSlot();
		if (!bunit) {
			break;
		}
		unit = GetTakenTempUnitAddr(); 
		if (!unit) { 
			break;
		}
		PackUnitIntoBox(bunit, unit); 
	} 
	return; 
}

	
//struct BoxUnit PackUnitIntoBox(struct BoxUnit boxRam[], struct Unit* unit) { 
  struct BoxUnit* PackUnitIntoBox(struct BoxUnit* boxRam, struct Unit* unit) { 
	if (SendItemsToConvoy(unit)) { // if convoy is full, do not deposit unit into pc box 
		boxRam->classID = unit->pClassData->number; 
		boxRam->hp = unit->maxHP; 
		boxRam->mag = unit->unk3A; 
		boxRam->str = unit->pow; 
		boxRam->skl = unit->skl; 
		boxRam->spd = unit->spd; 
		boxRam->def = unit->def; 
		boxRam->res = unit->res; 
		boxRam->luk = unit->lck; 
		boxRam->lvl = unit->level; 
		boxRam->exp = unit->exp; 
		for (int i = 0; i<5; i++) { 
			boxRam->moves[i] = unit->ranks[i];
		} 
		
	} 
	return boxRam; 
} 
	
struct Unit* UnpackUnitFromBox(struct BoxUnit* boxRam, struct Unit* unit) { 
	if ((boxRam->classID != 0xFF) && (boxRam->classID)) { 
		unit->pClassData = &NewClassTable[boxRam->classID]; 
		unit->maxHP = 		boxRam->hp ; 
		unit->curHP = 		unit->maxHP; 
		unit->unk3A = 		boxRam->mag; 
		unit->pow = 		boxRam->str; 
		unit->skl = 		boxRam->skl; 
		unit->spd = 		boxRam->spd; 
		unit->def = 		boxRam->def; 
		unit->res = 		boxRam->res; 
		unit->lck = 		boxRam->luk; 
		unit->level = 		boxRam->lvl; 
		unit->exp = 		boxRam->exp; 
		for (int i = 0; i<5; i++) { 
			unit->ranks[i] = boxRam->moves[i];
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
		unit->state = US_NOT_DEPLOYED | US_HIDDEN | US_BIT16; // 0x10009 Escaped, Undeployed, Hidden 
		unit->index = GetFreeDeploymentID(); 
		unit->pCharacterData = &gCharacterData[GetFreeUnitID()]; 
		

	} 

	return unit; 
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



inline struct Unit* GetTempUnit(int i) { 
	return &PCBoxUnitsBuffer[i]; 
} 

struct Unit* GetFreeTempUnitAddr(void) {
    int i, last = BoxBufferCapacity;
    for (i = 0; i < last; ++i) {
        struct Unit* unit = GetTempUnit(i);

        if (unit->pCharacterData == NULL)
            return unit;
    }
    return NULL;
}

struct Unit* GetTakenTempUnitAddr(void) {
    int i, last = BoxBufferCapacity;
    for (i = 0; i < last; ++i) {
        struct Unit* unit = GetTempUnit(i);
        if (unit->pCharacterData)
            return unit;
    }
    return NULL;
}


int GetFreeUnitID(void) { 
	struct Unit* unit; 
	for (int i = 1; i<0x40; i++) { // unit ID, not deployment ID 
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



void* PC_GetSaveAddressBySlot(unsigned slot) {
	if (slot > 2) 
		return NULL;

	return (void*)(0xE000000) + PCBoxSaveBlockDecl[slot].offset;
}

