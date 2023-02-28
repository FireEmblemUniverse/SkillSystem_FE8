#ifndef MAIN_H
#define MAIN_H
#include "gbafeext.h"

struct SSS_MainProcState {
  
	/* 00 */ PROC_HEADER;
  /* 2A */ u16 iterator;
  
};

extern const ProcInstruction SSS_mainProc[];
void SSS_init(struct SSS_MainProcState* proc);
void SSS_loop(struct SSS_MainProcState* proc);
void SSS_ClearBG1Tiles();
void SSS_UpdateBG1Tiles(int leftOffset, int rightOffset, int width);

// Graphics
extern const void* SSS_MuralGfx;
extern const u16 SSS_MuralPal[16];
extern const void* SSS_PageAndPortraitGfx;
extern const void* SSS_PageTSATable[];

#endif // MAIN_H