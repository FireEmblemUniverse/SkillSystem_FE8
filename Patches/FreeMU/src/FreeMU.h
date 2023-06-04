#pragma once
#include "gbafe.h"

enum State {yield=0, no_yield=1};

typedef struct FMUProc FMUProc;
typedef bool (*ButtonFunc) (struct FMUProc*);

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
	///* 35 */    u8 timerPress; 
	/* 36 */    u16 bufferPress; 
	/* 38 */    int timerPress;
	/* 3c */    int timerYield; 
};

struct FMUTrapDef{
	u8 TrapID;
	ButtonFunc Func;
};
extern struct FMUTrapDef HookListFMU_TrapList_OnPressA[];
extern struct FMUTrapDef HookListFMU_TrapList_Auto[];


struct LocEventDef {
	u8 LocID;
	u8 TrapID;
};


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
extern u8* const FreeMoveFlag;

#define RunCharacterEvents ( (void(*)(u8,u8))(0x8083FB1) )
#define CheckForCharacterEvents ( (u8(*)(u8,u8))(0x8083F69) )
extern const ProcCode FreeMovementControlProc[];
extern const MenuDefinition FreeMovementLMenu;
extern bool RunMiscBasedEvents(u8,u8);


/*------------- External --------------*/
bool FMU_CanUnitBeOnPos(Unit*, s8, s8);
void EnableFreeMovementASMC(void);
void DisableFreeMovementASMC(void);
u8 GetFreeMovementState(void);
void End6CInternal_FreeMU(FMUProc* proc);
void ChangeControlledUnitASMC(struct FMUProc*);
void NewPlayerPhaseEvaluationFunc(struct Proc*);
void NewMakePhaseControllerFunc(struct Proc*);
void pFMU_OnInit(struct FMUProc*);
void pFMU_InitTimer(struct FMUProc*);
int pFMU_CorrectCameraPosition(struct FMUProc*);
u8 FMU_ChkKeyForMUExtra(void);


/*------------- Core --------------*/
void pFMU_MainLoop(struct FMUProc*);
int pFMU_HanleContinueMove(struct FMUProc*);
int pFMU_MoveUnit(struct FMUProc*);
int pFMU_HandleKeyMisc(struct FMUProc*);
int pFMU_HandleSave(struct FMUProc*);
void pFMU_PressA(struct FMUProc*);
void pFMU_PressB(struct FMUProc*);
void pFMU_PressL(struct FMUProc*);
void pFMU_PressR(struct FMUProc*);
void pFMU_PressSelect(struct FMUProc*);
void pFMU_PressStart(struct FMUProc*);
void BufferButtonPresses(struct FMUProc*); 


/*------------- Events --------------*/
void pFMU_RunMiscBasedEvents(struct FMUProc*);
int pFMU_RunLocBasedAsmcAuto(struct FMUProc*);
bool FMUmisc_RunMapEvents(struct FMUProc*);
bool FMUmisc_RunTalkEvents(struct FMUProc*);
bool FMU_RunTrapASMC(FMUProc*);
bool FMU_RunTrapASMC_Auto(FMUProc*);

/*------------- KeyPress --------------*/
bool FMU_OnButton_StartMenu(FMUProc*);
bool FMU_OnButton_EndFreeMove(FMUProc*);
bool FMU_OnButton_ChangeUnit(FMUProc*);

/*------------- Graphics --------------*/
extern void* FMU_idleSMSGfxTable[0xFF];

/*------------- Other -----------------*/
extern u8 gSMSGfxBuffer_Frame1[0x2000];                                   //! FE8U = 0x2034010
extern u8 gSMSGfxBuffer_Frame2[0x2000];                                   //! FE8U = 0x2036010
extern u8 gSMSGfxBuffer_Frame3[0x2000];                                   //! FE8U = 0x2038010
const u8 CheckEventId(u16 eventId);                                       //! FE8U = 0x8083DA8
const void CopyTileGfxForObj(void* src, void* dest, u8 width, u8 height); //! FE8U = 0x8013020
const void MuCtr_OnEnd(Proc* proc);                                       //! FE8U = 0x807A1FD
