#include "gbafe.h"


/*
## UM_DrawBack
 Draw Back[X]
 
## UM_Sacrifice
 Sacrifice[X]

## UM_ArdentSacrifice
 Sacrifice[X]
 
## UM_ReciprocalAid
 Reciprocal Aid[X]//Swaid[X]
 */
 
 // skill sys 
extern int SkillTester(struct Unit* unit, int id); 
extern int DrawBackID_Link; 
extern int DrawBackActID_Link; 
extern int SacrificeID_Link; 
extern int SacrificeActID_Link; 
extern int ArdentSacrificeID_Link; 
extern int ArdentSacrificeActID_Link; 
extern int ReciprocalAidID_Link; 
extern int ReciprocalAidActID_Link; 
extern int HealTargetBottomText_Link; 
extern int DrawBackTargetBottomText_Link; 
extern void* HealTargetEvent; 
extern void* HarmAndHealEvent; 
extern const struct TargetSelectionDefinition gSacrificeTargetSelection; 
extern const struct TargetSelectionDefinition gArdentSacrificeTargetSelection; 
extern const struct TargetSelectionDefinition gReciprocalAidTargetSelection; 
extern const struct TargetSelectionDefinition gDrawBackTargetSelection; 
 
 // vanilla 
extern void MakeTargetListForAdjacentHeal(struct Unit* unit); 
extern struct Unit* gSubjectUnit;
s8 AreAllegiancesAllied(int left, int right);
void StartUnitHpInfoWindow(struct Proc*);

// headers 
void TryAddToReciprocalAidTargetList(struct Unit* unit);
void MakeReciprocalAidTargetList(struct Unit* unit);
void TryDrawBackAllyToTargetList(struct Unit* unit);
void MakeDrawBackTargetListForAdjacentAlly(struct Unit* unit);
struct Vec2u GetDrawBackCoord(int x1, int x2, int y1, int y2);
int DrawBackAction(struct MenuProc* menu);
int DrawBack_Usability(struct MenuProc* menu);
int DrawBack_Effect(struct MenuProc* menu);
void MakeSacrificeTargetList(struct Unit*); 

 
int Sacrifice_Usability(struct MenuProc* menu) { 
	if (gActiveUnit->curHP <= 1) { 
		return 3; // false 
	} 
	if (gActiveUnit->state & US_CANTOING) { 
		return 3; // false 
	} 
	if (SkillTester(gActiveUnit, SacrificeID_Link) == 0) { 
		return 3; // false 
	}
	MakeSacrificeTargetList(gActiveUnit); 
	if (GetTargetListSize()) { 
		return 1; // usable 
	} 
	return 3; // not usable 
} 



int SacrificeAction(struct Proc* proc) { 
	gActiveUnit->state |= US_HAS_MOVED; 
	gActiveUnit->state &= ~US_CANTOING; 
	int actorHP = gActiveUnit->curHP;
	struct Unit* targetUnit = GetUnit(gActionData.targetIndex);
	int targetHP = targetUnit->curHP; 
	int amountToHeal = actorHP - 1; 
	int targetMax = targetUnit->maxHP;
	if ((amountToHeal + targetHP) > targetMax) { 
		amountToHeal = targetMax - targetHP; 
	} 
	
	// if target has bad status, recover it 
	int stID = targetUnit->statusIndex; 
	if (stID) { 
		if ((stID == UNIT_STATUS_POISON) || (stID == UNIT_STATUS_SLEEP) || (stID == UNIT_STATUS_SILENCED) || (stID == UNIT_STATUS_BERSERK) || (stID == UNIT_STATUS_SICK) || (stID == UNIT_STATUS_PETRIFY)) {
			targetUnit->statusIndex = 0; 
			targetUnit->statusDuration = 0; 
		}			
	}
	//gActiveUnit->curHP -= amountToHeal; // if not showing anim
	gEventSlot[1] = gActiveUnit->pCharacterData->number; 
	gEventSlot[2] = targetUnit->pCharacterData->number; 
	gEventSlot[6] = amountToHeal;
	//gActiveUnit->state = gActiveUnit->state & ~US_HIDDEN; 
	//SMS_UpdateFromGameData();
	//MU_EndAll();
	CallMapEventEngine(&HarmAndHealEvent, 1); 
	return 0; // parent proc yields 
} 

int ArdentSacrificeAction(struct Proc* proc) { 
	gActiveUnit->state |= US_HAS_MOVED; 
	gActiveUnit->state &= ~US_CANTOING; 
	int actorHP = gActiveUnit->curHP;
	struct Unit* targetUnit = GetUnit(gActionData.targetIndex);
	int targetHP = targetUnit->curHP; 
	int amountToHeal = actorHP - 1; 
	int targetMax = targetUnit->maxHP;
	if ((amountToHeal + targetHP) > targetMax) { 
		amountToHeal = targetMax - targetHP; 
	} 
	if (amountToHeal > 10) { 
		amountToHeal = 10; 
	} 
	//gActiveUnit->curHP -= amountToHeal; // if not showing anim
	gEventSlot[1] = gActiveUnit->pCharacterData->number; 
	gEventSlot[2] = targetUnit->pCharacterData->number; 
	gEventSlot[6] = amountToHeal;
	//gActiveUnit->state = gActiveUnit->state & ~US_HIDDEN; 
	//SMS_UpdateFromGameData();
	//MU_EndAll();
	CallMapEventEngine(&HarmAndHealEvent, 1); 
	return 0; // parent proc yields 
} 

int ReciprocalAidAction(struct Proc* proc) { 
	gActiveUnit->state |= US_HAS_MOVED; 
	gActiveUnit->state &= ~US_CANTOING; 
	int actorHP = gActiveUnit->curHP;
	//int actorMax = gActiveUnit->maxHP; 
	struct Unit* targetUnit = GetUnit(gActionData.targetIndex);
	int targetHP = targetUnit->curHP; 

	int amountToHeal = 1; // default case 
	//int targetMax = targetUnit->maxHP;
	
	
	
	// target is lower hp than you, so heal them 
	if (targetHP < actorHP) { 
		amountToHeal = actorHP - targetHP; 
		//gActiveUnit->curHP -= amountToHeal; // if not showing anim 
		gEventSlot[1] = gActiveUnit->pCharacterData->number; // unit to harm 
		gEventSlot[2] = targetUnit->pCharacterData->number; 
		gEventSlot[6] = amountToHeal;
	} 
	else { // if you're lower or equal hp vs target, heal yourself 
		amountToHeal = targetHP - actorHP; 
		//targetUnit->curHP -= amountToHeal; 
		gEventSlot[1] = targetUnit->pCharacterData->number; // unit to harm 
		gEventSlot[2] = gActiveUnit->pCharacterData->number; 
		gEventSlot[6] = amountToHeal;
	} 
	
	
	//gActiveUnit->state = gActiveUnit->state & ~US_HIDDEN; 
	//SMS_UpdateFromGameData();
	//MU_EndAll();
	if (amountToHeal) { 
		CallMapEventEngine(&HarmAndHealEvent, 1); 
	} 
	return 0; // parent proc yields 
} 


void HealTargetInit(struct TargetSelectionProc* targetProc) { 
	StartUnitHpInfoWindow((struct Proc*) targetProc);  
	StartBottomHelpText((struct Proc*)targetProc, GetStringFromIndex(HealTargetBottomText_Link));
} 

int SacrificeTargetAPress(struct TargetSelectionProc* targetProc, struct TargetEntry* entry) { 
	gActionData.unitActionType = SacrificeActID_Link; 
	gActionData.targetIndex = entry->unitIndex; 
	return TSE_END|TSE_PLAY_BEEP|TSE_CLEAR_GFX; 
} 	
	
int ArdentSacrificeTargetAPress(struct TargetSelectionProc* targetProc, struct TargetEntry* entry) { 
	gActionData.unitActionType = ArdentSacrificeActID_Link; 
	gActionData.targetIndex = entry->unitIndex; 
	return TSE_END|TSE_PLAY_BEEP|TSE_CLEAR_GFX; 
} 

int ReciprocalAidTargetAPress(struct TargetSelectionProc* targetProc, struct TargetEntry* entry) { 
	gActionData.unitActionType = ReciprocalAidActID_Link; 
	gActionData.targetIndex = entry->unitIndex; 
	return TSE_END|TSE_PLAY_BEEP|TSE_CLEAR_GFX; 
} 
int DrawBackTargetAPress(struct TargetSelectionProc* targetProc, struct TargetEntry* entry) { 
	gActionData.unitActionType = DrawBackActID_Link; 
	gActionData.targetIndex = entry->unitIndex; 
	return TSE_END|TSE_PLAY_BEEP|TSE_CLEAR_GFX; 
} 



int Sacrifice_Effect(struct MenuProc* menu) { 
	MakeSacrificeTargetList(gActiveUnit); 
	StartTargetSelection(&gSacrificeTargetSelection); // returns TargetSelectionProc* 
	return 7; // close menu and such 
} 
int ArdentSacrifice_Effect(struct MenuProc* menu) { 
	MakeTargetListForAdjacentHeal(gActiveUnit); 
	StartTargetSelection(&gArdentSacrificeTargetSelection); // returns TargetSelectionProc* 
	return 7; // close menu and such 
} 
int ReciprocalAid_Effect(struct MenuProc* menu) { 
	MakeReciprocalAidTargetList(gActiveUnit); 
	StartTargetSelection(&gReciprocalAidTargetSelection); // returns TargetSelectionProc* 
	return 7; // close menu and such 
} 

int ArdentSacrifice_Usability(struct MenuProc* menu) { 
	if (gActiveUnit->curHP <= 1) { 
		return 3; // false 
	} 
	if (gActiveUnit->state & US_CANTOING) { 
		return 3; // false 
	} 
	if (SkillTester(gActiveUnit, ArdentSacrificeID_Link) == 0) { 
		return 3; // false 
	}
	MakeTargetListForAdjacentHeal(gActiveUnit); 
	if (GetTargetListSize()) { 
		return 1; // usable 
	} 
	return 3; // not usable 
} 
 
int ReciprocalAid_Usability(struct MenuProc* menu) { 
	if (gActiveUnit->state & US_CANTOING) { 
		return 3; // false 
	} 
	if (SkillTester(gActiveUnit, ReciprocalAidID_Link) == 0) { 
		return 3; // false 
	}
	MakeReciprocalAidTargetList(gActiveUnit); // calls InitTargets 
	if (GetTargetListSize()) { 
		return 1; // usable 
	} 
	return 3; // not usable 
} 
 
 
 
 
 
 
 
 
 void TryAddToSacrificeTargetList(struct Unit* unit) {

    if (!AreAllegiancesAllied(gSubjectUnit->index, unit->index)) {
        return;
    }

    if (unit->state & US_RESCUED) {
        return;
    }
	// if target is at full hp and not statused, exit 
	if ((unit->statusIndex == 0) && (unit->maxHP == unit->curHP)) {
		return; 
	}

    AddTarget(unit->xPos, unit->yPos, unit->index, 0);

    return;
}
 
void MakeSacrificeTargetList(struct Unit* unit) {
    int x = unit->xPos;
    int y = unit->yPos;

    gSubjectUnit = unit;

    BmMapFill(gMapRange, 0);

    ForEachAdjacentUnit(x, y, TryAddToSacrificeTargetList);

    return;
}
 
 
  
void TryAddToReciprocalAidTargetList(struct Unit* unit) {

    if (!AreAllegiancesAllied(gSubjectUnit->index, unit->index)) {
        return;
    }

    if (unit->state & US_RESCUED) {
        return;
    }
	// if both units are full hp, exit 
	if ((gSubjectUnit->maxHP == gSubjectUnit->curHP) && (unit->maxHP == unit->curHP)) {
		return; 
	}
	if ((unit->maxHP == unit->curHP) && (unit->maxHP < gSubjectUnit->curHP)) { 
		return; 
	} 

    AddTarget(unit->xPos, unit->yPos, unit->index, 0);

    return;
}
 
void MakeReciprocalAidTargetList(struct Unit* unit) {
    int x = unit->xPos;
    int y = unit->yPos;

    gSubjectUnit = unit;

    BmMapFill(gMapRange, 0);

    ForEachAdjacentUnit(x, y, TryAddToReciprocalAidTargetList);

    return;
}

static inline bool IsPosInvaild(s8 x, s8 y){
	return( (x<0) & (x>gMapSize.x) & (y<0) & (y>gMapSize.y) );
}


int DrawBack_Usability(struct MenuProc* menu) { 
	if (gActiveUnit->state & US_CANTOING) { 
		return 3; // false 
	} 
	if (SkillTester(gActiveUnit, DrawBackID_Link) == 0) { 
		return 3; // false 
	}
	
	//ForEachAdjacentUnit(int x, int y, void(*)(struct Unit*))
	MakeDrawBackTargetListForAdjacentAlly(gActiveUnit); // calls InitTargets 
	if (GetTargetListSize()) { 
		return 1; // usable 
	} 
	return 3; // not usable 
} 

int DrawBack_Effect(struct MenuProc* menu) { 
	MakeDrawBackTargetListForAdjacentAlly(gActiveUnit); 
	//TryDrawBackAllyToTargetList(gActiveUnit); 
	StartTargetSelection(&gDrawBackTargetSelection); // returns TargetSelectionProc* 
	return 7; // close menu and such 
	
} 

void DrawBackTargetInit(struct TargetSelectionProc* targetProc) { 
	StartUnitHpInfoWindow((struct Proc*) targetProc);  
	StartBottomHelpText((struct Proc*)targetProc, GetStringFromIndex(DrawBackTargetBottomText_Link));
} 


int DrawBackAction(struct MenuProc* menu) { 
	gActiveUnit->state |= US_HAS_MOVED|US_CANTOING; 
	//gActiveUnit->state &= ~US_CANTOING; 
	struct Unit* targetUnit = GetUnit(gActionData.targetIndex);
	
	int x1 = gActiveUnit->xPos; 
	int y1 = gActiveUnit->yPos; 
	
	int x2 = targetUnit->xPos; // target 
	
	int y2 = targetUnit->yPos; // target 
	
	struct Vec2u dest = GetDrawBackCoord(x1, x2, y1, y2);
	
	targetUnit->xPos = gActiveUnit->xPos; 
	targetUnit->yPos = gActiveUnit->yPos; 

	gActionData.xMove = dest.x; 
	gActionData.yMove = dest.y; 

	return 0; // target proc yields 
	
} 

struct Vec2u GetDrawBackCoord(int x1, int x2, int y1, int y2) { 
	struct Vec2u result;
	result.x = x1; 
	result.y = y1; 
	//int dir = 0; 
	if (x1 != x2) { 
		if (x1 > x2) { 
		//dir = MU_COMMAND_MOVE_RIGHT; // actor is on the right side of target, so move both of them right 
		result.x = x1 + 1; 
		}
		else if (x1 < x2) { 
		//dir = MU_COMMAND_MOVE_LEFT; 
		result.x = x1 - 1; 
		} 
	} 
	else if (y1 != y2) { 
		if (y1 > y2) { 
		//dir = MU_COMMAND_MOVE_DOWN; 
		result.y = y1 + 1; 
		}
		else if (y1 < y2) { 
		//dir = MU_COMMAND_MOVE_UP;
		result.y = y1 - 1; 
		}
	} 
	return result; 

} 

void TryDrawBackAllyToTargetList(struct Unit* unit) {

    if (!AreAllegiancesAllied(gSubjectUnit->index, unit->index)) {
        return;
    }

    if (unit->state & US_RESCUED) {
        return;
    }
	if (unit == gSubjectUnit) { 
		return; 
	} 
	

	int x1 = gSubjectUnit->xPos; 
	int x2 = unit->xPos; // target 
	int y1 = gSubjectUnit->yPos; 
	int y2 = unit->yPos; // target 
	
	struct Vec2u dest = GetDrawBackCoord(x1, x2, y1, y2);
	
	if (IsPosInvaild(dest.x, dest.y)) { 
		return; 
	}
	
	//if (gMapMovement[dest.y][dest.x] < 0xF) { // can we actually move there 
	if (gMapUnit[dest.y][dest.x]) { 
		return; // dest sq is occupied 
	} 
	if (gMapHidden[dest.y][dest.x] & 1) { 
		return; // hidden unit here 
	} 
	if (CanUnitCrossTerrain(gSubjectUnit, gMapTerrain[dest.y][dest.x])) { // can we actually move there 
		if (CanUnitCrossTerrain(unit, gMapTerrain[y1][x1])) { // can target be pulled onto here? 
			AddTarget(unit->xPos, unit->yPos, unit->index, 0);
		} 
	} 

    return;
}
 

void MakeDrawBackTargetListForAdjacentAlly(struct Unit* unit) {
	InitTargets(0, 0); 
    int x = unit->xPos;
    int y = unit->yPos;

    gSubjectUnit = unit;

    BmMapFill(gMapRange, 0);

    ForEachAdjacentUnit(x, y, TryDrawBackAllyToTargetList);

    return;
}

 
 