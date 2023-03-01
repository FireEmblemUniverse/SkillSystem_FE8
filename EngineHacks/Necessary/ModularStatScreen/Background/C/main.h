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
void SSS_ClearBG1Tiles();
void SSS_UpdateBG1Tiles(int leftOffset, int rightOffset, int width);
void SSS_ScrollBG1(s16 vOffs);
void SSS_BlendMMSBox();

// Graphics
extern const void* SSS_MuralGfx;
extern const u16 SSS_MuralPal[16];
extern const void* SSS_PageAndPortraitGfx;
extern const u16 SSS_PageAndPortraitPal[16];
extern const void* SSS_PageTSATable[];
extern const void* SSS_PortraitBoxTSA;

// Vanilla, but not in FE-Clib.
extern u16 gpStatScreenPageBg0Map[0x280]; //! FE8U = 0x2003D2C
extern u16 gpStatScreenPageBg1Map[0x280]; //! FE8U = 0x200422C
extern u16 gpStatScreenPageBg2Map[0x280]; //! FE8U = 0x200472C
extern u8 StatScreenStruct[0x14]; //! FE8U = 0x2003BFC

#endif // MAIN_H