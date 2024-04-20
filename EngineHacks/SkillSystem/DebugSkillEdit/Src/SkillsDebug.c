
#include "gbafe.h"

enum { UNIT_SKILL_COUNT = 4 };

#define SKILL_ICON(aSkillId) ((1 << 8) + (aSkillId))

#define PlaySfx(aSongId) do { \
	if (!gPlaySt.config.disableSoundEffects) \
		m4aSongNumStart(aSongId); \
} while (0)

extern const u16 SkillDescTable[];


u8* UnitGetSkillList(struct Unit* unit)
{
    extern u8 gBWLDataStorage[];

    return gBWLDataStorage + 0x10 * (unit->pCharacterData->number - 1) + 1;
}


int IsSkill(int skillId)
{
    if (skillId == 0)
        return FALSE;

    if (skillId == 255)
        return FALSE;

    return !!SkillDescTable[skillId];
}


int UnitCountSkills(struct Unit* unit)
{
    u8* const skills = UnitGetSkillList(unit);

    int count = 0;

    for (int i = 0; i < UNIT_SKILL_COUNT && skills[i]; ++i)
        count++;

    return count;
}


void UnitClearBlankSkills(struct Unit* unit)
{
    u8* const skills = UnitGetSkillList(unit);

    int iIn = 0, iOut = 0;

    for (; iIn < UNIT_SKILL_COUNT; ++iIn)
    {
        if (skills[iIn])
            skills[iOut++] = skills[iIn];
    }

    for (; iOut < UNIT_SKILL_COUNT; ++iOut)
        skills[iOut] = 0;
}


char* GetSkillName(int skillId)
{
    char* desc = GetStringFromIndex(SkillDescTable[skillId]);

    for (char* it = desc; *it; ++it)
    {
        if (*it == ':')
        {
            *it = 0;
            break;
        }
    }

    return desc;
}

int SkillListCommandDraw(struct MenuProc* menu, struct MenuItemProc* command);
u8 SkillListCommandIdle(struct MenuProc* menu, struct MenuItemProc* command);
u8 SkillListCommandSelect(struct MenuProc* menu, struct MenuItemProc* command);

u8 RemoveSkillCommandSelect(struct MenuProc* menu, struct MenuItemProc* command);

int ReplaceSkillCommandDraw(struct MenuProc* menu, struct MenuItemProc* command);
u8 ReplaceSkillCommandIdle(struct MenuProc* menu, struct MenuItemProc* command);
u8 ReplaceSkillCommandSelect(struct MenuProc* menu, struct MenuItemProc* command);

void SkillDebugMenuEnd(struct MenuProc* menu);

struct SkillDebugProc
{
    PROC_HEADER;

    /* 2C */ struct Unit* unit;

    /* 30 */ u32 skillsUpdated;
    /* 34 */ u32 skillSelected;
    /* 38 */ u32 skillReplacement;
};

const struct ProcCmd Proc_SkillDebug[] =
{
    PROC_CALL(LockGame),

    PROC_YIELD,

    PROC_CALL(UnlockGame),
    PROC_END,
};

const struct MenuItemDef MenuCommands_SkillDebug[] =
{
    {
        .isAvailable = MenuAlwaysEnabled,

        .onDraw = SkillListCommandDraw,
        .onIdle = SkillListCommandIdle,
        .onSelected = SkillListCommandSelect,
    },

    {
        .isAvailable = MenuAlwaysEnabled,

        .name = " Remove Skill",
        .onSelected = RemoveSkillCommandSelect,
    },

    {
        .isAvailable = MenuAlwaysEnabled,

        .onDraw = ReplaceSkillCommandDraw,
        .onIdle = ReplaceSkillCommandIdle,
        .onSelected = ReplaceSkillCommandSelect,
    },

    {} // END
};

const struct MenuDef Menu_SkillDebug =
{
    .rect = { 1, 11, 16 },
    .menuItems = MenuCommands_SkillDebug,

    .onEnd = SkillDebugMenuEnd,
    .onBPress = ItemMenu_ButtonBPressed,
};

int SkillDebugCommand_OnSelect(struct MenuProc* menu, struct MenuItemDef* command)
{
    struct SkillDebugProc* proc = (void*) Proc_Start(Proc_SkillDebug, PROC_TREE_3);

    proc->unit = gActiveUnit;
    proc->skillsUpdated = FALSE;
    proc->skillSelected = 0;
    proc->skillReplacement = 1; // assumes skill #1 is valid

    StartMenu(&Menu_SkillDebug, (void*) proc);

    StartFace(0, GetUnitPortraitId(proc->unit), 72, 16, 3);

    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6A | MENU_ACT_CLEAR;
}

void SkillListCommandDrawIdle(struct MenuItemProc* command)
{
    struct MenuProc* const menu = (void*) command->proc_parent;
    struct SkillDebugProc* const proc = (void*) menu->proc_parent;

    if (proc->skillsUpdated)
    {
        SkillListCommandDraw(menu, command);
        BG_EnableSyncByMask(BG0_SYNC_BIT);

        proc->skillsUpdated = FALSE;
    }

    if (gKeyStatusPtr->repeatedKeys & L_BUTTON)
    {
        if (proc->skillSelected != 0)
            proc->skillSelected--;

        PlaySfx(0x6B);
    }

    if (gKeyStatusPtr->repeatedKeys & R_BUTTON)
    {
        if (proc->skillSelected + 1 < UNIT_SKILL_COUNT && UnitGetSkillList(proc->unit)[proc->skillSelected] != 0)
            proc->skillSelected++;

        PlaySfx(0x6B);
    }

    PutSprite(0,
        command->xTile*8 + 16*proc->skillSelected,
        command->yTile*8 - 12,
        &gObject_16x16[0], TILEREF(6, 0));
}

int SkillListCommandDraw(struct MenuProc* menu, struct MenuItemProc* command)
{
	asm("mov r11,r11;");
    struct SkillDebugProc* proc = (void*) menu->proc_parent;

    u8* const skills = UnitGetSkillList(proc->unit);

    u16* const out = gBG0TilemapBuffer + TILEMAP_INDEX(command->xTile, command->yTile);

    ClearText(&command->text);

    if (UnitCountSkills(proc->unit) == 0)
    {
        Text_SetColor(&command->text, TEXT_COLOR_SYSTEM_GRAY);
        Text_DrawString(&command->text, " No Skills");
    }

    PutText(&command->text, out);

    LoadIconPalettes(4);

    for (int i = 0; i < UNIT_SKILL_COUNT; ++i)
    {
        if (IsSkill(skills[i]))
            DrawIcon(out + TILEMAP_INDEX(2*i, 0), SKILL_ICON(skills[i]), TILEREF(0, 4));
    }

    command->proc_idleCb = (void*) SkillListCommandDrawIdle;
	
	return 0;
}

u8 SkillListCommandIdle(struct MenuProc* menu, struct MenuItemProc* command)
{
    struct SkillDebugProc* proc = (void*) menu->proc_parent;

    if (gKeyStatusPtr->repeatedKeys & DPAD_LEFT)
    {
        if (proc->skillSelected != 0)
            proc->skillSelected--;

        PlaySfx(0x6B);
    }

    if (gKeyStatusPtr->repeatedKeys & DPAD_RIGHT)
    {
        if (proc->skillSelected + 1 < UNIT_SKILL_COUNT && UnitGetSkillList(proc->unit)[proc->skillSelected] != 0)
            proc->skillSelected++;

        PlaySfx(0x6B);
    }

    return MENU_ITEM_NONE;
}

u8 SkillListCommandSelect(struct MenuProc* menu, struct MenuItemProc* command)
{
    return MENU_ITEM_NONE;
}

u8 RemoveSkillCommandSelect(struct MenuProc* menu, struct MenuItemProc* command)
{
    struct SkillDebugProc* proc = (void*) menu->proc_parent;

    UnitGetSkillList(proc->unit)[proc->skillSelected] = 0;
    UnitClearBlankSkills(proc->unit);

    proc->skillsUpdated = TRUE;

    return MENU_ACT_SND6A;
}

int ReplaceSkillCommandDraw(struct MenuProc* menu, struct MenuItemProc* command)
{
    struct SkillDebugProc* proc = (void*) menu->proc_parent;

    u16* const out = gBG0TilemapBuffer + TILEMAP_INDEX(command->xTile, command->yTile);

    ClearText(&command->text);

    Text_DrawString(&command->text, " Set");

    Text_SetCursor(&command->text, 42);
    Text_SetColor(&command->text, TEXT_COLOR_SYSTEM_BLUE);
    Text_DrawString(&command->text, GetSkillName(proc->skillReplacement));

    PutText(&command->text, out);

    DrawIcon(
        out + TILEMAP_INDEX(3, 0),
        SKILL_ICON(proc->skillReplacement), TILEREF(0, 4));
	
	return 0;
}

u8 ReplaceSkillCommandIdle(struct MenuProc* menu, struct MenuItemProc* command)
{
    struct SkillDebugProc* proc = (void*) menu->proc_parent;

    int updated = FALSE;

    if (gKeyStatusPtr->repeatedKeys & DPAD_LEFT)
    {
        unsigned id = proc->skillReplacement;

        do
        {
            id = (id - 1) % 0x100;
        }
        while (!IsSkill(id));

        updated = (proc->skillReplacement != id);
        proc->skillReplacement = id;

        PlaySfx(0x6B);
    }

    if (gKeyStatusPtr->repeatedKeys & DPAD_RIGHT)
    {
        unsigned id = proc->skillReplacement;

        do
        {
            id = (id + 1) % 0x100;
        }
        while (!IsSkill(id));

        updated = (proc->skillReplacement != id);
        proc->skillReplacement = id;

        PlaySfx(0x6B);
    }

    if (updated)
    {
        ResetIconGraphics();

        ReplaceSkillCommandDraw(menu, command);
        BG_EnableSyncByMask(BG0_SYNC_BIT);

        // This is to force redraw skill icons
        proc->skillsUpdated = TRUE;
    }

    return 0;
}

u8 ReplaceSkillCommandSelect(struct MenuProc* menu, struct MenuItemProc* command)
{
    struct SkillDebugProc* proc = (void*) menu->proc_parent;

    UnitGetSkillList(proc->unit)[proc->skillSelected] = proc->skillReplacement;
    proc->skillsUpdated = TRUE;

    return MENU_ACT_SND6A;
}

void SkillDebugMenuEnd(struct MenuProc* menu)
{
    EndFaceById(0);
}
