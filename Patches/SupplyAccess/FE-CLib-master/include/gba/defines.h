#ifndef GUARD_GBA_DEFINES
#define GUARD_GBA_DEFINES

#include "types.h"

#define TRUE  1
#define FALSE 0

#define PLTT ((unsigned char*)(0x5000000))
#define VRAM ((unsigned char*)(0x6000000))
#define OAM  ((unsigned char*)(0x7000000))

#define VRAM_BG_CHAR_ADDR(n)   (VRAM + (0x4000 * (n)))
#define VRAM_BG_SCREEN_ADDR(n) (VRAM + (0x800 * (n)))
#define VRAM_BG_TILE_ADDR(n)   (VRAM + (0x80 * (n)))

#define VRAM_OBJ (VRAM + 0x10000)

#define COLOR_RGB(r, g, b) (((r) & 0x1F) + (((g) & 0x1F) << 5) + (((b) & 0x1F) << 10))

#define COLOR_WHITE COLOR_RGB(31, 31, 31)
#define COLOR_BLACK COLOR_RGB(0,  0,  0)

#endif // GUARD_GBA_DEFINES
