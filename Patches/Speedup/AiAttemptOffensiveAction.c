
#define POKEMBLEM_VERSION 
//#define APPROXIMATE_BEST_TARGET
#define USE_CLOSEST_TARGET


#include "Ai.h" 

extern void TurnOnBGMFlag(void); 
// AiSimulateBestBattleAgainstTarget takes ~100k cycles before getting to: 
	// AiSimulateBattleAgainstTargetAtPosition->
// BattleGenerateSimulationInternal calls InitBattleUnit twice  which is a little expensive at 100k 

// https://github.com/FireEmblemUniverse/fireemblem8u/blob/b9ad9bcafd9d4ecb7fc13cc77a464e2a82ac8338/src/bmbattle.c#L181C6-L181C20
// BattleGenerate takes ~600k cycles:
// ComputeBattleUnitStats ~200k twice largely due to ~100k from MakeAuraSkillBuffer - now down to 20k by only making it for players 
// BattleUnwind ~150k 

// after acting: 8037745 HandlePostActionTraps ~550k 
// 801D301 MaybeRunPostActionEvents ~880k 
// 803A63D Procs CpPerform CallASM ~700k 

extern u8 BossChapterTable[]; 

//! FE8U = 0x0803D450
// NOTE: Shade+ and Steal+ hook this function 
// WARNING: Barricade normally sets r11 to 0 despite not pushing / popping r11  
// Please comment out asm("mov r11, r0"); from EngineHacks\Necessary\CalcLoops\CanUnitDoubleCalcLoop and make 
// can break at start and end of 8039858
s8 NewAiAttemptOffensiveAction(s8 (*isEnemy)(struct Unit* unit)) {
	//asm("mov r11, r11"); 
    struct AiCombatSimulationSt tmpResult;
    struct AiCombatSimulationSt finalResult;

    int i;
	struct Unit* actor = gActiveUnit; 
	

    finalResult.targetId = 0;
    finalResult.score = 0;
	finalResult.itemSlot = 0; // so compiler is happy 
	finalResult.xMove = 0; // so compiler is happy 
	finalResult.yMove = 0; // so compiler is happy 

#ifndef POKEMBLEM_VERSION 
    if (actor->state & US_IN_BALLISTA) {
        BmMapFill(gBmMapMovement, -1);
        gBmMapMovement[actor->yPos][actor->xPos] = 0;

        if (GetRiddenBallistaAt(actor->xPos, actor->yPos) != 0) {
            goto _0803D628;
        }

        TryRemoveUnitFromBallista(actor);
    } 
	if (UNIT_CATTRIBUTES(actor) & CA_STEAL) {

		if (GetUnitItemCount(actor) < UNIT_ITEM_COUNT) {
			GenerateUnitMovementMap(actor);
			MarkMovementMapEdges();

			if (AiAttemptStealActionWithinMovement() == 1) {
				return 0;
			}
		}
	}
#endif 

	if (gAiState.flags & AI_FLAG_1) {
		BmMapFill(gBmMapMovement, -1); 
		gBmMapMovement[actor->yPos][actor->xPos] = 0;
	} else {
		GenerateUnitMovementMap(actor);
	}

#ifndef POKEMBLEM_VERSION
	if (UnitHasMagicRank(actor)) {
		GenerateMagicSealMap(-1);
	}
#endif 

    SetWorkingBmMap(gBmMapRange);

	#ifdef USE_CLOSEST_TARGET
	int xPos = actor->xPos; 
	int yPos = actor->yPos; 
	int bestDist = 0xFF; 
	int currDist; 
	int numberOfTargetsTried = 0; 
	int triedUnit = false; 
	int actorUID = actor->pCharacterData->number; 
	#endif 


	int startID = 1; int endID = 0x7F; // actor is an enemy so they target players/npcs 
	if (AreUnitsAllied(actor->index, 1)) { 
		startID = 0x80; endID = 0xC0; // actor is a player/npc so they target enemies 
	} 
	//else { 
		//startID = 1; endID = 0x7F; // actor is an enemy so they target players/npcs 
	//} 
	for (int uid = startID; uid < endID; uid++) {
		if (triedUnit) { 
			if (numberOfTargetsTried >= 7) { break; } // against bosses we'll check everyone 
			if ((BossChapterTable[gPlaySt.chapterIndex] == 0) && (numberOfTargetsTried >= 3)) { break; } // only bother looking at the first 3 valid targets as to not cause lag
			//else 
			numberOfTargetsTried++; 
			triedUnit = false; 

		} 
		
		
		
		struct Unit* unit = GetUnit(uid);

		if (!UNIT_IS_VALID(unit)) {
			continue;
		}

		if (unit->state & (US_HIDDEN | US_DEAD | US_RESCUED | US_BIT16)) {
			continue;
		}
		
		#ifdef USE_CLOSEST_TARGET 
		 
		currDist = abs(unit->xPos - xPos) + abs(unit->yPos - yPos);
		if (actorUID < 0xA0) { 
			if (currDist >= bestDist) { // wild pokemon skip units that are farther away from them (up to 3 units are checked) 
				continue; 
			} 
		} 
		#endif 

		if (!isEnemy(unit)) { // This checks specific unit IDs to not target as well as AreUnitsAllied 
			continue;
		}
		
		for (i = 0; i < 5; i++) {
			u16 item = actor->items[i];

			if (item == 0) {
				break;
			}

	#ifndef POKEMBLEM_VERSION
			if (item == ITEM_NIGHTMARE) {
				continue;
			}
	#endif 

			if (!CanUnitUseWeapon(actor, item)) {
				continue;
			}

			tmpResult.itemSlot = i;
			if (!AiReachesByBirdsEyeDistance(actor, unit, item)) {
				continue;
			}

			AiFillReversedAttackRangeMap(unit, item);

			tmpResult.targetId = unit->index;

			if (!AiSimulateBestBattleAgainstTarget(&tmpResult)) { // 800k cycles per unit 
				continue;
			}
			#ifdef USE_CLOSEST_TARGET 
			triedUnit = true; 
			#endif 

			if (tmpResult.score >= finalResult.score) {
				finalResult = tmpResult;
				finalResult.itemSlot = i;
				
				#ifdef USE_CLOSEST_TARGET 
				bestDist = currDist; 
				//if (bestDist <= 1) { 
					//break; 
				//} 
				#endif 
			}
	}






    }

#ifndef POKEMBLEM_VERSION 
_0803D628:
    if (UNIT_CATTRIBUTES(actor) & CA_BALLISTAE) {
        if (AiAttemptBallistaCombat(isEnemy, &tmpResult) == 1) {
            if (tmpResult.score >= finalResult.score) {
                finalResult = tmpResult;
            }
        }
    }
#endif 

    if ((finalResult.score != 0) || (finalResult.targetId != 0)) {
        AiSetDecision(finalResult.xMove, finalResult.yMove, 1, finalResult.targetId, finalResult.itemSlot, 0, 0);
		TurnOnBGMFlag(); 

#ifndef POKEMBLEM_VERSION 
        if ((s8)finalResult.itemSlot != -1) {
            TryRemoveUnitFromBallista(actor);
        }
#endif 
    }
	//asm("mov r11, r11"); 
	return 0; // added so the compiler doesn't get mad at me 
}

/*
inline s8 AreUnitsAlliedInline(int left, int right);
inline struct Unit* GetUnitInline(int id);
struct Unit* CONST_DATA gUnitLookup[0x100]; 
inline struct Unit* GetUnitInline(int id) {
    return gUnitLookup[id & 0xFF];
}
inline s8 AreUnitsAlliedInline(int left, int right) {
    int a = left & 0x80;
    int b = right & 0x80;
    return (a == b);
}
*/
