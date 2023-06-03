#include "FreeMU.h"
extern u8 MuCtr_StartMoveTowards(Unit*, u8 x, u8 y, u8, u8 flags); //0x8079DDD

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
extern void MU_DisplayAsMMS(struct MUProc* proc); 

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


void pFMU_UpdateSMS(struct FMUProc* proc){
  u32 tileIndex = (proc->FMUnit->pMapSpriteHandle->oam2Base & 0x3FF) - 0x80;
  u8 smsID = proc->FMUnit->pClassData->SMSId;
  //u16 size = gStandingMapSpriteData[smsID].size;
  u16 size = 1; 
  u8 width =  size < 2 ? 16 : 32;
  u8 height = size > 0 ? 32 : 16;
  u32 srcOffs[3] = {0, 0, 0};
  int frame = GetGameClock() % 72;
  
  // Do nothing if no different-direction facing idle sprites exist.
  if (FMU_idleSMSGfxTable[smsID] == NULL)
    return;
  
  // Decompress sms gfx.
  if (proc->smsFacing==2)
    Decompress(gStandingMapSpriteData[smsID].pGraphics, gGenericBuffer);    // Downward facing sms.
  else {
    Decompress(FMU_idleSMSGfxTable[smsID], gGenericBuffer);                 // Other direction-facing sms.
    srcOffs[0] = proc->smsFacing==3 ? proc->smsFacing-1 : proc->smsFacing;  // Up-facing sprite comes immediately after right.
  }
  
  // Move sms gfx into smsbuffer.
  srcOffs[0] = (srcOffs[0] << (7 + size)) * 3;
  srcOffs[1] = srcOffs[0] + (0x80 << (size << 2));
  srcOffs[2] = srcOffs[1] + (0x80 << (size << 2));
  CopyTileGfxForObj((void*)gGenericBuffer+srcOffs[0], (void*)gSMSGfxBuffer_Frame1+(tileIndex<<5), width>>3, height>>3);
  CopyTileGfxForObj((void*)gGenericBuffer+srcOffs[0], (void*)gSMSGfxBuffer_Frame2+(tileIndex<<5), width>>3, height>>3);
  CopyTileGfxForObj((void*)gGenericBuffer+srcOffs[0], (void*)gSMSGfxBuffer_Frame3+(tileIndex<<5), width>>3, height>>3);
  
  // Overwrite VRAM with new SMS next frame. Timings taken from 0x8026F2C, SyncUnitSpriteSheet.
  if (frame < 31)
    RegisterTileGraphics(gSMSGfxBuffer_Frame1, (void*)0x06011000, sizeof(gSMSGfxBuffer_Frame1));
  else if (frame < 35)
    RegisterTileGraphics(gSMSGfxBuffer_Frame2, (void*)0x06011000, sizeof(gSMSGfxBuffer_Frame2));
  else if (frame < 67)
    RegisterTileGraphics(gSMSGfxBuffer_Frame3, (void*)0x06011000, sizeof(gSMSGfxBuffer_Frame3));
  else
    RegisterTileGraphics(gSMSGfxBuffer_Frame2, (void*)0x06011000, sizeof(gSMSGfxBuffer_Frame2));
  return;
}

// This replaces MuCtr_OnEnd.
// Adapts different-facing SMS during free movement.
void pFMUCtr_OnEnd(Proc* proc){
  struct FMUProc* FMUproc = (FMUProc*)ProcFind(FreeMovementControlProc);
  
  MuCtr_OnEnd(proc);
  
  // Determine facing direction and update sms.
  if (FMUproc!=NULL && GetFreeMovementState())
    pFMU_UpdateSMS(FMUproc);

  return;
}

void pFMU_MoveUnit(struct FMUProc* proc){	//Label 1
	u16 iKeyCur = gKeyState.heldKeys;
	s8 x = gActiveUnit->xPos;
	s8 y = gActiveUnit->yPos;
  u8 facingCur = proc->smsFacing;
	
	//proc->xCur = x;
	//proc->xCur = y;
	//proc->xTo  = x;
	//proc->xTo  = y;
	
	if(0xF0&iKeyCur){
		if(iKeyCur&0x10) {
      x++;
      proc->smsFacing = 1;
    }
		else if(iKeyCur&0x20) {
      x--;
      proc->smsFacing = 0;
    }
		else if(iKeyCur&0x40) {
      y--;
      proc->smsFacing = 3;
    }
		else if(iKeyCur&0x80) {
      y++;
      proc->smsFacing = 2;
    }
	}
	
		
	if( !IsPosInvaild(x,y) ){
		proc->xTo = x;
		proc->yTo = y;
	}
		
	if( FMU_CanUnitBeOnPos(gActiveUnit, x, y) ){
		if( !IsPosInvaild(x,y) )
			MuCtr_StartMoveTowards(gActiveUnit, x, y, 0x10, 0x0);
	}
	else
    if (facingCur != proc->smsFacing)
      pFMU_UpdateSMS(proc);
		ProcGoto((Proc*)proc,0x2);
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
		//ProcGoto((Proc*)proc,0xE);
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



/*
void pFMU_MainLoop(struct FMUProc* proc){

	struct MUProc* muProc = MU_GetByUnit(gActiveUnit);
	
	if (muProc) { 
		if (muProc->pMUConfig->commands[muProc->pMUConfig->currentCommand] != MU_COMMAND_HALT && muProc->stateId > MU_STATE_NONACTIVE) { 
			return; // MU_COMMAND_HALT is the terminator 
		} 
	} 
	else { 
		struct MUProc* muProc = MU_Create(gActiveUnit);
		MU_DisplayAsMMS(muProc);
		HideUnitSMS(gActiveUnit);
	} 
	

	ProcGoto((Proc*)proc,0x1);
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
				MU_StartMoveScript(muProc, &mD[0]); 
				gActiveUnit->xPos = x; 
				gActiveUnit->yPos = y; 
				//MuCtr_StartMoveTowards(gActiveUnit, x, y, 0x10);
		}
	} 
	
	if (mD[0] == MU_COMMAND_HALT) { 
			ProcGoto((Proc*)proc,0x2);
	}
	return;
}

*/
