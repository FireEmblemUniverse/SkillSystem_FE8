#ifndef MAIN_H
#define MAIN_H
#include "gbafe.h"

struct SSS_MainProcState {
  
	/* 00 */ PROC_HEADER;
  /* 2A */ u16 iterator;
  
};

extern const ProcInstruction SSS_mainProc[];
void SSS_init(struct SSS_MainProcState* proc);
void SSS_loop(struct SSS_MainProcState* proc);
void SSS_clearBG1Tiles();
void SSS_updateBG1Tiles(int leftOffset, int rightOffset, int width);
void SSS_scrollBG1(s16 vOffs);
void SSS_blendMMSBox();

// Graphics
extern const void* SSS_MuralGfx;
extern const u16 SSS_MuralPal[16];
extern const void* SSS_PageAndPortraitGfxTable[4];
extern const u16* SSS_PageAndPortraitPalTable[4];
extern const u16* SSS_StatsBoxPalTable[4];
extern const void* SSS_PageTSATable[];
extern const void* SSS_PortraitBoxTSA;

// Vanilla, but not in FE-Clib.
extern u16 gpStatScreenPageBg0Map[0x280]; //! FE8U = 0x2003D2C
extern u16 gpStatScreenPageBg1Map[0x280]; //! FE8U = 0x200422C
extern u16 gpStatScreenPageBg2Map[0x280]; //! FE8U = 0x200472C
extern u8 StatScreenStruct[0x14]; //! FE8U = 0x2003BFC
//extern u16* gOldUIPalettePointers[4]; //! FE8U = 0x85B6440

#endif // MAIN_H