#include <stdio.h>
#include "main.h"

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
  
  // Initialize Scrolling Mural.
  Decompress(&SSS_MuralGfx, (void*)0x600B000);
  ApplyPalette(SSS_MuralPal, 12);
  for (int i = 0; i < 20; i++) {
    for (int j = 0; j < 32; j++) {
      gBg3MapBuffer[i*32 + j] = 0xC000 | (i*32 + j + 0x180);
    }
  }
  
  // Initialize Portrait box.
  Decompress(SSS_PageAndPortraitGfxTable[gChapterData.windowColour], (void*)0x6000000);
  ApplyPalette(SSS_PageAndPortraitPalTable[gChapterData.windowColour], 1);
  Decompress(&SSS_PortraitBoxTSA, gGenericBuffer);
  CpuFastFill(0, gBg1MapBuffer, 0x800);               // Clear screen entries.
  BgMap_ApplyTsa(gBg1MapBuffer, gGenericBuffer, 0x0000);
  
  // Initialize right page.
  CpuFastFill(0, gpStatScreenPageBg1Map, 0x280);      // Clear screen entries.
  u8 pageNumber = StatScreenStruct[0];
  Decompress(SSS_PageTSATable[pageNumber], gGenericBuffer);
  BgMap_ApplyTsa(gpStatScreenPageBg1Map, gGenericBuffer, 0x0000);
  BgMapCopyRect(&gpStatScreenPageBg1Map[0], &gBg1MapBuffer[0x4C], 18, gGenericBuffer[1]+1);   // Height differs.
  
  // Load palette for bottom-leftbox.
  ApplyPalette(SSS_PageAndPortraitPalTable[gChapterData.windowColour], 18);
  
  // Load palette for Equipment-statsbox.
  ApplyPalette(SSS_StatsBoxPalTable[gChapterData.windowColour], 3);
  
  EnableBgSyncByMask(7);
}

// Scroll BG3. TODO make customizable (vertical, diagonal, path-tracking scrolling!)
void SSS_loop(struct SSS_MainProcState* proc) {
  proc->iterator += 1;
  u16 xPos = proc->iterator >> 2;
  SetBgPosition(3, (u8)xPos, 0);
}

// Clear BG1Tiles when horizontally flipping pages.
// Hook also replaces clearing BG2Tiles. So we clear those too.
void SSS_clearBG1Tiles() {
  BgMapFillRect(&gBg1MapBuffer[0x4C], 18, 18, 0);
  BgMapFillRect(&gBg2MapBuffer[0x4C], 18, 18, 0);
}

// Update BG1Tiles when horizontally flipping pages.
// Hook also replaces updating BG2Tiles. So we update those too.
void SSS_updateBG1Tiles(int leftOffset, int rightOffset, int width) {
  BgMapCopyRect(&gpStatScreenPageBg1Map[leftOffset>>1], &gBg1MapBuffer[0x4C + (rightOffset>>1)], width, 18);
  BgMapCopyRect(&gpStatScreenPageBg2Map[leftOffset>>1], &gBg2MapBuffer[0x4C + (rightOffset>>1)], width, 18);
}

// Scroll BG1 when vertically scrolling.
// Hook also replaces scrolling BG0 and BG2. So that's in here too.
void SSS_scrollBG1(s16 vOffs) {
  SetBgPosition(0, 0, vOffs);
  SetBgPosition(1, 0, vOffs);
  SetBgPosition(2, 0, vOffs);
}

// Setup BLDCNT, EVA and EVB for bottom-left box.
// Hook overwrites some other stuff that we take care of as well.
void SSS_blendMMSBox() {
  // Overwritten by hook.
  gLCDIOBuffer.bgControl[3].priority = 3;
  SetDefaultColorEffects();
  StatScreenStruct[8] = 0;
  
  // Enable alphablend.
  SetColorEffectsParameters(0, 6, 8, 0);                    // EVA = 6, EVB = 8.
  SetColorEffectsFirstTarget(0, 0, 1, 0, 0);                // First target BG2.
  SetColorEffectBackdropFirstTarget(1);                     // First target Backdrop.
  SetColorEffectsSecondTarget(0, 0, 0, 1, 0);               // Second target BG3.
  SetColorEffectBackdropSecondTarget(0);
  gLCDIOBuffer.blendControl.effect = BLEND_EFFECT_ALPHA;    // Enable alphablending.
}