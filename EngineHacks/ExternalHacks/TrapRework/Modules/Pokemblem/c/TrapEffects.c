#include "gbafe.h"

extern void RemoveLightRune(struct Trap* trap); 

#define returnValue 0x94 

struct FMURam { 
	u8 state : 1; 
	u8 running : 1; 
	u8 dir : 2; 
	u8 silent : 1; 
	u8 use_dir : 1; 
};

extern struct FMURam* FreeMoveRam; 

extern void SetNewFlag_No_sC(int); 
extern int CheckNewFlag_No_sC(int id);
extern int CheckEventId(int); 
extern int GetFreeMovementState(void); 

extern struct Trap* AddTrapExtFix(int x, int y, int type, int ext1, int ext2, int ext3, int ext4, int ext5);  //! FE8U = (0x0802E2E0+1)
extern const void* GiveCoinsEvent; 
extern int CoinsTrapID_Link; 

void AlwaysInitTrap(struct EventTrapData* eTrap) { 
	AddTrapExtFix(eTrap->data[0], eTrap->data[1], eTrap->type, eTrap->data[2], eTrap->data[3], eTrap->data[4], 0, 0); 
} 

// this won't work for all trap types because diff trap types have flag offsets 
void InitIfNewFlagInByte3IsOff(struct EventTrapData* eTrap) { 
	if (eTrap->data[2]) { 
		if (CheckNewFlag_No_sC(eTrap->data[2])) { // 2 because type comes first 
		return; 
		}
	}
	AddTrapExtFix(eTrap->data[0], eTrap->data[1], eTrap->type, eTrap->data[2], eTrap->data[3], eTrap->data[4], 0, 0); 
} 

void InitIfFlagInByte3IsOff(struct EventTrapData* eTrap) { 
	if (eTrap->data[2]) { 
		if (CheckEventId(eTrap->data[2])) { // 2 because type comes first 
		return; 
		}
	}
	AddTrapExtFix(eTrap->data[0], eTrap->data[1], eTrap->type, eTrap->data[2], eTrap->data[3], eTrap->data[4], 0, 0); 
} 


	
struct Trap* NewGetAdjacentTrap(struct Unit* unit, int trapID_low, int trapID_high) { 
	struct Trap* trap = NULL; 
	int x = unit->xPos; 
	int y = unit->yPos; 
	
	if (FreeMoveRam->use_dir && GetFreeMovementState()) { 
		//struct FMUProc* proc = (FMUProc*)ProcFind(FreeMovementControlProc);
		int dir = FreeMoveRam->dir; 
		if (dir==MU_FACING_LEFT)      x--;
		else if (dir==MU_FACING_RIGHT)x++;
		else if (dir==MU_FACING_DOWN) y++;
		else if (dir==MU_FACING_UP) y--;
		trap = GetTrapAt(x, y);
		if ((trap) && (trap->type >= trapID_low) && (trap->type <= trapID_high)) 
			return trap;
		else 
			return 0; 
	} 
	
	x++; 
	trap = GetTrapAt(x, y); 
	if (trap && (trap->type >= trapID_low) && (trap->type <= trapID_high)) {
	return trap; } 
	x--; x--; 
	trap = GetTrapAt(x, y); 
	if (trap && (trap->type >= trapID_low) && (trap->type <= trapID_high)) {
	return trap; } 
	
	x++; y++; 
	trap = GetTrapAt(x, y); 
	if (trap && (trap->type >= trapID_low) && (trap->type <= trapID_high)) {
	return trap; } 
	
	y--; y--; 
	trap = GetTrapAt(x, y); 
	if (trap && (trap->type >= trapID_low) && (trap->type <= trapID_high)) {
	return trap; } 
	

	return 0; 
} 

struct Trap* NewGetAdjacentTrapID(struct Unit* unit, int trapID) {
	return NewGetAdjacentTrap(unit, trapID, trapID); 
} 


struct CoinsTrap { 
	/* 00 */ u8 xPosition;
	/* 01 */ u8 yPosition;
	/* 02 */ u8 type;
	/* 03 */ u8 flag;
	/* 04 */ u16 gold; 
};



int NewObtainCoinsUsability(int trapID) { 
	struct CoinsTrap* trap = (struct CoinsTrap*)NewGetAdjacentTrapID(gActiveUnit, CoinsTrapID_Link); 
	if (trap) { 
		if (!CheckNewFlag_No_sC(trap->flag)) { 
			if (!(gActiveUnit->state & US_CANTOING)) {
				return true;  
			}
		} 
	}
	return 3; // false 
} 

int NewObtainCoinsUsability0x15(void) { 
	return NewObtainCoinsUsability(CoinsTrapID_Link); 
}


int TrapEffectCleanup(void) { 
	gActionData.unitActionType = 0x1; // from wait routine 
	SMS_UpdateFromGameData(); // needed while in FMU mode 
	return returnValue; //  play beep sound & end menu on next frame & clear menu graphics

} 


int NewObtainCoinsEffect(void) { 

	struct Trap* trap = NewGetAdjacentTrapID(gActiveUnit, CoinsTrapID_Link); 
	if (trap) { 
	SetNewFlag_No_sC(trap->data[0]); 
	short gold = trap->data[1] | trap->data[2]<<8; 
	gEventSlot[3] = gold; 
	
	CallMapEventEngine(&GiveCoinsEvent, EV_RUN_CUTSCENE);
	RemoveLightRune((struct Trap*)trap); // also fixes the terrain 
	}
	
	
	//int result = ObtainCoinsEffect(); 

	return TrapEffectCleanup(); 
} 

extern int BerryTrapID_Link; 
extern const void* PickBerryEvent; 
extern const void* NoBerriesEvent; 

int NewBerryTreeUsability(void) { 
	struct Trap* trap = NewGetAdjacentTrapID(gActiveUnit, BerryTrapID_Link); 
	if (trap) 
		return true; 
	return 3; 
} 

int NewPickBerryTreeEffect(void) { 
	struct Trap* trap = NewGetAdjacentTrapID(gActiveUnit, BerryTrapID_Link); 
	int berries = 0; 
	if (trap) berries = trap->data[0];
	if (berries) { 
		gEventSlot[4] = berries; 
		trap->data[0] = 0; // no more berries 
		CallMapEventEngine(&PickBerryEvent, EV_RUN_CUTSCENE);
		gActionData.unitActionType = 0x1; // only use up turn if we got a berry 
	} 
	else {
		CallMapEventEngine(&NoBerriesEvent, EV_RUN_CUTSCENE);
		// set cantoing? 
	}
	return returnValue; 
} 

int DisplayTextEffect(struct Trap* trap); 
extern int SignTrapID_Link; 
extern int Sign2TrapID_Link; 
extern int BlankExamineID_Link; 
extern int BlankTalkID_Link; 
extern int TutSignID_Link; 
extern int HelpMsgFlagOffset_Link; 
extern const void* TutTextEvent; 

int DisplayTextUsability(int id);

int DisplayTextUsability0x50(void) { 
	return DisplayTextUsability(SignTrapID_Link); 
} 
int DisplayTextUsability0x51(void) { 
	return DisplayTextUsability(Sign2TrapID_Link); 
} 
int DisplayTextUsability0x52(void) { 
	return DisplayTextUsability(BlankExamineID_Link); 
} 
int DisplayTextUsability0x53(void) { 
	return DisplayTextUsability(BlankTalkID_Link); 
} 
int DisplayTextUsability0x54(void) { 
	struct Trap* trap = NewGetAdjacentTrapID(gActiveUnit, TutSignID_Link);
	if (trap) { 
		//if ((trap->data[0] == 0) || !(CheckNewFlag_No_sC(trap->data[0] | (HelpMsgFlagOffset_Link)))) { // we want it to always be readable 
		// this flag is only set so the automatic message is not repeatedly shown 
		return 1; 
		//} 
	} 
	return 3; 
} 

int DisplayTextUsability(int id) { 
	struct Trap* trap = NewGetAdjacentTrapID(gActiveUnit, id);
	if (trap) { 
		if ((trap->data[0] == 0) || !(CheckNewFlag_No_sC(trap->data[0]))) { 
		return 1; 
		} 
	} 
	return 3; 
} 

int DisplayTextEffect0x50(void) { 
	int id1 = SignTrapID_Link; 
	struct Trap* trap = NewGetAdjacentTrapID(gActiveUnit, id1); 
	// for some reason these use SetNewFlag yet the initialization uses CheckEventId 
	// the asm I wrote does this so whatever, I'm leaving it like this for now 
	if (trap) SetNewFlag_No_sC(trap->data[0]); // maybe should use a defined offset for the flag 
	//SetNewFlag_No_sC(trap->data[0]<<3 | (HelpMsgFlagOffset_Link)); 
	return DisplayTextEffect(trap); 
} 

int DisplayTextEffect0x51(void) { 
	int id1 = Sign2TrapID_Link; 
	struct Trap* trap = NewGetAdjacentTrapID(gActiveUnit, id1); 
	if (trap) SetNewFlag_No_sC(trap->data[0]); 
	return DisplayTextEffect(trap); 
} 

int DisplayTextEffect0x52(void) { 
	int id1 = BlankExamineID_Link; 
	struct Trap* trap = NewGetAdjacentTrapID(gActiveUnit, id1); 
	if (trap) SetNewFlag_No_sC(trap->data[0]); 
	return DisplayTextEffect(trap); 
} 

int DisplayTextEffect0x53(void) { 
	int id1 = BlankTalkID_Link; 
	struct Trap* trap = NewGetAdjacentTrapID(gActiveUnit, id1); 
	if (trap) SetNewFlag_No_sC(trap->data[0]); 
	return DisplayTextEffect(trap); 
} 

// sets a different flag 
int DisplayTextEffect0x54(void) { 
	int id1 = TutSignID_Link; 
	struct Trap* trap = NewGetAdjacentTrapID(gActiveUnit, id1); 
	//if (trap) SetNewFlag_No_sC(trap->data[0]<<3 | (HelpMsgFlagOffset_Link)); 
	if (trap) { 
	SetNewFlag_No_sC(trap->data[0] | (HelpMsgFlagOffset_Link)); } 
	return DisplayTextEffect(trap); 
} 

int DisplayTextEffect(struct Trap* trap) { 
	if (trap) { 
	//SetNewFlag_No_sC(trap->data[0]); TutorialTraps have a different ram offset!
	// Do not set flag in this function 
	int textID = trap->data[1] | trap->data[2]<<8; 
	gEventSlot[2] = textID; 
		
	if (textID) { 
		CallMapEventEngine(&TutTextEvent, EV_RUN_CUTSCENE);
		gActionData.unitActionType = 0x1; // only use up turn if we got a berry 
	} 
	} 
	return returnValue; 
} 


struct ObstacleTrap { 
	/* 00 */ u8 xPosition;
	/* 01 */ u8 yPosition;
	/* 02 */ u8 type;
	/* 03 */ u8 pad1;
	/* 03 */ u8 pad2;
	/* 04 */ u8 effectID; 
};


extern int CutBushTrapID_Link; 
extern int RockSmashTrapID_Link; 
extern int StrengthBoulderTrapID_Link; 
extern int ObtainedCutFlag_Link; 
extern int RockSmashFlag_Link; 
extern int StrengthBoulderFlag_Link; 
// AlwaysInitTrap

int NewCutBushUsability() { 
	if (CheckEventId(ObtainedCutFlag_Link)) { 
		struct ObstacleTrap* trap = (struct ObstacleTrap*)NewGetAdjacentTrapID(gActiveUnit, CutBushTrapID_Link); 
		if (trap) { 
			if (!(gActiveUnit->state & US_CANTOING)) {
				return true;  
			}
		}
	} 
	return 3; // false 
} 
int NewRockSmashUsability() { 
	if (CheckEventId(RockSmashFlag_Link)) { 
		struct ObstacleTrap* trap = (struct ObstacleTrap*)NewGetAdjacentTrapID(gActiveUnit, RockSmashTrapID_Link); 
		if (trap) { 
			if (!(gActiveUnit->state & US_CANTOING)) {
				return true;  
			}
		}
	} 
	return 3; // false 
} 
int NewStrengthBoulderUsability() { 
	if (CheckEventId(StrengthBoulderFlag_Link)) { 
		struct ObstacleTrap* trap = (struct ObstacleTrap*)NewGetAdjacentTrapID(gActiveUnit, StrengthBoulderTrapID_Link); 
		if (trap) { 
			if (!(gActiveUnit->state & US_CANTOING)) {
				return true;  
			}
		}
	} 
	return 3; // false 
} 

int NewCutBushEffect(void) { 
	struct Trap* trap = NewGetAdjacentTrapID(gActiveUnit, CutBushTrapID_Link); 
	if (trap) { 
	//CallMapEventEngine(&GiveCoinsEvent, EV_RUN_CUTSCENE);
		RemoveLightRune((struct Trap*)trap); // also fixes the terrain 
	}
	return TrapEffectCleanup(); 
} 
int NewRockSmashEffect(void) { 
	struct Trap* trap = NewGetAdjacentTrapID(gActiveUnit, RockSmashTrapID_Link); 
	if (trap) { 
	//CallMapEventEngine(&GiveCoinsEvent, EV_RUN_CUTSCENE);
		RemoveLightRune((struct Trap*)trap); // also fixes the terrain 
	}
	return TrapEffectCleanup(); 
} 
//int NewStrengthBoulderEffect(void) { } // done in asm 



