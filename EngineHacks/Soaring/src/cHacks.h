#ifndef __CHACKSH__
#define __CHACKSH__

#pragma long_calls

#include "libgbafe/gbafe.h"

//from tonc
  typedef u16 COLOR;

  #define INLINE static inline
  #define MEM_IO      0x04000000
  #define MEM_VRAM    0x06000000
  #define REG_DISPCNT     *((volatile u32*)(MEM_IO+0x0000))
  #define g_LCDIOBuffer   (*(vu16 *)0x3003080)
  #define g_REG_BG2CNT (*(vu16 *)(0x3003094))
  #define g_REG_BG2PA  (*(vu16 *)(0x30030c8))
  #define g_REG_BG2PB  (*(vu16 *)(0x30030ca))
  #define g_REG_BG2PC  (*(vu16 *)(0x30030cc))
  #define g_REG_BG2PD  (*(vu16 *)(0x30030ce))
  #define g_REG_BG2X   (*(vu32 *)(0x30030d0))
  #define g_REG_BG2X_L (*(vu16 *)(0x30030d0))
  #define g_REG_BG2X_H (*(vu16 *)(0x30030d2))
  #define g_REG_BG2Y   (*(vu32 *)(0x30030d4))
  #define g_REG_BG2Y_L (*(vu16 *)(0x30030d4))
  #define g_REG_BG2Y_H (*(vu16 *)(0x30030d6))
  // --- REG_DISPCNT defines ---
  #define DCNT_MODE0      0x0000
  #define DCNT_MODE1      0x0001
  #define DCNT_MODE2      0x0002
  #define DCNT_MODE3      0x0003
  #define DCNT_MODE4      0x0004
  #define DCNT_MODE5      0x0005
  // layers
  #define DCNT_BG0        0x0100
  #define DCNT_BG1        0x0200
  #define DCNT_BG2        0x0400
  #define DCNT_BG3        0x0800
  #define DCNT_OBJ        0x1000

  #define SCREEN_WIDTH   240
  #define SCREEN_HEIGHT  160

  #define vid_mem     ((u16*)MEM_VRAM)

  INLINE void m3_plot(int x, int y, COLOR clr)
  {   vid_mem[y*SCREEN_WIDTH+x]= clr;    }

  #define CLR_BLACK   0x0000
  #define CLR_RED     0x001F
  #define CLR_LIME    0x03E0
  #define CLR_YELLOW  0x03FF
  #define CLR_BLUE    0x7C00
  #define CLR_MAG     0x7C1F
  #define CLR_CYAN    0x7FE0
  #define CLR_WHITE   0x7FFF


  INLINE COLOR RGB15(u32 red, u32 green, u32 blue)
  {   return red | (green<<5) | (blue<<10);   }


//fixed point
#define Q_8_8(iPart, fPart) (((iPart) << 8) | (fPart))
#define IPART(n) ((n) >> 8)
#define FPART(n) ((n) & 0xFFFF)

//declare functions
void CreateNewWorldMap();
void NewWMLoop();
void NewFadeIn(int duration);
bool FadeInExists();
void SetUpNewWMGraphics();
void m7HblCallBack();
void m7VblCallBack();
int SoarUsability();
void SoarEffect();


#pragma long_calls_off

#endif