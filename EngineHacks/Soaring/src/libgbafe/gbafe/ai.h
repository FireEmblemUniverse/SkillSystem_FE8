#ifndef GBAFE_AI_H
#define GBAFE_AI_H

#include "common.h"

typedef struct AiDecision AiDecision;
typedef struct AiData     AiData;

typedef void(*CpOrderFunc)(struct Proc*);
typedef int(*CpPerformFunc)(struct Proc*);
typedef void(*AiDecitionMakerFunc)(void);
typedef int(*AiUnitPredicate)(struct Unit*);

struct AiDecision
{
	/* 00 */ u8 decisionType;

	/* 01 */ u8 unitIndex;

	/* 02 */ u8 xMovement;
	/* 03 */ u8 yMovement;

	/* 04 */ u8 _pad04[0x06 - 0x04];

	/* 06 */ u8 unitTargetIndex;

	/* 07 */ u8 paramA;
	/* 08 */ u8 paramB;
	/* 09 */ u8 paramC;

	/* 0A */ u8 decisionTaken;
};

struct AiData
{
	/* 00 */ u8 aiUnits[0x74];

	/* 74 */ u8* aiUnitIt;

	/* 78 */ u8 cpOrderNext;
	/* 79 */ u8 cpDecideNext;

	/* 7A */ u8 dangerMapActive;

	/* 7B */ u8 aiConfig;

	/* 7C */ u8 unk7C;
	/* 7D */ u8 battleDecisionWeightTableId;
	/* 7E */ u8 unk7E;
	/* 7F */ u8 unk7F;
	/* 80 */ u32 specialItemsConfig;
	/* 84 */ u8 unk84;
	/* 85 */ u8 highestBlueMov;
	/* 86 */ u8 scrResult;

	/* 87 */ u8 unk87[0x90 - 0x87];

	/* 90 */ struct AiDecision decision;
};

enum {
	AI_DECISION_NONE   = 0,
	AI_DECISION_COMBAT = 1,
	// 2?
	AI_DECISION_STEAL  = 3,
	AI_DECISION_LOOT   = 4,
	AI_DECISION_STAFF  = 5,
	AI_DECISION_CHEST  = 6,
	AI_DECISION_DANCE  = 7,
	AI_DECISION_TALK   = 8,
};

extern struct AiData gAiData;

extern AiDecitionMakerFunc gpAiDecisionMaker;

extern const struct ProcInstruction gProc_CpOrder[];
extern const struct ProcInstruction gProc_CpDecide[];

// TODO: address comments for reference

int MakeAiUnitQueue(void);
void SortAiUnitQueue(int size);
void ClearAiDecision(void);

void AiDecisionMaker_HealEscape(void);
void AiDecisionMaker_AiScript1(void);
void AiDecisionMaker_AiScript2(void);
void AiDecisionMaker_SpecialItems(void);

void AiFillMovementMapForUnit(struct Unit*);
int GetAiSafestAccessibleAdjacentPosition(int x, int y, struct Vec2* out);
void AiSetDecision(int xPos, int yPos, int actionId, int targetId, int a, int b, int c);
void AiUpdateDecision(int actionId, int targetId, int a, int b, int c);
s8 AreAllegiancesAllied(int factionA, int factionB);

s8 AiGetClosestUnitPosition(AiUnitPredicate pred, struct Vec2* result); //!< FE8U:0803A925
void AiTryMoveTowards(int x, int y, int decisionId, int safetyThreshold, int ignoreEnemies); //!< FE8U:0803BA09

#endif // GBAFE_AI_H
