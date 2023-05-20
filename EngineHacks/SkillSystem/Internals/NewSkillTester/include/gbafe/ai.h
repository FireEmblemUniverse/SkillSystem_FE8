#ifndef GBAFE_AI_H
#define GBAFE_AI_H

#include "common.h"

typedef struct AiDecision AiDecision;
typedef struct AiData     AiData;

typedef void(*CpOrderFunc)(struct Proc*);
typedef void(*AiDecitionMakerFunc)(void);

struct AiDecision {
	/* 00 */ u8 decisionType;

	/* 01 */ u8 unitIndex;

	/* 02 */ u8 xMovement;
	/* 03 */ u8 yMovement;

	/* 04 */ u8 _pad04[0x06 - 0x04];

	/* 06 */ u8 unitTargetIndex;
	/* 07 */ u8 usedItemSlot;

	/* 08 */ u8 xOther;
	/* 09 */ u8 yOther;

	/* 0A */ u8 decisionTaken;
};

struct AiData {
	/* 00 */ u8 aiUnits[0x74];

	/* 74 */ u8* aiUnitIt;

	/* 78 */ u8 cpOrderNext;
	/* 79 */ u8 cpDecideNext;

	/* 7A */ u8 dangerMapActive;

	/* 7B */ u8 aiConfig;

	/* 7C */ u8 _pad7C[0x85 - 0x7C];

	/* 85 */ u8 highestBlueMov;

	/* 86 */ u8 _pad86[0x90 - 0x86];

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
void AiSetDecision(int xPos, int yPos, int actionId, int targetId, int itemSlot, int xPos2, int yPos2);

#endif // GBAFE_AI_H
