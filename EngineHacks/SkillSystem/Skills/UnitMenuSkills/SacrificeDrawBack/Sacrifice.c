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
//extern void MakeTargetListForAdjacentHeal(struct Unit* unit); 
//extern struct Unit* gSubjectUnit;
//s8 AreUnitsAllied(int left, int right);
//void StartUnitHpInfoWindow(struct Proc*);
extern void ForEachAdjacentUnit(int x, int y, void(*)(struct Unit*));
extern int CanUnitCrossTerrain(const struct Unit*, u8 terrain);

struct TargetSelectionProc;

typedef struct TargetEntry TargetEntry;
typedef struct TargetSelectionDefinition TargetSelectionDefinition;
typedef struct TargetSelectionProc TargetSelectionProc;

struct TargetEntry {
	/* 00 */ u8 x, y;
	/* 02 */ u8 unitIndex;
	/* 03 */ u8 trapIndex;

	/* 04 */ TargetEntry* next;
	/* 08 */ TargetEntry* prev;
};

struct TargetSelectionDefinition {
	/* 00 */ void(*onInit)(struct TargetSelectionProc*);
	/* 04 */ void(*onEnd)(struct TargetSelectionProc*);

	/* 08 */ void(*onInitTarget)(struct TargetSelectionProc*, struct TargetEntry*);

	/* 0C */ void(*onSwitchIn)(struct TargetSelectionProc*, struct TargetEntry*);
	/* 10 */ void(*onSwitchOut)(struct TargetSelectionProc*, struct TargetEntry*);

	/* 14 */ int(*onAPress)(struct TargetSelectionProc*, struct TargetEntry*);
	/* 18 */ int(*onBPress)(struct TargetSelectionProc*, struct TargetEntry*);
	/* 1C */ int(*onRPress)(struct TargetSelectionProc*, struct TargetEntry*);
};

struct TargetSelectionProc {
	PROC_HEADER;

	/* 2C */ const TargetSelectionDefinition* pDefinition;
	/* 30 */ TargetEntry* pCurrentEntry;
	
	/* 34 */ u8 stateBits;

	/* 38 */ int(*onAPressOverride)(TargetSelectionProc*, TargetEntry*);
};
enum _TargetSelectionEffect {
	TSE_NONE = 0x00,

	TSE_DISABLE = 0x01, // (for one frame, probably useful for blocking)
	TSE_END = 0x02,
	TSE_PLAY_BEEP = 0x04,
	TSE_PLAY_BOOP = 0x08,
	TSE_CLEAR_GFX = 0x10,
	TSE_END_FACE0 = 0x20
};

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
	if (GetSelectTargetCount()) { 
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
	gEventSlots[1] = gActiveUnit->pCharacterData->number; 
	gEventSlots[2] = targetUnit->pCharacterData->number; 
	gEventSlots[6] = amountToHeal;
	//gActiveUnit->state = gActiveUnit->state & ~US_HIDDEN; 
	//SMS_UpdateFromGameData();
	//MU_EndAll();
	CallEvent(&HarmAndHealEvent, 1); 
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
	gEventSlots[1] = gActiveUnit->pCharacterData->number; 
	gEventSlots[2] = targetUnit->pCharacterData->number; 
	gEventSlots[6] = amountToHeal;
	//gActiveUnit->state = gActiveUnit->state & ~US_HIDDEN; 
	//SMS_UpdateFromGameData();
	//MU_EndAll();
	CallEvent(&HarmAndHealEvent, 1); 
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
		gEventSlots[1] = gActiveUnit->pCharacterData->number; // unit to harm 
		gEventSlots[2] = targetUnit->pCharacterData->number; 
		gEventSlots[6] = amountToHeal;
	} 
	else { // if you're lower or equal hp vs target, heal yourself 
		amountToHeal = targetHP - actorHP; 
		//targetUnit->curHP -= amountToHeal; 
		gEventSlots[1] = targetUnit->pCharacterData->number; // unit to harm 
		gEventSlots[2] = gActiveUnit->pCharacterData->number; 
		gEventSlots[6] = amountToHeal;
	} 
	
	
	//gActiveUnit->state = gActiveUnit->state & ~US_HIDDEN; 
	//SMS_UpdateFromGameData();
	//MU_EndAll();
	if (amountToHeal) { 
		CallEvent(&HarmAndHealEvent, 1); 
	} 
	return 0; // parent proc yields 
} 


void HealTargetInit(struct TargetSelectionProc* targetProc) { 
	StartUnitHpInfoWindow((struct Proc*) targetProc);  
	StartSubtitleHelp((struct Proc*)targetProc, GetStringFromIndex(HealTargetBottomText_Link));
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
	NewTargetSelection(&gSacrificeTargetSelection); // returns TargetSelectionProc* 
	return 7; // close menu and such 
} 
int ArdentSacrifice_Effect(struct MenuProc* menu) { 
	MakeTargetListForAdjacentHeal(gActiveUnit); 
	NewTargetSelection(&gArdentSacrificeTargetSelection); // returns TargetSelectionProc* 
	return 7; // close menu and such 
} 
int ReciprocalAid_Effect(struct MenuProc* menu) { 
	MakeReciprocalAidTargetList(gActiveUnit); 
	NewTargetSelection(&gReciprocalAidTargetSelection); // returns TargetSelectionProc* 
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
	if (GetSelectTargetCount()) { 
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
	if (GetSelectTargetCount()) { 
		return 1; // usable 
	} 
	return 3; // not usable 
} 
 
 
 
 
 
 
 
 
 void TryAddToSacrificeTargetList(struct Unit* unit) {

    if (!AreUnitsAllied(gSubjectUnit->index, unit->index)) {
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

    BmMapFill(gBmMapRange, 0);

    ForEachAdjacentUnit(x, y, TryAddToSacrificeTargetList);

    return;
}
 
 
  
void TryAddToReciprocalAidTargetList(struct Unit* unit) {

    if (!AreUnitsAllied(gSubjectUnit->index, unit->index)) {
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

    BmMapFill(gBmMapRange, 0);

    ForEachAdjacentUnit(x, y, TryAddToReciprocalAidTargetList);

    return;
}

static inline bool IsPosInvaild(s8 x, s8 y){
	return( (x<0) & (x>gBmMapSize.x) & (y<0) & (y>gBmMapSize.y) );
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
	if (GetSelectTargetCount()) { 
		return 1; // usable 
	} 
	return 3; // not usable 
} 

int DrawBack_Effect(struct MenuProc* menu) { 
	MakeDrawBackTargetListForAdjacentAlly(gActiveUnit); 
	//TryDrawBackAllyToTargetList(gActiveUnit); 
	NewTargetSelection(&gDrawBackTargetSelection); // returns TargetSelectionProc* 
	return 7; // close menu and such 
	
} 

void DrawBackTargetInit(struct TargetSelectionProc* targetProc) { 
	StartUnitHpInfoWindow((struct Proc*) targetProc);  
	StartSubtitleHelp((struct Proc*)targetProc, GetStringFromIndex(DrawBackTargetBottomText_Link));
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

    if (!AreUnitsAllied(gSubjectUnit->index, unit->index)) {
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
	
	//if (gBmMapMovement[dest.y][dest.x] < 0xF) { // can we actually move there 
	if (gBmMapUnit[dest.y][dest.x]) { 
		return; // dest sq is occupied 
	} 
	if (gBmMapHidden[dest.y][dest.x] & 1) { 
		return; // hidden unit here 
	} 
	if (CanUnitCrossTerrain(gSubjectUnit, gBmMapTerrain[dest.y][dest.x])) { // can we actually move there 
		if (CanUnitCrossTerrain(unit, gBmMapTerrain[y1][x1])) { // can target be pulled onto here? 
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

    BmMapFill(gBmMapRange, 0);

    ForEachAdjacentUnit(x, y, TryDrawBackAllyToTargetList);

    return;
}

 
 