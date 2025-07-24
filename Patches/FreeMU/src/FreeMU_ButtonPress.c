#include "FreeMU.h"

void FMU_ResetLCDIO(void) {
  gLCDIOBuffer.dispControl.enableWin0 = 0;
  gLCDIOBuffer.dispControl.enableWin1 = 0;
  gLCDIOBuffer.dispControl.enableObjWin = 0;
  gLCDIOBuffer.blendControl.effect = 0;
}

extern struct MenuProc *StartSemiCenteredOrphanMenu(const struct MenuDef *def,
                                                    int xSubject, int xTileLeft,
                                                    int xTileRight);
extern const struct MenuDef gUnitActionMenuDef;
bool FMU_open_um(struct FMUProc *proc) {
  if (FMU_ShouldWeYieldForEvent(proc)) {
    return 0;
  }
  if ((proc->xCur != proc->xTo) || (proc->yCur != proc->yTo)) {
    proc->xCur = proc->xTo;
    proc->yCur = proc->yTo;
    gActiveUnit->xPos = proc->xCur;
    gActiveUnit->yPos = proc->yCur;
  }

  FMU_ResetLCDIO();
  StartSemiCenteredOrphanMenu(&gUnitActionMenuDef,
                              gBmSt.cursorTarget.x - gBmSt.camera.x, 1, 0x14);
  proc->updateSMS = true;
  return 1;
}

extern const void *HandleProtag;
extern int StartSoaring(Proc *MenuProc);
int CallSoarEffect(struct Proc *menu) {
  CallMapEventEngine(&HandleProtag, 3);
  return StartSoaring(menu);
}

/*!!!!*/

bool FMU_OnButton_StartMenu(FMUProc *proc) {
  if (FMU_ShouldWeYieldForEvent(proc)) {
    return 0;
  }

  // MU_EndAll();
  // EndPlayerPhaseSideWindows();
  FMU_ResetLCDIO();
  // proc->updateSMS = true;
  StartMenuAdjusted(&FreeMovementLMenu, 0, 0, 0);
  return 1;
}

extern int MapMenuCommnd_StatusEffect(void); // Procs
int FMU_CallStatus() {
  // FMU_ResetLCDIO();
  //  There's a graphical glitch when opening the status menu
  //  it starts proc A01B54. Config starts proc A2ECE0 and doesn't glitch
  //  might need to fade to black with FMU before starting this proc, idk
  MapMenuCommnd_StatusEffect();
  return 0x17;
}

int FMU_OnButton_EndFreeMove(void) {
  struct FMUProc *proc = (struct FMUProc *)ProcFind(FreeMovementControlProc);
  FreeMoveRam->silent = false;
  FMU_ResetLCDIO();
  ProcGoto((Proc *)proc, 0xF);
  End6CInternal_FreeMU();
  FMU_StartPlayerPhase();
  SetCursorMapPosition(gActiveUnit->xPos, gActiveUnit->yPos);
  return 0xB7; // close menu etc
}

extern void SetupActiveUnit(struct Unit *unit);
extern int AreAllPlayersSafe(void);
extern int CallCommandEffect(void);
extern void TurnOnBGMFlag(void);
int FMU_EndFreeMoveSilent(void) {
  FreeMoveRam->silent = true;
  FMU_ResetLCDIO(); // restore things back to normal - otherwise map can glitch
  struct FMUProc *proc = (struct FMUProc *)ProcFind(FreeMovementControlProc);
  if (proc) {
    gActiveUnit->xPos = proc->xTo;
    gActiveUnit->yPos = proc->yTo;
    ProcGoto((Proc *)proc, 0xF);
    End6CInternal_FreeMU();
    // EndAllMenus();
  }
  // SetupActiveUnit(gActiveUnit);
  FMU_StartPlayerPhase();
  SetCursorMapPosition(gActiveUnit->xPos, gActiveUnit->yPos);
  SetEventId(
      0x1); // so can only call once - if this flag is on, do not move protag
  CallCommandEffect();
  UnsetEventId(0x8); // so can call
  if (AreAllPlayersSafe()) {
    UnsetEventId(0x1);
  } else {
    TurnOnBGMFlag();
  }

  return 0xB7; // close menu etc
}

bool FMU_OnButton_ChangeUnit(FMUProc *proc) {
  Unit *UnitNext = GetUnit(proc->FMUnit->index + 1);
  while (IsCharNotOnMap(UnitNext)) {
    UnitNext = GetUnit(UnitNext->index + 1);
    if (IsCharInvaild(UnitNext)) {
      UnitNext = GetUnit(1);
      proc->FMUnit = UnitNext;
      gActiveUnit = UnitNext;
      return 1;
    }
  }

  if (IsCharInvaild(UnitNext))
    UnitNext = GetUnit(1);
  proc->FMUnit = UnitNext;
  gActiveUnit = UnitNext;
  return 1;
}

bool FMU_OnButton_ViewStatusScreen(FMUProc *proc) {

  struct Unit *unit = NULL;
  s8 x = gActiveUnit->xPos;
  s8 y = gActiveUnit->yPos;
  if (proc->smsFacing == 0)
    x--;
  else if (proc->smsFacing == 1)
    x++;
  else if (proc->smsFacing == 2)
    y++;
  else
    y--;

  int deploymentID = gMapUnit[y][x];
  if (deploymentID) {
    unit = GetUnit(deploymentID);
  }

  if (UNIT_IS_VALID(unit)) {
    // basically copied from 0x801C9BE
    if (CanShowUnitStatScreen(unit)) {
      MU_EndAll();
      EndPlayerPhaseSideWindows();
      FMU_ResetLCDIO();
      proc->updateSMS = true;
      SetStatScreenConfig(1);
      StartStatScreen(unit, (Proc *)proc);
      // maybe tell FMUProc to yield here
      return 1;
    }
  }
  return 0;
}

struct StatScreenInfo {
  /* 00 */ u8 unk00;
  /* 01 */ u8 unitId;
  /* 02 */ u16 config;
};

struct Text {
  u16 chr_position;
  u8 x;
  u8 colorId;
  u8 tile_width;
  s8 db_enabled;
  u8 db_id;
  u8 is_printing;
};

struct StatScreenSt {
  /* 00 */ u8 page;
  /* 01 */ u8 pageAmt;
  /* 02 */ u16 pageSlideKey; // 0, DPAD_RIGHT or DPAD_LEFT
  /* 04 */ short xDispOff; // Note: Always 0, not properly taked into account by
                           // most things
  /* 06 */ short yDispOff;
  /* 08 */ s8 inTransition;
  /* 0C */ struct Unit *unit;
  /* 10 */ struct MUProc *mu;
  /* 14 */ const struct HelpBoxInfo *help;
  /* 18 */ struct Text text[35];
};

extern struct StatScreenSt gStatScreen;
extern struct StatScreenInfo sStatScreenInfo;

//    ORG $888BC //Stores byte to store 1 before stat screen struct
// callHack_r3(Store_Page)
// commented this out from
// EngineHacks\Necessary\ModularStatScreen\ModularStatScreen.event @ line 69
void StatScreen_OnClose(void) {
  gChapterData.chapterStateBits =
      (gChapterData.chapterStateBits & ~3) | (gStatScreen.page & 3);
  sStatScreenInfo.unitId = gStatScreen.unit->index;
  SetInterrupt_LCDVCountMatch(NULL);

  gLCDIOBuffer.dispControl.enableBg0 = FALSE;
  gLCDIOBuffer.dispControl.enableBg1 = FALSE;
  gLCDIOBuffer.dispControl.enableBg2 = FALSE;
  gLCDIOBuffer.dispControl.enableBg3 = FALSE;
  gLCDIOBuffer.dispControl.enableObj = FALSE;
  if (!FreeMoveRam->state) { // added

  } else {
    struct FMUProc *proc = (struct FMUProc *)ProcFind(FreeMovementControlProc);
    proc->updateAfterStatusScreen = true;
    proc->yield = true;
    proc->countdown = 1;

    // gLCDIOBuffer.dispControl.enableBg0 = true;
    // gLCDIOBuffer.dispControl.enableBg1 = true;
    // gLCDIOBuffer.dispControl.enableBg2 = true;
    // gLCDIOBuffer.dispControl.enableBg3 = true;
    // gLCDIOBuffer.dispControl.enableObj = true;
    // FMU_ResetLCDIO();
    // StartFadeOutBlackMedium();
    // RenderBmMap();
  }
}
