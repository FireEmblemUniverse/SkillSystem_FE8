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


int GetMaxStr(struct Unit* unit);
int GetMaxSkl(struct Unit* unit);
int GetMaxSpd(struct Unit* unit);
int GetMaxDef(struct Unit* unit);
int GetMaxRes(struct Unit* unit);
int GetMaxMag(struct Unit* unit);
int GetMaxLck(struct Unit* unit); 
int GetMaxStrV(struct Unit* unit, int variance);
int GetMaxSklV(struct Unit* unit, int variance);
int GetMaxSpdV(struct Unit* unit, int variance);
int GetMaxDefV(struct Unit* unit, int variance);
int GetMaxResV(struct Unit* unit, int variance);
int GetMaxMagV(struct Unit* unit, int variance);
int GetMaxLckV(struct Unit* unit, int variance); 
struct magClassTable { 
u8 base; 
u8 growth; 
u8 cap; 
u8 promo; 
}; 
struct classLuckTable { 
u8 unk1;
u8 unk2;
u8 unk3;
u8 cap; 
}; 
extern struct classLuckTable ClassLuckTable[]; 
extern struct magClassTable MagClassTable[]; 

int GetAverageCap(struct Unit* unit) { 
	int classID = unit->pClassData->number; 
	int i = 0; 
	int result = UNIT_POW_MAX(unit); i++; 
	result += UNIT_SKL_MAX(unit); i++; 
	result += UNIT_SPD_MAX(unit); i++; 
	result += UNIT_DEF_MAX(unit); i++; 
	result += UNIT_RES_MAX(unit); i++; 
	result += MagClassTable[classID].cap; i++; 
	//result += ClassLuckTable[classID].cap; 
	//result += ClassMaxHPTable[classID].cap; 
	return (result / i); 
} 
int GetAverageGrowth(struct Unit* unit) { 
	int classID = unit->pClassData->number; 
	int i = 0; 
	int result = unit->pClassData->growthPow + 10; i++; 
	result += unit->pClassData->growthSkl + 10; i++; 
	result += unit->pClassData->growthSpd + 10; i++; 
	result += unit->pClassData->growthDef + 10; i++; 
	result += unit->pClassData->growthRes + 10; i++; 
	result += MagClassTable[classID].growth + 10; i++; 
	//result += ClassLuckTable[classID].growth; 
	//result += ClassMaxHPTable[classID].growth; 
	return (result / i); 
} 

// mov r2, r6 @ index in stat booster pointer of growth
int GetRandomizedGrowth(struct Unit* unit, int growth, int id) { // index in stat booster pointer of growth
	if (!CheckFlag(RandomizeGrowthsFlag_Link)) { return growth; } 
	int uid = unit->pCharacterData->number;

	int avgCap = GetAverageCap(unit); 
	if ((uid >= 0x50) && (uid<0x87)) { growth += 10; } // so wilds match players 
	if ((uid > 0x8C) && (uid<0xA0)) { growth += 10; } 
	int newGrowth = growth; 
	
	int cid = id + unit->pClassData->number;
	newGrowth = HashByte_Global(newGrowth, (newGrowth/10) + avgCap, cid) + (avgCap / 3);
	//if (abs(newGrowth - ((growth * 2) / 3)) < 15) { newGrowth = HashByte_Global(newGrowth, ((growth*2)/3) + 30, cid); } // reroll if too similar 
	
	// HP 
	if (id == 10) { return newGrowth; } 
	
	// average random + half of the cap 
	typedef int (*func_unit_int)(struct Unit*, int);
	//void func ( int (*f)(int) ) = GetMaxStr(); 
	func_unit_int func = &GetMaxStrV; 
	
	// STR 
	if (id == 11) { func = &GetMaxStrV; } 
	// SKL 
	if (id == 12) { func = &GetMaxSklV; } 
	// SPD 
	if (id == 13) { func = &GetMaxSpdV; } 
	// DEF
	if (id == 14) { func = &GetMaxDefV; } 
	// RES 
	if (id == 15) { func = &GetMaxResV; } 
	// LCK 
	if (id == 16) { func = &GetMaxLckV; } 
	// MAG 
	if (id == 17) { func = &GetMaxMagV; } 
	
	int statCap = func(unit, 0);
	
	int result = (statCap*5)/2; //((statCap*3)/2); // + (newGrowth/5);
	newGrowth = HashByte_Global(statCap, avgCap/4, cid);
	result -= newGrowth; 
	if (result < 0) { result = 0; } 
	int max = (GetAverageGrowth(unit) * 3)/2; 
	if (result > max) { newGrowth = max; } 
	
	//if (abs(result - growth) < 20) { result = ((func(unit, result)*3)/2) + (result/5); } 
	//if (abs(result - growth) < 20) { result = ((func(unit, result)*3)/2) + (result/5); } 
	//if (abs(result - growth) < 20) { result = ((func(unit, result)*3)/2) + (result/5); } 
	//if (abs(result - growth) < 20) { result = ((func(unit, result)*3)/2) + (result/5); } 
	
	if ((result - growth) > 99) { result = 99; } // more than +99 growth looks bad on stat screen 
	if ((growth - result) > 99) { result = growth - 99; } // more than +99 growth looks bad on stat screen 
	return result; 
} 

int RandStat(int stat, int variance, int avgCap) { 
	int max = (stat/3) + (avgCap/5); 
	int min = avgCap / 10; 
	max -= min; 
	max = max < 63 ? max : 63 ; // cap at 63 
	return HashByte_Global(stat, max, variance) + min; 
} 

void RandomizeStats(struct Unit* unit) { 
	if (!CheckFlag(RandomizeBaseStatsFlag_Link)) { return; } 
	int classID = unit->pClassData->number; 
	int avgCap = GetAverageCap(unit); 
	unit->maxHP = RandStat(unit->maxHP, classID, avgCap); 
	if (unit->maxHP < 10) { unit->maxHP += 10; } 
	unit->pow = RandStat(unit->pow, classID, avgCap); 
	unit->skl = RandStat(unit->skl, classID, avgCap); 
	unit->spd = RandStat(unit->spd, classID, avgCap); 
	unit->def = RandStat(unit->def, classID, avgCap); 
	unit->res = RandStat(unit->res, classID, avgCap); 
	unit->lck = RandStat(unit->lck, classID, avgCap); 
	unit->_u3A = RandStat(unit->_u3A, classID, avgCap); // mag 
} 


int RandomizeStatCap(int statCap, struct Unit* unit, int variance) { 
	int avgCap = GetAverageCap(unit); 
	int min = (avgCap / 3); // eg. 10 - 20 
	int max = ((avgCap * 3)/2) - min; // eg. 45 - 90 
	if ((avgCap - statCap) > 10) { max = (max*3)/2; } 
	int classID = unit->pClassData->number + variance; 
	int result = HashByte_Global(statCap, max, classID) + min;
	
	
	
	if (abs(result - statCap) < (avgCap/2)) { result = HashByte_Global(result, max, classID) + min; } // reroll if too similar 
	if (abs(result - statCap) < (avgCap/2)) { result = HashByte_Global(result, max, classID) + min; } // reroll if too similar 
	if (abs(result - statCap) < 16) { result = HashByte_Global(result, max, classID) + min; } // reroll if too similar 
	if (abs(result - statCap) < 11) { result = HashByte_Global(result, max + min, classID); } // reroll if too similar 
	if (abs(result - statCap) < 6) { result = HashByte_Global(result, max + min, classID); } // reroll if too similar 
	
	
	
	if (result > 60) { result = 60; } // probably unnecessary 
	return result; 

} 

int GetMaxStrV(struct Unit* unit, int variance) { 
	int rand = CheckFlag(RandomizeGrowthsFlag_Link);
	int num = UNIT_POW_MAX(unit); 
	if (!rand) { return num; } 
	return RandomizeStatCap(num, unit, 0+variance); // extra variance variable so stats with same max will differ 
} 
int GetMaxStr(struct Unit* unit) { 
	return GetMaxStrV(unit, 0); 
} 

int GetMaxSklV(struct Unit* unit, int variance) { 
	int rand = CheckFlag(RandomizeGrowthsFlag_Link);
	int num = UNIT_SKL_MAX(unit); 
	if (!rand) { return num; } 
	return RandomizeStatCap(num, unit, 1+variance); 
} 
int GetMaxSkl(struct Unit* unit) { 
	return GetMaxSklV(unit, 0); 
} 

int GetMaxSpdV(struct Unit* unit, int variance) { 
	int rand = CheckFlag(RandomizeGrowthsFlag_Link);
	int num = UNIT_SPD_MAX(unit); 
	if (!rand) { return num; } 
	return RandomizeStatCap(num, unit, 2+variance); 
} 
int GetMaxSpd(struct Unit* unit) { 
	return GetMaxSpdV(unit, 0);
} 

int GetMaxDefV(struct Unit* unit, int variance) { 
	int rand = CheckFlag(RandomizeGrowthsFlag_Link);
	int num = UNIT_DEF_MAX(unit); 
	if (!rand) { return num; } 
	return RandomizeStatCap(num, unit, 3+variance); 
} 
int GetMaxDef(struct Unit* unit) { 
	return GetMaxDefV(unit, 0);
} 

int GetMaxResV(struct Unit* unit, int variance) { 
	int rand = CheckFlag(RandomizeGrowthsFlag_Link);
	int num = UNIT_RES_MAX(unit); 
	if (!rand) { return num; } 
	return RandomizeStatCap(num, unit, 4+variance); 
} 
int GetMaxRes(struct Unit* unit) { 
	return GetMaxResV(unit, 0); 
} 

int GetMaxMagV(struct Unit* unit, int variance) { 
	int rand = CheckFlag(RandomizeGrowthsFlag_Link);
	int magCap = MagClassTable[unit->pClassData->number].cap; 
	if (!rand) { return magCap; }
	return RandomizeStatCap(magCap, unit, 5+variance); 
} 
int GetMaxMag(struct Unit* unit) { 
	return GetMaxMagV(unit, 0); 
} 

int GetMaxLckV(struct Unit* unit, int variance) { 
	int rand = CheckFlag(RandomizeGrowthsFlag_Link);
	int num = ClassLuckTable[((unit)->pClassData->number)].cap; 
	if (!rand) { return num; } 
	return RandomizeStatCap(num, unit, 6+variance); 
} 
int GetMaxLck(struct Unit* unit) { 
	return GetMaxLckV(unit, 0); 
} 


void RandomizeStatCaps(struct BattleUnit* bu, struct Unit* unit) { 
	
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
	
	max = GetMaxLck(unit);
    if ((unit->lck + bu->changeLck) > max) { 
	bu->changeLck = max - unit->lck; } 
	
	max = GetMaxMag(unit);
    if ((unit->_u3A + bu->changeCon) > max) { 
	bu->changeCon = max - unit->_u3A; } 

} 

void UnitRandomizeStatCaps(struct Unit* unit) { 
	
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
	
	max = GetMaxLck(unit);
    if (unit->lck > max) { 
	unit->lck = max; } 
	
	max = GetMaxMag(unit);
    if (unit->_u3A  > max) { 
	unit->_u3A = max; } 
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
