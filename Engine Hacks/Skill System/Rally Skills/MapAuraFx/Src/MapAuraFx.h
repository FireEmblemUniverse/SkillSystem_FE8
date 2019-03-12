#ifndef MAP_AURA_FX_INCLUDED
#define MAP_AURA_FX_INCLUDED

#include "gbafe.h"

void StartMapAuraFx(void);
void EndMapAuraFx(void);
int  IsMapAuraFxActive(void);
void SetMapAuraFxSpeed(int speed);
void SetMapAuraFxBlend(unsigned blend);
void SetMapAuraFxPalette(const u16 palette[]);
void AddMapAuraFxUnit(struct Unit* unit);

#endif // MAP_AURA_FX_INCLUDED
