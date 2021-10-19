#include <stdio.h>
#include "SkillProcDisplay.h"


// Animated battle.
const struct ProcInstruction SPD_main_Proc[] = {
  PROC_SET_NAME("SPD_main"),
  PROC_SET_DESTRUCTOR(SPD_destructor),
  PROC_END_DUPLICATES,
  PROC_SLEEP(1),
  PROC_CALL_ROUTINE(SPD_init),
  PROC_LOOP_ROUTINE(SPD_loop),
  PROC_END
};

void SPD_init(struct SPD_ProcStateMain* proc) {
  // We could crash if skill is either 0 or 255.
  if (!proc->skill || proc->skill == 0xFF)
    proc->skill = 1;
  
  CopyTileGfxForObj(&SkillIcons[proc->skill], (void*)0x6013380, 2, 2);
  
  // Prepare skill name.
  GetStringFromIndex((int)SkillDescTable[proc->skill]);
  int i = 0;
  while (gCurrentTextString[i] != 0x3A) // 0x3A = ":", we cut off everything past colon.
    i++;
  gCurrentTextString[i] = 0;
  
  // Draw skill name.
  FontData* font = (FontData*)0x2017648;
  Text_InitFontExt(font, (void*)0x6000020, 1, 0);
  *(u32*)((u32)font+8) = 0x8004269;    // Draws glyphs by overwriting pixels instead of adding.
  Text_InitClear(&proc->textHandle, 8);
  Text_SetXCursor(&proc->textHandle, (int)Text_GetStringTextCenteredPos(SKILLDISPLAY_WIDTH*8, gCurrentTextString));
  CpuFastCopy(&SPD_ProcDisplayTiles, (void*)0x6000020, SKILLDISPLAY_WIDTH*64);
  Text_DrawString(&proc->textHandle, gCurrentTextString);
  
  proc->timer = 0;
}

// Determine where to draw skill icon + name.
void SPD_loop(struct SPD_ProcStateMain* proc) {
  AIStruct skillIcon;
  s16 xOffset;
  int endTimer = proc->timer - (DISPLAY_TIME + (SKILLDISPLAY_WIDTH+2));
  proc->timer++;
  
  // Draw name.
  if (proc->timer > DISPLAY_TIME + ((SKILLDISPLAY_WIDTH+2)*2)) {
    BreakProcLoop((Proc*)proc);
    return;
  }
  else if (proc->timer <= (SKILLDISPLAY_WIDTH+2)) {   // Slide name forward.
    xOffset = proc->timer << 3;
    if (proc->right) {    // Right side.
      for (int i = 0; i < proc->timer-2; i++) {
        gBg0MapBuffer[0x9D - ((proc->timer-3)-i)] = 0x3000 | (1+(i*2));
        gBg0MapBuffer[0xBD - ((proc->timer-3)-i)] = 0x3000 | (2+(i*2));
      }
    }
    else {    // Left side.
      for (int i = 0; i < proc->timer-2; i++) {
        gBg0MapBuffer[0x80 + ((proc->timer-3)-i)] = 0x2000 | ((SKILLDISPLAY_WIDTH*2-1)-(i*2));
        gBg0MapBuffer[0xA0 + ((proc->timer-3)-i)] = 0x2000 | ((SKILLDISPLAY_WIDTH*2)-(i*2));
      }
    }
    EnableBgSyncByIndex(0);
  }
  else if (endTimer > 0) {    // Slide name backward.
    xOffset = ((SKILLDISPLAY_WIDTH+2) - endTimer) << 3;
    if (proc->right) {    // Right side.
      gBg0MapBuffer[(0x9D-SKILLDISPLAY_WIDTH)+endTimer] = 0x3080;
      gBg0MapBuffer[(0xBD-SKILLDISPLAY_WIDTH)+endTimer] = 0x3080;
      for (int i = endTimer; i < SKILLDISPLAY_WIDTH; i++) {
        gBg0MapBuffer[(0x9D-SKILLDISPLAY_WIDTH) + i + 1] = 0x3000 | (((i-endTimer)*2)+1);
        gBg0MapBuffer[(0xBD-SKILLDISPLAY_WIDTH) + i + 1] = 0x3000 | (((i-endTimer)*2)+2);
      }
    }
    else {    // Left side.
      gBg0MapBuffer[(0x80+SKILLDISPLAY_WIDTH)-endTimer] = 0x2080;
      gBg0MapBuffer[(0xA0+SKILLDISPLAY_WIDTH)-endTimer] = 0x2080;
      for (int i = endTimer; i < SKILLDISPLAY_WIDTH; i++) {
        gBg0MapBuffer[(0x80+SKILLDISPLAY_WIDTH) - (i + 1)] = 0x2000 | ((SKILLDISPLAY_WIDTH*2)-(((i-endTimer)*2)+1));
        gBg0MapBuffer[(0xA0+SKILLDISPLAY_WIDTH) - (i + 1)] = 0x2000 | ((SKILLDISPLAY_WIDTH*2)-((i-endTimer)*2));
      }
    }
    EnableBgSyncByIndex(0);
  }
  else    // Name remains stationary.
    xOffset = ((SKILLDISPLAY_WIDTH+2)*8);
  
  if (proc->right)
    xOffset = 240 - xOffset;
  else
    xOffset -= 16;
  
  // Draw icon.
  *(u32*)((u32)&skillIcon+0x3C) = 0x85B9544;
  *(u16*)((u32)&skillIcon+0x1C) = 0;          // OAM0.
  *(u16*)((u32)&skillIcon+0x1E) = 0;          // OAM1.
  skillIcon.oam2base = 0xD19C;                // OAM2.
  skillIcon.xPosition = *(s16*)((u32)proc->parent+(u32)0x32) + xOffset; // xPos. Parent is gProc_ekrGauge.
  skillIcon.yPosition = *(s16*)((u32)proc->parent+(u32)0x3A) + 32;      // yPos. ^draws stuff like item icons.
  skillIcon.state2 = 0;  // Some bitfield.
  DisplayAIS(&skillIcon);
}

// Clear skill icon + name.
void SPD_destructor(struct SPD_ProcStateMain* proc) {
  // Skill icon is a sprite, can't be undrawn for next frame.
  // However, we can fill the sprite with transparant colour.
  CpuFastFill(0, (void*)0x6013380, 0x40);
  CpuFastFill(0, (void*)0x6013780, 0x40);
  CpuFastFill(0, (void*)0x6000020, SKILLDISPLAY_WIDTH*64);
  
  // Clear name screen entries.
  for (int i = 0; i < SKILLDISPLAY_WIDTH; i++) {
    gBg0MapBuffer[0x80 + i] = 0x2080;
    gBg0MapBuffer[0xA0 + i] = 0x2080;
    gBg0MapBuffer[0x9D - i] = 0x3080;
    gBg0MapBuffer[0xBD - i] = 0x3080;
  }
  EnableBgSyncByIndex(0);
}

// Map battle.
const struct ProcInstruction SPD_Map_main_Proc[] = {
  PROC_SET_NAME("SPD_Map_main"),
  PROC_SET_DESTRUCTOR(SPD_Map_clearScreenEntries),
  PROC_END_DUPLICATES,
  PROC_YIELD,
  PROC_CALL_ROUTINE(SPD_Map_init),
  PROC_LOOP_ROUTINE(SPD_Map_loop),
  PROC_END
};

void SPD_Map_init(struct SPD_Map_ProcStateMain* proc) {
  // We could crash if skill is either 0 or 255.
  if (!proc->skill || proc->skill == 0xFF)
    proc->skill = 1;
  
  CpuFastCopy(&SkillIcons[proc->skill], (void*)0x6000C00, 0x80);
  ApplyPalettes(gIconPalettes, 4, 1);
  
  proc->timer = 0;
}

void SPD_Map_clearScreenEntries(struct SPD_Map_ProcStateMain* proc) {
  int l = proc->left ? -1 : 1;
  int m = (int)proc->left;
  
  for (int i = 0; i < 2; i++)
    for (int j = 0; j < 3; j++)
      gBg0MapBuffer[(proc->y+i+1)*0x20 + (proc->x+(10+m+j)*l)] = 0;
  EnableBgSyncByIndex(0);
}

// Draw skill icon on BG0.
void SPD_Map_loop(struct SPD_Map_ProcStateMain* proc) {
  int i, j, k, l, m, offset;
  proc->timer++;

  // Clear screen entries first.
  SPD_Map_clearScreenEntries(proc);
  
  if (proc->timer >= MAP_DISPLAY_TIME+3) {
    BreakProcLoop((Proc*)proc);
    return;
  }
  
  // Draw skill icon.
  if (proc->timer == 1 || proc->timer - MAP_DISPLAY_TIME == 2)
    offset = 0;
  else if (proc->timer == 2 || proc->timer - MAP_DISPLAY_TIME == 1)
    offset = 1;
  else
    offset = 2;
  k = offset ? 2 : 1;
  l = proc->left ? -1 : 1;
  m = (int)proc->left;
  for (i = 0; i < k; i++)
    for (j = 0; j < 2; j++)
      gBg0MapBuffer[(proc->y+j+1)*0x20 + proc->x+l*(10+m-i+offset)] = j * 2 - i * l + 0x4061 - m;
  //EnableBgSyncByIndex(0);   // Already set by SPD_Map_clearScreenEntries.
}