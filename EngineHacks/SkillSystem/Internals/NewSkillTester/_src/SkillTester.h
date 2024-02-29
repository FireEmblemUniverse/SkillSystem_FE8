#include "gbafe.h"

typedef struct SkillBuffer SkillBuffer;
typedef struct AuraSkillBuffer AuraSkillBuffer;
typedef struct SkillTestConfig SkillTestConfig;
typedef struct BWLData BWLData;


//extern s8 AreAllegiancesEqual(int factionA, int factionB);
//extern s8 AreAllegiancesAllied(int factionA, int factionB);
//extern int AreUnitsAllied(int, int) __attribute__((long_call));
//extern int IsSameAllegience(int, int) __attribute__((long_call)); // forgive the typo
//extern BWLData* BWL_GetEntry(int charID);
//Using a function pointer GetInitialSkillList doesn't have the thumb bit set
extern u8* (*GetInitialSkillList_Pointer) (struct Unit* unit, u8* skillBuffer);

struct SkillBuffer {
/*00*/  u8 lastUnitChecked;
/*01*/  u8 skills[11];
};

struct BWLData {
/*00*/  u8 unk1;
/*01*/  u8 skills[4];
/*05*/  u8 pad[11]; //Stuff not relevant for skills
};

struct AuraSkillBuffer {
/*00*/  u8 skillID;
/*01*/  u8 distance : 6; //Relative to main unit
/*01*/  u8 faction  : 2;
};

struct SkillTestConfig {
/*00*/  u16 auraSkillBufferLimit;
/*02*/  u8 genericLearnedSkillLimit;
/*03*/  u8 passiveSkillStack;
/*04*/  u8 roofUnitAuras;
};

//extern struct BWLData gBWLDataArray[];

struct ItemDataExt {
    /* 00 */ u16 nameTextId;
    /* 02 */ u16 descTextId;
    /* 04 */ u16 useDescTextId;

    /* 06 */ u8  number;
    /* 07 */ u8  weaponType;

    /* 08 */ u32 attributes;

    /* 0C */ const struct ItemStatBonuses* pStatBonuses;
    /* 10 */ const u8* pEffectiveness;

    /* 14 */ u8  maxUses;

    /* 15 */ u8  might;
    /* 16 */ u8  hit;
    /* 17 */ u8  weight;
    /* 18 */ u8  crit;

    /* 19 */ u8 encodedRange;

    /* 1A */ u16 costPerUse;
    /* 1C */ u8  weaponRank;
    /* 1D */ u8  iconId;
    /* 1E */ u8  useEffectId;
    /* 1F */ u8  weaponEffectId;
    /* 20 */ u8  weaponExp;
	/* 21 */ u8  debuffType;
	/* 22 */ u8  IERdata;
	/* 23 */ u8  skill;
};

typedef struct ItemDataExt ItemDataExt;

//RAM buffers
extern SkillBuffer gAttackerSkillBuffer;
extern SkillBuffer gDefenderSkillBuffer;
extern AuraSkillBuffer gAuraSkillBuffer[];
extern u8 gTempSkillBuffer[];
extern u8 gUnitRangeBuffer[];

//Tables in ROM defined by buildfile
extern u8 AuraSkillTable[];
extern u8 NegatedSkills[];
extern u8 PersonalSkillTable[];
extern u8 ClassSkillTable[];

extern u8 NihilIDLink;
extern u32 PassiveSkillBit;

extern SkillTestConfig gSkillTestConfig;
