#ifndef GBAFE_UNIT_H
#define GBAFE_UNIT_H

// Rename to bmunit.h? Since it corresponds to bmunit.c from the proto
// Maybe corresponds to multiple files

#include <stdint.h>

#include "common.h"

typedef struct Unit Unit;
typedef struct BattleUnit BattleUnit;
typedef struct EventUnit EventUnit;

typedef struct CharacterData CharacterData;
typedef struct ClassData ClassData;

struct SMSHandle;

enum {
	// Config

	// Maximum unit level
	UNIT_LEVEL_MAX = 20,

	// Maximum unit item count
	UNIT_ITEM_COUNT = 5,

	// Maximum unit definition item count
	UNIT_DEFINITION_ITEM_COUNT = 4
};

// Meaningful constants
enum {
	UNIT_EXP_DISABLED = 0xFF
};

struct CharacterData {
	/* 00 */ u16 nameTextId;
	/* 02 */ u16 descTextId;
	/* 04 */ u8 number;
	/* 05 */ u8 defaultClass;
	/* 06 */ u16 portraitId;
	/* 08 */ u8 miniPortrait;
	/* 09 */ u8 affinity;
	/* 0A */ u8 unk0A;

	/* 0B */ s8 baseLevel;
	/* 0C */ s8 baseHP;
	/* 0D */ s8 basePow;
	/* 0E */ s8 baseSkl;
	/* 0F */ s8 baseSpd;
	/* 10 */ s8 baseDef;
	/* 11 */ s8 baseRes;
	/* 12 */ s8 baseLck;
	/* 13 */ s8 baseCon;

	/* 14 */ u8 baseRanks[8];

	/* 1C */ u8 growthHP;
	/* 1D */ u8 growthPow;
	/* 1E */ u8 growthSkl;
	/* 1F */ u8 growthSpd;
	/* 20 */ u8 growthDef;
	/* 21 */ u8 growthRes;
	/* 22 */ u8 growthLck;

	/* 23 */ u8 unk23;
	/* 24 */ u8 unk24;
	/* 25 */ u8 unk25;
	/* 26 */ u8 unk26;
	/* 27 */ u8 unk27;

	/* 28 */ u32 attributes;

	/* 2C */ void* pSupportData;
	/* 30 */ void* pUnk30;
};

struct ClassData {
	/* 00 */ u16 nameTextId;
	/* 02 */ u16 descTextId;
	/* 04 */ u8 number;
	/* 05 */ u8 promotion;
	/* 06 */ u8 SMSId;
	/* 07 */ u8 slowWalking;
	/* 08 */ u16 defaultPortraitId;
	/* 0A */ u8 unk0A;

	/* 0B */ s8 baseHP;
	/* 0C */ s8 basePow;
	/* 0D */ s8 baseSkl;
	/* 0E */ s8 baseSpd;
	/* 0F */ s8 baseDef;
	/* 10 */ s8 baseRes;
	/* 11 */ s8 baseCon;
	/* 12 */ s8 baseMov;

	/* 13 */ s8 maxHP;
	/* 14 */ s8 maxPow;
	/* 15 */ s8 maxSkl;
	/* 16 */ s8 maxSpd;
	/* 17 */ s8 maxDef;
	/* 18 */ s8 maxRes;
	/* 19 */ s8 maxCon;

	/* 1A */ s8 classRelativePower;

	/* 1B */ s8 growthHP;
	/* 1C */ s8 growthPow;
	/* 1D */ s8 growthSkl;
	/* 1E */ s8 growthSpd;
	/* 1F */ s8 growthDef;
	/* 20 */ s8 growthRes;
	/* 21 */ s8 growthLck;

	/* 22 */ u8 promotionHp;
	/* 23 */ u8 promotionPow;
	/* 24 */ u8 promotionSkl;
	/* 25 */ u8 promotionSpd;
	/* 26 */ u8 promotionDef;
	/* 27 */ u8 promotionRes;

	/* 28 */ u32 attributes;

	/* 2C */ u8 baseRanks[8];

	/* 34 */ const void* pBattleAnimDef;
	/* 38 */ const s8* pMovCostTable[3]; // standard, rain, snow

	/* 44 */ const s8* pTerrainAvoidLookup;
	/* 48 */ const s8* pTerrainDefenseLookup;
	/* 4C */ const s8* pTerrainResistanceLookup;

	/* 50 */ const void* pUnk50;
};

struct Unit {
	/* 00 */ const struct CharacterData* pCharacterData;
	/* 04 */ const struct ClassData* pClassData;

	/* 08 */ s8 level;
	/* 09 */ u8 exp;
	/* 0A */ u8 unk0A_saved;

	/* 0B */ s8 index;

	/* 0C */ u32 state;

	/* 10 */ s8 xPos;
	/* 11 */ s8 yPos;

	/* 12 */ s8 maxHP;
	/* 13 */ s8 curHP;
	/* 14 */ s8 pow;
	/* 15 */ s8 skl;
	/* 16 */ s8 spd;
	/* 17 */ s8 def;
	/* 18 */ s8 res;
	/* 19 */ s8 lck;

	/* 1A */ s8 conBonus;
	/* 1B */ u8 rescueOtherUnit;
	/* 1C */ u8 ballistaIndex;
	/* 1D */ s8 movBonus;

	/* 1E */ u16 items[UNIT_ITEM_COUNT];
	/* 28 */ u8 ranks[8];

	/* 30 */ u8 statusIndex : 4;
	/* 30 */ u8 statusDuration : 4;

	/* 31 */ u8 torchDuration : 4;
	/* 31 */ u8 barrierDuration : 4;

								// EDITS FOR SUPPORT REWORK
	/* 32 */ u16 supportLevels;
	/* 34 */ u8 supports[5]; // 38 is also character leader. Unioning to the last index of this array sounds oof, so eeeehhhhh.
	
	/* 39 */ u8 supportBits;
	/* 3A */ u8 unk3A;
	/* 3B */ u8 unk3B;

	/* 3C */ struct SMSHandle* pMapSpriteHandle;

	/* 40 */ u16 ai3And4;
	/* 42 */ u8 ai1;
	/* 43 */ u8 ai1data;
	/* 44 */ u8 ai2;
	/* 45 */ u8 ai2data;
	/* 46 */ u8 unk46_saved;
	/* 47 */ u8 unk47;
};

struct UnitDefinition {
	/* 00 */ u8  charIndex;
	/* 01 */ u8  classIndex;
	/* 02 */ u8  leaderCharIndex;

	/* 03 */ u8  autolevel  : 1;
	/* 03 */ u8  allegiance : 2;
	/* 03 */ u8  level	  : 5;

	/* 04 */ u16 xPosition  : 6; /* 04:0 to 04:5 */
	/* 04 */ u16 yPosition  : 6; /* 04:6 to 05:3 */
	/* 05 */ u16 genMonster : 1; /* 05:4 */
	/* 05 */ u16 itemDrop   : 1; /* 05:5 */
	/* 05 */ u16 sumFlag	: 1; /* 05:6 */
	/* 05 */ u16 extraData  : 9; /* 05:7 to 06:7 */
	/* 07 */ u16 redaCount  : 8;

	/* 08 */ const void* redas;

	/* 0C */ u8 items[UNIT_DEFINITION_ITEM_COUNT];

	struct {
		/* 10 */ u8 ai1;
		/* 11 */ u8 ai2;
		/* 12 */ u8 ai3;
		/* 13 */ u8 ai4;
	} ai;
};

enum {
	// Unit state constant masks

	US_NONE		 = 0,

	US_HIDDEN	   = (1 << 0),
	US_UNSELECTABLE = (1 << 1),
	US_DEAD		 = (1 << 2),
	US_NOT_DEPLOYED = (1 << 3),
	US_RESCUING	 = (1 << 4),
	US_RESCUED	  = (1 << 5),
	US_HAS_MOVED	= (1 << 6), // Bad name?
	US_CANTOING	 = US_HAS_MOVED, // Alias
	US_UNDER_A_ROOF = (1 << 7),
	US_BIT8 = (1 << 8),
	// = (1 << 9),
	US_HAS_MOVED_AI = (1 << 10),
	US_IN_BALLISTA  = (1 << 11),
	US_DROP_ITEM	= (1 << 12),
	US_GROWTH_BOOST = (1 << 13),
	US_SOLOANIM_1   = (1 << 14),
	US_SOLOANIM_2   = (1 << 15),
	US_BIT16		= (1 << 16),
	US_BIT17		= (1 << 17),
	US_BIT18		= (1 << 18),
	US_BIT19		= (1 << 19),
	US_BIT20		= (1 << 20),
	US_BIT21		= (1 << 21),
	US_BIT22		= (1 << 22),
	// = (1 << 23),
	// = (1 << 24),
	US_BIT25 = (1 << 25),
	US_BIT26 = (1 << 26),
	// = (1 << 27),
	// = (1 << 28),
	// = (1 << 29),
	// = (1 << 30),
	// = (1 << 31),

	// Helpers
	US_UNAVAILABLE = (US_DEAD | US_NOT_DEPLOYED | US_BIT16),
};

enum {
	// Unit status identifiers

	UNIT_STATUS_NONE = 0,

	UNIT_STATUS_POISON = 1,
	UNIT_STATUS_SLEEP = 2,
	UNIT_STATUS_SILENCED = 3,
	UNIT_STATUS_BERSERK = 4,

	UNIT_STATUS_ATTACK = 5,
	UNIT_STATUS_DEFENSE = 6,
	UNIT_STATUS_CRIT = 7,
	UNIT_STATUS_AVOID = 8,

	UNIT_STATUS_SICK = 9,
	UNIT_STATUS_RECOVER = 10,

	UNIT_STATUS_PETRIFY = 11,
	UNIT_STATUS_12 = 12,
	UNIT_STATUS_13 = 13,
};

enum {
	UA_BLUE = 0x00,
	UA_GREEN = 0x40,
	UA_RED = 0x80,

	FACTION_BLUE   = 0x00, // player units
	FACTION_GREEN  = 0x40, // ally npc units
	FACTION_RED	= 0x80, // enemy units
	FACTION_PURPLE = 0xC0, // link arena 4th team
};

enum {
	// Character/Class attributes

	CA_NONE = 0,

	CA_MOUNTEDAID = (1 << 0),
	CA_CANTO = (1 << 1),
	CA_STEAL = (1 << 2),
	CA_LOCKPICK = (1 << 3),
	CA_DANCE = (1 << 4),
	CA_PLAY = (1 << 5),
	CA_CRITBONUS = (1 << 6),
	CA_BALLISTAE = (1 << 7),
	CA_PROMOTED = (1 << 8),
	CA_SUPPLY = (1 << 9),
	CA_MOUNTED = (1 << 10),
	CA_WYVERN = (1 << 11),
	CA_PEGASUS = (1 << 12),
	CA_LORD = (1 << 13),
	CA_FEMALE = (1 << 14),
	CA_BOSS = (1 << 15),
	CA_LOCK_1 = (1 << 16),
	CA_LOCK_2 = (1 << 17),
	CA_LOCK_3 = (1 << 18), // Dragons or Monster depending of game
	CA_MAXLEVEL10 = (1 << 19),
	CA_UNSELECTABLE = (1 << 20),
	CA_TRIANGLEATTACK_PEGASI = (1 << 21),
	CA_TRIANGLEATTACK_ARMORS = (1 << 22),
	CA_BIT_23 = 0x00800000,
	CA_NEGATE_LETHALITY = 0x01000000,
	CA_LETHALITY = 0x02000000,
	CA_MAGICSEAL = 0x04000000,
	CA_SUMMON = 0x08000000,
	CA_LOCK_4 = 0x10000000,
	CA_LOCK_5 = 0x20000000,
	CA_LOCK_6 = 0x40000000,
	CA_LOCK_7 = 0x80000000,

	// Helpers
	CA_REFRESHER = CA_DANCE | CA_PLAY,
	CA_TRIANGLEATTACK_ANY = CA_TRIANGLEATTACK_ARMORS | CA_TRIANGLEATTACK_PEGASI,
};

#define UNIT_IS_VALID(aUnit) ((aUnit) && (aUnit)->pCharacterData)

#define UNIT_FACTION(aUnit) ((aUnit)->index & 0xC0)

#define UNIT_CATTRIBUTES(aUnit) ((aUnit)->pCharacterData->attributes | (aUnit)->pClassData->attributes)

#define UNIT_MHP_MAX(aUnit) (UNIT_FACTION(unit) == FACTION_RED ? 120 : 60)
#define UNIT_POW_MAX(aUnit) ((aUnit)->pClassData->maxPow)
#define UNIT_SKL_MAX(aUnit) ((aUnit)->pClassData->maxSkl)
#define UNIT_SPD_MAX(aUnit) ((aUnit)->pClassData->maxSpd)
#define UNIT_DEF_MAX(aUnit) ((aUnit)->pClassData->maxDef)
#define UNIT_RES_MAX(aUnit) ((aUnit)->pClassData->maxRes)
#define UNIT_LCK_MAX(aUnit) (30)
#define UNIT_CON_MAX(aUnit) ((aUnit)->pClassData->maxCon)
#define UNIT_MOV_MAX(aUnit) (15)

#define UNIT_CON_BASE(aUnit) ((aUnit)->pClassData->baseCon + (aUnit)->pCharacterData->baseCon)
#define UNIT_MOV_BASE(aUnit) ((aUnit)->pClassData->baseMov)

#define UNIT_CON(aUnit) (UNIT_CON_BASE(aUnit) + (aUnit)->conBonus)
#define UNIT_MOV(aUnit) ((aUnit)->movBonus + UNIT_MOV_BASE(aUnit))

#define UNIT_IS_GORGON_EGG(aUnit) (((aUnit)->pClassData->number == CLASS_GORGONEGG) || ((aUnit)->pClassData->number == CLASS_GORGONEGG2))
#define UNIT_IS_PHANTOM(aUnit) ((aUnit)->pClassData->number == CLASS_PHANTOM)

#define UNIT_ARENA_LEVEL(aUnit) (((aUnit)->state >> 17) & 0x7)

// Compat with old FE-CLib
#define UNIT_ATTRIBUTES(aUnit) UNIT_CATTRIBUTES(aUnit)

extern const struct CharacterData gCharacterData[];
extern const struct ClassData gClassData[];

extern struct Unit gUnitArrayBlue[]; //! FE8U = 0x202BE4C
extern struct Unit* gActiveUnit; //! FE8U = 0x3004E50
extern struct Unit* const gUnitLookup[]; //! FE8U = 0x859A5D0

extern u8 gActiveUnitId; //! FE8U = 0x202BE44
extern struct Vec2 gActiveUnitMoveOrigin; //! FE8U = 0x202BE48

void ClearUnits(void); //! FE8U = 0x80177C5
void ClearUnit(struct Unit*); //! FE8U = 0x80177F5
void CopyUnit(const struct Unit*, struct Unit*); //! FE8U = 0x801781D
struct Unit* GetFreeUnit(int faction); //! FE8U = 0x8017839
struct Unit* GetFreeBlueUnit(); //! FE8U = 0x8017871

int GetUnitFogViewRange(const struct Unit*); //! FE8U = 0x80178A9

void SetUnitStatus(struct Unit*, int status); //! FE8U = 0x80178D9
void SetUnitStatusExt(struct Unit*, int status, int duration); //! FE8U = 0x80178F5

int GetUnitSMSId(const struct Unit*); //! FE8U = 0x8017905

int UnitAddItem(struct Unit*, u16); //! FE8U = 0x8017949
void ClearUnitInventory(struct Unit*); //! FE8U = 0x801796D
void UnitRemoveInvalidItems(struct Unit*); //! FE8U = 0x8017985
int GetUnitItemCount(const struct Unit*); //! FE8U = 0x80179D9
int UnitHasItem(const struct Unit*, u16); //! FE8U = 0x80179F9

int LoadUnits(const struct UnitDefinition[]); //! FE8U = 0x8017A35
int CanClassWieldWeaponType(u8); //! FE8U = 0x8017A8D
struct Unit* LoadUnit(const struct UnitDefinition*); //! FE8U = 0x8017AC5
void UnitInitFromDefinition(struct Unit*, const struct UnitDefinition*); //! FE8U = 0x8017D3D
void UnitLoadItemsFromDefinition(struct Unit*, const struct UnitDefinition*); //! FE8U = 0x8017DF9
void UnitLoadStatsFromChracter(struct Unit*, const struct CharacterData*); //! FE8U = 0x8017E35
void FixROMUnitStructPtr(struct Unit*); //! FE8U = 0x8017EBD
void UnitLoadSupports(struct Unit*); //! FE8U = 0x8017EF5
void UnitAutolevelWExp(struct Unit*); //! FE8U = 0x8017F21
void UnitAutolevelCore(struct Unit*, int, int); //! FE8U = 0x8017FC5
void UnitAutolevelPenalty(struct Unit*, int, int); //! FE8U = 0x8018065
void UnitApplyBonusLevels(struct Unit*, int); //! FE8U = 0x80180CD
void UnitAutolevel(struct Unit*); //! FE8U = 0x8018121
void UnitAutolevelRealistic(struct Unit*); //! FE8U = 0x8018161
void UnitCheckStatCaps(struct Unit*); //! FE8U = 0x80181C9

struct Unit* GetUnitByCharId(u8 charId); //! FE8U = 0x801829D
struct Unit* GetUnitFromCharIdAndFaction(u8 charId, int faction); //! FE8U = 0x80182D9

int CanUnitRescue(const struct Unit*, const struct Unit*); //! FE8U = 0x801831D
void UnitRescue(struct Unit*, struct Unit*); //! FE8U = 0x801834D
void UnitDrop(struct Unit*, int x, int y); //! FE8U = 0x8018371
void UnitGive(struct Unit*, struct Unit*); //! FE8U = 0x80183C9
void UnitChangeFaction(struct Unit* unit, int faction); //! FE8U = 0x8018431
void UnitFinalizeMovement(struct Unit*); //! FE8U = 0x801849D

void UnitBeginAction(struct Unit*); //! FE8U = 0x801865D
void UnitBeginCantoAction(struct Unit*); //! FE8U = 0x80186D5
void MoveActiveUnit(int x, int y); //! FE8U = 0x8018741

void SetAllUnitNotBackSprite(void); //! FE8U = 0x801895D

void UnitUpdateUsedItem(struct Unit*, int slot); //! FE8U = 0x8018995

int GetUnitAid(const struct Unit*); //! FE8U = 0x80189B9
int GetUnitMagBy2Range(const struct Unit*); //! FE8U = 0x8018A1D
int UnitHasMagicRank(const struct Unit*); //! FE8U = 0x8018A59
int GetUnitWeaponUsabilityBits(const struct Unit*); //! FE8U = 0x8018B29

int CanUnitMove(void); //! FE8U = 0x8018BD9

int IsPositionMagicSealed(int x, int y); //! FE8U = 0x8018C99
int IsUnitMagicSealed(const struct Unit*); //! FE8U = 0x8018D09

u16 GetUnitLastItem(const struct Unit*); //! FE8U = 0x8018D35

const u8* GetUnitMovementCost(const struct Unit*); //! FE8U = 0x8018D4D

u8 GetClassSMSId(u8); //! FE8U = 0x8018D91

void UpdatePrevDeployStates(void); //! FE8U = 0x8018DB1
void LoadUnitPrepScreenPositions(void); //! FE8U = 0x8018E31
int IsUnitSlotAvailable(int faction); //! FE8U = 0x8018F49
void ClearCutsceneUnits(void); //! FE8U = 0x80190B5

int GetUnitCurrentHp(const struct Unit*); //! FE8U = 0x8019151
int GetUnitMaxHp(const struct Unit*); //! FE8U = 0x8019191
int GetUnitPower(const struct Unit*); //! FE8U = 0x80191B1
int GetUnitSkill(const struct Unit*); //! FE8U = 0x80191D1
int GetUnitSpeed(const struct Unit*); //! FE8U = 0x8019211
int GetUnitDefense(const struct Unit*); //! FE8U = 0x8019251
int GetUnitResistance(const struct Unit*); //! FE8U = 0x8019271
int GetUnitLuck(const struct Unit*); //! FE8U = 0x8019299
int GetUnitPortraitId(const struct Unit*); //! FE8U = 0x80192B9
int GetUnitMiniPortraitId(const struct Unit*); //! FE8U = 0x80192F5
u8 GetUnitLeaderCharId(const struct Unit*); //! FE8U = 0x8019341

void SetUnitHp(struct Unit*, int); //! FE8U = 0x8019369
void AddUnitHp(struct Unit*, int); //! FE8U = 0x80193A5

char* GetUnitRescueName(const struct Unit*); //! FE8U = 0x80193E9
char* GetUnitStatusName(const struct Unit*); //! FE8U = 0x8019415

struct Unit* GetUnit(u8 index); //! FE8U = 0x8019431

const struct ClassData* GetClassData(u8); //! FE8U = 0x8019445
const struct CharacterData* GetCharacterData(u8); //! FE8U = 0x8019465

void UnitRemoveItem(struct Unit*, int slot); //! FE8U = 0x8019485

int CanUnitCrossTerrain(const struct Unit*, u8 terrain); //! FE8U = 0x801949D

#endif // GBAFE_UNIT_H
