#ifndef GBAFE_EVENT_H
#define GBAFE_EVENT_H

// From StanH' version FE8U
struct EventEngineProc {
    PROC_HEADER;

    /* 2C */ void (*pCallback)(struct EventEngineProc*);

    /* 30 */ const u16* pEventStart;
    /* 34 */ const u16* pEventIdk;
    /* 38 */ const u16* pEventCurrent;

    /* 3C */ u16 evStateBits;
    /* 3E */ u16 evStallTimer;

    /* 40 */ s8 overwrittenTextSpeed;
    /* 41 */ u8 execType;
    /* 42 */ u8 activeTextType;
    /* 43 */ u8 chapter;

    /* 44 */ u16 mapSpritePalIdOverride;

    /* 46 */ // pad

    /* 48 */ const void* pUnitLoadData;
    /* 4C */ u16 unitLoadCount;
    
    /* 4E */ u8  idk4E;
};

enum EventExecType {
    EV_EXEC_WORLDMAP  = 0, // for world map events
    EV_EXEC_CUTSCENE  = 1, // for overall chapter cutscene events?
    EV_EXEC_GAMEPLAY  = 2, // for gameplay-triggered events? (battle quotes, villages tile changes, chests, game over)
    EV_EXEC_QUIET     = 3, // for events that should just execute events? (no fade, no clearing stuff, etc)
    EV_EXEC_UNK4      = 4, // not used?
    EV_EXEC_UNK5      = 5  // not used?
};

enum EventStateFlags {
    EV_STATE_NONE      = 0,

    EV_STATE_ABORT     = (1 << 0x0), // queued event engine calls will wait
    EV_STATE_0002      = (1 << 0x1), // prevents "ENDA events" to play. Needs further investigation
    EV_STATE_SKIPPING  = (1 << 0x2), // currently skipping events (trigger with start)
    EV_STATE_0008      = (1 << 0x3), // ??? seems to be dialogue related
    EV_STATE_NOSKIP    = (1 << 0x4), // prevents skipping with start, set by EVBIT_MODIFY
    EV_STATE_0020      = (1 << 0x5), // set by EVBIT_MODIFY
    EV_STATE_0040      = (1 << 0x6), // set by EVBIT_MODIFY
    EV_STATE_NOFADE    = (1 << 0x7), // don't fade at end of events
    EV_STATE_FADEDIN   = (1 << 0x8), // faded into white/back
    EV_STATE_UNITCAM   = (1 << 0x9), // camera follows unit movement
    EV_STATE_CHANGECH  = (1 << 0xA), // moving to another chapter (?)
    EV_STATE_CHANGEGM  = (1 << 0xB), // changing "game mode" (GAMECTRL field 0x29 was changed?)
    EV_STATE_GFXLOCKED = (1 << 0xC)  // set when the game graphics have been locked through events (codes 0x23/0x24)

    // I don't think there's more, but I could be wrong
};











extern unsigned gEventSlot[];
extern unsigned gEventQueue[];

extern unsigned gEventCounter;

void SetEventCounter(unsigned); //! FE8U = 0x800D589
unsigned GetEventCounter(void); //! FE8U = 0x800D595




// Mokha
u8 GetBattleMapType(void); // 0x80BD069
u8 GetLocationEventCommandAt(s8 x, s8 y); // 0x8084079
u32* CheckEventDefinition(u32*);
s8 CheckEventId(int eventID); // 0x8083DA9

void RunLocationEvents(s8 x, s8 y); // 0x80840C5
void CallMapEventEngine(u32*,u8); // 0x800D07D
void CallEventDefinition(u32*,u8); // 0x8082E81
u32 CheckNextEventDefinition(u32*); // 0x8082F29
void ClearActiveEventRegistry(u32*); // 0x80845A5
int MapEventEngineExists(); // 0x800D199

// Toturial
int CheckBattleForecastTutorialEvent(); // 0x8084560+1

#endif // GBAFE_EVENT_H
