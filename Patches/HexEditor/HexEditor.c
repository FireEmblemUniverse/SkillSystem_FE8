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
    /* 2C */ u32 address;
	/* 30 */ u8 digit; 
} HexEditorProc;

static void HexEditorLoop(HexEditorProc* proc); 
const struct ProcCmd HexEditorProcCmd[] =
{
    PROC_CALL(LockGame),
    PROC_CALL(BMapDispSuspend),
	PROC_CALL(StartFadeFromBlack), 

    PROC_YIELD,
	PROC_REPEAT(HexEditorLoop), 

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
LocationTable HexEditorCursorLocationTable[] = {
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




extern void ChapterStatus_SetupFont(ProcPtr proc); 
extern char* hexadecimalTable[]; // = { "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F" }; 
static void DrawHexEditor(HexEditorProc* proc) { 

	
		ResetTextFont();
		SetTextFontGlyphs(0);
//		ChapterStatus_SetupFont((void*)proc);

		BG_Fill(gBG0TilemapBuffer, 0);
		BG_EnableSyncByMask(BG0_SYNC_BIT);
		ResetTextFont();
		SetTextFontGlyphs(0);
		SetTextFont(0);
		
		char* string = "Hex Editor"; 
		PutDrawText(NULL, gBG0TilemapBuffer + TILEMAP_INDEX(12,1), TEXT_COLOR_SYSTEM_GREEN, 0, (GetStringTextLen(string)+8)/8, string);
		string = "Address"; 
		PutDrawText(NULL, gBG0TilemapBuffer + TILEMAP_INDEX(8,4), TEXT_COLOR_SYSTEM_WHITE, 0, (GetStringTextLen(string)+8)/8, string);
	//struct Text handle;
	//InitText(&handle, 10);
	TileMap_FillRect(gBG0TilemapBuffer + TILEMAP_INDEX(NUMBER_X-8, Y_HAND), 9, 2, 0);
	BG_EnableSyncByMask(BG0_SYNC_BIT);
	
	u8* nybbleA = (u8*)proc->address; 
	u8* nybbleB = (u8*)proc->address; 
	
	u8 nybbleC = *nybbleA & 0xF; 
	u8 nybbleD = (*nybbleB>>4) & 0xF; 
	PutDrawText(0, gBG0TilemapBuffer + TILEMAP_INDEX(NUMBER_X, Y_HAND), TEXT_COLOR_SYSTEM_GOLD, 0, 1, hexadecimalTable[nybbleC]);
	PutDrawText(0, gBG0TilemapBuffer + TILEMAP_INDEX(NUMBER_X-1, Y_HAND), TEXT_COLOR_SYSTEM_GOLD, 0, 1, hexadecimalTable[nybbleD]);
	
	for (int i = 0; i < 8; i++) { 
		nybbleC = (proc->address >> (4*(7-i))) & 0xF; 
		PutDrawText(0, gBG0TilemapBuffer + TILEMAP_INDEX(NUMBER_X-(7-i), Y_HAND-4), TEXT_COLOR_SYSTEM_GOLD, 0, 1, hexadecimalTable[nybbleC]);
	} 
	
	
	//ClearText

	//PutNumber(, TEXT_COLOR_SYSTEM_GOLD, proc->address); 

	BG_EnableSyncByMask(BG0_SYNC_BIT);

	//DrawTextInline(0, BGLoc(BG0Buffer, 2, 0), 4, 0, , string);

} 

//extern char NumberTitle_Text; 
//extern char NumberDesc_Text;




void StartHexEditor(ProcPtr parent) { 
	ClearBg0Bg1();
	//EnableBgSyncByIndex(0);
	HexEditorProc* proc; 
	if (parent) { proc = (HexEditorProc*)Proc_StartBlocking((ProcPtr)&HexEditorProcCmd, parent); } 
	else { proc = (HexEditorProc*)Proc_Start((ProcPtr)&HexEditorProcCmd, PROC_TREE_3); } 
	if (proc) { 
		proc->address = (u32)gEventSlots[1]; 
		proc->digit = 0; 
		//ResetText();


		DrawHexEditor(proc);
		
		//BG_EnableSyncByMask(BG0_SYNC_BIT);
		StartGreenText(proc); 
		
	} 
	
} 



const u16 HexEditorsSprite_VertHand[] = {
    1,
    0x0002, 0x4000, 0x0006
};
const u8 HexEditorsHandVOffsetLookup[] = {
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

    y += (HexEditorsHandVOffsetLookup[Mod(GetGameClock(), ARRAY_COUNT(HexEditorsHandVOffsetLookup))] - 14);
    PutSprite(2, x, y, HexEditorsSprite_VertHand, 0);
}

#define DIGIT_MAX 1
extern struct KeyStatusBuffer sKeyStatusBuffer;
static void HexEditorLoop(HexEditorProc* proc) { 

	DisplayVertUiHand(HexEditorCursorLocationTable[proc->digit].x, HexEditorCursorLocationTable[proc->digit].y); // 6 is the tile of the downwards hand 	
	u16 keys = sKeyStatusBuffer.newKeys; 
	if (!keys) { keys = sKeyStatusBuffer.repeatedKeys; } 
	if ((keys & START_BUTTON)||(keys & A_BUTTON)) { //press A or Start to continue
		gEventSlots[0xC] = proc->address; 
		Proc_Break((ProcPtr)proc);
		m4aSongNumStart(0x6B); 
	};
	//int max = gEventSlots[3]; 
	//int min = gEventSlots[2]; 
	//int max_digits = GetMaxDigits(max); 
	
    if (keys & DPAD_RIGHT) {
		if (proc->digit == 0) { proc->address++; } 
		else if (proc->digit > 0) { proc->digit--; } 
		DrawHexEditor(proc);
    }
    if (keys & DPAD_LEFT) {
		if (proc->digit == DIGIT_MAX) { proc->address--; } 
		else if (proc->digit < DIGIT_MAX) { proc->digit++; } 
		DrawHexEditor(proc);
    }
	
	
    if (keys & DPAD_UP) {
		
		
		u8* nybbleA = (u8*)proc->address; 
		//int nybbleB = (*nybbleA>>(4*proc->digit)) & 0xF; 
		//nybbleB--; 
		*nybbleA = (*nybbleA + (1<<(4*proc->digit)));
	//PutDrawText(0, gBG0TilemapBuffer + TILEMAP_INDEX(NUMBER_X, Y_HAND), TEXT_COLOR_SYSTEM_GOLD, 0, 1, hexadecimalTable[nybbleC]);
	//PutDrawText(0, gBG0TilemapBuffer + TILEMAP_INDEX(NUMBER_X-1, Y_HAND), TEXT_COLOR_SYSTEM_GOLD, 0, 1, hexadecimalTable[nybbleD]);
		//proc->address--; 
		//if (proc->address == max) { proc->address = min; } 
		//else { 
			//proc->address += DigitDecimalTable[proc->digit]; 
			//if (proc->address > max) { proc->address = max; } 
		//} 
		DrawHexEditor(proc); 
	}
    else if (keys & DPAD_DOWN) {
		u8* nybbleA = (u8*)proc->address; 
		//int nybbleB = (*nybbleA>>(4*proc->digit)) & 0xF; 
		//nybbleB--; 
		*nybbleA = (*nybbleA - (1<<(4*proc->digit)));
		//*nybbleA = (*nybbleA & 0xFFFFFFF0) + nybbleB; 
		//proc->address++; 
		//if (proc->address == min) { proc->address = max; } 
		//else { 
		//	proc->address -= DigitDecimalTable[proc->digit]; 
		//	if (proc->address < min) { proc->address = min; } 
		//} 
		
		DrawHexEditor(proc); 
	}
} 
