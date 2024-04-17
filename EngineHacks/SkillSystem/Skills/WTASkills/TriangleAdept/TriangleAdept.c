#include "bmunit.h"
#include "bmbattle.h"

// externals
extern bool SkillTester(struct Unit* unit, u8 skillID);
extern u8 TriAdeptID_Link;
extern u8 TriAdeptPlusID_Link;

// function prototypes
void TriangleAdept(struct BattleUnit* bunitA, struct BattleUnit* bunitB);



void TriangleAdept(struct BattleUnit* bunitA, struct BattleUnit* bunitB) {
	
	if (SkillTester(&bunitA->unit, TriAdeptPlusID_Link) || 
		SkillTester(&bunitB->unit, TriAdeptPlusID_Link) ) {
		
		bunitA->wTriangleHitBonus *= 2;
		bunitA->wTriangleDmgBonus *= 2;
		bunitB->wTriangleHitBonus *= 2;
		bunitB->wTriangleDmgBonus *= 2;
		
	}
	
	if (SkillTester(&bunitA->unit, TriAdeptID_Link)) {
	
		bunitA->wTriangleHitBonus *= 2;
		bunitA->wTriangleDmgBonus *= 2;
	
	}
	
	if (SkillTester(&bunitB->unit, TriAdeptID_Link)) {
	
		bunitB->wTriangleHitBonus *= 2;
		bunitB->wTriangleDmgBonus *= 2;
	
	}
	
	
	
	
	
}

