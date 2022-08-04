
#include "gbafe.h"


enum { UNIT_MOVE_COUNT = 5 };


extern u16 gBG0MapBuffer[32][32];
extern u16 gBG1MapBuffer[32][32]; // 0x020234A8.


#define item_name_offset 16
#define new_item_name_offset 48
#define new_item_icon_offset 13
#define new_item_desc_offset 72

#define menu_tile_X 1
#define menu_tile_Y 0
#define menu_Length 29 //29






/*extern const ItemData gItemData[]; */ 
char* GetItemName(int item); 

static
u8* UnitGetMoveList(struct Unit* unit)
{
	return unit->ranks; 
}

static
int IsMove(int moveId)
{
    if (moveId == 0)
        return FALSE;

    if (moveId == 255)
        return FALSE;

    return GetItemDescId(moveId);
}











static void MoveListCommandDraw(struct MenuProc* menu, struct MenuCommandProc* command);
static int MoveCommandSelect(struct MenuProc* menu, struct MenuCommandProc* command);
//static int MoveCommandConfirm(struct MenuProc* menu, struct MenuCommandProc* command);
//static int MoveCommandDecline(struct MenuProc* menu, struct MenuCommandProc* command);
static int List_Idle(struct MenuProc* menu, struct MenuCommandProc* command);
static int MoveListCommandSelect(struct MenuProc* menu, struct MenuCommandProc* command);
static void ReplaceMoveCommandDraw(struct MenuProc* menu, struct MenuCommandProc* command);
static void ReplaceMoveMenuEnd(struct MenuProc* menu);



struct ReplaceMoveProc
{
    /* 00 */ PROC_HEADER; // this ends at +29
    /* 2C */ struct Unit* unit;
    /* 30 */ u8 movesUpdated;
			u8 moveSelected;
			u8 hover_move_Updated; 
			u8 move_hovering; // 
			u16 moveReplacement; // 0x34 
			u16 tileNext; 
			struct TextHandle handle[3]; // 0x38 - 0x4F 
};


extern void PostForgetOldMoveMenu(void);
extern void BPressForgetOldMoveMenu(void);

static const struct ProcInstruction Proc_ReplaceMove[] =
{
    PROC_CALL_ROUTINE(LockGameLogic),

    PROC_YIELD,
    PROC_CALL_ROUTINE(PostForgetOldMoveMenu),
    PROC_CALL_ROUTINE(UnlockGameLogic),
    PROC_END,
};

static const struct MenuCommandDefinition MenuCommands_ReplaceMove[] =
{
    {
        .isAvailable = MenuCommandAlwaysUsable,
        .onEffect = MoveListCommandSelect,
        .onDraw = ReplaceMoveCommandDraw,
		.onIdle = List_Idle

    },

    {
        .isAvailable = MenuCommandAlwaysUsable,

        .onDraw = MoveListCommandDraw,
		.onIdle = List_Idle,
        .onEffect = MoveCommandSelect,
    },
	
	
    {
		.isAvailable = MenuCommandAlwaysUsable,

        .onDraw = MoveListCommandDraw,
		.onIdle = List_Idle,
		
        .onEffect = MoveCommandSelect,
    },
	
    {
		.isAvailable = MenuCommandAlwaysUsable,

        .onDraw = MoveListCommandDraw,
		.onIdle = List_Idle,
        .onEffect = MoveCommandSelect,
    },
	
	
    {
		.isAvailable = MenuCommandAlwaysUsable,

        .onDraw = MoveListCommandDraw,
		.onIdle = List_Idle,
        .onEffect = MoveCommandSelect,
    },
    {
		.isAvailable = MenuCommandAlwaysUsable,

        .onDraw = MoveListCommandDraw,
		.onIdle = List_Idle,
        .onEffect = MoveCommandSelect,
    },

	
    {} // END
};

void DrawItemInfo(struct MenuProc* menu, struct MenuCommandProc* command, struct ReplaceMoveProc* proc);
void UpdateItemInfo(struct MenuProc* menu, struct MenuCommandProc* command, struct ReplaceMoveProc* proc);


static const struct MenuDefinition Menu_ReplaceMoveDebug =
{
    .geometry = { menu_tile_X, menu_tile_Y, menu_Length },
    .commandList = MenuCommands_ReplaceMove,

    .onEnd = ReplaceMoveMenuEnd,
	
    //.onBPress = (void*) (0x08022860+1), // FIXME
	.onBPress = (void*) (BPressForgetOldMoveMenu), // Now in the proc call routine 
};

extern const ProcCode gProc_8A01650[]; 
int ReplaceMoveCommand_OnSelect(struct MenuProc* menu, struct MenuCommandProc* command)
{
    struct ReplaceMoveProc* proc = (void*) ProcStart(Proc_ReplaceMove, ROOT_PROC_3);
    //struct ReplaceMoveProc* proc2 = (void*) ProcStart(&gProc_8A01650[0], ROOT_PROC_3);
	
	int* gVeslyUnit = (int*) 0x30017BC;
	int* gVeslySkill = (int*) 0x0202BCDE;	
	proc->moveReplacement = *gVeslySkill; // Short 
    proc->unit = (struct Unit*) *gVeslyUnit; // Struct UnitRamPointer 

	
	int* MemorySlot1 = (int*) 0x30004BC;
	int* MemorySlot3 = (int*) 0x30004C4; 
	int* MemorySlot4 = (int*) 0x30004C8; 
	
	*MemorySlot1 = (void*)proc->unit; 
	*MemorySlot3 = 0xF8;
	*MemorySlot4 = proc->moveReplacement; 

	int* MemorySlot6 = (int*) 0x30004D0; 
	*MemorySlot6 = 0; // TRUE 

	
    proc->movesUpdated = FALSE;
    proc->moveSelected = 0;
	
	
	proc->hover_move_Updated = FALSE; 
	proc->move_hovering = 0;
    StartMenuChild(&Menu_ReplaceMoveDebug, (void*) proc);
    return ME_DISABLE | ME_END | ME_PLAY_BEEP | ME_CLEAR_GFX;
}




// stuff from A00AD0 HelpTextBubble
// 203E784
extern void* gHelpBox_RMenu; // RMenu(up,down,left,right,xcoord,ycoord,SlotID,Looper,Getter) "POIN up down left right; BYTE xcoord ycoord; SHORT SlotID; POIN Looper|1 Getter|1"

extern void* gText_HelpBox; // 0x203E794 
extern void* gText_HelpBoxTextOffset; //  0x203E7AC



extern void StartDrawDialogProcs(int item, u16 descTextId); // 0x808A0FC

extern void DrawHelpBoxWeaponStatLabels(int item); // 0x8089C40 
extern void MakeHelpDialog_WeaponDetail(int item); // 0x8089CD4
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



void DrawItemInfo(struct MenuProc* menu, struct MenuCommandProc* command, struct ReplaceMoveProc* proc)
{
	for (int x = 0; x < 30; x++) { // clear out most of bg0 
		for (int y = 0; y < 20; y++) { 
			gBG0MapBuffer[y][x] = 0;
		}
	}
	BgMap_ApplyTsa(&gBG1MapBuffer[14][5], &ReplaceMovesTSA, 0);
	// [2000932..2000933]!!
	// [2028E6a..2028E6b]!! 
	// 0x8004a9e 
	
	Text_ResetTileAllocation();

	//u16 tile = gpCurrentFont->tileNext; 
	// u16 tileNext starts at 0 when ResetTileAllocation is used (vram 0x6001000) 
	// 

	menu->pCommandProc[0]->text.tileIndexOffset = gpCurrentFont->tileNext; 
	
	menu->pCommandProc[0]->text.tileWidth = 92;
	// update tileNext to be whatever we offset it to 
	// in this case it's 0, but it would be important if it wasn't 
	// menu starts at tileNext as 0 (and draws spaces as needed) 
	for (u8 c = 1; c <= menu->commandCount; c++) { 
		gpCurrentFont->tileNext = menu->pCommandProc[c-1]->text.tileIndexOffset + menu->pCommandProc[c-1]->text.tileWidth; 
		menu->pCommandProc[c]->text.tileIndexOffset =  gpCurrentFont->tileNext; 
	} 
	//menu->pCommandProc[1]->text.currentBufferId = 0; //handles[i].currentBufferId;
	MoveListCommandDraw(menu, menu->pCommandProc[1]); 
	MoveListCommandDraw(menu, menu->pCommandProc[2]); 
	MoveListCommandDraw(menu, menu->pCommandProc[3]); 
	MoveListCommandDraw(menu, menu->pCommandProc[4]); 
	MoveListCommandDraw(menu, menu->pCommandProc[5]); 
	
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
	
	u8 i = 0; 
	u8 x = 6; 
	
	
	u32 width = (Text_GetStringTextWidth("Learn ")+8)/8;
	Text_InitClear(&handles[i], width); 
    handles[i].tileWidth = width;
	//Text_SetXCursor(&handles[i], 0);
	Text_SetColorId(&handles[i], TEXT_COLOR_GREEN);
    Text_DrawString(&handles[i], "Learn ");
	Text_Display(&handles[i], &gBG0MapBuffer[1][8]); i++; 


	//Text_SetXCursor(&handles[i], new_item_desc_offset+new_item_name_offset);
	width = (Text_GetStringTextWidth(GetItemName(proc->moveReplacement))+8)/8;
	Text_InitClear(&handles[i], width); 
    handles[i].tileWidth = width;
	//Text_SetXCursor(&handles[i], new_item_name_offset);
    Text_SetColorId(&handles[i], TEXT_COLOR_BLUE);
    Text_DrawString(&handles[i], GetItemName(proc->moveReplacement)); 
	Text_Display(&handles[i], &gBG0MapBuffer[1][17]); i++; 	
	

	
	
	

	

	


	proc->tileNext = gpCurrentFont->tileNext; 
	
	//PrepareText(&handles[i], " Rng");
	//Text_Display(&handles[i], &gBG0MapBuffer[15][7+x]); i++; 
	//
	//PrepareText(&handles[i], " Wt");
	//Text_Display(&handles[i], &gBG0MapBuffer[15][14+x]); i++; 
	//
	//PrepareText(&handles[i], "Dmg");
	//Text_Display(&handles[i], &gBG0MapBuffer[17][0+x]); i++; 
	//PrepareText(&handles[i], " Hit");
	//Text_Display(&handles[i], &gBG0MapBuffer[17][7+x]); i++; 
	//PrepareText(&handles[i], " Crit");
	//Text_Display(&handles[i], &gBG0MapBuffer[17][14+x]); i++; 

	//u8* const moves = UnitGetMoveList(proc->unit);
    u16* const out = gBg0MapBuffer + TILEMAP_INDEX(2, 1);
	LoadIconPalettes(4); 
    DrawIcon(
        out + TILEMAP_INDEX(new_item_icon_offset, 0), 
        GetItemIconId(proc->moveReplacement), TILEREF(0, 4)); 

	EnableBgSyncByMask(BG0_SYNC_BIT);
	EnableBgSyncByMask(BG1_SYNC_BIT);
	
	//asm("mov r11, r11");
	
	
	UpdateItemInfo(menu, command, proc); 

	
	
} 

/*
static void PrepareNum(TextHandle* handle, int num)
{
	u32 width = 1; 
	for (int n = num; n>0;) {
		n = n/10;
		width++; 
	} 
 
	//(Text_GetStringTextWidth(string)+8)/8;
	Text_InitClear(handle, width); 
    //handle->tileWidth = width;

	
	Text_SetColorId(handle,TEXT_COLOR_GOLD);
	Text_DrawNumber(handle, num);
}
*/

extern u8 gSpecialUiCharAllocationTable[]; // 0x2028E78

void UpdateItemInfo(struct MenuProc* menu, struct MenuCommandProc* command, struct ReplaceMoveProc* proc)
{

	for (int x = 0; x < 30; x++) { // clear out most of bg0 
		for (int y = 14; y < 20; y++) { 
			gBG0MapBuffer[y][x] = 0;
		}
	}

	u8 x = 6;
	
	u8 i = 0; 
	
	gpCurrentFont->tileNext = proc->tileNext; 
	u8 hover = proc->move_hovering-1; 
	u16 item; 
	
	if (proc->move_hovering == 0) { // UNIT_MOVE_COUNT) { 
		item = proc->moveReplacement;
	} 
	else { 
		item = UnitGetMoveList(proc->unit)[hover];
	} 
	
	TextHandle handles[5] = {};
	for ( int i = 0 ; i < 5 ; i++ )
	{
		//handles[i].tileIndexOffset = tile; // offset to start at 
		handles[i].xCursor = 0;
		//handles[i].tileIndexOffset = 0x180;
		handles[i].colorId = TEXT_COLOR_NORMAL;
		handles[i].useDoubleBuffer = 0;
		handles[i].currentBufferId = 0;
		handles[i].unk07 = 0;
	}
	
	
	PrepareText(&handles[i], " Rng");
	Text_Display(&handles[i], &gBG0MapBuffer[15][7+x]); i++; 

	PrepareText(&handles[i], " Wt");
	Text_Display(&handles[i], &gBG0MapBuffer[15][14+x]); i++; 
	
	PrepareText(&handles[i], "Dmg");
	Text_Display(&handles[i], &gBG0MapBuffer[17][0+x]); i++; 
	PrepareText(&handles[i], " Hit");
	Text_Display(&handles[i], &gBG0MapBuffer[17][7+x]); i++; 
	PrepareText(&handles[i], " Crit");
	Text_Display(&handles[i], &gBG0MapBuffer[17][14+x]); i++; 

	

	
	 
	PrepareText(&proc->handle[0], GetItemDisplayRankString(item));
	Text_Display(&proc->handle[0], &gBG0MapBuffer[15][5+x]); i++; 
	//gpCurrentFont->tileNext = gpCurrentFont->tileNext + 3; 
	// 0x8004AE8 = POIN gSpecialUiCharAllocationTable 
	PrepareText(&proc->handle[1], GetItemDisplayRangeString(item));
	Text_Display(&proc->handle[1], &gBG0MapBuffer[15][10+x]); i++; 
	//gpCurrentFont->tileNext = gpCurrentFont->tileNext + 3; 

	PrepareText(&proc->handle[2], GetWeaponTypeDisplayString(GetItemType(item)));
	Text_Display(&proc->handle[2], &gBG0MapBuffer[15][0+x]); i++; 
	
	
	gSpecialUiCharAllocationTable[0] = 0xFF; //no clue but it made DrawUiNumber work properly 

	DrawUiNumber(&gBG0MapBuffer[15][18+x], TEXT_COLOR_GOLD, GetItemWeight(item)); 
	DrawUiNumber(&gBG0MapBuffer[17][5+x], TEXT_COLOR_GOLD, GetItemMight(item));
	DrawUiNumber(&gBG0MapBuffer[17][12+x], TEXT_COLOR_GOLD, GetItemHit(item)); 
	DrawUiNumber(&gBG0MapBuffer[17][18+x], TEXT_COLOR_GOLD, GetItemCrit(item)); 
	



	EnableBgSyncByMask(BG0_SYNC_BIT);
}

static int List_Idle(struct MenuProc* menu, struct MenuCommandProc* command)
{
    struct ReplaceMoveProc* const proc = (void*) menu->parent;
    u8* const moves = UnitGetMoveList(proc->unit);		
	if (proc->move_hovering != menu->commandIndex)
	{   
		proc->hover_move_Updated = TRUE;
		proc->move_hovering = menu->commandIndex;
		UpdateItemInfo(menu, command, proc); 
		/*         proc->movesUpdated = TRUE; */
	}
	if (gKeyState.repeatedKeys & KEY_BUTTON_R) { 
		if (proc->move_hovering) { 
			MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering-1]));
		} 
		else { 
			MenuCallHelpBox(menu, GetItemDescId(proc->moveReplacement));
		} 
	}
	
	
    return ME_NONE;
}


static void MoveListCommandDraw(struct MenuProc* menu, struct MenuCommandProc* command)
{
    struct ReplaceMoveProc* const proc = (void*) menu->parent;
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
    struct ReplaceMoveProc* const proc = (void*) menu->parent;
	DrawItemInfo(menu, command, proc); 

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

    //.onEnd = ReplaceMoveMenuEnd,
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

    struct ReplaceMoveProc* const proc = (void*) menu->parent;
    UnitGetMoveList(proc->unit)[proc->move_hovering] = proc->moveReplacement;
	return ME_DISABLE | ME_END | ME_PLAY_BEEP | ME_CLEAR_GFX;
}

static int MoveCommandDecline(struct MenuProc* menu, struct MenuCommandProc* command)
{
    struct ReplaceMoveProc* const proc = (void*) menu->parent;
    UnitGetMoveList(proc->unit)[proc->move_hovering] = proc->moveReplacement;
	return ME_DISABLE | ME_END | ME_PLAY_BEEP | ME_CLEAR_GFX;
}

*/



static int MoveCommandSelect(struct MenuProc* menu, struct MenuCommandProc* command)
{
    struct ReplaceMoveProc* const proc = (void*) menu->parent;
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


   





static void ReplaceMoveMenuEnd(struct MenuProc* menu)
{
    EndFaceById(0);
}
