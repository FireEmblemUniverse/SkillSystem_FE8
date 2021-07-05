
#include "FE-CLib-master/include/gbafe.h"

enum { UNIT_SKILL_COUNT = 8 };

#define BG_SYNC_BIT(aBg) (1 << (aBg))
enum { BG0_SYNC_BIT = BG_SYNC_BIT(0) };

#define SKILL_ICON(aSkillId) ((1 << 8) + (aSkillId))

extern const u16 SkillDescTable[];

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

static const struct ProcInstruction Proc_SkillDebug[] =
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

        .onDraw = SkillListCommandDraw,
        .onIdle = SkillListCommandIdle,
        .onEffect = SkillListCommandSelect,
    },

    {
        .isAvailable = MenuCommandAlwaysUsable,

        .rawName = " Forget Move",
        .onEffect = RemoveSkillCommandSelect,
    },

    {
        .isAvailable = MenuCommandAlwaysUsable,

        .onDraw = ReplaceSkillCommandDraw,
        .onIdle = ReplaceSkillCommandIdle,
        .onEffect = ReplaceSkillCommandSelect,
    },

    {} // END
};

static const struct MenuDefinition Menu_SkillDebug =
{
    .geometry = { 1, 11, 16 },
    .commandList = MenuCommands_SkillDebug,

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

    StartFace(0, GetUnitPortraitId(proc->unit), 72, 16, 3);

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
        command->xDrawTile*8 + 16*proc->skillSelected,
        command->yDrawTile*8 - 12,
        &gObj_16x16, TILEREF(6, 0)); /* The little hand cursor */ 
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

    for (int i = 0; i < UNIT_SKILL_COUNT; ++i)
    {
        if (IsMove(moves[i]))
            DrawIcon(out + TILEMAP_INDEX(2*i, 0), SKILL_ICON(moves[i]), TILEREF(0, 4));
			/* Text_DrawString(&command->text, GetItemName(proc->skillReplacement)); */
    }

    command->onCycle = (void*) SkillListCommandDrawIdle;
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
    Text_DrawString(&command->text, GetItemName(proc->skillReplacement));

    Text_Display(&command->text, out);

    DrawIcon(
        out + TILEMAP_INDEX(5, 0), /* Bottom left offset of icon to give the unit         */ 
        SKILL_ICON(proc->skillReplacement), TILEREF(0, 4)); /* Palette? */ 
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
