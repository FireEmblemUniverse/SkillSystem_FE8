#include "FreeMU.h"

static inline bool IsPosInvaild(s8 x, s8 y){
	return( (x<0) & (x>gMapSize.x) & (y<0) & (y>gMapSize.y) );
}

static inline bool IsCharNotOnMap(Unit* unit){
	if(-1==unit->xPos)
		return 1;
	return 0;
}

static inline bool IsCharInvaild(Unit* unit){
	if(0==unit)
		return 1;
	if(0==unit->pCharacterData)
		return 1;
	return 0;
}





/*
 *
 *	In Core
 *
*/

void pFMU_MainLoop(struct FMUProc* proc){
	if(MU_Exists()){
		/* u8 iKeyDirec = FMU_CheckDirectionButtonPress();
		if(0!=iKeyDirec)
			*(gUnitMoveBuffer+0x4) = iKeyDirec; */
		return;
	}
	ProcGoto((Proc*)proc,0x1);
	return;
}


void pFMU_HanleContinueMove(struct FMUProc*){
	return;
}


void pFMU_MoveUnit(struct FMUProc* proc){	//Label 1
	u16 iKeyCur = gKeyState.heldKeys;
	s8 x = gActiveUnit->xPos;
	s8 y = gActiveUnit->yPos;
	
	proc->xCur = x;
	proc->xCur = y;
	proc->xTo  = x;
	proc->xTo  = y;
	
	if(0xF0&iKeyCur){
		if(iKeyCur&0x10) 		x++;
		else if(iKeyCur&0x20)	x--;
		else if(iKeyCur&0x40)	y--;
		else if(iKeyCur&0x80)	y++;
	}
	
		
	if( !IsPosInvaild(x,y) ){
		proc->xTo = x;
		proc->xTo = y;
	}
		
	if( FMU_CanUnitBeOnPos(gActiveUnit, x, y) ){
		if( !IsPosInvaild(x,y) )
			MuCtr_StartMoveTowards(gActiveUnit, x, y, 0x10);
	}
	else
		ProcGoto((Proc*)proc,0x2);
	return;
}


void pFMU_HandleKeyMisc(struct FMUProc* proc){	//Label 2
	u16 iKeyCur = gKeyState.heldKeys;
	if(1&iKeyCur){ 			//Press A
		ProcGoto((Proc*)proc,0x4); 
		return;
		}			
	if(2&(iKeyCur>>0x8)){ 	//Press L
		ProcGoto((Proc*)proc,0x5); 
		return;
		}
	if(4&iKeyCur){ 			//Press Select
		ProcGoto((Proc*)proc,0x6); 
		return;
		}
	if(8&iKeyCur){ 			//Press Start
		ProcGoto((Proc*)proc,0x7); 
		return;
		}	
	return;
}

void pFMU_HandleSave(struct FMUProc* proc){	//KeyPress Default
	if(++proc->uTimer%5==0){
		ProcGoto((Proc*)proc,0xE);
		proc->uTimer=0;
	}
	return;
}


void pFMU_PressA(struct FMUProc* proc){
	FMUmisc_RunMapEvents(proc);
	FMUmisc_RunTalkEvents(proc);
	return;
}


void pFMU_PressL(struct FMUProc* proc){
	StartMenuAdjusted(&FreeMovementLMenu,0,0,0);
	return;
}

void pFMU_PressSelect(struct FMUProc* proc){
	u16 iKeyCur = gKeyState.heldKeys;
	if( 0==(4&iKeyCur) ) 			//Press Select
		return;

	Unit* UnitNext = GetUnit(proc->FMUnit->index+1);
	while( IsCharNotOnMap(UnitNext) )
	{
		UnitNext = GetUnit(UnitNext->index+1);
		if( IsCharInvaild(UnitNext) )
		{
			UnitNext = GetUnit(1);
			proc->FMUnit = UnitNext;
			gActiveUnit = UnitNext;
			return;
		}
	}
	
	if( IsCharInvaild(UnitNext) )
		UnitNext = GetUnit(1);
	proc->FMUnit = UnitNext;
	gActiveUnit = UnitNext;
	return;
}

void pFMU_PressStart(struct FMUProc* proc){
	return;
}






