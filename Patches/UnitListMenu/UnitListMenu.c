
#include "gbafe.h"



extern u16 gBG0MapBuffer[32][32];
extern u16 gBG1MapBuffer[32][32]; 






static void UnitListCommandDraw(struct MenuProc* menu, struct MenuCommandProc* command);
static int CommandSelect(struct MenuProc* menu, struct MenuCommandProc* command);
//static int MoveCommandConfirm(struct MenuProc* menu, struct MenuCommandProc* command);
//static int MoveCommandDecline(struct MenuProc* menu, struct MenuCommandProc* command);
static int List_Idle(struct MenuProc* menu, struct MenuCommandProc* command);
static int MoveListCommandSelect(struct MenuProc* menu, struct MenuCommandProc* command);
static void ReplaceMoveCommandDraw(struct MenuProc* menu, struct MenuCommandProc* command);
static void UnitListMenuEnd(struct MenuProc* menu);



struct UnitListProc
{
    /* 00 */ PROC_HEADER; // this ends at +29
    /* 2C */ struct Unit* unit;
			u8 hoverUpdated; 
};

static const struct ProcInstruction Proc_UnitList[] =
{
    PROC_CALL_ROUTINE(LockGameLogic),

    PROC_YIELD,
    PROC_CALL_ROUTINE(UnlockGameLogic),
    PROC_END,
};

static const struct MenuCommandDefinition MenuCommands_ReplaceMove[] =
{
    {
        .isAvailable = MenuCommandAlwaysUsable,
        .onDraw = UnitListCommandDraw,
		.onIdle = List_Idle,
        .onEffect = CommandSelect,

    },

    {
        .isAvailable = MenuCommandAlwaysUsable,
        .onDraw = UnitListCommandDraw,
		.onIdle = List_Idle,
        .onEffect = CommandSelect,
    },
	
	
    {
		.isAvailable = MenuCommandAlwaysUsable,

        .onDraw = UnitListCommandDraw,
		.onIdle = List_Idle,
		
        .onEffect = CommandSelect,
    },
	
    {
		.isAvailable = MenuCommandAlwaysUsable,

        .onDraw = UnitListCommandDraw,
		.onIdle = List_Idle,
        .onEffect = CommandSelect,
    },
	
	
    {
		.isAvailable = MenuCommandAlwaysUsable,

        .onDraw = UnitListCommandDraw,
		.onIdle = List_Idle,
        .onEffect = CommandSelect,
    },
    {
		.isAvailable = MenuCommandAlwaysUsable,

        .onDraw = UnitListCommandDraw,
		.onIdle = List_Idle,
        .onEffect = CommandSelect,
    },

	
    {} // END
};

void DrawUnitInfo(struct MenuProc* menu, struct MenuCommandProc* command, struct UnitListProc* proc);


static const struct MenuDefinition Menu_UnitList =
{
    .geometry = { menu_tile_X, menu_tile_Y, menu_Length },
    .commandList = MenuCommands_ReplaceMove,

    .onEnd = UnitListMenuEnd,
	
    .onBPress = (void*) (0x08022860+1), // FIXME
	//.onBPress = (void*) (BPressForgetOldMoveMenu), // Now in the proc call routine 
};

int UnitList_ASMC(struct MenuProc* menu, struct MenuCommandProc* command)
{
    struct UnitListProc* proc = (void*) ProcStart(Proc_UnitList, ROOT_PROC_3);
	
	proc->hoverUpdated = FALSE; 
	proc->move_hovering = 0;
    StartMenuChild(&Menu_UnitList, (void*) proc);
    return ME_DISABLE | ME_END | ME_PLAY_BEEP | ME_CLEAR_GFX;
}


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
extern TSA ReplaceMovesTSA;

static void PrepareText(TextHandle* handle, char* string)
{
	//Text_Clear(handle);
	//Text_InitClear(handle, handle->tileWidth); 
	u32 width = (Text_GetStringTextWidth(string)+8)/8;
	Text_InitClear(handle, width); 
    handle->tileWidth = width;
	
	Text_SetColorId(handle,TEXT_COLOR_GOLD);
	Text_DrawString(handle,string);
	//Text_Display(&handle,&gBG0MapBuffer[y][x]);
}



void DrawUnitInfo(struct MenuProc* menu, struct MenuCommandProc* command, struct UnitListProc* proc)
{
	for (int x = 0; x < 30; x++) { // clear out most of bg0 
		for (int y = 0; y < 20; y++) { 
			gBG0MapBuffer[y][x] = 0;
		}
	}
	//BgMap_ApplyTsa(&gBG1MapBuffer[14][5], &ReplaceMovesTSA, 0);
	// [2000932..2000933]!!
	// [2028E6a..2028E6b]!! 
	// 0x8004a9e 
	
	Text_ResetTileAllocation();

	//u16 tile = gpCurrentFont->tileNext; 
	// u16 tileNext starts at 0 when ResetTileAllocation is used (vram 0x6001000) 
	// 

	menu->pCommandProc[0]->text.tileIndexOffset = gpCurrentFont->tileNext; 
	
	menu->pCommandProc[0]->text.tileWidth = 0;
	// update tileNext to be whatever we offset it to 
	// in this case it's 0, but it would be important if it wasn't 
	// menu starts at tileNext as 0 (and draws spaces as needed) 
	for (u8 c = 1; c <= menu->commandCount; c++) { 
		gpCurrentFont->tileNext = menu->pCommandProc[c-1]->text.tileIndexOffset + menu->pCommandProc[c-1]->text.tileWidth; 
		menu->pCommandProc[c]->text.tileIndexOffset =  gpCurrentFont->tileNext; 
	} 
	//menu->pCommandProc[1]->text.currentBufferId = 0; //handles[i].currentBufferId;
	UnitListCommandDraw(menu, menu->pCommandProc[1]); 
	UnitListCommandDraw(menu, menu->pCommandProc[2]); 
	UnitListCommandDraw(menu, menu->pCommandProc[3]); 
	UnitListCommandDraw(menu, menu->pCommandProc[4]); 
	UnitListCommandDraw(menu, menu->pCommandProc[5]); 
	
	//u16 tile = menu->tileBase+20;  
	
	TextHandle handles[20] = {};
	for ( int i = 0 ; i < 20 ; i++ )
	{
		//handles[i].tileIndexOffset = tile; // offset to start at 
		handles[i].xCursor = 0;
		//handles[i].tileIndexOffset = 0x180;
		handles[i].colorId = TEXT_COLOR_NORMAL;
		handles[i].useDoubleBuffer = 0;
		handles[i].currentBufferId = 0;
		handles[i].unk07 = 0;
	}

	proc->tileNext = gpCurrentFont->tileNext; 


	EnableBgSyncByMask(BG0_SYNC_BIT);
	EnableBgSyncByMask(BG1_SYNC_BIT);
	

	
	
} 

extern u8 gSpecialUiCharAllocationTable[]; // 0x2028E78


static int List_Idle(struct MenuProc* menu, struct MenuCommandProc* command)
{
    struct UnitListProc* const proc = (void*) menu->parent;
    u8* const moves = UnitGetMoveList(proc->unit);		
	if (proc->move_hovering != menu->commandIndex)
	{   
		proc->hover_move_Updated = TRUE;
		proc->move_hovering = menu->commandIndex;
		UpdateItemInfo(menu, command, proc); 
		/*         proc->movesUpdated = TRUE; */
	}	
    return ME_NONE;
}


static void UnitListCommandDraw(struct MenuProc* menu, struct MenuCommandProc* command)
{
    struct UnitListProc* const proc = (void*) menu->parent;
    u8* const moves = UnitGetMoveList(proc->unit);
	int i = (command->commandDefinitionIndex)-1;
    u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);

    Text_Clear(&command->text);
	Text_SetXCursor(&command->text, new_item_desc_offset);
    Text_SetColorId(&command->text, TEXT_COLOR_BLUE);
    Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(moves[i]))); 
	Text_Display(&command->text, out); 
	Text_SetXCursor(&command->text, 0);

    LoadIconPalettes(4); /* Icon palette */

	if (IsMove(moves[i])) {
		DrawIcon(out + TILEMAP_INDEX(0, 0), GetItemIconId(moves[i]), TILEREF(0, 4)); 
		Text_SetXCursor(&command->text, item_name_offset);
		Text_SetColorId(&command->text, TEXT_COLOR_BLUE);
		Text_DrawString(&command->text, GetItemName(moves[i])); 
		}
	else {
		Text_SetColorId(&command->text, TEXT_COLOR_GRAY);
		Text_DrawString(&command->text, " No Move");
	}

}

static void ReplaceMoveCommandDraw(struct MenuProc* menu, struct MenuCommandProc* command)
{
    struct UnitListProc* const proc = (void*) menu->parent;
	DrawUnitInfo(menu, command, proc); 

}






static int MoveListCommandSelect(struct MenuProc* menu, struct MenuCommandProc* command)
{
    return ME_NONE;
}

/*
static const struct MenuCommandDefinition MenuCommands_Confirmation[] =
{
    {
        .isAvailable = MenuCommandAlwaysUsable,
        .onEffect = MoveCommandConfirm,
        .rawName = " Yes",
    },
    {
        .isAvailable = MenuCommandAlwaysUsable,
        .onEffect = MoveCommandDecline,
        .rawName = " No",
    },	
	
};


static int ClearStuff(struct MenuProc* menu)
{
    return ME_CLEAR_GFX;
}

static const struct MenuDefinition Menu_Confirmation =
{
    .geometry = { 196, 0, 0, 0 }, // The box 
	//.onInit = ClearStuff,
    .commandList = MenuCommands_Confirmation,

    //.onEnd = UnitListMenuEnd,
	//.onBPress = (void*) (ReturnTMIfUnused),
};



static const struct ProcInstruction Proc_Confirmation[] =
{
    PROC_CALL_ROUTINE(LockGameLogic),

    PROC_YIELD,

    PROC_CALL_ROUTINE(UnlockGameLogic),
    PROC_END,
	
	
void ClearBG0BG1(void); //! FE8U = 0x804E885

void LoadGameCoreGfx(void);
};

static const struct ProcInstruction Proc_Confirmation[] =
{
    PROC_CALL_ROUTINE(LockGameLogic),
    PROC_YIELD,

    PROC_CALL_ROUTINE(UnlockGameLogic),
    PROC_END,
};


static int MoveCommandConfirm(struct MenuProc* menu, struct MenuCommandProc* command)
{

    struct UnitListProc* const proc = (void*) menu->parent;
    UnitGetMoveList(proc->unit)[proc->move_hovering] = proc->moveReplacement;
	return ME_DISABLE | ME_END | ME_PLAY_BEEP | ME_CLEAR_GFX;
}

static int MoveCommandDecline(struct MenuProc* menu, struct MenuCommandProc* command)
{
    struct UnitListProc* const proc = (void*) menu->parent;
    UnitGetMoveList(proc->unit)[proc->move_hovering] = proc->moveReplacement;
	return ME_DISABLE | ME_END | ME_PLAY_BEEP | ME_CLEAR_GFX;
}

*/



static int CommandSelect(struct MenuProc* menu, struct MenuCommandProc* command)
{
    struct UnitListProc* const proc = (void*) menu->parent;
    //UnitGetMoveList(proc->unit)[proc->move_hovering] = proc->moveReplacement;
	int* MemorySlot5 = (int*) 0x30004CC; 
	
	*MemorySlot5 = proc->move_hovering; 
	
	int* MemorySlot6 = (int*) 0x30004D0; 
	
	*MemorySlot6 = 1; // TRUE 

	
	// Assuming newMenuDefinition and parent are already defined as pointers.
	// This geometry is for the hand cursor?
	//MenuGeometry ConfirmationMenuGeometry = { .x = 196, .y = 0, .h = 0, .w = 0 }; // Fill these with your own values. Also, you don't need to declare this as "struct MenuGeometry" because of the typedef at the top of menu.h.

	//struct ConfirmationProc* proc_confirm = (void*) ProcStart(Proc_Confirmation, ROOT_PROC_3);
	//EndMenu(menu);

	//StartMenuAt(&Menu_Confirmation, ConfirmationMenuGeometry, (void*) proc_confirm);

	//MenuProc* Menu_Confirmation = StartMenuAt(Menu_Confirmation, ConfirmationMenuGeometry, (void*) /*proc*/ Proc_Confirmation);
	
	//StartMenuAt(&Menu_Confirmation, ConfirmationMenuGeometry, (void*) proc);
	//StartMenuExt2(&Menu_Confirmation, backBgId, baseTile, frontBgId, idk, (void*) proc);
	
	return ME_DISABLE | ME_END | ME_PLAY_BEEP | ME_CLEAR_GFX;
	//return ME_DISABLE | ME_END | ME_PLAY_BEEP | ME_CLEAR_GFX;
}


   





static void UnitListMenuEnd(struct MenuProc* menu)
{
    EndFaceById(0);
}
