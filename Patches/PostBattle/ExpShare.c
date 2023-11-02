#include "gbafe.h"
extern int SkillTester(struct Unit* unit, int SkillID); 
extern int ExpShareID_Link; 
extern void* ShareExpEvent; 
extern int IsTrainersTeamDefeated(void); 
void GrantExp(struct Unit* unit) { 
	if (gActiveUnit->level >= unit->level) { 
		if (SkillTester(unit, ExpShareID_Link)) { 
			int expGain = gBattleActor.expGain; 
			gEventSlot[2] = unit->pCharacterData->number; 
			gEventSlot[4] = expGain; 
			CallMapEventEngine(&ShareExpEvent, 1);
			//asm("mov r11, r11"); 
		}
	} 
} 

void ExpShare(struct Unit* actor, struct Unit* target) { 
	if (IsTrainersTeamDefeated()) { return; } 
	if (!(actor->index >> 7) && (gActionData.unitActionType == UNIT_ACTION_COMBAT) && (gBattleActor.expGain)) { // player attacking only 
		InitTargets(actor->xPos, actor->yPos); 
		
		
		
		//BmMapFill(gMapRange, 0);
		//SetSubjectMap(gMapRange);
		int range = 2; 
		MapAddInRange(actor->xPos, actor->yPos, range, 1); //! FE8U = 0x801AABD
		MapAddInRange(actor->xPos, actor->yPos, 0, (-1)); 
		//MapSetInRange(actor->xPos, actor->yPos, range, 1);
		ForEachUnitInRange(GrantExp);
		//ForEachUnitInRange(void(*)(struct Unit*));



	}
} 

