#ifndef GBAFE_PROC_H
#define GBAFE_PROC_H

// proc.c

#include "common.h"

typedef struct Proc Proc;
typedef struct Proc ProcState;

typedef struct ProcInstruction ProcCode;
typedef struct ProcInstruction ProcInstruction;

struct ProcInstruction {
	u16 type;
	u16 sArg;
	const void* lArg;
};

#define PROC_FIELDS \
	ProcInstruction* codeStart; /* start of instructions */ \
	ProcInstruction* codeNext; /* next instruction */ \
	void (*onEnd)(Proc*); /* called on proc end */ \
	void (*onCycle)(Proc*); /* called on proc cycle */ \
	const char* name; /* name (debug) */ \
	Proc* parent; /* parent proc */ \
	Proc* child; /* first child proc */ \
	Proc* previous; /* previous proc (younger sibling) */ \
	Proc* next; /* next proc (older sibling) */ \
	u16 sleepTime; /* time left to sleep */ \
	u8 mark; /* mark */ \
	u8 statebits; /* state */ \
	u8 lockCount; /* lock count*/

struct Proc {
	PROC_FIELDS;
};

#define ROOT_PROC_0 (Proc*)(0)
#define ROOT_PROC_1 (Proc*)(1)
#define ROOT_PROC_2 (Proc*)(2)
#define ROOT_PROC_3 (Proc*)(3)
#define ROOT_PROC_4 (Proc*)(4)
#define ROOT_PROC_5 (Proc*)(5)
#define ROOT_PROC_6 (Proc*)(6)
#define ROOT_PROC_7 (Proc*)(7)

#define PROC_END { 0x00, 0x0000, 0 }
#define PROC_SET_NAME(aName) { 0x01, 0x0000, aName }
#define PROC_CALL_ROUTINE(apRoutine) { 0x02, 0x0000, (const void*)(apRoutine) }
#define PROC_LOOP_ROUTINE(apRoutine) { 0x03, 0x0000, (const void*)(apRoutine) }
#define PROC_SET_DESTRUCTOR(apRoutine) { 0x04, 0x0000, (const void*)(apRoutine) }
#define PROC_NEW_CHILD(ap6CChild) { 0x05, 0x0000, (const void*)(ap6CChild) }
#define PROC_NEW_CHILD_BLOCKING(ap6CChild) { 0x06, 0x0000, (const void*)(ap6CChild) }
#define PROC_NEW_MAIN_BUGGED(ap6CMain) { 0x07, 0x0000, ap6CMain }
#define PROC_WHILE_EXISTS(ap6CToCheck) { 0x08, 0x0000, (const void*)(ap6CToCheck) }
#define PROC_END_ALL(ap6CToCheck) { 0x09, 0x0000, (const void*)(ap6CToCheck) }
#define PROC_BREAK_ALL_LOOP(ap6CToCheck) { 0x0A, 0x0000, (const void*)(ap6CToCheck) }
#define PROC_LABEL(aLabelId) { 0x0B, aLabelId, 0 }
#define PROC_GOTO(aLabelId) { 0x0C, aLabelId, 0 }
#define PROC_JUMP(ap6CCode) { 0x0D, 0x0000, (const void*)(ap6CCode) }
#define PROC_SLEEP(aTime) { 0x0E, aTime, 0 }
#define PROC_SET_MARK(aMark) { 0x0F, aMark, 0 }
#define PROC_BLOCK { 0x10, 0x0000, 0 }
#define PROC_END_IF_DUPLICATE { 0x11, 0x0000, 0 }
#define PROC_SET_BIT4 { 0x12, 0x0000, 0 }
#define PROC_13 { 0x13, 0x0000, 0 }
#define PROC_WHILE_ROUTINE(aprRoutine) { 0x14, 0x0000, (const void*)(aprRoutine) }
#define PROC_15 { 0x15, 0x0000, 0 }
#define PROC_CALL_ROUTINE_2(aprRoutine) { 0x16, 0x0000, (const void*)(aprRoutine) }
#define PROC_END_DUPLICATES { 0x17, 0x0000, 0 }
#define PROC_CALL_ROUTINE_ARG(aprRoutine, aArgument) { 0x18, aArgument, (const void*)(aprRoutine) }
#define PROC_19 { 0x19, 0x0000, 0 }

#define PROC_YIELD PROC_SLEEP(0)

Proc* ProcStart(const ProcInstruction*, Proc*); //! FE8U = (0x08002C7C+1)
Proc* ProcStartBlocking(const ProcInstruction*, Proc*); //! FE8U = (0x08002CE0+1)
void EndProc(Proc*); //! FE8U = (0x08002D6C+1)
void ExecProc(Proc*); //! FE8U = (0x08002E84+1)
void BreakProcLoop(Proc*); //! FE8U = (0x08002E94+1)
Proc* ProcFind(const ProcInstruction*); //! FE8U = (0x08002E9C+1)
void ProcGoto(Proc*, int); //! FE8U = (0x08002F24+1)
void ProcGotoPtr(Proc*, const ProcInstruction*); //! FE8U = (0x08002F5C+1)
void ProcMark(Proc*, int); //! FE8U = (0x08002F64+1)
void ProcSetEndFunc(Proc*, void(*)(Proc*)); //! FE8U = (0x08002F6C+1)
void ForEveryProc(void(*)(Proc*)); //! FE8U = (0x08002F70+1)
void ForEachProc(const ProcInstruction*, void(*)(Proc*)); //! FE8U = (0x08002F98+1)
void ProcHaltEachMarked(int); //! FE8U = (0x08002FEC+1)
void ProcResumeEachMarked(int); //! FE8U = (0x08003014+1)
void EndEachProcMarked(int); //! FE8U = (0x08003040+1)
void EndEachProc(const ProcInstruction*); //! FE8U = (0x08003078+1)
void BreakEachProcLoop(const ProcInstruction*); //! FE8U = (0x08003094+1)
void SetProcCycleHandler(Proc*, void(*)(Proc*)); //! FE8U = (0x08003450+1)

// compat with decomp

#define PROC_HEADER PROC_FIELDS

#define Proc_Create ProcStart
#define Proc_CreateBlockingChild ProcStartBlocking
#define Proc_Delete EndProc
#define Proc_Run ExecProc
#define Proc_ClearNativeCallback BreakProcLoop
#define Proc_Find ProcFind
#define Proc_GotoLabel ProcGoto
#define Proc_JumpToPointer ProcGotoPtr
#define Proc_SetMark ProcMark
#define Proc_SetDestructor ProcSetEndFunc
#define Proc_ForEach ForEveryProc
#define Proc_ForEachWithScript ForEachProc
#define Proc_BlockEachWithMark ProcHaltEachMarked
#define Proc_UnblockEachWithMark ProcResumeEachMarked

// void Proc_Initialize(void);
// ??? Proc_Create(???);
// ??? Proc_CreateBlockingChild(???);
// ??? Proc_Delete(???);;
// ??? Proc_Run(???);
// ??? Proc_ClearNativeCallback(???);
// ??? Proc_Find(???);
// ??? Proc_FindNonBlocked(???);
// ??? Proc_FindWithMark(???);
// ??? Proc_GotoLabel(???);
// ??? Proc_JumpToPointer(???);
// ??? Proc_SetMark(???);
// ??? Proc_SetDestructor(???);
// ??? Proc_ForEach(???);
// ??? Proc_ForEachWithScript(???);
// ??? Proc_ForEachWithMark(???);
// ??? Proc_BlockEachWithMark(???);
// ??? Proc_UnblockEachWithMark(???);
// ??? Proc_DeleteEachWithMark(???);
// ??? Proc_DeleteAllWithScript(???);
// ??? Proc_ClearNativeCallbackEachWithScript(???);
// ??? sub_80030CC(???);
// ??? sub_800344C(???);
// ??? Proc_SetNativeFunc(???);
// ??? Proc_BlockSemaphore(???);
// ??? Proc_WakeSemaphore(???);
// ??? Proc_FindAfter(???);
// ??? Proc_FindAfterWithParent(???);
// ??? sub_80034D4(???);
// ??? sub_80034FC(???);
// ??? sub_8003530(???);
// ??? sub_8003540(???);

#endif // GBAFE_PROC_H
