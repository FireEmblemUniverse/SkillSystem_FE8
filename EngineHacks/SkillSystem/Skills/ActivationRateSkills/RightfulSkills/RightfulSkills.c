#include "RightfulSkills.h"

int RightfulKing(int activationChance, struct BattleUnit* unit) {
	return SkillTester(unit,RightfulKingID_Link) ? activationChance+10 : activationChance;
}

int RightfulGod(int activationChance, struct BattleUnit* unit) {
	return SkillTester(unit,RightfulGodID_Link) ? activationChance+30 : activationChance;
}


int RightfulArch(int activationChance, struct BattleUnit* unit) {
	return SkillTester(unit,RightfulArchID_Link) ? 100 : activationChance;	
}
