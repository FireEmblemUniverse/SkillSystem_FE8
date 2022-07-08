#include "unit_mover.h"

extern u32 MoveArrowType; 
extern u32 IceTrapType; 
extern u32 StopSlidingTrapType; 

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
};

void HandleTrap(Proc* proc, Unit* unit, int idk);
void TrapHandlerCheck(TrapHandlerProc* proc);
void TrapCleanup(TrapHandlerProc* proc);

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
	PROC_CALL_ROUTINE(TrapCleanup),
	PROC_END
};

int CanUnitBeOnPosition(Unit* unit, int x, int y) {
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
	
	while (CanUnitBeOnPosition(unit, (result.x + step.x), (result.y + step.y))) {
		result.x += step.x;
		result.y += step.y;
		if (!(--moveAmount)) 
			break;
		if (gMapHidden[result.y][result.x] & 2) // check for a hidden trap such as a mine
			break;
		Trap* trap = GetTrapAt(result.x, result.y);
		if (trap->type == StopSlidingTrapType) {
			moveAmount = -1;
			break;
		}
		
	} 
	return result;
}

void HandleTrap(ProcState* proc, Unit* unit, int idk) {
	RefreshEntityBmMaps();
	MU_EndAll();
	
	TrapHandlerProc* newProc = (TrapHandlerProc*) ProcStartBlocking(ProcCode_TrapHandler, proc);
	
	newProc->pUnit = unit;
	newProc->idk   = idk;
}


extern struct MovementArrowStruct *gpMovementArrowData; 
extern const ProcInstruction gProc_MoveUnit;
typedef struct MUProc muProc; 

void TrapCleanup(TrapHandlerProc* proc) { 
	//moveunit->pUnit->state = moveunit->pUnit->state & 0xFFFFFFFE; // remove hide bitflag 
	proc->pUnit->state = (proc->pUnit->state & 0xFFFFFFFE) | 0x2; // remove hide bitflag 
	
	RefreshUnitsOnBmMap();
	//RefreshMinesOnBmMap(); 
	SMS_UpdateFromGameData();
	RenderBmMap();
} 

void TrapHandlerCheck(TrapHandlerProc* proc) {
	u8 x = proc->pUnit->xPos;
	u8 y = proc->pUnit->yPos;
	Trap* trap = GetTrapAt(x, y);
	u8 previousTileX = x; 
	u8 previousTileY = y; 
	u8 direction = trap->data[0]; 
	if (trap) {
		
		
		if (trap->type == IceTrapType) { // ice trap 
			struct MovementArrowStruct MoveArrow = *gpMovementArrowData; // does a memcpy but works lol gpMovementArrowData 0859dba0
			//asm("mov r11, r11"); 
			for (int i = MoveArrow.count; i>=0; i--) { 
				if ((MoveArrow.xdata[i] == x) && (MoveArrow.ydata[i] == y)) { 
					if (i>0) { 
						previousTileX = MoveArrow.xdata[i-1]; // use entry immediately before our current location 
						previousTileY = MoveArrow.ydata[i-1]; // then discern direction from this 
					} 
				}
			} 
			// right, down, left, up
			// BYTE 1 2 0 3
			
			if (previousTileX < x) { direction = 1; } // right 
			if (previousTileX > x) { direction = 0; } // left 
			if (previousTileY < y) { direction = 2; } // down 
			if (previousTileY > y) { direction = 3; } // up
		}
		if ((trap->type == IceTrapType) | (trap->type == MoveArrowType)) { 
			u32 bicState = ~0x42; // canto / ended turn already 
			proc->pUnit->state = (proc->pUnit->state & bicState) | 0x1; // add hide bitflag if it wasn't already there (eg. for chained movements) 
			
			
			struct Vec2 dest = GetPushPosition(proc->pUnit, direction, 0);
			struct Vec2 start;
			start.x = x; 
			start.y = y; 
			struct MUProc* muProc = (void*)ProcFind(&gProc_MoveUnit);
			if ( !muProc ) { // starting the MUProc (without using it i guess) breaks the game 
				muProc = (void*)MU_Create(proc->pUnit); // If the proc doesn't exist yet, make one.
			} 

			
			NewUnitMoveAnim(muProc, start, dest, (Proc*) proc);
			SMS_UpdateFromGameData();
			
			
			
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
