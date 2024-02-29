#include "gbafe.h" // headers 

#define PUREFUNC __attribute__((pure))
#define ARMFUNC __attribute__((target("arm")))
int Div(int a, int b) PUREFUNC;
int Mod(int a, int b) PUREFUNC;
int DivArm(int b, int a) PUREFUNC;

extern int CR_PAGE1MAXINDEX;
extern const u8 CR_NumberOfOptionsPerEntryTable[]; 


typedef struct {
    /* 00 */ PROC_HEADER;
    /* 2C */ u32 address;
	/* 30 */ u8 id; // menu id 
	u8 offset; 
	u8 entries; // number of options 
	s8 Option[15];
} ChallengeRunProc;

static void ChallengeRunLoop(ChallengeRunProc* proc); 
const struct ProcCmd ChallengeRunProcCmd[] =
{
    PROC_CALL(LockGame),
    PROC_CALL(BMapDispSuspend),
	PROC_CALL(StartFadeFromBlack), 

    PROC_YIELD,
	PROC_REPEAT(ChallengeRunLoop), 

    PROC_CALL(UnlockGame),
    PROC_CALL(BMapDispResume),
    PROC_END,
};

#define MENU_X 18
#define MENU_Y 24
typedef const struct {
  u32 x;
  u32 y;
} LocationTable;


static const LocationTable CR_CursorLocationTable[] = {
  {MENU_X, MENU_Y + (16*0)},
  {MENU_X, MENU_Y + (16*1)},
  {MENU_X, MENU_Y + (16*2)},
  {MENU_X, MENU_Y + (16*3)},
  {MENU_X, MENU_Y + (16*4)},
  {MENU_X, MENU_Y + (16*5)},
  {MENU_X, MENU_Y + (16*6)}, //,
  {MENU_X, MENU_Y + (16*7)} //,
  // {10, 0x88} //leave room for a description?
};


extern u16* bg_table[4]; // = {gBG0TilemapBuffer, gBG1TilemapBuffer, gBG2TilemapBuffer, gBG3TilemapBuffer}; 
//#define BG_SYNC_BIT(aBg) (1 << (aBg))
//static void InitMultiline(struct Text th[], int lines, int x, int y, int bg, int color, int textID); 
//static void PrepareMultiline(struct Text th[], int textID); 
//static void DrawMultiline(struct Text th[], int lines, int x, int y, int bg);
//static int CountTextIDLines(int textID); 
//static char *GetStrNextLine(char *str); 

void InitLine(int handleID, int x, int y, int bg, int color, char* str);
void PrepareLine(int handleID, const char* str);
void DrawLine(int handleID, int x, int y, int bg);

#define white TEXT_COLOR_SYSTEM_WHITE

void DrawChallengeRun(ChallengeRunProc* proc) { 


	ResetTextFont();
	SetTextFontGlyphs(0);
	SetTextFont(0);
	BG_Fill(gBG0TilemapBuffer, 0);
	BG_EnableSyncByMask(BG0_SYNC_BIT);

	// should display down arrow? 
	if ((proc->entries > 8) && (proc->offset >= proc->entries)) {
		DisplayUiVArrow(120, 152, 0x3240, 0);
	}
	
	if (proc->offset) {
        DisplayUiVArrow(120, 64, 0x3240, 1);
    }



	
	int i, x, y, bg; 
	char* str[20]; 

	
	x = (MENU_X/8)+1; 
	y = (MENU_Y / 8); 
	bg = 0; 
	
	
	str[0] = "Challenge Runs";
	str[1] = "Brock"; 
	str[2] = "2"; 
	str[3] = "3"; 
	str[4] = "4"; 
	str[5] = "5"; 
	str[6] = "6"; 
	str[7] = "7"; 
	str[8] = "8"; 
	str[9] = "9"; 
	str[10] = "10"; 
	str[11] = "11"; 
	str[12] = "12"; 
	
	i = 0; 
	// InitLine(int handleID, int x, int y, int bg, int color, char* str) 
	InitLine(i, x, y+00, bg, white, str[i+proc->offset]); i++; 
	InitLine(i, x, y+02, bg, white, str[i+proc->offset]); i++; 
	InitLine(i, x, y+04, bg, white, str[i+proc->offset]); i++; 
	InitLine(i, x, y+06, bg, white, str[i+proc->offset]); i++; 
	InitLine(i, x, y+8, bg, white, str[i+proc->offset]); i++; 
	InitLine(i, x, y+10, bg, white, str[i+proc->offset]); i++; 
	InitLine(i, x, y+12, bg, white, str[i+proc->offset]); i++; 
	InitLine(i, x, y+14, bg, white, str[i+proc->offset]); i++; 
	
	i = 0; 
	PrepareLine(i, str[i+proc->offset]); i++;
	PrepareLine(i, str[i+proc->offset]); i++;
	PrepareLine(i, str[i+proc->offset]); i++;
	PrepareLine(i, str[i+proc->offset]); i++;
	PrepareLine(i, str[i+proc->offset]); i++;
	PrepareLine(i, str[i+proc->offset]); i++;
	PrepareLine(i, str[i+proc->offset]); i++;
	PrepareLine(i, str[i+proc->offset]); i++;
	
	i = 0; 
	DrawLine(i, x, y+00, bg); i++; 
	DrawLine(i, x, y+02, bg); i++; 
	DrawLine(i, x, y+04, bg); i++; 
	DrawLine(i, x, y+06, bg); i++; 
	DrawLine(i, x, y+8, bg); i++; 
	DrawLine(i, x, y+10, bg); i++; 
	DrawLine(i, x, y+12, bg); i++; 
	DrawLine(i, x, y+14, bg); i++; 


} 


void StartChallengeRun(ProcPtr parent) { 
	ClearBg0Bg1();
	//EnableBgSyncByIndex(0);
	ChallengeRunProc* proc; 
	if (parent) { proc = (ChallengeRunProc*)Proc_StartBlocking((ProcPtr)&ChallengeRunProcCmd, parent); } 
	else { proc = (ChallengeRunProc*)Proc_Start((ProcPtr)&ChallengeRunProcCmd, PROC_TREE_3); } 
	if (proc) { 
		proc->address = 0; 
		proc->id = 0; 
		proc->offset = 0; 
		proc->entries = 12; 
		//ResetText();
		UnpackUiVArrowGfx(0x240, 3);
		DrawChallengeRun(proc);
		//BG_EnableSyncByMask(BG0_SYNC_BIT);
		StartGreenText(proc); 
	} 
} 

extern struct KeyStatusBuffer sKeyStatusBuffer;
static void ChallengeRunLoop(ChallengeRunProc* proc) { 

	DisplayUiHand(CR_CursorLocationTable[proc->id].x, CR_CursorLocationTable[proc->id].y); 	
	u16 keys = sKeyStatusBuffer.newKeys; 
	if (!keys) { keys = sKeyStatusBuffer.repeatedKeys; } 
	if ((keys & START_BUTTON)||(keys & A_BUTTON)) { //press A or Start to continue
		gEventSlots[0xC] = proc->address; 
		Proc_Break((ProcPtr)proc);
		m4aSongNumStart(0x6B); 
	};

	
    if (keys & DPAD_DOWN) {
		if (proc->id < CR_PAGE1MAXINDEX) { proc->id++; }
		else { proc->id = 0; } 
		DrawChallengeRun(proc);
	}
    if (keys & DPAD_UP) {
		if (proc->id != 0) { proc->id--; }
		else { proc->id = CR_PAGE1MAXINDEX; }
		DrawChallengeRun(proc);
	}

    if (keys & DPAD_LEFT) {
		proc->Option[proc->id]--;
		if (proc->Option[proc->id] < 0) { 
			proc->Option[proc->id] = CR_NumberOfOptionsPerEntryTable[proc->id] - 1;
		} 
		DrawChallengeRun(proc);
	} 
    if (keys & DPAD_RIGHT) {
		proc->Option[proc->id]++;
		if (proc->Option[proc->id] >= CR_NumberOfOptionsPerEntryTable[proc->id]) { 
			proc->Option[proc->id] = 0;
		} 
		DrawChallengeRun(proc);
	}
} 

void InitLine(int handleID, int x, int y, int bg, int color, char* str)
{
	if (handleID > 10) return;
	struct Text* th = &gPrepMainMenuTexts[handleID];
	bg &= 0x3; 
    ClearText(th);
	
	int width = width = (GetStringTextLen(str)+8)/8;  
	int height = 2; // because single line 
	InitText(th, width);
	Text_SetColor(th, color);

    TileMap_FillRect(
        TILEMAP_LOCATED(bg_table[bg], x, y),
        width+x, height+y, 0);
    BG_EnableSyncByMask(BG_SYNC_BIT(bg));
}



void PrepareLine(int handleID, const char* str)
{
	if (handleID > 10) return;
	struct Text* th = &gPrepMainMenuTexts[handleID];

    while (1) {
        if ('\0' == *str)        /* End for fetext */
            return;

        if ('\1' == *str) {      /* '\n' for fetext */
			return; // only draw 1 line 
        }

        str = Text_DrawCharacter(th, str);
    }
}

void DrawLine(int handleID, int x, int y, int bg)
{
	if (handleID > 10) return;
	struct Text* th = &gPrepMainMenuTexts[handleID];
	bg &= 0x3; 
    PutText(th, TILEMAP_LOCATED(bg_table[bg], x, y));

    BG_EnableSyncByMask(BG_SYNC_BIT(bg));
}

/*
static void InitMultiline(struct Text th[], int lines, int x, int y, int bg, int color, int textID)
{
	if (!textID) return; 
	bg &= 0x3; 
	if ((int)th < 10) { th = &gPrepMainMenuTexts[(int)th]; } 
	if (!lines) { return; } 
    int i;
    for (i = 0; i < lines; i++) { 
        ClearText(&gPrepMainMenuTexts[i]);
	} 
	
	char *str = GetStringFromIndex(textID);
	
	int width = 0; 
	int max_width = 0; 
	int height = 2 * (lines - 1) + y; 



    BG_EnableSyncByMask(BG_SYNC_BIT(bg));
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
	
}

static int CountStrLines(char *str) {
	int i = 0;
	while (*str) { 
	i++;
	str = GetStrNextLine(str); }
	return i; 
}
static int CountTextIDLines(int textID) {
	if (!textID) return 0; 
	char *str = GetStringFromIndex(textID);
	return CountStrLines(str); 
}
static char *GetStrNextLine(char *str) // char *GetStringLineEnd(char *str);
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

static void PrepareMultiline(struct Text th[], int textID)
{
	if (!textID) return; 
	if ((int)th < 10) { th = &gPrepMainMenuTexts[(int)th]; } 
	
    const char *str = GetStringFromIndex(textID);

    while (1) {
        if ('\0' == *str)        // End for fetext 
            return;

        if ('\1' == *str) {      // '\n' for fetext 
            th++;
            str++;
            continue;
        }

        str = Text_DrawCharacter(th, str);
    }
}

static void DrawMultiline(struct Text th[], int lines, int x, int y, int bg)
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

*/




