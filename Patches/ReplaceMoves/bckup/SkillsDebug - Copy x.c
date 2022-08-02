
#include "FE-CLib-master/include/gbafe.h"


enum { UNIT_SKILL_COUNT = 8 };

#define BG_SYNC_BIT(aBg) (1 << (aBg))
enum { BG0_SYNC_BIT = BG_SYNC_BIT(0) };

enum { BG1_SYNC_BIT = BG_SYNC_BIT(1) };




typedef unsigned char u8;
#define PUSH(reg) \
    __asm__ __volatile__("push\t{" #reg "}");
#define POP(reg) \
    __asm__ __volatile__("pop\t{" #reg "}");
#define POPVAR(var) \
    __asm__ __volatile__("pop\t{%0}" : "=r" (var));




/*

*/
	
/* 
int someInt;
PUSH(T9);
POPVAR(someInt);
someFunc(someInt);
*/


/*
#define Icons_Spacing 2 
#define menu_tile_X 1
#define menu_tile_Y 11
#define menu_Length 16

#define portrait_pos_a 72 
#define portrait_pos_b 16 


*/


#define Icons_Spacing 0
#define item_name_offset 16
#define item_y_offset 8

#define new_item_name_offset 48
#define new_item_icon_offset 13

#define new_item_desc_offset 72

#define menu_tile_X 1
#define menu_tile_Y 0
#define menu_Length 29

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
static void SkillListCommandDraw_2(struct MenuProc* menu, struct MenuCommandProc* command);
static void SkillListCommandDraw_3(struct MenuProc* menu, struct MenuCommandProc* command);
static void SkillListCommandDraw_4(struct MenuProc* menu, struct MenuCommandProc* command);
static void SkillListCommandDraw_5(struct MenuProc* menu, struct MenuCommandProc* command);
static void SkillListCommandDraw_6(struct MenuProc* menu, struct MenuCommandProc* command);
static void SkillListCommandDraw_7(struct MenuProc* menu, struct MenuCommandProc* command);
static void SkillListCommandDraw_8(struct MenuProc* menu, struct MenuCommandProc* command);

static void NewMoveDetailsDraw(struct MenuProc* menu, struct MenuCommandProc* command);
static int MoveCommandSelect(struct MenuProc* menu, struct MenuCommandProc* command);

static int List_1_Idle(struct MenuProc* menu, struct MenuCommandProc* command);
static int List_2_Idle(struct MenuProc* menu, struct MenuCommandProc* command);
static int List_3_Idle(struct MenuProc* menu, struct MenuCommandProc* command);
static int List_4_Idle(struct MenuProc* menu, struct MenuCommandProc* command);
static int List_5_Idle(struct MenuProc* menu, struct MenuCommandProc* command);
static int List_6_Idle(struct MenuProc* menu, struct MenuCommandProc* command);
static int List_7_Idle(struct MenuProc* menu, struct MenuCommandProc* command);
static int List_8_Idle(struct MenuProc* menu, struct MenuCommandProc* command);

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
	
    ///* 2C */ u32 skillReplacement_u32; // this is +29 aligned to the next 4 byte boundry, saved_r2 
	//			struct Unit* unit;
    ///* 30 */ u32 unit_u32;
	//		short skillReplacement;

			// Pointer to ram 

    /* 30 */ int movesUpdated;
    /* 34 */ int skillSelected;


			
			int hover_move_Updated;

			int move_hovering;
			
			

	
			/*#define PUSH(reg) \
				__asm__ __volatile__("addiu\t$sp, $sp, 0xfffc"); \
				__asm__ __volatile__("sw\t" #reg ", 0x0000 ($sp)")
			#define POP(reg) \
				__asm__ __volatile__("lw\t" #reg ", 0x0000 ($sp)"); \
				__asm__ __volatile__("addiu\t$sp, $sp, 0x0004")
			#define POPVAR(var) \
				__asm__ __volatile__("lw\t%0, 0x0000 ($sp)" : "=r" (var)); \
				__asm__ __volatile__("addiu\t$sp, $sp, 0x0004") */	
};

/*
int someInt;
PUSH(T9);
POPVAR(someInt);
someFunc(someInt);
*/
/*int func(int arg1, int arg2, int arg3, int arg4) { // ... */ 





static const struct ProcInstruction Proc_SkillDebug[] =
{
    PROC_CALL_ROUTINE(LockGameLogic),

    PROC_YIELD,

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
        /*.onIdle = ReplaceSkillCommandIdle,*/

    },

    {
        .isAvailable = MenuCommandAlwaysUsable,

        .onDraw = SkillListCommandDraw_1,
		.onIdle = List_1_Idle,
        .onEffect = MoveCommandSelect,
    },
	
	
    {
		.isAvailable = MenuCommandAlwaysUsable,

        .onDraw = SkillListCommandDraw_2,
		.onIdle = List_2_Idle,
		
        .onEffect = MoveCommandSelect,
    },
	
    {
		.isAvailable = MenuCommandAlwaysUsable,

        .onDraw = SkillListCommandDraw_3,
		.onIdle = List_3_Idle,
        .onEffect = MoveCommandSelect,
    },
	
	
    {
		.isAvailable = MenuCommandAlwaysUsable,

        .onDraw = SkillListCommandDraw_4,
		.onIdle = List_4_Idle,
        .onEffect = MoveCommandSelect,
    },
    {
		.isAvailable = MenuCommandAlwaysUsable,

        .onDraw = SkillListCommandDraw_5,
		.onIdle = List_5_Idle,
        .onEffect = MoveCommandSelect,
    },
    {
		.isAvailable = MenuCommandAlwaysUsable,
        .onDraw = SkillListCommandDraw_6,
		.onIdle = List_6_Idle,
        .onEffect = MoveCommandSelect,

    },
    {
		.isAvailable = MenuCommandAlwaysUsable,
        .onDraw = SkillListCommandDraw_7,
		.onIdle = List_7_Idle,
        .onEffect = MoveCommandSelect,

    },
	
    {
		.isAvailable = MenuCommandAlwaysUsable,
        .onDraw = SkillListCommandDraw_8,
		.onIdle = List_8_Idle,
        .onEffect = MoveCommandSelect,

    },
	
    {} // END
};


static void NewMoveDetailsDraw(struct MenuProc* menu, struct MenuCommandProc* command)
{
    struct SkillDebugProc* const proc = (void*) menu->parent;

    u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);

    Text_Clear(&command->text);

    Text_DrawString(&command->text, " Learn");



    
	
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





extern void ReturnTMIfUnused(void);

static const struct MenuDefinition Menu_SkillDebug =
{
    .geometry = { menu_tile_X, menu_tile_Y, menu_Length },
    .commandList = MenuCommands_SkillDebug,

    .onEnd = SkillDebugMenuEnd,
    //.onBPress = (void*) (0x08022860+1), // FIXME
	.onBPress = (void*) (ReturnTMIfUnused),
};



int SkillDebugCommand_OnSelect(struct MenuProc* menu, struct MenuCommandProc* command)
{
    struct SkillDebugProc* proc = (void*) ProcStart(Proc_SkillDebug, ROOT_PROC_3);



	
/*	proc->skillReplacement = test;
*/

	//test = (int)(long) proc->unit_u32;
	
//gpointer p;
//int i;
//p = (void*) (long) 42;
//i = (int) (long) p;

	//proc->unit = (void*) (long) test;
	//struct Unit* gVeslyUnit = (struct Unit*) 0x30017BC;
	
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

	

	
    proc->movesUpdated = FALSE;
    proc->skillSelected = 0;
    /*proc->skillReplacement = 1; // assumes skill #1 is valid */
	
	proc->hover_move_Updated = FALSE; 
	proc->move_hovering = 0;
    StartMenuChild(&Menu_SkillDebug, (void*) proc);
	

	
	

    return ME_DISABLE | ME_END | ME_PLAY_BEEP | ME_CLEAR_GFX;
}

static void SkillListCommandDrawIdle(struct MenuCommandProc* command)
{
    struct MenuProc* const menu = (void*) command->parent;
    struct SkillDebugProc* const proc = (void*) menu->parent;

    if ((proc->movesUpdated))
    {
        SkillListCommandDraw_2(menu, command);
        /*EnableBgSyncByMask(BG0_SYNC_BIT);*/

        proc->movesUpdated = FALSE;
    }

    if (gKeyState.repeatedKeys & KEY_BUTTON_L)
    {
        if (proc->skillSelected != 0)
            proc->skillSelected--;

        PlaySfx(0x6B);
    }

    if (gKeyState.repeatedKeys & KEY_BUTTON_R)
    {
        if (proc->skillSelected + 1 < UNIT_SKILL_COUNT && UnitGetMoveList(proc->unit)[proc->skillSelected] != 0)
            proc->skillSelected++;

        PlaySfx(0x6B);
    }

    ObjInsertSafe(0,
        command->xDrawTile*8 + (8*Icons_Spacing)*proc->skillSelected, /* X spacing of the upper hand cursor */ 
        command->yDrawTile*8 + 12,
        &gObj_16x16, TILEREF(6, 0)); /* The little hand cursor: y offset as -12 and TILEREF as 6,0 for above  */ 
}

static int List_1_Idle(struct MenuProc* menu, struct MenuCommandProc* command)
{
    struct SkillDebugProc* const proc = (void*) menu->parent;
	
	if (proc->move_hovering != 0)
	{   
		proc->hover_move_Updated = TRUE;
		proc->move_hovering = 0;
		/*         proc->movesUpdated = TRUE; */
	}
    return ME_NONE;
}


static int List_2_Idle(struct MenuProc* menu, struct MenuCommandProc* command)
{
    struct SkillDebugProc* const proc = (void*) menu->parent;
	
	if (proc->move_hovering != 1)
	{   
		proc->hover_move_Updated = TRUE;
		proc->move_hovering = 1;
		/*         proc->movesUpdated = TRUE; */
	}
    return ME_NONE;
}

static int List_3_Idle(struct MenuProc* menu, struct MenuCommandProc* command)
{
    struct SkillDebugProc* const proc = (void*) menu->parent;
	
	if (proc->move_hovering != 2)
	{   
		proc->hover_move_Updated = TRUE;
		proc->move_hovering = 2;
	}
	

	
	
    return ME_NONE;
}

static int List_4_Idle(struct MenuProc* menu, struct MenuCommandProc* command)
{
    struct SkillDebugProc* const proc = (void*) menu->parent;
	
	if (proc->move_hovering != 3)
	{   
		proc->hover_move_Updated = TRUE;
		proc->move_hovering = 3;
		/*         proc->movesUpdated = TRUE; */
	}
    return ME_NONE;
}

static int List_5_Idle(struct MenuProc* menu, struct MenuCommandProc* command)
{
    struct SkillDebugProc* const proc = (void*) menu->parent;
	
	if (proc->move_hovering != 4)
	{   
		proc->hover_move_Updated = TRUE;
		proc->move_hovering = 4;
	}

    return ME_NONE;
}

static int List_6_Idle(struct MenuProc* menu, struct MenuCommandProc* command)
{
    struct SkillDebugProc* const proc = (void*) menu->parent;
	
	if (proc->move_hovering != 5)
	{   
		proc->hover_move_Updated = TRUE;
		proc->move_hovering = 5;
	}

    return ME_NONE;
}


static int List_7_Idle(struct MenuProc* menu, struct MenuCommandProc* command)
{
    struct SkillDebugProc* const proc = (void*) menu->parent;
	
	if (proc->move_hovering != 6)
	{   
		proc->hover_move_Updated = TRUE;
		proc->move_hovering = 6;
	}
    return ME_NONE;
}

static int List_8_Idle(struct MenuProc* menu, struct MenuCommandProc* command)
{
    struct SkillDebugProc* const proc = (void*) menu->parent;
	
	if (proc->move_hovering != 7)
	{   
		proc->hover_move_Updated = TRUE;
		proc->move_hovering = 7;
	}
    return ME_NONE;
}


static void SkillListCommandDraw(struct MenuProc* menu, struct MenuCommandProc* command)
{
    struct SkillDebugProc* const proc = (void*) menu->parent;

    u8* const moves = UnitGetMoveList(proc->unit);
	int i = proc->move_hovering;
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

static void SkillListCommandDraw_1(struct MenuProc* menu, struct MenuCommandProc* command)
{
    struct SkillDebugProc* const proc = (void*) menu->parent;

    u8* const moves = UnitGetMoveList(proc->unit);
	int i = 0;
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

static void SkillListCommandDraw_2(struct MenuProc* menu, struct MenuCommandProc* command)
{
    struct SkillDebugProc* const proc = (void*) menu->parent;

    u8* const moves = UnitGetMoveList(proc->unit);
	int i = 1;
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

static void SkillListCommandDraw_3(struct MenuProc* menu, struct MenuCommandProc* command)
{
    struct SkillDebugProc* const proc = (void*) menu->parent;

    u8* const moves = UnitGetMoveList(proc->unit);
    int i = 2;
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

static void SkillListCommandDraw_4(struct MenuProc* menu, struct MenuCommandProc* command)
{
    struct SkillDebugProc* const proc = (void*) menu->parent;

    u8* const moves = UnitGetMoveList(proc->unit);
    int i = 3;
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






static void SkillListCommandDraw_5(struct MenuProc* menu, struct MenuCommandProc* command)
{
    struct SkillDebugProc* const proc = (void*) menu->parent;

    u8* const moves = UnitGetMoveList(proc->unit);
    int i = 4;
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

static void SkillListCommandDraw_6(struct MenuProc* menu, struct MenuCommandProc* command)
{
    struct SkillDebugProc* const proc = (void*) menu->parent;

    u8* const moves = UnitGetMoveList(proc->unit);
    int i = 5;
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

static void SkillListCommandDraw_7(struct MenuProc* menu, struct MenuCommandProc* command)
{
    struct SkillDebugProc* const proc = (void*) menu->parent;

    u8* const moves = UnitGetMoveList(proc->unit);
    int i = 6;
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

static void SkillListCommandDraw_8(struct MenuProc* menu, struct MenuCommandProc* command)
{
    struct SkillDebugProc* const proc = (void*) menu->parent;

    u8* const moves = UnitGetMoveList(proc->unit);
    int i = 7;
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



static int MoveCommandSelect(struct MenuProc* menu, struct MenuCommandProc* command)
{
    struct SkillDebugProc* const proc = (void*) menu->parent;
	u8* const moves = UnitGetMoveList(proc->unit);
    u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);




    UnitGetMoveList(proc->unit)[proc->move_hovering] = proc->skillReplacement;
	proc->movesUpdated = TRUE;
	
	if (proc->movesUpdated)
    {
        /*ClearIcons();*/
		
		
        SkillListCommandDraw(menu, command);
        /*EnableBgSyncByMask(BG0_SYNC_BIT);*/

        // This is to force redraw skill icons
        proc->movesUpdated = FALSE;
    }
	
	/*UnitClearBlankSkills(proc->unit);
    proc->movesUpdated = TRUE;*/

	/*extern u16 gPopupItem;
	void SetPopupItem(u16 item); //! FE8U = 0x801145D
	Popup_Create(gPopupNumber, style, style, menu->parent); //! FE8U = 0x8011475
	*/
	/*LoadIconPalettes(4); 
    DrawIcon(
        out + TILEMAP_INDEX(new_item_icon_offset, 0), 
        GetItemIconId(proc->skillReplacement), TILEREF(0, 4)); 
		*/

	int x_coord = 0;
	int y_coord = 0;
	/*
	Text_Clear(&command->text);
	DebugObjFontInit(GetIconGfxIndex(0), 1);
	DebugObjPrint(x_coord, y_coord, GetItemName(moves[proc->move_hovering]));
*/

	

/*
	Text_SetXCursor(&command->text, new_item_desc_offset);
    Text_SetColorId(&command->text, TEXT_COLOR_GOLD);
    Text_DrawString(&command->text, GetItemName(moves[proc->move_hovering])); 
	Text_Display(&command->text, out); 
*/
	EndMenu(menu);
    return ME_PLAY_BEEP;
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

    Text_Clear(&command->text);
	
	Text_SetXCursor(&command->text, new_item_desc_offset);
	Text_SetColorId(&command->text, TEXT_COLOR_GREEN);
    Text_DrawString(&command->text, "Learn ");
	Text_Display(&command->text, out); 

	Text_SetXCursor(&command->text, new_item_desc_offset+new_item_name_offset);
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
