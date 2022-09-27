#ifndef GBAFE_ARMFUNC_H
#define GBAFE_ARMFUNC_H

#include "common.h"
#include "hiobj.h"

void RamFuncInit(void); //! FE8U = 0x8002AF9

void HuffmanTextDecomp(const char* source, char* target); //! FE8U = 0x8002BA5
void FillMovementMapCore(void); //! FE8U = 0x8002BF5

void BgMap_ApplyTsa(u16* target, const void* source, u16 tileBase); //! FE8U = 0x80D74A1
void BgMapFillRect(u16* target, int width, int height, int value); //! FE8U = 0x80D74A9
void BgMapCopyRect(const u16* source, u16* target, int width, int height); //! FE8U = 0x80D74B9

// decomp compat
#define StoreRoutinesToIRAM RamFuncInit
#define CallARM_DecompText HuffmanTextDecomp
#define CallARM_FillMovementMap FillMovementMapCore

#endif // GBAFE_ARMFUNC_H
