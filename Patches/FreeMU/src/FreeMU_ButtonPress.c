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

extern struct MenuProc* StartSemiCenteredOrphanMenu(const struct MenuDef* def, int xSubject, int xTileLeft, int xTileRight);
extern const struct MenuDef gUnitActionMenuDef;
bool FMU_open_um(struct FMUProc* proc){
	gLCDIOBuffer.dispControl.enableWin0 = 0;
	gLCDIOBuffer.dispControl.enableWin1 = 0;
	gLCDIOBuffer.dispControl.enableObjWin = 0;
	gLCDIOBuffer.blendControl.effect = 0;
	StartSemiCenteredOrphanMenu(&gUnitActionMenuDef, gBmSt.cursorTarget.x - gBmSt.camera.x, 1, 0x14);
	return 1;
}

/*!!!!*/

bool FMU_OnButton_StartMenu(FMUProc* proc){
	gLCDIOBuffer.dispControl.enableWin0 = 0;
	gLCDIOBuffer.dispControl.enableWin1 = 0;
	gLCDIOBuffer.dispControl.enableObjWin = 0;
	gLCDIOBuffer.blendControl.effect = 0;
	StartMenuAdjusted(&FreeMovementLMenu,0,0,0);
	return 1;
}

int FMU_OnButton_EndFreeMove(void){
	struct FMUProc* proc = (struct FMUProc*)ProcFind(FreeMovementControlProc);
	FreeMoveRam->silent = false; 
	gLCDIOBuffer.dispControl.enableWin0 = 0;
	gLCDIOBuffer.dispControl.enableWin1 = 0;
	gLCDIOBuffer.dispControl.enableObjWin = 0;
	gLCDIOBuffer.blendControl.effect = 0;
	ProcGoto((Proc*)proc,0xF);
	End6CInternal_FreeMU(proc);
	return 0xB7; // close menu etc 
}

extern void SetupActiveUnit(struct Unit* unit); 
extern int CallCommandEffect(void); 
int FMU_EndFreeMoveSilent(void){
	FreeMoveRam->silent = true; 
	gLCDIOBuffer.dispControl.enableWin0 = 0;
	gLCDIOBuffer.dispControl.enableWin1 = 0;
	gLCDIOBuffer.dispControl.enableObjWin = 0;
	gLCDIOBuffer.blendControl.effect = 0; // restore things back to normal - otherwise map can glitch 
	struct FMUProc* proc = (struct FMUProc*)ProcFind(FreeMovementControlProc);
	if (proc) { 
		gActiveUnit->xPos = proc->xTo; 
		gActiveUnit->yPos = proc->yTo; 
		ProcGoto((Proc*)proc,0xF);
		End6CInternal_FreeMU(proc);
	}
	SetupActiveUnit(gActiveUnit); 
	CallCommandEffect(); 
	return 0xB7; // close menu etc 
}

bool FMU_OnButton_ChangeUnit(FMUProc* proc){
	Unit* UnitNext = GetUnit(proc->FMUnit->index+1);
	while( IsCharNotOnMap(UnitNext) )
	{
		UnitNext = GetUnit(UnitNext->index+1);
		if( IsCharInvaild(UnitNext) )
		{
			UnitNext = GetUnit(1);
			proc->FMUnit = UnitNext;
			gActiveUnit = UnitNext;
			return 1;
		}
	}
	
	if( IsCharInvaild(UnitNext) )
		UnitNext = GetUnit(1);
	proc->FMUnit = UnitNext;
	gActiveUnit = UnitNext;
	return 1;
}
