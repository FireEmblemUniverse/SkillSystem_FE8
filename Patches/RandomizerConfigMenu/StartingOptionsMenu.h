
#include "gbafe.h"

typedef struct {
  Proc Header;
  u8 Page;
  u8 CursorIndex;
  u8 LastCursorIndex;
  s8 Option[8];

  //more options here
} OptionsProc;

// Temporarily save via a proc until the game starts 
typedef struct {
  Proc Header;
  u16 FlagOn[20];
} OptionsSavedProc;

void SaveStartingOptionsLoop(OptionsSavedProc* CurrentProc);
void StartingOptionsSetup(OptionsProc* CurrentProc);
void updateOptionsPage(OptionsProc* CurrentProc);
void StartingOptionsLoop(OptionsProc* CurrentProc);
void GenerateBGTsa(u16 *MapOffset, u32 NumberOfTiles, u8 PaletteId, u16 baseTile);
void SetOptionFlagsASMC();
void SaveOptionsData(void* target, unsigned size);
void LoadOptionsData(void* source, unsigned size);

extern void BG_Fill(void *dest, int b);

extern u8 CasualModeFlagLink;

extern u8 FixedGrowthsFlagLink;
extern u8 ZeroGrowthsFlagLink;
extern u8 PerfectGrowthsFlagLink;

extern u8 OneRNFlagLink;
extern u8 FatesRNFlagLink;
extern u8 EvilRNFlagLink;
extern u8 PerfectHitFlagLink;
extern u8 NiceRNGFlagLink;
extern u8 CoinTossRNGFlagLink;

extern int SpinRoutine1;
extern int SpinRoutine2;

extern void EnableAllGfx();
extern void NewFadeIn();
extern void NewFadeOut();
extern void FadeInExists();
extern void FadeOutExists();
extern void SetEventId(u8 flagID);
extern void UnsetEventId(u8 flagID);
extern void Font_ResetAllocation();
extern void LZ77UnCompVram();
//extern const SpinProc[];
extern void nullsub_64();


#define BGLoc(BGOffset, x, y) (void*)(BGOffset + 0x2 * x + 0x40 * y)
#define BG0Buffer (void*)0x02022CA8
#define BG1Buffer (void*)0x020234A8
#define BG2Buffer (void*)0x02023CA8
#define BG3Buffer (void*)0x020244A8 
#define BG0Offset (void*)0x6006000
#define gColorSpecialEffectsSelectionBuffer (u16*) 0x030030BC
#define gBg1ControlBuffer (u16*) 0x03003090
#define SoundRoomTable ((struct SoundRoomData*) 0x8A20E74)
#define SetFont ((void (*)(u32 fontStructPointer))(0x8003D38+1))
#define LoadFontUI ((void (*))(0x80043A8+1))
#define InitDefaultFont ((void (*)())(0x8003C94+1))
#define InitText ((void (*)(int TextStruct, int TextTileWidth))(0x8003D5C+1))
#define ClearText ((void (*)(int TextStruct))(0x08003DC8+1))
#define PrintInline ((void (*)(int TextStruct, int TilePointerRoot, int ColorID, int localX, int TileWidth, char *Text))(0x0800443C+1))
#define UncompTID ((void (*)(u16 TID, char *Buffer))(0x800A280+1))
#define UpdateBG3HOffset ((void (*)())(0x8086B7C+1))
#define CursorMaxIndex (sizeof(CursorLocationTable)/sizeof(CursorLocationTable[0]))-1
#define thisPage CurrentProc->Page
#define newInput sInput->newPress

#define sInput ((InputBuffer*)0x2024CC0)

#define InputA 0x1
#define InputB 0x2
#define InputSelect 0x4
#define InputStart 0x8
#define InputRight 0x10
#define InputLeft 0x20
#define InputUp 0x40
#define InputDown 0x80
#define InputR 0x100
#define InputL 0x200

typedef struct {
	u8 firstTickDelay;
	u8 nextTickDelay;
	u8 tickDownCounter;
	u8 pad1;
	u16 currentPress;
	u16 tickPress;
	u16 newPress;
	u16 previousPress;
	u16 lastPressState;
	u16 releasedPress;
	u16 newPress2;
	u16 timeSinceLastStartSelect;
} InputBuffer;

typedef struct {
  u32 x;
  u32 y;
} LocationTable;

typedef struct {
	u8 CasualMode;
	u8 GrowthSetting;
	u8 RNGSetting;
  
} OptionsStruct;

static OptionsStruct* const OptionsSaved = (OptionsStruct* const) (0x3005265); //last 4 bytes of event ids (unused)
