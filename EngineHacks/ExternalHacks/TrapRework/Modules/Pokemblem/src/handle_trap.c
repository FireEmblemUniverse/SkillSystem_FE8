#include "unit_mover.h"

typedef struct _TrapHandlerProc TrapHandlerProc;
struct _TrapHandlerProc {
	PROC_FIELDS
	
	Unit* pUnit;
	int   idk;
};

void HandleTrap(Proc* proc, Unit* unit, int idk);
void TrapHandlerCheck(TrapHandlerProc* proc);

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

void TrapHandlerCheck(TrapHandlerProc* proc) {
	Trap* trap = GetTrapAt(proc->pUnit->xPos, proc->pUnit->yPos);
	
	if (trap) {
		// NewUnitMoveAnim(proc->pUnit, OppositeDirectionTable[trap->data[0]], (Proc*) proc);
		
		struct Vec2 pos = GetPushPosition(proc->pUnit, trap->data[0], 0);
		
		if (pos.x == proc->pUnit->xPos && pos.y == proc->pUnit->yPos) {
			ProcGoto((Proc*) proc, 1);
		} else {
			// FIXME: write definitions for the whole AI pre-action struct thingy
			
			uint8_t* const pAIX = (uint8_t*) 0x0203AA96;
			uint8_t* const pAIY = (uint8_t*) 0x0203AA97;
			
			(*pAIX) = proc->pUnit->xPos = gActionData.xMove = pos.x;
			(*pAIY) = proc->pUnit->yPos = gActionData.yMove = pos.y;
		}
	} else
		ProcGoto((Proc*) proc, 1);
}
