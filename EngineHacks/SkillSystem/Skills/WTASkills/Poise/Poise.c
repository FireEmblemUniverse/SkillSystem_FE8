#include "bmunit.h"
#include "bmbattle.h"

// externals
extern bool SkillTester(struct Unit* unit, u8 skillID);
extern u8 PoiseID_Link;

// function prototypes
void Poise(struct BattleUnit* bunitA, struct BattleUnit* bunitB);



void Poise(struct BattleUnit* bunitA, struct BattleUnit* bunitB) {
	
	//check if defender has poise
	if (SkillTester((struct Unit*)bunitB,PoiseID_Link) && (bunitA->wTriangleHitBonus > 0)) {
		bunitA->wTriangleHitBonus = 0;
	}
	
	//check if attacker has poise
	if (SkillTester((struct Unit*)bunitA,PoiseID_Link) && (bunitB->wTriangleHitBonus > 0)) {
		bunitB->wTriangleHitBonus = 0;
	}
	
	
}

