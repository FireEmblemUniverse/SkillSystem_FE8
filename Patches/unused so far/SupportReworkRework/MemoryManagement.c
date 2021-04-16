
static int GetSupportLevel(Unit* unit, int supporting) // Gets the support level (0-7) of this support. 0xFF is none exists.
{
	int loc = FindSupport(unit,supporting);
	if ( loc == 0xFF ) { return 0xFF; } // No support found.
	int levels = unit->supportLevels;
	levels >>= (3*loc);
	return levels & 7; // Isolated level.
}

static int FindSupport(Unit* unit, int supporting) // Gets the index of this suppport for unit. 0xFF if none exists.
{
	for ( int i = 0 ; i < 5 ; i++ )
	{
		if ( unit->supports[i] == supporting ) { return i; }
	}
	return 0xFF;
}

static int AddSupport(Unit* unit, int supporting) // Create a new support for both characters. Creates level of 0.
{
	if ( FindSupport(unit,supporting) != 0xFF ) { return 0; } // They already have a support!
	int thisCharID = ToCharID(unit);
	Unit* otherUnit = ToUnit(supporting);
	if ( CountSupports(unit) == 5 || CountSupports(otherUnit) == 5 ) { return 0; } // At least one of the characters has full supports.
	for ( int i = 0 ; ; i++ ) // No need for a condition because both characters are already guranteed to have ample room.
	{
		if ( unit->supports[i] == 0 )
		{
			unit->supports[i] = supporting;
			SetSupport(unit,supporting,0);
			break;
		}
	}
	for ( int i = 0 ; ; i++ )
	{
		if ( otherUnit->supports[i] == 0 )
		{
			otherUnit->supports[i] = thisCharID;
			return SetSupport(otherUnit,thisCharID,0);
		}
	}
}

static int SetSupport(Unit* unit, int supporting, int level) // Sets the support level of a support for both units. No effect if the support isn't found.
{
	int thisCharID = ToCharID(unit);
	Unit* otherUnit = ToUnit(supporting);
	if ( level < 0 || level > MaxSupportLevel ) { return 0; } // Ensure the level passed in is within the valid range.
	int loc1 = FindSupport(unit,supporting);
	if ( loc1 == 0xFF )
	{
		// No support exists yet. Let's add one.
		if ( !AddSupport(unit,supporting) ) { return 0; } // Adding a support failed.
		loc1 = FindSupport(unit,supporting);
	}
	int loc2 = FindSupport(otherUnit,thisCharID);
	
	unit->supportLevels &= ~(7<<(loc1*3)); // Clear the levels. This should be equivalent to bic.
	otherUnit->supportLevels &= ~(7<<(loc2*3));
	
	unit->supportLevels |= level << (loc1*3);
	otherUnit->supportLevels |= level << (loc2*3);
	return 1;
}

static int IncreaseSupport(Unit* unit, int supporting) // Increase the support level of an existing support or create a new one for both characters.
{
	Unit* supportingUnit = ToUnit(supporting);
	int thisChar = ToCharID(unit);
	if ( FindSupport(unit,supporting) != 0xFF )
	{
		// A support already exists.
		int level = GetSupportLevel(supportingUnit,thisChar)+1;
		if ( level < 0 || level > MaxSupportLevel ) { return 0; } // Check the second first to ensure no valid changes are made to the first.
		if ( !SetSupport(unit,supporting,level) ) { return 0; }; // Immediately exit false if the first failed.
		SetSupport(supportingUnit,thisChar,level);
		return 1;
	}
	else
	{
		// No support exists.
		return AddSupport(unit,supporting); // This already checks for if each has max supports.
	}
}

static int ClearSupport(Unit* unit, int supporting) // Clear the support characters and levels for both units.
{
	Unit* supportingUnit = ToUnit(supporting);
	int thisChar = ToCharID(unit);
	int loc1 = FindSupport(unit,supporting);
	int loc2 = FindSupport(supportingUnit,thisChar);
	if ( loc1 == 0xFF || loc2 == 0xFF ) { return 0; } // It should be sufficient to check only one character for support not found but eh may as well be thourough.
	unit->supports[loc1] = 0; // Clear the characters.
	supportingUnit->supports[loc2] = 0;
	unit->supportLevels &= ~(7<<(loc1*3)); // Clear the levels. This should be equivalent to bic.
	supportingUnit->supportLevels &= ~(7<<(loc2*3));
	return 1;
}

static int CountSupports(Unit* unit) // Self-explanitory.
{
	if ( unit->index >> 6 ) { return 0; } // If not player, no supports.
	int count = 0;
	for ( int i = 0 ; i < 5 ; i++ )
	{
		if ( unit->supports[i] ) { count++; }
	}
	return count;
}

static int CanUnitsSupport(Unit* unit, int otherChar, int level) // Level of 0xFF = undefined level.
{
	Unit* otherUnit = ToUnit(otherChar);
	if ( !unit || !otherUnit || (unit->state & US_DEAD) || (otherUnit->state & US_DEAD) ) { return 0; } // Return unusable unless both units exist and are not dead.
	if ( (unit->index&0xC0) != UA_BLUE || (otherUnit->index&0xC0) != UA_BLUE ) { return 0; }
	if ( level == 0xFF ) { level = GetSupportLevel(unit,otherChar)+1; }
	if ( level == 0 )
	{
		// Let's see if they can add a support.
		return CountSupports(unit) < 5 && CountSupports(otherUnit) < 5 && FindSupport(unit,otherChar) == 0xFF;
	}
	else
	{
		// Let's see if they can increase their support level to this level.
		return level > 0 && level <= MaxSupportLevel && GetSupportLevel(unit,otherChar) == level-1;
	}
}

static int GetNthValidSupport(Unit* unit, int n) // Used for the stat screen R text.
{
	for ( int i = 0 ; i < 5 ; i++ )
	{
		if ( unit->supports[i] )
		{
			if ( !n ) { return i; }
			n--;
		}
	}
	return 0xFF; // nth valid support doesn't exist.
}

// These 2 functions are for use with 0xFF representing the first character struct.
static Unit* ToUnit(int charID)
{
	if ( charID == 0xFF) { return GetUnit(1); }
	else { return GetUnitByCharId(charID); }
}

static int ToCharID(Unit* unit)
{
	if ( unit == GetUnit(1) ) { return 0xFF; }
	else { return unit->pCharacterData->number; }
}
