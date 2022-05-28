#include "gbafe.h"

static int  PokedexIdle (MenuProc* menu, MenuCommandProc* command);
static int  PokedexDrawIdle(MenuProc* menu, MenuCommandProc* command);
static void PokedexDraw(struct MenuProc* menu, struct MenuCommandProc* command);
static int CallPokedexMenuEnd(struct MenuProc* menu, struct MenuCommandProc* command);
static void PokedexMenuEnd(struct MenuProc* menu, struct MenuCommandProc* command);
static void DrawRawText(TextHandle handle, char* string, int x, int y);

static void DrawMultiline(TextHandle* handles, char* string, int lines);
static int GetNumLines(char* string);

extern u16 gBG0MapBuffer[32][32]; // 0x02022CA8. Snek: Ew why does FE-CLib-master not do it like this?
extern u16 gBG1MapBuffer[32][32]; // 0x020234A8.

extern const u16 MyPalette[]; 
extern u8 gPaletteSyncFlag;

enum { BG0_SYNC_BIT = BG_SYNC_BIT(0) };

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



struct PokemonLocation 
{
	u32 areaBitfield_A;
	u32 areaBitfield_B;
};
static void Pokedex_RetrieveAreasFound(u8 classID, int* areaBitfield_A, int* areaBitfield_B);

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
	u8 padding;
	/* 34 */ int areaBitfield_A;
	/* 38 */ int areaBitfield_B;
};

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
        if (proc->menuIndex < 0xFF) {
            proc->menuIndex--;
			while (!PokedexTable[proc->menuIndex].IndexNumber)
			{
				if (proc->menuIndex > 2) 
				{
					proc->menuIndex--;
				}
				else { proc->menuIndex = 0xFF; }
			}
            PokedexDraw(menu, command);
            PlaySfx(0x6B);
        }
    }

    if (gKeyState.repeatedKeys & KEY_DPAD_RIGHT) {
        if (proc->menuIndex < 0xFF) {
            proc->menuIndex++;
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
    }

    return ME_NONE;
}


static void DrawRawText(TextHandle handle, char* string, int x, int y)
{
	Text_Clear(&handle);
	Text_SetColorId(&handle,TEXT_COLOR_GOLD);
	Text_DrawString(&handle,string);
	Text_Display(&handle,&gBG0MapBuffer[y][x]);
}

static int PokedexDrawIdle(MenuProc* menu, MenuCommandProc* command) {
    struct PokedexProc* const proc = (void*) menu->parent;
    u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);

	int* areaBitfield_A = &proc->areaBitfield_A;
	int* areaBitfield_B = &proc->areaBitfield_B;
	*areaBitfield_A = 0;
	*areaBitfield_B = 0;
	proc->areaBitfield_A = 0;
	proc->areaBitfield_B = 0;
	
	bool caught = CheckIfCaught(proc->menuIndex);
	bool seen = CheckIfSeen(proc->menuIndex);

	const struct ClassData* ClassData = GetClassData(proc->menuIndex);
	u16 title = 0;
    Text_Clear(&command->text);
	Text_ResetTileAllocation(); // 0x08003D20
	
	
	Pokedex_RetrieveAreasFound(proc->menuIndex, areaBitfield_A, areaBitfield_B);
	//asm("mov r11, r11");
	
	
	if (proc->menuIndex)
	{
		if (seen)
		{
			title = ClassData->nameTextId;
			Text_DrawString(&command->text, GetStringFromIndex(title));
			Text_Display(&command->text, out); // Class name 
		}
	}
	
	
	
    Text_SetColorId(&command->text, TEXT_COLOR_NORMAL);
    if (!title) {
		Text_SetXCursor(&command->text, 0xC);
		Text_DrawString(&command->text, "???");
        //
		Text_Display(&command->text, out); // Class name 
    }


	
	//DrawUiNumber(&gBG0MapBuffer[5][21],TEXT_COLOR_GOLD,  5); 

	int tile = 40;
	
	TextHandle caughtNameHandle = {
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 4
	};
	tile += 4;
	DrawRawText(caughtNameHandle," Seen",1,16);

	TextHandle seenNameHandle = {
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 5
	};
	tile += 5;
	DrawRawText(seenNameHandle," Caught",1,18);
	
	DrawUiNumber(&gBG0MapBuffer[16][9],TEXT_COLOR_GOLD,  proc->TotalSeen); 
	DrawUiNumber(&gBG0MapBuffer[18][9],TEXT_COLOR_GOLD,  proc->TotalCaught);
	BgMap_ApplyTsa(&gBG1MapBuffer[16][1], &PokedexSeenCaughtBox, 0);
	
	
	EndFaceById(0);
	struct FaceProc* FaceProc = StartFace(0, ClassData->defaultPortraitId, 200, 4, 1);
	FaceProc->tileData &= ~(3 << 10); // Clear bits 10 and 11 (priority) such that they are 0 (highest priority) and appear above the background 
	
	BgMap_ApplyTsa(&gBG1MapBuffer[0][20], &PokedexPortraitBox, 0);
	
	if (!seen)
	{ 
		//FaceProc->pPortraitData->pPortraitPalette = 
		int paletteID = 22*32;
		int paletteSize = 32; 
		CopyToPaletteBuffer(MyPalette, paletteID, paletteSize); // source pointer, palette offset, size 
		gPaletteSyncFlag = 1;
	}
	
	LoadIconPalettes(4);
	ClearIcons();
	EnableBgSyncByMask(BG0_SYNC_BIT);
	
	for (int x = 0; x < 20; x++) { // clear out most of bg0 
		for (int y = 0; y < 15; y++) { 
			gBG0MapBuffer[y][x] = 0;
		}
	}
	
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
	//ObjClear();
	if (proc->areaBitfield_A)
	{
		for (int i = 0; i<64; i++)
		{
			if (proc->areaBitfield_A & 1<<i)
			{
				u8 xx = AreaTable[i].xx;
				u8 yy = AreaTable[i].yy;
				DrawIcon(&gBG0MapBuffer[yy][xx],0xC,TILEREF(0, 0x4));
			}
		}
	}
	DrawUiNumber(&gBG0MapBuffer[12][18], TEXT_COLOR_GOLD, PokedexTable[proc->menuIndex].IndexNumber);

	char* string = GetStringFromIndex(PokedexTable[proc->menuIndex].textID);
	int lines = GetNumLines(string);
	//int lines = 4;
	//int tile = 0;
	TextHandle handles[lines];
	for ( int i = 0 ; i < lines ; i++ )
	{
		handles[i].tileIndexOffset = gpCurrentFont->tileNext+tile;
		handles[i].xCursor = 0;
		handles[i].colorId = TEXT_COLOR_NORMAL;
		handles[i].tileWidth = 18;
		handles[i].useDoubleBuffer = 0;
		handles[i].currentBufferId = 0;
		handles[i].unk07 = 0;
		tile += 18;
		Text_Clear(&handles[i]);
	}
	
	
	DrawMultiline(handles, string, lines);
	
	for ( int i = 0 ; i < lines ; i++ )
	{
		Text_Display(&handles[i],&gBG0MapBuffer[14+2*i][12]);
		//Text_Display(&handles[i],&gBG0MapBuffer[12+2*i][20]);
	}
	
    return ME_NONE;
}

enum {
NL = 1, // Text control code for new line.
};

static void DrawMultiline(TextHandle* handles, char* string, int lines) // There's a TextHandle for every line we need to pass in.
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
        Text_InsertString(handles,0,handles->colorId,(char*)gGenericBuffer);
        //Text_DrawString(handles,(char*)gGenericBuffer);
        handles++;
        j++;
    }
}

extern const u8 WorldMap_img[];
extern const u16 WorldMap_pal[];
extern const u8 gWorldMapPaletteCount;
extern const u8 WorldMap_tsa[];

//Initializes menu
int Pokedex_OnSelect(struct MenuProc* menu, struct MenuCommandProc* command) {
    struct PokedexProc* proc = (void*) ProcStart(Proc_ChapterPokedex, ROOT_PROC_3);

    proc->menuIndex = 1;
	proc->TotalCaught = CountCaught();
	proc->TotalSeen = CountSeen();
	
	Decompress(WorldMap_img,(void*)0x600C000);
	
	CopyToPaletteBuffer(WorldMap_pal,0x20*6,(gWorldMapPaletteCount-2)*32);
	CopyToPaletteBuffer(WorldMap_pal+(gWorldMapPaletteCount-1)*16,0x20*15,32);
	
	memcpy(gGenericBuffer, WorldMap_tsa, 0x4B2);
	//Decompress(WorldMap_tsa,gGenericBuffer);
	TSA* tsaBuffer = (TSA*)gGenericBuffer;
	for ( int i = 0 ; i < tsaBuffer->height+1 ; i++ )
	{
		for ( int j = 0 ; j < tsaBuffer->width+1 ; j++ )
		{
			if ( tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID == 16-6 )
			{
				tsaBuffer->tiles[i*(tsaBuffer->width+1)+j].paletteID--;
			}
		}
	}
	BgMap_ApplyTsa(gBg2MapBuffer,gGenericBuffer, 6<<12);
	SetBgTileDataOffset(2,0xC000);
	
	struct LCDIOBuffer* LCDIOBuffer = &gLCDIOBuffer;
	LCDIOBuffer->bgOffset[3].x = 0; // make offset as 0, rather than scrolled to the right
	LCDIOBuffer->bgOffset[3].y = 0; 

	
	
	LoadIconPalettes(4);
	EnableBgSyncByMask(BG_SYNC_BIT(2)); // sync bg 3 
	EnablePaletteSync();


    StartMenuChild(&Menu_Pokedex, (void*) proc);

    return ME_DISABLE | ME_END | ME_PLAY_BEEP | ME_CLEAR_GFX;
}

//This actually draws the UI
static void PokedexDraw(struct MenuProc* menu, struct MenuCommandProc* command) {
    command->onCycle = (void*) PokedexDrawIdle(menu, command);
}

//For the final things before exiting the menu
static int CallPokedexMenuEnd(struct MenuProc* menu, struct MenuCommandProc* command) {
	PokedexMenuEnd(menu, command);
	struct Proc* const proc = (void*) menu->parent; // latter makes more sense, but gives warning as EndProc expects Proc*, not PokedexProc* 
	//struct PokedexProc* const proc = (void*) menu->parent;
	EndProc(proc);
	UnlockGameLogic();
	UnlockGameGraphicsLogic(); 
	return true;
}

static void PokedexMenuEnd(struct MenuProc* menu, struct MenuCommandProc* command) {
	EndFaceById(0);
	FillBgMap(gBg0MapBuffer,0);
	FillBgMap(gBg1MapBuffer,0);
	FillBgMap(gBg2MapBuffer,0);
	EnableBgSyncByMask(1|2|4);
	UnpackChapterMapPalette(gChapterData.chapterIndex); 
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

static void Pokedex_RetrieveAreasFound(u8 classID, int* areaBitfield_A, int* areaBitfield_B)
{ 
	for (u16 i = 0 ; i <= 0x80 ; i++) 
	{
		u8 Chapter = MonsterSpawnTable[i].ChID;
		if (Chapter)
		{
			//asm("mov r11, r11");
			if ((MonsterSpawnTable[i].Class_1 == classID) | (MonsterSpawnTable[i].Class_2 == classID) | (MonsterSpawnTable[i].Class_3 == classID) | (MonsterSpawnTable[i].Class_4 == classID) | (MonsterSpawnTable[i].Class_5 == classID))
			{
				if (Chapter <= 63)
				{
					//*areaBitfield_A = 1;
					//asm("mov r11, r11");
					*areaBitfield_A = *areaBitfield_A | 1<<Chapter;
				}
				if ((Chapter > 63) && (Chapter < 127))
				{
					*areaBitfield_B = *areaBitfield_B | 1<<Chapter;
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




