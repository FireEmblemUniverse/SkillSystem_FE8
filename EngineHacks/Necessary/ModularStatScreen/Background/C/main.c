#include <stdio.h>
#include "main.h"

const struct ProcCmd SSS_mainProc[] = {
  PROC_NAME("SSS_Main"),
  PROC_CALL(SSS_init),
  PROC_REPEAT(SSS_loop),
  PROC_END
};

// Initialize backgrounds when opening statscreen.
void SSS_init(struct SSS_MainProcState* proc) {
  proc->iterator = 0;
  BG_SetPosition(1, 0, 0);
  BG_SetPosition(3, 0, 0);
  
  // Initialize Scrolling Mural.
  Decompress(&SSS_MuralGfx, (void*)0x600B000);
  ApplyPalette(SSS_MuralPal, 12);
  for (int i = 0; i < 20; i++) {
    for (int j = 0; j < 32; j++) {
      gBG3TilemapBuffer[i*32 + j] = 0xC000 | (i*32 + j + 0x180);
    }
  }
  
  // Initialize Portrait box.
  Decompress(SSS_PageAndPortraitGfxTable[gPlaySt.config.windowColor], (void*)0x6000000);
  ApplyPalette(SSS_PageAndPortraitPalTable[gPlaySt.config.windowColor], 1);
  Decompress(&SSS_PortraitBoxTSA, gGenericBuffer);
  CpuFastFill(0, gBG1TilemapBuffer, 0x800);               // Clear screen entries.
  CallARM_FillTileRect(gBG1TilemapBuffer, gGenericBuffer, 0x0000);
  
  // Initialize right page.
  CpuFastFill(0, gpStatScreenPageBg1Map, 0x280);      // Clear screen entries.
  u8 pageNumber = StatScreenStruct[0];
  Decompress(SSS_PageTSATable[pageNumber], gGenericBuffer);
  CallARM_FillTileRect(gpStatScreenPageBg1Map, gGenericBuffer, 0x0000);
  TileMap_CopyRect(&gpStatScreenPageBg1Map[0], &gBG1TilemapBuffer[0x4C], 18, gGenericBuffer[1]+1);   // Height differs.
  
  // Load palette for bottom-leftbox.
  ApplyPalette(SSS_PageAndPortraitPalTable[gPlaySt.config.windowColor], 18);
  
  // Load palette for Equipment-statsbox.
  ApplyPalette(SSS_StatsBoxPalTable[gPlaySt.config.windowColor], 3);
  
  BG_EnableSyncByMask(7);
}

// Scroll BG3. TODO make customizable (vertical, diagonal, path-tracking scrolling!)
void SSS_loop(struct SSS_MainProcState* proc) {
  proc->iterator += 1;
  u16 xPos = proc->iterator >> 2;
  BG_SetPosition(3, (u8)xPos, 0);
}

// Clear BG1Tiles when horizontally flipping pages.
// Hook also replaces clearing BG2Tiles. So we clear those too.
void SSS_clearBG1Tiles() {
  TileMap_FillRect(&gBG1TilemapBuffer[0x4C], 18, 18, 0);
  TileMap_FillRect(&gBG2TilemapBuffer[0x4C], 18, 18, 0);
}

// Update BG1Tiles when horizontally flipping pages.
// Hook also replaces updating BG2Tiles. So we update those too.
void SSS_updateBG1Tiles(int leftOffset, int rightOffset, int width) {
  TileMap_CopyRect(&gpStatScreenPageBg1Map[leftOffset>>1], &gBG1TilemapBuffer[0x4C + (rightOffset>>1)], width, 18);
  TileMap_CopyRect(&gpStatScreenPageBg2Map[leftOffset>>1], &gBG2TilemapBuffer[0x4C + (rightOffset>>1)], width, 18);
}

// Scroll BG1 when vertically scrolling.
// Hook also replaces scrolling BG0 and BG2. So that's in here too.
void SSS_scrollBG1(s16 vOffs) {
  BG_SetPosition(0, 0, vOffs);
  BG_SetPosition(1, 0, vOffs);
  BG_SetPosition(2, 0, vOffs);
}

// Setup BLDCNT, EVA and EVB for bottom-left box.
// Hook overwrites some other stuff that we take care of as well.
void SSS_blendMMSBox() {
  // Overwritten by hook.
  gLCDControlBuffer.bg3cnt.priority = 3;
  SetDefaultColorEffects();
  StatScreenStruct[8] = 0;
  
  // Enable alphablend.
  SetSpecialColorEffectsParameters(0, 6, 8, 0);                    // EVA = 6, EVB = 8.
  SetBlendTargetA(0, 0, 1, 0, 0);                // First target BG2.
  SetBlendBackdropA(1);                     // First target Backdrop.
  SetBlendTargetB(0, 0, 0, 1, 0);               // Second target BG3.
  SetBlendBackdropA(0);
  gLCDControlBuffer.bldcnt.effect = BLEND_EFFECT_ALPHA;    // Enable alphablending.
}