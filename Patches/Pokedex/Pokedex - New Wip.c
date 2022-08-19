#include "gbafe.h"
extern void UnpackChapterMapPalette(u8 chapterID); 

static int  PokedexIdle (MenuProc* menu, MenuCommandProc* command);
static int  PokedexDrawIdle(MenuProc* menu, MenuCommandProc* command);
static void PokedexDraw(struct MenuProc* menu, struct MenuCommandProc* command);

static int CallPokedexMenuEnd(struct MenuProc* menu, struct MenuCommandProc* command);
static void PokedexMenuEnd(struct MenuProc* menu, struct MenuCommandProc* command);
static void PrepareText(TextHandle* handle, char* string);
static void DrawWorldMap(void);
static void DrawMultiline(TextHandle* handles, char* string, int lines, char* dest[lines]);
static int GetNumLines(char* string);
//static void DisplayTextNow(void);

extern u8 gSpecialUiCharAllocationTable[]; // 02028E78.

extern u16 gBG0MapBuffer[32][32]; // 0x02022CA8. Snek: Ew why does FE-CLib-master not do it like this?
extern u16 gBG1MapBuffer[32][32]; // 0x020234A8.
extern u16 gBG2MapBuffer[32][32]; // 0x020234A8.

extern const u16 MyPalette[]; 
extern u8 gPaletteSyncFlag;



typedef struct Tile Tile;
typedef struct TSA TSA;
struct Tile
{
	u16 tileID : 10;
	u16 horizontalFlip : 1;
	u16 verticalFlip : 1;
	u16 paletteID : 4;
};

struct TSA
{
	u8 width, height;
	Tile tiles[];
};
extern TSA PokedexPortraitBox;
extern TSA PokedexDescBox;
extern TSA PokedexNumberBox;
extern TSA PokedexSeenCaughtBox;

struct PokedexTable_Struct
{
    u8 IndexNumber;
    u8 Unk1;
    u16 textID;
};

struct AreaTable_Struct
{
	u8 xx; 
	u8 yy;
};
extern struct AreaTable_Struct AreaTable[0xFF];


static void Pokedex_RetrieveAreasFound(u8 classID, int* areaBitfield_A, int* areaBitfield_B, int* areaBitfield_C, int* areaBitfield_D);


extern const u8 WorldMap_img[];
extern const u16 WorldMap_pal[];
extern const u8 gWorldMapPaletteCount;
extern const u8 WorldMap_tsa[];
extern u32 CheckIfSeen(u8 ClassID); 
extern u32 CheckIfCaught(u8 ClassID); 
extern u32 CountSeen(); 
extern u32 CountCaught(); 

extern struct PokedexTable_Struct PokedexTable[0xFF]; 


struct PokedexProc
{
    PROC_HEADER;

    /* 2C */ struct Unit* unit;

    /* 30 */ u8 menuIndex;
	u8 TotalSeen;
	u8 TotalCaught; 
	u8 cycle;
	/* 34 */ int areaBitfield_A;
	/* 38 */ int areaBitfield_B;
	/* 3C */ int areaBitfield_C;
	/* 40 */ int areaBitfield_D;
	bool caught;
	bool seen; 
	/* 48 */ 
	int tileStart;
};

struct PokedexProcText
{
	PROC_HEADER;
};

/*
static const struct ProcInstruction Proc_PokedexText[] =
{
	PROC_YIELD,
	PROC_CALL_ROUTINE(DisplayTextNow),
	PROC_SLEEP(1),
	
    PROC_END,
};
*/

static const struct ProcInstruction Proc_ChapterPokedex[] =
{
    PROC_CALL_ROUTINE(LockGameLogic),
	PROC_CALL_ROUTINE(LockGameGraphicsLogic),

    PROC_YIELD,

	PROC_CALL_ROUTINE(UnlockGameLogic),
	PROC_CALL_ROUTINE(UnlockGameGraphicsLogic), 
    PROC_END,
};



//For selecting what each menu command does.
static const struct MenuCommandDefinition MenuCommands_Pokedex[] =
{
    {
        .isAvailable = MenuCommandAlwaysUsable,

        .onDraw = PokedexDraw,
        .onIdle = PokedexIdle,
        .onEffect = CallPokedexMenuEnd,
    },

    {} //END

};



static const struct MenuDefinition Menu_Pokedex =
{
    .geometry = { 20, 10, 10 },
    .commandList = MenuCommands_Pokedex,

    //.onEnd = PokedexMenuEnd,
    .onBPress = PokedexMenuEnd,
    //.onBPress = (void*) (0x080152F4+1), // Goes back to main game loop
};


//Handles what to do when buttons are pushed
static int PokedexIdle (MenuProc* menu, MenuCommandProc* command) {
    struct PokedexProc* const proc = (void*) menu->parent;

    //TODO update graphics in a cleaner way
    if (gKeyState.repeatedKeys & KEY_DPAD_LEFT) {
        if (proc->menuIndex < 0xFF) { proc->menuIndex--; }
		while (!PokedexTable[proc->menuIndex].IndexNumber)
		{
			if (proc->menuIndex > 1) 
			{
				proc->menuIndex--;
			}
			else { proc->menuIndex = 0xFF; }
		}
		PokedexDraw(menu, command);
		PlaySfx(0x6B);
    }

    if (gKeyState.repeatedKeys & KEY_DPAD_RIGHT) {
        if (proc->menuIndex < 0xFF) { proc->menuIndex++; }
		while (!PokedexTable[proc->menuIndex].IndexNumber)
		{
			if (proc->menuIndex < 0xFF) 
			{
				proc->menuIndex++;
			}
			else { proc->menuIndex = 1; }
		}
		PokedexDraw(menu, command);
		PlaySfx(0x6B);
    }
    if (gKeyState.repeatedKeys & KEY_DPAD_UP) {
		u8 c = 0;
		while (c<10) {
			if (proc->menuIndex > 1) 
				{
					proc->menuIndex--;
				}
			else { proc->menuIndex = 0xFF; }
			
			if (PokedexTable[proc->menuIndex].IndexNumber) { c++; } 
		}
		PokedexDraw(menu, command);
		PlaySfx(0x6B);
	}
    if (gKeyState.repeatedKeys & KEY_DPAD_DOWN) {
		u8 c = 0;
		while (c<10) {
			if (proc->menuIndex < 0xFF) 
				{
					proc->menuIndex++;
				}
			else { proc->menuIndex = 1; }
			
			if (PokedexTable[proc->menuIndex].IndexNumber) { c++; } 
		}
		PokedexDraw(menu, command);
		PlaySfx(0x6B);
	}

    
	
	
	if (proc->cycle >=40) { proc->cycle = 0; } 
	
	proc->cycle++; 
	if ( (proc->cycle < 20) & proc->seen) 
	{ 
		//ObjClear();
		
		if (proc->areaBitfield_A)
		{
			for (int i = 0; i<32; i++)
			{
				if (proc->areaBitfield_A & 1<<i)
				{
					u8 xx = AreaTable[i].xx;
					u8 yy = AreaTable[i].yy;
					ObjInsertSafe(0, xx*8, yy*8, &gObj_8x8, TILEREF(0x65, 0)); // + icon 
				}
			}
		}
		if (proc->areaBitfield_B)
		{
			for (int i = 0; i<32; i++)
			{
				if (proc->areaBitfield_B & 1<<i)
				{
					u8 xx = AreaTable[i+32].xx; // bitpacked chapters, so add +32
					u8 yy = AreaTable[i+32].yy;
					ObjInsertSafe(0, xx*8, yy*8, &gObj_8x8, TILEREF(0x65, 0)); // + icon 
				}
			}
		}
		if (proc->areaBitfield_C)
		{
			for (int i = 0; i<32; i++)
			{
				if (proc->areaBitfield_C & 1<<i)
				{
					u8 xx = AreaTable[i+64].xx; // bitpacked chapters, so add +64 
					u8 yy = AreaTable[i+64].yy;
					ObjInsertSafe(0, xx*8, yy*8, &gObj_8x8, TILEREF(0x65, 0)); // + icon 
				}
			}
		}
		if (proc->areaBitfield_D)
		{
			for (int i = 0; i<32; i++)
			{
				if (proc->areaBitfield_D & 1<<i)
				{
					u8 xx = AreaTable[i+96].xx; // bitpacked chapters, so add +96 
					u8 yy = AreaTable[i+96].yy;
					ObjInsertSafe(0, xx*8, yy*8, &gObj_8x8, TILEREF(0x65, 0)); // + icon 
				}
			}
		}
	}
    return ME_NONE;
}



//extern TextHandle textH[10]; // 0x203E794 is used by R-text 
static int PokedexDrawIdle(MenuProc* menu, MenuCommandProc* command) {
    struct PokedexProc* const proc = (void*) menu->parent;
    u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);

	int* areaBitfield_A = &proc->areaBitfield_A;
	int* areaBitfield_B = &proc->areaBitfield_B;
	int* areaBitfield_C = &proc->areaBitfield_C;
	int* areaBitfield_D = &proc->areaBitfield_D;
	proc->areaBitfield_A = 0;
	proc->areaBitfield_B = 0;
	proc->areaBitfield_C = 0;
	proc->areaBitfield_D = 0;
	proc->cycle = 0;
	
	
	bool caught = CheckIfCaught(proc->menuIndex);
	bool seen = CheckIfSeen(proc->menuIndex);
	proc->caught = caught;
	proc->seen = seen;

	gpCurrentFont->tileNext = proc->tileStart; // makes it so you don't need to use Text_ResetTileAllocation
	gSpecialUiCharAllocationTable[0] = 0xFF; // dunno what this does or if I am using it right 

	for (int x = 0; x < 30; x++) { // clear out most of bg0 
		for (int y = 0; y < 20; y++) { 
			gBG0MapBuffer[y][x] = 0;
		}
	}
/*
	for (int x = 0; x < 17; x++) { // clear out most of bg0 
		for (int y = 0; y < 15; y++) { 
			gBG0MapBuffer[y][x] = 0;
		}
	}
*/
	EnableBgSyncByMask(BG0_SYNC_BIT);

	//DrawWorldMap();
	//Text_ResetTileAllocation(); // I ran into tile graphical issues using Snek's method with gpCurrentFont 

	extern char* textHandles; 
	
	const int NumOfEntries = 6;
	TextHandle textH[NumOfEntries];
	char* string[NumOfEntries]; 
	struct TextBatchEntry textBatch[NumOfEntries]; 
	for (int c = 0; c<NumOfEntries; c++) { 
		string[c] = 0; 
		textH[c].tileIndexOffset = 0; 
		textH[c].xCursor = 0; 
		textH[c].colorId = 0; 
		textH[c].tileWidth = 0; 
		textH[c].useDoubleBuffer = 0; 
		textH[c].currentBufferId = 0; 
		textH[c].unk07 = 0; 
		textBatch[c].textHandle = &textH[c];
		textBatch[c].tileWidth = textH[c].tileWidth; 
	} 
	
	u8 i = 0;
	

	
	string[i] = " Seen"; 
	textBatch[i].textHandle = &textH[i];
	textBatch[i].tileWidth = (Text_GetStringTextWidth(string[i])+7)/8; i++; 
	string[i] = " Caught"; 
	textBatch[i].textHandle = &textH[i];
	textBatch[i].tileWidth = (Text_GetStringTextWidth(string[i])+7)/8; i++; 
	// for each string, set string[i] to = your string, then set up textBatch for i's entry 


	//u16 className = 0;
/*
	
    //Text_InitClear(&command->text, command->text.tileWidth);
	string[i] = "asdf"; 
	Pokedex_RetrieveAreasFound(proc->menuIndex, areaBitfield_A, areaBitfield_B, areaBitfield_C, areaBitfield_D);
	if (proc->menuIndex)
	{
		if (seen)
		{
			className = ClassData->nameTextId;
			string[i] = GetStringFromIndex(className);
		}
	}
    //Text_SetColorId(&command->text, TEXT_COLOR_NORMAL);
    if (!className) {
		//string[i] = " ???        ";
		string[i] = " ???";
    }
*/ 
	const struct ClassData* ClassData = GetClassData(proc->menuIndex);
	//gpCurrentFont->pVRAMTileRoot = 0x6003000; 
	u16 classNameID = ClassData->nameTextId;
	
	//gCurrentTextString, 0x202A6AC


	//char* className = GetStringFromIndex(classNameID);

	//extern char* NewTextTable[0x2000]; 
	extern char* NewTextTable[0x2000]; 
	
	//memcpy((void*)&textHandles, (void*)className, 100);
	////string[i] = String_GetFromIndexExt(classNameID, textHandles);
	////string[i] = GetStringFromIndex(0x505);
	//string[i] = &textHandles;
	//string[i] = &className;
	string[i] = (char*)((int)NewTextTable[classNameID] & 0x7FFFFFFF); // this is what anti-huffman does
	//string[i] = "test";
			
	textBatch[i].textHandle = &textH[i];
	textBatch[i].tileWidth = (Text_GetStringTextWidth(string[i])+7)/8; i++; 


	

	if (seen & (!caught)) { 
		string[i] = " test "; 
		string[i+1] = "   ...   ...   ...   ...   ...   ...   ...   ...   ...";
		string[i+2] = "              MISSING DATA";
	}
	
	if (!(seen | caught)) { 
		string[i] =  " No Data";
		string[i+1] =  "";
		string[i+2] =  "";
	} 
	
	if (caught) {
		string[i] =  " No Data";
		string[i+1] =  "";
		string[i+2] =  "";
	}


	const char* currLine = GetStringFromIndex(PokedexTable[proc->menuIndex].textID);
	int lines = 1; //GetNumLines(currLine);
	//int tilesToAdd = 0; 
	while (*currLine != 0 && *currLine != 1)
		{
			string[i] = currLine; 

			textBatch[i].textHandle = &textH[i];
			int width = (Text_GetStringTextWidth(string[i])+7)/8; 
			textBatch[i].tileWidth = width; 
			i++; 
			//tilesToAdd += width; 
			
			currLine = Text_GetStringNextLine(currLine);
			if (*currLine == 0)
				break;
			currLine++;
			lines++; 
		}

	
	//Text_ResetTileAllocation(); 
	InitClearTextBatch(textBatch);
	//gSpecialUiCharAllocationTable[0] = 0xA0;

	
	EndFaceById(0);
	struct FaceProc* FaceProc = StartFace(0, ClassData->defaultPortraitId, 200, 4, 1);
	FaceProc->tileData &= ~(3 << 10); // Clear bits 10 and 11 (priority) such that they are 0 (highest priority) and appear above the background 

	if (!seen)
	{ 
		int paletteID = 22*32;
		int paletteSize = 32; 
		CopyToPaletteBuffer(MyPalette, paletteID, paletteSize); // source pointer, palette offset, size 
		gPaletteSyncFlag = 1;
	}
	
	LoadIconPalettes(4);
	ClearIcons();
	EnableBgSyncByMask(BG0_SYNC_BIT);








	
	
	i = 0; 
	PrepareText(&textH[i], string[i]); i++;
	PrepareText(&textH[i], string[i]); i++;
	PrepareText(&textH[i], string[i]); i++;

	for (int c = 0 ; c < lines ; c++ )
	{
		PrepareText(&textH[i], string[i]); i++;
	}

	//PrepareText(&textH[i], string[i]); i++; 
	//className = GetStringFromIndex(classNameID);
	//gpCurrentFont->tileNext = gpCurrentFont->tileNext + tilesToAdd; 
	
	
	
	DrawUiNumber(&gBG0MapBuffer[1][5], TEXT_COLOR_GOLD, PokedexTable[proc->menuIndex].IndexNumber);
	DrawUiNumber(&gBG0MapBuffer[16][9],TEXT_COLOR_GOLD,  proc->TotalSeen); 
	DrawUiNumber(&gBG0MapBuffer[18][9],TEXT_COLOR_GOLD,  proc->TotalCaught);
	
	i = 0; 

	Text_Display(&textH[i],   &gBG0MapBuffer[18][1]); i++;
	Text_Display(&textH[i], &gBG0MapBuffer[16][1]); i++; 
	Text_Display(&textH[i], &gBG0MapBuffer[11][21]); i++; // pkmn name 
	for (int c = 0 ; c < lines ; c++ )
	{
		Text_Display(&textH[i],&gBG0MapBuffer[14+c*2][12]); i++; 
	}
	
	

	BgMap_ApplyTsa(&gBG1MapBuffer[16][1], &PokedexSeenCaughtBox, 0);
	
	BgMap_ApplyTsa(&gBG1MapBuffer[0][2], &PokedexNumberBox, 0);

	BgMap_ApplyTsa(&gBG1MapBuffer[0][20], &PokedexPortraitBox, 0);
	BgMap_ApplyTsa(&gBG1MapBuffer[14][12], &PokedexDescBox, 0);
	
	if (caught)
	{
		DrawIcon(
		out + TILEMAP_INDEX(6, 0),
		0xAB, TILEREF(0, 4));
	}
	else
	{
		DrawIcon(
		out + TILEMAP_INDEX(6, 0),
		0xAA, TILEREF(0, 4));
	}

	
	//struct PokedexProcText* procText = (void*) ProcStartBlocking(Proc_PokedexText, menu);
	
    return ME_NONE;
}


static void PrepareText(TextHandle* handle, char* string)
{
	//u32 width = (Text_GetStringTextWidth(string)+8)/8;
	//Text_Clear(handle);
	//Text_InitClear(handle, width); // this one makes it bounce 
    //handle->tileWidth = width;
	
	Text_SetColorId(handle,TEXT_COLOR_GOLD);
	Text_DrawString(handle,string);
	//Text_Display(&handle,&gBG0MapBuffer[y][x]);
}



enum {
NL = 1, // Text control code for new line.
};

static void DrawMultiline(TextHandle* handles, char* string, int lines, char* dest[lines]) // There's a TextHandle for every line we need to pass in.
{
    // We're going to copy each line of the string to gGenericBuffer then draw the string from there.
	int j = 0;
    for ( int i = 0 ; i < lines ; i++ )
    {
        int k = 0;
        for ( ; string[j] && string[j] != NL ; k++ )
        {
            gGenericBuffer[k] = string[j];
            j++;
        }
        gGenericBuffer[k] = 0;

		//u32 width = ((Text_GetStringTextWidth((char*)gGenericBuffer))+8)/8;

		//Text_InitClear(&handles[i], width);
		//handles[i].tileWidth = width;
		//handles[i].xCursor = 0;
		//handles[i].colorId = TEXT_COLOR_NORMAL;
		//handles[i].useDoubleBuffer = 0;
		//handles[i].currentBufferId = 0;
		//handles[i].unk07 = 0;
		
		
		dest[i] = (char*)gGenericBuffer;
        //Text_InsertString(&handles[i],0,handles->colorId,(char*)gGenericBuffer);
		
		
		
        //Text_DrawString(&handles[i],(char*)gGenericBuffer);
        //handles++;
        j++;
    }
}

void DrawWorldMap() {
	CopyToPaletteBuffer(WorldMap_pal,0x20*6,(gWorldMapPaletteCount-2)*32);
	CopyToPaletteBuffer(WorldMap_pal+(gWorldMapPaletteCount-1)*16,0x20*15,32);
	EnablePaletteSync();
	

	
	//Text_ResetTileAllocation();
	
	
	//ClearTileRegistry();
	//RegisterFillTile(0, (void*)0x6001000, 0x5000); // so text can be here 
	CPU_FILL(0, gGenericBuffer, 0x2000, 32)
	Decompress(WorldMap_img,(void*)gGenericBuffer+800);
	RegisterTileGraphics(gGenericBuffer+800, (void*)0x600A000, 0x2000); //! FE8U = 0x8002055
	//Text_ResetTileAllocation();
	SyncRegisteredTiles();
	
	//RegisterTileGraphics(WorldMap_img, (void*)0x6008000, 0x4B2); // src, dst, size 

	
	memcpy(gGenericBuffer+1600, WorldMap_tsa, 0x4B2); // dst, src, size 
	//Decompress(WorldMap_tsa,gGenericBuffer);
	TSA* tsaBuffer = (TSA*)gGenericBuffer+1600;
	
	
	//for ( int i = 0 ; i < tsaBuffer->height+1 ; i++ )
	//{
	//	for ( int j = 0 ; j < tsaBuffer->width+1 ; j++ )
	//	{
	//		if ( tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID == 16-6 )
	//		{
	//			tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID--;
	//		}
	//	}
	//}
	BgMap_ApplyTsa(gBg2MapBuffer,gGenericBuffer+1600, 6<<12);
	//SetBgTileDataOffset(2,0xA000);
	SetBgMapDataOffset(2, 0xA000);
	
	
	struct LCDIOBuffer* LCDIOBuffer = &gLCDIOBuffer;
	LCDIOBuffer->bgOffset[2].x = 0; // make offset as 0, rather than scrolled to the right
	LCDIOBuffer->bgOffset[2].y = 0; 

	
	
	LoadIconPalettes(4);
	EnableBgSyncByMask(BG_SYNC_BIT(2)); // sync bg 2 
	//EnablePaletteSync();

}

//Initializes menu
int Pokedex_OnSelect(struct MenuProc* menu, struct MenuCommandProc* command) {
	Text_ResetTileAllocation();
    struct PokedexProc* proc = (void*) ProcStart(Proc_ChapterPokedex, ROOT_PROC_3);

	proc->tileStart = gpCurrentFont->tileNext;
    proc->menuIndex = 1;
	proc->TotalCaught = CountCaught();
	proc->TotalSeen = CountSeen();
	proc->caught = CheckIfCaught(proc->menuIndex);
	proc->seen = CheckIfSeen(proc->menuIndex);
	
	// // 0x08003D20
	
	
	//for (int c = 0; c<10; c++) { 
	//	Text_Clear(&textH[c]); 
	//} 
	
	
	DrawWorldMap();

    StartMenuChild(&Menu_Pokedex, (void*) proc);

    return ME_DISABLE | ME_END | ME_PLAY_BEEP | ME_CLEAR_GFX;
}

//This actually draws the UI
static void PokedexDraw(struct MenuProc* menu, struct MenuCommandProc* command) {
    command->onCycle = (void*) PokedexDrawIdle(menu, command);
}

//For the final things before exiting the menu
static int CallPokedexMenuEnd(struct MenuProc* menu, struct MenuCommandProc* command) {
	return false;
}

/*
	struct Proc* const proc = (void*) menu->parent; // latter makes more sense, but gives warning as EndProc expects Proc*, not PokedexProc* 
	//struct PokedexProc* const proc = (void*) menu->parent;
	EndProc(proc);
	PokedexMenuEnd(menu, command);
	UnlockGameLogic();
	UnlockGameGraphicsLogic(); 
	return true;
	
}
*/

static void PokedexMenuEnd(struct MenuProc* menu, struct MenuCommandProc* command) {
	EndFaceById(0);
	UnpackChapterMapPalette(gChapterData.chapterIndex); 
	FillBgMap(gBg0MapBuffer,0);
	FillBgMap(gBg1MapBuffer,0);
	FillBgMap(gBg2MapBuffer,0);
	//FillBgMap(gBg3MapBuffer,0); // causes gfx glitch once you scroll 
	EnablePaletteSync();
	SetBgTileDataOffset(2, 0); // fixes gfx glitch in some cases, as we offset to 0x8000 earlier 
	
	EnableBgSyncByMask(BG0_SYNC_BIT|BG1_SYNC_BIT|BG2_SYNC_BIT); // sync bgs
	
	UnpackChapterMapGraphics(gChapterData.chapterIndex); // 1 frame of messed up graphics 
	
	//RenderBmMap();
	//SMS_UpdateFromGameData();
	//MU_EndAll();
	//LoadMapSpritePalettes();

    return;
}






struct MonsterSpawnTable_Struct
{
	u8 Class_1;
	u8 Class_2;
	u8 Class_3;
	u8 Class_4;
	u8 Class_5;
	u8 Chance_1;
	u8 Chance_2;
	u8 Chance_3;
	u8 Chance_4;
	u8 Chance_5;
	u8 ChID;
	u8 Padding;
};

extern struct MonsterSpawnTable_Struct MonsterSpawnTable[0xFF];

static void Pokedex_RetrieveAreasFound(u8 classID, int* areaBitfield_A, int* areaBitfield_B, int* areaBitfield_C, int* areaBitfield_D)
{ 
	for (u16 i = 0 ; i <= 0x80 ; i++) 
	{
		u8 Chapter = MonsterSpawnTable[i].ChID;
		if (Chapter)
		{
			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
			{
				if (Chapter < 32)
				{
					*areaBitfield_A = *areaBitfield_A | 1<<Chapter;
				}
				if ((Chapter >= 32) && (Chapter < 64))
				{
					*areaBitfield_B = *areaBitfield_B | 1<<(Chapter-32);
				}
				if ((Chapter >= 64) && (Chapter < 96))
				{
					*areaBitfield_C = *areaBitfield_C | 1<<(Chapter-64);
				}
				if ((Chapter >= 96) && (Chapter < 128))
				{
					*areaBitfield_D = *areaBitfield_D | 1<<(Chapter-96);
				}
				
			}
		}
	}
	return;
}


static int GetNumLines(char* string) // Basically count the number of NL codes.
{
	int sum = 1;
	for ( int i = 0 ; string[i] ; i++ )
	{
		if ( string[i] == NL ) { sum++; }
	}
	return sum;
}




