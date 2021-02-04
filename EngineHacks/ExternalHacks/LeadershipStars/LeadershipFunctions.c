#include "include\gbafe.h"

// Leadership Stars FE8. Hack by Zeta/Gilgamesh
// Requires FE-CLIB
// Free to use/modify

#define MAX_BLUE_UNITS 20
#define MAX_GREEN_UNITS 20
#define MAX_RED_UNITS 50

extern struct Unit gUnitArrayRed[]; //! FE8U = 0x202CFBC
extern struct Unit gUnitArrayGreen[]; //! FE8U = 0x202DDCC

struct Leadership
{
	u8 UnitID;
	u8 LeadershipStars;
};

extern struct Leadership LeadershipTable[];

extern u8 AllyStarHitBonus;
extern u8 AllyStarAvoidBonus;

extern u8 EnemyStarHitBonus;
extern u8 EnemyStarAvoidBonus;

extern u8 NPCStarHitBonus;
extern u8 NPCStarAvoidBonus;

extern u8 CancelOutOpposingLeadership;

signed char GetFactionLeadershipCount(u8 faction)
{
	signed char total = 0;
	Unit *unitArray = gUnitArrayBlue;
	int maxUnits = MAX_BLUE_UNITS;
	
	if (faction == FACTION_RED)
	{
		unitArray = gUnitArrayRed;
		maxUnits = MAX_RED_UNITS;
	}
	if (faction == FACTION_GREEN)
	{
		unitArray = gUnitArrayGreen;
		maxUnits = MAX_GREEN_UNITS;		
	}
	
	// go through the unit array for the appropriate faction
	for (int x = 0; x < maxUnits; x++)
	{
		// make sure the unit is alive
		if (unitArray[x].pCharacterData != NULL && !(unitArray[x].state & US_UNAVAILABLE))
		{
			// now check through the leadership table to see if they're on it
			for (int y = 0; LeadershipTable[y].UnitID != 0; y++)
			{
				if (LeadershipTable[y].UnitID == unitArray[x].pCharacterData->number)
				{
					total += LeadershipTable[y].LeadershipStars;
					break; // no need to go through the rest of the leadership table
				}
			}
		}
	}
	
	return total;
}

/*
signed char GetFactionLeadershipCount(u8 faction)
{
	signed char total = 0;
	for (int x = 0; LeadershipTable[x].UnitID != 0; x++)
	{
		Unit *potentialLeader = GetUnitByCharId(LeadershipTable[x].UnitID);
		if (potentialLeader != NULL && !(potentialLeader->state & US_UNAVAILABLE) && faction == UNIT_FACTION(potentialLeader)) // make sure they exist, are on the field and are on the same faction
		{
			total += LeadershipTable[x].LeadershipStars;
		}
	}
	
	return total;
}
*/

void CalculateHitAvoidBonus(BattleUnit* bunit, signed char leadership)
{
	if (UNIT_FACTION(&bunit->unit) == FACTION_BLUE)
	{
		bunit->battleHitRate += leadership * AllyStarHitBonus;
		bunit->battleAvoidRate += leadership * AllyStarAvoidBonus;
	}
	else if (UNIT_FACTION(&bunit->unit) == FACTION_RED)
	{
		bunit->battleHitRate += leadership * EnemyStarHitBonus;
		bunit->battleAvoidRate += leadership * NPCStarAvoidBonus;
	}
	else
	{
		bunit->battleHitRate += leadership * NPCStarHitBonus;
		bunit->battleAvoidRate += leadership * NPCStarAvoidBonus;
	}
}

void ApplyLeadershipBonus(BattleUnit *bunitOne, BattleUnit *bunitTwo)
{
	signed char unitOneLeadership = GetFactionLeadershipCount(UNIT_FACTION(&bunitOne->unit));
	signed char unitTwoLeadership = GetFactionLeadershipCount(UNIT_FACTION(&bunitTwo->unit));
	
	if (CancelOutOpposingLeadership)
		unitOneLeadership -= unitTwoLeadership;
	
	if (unitOneLeadership > 0)
		CalculateHitAvoidBonus(bunitOne, unitOneLeadership);
}

// gets the leadership star count for a single unit
u8 GetLeadershipStarCount(Unit *unit)
{
	for (int x = 0; LeadershipTable[x].UnitID != 0; x++)
	{
		if (unit->pCharacterData->number == LeadershipTable[x].UnitID)
			return LeadershipTable[x].LeadershipStars;
	}
	
	return 0xFF;
}