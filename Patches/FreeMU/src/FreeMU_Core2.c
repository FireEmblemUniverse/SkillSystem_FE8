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



void InitUpdateBool(struct FMUProc* proc) {
	proc->updateBool = false; 
	proc->facingId = MU_FACING_SELECTED;
} 

/*
 *
 *	In Core
 *
*/
extern void MU_DisplayAsMMS(struct MUProc* proc); 

void pFMU_MainLoop(struct FMUProc* proc){

	struct MUProc* muProc = MU_GetByUnit(gActiveUnit);
	
	if (muProc) { 
		if (muProc->pMUConfig->commands[muProc->pMUConfig->currentCommand] != MU_COMMAND_HALT && muProc->stateId > MU_STATE_NONACTIVE) { 
			return; // MU_COMMAND_HALT is the terminator 
		} 
	} 
	
	if (muProc) { 
		if (muProc->pMUConfig->commands[muProc->pMUConfig->currentCommand] == MU_COMMAND_HALT) { 
			if (proc->updateBool) { 
				asm("mov r11, r11"); 
				//MU_End(muProc);

				muProc->stateId = MU_STATE_NONACTIVE; // yes
				
				MU_DisplayAsMMS(muProc);
				HideUnitSMS(gActiveUnit);
				
				proc->updateBool = false; 
				muProc->boolIsHidden = false; 
				MU_Show(muProc);
			}
		} 
	} 
	
	else { 
		//MU_EndAll();
		struct MUProc* muProc = MU_Create(gActiveUnit);
		muProc->stateId = MU_STATE_NONACTIVE; // yes
		MU_DisplayAsMMS(muProc);
		HideUnitSMS(gActiveUnit);
		MU_SetFacing(muProc, proc->facingId);
		MU_Show(muProc);
	} 
	

	
	
	if (muProc->facingId != MU_FACING_STANDING && muProc->facingId != MU_FACING_UNK11) { 
		//return;
	} 
	//int finishedMov = ((u8)(muProc->stateId - MU_STATE_MOVEMENT) <= (MU_STATE_WAITING - MU_STATE_MOVEMENT)); 

	

	
	// if muProc->pMUConfig.currentCommand hasn't changed ? 
	

	

	 
	//if (muProc->moveTimer == 0) { 
	//if (!MU_IsAnyActive() || muProc->boolIsHidden) { 
			//HideUnitSMS(gActiveUnit);
			//muProc->boolIsHidden = false; 
			//MU_SetFacing(muProc, MU_FACING_UP);
	//} 
	
	
	/*
	if (!MU_Exists()) { 
		struct MUProc* muProc = MU_Create(gActiveUnit);
		muProc->stateId = MU_STATE_NONACTIVE; // yes 
		
		MU_SetFacing(muProc, MU_FACING_UP); //does these 2 commands below 
		//muProc->facingId = MU_FACING_UP;
		//AP_SwitchAnimation(proc->pAPHandle, proc->facingId);
		
		
		
		struct MUConfig* config = muProc->pMUConfig;
		config->currentCommand = 1; 
		for (int i = 0; i < MU_COMMAND_MAX_COUNT; i++) { 
			config->commands[MU_COMMAND_MAX_COUNT] = MU_COMMAND_FACE_UP; // to idle ? 
		} 
		
		//MU_StartActionAnim(muProc);
		//MU_SetFacing(muProc, MU_COMMAND_FACE_UP);
		
		HideUnitSMS(gActiveUnit);
		MU_Show(muProc);
	} 
		
	if(MU_IsAnyActive()){
		return;
	}
	*/
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
	
	//proc->xCur = x;
	//proc->xCur = y;
	//proc->xTo  = x;
	//proc->xTo  = y;
	u8 mD[10]; //moveDirections[10]; 
	mD[0] = MU_COMMAND_HALT; // default to do no movement 
	struct MUProc* muProc = MU_GetByUnit(gActiveUnit);
	
	
	if(0xF0&iKeyCur){
		if(iKeyCur&0x10) 		{ x++; if (muProc->facingId != MU_FACING_RIGHT) mD[0] = MU_COMMAND_FACE_RIGHT; else mD[0] = MU_COMMAND_MOVE_RIGHT; } 
		else if(iKeyCur&0x20)	{ x--; if (muProc->facingId != MU_FACING_LEFT) mD[0] = MU_COMMAND_FACE_LEFT; else mD[0] = MU_COMMAND_MOVE_LEFT; } 
		else if(iKeyCur&0x40)	{ y--; if (muProc->facingId != MU_FACING_UP) mD[0] = MU_COMMAND_FACE_UP; else mD[0] = MU_COMMAND_MOVE_UP; } 
		else if(iKeyCur&0x80)	{ y++; if (muProc->facingId != MU_FACING_DOWN) mD[0] = MU_COMMAND_FACE_DOWN; else mD[0] = MU_COMMAND_MOVE_DOWN; } 
	}
	mD[1] = MU_COMMAND_HALT; // halt 
	if (mD[0] > MU_COMMAND_HALT) {
		MU_StartMoveScript(muProc, &mD[0]); // always change directions freely 
		proc->facingId = mD[0] - 6; 
	}
	else { 
		if( !IsPosInvaild(x,y) ){
			proc->xTo = x;
			proc->yTo = y;
		}
			
		if( FMU_CanUnitBeOnPos(gActiveUnit, x, y) ){
			if( !IsPosInvaild(x,y) ) { } 
				//MU_EndAll();
				
				
				MU_StartMoveScript(muProc, &mD[0]); 
				gActiveUnit->xPos = x; 
				gActiveUnit->yPos = y; 
				//MuCtr_StartMoveTowards(gActiveUnit, x, y, 0x10);
				proc->updateBool = true; 
		}
	} 
	
	if (mD[0] == MU_COMMAND_HALT) { 
			ProcGoto((Proc*)proc,0x2);
	}
	return;
}



void pFMU_HandleKeyMisc(struct FMUProc* proc){	//Label 2
	u16 iKeyCur = gKeyState.heldKeys;
	if(1&iKeyCur){ 			//Press A
		ProcGoto((Proc*)proc,0x4); 
		return;
		}			
	if(2&iKeyCur){ 			//Press B
		ProcGoto((Proc*)proc,0x5); 
		return;
		}	
	if(2&(iKeyCur>>0x8)){ 	//Press L
		ProcGoto((Proc*)proc,0x6); 
		return;
		}
	if(1&(iKeyCur>>0x8)){ 	//Press R
		ProcGoto((Proc*)proc,0x7); 
		return;
		}
	if(4&iKeyCur){ 			//Press Select
		ProcGoto((Proc*)proc,0x8); 
		return;
		}
	if(8&iKeyCur){ 			//Press Start
		ProcGoto((Proc*)proc,0x9); 
		return;
		}
	return;
}

void pFMU_HandleSave(struct FMUProc* proc){	//KeyPress Default
	if( TimerDelay < ++proc->uTimer ){
		ProcGoto((Proc*)proc,0xE);
		proc->uTimer=0;
	}
	return;
}


void pFMU_PressA(struct FMUProc* proc){
	u16 iKeyCur = gKeyState.heldKeys;
	if( 0 == (1&iKeyCur) )
		return;
	
	ButtonFunc* it = &FMU_FunctionList_OnPressA[0];
	while(*it)
		if( (*it++)(proc) )
			return;
	return;
}


void pFMU_PressB(struct FMUProc* proc){
	u16 iKeyCur = gKeyState.heldKeys;
	if( 0 == (2&iKeyCur) )
		return;
	
	ButtonFunc* it = &FMU_FunctionList_OnPressB[0];
	while(*it)
		if( (*it++)(proc) )
			return;
	return;
}

void pFMU_PressL(struct FMUProc* proc){
	u16 iKeyCur = gKeyState.heldKeys;
	if( 0 == (2&iKeyCur>>0x8) )
		return;
	
	ButtonFunc* it = &FMU_FunctionList_OnPressL[0];
	while(*it)
		if( (*it++)(proc) )
			return;
	return;
}

void pFMU_PressR(struct FMUProc* proc){
	u16 iKeyCur = gKeyState.heldKeys;
	if( 0 == (1&iKeyCur>>0x8) )
		return;
	
	ButtonFunc* it = &FMU_FunctionList_OnPressR[0];
	while(*it)
		if( (*it++)(proc) )
			return;
	return;
}

void pFMU_PressStart(struct FMUProc* proc){
	u16 iKeyCur = gKeyState.heldKeys;
	if( 0 == (8&iKeyCur) )
		return;
	
	ButtonFunc* it = &FMU_FunctionList_OnPressStart[0];
	while(*it)
		if( (*it++)(proc) )
			return;
	return;
}

void pFMU_PressSelect(struct FMUProc* proc){
	u16 iKeyCur = gKeyState.heldKeys;
	if( 0 == (4&iKeyCur) ) 			//Press Select
		return;

	ButtonFunc* it = &FMU_FunctionList_OnPressSelect[0];
	while(*it)
		if( (*it++)(proc) )
			return;
	return;
}







