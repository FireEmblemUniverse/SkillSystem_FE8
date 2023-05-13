#include "gbafe.h" 

extern int SkillTester(struct Unit* unit, int id); 
extern int CanUnitDouble(struct BattleUnit* bunitA, struct BattleUnit* bunitB);
extern int KeenFighterID_Link; 
extern int SteadyBrawlerID_Link; 

void KeenFighter(struct BattleUnit* bunitA, struct BattleUnit* bunitB) { 

	if (SkillTester(&bunitB->unit, KeenFighterID_Link)) { 
		// if they can double or have a brave weapon 
		if (CanUnitDouble(bunitA, bunitB) || (GetItemAttributes(bunitA->weaponBefore) & IA_BRAVE)) { 
			int dmg = bunitA->battleAttack - bunitB->battleDefense; 
			if (dmg < 0) dmg = 0; 
			int newDmg = (dmg * 3)/4; 
			bunitB->battleDefense += (dmg-newDmg); 
		} 
	} 
} 

void SteadyBrawler(struct BattleUnit* bunitA, struct BattleUnit* bunitB) { 
	if (SkillTester(&bunitB->unit, SteadyBrawlerID_Link)) { 
		if (gBattleTarget.battleDefense) { // if def isn't calculated yet, do nothing 
			if (CanUnitDouble(bunitB, bunitA)) { 
			int dmg = bunitB->battleAttack - bunitA->battleDefense; 
			if (dmg < 0) dmg = 0; 
			int subDmg = (dmg/4); 
			bunitB->battleAttack -= subDmg; 
			} 
			else { 
				int dmg = bunitB->battleAttack - bunitA->battleDefense; 
				if (dmg < 0) dmg = 0; 
				int addDmg = (dmg+2)/4; // for rounding 
				bunitB->battleAttack += addDmg; 
			} 
		}
	} 
} 






