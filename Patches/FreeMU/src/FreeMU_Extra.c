#include "FreeMU.h"

/*
 * Basic! 
 */
bool FMU_CanUnitBeOnPos(Unit* unit, s8 x, s8 y){
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



 

void EnableFreeMovementASMC(void){
	*FreeMoveFlag |= 1;
	return;
}
 
void DisableFreeMovementASMC(void){
	*FreeMoveFlag = (*FreeMoveFlag>>1)<<1;
	return;
}

u8 GetFreeMovementState(void){
	return (*FreeMoveFlag&1);
}

void End6CInternal_FreeMU(FMUProc* proc){
	DisableFreeMovementASMC();
	ProcGoto((Proc*)proc,0xF);
	return;	
}

/*
 * On Game Control 
 */
 
void ChangeControlledUnitASMC(struct FMUProc* proc){
	proc->FMUnit=GetUnitStructFromEventParameter(gEventSlot[1]);
	EnsureCameraOntoPosition(0,proc->FMUnit->xPos, proc->FMUnit->yPos);
	return;
}

void NewPlayerPhaseEvaluationFunc(struct Proc* ParentProc){
	if( GetFreeMovementState() )
		ProcStartBlocking(FreeMovementControlProc,ParentProc);
	else
		ProcGoto(ProcStartBlocking(gProc_PlayerPhase,ParentProc),0x7);
	BreakProcLoop(ParentProc);
	return;
}
 
void NewMakePhaseControllerFunc(struct Proc* ParentProc){
	const ProcCode* pTmpProcCode = FreeMovementControlProc;
	if(0==GetFreeMovementState())
	{
		if( 0==gChapterData.currentPhase )
			pTmpProcCode=gProc_PlayerPhase;
		else
			pTmpProcCode=gProc_CpPhase;
	}
	ProcStartBlocking(pTmpProcCode,ParentProc);
	BreakProcLoop(ParentProc);
	return;
}


/*
 * Inside Proc
 */
void pFMU_OnInit(struct FMUProc* proc){
	//vaild?
	if( 0 == proc->FMUnit )
		proc->FMUnit = gUnitArrayBlue;
	if( !( 1&(u32)(proc->FMUnit)>>0x11) )
		proc->FMUnit = gUnitArrayBlue;
	if( !( 1&(u32)(proc->FMUnit)>>0x19) )
		proc->FMUnit = gUnitArrayBlue;
	
	gActiveUnit = proc->FMUnit;
	return;
}


void pFMU_InitTimer(struct FMUProc* proc){
	proc->uTimer = 0;
	return;
}


void pFMU_CorrectCameraPosition(struct FMUProc* proc){
	EnsureCameraOntoPosition((Proc*)proc, gActiveUnit->xPos, gActiveUnit->yPos);
}


u8 FMU_ChkKeyForMUExtra(void){
	u16 iKeyCur = gKeyState.heldKeys;
	if ( iKeyCur&0x10 )	//right
		return 1;
	if ( iKeyCur&0x20 )	//left
		return 0;
	if ( iKeyCur&0x40 )	//up
		return 3;
	if ( iKeyCur&0x80 )	//down
		return 2;
	return 0x10;	
}



