#include "gbafe.h" 
// see https://github.com/FireEmblemUniverse/fireemblem8u/blob/f3fc2db675198eba47b075e3a94a6284f576df90/src/bmbattle.c#L825

extern int DoublingThresholdLink; 
extern int CallRoutine(void* functionToCall, void* a, void* b, void* c, void* d); // call some arbitrary routine 

extern s8 BattleGenerateRoundHits(struct BattleUnit* attacker, struct BattleUnit* defender);
extern void BattleGetBattleUnitOrder(struct BattleUnit** outAttacker, struct BattleUnit** outDefender);
extern void ClearBattleHits(void); 
extern void BattleForecastHitCountUpdate(struct BattleUnit* battleUnit, u8* hitsCounter, int* usesCounter); 
extern int IsUnitEffectiveAgainst(struct BattleUnit* attacker, struct BattleUnit* defender);

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

struct BattleForecastProc {
    /* 00 */ PROC_HEADER;

    /* 2C */ int unk_2C;
    /* 30 */ s8 x;
    /* 31 */ s8 y;
    /* 32 */ u8 frameKind;
    /* 33 */ s8 ready;
    /* 34 */ s8 needContentUpdate;
    /* 35 */ s8 side; // -1 is left, +1 is right
    /* 36 */ s8 unk_36;
    /* 38 */ struct TextHandle unitNameTextA;
    /* 40 */ struct TextHandle unitNameTextB;
    /* 48 */ struct TextHandle itemNameText;
    /* 50 */ s8 hitCountA;
    /* 51 */ s8 hitCountB;
    /* 52 */ s8 isEffectiveA;
    /* 53 */ s8 isEffectiveB;
};




void NewInitBattleForecastBattleStats(struct BattleForecastProc* proc) {
    struct BattleUnit* buFirst;
    struct BattleUnit* buSecond;


    int usesA = GetItemUses(gBattleActor.weaponBefore);
    int usesB = GetItemUses(gBattleTarget.weaponBefore);

    s8 followUp = BattleGetFollowUpOrder(&buFirst, &buSecond);

    proc->hitCountA = 0;
    proc->isEffectiveA = 0;

    if ((gBattleActor.weapon != 0) || (gBattleActor.weaponBroke)) {
        BattleForecastHitCountUpdate(&gBattleActor, &proc->hitCountA, &usesA);

        if ((followUp != 0) && (buFirst == &gBattleActor)) {
            BattleForecastHitCountUpdate(buFirst, &proc->hitCountA, &usesA);
        }
		if (followUp != 0) { 
			BattleForecastHitCountUpdate(buSecond, &proc->hitCountB, &usesB);
		} 

        if (IsUnitEffectiveAgainst(&gBattleActor.unit, &gBattleTarget.unit) != 0) {
            proc->isEffectiveA = 1;
        }

        if (IsItemEffectiveAgainst(gBattleActor.weaponBefore, &gBattleTarget.unit) != 0) {
            proc->isEffectiveA = 1;
        }

        if ((gBattleActor.wTriangleHitBonus > 0) && (gBattleActor.weaponAttributes & IA_REVERTTRIANGLE) != 0) {
            proc->isEffectiveA = 1;
        }
    }

    proc->hitCountB = 0;
    proc->isEffectiveB = 0;

    if ((gBattleTarget.weapon != 0) || (gBattleTarget.weaponBroke)) {
        BattleForecastHitCountUpdate(&gBattleTarget, &proc->hitCountB, &usesB);
        if ((followUp != 0) && (buFirst == &gBattleTarget)) {
            BattleForecastHitCountUpdate(buFirst, &proc->hitCountB, &usesB);
			BattleForecastHitCountUpdate(buSecond, &proc->hitCountA, &usesA);
        }

        if (IsUnitEffectiveAgainst(&gBattleTarget.unit, &gBattleActor.unit) != 0) {
            proc->isEffectiveB = 1;
        }

        if (IsItemEffectiveAgainst(gBattleTarget.weaponBefore, &gBattleActor.unit) != 0) {
            proc->isEffectiveB = 1;
        }

        if ((gBattleTarget.wTriangleHitBonus > 0) && (gBattleTarget.weaponAttributes & IA_REVERTTRIANGLE) != 0) {
            proc->isEffectiveB = 1;
        }
    }

    return;
}



void BattleUnwind(void) {
    ClearBattleHits();

    // this do { ... } while (0); is required for match
    // which is kind of neat because it implies scrapped plans for supporting some accost kind of thing

    do {
        struct BattleUnit* attacker;
        struct BattleUnit* defender;

        BattleGetBattleUnitOrder(&attacker, &defender);

        gBattleHitIterator->info |= BATTLE_HIT_INFO_BEGIN;

        if (!BattleGenerateRoundHits(attacker, defender)) { // attacker hits defender 
			// if not the initial hit: 
            gBattleHitIterator->attributes |= BATTLE_HIT_ATTR_RETALIATE; 
			int countered = BattleGenerateRoundHits(defender, attacker); // defender (potentially) counter attacks 
			if (!countered) {
				//if not the counter attack, follow up attack 
				gBattleHitIterator->attributes = BATTLE_HIT_ATTR_FOLLOWUP;
				int atkrDouble = BattleGenerateRoundHits(&gBattleActor, &gBattleTarget); 
				if (!atkrDouble) { 
						gBattleHitIterator->attributes = BATTLE_HIT_ATTR_FOLLOWUP;
						BattleGenerateRoundHits(&gBattleTarget, &gBattleActor);
				
				/*
				int counterattacks = BattleGetFollowUpOrder(&attacker, &defender);
				if (counterattacks) {
					gBattleHitIterator->attributes = BATTLE_HIT_ATTR_FOLLOWUP;
					//BattleGenerateRoundHits(attacker, defender);
					BattleGenerateRoundHits(&gBattleActor, &gBattleTarget);            
					if (counterattacks > 1) { 
						gBattleHitIterator->attributes = BATTLE_HIT_ATTR_FOLLOWUP;
						BattleGenerateRoundHits(&gBattleTarget, &gBattleActor);
					}
				}
				*/
				}	
			}
        }
    } while (FALSE);

    gBattleHitIterator->info |= BATTLE_HIT_INFO_END;
}



s8 NewBattleGetFollowUpOrder(struct BattleUnit** outAttacker, struct BattleUnit** outDefender) {
    //if (gBattleTarget.battleSpeed > 250) {
		//return FALSE; } 
	int threshold = DoublingThresholdLink;

	int attackerDouble = CanUnitDouble((&gBattleActor), (&gBattleTarget), threshold); 
	if (attackerDouble) { 
	    *outAttacker = &gBattleActor;
		*outDefender = &gBattleTarget;
	} 

	int defenderDouble = CanUnitDouble((*outAttacker), (*outDefender), threshold); 
	if (defenderDouble) { 
		*outAttacker = &gBattleTarget;
		*outDefender = &gBattleActor;
	} 
	
	// if both can double each other: 
	/*
	if (attackerDouble && defenderDouble) { 
		asm("mov r11, r11"); 
		gBattleHitIterator->attributes = BATTLE_HIT_ATTR_FOLLOWUP;
		BattleGenerateRoundHits(&gBattleActor, &gBattleTarget); // make the attacker double first 
		gBattleHitIterator->attributes = BATTLE_HIT_ATTR_FOLLOWUP;
		BattleGenerateRoundHits(&gBattleTarget, &gBattleActor); // make the attacker double first 
	}
	*/
	
	
	return (attackerDouble + defenderDouble); // if this is true, then *outAttacker will double *outDefender. 
}


int CanUnitDouble(struct BattleUnit* bunitA, struct BattleUnit* bunitB, int threshold) { 
	return true; 

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



