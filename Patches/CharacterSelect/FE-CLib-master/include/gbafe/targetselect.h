#ifndef GBAFE_TARGETSELECT_H
#define GBAFE_TARGETSELECT_H

#include "proc.h"

struct TargetSelectionProc;

typedef struct TargetEntry TargetEntry;
typedef struct TargetSelectionDefinition TargetSelectionDefinition;
typedef struct TargetSelectionProc TargetSelectionProc;

struct TargetEntry {
	/* 00 */ u8 x, y;
	/* 02 */ u8 unitIndex;
	/* 03 */ u8 trapIndex;

	/* 04 */ TargetEntry* next;
	/* 08 */ TargetEntry* prev;
};

struct TargetSelectionDefinition {
	/* 00 */ void(*onInit)(struct TargetSelectionProc*);
	/* 04 */ void(*onEnd)(struct TargetSelectionProc*);

	/* 08 */ void(*onInitTarget)(struct TargetSelectionProc*, struct TargetEntry*);

	/* 0C */ void(*onSwitchIn)(struct TargetSelectionProc*, struct TargetEntry*);
	/* 10 */ void(*onSwitchOut)(struct TargetSelectionProc*, struct TargetEntry*);

	/* 14 */ int(*onAPress)(struct TargetSelectionProc*, struct TargetEntry*);
	/* 18 */ int(*onBPress)(struct TargetSelectionProc*, struct TargetEntry*);
	/* 1C */ int(*onRPress)(struct TargetSelectionProc*, struct TargetEntry*);
};

struct TargetSelectionProc {
	PROC_HEADER;

	/* 2C */ const TargetSelectionDefinition* pDefinition;
	/* 30 */ TargetEntry* pCurrentEntry;
	
	/* 34 */ u8 stateBits;

	/* 38 */ int(*onAPressOverride)(TargetSelectionProc*, TargetEntry*);
};

enum _TargetSelectionEffect {
	TSE_NONE = 0x00,

	TSE_DISABLE = 0x01, // (for one frame, probably useful for blocking)
	TSE_END = 0x02,
	TSE_PLAY_BEEP = 0x04,
	TSE_PLAY_BOOP = 0x08,
	TSE_CLEAR_GFX = 0x10,
	TSE_END_FACE0 = 0x20
};

extern struct Vec2u gTargetPosition; //! FE8U = 0x0203DDE8
extern TargetEntry gTargetArray[]; //! FE8U = 0x0203DDEC
extern unsigned int gTargetArraySize; //! FE8U = 0x0203E0EC

void InitTargets(int x, int y); //! FE8U = 0x804F8A5
void AddTarget(int x, int y, u8 unit, u8 trap); //! FE8U = 0x804F8BD
void LinkTargets(void); //! FE8U = 0x804F911

void TargetSelection_GetRealCursorPosition(struct TargetSelectionProc*, int* xTarget, int* yTarget); //! FE8U = 0x804F959
void TargetSelection_Loop(struct TargetSelectionProc*); //! FE8U = 0x804F96D

struct TargetSelectionProc* StartTargetSelection(const struct TargetSelectionDefinition*); //! FE8U = 0x804FA3D
struct TargetSelectionProc* StartTargetSelectionExt(const struct TargetSelectionDefinition*, int(*)(struct TargetSelectionProc*, struct TargetEntry*)); //! FE8U = 0x804FAA5

struct Proc* EndTargetSelection(struct TargetSelectionProc*); //! FE8U = 0x804FAB9

// TargetSelection_HandleMoveInput //! FE8U = 0x804FAED
// TargetSelection_HandleSelectInput //! FE8U = 0x804FB65

unsigned GetFarthestTargetIndex(void); //! FE8U = 0x804FBFD
struct TargetEntry* LinkTargetsOrdered(void); //! FE8U = 0x804FC5D
struct TargetEntry* GetLinkedTargetList(void); //! FE8U = 0x804FD01
struct TargetEntry* GetFirstTargetPointer(void); //! FE8U = 0x804FD11
unsigned GetTargetListSize(void); //! FE8U = 0x804FD29
struct TargetEntry* GetTarget(unsigned index); //! FE8U = 0x804FD35

void ForEachUnitInRange(void(*)(struct Unit*)); //! FE8U = 0x8024EAD
void ForEachPosInRange(void(*)(int, int)); //! FE8U = 0x8024F19
void ForEachAdjacentUnit(int x, int y, void(*)(struct Unit*)); //! FE8U = 0x8024F71
void ForEachAdjacentPosition(int x, int y, void(*)(int, int)); //! FE8U = 0x8024FA5

int GenericSelection_BackToUM(TargetSelectionProc*, TargetEntry*); //! FE8U = 0x8022749
int GenericSelection_BackToUM_CamWait(TargetSelectionProc*, TargetEntry*); //! FE8U = 0x802282D

#endif // GBAFE_TARGETSELECT_H
