#ifndef GBAFE_ANIMINTERPRETER_H
#define GBAFE_ANIMINTERPRETER_H

#include "common.h"

typedef struct AnimationInterpreter AnimationInterpreter;
typedef struct AnimationInterpreter AIStruct;

struct AnimationInterpreter {
	/* 00 */ u16 state;
	/* 02 */ s16 xPosition;
	/* 04 */ s16 yPosition;
	/* 06 */ u16 delayTimer;
	/* 08 */ u16 oam2base;
	/* 0A */ u16 drawLayerPriority;
	/* 0C */ u16 state2;
	/* 0E */ u16 nextRoundId;
	/* 10 */ u16 state3;
	/* 12 */ u8 currentRoundType;
	/* 13 */ u8 frameIndex;

	/* 14 */ u8 queuedCommandCount;
	/* 15 */ u8 commandQueue[0xB];

	/* 20 */ const void* pCurrentFrame;
	/* 24 */ const void* pStartFrame;
	/* 28 */ const void* pUnk28;
	/* 2C */ const void* pUnk2C;
	/* 30 */ const void* pStartObjData; // aka "OAM data"

	/* 34 */ struct AnimationInterpreter* pPrev;
	/* 38 */ struct AnimationInterpreter* pNext;

	/* 40 */ const void* pUnk40;
	/* 44 */ const void* pUnk44;
};

extern u8 gBattleCharacterIndices[2]; //! FE8U = 0x203E190

void UpdateAISs(void); //! FE8U = 0x8004E41
void ClearAISs(void); //! FE8U = 0x8004EB9
struct AnimationInterpreter* CreateAIS(const u32* animScript, int depth); //! FE8U = 0x8004F49
void SortAISs(void); //! FE8U = 0x8004FAD
void DeleteAIS(struct AnimationInterpreter* ais); //! FE8U = 0x8005005
void DisplayAIS(struct AnimationInterpreter* ais); //! FE8U = 0x8005035

int GetAISSubjectId(const struct AnimationInterpreter*); //! FE8U = 0x805A16D
int IsBatteRoundTypeAMiss(u16); //! FE8U = 0x805A185
int GetBattleAnimRoundType(int index); //! FE8U = 0x8058A0D

void StartEkrNamewinAppear(int, int, int);

#endif // GBAFE_ANIMINTERPRETER_H
