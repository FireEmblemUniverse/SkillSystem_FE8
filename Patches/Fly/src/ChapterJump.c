#include "gbafe.h"

static int  JumpEvent(MenuProc* menu, MenuCommandProc* command);
static int  JumpIdle (MenuProc* menu, MenuCommandProc* command);
static int  JumpDrawIdle(MenuProc* menu, MenuCommandProc* command);
static void JumpDraw(struct MenuProc* menu, struct MenuCommandProc* command);
static void JumpMenuEnd(struct MenuProc* menu);

struct DebugEventList
{
    u32 eventPointer;
};

extern int EmptyEvent;
extern struct DebugEventList DebugEvent[0xFF];

struct ChapterJumpProc
{
    PROC_HEADER;

    /* 2C */ struct Unit* unit;

    /* 30 */ u8 menuIndex;
};

static const struct ProcInstruction Proc_ChapterJump[] =
{
    PROC_CALL_ROUTINE(LockGameLogic),

    PROC_YIELD,

    PROC_CALL_ROUTINE(UnlockGameLogic),
    PROC_END,
};

//For selecting what each menu command does.
static const struct MenuCommandDefinition MenuCommands_Jump[] =
{
    {
        .isAvailable = MenuCommandAlwaysUsable,

        .onDraw = JumpDraw,
        .onIdle = JumpIdle,
        .onEffect = JumpEvent,
    },

    {} //END

};

static const struct MenuDefinition Menu_Jump =
{
    .geometry = { 7, 1, 16 },
    .commandList = MenuCommands_Jump,

    .onEnd = JumpMenuEnd,
    .onBPress = (void*) (0x080152F4+1), // Goes back to main game loop
};

//Handles what to do when buttons are pushed
static int JumpIdle (MenuProc* menu, MenuCommandProc* command) {
    struct ChapterJumpProc* const proc = (void*) menu->parent;

    //TODO update graphics in a cleaner way
    if (gKeyState.repeatedKeys & KEY_DPAD_LEFT) {
        if (proc->menuIndex != 0) {
            proc->menuIndex--;
            JumpDraw(menu, command);
            PlaySfx(0x6B);
        }
    }

    if (gKeyState.repeatedKeys & KEY_DPAD_RIGHT) {
        if (proc->menuIndex < 0x4E) {
            proc->menuIndex++;
            JumpDraw(menu, command);
            PlaySfx(0x6B);
        }
    }

    return ME_NONE;
}

/*
Event data:
22 2A 01 00 28 02 07 00 20 01 00 00
       ^ Chapter ID byte
*/
static int JumpEvent(MenuProc* menu, MenuCommandProc* command) {
    struct ChapterJumpProc* const proc = (void*) menu->parent;

    int eventList[8] = {
    0x003C1721, //FADI 60
    0x00000A40, //CALL
    DebugEvent[proc->menuIndex].eventPointer,
    0x00020540, //SVAL 2
    proc->menuIndex,
    0xFFFD2A22, //MNC2
    0x00070228, //NoFade
    0x00000120  //ENDA
    };

    if (eventList[2] == 0) {
        eventList[2] = (int)&EmptyEvent;
    }

    memcpy((void*)0x202B670, &eventList, 32);

    CallMapEventEngine((void*) (0x202B670), 1);
    
    return ME_END;

}

//I think this is supposed to run repeatedly, but that doesn't seem to be the case
static int JumpDrawIdle(MenuProc* menu, MenuCommandProc* command) {
    struct ChapterJumpProc* const proc = (void*) menu->parent;
    u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);

    u16 title = GetChapterDefinition(proc->menuIndex)->titleID;

    Text_Clear(&command->text);

    //TODO display chapter ID if there is no chapter title
    Text_SetColorId(&command->text, TEXT_COLOR_NORMAL);
    if (title == 0) {
        Text_DrawNumberOr2Dashes(&command->text, proc->menuIndex);
    }
    else {
        Text_DrawString(&command->text, GetStringFromIndex(title));
    }

    Text_Display(&command->text, out);
    return ME_NONE;
}

//Initializes menu
int Jump_OnSelect(struct MenuProc* menu, struct MenuCommandProc* command) {
    struct ChapterJumpProc* proc = (void*) ProcStart(Proc_ChapterJump, ROOT_PROC_3);

    proc->menuIndex = 0;

    StartMenuChild(&Menu_Jump, (void*) proc);

    return ME_DISABLE | ME_END | ME_PLAY_BEEP | ME_CLEAR_GFX;
}

//This actually draws the UI
static void JumpDraw(struct MenuProc* menu, struct MenuCommandProc* command) {
    command->onCycle = (void*) JumpDrawIdle(menu, command);
}

//For the final things before exiting the menu
static void JumpMenuEnd(struct MenuProc* menu) {
    return;
}
