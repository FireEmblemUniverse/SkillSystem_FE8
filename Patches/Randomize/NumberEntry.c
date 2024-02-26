#include "gbafe.h" // headers 

#define PUREFUNC __attribute__((pure))
#define ARMFUNC __attribute__((target("arm")))
int Div(int a, int b) PUREFUNC;
int Mod(int a, int b) PUREFUNC;
int DivArm(int b, int a) PUREFUNC;

//#define POKEMBLEM_VERSION 
#ifdef POKEMBLEM_VERSION 
extern u32* StartTimeSeedRamLabel; 
#endif 


typedef struct {
    /* 00 */ PROC_HEADER;
    /* 2C */ int seed;
	/* 30 */ u8 digit; 
} SeedMenuProc;

void SeedMenuLoop2(SeedMenuProc* proc); 
const struct ProcCmd SeedMenuProcCmd2[] =
{
    PROC_CALL(LockGame),
    PROC_CALL(BMapDispSuspend),
	PROC_CALL(StartFadeFromBlack), 

    PROC_YIELD,
	PROC_REPEAT(SeedMenuLoop2), 

    PROC_CALL(UnlockGame),
    PROC_CALL(BMapDispResume),
    PROC_END,
};

#define START_X 19
#define Y_HAND 11
typedef const struct {
  u32 x;
  u32 y;
} LocationTable;
LocationTable CursorLocationTable2[] = {
  {(START_X*8) - (0 * 8) - 4, Y_HAND*8},
  {(START_X*8) - (1 * 8) - 4, Y_HAND*8},
  {(START_X*8) - (2 * 8) - 4, Y_HAND*8},
  {(START_X*8) - (3 * 8) - 4, Y_HAND*8},
  {(START_X*8) - (4 * 8) - 4, Y_HAND*8},
  {(START_X*8) - (5 * 8) - 4, Y_HAND*8},
  {(START_X*8) - (6 * 8) - 4, Y_HAND*8}, 
  {(START_X*8) - (7 * 8) - 4, Y_HAND*8}, 
  {(START_X*8) - (8 * 8) - 4, Y_HAND*8}, 
};

const u32 DigitDecimalTable2[] = { 
1, 10, 100, 1000, 10000, 100000, 1000000, 10000000, 100000000
}; 

int GetMaxDigits2(int number) { 

	int result = 1; 
	while (number > DigitDecimalTable2[result]) { result++; } 
	//result++; // table is 0 indexed, but we count digits from 1 
	if (result > 9) { result = 9; } 
	return result; 

} 

extern void ChapterStatus_SetupFont(ProcPtr proc); 
void DrawSeedMenu2(SeedMenuProc* proc) { 

	

	//struct Text handle;
	//InitText(&handle, 10);
	TileMap_FillRect(gBG0TilemapBuffer + TILEMAP_INDEX(START_X-8, Y_HAND), 9, 2, 0);
	BG_EnableSyncByMask(BG0_SYNC_BIT);

	PutNumber(gBG0TilemapBuffer + TILEMAP_INDEX(START_X, Y_HAND), TEXT_COLOR_SYSTEM_GOLD, proc->seed); 

	BG_EnableSyncByMask(BG0_SYNC_BIT);

	//DrawTextInline(0, BGLoc(BG0Buffer, 2, 0), 4, 0, , string);

} 

extern char NumberTitle_Text; 
extern char NumberDesc_Text;

void StartSeedMenu2(ProcPtr parent) { 
	ClearBg0Bg1();
	//EnableBgSyncByIndex(0);
	SeedMenuProc* proc; 
	if (parent) { proc = (SeedMenuProc*)Proc_StartBlocking((ProcPtr)&SeedMenuProcCmd2, parent); } 
	else { proc = (SeedMenuProc*)Proc_Start((ProcPtr)&SeedMenuProcCmd2, PROC_TREE_3); } 
	if (proc) { 
		#ifdef POKEMBLEM_VERSION 
		proc->seed = *StartTimeSeedRamLabel; 
		#else 
		proc->seed = gEventSlots[1]; // initial seed 
		#endif 
		while (proc->seed > gEventSlots[3]) { proc->seed = proc->seed / 2; } // s3 as max 
		while (proc->seed < 0) { proc->seed = (proc->seed * 2)+1; } 
		if (proc->seed < gEventSlots[2]) { proc->seed = gEventSlots[2]; } // s2 as min 
		proc->digit = 0; 
		//ResetText();
		ResetTextFont();
		SetTextFontGlyphs(0);
//		ChapterStatus_SetupFont((void*)proc);

		BG_Fill(gBG0TilemapBuffer, 0);
		BG_EnableSyncByMask(BG0_SYNC_BIT);
		ResetTextFont();
		SetTextFontGlyphs(0);
		SetTextFont(0);
		DrawSeedMenu2(proc);
		
		#ifdef HARDCODE_TEXT
		char* string = "Game Seed"; 
		PutDrawText(NULL, gBG0TilemapBuffer + TILEMAP_INDEX(12,1), TEXT_COLOR_SYSTEM_GREEN, 0, (GetStringTextLen(string)+8)/8, string);
		string = "Match with a friend for the"; 
		PutDrawText(NULL, gBG0TilemapBuffer + TILEMAP_INDEX(8,4), TEXT_COLOR_SYSTEM_WHITE, 0, (GetStringTextLen(string)+8)/8, string);
		string = "same randomizer settings.";
		PutDrawText(NULL, gBG0TilemapBuffer + TILEMAP_INDEX(8,6), TEXT_COLOR_SYSTEM_WHITE, 2, (GetStringTextLen(string)+8)/8, string);
		#endif 
		#ifndef HARDCODE_TEXT 
		char* string = GetStringFromIndex(gEventSlots[4]); 
		PutDrawText(NULL, gBG0TilemapBuffer + TILEMAP_INDEX(12,1), TEXT_COLOR_SYSTEM_GREEN, 0, (GetStringTextLen(string)+8)/8, string);
		string = GetStringFromIndex(gEventSlots[5]); 
		PutDrawText(NULL, gBG0TilemapBuffer + TILEMAP_INDEX(8,4), TEXT_COLOR_SYSTEM_WHITE, 0, (GetStringTextLen(string)+8)/8, string);
		string = GetStringFromIndex(gEventSlots[6]); 
		PutDrawText(NULL, gBG0TilemapBuffer + TILEMAP_INDEX(8,6), TEXT_COLOR_SYSTEM_WHITE, 0, (GetStringTextLen(string)+8)/8, string);
		string = GetStringFromIndex(gEventSlots[7]); 
		PutDrawText(NULL, gBG0TilemapBuffer + TILEMAP_INDEX(8,8), TEXT_COLOR_SYSTEM_WHITE, 0, (GetStringTextLen(string)+8)/8, string);
		#endif 
		
		BG_EnableSyncByMask(BG0_SYNC_BIT);
		StartGreenText(proc); 
		
	} 
	
} 

const u16 sSprite_VertHand2[] = {
    1,
    0x0002, 0x4000, 0x0006
};
const u8 sHandVOffsetLookup2[] = {
    0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 2, 3, 3, 3, 3,
    4, 4, 4, 4, 4, 4, 4, 3, 3, 2, 2, 2, 1, 1, 1, 1,
};
extern int sPrevHandClockFrame; 
extern struct Vec2 sPrevHandScreenPosition; 
extern int sPrevHandClockFrame; 
void DisplayVertUiHand2(int x, int y)
{
    if ((GetGameClock() - 1) == sPrevHandClockFrame)
    {
        x = (x + sPrevHandScreenPosition.x) >> 1;
        y = (y + sPrevHandScreenPosition.y) >> 1;
    }

    sPrevHandScreenPosition.x = x;
    sPrevHandScreenPosition.y = y;
    sPrevHandClockFrame = GetGameClock();

    y += (sHandVOffsetLookup2[Mod(GetGameClock(), ARRAY_COUNT(sHandVOffsetLookup2))] - 14);
    PutSprite(2, x, y, sSprite_VertHand2, 0);
}

extern struct KeyStatusBuffer sKeyStatusBuffer;
void SeedMenuLoop2(SeedMenuProc* proc) { 

	DisplayVertUiHand2(CursorLocationTable2[proc->digit].x, CursorLocationTable2[proc->digit].y); // 6 is the tile of the downwards hand 	
	u16 keys = sKeyStatusBuffer.newKeys; 
	if (!keys) { keys = sKeyStatusBuffer.repeatedKeys; } 
	if ((keys & START_BUTTON)||(keys & A_BUTTON)) { //press A or Start to continue
		#ifdef POKEMBLEM_VERSION 
		*StartTimeSeedRamLabel = proc->seed; 
		#endif 
		gEventSlots[0xC] = proc->seed; 
		Proc_Break((ProcPtr)proc);
		m4aSongNumStart(0x6B); 
	};
	int max = gEventSlots[3]; 
	int min = gEventSlots[2]; 
	int max_digits = GetMaxDigits2(max); 
	
    if (keys & DPAD_RIGHT) {
      if (proc->digit > 0) { proc->digit--; }
      else { proc->digit = max_digits - 1; } 
	  DrawSeedMenu2(proc);
    }
    if (keys & DPAD_LEFT) {
      if (proc->digit < (max_digits-1)) { proc->digit++; }
      else { proc->digit = 0; } 
	  DrawSeedMenu2(proc);
    }
	
    if (keys & DPAD_UP) {
		if (proc->seed == max) { proc->seed = min; } 
		else { 
			proc->seed += DigitDecimalTable2[proc->digit]; 
			if (proc->seed > max) { proc->seed = max; } 
		} 
		DrawSeedMenu2(proc); 
	}
    if (keys & DPAD_DOWN) {
		
		if (proc->seed == min) { proc->seed = max; } 
		else { 
			proc->seed -= DigitDecimalTable2[proc->digit]; 
			if (proc->seed < min) { proc->seed = min; } 
		} 
		
		DrawSeedMenu2(proc); 
	}
} 
