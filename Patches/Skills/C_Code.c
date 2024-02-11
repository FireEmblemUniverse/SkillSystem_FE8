#include "gbafe.h" // headers 
extern int SkillTester(struct Unit* unit, int SkillID); 
extern int MultiscaleID_Link; 

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


extern const void* ObjTypePalettePLIST[];
void UnpackChapterMapPalette(void) {
	if ((gActiveUnit->pCharacterData) && (gActiveUnit->pClassData->number == MissingnoID_Link)) { 
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
	if (actor->pClassData->number == MissingnoID_Link) { 
		if (gActionData.unitActionType == UNIT_ACTION_COMBAT) { // attacking only 
			
			target->pMapSpriteHandle = actor->pMapSpriteHandle; 
			
		
		
		} 
		//UnpackChapterMapPalette(); 
	}
}

