#include "unit_mover.h"

extern const uint8_t pFacingTable[];

const ProcInstruction ProcCode_UnitMoveAnim[] = {
	PROC_SET_DESTRUCTOR(UnitMoveAnim_OnDestruct), // Delet
	PROC_YIELD,                                   // Yielding to ensure everything is set up properly
	PROC_LOOP_ROUTINE(UnitMoveAnim_OnLoop),       // Move that sprite
	PROC_END                                      // End
};

UnitMoveAnimProc* NewUnitMoveAnim(MoveUnitState* moveunit, struct Vec2 from, struct Vec2 to, Proc* parent) {
	UnitMoveAnimProc* moveAnimProc = 0;

	// making 6C
	if (parent) {
		moveAnimProc = (UnitMoveAnimProc*) ProcStartBlocking(ProcCode_UnitMoveAnim, parent);
		moveAnimProc->locks = 0;
	} else {
		moveAnimProc = (UnitMoveAnimProc*) ProcStart(ProcCode_UnitMoveAnim, ROOT_PROC_3);
		
		moveAnimProc->locks = 1;
		LockGameLogic();
	}
	
	// making linked MOVEUNIT
	// MoveUnitProc* moveunit = NewMoveUnitForMapUnit(unit);
	// MU_SetFacing(moveunit, facing);
	
	MU_SetDisplayPosition(moveunit, from.x, from.y);
	
	// writing fields to the proc struct
	moveAnimProc->pMoveUnit = moveunit;
	moveAnimProc->from      = from;
	moveAnimProc->to        = to;
	moveAnimProc->clock     = 0;
	
	// Returning
	return moveAnimProc;
}

void UnitMoveAnim_OnDestruct(UnitMoveAnimProc* proc) {
	if (proc->locks)
		UnlockGameLogic();
}

void UnitMoveAnim_OnLoop(UnitMoveAnimProc* proc) {
	// TODO: check for fast/slow speed option
	if (!MoveMoveUnitTowards(proc->pMoveUnit, proc->to.x, proc->to.y, 5))
		BreakProcLoop((Proc*) proc);
	// else {
		// int localTime = (proc->timer++) % 4;
		
		// if (!localTime) { // localTime == 0
			// int facing = pFacingTable[((proc->timer++) / 4) % 4];
			// MU_SetFacing(proc->pMoveUnit, facing);
		// }
	// }
}
