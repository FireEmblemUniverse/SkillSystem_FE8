#ifndef GBAFE_DEBUG_PRINT_H
#define GBAFE_DEBUG_PRINT_H

#include "common.h"

void DebugBgFontInit(int bgIndex, unsigned gfxTileBase); //! FE8U = 0x800378D
void DebugBgPrint(u16* target, const char* string); //! FE8U = 0x8003805
void DebugObjFontInit(int gfxObjTileBase, unsigned objPalIndex); //! FE8U = 0x8003B25
void DebugObjPrint(int x, int y, const char* string); //! FE8U = 0x8003BB1
void DebugObjPrintNumber(int x, int y, unsigned Number, unsigned DigitCount); //! FE8U = 0x8003BFD
void DebugObjPrintNumberHex(int x, int y, unsigned Number, unsigned DigitCount); //! FE8U = 0x8003C21

#endif // GBAFE_DEBUG_PRINT_H
