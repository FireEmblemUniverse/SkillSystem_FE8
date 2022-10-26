#include "unit_mover.h"

extern u32 MoveArrowType; 
extern u32 IceTrapType; 
extern u32 StopSlidingTrapType; 
extern u32 BrokenIceTrapType; 
extern u32 PuddleTrapType; 

extern struct MovementArrowStruct *gpMovementArrowData; 

extern struct MovementArrowStruct MoveArrow; 
struct MovementArrowStruct { 
	PROC_FIELDS 
	u8 cursorX; // cursor after reaching destination 
	u8 cursorY; 
	u8 remainingMove; 
	s8 count; // count of entries 
	s8 xdata[20]; 
	s8 ydata[20]; 
	s8 movecost[20]; 
}; 
/*
Movement Arrow Data Layout:
	+29 | byte       | last cursor x pos
	+2A | byte       | last cursor y pos
	+2B | byte       | Active Unit Remaining Movement (In vanilla: ClassBase+MoveBonus-AlreadyMovedAmount)
	+2C | sbyte      | last entry index of the point arrays
	+2D | sbyte[20?] | array of point x coords
	+41 | sbyte[20?] | array of point y coords
	+55 | sbyte[20?] | array of point movement costs
*/ 


typedef struct _TrapHandlerProc TrapHandlerProc;
struct _TrapHandlerProc {
	PROC_FIELDS
	
	Unit* pUnit;
	int   idk;
	u8 direction; 
};

void HandleTrap(Proc* proc, Unit* unit, int idk);
void TrapHandlerCheck(TrapHandlerProc* proc);
void TrapUnitMenu(TrapHandlerProc* proc);
void TrapCleanup(Unit* unit);

static const struct Vec2 DirectionStepTable[] = {
	{ -1,  0 }, // left
	{ +1,  0 }, // right
	{  0, +1 }, // down
	{  0, -1 }  // up
};

/*
static const uint8_t OppositeDirectionTable[] = {
	1, // left  -> right
	0, // right -> left
	3, // down  -> up
	2  // up    -> down
};
//*/

static const ProcCode ProcCode_TrapHandler[] = {
	PROC_SET_NAME("Stan:MovingTrapHandler"),
	PROC_YIELD,
	
	PROC_WHILE_ROUTINE(MU_IsAnyActive),
	
PROC_LABEL(0),
	PROC_CALL_ROUTINE(TrapHandlerCheck),
	PROC_WHILE_ROUTINE(0x08078721), // Blocking MoveUnit 6C Exists
	PROC_GOTO(0),
	
PROC_LABEL(1),
	PROC_CALL_ROUTINE(TrapUnitMenu),
	PROC_END
};




const int CanUnitBeOnPosition(Unit* unit, int x, int y) { // also used by strength boulders 
	if (x < 0 || y < 0)
		return 0; // position out of bounds
	
	if (x >= gMapSize.x || y >= gMapSize.y)
		return 0; // position out of bounds
	
	if (gMapUnit[y][x])
		return 0; // a unit is occupying this position
	
	if (gMapHidden[y][x] & 1)
		return 0; // a hidden unit is occupying this position
	
	return CanUnitCrossTerrain(unit, gMapTerrain[y][x]);
}

struct Vec2 GetPushPosition(Unit* unit, int direction, int moveAmount) {
	struct Vec2 result = {
		unit->xPos,
		unit->yPos
	};
	const struct Vec2 step = DirectionStepTable[direction];
	bool StopIfNotIce = false; 
	
	//struct MovementArrowStruct MoveArrow = *gpMovementArrowData;
	//Trap* trap = GetTrapAt(MoveArrow.xdata[0], MoveArrow.ydata[0]);
	//if (trap->type == IceTrapType) { 
	//	RemoveTrap(trap);
	//	StopIfNotIce = true; 
	//} 
	Trap* trap;
	trap = GetTrapAt(result.x, result.y);
	if (trap->type == IceTrapType) { 
		RemoveTrap(trap);
		StopIfNotIce = true; 
	} 

	while (CanUnitBeOnPosition(unit, (result.x + step.x), (result.y + step.y))) {
		trap = GetTrapAt(result.x, result.y);
		if (trap->type == IceTrapType) { 
			RemoveTrap(trap);
			StopIfNotIce = true; 
		} 
	
		result.x += step.x;
		result.y += step.y;
		if (!(--moveAmount)) 
			break;
		

		if (trap->type == StopSlidingTrapType) {
			//asm("mov r11, r11"); 
			result.x -= step.x; 
			result.y -= step.y; 
			moveAmount = -1;
			break;
		}
		
		if (trap->type == BrokenIceTrapType) {
			//asm("mov r11, r11"); 
			//RemoveTrap(trap);
			//AddTrap(result.x, result.y, PuddleTrapType, 0);
			result.x -= step.x; 
			result.y -= step.y; 
			moveAmount = -1;
			break;
		}

		if ((!(gMapTerrain[result.y][result.x] == 0x2F)) & StopIfNotIce) {
			break; 
		}


		if (gMapHidden[result.y][result.x] && 2) { // check for a hidden trap such as a mine
			if (!(gMapTerrain[result.y][result.x] == 0x2F)) { // if gMapHidden and not ice, stop here 
				break; 
			} 
		} 
	}
	trap = GetTrapAt(result.x, result.y);
	if (trap->type == IceTrapType) { 
		RemoveTrap(trap);
	} 
		
	return result;
}

void HandleTrap(ProcState* proc, Unit* unit, int idk) {
	RefreshEntityBmMaps();

	
	//if ((unit->state && US_HAS_MOVED_AI)) { 
	// unit state 0x1E US_Processing_Movement ? 
	if (gActionData.unitActionType == 0x1E) { 
		TrapHandlerProc* newProc = (TrapHandlerProc*) ProcStartBlocking(ProcCode_TrapHandler, proc);
		gActionData.unitActionType = 0x1F; 
		//unit->state = unit->state | US_HAS_MOVED_AI; 
		newProc->pUnit = unit;
		newProc->idk   = idk;
		struct MUProc* muProc = MU_GetByUnit(unit);
		if (muProc) { newProc->direction = muProc->facingId; } 
		MU_EndAll();
	} 
	

	else { 
		TrapCleanup(unit); 
		//Trap* trap = GetTrapAt(x, y);
		//RemoveTrap(struct Trap* trap);
	} 
	
}



//extern const ProcInstruction gProc_MoveUnit;
//extern const ProcInstruction gProc_PlayerPhase;
extern void UpdateAllLightRunes(void); 
extern const MenuDefinition gMenu_UnitMenu; 
extern MenuProc* StartMenu_AndDoSomethingCommands(const MenuDefinition*, int xScreen, int xLeft, int xRight); //! FE8U = 0x804F64D

typedef struct MUProc muProc; 

void TrapUnitMenu(TrapHandlerProc* proc) { 

	if (!(proc->pUnit->index >> 6)) { 
		int x1 = gGameState._unk1C.x; 
		int x2 = gGameState.cameraRealPos.x; 
		x1 = x1 - x2; 
		
		// added Sept 2022 so walking 1 tile onto cracked ice / puddles etc. opens the unit menu 
		//proc->pUnit->state = (proc->pUnit->state & 0xFFFFFFFE) | 1; // add hide bitflag 
		proc->pUnit->state = (proc->pUnit->state | 1); // add hide bitflag 
		//RefreshEntityBmMaps();
		//RefreshUnitsOnBmMap();
		SMS_UpdateFromGameData();
		
		MU_EndAll();
		struct MUProc* muProc = MU_Create(proc->pUnit);
		MU_EnableAttractCamera(muProc);
		//muProc->boolAttractCamera = true; 
		muProc->boolForceMaxSpeed = true; 
		//MU_StartActionAnim(muProc);
		
		StartMenu_AndDoSomethingCommands(&gMenu_UnitMenu, x1, 1, 20); //! FE8U = 0x804F64D
		Proc* playerPhaseProc = ProcFind(&gProc_PlayerPhase[0]); //! FE8U = (0x08002E9C+1)
		ProcGoto(playerPhaseProc, 7); // apply unit action etc. //! FE8U = (0x08002F24+1)
	} 

	// else 
	if (proc->pUnit->index >> 6) {  TrapCleanup(proc->pUnit); } 
} 

void TrapCleanup(Unit* unit) { 

	MU_EndAll();
	//moveunit->pUnit->state = moveunit->pUnit->state & 0xFFFFFFFE; // remove hide bitflag 
	//gActionData.unitActionType = UNIT_ACTION_TRADED; 
	unit->state = (unit->state & 0xFFFFFFFE) | 0x2; // remove hide bitflag 
	RefreshEntityBmMaps();
	RefreshUnitsOnBmMap();
	//RefreshMinesOnBmMap(); 
	
	SMS_UpdateFromGameData();
	RenderBmMap();
} 

void TrapHandlerCheck(TrapHandlerProc* proc) {
	u8 x = proc->pUnit->xPos;
	u8 y = proc->pUnit->yPos;
	Trap* trap = GetTrapAt(x, y);
	//u8 previousTileX = x; 
	//u8 previousTileY = y; 
	u8 direction = trap->data[0]; 
	
	if (trap->type) {
		
		if (trap->type == BrokenIceTrapType) { 
			//RemoveTrap(trap);
			//AddTrap(x, y, PuddleTrapType, 0);
			//UpdateAllLightRunes();
		} 
		
		if (trap->type == IceTrapType) { // ice trap 
			direction = proc->direction; 
			//struct MovementArrowStruct MoveArrow = *gpMovementArrowData; // does a memcpy but works lol gpMovementArrowData 0859dba0
			//asm("mov r11, r11"); 
			//for (int i = MoveArrow.count; i>0; i--) { 
			//	if ((MoveArrow.xdata[i] == x) && (MoveArrow.ydata[i] == y)) { 
			//		if (i>0) { 
			//			previousTileX = MoveArrow.xdata[i-1]; // use entry immediately before our current location 
			//			previousTileY = MoveArrow.ydata[i-1]; // then discern direction from this 
			//		} 
			//	}
			//} 
			//
			//// right, down, left, up
			//// BYTE 1 2 0 3
			//
			//if (previousTileX < x) { direction = 1; } // right 
			//if (previousTileX > x) { direction = 0; } // left 
			//if (previousTileY < y) { direction = 2; } // down 
			//if (previousTileY > y) { direction = 3; } // up

		}
		if ((trap->type == IceTrapType) | (trap->type == MoveArrowType)) { 
			u32 bicState = ~0x42; // canto / ended turn already 
			proc->pUnit->state = (proc->pUnit->state & bicState) | 0x1; // add hide bitflag if it wasn't already there (eg. for chained movements) 
			SMS_UpdateFromGameData(); // so they will be hidden during chained movement 
			
			struct Vec2 dest = GetPushPosition(proc->pUnit, direction, 0);
			struct Vec2 start;
			start.x = x; 
			start.y = y; 
			struct MUProc* muProc = (void*)ProcFind(&gProc_MoveUnit[0]);
			if ( !muProc ) { // starting the MUProc (without using it i guess) breaks the game 
				muProc = (void*)MU_Create(proc->pUnit); // If the proc doesn't exist yet, make one.
			} 

			
			NewUnitMoveAnim(muProc, start, dest, (Proc*) proc);
			
			
			
			
			if ((dest.x == x) && (dest.y == y)) {
				ProcGoto((Proc*) proc, 1);
			} else {
				// FIXME: write definitions for the whole AI pre-action struct thingy
				
				uint8_t* const pAIX = (uint8_t*) 0x0203AA96;
				uint8_t* const pAIY = (uint8_t*) 0x0203AA97;
				
				(*pAIX) = proc->pUnit->xPos = gActionData.xMove = dest.x;
				(*pAIY) = proc->pUnit->yPos = gActionData.yMove = dest.y;
			}
		}
		else 
			ProcGoto((Proc*) proc, 1);
	} else
		ProcGoto((Proc*) proc, 1);
}
