

//#define POKEMBLEM_VERSION 

#define SHORTCALL __attribute__((short_call))
#define CONSTFUNC __attribute__((const))



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
int BuildAiUnitList(void);
void SortAiUnitList(int count);







#ifdef POKEMBLEM_VERSION 
void BmMapFill(u8** map, int value) SHORTCALL;
void GenerateUnitMovementMap(struct Unit* unit) SHORTCALL;
void SetWorkingBmMap(u8** map) SHORTCALL;
s8 CanUnitUseWeapon(struct Unit* unit, int item) SHORTCALL CONSTFUNC;
s8 AiReachesByBirdsEyeDistance(struct Unit* unit, struct Unit* other, u16 item) SHORTCALL CONSTFUNC;
void AiFillReversedAttackRangeMap(struct Unit*, u16) SHORTCALL;
s8 AiSimulateBestBattleAgainstTarget(struct AiCombatSimulationSt*) SHORTCALL;
void AiSetDecision(s16 xMove, s16 yMove, u8 actionId, u8 targetId, u8 itemSlot, u8 xTarget, u8 yTarget) SHORTCALL;
s8 AreUnitsAllied(int left, int right) SHORTCALL CONSTFUNC;
struct Unit* GetUnit(int id) SHORTCALL CONSTFUNC;
#endif 









/*

EWRAM_DATA struct Unit gUnitArrayRed[50]   = {}; // Red units
EWRAM_DATA struct Unit gUnitArrayGreen[20] = {}; // Green units
EWRAM_DATA struct Unit gUnitArrayPurple[5] = {}; // Purple units

struct Unit* CONST_DATA gUnitLookup[0x100] = { // unit lookup
    [FACTION_BLUE + 0x01] = gUnitArrayBlue + 0,
    [FACTION_BLUE + 0x02] = gUnitArrayBlue + 1,
    [FACTION_BLUE + 0x03] = gUnitArrayBlue + 2,
    [FACTION_BLUE + 0x04] = gUnitArrayBlue + 3,
    [FACTION_BLUE + 0x05] = gUnitArrayBlue + 4,
    [FACTION_BLUE + 0x06] = gUnitArrayBlue + 5,
    [FACTION_BLUE + 0x07] = gUnitArrayBlue + 6,
    [FACTION_BLUE + 0x08] = gUnitArrayBlue + 7,
    [FACTION_BLUE + 0x09] = gUnitArrayBlue + 8,
    [FACTION_BLUE + 0x0A] = gUnitArrayBlue + 9,
    [FACTION_BLUE + 0x0B] = gUnitArrayBlue + 10,
    [FACTION_BLUE + 0x0C] = gUnitArrayBlue + 11,
    [FACTION_BLUE + 0x0D] = gUnitArrayBlue + 12,
    [FACTION_BLUE + 0x0E] = gUnitArrayBlue + 13,
    [FACTION_BLUE + 0x0F] = gUnitArrayBlue + 14,
    [FACTION_BLUE + 0x10] = gUnitArrayBlue + 15,
    [FACTION_BLUE + 0x11] = gUnitArrayBlue + 16,
    [FACTION_BLUE + 0x12] = gUnitArrayBlue + 17,
    [FACTION_BLUE + 0x13] = gUnitArrayBlue + 18,
    [FACTION_BLUE + 0x14] = gUnitArrayBlue + 19,
    [FACTION_BLUE + 0x15] = gUnitArrayBlue + 20,
    [FACTION_BLUE + 0x16] = gUnitArrayBlue + 21,
    [FACTION_BLUE + 0x17] = gUnitArrayBlue + 22,
    [FACTION_BLUE + 0x18] = gUnitArrayBlue + 23,
    [FACTION_BLUE + 0x19] = gUnitArrayBlue + 24,
    [FACTION_BLUE + 0x1A] = gUnitArrayBlue + 25,
    [FACTION_BLUE + 0x1B] = gUnitArrayBlue + 26,
    [FACTION_BLUE + 0x1C] = gUnitArrayBlue + 27,
    [FACTION_BLUE + 0x1D] = gUnitArrayBlue + 28,
    [FACTION_BLUE + 0x1E] = gUnitArrayBlue + 29,
    [FACTION_BLUE + 0x1F] = gUnitArrayBlue + 30,
    [FACTION_BLUE + 0x20] = gUnitArrayBlue + 31,
    [FACTION_BLUE + 0x21] = gUnitArrayBlue + 32,
    [FACTION_BLUE + 0x22] = gUnitArrayBlue + 33,
    [FACTION_BLUE + 0x23] = gUnitArrayBlue + 34,
    [FACTION_BLUE + 0x24] = gUnitArrayBlue + 35,
    [FACTION_BLUE + 0x25] = gUnitArrayBlue + 36,
    [FACTION_BLUE + 0x26] = gUnitArrayBlue + 37,
    [FACTION_BLUE + 0x27] = gUnitArrayBlue + 38,
    [FACTION_BLUE + 0x28] = gUnitArrayBlue + 39,
    [FACTION_BLUE + 0x29] = gUnitArrayBlue + 40,
    [FACTION_BLUE + 0x2A] = gUnitArrayBlue + 41,
    [FACTION_BLUE + 0x2B] = gUnitArrayBlue + 42,
    [FACTION_BLUE + 0x2C] = gUnitArrayBlue + 43,
    [FACTION_BLUE + 0x2D] = gUnitArrayBlue + 44,
    [FACTION_BLUE + 0x2E] = gUnitArrayBlue + 45,
    [FACTION_BLUE + 0x2F] = gUnitArrayBlue + 46,
    [FACTION_BLUE + 0x30] = gUnitArrayBlue + 47,
    [FACTION_BLUE + 0x31] = gUnitArrayBlue + 48,
    [FACTION_BLUE + 0x32] = gUnitArrayBlue + 49,
    [FACTION_BLUE + 0x33] = gUnitArrayBlue + 50,
    [FACTION_BLUE + 0x34] = gUnitArrayBlue + 51,
    [FACTION_BLUE + 0x35] = gUnitArrayBlue + 52,
    [FACTION_BLUE + 0x36] = gUnitArrayBlue + 53,
    [FACTION_BLUE + 0x37] = gUnitArrayBlue + 54,
    [FACTION_BLUE + 0x38] = gUnitArrayBlue + 55,
    [FACTION_BLUE + 0x39] = gUnitArrayBlue + 56,
    [FACTION_BLUE + 0x3A] = gUnitArrayBlue + 57,
    [FACTION_BLUE + 0x3B] = gUnitArrayBlue + 58,
    [FACTION_BLUE + 0x3C] = gUnitArrayBlue + 59,
    [FACTION_BLUE + 0x3D] = gUnitArrayBlue + 60,
    [FACTION_BLUE + 0x3E] = gUnitArrayBlue + 61,

    [FACTION_RED + 0x01] = gUnitArrayRed + 0,
    [FACTION_RED + 0x02] = gUnitArrayRed + 1,
    [FACTION_RED + 0x03] = gUnitArrayRed + 2,
    [FACTION_RED + 0x04] = gUnitArrayRed + 3,
    [FACTION_RED + 0x05] = gUnitArrayRed + 4,
    [FACTION_RED + 0x06] = gUnitArrayRed + 5,
    [FACTION_RED + 0x07] = gUnitArrayRed + 6,
    [FACTION_RED + 0x08] = gUnitArrayRed + 7,
    [FACTION_RED + 0x09] = gUnitArrayRed + 8,
    [FACTION_RED + 0x0A] = gUnitArrayRed + 9,
    [FACTION_RED + 0x0B] = gUnitArrayRed + 10,
    [FACTION_RED + 0x0C] = gUnitArrayRed + 11,
    [FACTION_RED + 0x0D] = gUnitArrayRed + 12,
    [FACTION_RED + 0x0E] = gUnitArrayRed + 13,
    [FACTION_RED + 0x0F] = gUnitArrayRed + 14,
    [FACTION_RED + 0x10] = gUnitArrayRed + 15,
    [FACTION_RED + 0x11] = gUnitArrayRed + 16,
    [FACTION_RED + 0x12] = gUnitArrayRed + 17,
    [FACTION_RED + 0x13] = gUnitArrayRed + 18,
    [FACTION_RED + 0x14] = gUnitArrayRed + 19,
    [FACTION_RED + 0x15] = gUnitArrayRed + 20,
    [FACTION_RED + 0x16] = gUnitArrayRed + 21,
    [FACTION_RED + 0x17] = gUnitArrayRed + 22,
    [FACTION_RED + 0x18] = gUnitArrayRed + 23,
    [FACTION_RED + 0x19] = gUnitArrayRed + 24,
    [FACTION_RED + 0x1A] = gUnitArrayRed + 25,
    [FACTION_RED + 0x1B] = gUnitArrayRed + 26,
    [FACTION_RED + 0x1C] = gUnitArrayRed + 27,
    [FACTION_RED + 0x1D] = gUnitArrayRed + 28,
    [FACTION_RED + 0x1E] = gUnitArrayRed + 29,
    [FACTION_RED + 0x1F] = gUnitArrayRed + 30,
    [FACTION_RED + 0x20] = gUnitArrayRed + 31,
    [FACTION_RED + 0x21] = gUnitArrayRed + 32,
    [FACTION_RED + 0x22] = gUnitArrayRed + 33,
    [FACTION_RED + 0x23] = gUnitArrayRed + 34,
    [FACTION_RED + 0x24] = gUnitArrayRed + 35,
    [FACTION_RED + 0x25] = gUnitArrayRed + 36,
    [FACTION_RED + 0x26] = gUnitArrayRed + 37,
    [FACTION_RED + 0x27] = gUnitArrayRed + 38,
    [FACTION_RED + 0x28] = gUnitArrayRed + 39,
    [FACTION_RED + 0x29] = gUnitArrayRed + 40,
    [FACTION_RED + 0x2A] = gUnitArrayRed + 41,
    [FACTION_RED + 0x2B] = gUnitArrayRed + 42,
    [FACTION_RED + 0x2C] = gUnitArrayRed + 43,
    [FACTION_RED + 0x2D] = gUnitArrayRed + 44,
    [FACTION_RED + 0x2E] = gUnitArrayRed + 45,
    [FACTION_RED + 0x2F] = gUnitArrayRed + 46,
    [FACTION_RED + 0x30] = gUnitArrayRed + 47,
    [FACTION_RED + 0x31] = gUnitArrayRed + 48,
    [FACTION_RED + 0x32] = gUnitArrayRed + 49,

    [FACTION_GREEN + 0x01] = gUnitArrayGreen + 0,
    [FACTION_GREEN + 0x02] = gUnitArrayGreen + 1,
    [FACTION_GREEN + 0x03] = gUnitArrayGreen + 2,
    [FACTION_GREEN + 0x04] = gUnitArrayGreen + 3,
    [FACTION_GREEN + 0x05] = gUnitArrayGreen + 4,
    [FACTION_GREEN + 0x06] = gUnitArrayGreen + 5,
    [FACTION_GREEN + 0x07] = gUnitArrayGreen + 6,
    [FACTION_GREEN + 0x08] = gUnitArrayGreen + 7,
    [FACTION_GREEN + 0x09] = gUnitArrayGreen + 8,
    [FACTION_GREEN + 0x0A] = gUnitArrayGreen + 9,
    [FACTION_GREEN + 0x0B] = gUnitArrayGreen + 10,
    [FACTION_GREEN + 0x0C] = gUnitArrayGreen + 11,
    [FACTION_GREEN + 0x0D] = gUnitArrayGreen + 12,
    [FACTION_GREEN + 0x0E] = gUnitArrayGreen + 13,
    [FACTION_GREEN + 0x0F] = gUnitArrayGreen + 14,
    [FACTION_GREEN + 0x10] = gUnitArrayGreen + 15,
    [FACTION_GREEN + 0x11] = gUnitArrayGreen + 16,
    [FACTION_GREEN + 0x12] = gUnitArrayGreen + 17,
    [FACTION_GREEN + 0x13] = gUnitArrayGreen + 18,
    [FACTION_GREEN + 0x14] = gUnitArrayGreen + 19,

    [FACTION_PURPLE + 0x01] = gUnitArrayPurple + 0,
    [FACTION_PURPLE + 0x02] = gUnitArrayPurple + 1,
    [FACTION_PURPLE + 0x03] = gUnitArrayPurple + 2,
    [FACTION_PURPLE + 0x04] = gUnitArrayPurple + 3,
    [FACTION_PURPLE + 0x05] = gUnitArrayPurple + 4,
};
*/





