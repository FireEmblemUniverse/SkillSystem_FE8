#ifndef __SOAR_H__
#define __SOAR_H__

#include "params.h"

#define __PAGEFLIP__ //remove to show draw
#define __ALWAYS_MOVE__
#define __FPSCOUNT__ //remove to hide fps counter


#define m7_screenbase 0x17
#define m7_charbase 2
#define CHARBLOCK(num) VRAM+(num * 0x4000)
#define SCRBLOCK(num) VRAM+(num*0x800)

#define FPS_COUNTER *(int*)(0x203fff8)
#define FPS_CURRENT *(int*)(0x203fffc)


#define MIN_Z_DISTANCE 24
#define MAX_Z_DISTANCE 512
#define SHADOW_DISTANCE MIN_Z_DISTANCE+16
#define FOG_DISTANCE (MAX_Z_DISTANCE>>1)
#define NUM_ALTITUDES 16
#define MAP_DIMENSIONS 1024
#define MAP_DIMENSIONS_LOG2 10
#define MAP_YOFS 0
#define INC_ZSTEP ((zdist>>6)+(zdist>>7)+((zdist>>8)<<2)+2)

#define SKY_COLOUR 0x7f0f
#define SEA_COLOUR 0x1840
#define SEA_COLOUR_SUNSET 0x0820

#define R_MASK(clr) (clr & 0b11111)
#define G_MASK(clr) (clr>>5)&0b11111
#define B_MASK(clr) (clr>>10)&0b11111

#define CEL_SHADE_THRESHOLD 6

#define g_yBuffer *((volatile u8*)(0x5000000)) //using the palette buffer lmao
#define gCurrentMusic *(volatile u16*)(0x2024e60) //currently playing music

#define VID_FLIP 0xa000 //page buffers
#define DCNT_PAGE 0x10

#define OAM_ATTR2(tile_id, prio, pal) ((0x200 + tile_id) | (prio<<0xA) | (pal<<0xC))

#define MOVEMENT_STEP 4

#define FREE_WRAM 0x3007000 //i sure hope this is free lol it's between the heap and the stack

#define WM_CURSOR ((volatile int*)(0x3005288)) //[0] is x<<8 and [1] is y<<8

extern const u16 colourMap[];
extern const u16 colourMap_sunset[];
extern const u8 heightMap[];
extern const u16 xMatrix[];
extern const u8 hosTables[12][0x100][0x100]; 
extern const void* pkSprite;
extern const void* pkSpriteF;
extern const void* locationSprites;
extern const void* locationPal;
extern const void* pkPal;
extern const void* pkPalF;
extern const void* minimapSprite;
extern const void* minimapPal;
extern const void* miniCursorSprite;
extern const void* miniCursorPal;
extern const void* fpsSprite;
extern const void* lensFlareSprite;
extern const void* lensFlarePal;
extern const int* SkyBG;
extern const int* SkyBG_lighter;
extern const int* SkyBG_darker;
extern const int* SkyBG_sunset;
extern const s16 pleftmatrix[0x10][MAX_Z_DISTANCE];
extern const int skies[5];
extern const u16 fogClrs[5];

extern const u16 gObj_32x8[3];
extern const u16 gObj_64x64[3];
extern const u16 gObj_aff32x32[3];
extern const u8 WorldMapNodes[16][16];
extern const u8 translatedLocations[];

#define sizeofPKSprite 64
#define sizeofLocationSprites 128
#define sizeofCursorSprite 16
#define sizeofMinimapSprite 64
#define sizeofFPSSprite 32
#define sizeofLensFlareSprite 16

#define PKBaseTID 0
#define LocationBaseTID PKBaseTID+sizeofPKSprite
#define CursorBaseTID LocationBaseTID+sizeofLocationSprites
#define MinimapBaseTID CursorBaseTID+sizeofCursorSprite
#define FPSBaseTID MinimapBaseTID+sizeofMinimapSprite
#define LensFlareBaseTID FPSBaseTID+sizeofFPSSprite

//from tonc
// tile 8x8@4bpp: 32bytes; 8 ints
typedef struct { u32 data[8];  } TILE, TILE4;
// d-tile: double-sized tile (8bpp)
typedef struct { u32 data[16]; } TILE8;
// tile block: 32x16 tiles, 16x16 d-tiles
typedef TILE  CHARBLOCK[512];
typedef TILE8 CHARBLOCK8[256];
#define pal_obj_mem 0x5000200

#define tile_mem  ( (CHARBLOCK*)0x06000000)
#define tile8_mem ((CHARBLOCK8*)0x06000000)

#define DX_TABLE(step) {            \
  step *0,                           \
  step *0.38,                        \
  step *0.71,                        \
  step *0.92,                        \
  step *1,                           \
  step *0.92,                        \
  step *0.71,                        \
  step *0.38,                        \
  step *0,                           \
  step *-0.38,                       \
  step *-0.71,                       \
  step *-0.92,                       \
  step *-1,                          \
  step *-0.92,                       \
  step *-0.71,                       \
  step *-0.38                        \
}

#define DY_TABLE(step) {            \
  step *-1,                         \
  step *-0.92,                      \
  step *-0.71,                      \
  step *-0.38,                      \
  step *0,                          \
  step *0.38,                       \
  step *0.71,                       \
  step *0.92,                       \
  step *1,                          \
  step *0.92,                       \
  step *0.71,                       \
  step *0.38,                       \
  step *0,                          \
  step *-0.38,                      \
  step *-0.71,                      \
  step *-0.92                       \
}

extern const s16 cam_dx_Angles[16];
extern const s16 cam_dy_Angles[16];
extern const s16 cam_pivot_dx_Angles[16];
extern const s16 cam_pivot_dy_Angles[16];

typedef struct SoarProc SoarProc;

struct SoarProc { //so we can store this info locally.
	PROC_FIELDS;
	int sPlayerPosX;
	int sPlayerPosY;
	int sPlayerPosZ;
  int sPlayerStepZ;
	int sPlayerYaw;
	u16* vid_page;
  s8 sunTransition;
  u8 ShowMap:1;
  u8 ShowFPS: 1;
  u8 takeOffTransition: 1;
  u8 landingTransition: 1;
  u8 disableFlare: 1;
  u8 turningCooldown: 2; 
  u8 unused:1;
  s8 oceanOffset;
  u8 oceanClock;
  int sFocusPtX;
  int sFocusPtY;
  int location;
  int sunsetVal;
};

typedef struct Point Point;

struct Point {
	int x;
	int y;
};


//16 possible angles for yaw
enum Angles{
  a_N,
  a_NNE,
  a_NE,
  a_ENE,
  a_E,
  a_ESE,
  a_SE,
  a_SSE,
  a_S,
  a_SSW,
  a_SW,
  a_WSW,
  a_W,
  a_WNW,
  a_NW,
  a_NNW
};

enum BumpDirs{
  bump_up,
  bump_down,
  bump_left,
  bump_right,
  bump_fwd,
  bump_back
};

void NewWMLoop(SoarProc* CurrentProc);
int thumb_loop(SoarProc* CurrentProc);
static inline int getPtHeight_thumb(int ptx, int pty);

static inline void DrawVerticalLine(int xcoord, int ystart, int ylen, u16 color, u16* vid_page);
static inline u8 getScrHeight(int ptx, int pty, int altitude, int zdist);
static inline u8 getPtHeight(int ptx, int pty);
static inline u16 getPointColour(int ptx, int pty, int sunsetVal);
static inline Point getPLeft(int camera_x, int camera_y, int angle, int zdist);
static inline void Render(SoarProc* CurrentProc);
static inline void UpdateSprites(SoarProc* CurrentProc);
void NewFadeOut(int time);
void LoadSprite();
void EndLoop(SoarProc* CurrentProc);
void MoveLord(SoarProc* CurrentProc);
void OnVBlankMain();
void BumpScreen(int direction);
#endif