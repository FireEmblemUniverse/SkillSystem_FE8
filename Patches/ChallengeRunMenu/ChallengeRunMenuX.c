#include "gbafe.h" // headers 

#define PUREFUNC __attribute__((pure))
#define ARMFUNC __attribute__((target("arm")))
int Div(int a, int b) PUREFUNC;
int Mod(int a, int b) PUREFUNC;
int DivArm(int b, int a) PUREFUNC;

extern int CR_MaxDisplayed;
extern int CR_TotalOptions;
extern const u8 CR_NumberOfOptionsPerEntryTable[]; 


typedef struct {
    /* 00 */ PROC_HEADER;
    /* 2C */ u32 address;
	/* 30 */ u8 id; // menu id 
	u8 offset; 
	u8 handleID; 
	u8 redraw; 
	u8 updateSMS; 
	u8 cannotCatch; 
	u8 cannotEvolve; 
	u8 pkmn[7];
	//s8 Option[15];
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
#define MENU_Y 16
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

void InitLine(int handleID, int x, int y, int color, int width, char* str);
void PrepareLine(int handleID, const char* str);
void DrawLine(int handleID, int x, int y, int bg);
void DrawChallengeRun(ChallengeRunProc* proc);
void DrawAdditionalRulesText(ChallengeRunProc* proc);

#define white TEXT_COLOR_SYSTEM_WHITE
#define gray TEXT_COLOR_SYSTEM_GRAY
#define grey TEXT_COLOR_SYSTEM_GRAY
#define blue TEXT_COLOR_SYSTEM_BLUE 
#define gold TEXT_COLOR_SYSTEM_GOLD
#define green TEXT_COLOR_SYSTEM_GREEN
#define black TEXT_COLOR_SYSTEM_BLACK 

void CR_EraseText(ChallengeRunProc* proc) { 
	//BG_Fill(gBG0TilemapBuffer, 0);
	//BG_EnableSyncByMask(BG0_SYNC_BIT);
	//ResetTextFont();
	DrawChallengeRun(proc);

}


extern const struct UnitDefinition* ChallengeRunUnitsTable[]; 
void SetPkmn(ChallengeRunProc* proc) { 
	const struct UnitDefinition* uDef = ChallengeRunUnitsTable[proc->id+proc->offset]; 
    int count;
	for (count = 0; count <= 6; count++) { 
		proc->pkmn[count] = 0; 
	} 
	
	count = 0; 
    while ((uDef->classIndex) && (count < 6)) {
		proc->pkmn[count] = uDef->classIndex; 
        uDef++;
        count++;
    }
}

void DrawCR_Sprites(ChallengeRunProc* proc, int bg) { 
	int i; 

	if (proc->offset) {
        DisplayUiVArrow(MENU_X+8, MENU_Y-8, 0x3240, 1); // up arrow 
    }
	// should display down arrow? 
	if ((CR_TotalOptions > 7) && (proc->offset < (CR_TotalOptions - CR_MaxDisplayed))) {
		DisplayUiVArrow(MENU_X+8, MENU_Y+(16*8), 0x3240, 0);
	}
	DisplayUiHand(CR_CursorLocationTable[proc->id].x, CR_CursorLocationTable[proc->id].y); 	
	
	if (proc->updateSMS) { 
	if (!proc->pkmn[0]) { return; } 
		ResetUnitSprites();
		SetPkmn(proc); 
	} 
    for (i = 0; i < 6; i++) {
        u32 yOff = ((i >> 1) << 4) + 16;///proc->yDiff_cur;
        //if((yOff + 0xF) < 0x60 )
            //PutUnitSprite(0, (i & 1) * 56 + 0x70, yOff + 0x18,
                        //GetUnit(1));
			if (!proc->pkmn[i]) { break; } 
			PutUnitSpriteForClassId(bg, (i & 1) * 56 + 0x70, yOff + 0x18, 0xc800, proc->pkmn[i]);
    }
	if (proc->updateSMS) { 
		proc->updateSMS = false; 
		if (!proc->pkmn[0]) { return; } 
		ForceSyncUnitSpriteSheet(); 
		return; 
	}
	SyncUnitSpriteSheet();
} 
void ClearLine(int); 
void DrawAdditionalRulesText(ChallengeRunProc* proc) { 
	//char* str2[4];
	int i = 0; 
	proc->cannotCatch = false; 
	proc->cannotEvolve = false; 
	if ((proc->id == 1) && (proc->offset == 0)) { proc->cannotEvolve = true; } 
	if (proc->id+proc->offset > 1) { proc->cannotCatch = true; } 


	
	i = 1; 
	ClearLine(i+proc->handleID);
	DrawLine(i+proc->handleID, 12,   12, 0); i++; 
	
	ClearLine(i+proc->handleID); 
	//if (proc->cannotEvolve) { 
	//DrawLine(i+proc->handleID, 12,   12+2, 0); 
	//} i++; ClearLine(i+proc->handleID); 
	//if (proc->cannotCatch) { 
	//	DrawLine(i+proc->handleID, 12,   12+4, 0); 
	//} i++; ClearLine(i+proc->handleID); 
	//if ((proc->cannotCatch) && (proc->cannotEvolve)) { 
	//	DrawLine(i+proc->handleID, 12,   12+4, 0); 
	//} i++; ClearLine(i+proc->handleID); 
	//if ((!proc->cannotEvolve) && (!proc->cannotCatch)) { 
	//DrawLine(i+proc->handleID, 12,   12+2, 0); } i++; 
	BG_EnableSyncByMask(BG_SYNC_BIT(0));
	
	
} 

void DrawChallengeRun(ChallengeRunProc* proc) { 


	int i, x, y, bg; 
	char* str[25]; 
	
	x = (MENU_X/8)+1; 
	y = (MENU_Y / 8); 
	bg = 0; 
	
	i = 0; 
	str[i] = "New Name"; i++; 
	str[i] = "LittleCup"; i++; 
	//str[i] = "UnderUsed"; i++; 
	//str[i] = "OverUsed"; i++; 
	str[i] = "Ash"; i++; 
	str[i] = "Gary"; i++; 
	//str[i] = "Red"; i++; 
	//str[i] = "Blue"; i++; 
	//str[i] = "Green"; i++; 
	//str[i] = "Yellow"; i++; 
	str[i] = "Oak"; i++; 
	str[i] = "Bill"; i++; 
	str[i] = "Brock"; i++; 
	str[i] = "Misty"; i++; 
	str[i] = "Lt. Surge"; i++; 
	str[i] = "Erika"; i++; 
	str[i] = "Koga"; i++; 
	str[i] = "Sabrina"; i++; 
	str[i] = "Blaine"; i++; 
	str[i] = "Giovanni"; i++; 
	str[i] = "Lorelei"; i++; 
	str[i] = "Bruno"; i++; 
	str[i] = "Agatha"; i++; 
	str[i] = "Lance"; i++; 
	str[i] = "Vesly"; i++; 
	
	char* str2[6];
	i = 0; 
	str2[i] = "Challenge Runs"; i++; 
	str2[i] = "Additional Rules"; i++; 
	str2[i] = "Cannot evolve Pokémon"; i++; 
	str2[i] = "Cannot capture Pokémon"; i++; // extra rules 
	str2[i] = "Cannot capture certain Pokémon"; i++; // extra rules 
	str2[i] = "None"; i++;
	
	ResetText();
	i = 0; 
	// InitLine(int handleID, int x, int y, int bg, int color, int width, char* str) 
	InitLine(i, x, y+00, white, 0, str[i+proc->offset]); i++; 
	InitLine(i, x, y+02, white, 0, str[i+proc->offset]); i++; 
	InitLine(i, x, y+04, white, 0, str[i+proc->offset]); i++; 
	InitLine(i, x, y+06, white, 0, str[i+proc->offset]); i++; 
	InitLine(i, x, y+ 8, white, 0, str[i+proc->offset]); i++; 
	InitLine(i, x, y+10, white, 0, str[i+proc->offset]); i++; 
	InitLine(i, x, y+12, white, 0, str[i+proc->offset]); i++; 
	InitLine(i, x, y+14, white, 0, str[i+proc->offset]); i++; 
	proc->handleID = i; 
	i = 0; 
	InitLine(i+proc->handleID, 12, 1,    green, 0, str2[i]); i++; 
	InitLine(i+proc->handleID, 13, 12,   white, 0, str2[i]); i++;
	InitLine(i+proc->handleID, 12, 12+2, white, 14, str2[i]); i++;
	InitLine(i+proc->handleID, 12, 12+4, white, 14, str2[i]); i++;
	InitLine(i+proc->handleID, 12, 12+4, white, 14, str2[i]); i++;
	InitLine(i+proc->handleID, 12, 12+2, white, 0, str2[i]); i++;
	
	
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
	PrepareLine(i+proc->handleID, str2[i]); i++;
	PrepareLine(i+proc->handleID, str2[i]); i++;
	PrepareLine(i+proc->handleID, str2[i]); i++;
	PrepareLine(i+proc->handleID, str2[i]); i++;
	PrepareLine(i+proc->handleID, str2[i]); i++;
	PrepareLine(i+proc->handleID, str2[i]); i++;
	
	i = 0; 
	DrawLine(i, x, y+00, bg); i++; 
	DrawLine(i, x, y+02, bg); i++; 
	DrawLine(i, x, y+04, bg); i++; 
	DrawLine(i, x, y+06, bg); i++; 
	DrawLine(i, x, y+ 8, bg); i++; 
	DrawLine(i, x, y+10, bg); i++; 
	DrawLine(i, x, y+12, bg); i++; 
	DrawLine(i, x, y+14, bg); i++; 
	DrawLine(i, 12,   1, bg); i++; 
	
	DrawAdditionalRulesText(proc);
	
	BG_EnableSyncByMask(BG_SYNC_BIT(bg));



	

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
		proc->redraw = false; 
		proc->updateSMS = true; // so it will init sprites to 0  
		proc->cannotCatch = false; 
		proc->cannotEvolve = false; 
		proc->handleID = 0; 
		proc->pkmn[0] = 0; 
		//ResetText();
		UnpackUiVArrowGfx(0x240, 3);
		SetTextFontGlyphs(0);
		SetTextFont(0);
		ResetTextFont();
		SetupMapSpritesPalettes();
		//CR_EraseText(proc);
		DrawChallengeRun(proc);
		//BG_EnableSyncByMask(BG0_SYNC_BIT);
		StartGreenText(proc); 
	} 
} 

extern struct KeyStatusBuffer sKeyStatusBuffer;
static void ChallengeRunLoop(ChallengeRunProc* proc) { 

	
	DrawCR_Sprites(proc, 0); 
	
	if (proc->redraw) { 
		proc->redraw = false; 
		DrawChallengeRun(proc);
	
	} 
	
	
	u16 keys = sKeyStatusBuffer.newKeys; 
	if (!keys) { keys = sKeyStatusBuffer.repeatedKeys; } 
	if ((keys & START_BUTTON)||(keys & A_BUTTON)) { //press A or Start to continue
		gEventSlots[0xC] = proc->address; 
		Proc_Break((ProcPtr)proc);
		m4aSongNumStart(0x6B); 
	};

	
    if (keys & DPAD_DOWN) {
		proc->updateSMS = true; 
		if (proc->id < CR_MaxDisplayed) { proc->id++; DrawAdditionalRulesText(proc); return; } // no need to redraw  
		else if ((proc->offset + proc->id) < CR_TotalOptions) { proc->offset++; } 
		else if (proc->id >= CR_MaxDisplayed) { proc->id = 0; proc->offset = 0;  } 
		CR_EraseText(proc);
		proc->redraw = true; 
	}
    if (keys & DPAD_UP) {
		proc->updateSMS = true; 
		if (proc->id) { proc->id--; DrawAdditionalRulesText(proc); return; } // no need to redraw  
		else if (proc->offset) { proc->offset--; } 
		
		else if (!proc->id) { proc->id = CR_MaxDisplayed; proc->offset = (CR_TotalOptions - CR_MaxDisplayed); } 
		CR_EraseText(proc);
		proc->redraw = true; 
	}

    //if (keys & DPAD_LEFT) {
	//	proc->Option[proc->id]--;
	//	if (proc->Option[proc->id] < 0) { 
	//		proc->Option[proc->id] = CR_NumberOfOptionsPerEntryTable[proc->id] - 1;
	//	} 
	//	DrawChallengeRun(proc);
	//} 
    //if (keys & DPAD_RIGHT) {
	//	proc->Option[proc->id]++;
	//	if (proc->Option[proc->id] >= CR_NumberOfOptionsPerEntryTable[proc->id]) { 
	//		proc->Option[proc->id] = 0;
	//	} 
	//	DrawChallengeRun(proc);
	//}
} 

extern struct Font *gActiveFont;

void ClearLine(int handleID) { 

	struct Text* th = &gStatScreen.text[handleID]; // max 34 
	ClearText(th);

} 

void InitLine(int handleID, int x, int y, int color, int width, char* str)
{
	if (handleID > 34) return;
	//struct Text* th = &gPrepMainMenuTexts[handleID]; // max 10 
	struct Text* th = &gStatScreen.text[handleID]; // max 34 
	ClearText(th);
	if (!width) { width = 9; } //(GetStringTextLen(str)+8)/8;  
	
    th->chr_position = gActiveFont->chr_counter;
    th->tile_width = width;
    th->db_id = 0;
    th->db_enabled = false;
    th->is_printing = false;
    gActiveFont->chr_counter += width;
	//InitText(th, width); // calls ClearText(th);
	Text_SetColor(th, color);

    //TileMap_FillRect(
    //    TILEMAP_LOCATED(bg_table[bg], x, y),
    //    width+x, height+y, 0);
    //BG_EnableSyncByMask(BG_SYNC_BIT(bg));
}



void PrepareLine(int handleID, const char* str)
{
	if (handleID > 34) return;
	//struct Text* th = &gPrepMainMenuTexts[handleID]; // max 10 
	struct Text* th = &gStatScreen.text[handleID]; // max 34 

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
	if (handleID > 34) return;
	//struct Text* th = &gPrepMainMenuTexts[handleID]; // max 10 
	struct Text* th = &gStatScreen.text[handleID]; // max 34 
	bg &= 0x3; 
    PutText(th, TILEMAP_LOCATED(bg_table[bg], x, y));

    //BG_EnableSyncByMask(BG_SYNC_BIT(bg));
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




