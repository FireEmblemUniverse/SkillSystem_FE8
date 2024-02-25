#include "gbafe.h" // headers 

#define PUREFUNC __attribute__((pure))
#define ARMFUNC __attribute__((target("arm")))
int Div(int a, int b) PUREFUNC;
int Mod(int a, int b) PUREFUNC;
int DivArm(int b, int a) PUREFUNC;

extern int SkillTester(struct Unit* unit, int SkillID); 
extern int RandomizeWeaponStatsFlag_Link; 
extern int RandomizeClassesFlag_Link;

// if both on, randomize all 0xA0+ 
//if only bosses, 0xA0+ in "boss chapters" 
//if only trainers, 0xA0+ in non-boss chapters 
extern int RandomizeTrainerClassesFlag_Link;
extern int RandomizeBossClassesFlag_Link;
extern int RandomizeGrowthsFlag_Link;
extern int RandomizeFoundItemsFlag_Link;
extern int RandomizeBaseStatsFlag_Link;

static char* const TacticianName = (char* const) (0x202bd10); //8 bytes long
extern u32* StartTimeSeedRamLabel; 

//extern int Div(int, int); 
//extern int Mod(int, int); 
u8 HashByte_N(u8 number, int max){
  if (max==0) return 0;
  u32 hash = 5381;
  hash = ((hash << 5) + hash) ^ number;
  hash = ((hash << 5) + hash) ^ gPlaySt.chapterIndex;
  hash = ((hash << 5) + hash) ^ *StartTimeSeedRamLabel;
  for (int i = 0; i < 9; ++i){
    if (TacticianName[i]==0) break;
    hash = ((hash << 5) + hash) ^ TacticianName[i];
  };
  return Mod((u16)hash, max);
};

u8 HashByte_Global(u8 number, int max, int variance){
  if (max==0) return 0;
  u32 hash = 5381;
  hash = ((hash << 5) + hash) ^ number;
  hash = ((hash << 5) + hash) ^ *StartTimeSeedRamLabel;
  hash = ((hash << 5) + hash) ^ variance; 
  for (int i = 0; i < 9; ++i){
    if (TacticianName[i]==0) break;
    hash = ((hash << 5) + hash) ^ TacticianName[i];
  };
  hash = Mod((u16)hash, max); 
  return hash;
};

u16 HashShort_Simple(u8 number, int max, int variance){
  if (max==0) return 0;
  u32 hash = 5381;
  hash = ((hash << 5) + hash) ^ number;
  hash = ((hash << 5) + hash) ^ *StartTimeSeedRamLabel;
  hash = ((hash << 5) + hash) ^ variance; 
  for (int i = 0; i < 9; ++i){
    if (TacticianName[i]==0) break;
    hash = ((hash << 5) + hash) ^ TacticianName[i];
  };
  hash = Mod((u16)hash, max); 
  return hash;
};


int GetItemMight(int item) {
	item &= 0xFF; 
	int might = GetItemData(item)->might;
	if (!CheckFlag(RandomizeWeaponStatsFlag_Link)) return might; 
	int max = ((might*3)/2)+5;
	int newMight = HashByte_Global(might, max, item);
	if (abs(newMight - might) < 3) { // encourage it to be at least 3 or more points different than normal 
	newMight =  HashByte_Global(newMight, max, newMight); } 
	return newMight; 
	
}

int GetItemHit(int item) {
	item &= 0xFF; 
	int hit = GetItemData(item)->hit;
	if (!CheckFlag(RandomizeWeaponStatsFlag_Link)) return GetItemData(item)->hit;
	int newHit = (HashByte_Global(hit, (hit+50)/5, item) * 5) + 20; 
	if (newHit > 250) newHit = 250; 
	return newHit; 
}


int GetItemCrit(int item) {
	item &= 0xFF; 
	int crit = GetItemData(item)->crit;
	if (!CheckFlag(RandomizeWeaponStatsFlag_Link)) return GetItemData(item)->crit;
	int newCrit = HashByte_Global(crit, ((crit*2)+40)/5, item) * 5; 
	if (newCrit > 250) newCrit = 250; 
	return newCrit; 
}

extern u8 BossChapterTable2[]; 
int ShouldUnitBeRandomized(struct Unit* unit) { 
	int unitID = unit->pCharacterData->number; 
	if ((CheckFlag(RandomizeClassesFlag_Link)) && (unitID < 0xA0)) return true; 
	int randomizeBosses = CheckFlag(RandomizeBossClassesFlag_Link); 
	int randomizeTrainers = CheckFlag(RandomizeTrainerClassesFlag_Link); 
	
	if ((randomizeBosses) && (randomizeTrainers) && (unitID >= 0xA0)) return true; 
	int isBoss = unit->pCharacterData->attributes & CA_BOSS; // class doesn't exist yet 
	if ((randomizeBosses) && (isBoss)) return true; 
	
	if (!randomizeTrainers) { 
		if ((unitID >= 0xA0) && (randomizeBosses) && (BossChapterTable2[gPlaySt.chapterIndex])) return true; 
		return false; 
	} 
	
	if (!randomizeBosses) { // if not boss chapter, return true 
		if ((unitID >= 0xA0) && (randomizeTrainers) && (!BossChapterTable2[gPlaySt.chapterIndex])) return true; 
		return false; 
	}
	return false; // default 


} 

//int GetRandomizedBaseStat(

// mov r2, r6 @ index in stat booster pointer of growth
int GetRandomizedGrowth(struct Unit* unit, int growth, int id) { 
	if (!CheckFlag(RandomizeGrowthsFlag_Link)) { return growth; } 
	int newGrowth = HashByte_Global(growth, growth*2, unit->pClassData->number+id);
	//return (newGrowth / 5) * 5; 
	return newGrowth; 
} 

int RandStat(int stat, int variance) { 
	int adj = (stat * 2) + 5; 
	int max = adj < 63 ? adj : 63 ; 
	return HashByte_Global(stat, max, variance); 
} 

void RandomizeStats(struct Unit* unit) { 
	if (!CheckFlag(RandomizeBaseStatsFlag_Link)) { return; } 
	int classID = unit->pClassData->number; 
	unit->maxHP = RandStat(unit->maxHP, classID); 
	if (unit->maxHP < 4) { unit->maxHP = 4; } 
	unit->pow = RandStat(unit->pow, classID); 
	unit->skl = RandStat(unit->skl, classID); 
	unit->spd = RandStat(unit->spd, classID); 
	unit->def = RandStat(unit->def, classID); 
	unit->res = RandStat(unit->res, classID); 
	unit->lck = RandStat(unit->lck, classID); 
	unit->_u3A = RandStat(unit->_u3A, classID); // mag 
} 

