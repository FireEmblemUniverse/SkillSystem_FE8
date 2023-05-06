#include "gbafe.h" 
// see https://github.com/FireEmblemUniverse/fireemblem8u/blob/f3fc2db675198eba47b075e3a94a6284f576df90/src/bmbattle.c#L825

extern int DoublingThresholdLink; 
extern int CallRoutine(void* functionToCall, void* a, void* b, void* c, void* d); // call some arbitrary routine 


int IsAttackerWeaponUnableToDouble(struct BattleUnit* bunitA);
int CanUnitDouble(struct BattleUnit* bunitA, struct BattleUnit* bunitB, int threshold);
s8 BattleGetFollowUpOrder(struct BattleUnit** outAttacker, struct BattleUnit** outDefender);
 

struct UnitDoubleCalcLoop_Struct { 
	void* function;
};

extern struct UnitDoubleCalcLoop_Struct CanUnitDoubleCalcLoop[]; 

// @functions in the loop can either 
//@A. set to always false (0)
//@B. set to always true (1)
//@C. keep the same as before (2)


enum 
{ 
CannotDouble = 0, 
ForceDouble = 1, 
NoChange = 2,
}; 







s8 NewBattleGetFollowUpOrder(struct BattleUnit** outAttacker, struct BattleUnit** outDefender) {
    if (gBattleTarget.battleSpeed > 250) {
		return FALSE; } 
	int threshold = DoublingThresholdLink;
    if (ABS(gBattleActor.battleSpeed - gBattleTarget.battleSpeed) < threshold)
        return FALSE;

    if (gBattleActor.battleSpeed > gBattleTarget.battleSpeed) {
        *outAttacker = &gBattleActor;
        *outDefender = &gBattleTarget;
    } else {
        *outAttacker = &gBattleTarget;
        *outDefender = &gBattleActor;
    }
	return CanUnitDouble((*outAttacker), (*outDefender), threshold); 
}


int CanUnitDouble(struct BattleUnit* bunitA, struct BattleUnit* bunitB, int threshold) { 

	if ((bunitA->battleSpeed - threshold) < bunitB->battleSpeed) 
		return false; 

    if (GetItemWeaponEffect(bunitA->weaponBefore) == WPN_EFFECT_HPHALVE)
        return false;

    if (GetItemIndex(bunitA->weapon) == 0xB5) { //ITEM_MONSTER_STONE)
	return false; } 
	
	for (int i = 0; i<255; i++) { 
		struct UnitDoubleCalcLoop_Struct doubleCalcLoop = CanUnitDoubleCalcLoop[i]; 
		if (!(doubleCalcLoop.function)) { // WORD 0 as terminator 
		break; }
		switch (CallRoutine(doubleCalcLoop.function, bunitA, bunitB, (void*)threshold, 0)) { 
			case NoChange:
				break; // keep trying functions 
			case ForceDouble: 
				return true; 
			case CannotDouble: 
				return false; 
		} 
	}
    return true;
} 


int IsAttackerWeaponUnableToDouble(struct BattleUnit* bunitA) { 
	if (GetItemWeaponEffect(bunitA->weaponBefore) == 0xC) { 
		return CannotDouble; } 
	return NoChange; 
} 



