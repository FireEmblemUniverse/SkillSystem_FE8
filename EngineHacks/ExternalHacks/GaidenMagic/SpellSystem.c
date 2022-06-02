
u8* SpellsGetter(Unit* unit, int type) // Returns a pointer to a list of spells this character can currently use. Type: -1 = All, 1 = black magic, 2 = white magic.
{
	return SpellsGetterForLevel(unit,-1,type);
}

u8* SpellsGetterForLevel(Unit* unit, int level, int type)  // Same as SpellsGetter but filters for a specific level.
{
	// Treat level = -1 as any level equal to or below the unit's current level.
	int unitLevel = unit->level;
	if ( UNIT_ATTRIBUTES(unit) & CA_PROMOTED ) { unitLevel += 80; } // Treat promoted as top bit set.
	u8* currBuffer = SpellsBuffer;
	SpellList* ROMList = SpellListTable[unit->pCharacterData->number];
	if ( ROMList )
	{
		// ROMList is a non-null pointer.
		for ( int i = 0 ; ROMList[i].level ; i++ )
		{
			if ( (level == -1 && unitLevel >= ROMList[i].level) || (level == ROMList[i].level) )
			{
				if ( type == -1 || type == GetSpellType(ROMList[i].spell) )
				{
					// Valid spell found!
					*currBuffer = ROMList[i].spell;
					currBuffer++;
				}
			}
		}
	}
	// Whether or not there were any matching spells (or if the list even existed), we need to terminate the list.
	*currBuffer = 0;
	return SpellsBuffer;
}

/* Intended behavior:
	First, check if we're using the spell menu.
		If so, return the selected spell. Otherwise, vanilla.
	If battle hasn't started yet, vanilla behavior. Return the first usable weapon in inventory.
	If the battle has started...
		If attacking, we already know we're not trying to use a Gaiden spell, so just vanilla.
		If defending, check if there is a usable weapon in inventory we can counter with.
			If so, vanilla. If not, return the first gaiden spell whether it's usable or not.
*/
int NewGetUnitEquippedWeapon(Unit* unit) // Autohook to 0x08016B28.
{
	int vanillaEquipped = GetVanillaEquipped(unit);
	if ( gChapterData.currentPhase == ( unit->index & 0xC0 ) )
	{
		// It is our phase.
		if ( !UsingSpellMenu ) { return vanillaEquipped; }
		else
		{
			// We need to cover the case of using a helpful staff on an ally.
			if ( unit->index == gBattleTarget.unit.index && GetItemType(SelectedSpell) == ITYPE_STAFF )
			{
				return vanillaEquipped;
			} else { return SelectedSpell|0xFF00; }
		}
	}
	else
	{
		// It is not our phase.
		// Well, all the logic is in NewGetUnitEquippedWeaponSlot. Why not get the slot then return that item, checking for case 9 (Gaiden magic)?
		if ( GetUnitEquippedWeaponSlot(unit) == 9 )
		{
			// We're not using the spell menu, but we're still using Gaiden magic. We must be trying to counter with it.
			int spell = GetFirstAttackSpell(unit);
			return ( spell ? spell|0xFF00 : 0 );
		}
		else { return vanillaEquipped; }
	}
}

/*
I'm adding some clarity comments here because the intended behavior here is a little confusing. - Snek
	For the attacker:
		Check to see if we're using the spell menu, and return 9 for using gaiden magic if we can use the selected spell.
	For the defender:
		Check to see whether the defender can retaliate with the standard equipped item (the first weapon in inventory they can use generally).
			If they can, use that.
		If they can NOT retaliate with that weapon (or if there isn't one), return their first attack gaiden spell (so not a staff lol).
			If the defender has insufficient HP, the battle rounds will naturally not occur for them.
*/
int NewGetUnitEquippedWeaponSlot(Unit* unit) // Autohook to 0x08016B58.
{
	 // If we're using the spell menu (AND THIS UNIT IS THE ACTOR, adding this check fixes an edge case bug on retaliation), return using Gaiden magic.
	if ( UsingSpellMenu && unit->index == gBattleActor.unit.index && CanUnitUseWeapon(unit,SelectedSpell) ) { return 9; }
	// This function appears only to be called in simulated and real battes (and on the stat screen)?
	if ( (gBattleStats.config & (BATTLE_CONFIG_REAL|BATTLE_CONFIG_SIMULATE)) && unit->index == gBattleTarget.unit.index )
	{
		int spell = GetFirstAttackSpell(unit);
		
		// If we're here this is a real or simulated batte, and we're the defender. See if we can use what would be the equipped weapon.
		for ( int i = 0 ; i < 5 ; i++ )
		{
			if ( CanUnitUseWeapon(unit,unit->items[i]) )
			{
				// This would be the equipped weapon. If we can't counter with this, then we should return the first Gaiden (attack) spell.
				if ( !gCan_Attack_Target(unit->items[i],gBattleStats.range,unit) )
				{
					return ( spell ? 9 : i );
				}
				else { return i; }
			}
		}
		return ( spell ? 9 : -1 );
	}
	else
	{
		for ( int i = 0 ; i < 5 ; i++ )
		{
			if ( CanUnitUseWeapon(unit,unit->items[i]) ) { return i; }
		}
	}
	return -1;
}

// On return, bit 1 set has weapon use, bit 2 set has staff use. I know this is used for deciding what squares to display in range display.
u32 NewGetUnitUseFlags(Unit* unit) // Autohook to 0x08018B28.
{
	u32 ret = 0;
	for ( int i = 0 ; i < 5 && unit->items[i] ; i++ )
	{
		u32 attributes = GetItemAttributes(unit->items[i]);
		if ( attributes & IA_WEAPON )
		{
			if ( CanUnitUseWeaponNow(unit,unit->items[i]) ) { ret |= 1; }
		}
		else if ( attributes & IA_STAFF )
		{
			if ( CanUnitUseStaffNow(unit,unit->items[i]) ) { ret |= 2; }
		}
	}
	// We've looped through inventory. Let's also loop through Gaiden spells.
	u8* spells = SpellsGetter(unit,-1);
	for ( int i = 0 ; spells[i] ; i++ )
	{
		u32 attributes = GetItemAttributes(spells[i]);
		if ( attributes & IA_WEAPON )
		{
			if ( CanUnitUseWeaponNow(unit,spells[i]) ) { ret |= 1; }
		}
		else if ( attributes & IA_STAFF )
		{
			if ( CanUnitUseStaffNow(unit,spells[i]) ) { ret |= 2; }
		}
	}
	return ret;
}

// Called by the Skill System's proc loop alongside counter skills. If this is a gaiden spell, set the HP drain bit and write how much HP to drain.
void Proc_GaidenMagicHPCost(BattleUnit* attacker, BattleUnit* defender, NewBattleHit* buffer, BattleStats* battleData)
{
	// First, let's check if the attacker is using a (gaiden) spell or if we're defending with Gaiden magic.
	if ( GetUnitEquippedWeaponSlot(&attacker->unit) == 9 ) // Instead of checking against UsingSpellMenu, we do this to cover the case of defense.
	{
		SetRoundForSpell(attacker,buffer);
	}
}

void SetRoundForSpell(BattleUnit* unit, NewBattleHit* buffer)
{
	if ( HasSufficientHP(&unit->unit,unit->weapon) )
	{
		int cost = GetSpellCost(unit->weapon);
		// Let's set the HP depletion bit.
		buffer->attributes |= BATTLE_HIT_ATTR_HPSTEAL; // "HP drain" bit.
		// Now let's subtract the cost from their HP. The check before gurantees they have enough HP to cast right now.
		unit->unit.curHP -= cost;
		buffer->damage -= cost;
	}
	else
	{
		// I think the cleanest way to handle preventing rounds with insufficient HP is to set a bit for later.
		buffer->attributes |= BATTLE_HIT_ATTR_5; // This bit is checked in an external hack I've made.
	}
}

int InitGaidenSpellLearnPopup(void) // Responsible for returning a boolean for whether we should show a "spell learned" popup after battle and for setting it up.
{
	// We should show the popup only if we've reached a level that unlocks a spell.
	// This should happen AFTER a level up, so we leveled up if our previous level != our current level.
	BattleUnit* subject = NULL;
	if ( gBattleActor.levelPrevious != gBattleActor.unit.level ) { subject = &gBattleActor; }
	if ( gBattleTarget.levelPrevious != gBattleTarget.unit.level ) { subject = &gBattleTarget; }
	if ( !subject ) { return 0; } // If this isn't filled, we shouldn't show a popup.
	// Our unit leveled up! Let's see if they have a spell to gain at their new level.
	u8* spells = SpellsGetterForLevel(&subject->unit,subject->unit.level,-1);
	// Eh let's just handle learning one spell at a time for now.
	if ( *spells )
	{
		gPopupItem = *spells|0xFF00;
		return 1;
	} else { return 0; }
}

int HasSufficientHP(Unit* unit, int spell)
{
	// WeaponEXP granted in item data is also the HP cost of the spell.
	return unit->curHP > GetSpellCost(spell);
}

// This function is going to check if we should be able to use this spell NOW. If this is an attack spell, are we in range, etc.
// This does NOT check for HP cost.
int CanCastSpellNow(Unit* unit, int spell)
{
	// This function should do a bit of miscellaneous conditional stuff.
	int type = GetItemType(spell);
	if ( type != ITYPE_STAFF )
	{
		if ( !CanUnitUseWeaponNow(gActiveUnit,spell) ) { return 0; }
		// Next, we can initialize a "dummy" target list and check if it's empty. If not, then there's a valid target we can attack.
		MakeTargetListForWeapon(gActiveUnit,spell);
		return GetTargetListSize() != 0;
	}
	else
	{
		return CanUnitUseItem(gActiveUnit,spell);
	}
}

int CanCastSpell(Unit* unit, int spell) // Same as CanCastSpellNow but calls the functions... without the "Now."
{
	int type = GetItemType(spell);
	if ( type != ITYPE_STAFF )
	{
		if ( !CanUnitUseWeapon(gActiveUnit,spell) ) { return 0; }
		// Next, we can initialize a "dummy" target list and check if it's empty. If not, then there's a valid target we can attack.
		MakeTargetListForWeapon(gActiveUnit,spell);
		return GetTargetListSize() != 0;
	}
	else
	{
		return CanUnitUseItem(gActiveUnit,spell);
	}
}

int CanUseAttackSpellsNow(Unit* unit, int type) // Can the unit use a Gaiden spell now that's an attack?
{
	u8* spells = SpellsGetter(unit,type);
	for ( int i = 0 ; spells[i] ; i++ )
	{
		if ( GetItemType(spells[i]) != ITYPE_STAFF && CanCastSpellNow(unit,spells[i]) )
		{
			return 1;
		}
	}
	return 0;
}

// This should loop through spells that are usable NOW. Basically, a spell should be considered usable if it appears in the spell menu.
// Don't check for HP because those are greyed out with error R-text.
int GetNthUsableSpell(Unit* unit, int n, int type)
{
	u8* spells = SpellsGetter(unit,type);
	int k = -1;
	for ( int i = 0 ; spells[i] ; i++ )
	{
		if ( CanCastSpellNow(unit,spells[i]) )
		{
			k++;
			if ( k == n ) { return i; }
		}
	}
	return -1;
}

static int GetVanillaEquipped(Unit* unit)
{
	for ( int i = 0 ; i < 5 ; i++ )
	{
		if ( CanUnitUseWeapon(unit,unit->items[i]) ) { return unit->items[i]; }
	}
	return 0;
}

int DoesUnitKnowSpell(Unit* unit, u8 spell)
{
	// Is this spell in this unit's spell list?
	u8* spells = SpellsGetter(unit,-1);
	for ( int i = 0 ; spells[i] ; i++ )
	{
		if ( spell == spells[i] ) { return 1; }
	}
	return 0;
}

int GetSpellType(int spell)
{
	int wType = GetItemType(spell);
	if ( wType == ITYPE_ANIMA || wType == ITYPE_DARK ) { return BLACK_MAGIC; }
	else if ( wType == ITYPE_STAFF || wType == ITYPE_LIGHT) { return WHITE_MAGIC; }
	else { return -1; }
}

int GetSpellCost(int spell)
{
	return GaidenSpellCostTable[GetItemIndex(spell)];
}

int GetFirstAttackSpell(Unit* unit)
{
	u8* spells = SpellsGetter(unit,-1);
	int spell = 0;
	for ( int i = 0 ; spells[i] ; i++ )
	{
		if ( GetItemType(spells[i]) != ITYPE_STAFF ) { spell = spells[i]; break; } // Ensure that the spell we could counter with would be an attack spell.
	}
	return spell;
}

void Target_Routine_For_Fortify(BattleUnit* unit)
{
	u16 item = 0;
	if ( UsingSpellMenu )
	{
		item = SelectedSpell|0xFF00;
	}
	else
	{
		item = unit->unit.items[gActionData.itemSlotIndex];
	}
	gHealStaff_RangeSetup(unit,0,item);
}

void GaidenZeroOutSpellVariables(void)
{
	UsingSpellMenu = 0;
	SelectedSpell = 0;
	DidSelectSpell = 0;
}
