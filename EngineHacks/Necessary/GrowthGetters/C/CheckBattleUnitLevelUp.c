#include "CheckBattleUnitLevelUp.h" 

#define regularGrowths 0 
#define fixedGrowths 1 
#define bracketedGrowths 2 

#define hpStat 0
#define strStat 1
#define sklStat 2
#define spdStat 3
#define defStat 4
#define resStat 5
#define lukStat 6
#define magStat 7

#ifdef POKEMBLEM_VERSION
extern int GetAverageStat(int growth, int stat, struct Unit* unit, int levels); // written in asm already 
#else 
int GetAverageStat(int growth, int stat, struct Unit* unit, int levels) { 
	int result = 0; 
	int baseStat = GetBaseStatFromDefinition(stat, unit); 
	result = ((growth * levels) / 100) + baseStat; 
	return result; 

} 
#endif 

int GetStatFromDefinition(int id, struct Unit* unit) { // unit required because bunit includes stats from temp boosters (eg. weapon provides +5 str) in their raw stats 
	switch (id) { 
	case hpStat: return unit->maxHP; 
	case strStat: return unit->pow; 
	case sklStat: return unit->skl; 
	case spdStat: return unit->spd; 
	case defStat: return unit->def; 
	case resStat: return unit->res; 
	case lukStat: return unit->lck; 
	case magStat: return unit->_u3A; // mag 
	}
	return 0; 
} 

int GetBaseStatFromDefinition(int id, struct Unit* unit) { // unit required because bunit includes stats from temp boosters (eg. weapon provides +5 str) in their raw stats 
	switch (id) { 
	case hpStat: return unit->pCharacterData->baseHP + unit->pClassData->baseHP; 
	case strStat: return unit->pCharacterData->basePow + unit->pClassData->basePow; 
	case sklStat: return unit->pCharacterData->baseSkl + unit->pClassData->baseSkl; 
	case spdStat: return unit->pCharacterData->baseSpd + unit->pClassData->baseSpd; 
	case defStat: return unit->pCharacterData->baseDef + unit->pClassData->baseDef; 
	case resStat: return unit->pCharacterData->baseRes + unit->pClassData->baseRes; 
	case lukStat: return unit->pCharacterData->baseLck; // classes do not have base luck + unit->pClassData->baseLck; 
	case magStat: return MagCharTable[unit->pCharacterData->number].base + MagClassTable[unit->pClassData->number].base; 
	} 
	return 0; 
} 

int GetNumberOfLevelUps(struct BattleUnit* bu) { // I just copied exactly what Teq did for this section 
	int numberOfLevels = bu->unit.level - 1; 
	if ((bu->unit.pCharacterData->attributes | bu->unit.pClassData->attributes) & CA_PROMOTED) { 
		numberOfLevels += 19; 
	} 
	if (numberOfLevels < 0) return 0; // probably unnecessary 
	return numberOfLevels; 
} 

int NewGetStatIncrease(int growth, int mode, int stat, struct BattleUnit* bu,  struct Unit* unit) { 
    int result = 0;

	if (mode == fixedGrowths) { 
		result = (((growth * GetNumberOfLevelUps(bu)) % 100) + growth) / 100;  // I just copied exactly what Teq did for this
		return result; 
	} 
	
	if (mode == bracketedGrowths) { 
		int averageStat = GetAverageStat(growth, stat, unit, GetNumberOfLevelUps(bu)); 
		int currentStat = GetStatFromDefinition(stat, unit); 
		while (growth > 100) {
			result++;
			growth -= 100;
		}
		if ((averageStat + PreventWhenAboveAverageBy_Link) > currentStat) { 
		return result; 
		} 
		if ((currentStat + ForceWhenBelowAverageBy_Link) < currentStat) { 
		result++; 
		} 
		else if (Roll1RN(growth))
        result++;
		return result; 
	} 
	
	
	
    while (growth > 100) {
        result++;
        growth -= 100;
    }

    if (Roll1RN(growth))
        result++;

    return result;
}

extern int Get_Hp_Growth(struct Unit* unit); 
extern int Get_Str_Growth(struct Unit* unit); 
extern int Get_Skl_Growth(struct Unit* unit); 
extern int Get_Spd_Growth(struct Unit* unit); 
extern int Get_Def_Growth(struct Unit* unit); 
extern int Get_Res_Growth(struct Unit* unit); 
extern int Get_Luk_Growth(struct Unit* unit); 
extern int* gMagGrowth(struct Unit* unit); 

void CheckBattleUnitLevelUp(struct BattleUnit* bu) {
    if (CanBattleUnitGainLevels(bu) && bu->unit.exp >= 100) {
		int mode = regularGrowths; // default  
		struct Unit* unit = NULL; 
		if (GrowthOptions_Link.FIXED_GROWTHS_MODE) { 
			if (CheckEventId(GrowthOptions_Link.FIXED_GROWTHS_FLAG_ID)) { 
			mode = fixedGrowths; 
			}
		} 
		if (GrowthOptions_Link.STAT_BRACKETING_EXISTS) { 
			if (CheckEventId(BRACKETED_GROWTHS_FLAG_ID_Link)) { 
			mode = bracketedGrowths; 
			unit = GetUnit(bu->unit.index); // required because bunit includes stats from temp boosters (eg. weapon provides +5 str) in their raw stats 
			}
		} 

		
		
        int statGainTotal = 0;

        bu->unit.exp -= 100;
        bu->unit.level++;

        if (UNIT_CATTRIBUTES(&bu->unit) & CA_MAXLEVEL10) {
            if (bu->unit.level == 10) {
                bu->expGain -= bu->unit.exp;
                bu->unit.exp = UNIT_EXP_DISABLED;
            }
        } else if (bu->unit.level >= Class_Level_Cap_Table[bu->unit.pClassData->number]) {
            bu->expGain -= bu->unit.exp;
            bu->unit.exp = UNIT_EXP_DISABLED;
        }

		int hpGrowth = Get_Hp_Growth(&bu->unit); 
		int strGrowth = Get_Str_Growth(&bu->unit); 
		int sklGrowth = Get_Skl_Growth(&bu->unit); 
		int spdGrowth = Get_Spd_Growth(&bu->unit); 
		int defGrowth = Get_Def_Growth(&bu->unit); 
		int resGrowth = Get_Res_Growth(&bu->unit); 
		int lukGrowth = Get_Luk_Growth(&bu->unit); 
		int magGrowth = 0; 
		if (magExists) { magGrowth = *gMagGrowth(&bu->unit); } 

        bu->changeHP  = NewGetStatIncrease(hpGrowth, mode, hpStat, bu, unit);
        statGainTotal += bu->changeHP;

        bu->changePow = NewGetStatIncrease(strGrowth, mode, strStat, bu, unit);
        statGainTotal += bu->changePow;

        bu->changeSkl = NewGetStatIncrease(sklGrowth, mode, sklStat, bu, unit);
        statGainTotal += bu->changeSkl;

        bu->changeSpd = NewGetStatIncrease(spdGrowth, mode, spdStat, bu, unit);
        statGainTotal += bu->changeSpd;

        bu->changeDef = NewGetStatIncrease(defGrowth, mode, defStat, bu, unit);
        statGainTotal += bu->changeDef;

        bu->changeRes = NewGetStatIncrease(resGrowth, mode, resStat, bu, unit);
        statGainTotal += bu->changeRes;

        bu->changeLck = NewGetStatIncrease(lukGrowth, mode, lukStat, bu, unit);
        statGainTotal += bu->changeLck;
		
		bu->changeCon = NewGetStatIncrease(magGrowth, mode, magStat, bu, unit); // mag uses the changeCon byte (and always has) 
        statGainTotal += bu->changeCon;
		
        if (statGainTotal < minStatGain_Link) {
            for (int attempts = 0; attempts < 5; ++attempts) {

				// if we did not get atleast x stat ups on level, try each of these in order 
				// previously you'd often get +1 hp and nothing else on bad level ups because of the order 
				// so I've changed the order to Str > Mag > Spd > Def > Res > Luk > Hp > Skl 
				// you're more likely to get a more useful single stat levelup this way 
				if (!bu->changePow) { // don't count changePow multiple times in statGainTotal 
					bu->changePow = NewGetStatIncrease(strGrowth, mode, strStat, bu, unit);
					statGainTotal += bu->changePow;
					if (statGainTotal >= minStatGain_Link)
						break;
				} 
				if (!bu->changeCon) { 
					bu->changeCon = NewGetStatIncrease(magGrowth, mode, magStat, bu, unit); // mag uses the changeCon byte (and always has) 
					statGainTotal += bu->changeCon;
					if (statGainTotal >= minStatGain_Link)
						break;
				} 
				
				if (!bu->changeSpd) { 
					bu->changeSpd = NewGetStatIncrease(spdGrowth, mode, spdStat, bu, unit);
					statGainTotal += bu->changeSpd;
					if (statGainTotal >= minStatGain_Link)
						break;
				}
				
				if (!bu->changeDef) { 
					bu->changeDef = NewGetStatIncrease(defGrowth, mode, defStat, bu, unit);
					statGainTotal += bu->changeDef;
					if (statGainTotal >= minStatGain_Link)
						break;
				} 
				
				if (!bu->changeRes) { 
					bu->changeRes = NewGetStatIncrease(resGrowth, mode, resStat, bu, unit);
					statGainTotal += bu->changeRes;
					if (statGainTotal >= minStatGain_Link)
						break;
				} 
				
				if (!bu->changeLck) { 
					bu->changeLck = NewGetStatIncrease(lukGrowth, mode, lukStat, bu, unit);
					statGainTotal += bu->changeLck;
					if (statGainTotal >= minStatGain_Link)
						break;
				} 
				
				if (!bu->changeHP) { 
					bu->changeHP  = NewGetStatIncrease(hpGrowth, mode, hpStat, bu, unit);
					statGainTotal += bu->changeHP;
					if (statGainTotal >= minStatGain_Link)
						break;
				} 
				if (!bu->changeSkl) { 
					bu->changeSkl = NewGetStatIncrease(sklGrowth, mode, sklStat, bu, unit);
					statGainTotal += bu->changeSkl;
					if (statGainTotal >= minStatGain_Link)
						break;
				}
				
            }
        }

        CheckBattleUnitStatCaps(GetUnit(bu->unit.index), bu);
    }
}


