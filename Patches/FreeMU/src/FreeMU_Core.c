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
	//u16 iKeyOld = proc->lastInput; 
	if (!(proc->yield)) { 
		proc->curInput = iKeyCur; 
		u16 iKeyUse = gKeyState.pressedKeys; // | gKeyState.prevKeys; 
		if (pFMU_HandleKeyMisc(proc, iKeyUse) == yield) { 
			proc->countdown = 3; 
			proc->yield = true; 
		}
		else if (!(proc->yield_move)) { 
			if (iKeyCur & 0xF0) { 
				iKeyCur = FMU_FilterMovementInput(proc, iKeyCur);
				//asm("mov r11, r11"); 
				pFMU_MoveUnit(proc, iKeyCur);
				proc->yield_move = true; 
			} 
		} 
	}
	
}

u16 FMU_FilterMovementInput(struct FMUProc* proc, u16 iKeyCur) { 
	iKeyCur &= 0xF0; 
	u16 iKeyUse = (gKeyState.pressedKeys & 0xF0); // prioritize most recently pressed keys over held down keys 
	if (iKeyUse) { 
		proc->lastInput = iKeyUse; 
	}
	iKeyUse = proc->lastInput & (gKeyState.heldKeys & 0xF0);
	if (iKeyUse) { // most recently pressed key, even if multiple are held down 
		iKeyCur = iKeyUse; 
	} 
	int i; 
	while (iKeyCur) { 
		if ((iKeyCur == KEY_DPAD_RIGHT) || (iKeyCur == KEY_DPAD_DOWN) || (iKeyCur == KEY_DPAD_LEFT) || (iKeyCur == KEY_DPAD_UP)) 
			break; 
		// choose which input at random instead of always prioritizing right > left > up > down 
		i = NextRN_N(4); 
		if (i == 0) 
			iKeyCur &= ~KEY_DPAD_RIGHT; 
		if (i == 1)         
			iKeyCur &= ~KEY_DPAD_UP; 
		if (i == 2)        
			iKeyCur &= ~KEY_DPAD_LEFT; 
		if (i == 3)         
			iKeyCur &= ~KEY_DPAD_DOWN; 
	} 
	

	return iKeyCur; 

} 

void FMU_ResetMoveSpeed(void) { 
	FreeMoveRam->running = false; 
}
void FMU_ResetDirection(void) { 
	FreeMoveRam->dir = 2; // facing down 
}

void PhaseSwitchGfx_BreakIfNoUnits(struct Proc* proc) { 
	if (FreeMoveRam->silent) {
		//
		if (gChapterData.currentPhase == 0x80) { 
		gChapterData.currentPhase = 0;
		FreeMoveRam->silent = false; } 
		
		EndProc(proc);

		return; 
	}

	if (GetPhaseAbleUnitCount(gChapterData.currentPhase)) { //24CEC
		return; 
	}
	EndProc(proc);
} 


unsigned GetPhaseAbleUnitCount(unsigned faction) {
	if (FreeMoveRam->silent && (gChapterData.currentPhase & 0xC0)) { 
		return 0; 
	}
    int count = 0;
    int id;
    for (id = faction + 1; id < faction + 0x40; id++) {
        struct Unit *unit = GetUnit(id);
        if (UNIT_IS_VALID(unit)) {
            u32 state = unit->state;
            u32 notAble = (
                US_UNSELECTABLE
                | US_DEAD
                | US_NOT_DEPLOYED
                | US_RESCUED
                | US_UNDER_A_ROOF
                | US_BIT16);
            if (!(state & notAble)) {
                if (unit->statusIndex != UNIT_STATUS_SLEEP
                    && unit->statusIndex != UNIT_STATUS_BERSERK)
                {
                    if (!(UNIT_CATTRIBUTES(unit) & CA_UNSELECTABLE)) {
                        count += 1;
                    }
                }
            }
        }
    }
    return count;
}


void FMU_InitVariables(struct FMUProc* proc) { 
	pFMU_OnInit(proc);
	CenterCameraOntoPosition((Proc*)proc,gActiveUnit->xPos,gActiveUnit->yPos);
	proc->xCur = gActiveUnit->xPos;
	proc->yCur = gActiveUnit->yPos;
	proc->xTo  = gActiveUnit->xPos;
	proc->yTo  = gActiveUnit->yPos;
	proc->usedLedge = false; 
	proc->end_after_movement = false; 
	
	
	if (FreeMoveRam->running) 
		proc->moveSpeed = FreeMU_MovingSpeed.speedB;
	else 
		proc->moveSpeed = FreeMU_MovingSpeed.speedA;
	
	proc->smsFacing = FreeMoveRam->dir;
	proc->scriptedMovement = false; 
	proc->curInput = 0; 
	proc->lastInput = 0; 
	proc->countdown = 2; 
	proc->yield = true; 
	proc->yield_move = true; 
	proc->range_event = false; 
	
}
void FMU_OnButton_ToggleSpeed(struct FMUProc* proc) { 
	//asm("mov r11, r11"); 
	if (FreeMoveRam->running == false) {
	FreeMoveRam->running = true; // 
	proc->moveSpeed = FreeMU_MovingSpeed.speedB;
	} 
	else {
	FreeMoveRam->running = false;
	proc->moveSpeed = FreeMU_MovingSpeed.speedA;
	}
} 

extern u8 MapEventEngineExists(void); 

#define  MU_SUBPIXEL_PRECISION 4
int FMU_HandleContinuedMovement(void) { 
	struct FMUProc* proc = (struct FMUProc*)ProcFind(FreeMovementControlProc);
	struct MUProc* muProc = MU_GetByUnit(gActiveUnit);
	struct MuCtr* ctrProc = (struct MuCtr*)ProcFind(&gUnknown_089A2DB0); 
	//ProcFind(&gProc_Menu) || 
	if ((!proc) || (!muProc) || (!ctrProc)) {
		return (-1); }
	if (muProc->pMUConfig->currentCommand == 1) {
		return (-1); } 
	u8 dir = FMU_ChkKeyForMUExtra(proc);
	if (dir == 0x10) { 
		return (-1); } 
	proc->smsFacing = dir; 
	int x = ctrProc->xPos; 
	int y = ctrProc->yPos; 
	if (dir == MU_FACING_RIGHT)
	x++; 
	if (dir == MU_FACING_LEFT)
	x--; 
	if (dir == MU_FACING_DOWN)
	y++; 
	if (dir == MU_FACING_UP)
	y--; 
	if (gMapFog[y][x]) {
		proc->end_after_movement = true; 
	}

	FMU_CheckForLedge(proc, x, y); // enables scripted movement 
	if (!FMU_CanUnitBeOnPos(gActiveUnit, x, y)) { 
		return (-1); } 
	muProc->pMUConfig->currentCommand = 1; 
	muProc->pMUConfig->commands[0] = dir;
	ctrProc->xPos = x; 
	ctrProc->yPos = y; 
	ctrProc->xPos2 = x; 
	ctrProc->yPos2 = y; 
	
	proc->xTo = x; 
	proc->yTo = y; 
	if (!pFMU_RunLocBasedAsmcAuto(proc)) { 
		proc->yield = true; 
		proc->yield_move = true; 
		proc->countdown = 2; 
		proc->range_event = true; 
	}  
	return dir; 
} 
//202f55a

void pFMU_MainLoop(struct FMUProc* proc){ 
	
	if (ProcFind(&gProc_Menu)) {
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
		if (muProc->stateId >= MU_STATE_MOVEMENT) { 
		return; 
		}
	} 
	MU_EndAll();
	*/
	//asm("mov r11, r11"); // gActiveUnit
	
	//if (MapEventEngineExists()) { // wait for events 
	//	return; 
	//}
	if (proc->range_event) { 
		proc->range_event = false; 
	} 
	
	if(MU_Exists()){
		return;
	}
	
	if (proc->yield_move) { 
		//asm("mov r11, r11"); 
		proc->yield_move = false; // 8002F24 proc goto 
	} 

	//asm("mov r11, r11"); 
	if (proc->usedLedge) { 
		gMapTerrain[proc->ledgeY][proc->ledgeX] = LEDGE_JUMP; 
		proc->usedLedge = false; 
	}
	//if (proc->xTo != 0xFF) { //[2024ed4+0x2d]!! 
	

	if ((proc->xTo == proc->xCur) && (proc->yTo == proc->yCur)) { 
		//asm("mov r8, r8"); 
	}
	else {
		if (pFMU_RunLocBasedAsmcAuto(proc) == yield) { 
			proc->countdown = 1; 
			proc->yield_move = true; 
			proc->yield = true; 
			//return; 
		} 
	} 
	if (proc->end_after_movement) { // after any scripted movement is done 
		FMU_EndFreeMoveSilent(); 
	}
	
	

	//}


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
  
  MuCtr_OnEnd(proc); // 0x807a270 
  
  // Determine facing direction and update sms.
  if (FMUproc!=NULL && GetFreeMovementState())
    pFMU_UpdateSMS(FMUproc);

  return;
}

int pFMU_MoveUnit(struct FMUProc* proc, u16 iKeyCur){	//Label 1
	s8 x = gActiveUnit->xPos;
	s8 y = gActiveUnit->yPos;
	u8 facingCur = proc->smsFacing;

	iKeyCur = iKeyCur & 0xF0; 
	if(iKeyCur){

		
		
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
		FreeMoveRam->dir = proc->smsFacing; 
	} 
	else { 
		if (gMapFog[y][x]) {
			proc->end_after_movement = true; 
		}
		if ((gMapTerrain[y][x] == LEDGE_JUMP) && (proc->smsFacing == MU_FACING_DOWN)) { 
			//x += (facingCur == MU_FACING_RIGHT); 
			//x -= (facingCur == MU_FACING_LEFT); 
			y += (facingCur == MU_FACING_DOWN); 
			//y -= (facingCur == MU_FACING_UP); 
			if( FMU_CanUnitBeOnPos(gActiveUnit, x, y) ){
				if( !IsPosInvaild(x,y) ) { 
				
					/*
					u8 mD[8]; //moveDirections[8];
					mD[0] = MU_COMMAND_MOVE_DOWN;
					mD[1] = MU_COMMAND_CAMERA_ON;
					mD[2] = MU_COMMAND_MOVE_DOWN;
					mD[3] = MU_COMMAND_CAMERA_ON;
					mD[4] = MU_COMMAND_END; // MuCtr_StartMoveTowards ends with HALT 
					mD[5] = MU_COMMAND_END;
					struct MUProc* muProc = MU_GetByUnit(gActiveUnit);
					if (!muProc) { 
						muProc = MU_Create(gActiveUnit);
					} 
					MU_SetFacing(muProc, proc->smsFacing);
					MU_DisplayAsMMS(muProc);
					HideUnitSMS(gActiveUnit);
					//MU_StartActionAnim(struct MUProc* moveunit);
					MU_StartMoveScript(muProc, &mD[0]); 
					gActiveUnit->xPos = x; 
					gActiveUnit->yPos = y; 
					// this version kinda works but does not call MU_CALL2_FixForFreeMU when it ends for whatever reason 
					*/ 
					//proc->yield_move = true; 
					//proc->yield = true; 
					//proc->countdown = 10; 
					proc->scriptedMovement = true; 
					proc->usedLedge = true; 
					gMapTerrain[y-1][x] = 1; 
					proc->ledgeX = x; 
					proc->ledgeY = y-1; 
					MuCtr_StartMoveTowards(gActiveUnit, x, y, 0x10, 0x0);
					
					proc->xTo  = x;
					proc->yTo  = y;
					return yield; 
				}
			}
			return no_yield; 
		} 
			
		if( FMU_CanUnitBeOnPos(gActiveUnit, x, y) ){
			if( !IsPosInvaild(x,y) ) { 
				
				//asm("mov r11, r11"); 
				MuCtr_StartMoveTowards(gActiveUnit, x, y, 0x10, 0x0);
				proc->xTo  = x;
				proc->yTo  = y;
				return yield; 
			} 
		}
		else {
			//ProcGoto((Proc*)proc,0x2);
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
