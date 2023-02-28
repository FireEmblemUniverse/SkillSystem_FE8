#include <stdio.h>
#include "main.h"

// FIXME, need to end proc.

const struct ProcInstruction SSS_mainProc[] = {
  PROC_SET_NAME("SSS_Main"),
  PROC_CALL_ROUTINE(SSS_init),
  PROC_LOOP_ROUTINE(SSS_loop),
  PROC_END
};

// Initialize backgrounds when opening statscreen.
void SSS_init(struct SSS_MainProcState* proc) {
  proc->iterator = 0;
  SetBgPosition(1, 0, 0);
  SetBgPosition(3, 0, 0);
  
  // Scrolling Mural
  Decompress(&SSS_MuralGfx, (void*)0x600B000);
  ApplyPalette(SSS_MuralPal, 12);
  for (int i = 0; i < 20; i++) {
    for (int j = 0; j < 32; j++) {
      gBg3MapBuffer[i*32 + j] = 0xC000 | (i*32 + j + 0x180);
    }
  }
  
  // Initialize right page.
  Decompress(&SSS_PageAndPortraitGfx, (void*)0x6000000);
  CpuFastFill(0, gBg1MapBuffer, 0x800);               // Clear screen entries.
  CpuFastFill(0, gpStatScreenPageBg1Map, 0x280);      // Clear screen entries.
  u8 pageNumber = *(u8*)0x2003BFC;    // This is the first byte of the StatScreenStruct. Not yet in FE-Clib.
  Decompress(SSS_PageTSATable[pageNumber], gGenericBuffer);
  BgMap_ApplyTsa(gpStatScreenPageBg1Map, gGenericBuffer, 0x1000);
  BgMapCopyRect(&gpStatScreenPageBg1Map[0], &gBg1MapBuffer[0x4C], 18, gGenericBuffer[1]+1);   // Height differs.
  
  EnableBgSyncByMask(7);
}

// Scroll BG3. TODO make customizable.
void SSS_loop(struct SSS_MainProcState* proc) {
  proc->iterator += 1;
  u16 xPos = proc->iterator >> 2;
  SetBgPosition(3, (u8)xPos, 0);
}

// Clear BG1Tiles when horizontally flipping pages.
// Hook also replaces clearing BG2Tiles. So we clear those too.
void SSS_ClearBG1Tiles() {
  BgMapFillRect(&gBg1MapBuffer[0x4C], 18, 18, 0);
  BgMapFillRect(&gBg2MapBuffer[0x4C], 18, 18, 0);
}

// Update BG1Tiles when horizontally flipping pages.
// Hook also replaces updating BG2Tiles. So we update those too.
void SSS_UpdateBG1Tiles(int leftOffset, int rightOffset, int width) {
  BgMapCopyRect(&gpStatScreenPageBg1Map[leftOffset>>1], &gBg1MapBuffer[0x4C + (rightOffset>>1)], width, 18);
  BgMapCopyRect(&gpStatScreenPageBg2Map[leftOffset>>1], &gBg2MapBuffer[0x4C + (rightOffset>>1)], width, 18);
}









