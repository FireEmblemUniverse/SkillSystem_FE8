#ifndef SKILLPROCDISPLAY_H
#define SKILLPROCDISPLAY_H
#include "gbafe.h"

#define DISPLAY_TIME 120
#define SKILLDISPLAY_WIDTH 8
#define MAP_DISPLAY_TIME 30

struct SPD_ProcStateMain {
  
	/* 00 */ PROC_HEADER;
  /* 29 */ u8 skill;
  /* 2A */ u8 right;
  /* 2B */ u8 timer;
  /* 2C */ u16 depth;
  /* 30 */ TextHandle textHandle;
  
};
extern const ProcInstruction SPD_main_Proc[];
void SPD_init(struct SPD_ProcStateMain* proc);
void SPD_loop(struct SPD_ProcStateMain* proc);
void SPD_destructor(struct SPD_ProcStateMain* proc);

struct SPD_Map_ProcStateMain {
  
	/* 00 */ PROC_HEADER;
  /* 29 */ u8 skill;
  /* 2A */ u8 left;
  /* 2B */ u8 timer;
  /* 2C */ u8 x;
  /* 2D */ u8 y;
  
};
extern const ProcInstruction SPD_Map_main_Proc[];
void SPD_Map_init(struct SPD_Map_ProcStateMain* proc);
void SPD_Map_loop(struct SPD_Map_ProcStateMain* proc);
void SPD_Map_clearScreenEntries(struct SPD_Map_ProcStateMain* proc);

struct SPD_SkillIcon {
  const u8 padding[128];
};
extern struct SPD_SkillIcon SkillIcons[256];
extern const u16 SkillDescTable[256];
extern const void* SPD_ProcDisplayTiles;
extern const void* SPD_ProcDisplayTSA;

extern void CopyTileGfxForObj(void* src, void* dest, u8 width, u8 height); //! FE8U = 0x8013021
extern char gCurrentTextString[]; //! FE8U = 0x202A6AC
extern const u16 gIconPalettes[]; //! FE8U = 0x85996F4

#endif // SKILLPROCDISPLAY_H