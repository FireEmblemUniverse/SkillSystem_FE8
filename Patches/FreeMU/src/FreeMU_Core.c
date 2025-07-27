#include "FreeMU.h"

extern int ProtagID_Link;

// used in WarningAndHpBars.s so talk bubble shows up during FMU
/*
ldrb	r0,[r6,#0xC]			@status byte
mov		r1,#1					@do not display standing
map sprite tst		r0,r1 bne		CheckIfFirstPass bl
HpBarIsFMUActive cmp r0, #0 bne CheckIfFirstPass
*/

// 859AE38 SendItemConvoy proc
int HpBarIsFMUActive(void) {
  if (!GetFreeMovementState())
    return false;
  struct FMUProc *FMUproc = (FMUProc *)ProcFind(FreeMovementControlProc);
  if (FMUproc) {
    return true;

    // struct MUProc* muProc = MU_GetByUnit(gActiveUnit);
    // if (muProc) return;
  }
  return false;
}

static inline bool IsPosInvaild(s8 x, s8 y) {
  return ((x < 0) || (x > gMapSize.x) || (y < 0) || (y > gMapSize.y));
}

static inline bool IsCharNotOnMap(Unit *unit) {
  if (-1 == unit->xPos)
    return 1;
  return 0;
}

static inline bool IsCharInvaild(Unit *unit) {
  if (0 == unit)
    return 1;
  if (0 == unit->pCharacterData)
    return 1;
  return 0;
}

#define bufferFramesMove 3
#define bufferFramesAct 4

void pFMU_InputLoop(struct Proc *inputProc) {
  // struct FMUProc* proc = (struct FMUProc*)inputProc->parent;

  // u16 iKeyCur = gKeyState.heldKeys;

  // if (gKeyState.lastPressKeys && (gKeyState.timeSinceNonStartSelect <=
  // bufferFramesMove)) { 	iKeyCur = iKeyCur | gKeyState.lastPressKeys; }
  // // use latest button press within x frames

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
  // u16 iKeyOld = proc->lastInput;
}

int IsFMUPaused(void) { return FreeMoveRam->pause; }

#define RealEventMinimumFrames                                                 \
  3 // we don't wait for events that have lasted 1-6 frames
void pFMU_MainLoop(struct FMUProc *proc) {
  int exit_early = false;
  if (ProcFind(&gProc_Menu) || ProcFind(&gProc_Config1) ||
      ProcFind(&gProc_ChapterStatusScreen) || ProcFind(&gProc_Shop) ||
      ProcFind(&gProc_TargetSelection) || ProcFind(&gProc_TradeMenu)) {
    exit_early = true;
  }
  if (ProcFind(&gProc_Supply)) {
    MU_EndAll();
    exit_early = true;
  }
  struct EventEngineProc *eventProc =
      (struct EventEngineProc *)ProcFind(&gProc_MapEventEngine);
  if (eventProc && FreeMoveRam->pause) {
    exit_early = true;
  }

  // if (ProcFind(&gProc_StatScreen)) {

  if (exit_early) {
    proc->yield = true;
    proc->countdown = 1;
  }

  if (eventProc) {
    if (eventProc->evStallTimer || eventProc->pUnitLoadData ||
        eventProc->activeTextType) {
      proc->yield = true;
      exit_early = true;
    }
  }

  if (eventProc) { // wait for events that exist for 3+ frames
    if (eventProc->pEventIdk ==
        proc->pEventIdk) { // if the same event as last time, increment time
                           // this event has existed
      if (proc->eventEngineTimer < 255) {
        proc->eventEngineTimer++;
      }
    } else {
      proc->pEventIdk = eventProc->pEventIdk;
      proc->eventEngineTimer = 0;
    }
  } else {
    proc->eventEngineTimer = 0;
  }

  // maybe accept B inputs during range events? for toggling speed

  if (exit_early) {
    return;
  }
  if (proc->eventEngineTimer >= RealEventMinimumFrames) {
    // struct MUProc* muProc = MU_GetByUnit(gActiveUnit);
    // if (muProc) {
    // MU_DisableAttractCamera(muProc); }
    proc->updateCameraAfterEvent = true;
    return;
  }
  if (FreeMoveRam->pause) {
    FreeMoveRam->pause = false;
    pFMU_OnInit(proc); // setup active unit
  }
  if (proc->updateCameraAfterEvent) {
    // struct MUProc* muProc = MU_GetByUnit(gActiveUnit);
    // if (muProc) {
    // MU_EnableAttractCamera(muProc); }
    CenterCameraOntoPosition((Proc *)proc, gActiveUnit->xPos,
                             gActiveUnit->yPos);
    proc->updateCameraAfterEvent = false;
    return;
  }
  if (proc->updateDangerZone) {
    proc->updateDangerZone = false;
    FMU_EnableDR();
    return;
  }

  if (proc->updateAfterStatusScreen && (proc->countdown == 0)) {

    // see
    // https://github.com/FireEmblemUniverse/fireemblem8u/blob/f27fe5c06962b4de940b7830564d70ff1e193e9c/src/statscreen.c#L430
    extern ProcInstruction *gProcScr_SSGlowyBlendCtrl;
    EndEachProc(gProcScr_SSGlowyBlendCtrl);
    UnlockGameGraphicsLogic();
    EndGreenTextColorManager();

    // StartFadeOutBlackMedium();
    // RenderBmMap();
    extern void ReloadGameCoreGraphics(void);
    ReloadGameCoreGraphics();
    gLCDIOBuffer.dispControl.enableBg0 = true;
    gLCDIOBuffer.dispControl.enableBg1 = true;
    gLCDIOBuffer.dispControl.enableBg2 = true;
    gLCDIOBuffer.dispControl.enableBg3 = true;
    gLCDIOBuffer.dispControl.enableObj = true;
    FMU_ResetLCDIO();

    proc->updateAfterStatusScreen = false;
  }

  if (!(proc->countdown)) {
    proc->yield = false;
  } else {
    proc->countdown--;
  }

  if (proc->usedIce) {
    // if (!MU_Exists()) { asm("mov r11, r11"); }
    return;
  }

  if (gKeyState.pressedKeys) {
    proc->curInput = gKeyState.pressedKeys; // for directional movement
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

  if (proc->range_event) {
    EndAllMenus();
    proc->range_event = false;
  }

  u16 iKeyUse = gKeyState.pressedKeys; // | gKeyState.prevKeys;
  if (!proc->yield) {
    if (pFMU_HandleKeyMisc(proc, iKeyUse) == yield) {
      proc->countdown = 3;
      proc->yield = true;
      proc->startTime = GetGameClock();
      return;
    }
  }

  if (MU_Exists()) {
    return;
  }
  if (proc->updateSMS) { // when units go through each other, this is needed
                         // afterwards
    RefreshUnitsOnBmMap();
    SMS_UpdateFromGameData();
    proc->updateSMS = false;
  }

  if (proc->yield_move && !(proc->countdown)) {
    proc->yield_move = false; // 8002F24 proc goto
  }

  if (proc->usedLedge) {
    gMapTerrain[proc->ledgeY][proc->ledgeX] = LEDGE_JUMP;
    proc->usedLedge = false;
  }
  // if (proc->xTo != 0xFF) { //[2024ed4+0x2d]!!

  if ((proc->xTo == proc->xCur) && (proc->yTo == proc->yCur)) {
    // asm("mov r8, r8");
  } else {
    // if (pFMU_RunLocBasedAsmcAutoAndUpdateCoord(proc) == yield) {
    // proc->countdown = 1;
    // proc->yield_move = true;
    // proc->yield = true;
    // return;
    // }
  }

  u16 iKeyCur = gKeyState.heldKeys;
  if (!proc->countdown) {
    if (!(proc->yield)) {
      if (!(proc->yield_move)) {
        if (iKeyCur & 0xF0) {
          iKeyCur = FMU_FilterMovementInput(proc, iKeyCur);
          int facing = proc->smsFacing;
          pFMU_MoveUnit(proc, iKeyCur);

          if (proc->smsFacing == facing) { // if we are turning directions,
                                           // don't run events again
            if (pFMU_RunLocBasedAsmcAuto(proc) == yield) {
              struct EventEngineProc *eventProc =
                  (struct EventEngineProc *)ProcFind(&gProc_MapEventEngine);
              if (eventProc) {
                proc->yield = true;
                proc->countdown = 3;
                if (FreeMoveRam->pause || FreeMoveRam->silent ||
                    eventProc->evStallTimer || eventProc->pUnitLoadData ||
                    eventProc->activeTextType) {
                  proc->countdown = 2;
                  proc->range_event = true;
                }
              }
            }
          }
          proc->yield_move = true;
        }
      }
    }
  }
  if (!(iKeyCur & 0xF0)) {
    // if (!(gKeyState.prevKeys & 0xF0)) {
    proc->startTime = GetGameClock(); // no keys held down this frame or
                                      // previous frame, so reset speed
                                      //}
  }

  if (proc->end_after_movement) { // after any scripted movement is done
    FMU_EndFreeMoveSilent();
    return;
  }
  //}

  // if(pFMU_MoveUnit(proc) == yield) {
  // return;
  //}

  // ProcGoto((Proc*)proc,0x1);
  return;
}

u16 FMU_FilterMovementInput(struct FMUProc *proc, u16 iKeyCur) {
  iKeyCur &= 0xF0;
  u16 iKeyUse =
      (gKeyState.pressedKeys &
       0xF0); // prioritize most recently pressed keys over held down keys
  if (iKeyUse) {
    proc->lastInput = iKeyUse;
  }
  iKeyUse = proc->lastInput & (gKeyState.heldKeys & 0xF0);
  if (iKeyUse) { // most recently pressed key, even if multiple are held down
    iKeyCur = iKeyUse;
  }

  /*
  int i;


  while (iKeyCur) {
          if ((iKeyCur == KEY_DPAD_RIGHT) || (iKeyCur == KEY_DPAD_DOWN) ||
  (iKeyCur == KEY_DPAD_LEFT) || (iKeyCur == KEY_DPAD_UP)) break;
          // choose which input at random instead of always prioritizing right >
  left > up > down i = NextRN_N(4); if (i == 0) iKeyCur &= ~KEY_DPAD_RIGHT; if
  (i == 1) iKeyCur &= ~KEY_DPAD_UP; if (i == 2) iKeyCur &= ~KEY_DPAD_LEFT; if (i
  == 3) iKeyCur &= ~KEY_DPAD_DOWN;
  }
  */

  return iKeyCur;
}

void FMU_ResetMoveSpeed(void) { FreeMoveRam->running = false; }
void FMU_ResetDirection(void) {
  FreeMoveRam->dir = 2; // facing down
}

u16 CountAvailableBlueUnits(
    void) { // so we game over with only our Protag alive
  int i;

  u16 result = 0;

  for (i = 1; i < 0x40; ++i) {
    struct Unit *unit = GetUnit(i);

    if (!UNIT_IS_VALID(unit))
      continue;

    if (unit->state & US_UNAVAILABLE)
      continue;

    if (unit->pCharacterData->number == ProtagID_Link)
      continue;

    ++result;
  }

  return result;
}

void PhaseSwitchGfx_BreakIfNoUnits(struct Proc *proc) {
  if (FreeMoveRam->silent) {
    EndProc(proc);
    //
    // if (gChapterData.currentPhase == 0x80) {
    // gChapterData.currentPhase = 0;
    // FreeMoveRam->silent = false; }
    //
    // EndProc(proc);

    return;
  }

  if (GetPhaseAbleUnitCount(gChapterData.currentPhase)) { // 24CEC
    return;
  }
  EndProc(proc);
}

void ProcFun_ResetCursorPosition(Proc *proc) {
  int x, y;

  x = -1;
  y = -1;

  if (FreeMoveRam->silent) {
    EndProc(proc);
    FreeMoveRam->silent = false;
    return;
  }

  if (0 == GetPhaseAbleUnitCount(gChapterData.currentPhase)) {
    EndProc(proc);
    return;
  }

  switch (gChapterData.currentPhase) {
  case FACTION_BLUE:
    GetPlayerStartCursorPosition(&x, &y);
    break;

  case FACTION_GREEN:
  case FACTION_RED:
#ifdef POKEMBLEM_VERSION
    return;
#endif
    GetEnemyStartCursorPosition(&x, &y);
    break;

  default:
    break;
  }

  if ((x >= 0) && (y >= 0)) {
    EnsureCameraOntoPosition(proc, x, y);
    SetCursorMapPosition(x, y);
  }
}

/*
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
*/

void UpdateDestCoord(struct FMUProc *proc, int x, int y) {
  gActionData.xMove = x;
  gActionData.yMove = y;
  proc->xTo = x;
  proc->yTo = y;
}

void FMU_InitVariables(struct FMUProc *proc) {
  pFMU_OnInit(proc);
  FMU_ResetLCDIO();
  MU_EndAll();
  proc->startTime = GetGameClock();
  // UnpackChapterMapGraphics(gChapterData.chapterIndex);
  // InitBaseTilesBmMap();
  // RenderBmMap();
  // ShowUnitSMS(gActiveUnit);
  // gActiveUnit->state &= ~1;
  // SMS_UpdateFromGameData();
  for (int i = 1; i < 0x40; i++) { // refresh all players when starting FMU
    struct Unit *unit = GetUnit(i);
    if (unit) {
      unit->state &= ~(US_UNSELECTABLE | US_CANTOING);
    }
  }

  CenterCameraOntoPosition((Proc *)proc, gActiveUnit->xPos, gActiveUnit->yPos);
  proc->updateSMS = false;
  proc->xCur = gActiveUnit->xPos;
  proc->yCur = gActiveUnit->yPos;
  UpdateDestCoord(proc, gActiveUnit->xPos, gActiveUnit->yPos);
  proc->usedLedge = false;
  proc->usedIce = false;
  proc->end_after_movement = false;
  proc->eventEngineTimer = 0;
  proc->pEventIdk = NULL;
  proc->updateCameraAfterEvent = false;
  proc->updateAfterStatusScreen = false;
  proc->updateDangerZone = false;
  // FreeMoveRam->silent = false;

  if (FreeMoveRam->running) {
    proc->moveSpeed = FreeMU_MovingSpeed.speedB;
  } else {
    proc->moveSpeed = FreeMU_MovingSpeed.speedA;
  }

  proc->commandID = (-1);
  proc->curInput = 0;
  proc->lastInput = 0;
  proc->countdown = 2;
  proc->yield = true;
  proc->yield_move = true;
  proc->range_event = false;

  // proc->smsFacing = GetUnitFacing(gActiveUnit); //FreeMoveRam->dir;
  proc->smsFacing = FreeMoveRam->dir;
  SetUnitFacing(gActiveUnit, proc->smsFacing);
  UpdateSMSDir(gActiveUnit, gActiveUnit->pClassData->SMSId, proc->smsFacing);
}
void FMU_OnButton_ToggleSpeed(struct FMUProc *proc) {
  if (FreeMoveRam->running == false) {
    FreeMoveRam->running = true; //
    proc->moveSpeed = FreeMU_MovingSpeed.speedB;
  } else {
    FreeMoveRam->running = false;
    proc->moveSpeed = FreeMU_MovingSpeed.speedA;
  }
}

int FMU_ShouldWeYieldForEvent(struct FMUProc *proc) {

  if (!proc)
    return true;

  if (proc->yield)
    return true;

  if (proc->eventEngineTimer >= RealEventMinimumFrames)
    return true;

  if (FreeMoveRam->pause) {
    struct EventEngineProc *eventProc =
        (struct EventEngineProc *)ProcFind(&gProc_MapEventEngine);
    if (eventProc) {
      return true;
    }
  }
  return false;
}

// [2024cc4]! [2024ccA]! 800135C [2024cc4..2024cd4]?
// 0x80152F4 OnGameLoopMain
#define MU_SUBPIXEL_PRECISION 4
int FMU_HandleContinuedMovement(void) {
  struct FMUProc *proc = (struct FMUProc *)ProcFind(FreeMovementControlProc);

  if (FMU_ShouldWeYieldForEvent(proc)) {
    return (-1);
  }

  struct MUProc *muProc = (struct MUProc *)ProcFind(&gProc_MoveUnit[0]);
  struct MuCtr *ctrProc = (struct MuCtr *)ProcFind(&gUnknown_089A2DB0);

  u16 iKeyUse = gKeyState.pressedKeys; // | gKeyState.prevKeys;
  iKeyUse |= proc->curInput;
  proc->curInput = 0;
  if (pFMU_HandleKeyMisc(proc, iKeyUse) == yield) {
    proc->countdown = 3;
    proc->yield = true;
  }

  if ((!muProc) || (!ctrProc)) {
    return (-1);
  }
  if (muProc->pMUConfig->currentCommand == 1) {
    return (-1);
  }

  if (proc->countdown) {
    return (-1);
  }

  if (gKeyState.pressedKeys &
      0xF0) { // if pressed a key this frame, prioritize it
    iKeyUse = gKeyState.pressedKeys;
  }
  if (!gKeyState.pressedKeys && !gKeyState.heldKeys) {
    iKeyUse = 0;
  }
  if ((iKeyUse & 0xF0) == 0) {
    // if we didn't press a key recently, use whatever is held down
    iKeyUse |=
        gKeyState
            .heldKeys; // we want to move the direction of a key being held down
    // or a key that was pressed since we last started moving
  }
  u8 dir = FMU_ChkKeyForMUExtra(proc, iKeyUse);

  if (dir == 0x10) { // stopping

    return (-1);
  }
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

  if (dir != proc->smsFacing) {
    proc->smsFacing = dir;
    FreeMoveRam->dir = proc->smsFacing;
    SetUnitFacing(gActiveUnit, dir);
    return (-1);
  }

  FMU_CheckForIce(proc, x, y);   // enables scripted movement
  FMU_CheckForLedge(proc, x, y); // enables scripted movement

  // if (gMapPUnit(x, y)) { // a unit is occupying this position
  //	proc->commandID = 0;
  //	proc->command[0] = proc->smsFacing;
  //	proc->command[1] = 0xFF;
  // }

  if (!FMU_CanUnitBeOnPos(gActiveUnit, x, y)) {
    return (-1);
  }

  if (gMapFog[y][x]) {               // after checking that we can go here
    proc->end_after_movement = true; // was causing a crash
                                     // proc->yield = true; // comment for crash
    // proc->countdown = 2; // comment for crash
  }

  muProc->pMUConfig->currentCommand = 1; // 03001900
  muProc->pMUConfig->commands[0] = dir;

  struct CamMoveProc *camProc = (struct CamMoveProc *)ProcFind(
      (const ProcInstruction *)&gProcScr_CamMove);
  if (camProc) { // idk
    // camProc->distance++;
  }

  ctrProc->xPos = x;
  ctrProc->yPos = y;
  ctrProc->xPos2 = x;
  ctrProc->yPos2 = y;
  UpdateDestCoord(proc, x, y);
  if (!pFMU_RunLocBasedAsmcAutoAndUpdateCoord(proc)) {
    struct EventEngineProc *eventProc =
        (struct EventEngineProc *)ProcFind(&gProc_MapEventEngine);
    if (eventProc) {
      if (eventProc->evStallTimer || eventProc->pUnitLoadData ||
          eventProc->activeTextType) {
        proc->yield = true;
        proc->yield_move = true;
        proc->countdown = 2;
        proc->range_event = true;
      }
    }
  }
  return dir;
}
// 202f55a

extern void MU_SetDefaultFacing_Auto(void);

void EndSupply_StartMMS(void) { // replaces a vanilla function
  if (gActiveUnit) {
    if (!FreeMoveRam->state) { // added
      HideUnitSMS(gActiveUnit);
      MU_Create(gActiveUnit);
      MU_SetDefaultFacing_Auto();
    }
  }
};

int pFMU_HanleContinueMove(struct FMUProc *proc) {
  proc->yield = false;
  return yield;
}

// This replaces MuCtr_OnEnd.
// Adapts different-facing SMS during free movement.
void pFMUCtr_OnEnd(Proc *proc) {
  struct FMUProc *FMUproc = (FMUProc *)ProcFind(FreeMovementControlProc);

  MuCtr_OnEnd(proc); // 0x807a270

  // Determine facing direction and update sms.
  if (FMUproc != NULL && GetFreeMovementState()) {
    gActiveUnit->state &= ~US_HIDDEN;
    pFMU_UpdateSMS(FMUproc);
  }

  return;
}
int gMapPUnit(int x, int y) {
  int deploymentID = gMapUnit[y][x];
  return ((deploymentID > 0) && (deploymentID < 0x40));
}

int pFMU_MoveUnit(struct FMUProc *proc, u16 iKeyCur) { // Label 1
  s8 x = gActiveUnit->xPos;
  s8 y = gActiveUnit->yPos;
  u8 facingCur = proc->smsFacing;

  iKeyCur = iKeyCur & 0xF0;
  if (iKeyCur) {

    if (iKeyCur & 0x10) {
      x++;
      proc->smsFacing = MU_FACING_RIGHT;
      // mD[0] = MU_COMMAND_MOVE_RIGHT;
    } else if (iKeyCur & 0x20) {
      x--;
      proc->smsFacing = MU_FACING_LEFT;
      // mD[0] = MU_COMMAND_MOVE_LEFT;
    } else if (iKeyCur & 0x40) {
      y--;
      proc->smsFacing = MU_FACING_UP;
      // mD[0] = MU_COMMAND_MOVE_UP;
    } else if (iKeyCur & 0x80) {
      y++;
      proc->smsFacing = MU_FACING_DOWN;
      // mD[0] = MU_COMMAND_MOVE_DOWN;
    }
  }

  if (facingCur != proc->smsFacing) {
    pFMU_UpdateSMS(proc);
    FreeMoveRam->dir = proc->smsFacing;
    SetUnitFacing(gActiveUnit, proc->smsFacing);
    proc->curInput = 0;  // so we don't immediately walk the next frame ?
    proc->countdown = 8; // STAL for 8 frames while we turn directions
  } else {
    if (FMU_CheckForIce(proc, x, y)) {
      return yield;
    }
    if ((gMapTerrain[y][x] == LEDGE_JUMP) &&
        (proc->smsFacing == MU_FACING_DOWN)) {
      // x += (facingCur == MU_FACING_RIGHT);
      // x -= (facingCur == MU_FACING_LEFT);
      y += (facingCur == MU_FACING_DOWN);
      // y -= (facingCur == MU_FACING_UP);

      if (!gMapUnit[y][x]) { // a unit is occupying under the cliff
        if (FMU_CanUnitBeOnPos(gActiveUnit, x, y)) {
          if (!IsPosInvaild(x, y)) {
            if (gMapFog[y][x]) {
              proc->end_after_movement = true;
            }
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
            // this version kinda works but does not call MU_CALL2_FixForFreeMU
            when it ends for whatever reason
            */
            // proc->yield_move = true;
            // proc->yield = true;
            // proc->countdown = 10;
            proc->commandID = 0;
            proc->command[0] = MU_COMMAND_MOVE_DOWN;
            proc->command[1] = 0xFF;

            proc->usedLedge = true;
            gMapTerrain[y - 1][x] = 1;
            proc->ledgeX = x;
            proc->ledgeY = y - 1;
            MuCtr_StartMoveTowards(gActiveUnit, x, y, 0x10, 0x0);
            struct MUProc *muProc = MU_GetByUnit(gActiveUnit);
            MU_EnableAttractCamera(muProc);
            UpdateDestCoord(proc, x, y);
            return yield;
          }
        }
      }
      return no_yield;
    }

    // if (gMapPUnit(x, y)) { // a unit is occupying this position
    //	proc->commandID = 0;
    //	proc->command[0] = proc->smsFacing;
    //	proc->command[1] = 0xFF;
    // }

    if (FMU_CanUnitBeOnPos(gActiveUnit, x, y)) {
      if (!IsPosInvaild(x, y)) {
        if (gMapFog[y][x]) {
          proc->end_after_movement = true;
        }
        MuCtr_StartMoveTowards(gActiveUnit, x, y, 0x10, 0x0);
        struct MUProc *muProc = MU_GetByUnit(gActiveUnit);
        MU_EnableAttractCamera(muProc);
        UpdateDestCoord(proc, x, y);
        return yield;
      }
    } else {
      // ProcGoto((Proc*)proc,0x2);
      return yield;
    }
  }
  return no_yield;
}

int pFMU_HandleKeyMisc(struct FMUProc *proc, u16 iKeyCur) { // Label 2
  int result = no_yield;
  if (proc->usedIce || proc->usedLedge) {
    return result;
  }

  if (1 & iKeyCur) { // Press A
    pFMU_PressA(proc);
    proc->yield_move = true;
    result = yield;
  } else if (2 & iKeyCur) { // Press B
    pFMU_PressB(proc);
    proc->yield_move = true;
    result = yield;
  } else if (2 & (iKeyCur >> 0x8)) { // Press L
    pFMU_PressL(proc);
    proc->yield_move = true;
    result = yield;
  } else if (1 & (iKeyCur >> 0x8)) { // Press R
    pFMU_PressR(proc);
    proc->yield_move = true;
    result = yield;
  } else if (4 & iKeyCur) { // Press Select
    pFMU_PressSelect(proc);
    proc->yield_move = true;
    result = yield;
  } else if (8 & iKeyCur) { // Press Start
    pFMU_PressStart(proc);
    proc->yield_move = true;
    result = yield;
  }
  if (result) {
    gLCDIOBuffer.dispControl.enableWin0 = 0;
    gLCDIOBuffer.dispControl.enableWin1 = 0;
    gLCDIOBuffer.dispControl.enableObjWin = 0;
    gLCDIOBuffer.blendControl.effect = 0;
  }
  return result;
}

int pFMU_HandleSave(struct FMUProc *proc) { // KeyPress Default
  if (TimerDelay < ++proc->uTimer) {
    ProcGoto((Proc *)proc, 0xE);
    proc->uTimer = 0;
    return yield;
  }
  return no_yield;
}

void pFMU_PressA(struct FMUProc *proc) {
  u16 iKeyCur = proc->curInput;
  if (0 == (1 & iKeyCur))
    return;

  ButtonFunc *it = &FMU_FunctionList_OnPressA[0];
  while (*it)
    if ((*it++)(proc))
      return;
  return;
}

void pFMU_PressB(struct FMUProc *proc) {
  u16 iKeyCur = proc->curInput;
  if (0 == (2 & iKeyCur))
    return;

  ButtonFunc *it = &FMU_FunctionList_OnPressB[0];
  while (*it)
    if ((*it++)(proc))
      return;
  return;
}

void pFMU_PressL(struct FMUProc *proc) {
  u16 iKeyCur = proc->curInput;
  if (0 == (2 & iKeyCur >> 0x8))
    return;

  ButtonFunc *it = &FMU_FunctionList_OnPressL[0];
  while (*it)
    if ((*it++)(proc))
      return;
  return;
}

void pFMU_PressR(struct FMUProc *proc) {
  u16 iKeyCur = proc->curInput;
  if (0 == (1 & iKeyCur >> 0x8))
    return;

  ButtonFunc *it = &FMU_FunctionList_OnPressR[0];
  while (*it)
    if ((*it++)(proc))
      return;
  return;
}

void pFMU_PressStart(struct FMUProc *proc) {
  u16 iKeyCur = proc->curInput;
  if (0 == (8 & iKeyCur))
    return;

  ButtonFunc *it = &FMU_FunctionList_OnPressStart[0];
  while (*it)
    if ((*it++)(proc))
      return;
  return;
}

void pFMU_PressSelect(struct FMUProc *proc) {
  u16 iKeyCur = proc->curInput;
  if (0 == (4 & iKeyCur)) // Press Select
    return;

  ButtonFunc *it = &FMU_FunctionList_OnPressSelect[0];
  while (*it)
    if ((*it++)(proc))
      return;
  return;
}

enum {
  CAMERA_MARGIN_LEFT = 16 * 7,   // 16 * 3,
  CAMERA_MARGIN_RIGHT = 16 * 7,  // 16 * 11,
  CAMERA_MARGIN_TOP = 16 * 5,    // 16 * 2,
  CAMERA_MARGIN_BOTTOM = 16 * 5, // 16 * 7,
};

u16 NewGetCameraCenteredX(int x) {
  int result = gBmSt.camera.x;

  if (gBmSt.camera.x + CAMERA_MARGIN_LEFT > x) {
    result = x - CAMERA_MARGIN_LEFT < 0 ? 0 : x - CAMERA_MARGIN_LEFT;
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
    result = y - CAMERA_MARGIN_TOP < 0 ? 0 : y - CAMERA_MARGIN_TOP;
  }

  if (gBmSt.camera.y + CAMERA_MARGIN_BOTTOM < y) {
    result = y - CAMERA_MARGIN_BOTTOM > gBmSt.cameraMax.y
                 ? gBmSt.cameraMax.y
                 : y - CAMERA_MARGIN_BOTTOM;
  }

  return result;
}
//[202BCBC..202BCBF]!!
s8 VeslyCenterCameraOntoPosition(struct Proc *parent, int x, int y) {
  struct CamMoveProc *proc;
  // camera is SHORT 0x0--p where -- is byte coord and p is number of pixels

  int xTarget = NewGetCameraCenteredX(x * 16);
  int yTarget = NewGetCameraCenteredY(y * 16);

  if ((xTarget == gBmSt.camera.x) && (yTarget == gBmSt.camera.y)) {
    return 0;
  }

  if (ProcFind((const ProcInstruction *)&gProcScr_CamMove)) {
    return 0;
  }

  if (parent) {
    proc = (struct CamMoveProc *)ProcStartBlocking(
        (const ProcInstruction *)&gProcScr_CamMove, parent);
  } else {
    proc = (struct CamMoveProc *)ProcStart(
        (const ProcInstruction *)&gProcScr_CamMove, (Proc *)3);
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
void FMU_ClearActionAndSave(struct FMUProc *proc) { PlayerPhase_Suspend(); }

extern int FacingBitOffset_Link;
extern int DirectionNumberOfBits_Link;
extern u32 *GetUnitDebuffEntry(struct Unit *unit);
extern u32 UnpackData(u32 *, int, int);
extern u32 PackData(u32 *, int, int, int value);

void SetUnitFacingASMC(
    void) { // this uses the generic buffer, so it must be used selectively!
  struct Unit *unit = GetUnitStructFromEventParameter(gEventSlot[1]);
  int dir = gEventSlot[3];

  //((struct unitFacing*)&unit->supports[5])->dir = dir;
  PackData(GetUnitDebuffEntry(unit), FacingBitOffset_Link,
           DirectionNumberOfBits_Link, dir);
  u8 smsID = unit->pClassData->SMSId;
  UpdateSMSDir(unit, smsID, dir);
}

void SetUnitFacing(struct Unit *unit, int dir) {
  //((struct unitFacing*)&unit->supports[5])->dir = dir;
  PackData(GetUnitDebuffEntry(unit), FacingBitOffset_Link,
           DirectionNumberOfBits_Link, dir);
}

void UpdateFacingAllIdenticalSpriteUnits(int smsID, int dir) {
  struct Unit *unit;
  for (int i = 1; i < 0xC0; i++) {
    unit = GetUnit(i);
    if (!UNIT_IS_VALID(unit)) {
      continue;
    }
    if (unit->pClassData->SMSId != smsID) {
      continue;
    }
    SetUnitFacing(unit, dir);
  }
}

void SetUnitFacingAndUpdateGfx(struct Unit *unit, int dir) {
  //((struct unitFacing*)&unit->supports[5])->dir = dir;
  PackData(GetUnitDebuffEntry(unit), FacingBitOffset_Link,
           DirectionNumberOfBits_Link, dir);
  u8 smsID = unit->pClassData->SMSId;
  UpdateSMSDir(unit, smsID, dir);
  UpdateFacingAllIdenticalSpriteUnits(smsID, dir);
}

int GetUnitFacing(struct Unit *unit) {
  // return ((struct unitFacing*)&unit->supports[5])->dir;
  return UnpackData(GetUnitDebuffEntry(unit), FacingBitOffset_Link,
                    DirectionNumberOfBits_Link);
}

int BuildStraightLineRangeFromUnit(struct Unit *unit) {
  int result = false;
  int unitID = unit->pCharacterData->number;
  int NotFreeMove = FreeMoveRam->state;
  if ((unitID < 0xE0) || (unitID > 0xEF) || (!NotFreeMove)) {
    return result;
  }

  int dangerRadius = false;
  if (unit->supportBits & (1 << 7)) { //@ Check if unit's DangerRadius is on
    dangerRadius = true;
  }

  int wep = GetUnitEquippedWeapon(unit);
  int c = 0;
  int range = 0;
  while (StraightLineWeaponsList[c]) {
    if (StraightLineWeaponsList[c] == wep) {
      result = true;
      range = GetItemMaxRange(wep);
      break;
    }
    c++;
  }

  if (!result) {
    return result;
  }
  int facing = GetUnitFacing(unit);

  int addX = 0;
  int addY = 0;
  int subX = 0;
  int subY = 0;
  if (facing == MU_FACING_RIGHT)
    addX = 1;
  if (facing == MU_FACING_LEFT)
    subX = 1;
  if (facing == MU_FACING_DOWN)
    addY = 1;
  if (facing == MU_FACING_UP)
    subY = 1;
  if (range == 3) {
    range = 4;
  }
  if (range < 3) {
    range = 3;
  }
  if (dangerRadius) {
    int x = unit->xPos;
    int y = unit->yPos;
    for (int i = 1; i <= range; i++) {

      gMapRange[y + (i * addY) - (i * subY)][x + (i * addX) - (i * subX)] = 1;
      gMapFog[y + (i * addY) - (i * subY)][x + (i * addX) - (i * subX)] = 1;
    }
    return result;
  }

  int x = unit->xPos;
  int y = unit->yPos;
  for (int i = 1; i <= range; i++) {
    gMapRange[y + (i * addY) - (i * subY)][x + (i * addX) - (i * subX)] = 1;
  }
  return result;
}

extern const struct SMSData NewStandingMapSpriteTable[];

extern u8 gGenericBuffer2[0x1000];
// u8 EWRAM_DATA gSMSGfxBuffer[3][8*0x20*0x20] = {};
void UpdateSMSDir(struct Unit *unit, u8 smsID, int facing) {

  if (!unit->pMapSpriteHandle) {
    return;
  }
  u32 tileIndex = (unit->pMapSpriteHandle->oam2Base & 0x3FF) - 0x80;

  u16 size = NewStandingMapSpriteTable[smsID].size;
  u8 width = size < 2 ? 16 : 32;
  u8 height = size > 0 ? 32 : 16;
  u32 srcOffs[3] = {0, 0, 0};
  int frame = GetGameClock() % 72;
  // return;
  srcOffs[0] = (srcOffs[0] << (7 + size)) * 3;
  srcOffs[1] = (srcOffs[0] << ((7 + size)) * 3 * 2);
  srcOffs[2] = (srcOffs[0] << ((7 + size)) * 3 * 4);

  // Do nothing if no different-direction facing idle sprites exist.
  if (FMU_idleSMSGfxTable_left[smsID] == NULL)
    return;
  // I've had issue with using this at the same time as the map is being
  // updated, which also uses gGenericBuffer, so I moved it 0x1500 in.
  if (facing == MU_FACING_LEFT) {
    Decompress(FMU_idleSMSGfxTable_left[smsID] + srcOffs[0], gGenericBuffer2);
    // Decompress(FMU_idleSMSGfxTable_left[smsID]+srcOffs[0], gGenericBuffer);
    // Decompress(FMU_idleSMSGfxTable_left[smsID]+srcOffs[0], gGenericBuffer);
  }

  if (facing == MU_FACING_RIGHT) {
    Decompress(FMU_idleSMSGfxTable_right[smsID] + srcOffs[0], gGenericBuffer2);
    // Decompress(FMU_idleSMSGfxTable_right[smsID]+srcOffs[0], gGenericBuffer);
    // Decompress(FMU_idleSMSGfxTable_right[smsID]+srcOffs[0], gGenericBuffer);
  }
  if (facing == MU_FACING_UP) {
    Decompress(FMU_idleSMSGfxTable_up[smsID] + srcOffs[0], gGenericBuffer2);
    // Decompress(FMU_idleSMSGfxTable_up[smsID]+srcOffs[0], gGenericBuffer);
    // Decompress(FMU_idleSMSGfxTable_up[smsID]+srcOffs[0], gGenericBuffer);
  }
  if (facing == MU_FACING_DOWN) {
    Decompress(NewStandingMapSpriteTable[smsID].pGraphics + srcOffs[0],
               gGenericBuffer2);
    // Decompress(NewStandingMapSpriteTable[smsID].pGraphics+srcOffs[0],
    // gGenericBuffer);
    // Decompress(NewStandingMapSpriteTable[smsID].pGraphics+srcOffs[0],
    // gGenericBuffer);
  }

  /*
  // Decompress sms gfx.
  if (facing==2)
    Decompress(NewStandingMapSpriteTable[smsID].pGraphics, gGenericBuffer); //
  Downward facing sms. else { Decompress(FMU_idleSMSGfxTable[smsID],
  gGenericBuffer);                 // Other direction-facing sms. srcOffs[0] =
  facing==3 ? facing-1 : facing;  // Up-facing sprite comes immediately after
  right.
  }

  // Move sms gfx into smsbuffer.
  srcOffs[0] = (srcOffs[0] << (7 + size)) * 3;
  srcOffs[1] = srcOffs[0] + (0x80 << (size << 2));
  srcOffs[2] = srcOffs[1] + (0x80 << (size << 2));
  */

  // src, dst, width, height
  CopyTileGfxForObj((void *)gGenericBuffer2 + srcOffs[0],
                    (void *)gSMSGfxBuffer_Frame1 + (tileIndex << 5), width >> 3,
                    height >> 3);
  CopyTileGfxForObj((void *)gGenericBuffer2 + srcOffs[1],
                    (void *)gSMSGfxBuffer_Frame2 + (tileIndex << 5), width >> 3,
                    height >> 3);
  CopyTileGfxForObj((void *)gGenericBuffer2 + srcOffs[2],
                    (void *)gSMSGfxBuffer_Frame3 + (tileIndex << 5), width >> 3,
                    height >> 3);

  // Overwrite VRAM with new SMS next frame. Timings taken from 0x8026F2C,
  // SyncUnitSpriteSheet.
  if (frame < 31)
    RegisterTileGraphics(gSMSGfxBuffer_Frame1, (void *)0x06011000,
                         sizeof(gSMSGfxBuffer_Frame1));
  else if (frame < 35)
    RegisterTileGraphics(gSMSGfxBuffer_Frame2, (void *)0x06011000,
                         sizeof(gSMSGfxBuffer_Frame2));
  else if (frame < 67)
    RegisterTileGraphics(gSMSGfxBuffer_Frame3, (void *)0x06011000,
                         sizeof(gSMSGfxBuffer_Frame3));
  else
    RegisterTileGraphics(gSMSGfxBuffer_Frame2, (void *)0x06011000,
                         sizeof(gSMSGfxBuffer_Frame2));
  return;
}

void UpdateSMSDir_All(void) {
  if (gChapterData.turnNumber > 1) {
    return;
  }
  struct Unit *unit = NULL;
  u8 smsID;
  int dir;
  int limit = 10;

  for (int i = 1; i < 0xC0; i++) {
    unit = GetUnit(i);
    if (!UNIT_IS_VALID(unit)) {
      continue;
    }
    if (unit->pCharacterData->number != ProtagID_Link &&
        (unit->pCharacterData->number < 0xE0 ||
         unit->pCharacterData->number > 0xEF)) {
      continue;
    }

    dir = GetUnitFacing(unit); // MU_FACING_DOWN
    if (dir != MU_FACING_DOWN) {
      smsID = unit->pClassData->SMSId;
      UpdateSMSDir(unit, smsID, dir);
      limit--;
      if (limit < 1) {
        break;
      }
    }
  }
}

void pFMU_UpdateSMS(struct FMUProc *proc) {
  struct Unit *unit = proc->FMUnit;
  u8 smsID = proc->FMUnit->pClassData->SMSId;
  int facing = proc->smsFacing;
  UpdateSMSDir(unit, smsID, facing);
}

#ifdef POKEMBLEM_VERSION
extern int GetConvoyItemSlot(int item);
extern void RemoveItemFromConvoy(int index);
extern int SuperRepel_Link;
// calling RemoveItemFromConvoy / ShrinkConvoyItemList
// can break the convoy if called while the generic buffer is in use !

void GiveRepelsToProtag(void) {
  struct Unit *unit = GetUnitStructFromEventParameter(ProtagID_Link);
  if (!unit) {
    return;
  }
  int slot = GetConvoyItemSlot(SuperRepel_Link);
  if (slot < 0) {
    return;
  }
  if (unit->items[0] != 0) {
    return;
  }
  unit->items[0] = GetConvoyItemArray()[slot];
  RemoveItemFromConvoy(slot);
}

#endif

/* @blh 0x801865C @ SetupActiveUnit
void UnitBeginAction(struct Unit* unit) {
    gActiveUnit = unit;
    gActiveUnitId = unit->index;

    gActiveUnitMoveOrigin.x = unit->xPos;
    gActiveUnitMoveOrigin.y = unit->yPos;

    gActionData.subjectIndex = unit->index;
    gActionData.unitActionType = 0;
    gActionData.moveCount = 0;

    gBmSt.unk3D = 0;
    gBmSt.unk3F = 0xFF;

    sub_802C334();

    gActiveUnit->state |= US_HIDDEN;
    gBmMapUnit[unit->yPos][unit->xPos] = 0;
}
*/

/*
void pFMU_MainLoop(struct FMUProc* proc){

        struct MUProc* muProc = MU_GetByUnit(gActiveUnit);

        if (muProc) {
                if
(muProc->pMUConfig->commands[muProc->pMUConfig->currentCommand] !=
MU_COMMAND_HALT && muProc->stateId > MU_STATE_NONACTIVE) { return; //
MU_COMMAND_HALT is the terminator
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
                if(iKeyCur&0x10) 		{ x++; if (muProc->facingId !=
MU_FACING_RIGHT) mD[0] = MU_COMMAND_FACE_RIGHT; else mD[0] =
MU_COMMAND_MOVE_RIGHT; } else if(iKeyCur&0x20)	{ x--; if (muProc->facingId !=
MU_FACING_LEFT) mD[0] = MU_COMMAND_FACE_LEFT; else mD[0] = MU_COMMAND_MOVE_LEFT;
} else if(iKeyCur&0x40)	{ y--; if (muProc->facingId != MU_FACING_UP) mD[0] =
MU_COMMAND_FACE_UP; else mD[0] = MU_COMMAND_MOVE_UP; } else if(iKeyCur&0x80)
{ y++; if (muProc->facingId != MU_FACING_DOWN) mD[0] = MU_COMMAND_FACE_DOWN;
else mD[0] = MU_COMMAND_MOVE_DOWN; }
        }
        mD[1] = MU_COMMAND_HALT; // halt
        if (mD[0] > MU_COMMAND_HALT) {
                MU_StartMoveScript(muProc, &mD[0]); // always change directions
freely proc->facingId = mD[0] - 6;
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
                                //MuCtr_StartMoveTowards(gActiveUnit, x, y,
0x10);
                }
        }

        if (mD[0] == MU_COMMAND_HALT) {
                        ProcGoto((Proc*)proc,0x2);
        }
        return;
}

*/

#include "FreeMU_ButtonPress.c"
#include "FreeMU_Event.c"
#include "FreeMU_Extra.c"
#include "FreeMU_SaveData.c"
