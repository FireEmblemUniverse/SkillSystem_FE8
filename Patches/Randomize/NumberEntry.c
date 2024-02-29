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

static void SeedMenuLoop(SeedMenuProc* proc); 
const struct ProcCmd SeedMenuProcCmd[] =
{
    PROC_CALL(LockGame),
    PROC_CALL(BMapDispSuspend),
	PROC_CALL(StartFadeFromBlack), 

    PROC_YIELD,
	PROC_REPEAT(SeedMenuLoop), 

    PROC_CALL(UnlockGame),
    PROC_CALL(BMapDispResume),
    PROC_END,
};

#define START_X 19
#define Y_HAND 11
#define NUMBER_X 17
typedef const struct {
  u32 x;
  u32 y;
} LocationTable;
LocationTable CursorLocationTable[] = {
  {(NUMBER_X*8) - (0 * 8) - 4, Y_HAND*8},
  {(NUMBER_X*8) - (1 * 8) - 4, Y_HAND*8},
  {(NUMBER_X*8) - (2 * 8) - 4, Y_HAND*8},
  {(NUMBER_X*8) - (3 * 8) - 4, Y_HAND*8},
  {(NUMBER_X*8) - (4 * 8) - 4, Y_HAND*8},
  {(NUMBER_X*8) - (5 * 8) - 4, Y_HAND*8},
  {(NUMBER_X*8) - (6 * 8) - 4, Y_HAND*8}, 
  {(NUMBER_X*8) - (7 * 8) - 4, Y_HAND*8}, 
  {(NUMBER_X*8) - (8 * 8) - 4, Y_HAND*8}, 
};

const u32 DigitDecimalTable[] = { 
1, 10, 100, 1000, 10000, 100000, 1000000, 10000000, 100000000, 1000000000
}; 

static int GetMaxDigits(int number) { 

	int result = 1; 
	while (number > DigitDecimalTable[result]) { result++; } 
	//result++; // table is 0 indexed, but we count digits from 1 
	if (result > 9) { result = 9; } 
	return result; 

} 

extern void ChapterStatus_SetupFont(ProcPtr proc); 
static void DrawSeedMenu(SeedMenuProc* proc) { 

	

	//struct Text handle;
	//InitText(&handle, 10);
	TileMap_FillRect(gBG0TilemapBuffer + TILEMAP_INDEX(NUMBER_X-8, Y_HAND), 9, 2, 0);
	BG_EnableSyncByMask(BG0_SYNC_BIT);

	PutNumber(gBG0TilemapBuffer + TILEMAP_INDEX(NUMBER_X, Y_HAND), TEXT_COLOR_SYSTEM_GOLD, proc->seed); 

	BG_EnableSyncByMask(BG0_SYNC_BIT);

	//DrawTextInline(0, BGLoc(BG0Buffer, 2, 0), 4, 0, , string);

} 

extern char NumberTitle_Text; 
extern char NumberDesc_Text;




extern u16* bg_table[4]; // = {gBG0TilemapBuffer, gBG1TilemapBuffer, gBG2TilemapBuffer, gBG3TilemapBuffer}; 
//#define BG_SYNC_BIT(aBg) (1 << (aBg))
void InitMultiline(struct Text th[], int lines, int x, int y, int bg, int color, int textID); 
void PrepareMultiline(struct Text th[], int textID); 
void DrawMultiline(struct Text th[], int lines, int x, int y, int bg);
int CountTextIDLines(int textID); 
char *GetStrNextLine(char *str); 

void StartNumberEntry(ProcPtr parent) { 
	ClearBg0Bg1();
	//EnableBgSyncByIndex(0);
	SeedMenuProc* proc; 
	if (parent) { proc = (SeedMenuProc*)Proc_StartBlocking((ProcPtr)&SeedMenuProcCmd, parent); } 
	else { proc = (SeedMenuProc*)Proc_Start((ProcPtr)&SeedMenuProcCmd, PROC_TREE_3); } 
	if (proc) { 
		#ifdef POKEMBLEM_VERSION 
		proc->seed = *StartTimeSeedRamLabel; 
		#else 
		proc->seed = gEventSlots[1]; // initial seed 
		#endif 
		
		#ifdef POKEMBLEM_VERSION 
		proc->seed &= 0x2FFFFFFF;
		#else 
		while (proc->seed > gEventSlots[3]) { proc->seed = proc->seed / 2; } // s3 as max 
		while (proc->seed < 0) { proc->seed = (proc->seed * 2)+1; } 
		if (proc->seed < gEventSlots[2]) { proc->seed = gEventSlots[2]; } // s2 as min 
		#endif 
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
		
		
		#ifdef HARDCODE_TEXT
		char* string = "Game Seed"; 
		PutDrawText(NULL, gBG0TilemapBuffer + TILEMAP_INDEX(12,1), TEXT_COLOR_SYSTEM_GREEN, 0, (GetStringTextLen(string)+8)/8, string);
		string = "Match with a friend for the"; 
		PutDrawText(NULL, gBG0TilemapBuffer + TILEMAP_INDEX(8,4), TEXT_COLOR_SYSTEM_WHITE, 0, (GetStringTextLen(string)+8)/8, string);
		string = "same randomizer settings.";
		PutDrawText(NULL, gBG0TilemapBuffer + TILEMAP_INDEX(8,6), TEXT_COLOR_SYSTEM_WHITE, 2, (GetStringTextLen(string)+8)/8, string);
		#endif 
		
		//struct Text th[5] = NULL; 
		int lines, x, y, bg; 
		int textID[2]; 
		textID[0] = gEventSlots[5]; 
		textID[1] = gEventSlots[6]; 
		
		lines = CountTextIDLines(textID[0]); 
		x = 8; 
		y = 4; 
		bg = 0; 
		InitMultiline(0, lines, x, y, bg, TEXT_COLOR_SYSTEM_WHITE, textID[0]); // these functions do nothing if no text ID 
		InitMultiline(3, 3, x, y+10, bg, TEXT_COLOR_SYSTEM_WHITE, textID[1]); 
		PrepareMultiline(0, textID[0]); 
		PrepareMultiline(3, textID[1]); 
		DrawMultiline(0, lines, x, y, bg);
		lines = CountTextIDLines(textID[1]); 
		DrawMultiline(3, lines, x, y+10, bg);
		if (gEventSlots[4]) { 
			char* string = GetStringFromIndex(gEventSlots[4]); 
			PutDrawText(NULL, gBG0TilemapBuffer + TILEMAP_INDEX(12,1), TEXT_COLOR_SYSTEM_GREEN, 0, (GetStringTextLen(string)+8)/8, string);
		} 
		DrawSeedMenu(proc);
		
		//BG_EnableSyncByMask(BG0_SYNC_BIT);
		StartGreenText(proc); 
		
	} 
	
} 


void InitMultiline(struct Text th[], int lines, int x, int y, int bg, int color, int textID)
{
	if (!textID) return; 
	bg &= 0x3; 
	if ((int)th < 10) { th = &gPrepMainMenuTexts[(int)th]; } 
	if (!lines) { return; } 
    int i;
    for (i = 0; i < lines; i++) { 
        ClearText(&th[i]);
	} 
	
	char *str = GetStringFromIndex(textID);
	
	int width = 0; 
	int max_width = 0; 
	int height = 2 * lines; 




	for (i = 0; i < lines; i++) { 
		width = (GetStringTextLen(str)+8)/8; 
        InitText(&th[i], width);
		Text_SetColor(&th[i], color);
		if (width > max_width) { max_width = width; } 
		str = GetStrNextLine(str); 
		if (!str) break; 
		
	}
	
	
	//asm("mov r11, r11"); 
    TileMap_FillRect(
        TILEMAP_LOCATED(bg_table[bg], x, y),
        max_width+x, height+y, 0);
    BG_EnableSyncByMask(BG_SYNC_BIT(bg));
}

int CountStrLines(char *str) {
	int i = 0;
	while (*str) { 
	i++;
	str = GetStrNextLine(str); }
	return i; 
}
int CountTextIDLines(int textID) {
	if (!textID) return 0; 
	char *str = GetStringFromIndex(textID);
	return CountStrLines(str); 
}
char *GetStrNextLine(char *str) // char *GetStringLineEnd(char *str);
{
    char c = *str;
    while (c > 1) {
        str++;
        c = *str;
    }
	if (str) { 
		str++; 
		return str;
	} 
	return NULL; 
}

void PrepareMultiline(struct Text th[], int textID)
{
	if (!textID) return; 
	if ((int)th < 10) { th = &gPrepMainMenuTexts[(int)th]; } 
	
    const char *str = GetStringFromIndex(textID);

    while (1) {
        if ('\0' == *str)        /* End for fetext */
            return;

        if ('\1' == *str) {      /* '\n' for fetext */
            th++;
            str++;
            continue;
        }

        str = Text_DrawCharacter(th, str);
    }
}

void DrawMultiline(struct Text th[], int lines, int x, int y, int bg)
{
	if (!lines) { return; } 
	bg &= 0x3; 
	if ((int)th < 10) { th = &gPrepMainMenuTexts[(int)th]; } 
    for (int i = 0; i < lines; i++) {
        PutText(
            &th[i],
            TILEMAP_LOCATED(bg_table[bg], x, (2 * i) + y));
    }

    BG_EnableSyncByMask(BG_SYNC_BIT(bg));
}

const u16 sSprite_VertHand[] = {
    1,
    0x0002, 0x4000, 0x0006
};
const u8 sHandVOffsetLookup[] = {
    0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 2, 3, 3, 3, 3,
    4, 4, 4, 4, 4, 4, 4, 3, 3, 2, 2, 2, 1, 1, 1, 1,
};
extern int sPrevHandClockFrame; 
extern struct Vec2 sPrevHandScreenPosition; 
extern int sPrevHandClockFrame; 
static void DisplayVertUiHand(int x, int y)
{
    if ((GetGameClock() - 1) == sPrevHandClockFrame)
    {
        x = (x + sPrevHandScreenPosition.x) >> 1;
        y = (y + sPrevHandScreenPosition.y) >> 1;
    }

    sPrevHandScreenPosition.x = x;
    sPrevHandScreenPosition.y = y;
    sPrevHandClockFrame = GetGameClock();

    y += (sHandVOffsetLookup[Mod(GetGameClock(), ARRAY_COUNT(sHandVOffsetLookup))] - 14);
    PutSprite(2, x, y, sSprite_VertHand, 0);
}

extern struct KeyStatusBuffer sKeyStatusBuffer;
static void SeedMenuLoop(SeedMenuProc* proc) { 

	DisplayVertUiHand(CursorLocationTable[proc->digit].x, CursorLocationTable[proc->digit].y); // 6 is the tile of the downwards hand 	
	u16 keys = sKeyStatusBuffer.newKeys; 
	if (!keys) { keys = sKeyStatusBuffer.repeatedKeys; } 
	if ((keys & START_BUTTON)||(keys & A_BUTTON)) { //press A or Start to continue
		#ifdef POKEMBLEM_VERSION 
		if (!proc->seed) { proc->seed = 12345; } // don't use 0 
		*StartTimeSeedRamLabel = proc->seed; 
		#endif 
		gEventSlots[0xC] = proc->seed; 
		Proc_Break((ProcPtr)proc);
		m4aSongNumStart(0x6B); 
	};
	int max = gEventSlots[3]; 
	int min = gEventSlots[2]; 
	int max_digits = GetMaxDigits(max); 
	
    if (keys & DPAD_RIGHT) {
      if (proc->digit > 0) { proc->digit--; }
      else { proc->digit = max_digits - 1; } 
	  DrawSeedMenu(proc);
    }
    if (keys & DPAD_LEFT) {
      if (proc->digit < (max_digits-1)) { proc->digit++; }
      else { proc->digit = 0; } 
	  DrawSeedMenu(proc);
    }
	
    if (keys & DPAD_UP) {
		if (proc->seed == max) { proc->seed = min; } 
		else { 
			proc->seed += DigitDecimalTable[proc->digit]; 
			if (proc->seed > max) { proc->seed = max; } 
		} 
		DrawSeedMenu(proc); 
	}
    if (keys & DPAD_DOWN) {
		
		if (proc->seed == min) { proc->seed = max; } 
		else { 
			proc->seed -= DigitDecimalTable[proc->digit]; 
			if (proc->seed < min) { proc->seed = min; } 
		} 
		
		DrawSeedMenu(proc); 
	}
} 
