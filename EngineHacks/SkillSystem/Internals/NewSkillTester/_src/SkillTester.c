#include "gbafe.h"

typedef struct SkillBuffer SkillBuffer;
typedef struct AuraSkillBuffer AuraSkillBuffer;

extern s8 AreAllegiancesEqual(int factionA, int factionB);
extern int AreUnitsAllied(int, int) __attribute__((long_call));
extern int IsSameAllegience(int, int) __attribute__((long_call)); // forgive the typo
static int absolute(int value) {return value < 0 ? -value : value;}
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

extern u8 gAttackerSkillBuffer[];
extern u8 gDefenderSkillBuffer[];
extern u8 gUnitRangeBuffer[];
extern AuraSkillBuffer gAuraSkillBuffer[];

//TODO: Separate this RAM address from SkillGetter
extern u8 SkillAttackerCache;
extern u8 SkillDefenderCache;

extern u8 AuraSkillTable[];
extern u8 NegatedSkills[];

extern u8 NihilIDLink;

//Makes skill buffer at a given location.
u8* MakeSkillBuffer(Unit* unit, u8* buffer) {
    int unitNum = unit->pCharacterData->number, count = 0, temp;
    
    temp = PersonalSkillTable[unitNum].skillID;
    if (IsSkillIDValid(temp)) {
        buffer[count++] = temp;
    }

    temp = ClassSkillTable[unit->pClassData->number].skillID;
    if (IsSkillIDValid(temp)) {
        buffer[count++] = temp;
    }

    for (int i = 0; i < 4; ++i) {
        if (!IsSkillIDValid(gBWLDataArray[unitNum].skills[i])) {
            break;
        }
        buffer[count++] = gBWLDataArray[unitNum].skills[i];
    }

    //Item passive skills
    for (int i = 0; i < 5 && unit->items[i]; ++i) {
        temp = unit->items[i];
        //TODO: Make this load an EA literal for the bit check
        if ((GetItemAttributes(temp) & 0x00800000)) {
            if (IsSkillIDValid(GetItemData(temp & 0xFF)->skill)) {
                buffer[count++] = GetItemData(temp & 0xFF)->skill;
            }
        }
    }

    //Extra checks made special for range skills so Gaiden Magic won't crash
    if (gBattleStats.config & 3) {
        if (unit->index == gBattleActor.unit.index) {
            temp = GetItemData(gBattleActor.weaponBefore & 0xFF)->skill;
        }
        else if (unit->index == gBattleTarget.unit.index) {
            temp = GetItemData(gBattleTarget.weaponBefore & 0xFF)->skill;
        }
        else {
            temp = GetItemData(GetUnitEquippedWeapon(unit) & 0xFF)->skill;
        }
    }

    //If the unit isn't in combat, use GetUnitEquippedWeapon
    else {
        temp = GetItemData(GetUnitEquippedWeapon(unit) & 0xFF)->skill;
    }

    if (IsSkillIDValid(temp)) {
        buffer[count++] = temp;
    }

    //Terminator
    buffer[count++] = 0;

    return buffer;
}

//Creates an aura skill buffer with skill coordinates relative to a unit
AuraSkillBuffer* MakeAuraSkillBuffer(Unit* unit) {
    u8 count = 0;

    for (int i = 0; i < 0x100; ++i) {
        Unit* other = gUnitLookup[i];

        if (!other)
            continue;

        if (!other->pCharacterData)
            continue;
        
        if (other->state & (US_RESCUED | US_NOT_DEPLOYED | US_DEAD | 0x00010000))
            continue;

        if (unit->index == i)
            continue;

        //If the unit is actually on the field, make a skill buffer for them
        u8* skills = MakeSkillBuffer(other, gAttackerSkillBuffer);

        //For every skill in the buffer, index AuraSkillTable to find a match
        for (int j = 0; skills[j] != 0; ++j) {
            if (AuraSkillTable[skills[j]]) {
                gAuraSkillBuffer[count].skillID = skills[j];
                gAuraSkillBuffer[count].distance = absolute(other->xPos - unit->xPos)
                                                 + absolute(other->yPos - unit->yPos);
                gAuraSkillBuffer[count].faction = UNIT_FACTION(other);
                ++count;
            }
        }
    }
    
    SkillAttackerCache = 0;
    return gAuraSkillBuffer;
}

//Checks for skills already added to the buffer without needing a full skill test
//Used by the weapon usability calc loop
bool CheckSkillBuffer(Unit* unit, int skillID) {
    if (skillID == 0)   {return TRUE;}
    if (skillID == 255) {return FALSE;}

    u8* buffer = gAttackerSkillBuffer;

    if (unit->index == SkillDefenderCache) {
        buffer = gDefenderSkillBuffer;
    }

    for (int i = 0; buffer[i] != 0; ++i) {
        if (buffer[i] == skillID) {
            return TRUE;
        }
    }
    return FALSE;
}

//Checks if the given skill is negated by Nihil
//If it is, the unit's opponent's skill buffer is searched through for nihil
bool NihilTester(Unit* unit, int skillID) {
    if ((gBattleStats.config & 3) && NegatedSkills[skillID]) {
        u8* buffer = gDefenderSkillBuffer;

        //If the unit is the defender, check the attacker skill buffer instead
        if (unit->index == SkillDefenderCache)
            buffer = gAttackerSkillBuffer;

        for (int i = 0; buffer[i]; i++) {
            if (buffer[i] == NihilIDLink)
                return TRUE;
        }
    }
    return FALSE;
}

//Checks unit for a given skill.
//If the unit tested is the same as time, uses the previous skill buffer
bool SkillTester(Unit* unit, u8 skillID) {
    if (skillID == 0)   {return TRUE;}
    if (skillID == 255) {return FALSE;}

    int index = unit->index;
    u8* buffer = gAttackerSkillBuffer;

    //If unit is the defender, use the defender buffer
    if (index == gBattleTarget.unit.index && (gBattleStats.config & 3)) {
        buffer = gDefenderSkillBuffer;
        if (index != SkillDefenderCache) {
            SkillDefenderCache = index;
            MakeSkillBuffer(unit, buffer);
        }
    }

    //Otherwise, default to the attacker buffer
    else {
        if (index != SkillAttackerCache) {
            SkillAttackerCache = index;
            MakeSkillBuffer(unit, buffer);
        }
    }

    //Check buffer for matching skill
    for (int i = 0; buffer[i] != 0; ++i) {
        if (buffer[i] == skillID) {
            return !NihilTester(unit, skillID);
        }
    }

    return FALSE;
}

//Loops through premade aura skill buffer to find matching aura skills within range
bool NewAuraSkillCheck(Unit* unit, int skillID, int param, int maxRange) {
    const s8(*pAllegianceChecker)(int, int) = ((param & 1) ? AreAllegiancesAllied : AreAllegiancesEqual);

    if (skillID == 0)   {return TRUE;}
    if (skillID == 255) {return FALSE;}

    for (int i = 0; gAuraSkillBuffer[i].skillID; ++i) {
        if (gAuraSkillBuffer[i].distance <= maxRange && gAuraSkillBuffer[i].skillID == skillID) {

            //NOTE: This is checking bits
            int check = pAllegianceChecker(unit->index, gAuraSkillBuffer[i].faction);

            if (param & 2)
                check = !check;

            if (check)
                return TRUE;
        }
    }

    return FALSE;
}

//Initializes buffers
void InitializePreBattleLoop(Unit* attacker, Unit* defender) {
    MakeAuraSkillBuffer(attacker);
    MakeSkillBuffer(attacker, gAttackerSkillBuffer);
    SkillAttackerCache = attacker->index;
    SkillDefenderCache = 0;

    if ((gBattleStats.config & 3)) {
        MakeSkillBuffer(&gBattleTarget.unit, gDefenderSkillBuffer);
        SkillDefenderCache = gBattleTarget.unit.index;
    }
}

u8* GetUnitsInRange(Unit* unit, int param, int range) {
    const s8(*pAllegianceChecker)(int, int) = ((param & 1) ? AreAllegiancesAllied : AreAllegiancesEqual);

    int count = 0;

    for (int i = 0; i < 0x100; ++i) {
        Unit* other = gUnitLookup[i];

        if (!other)
            continue;

        if (!other->pCharacterData)
            continue;
        
        if (other->state & (US_RESCUED | US_NOT_DEPLOYED | US_DEAD | 0x00010000))
            continue;

        if (unit->index == i)
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
