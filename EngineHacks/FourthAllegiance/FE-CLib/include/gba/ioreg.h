#ifndef GUARD_GBA_IO_REG_H
#define GUARD_GBA_IO_REG_H

#include "types.h"

enum
{
    IO_ADDR_DISPCNT  = 0x4000000,
    IO_ADDR_DISPSTAT = 0x4000004,
    IO_ADDR_VCOUNT   = 0x4000006,
    IO_ADDR_BG0CNT   = 0x4000008,
    IO_ADDR_BG1CNT   = 0x400000A,
    IO_ADDR_BG2CNT   = 0x400000C,
    IO_ADDR_BG3CNT   = 0x400000E,
    IO_ADDR_BG0HOFS  = 0x4000010,
    IO_ADDR_BG0VOFS  = 0x4000012,
    IO_ADDR_BG1HOFS  = 0x4000014,
    IO_ADDR_BG1VOFS  = 0x4000016,
    IO_ADDR_BG2HOFS  = 0x4000018,
    IO_ADDR_BG2VOFS  = 0x400001A,
    IO_ADDR_BG3HOFS  = 0x400001C,
    IO_ADDR_BG3VOFS  = 0x400001E,
    IO_ADDR_BG2PA    = 0x4000020,
    IO_ADDR_BG2PB    = 0x4000022,
    IO_ADDR_BG2PC    = 0x4000024,
    IO_ADDR_BG2PD    = 0x4000026,
    IO_ADDR_BG2X     = 0x4000028,
    IO_ADDR_BG2Y     = 0x400002C,
    IO_ADDR_BG3PA    = 0x4000030,
    IO_ADDR_BG3PB    = 0x4000032,
    IO_ADDR_BG3PC    = 0x4000034,
    IO_ADDR_BG3PD    = 0x4000036,
    IO_ADDR_BG3X     = 0x4000038,
    IO_ADDR_BG3Y     = 0x400003C,

    // TODO: win io

    IO_ADDR_MOSAIC   = 0x400004C,
    IO_ADDR_BLDCNT   = 0x4000050,
    IO_ADDR_BLDALPHA = 0x4000052,
    IO_ADDR_BLDY     = 0x4000054,

    // TODO: sound io
    // TODO: dma io
    // TODO: timer io
    // TODO: sio io

    IO_ADDR_KEYINPUT = 0x4000130,
    IO_ADDR_KEYCNT   = 0x4000132,

    // TODO: more sio io

    IO_ADDR_IE       = 0x4000200,
    IO_ADDR_IF       = 0x4000202,
    IO_ADDR_WAITCNT  = 0x4000204,
    IO_ADDR_IME      = 0x4000208,
};

#define DISPCNT  (*(struct DispControl*) (IO_ADDR_DISPCNT))
#define DISPSTAT (*(struct DispStat*)    (IO_ADDR_DISPSTAT))
#define VCOUNT   (*(u16*)                (IO_ADDR_VCOUNT))
#define BG0CNT   (*(struct BgControl*)   (IO_ADDR_BG0CNT))
#define BG1CNT   (*(struct BgControl*)   (IO_ADDR_BG1CNT))
#define BG2CNT   (*(struct BgControl*)   (IO_ADDR_BG2CNT))
#define BG3CNT   (*(struct BgControl*)   (IO_ADDR_BG3CNT))
#define BG0HOFS  (*(u16*)                (IO_ADDR_BG0HOFS))
#define BG0VOFS  (*(u16*)                (IO_ADDR_BG0VOFS))
#define BG1HOFS  (*(u16*)                (IO_ADDR_BG1HOFS))
#define BG1VOFS  (*(u16*)                (IO_ADDR_BG1VOFS))
#define BG2HOFS  (*(u16*)                (IO_ADDR_BG2HOFS))
#define BG2VOFS  (*(u16*)                (IO_ADDR_BG2VOFS))
#define BG3HOFS  (*(u16*)                (IO_ADDR_BG3HOFS))
#define BG3VOFS  (*(u16*)                (IO_ADDR_BG3VOFS))
#define BG2PA    (*(u16*)                (IO_ADDR_BG2PA)) // TODO: better type
#define BG2PB    (*(u16*)                (IO_ADDR_BG2PB)) // TODO: better type
#define BG2PC    (*(u16*)                (IO_ADDR_BG2PC)) // TODO: better type
#define BG2PD    (*(u16*)                (IO_ADDR_BG2PD)) // TODO: better type
#define BG2X     (*(u32*)                (IO_ADDR_BG2X))  // TODO: better type
#define BG2Y     (*(u32*)                (IO_ADDR_BG2Y))  // TODO: better type
#define BG3PA    (*(u16*)                (IO_ADDR_BG3PA)) // TODO: better type
#define BG3PB    (*(u16*)                (IO_ADDR_BG3PB)) // TODO: better type
#define BG3PC    (*(u16*)                (IO_ADDR_BG3PC)) // TODO: better type
#define BG3PD    (*(u16*)                (IO_ADDR_BG3PD)) // TODO: better type
#define BG3X     (*(u32*)                (IO_ADDR_BG3X))  // TODO: better type
#define BG3Y     (*(u32*)                (IO_ADDR_BG3Y))  // TODO: better type

// TODO: win io

#define MOSAIC   (*(struct MosaicConfig*)(IO_ADDR_MOSAIC))
#define BLDCNT   (*(struct BlendControl*)(IO_ADDR_BLDCNT))
#define BLDALPHA (*(struct BlendAlpha*)  (IO_ADDR_BLDALPHA))
#define BLDY     (*(u16*)                (IO_ADDR_BLDY))

// TODO: sound io
// TODO: dma io
// TODO: timer io
// TODO: sio io

#define KEYINPUT (*(u16*)                (IO_ADDR_KEYINPUT))
#define KEYCNT   (*(struct KeyControl*)  (IO_ADDR_KEYCNT))

// TODO: more sio io

#define IE       (*(u16*)                (IO_ADDR_IE))
#define IF       (*(u16*)                (IO_ADDR_IF))
#define WAITCNT  (*(struct WaitControl*) (IO_ADDR_WAITCNT))
#define IME      (*(u16*)                (IO_ADDR_IME))

// HELPERS

#define BG0OFFSET (*(struct Vec2u*)   (IO_ADDR_BG0HOFS))
#define BG1OFFSET (*(struct Vec2u*)   (IO_ADDR_BG1HOFS))
#define BG2OFFSET (*(struct Vec2u*)   (IO_ADDR_BG2HOFS))
#define BG3OFFSET (*(struct Vec2u*)   (IO_ADDR_BG3HOFS))

#define BG2AFFINE (*(struct BgAffine*)(IO_ADDR_BG2PA))
#define BG3AFFINE (*(struct BgAffine*)(IO_ADDR_BG3PA))

#endif // GUARD_GBA_IO_REG_H
