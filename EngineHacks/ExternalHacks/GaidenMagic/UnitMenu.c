
/* Intended behavior:
	Return 1 if there is any spell that is usable with enough HP to cast it with a valid target.
	Return 2 if there is at least 1 usable spell, but there isn't enough HP to cast any usable spells.
	Return 3 if there are no spells with valid targets. */
int GaidenBlackMagicUMUsability(void) // It's kinda weird that usability is void, but the other UM functions get the menu proc passed in...
{
	return GaidenMagicUMUsabilityExt(SpellsGetter(gActiveUnit,BLACK_MAGIC)); // This is a 0-terminated list of spells this character has learned.
}

int GaidenWhiteMagicUMUsability(void)
{
	return GaidenMagicUMUsabilityExt(SpellsGetter(gActiveUnit,WHITE_MAGIC));
}

static int GaidenMagicUMUsabilityExt(u8* spellList)
{
	u8* validList = gGenericBuffer; // Let's build a list of valid spells.
	for ( int i = 0 ; spellList[i] ; i++ )
	{	
		if ( !CanCastSpellNow(gActiveUnit,spellList[i]|0xFF00) ) { continue; }
		*validList = spellList[i];
		validList++;
	}
	*validList = 0;
	// At this point, validList has a 0-terminated list of spells that we can use NOW (aside from HP costs).
	validList = gGenericBuffer;
	if ( !*validList ) { return 3; } // Return unusable if there are no valid spells.
	for ( int i = 0 ; validList[i] ; i++ )
	{
		// Now let's loop through all valid spells and see if there are ANY that we can cast given our current HP.
		if ( HasSufficientHP(gActiveUnit,validList[i]) ) { return 1; } // We've found a spell we can cast! Return usable.
	}
	return 2; // There were valid spells, but we don't have enough HP to cast any of them. Return greyed out.
}

int GaidenBlackMagicUMEffect(MenuProc* proc, MenuCommandProc* commandProc)
{
	UsingSpellMenu = BLACK_MAGIC;
	return GaidenMagicUMEffectExt(SpellsGetter(gActiveUnit,BLACK_MAGIC),proc,commandProc);
}

int GaidenWhiteMagicUMEffect(MenuProc* proc, MenuCommandProc* commandProc)
{
	UsingSpellMenu = WHITE_MAGIC;
	return GaidenMagicUMEffectExt(SpellsGetter(gActiveUnit,WHITE_MAGIC),proc,commandProc);
}

int GaidenMagicUMEffectExt(u8* spellsList, MenuProc* proc, MenuCommandProc* commandProc)
{
	if ( proc && commandProc->availability == 2 )
	{
		// Option is greyed out. Error R-text!
		MenuCallHelpBox(proc,gGaidenMagicUMErrorText);
		return 0x08;
	}	
	else
	{
		_ResetIconGraphics();
		SelectedSpell = spellsList[0];
		LoadIconPalettes(4);
		MenuProc* menu = StartMenu(&SpellSelectMenuDefs);
		// We're going to load a face now. I'm going to leave out the hardcoded check for the phantom (for now at least).
		StartFace(0,GetUnitPortraitId(gActiveUnit),0xB0,0xC,2);
		SetFaceBlinkControlById(0,5);
		ForceMenuItemPanel(menu,gActiveUnit,15,11);
		return 0x17;
	}
}

int GaidenBlackMagicUMHover(MenuProc* proc)
{
	UsingSpellMenu = BLACK_MAGIC;
	BmMapFill(gMapMovement,-1);
	BmMapFill(gMapRange,0);
	if ( CanUseAttackSpellsNow(gActiveUnit,BLACK_MAGIC) ) // If we can use an attack spell now, display the red range.
	{
		All_Spells_One_Square(gActiveUnit,&RangeUsabilityCheckNotStaff);
		DisplayMoveRangeGraphics(3);
	}
	else
	{
		All_Spells_One_Square(gActiveUnit,&RangeUsabilityCheckStaff);
		DisplayMoveRangeGraphics(5);
	}
	// Bit 1 copies the blue palette to the palette buffer. Bit 2 copies the red palette. Bit 3 copies the green palette.
	// Not having the bottom bit set seems to have problems clearing the squares?
	// Seems the blue palette is always in buffer 4+2, the red and green palettes are always in buffer 4+22.
	return 0;
}

int GaidenWhiteMagicUMHover(MenuProc* proc)
{
	UsingSpellMenu = WHITE_MAGIC;
	BmMapFill(gMapMovement,-1);
	BmMapFill(gMapRange,0);
	if ( CanUseAttackSpellsNow(gActiveUnit,WHITE_MAGIC) ) // If we can use an attack spell now, display the red range.
	{
		All_Spells_One_Square(gActiveUnit,&RangeUsabilityCheckNotStaff);
		DisplayMoveRangeGraphics(3);
	}
	else
	{
		All_Spells_One_Square(gActiveUnit,&RangeUsabilityCheckStaff);
		DisplayMoveRangeGraphics(5);
	}
	return 0;
}

int GaidenMagicUMUnhover(MenuProc* proc)
{
	if ( !SelectedSpell ) { UsingSpellMenu = 0; } // Don't unset this if we're going to the spell menu.
	HideMoveRangeGraphics();
	return 0;
}
