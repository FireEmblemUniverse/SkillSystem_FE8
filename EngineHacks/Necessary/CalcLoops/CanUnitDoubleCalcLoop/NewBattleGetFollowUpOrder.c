#include "gbafe.h" 
// see https://github.com/FireEmblemUniverse/fireemblem8u/blob/f3fc2db675198eba47b075e3a94a6284f576df90/src/bmbattle.c#L825

extern int DoublingThresholdLink; 

extern int CallRoutine(void* functionToCall, void* a, void* b, void* c, void* d); // call some arbitrary routine 

struct UnitDoubleCalcLoop_Struct { 
	void* function;
};

extern struct UnitDoubleCalcLoop_Struct UnitDoubleLoopList[]; 

// @functions in the loop can either 
//@A. set to always true
//@B. set to always false
//@C. keep the same as before

int CanUnitDouble(struct BattleUnit* bunitA, struct BattleUnit* bunitB) { 

	if ((bunitA->battleSpeed - DoublingThresholdLink) > bunitB->battleSpeed) 
		return false; 

    if (GetItemWeaponEffect(bunitA->weaponBefore) == WPN_EFFECT_HPHALVE)
        return FALSE;

    if (GetItemIndex(bunitA->weapon) == 0xB5) { //ITEM_MONSTER_STONE)
	return FALSE; } 
	
	for (int i = 0; i<255; i++) { 
		struct UnitDoubleCalcLoop_Struct doubleCalcLoop = UnitDoubleLoopList[i]; 
		if (!(doubleCalcLoop.function)) { // WORD 0 as terminator 
		break; }
		if (!(CallRoutine(doubleCalcLoop.function, bunitA, bunitB, 0, 0))) {
		return false; }
	}

    return TRUE;

} 


s8 BattleGetFollowUpOrder(struct BattleUnit** outAttacker, struct BattleUnit** outDefender) {
    if (gBattleTarget.battleSpeed > 250)
        return FALSE;

    if (ABS(gBattleActor.battleSpeed - gBattleTarget.battleSpeed) < DoublingThresholdLink)
        return FALSE;

    if (gBattleActor.battleSpeed > gBattleTarget.battleSpeed) {
        *outAttacker = &gBattleActor;
        *outDefender = &gBattleTarget;
    } else {
        *outAttacker = &gBattleTarget;
        *outDefender = &gBattleActor;
    }
	return CanUnitDouble((*outAttacker), (*outDefender)); 

}




