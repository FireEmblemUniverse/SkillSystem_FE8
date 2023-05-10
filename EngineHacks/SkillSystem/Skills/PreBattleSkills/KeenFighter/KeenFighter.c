#include "gbafe.h" 

extern int SkillTester(struct Unit* unit, int id); 
extern int CanUnitDouble(struct BattleUnit* bunitA, struct BattleUnit* bunitB);
extern int KeenFighterID_Link; 



void KeenFighter(struct BattleUnit* bunitA, struct BattleUnit* bunitB) { 

	if (SkillTester(&bunitB->unit, KeenFighterID_Link)) { 
		// if they can double or have a brave weapon 
		if (CanUnitDouble(bunitA, bunitB) || (GetItemAttributes(bunitA->weaponBefore) & IA_BRAVE)) { 
			int dmg = bunitA->battleAttack - bunitB->battleDefense; // : 0; // min 0 
			if (dmg < 0) dmg = 0; 
			int newDmg = (dmg * 3)/4; 
			bunitB->battleDefense += (dmg-newDmg); 
		} 
	} 
} 





