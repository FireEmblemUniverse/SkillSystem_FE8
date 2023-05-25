#include "gbafe.h"
extern int SkillTester(struct Unit* unit, int SkillID); 
extern int ExpShareID_Link; 

void GrantExp(struct Unit* unit) { 
	if (SkillTester(unit, ExpShareID_Link)) { 
		asm("mov r11, r11"); 

	} 
} 

void ExpShare(struct Unit* actor, struct Unit* target) { 

	if ((actor->index >> 7) && (gActionData.unitActionType == UNIT_ACTION_COMBAT)) { // player attacking only 
		BmMapFill(gMapRange, 0);
		SetSubjectMap(gMapRange);
		//MapAddInRange(int x, int y, int range, int value); //! FE8U = 0x801AABD
		int range = 2; 
		MapSetInRange(actor->xPos, actor->yPos, range, 1);
		ForEachUnitInRange(void(*)GrantExp);
		//ForEachUnitInRange(void(*)(struct Unit*));



	}
} 

