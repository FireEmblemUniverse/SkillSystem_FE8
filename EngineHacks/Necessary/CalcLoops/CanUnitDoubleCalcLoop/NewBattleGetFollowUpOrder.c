#include "gbafe.h" 
#include <stdlib.h> 
// see https://github.com/FireEmblemUniverse/fireemblem8u/blob/f3fc2db675198eba47b075e3a94a6284f576df90/src/bmbattle.c#L825

extern int DoublingThresholdLink; 


extern s8 BattleGenerateRoundHits(struct BattleUnit* attacker, struct BattleUnit* defender);
extern void BattleGetBattleUnitOrder(struct BattleUnit** outAttacker, struct BattleUnit** outDefender);
extern void ClearBattleHits(void); 
extern void BattleForecastHitCountUpdate(struct BattleUnit* battleUnit, u8* hitsCounter, int* usesCounter); 
extern int IsUnitEffectiveAgainst(struct BattleUnit* attacker, struct BattleUnit* defender);
extern s8 BattleGetFollowUpOrder(struct BattleUnit** outAttacker, struct BattleUnit** outDefender);


int DoesUnitImmediatelyFollowUp(struct BattleUnit* bunitA, struct BattleUnit* bunitB);
int IsAttackerWeaponUnableToDouble(struct BattleUnit* bunitA);
int CanUnitDouble(struct BattleUnit* bunitA, struct BattleUnit* bunitB);
s8 NewBattleGetFollowUpOrder(struct BattleUnit** outAttacker, struct BattleUnit** outDefender);


void NewBattleUnwind(void); 
extern int SkillTester(struct Unit* unit, int id); 
extern int AssassinateID_Link; 
extern int DesperationID_Link; 
extern int RecklessFighterID_Link; 
extern int PridefulWarriorID_Link; 
extern int LastWordID_Link;
extern int BoldFighterID_Link; 
extern int VengefulFighterID_Link; 
extern int QuickLearnerID_Link; 
extern int PassionsFlowID_Link; 
extern int QuickRiposteID_Link; 
extern int BidingBlowID_Link; 
extern int AdvantageChaserID_Link; 

struct UnitDoubleCalcLoop_Struct { 
	int(*function)(struct BattleUnit* attacker, struct BattleUnit* defender);
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

int BidingBlow(struct BattleUnit* bunitA, struct BattleUnit* bunitB) { 
	if (gBattleStats.config & (BATTLE_CONFIG_REAL | BATTLE_CONFIG_SIMULATE)) {
		if (SkillTester(&bunitA->unit, BidingBlowID_Link)) { 
			if (bunitA == &gBattleActor) { 
				if (!bunitB->canCounter) {  
					return ForceDouble; 
				}
			} 
		}
	}
	return NoChange; 
} 

int PassionsFlow(struct BattleUnit* bunitA, struct BattleUnit* bunitB) { 
	if (SkillTester(&bunitA->unit, PassionsFlowID_Link)) { 
		if (bunitA == &gBattleActor) { 
			struct SupportBonuses* bonuses = 0; 
			// this function returns true if any bonuses are found and also puts the bonuses into the provided ram 
			if (GetUnitSupportBonuses(&bunitA->unit, bonuses)) {  
				return ForceDouble; 
			}
		} 
	}
	return NoChange; 
} 

int GetEffLvl(struct BattleUnit* bunitA) { 
	u32 attrb = UNIT_CATTRIBUTES(&bunitA->unit);
	int result = bunitA->unit.level+10; 
	result -= 10*(attrb & CA_MAXLEVEL10); 
	result += 20*(attrb & CA_PROMOTED); 
	return result; 
} 

int QuickLearner(struct BattleUnit* bunitA, struct BattleUnit* bunitB) { 
	if (SkillTester(&bunitA->unit, QuickLearnerID_Link)) { 
		if (GetEffLvl(bunitA) < GetEffLvl(bunitB)) { 
			return ForceDouble; 
		} 
	} 
	return NoChange; 
} 

int BoldFighter(struct BattleUnit* bunitA, struct BattleUnit* bunitB) { 
	if (SkillTester(&bunitA->unit, BoldFighterID_Link)) { 
		if (bunitA == &gBattleActor) { 
			return ForceDouble; 
		} 
	} 
	return NoChange; 
} 

int QuickRiposte(struct BattleUnit* bunitA, struct BattleUnit* bunitB) { 
	if (gBattleStats.config & (BATTLE_CONFIG_REAL | BATTLE_CONFIG_SIMULATE)) { // Quick Riposte as asm did this for some reason:
	//@pre-battle data pointer, gonna check if a target has been selected or the fight has started (0x02 if targeting someone, 0x01 if battle started)
		if (bunitA->hpInitial >= (bunitA->unit.maxHP / 2)) { 
			if (SkillTester(&bunitA->unit, QuickRiposteID_Link)) { 
				if (bunitA == &gBattleTarget) { 
					return ForceDouble; 
				} 
			} 
		} 
		if (bunitB->hpInitial >= (bunitB->unit.maxHP / 2)) { 
			if (SkillTester(&bunitB->unit, QuickRiposteID_Link)) { 
				if (bunitB == &gBattleTarget) { 
					return CannotDouble; 
				} 
			} 
		} 
	} 
	
	return NoChange; 
} 

int VengefulFighter(struct BattleUnit* bunitA, struct BattleUnit* bunitB) { 
	if (SkillTester(&bunitA->unit, VengefulFighterID_Link)) { 
		if (bunitA == &gBattleTarget) { 
			return ForceDouble; 
		} 
	} 
	return NoChange; 
} 


int LastWord(struct BattleUnit* bunitA, struct BattleUnit* bunitB) { 
	if (SkillTester(&bunitA->unit, LastWordID_Link)) { 
		if (CanUnitDouble(bunitB, bunitA)) { 
			return ForceDouble; 
		} 
	} 
	return NoChange; 
} 

int PridefulWarrior(struct BattleUnit* bunitA, struct BattleUnit* bunitB) { 
	if (SkillTester(&bunitA->unit, PridefulWarriorID_Link)) { 
		return ForceDouble; } 
	return NoChange; 
} 


int RecklessFighter(struct BattleUnit* bunitA, struct BattleUnit* bunitB) { 
	if (SkillTester(&bunitA->unit, RecklessFighterID_Link) || SkillTester(&bunitB->unit, RecklessFighterID_Link)) { 
		return ForceDouble; } 
	return NoChange; 
} 

int AdvantageChaser(struct BattleUnit* bunitA, struct BattleUnit* bunitB) {
	if (SkillTester(&bunitA->unit, AdvantageChaserID_Link)) {
		if (bunitA == &gBattleActor) {
			if (gBattleActor.wTriangleHitBonus > 0) {
				return ForceDouble;
			}
		}
	}
	return NoChange;
}

int DoesUnitImmediatelyFollowUp(struct BattleUnit* bunitA, struct BattleUnit* bunitB) { 
	int result = false; 
    int dist = gBattleStats.range; 
	int hasDesperation = (SkillTester(&bunitA->unit, DesperationID_Link) && (bunitA->hpInitial < (bunitA->unit.maxHP/2)));
	int hasAssassinate = (SkillTester(&bunitA->unit, AssassinateID_Link) && (dist == 1) && (bunitA == &gBattleActor)); // assassinate only works while attacking 
	if (hasDesperation || hasAssassinate) { 
		result = true; } 
	return result; 
} 
enum 
{ 
NoFollowUp = 0, 
OneFollowUp = 1, 
BothFollowUp = 2,
}; 
void NewBattleUnwind(void) {
    ClearBattleHits();

    // this do { ... } while (0); is required for match
    // which is kind of neat because it implies scrapped plans for supporting some accost kind of thing

    do {
        struct BattleUnit* attacker;
        struct BattleUnit* defender;

        BattleGetBattleUnitOrder(&attacker, &defender);
		int hasPridefulWarrior = (SkillTester(&attacker->unit, PridefulWarriorID_Link)); 
		if (hasPridefulWarrior) { 
			attacker = &gBattleTarget;
			defender = &gBattleActor; 
		} 

        gBattleHitIterator->info |= BATTLE_HIT_INFO_BEGIN;

        if (!BattleGenerateRoundHits(attacker, defender)) { // attacker hits defender 
			// if the initial hit doesn't kill:
			if (DoesUnitImmediatelyFollowUp(attacker, defender)) {
				int atkrDouble = CanUnitDouble(attacker, defender);
				int desperationEnds = false; // names? idk
				if (atkrDouble) {
					gBattleHitIterator->attributes = BATTLE_HIT_ATTR_FOLLOWUP;
					desperationEnds = BattleGenerateRoundHits(attacker, defender);
				}
				if (!desperationEnds) {
					//int followUpHits = BattleGetFollowUpOrder(&attacker, &defender);
					gBattleHitIterator->attributes |= BATTLE_HIT_ATTR_RETALIATE; 
					int countered = BattleGenerateRoundHits(&gBattleTarget, &gBattleActor); // defender (potentially) counter attacks 
					if (!countered) {
						if (!atkrDouble && (CanUnitDouble(&gBattleTarget, &gBattleActor))) {
							gBattleHitIterator->attributes = BATTLE_HIT_ATTR_FOLLOWUP;
							BattleGenerateRoundHits(&gBattleTarget, &gBattleActor);
						}
					}
				}
			}
			else {
				gBattleHitIterator->attributes |= BATTLE_HIT_ATTR_RETALIATE;
				int countered = BattleGenerateRoundHits(defender, attacker); // defender (potentially) counter attacks 
				if (!countered) {
					//if not the counter attack, follow up attack 
					
					int followUpHits = BattleGetFollowUpOrder(&attacker, &defender);
					if (followUpHits) {
						gBattleHitIterator->attributes = BATTLE_HIT_ATTR_FOLLOWUP;
						int atkrDouble = BattleGenerateRoundHits(attacker, defender); 
						if ((!atkrDouble) && (followUpHits == BothFollowUp)) { 
							gBattleHitIterator->attributes = BATTLE_HIT_ATTR_FOLLOWUP;
							BattleGenerateRoundHits(defender, attacker);
						}
					}
				}
			}
        }
    } while (FALSE);

    gBattleHitIterator->info |= BATTLE_HIT_INFO_END;
	
	asm("mov r0, #0"); // This is what a hook for Barricade did  
	asm("mov r11, r0"); // for some reason it sets r11 to 0. r11 is not used by this function. 
	// "Barricade uses r11 for various things through combat. This unsets it afterward."
}




s8 NewBattleGetFollowUpOrder(struct BattleUnit** outAttacker, struct BattleUnit** outDefender) {
	int result = NoFollowUp; // default 
	int defenderDouble = CanUnitDouble((&gBattleTarget), (&gBattleActor)); 
	if (defenderDouble) { 
		result += OneFollowUp;
		*outAttacker = &gBattleTarget;
		*outDefender = &gBattleActor;
	} 
	
	int attackerDouble = CanUnitDouble((&gBattleActor), (&gBattleTarget)); 
	if (attackerDouble) { 
		result += OneFollowUp; 
	    *outAttacker = &gBattleActor;
		*outDefender = &gBattleTarget;
	} 	
	return result; 
}


int CanUnitDouble(struct BattleUnit* bunitA, struct BattleUnit* bunitB) { 
	int threshold = DoublingThresholdLink; 
	int result = true; 
	if ((bunitA->battleSpeed - threshold) < bunitB->battleSpeed) {
	result = false; } 

    if (GetItemWeaponEffect(bunitA->weaponBefore) == WPN_EFFECT_HPHALVE)
        return false;

    if (GetItemIndex(bunitA->weapon) == 0xB5) { //ITEM_MONSTER_STONE)
	return false; } 
	
	for (int i = 0; ; i++) { 
		struct UnitDoubleCalcLoop_Struct* doubleCalcLoop = &CanUnitDoubleCalcLoop[i]; 
		if (!(doubleCalcLoop->function)) { // WORD 0 as terminator 
		break; }
		switch (doubleCalcLoop->function(bunitA, bunitB)) { 
			case NoChange:
				break; // keep trying functions 
			case ForceDouble: 
				return true; 
			case CannotDouble: 
				return false; 
		} 
	}
    return result;
} 


int IsAttackerWeaponUnableToDouble(struct BattleUnit* bunitA) { 
	if (GetItemWeaponEffect(bunitA->weaponBefore) == 0xC) { 
		return CannotDouble; } 
	return NoChange; 
} 



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
void NewInitBattleForecastBattleStats(struct BattleForecastProc* proc); 

void NewInitBattleForecastBattleStats(struct BattleForecastProc* proc) {
    struct BattleUnit* buFirst;
    struct BattleUnit* buSecond;


    int usesA = GetItemUses(gBattleActor.weaponBefore);
    int usesB = GetItemUses(gBattleTarget.weaponBefore);

    s8 followUp = BattleGetFollowUpOrder(&buFirst, &buSecond);

    proc->hitCountA = 0;
    proc->isEffectiveA = 0;

    if ((gBattleActor.weapon != 0) || (gBattleActor.weaponBroke)) {
        BattleForecastHitCountUpdate(&gBattleActor, (u8*)&proc->hitCountA, &usesA);

        if ((followUp != 0) && (buFirst == &gBattleActor)) {
            BattleForecastHitCountUpdate(buFirst, (u8*)&proc->hitCountA, &usesA);
        }

        if (IsUnitEffectiveAgainst((struct BattleUnit*)&gBattleActor.unit, (struct BattleUnit*)&gBattleTarget.unit) != 0) {
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
        BattleForecastHitCountUpdate(&gBattleTarget, (u8*)&proc->hitCountB, &usesB);
        if ((followUp != 0) && (buFirst == &gBattleTarget)) {
            BattleForecastHitCountUpdate(buFirst, (u8*)&proc->hitCountB, &usesB);
        }
        if ((followUp == BothFollowUp)) { // added 
            BattleForecastHitCountUpdate(buSecond, (u8*)&proc->hitCountB, &usesB);
        }

        if (IsUnitEffectiveAgainst((struct BattleUnit*)&gBattleTarget.unit, (struct BattleUnit*)&gBattleActor.unit) != 0) {
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


