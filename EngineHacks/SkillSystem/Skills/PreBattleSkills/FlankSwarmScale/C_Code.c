#include "gbafe.h" // headers 
extern int SkillTester(struct Unit* unit, int SkillID); 
extern int SwarmID_Link; 
extern int FlankID_Link;
extern int SwarmBonusDamagePercent; 
extern int FlankBonusDamagePercent; 
extern int FlankRequiresSkill_Link; 
extern int MultiscaleID_Link; 


inline const s8* VanillaGetUnitMovementCost(struct Unit* unit) {
    if (unit->state & US_IN_BALLISTA)
        return Unk_TerrainTable_0880BC18;

    switch (gPlaySt.chapterWeatherId) {

    case WEATHER_RAIN:
        return unit->pClassData->pMovCostTable[1];

    case WEATHER_SNOW:
    case WEATHER_SNOWSTORM:
        return unit->pClassData->pMovCostTable[2];

    default:
        return unit->pClassData->pMovCostTable[0];

    } // switch (gPlaySt.chapterWeatherId)
}

// use vanilla version so we don't lag by using hooked versions that accounts for pass etc 
inline s8 Vanilla_CanUnitCrossTerrain(struct Unit* unit, int terrain) {
    const s8* lookup = (s8*)VanillaGetUnitMovementCost(unit);
    return (lookup[terrain] > 0) ? TRUE : FALSE;
}

bool Generic_CanUnitBeOnPos(struct Unit* unit, s8 x, s8 y, int x2, int y2){
	if (x < 0 || y < 0)
		return 0; // position out of bounds
	if (x >= gBmMapSize.x || y >= gBmMapSize.y)
		return 0; // position out of bounds
	if (gBmMapUnit[y][x]) 
		return 0; 
	if (gBmMapHidden[y][x] & 1)
		return 0; // a hidden unit is occupying this position	
	if ((x2 == x) && (y2 == y))
		return 0; // exception / a battle unit is on this tile 
	return Vanilla_CanUnitCrossTerrain(unit, gBmMapTerrain[y][x]); //CanUnitCrossTerrain(unit, gMapTerrain[y][x]);
}

// If an adjacent target is surrounded, +50% damage. 
void SwarmEffect(struct BattleUnit* bunitA, struct BattleUnit* bunitB) {
	if (gBattleStats.config & (BATTLE_CONFIG_REAL | BATTLE_CONFIG_SIMULATE)) {
		if (gBattleStats.range == 1) { 
			if (SkillTester(&bunitB->unit, SwarmID_Link)) { 
				struct Unit* unit = &bunitA->unit;
				int x = unit->xPos; 
				int x2 = bunitB->unit.xPos; 
				int y = unit->yPos; 
				int y2 = bunitB->unit.yPos; 
				// if the target can be on any adjacent position, do nothing 
				if (Generic_CanUnitBeOnPos(unit, x+1, y, x2, y2)) { return; } 
				if (Generic_CanUnitBeOnPos(unit, x-1, y, x2, y2)) { return; } 
				if (Generic_CanUnitBeOnPos(unit, x, y+1, x2, y2)) { return; } 
				if (Generic_CanUnitBeOnPos(unit, x, y-1, x2, y2)) { return; } 
				int dmg = bunitB->battleAttack - bunitA->battleDefense; 
				if (dmg < 0) dmg = 0; 
				int addDmg = ((dmg)*(SwarmBonusDamagePercent))/100; // dmg+(dmg*SwarmBonusDamagePercent/200) for rounding 
				//int addDmg = ((dmg+(dmg*SwarmBonusDamagePercent/200))*(SwarmBonusDamagePercent+100))/100; // dmg+(dmg*SwarmBonusDamagePercent/200) for rounding 
				bunitB->battleAttack += addDmg; 
			}
		} 
	}
}
			
		

// If an ally is on the opposite side of an adjacent target, +25% damage. 
void FlankEffect(struct BattleUnit* bunitA, struct BattleUnit* bunitB) {
	if (gBattleStats.config & (BATTLE_CONFIG_REAL | BATTLE_CONFIG_SIMULATE)) {
		if (gBattleStats.range == 1) { 
			if (SkillTester(&bunitB->unit, FlankID_Link) || (!FlankRequiresSkill_Link)) { 
			
				int activeX = bunitB->unit.xPos; 
				int targetX = bunitA->unit.xPos; 
				int activeY = bunitB->unit.yPos; 
				int targetY = bunitA->unit.yPos; 
				int dirX = activeX - targetX; 
				int dirY = activeY - targetY; 
				int deploymentID = bunitB->unit.index; 
				int allyID = 0; 
				if ((dirX > 0) && (activeX > 1)) allyID = gBmMapUnit[activeY][activeX-2]; 
				if (dirX < 0) allyID = gBmMapUnit[activeY][activeX+2]; 
				if ((dirY > 0) && (activeY > 1)) allyID = gBmMapUnit[activeY-2][activeX]; 
				if (dirY < 0) allyID = gBmMapUnit[activeY+2][activeX]; 
				
				//int allyID = gBmMapUnit[activeY+dirY+dirY][activeX+dirX+dirX]; 
				
				if ((allyID) && (AreUnitsAllied(deploymentID, allyID))) { 
					int dmg = bunitB->battleAttack - bunitA->battleDefense; 
					if (dmg < 0) dmg = 0; 
					//int addDmg = ((dmg+(dmg*FlankBonusDamagePercent/200))*(FlankBonusDamagePercent+100))/100; // dmg+(dmg*FlankBonusDamagePercent/200) for rounding 
					int addDmg = ((dmg)*(FlankBonusDamagePercent))/100; // dmg+(dmg*FlankBonusDamagePercent/200) for rounding 
					bunitB->battleAttack += addDmg; 
				}
				
			
			}
		}
	}
}
		


void MultiscaleEffect(struct BattleUnit* bunitA, struct BattleUnit* bunitB) {
	if (gBattleStats.config & (BATTLE_CONFIG_REAL | BATTLE_CONFIG_SIMULATE)) {
		if (SkillTester(&bunitB->unit, MultiscaleID_Link)) { 
			if (bunitB->hpInitial == bunitB->unit.maxHP) { 
				if (bunitB->unit.curHP == bunitB->unit.maxHP) { 
					int dmg = bunitA->battleAttack - bunitB->battleDefense; 
					if (dmg < 0) dmg = 0; 
					int subDmg = dmg/2; // for rounding 
					bunitA->battleAttack -= subDmg; 
				} 
			} 
		}
	}
} 

