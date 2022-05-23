#include "gbafe.h"

static int  PokedexIdle (MenuProc* menu, MenuCommandProc* command);
static int  PokedexDrawIdle(MenuProc* menu, MenuCommandProc* command);
static void PokedexDraw(struct MenuProc* menu, struct MenuCommandProc* command);
static void PokedexMenuEnd(struct MenuProc* menu, struct MenuCommandProc* command);
static void DrawRawText(TextHandle handle, char* string, int x, int y);

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
    u8 DisplayBool;
    u8 Unk1;
    u8 Unk2;
    u8 Unk3;
};


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
};

static const struct ProcInstruction Proc_ChapterPokedex[] =
{
    PROC_CALL_ROUTINE(LockGameLogic),

    PROC_YIELD,

    PROC_CALL_ROUTINE(UnlockGameLogic),
    PROC_END,
};

//For selecting what each menu command does.
static const struct MenuCommandDefinition MenuCommands_Pokedex[] =
{
    {
        .isAvailable = MenuCommandAlwaysUsable,

        .onDraw = PokedexDraw,
        .onIdle = PokedexIdle,
        //.onEffect = PokedexEvent,
    },

    {} //END

};

static const struct MenuDefinition Menu_Pokedex =
{
    .geometry = { 10, 1, 11 },
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
			while (!PokedexTable[proc->menuIndex].DisplayBool)
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
			while (!PokedexTable[proc->menuIndex].DisplayBool)
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

	const struct ClassData* ClassData = GetClassData(proc->menuIndex);
	u16 title = 1;
	Text_ResetTileAllocation(); // 0x08003D20
	if (proc->menuIndex)
	{
		//asm("mov r11, r11");
		title = ClassData->nameTextId;
		//asm("mov r11, r11");
	}
	
    Text_Clear(&command->text);

    //TODO display chapter ID if there is no chapter title
    Text_SetColorId(&command->text, TEXT_COLOR_NORMAL);
    if (title == 0) {
		Text_SetXCursor(&command->text, 0xC);
        Text_DrawNumberOr2Dashes(&command->text, proc->menuIndex);
    }
    else {
        Text_DrawString(&command->text, GetStringFromIndex(title));
    }

    Text_Display(&command->text, out); // Class name 
	
 
 
	//DrawUiNumber(&gBG0MapBuffer[5][21],TEXT_COLOR_GOLD,  5); 
	DrawUiNumber(&gBG0MapBuffer[2][28],TEXT_COLOR_GOLD,  proc->TotalSeen); 
	DrawUiNumber(&gBG0MapBuffer[4][28],TEXT_COLOR_GOLD,  proc->TotalCaught);
	
	int tile = 40;
	
	TextHandle caughtNameHandle = {
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 4
	};
	tile += 4;
	DrawRawText(caughtNameHandle," Seen",22,2);

	TextHandle seenNameHandle = {
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 5
	};
	tile += 5;
	DrawRawText(seenNameHandle," Caught",22,4);
	
	
	EndFaceById(0);
	struct FaceProc* FaceProc = StartFace(0, ClassData->defaultPortraitId, 40, 4, 3);
	FaceProc->tileData &= ~(3 << 10); // Clear bits 10 and 11 (priority) such that they are 0 (highest priority) and appear above the background 
	
	BgMap_ApplyTsa(&gBG1MapBuffer[0][0], &PokedexPortraitBox, 0);
	
	if (!CheckIfSeen(proc->menuIndex))
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
	if (CheckIfCaught(proc->menuIndex))
	{
		DrawIcon(
		out + TILEMAP_INDEX(7, 0),
		0xAB, TILEREF(0, 4));
	}
	else
	{
		if (CheckIfSeen(proc->menuIndex))
		{
			DrawIcon(
			out + TILEMAP_INDEX(7, 0),
			0xAA, TILEREF(0, 4));
		}
	}
	BgMap_ApplyTsa(&gBG1MapBuffer[1][21], &PokedexSeenCaughtBox, 0);
	
	

	EnableBgSyncByMask(1);
	
	
	
    return ME_NONE;
}

//Initializes menu
int Pokedex_OnSelect(struct MenuProc* menu, struct MenuCommandProc* command) {
    struct PokedexProc* proc = (void*) ProcStart(Proc_ChapterPokedex, ROOT_PROC_3);

    proc->menuIndex = 1;
	proc->TotalCaught = CountCaught();
	proc->TotalSeen = CountSeen();
	

	
    StartMenuChild(&Menu_Pokedex, (void*) proc);

    return ME_DISABLE | ME_END | ME_PLAY_BEEP | ME_CLEAR_GFX;
}

//This actually draws the UI
static void PokedexDraw(struct MenuProc* menu, struct MenuCommandProc* command) {
    command->onCycle = (void*) PokedexDrawIdle(menu, command);
}

//For the final things before exiting the menu
static void PokedexMenuEnd(struct MenuProc* menu, struct MenuCommandProc* command) {
	EndFaceById(0);
    return;
}
