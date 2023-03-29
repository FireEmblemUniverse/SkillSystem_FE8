#ifndef GBA_TYPES_INCLUDED
#define GBA_TYPES_INCLUDED

#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#ifdef __cplusplus
#  define noreturn
#else
#  include <stdnoreturn.h>
#endif

typedef uint8_t   u8;
typedef uint16_t u16;
typedef uint32_t u32;
typedef uint64_t u64;
typedef int8_t    s8;
typedef int16_t  s16;
typedef int32_t  s32;
typedef int64_t  s64;

typedef volatile u8   vu8;
typedef volatile u16 vu16;
typedef volatile u32 vu32;
typedef volatile u64 vu64;
typedef volatile s8   vs8;
typedef volatile s16 vs16;
typedef volatile s32 vs32;
typedef volatile s64 vs64;

struct DispControl
{
    unsigned bgMode : 3;
    unsigned : 1; // cgbMode
    unsigned bmpFrameNum : 1;
    unsigned hblankIntervalFree : 1;
    unsigned obj1dMap : 1;
    unsigned forcedBlank : 1;
    unsigned enableBg0 : 1;
    unsigned enableBg1 : 1;
    unsigned enableBg2 : 1;
    unsigned enableBg3 : 1;
    unsigned enableObj : 1;
    unsigned enableWin0 : 1;
    unsigned enableWin1 : 1;
    unsigned enableObjWin : 1;
};

struct DispStat
{
    unsigned vblank : 1;
    unsigned hblank : 1;
    unsigned vcount : 1;
    unsigned vblankIrqEnable : 1;
    unsigned hblankIrqEnable : 1;
    unsigned vcountIrqEnable : 1;
    unsigned : 2;
    unsigned vcountCompare : 8;
};

struct BgControl
{
    unsigned priority : 2;
    unsigned tileBaseBlock : 2;
    unsigned : 2;
    unsigned mosaic : 1;
    unsigned colorMode : 1;
    unsigned mapBaseBlock : 5;
    unsigned areaOverflowMode : 1;
    unsigned screenSize : 2;
};

struct WinControl
{
    unsigned win0_enableBg0 : 1;
    unsigned win0_enableBg1 : 1;
    unsigned win0_enableBg2 : 1;
    unsigned win0_enableBg3 : 1;
    unsigned win0_enableObj : 1;
    unsigned win0_enableBlend : 1;
    unsigned : 2;

    unsigned win1_enableBg0 : 1;
    unsigned win1_enableBg1 : 1;
    unsigned win1_enableBg2 : 1;
    unsigned win1_enableBg3 : 1;
    unsigned win1_enableObj : 1;
    unsigned win1_enableBlend : 1;
    unsigned : 2;

    unsigned wout_enableBg0 : 1;
    unsigned wout_enableBg1 : 1;
    unsigned wout_enableBg2 : 1;
    unsigned wout_enableBg3 : 1;
    unsigned wout_enableObj : 1;
    unsigned wout_enableBlend : 1;
    unsigned : 2;

    unsigned wobj_enableBg0 : 1;
    unsigned wobj_enableBg1 : 1;
    unsigned wobj_enableBg2 : 1;
    unsigned wobj_enableBg3 : 1;
    unsigned wobj_enableObj : 1;
    unsigned wobj_enableBlend : 1;
    unsigned : 2;
};

struct BlendControl
{
    unsigned target1_enableBg0 : 1;
    unsigned target1_enableBg1 : 1;
    unsigned target1_enableBg2 : 1;
    unsigned target1_enableBg3 : 1;
    unsigned target1_enableObj : 1;
    unsigned target1_backdrop : 1;

    unsigned effect : 2;

    unsigned target2_enableBg0 : 1;
    unsigned target2_enableBg1 : 1;
    unsigned target2_enableBg2 : 1;
    unsigned target2_enableBg3 : 1;
    unsigned target2_enableObj : 1;
    unsigned target2_backdrop : 1;

    unsigned : 2;
};

struct BlendAlpha
{
    unsigned eva : 5;
    unsigned : 3;
    unsigned evb : 5;
    unsigned : 3;
};

struct KeyControl
{
    unsigned keys : 14;
    unsigned enable : 1;
    unsigned condition : 1;
};

// Multi-player SIO Control Structure
struct SioMultiControl
{
    u16 baudRate:2;    // baud rate
    u16 si:1;          // SI terminal
    u16 sd:1;          // SD terminal
    u16 id:2;          // ID
    u16 error:1;       // error flag
    u16 enable:1;      // SIO enable
    u16 unused_11_8:4;
    u16 mode:2;        // communication mode (should equal 2)
    u16 intrEnable:1;  // IRQ enable
    u16 unused_15:1;
    u16 data;          // data
};

#define ST_SIO_MULTI_MODE 2 // Multi-player communication mode

// baud rate
#define ST_SIO_9600_BPS   0 //   9600 bps
#define ST_SIO_38400_BPS  1 //  38400 bps
#define ST_SIO_57600_BPS  2 //  57600 bps
#define ST_SIO_115200_BPS 3 // 115200 bps

struct WaitControl
{
    unsigned sramWait : 2;

    unsigned ws0WaitFirst : 2;
    unsigned ws0WaitSecond : 1;

    unsigned ws1WaitFirst : 2;
    unsigned ws1WaitSecond : 1;

    unsigned ws2WaitFirst : 2;
    unsigned ws2WaitSecond : 1;

    unsigned phi : 2;
    unsigned : 1;

    unsigned prefetch : 1;
    unsigned gamepakType : 1;
};

enum
{
    WAIT_FIRST_4CYCLES = 0,
    WAIT_FIRST_3CYCLES = 1,
    WAIT_FIRST_2CYCLES = 2,
    WAIT_FIRST_8CYCLES = 3,
};

enum
{
    WAIT_SECOND_XCYCLES = 0,
    WAIT_SECOND_1CYCLES = 1,
};

struct BgAffine
{
    u16 pa;
    u16 pb;
    u16 pc;
    u16 pd;
    u32 x;
    u32 y;
};

// For use with BitUnPack
struct BitUnPackInfo
{
    unsigned sourceLength : 16;
    unsigned widthSource : 8; // 1, 2, 4, 8
    unsigned widthDest : 8; // 1, 2, 4, 8, 16, 32
    unsigned addend : 31;
    unsigned addToZero : 1;
};

// Key masks
enum
{
    KEY_BUTTON_A      = (1 << 0),
    KEY_BUTTON_B      = (1 << 1),
    KEY_BUTTON_START  = (1 << 2),
    KEY_BUTTON_SELECT = (1 << 3),
    KEY_DPAD_RIGHT    = (1 << 4),
    KEY_DPAD_LEFT     = (1 << 5),
    KEY_DPAD_UP       = (1 << 6),
    KEY_DPAD_DOWN     = (1 << 7),
    KEY_BUTTON_R      = (1 << 8),
    KEY_BUTTON_L      = (1 << 9),
};

// Interrupt masks
enum
{
    INTERRUPT_VBLANK = (1 << 0),
    INTERRUPT_HBLANK = (1 << 1),
    INTERRUPT_VCOUNT = (1 << 2),
    INTERRUPT_TIMER0 = (1 << 3),
    INTERRUPT_TIMER1 = (1 << 4),
    INTERRUPT_TIMER2 = (1 << 5),
    INTERRUPT_TIMER3 = (1 << 6),
    INTERRUPT_SIO    = (1 << 7),
    INTERRUPT_DMA0   = (1 << 8),
    INTERRUPT_DMA1   = (1 << 9),
    INTERRUPT_DMA2   = (1 << 10),
    INTERRUPT_DMA3   = (1 << 11),
    INTERRUPT_KEYPAD = (1 << 12),
    INTERRUPT_13     = (1 << 13),
};

// Utility types

struct Vec2   { short          x, y; };
struct Vec2l  { int            x, y; };
struct Vec2u  { unsigned short x, y; };
struct Vec2lu { unsigned       x, y; };

#endif // GBA_TYPES_INCLUDED
