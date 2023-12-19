#ifndef SKILLPROCDISPLAY_H
#define SKILLPROCDISPLAY_H
#include "gbafe.h"

#define DISPLAY_TIME 120
#define SKILLDISPLAY_WIDTH 8
#define MAP_DISPLAY_TIME 30

typedef struct AnimationInterpreter AnimationInterpreter;
typedef struct AnimationInterpreter AIStruct;

struct AnimationInterpreter {
	/* 00 */ u16 state;
	/* 02 */ s16 xPosition;
	/* 04 */ s16 yPosition;
	/* 06 */ u16 delayTimer;
	/* 08 */ u16 oam2base;
	/* 0A */ u16 drawLayerPriority;
	/* 0C */ u16 state2;
	/* 0E */ u16 nextRoundId;
	/* 10 */ u16 state3;
	/* 12 */ u8 currentRoundType;
	/* 13 */ u8 frameIndex;

	/* 14 */ u8 queuedCommandCount;
	/* 15 */ u8 commandQueue[0xB];

	/* 20 */ const void* pCurrentFrame;
	/* 24 */ const void* pStartFrame;
	/* 28 */ const void* pUnk28;
	/* 2C */ const void* pUnk2C;
	/* 30 */ const void* pStartObjData; // aka "OAM data"

	/* 34 */ struct AnimationInterpreter* pPrev;
	/* 38 */ struct AnimationInterpreter* pNext;

	/* 40 */ const void* pUnk40;
	/* 44 */ const void* pUnk44;
};

struct SPD_ProcStateMain {
  
	/* 00 */ PROC_HEADER;
  /* 29 */ u8 skill;
  /* 2A */ u8 right;
  /* 2B */ u8 timer;
  /* 2C */ u16 depth;
  /* 30 */ struct Text textHandle;
  
};
extern const struct ProcCmd SPD_main_Proc[];
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
extern const struct ProcCmd SPD_Map_main_Proc[];
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
extern char sMsgString[]; //! FE8U = 0x202A6AC
extern const u16 gIconPalettes[]; //! FE8U = 0x85996F4

#endif // SKILLPROCDISPLAY_H