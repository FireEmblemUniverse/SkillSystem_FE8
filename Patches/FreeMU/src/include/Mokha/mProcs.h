#ifndef HEARDERMOKHA_PROCDEF
#define HEARDERMOKHA_PROCDEF

extern const ProcCode gProc_MapMain[];
void MapMain_CallBeginningEvent(Proc*); // 0x80153D5
void MapMain_SwitchPhases(Proc*); //  0x8015411
void MapMain_ThisProbablyUsedToBeEventRelatedInEarlierGames(Proc*); //  0x8015435
void MapMain_StartPhaseController(Proc*); //  0x8015451
void MapMain_StartPlayerPhaseAndApplyAction(Proc*); //  0x80154A5
void MapMain_UpdateTraps(Proc*); //  0x80154C9
void MapMain_Suspend(Proc*); //  0x80154F5
void MapMain_StartIntroFx(Proc*); //  0x801550D
void MapMain_DeployEveryone(Proc*); //  0x8015545

extern const ProcCode gProc_CpPhase[]; // 0x85A7F08
extern const ProcCode gProc_BerserkPhase[]; // 0x85A7F30

#endif // HEARDERMOKHA_PROCDEF