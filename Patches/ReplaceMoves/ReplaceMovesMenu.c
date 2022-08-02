
#include "gbafe.h"


enum { UNIT_SKILL_COUNT = 5 };


extern u16 gBG0MapBuffer[32][32];
extern u16 gBG1MapBuffer[32][32]; // 0x020234A8.


#define Icons_Spacing 0
#define item_name_offset 16
#define item_y_offset 8

#define new_item_name_offset 48
#define new_item_icon_offset 13

#define new_item_desc_offset 72

#define menu_tile_X 1
#define menu_tile_Y 0
#define menu_Length 29 //29

#define item_menu_tile_X 13
#define item_menu_tile_Y 0
#define item_menu_Length 16



#define portrait_pos_a 144 
#define portrait_pos_b 16 



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







static
int UnitCountSkills(struct Unit* unit)
{
    u8* const moves = UnitGetMoveList(unit);

    int count = 0;

    for (int i = 0; i < UNIT_SKILL_COUNT && moves[i]; ++i)
        count++;

    return count;
}

static
void UnitClearBlankSkills(struct Unit* unit)
{
    u8* const moves = UnitGetMoveList(unit);

    int iIn = 0, iOut = 0;

    for (; iIn < UNIT_SKILL_COUNT; ++iIn)
    {
        if (moves[iIn])
            moves[iOut++] = moves[iIn];
    }

    for (; iOut < UNIT_SKILL_COUNT; ++iOut)
        moves[iOut] = 0;
}

static void SkillListCommandDraw_1(struct MenuProc* menu, struct MenuCommandProc* command);

static void NewMoveDetailsDraw(struct MenuProc* menu, struct MenuCommandProc* command);
static int MoveCommandSelect(struct MenuProc* menu, struct MenuCommandProc* command);
static int MoveCommandConfirm(struct MenuProc* menu, struct MenuCommandProc* command);
static int MoveCommandDecline(struct MenuProc* menu, struct MenuCommandProc* command);
static int List_Idle(struct MenuProc* menu, struct MenuCommandProc* command);

static int SkillListCommandIdle(struct MenuProc* menu, struct MenuCommandProc* command);
static int SkillListCommandSelect(struct MenuProc* menu, struct MenuCommandProc* command);

static int RemoveSkillCommandSelect(struct MenuProc* menu, struct MenuCommandProc* command);

static void ReplaceSkillCommandDraw(struct MenuProc* menu, struct MenuCommandProc* command);

static int ReplaceSkillCommandIdle(struct MenuProc* menu, struct MenuCommandProc* command);
static int ReplaceSkillCommandSelect(struct MenuProc* menu, struct MenuCommandProc* command);

static void SkillDebugMenuEnd(struct MenuProc* menu);

short GetNewSkill(const struct Unit*); //0x202BCDE;

struct SkillDebugProc
{
    /* 00 */ PROC_HEADER; // this ends at +29
	    /* 2C */ short skillReplacement;
    /* 30 */ struct Unit* unit;
    /* 30 */ int movesUpdated;
    /* 34 */ int skillSelected;


			
			int hover_move_Updated; // 0x38 

			int move_hovering; // 0x3c 
			int a; // 0x40  
			int b; // 0x44 
			int c; // 0x48 
			int d; // 0x4c 
			int e; // 0x50 
			int f; // 0x54 
			u32 weapon; // 0x58 
};

/*
int someInt;
PUSH(T9);
POPVAR(someInt);
someFunc(someInt);
*/
/*int func(int arg1, int arg2, int arg3, int arg4) { // ... */ 


extern void PostForgetOldMoveMenu(void);
extern void BPressForgetOldMoveMenu(void);

static const struct ProcInstruction Proc_SkillDebug[] =
{
    PROC_CALL_ROUTINE(LockGameLogic),

    PROC_YIELD,
    PROC_CALL_ROUTINE(PostForgetOldMoveMenu),
    PROC_CALL_ROUTINE(UnlockGameLogic),
    PROC_END,
};

/*
static const struct MenuCommandDefinition MenuCommands_ItemDetails[] =
{
	{
        .isAvailable = MenuCommandAlwaysUsable,

        .onDraw = NewMoveDetailsDraw,
    },
	
	{}
};
*/

static const struct MenuCommandDefinition MenuCommands_SkillDebug[] =
{
    {
        .isAvailable = MenuCommandAlwaysUsable,
        .onEffect = SkillListCommandSelect,
        .onDraw = ReplaceSkillCommandDraw,
		.onIdle = List_Idle
        /*.onIdle = ReplaceSkillCommandIdle,*/

    },

    {
        .isAvailable = MenuCommandAlwaysUsable,

        .onDraw = SkillListCommandDraw_1,
		.onIdle = List_Idle,
        .onEffect = MoveCommandSelect,
    },
	
	
    {
		.isAvailable = MenuCommandAlwaysUsable,

        .onDraw = SkillListCommandDraw_1,
		.onIdle = List_Idle,
		
        .onEffect = MoveCommandSelect,
    },
	
    {
		.isAvailable = MenuCommandAlwaysUsable,

        .onDraw = SkillListCommandDraw_1,
		.onIdle = List_Idle,
        .onEffect = MoveCommandSelect,
    },
	
	
    {
		.isAvailable = MenuCommandAlwaysUsable,

        .onDraw = SkillListCommandDraw_1,
		.onIdle = List_Idle,
        .onEffect = MoveCommandSelect,
    },
    {
		.isAvailable = MenuCommandAlwaysUsable,

        .onDraw = SkillListCommandDraw_1,
		.onIdle = List_Idle,
        .onEffect = MoveCommandSelect,
    },

	
    {} // END
};

void DrawItemInfo(struct SkillDebugProc* proc);

static void NewMoveDetailsDraw(struct MenuProc* menu, struct MenuCommandProc* command)
{
    struct SkillDebugProc* const proc = (void*) menu->parent;

    u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);

    Text_Clear(&command->text);

    Text_DrawString(&command->text, " Learnwetr");



    
	
    Text_SetColorId(&command->text, TEXT_COLOR_NORMAL);
	Text_DrawString(&command->text, " asdf");
	
    /*Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(proc->skillReplacement))); 
	Text_SetXCursor(&command->text, 158); 
	*/
	

    Text_Display(&command->text, out);

    DrawIcon(
        out + TILEMAP_INDEX(5, 0), /* Bottom left offset of icon to give the unit         */ 
        GetItemIconId(proc->skillReplacement), TILEREF(0, 4)); /* Palette? */  /* */
}







static const struct MenuDefinition Menu_SkillDebug =
{
    .geometry = { menu_tile_X, menu_tile_Y, menu_Length },
    .commandList = MenuCommands_SkillDebug,

    .onEnd = SkillDebugMenuEnd,
	
    //.onBPress = (void*) (0x08022860+1), // FIXME
	.onBPress = (void*) (BPressForgetOldMoveMenu), // Now in the proc call routine 
};

extern const ProcCode gProc_8A01650[]; 
int SkillDebugCommand_OnSelect(struct MenuProc* menu, struct MenuCommandProc* command)
{
    struct SkillDebugProc* proc = (void*) ProcStart(Proc_SkillDebug, ROOT_PROC_3);
    //struct SkillDebugProc* proc2 = (void*) ProcStart(&gProc_8A01650[0], ROOT_PROC_3);
	//proc2->weapon = 0x01; 
	
	int* gVeslyUnit = (int*) 0x30017BC;
	int* gVeslySkill = (int*) 0x0202BCDE;	
	proc->skillReplacement = *gVeslySkill; // Short 
    proc->unit = (struct Unit*) *gVeslyUnit; // Struct UnitRamPointer 

	
	int* MemorySlot1 = (int*) 0x30004BC;
	int* MemorySlot3 = (int*) 0x30004C4; 
	int* MemorySlot4 = (int*) 0x30004C8; 
	
	*MemorySlot1 = proc->unit; 
	*MemorySlot3 = 0xF8;
	*MemorySlot4 = proc->skillReplacement; 

	int* MemorySlot6 = (int*) 0x30004D0; 
	*MemorySlot6 = 0; // TRUE 

	
    proc->movesUpdated = FALSE;
    proc->skillSelected = 0;
	
    /*proc->skillReplacement = 1; // assumes skill #1 is valid */
	
	proc->hover_move_Updated = FALSE; 
	proc->move_hovering = 0;
    StartMenuChild(&Menu_SkillDebug, (void*) proc);
    return ME_DISABLE | ME_END | ME_PLAY_BEEP | ME_CLEAR_GFX;
}

static void PrepareText(TextHandle* handle, char* string)
{
	u32 width = (Text_GetStringTextWidth(string)+8)/8;
	Text_InitClear(handle, width); 
    handle->tileWidth = width;
	
	Text_SetColorId(handle,TEXT_COLOR_GOLD);
	Text_DrawString(handle,string);
	//Text_Display(&handle,&gBG0MapBuffer[y][x]);
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

void DrawItemInfo(struct SkillDebugProc* proc)
{
	for (int x = 0; x < 30; x++) { // clear out most of bg0 
		for (int y = 14; y < 20; y++) { 
			gBG0MapBuffer[y][x] = 0;
		}
	}
	BgMap_ApplyTsa(&gBG1MapBuffer[14][5], &ReplaceMovesTSA, 0);
	
	
	Text_ResetTileAllocation();
	u8 hover = proc->move_hovering-1; 
	
	if (proc->move_hovering > UNIT_SKILL_COUNT) { 
		proc->weapon = proc->skillReplacement;
	} 
	else { 
		proc->weapon = UnitGetMoveList(proc->unit)[hover];
	} 
	u16 item = proc->weapon; 
	
	//StartDrawDialogProcs(0x01, 0x14A7); // weapon, descID 
	//gHelpBox_RMenu = ST_Level; 
	

	TextHandle handles[20] = {};
	for ( int i = 0 ; i < 20 ; i++ )
	{
		handles[i].xCursor = 0;
		//handles[i].tileIndexOffset = 0x180;
		handles[i].colorId = TEXT_COLOR_NORMAL;
		handles[i].useDoubleBuffer = 0;
		handles[i].currentBufferId = 0;
		handles[i].unk07 = 0;
	}
	
	u8 i = 0; 
	u8 x = 6; 
	PrepareText(&handles[i], GetWeaponTypeDisplayString(GetItemType(item)));
	Text_Display(&handles[i], &gBG0MapBuffer[15][0+x]); i++; 
	PrepareText(&handles[i], GetItemDisplayRankString(item));
	Text_Display(&handles[i], &gBG0MapBuffer[15][5+x]); i++; 
	
	PrepareText(&handles[i], " Rng");
	Text_Display(&handles[i], &gBG0MapBuffer[15][7+x]); i++; 
	PrepareText(&handles[i], GetItemDisplayRangeString(item));
	Text_Display(&handles[i], &gBG0MapBuffer[15][10+x]); i++; 
	
	PrepareText(&handles[i], " Wt");
	Text_Display(&handles[i], &gBG0MapBuffer[15][14+x]); i++; 
	DrawUiNumber(&gBG0MapBuffer[15][18+x], TEXT_COLOR_GOLD, GetItemWeight(item)); 
	
	PrepareText(&handles[i], "Dmg");
	Text_Display(&handles[i], &gBG0MapBuffer[17][0+x]); i++; 
	DrawUiNumber(&gBG0MapBuffer[17][5+x], TEXT_COLOR_GOLD, GetItemMight(item));
	
	
	PrepareText(&handles[i], " Hit");
	Text_Display(&handles[i], &gBG0MapBuffer[17][7+x]); i++; 
	DrawUiNumber(&gBG0MapBuffer[17][12+x], TEXT_COLOR_GOLD, GetItemHit(item)); 
	
	PrepareText(&handles[i], " Crit");
	Text_Display(&handles[i], &gBG0MapBuffer[17][14+x]); i++; 
	DrawUiNumber(&gBG0MapBuffer[17][18+x], TEXT_COLOR_GOLD, GetItemCrit(item)); 
	
	EnableBgSyncByMask(BG0_SYNC_BIT);
	EnableBgSyncByMask(BG1_SYNC_BIT);

} 



static int List_Idle(struct MenuProc* menu, struct MenuCommandProc* command)
{
    struct SkillDebugProc* const proc = (void*) menu->parent;
    u8* const moves = UnitGetMoveList(proc->unit);		
	if (proc->move_hovering != menu->commandIndex)
	{   
		proc->hover_move_Updated = TRUE;
		proc->move_hovering = menu->commandIndex;
		DrawItemInfo(proc); 
		/*         proc->movesUpdated = TRUE; */
	}
	if (gKeyState.repeatedKeys & KEY_BUTTON_R) { 
		MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering]));
	}
	
	
    return ME_NONE;
}


static void SkillListCommandDraw_1(struct MenuProc* menu, struct MenuCommandProc* command)
{
    struct SkillDebugProc* const proc = (void*) menu->parent;
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








static int SkillListCommandIdle(struct MenuProc* menu, struct MenuCommandProc* command)
{
    struct SkillDebugProc* const proc = (void*) menu->parent;

    if (gKeyState.repeatedKeys & KEY_DPAD_LEFT)
    {
        if (proc->skillSelected != 0)
            proc->skillSelected--;

        PlaySfx(0x6B);
    }

    if (gKeyState.repeatedKeys & KEY_DPAD_RIGHT)
    {
        if (proc->skillSelected + 1 < UNIT_SKILL_COUNT && UnitGetMoveList(proc->unit)[proc->skillSelected] != 0)
            proc->skillSelected++;

        PlaySfx(0x6B);
    }

    return ME_NONE;
}

static int SkillListCommandSelect(struct MenuProc* menu, struct MenuCommandProc* command)
{
    return ME_NONE;
}

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

    //.onEnd = SkillDebugMenuEnd,
	//.onBPress = (void*) (ReturnTMIfUnused),
};



/*static const struct ProcInstruction Proc_Confirmation[] =
{
    PROC_CALL_ROUTINE(LockGameLogic),

    PROC_YIELD,

    PROC_CALL_ROUTINE(UnlockGameLogic),
    PROC_END,
	
	
void ClearBG0BG1(void); //! FE8U = 0x804E885

void LoadGameCoreGfx(void);
};*/

static const struct ProcInstruction Proc_Confirmation[] =
{
    PROC_CALL_ROUTINE(LockGameLogic),
    PROC_YIELD,

    PROC_CALL_ROUTINE(UnlockGameLogic),
    PROC_END,
};




static int MoveCommandSelect(struct MenuProc* menu, struct MenuCommandProc* command)
{
    struct SkillDebugProc* const proc = (void*) menu->parent;
	u8* const moves = UnitGetMoveList(proc->unit);
    u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
    //UnitGetMoveList(proc->unit)[proc->move_hovering] = proc->skillReplacement;
	int* MemorySlot5 = (int*) 0x30004CC; 
	
	*MemorySlot5 = proc->move_hovering; 
	
	int* MemorySlot6 = (int*) 0x30004D0; 
	
	*MemorySlot6 = 1; // TRUE 
	
	/*
	int backBgId = 2;
	static u16 const baseTile = TILEREF(1, 1);
	int frontBgId = 3; 
	int idk = 0; 
	*/
	
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


   

static int MoveCommandConfirm(struct MenuProc* menu, struct MenuCommandProc* command)
{

    struct SkillDebugProc* const proc = (void*) menu->parent;
	u8* const moves = UnitGetMoveList(proc->unit);
    u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
    UnitGetMoveList(proc->unit)[proc->move_hovering] = proc->skillReplacement;
	

	
	return ME_DISABLE | ME_END | ME_PLAY_BEEP | ME_CLEAR_GFX;
}

static int MoveCommandDecline(struct MenuProc* menu, struct MenuCommandProc* command)
{
    struct SkillDebugProc* const proc = (void*) menu->parent;
	u8* const moves = UnitGetMoveList(proc->unit);
    u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
    UnitGetMoveList(proc->unit)[proc->move_hovering] = proc->skillReplacement;
	

	
	return ME_DISABLE | ME_END | ME_PLAY_BEEP | ME_CLEAR_GFX;
}




static int RemoveSkillCommandSelect(struct MenuProc* menu, struct MenuCommandProc* command)
{
    struct SkillDebugProc* const proc = (void*) menu->parent;

    UnitGetMoveList(proc->unit)[proc->skillSelected] = 0;
    UnitClearBlankSkills(proc->unit);

    proc->movesUpdated = TRUE;

    return ME_PLAY_BEEP;
}




static void ReplaceSkillCommandDraw(struct MenuProc* menu, struct MenuCommandProc* command)
{
    struct SkillDebugProc* const proc = (void*) menu->parent;
    u8* const moves = UnitGetMoveList(proc->unit);
    u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);

    //Text_Clear(&command->text);
	
	Text_SetXCursor(&command->text, 0);
	Text_SetColorId(&command->text, TEXT_COLOR_GREEN);
    Text_DrawString(&command->text, "Learn ");
	Text_Display(&command->text, out); 

	//Text_SetXCursor(&command->text, new_item_desc_offset+new_item_name_offset);
	Text_SetXCursor(&command->text, new_item_name_offset);
    Text_SetColorId(&command->text, TEXT_COLOR_BLUE);
    Text_DrawString(&command->text, GetItemName(proc->skillReplacement)); 
	Text_Display(&command->text, out); 

/*
    Text_SetXCursor(&command->text, 58);
    Text_SetColorId(&command->text, TEXT_COLOR_BLUE);

    Text_DrawString(&command->text, GetItemName(proc->skillReplacement)); 

    Text_Display(&command->text, out); 
	*/
	

	LoadIconPalettes(4); 
    DrawIcon(
        out + TILEMAP_INDEX(new_item_icon_offset, 0), 
        GetItemIconId(proc->skillReplacement), TILEREF(0, 4)); 
		
	List_Idle(menu, command); 

}



static int ReplaceSkillCommandIdle(struct MenuProc* menu, struct MenuCommandProc* command)
{
    struct SkillDebugProc* const proc = (void*) menu->parent;

    int updated = FALSE;

    if (gKeyState.repeatedKeys & KEY_DPAD_LEFT)
    {
        unsigned id = proc->skillReplacement;

        do
        {
            id = (id - 1) % 0x100;
        }
        while (!IsMove(id));

        updated = (proc->skillReplacement != id);
        proc->skillReplacement = id;

        PlaySfx(0x6B);
    }

    if (gKeyState.repeatedKeys & KEY_DPAD_RIGHT)
    {
        unsigned id = proc->skillReplacement;

        do
        {
            id = (id + 1) % 0x100;
        }
        while (!IsMove(id));

        updated = (proc->skillReplacement != id);
        proc->skillReplacement = id;

        PlaySfx(0x6B);
    }

    if (updated)
    {
		/*
        ClearIcons();

        ReplaceSkillCommandDraw(menu, command);
        /*EnableBgSyncByMask(BG0_SYNC_BIT);*/

        // This is to force redraw skill icons
        proc->movesUpdated = TRUE;
    }

    return ME_NONE;
}

    //proc->movesUpdated = TRUE;

static int ReplaceSkillCommandSelect(struct MenuProc* menu, struct MenuCommandProc* command)
{
    struct SkillDebugProc* const proc = (void*) menu->parent;

    UnitGetMoveList(proc->unit)[proc->skillSelected] = proc->skillReplacement;

	EndMenu(menu);

    return ME_PLAY_BEEP;
}

static void SkillDebugMenuEnd(struct MenuProc* menu)
{
    EndFaceById(0);
}
