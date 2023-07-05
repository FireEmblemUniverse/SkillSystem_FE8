#include "gbafe.h"
#include "Boxes.h" 


// on leaving prep: store excess units >30 party size into SRAM 
// new units are added to unit struct ram up to 50 as usual 
// prep displays unit struct ram + temp unit ram 
// starting prep loads temp unit ram with the data from your SRAM 



// need to clear all from save file on new game 
// need to copy over box units when save file is copied, too 



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

int IsBoxFull(int slot) { 
	struct BoxUnit* boxUnitSaved = (void*)PC_GetSaveAddressBySlot(slot); 
	for (int i = 0; i < BoxCapacity; i++) { 
		if (!boxUnitSaved[i].classID)
			return false; 
	} 
	return true; 
} 




struct BoxUnit* GetFreeBoxSlot(int slot) { 
	struct BoxUnit* boxUnitSaved = (void*)PC_GetSaveAddressBySlot(slot); 
	for (int i = 0; i < BoxCapacity; i++) { 
		if ((boxUnitSaved[i].classID == 0) || (boxUnitSaved[i].classID == 0xFF))
			return &boxUnitSaved[i]; 
	} 
	return NULL; 
} 

struct BoxUnit* GetTakenBoxSlot(int slot, int index) { 
	struct BoxUnit* boxUnitSaved = (void*)PC_GetSaveAddressBySlot(slot); 
	int c = 0; 
	for (int i = 0; i < BoxCapacity; i++) { 
		if (boxUnitSaved[i].classID && boxUnitSaved[i].classID != 0xFF) { 
			
			
			if (c == index) { 
				return &boxUnitSaved[i]; 
			} 
			c++; 
		} 
		
	} 
	
	return NULL; 
} 

void ClearAllBoxUnitsASMC(void) { 
	ClearAllBoxUnits(gChapterData.saveSlotIndex);
} 

void ClearAllBoxUnits(int slot) {
	
	struct BoxUnit* boxRam; 
	void* baseRam = PC_GetSaveAddressBySlot(slot); 
	for (int i = 0; i<BoxCapacity; i++) { 
		boxRam = (struct BoxUnit*)baseRam; 
		memset((void*)&boxRam[i], 0,  0x10); 
		//ClearBoxUnit(&boxRam[i]);
	}
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


void RelocateUnitsPast50(void) { 
	memcpy((void*)&PCBoxUnitsBuffer[0], (void*)&gUnitArrayBlue[50], 0x48*12);
	memset(&gUnitArrayBlue[51], 0, 0x48*12); 
} 

void ClearPCBoxUnitsBuffer(void) { 
	memset((void*)&PCBoxUnitsBuffer[0], 0, BoxBufferCapacity*0x48);
} 

extern struct Unit unit[62]; // gGenericBuffer 0x2020188
void DeploySelectedUnits() { 
	//asm("mov r11, r11");
	
	//struct Unit unit[50] = (struct Unit*)&gGenericBuffer[0];
	//struct Unit unit[50] = (void*)gGenericBuffer;
	struct Unit* unitTemp;
	
	memcpy((void*)&unit[0], (void*)&gUnitArrayBlue[0], 0x48*62); // move all units to the stack 
	memset(&gUnitArrayBlue[0], 0, 0x48*62); 
	
	
	for (int i = 0; i<50; i++) { // move units that were deployed back into unit struct ram 
		if ((unit[i].pCharacterData) && (!(unit[i].state & US_NOT_DEPLOYED))) { 
			memcpy(GetFreeBlueUnit(), (void*)&unit[i], 0x48);
			ClearUnit(&unit[i]); 
		}
	} 
	for (int i = 0; i<BoxBufferCapacity; i++) { 
		unitTemp = &PCBoxUnitsBuffer[i]; 
		if ((unitTemp->pCharacterData) && (!(unitTemp->state & US_NOT_DEPLOYED))) {
			memcpy(GetFreeBlueUnit(), (void*)unitTemp, 0x48); // copy unit into a free slot in unit struct ram 
			ClearUnit(unitTemp); 
		}
	}
	
	int c = CountUnitsInUnitStructRam();
	
	for (int i = 0; i<50; i++) { // move units that were undeployed back into unit struct ram until it's full. Then into PC box 
		if ((unit[i].pCharacterData)) { 
			if (c < 50) { 
			memcpy(GetFreeBlueUnit(), (void*)&unit[i], 0x48);
			ClearUnit(&unit[i]); 
			c++; 
			} 
			else {
				memcpy(GetFreeTempUnitAddr(), (void*)&unit[i], 0x48); // copy unit into a free slot in pc 
				ClearUnit(&unit[i]); 
			}
		} 
	} 
	
	

	
} 


void PackUnitIntoBox_ASMC(void) { 
	//struct Unit* unit = GetTakenTempUnitAddr(); 
	int slot = gChapterData.saveSlotIndex; 
	
	struct Unit* unit = GetFreeTempUnitAddr(); 
	
	if (unit) { 
	struct Unit* realUnit = GetUnitStructFromEventParameter(gEventSlot[1]);
	memcpy(unit, realUnit, 0x48);
	ClearUnit(realUnit); 
	PackUnitIntoBox(GetFreeBoxSlot(slot), unit); 
	} 
} 
void UnpackUnitFromBox_ASMC(void) { 
	int slot = gChapterData.saveSlotIndex; 
	//struct Unit* unit = GetUnitStructFromEventParameter(gEventSlot[1]); 
	struct Unit* unit = GetTakenTempUnitAddr();
	UnpackUnitFromBox(GetTakenBoxSlot(slot, 0), unit); 
	memcpy(GetFreeBlueUnit(), (void*)unit, 0x48);
	
	
	//memset((void*)&unit, 0, 0x48);
	ClearUnit(unit); 
	return; 
} 


// ClearUnit(unit); // FE8U = 0x80177F5
		//SMS_UpdateFromGameData();
		//ClearBoxUnit(boxRam); 


int UnpackUnitsFromBox(int slot) { 
	int i, cur = 0; 
	struct Unit* unit; 
	struct BoxUnit* bunit;
	for (i=0; i<BoxCapacity; i++) { 
		bunit = GetTakenBoxSlot(slot, i);
		if (!bunit) {
			break;
		}
		unit = GetFreeTempUnitAddr(); 
		if (!unit) { 
			break;
		}
		cur++;
		UnpackUnitFromBox(bunit, unit); 
		
	} 
	return cur; 
}

void PackUnitsIntoBox(int slot) { 
	ClearAllBoxUnits(slot);
	int i; 
	struct Unit* unit; 
	struct BoxUnit* bunit;
	
	for (i=0; i<BoxCapacity; i++) { 
		bunit = GetFreeBoxSlot(slot);
		if (!bunit) {
			break;
		}
		unit = GetTakenTempUnitAddr(); 
		if (!unit) { 
			break;
		}
		PackUnitIntoBox(bunit, unit); 
		ClearUnit(unit); 
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
	//ClearUnit(unit); 
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
int CountTempUnits(void) {
	int cur = 0;
    int i, last = BoxBufferCapacity;
    for (i = 0; i < last; ++i) {
        struct Unit* unit = GetTempUnit(i);
        if (unit->pCharacterData)
            cur++;
    }
    return cur;
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

