
#include "gbafe.h"


enum { UNIT_SKILL_COUNT = 5 };

#define BG_SYNC_BIT(aBg) (1 << (aBg))



#define Icons_Spacing 2
#define item_name_offset 16
#define item_y_offset 8
#define title_offset 8

#define menu_tile_X 1
#define menu_tile_Y 0
#define menu_Length 12



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
int UnitCountMoves(struct Unit* unit)
{
    u8* const moves = UnitGetMoveList(unit);

    int count = 0;

    for (int i = 0; i < 5 && moves[i]; ++i)
        count++;

    return count;
}

static
void UnitClearBlankSkills(struct Unit* unit)
{
    u8* const moves = UnitGetMoveList(unit);

    int iIn = 0, iOut = 0;

    for (; iIn < 5; ++iIn)
    {
        if (moves[iIn])
            moves[iOut++] = moves[iIn];
    }

    for (; iOut < 5; ++iOut)
        moves[iOut] = 0;
}

static void MoveListCommandDraw(struct MenuProc* menu, struct MenuCommandProc* command);

static int MoveCommandSelect(struct MenuProc* menu, struct MenuCommandProc* command);
static int List_Idle(struct MenuProc* menu, struct MenuCommandProc* command);
static int SkillListCommandSelect(struct MenuProc* menu, struct MenuCommandProc* command);
static void ReplaceMoveCommandDraw(struct MenuProc* menu, struct MenuCommandProc* command);


static void SkillDebugMenuEnd(struct MenuProc* menu);

short GetNewSkill(const struct Unit*); //0x202BCDE;

struct ReorderMovesProc
{
    /* 00 */ PROC_HEADER; // this ends at +29
	    /* 2C */ short skillReplacement;
    /* 30 */ struct Unit* unit;
    /* 30 */ int movesUpdated;
    /* 34 */ int SelectedMoveIndex;


			
			int hover_move_Updated;

			int move_hovering;
};


static const struct ProcInstruction Proc_ReorderMoves[] =
{
    PROC_CALL_ROUTINE(LockGameLogic),

    PROC_YIELD,
    PROC_CALL_ROUTINE(UnlockGameLogic),
    PROC_END,
};



static const struct MenuCommandDefinition MenuCommands_SkillDebug[] =
{
    {
        .isAvailable = MenuCommandAlwaysUsable,
        .onEffect = SkillListCommandSelect,
        .onDraw = ReplaceMoveCommandDraw,
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









static const struct MenuDefinition Menu_SkillDebug =
{
    .geometry = { menu_tile_X, menu_tile_Y, menu_Length },
    .commandList = MenuCommands_SkillDebug,

    .onEnd = SkillDebugMenuEnd,
	
    .onBPress = (void*) (0x08022860+1), // FIXME
};



int ReorderMovesEffect(struct MenuProc* menu, struct MenuCommandProc* command)
{
    struct ReorderMovesProc* proc = (void*) ProcStart(Proc_ReorderMoves, ROOT_PROC_3);

    proc->unit = gActiveUnit;

    proc->movesUpdated = FALSE;
    proc->SelectedMoveIndex = 255;
    /*proc->skillReplacement = 1; // assumes skill #1 is valid */
	
	proc->hover_move_Updated = FALSE; 
	proc->move_hovering = 0;
    StartMenuChild(&Menu_SkillDebug, (void*) proc);
	StartFace(0, GetUnitPortraitId(proc->unit), 72, 16, 3);
    return ME_DISABLE | ME_END | ME_PLAY_BEEP | ME_CLEAR_GFX;
}


static void MoveListCommandDraw(struct MenuProc* menu, struct MenuCommandProc* command)
{
    struct ReorderMovesProc* const proc = (void*) menu->parent;

    u8* const moves = UnitGetMoveList(proc->unit);
	int i = command->commandDefinitionIndex-1;
    u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);

	//Text_InitClear(&command->text, width);
    Text_Clear(&command->text);
	Text_SetXCursor(&command->text, 0);
	Text_Display(&command->text, out); 
    LoadIconPalettes(4); /* Icon palette */

	if (IsMove(moves[i])) {
		DrawIcon(out + TILEMAP_INDEX(0, 0), GetItemIconId(moves[i]), TILEREF(0, 4)); 
		Text_SetXCursor(&command->text, item_name_offset);
		if (i == proc->SelectedMoveIndex) {
			Text_SetColorId(&command->text, TEXT_COLOR_GREEN);
		}
		else { Text_SetColorId(&command->text, TEXT_COLOR_NORMAL); }
		Text_DrawString(&command->text, GetItemName(moves[i])); 
		}
	else {
		Text_SetColorId(&command->text, TEXT_COLOR_GRAY);
		Text_DrawString(&command->text, " No Move");
	}
	EnableBgSyncByMask(BG0_SYNC_BIT);
}


static int List_Idle(struct MenuProc* menu, struct MenuCommandProc* command)
{
    struct ReorderMovesProc* const proc = (void*) menu->parent;
    u8* const moves = UnitGetMoveList(proc->unit);		
	int updated = (proc->movesUpdated);
	if (updated)
    {

	//MoveListCommandDraw(menu, menu->pCommandProc[0]); 
	MoveListCommandDraw(menu, menu->pCommandProc[1]); 
	MoveListCommandDraw(menu, menu->pCommandProc[2]); 
	MoveListCommandDraw(menu, menu->pCommandProc[3]); 
	MoveListCommandDraw(menu, menu->pCommandProc[4]); 
	MoveListCommandDraw(menu, menu->pCommandProc[5]); 
        proc->movesUpdated = false;
    }
	if (proc->move_hovering != menu->commandIndex-1)
	{   
		proc->hover_move_Updated = TRUE;
		proc->move_hovering = menu->commandIndex-1;
		proc->movesUpdated = FALSE;
	}
	if (gKeyState.repeatedKeys & KEY_BUTTON_R) { 
		MenuCallHelpBox(menu, GetItemDescId(moves[proc->move_hovering]));
	}


    return ME_NONE;
}

static int SkillListCommandSelect(struct MenuProc* menu, struct MenuCommandProc* command)
{
    return ME_NONE;
}


static int MoveCommandSelect(struct MenuProc* menu, struct MenuCommandProc* command)
{
    struct ReorderMovesProc* const proc = (void*) menu->parent;

    u8* const moves = UnitGetMoveList(proc->unit);
	
	if (proc->SelectedMoveIndex != 255) { 
	
		unsigned new_move = moves[proc->move_hovering];
		if (new_move) { 
		moves[proc->move_hovering] = moves[proc->SelectedMoveIndex];
		moves[proc->SelectedMoveIndex] = new_move;

		//UnitGetMoveList(proc->unit)[proc->SelectedMoveIndex] = 0;
		UnitClearBlankSkills(proc->unit);

		proc->movesUpdated = TRUE;
		proc->SelectedMoveIndex = 255;
		return ME_PLAY_BEEP; 
		}
		return ME_PLAY_BOOP; 
		//return ME_DISABLE | ME_END | ME_PLAY_BEEP | ME_CLEAR_GFX;
	} 
	else { proc->SelectedMoveIndex = proc->move_hovering; 
		proc->movesUpdated = TRUE; 
	} 

    return ME_PLAY_BEEP;
}




static void ReplaceMoveCommandDraw(struct MenuProc* menu, struct MenuCommandProc* command)
{
    //struct ReorderMovesProc* const proc = (void*) menu->parent;
    //u8* const moves = UnitGetMoveList(proc->unit);
    u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);

    Text_Clear(&command->text);
	
	Text_SetXCursor(&command->text, title_offset);
	Text_SetColorId(&command->text, TEXT_COLOR_BLUE);
    Text_DrawString(&command->text, "Order Moves");
	Text_Display(&command->text, out); 



}




static void SkillDebugMenuEnd(struct MenuProc* menu)
{
    EndFaceById(0);
}
