
#include "include/global.h"
#include "include/proc.h"
#include "include/bmunit.h"
#include "include/bmmap.h"
#include "include/bmtrick.h"
#include "include/bmarch.h"
#include "include/bmudisp.h"
#include "include/cp_utility.h"
#include "include/cp_script.h"
#include "include/bmsave.h"
#include "include/constants/classes.h"
#include "include/cp_common.h"

#include "include/bmidoten.h"
#include "include/bmitem.h"
#include "include/bmphase.h"
#include "include/bmbattle.h"
#include "include/cp_data.h"
#include "include/constants/items.h"

#include "include/rng.h"
#include "include/constants/terrains.h"
#include "include/cp_utility.h"

// forward decl.
s8 AiGetChestUnlockItemSlot(u8*);
void SetupUnitStatusStaffAIFlags(struct Unit*, u16);
void SetupUnitHealStaffAIFlags(struct Unit*, u16);
void SaveNumberOfAlliedUnitsIn0To8Range(struct Unit*);

//static const struct AiCombatScoreCoefficients* sCombatScoreCoefficients;

struct AiCombatSimulationSt {
    /* 00 */ u8 xMove;
    /* 01 */ u8 yMove;
    /* 02 */ u8 targetId;
    /* 04 */ u16 itemSlot;
    /* 08 */ u32 score;
};

void AiFillReversedAttackRangeMap(struct Unit*, u16);
s8 AiAttemptBallistaCombat(s8 (*isEnemy)(struct Unit* unit), struct AiCombatSimulationSt*);
s8 AiAttemptStealActionWithinMovement(void);
s8 AiSimulateBestBattleAgainstTarget(struct AiCombatSimulationSt*);
s8 AiSimulateBestBallistaBattleAgainstTarget(struct AiCombatSimulationSt*, u16);
u32 AiGetCombatPositionScore(int, int, struct AiCombatSimulationSt*);
s8 AiSimulateBattleAgainstTargetAtPosition(struct AiCombatSimulationSt*);
void AiComputeCombatScore(struct AiCombatSimulationSt*);
int AiGetInRangeCombatPositionScoreComponent(int, int, struct Unit*);



// can break at start and end of 8039858 CpOrderFunc_BeginDecide to see how much lag there is 
// see https://github.com/FireEmblemUniverse/fireemblem8u/blob/b9ad9bcafd9d4ecb7fc13cc77a464e2a82ac8338/src/cp_decide.c#L71
// CpDecideMain at 8039B00 
// AiTryDoOffensiveAction 0x803D450 - 0x803D880 
// AiTryMoveTowards 0x803BA08 
// if these function are optimized, the ai will be faster 



void CpDecide_Main(ProcPtr proc)
{
	//asm("mov r11, r11"); 
next_unit:
    gAiState.decideState = 0;

    if (*gAiState.unitIt)
    {
        gAiState.unk7C = 0;

        gActiveUnitId = *gAiState.unitIt;
        gActiveUnit = GetUnit(gActiveUnitId);

        if (gActiveUnit->state & (US_DEAD | US_UNSELECTABLE) || !gActiveUnit->pCharacterData)
        {
            gAiState.unitIt++;
            goto next_unit;
        }

        do
        {
			// These 3 add some lag - maybe they can be done conditionally?
            RefreshEntityBmMaps(); 
            RenderBmMap();
            RefreshUnitSprites();

            AiUpdateNoMoveFlag(gActiveUnit);

            gAiState.combatWeightTableId = (gActiveUnit->ai3And4 & 0xF8) >> 3;

            gAiState.dangerMapFilled = FALSE;
            AiInitDangerMap(); // This causes some lag (but has been optimized) 

            AiClearDecision();
			//asm("mov r11, r11"); 
            AiDecideMainFunc();  // Lag from ai scripts eg. 
				// AiTryDoOffensiveAction 0x803D450
				// AiTryMoveTowards 0x803BA08 
/* 
// Try each AI until one is accepted 
static DecideFunc CONST_DATA sDecideFuncList[] =
{
    DecideHealOrEscape,
    DecideScriptA,
    DecideScriptB,
    DecideSpecialItems,
    NULL, NULL,
};

void AiDecideMain(void)
{
    while (sDecideFuncList[gAiState.decideState] && !gAiDecision.actionPerformed)
    {
        sDecideFuncList[gAiState.decideState++]();
    }
}
*/

            gActiveUnit->state |= US_HAS_MOVED_AI;

            if (!gAiDecision.actionPerformed ||
                (gActiveUnit->xPos == gAiDecision.xMove && gActiveUnit->yPos == gAiDecision.yMove && gAiDecision.actionId == AI_ACTION_NONE))
            {
                // Ignoring actions that are just moving to the same square

                gAiState.unitIt++;
                Proc_Goto(proc, 0);
				//goto next_unit; // maybe faster? 
            }
            else
            {
                gAiState.unitIt++;
				//asm("mov r11, r11"); 
                Proc_StartBlocking(gProcScr_CpPerform, proc);
            }
        } while (0);
    }
    else
    {
        Proc_End(proc);
    }
}


//! FE8U = 0x0803D450
// NOTE: Shade+ and Steal+ hook this function 
// WARNING: Barricade normally sets r11 to 0 despite not pushing / popping r11  
// Please comment out asm("mov r11, r0"); from EngineHacks\Necessary\CalcLoops\CanUnitDoubleCalcLoop and make 
s8 AiAttemptOffensiveAction(s8 (*isEnemy)(struct Unit* unit)) {
    struct AiCombatSimulationSt tmpResult;
    struct AiCombatSimulationSt finalResult;

    int i;

    finalResult.targetId = 0;
    finalResult.score = 0;

    if (gActiveUnit->state & US_IN_BALLISTA) {
        BmMapFill(gBmMapMovement, -1);
        gBmMapMovement[gActiveUnit->yPos][gActiveUnit->xPos] = 0;

        if (GetRiddenBallistaAt(gActiveUnit->xPos, gActiveUnit->yPos) != 0) {
            goto _0803D628;
        }

        TryRemoveUnitFromBallista(gActiveUnit);
    } else {
        if (UNIT_CATTRIBUTES(gActiveUnit) & CA_STEAL) {

            if (GetUnitItemCount(gActiveUnit) < UNIT_ITEM_COUNT) {
                GenerateUnitMovementMap(gActiveUnit);
                MarkMovementMapEdges();

                if (AiAttemptStealActionWithinMovement() == 1) {
                    return 0;
                }
            }
        }

        if (gAiState.flags & AI_FLAG_1) {
            BmMapFill(gBmMapMovement, -1);
            gBmMapMovement[gActiveUnit->yPos][gActiveUnit->xPos] = 0;
        } else {
            GenerateUnitMovementMap(gActiveUnit);
        }

        if (UnitHasMagicRank(gActiveUnit)) {
            GenerateMagicSealMap(-1);
        }
    }

    SetWorkingBmMap(gBmMapRange);

    for (i = 0; i < UNIT_ITEM_COUNT; i++) {
        u16 item = gActiveUnit->items[i];

        if (item == 0) {
            break;
        }

        if (item == ITEM_NIGHTMARE) {
            continue;
        }

        if (!CanUnitUseWeapon(gActiveUnit, item)) {
            continue;
        }

        tmpResult.itemSlot = i;

        {
            int uid;
            for (uid = 1; uid < 0xC0; uid++) {
                struct Unit* unit = GetUnit(uid);

                if (!UNIT_IS_VALID(unit)) {
                    continue;
                }

                if (unit->state & (US_HIDDEN | US_DEAD | US_RESCUED | US_BIT16)) {
                    continue;
                }

                if (!isEnemy(unit)) {
                    continue;
                }
                if (!AiReachesByBirdsEyeDistance(gActiveUnit, unit, item)) {
                    continue;
                }

                AiFillReversedAttackRangeMap(unit, item);

                tmpResult.targetId = unit->index;

                if (!AiSimulateBestBattleAgainstTarget(&tmpResult)) {
                    continue;
                }

                if (tmpResult.score >= finalResult.score) {
                    finalResult = tmpResult;
                    finalResult.itemSlot = i;
                }
            }
        }
    }

_0803D628:
    if (UNIT_CATTRIBUTES(gActiveUnit) & CA_BALLISTAE) {
        if (AiAttemptBallistaCombat(isEnemy, &tmpResult) == 1) {
            if (tmpResult.score >= finalResult.score) {
                finalResult = tmpResult;
            }
        }
    }

    if ((finalResult.score != 0) || (finalResult.targetId != 0)) {
        AiSetDecision(finalResult.xMove, finalResult.yMove, 1, finalResult.targetId, finalResult.itemSlot, 0, 0);

        if ((s8)finalResult.itemSlot != -1) {
            TryRemoveUnitFromBallista(gActiveUnit);
        }
    }
	return 0; // added so the compiler doesn't get mad at me 
}



//! FE8U = 0x0803BA08
// NOTE: MSG/3rdParty/InjectMovGetters hooks this function 
void AiTryMoveTowards(s16 x, s16 y, u8 action, u8 maxDanger, u8 unk) {
    s16 ix;
    s16 iy;

    u8 bestRange;

    s16 xOut = 0;
    s16 yOut = 0;

    if ((gActiveUnit->xPos == x) && (gActiveUnit->yPos == y))  {
        AiSetDecision(gActiveUnit->xPos, gActiveUnit->yPos, action, 0, 0, 0, 0);
        return;
    }

    if (unk) {
        GenerateExtendedMovementMapOnRange(x, y, GetUnitMovementCost(gActiveUnit));
    } else {
        sub_80410C4(x, y, gActiveUnit);
    }

    GenerateUnitMovementMap(gActiveUnit);

    bestRange = gBmMapRange[gActiveUnit->yPos][gActiveUnit->xPos];
    xOut = -1;

    for (iy = gBmMapSize.y - 1; iy >= 0; iy--) {
        for (ix = gBmMapSize.x - 1; ix >= 0; ix--) {
            if (gBmMapMovement[iy][ix] > MAP_MOVEMENT_MAX) {
                continue;
            }

            if (gBmMapUnit[iy][ix] != 0 && gBmMapUnit[iy][ix] != gActiveUnitId) {
                continue;
            }

            if (maxDanger == 0) {
                if (UNIT_MOV(gActiveUnit) < gAiState.bestBlueMov && gBmMapOther[iy][ix] != 0) {
                    continue;
                }
            }

            if (!AiCheckDangerAt(ix, iy, maxDanger)) {
                continue;
            }

            if (gBmMapRange[iy][ix] > bestRange) {
                continue;
            }

            bestRange = gBmMapRange[iy][ix];
            xOut = ix;
            yOut = iy;
        }
    }

    if (xOut >= 0) {
        AiSetDecision(xOut, yOut, action, 0, 0, 0, 0);
    }

    return;
}



