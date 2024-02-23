
#include "gbafe.h"

void LiteralTelephone(struct Proc* parentProc);

extern u8 TelephoneChance;
extern const u32 TelephoneEvent;

extern int callGfx1[0x1400];
extern int callGfx2[0x1400];
extern const u16 callPal;

#define PaletteBuffer(x,y) gPaletteBuffer[0x20*y + x]