#include "gbafe.h"
#include "Boxes.h" 


// on saving: units beyond 45 are saved to pc box instead of unit struct ram 
// this way new units shouldn't be deleted on suspend 


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

/*
int IsBoxFull(int slot) { 
	(*ReadSramFast)((void*)PC_GetSaveAddressBySlot(slot), (void*)&unit[0], PCBoxSizeLookup[0]);
	struct BoxUnit* boxUnitSaved = (void*)&unit[0]; 
	
	for (int i = 0; i < BoxCapacity; i++) { 
		if (!boxUnitSaved[i].classID)
			return false; 
	} 
	return true; 
} 
*/




struct BoxUnit* GetFreeBoxSlot(int slot) { 
	struct BoxUnit* boxUnitSaved = (void*)&bunit[0]; 
	
	for (int i = 0; i < BoxCapacity; i++) { 
		if ((boxUnitSaved[i].classID == 0) || (boxUnitSaved[i].classID == 0xFF))
			return &boxUnitSaved[i]; 
	} 
	return NULL; 
} 


struct BoxUnit* GetTakenBoxSlot(int slot, int index) { 
	struct BoxUnit* boxUnitSaved = (void*)&bunit[0]; 
	
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

#ifndef POKEMBLEM_VERSION 
struct BoxUnit* GetCharIDFromBox(int slot, int index) { 
	struct BoxUnit* boxUnitSaved = (void*)&bunit[0]; 
	for (int i = 0; i < BoxCapacity; i++) { 
		if (boxUnitSaved[i].classID && boxUnitSaved[i].classID != 0xFF) { 
			if (boxUnitSaved[i].unitID == index) { 
				return &boxUnitSaved[i]; 
			} 
		} 
		
	} 
	return NULL; 
} 


void EnsureUnitInPartyASMC(void) { 
	int slot = gChapterData.saveSlotIndex;
	int charID = gEventSlot[1];
	gEventSlot[0xC] = EnsureUnitInParty(slot, charID); 
	
} 


int EnsureUnitInParty(int slot, int charID) { 
	(*ReadSramFast)((void*)PC_GetSaveAddressBySlot(slot), (void*)&bunit[0], sizeof(*bunit)*BoxCapacity); // use the generic buffer instead of reading directly from SRAM 
	struct BoxUnit* boxUnitSaved = GetCharIDFromBox(slot, charID);
	int result = false; 
	struct Unit* newUnit; 
	int deploymentID = 0; 
	if (boxUnitSaved) { 
		deploymentID = GetFreeDeploymentID(); 
		newUnit = &gUnitArrayBlue[deploymentID];
		UnpackUnitFromBox((struct BoxUnit*)boxUnitSaved, newUnit); 
		newUnit->index = deploymentID; 
		
		result = true; 
	} 
	if (GetUnitStructFromEventParameter(charID)) { 
		result = true; 
	}

	return result; 
} 
#endif 

void ClearAllBoxUnitsASMC(void) { 
	ClearAllBoxUnits(gChapterData.saveSlotIndex);
} 

void ClearAllBoxUnits(int slot) {
	memset((void*)&bunit[0], 0, PCBoxSizeLookup[0]);
	WriteAndVerifySramFast((void*)&bunit[0], (void*)PC_GetSaveAddressBySlot(slot), PCBoxSizeLookup[0]);
	
	
	//struct BoxUnit* boxRam; 
	//void* baseRam = PC_GetSaveAddressBySlot(slot); 
	//
	//
	//for (int i = 0; i<BoxCapacity; i++) { 
	//	boxRam = (struct BoxUnit*)baseRam; 
	//	//memset((void*)&boxRam[i], 0,  ENTRYSIZE); 
	//	ClearBoxUnit(&boxRam[i]);
	//}
}

#ifdef POKEMBLEM_VERSION
struct BoxUnit* ClearBoxUnit(struct BoxUnit* boxRam) { // unused 
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
#endif 

//extern struct Unit* GetUnitStructFromEventParameter(short index); 

void RelocateUnitsPastThreshold(int startingOffset) { 

	#ifdef POKEMBLEM_VERSION
	// if protag is not in the first 50 units, don't let it go in box 
	struct Unit someUnit;
	someUnit.pCharacterData = 0; 
	struct Unit* protag = GetUnitStructFromEventParameter(ProtagID_Link);
	if (protag && protag->pCharacterData) { 
		memcpy((void*)&someUnit, (void*)protag, 0x48); 
		ClearUnit(protag); 
	} 
	#endif 
	
	memcpy((void*)&PCBoxUnitsBuffer[startingOffset], (void*)&gUnitArrayBlue[PartySizeThreshold], 0x48*(62 - PartySizeThreshold));
	memset(&gUnitArrayBlue[PartySizeThreshold], 0, 0x48*(62 - PartySizeThreshold)); 
	
	#ifdef POKEMBLEM_VERSION
	if (someUnit.pCharacterData) { 
		int deploymentID = GetFreeDeploymentID(); 
		struct Unit* newUnit = &gUnitArrayBlue[deploymentID];
		memcpy((void*)newUnit, (void*)&someUnit, 0x48);
		newUnit->index = deploymentID;  // copy unit into a free slot in unit struct ram 
	} 
	#endif 
	
} 

void ClearPCBoxUnitsBuffer(void) { 
	memset((void*)&PCBoxUnitsBuffer[0], 0, BoxBufferCapacity*0x48);
} 


void DeploySelectedUnits() { 
	//asm("mov r11, r11");
	
	//struct Unit unit[50] = (struct Unit*)&gGenericBuffer[0];
	//struct Unit unit[50] = (void*)gGenericBuffer;
	struct Unit* unitTemp;
	struct Unit* newUnit; 
	int deploymentID = 0; 
	
	memcpy((void*)&unit[0], (void*)&gUnitArrayBlue[0], 0x48*62); // move all units to gGenericBuffer 
	memset(&gUnitArrayBlue[0], 0, 0x48*62); // clear units from unit struct ram 
	
	
	for (int i = 0; i<50; i++) { // move units that were deployed back into unit struct ram 
		if ((unit[i].pCharacterData) && (!(unit[i].state & US_NOT_DEPLOYED))) { 
			deploymentID = GetFreeDeploymentID(); 
			newUnit = &gUnitArrayBlue[deploymentID];
			memcpy((void*)newUnit, (void*)&unit[i], 0x48);
			newUnit->index = deploymentID; 
			
			ClearUnit(&unit[i]); 
		}
	} 
	for (int i = 0; i<BoxBufferCapacity; i++) { 
		unitTemp = &PCBoxUnitsBuffer[i]; 
		if ((unitTemp->pCharacterData) && (!(unitTemp->state & US_NOT_DEPLOYED))) {
			//unitTemp->state &= ~(US_BIT16); // remove "escaped" bitflag 
			deploymentID = GetFreeDeploymentID(); 
			newUnit = &gUnitArrayBlue[deploymentID];
			memcpy((void*)newUnit, (void*)unitTemp, 0x48);
			newUnit->index = deploymentID;  // copy unit into a free slot in unit struct ram 
			ClearUnit(unitTemp); 
		}
	}
	
	int c = CountTotalUnitsInUnitStructRam();
	
	for (int i = 0; i<PartySizeThreshold; i++) { // move units that were undeployed back into unit struct ram until it's full. Then into PC box 
		if ((unit[i].pCharacterData)) { 
			if (c < PartySizeThreshold) { 
			deploymentID = GetFreeDeploymentID(); 
			newUnit = &gUnitArrayBlue[deploymentID];
			memcpy((void*)newUnit, (void*)&unit[i], 0x48);
			newUnit->index = deploymentID;  // copy unit into a free slot in unit struct ram 
			
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


// 0xE00691C 
// 0xE0070BC 
// 2020188

int UnpackUnitsFromBox(int slot) { 
	int i, cur = 0; 
	struct Unit* unit2; 
	struct BoxUnit* bunit2;
	
	// src, dst, size 
	(*ReadSramFast)((void*)PC_GetSaveAddressBySlot(slot), (void*)&bunit[0], sizeof(*bunit)*BoxCapacity); // use the generic buffer instead of reading directly from SRAM 
	
	
	
	for (i=0; i<BoxCapacity; i++) { 
		bunit2 = GetTakenBoxSlot(slot, i); 
		if (!bunit2) {
			break;
		}
		unit2 = GetFreeTempUnitAddr(); 
		if (!unit2) { 
			break;
		}
		cur++;
		
		UnpackUnitFromBox((struct BoxUnit*)&bunit[i], unit2); 
		
	} 
	return cur; 
}

void PackUnitsIntoBox(int slot) { 
	ClearAllBoxUnits(slot);
	int i; 
	struct Unit* unit2; 
	#ifndef POKEMBLEM_VERSION
	struct BoxUnit* bunit2;
	#endif 
	//struct BoxUnit* bunitStart = GetFreeBoxSlot(slot);
	
	for (i=0; i<BoxCapacity; i++) { 
		//bunit2 = GetFreeBoxSlot(slot);
		//if (!bunit2) {
		//	break;
		//}
		unit2 = GetTakenTempUnitAddr(); 
		if (!unit2) { 
			break;
		}
		
		#ifndef POKEMBLEM_VERSION 
		bunit2 = GetCharIDFromBox(slot, unit2->pCharacterData->number); // avoid duplicate char IDs in case EnsureUnitInParty has been used. 
		if (bunit2) { 
			PackUnitIntoBox((void*)bunit2, unit2); 
			ClearUnit(unit2); 
			return; 
		}
		#endif 
		
	
		PackUnitIntoBox((void*)&bunit[i], unit2); 
		// use the generic buffer instead of reading directly from SRAM 
		
		ClearUnit(unit2); 
	} 
	
	return; 
}

#ifdef POKEMBLEM_VERSION 
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
		unit->pClassData = &(*classTablePoin)[boxRam->classID]; 
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
		unit->state = US_NOT_DEPLOYED | US_HIDDEN; // | US_BIT16; // 0x10009 Escaped, Undeployed, Hidden 
		unit->index = 0; //GetFreeDeploymentID(); 
		unit->pCharacterData = &gCharacterData[GetFreeUnitID()]; 
		

	} 

	return unit; 
} 
#endif 

int GetFreeDeploymentID(void) { 
	struct Unit* unit; 
	for (int i = 0; i<0x40; i++) { // deployment ID 
		unit = &gUnitArrayBlue[i]; 
		if (unit->pCharacterData) { 
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

extern s8 IsUnitInCurrentRoster(struct Unit *unit);
int CountAndUndeployTempUnits(void) {
	int cur = 0;
    int i, last = BoxBufferCapacity;
    for (i = 0; i < last; ++i) {
        struct Unit* unit = GetTempUnit(i);
        if (unit->pCharacterData) { 
			if (IsUnitInCurrentRoster(unit)) {
				NewRegisterPrepUnitList(cur, unit);
				cur++;
			}
			else { 
				unit->state |= US_NOT_DEPLOYED; 
			}
		}
    }
    return cur;
}


int CountUnusableStoredUnitsUpToIndex(int index) {
	int cur = 0;
    int i;
    for (i = 0; i < BoxCapacity; ++i) {
        struct Unit* unit = GetTempUnit(i);
        if (unit->pCharacterData) { 
			if (!IsUnitInCurrentRoster(unit)) { 
				cur++;
			}
			else { 
				//cur++;
				if (i >= index) { 
					break; // keep counting until we find a valid unit so we know how many units to skip over 
				} 
			}
			
		} 
    }
    return cur;
}
struct Unit* GetBoxUnitStructFromCharID(int id) { 
	struct Unit* unit = NULL; 
	
	int i;
    for (i = 0; i < BoxBufferCapacity; ++i) {
        unit = GetTempUnit(i);
        if (unit->pCharacterData->number == id) { 
            return unit;
		} 
    }

	return NULL; 
} 

int GetFreeUnitID(void) { 
	struct Unit* unit; 
	int result = 0xFF; 
	for (int i = 1; i<0x40; i++) { // unit ID, not deployment ID 
		unit = GetUnitStructFromEventParameter(i); 
		if (unit) { 
			continue; 
		}
		else {
			unit = GetBoxUnitStructFromCharID(i); 
			if (unit) { 
			continue; 
			} 
			else { 
			result = i; 
			break; 
			} 
		}
	}
	
	
	return result; 
} 



void* PC_GetSaveAddressBySlot(unsigned slot) {
	if (slot > 2) 
		return NULL;

	return (void*)(0xE000000) + PCBoxSaveBlockDecl[slot].offset;
}


#ifndef POKEMBLEM_VERSION 

int GetFlooredWEXP(int inputRank) { 
  int i = 0;
  if (inputRank > 0) i++; // E 
  if (inputRank >= 16) i++;
  if (inputRank >= 31) i++; // D
  if (inputRank >= 51) i++;
  if (inputRank >= 71) i++; // C 
  if (inputRank >= 86) i++;
  if (inputRank >= 101) i++; 
  if (inputRank >= 121) i++; // B 
  if (inputRank >= 151) i++;
  if (inputRank >= 181) i++; // A 
  if (inputRank >= 196) i++;
  if (inputRank >= 211) i++;
  if (inputRank >= 226) i++;
  if (inputRank >= 241) i++;
  if (inputRank >= 251) i = 0xF; // S 
  return i;
} 

int UnpackFlooredWEXP(int value) { 
  if (value == 0)    return 0; // E 
  if (value == 1)    return 1; // E 
  if (value == 2)  return 16;
  if (value == 3)  return 31; // D
  if (value == 4)  return 51;
  if (value == 5)  return 71; // C 
  if (value == 6)  return 86;
  if (value == 7) return 101; 
  if (value == 8) return 121; // B 
  if (value == 9) return 151;
  if (value == 0xA) return 181; // A 
  if (value == 0xB) return 196;
  if (value == 0xC) return 211;
  if (value == 0xD) return 226;
  if (value == 0xE) return 241;
  if (value == 0xF) return 255; // S 
  return 0; 
} 

int GetFlooredSupportEXP(int inputRank) { 
  int i = 0;
  if (inputRank > 0) i++; 
  if (inputRank >= 21) i++;
  if (inputRank >= 41) i++;
  if (inputRank >= 61) i++;
  
  if (inputRank >= 80) i++; 
  if (inputRank >= 81) i++; // C 
  
  if (inputRank >= 101) i++; 
  if (inputRank >= 121) i++; 
  if (inputRank >= 141) i++; 
  
  if (inputRank >= 160) i++; 
  if (inputRank >= 161) i++; // B 
  
  if (inputRank >= 186) i++;
  if (inputRank >= 216) i++; 
  
  if (inputRank >= 240) i++;
  if (inputRank >= 241) i++; // A 
  return i;
} 
int UnpackFlooredSupportEXP(int value) { 
  if (value == 0)    return 0; 
  if (value == 1)    return 1; 
  if (value == 2)  return 21;
  if (value == 3)  return 41; 
  if (value == 4)  return 61;
  if (value == 5)  return 80; // C ready 
  if (value == 6)  return 81; // C 
  if (value == 7) return 101; 
  if (value == 8) return 121; 
  if (value == 9) return 141;
  if (value == 0xA) return 160; // B ready 
  if (value == 0xB) return 161; // B
  if (value == 0xC) return 186;
  if (value == 0xD) return 216;
  if (value == 0xE) return 240; // A ready 
  if (value == 0xF) return 255; // A 
  return 0; 
} 



  struct BoxUnit* PackUnitIntoBox(struct BoxUnit* boxRam, struct Unit* unit) { 
	
	if (SendItemsToConvoy(unit)) { // if convoy is full, do not deposit unit into pc box 
		boxRam->escaped = ((unit->state & US_BIT16) != 0);
		boxRam->departed = ((unit->state & (1<<24)) != 0);
		boxRam->unitID = unit->pCharacterData->number; 
		boxRam->classID = unit->pClassData->number; 
		boxRam->supportBits = unit->supportBits; 
		boxRam->metis = ((unit->state & US_GROWTH_BOOST) != 0);
		boxRam->wexp[0] = GetFlooredWEXP(unit->ranks[0]) | (GetFlooredWEXP(unit->ranks[1]) << 4); 
		boxRam->wexp[1] = GetFlooredWEXP(unit->ranks[2]) | (GetFlooredWEXP(unit->ranks[3]) << 4); 
		boxRam->wexp[2] = GetFlooredWEXP(unit->ranks[4]) | (GetFlooredWEXP(unit->ranks[5]) << 4); 
		boxRam->wexp[3] = GetFlooredWEXP(unit->ranks[6]) | (GetFlooredWEXP(unit->ranks[7]) << 4); 
		boxRam->support0 = GetFlooredSupportEXP(unit->supports[0]);
		boxRam->support1 = GetFlooredSupportEXP(unit->supports[1]);
		boxRam->support2 = GetFlooredSupportEXP(unit->supports[2]);
		boxRam->support3 = GetFlooredSupportEXP(unit->supports[3]);
		boxRam->support4 = GetFlooredSupportEXP(unit->supports[4]);
		boxRam->support5 = GetFlooredSupportEXP(unit->supports[5]);
		boxRam->unitLeader = GetFlooredSupportEXP(unit->unitLeader); 
		
		boxRam->conBonus = unit->conBonus < 16 ? unit->conBonus : 15; 
		boxRam->movBonus = unit->movBonus < 16 ? unit->movBonus : 15; 
		
		boxRam->hp = unit->maxHP<127 ? unit->maxHP : 127; 
		boxRam->mag = unit->unk3A < 64 ? unit->unk3A : 63; 
		boxRam->str = unit->pow < 64 ? unit->pow : 63; 
		boxRam->skl = unit->skl < 64 ? unit->skl : 63; 
		boxRam->spd = unit->spd < 64 ? unit->spd : 63; 
		boxRam->def = unit->def < 64 ? unit->def : 63; 
		boxRam->res = unit->res < 64 ? unit->res : 63; 
		boxRam->luk = unit->lck < 64 ? unit->lck : 63;
		boxRam->lvl = unit->level < 127 ? unit->level : 127;
		boxRam->exp = unit->exp < 127 ? unit->exp : 127;
		
	} 
	//ClearUnit(unit); 
	return boxRam; 
} 



struct Unit* UnpackUnitFromBox(struct BoxUnit* boxRam, struct Unit* unit) { 
	if ((boxRam->classID != 0xFF) && (boxRam->classID)) { 
		unit->pCharacterData = &gCharacterData[boxRam->unitID]; 
		unit->pClassData = &(*classTablePoin)[boxRam->classID]; 
		unit->maxHP = 		boxRam->hp; 
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
		if (unit->exp == 127) {
			unit->exp = 255; // prevents levelling up 
		}
		
		for (int i = 0; i<8; i++) { 
			if (i & 1) { 
				unit->ranks[i] = UnpackFlooredWEXP((boxRam->wexp[i/2] & 0xF0) >> 4);
			} 
			else 
				unit->ranks[i] = UnpackFlooredWEXP((boxRam->wexp[i/2] & 0xF) >> 4);
		} 
		
		// zero things out 
		unit->aiFlag = 0; 
		unit->conBonus = boxRam->conBonus; 
		unit->rescueOtherUnit = 0; 
		unit->ballistaIndex = 0; 
		unit->movBonus = boxRam->movBonus; 
		for (int i = 0; i<5; i++) { 
			unit->items[i] = 0; 
		}
		unit->statusIndex = 0; 
		unit->statusDuration = 0; 
		unit->torchDuration = 0; 
		unit->barrierDuration = 0; 
		unit->supports[0] = UnpackFlooredSupportEXP(boxRam->support0); 
		unit->supports[1] = UnpackFlooredSupportEXP(boxRam->support1); 
		unit->supports[2] = UnpackFlooredSupportEXP(boxRam->support2); 
		unit->supports[3] = UnpackFlooredSupportEXP(boxRam->support3); 
		unit->supports[4] = UnpackFlooredSupportEXP(boxRam->support4); 
		unit->supports[5] = UnpackFlooredSupportEXP(boxRam->support5); 
		unit->unitLeader = UnpackFlooredSupportEXP(boxRam->unitLeader); 
		unit->supportBits = boxRam->supportBits; 
		
		
		
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
		unit->state = US_NOT_DEPLOYED | US_HIDDEN | ((boxRam->escaped!=0)<<16) | ((boxRam->departed!=0)<<24) | ((boxRam->metis!=0)<<13); // 0x10009 Escaped, Undeployed, Hidden 
		unit->index = 0; //GetFreeDeploymentID(); // maybe important 
		
		

	} 

	return unit; 
} 
#endif 


