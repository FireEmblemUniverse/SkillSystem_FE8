#include "gbafe.h"

static int  PokedexIdle (MenuProc* menu, MenuCommandProc* command);
static int  PokedexDrawIdle(MenuProc* menu, MenuCommandProc* command);
static void PokedexDraw(struct MenuProc* menu, struct MenuCommandProc* command);
static void PokedexMenuEnd(struct MenuProc* menu, struct MenuCommandProc* command);

extern u16 gBG0MapBuffer[32][32]; // 0x02022CA8. Snek: Ew why does FE-CLib-master not do it like this?

enum { BG0_SYNC_BIT = BG_SYNC_BIT(0) };

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
    .geometry = { 7, 1, 16 },
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

static void DrawStatNames(TextHandle handle, char* string, int x, int y);

static void DrawStatNames(TextHandle handle, char* string, int x, int y)
{
	Text_Clear(&handle);
	Text_SetColorId(&handle,TEXT_COLOR_GOLD);
	//Text_AppendStringAscii(&handle,string);
	Text_DrawString(&handle,string);
	Text_Display(&handle,&gBG0MapBuffer[y][x]);
}

//I think this is supposed to run repeatedly, but that doesn't seem to be the case
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

    Text_Display(&command->text, out);
	
 
	//DrawUiNumber(&gBG0MapBuffer[5][21],TEXT_COLOR_GOLD,  5); 
	DrawUiNumber(&gBG0MapBuffer[5][21],TEXT_COLOR_GOLD,  proc->TotalSeen); 
	DrawUiNumber(&gBG0MapBuffer[7][21],TEXT_COLOR_GOLD,  proc->TotalCaught);
	
	int tile = 40;
	
	TextHandle caughtNameHandle = {
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 3
	};
	tile += 3;
	DrawStatNames(caughtNameHandle,"Seen",15,5);

	TextHandle seenNameHandle = {
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 4
	};
	tile += 4;
	DrawStatNames(seenNameHandle,"Caught",15,7);
	
	
	EndFaceById(0);
	if (CheckIfSeen(proc->menuIndex))
	{ 
		StartFace(0, ClassData->defaultPortraitId, 64, 32, 3);
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
