#include "Hero.h"

int HeroSkill(int activationChance, struct BattleUnit* unit) {
	return (unit->unit.curHP <= unit->unit.maxHP/2 && SkillTester(unit,HeroID_Link)) ? activationChance+30 : activationChance;
}
