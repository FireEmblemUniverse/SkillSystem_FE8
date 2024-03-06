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
extern int RandomizeSkillsFlag_Link; 

extern char* TacticianName; //8 bytes long

#define POKEMBLEM_VERSION 
#ifdef POKEMBLEM_VERSION 
extern u32* StartTimeSeedRamLabel; 
#endif 
#include "NumberEntry.c" 

//extern int Div(int, int); 
//extern int Mod(int, int); 
u8 HashByte_Ch(int number, int max){
  if (max==0) return 0;
  u32 hash = 5381;
  hash = ((hash << 5) + hash) ^ number;
  hash = ((hash << 5) + hash) ^ gPlaySt.chapterIndex;
  hash = ((hash << 5) + hash) ^ *StartTimeSeedRamLabel;
  //for (int i = 0; i < 9; ++i){
  //  if (TacticianName[i]==0) break;
  //  hash = ((hash << 5) + hash) ^ TacticianName[i];
  //};
  return Mod((hash & 0x2FFFFFFF), max);
};

u16 HashShort_Ch(int number, int max){
  if (max==0) return 0;
  u32 hash = 5381;
  hash = ((hash << 5) + hash) ^ number;
  hash = ((hash << 5) + hash) ^ gPlaySt.chapterIndex;
  hash = ((hash << 5) + hash) ^ *StartTimeSeedRamLabel;
  //for (int i = 0; i < 9; ++i){
  //  if (TacticianName[i]==0) break;
  //  hash = ((hash << 5) + hash) ^ TacticianName[i];
  //};
  return Mod((hash & 0x2FFFFFFF), max);
};

u32 HashSeed(u32 number) { 
  u32 hash = 5381;
  hash = ((hash << 5) + hash) ^ number;
  //for (int i = 0; i < 9; ++i){
  //  if (TacticianName[i]==0) break;
  //  hash = ((hash << 5) + hash) ^ TacticianName[i];
  //};
  return hash;
}

u8 HashByte_Global(int number, int max, int variance){
  if (max==0) return 0;
  u32 hash = 5381;
  hash = ((hash << 5) + hash) ^ number;
  hash = ((hash << 5) + hash) ^ *StartTimeSeedRamLabel;
  hash = ((hash << 5) + hash) ^ variance; 
  //for (int i = 0; i < 9; ++i){
  //  if (TacticianName[i]==0) break;
  //  hash = ((hash << 5) + hash) ^ TacticianName[i];
  //};
  hash = Mod((hash & 0x2FFFFFFF), max);
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
	int uid = unit->pCharacterData->number;
	int newGrowth = growth; 
	if ((uid >= 0x50) && (uid<0x87)) { newGrowth += 10; } // so wilds match players 
	if ((uid > 0x8C) && (uid<0xA0)) { newGrowth += 10; } 
	
	newGrowth = HashByte_Global(newGrowth, newGrowth*2, unit->pClassData->number+id);
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
	if (unit->maxHP < 10) { unit->maxHP = 10; } 
	unit->pow = RandStat(unit->pow, classID); 
	unit->skl = RandStat(unit->skl, classID); 
	unit->spd = RandStat(unit->spd, classID); 
	unit->def = RandStat(unit->def, classID); 
	unit->res = RandStat(unit->res, classID); 
	unit->lck = RandStat(unit->lck, classID); 
	unit->_u3A = RandStat(unit->_u3A, classID); // mag 
} 


int RandomizeStatCap(int statCap, struct Unit* unit, int variance) { 
	int min = (statCap / 5); 
	int max = 60 - min; //((statCap+10)* 5) / 4; 
	int classID = unit->pClassData->number + variance; 
	max = HashByte_Global(statCap, max, classID) + min;
	if (max > 60) { max = 60; } // probably unnecessary 
	return max; 

} 

int GetMaxStr(struct Unit* unit) { 
	int rand = CheckFlag(RandomizeBaseStatsFlag_Link);
	int num = UNIT_POW_MAX(unit); 
	if (!rand) { return num; } 
	return RandomizeStatCap(num, unit, 0); // extra variance variable so stats with same max will differ 
} 
int GetMaxSkl(struct Unit* unit) { 
	int rand = CheckFlag(RandomizeBaseStatsFlag_Link);
	int num = UNIT_SKL_MAX(unit); 
	if (!rand) { return num; } 
	return RandomizeStatCap(num, unit, 1); 
} 
int GetMaxSpd(struct Unit* unit) { 
	int rand = CheckFlag(RandomizeBaseStatsFlag_Link);
	int num = UNIT_SPD_MAX(unit); 
	if (!rand) { return num; } 
	return RandomizeStatCap(num, unit, 2); 
} 
int GetMaxDef(struct Unit* unit) { 
	int rand = CheckFlag(RandomizeBaseStatsFlag_Link);
	int num = UNIT_DEF_MAX(unit); 
	if (!rand) { return num; } 
	return RandomizeStatCap(num, unit, 3); 
} 
int GetMaxRes(struct Unit* unit) { 
	int rand = CheckFlag(RandomizeBaseStatsFlag_Link);
	int num = UNIT_RES_MAX(unit); 
	if (!rand) { return num; } 
	return RandomizeStatCap(num, unit, 4); 
} 

int GetMaxMag(int magCap, struct Unit* unit) { // takes original cap as input lol 
	int rand = CheckFlag(RandomizeBaseStatsFlag_Link);
	if (!rand) { return magCap; } 
	return RandomizeStatCap(magCap, unit, 5); 
} 

int RandomizeStatCaps(int magCap, struct BattleUnit* bu, struct Unit* unit) { 
	
	int max = GetMaxStr(unit);
    if ((unit->pow + bu->changePow) > max ) { 
	bu->changePow = max - unit->pow; } 

	max = GetMaxSkl(unit);
    if ((unit->skl + bu->changeSkl) > max) { 
	bu->changeSkl = max - unit->skl; }

	max = GetMaxSpd(unit);
    if ((unit->spd + bu->changeSpd) > max) { 
	bu->changeSpd = max - unit->spd; }

	max = GetMaxDef(unit);
    if ((unit->def + bu->changeDef) > max) { 
	bu->changeDef = max - unit->def; } 

	max = GetMaxRes(unit);
    if ((unit->res + bu->changeRes) > max) { 
	bu->changeRes = max - unit->res; } 
	
	return GetMaxMag(magCap, unit); 

} 

int UnitRandomizeStatCaps(int magCap, struct Unit* unit) { 
	
	int max = GetMaxStr(unit);
    if (unit->pow > max ) { 
	unit->pow = max; } 

	max = GetMaxSkl(unit);
    if (unit->skl > max) { 
	unit->skl = max; }

	max = GetMaxSpd(unit);
    if (unit->spd > max) { 
	unit->spd = max; }

	max = GetMaxDef(unit);
    if (unit->def > max) { 
	unit->def = max; } 

	max = GetMaxRes(unit);
    if (unit->res > max) { 
	unit->res = max; } 
	
	return GetMaxMag(magCap, unit); 

} 


int RandomizeLuckCap(int lukcap) {
	
	
	return lukcap; 
}


extern u16* RandomItemsTable[]; 
int CountItems(int tier) {
	int i = 0; 
	while (RandomItemsTable[tier][i]) { 
		i++; 
	} 
	return i; 
}

int GetItemTier(int item) { 
	for (int tier = 0; tier < 4; tier++) { 
		int i = 0; 
		while (RandomItemsTable[tier][i]) { 
			if (item == RandomItemsTable[tier][i]) { return tier; } 
			i++; 
		} 
	} 
	return 0; // if we can't find it, treat it as tier 0 
} 
int RandomizeItem(int item) { 
	if (!item) { return item; } 
	int tier = GetItemTier(item); 
	int max = CountItems(tier); 
	return RandomItemsTable[tier][HashShort_Ch(item, max)]; 
} 

void RandomizeItem_ASMC(void) { 
	if (!CheckFlag(RandomizeFoundItemsFlag_Link)) { return; } 
	int item = gEventSlots[3]; 
	int tier = GetItemTier(item); 
	int max = CountItems(tier); 
	gEventSlots[3] = RandomItemsTable[tier][HashShort_Ch(item, max)]; 
} 
void RandomizeCoins_ASMC(void) { 
	if (!CheckFlag(RandomizeFoundItemsFlag_Link)) { return; } 
	int coins = gEventSlots[3]; 
	int max = coins * 2; 
	if (max > 65000) { max = 65000; } 
	gEventSlots[3] = HashShort_Ch(coins, max); 
} 

extern u8 RandomSkillsTable[]; 
int CountSkills() {
	int i = 0; 
	while (RandomSkillsTable[i]) { 
		i++; 
	} 
	return i; 
}
int RandomizeSkill(int id, int classID) {
	if (!CheckFlag(RandomizeSkillsFlag_Link)) { return id; } 
	int max = CountSkills(); 
	return RandomSkillsTable[HashByte_Global(id, max, classID)]; 
}


u16 const gDefaultShopInventory[] = {
    ITEM_SWORD_IRON,
    ITEM_LANCE_IRON,
    ITEM_AXE_IRON,
    ITEM_BOW_IRON,
    ITEM_ANIMA_FIRE,
    ITEM_STAFF_HEAL,
    ITEM_NONE,
    ITEM_NONE,
};

void StartShopScreen(struct Unit* unit, u16* inventory, u8 shopType, ProcPtr parent) {
    struct BmShopProc* proc;
    u16* shopItems;
    int i;

    EndPlayerPhaseSideWindows();

    if (parent != 0) {
        proc = Proc_StartBlocking(gProcScr_Shop, parent);
    } else {
        proc = Proc_Start(gProcScr_Shop, PROC_TREE_3);
    }

    proc->shopType = shopType;
    proc->unit = unit;

    shopItems = gDefaultShopInventory;
    if (inventory != 0) {
        shopItems = inventory;
    }

	int rand = CheckFlag(RandomizeFoundItemsFlag_Link);
	if (rand) { 
		for (i = 0; i < 20; i++) {
			u16 itemId = *shopItems++;
			//asm("mov r11, r11"); 
			itemId = RandomizeItem(itemId);
			if (!(itemId & 0xFF00) && (itemId)) { itemId |= 0x100; } // 1 durability 
			proc->shopItems[i] = itemId; 
		}

	} 
	else {
		for (i = 0; i < 20; i++) {
			u16 itemId = *shopItems++;

			proc->shopItems[i] = MakeNewItem(itemId);
		}
	} 

    UpdateShopItemCounts(proc);

    return;
}
