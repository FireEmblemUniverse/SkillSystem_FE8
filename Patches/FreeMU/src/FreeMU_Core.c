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

#define bufferFramesMove 3
#define bufferFramesAct 4

void pFMU_InputLoop(struct Proc* inputProc) { 
	struct FMUProc* proc = (struct FMUProc*)inputProc->parent; 
	
	
	
	
	u16 iKeyCur = gKeyState.heldKeys;
	
	//if (gKeyState.lastPressKeys && (gKeyState.timeSinceNonStartSelect <= bufferFramesMove)) { 
	//	iKeyCur = iKeyCur | gKeyState.lastPressKeys; 
	//} // use latest button press within x frames 
	
	
	/*

	else { 
		if (!(gKeyState.heldKeys)) { 
			
		} 
	} 

	if (!(gKeyState.heldKeys)) { 
		if (gKeyState.lastPressKeys && ()) { 
			iKeyCur = iKeyCur | gKeyState.lastPressKeys; 
		} // use latest button press within x frames 
	} 
	*/
	/*
	if(0xF0&iKeyCur) { 
		if (!proc->yield_move) { 
			ProcGoto((Proc*)proc,0x1); // movement input 
			return yield;
		} 
	} */ 
	u16 iKeyOld = proc->lastInput; 
	proc->lastInput = proc->curInput; 
	if (!(proc->yield)) { 
		proc->curInput = iKeyCur; 
		u16 iKeyAct = gKeyState.pressedKeys; // | gKeyState.prevKeys; 
		if (pFMU_HandleKeyMisc(proc, iKeyAct) == yield) { 
			proc->countdown = 3; 
			proc->yield = true; 
		}
		else if (!(proc->yield_move)) { 
			if (iKeyCur) { 
				pFMU_MoveUnit(proc, iKeyCur);
				proc->yield_move = true; 
			} 
		} 
	}
	
}




extern u8* FMU_SpeedRam_Link; 
void FMU_ResetMoveSpeed(struct FMUProc* proc) { 
	*FMU_SpeedRam_Link = FreeMU_MovingSpeed.speedA;
}
void FMU_InitVariables(struct FMUProc* proc) { 
	pFMU_OnInit(proc);
	CenterCameraOntoPosition((Proc*)proc,gActiveUnit->xPos,gActiveUnit->yPos);
	proc->smsFacing = 2;
	proc->moveSpeed = *FMU_SpeedRam_Link;
	proc->curInput = 0; 
	proc->lastInput = 0; 
	proc->countdown = 2; 
	proc->yield = true; 
	proc->yield_move = true; 
	
}
void FMU_OnButton_ToggleSpeed(struct FMUProc* proc) { 
	//asm("mov r11, r11"); 
	if (*FMU_SpeedRam_Link == FreeMU_MovingSpeed.speedA) {
	*FMU_SpeedRam_Link = FreeMU_MovingSpeed.speedB;
	proc->moveSpeed = FreeMU_MovingSpeed.speedB;
	} 
	else {
	*FMU_SpeedRam_Link = FreeMU_MovingSpeed.speedA;
	proc->moveSpeed = FreeMU_MovingSpeed.speedA;
	}
} 


extern const ProcInstruction* gProc_Menu; 
#define  MU_SUBPIXEL_PRECISION 4
void pFMU_MainLoop(struct FMUProc* proc){ 
	
	if (ProcFind(gProc_Menu)) {
		return; 
	}
	if (!(proc->countdown)) { 
		proc->yield = false;
	} 
	else { 
		proc->countdown--; 
	} 
	/*
	struct MUProc* muProc = MU_GetByUnit(gActiveUnit);
	if (muProc) { 
		if (!(ProcFind((const ProcInstruction*)gProc_CameraMovement))) { 
			//EnsureCameraOntoPosition((Proc*)proc,((muProc->xSubPosition)/16) >> 4, ((muProc->ySubPosition)/16) >> 4);
			int right = (muProc->facingId == MU_FACING_RIGHT); 
			int left = (muProc->facingId == MU_FACING_LEFT); 
			int up = (muProc->facingId == MU_FACING_UP);
			int down = (muProc->facingId == MU_FACING_DOWN);
			if (right) right = 1; 
			if (left) left = 1; 
			if (up) up = 1; 
			if (down) down = 1; 
			
			//VeslyCenterCameraOntoPosition((Proc*)proc,((((muProc->xSubPosition)/16) >> 4) + right - left), ((((muProc->ySubPosition)/16) >> 4) + down - up));
			
			
			
			//EnsureCameraOntoPosition((Proc*)proc,gActiveUnit->xPos, gActiveUnit->yPos);
			//VeslyCenterCameraOntoPosition((Proc*)proc, gActiveUnit->xPos, gActiveUnit->yPos);
			
			//gGameState.cameraRealPos.x = GetCameraCenteredX(muProc->xSubPosition >> MU_SUBPIXEL_PRECISION) + (muProc->xSubOffset & 0xF);
			//gGameState.cameraRealPos.y = GetCameraCenteredY(muProc->ySubPosition >> MU_SUBPIXEL_PRECISION) + (muProc->ySubOffset & 0xF);
			
			//muProc->boolAttractCamera = true; 
			//#define adjustBorder 4
			//int right = (muProc->facingId == MU_FACING_RIGHT) * adjustBorder; 
			//int left = (muProc->facingId == MU_FACING_LEFT) * adjustBorder; 
			//int up = (muProc->facingId == MU_FACING_UP) * adjustBorder; 
			//int down = (muProc->facingId == MU_FACING_DOWN) * adjustBorder; 
			//gGameState.cameraRealPos.x = GetCameraAdjustedX((muProc->xSubPosition >> MU_SUBPIXEL_PRECISION) + right - left);
			//gGameState.cameraRealPos.y = GetCameraAdjustedY((muProc->ySubPosition >> MU_SUBPIXEL_PRECISION) + down - up);
			//muProc->boolAttractCamera = false; 
			//CenterCameraOntoPosition((Proc*)proc,((muProc->xSubPosition)/16) >> 4, ((muProc->ySubPosition)/16) >> 4);
			
			//gGameState.cameraRealPos.x = GetCameraAdjustedX(15); 
			//gGameState.cameraRealPos.y = GetCameraAdjustedY(12); 
		}
	}
	*/
	/*
	struct MUProc* muProc = MU_GetByUnit(gActiveUnit);
	
	if (muProc) { 
		if (muProc->stateId >= MU_STATE_MOVEMENT) { 
		return; 
		}
	} 
	MU_EndAll();
	*/
	
	if(MU_Exists()){
		return;
	}
	proc->yield_move = false; // 8002F24 proc goto 
	
	//if(pFMU_MoveUnit(proc) == yield) {
		//return; 
	//}
	//ProcGoto((Proc*)proc,0x1);
	return;
}


int pFMU_HanleContinueMove(struct FMUProc* proc){
	proc->yield = false;
	return yield;
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

int pFMU_MoveUnit(struct FMUProc* proc, u16 iKeyCur){	//Label 1
	// do not consider input for movement if ABLR were pressed 
	//if (((gKeyState.lastPressKeys & 0x303) || (gKeyState.heldKeys & 0x303)) && (gKeyState.timeSinceNonStartSelect <= bufferFramesAct)) { // ABLR 
		//iKeyCur = 0; 
	//}
	s8 x = gActiveUnit->xPos;
	s8 y = gActiveUnit->yPos;
	u8 facingCur = proc->smsFacing;
  
  
	//u8 mD[10]; //moveDirections[10]; 
	//mD[0] = MU_COMMAND_HALT; // default to do no movement 

	iKeyCur = iKeyCur & 0xF0; 
	if(iKeyCur){
		int i; 
		
		
		//while (!((iKeyCur != KEY_DPAD_RIGHT) || (iKeyCur != KEY_DPAD_LEFT) || (iKeyCur != KEY_DPAD_DOWN) || (iKeyCur != KEY_DPAD_UP))) { 
		while (true) { 
			if ((iKeyCur == KEY_DPAD_RIGHT) || (iKeyCur == KEY_DPAD_DOWN) || (iKeyCur == KEY_DPAD_LEFT) || (iKeyCur == KEY_DPAD_UP)) 
				break; 
			asm("mov r11, r11"); 
			// choose which input at random instead of always prioritizing right > left > up > down 
			i = NextRN_N(4); 
			if (i == 0) 
				iKeyCur = iKeyCur & 0xE0;//&~ KEY_DPAD_RIGHT; 
			if (i == 1)           //
				iKeyCur = iKeyCur & 0xD0;//&~ KEY_DPAD_UP; 
			if (i == 2)           //
				iKeyCur = iKeyCur & 0xB0;//&~ KEY_DPAD_LEFT; 
			if (i == 3)           //
				iKeyCur = iKeyCur & 0x70;//&~ KEY_DPAD_DOWN; 
		} 
		
		
		if(iKeyCur&0x10) {
		x++;
		proc->smsFacing = MU_FACING_RIGHT;
		//mD[0] = MU_COMMAND_MOVE_RIGHT;
		}
		else if(iKeyCur&0x20) {
		x--;
		proc->smsFacing = MU_FACING_LEFT;
		//mD[0] = MU_COMMAND_MOVE_LEFT;
		}
		else if(iKeyCur&0x40) {
		y--;
		proc->smsFacing = MU_FACING_UP;
		//mD[0] = MU_COMMAND_MOVE_UP;
		}
		else if(iKeyCur&0x80) {
		y++;
		proc->smsFacing = MU_FACING_DOWN;
		//mD[0] = MU_COMMAND_MOVE_DOWN;
		}
	}
	 
    if (facingCur != proc->smsFacing) { 
        pFMU_UpdateSMS(proc);
	} 
	else { 
		
		if( !IsPosInvaild(x,y) ){
			proc->xTo = x;
			proc->yTo = y;
		}
			
		if( FMU_CanUnitBeOnPos(gActiveUnit, x, y) ){
			if( !IsPosInvaild(x,y) ) { 
				MuCtr_StartMoveTowards(gActiveUnit, x, y, 0x10, 0x0);
				//struct MUProc* muProc = MU_GetByUnit(gActiveUnit);
				//MU_DisableAttractCamera(muProc);
				//gGameState.cameraRealPos.x+= 16; 

				
				/*
				mD[1] = MU_COMMAND_CAMERA_ON; 
				mD[2] = MU_COMMAND_HALT;
				struct MUProc* muProc = MU_GetByUnit(gActiveUnit);
				if (!muProc) { 
					muProc = MU_Create(gActiveUnit);
				} 
				MU_SetFacing(muProc, proc->smsFacing);
				MU_DisplayAsMMS(muProc);
				HideUnitSMS(gActiveUnit);
				MU_EnableAttractCamera(muProc);
				MU_StartMoveScript(muProc, &mD[0]); 
				gActiveUnit->xPos = x; 
				gActiveUnit->yPos = y; 
				//MuCtr_StartMoveTowards(gActiveUnit, x, y, 0x10, 0x0);
				//struct MUProc* muProc = MU_GetByUnit(gActiveUnit);
				*/
				return yield; 
			} 
		}
		else {
			ProcGoto((Proc*)proc,0x2);
			return yield; 
		}
			
	} 
	return no_yield;
}




int pFMU_HandleKeyMisc(struct FMUProc* proc, u16 iKeyCur){	//Label 2
	if(1&iKeyCur){ 			//Press A
		pFMU_PressA(proc); 
		proc->yield_move = true; 
		return yield;
		}			
	if(2&iKeyCur){ 			//Press B
		pFMU_PressB(proc);
		proc->yield_move = true; 
		return yield;
		}	
	if(2&(iKeyCur>>0x8)){ 	//Press L
		pFMU_PressL(proc);
		proc->yield_move = true; 
		return yield;
		}
	if(1&(iKeyCur>>0x8)){ 	//Press R
		pFMU_PressR(proc);
		proc->yield_move = true; 
		return yield;
		}
	if(4&iKeyCur){ 			//Press Select
		pFMU_PressSelect(proc);
		proc->yield_move = true; 
		return yield;
		}
	if(8&iKeyCur){ 			//Press Start
		pFMU_PressStart(proc);
		proc->yield_move = true; 
		return yield;
		}
	return no_yield;
}

int pFMU_HandleSave(struct FMUProc* proc){	//KeyPress Default
	if( TimerDelay < ++proc->uTimer ){
		ProcGoto((Proc*)proc,0xE);
		proc->uTimer=0;
		return yield;
	}
	return no_yield;
}


void pFMU_PressA(struct FMUProc* proc){
	u16 iKeyCur = proc->curInput;
	if( 0 == (1&iKeyCur) )
		return;
	
	ButtonFunc* it = &FMU_FunctionList_OnPressA[0];
	while(*it)
		if( (*it++)(proc) )
			return;
	return;
}


void pFMU_PressB(struct FMUProc* proc){
	u16 iKeyCur = proc->curInput;
	if( 0 == (2&iKeyCur) )
		return;
	
	ButtonFunc* it = &FMU_FunctionList_OnPressB[0];
	while(*it)
		if( (*it++)(proc) )
			return;
	return;
}

void pFMU_PressL(struct FMUProc* proc){
	u16 iKeyCur = proc->curInput;
	if( 0 == (2&iKeyCur>>0x8) )
		return;
	
	ButtonFunc* it = &FMU_FunctionList_OnPressL[0];
	while(*it)
		if( (*it++)(proc) )
			return;
	return;
}

void pFMU_PressR(struct FMUProc* proc){
	u16 iKeyCur = proc->curInput;
	if( 0 == (1&iKeyCur>>0x8) )
		return;
	
	ButtonFunc* it = &FMU_FunctionList_OnPressR[0];
	while(*it)
		if( (*it++)(proc) )
			return;
	return;
}

void pFMU_PressStart(struct FMUProc* proc){
	u16 iKeyCur = proc->curInput;
	if( 0 == (8&iKeyCur) )
		return;
	
	ButtonFunc* it = &FMU_FunctionList_OnPressStart[0];
	while(*it)
		if( (*it++)(proc) )
			return;
	return;
}

void pFMU_PressSelect(struct FMUProc* proc){
	u16 iKeyCur = proc->curInput;
	if( 0 == (4&iKeyCur) ) 			//Press Select
		return;

	ButtonFunc* it = &FMU_FunctionList_OnPressSelect[0];
	while(*it)
		if( (*it++)(proc) )
			return;
	return;
}


enum {
    CAMERA_MARGIN_LEFT   = 16 * 7, //16 * 3,
    CAMERA_MARGIN_RIGHT  = 16 * 7,//16 * 11,
    CAMERA_MARGIN_TOP    = 16 * 5,//16 * 2,
    CAMERA_MARGIN_BOTTOM = 16 * 5,//16 * 7,
};

u16 NewGetCameraCenteredX(int x) {
    int result = gBmSt.camera.x;

    if (gBmSt.camera.x + CAMERA_MARGIN_LEFT > x) {
        result = x - CAMERA_MARGIN_LEFT < 0
            ? 0
            : x - CAMERA_MARGIN_LEFT;
    }

    if (gBmSt.camera.x + CAMERA_MARGIN_RIGHT < x) {
        result = x - CAMERA_MARGIN_RIGHT > gBmSt.cameraMax.x
            ? gBmSt.cameraMax.x
            : x - CAMERA_MARGIN_RIGHT;
    }

    return result;
}

u16 NewGetCameraCenteredY(int y) {
    int result = gBmSt.camera.y;

    if (gBmSt.camera.y + CAMERA_MARGIN_TOP > y) {
        result = y - CAMERA_MARGIN_TOP < 0
            ? 0
            : y - CAMERA_MARGIN_TOP;
    }

    if (gBmSt.camera.y + CAMERA_MARGIN_BOTTOM < y) {
        result = y - CAMERA_MARGIN_BOTTOM > gBmSt.cameraMax.y
            ? gBmSt.cameraMax.y
            : y - CAMERA_MARGIN_BOTTOM;
    }

    return result;
}
//[202BCBC..202BCBF]!!
s8 VeslyCenterCameraOntoPosition(struct Proc* parent, int x, int y) {
    struct CamMoveProc* proc;
	// camera is SHORT 0x0--p where -- is byte coord and p is number of pixels 

    int xTarget = NewGetCameraCenteredX(x*16);
    int yTarget = NewGetCameraCenteredY(y*16);
	

    if ((xTarget == gBmSt.camera.x) && (yTarget == gBmSt.camera.y)) {
        return 0;
    }
	
    if (ProcFind((const ProcInstruction*)&gProcScr_CamMove)) {
        return 0;
    }

    if (parent) {
        proc = (struct CamMoveProc*)ProcStartBlocking((const ProcInstruction*)&gProcScr_CamMove, parent);
    } else {
        proc = (struct CamMoveProc*)ProcStart((const ProcInstruction*)&gProcScr_CamMove, (Proc*)3);
    }
    proc->from.x = gBmSt.camera.x;
    proc->from.y = gBmSt.camera.y;

    proc->to.x = xTarget;
    proc->to.y = yTarget;

    proc->watchedCoordinate.x = x;
    proc->watchedCoordinate.y = y;

    return 1;
}

extern void PlayerPhase_Suspend(void); 
void FMU_ClearActionAndSave(struct FMUProc* proc) { 
	PlayerPhase_Suspend(); 
} 

extern const struct SMSData NewStandingMapSpriteTable[];
void pFMU_UpdateSMS(struct FMUProc* proc){
  u32 tileIndex = (proc->FMUnit->pMapSpriteHandle->oam2Base & 0x3FF) - 0x80;
  u8 smsID = proc->FMUnit->pClassData->SMSId;
  u16 size = NewStandingMapSpriteTable[smsID].size;
  u8 width =  size < 2 ? 16 : 32;
  u8 height = size > 0 ? 32 : 16;
  u32 srcOffs[3] = {0, 0, 0};
  int frame = GetGameClock() % 72;
  
  // Do nothing if no different-direction facing idle sprites exist.
  if (FMU_idleSMSGfxTable[smsID] == NULL)
    return;
  
  // Decompress sms gfx.
  if (proc->smsFacing==2)
    Decompress(NewStandingMapSpriteTable[smsID].pGraphics, gGenericBuffer);    // Downward facing sms.
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
