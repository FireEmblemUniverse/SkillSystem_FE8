#include "CheckBattleUnitLevelUp.h" 


int NewGetStatIncrease(int growth) {
    int result = 0;

    while (growth > 100) {
        result++;
        growth -= 100;
    }

    if (Roll1RN(growth))
        result++;

    return result;
}

void CheckBattleUnitLevelUp(struct BattleUnit* bu) {
    if (CanBattleUnitGainLevels(bu) && bu->unit.exp >= 100) {
        int growthBonus, statGainTotal;

        bu->unit.exp -= 100;
        bu->unit.level++;

        if (UNIT_CATTRIBUTES(&bu->unit) & CA_MAXLEVEL10) {
            if (bu->unit.level == 10) {
                bu->expGain -= bu->unit.exp;
                bu->unit.exp = UNIT_EXP_DISABLED;
            }
        } else if (bu->unit.level == 20) {
            bu->expGain -= bu->unit.exp;
            bu->unit.exp = UNIT_EXP_DISABLED;
        }

        growthBonus = (bu->unit.state & US_GROWTH_BOOST) ? 5: 0;
        statGainTotal = 0;

        bu->changeHP  = NewGetStatIncrease(bu->unit.pCharacterData->growthHP + growthBonus);
        statGainTotal += bu->changeHP;

        bu->changePow = NewGetStatIncrease(bu->unit.pCharacterData->growthPow + growthBonus);
        statGainTotal += bu->changePow;

        bu->changeSkl = NewGetStatIncrease(bu->unit.pCharacterData->growthSkl + growthBonus);
        statGainTotal += bu->changeSkl;

        bu->changeSpd = NewGetStatIncrease(bu->unit.pCharacterData->growthSpd + growthBonus);
        statGainTotal += bu->changeSpd;

        bu->changeDef = NewGetStatIncrease(bu->unit.pCharacterData->growthDef + growthBonus);
        statGainTotal += bu->changeDef;

        bu->changeRes = NewGetStatIncrease(bu->unit.pCharacterData->growthRes + growthBonus);
        statGainTotal += bu->changeRes;

        bu->changeLck = NewGetStatIncrease(bu->unit.pCharacterData->growthLck + growthBonus);
        statGainTotal += bu->changeLck;

        if (statGainTotal == 0) {
            for (statGainTotal = 0; statGainTotal < 2; ++statGainTotal) {
                bu->changeHP = NewGetStatIncrease(bu->unit.pCharacterData->growthHP);

                if (bu->changeHP)
                    break;

                bu->changePow = NewGetStatIncrease(bu->unit.pCharacterData->growthPow);

                if (bu->changePow)
                    break;

                bu->changeSkl = NewGetStatIncrease(bu->unit.pCharacterData->growthSkl);

                if (bu->changeSkl)
                    break;

                bu->changeSpd = NewGetStatIncrease(bu->unit.pCharacterData->growthSpd);

                if (bu->changeSpd)
                    break;

                bu->changeDef = NewGetStatIncrease(bu->unit.pCharacterData->growthDef);

                if (bu->changeDef)
                    break;

                bu->changeRes = NewGetStatIncrease(bu->unit.pCharacterData->growthRes);

                if (bu->changeRes)
                    break;

                bu->changeLck = NewGetStatIncrease(bu->unit.pCharacterData->growthLck);

                if (bu->changeLck)
                    break;
            }
        }

        CheckBattleUnitStatCaps(GetUnit(bu->unit.index), bu);
    }
}


