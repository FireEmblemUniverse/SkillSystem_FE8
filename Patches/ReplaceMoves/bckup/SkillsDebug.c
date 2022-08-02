
#include "FE-CLib-master/include/gbafe.h"

enum { UNIT_SKILL_COUNT = 8 };

#define BG_SYNC_BIT(aBg) (1 << (aBg))
enum { BG0_SYNC_BIT = BG_SYNC_BIT(0) };



extern const u16 SkillDescTable[];



/*
#define Icons_Spacing 2 
#define menu_tile_X 1
#define menu_tile_Y 11
#define menu_Length 16

#define portrait_pos_a 72 
#define portrait_pos_b 16 


*/


#define Icons_Spacing 2
#define item_name_offset 20
#define item_y_offset 8

#define menu_tile_X 1
#define menu_tile_Y 0
#define menu_Length 12

#define item_menu_tile_X 13
#define item_menu_tile_Y 0
#define item_menu_Length 16

#define portrait_pos_a 72 
#define portrait_pos_b 16 



/*extern const ItemData gItemData[]; */ 
char* GetItemName(int item); 

static
u8* UnitGetMoveList(struct Unit* unit)
{
	/* extern u8 unit+ranks[8];
		return unitRanks + (unit); // (unit)->pCharacterData->number - 1)*/ 
	/*u8 unitRanks[] = unit->ranks[];*/
	return unit->ranks; /*+ (unit); */    
}

static
int IsMove(int moveId)
{
    if (moveId == 0)
        return FALSE;

    if (moveId == 255)
        return FALSE;

    return !!SkillDescTable[moveId]; /* GetItemDescId() */ 
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


static void SkillListCommandDraw(struct MenuProc* menu, struct MenuCommandProc* command);
static void SkillListCommandDraw_2(struct MenuProc* menu, struct MenuCommandProc* command);
static void SkillListCommandDraw_3(struct MenuProc* menu, struct MenuCommandProc* command);

static void NewMoveDetailsDraw(struct MenuProc* menu, struct MenuCommandProc* command);




static int SkillListCommandIdle(struct MenuProc* menu, struct MenuCommandProc* command);
static int SkillListCommandSelect(struct MenuProc* menu, struct MenuCommandProc* command);

static int RemoveSkillCommandSelect(struct MenuProc* menu, struct MenuCommandProc* command);

static void ReplaceSkillCommandDraw(struct MenuProc* menu, struct MenuCommandProc* command);
static int ReplaceSkillCommandIdle(struct MenuProc* menu, struct MenuCommandProc* command);
static int ReplaceSkillCommandSelect(struct MenuProc* menu, struct MenuCommandProc* command);

static void SkillDebugMenuEnd(struct MenuProc* menu);

struct SkillDebugProc
{
    PROC_HEADER;

    /* 2C */ struct Unit* unit;

    /* 30 */ int skillsUpdated;
    /* 34 */ int skillSelected;
    /* 38 */ int skillReplacement;
};



static
int IsValidMove(int moveId)
{
    if (moveId == 0)
        return FALSE;

    if (moveId == 255)
        return FALSE;

    return TRUE; 
}

static int IsMenuAvailable(struct MenuProc* menu, struct MenuCommandProc* command);

static int IsMenuAvailable(struct MenuProc* menu, struct MenuCommandProc* command)
{
    struct SkillDebugProc* const proc = (void*) menu->parent;

	IsValidMove(proc->skillSelected); 

    return ME_PLAY_BEEP;
}







static const struct ProcInstruction Proc_SkillDebug[] =
{
    PROC_CALL_ROUTINE(LockGameLogic),

    PROC_YIELD,

    PROC_CALL_ROUTINE(UnlockGameLogic),
    PROC_END,
};

static const struct MenuCommandDefinition MenuCommands_ItemDetails[] =
{
	{
        .isAvailable = MenuCommandAlwaysUsable,

        .onDraw = NewMoveDetailsDraw,
        /*.onIdle = ReplaceSkillCommandIdle,
        .onEffect = ReplaceSkillCommandSelect,*/
    },
	
	{}
};

static const struct MenuCommandDefinition MenuCommands_SkillDebug[] =
{
    {
        .isAvailable = MenuCommandAlwaysUsable,

        .onDraw = ReplaceSkillCommandDraw,
        .onIdle = ReplaceSkillCommandIdle,
        .onEffect = ReplaceSkillCommandSelect,
    },

    {
        .isAvailable = MenuCommandAlwaysUsable,

        .rawName = " Forget Move",
        .onEffect = RemoveSkillCommandSelect,
    },

    {
		.isAvailable = MenuCommandAlwaysUsable,

        .onDraw = SkillListCommandDraw,
        .onEffect = SkillListCommandSelect,
        /*.onIdle = SkillListCommandIdle,
        .onEffect = SkillListCommandSelect,*/
    },
	
    {
		.isAvailable = MenuCommandAlwaysUsable,

        .onDraw = SkillListCommandDraw_2,
        .onEffect = SkillListCommandSelect,
    },
	
    {
		.isAvailable = MenuCommandAlwaysUsable,
		/*.isAvailable = IsMenuAvailable,*/

        .onDraw = SkillListCommandDraw_3,
        .onEffect = SkillListCommandSelect,
    },
    {
		.isAvailable = MenuCommandAlwaysUsable,
		/*.isAvailable = IsMenuAvailable,*/

        .onDraw = SkillListCommandDraw_3,
        .onEffect = SkillListCommandSelect,
    },
    {
		.isAvailable = MenuCommandAlwaysUsable,
		/*.isAvailable = IsMenuAvailable,*/

        .onDraw = SkillListCommandDraw_3,
        .onEffect = SkillListCommandSelect,
    },
    {
		.isAvailable = MenuCommandAlwaysUsable,
		/*.isAvailable = IsMenuAvailable,*/

        .onDraw = SkillListCommandDraw_3,
        .onEffect = SkillListCommandSelect,
    },
	/*
    {
		.isAvailable = MenuCommandAlwaysUsable,

        .onDraw = SkillListCommandDraw_3,
        .onEffect = SkillListCommandSelect,
    },
    {
		.isAvailable = MenuCommandAlwaysUsable,
        .onDraw = SkillListCommandDraw_3,
        .onEffect = SkillListCommandSelect,
    }, */

    {} // END
};


static void NewMoveDetailsDraw(struct MenuProc* menu, struct MenuCommandProc* command)
{
    struct SkillDebugProc* const proc = (void*) menu->parent;

    u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);

    Text_Clear(&command->text);

    /*Text_DrawString(&command->text, " Learn");*/



    Text_SetXCursor(&command->text, 158); 
	
    Text_SetColorId(&command->text, TEXT_COLOR_NORMAL);
    Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(proc->skillReplacement)));
	

    Text_Display(&command->text, out);

    /*DrawIcon(
        out + TILEMAP_INDEX(5, 0), *//* Bottom left offset of icon to give the unit         */ 
        /*GetItemIconId(proc->skillReplacement), TILEREF(0, 4));*/ /* Palette? */  /* */
}







static const struct MenuDefinition Menu_SkillDebug =
{
    .geometry = { menu_tile_X, menu_tile_Y, menu_Length },
    .commandList = MenuCommands_SkillDebug,

    .onEnd = SkillDebugMenuEnd,
    .onBPress = (void*) (0x08022860+1), // FIXME
};

static const struct MenuDefinition Menu_ItemDetails =
{
    .geometry = { item_menu_tile_X, item_menu_tile_Y, item_menu_Length },
    .commandList = MenuCommands_ItemDetails,

    .onEnd = SkillDebugMenuEnd,
    .onBPress = (void*) (0x08022860+1), // FIXME
};


int SkillDebugCommand_OnSelect(struct MenuProc* menu, struct MenuCommandProc* command)
{
    struct SkillDebugProc* proc = (void*) ProcStart(Proc_SkillDebug, ROOT_PROC_3);

    proc->unit = gActiveUnit;
    proc->skillsUpdated = FALSE;
    proc->skillSelected = 0;
    proc->skillReplacement = 1; // assumes skill #1 is valid

    StartMenuChild(&Menu_SkillDebug, (void*) proc);
	StartMenuChild(&Menu_ItemDetails, (void*) proc);

    StartFace(0, GetUnitPortraitId(proc->unit), portrait_pos_a, portrait_pos_b, 3);

    return ME_DISABLE | ME_END | ME_PLAY_BEEP | ME_CLEAR_GFX;
}

static void SkillListCommandDrawIdle(struct MenuCommandProc* command)
{
    struct MenuProc* const menu = (void*) command->parent;
    struct SkillDebugProc* const proc = (void*) menu->parent;

    if (proc->skillsUpdated)
    {
        SkillListCommandDraw(menu, command);
        EnableBgSyncByMask(BG0_SYNC_BIT);

        proc->skillsUpdated = FALSE;
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




static void SkillListCommandDraw(struct MenuProc* menu, struct MenuCommandProc* command)
{
    struct SkillDebugProc* const proc = (void*) menu->parent;

    u8* const moves = UnitGetMoveList(proc->unit);

    u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);

    Text_Clear(&command->text);

    if (UnitCountSkills(proc->unit) == 0)
    {
        Text_SetColorId(&command->text, TEXT_COLOR_GRAY);
        Text_DrawString(&command->text, " No Moves");
    }

    Text_Display(&command->text, out);

    LoadIconPalettes(4); /* Icon palette */

    int i = 0;
	if (IsMove(moves[i])) {
		DrawIcon(out + TILEMAP_INDEX(0, 0), GetItemIconId(moves[i]), TILEREF(0, 4)); /* The icons       */ 
		Text_SetXCursor(&command->text, item_name_offset);
		Text_DrawString(&command->text, GetItemName(moves[i])); 
		}

    /* command->onCycle = (void*) SkillListCommandDrawIdle; */
}

static void SkillListCommandDraw_2(struct MenuProc* menu, struct MenuCommandProc* command)
{
    struct SkillDebugProc* const proc = (void*) menu->parent;

    u8* const moves = UnitGetMoveList(proc->unit);

    u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);

    Text_Clear(&command->text);

    Text_Display(&command->text, out);

    LoadIconPalettes(4); /* Icon palette */

    int i = 2;
	if (IsMove(moves[i])) {
		DrawIcon(out + TILEMAP_INDEX(0, 0), GetItemIconId(moves[i]), TILEREF(0, 4)); /* The icons       */ 
		Text_SetXCursor(&command->text, item_name_offset);
		/*Text_Advance(&command->text, item_y_offset*(i+1));*/
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

    u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);

    Text_Clear(&command->text);

    Text_Display(&command->text, out);

    LoadIconPalettes(4); /* Icon palette */

    int i = 2;
	if (IsMove(moves[i])) {
		DrawIcon(out + TILEMAP_INDEX(0, 0), GetItemIconId(moves[i]), TILEREF(0, 4)); 
		Text_SetXCursor(&command->text, item_name_offset);
		/*Text_Advance(&command->text, item_y_offset*(i+1));*/
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

static int RemoveSkillCommandSelect(struct MenuProc* menu, struct MenuCommandProc* command)
{
    struct SkillDebugProc* const proc = (void*) menu->parent;

    UnitGetMoveList(proc->unit)[proc->skillSelected] = 0;
    UnitClearBlankSkills(proc->unit);

    proc->skillsUpdated = TRUE;

    return ME_PLAY_BEEP;
}

static void ReplaceSkillCommandDraw(struct MenuProc* menu, struct MenuCommandProc* command)
{
    struct SkillDebugProc* const proc = (void*) menu->parent;

    u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);

    Text_Clear(&command->text);

    Text_DrawString(&command->text, " Learn");

    Text_SetXCursor(&command->text, 58);
    Text_SetColorId(&command->text, TEXT_COLOR_BLUE);
    /*Text_DrawString(&command->text, GetStringFromIndex(GetItemDescId(proc->skillReplacement))); */
	
    Text_DrawString(&command->text, GetItemName(proc->skillReplacement)); /* We want GetItemDescId to be made into a Char so we can display it? */ 

    Text_Display(&command->text, out);

    DrawIcon(
        out + TILEMAP_INDEX(5, 0), /* Bottom left offset of icon to give the unit         */ 
        GetItemIconId(proc->skillReplacement), TILEREF(0, 4)); /* Palette? */ 
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
        ClearIcons();

        ReplaceSkillCommandDraw(menu, command);
        EnableBgSyncByMask(BG0_SYNC_BIT);

        // This is to force redraw skill icons
        proc->skillsUpdated = TRUE;
    }

    return ME_NONE;
}

static int ReplaceSkillCommandSelect(struct MenuProc* menu, struct MenuCommandProc* command)
{
    struct SkillDebugProc* const proc = (void*) menu->parent;

    UnitGetMoveList(proc->unit)[proc->skillSelected] = proc->skillReplacement;
    proc->skillsUpdated = TRUE;

    return ME_PLAY_BEEP;
}

static void SkillDebugMenuEnd(struct MenuProc* menu)
{
    EndFaceById(0);
}
