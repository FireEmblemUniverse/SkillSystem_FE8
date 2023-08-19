#pragma once
#include "gbafe.h"

enum State {yield=0, no_yield=1};

typedef struct FMUProc FMUProc;
typedef bool (*ButtonFunc) (struct FMUProc*);

#define LEDGE_JUMP 0x26 // terrain type 

extern struct Unit* GetUnitStructFromEventParameter(int id); 

struct FMUProc {
	PROC_FIELDS;
	/* 29 */	u8 uTimer;
	/* 2A */	u16 Free;
	/* 2C */	s8 xCur;
	/* 2D */	s8 xTo;
	/* 2E */	s8 yCur;
	/* 2F */	s8 yTo;
	/* 30 */	Unit* FMUnit;
	/* 34 */    s8 smsFacing; 
	/* 35 */    u8 moveSpeed; // hardcoded to this proc field in MU6Cfix
	/* 36 */    u16 curInput; 
	/* 38 */    u16 lastInput; 
	/* 3a */    u8 yield; 
	/* 3b */    u8 yield_move; 
	/* 3c */    u8 countdown; 
	/* 3d */    u8 usedLedge; 
	/* 3e */    u8 ledgeX; 
	/* 3f */    u8 ledgeY; 
	/* 40 */    u8 range_event; 
	/* 41 */    u8 end_after_movement; 
	/* 42 */    u8 updateSMS; 
	/* 43 */    u8 eventEngineTimer; 
	/* 44 */    void* pEventIdk; 
	/* 48 */    u8 updateCameraAfterEvent; 
	/* 49 */    u8 updateAfterStatusScreen;
	/* 4a */    u8 commandID; //scriptedMovement 
	/* 4b */    u8 command[0x15]; //scriptedMovement 
};

struct MuCtr { 
	PROC_FIELDS; 
	u8 dummy1; 
	u8 dummy2; 
	u8 dummy3; 
	u32 dummyA; // 0x2c 
	u32 dummyB; // 0x30 
	u32 dummyC; // 0x34 
	u32 dummyD; // 0x38
	u32 dummyE; // 0x3C
	u8 xPos; // 0x40 
	u8 yPos; 
	u8 xPos2; 
	u8 yPos2; 


}; 
extern const ProcInstruction gUnknown_089A2DB0; 
extern const ProcInstruction gProc_TargetSelection; 
extern const ProcInstruction gProc_TradeMenu; 
extern const ProcInstruction gProc_CameraMovement; 
extern const ProcInstruction gProc_Menu; 
extern const ProcInstruction gProc_Supply; 
extern const ProcInstruction gProc_Shop; 
extern const ProcInstruction gProc_MapMain; 

extern int ProtagID_Link; 
extern u8 StraightLineWeaponsList[];

struct FMUTrapDef{
	ButtonFunc Func;
	ButtonFunc Usab; 
};
extern struct FMUTrapDef HookListFMU_TrapTable_PressA_Auto[];
extern struct FMUTrapDef HookListFMU_TrapTable_PressA_Adjacent[];

extern struct FMUTrapDef HookListFMU_TrapTable_Auto_On[];
extern struct FMUTrapDef HookListFMU_TrapTable_Auto_Adjacent[];


struct LocEventDef {
	u8 LocID;
	u8 TrapID;
};

struct speedToggleStruct { 
	u8 speedA; 
	u8 speedB; 
}; 
extern struct speedToggleStruct FreeMU_MovingSpeed; 
extern struct LocEventDef HookListFMU_LocationBasedEvent[];
extern struct LocEventDef HookListFMU_LocationBasedEventDoor[];
extern ButtonFunc FMU_FunctionList_OnPressA[];
extern ButtonFunc FMU_FunctionList_OnPressB[];
extern ButtonFunc FMU_FunctionList_OnPressR[];
extern ButtonFunc FMU_FunctionList_OnPressL[];
extern ButtonFunc FMU_FunctionList_OnPressSelect[];
extern ButtonFunc FMU_FunctionList_OnPressStart[];

extern const u8 TimerDelay;
//#define FreeMoveFlag iFRAM[0]
//extern u8* const FreeMoveFlag;
struct FMURam { 
	u8 state : 1; 
	u8 running : 1; 
	u8 dir : 2; 
	u8 silent : 1; 
	u8 use_dir : 1; 
	u8 pause : 1; 
};

extern struct FMURam* FreeMoveRam; 

struct unitFacing { // uses +0x39 supportBits 
	u8 dir : 2; 
};

#define RunCharacterEvents ( (void(*)(u8,u8))(0x8083FB1) )
#define CheckForCharacterEvents ( (u8(*)(u8,u8))(0x8083F69) )
extern const ProcCode FMU_IdleProc[];
extern const ProcCode FreeMovementControlProc[];
extern const MenuDefinition FreeMovementLMenu;
extern bool RunMiscBasedEvents(u8,u8);
extern const ProcInstruction gProc_MapEventEngine; 
extern u8 GetLocationEventCommandAt(int x, int y); 
extern void RunLocationEvents(int x, int y); 


/*------------- External --------------*/
bool FMU_CanUnitBeOnPos(Unit*, s8, s8);
void EnableFreeMovementASMC(void);
void DisableFreeMovementASMC(void);
u8 GetFreeMovementState(void);
void End6CInternal_FreeMU();
void ChangeControlledUnitASMC(struct FMUProc*);
void NewPlayerPhaseEvaluationFunc(struct Proc*);
void NewMakePhaseControllerFunc(struct Proc*);
void pFMU_OnInit(struct FMUProc*);
void pFMU_InitTimer(struct FMUProc*);
int pFMU_CorrectCameraPosition(struct FMUProc*);
u8 FMU_ChkKeyForMUExtra(struct FMUProc*, u16);
void FMU_InitVariables(struct FMUProc* proc); 
extern const void* StallEvent; 
/*------------- Core --------------*/
void pFMU_MainLoop(struct FMUProc*);
int pFMU_HanleContinueMove(struct FMUProc*);
int pFMU_MoveUnit(struct FMUProc*, u16 iKeyCur);
int pFMU_HandleKeyMisc(struct FMUProc*, u16 iKeyCur);
int pFMU_HandleSave(struct FMUProc*);
void pFMU_PressA(struct FMUProc*);
void pFMU_PressB(struct FMUProc*);
void pFMU_PressL(struct FMUProc*);
void pFMU_PressR(struct FMUProc*);
void pFMU_PressSelect(struct FMUProc*);
void pFMU_PressStart(struct FMUProc*);
void pFMU_UpdateSMS(struct FMUProc* proc);
bool FMU_CheckForLedge(struct FMUProc* proc, int x, int y);
void FMU_ResetLCDIO(void);
int gMapPUnit(int x, int y);
void SetUnitFacing(struct Unit* unit, int dir);
int GetUnitFacing(struct Unit* unit);
void UpdateSMSDir(struct Unit* unit, u8 smsID, int facing);

/*------------- Events --------------*/
void pFMU_RunMiscBasedEvents(struct FMUProc*);
int pFMU_RunLocBasedAsmcAuto(struct FMUProc*);
bool FMUmisc_RunMapEvents(struct FMUProc*);
bool FMUmisc_RunTalkEvents(struct FMUProc*);
bool FMU_RunTrapASMC(FMUProc*);
bool FMU_RunTrapASMC_Auto(FMUProc*);
bool FMU_RunTrap(FMUProc* proc, struct FMUTrapDef* trapEff, int x, int y);

/*------------- KeyPress --------------*/
bool FMU_OnButton_StartMenu(FMUProc*);
int FMU_OnButton_EndFreeMove(void);
int FMU_EndFreeMoveSilent(void);
bool FMU_OnButton_ChangeUnit(FMUProc*);
u16 FMU_FilterMovementInput(struct FMUProc*, u16);

/*------------- Graphics --------------*/
extern void* FMU_idleSMSGfxTable_left[0xFF];
extern void* FMU_idleSMSGfxTable_right[0xFF];
extern void* FMU_idleSMSGfxTable_up[0xFF];

/*------------- Other -----------------*/
extern u8 gSMSGfxBuffer_Frame1[0x2000];                                   //! FE8U = 0x2034010
extern u8 gSMSGfxBuffer_Frame2[0x2000];                                   //! FE8U = 0x2036010
extern u8 gSMSGfxBuffer_Frame3[0x2000];                                   //! FE8U = 0x2038010
const u8 CheckEventId(u16 eventId);                                       //! FE8U = 0x8083DA8
const void CopyTileGfxForObj(void* src, void* dest, u8 width, u8 height); //! FE8U = 0x8013020
const void MuCtr_OnEnd(Proc* proc);                                       //! FE8U = 0x807A1FD
extern int CenterCameraOntoPosition(struct Proc* parent, int x, int y);
extern u8 MapEventEngineExists(void); 
void FMU_StartPlayerPhase(void);

void pFMU_DoNothing(struct Proc* proc);

extern void MU_DisplayAsMMS(struct MUProc* proc); 

extern u16 GetCameraCenteredX(int x); 
extern u16 GetCameraAdjustedX(int x); 
extern u16 GetCameraCenteredY(int y); 
extern u16 GetCameraAdjustedY(int y); 

extern void GetPlayerStartCursorPosition(int *px, int *py);
extern void GetEnemyStartCursorPosition(int *px, int *py); 


struct CamMoveProc {
    /* 00 */ PROC_HEADER;
	/* 2a */ short dummy; 
    /* 2C */ struct Vec2 to;
    /* 30 */ struct Vec2 from;
    /* 34 */ struct Vec2 watchedCoordinate;
    /* 38 */ s16 calibration;
    /* 3A */ s16 distance;
    /* 3C */ int frame;
    /* 40 */ s8 xCalibrated;
};
struct ProcCmd
{
    short opcode;
    short dataImm;
    const void* dataPtr;
};
extern struct ProcCmd gProcScr_CamMove[];



struct BmSt // Game State Struct
{
    /* 00 */ s8  mainLoopEndedFlag;

    /* 01 */ s8  gameLogicSemaphore;
    /* 02 */ s8  gameGfxSemaphore;

    /* 03 */ u8  _unk04;

    /* 04 */ u8  gameStateBits;

    /* 05 */ u8  _unk05;

    /* 06 */ u16 prevVCount;

    /* 08 */ u32 _unk08;

    /* 0C */ struct Vec2 camera;
    /* 10 */ struct Vec2 cameraPrevious;
    /* 14 */ struct Vec2 playerCursor;
    /* 18 */ struct Vec2 cursorPrevious;
    /* 1C */ struct Vec2 cursorTarget;
    /* 20 */ struct Vec2 playerCursorDisplay;
    /* 24 */ struct Vec2u mapRenderOrigin;
    /* 28 */ struct Vec2 cameraMax;

    /* 2C */ u16 itemUnk2C;
    /* 2E */ u16 itemUnk2E;

    /* 30 */ u16 unk30;
    /* 32 */ s16 unk32;
    /* 34 */ s16 unk34;
    /* 36 */ s8 unk36;
    /* 37 */ s8 unk37;
    /* 38 */ u8 altBlendACa;
    /* 39 */ u8 altBlendACb;
    /* 3A */ u8 altBlendBCa;
    /* 3B */ u8 altBlendBCb;
    /* 3C */ u8 just_resumed;
    /* 3D */ u8 unk3D;
    /* 3E */ u8 unk3E;
    /* 3F */ s8 unk3F;
};
extern struct BmSt gBmSt;


struct MenuRect { s8 x, y, w, h; };

struct MenuDef;
struct MenuItemDef;

struct MenuProc;
struct MenuItemProc;

struct MenuItemProc
{
    /* 00 */ PROC_HEADER;

    /* 2A */ short xTile;
    /* 2C */ short yTile;

    /* 30 */ const struct MenuItemDef* def;

    /* 34 */ struct TextHandle text;

    /* 3C */ s8 itemNumber;
    /* 3D */ u8 availability;
};

struct MenuItemDef
{
    /* 00 */ const char* name;

    /* 04 */ u16 nameMsgId, helpMsgId;
    /* 08 */ u8 color, overrideId;

    /* 0C */ u8(*isAvailable)(const struct MenuItemDef*, int number);

    /* 10 */ int(*onDraw)(struct MenuProc*, struct MenuItemProc*);

    /* 14 */ u8(*onSelected)(struct MenuProc*, struct MenuItemProc*);
    /* 18 */ u8(*onIdle)(struct MenuProc*, struct MenuItemProc*);

    /* 1C */ int(*onSwitchIn)(struct MenuProc*, struct MenuItemProc*);
    /* 20 */ int(*onSwitchOut)(struct MenuProc*, struct MenuItemProc*);
};

struct MenuDef
{
    /* 00 */ struct MenuRect rect;
    /* 04 */ u8 style;
    /* 08 */ const struct MenuItemDef* menuItems;

    /* 0C */ void(*onInit)(struct MenuProc*);
    /* 10 */ void(*onEnd)(struct MenuProc*);
    /* 14 */ void(*_u14)(struct MenuProc*);
    /* 18 */ u8(*onBPress)(struct MenuProc*, struct MenuItemProc*);
    /* 1C */ u8(*onRPress)(struct MenuProc*);
    /* 20 */ u8(*onHelpBox)(struct MenuProc*, struct MenuItemProc*);
};
struct EventEngineProc {
    PROC_HEADER;
	u8 dummy1;
	u8 dummy2;
	u8 dummy3;

    /* 2C */ void (*pCallback)(struct EventEngineProc*);

    /* 30 */ const u16* pEventStart;
    /* 34 */ const u16* pEventIdk;
    /* 38 */ const u16* pEventCurrent;

    /* 3C */ u16 evStateBits;
    /* 3E */ u16 evStallTimer;

    /* 40 */ s8 overwrittenTextSpeed;
    /* 41 */ u8 execType;
    /* 42 */ u8 activeTextType;
    /* 43 */ u8 chapterIndex;

    /* 44 */ u16 mapSpritePalIdOverride;

    /* 46 */ // pad

    /* 48 */ const void* pUnitLoadData;
    /* 4C */ s16 unitLoadCount;

    /* 4E */ u8  idk4E;

    /* 4F */ u8 _pad_4F[0x54 - 0x4F];
    /* 54 */ struct Unit *unit;
};









