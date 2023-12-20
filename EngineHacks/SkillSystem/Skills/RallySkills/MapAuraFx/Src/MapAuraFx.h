#ifndef MAP_AURA_FX_INCLUDED
#define MAP_AURA_FX_INCLUDED

#include "gbafe.h"

#define TILEMAP_INDEX(aX, aY) (0x20 * (aY) + (aX))
#define TILEMAP_LOCATED(aMap, aX, aY) (TILEMAP_INDEX((aX), (aY)) + (aMap))
#define BG_LOCATED_TILE(aMap, aX, aY) ((aMap)[(aX) + (aY) * 0x20])

void StartMapAuraFx(void);
void EndMapAuraFx(void);
int  IsMapAuraFxActive(void);
void SetMapAuraFxSpeed(int speed);
void SetMapAuraFxBlend(unsigned blend);
void SetMapAuraFxPalette(const u16 palette[]);
void AddMapAuraFxUnit(struct Unit* unit);

#endif // MAP_AURA_FX_INCLUDED
