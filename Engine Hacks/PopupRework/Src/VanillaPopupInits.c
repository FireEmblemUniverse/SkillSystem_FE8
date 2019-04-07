#include "PopupRework.h"

static int PopR_InitWRankNewCommon(unsigned wType) {
	extern struct BattleUnit* gpUnitLeft_BattleStruct;
	extern struct BattleUnit* gpUnitRight_BattleStruct;

	// Check if had wrank before promotion
	if (gpUnitRight_BattleStruct->unit.ranks[wType])
		return FALSE;

	// Check if has not wrank even after promotion
	if (!gpUnitLeft_BattleStruct->unit.ranks[wType])
		return FALSE;

	SetPopupWType(wType);
	return TRUE;
}

#define POPR_INIT_WRANK_DECL(WRankName, WRankId) \
int PopR_Init ## WRankName ## RankNew (void) { \
	return PopR_InitWRankNewCommon((WRankId)); \
}

POPR_INIT_WRANK_DECL(Sword, 0)
POPR_INIT_WRANK_DECL(Lance, 1)
POPR_INIT_WRANK_DECL(Axe,   2)
POPR_INIT_WRANK_DECL(Bow,   3)
POPR_INIT_WRANK_DECL(Staff, 4)
POPR_INIT_WRANK_DECL(Anima, 5)
POPR_INIT_WRANK_DECL(Light, 6)
POPR_INIT_WRANK_DECL(Elder, 7)

#undef POPR_INIT_WRANK_DECL

int PopR_InitWRankUp(void) {
	// Check Active Unit
	if (BattleUnit_ShouldDisplayWRankUp(&gBattleActor)) {
		SetPopupWType(gBattleActor.weaponType);
		return TRUE;
	}

	// Check Target Unit
	if (BattleUnit_ShouldDisplayWRankUp(&gBattleTarget)) {
		SetPopupWType(gBattleTarget.weaponType);
		return TRUE;
	}

	return FALSE;
}

int PopR_InitWeaponBroke(void) {
	// Check Active Unit
	if (BattleUnit_ShouldDisplayWpnBroke(&gBattleActor)) {
		SetPopupItem(gBattleActor.weaponBefore);
		return TRUE;
	}

	// Check Target Unit
	if (BattleUnit_ShouldDisplayWpnBroke(&gBattleTarget)) {
		SetPopupItem(gBattleTarget.weaponBefore);
		return TRUE;
	}

	return FALSE;
}

const u32 gPopup_PopR_NewWType[] = {
	0x0C, 0x5A, // set_sound 0x5A
	0x08, 0x00, // set_color 0x00
	0x06, 0x0D, // string_id 0x0D @ "You can now use [X]"
	0x0A, 0,    // wtype_icon
	0x00, 0,    // end
};
