
// We need to change this FE8-Item Range Fix function to include checking Gaiden magic.
	// Slot is the inventory slot to check. -1 is check all slots, and 9 can represent just for Gaiden magic. Why don't we let -2 mean only loop through items in inventory?
// Wow this function actually is supposed to return a value in r1.
	// Return the range bitfield (range mask) in r0 and the min/max halfword in r1.
	// The min/max halfword only really appears to apply to special ranges not even including seige tomes?
	// Jesus christ this return scheme aaaaaaaaa. This is a way to "trick" the compiler into returning into r1.
long long Return_Range_Bitfield(Unit* unit, int slot, int(*usability)(Unit* unit, int item))
{
	long long current = 0;
	if ( slot == -1 || slot == -2 )
	{
		// Loop through all items.
		for ( int i = 0 ; i < 5 && unit->items[i] ; i++ )
		{
			if ( usability(unit,unit->items[i]) )
			{
				current = IncorporateNewRange(current,gGet_Item_Range(unit,unit->items[i]));
			}
		}
		return ( slot == -1 ? IncorporateNewRange(current,GetUnitRangeMaskForSpells(unit,usability)) : current );
	}
	else
	{
		// Get for this specific slot.
		if ( slot != 9 )
		{
			return gGet_Item_Range(unit,unit->items[slot]);
		}
		else
		{
			// Specifically return all the Gaiden magic that's usable.
			return GetUnitRangeMaskForSpells(unit,usability);
		}
	}
}

// r0 = mask, r1 = minmax. See ReturnRangeBitfield.
long long GetUnitRangeMaskForSpells(Unit* unit, int(*usability)(Unit* unit, int item))
{
	long long current = 0;
	u8* spells = SpellsGetter(unit,(UsingSpellMenu ? UsingSpellMenu : -1)); // If UsingSpellMenu is nonzero, only get Gaiden spells of that type.
	for ( int i = 0 ; spells[i] ; i++ )
	{
		int spell = spells[i]|0xFF00;
		if ( usability == NULL )
		{
			if ( CanCastSpell(unit,spell) ) { current = IncorporateNewRange(current,gGet_Item_Range(unit,spell)); }
		}
		else
		{
			if ( usability(unit,spell) ) { current = IncorporateNewRange(current,gGet_Item_Range(unit,spell)); }
		}
	}
	return current;
}

static long long IncorporateNewRange(long long existing, long long new)
{
	u32 existingMask = existing & 0xFFFFFFFF;
	u32 newMask = new & 0xFFFFFFFF;
	long long existingMin = existing >> 40;
	long long newMin = new >> 40;
	long long existingMax = (existing >> 32) & 0xFF;
	long long newMax = (new >> 32) & 0xFF;
	return existingMask|newMask|(( newMin < existingMin ? newMin : existingMin ) << 40)|(( newMax > existingMax ? newMax : existingMax ) << 32);
}

int RangeUsabilityCheckStaff(Unit* unit, int item)
{
	// On top of being able to cast the spell, only return true if this is also a staff.
	return GetItemType(item) == ITYPE_STAFF && CanCastSpell(unit,item);
}

int RangeUsabilityCheckNotStaff(Unit* unit, int item)
{
	return GetItemType(item) != ITYPE_STAFF && CanCastSpell(unit,item);
}

void All_Spells_One_Square(Unit* unit, int(*usability)(Unit* unit, int item))
{
	asm("push { r7 }");
	long long mask = Return_Range_Bitfield(unit,9,usability);
	asm("mov r7, #0x00\nmov r12, r7"); // Write_Range takes this parameter through r12?
	gWrite_Range(unit->xPos,unit->yPos,mask);
	asm("pop { r7 }");
}
