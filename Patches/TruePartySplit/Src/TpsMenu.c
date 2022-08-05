
#include "Tps.h"

static const void(*SetNextVCount)(int vcount) = (void*) 0x08001308+1;
static const void(*PutUnitSpriteExt)(int layer, int x, int y, int oam2, const Unit* unit) = (void*) 0x08027E4C+1;
static const void(*DrawUiItemHoverExt)(int bg, int tile, int x, int y, int width) = (void*) 0x0804E98C+1;
static const void(*ClearUiItemHoverExt)(int bg, int tile, int x, int y, int width) = (void*) 0x0804EA08+1;
static const void(*PutFrozenHandCursor)(int x, int y) = (void*) 0x804E848+1;

enum
{
    // MAGIC CONSTANTS

    LIST_PANEL_WIDTH = 10,
    LIST_PANEL_LINES = 7,

    LIST_PANEL_LEFT_X = 2,
    LIST_PANEL_LEFT_Y = 4,

    LIST_PANEL_RIGHT_X = 18,
    LIST_PANEL_RIGHT_Y = 4,
};

struct TpsUidStorageProc
{
    /* 00 */ PROC_HEADER;
    /* 29 */ u8 forced_amt;
    /* 2A */ u8 uids[0x40];
};

struct TpsUidStorageMasterProc
{
    /* 00 */ PROC_HEADER;
    /* 2C */ struct TpsUidStorageProc* parties[8];
};

struct TpsMenuUnitListTextStorageProc
{
    /* 00 */ PROC_HEADER;
    /* 2C */ struct TextHandle text[8];
};

struct TpsMenuUnitListProc
{
    /* 00 */ PROC_HEADER;

    /* 2C */ int bg;
    /* 30 */ int x, y;
    /* 38 */ int target_top_num;
    /* 3C */ struct TpsUidStorageProc* uid_storage;

    /* 40 */ struct TpsMenuUnitListTextStorageProc* text_storage;
    /* 44 */ int scroll_offset;
};

struct TpsMenuProc
{
    /* 00 */ PROC_HEADER;
    /* 2C */ struct TpsMenuInfo const* info;
    /* 30 */ struct TpsUidStorageMasterProc* uid_storage;
    /* 34 */ struct TpsMenuUnitListProc* unit_list_proc[2];
    /* 3C */ u8 hover_col, hover_row;
    /* 3E */ u8 select_col, select_row;
    /* 40 */ u8 current_party_select[2];
};

static struct TpsUidStorageMasterProc* StartTpsUidStorage(struct TpsMenuInfo const* info, struct Proc* parent);
static struct TpsMenuUnitListProc* StartTpsMenuUnitList(int bg, int x, int y, int party, struct TpsMenuProc* parent);

static struct ProcInstruction const ProcScr_StorageDummy[] =
{
    PROC_SET_NAME("TpsMenu Storage"),
    PROC_BLOCK,
};

// ============================
// = TPS MENU UNIT ID STORAGE =
// ============================

static void TpsUidStorage_RemoveBlankEntries(struct TpsUidStorageProc* proc)
{
    int count = 0;

    for (int i = 0; i < 0x40; ++i)
    {
        if (proc->uids[i] != 0)
            count = i + 1;
    }

    for (int i = 0; i < count; ++i)
    {
        while (i < count && proc->uids[i] == 0)
        {
            for (int j = i; j < count; ++j)
                proc->uids[j] = proc->uids[j+1];

            count--;
        }
    }
}

struct TpsUidStorageMasterProc* StartTpsUidStorage(struct TpsMenuInfo const* info, struct Proc* parent)
{
    struct TpsUidStorageMasterProc* proc = (struct TpsUidStorageMasterProc*) ProcStart(ProcScr_StorageDummy, parent);

    for (int i = 0; i < 8; ++i)
        proc->parties[i] = NULL;

    struct TpsMenuPartyInfo const* party_info[8] = {};

    for (struct TpsMenuPartyInfo const* const* party_info_it = info->party_info_list; *party_info_it != NULL; ++party_info_it)
    {
        struct TpsMenuPartyInfo const* const this_party_info = *party_info_it;
        party_info[this_party_info->party_num] = this_party_info;

        proc->parties[this_party_info->party_num] = (struct TpsUidStorageProc*) ProcStart(ProcScr_StorageDummy, (struct Proc*) proc);

        proc->parties[this_party_info->party_num]->forced_amt = 0;

        for (int j = 0; j < 0x40; ++j)
            proc->parties[this_party_info->party_num]->uids[j] = 0;
    }

    // Step one: forced party members

    for (int i = 1; i < 0x40; ++i)
    {
        struct Unit* const unit = GetUnit(i);

        if (unit == NULL || unit->pCharacterData == NULL)
            continue;

        if (unit->state & US_DEAD)
            continue;

        int const pid = unit->pCharacterData->number;

        if (TpsIsDisabledByPid(pid))
            continue;

        int const party_num = TpsGetPartyByPid(pid);

        if (party_info[party_num] != NULL)
        {
            for (u8 const* it = party_info[party_num]->forced_pids; *it != 0; ++it)
            {
                if (*it == pid)
                {
                    for (int j = 0; j < 0x40; ++j)
                    {
                        if (proc->parties[party_num]->uids[j] == 0)
                        {
                            proc->parties[party_num]->uids[j] = i;
                            proc->parties[party_num]->forced_amt = i+1;
                            break;
                        }
                    }

                    break;
                }
            }
        }
    }

    // Step two: non forced party members

    for (int i = 1; i < 0x40; ++i)
    {
        struct Unit* const unit = GetUnit(i);

        if (unit == NULL || unit->pCharacterData == NULL)
            continue;

        if (unit->state & US_DEAD)
            continue;

        int const pid = unit->pCharacterData->number;

        if (TpsIsDisabledByPid(pid))
            continue;

        int const party_num = TpsGetPartyByPid(pid);

        if (party_info[party_num] != NULL)
        {
            int is_forced = FALSE;

            for (u8 const* it = party_info[party_num]->forced_pids; *it != 0; ++it)
            {
                if (*it == pid)
                {
                    is_forced = TRUE;
                    break;
                }
            }

            if (!is_forced)
            {
                for (int j = 0; j < 0x40; ++j)
                {
                    if (proc->parties[party_num]->uids[j] == 0)
                    {
                        proc->parties[party_num]->uids[j] = i;
                        break;
                    }
                }
            }
        }
    }

    return proc;
}

// ==============================
// = TPS MENU UNIT LIST DISPLAY =
// ==============================

static void TpsMenuUnitList_Init(struct TpsMenuUnitListProc* proc);
static void TpsMenuUnitList_Loop(struct TpsMenuUnitListProc* proc);

static struct ProcInstruction const ProcScr_TpsMenuUnitList[] =
{
    PROC_SET_NAME("TpsMenu Unit List"),
    PROC_SLEEP(0),

PROC_LABEL(0),
    PROC_CALL_ROUTINE(TpsMenuUnitList_Init),
    PROC_LOOP_ROUTINE(TpsMenuUnitList_Loop),

    PROC_END,
};

static void TpsMenuUnitList_DrawUnitText(struct TpsMenuUnitListProc* proc, int unit_num)
{
    int const text_num = unit_num % 8;
    struct TextHandle* const text = &proc->text_storage->text[text_num];

    int const unit_id = proc->uid_storage->uids[unit_num];

    Text_Clear(text);

    if (unit_id == 0)
        return;

    if (unit_num < proc->uid_storage->forced_amt)
        Text_SetColorId(text, TEXT_COLOR_GREEN);

    Text_Advance(text, 2);
    Text_DrawString(text, GetStringFromIndex(GetUnit(unit_id)->pCharacterData->nameTextId));
}

static void TpsMenuUnitList_PutUnitText(struct TpsMenuUnitListProc* proc)
{
    int const scroll_top_num = proc->scroll_offset / 16;

    for (int i = 0; i < 8; ++i)
    {
        int const text_num = (scroll_top_num + i) % 8;
        struct TextHandle* const text = &proc->text_storage->text[text_num];

        Text_Display(text, GetBgMapBuffer(proc->bg) + TILEMAP_INDEX(2, i*2));
    }
}

static void TpsMenuUnitList_RefreshUnitText(struct TpsMenuUnitListProc* proc, int start, int count)
{
    for (int i = 0; i < count; ++i)
    {
        TpsMenuUnitList_DrawUnitText(proc, start + i);
    }

    TpsMenuUnitList_PutUnitText(proc);
}

static void TpsMenuUnitList_RefreshAll(struct TpsMenuUnitListProc* proc)
{
    TpsMenuUnitList_RefreshUnitText(proc, proc->scroll_offset / 16, 8);
}

static void TpsMenuUnitList_SetScrollOffset(struct TpsMenuUnitListProc* proc, int scroll_offset)
{
    int const old_scroll_top_num = proc->scroll_offset / 16;
    int const new_scroll_top_num = scroll_offset / 16;

    proc->scroll_offset = scroll_offset;

    if (new_scroll_top_num > old_scroll_top_num)
    {
        // scrolling down

        int refresh_count = new_scroll_top_num - old_scroll_top_num;

        if (refresh_count > 8)
            refresh_count = 8;

        int refresh_start = new_scroll_top_num + 8 - refresh_count;

        TpsMenuUnitList_RefreshUnitText(proc, refresh_start, refresh_count);
    }

    if (new_scroll_top_num < old_scroll_top_num)
    {
        // scrolling up

        int refresh_count = old_scroll_top_num - new_scroll_top_num;

        if (refresh_count > 8)
            refresh_count = 8;

        int refresh_start = new_scroll_top_num;

        TpsMenuUnitList_RefreshUnitText(proc, refresh_start, refresh_count);
    }

    SetBgPosition(proc->bg, -proc->x*8, -proc->y*8 + scroll_offset % 16);
    EnableBgSyncByIndex(proc->bg);
}

static void TpsMenuUnitList_TrySetTargetTopNum(struct TpsMenuUnitListProc* proc, int target_top_num)
{
    if (target_top_num < 0)
        target_top_num = 0;

    if (target_top_num > 0x40-8)
        target_top_num = 0x40-8;

    while (target_top_num > 0 && proc->uid_storage->uids[target_top_num+LIST_PANEL_LINES-2] == 0)
        target_top_num--;

    proc->target_top_num = target_top_num;
}

void TpsMenuUnitList_Init(struct TpsMenuUnitListProc* proc)
{
    proc->text_storage = (struct TpsMenuUnitListTextStorageProc*) ProcStart(ProcScr_StorageDummy, (struct Proc*) proc);

    for (int i = 0; i < 8; ++i)
        Text_InitClear(&proc->text_storage->text[i], LIST_PANEL_WIDTH-2);

    proc->scroll_offset = 0;

    for (int i = 0; i < 8; ++i)
        TpsMenuUnitList_DrawUnitText(proc, i);

    TpsMenuUnitList_PutUnitText(proc);

    WriteUIWindowTileMap(gBg2MapBuffer, proc->x-1, proc->y-1, LIST_PANEL_WIDTH+2, LIST_PANEL_LINES*2+2, TILEREF(0, 0), 0);
    EnableBgSyncByMask(BG2_SYNC_BIT);

    TpsMenuUnitList_SetScrollOffset(proc, proc->target_top_num*16);
}

void TpsMenuUnitList_Loop(struct TpsMenuUnitListProc* proc)
{
    int const scroll_target = proc->target_top_num * 16;

    if (proc->scroll_offset != scroll_target)
    {
        int new_scroll_offset = proc->scroll_offset + (scroll_target - proc->scroll_offset) / 2;

        if (ABS(new_scroll_offset - scroll_target) == 1)
            new_scroll_offset = scroll_target;

        TpsMenuUnitList_SetScrollOffset(proc, new_scroll_offset);
    }

    int const scroll_top_num = proc->scroll_offset / 16;
    int const sprite_offset = proc->scroll_offset % 16;

    for (int i = 0; i < 8; ++i)
    {
        int const unit_id = proc->uid_storage->uids[scroll_top_num + i];

        if (unit_id == 0)
            break;

        int const x = proc->x*8;
        int const y = proc->y*8 - sprite_offset + i*16;

        PutUnitSpriteExt(10-i, x, y, (1 << 10), GetUnit(unit_id));
    }
	
}

struct TpsMenuUnitListProc* StartTpsMenuUnitList(int bg, int x, int y, int party, struct TpsMenuProc* parent)
{
    struct TpsMenuUnitListProc* proc = (struct TpsMenuUnitListProc*) ProcStart(ProcScr_TpsMenuUnitList, (struct Proc*) parent);

    proc->bg = bg;
    proc->x = x;
    proc->y = y;
    proc->target_top_num = 0;
    proc->uid_storage = parent->uid_storage->parties[party];

    return proc;
}

// ==========================
// = TPS MENU LOCATION UTIL =
// ==========================

static struct Vec2 GetCellDisplayTileLocation(int col, int local_row)
{
    struct Vec2 result = { 0, 0 };

    if (col == 0)
    {
        result.x = LIST_PANEL_LEFT_X;
        result.y = LIST_PANEL_LEFT_Y+local_row*2;
    }

    if (col == 1)
    {
        result.x = LIST_PANEL_RIGHT_X;
        result.y = LIST_PANEL_RIGHT_Y+local_row*2;
    }

    return result;
}

static int GetTpsMenuAdjustedRow(struct TpsMenuProc* proc, int col, int row)
{
    struct TpsUidStorageProc* const storage = proc->unit_list_proc[col]->uid_storage;

    if (row < 0)
        row = 0;

    if (row > 0x40)
        row = 0x40;

    while (row > 0 && storage->uids[row-1] == 0)
        row--;

    return row;
}

// ================================
// = TPS MENU SELECTION HIGHLIGHT =
// ================================

struct TpsMenuSelectionHighlight
{
    /* 00 */ PROC_HEADER;
    /* 2C */ int last_hover_col;
    /* 30 */ int last_hover_local_row;
};

static void TpsMenuSelectionHighlight_Init(struct TpsMenuSelectionHighlight* proc);
static void TpsMenuSelectionHighlight_Loop(struct TpsMenuSelectionHighlight* proc);

static struct ProcInstruction const ProcScr_TpsMenuSelectionHighlight[] =
{
    PROC_SET_NAME("TpsMenu Selection Highlight"),

    PROC_CALL_ROUTINE(TpsMenuSelectionHighlight_Init),
    PROC_LOOP_ROUTINE(TpsMenuSelectionHighlight_Loop),

    PROC_END,
};

void TpsMenuSelectionHighlight_Init(struct TpsMenuSelectionHighlight* proc)
{
    proc->last_hover_col = -1;
    proc->last_hover_local_row = -1;
}

void TpsMenuSelectionHighlight_Loop(struct TpsMenuSelectionHighlight* proc)
{
    struct TpsMenuProc* const menu = (struct TpsMenuProc*) proc->parent;

    int const new_col = menu->hover_col;
    int const new_local_row = menu->hover_row - menu->unit_list_proc[menu->hover_col]->target_top_num;

    if (new_local_row == proc->last_hover_local_row && new_col == proc->last_hover_col)
        return;

    if (proc->last_hover_col >= 0)
    {
        struct Vec2 const loc = GetCellDisplayTileLocation(proc->last_hover_col, proc->last_hover_local_row);
        ClearUiItemHoverExt(2, 0, loc.x, loc.y, LIST_PANEL_WIDTH);
    }

    struct Vec2 const loc = GetCellDisplayTileLocation(new_col, new_local_row);
    DrawUiItemHoverExt(2, 0, loc.x, loc.y, LIST_PANEL_WIDTH);

    proc->last_hover_col = new_col;
    proc->last_hover_local_row = new_local_row;
}

static void StartTpsMenuSelectionHighlight(struct TpsMenuProc* parent)
{
    ProcStart(ProcScr_TpsMenuSelectionHighlight, (struct Proc*) parent);
}

// ============
// = TPS MENU =
// ============

enum
{
    L_TPSMENU_NEUTRAL,
    L_TPSMENU_SELECTED,
};

static void TpsMenu_Init(struct TpsMenuProc* proc);
static void TpsMenu_NeutralLoop(struct TpsMenuProc* proc);
static void TpsMenu_SelectedLoop(struct TpsMenuProc* proc);

static struct ProcInstruction const ProcScr_TpsMenu[] =
{
    PROC_SET_NAME("TpsMenu Main"),
    PROC_SLEEP(0),

    PROC_CALL_ROUTINE(NewGreenTextColorManager),
    PROC_SET_DESTRUCTOR(EndGreenTextColorManager),

    PROC_CALL_ROUTINE(StartTpsMenuSelectionHighlight),

    PROC_CALL_ROUTINE(TpsMenu_Init),

PROC_LABEL(L_TPSMENU_NEUTRAL),
    PROC_LOOP_ROUTINE(TpsMenu_NeutralLoop),

PROC_LABEL(L_TPSMENU_SELECTED),
    PROC_LOOP_ROUTINE(TpsMenu_SelectedLoop),

PROC_LABEL(5), 

    PROC_END,
};

static void TpsMenuOnVMatch(void)
{
    int const vcount = VCOUNT;

    if (vcount == LIST_PANEL_LEFT_Y*8)
    {
        DISPCNT.enableBg0 = TRUE;
        DISPCNT.enableBg1 = TRUE;
        DISPCNT.enableObj = TRUE;

        SetNextVCount(LIST_PANEL_LEFT_Y*8 + LIST_PANEL_LINES*16);
    }

    if (vcount == LIST_PANEL_LEFT_Y*8 + LIST_PANEL_LINES*16)
    {
        DISPCNT.enableBg0 = FALSE;
        DISPCNT.enableBg1 = FALSE;
        DISPCNT.enableObj = FALSE;

        SetNextVCount(LIST_PANEL_LEFT_Y*8);
    }
}

void TpsMenu_Init(struct TpsMenuProc* proc)
{
    gLCDIOBuffer.bgControl[0].priority = 0;
    gLCDIOBuffer.bgControl[1].priority = 0;
    gLCDIOBuffer.bgControl[2].priority = 1;

    gLCDIOBuffer.dispControl.enableBg0 = FALSE;
    gLCDIOBuffer.dispControl.enableBg1 = FALSE;
    gLCDIOBuffer.dispControl.enableObj = FALSE;

    SetLCDVCountSetting(LIST_PANEL_LEFT_Y*8);
    SetInterrupt_LCDVCountMatch(TpsMenuOnVMatch);

    proc->uid_storage = StartTpsUidStorage(proc->info, (struct Proc*) proc);

    proc->current_party_select[0] = 0;
    proc->current_party_select[1] = 1;

    proc->unit_list_proc[0] = StartTpsMenuUnitList(0, LIST_PANEL_LEFT_X, LIST_PANEL_LEFT_Y, proc->info->party_info_list[proc->current_party_select[0]]->party_num, proc);
    proc->unit_list_proc[1] = StartTpsMenuUnitList(1, LIST_PANEL_RIGHT_X, LIST_PANEL_RIGHT_Y, proc->info->party_info_list[proc->current_party_select[1]]->party_num, proc);

    proc->hover_col = 0;
    proc->hover_row = 0;
}

static void TpsMenu_UpdateScroll(struct TpsMenuProc* proc)
{
    for (int i = 0; i < 2; ++i)
    {
        while (proc->unit_list_proc[i]->target_top_num > 0 && proc->unit_list_proc[i]->uid_storage->uids[proc->unit_list_proc[i]->target_top_num + (LIST_PANEL_LINES-2)] == 0)
            TpsMenuUnitList_TrySetTargetTopNum(proc->unit_list_proc[i], proc->unit_list_proc[i]->target_top_num-1);
    }

    if (proc->hover_row < proc->unit_list_proc[proc->hover_col]->target_top_num + 1)
        TpsMenuUnitList_TrySetTargetTopNum(proc->unit_list_proc[proc->hover_col], proc->hover_row - 1);

    if (proc->hover_row > proc->unit_list_proc[proc->hover_col]->target_top_num + (LIST_PANEL_LINES-2))
        TpsMenuUnitList_TrySetTargetTopNum(proc->unit_list_proc[proc->hover_col], proc->hover_row - (LIST_PANEL_LINES-2));
}

static void TpsMenu_ChangeColumn(struct TpsMenuProc* proc)
{
    int const old_hover_col = proc->hover_col;
    int const new_hover_row = GetTpsMenuAdjustedRow(proc, old_hover_col ^ 1, proc->hover_row - proc->unit_list_proc[old_hover_col]->target_top_num + proc->unit_list_proc[old_hover_col ^ 1]->target_top_num);

    proc->hover_col = old_hover_col ^ 1;
    proc->hover_row = new_hover_row;

    TpsMenu_UpdateScroll(proc);
}

static int TpsMenu_UpdateSelectionFromKeys(struct TpsMenuProc* proc)
{
    int changed_selection = FALSE;

    if ((gKeyState.repeatedKeys & KEY_DPAD_LEFT) && proc->hover_col == 1)
    {
        TpsMenu_ChangeColumn(proc);
        changed_selection = TRUE;

        // TODO: SONG IDS
        PlaySfx(0x67);
    }

    if ((gKeyState.repeatedKeys & KEY_DPAD_RIGHT) && proc->hover_col == 0)
    {
        TpsMenu_ChangeColumn(proc);
        changed_selection = TRUE;

        // TODO: SONG IDS
        PlaySfx(0x67);
    }

    if (gKeyState.repeatedKeys & KEY_DPAD_DOWN)
    {
        if (proc->unit_list_proc[proc->hover_col]->uid_storage->uids[proc->hover_row] == 0)
        {
            if (gKeyState.repeatedKeys == gKeyState.pressedKeys)
            {
                proc->hover_row = 0;
                changed_selection = TRUE;

                // TODO: SONG IDS
                PlaySfx(0x67);
            }
        }
        else
        {
            proc->hover_row += 1;
            changed_selection = TRUE;

            // TODO: SONG IDS
            PlaySfx(0x67);
        }
    }

    if (gKeyState.repeatedKeys & KEY_DPAD_UP)
    {
        if (proc->hover_row == 0)
        {
            if (gKeyState.repeatedKeys == gKeyState.pressedKeys)
            {
                proc->hover_row = GetTpsMenuAdjustedRow(proc, proc->hover_col, 99);
                changed_selection = TRUE;

                // TODO: SONG IDS
                PlaySfx(0x67);
            }
        }
        else
        {
            proc->hover_row -= 1;
            changed_selection = TRUE;

            // TODO: SONG IDS
            PlaySfx(0x67);
        }
    }

    if (changed_selection)
        TpsMenu_UpdateScroll(proc);

    return changed_selection;
}

static void TpsMenu_DisplayHoverHandCursor(struct TpsMenuProc* proc)
{
    struct Vec2 const loc = GetCellDisplayTileLocation(proc->hover_col, proc->hover_row - proc->unit_list_proc[proc->hover_col]->target_top_num);
    UpdateHandCursor(8*loc.x, 8*loc.y);
}

static void TpsMenu_DisplaySelectHandCursor(struct TpsMenuProc* proc)
{
    int const local_row = proc->select_row - proc->unit_list_proc[proc->select_col]->target_top_num;

    if (local_row < 0 || local_row > LIST_PANEL_LINES)
        return;

    struct Vec2 const loc = GetCellDisplayTileLocation(proc->select_col, local_row);
    PutFrozenHandCursor(8*loc.x, 8*loc.y);
}

void TpsMenu_NeutralLoop(struct TpsMenuProc* proc)
{
    TpsMenu_UpdateSelectionFromKeys(proc);
    TpsMenu_DisplayHoverHandCursor(proc);

    if (gKeyState.pressedKeys & KEY_BUTTON_A)
    {
        if (proc->hover_row < proc->unit_list_proc[proc->hover_col]->uid_storage->forced_amt)
        {
            // cannot move forced unit!

            // TODO: SONG IDS
            PlaySfx(0x6C);
        }
        else
        {
            if (proc->unit_list_proc[proc->hover_col]->uid_storage->uids[proc->hover_row] == 0)
            {
                // cannot move nothing!
				

                // TODO: SONG IDS
                PlaySfx(0x6C);
            }
            else
            {
                proc->select_col = proc->hover_col;
                proc->select_row = proc->hover_row;

                TpsMenu_ChangeColumn(proc);

                // TODO: SONG IDS
                PlaySfx(0x6A);

                ProcGoto((struct Proc*) proc, L_TPSMENU_SELECTED);
            }
        }
    }

    if (gKeyState.pressedKeys & KEY_BUTTON_B)
    {
        // TODO: SONG IDS
        PlaySfx(0x6C);
    }

    if (gKeyState.pressedKeys & KEY_BUTTON_START)
    {
        // TODO: SONG IDS
		//BreakProcLoop((void*)proc); //ProcInstruction
		ProcGoto((struct Proc*) proc, 5); // 
		ClearBG0BG1();
		FillBgMap(&gBg2MapBuffer[0], 0);
		EnableBgSyncByMask(BG0_SYNC_BIT);
		EnableBgSyncByMask(BG1_SYNC_BIT);
		EnableBgSyncByMask(BG2_SYNC_BIT);
        PlaySfx(0x6C);
    }

    if (gKeyState.pressedKeys & KEY_BUTTON_SELECT)
    {
        // int const other_col = proc->hover_col ^ 1;

        // TODO: SONG IDS
        PlaySfx(0x6C);
    }
}

static void TpsMenu_DoSwapUids(struct TpsMenuProc* proc)
{
    int const tmp = proc->unit_list_proc[proc->hover_col]->uid_storage->uids[proc->hover_row];
    proc->unit_list_proc[proc->hover_col]->uid_storage->uids[proc->hover_row] = proc->unit_list_proc[proc->select_col]->uid_storage->uids[proc->select_row];
    proc->unit_list_proc[proc->select_col]->uid_storage->uids[proc->select_row] = tmp;

    TpsUidStorage_RemoveBlankEntries(proc->unit_list_proc[proc->hover_col]->uid_storage);
    TpsUidStorage_RemoveBlankEntries(proc->unit_list_proc[proc->select_col]->uid_storage);

    TpsMenuUnitList_RefreshAll(proc->unit_list_proc[proc->hover_col]);
    TpsMenuUnitList_RefreshAll(proc->unit_list_proc[proc->select_col]);
}

void TpsMenu_SelectedLoop(struct TpsMenuProc* proc)
{
    TpsMenu_UpdateSelectionFromKeys(proc);
    TpsMenu_DisplayHoverHandCursor(proc);
    TpsMenu_DisplaySelectHandCursor(proc);

    if (gKeyState.pressedKeys & KEY_BUTTON_A)
    {
        if (proc->hover_row < proc->unit_list_proc[proc->hover_col]->uid_storage->forced_amt)
        {
            // cannot move forced unit!

            // TODO: SONG IDS
            PlaySfx(0x6C);
        }
        else
        {

			
			
            
			
			// update unit on right side to be in party Y 
			u8 uid = proc->unit_list_proc[proc->hover_col]->uid_storage->uids[proc->hover_row];
			u8 party = proc->info->party_info_list[proc->select_col]->party_num; 
			//u8 party = proc->info->party_info_list[proc->current_party_select[proc->hover_col]]->party_num;
			asm("mov r11, r11");
			if (uid)
				TpsSetPartyRawForPid(uid, party);
			
			// update unit on left side to be in party X 
			uid = proc->unit_list_proc[proc->select_col]->uid_storage->uids[proc->select_row];
			party = proc->info->party_info_list[proc->hover_col]->party_num; 
			asm("mov r11, r11");
			if (uid)
				TpsSetPartyRawForPid(uid, party);
			
			TpsRefreshUnitAwayBits();
			TpsMenu_DoSwapUids(proc);

            proc->hover_col = proc->select_col;
            proc->hover_row = proc->select_row;

            TpsMenu_UpdateScroll(proc);

            // TODO: SONG IDS
            PlaySfx(0x6A);

            ProcGoto((struct Proc*) proc, L_TPSMENU_NEUTRAL);
        }
    }

    if (gKeyState.pressedKeys & KEY_BUTTON_B)
    {
        proc->hover_col = proc->select_col;
        proc->hover_row = proc->select_row;

        TpsMenu_UpdateScroll(proc);

        // TODO: SONG IDS
        PlaySfx(0x6B);

        ProcGoto((struct Proc*) proc, L_TPSMENU_NEUTRAL);
    }

    if (gKeyState.pressedKeys & KEY_BUTTON_START)
    {
        // TODO: SONG IDS
        PlaySfx(0x6C);
    }

    if (gKeyState.pressedKeys & KEY_BUTTON_SELECT)
    {
        // TODO: SONG IDS
        PlaySfx(0x6C);
    }
}

void StartTpsMenu(struct TpsMenuInfo const* info, struct Proc* parent)
{
    struct TpsMenuProc* proc;

    if (parent != NULL)
        proc = (struct TpsMenuProc*) ProcStartBlocking(ProcScr_TpsMenu, parent);
    else
        proc = (struct TpsMenuProc*) ProcStart(ProcScr_TpsMenu, ROOT_PROC_3);

    proc->info = info;
}
