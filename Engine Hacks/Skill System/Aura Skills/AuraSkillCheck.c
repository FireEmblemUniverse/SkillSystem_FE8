#include "gbafe.h"

extern int SkillTester(Unit*, int) __attribute__((long_call));

extern int AreUnitsAllied(int, int) __attribute__((long_call));
extern int IsSameAllegience(int, int) __attribute__((long_call)); // forgive the typo

extern uint8_t gAuraUnitListOut[];

static int absolute(int value) { return value < 0 ? -value : value; }

static int AuraSkillTest(Unit* unit, Unit* other, int skill, int param);

long long AuraSkillCheck(Unit* unit, int skill, int param, int maxRange) {
	int count = 0;

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
		
		int distance = absolute(other->xPos - unit->xPos)
		             + absolute(other->yPos - unit->yPos);
		
		if ((distance <= maxRange) && AuraSkillTest(unit, other, skill, param))
			gAuraUnitListOut[count++] = i;
	}

	gAuraUnitListOut[count] = 0;

	union {
		long long asLongLong;
		struct {
			int count;
			uint8_t* pList;
		};
	} result;

	result.count = count;
	result.pList = gAuraUnitListOut;

	return result.asLongLong;
}

int AuraSkillTest(Unit* unit, Unit* other, int skill, int param) {
	const int(*pAllegianceChecker)(int, int) = ((param & 1) ? AreUnitsAllied : IsSameAllegience);
	
	if (param == 4)
		return SkillTester(other, skill);
	
	if (param > 4)
		return 0;

	int check = pAllegianceChecker(unit->index, other->index);

	if (param & 2)
		check = !check;

	return check && SkillTester(other, skill);
}
