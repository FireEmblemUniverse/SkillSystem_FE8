#include "gbafe.h"

extern void RemoveLightRune(struct Trap* trap); 

struct FMURam { 
	u8 state : 1; 
	u8 running : 1; 
	u8 dir : 2; 
	u8 silent : 1; 
	u8 use_dir : 1; 
};

extern struct FMURam* FreeMoveRam; 

extern void SetNewFlag(int); 
extern int CheckNewFlag(int); 


extern const void* GiveCoinsEvent; 
extern int CoinsTrapID_Link; 




	
struct Trap* NewGetAdjacentTrap(struct Unit* unit, int trapID_low, int trapID_high) { 
	struct Trap* trap = 0; 
	int x = unit->xPos; 
	int y = unit->yPos; 
	
	if (FreeMoveRam->use_dir) { 
		//struct FMUProc* proc = (FMUProc*)ProcFind(FreeMovementControlProc);
		int dir = FreeMoveRam->dir; 
		if (dir==0)      x--;
		else if (dir==1) x++;
		else if (dir==2) y++;
		else             y--;
		trap = GetTrapAt(x, y);
		if ((trap->type >= trapID_low) && (trap->type <= trapID_high)) 
			return trap;
		else 
			return 0; 
	} 
	
	for (int i = 0; i < 4; i++) { 
		if (i == 0) x++; 
		if (i == 1) x-= 2; 
		if (i == 2) { x++; y++; } 
		if (i == 3) y-= 2; 
		trap = GetTrapAt(x, y);
		if ((trap->type >= trapID_low) && (trap->type <= trapID_high)) 
			return trap;
	} 
	return 0; 
} 

struct Trap* NewGetAdjacentTrapID(struct Unit* unit, int trapID) {
	return NewGetAdjacentTrap(unit, trapID, trapID); 
} 

void NewObtainCoinsInit(struct EventTrapData* eTrap) { 
	//struct CoinsTrap* trap = (struct CoinsTrap*)AddTrapExt(eTrap->data[0], eTrap->data[1], eTrap->type, eTrap->data[2], eTrap->data[3], eTrap->data[4], 0);
	AddTrapExt(eTrap->data[0], eTrap->data[1], eTrap->type, eTrap->data[2], eTrap->data[3], eTrap->data[4], 0); 

} 

//struct Trap {
//	/* 00 */ u8 xPosition;
//	/* 01 */ u8 yPosition;
//	
//	/* 02 */ u8 type;
//	
//	/* 03 */ u8 data[5];
//};

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
		if (!CheckNewFlag(trap->flag)) { 
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
	gActionData.unitActionType = 0x10; // from wait routine 
	SMS_UpdateFromGameData(); // needed while in FMU mode 
	return 0x94; //  play beep sound & end menu on next frame & clear menu graphics

} 


int NewObtainCoinsEffect(void) { 

	struct Trap* trap = NewGetAdjacentTrapID(gActiveUnit, CoinsTrapID_Link); 

	SetNewFlag(trap->data[0]); 
	short gold = trap->data[1] | trap->data[2]<<8; 
	gEventSlot[3] = gold; 
	
	CallMapEventEngine(&GiveCoinsEvent, EV_RUN_CUTSCENE);
	RemoveLightRune((struct Trap*)trap); // also fixes the terrain 
	
	
	//int result = ObtainCoinsEffect(); 

	return TrapEffectCleanup(); 
} 

extern int BerryTrapID_Link; 
extern const void* PickBerryEvent; 
extern const void* NoBerriesEvent; 
int NewPickBerryTreeEffect(void) { 
	struct Trap* trap = NewGetAdjacentTrapID(gActiveUnit, BerryTrapID_Link); 
	int berries = trap->data[0];
	if (berries) { 
		trap->data[0] = 0; // no more berries 
		gEventSlot[4] = berries; 
		CallMapEventEngine(&PickBerryEvent, EV_RUN_CUTSCENE);
		gActionData.unitActionType = 0x10; // only use up turn if we got a berry 
	} 
	else {
		CallMapEventEngine(&NoBerriesEvent, EV_RUN_CUTSCENE);
		// set cantoing? 
	}
	return 0x94; 
} 





