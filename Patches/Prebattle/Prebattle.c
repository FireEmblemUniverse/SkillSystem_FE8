#include "gbafe.h"
extern int SkillTester(struct Unit* unit, int SkillID); 
extern int ScaledUpID_Link; 

// deal 20% more dmg 
void ScaledUp(struct BattleUnit* bunitA, struct BattleUnit* bunitB) { 
	if (SkillTester(&bunitB->unit, ScaledUpID_Link)) { 
		if (gBattleTarget.battleDefense) { // if def isn't calculated yet, do nothing 
			int dmg = bunitB->battleAttack - bunitA->battleDefense; 
			if (dmg < 0) dmg = 0; 
			int addDmg = (dmg+2)/5; // for rounding 
			bunitB->battleAttack += addDmg; 
		
		} 
	} 
} 

