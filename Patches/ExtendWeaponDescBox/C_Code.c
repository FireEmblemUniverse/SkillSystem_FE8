#include "C_Code.h"

struct SpriteEntry
{
    /* 00 */ struct SpriteEntry * next;
    /* 04 */ s16 oam1;
    /* 06 */ s16 oam0;
    /* 08 */ u16 oam2;
    /* 0A */ // pad
    /* 0C */ const u16 * object;
};

extern struct SpriteEntry sSpritePool[0x80];
extern struct SpriteEntry * gSpriteAllocIt;
extern struct SpriteEntry sSpriteLayers[0x10];

// 02029d8c b sSpritePool	/home/runner/work/fireemblem8u/fireemblem8u/src/ctc.c:132
// 0202a58c b sSpriteLayers	/home/runner/work/fireemblem8u/fireemblem8u/src/ctc.c:133
// 03004970 B gSpriteAllocIt

void PutSprite(int layer, int x, int y, const u16 * object, int oam2)
{
    // Max 128 sprites
    if ((u32)gSpriteAllocIt >= (u32)&sSpriteLayers[0]) // ensure no buffer overflow
    {
        return;
    }

    gSpriteAllocIt->next = sSpriteLayers[layer].next;
    gSpriteAllocIt->oam1 = x & 0x1FF;
    gSpriteAllocIt->oam0 = y & 0xFF;
    gSpriteAllocIt->oam2 = oam2;
    gSpriteAllocIt->object = object;

    sSpriteLayers[layer].next = gSpriteAllocIt++;
}

void PutSpriteExt(int layer, int xOam1, int yOam0, const u16 * object, int oam2)
{
    // Max 128 sprites
    if ((u32)gSpriteAllocIt >= (u32)&sSpriteLayers[0]) // ensure no buffer overflow
    {
        return;
    }
    gSpriteAllocIt->next = sSpriteLayers[layer].next;
    gSpriteAllocIt->oam1 = xOam1;
    gSpriteAllocIt->oam0 = yOam0;
    gSpriteAllocIt->oam2 = oam2;
    gSpriteAllocIt->object = object;

    sSpriteLayers[layer].next = gSpriteAllocIt++;
}
