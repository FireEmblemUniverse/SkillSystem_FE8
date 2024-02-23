#include "gbafe.h" // headers 
extern int SkillTester(struct Unit* unit, int SkillID); 
extern int SwarmID_Link; 
extern int FlankID_Link;
extern int SwarmBonusDamagePercent; 
extern int FlankBonusDamagePercent; 
extern int FlankRequiresSkill_Link; 
extern int MultiscaleID_Link; 


// use vanilla version so we don't lag by using hooked versions that accounts for pass etc 
inline s8 Vanilla_CanUnitCrossTerrain(struct Unit* unit, int terrain) {
    const s8* lookup = (s8*)GetUnitMovementCost(unit);
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

extern int MissingnoID_Link; 
extern int ShouldWeaponHaveStabBonus(int wep, int classID); 
extern int SilphScopeID_Link; 

void SilphScopeEffect(struct BattleUnit* bunitA, struct BattleUnit* bunitB) {
	if (gBattleStats.config & (BATTLE_CONFIG_REAL | BATTLE_CONFIG_SIMULATE)) {
		
		if (ShouldWeaponHaveStabBonus(bunitB->weaponBefore, bunitB->unit.pClassData->number)) { 
			if (SkillTester(&bunitB->unit, SilphScopeID_Link)) { 
				int effectiveness = IsItemEffectiveAgainst(bunitB->weaponBefore, &bunitA->unit); 
				if (effectiveness) { 
					if ((effectiveness != 1) && (effectiveness != 2) && (effectiveness != 7) && (effectiveness != 9)) { 
						bunitB->battleEffectiveCritRate = 100; 
						bunitB->battleCritRate = 200; 
					}
				}				
			}
		}
	}
} 

extern const void* ObjTypePalettePLIST[];
void UnpackChapterMapPalette(void) {
	if ((gActiveUnit) && (gActiveUnit->pCharacterData) && (gActiveUnit->pClassData->number == MissingnoID_Link)) { 
		ApplyPalettes(
			//gChapterDataAssetTable[GetROMChapterStruct(NextRN_N(gPlaySt.chapterIndex))->map.paletteId],
			ObjTypePalettePLIST[GetROMChapterStruct(NextRN_N(99))->map.paletteId],
			6, 10); // TODO: palette id constant?
		return; 
	}
	
    ApplyPalettes(
        ObjTypePalettePLIST[GetROMChapterStruct(gPlaySt.chapterIndex)->map.paletteId],
        6, 10); // TODO: palette id constant?
}



void MissingnoEffect(struct Unit* actor, struct Unit* target) { 
	if (gActionData.unitActionType == UNIT_ACTION_COMBAT) { // attacking only 
		if ((actor->pClassData->number == MissingnoID_Link) || (target->pClassData->number == MissingnoID_Link)) { 	
			for (int i = 4; i>0; i--) { // dupe items
				if (!actor->items[i]) { 
					actor->items[i] = actor->items[(4-i)]; 
				} 
				if (!target->items[i]) { 
					target->items[i] = target->items[(4-i)]; 
				} 
			} 
			for (int i = 1; i<5; i++) { 
				if (!actor->items[i]) { 
					actor->items[i] = actor->items[i-1]; 
				} 
				if (!target->items[i]) { 
					target->items[i] = target->items[i-1]; 
				} 
			}
			//UnitRemoveInvalidItems(actor); 
			//UnitRemoveInvalidItems(target); 
			//target->pMapSpriteHandle = actor->pMapSpriteHandle; 
		
		} 
		//UnpackChapterMapPalette(); 
	}
}

