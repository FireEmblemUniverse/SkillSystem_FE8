#include "gbafe.h"

typedef struct SkillBuffer SkillBuffer;
typedef struct AuraSkillBuffer AuraSkillBuffer;

extern s8 AreAllegiancesEqual(int factionA, int factionB);
extern int AreUnitsAllied(int, int) __attribute__((long_call));
extern int IsSameAllegience(int, int) __attribute__((long_call)); // forgive the typo
static int absolute(int value) { return value < 0 ? -value : value; }
static bool IsSkillIDValid(int skillID) {return skillID != 0 && skillID != 255;}

struct BWLData {
    u8 unk1;
    u8 skills[4];
    u8 pad[11];
};

struct AuraSkillBuffer {
    u8 skillID;
    u8 distance;
    u8 faction;
    u8 pad;
};

extern struct BWLData gBWLDataArray[];
extern u8 gSkillBuffer[];
extern u8 AuraSkills[];
extern u8 gUnitRangeBuffer[];

extern u8 SkillAttackerCache;
extern u8 SkillDefenderCache; //For Nihil

extern AuraSkillBuffer gAuraSkillBuffer[];

u8* MakeSkillBuffer(Unit* unit) {
    u8 unitNum = unit->pCharacterData->number, count = 0, temp = 0;
    u8* buff = gSkillBuffer;

    temp = PersonalSkillTable[unitNum].skillID;
    if (temp != 0 && temp != 255) {
        buff[count++] = temp;
    }

    temp = ClassSkillTable[unit->pClassData->number].skillID;
    if (temp != 0 && temp != 255) {
        buff[count++] = temp;
    }

    for (int i = 0; i <= 3; ++i) {
        if (IsSkillIDValid(gBWLDataArray[unitNum].skills[i])) {
            buff[count++] = gBWLDataArray[unitNum].skills[i];
            continue;
        }
        break;
    }

    //Extra checks made special for range skills so Gaiden Magic won't crash
    if (gBattleStats.config & 3) {
        if (unit->index == gBattleActor.unit.index) {
            temp = GetItemData(gBattleActor.weaponBefore & 0xFF)->skill;
        }
        else if (unit->index == gBattleTarget.unit.index) {
            temp = GetItemData(gBattleTarget.weaponBefore & 0xFF)->skill;
        }
    }

    //If the unit isn't in combat, use GetUnitEquippedWeapon
    else {
        temp = GetItemData(GetUnitEquippedWeapon(unit) & 0xFF)->skill;
    }

    if (temp != 0 && temp != 255) {
        buff[count++] = temp;
    }

    buff[count++] = 0;

    SkillAttackerCache = unit->index;
    return buff;
}

AuraSkillBuffer* MakeAuraSkillBuffer(Unit* unit) {
    u8 count = 0;

    for (int i = 0; i < 0x100; ++i) {
        Unit* other = gUnitLookup[i];

		if (!other)
			continue;

		if (unit->index == i)
			continue;

		if (!other->pCharacterData)
			continue;
        
        if (other->state & (US_RESCUED | US_NOT_DEPLOYED | US_DEAD | 0x00010000))
			continue;

        u8* skills = MakeSkillBuffer(other);

        //For every skill in the buffer, loop through the AuraSkills list to find a match
        for (int j = 0; skills[j] != 0; ++j) {
            for (int k = 0; AuraSkills[k] != 0; ++k) {
                if (AuraSkills[k] == skills[j]) {
                    gAuraSkillBuffer[count].skillID = skills[j];
                    gAuraSkillBuffer[count].distance = absolute(other->xPos - unit->xPos)
                                                     + absolute(other->yPos - unit->yPos);
                    gAuraSkillBuffer[count].faction = UNIT_FACTION(other);
                    ++count;
                    break;
                }
            }
        }
    }

    return gAuraSkillBuffer;
}

//Checks for skills already added to the buffer without needing a full skill test
//Used by the weapon usability calc loop
int CheckSkillBuffer(Unit* unit, int skill) {
    for (int i = 0; gSkillBuffer[i] != 0; ++i) {
        if (gSkillBuffer[i] == skill) {
            return TRUE;
        }
    }
    return FALSE;
}

int SkillTester(Unit* attacker, u8 skill) {
    if (skill == 0)   {return TRUE;}
    if (skill == 255) {return FALSE;}

    if (attacker->index != SkillAttackerCache) {
        MakeSkillBuffer(attacker);
    }

    for (int i = 0; gSkillBuffer[i] != 0; ++i) {
        if (gSkillBuffer[i] == skill) {
            return TRUE;
        }
    }

    return FALSE;
}

int NewAuraSkillCheck(Unit* unit, int skill, int param, int maxRange) {
    const s8(*pAllegianceChecker)(int, int) = ((param & 1) ? AreAllegiancesAllied : AreAllegiancesEqual);

    if (skill == 0)   {return TRUE;}
    if (skill == 255) {return FALSE;}

    for (int i = 0; gAuraSkillBuffer[i].skillID; ++i) {
        if (gAuraSkillBuffer[i].skillID == skill && gAuraSkillBuffer[i].distance <= maxRange) {

            //NOTE: this is checking bits
            if (param == 4)
		        return TRUE;

            if (param > 4)
		        return 0;

            int check = pAllegianceChecker(unit->index, gAuraSkillBuffer[i].faction);

            if (param & 2)
        		check = !check;

            return check;
        }
    }

    return FALSE;
}

u8* GetUnitsInRange(Unit* unit, int param, int range) {
    const s8(*pAllegianceChecker)(int, int) = ((param & 1) ? AreAllegiancesAllied : AreAllegiancesEqual);

    int count = 0;

    for (int i = 0; i < 0x100; ++i) {
        Unit* other = gUnitLookup[i];

        //NOTE: this is checking bits
		if (!other)
			continue;

		if (unit->index == i)
			continue;

		if (!other->pCharacterData)
			continue;
        
        if (other->state & (US_RESCUED | US_NOT_DEPLOYED | US_DEAD | 0x00010000))
			continue;

        //Done in a way that check is always true when a unit matching the critera is found
        int check = (param & 2) ? !pAllegianceChecker(unit->index, other->index) :
                                   pAllegianceChecker(unit->index, other->index);

        if (check) {
            if ((absolute(other->xPos - unit->xPos)
               + absolute(other->yPos - unit->yPos)) <= range) {
                gUnitRangeBuffer[count++] = i;
            }
        }
    }

    gUnitRangeBuffer[count] = 0;
    if (!gUnitRangeBuffer[0])
        return FALSE;

    return gUnitRangeBuffer;
}
