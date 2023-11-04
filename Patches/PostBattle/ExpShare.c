#include "gbafe.h"
extern int SkillTester(struct Unit* unit, int SkillID); 
extern int ExpShareID_Link; 
extern void* ShareExpEvent; 
extern int IsTrainersTeamDefeated(void); 
extern u8* ExpShareUnitID_Link[]; 
extern u8* ExpShareAmount_Link[]; 
extern u32** TempRamWhileExpShare_Link;
extern u32** TempRamWhileExpShare_Link2;
extern u32** TempRamWhileExpShare_Link3;

void GrantExp(struct Unit* unit) { 
	if (gActiveUnit->level >= unit->level) { 
		if (SkillTester(unit, ExpShareID_Link)) { 
			int expGain = gBattleActor.expGain; 
			
			//gEventSlot[1] = unit->pCharacterData->number; 
			*ExpShareUnitID_Link[0] = unit->pCharacterData->number; 
			//gEventSlot[4] = expGain; 
			*ExpShareAmount_Link[0] = expGain; 
			CallMapEventEngine(&ShareExpEvent, 1);
			//asm("mov r11, r11"); 
		}
	} 
} 

void ExpShareSetupMemorySlots(void) { 
	*TempRamWhileExpShare_Link = gEventSlot[1]; 
	*TempRamWhileExpShare_Link2 = gEventSlot[2]; 
	*TempRamWhileExpShare_Link3 = gEventSlot[4]; 
	gEventSlot[2] = *ExpShareUnitID_Link[0]; 
	gEventSlot[4] = *ExpShareAmount_Link[0]; 
} 
void ExpShareRestoreMemorySlots(void) { 
	gEventSlot[1] = *TempRamWhileExpShare_Link; // -3 (0xFFFD) 
	gEventSlot[2] = *TempRamWhileExpShare_Link2; // unit id 
	gEventSlot[4] = *TempRamWhileExpShare_Link3; // exp 

} 


void ExpShare(struct Unit* actor, struct Unit* target) { 
	if (!(actor->index >> 7) && (gActionData.unitActionType == UNIT_ACTION_COMBAT) && (gBattleActor.expGain)) { // player attacking only 
		InitTargets(actor->xPos, actor->yPos); 
		
		
		
		BmMapFill(gMapRange, 0);
		SetSubjectMap(gMapRange);
		int range = 2; 
		MapAddInRange(actor->xPos, actor->yPos, range, 1); //! FE8U = 0x801AABD
		//MapAddInRange(actor->xPos, actor->yPos, 0, (-1)); 
		MapAddInRange(actor->xPos, actor->yPos, 0, 0); 
		//MapSetInRange(actor->xPos, actor->yPos, range, 1);
		ForEachUnitInRange(GrantExp);
		//ForEachUnitInRange(void(*)(struct Unit*));



	}
} 

