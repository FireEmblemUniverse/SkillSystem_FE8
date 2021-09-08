#include "include/gbafe.h"

#ifndef FREE_MOVEMENT_MOKHA
#define FREE_MOVEMENT_MOKHA

struct FMUProc {
	PROC_FIELDS;
	/* 29 */	u8 uTimer;
	/* 2A */	u16 Free;
	/* 2C */	s8 xCur;
	/* 2D */	s8 xTo;
	/* 2E */	s8 yCur;
	/* 2F */	s8 yTo;
	/* 30 */	Unit* FMUnit;
};

#define FreeMoveFlag iFRAM[0]
#define RunCharacterEvents ( (void(*)(u8,u8))(0x8083FB1) )
#define CheckForCharacterEvents ( (u8(*)(u8,u8))(0x8083F69) )
extern const ProcCode FreeMovementControlProc[];
extern const MenuDefinition FreeMovementLMenu;
extern void RunMiscBasedEvents(u8,u8);


/*------------- External --------------*/
bool FMU_CanUnitBeOnPos(Unit*, s8, s8);
void EnableFreeMovementASMC(void);
void DisableFreeMovementASMC(void);
u8 GetFreeMovementState(void);
void ChangeControlledUnitASMC(struct FMUProc*);
void NewPlayerPhaseEvaluationFunc(struct Proc*);
void NewMakePhaseControllerFunc(struct Proc*);
void pFMU_OnInit(struct FMUProc*);
void pFMU_InitTimer(struct FMUProc*);
void pFMU_CorrectCameraPosition(struct FMUProc*);
u8 FMU_ChkKeyForMUExtra(void);


/*------------- Core --------------*/
void pFMU_MainLoop(struct FMUProc*);
void pFMU_HanleContinueMove(struct FMUProc*);
void pFMU_MoveUnit(struct FMUProc*);
void pFMU_HandleKeyMisc(struct FMUProc*);
void pFMU_HandleSave(struct FMUProc*);
void pFMU_PressA(struct FMUProc*);
void pFMU_PressL(struct FMUProc*);
void pFMU_PressSelect(struct FMUProc*);
void pFMU_PressStart(struct FMUProc*);


/*------------- Events --------------*/
void pFMU_RunMiscBasedEvents(struct FMUProc*);
void FMUmisc_RunMapEvents(struct FMUProc*);
void FMUmisc_RunTalkEvents(struct FMUProc*);


#endif //FREE_MOVEMENT_MOKHA