#ifndef GBAFE_SUPPORT_H
#define GBAFE_SUPPORT_H

enum
{
	SUPPORT_LEVEL_NONE,
	SUPPORT_LEVEL_C,
	SUPPORT_LEVEL_B,
	SUPPORT_LEVEL_A,
};

enum
{
	SUPPORT_EXP_C = 81,
	SUPPORT_EXP_B = 161,
	SUPPORT_EXP_A = 241,
};

struct SupportData
{
	/* 00 */ u8 characters[7];
	/* 07 */ u8 supportExpBase[7];
	/* 0E */ u8 supportExpGrowth[7];
	/* 15 */ u8 supportCount;
};

struct SupportBonuses
{
	/* 00 */ u8 affinity;

	/* 01 */ u8 bonusAttack;
	/* 02 */ u8 bonusDefense;
	/* 03 */ u8 bonusHit;
	/* 04 */ u8 bonusAvoid;
	/* 05 */ u8 bonusCrit;
	/* 06 */ u8 bonusDodge;
};

int GetROMUnitSupportCount(struct Unit* unit);
u8 GetROMUnitSupportingId(struct Unit* unit, int num);
struct Unit* GetUnitSupportingUnit(struct Unit* unit, int num);
int GetUnitSupportLevel(struct Unit* unit, int num);
int GetUnitTotalSupportLevel(struct Unit* unit);
void UnitGainSupportExp(struct Unit* unit, int num);
void UnitGainSupportLevel(struct Unit* unit, int num);
s8 CanUnitSupportNow(struct Unit* unit, int num);
int GetUnitStartingSupportValue(struct Unit* unit, int num);
int GetSupportDataIdForOtherUnit(struct Unit* unit, u8 charId);
void ClearUnitSupports(struct Unit* unit);
void ProcessTurnSupportExp(void);
int GetUnitSupportBonuses(struct Unit* unit, struct SupportBonuses* bonuses);
int GetUnitAffinityIcon(struct Unit* unit);
int GetCharacterAffinityIcon(int characterId);
int GetSupportLevelUiChar(int level);
char* GetAffinityName(int affinity); // unused?
s8 HaveCharactersMaxSupport(u8 charA, u8 charB);
void SwapUnitStats(struct Unit* unitA, struct Unit* unitB);

#endif // GBAFE_SUPPORT_H
