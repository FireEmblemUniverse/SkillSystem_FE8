
static void CreatorBoonBaneDraw(CreatorProc* proc)
{
	Unit* unit = proc->mainUnit;
	const CharacterData* charData = unit->pCharacterData;
	
	ApplyBGBox(gBG1MapBuffer,&gCreatorBoonBaneBoxTSA,10,1);
	
	// Draw the unit's constant base stats and growths.
	DrawUiNumber(&gBG0MapBuffer[4][13],TEXT_COLOR_GOLD,unit->maxHP);
	if ( proc->route != Mage )
	{
		DrawUiNumber(&gBG0MapBuffer[6][13],TEXT_COLOR_GOLD,unit->pow);
	}
	else
	{
		DrawUiNumber(&gBG0MapBuffer[6][13],TEXT_COLOR_GOLD,unit->unk3A); // Magic.
	}
	DrawUiNumber(&gBG0MapBuffer[8][13],TEXT_COLOR_GOLD,unit->skl);
	DrawUiNumber(&gBG0MapBuffer[10][13],TEXT_COLOR_GOLD,unit->spd);
	DrawUiNumber(&gBG0MapBuffer[12][13],TEXT_COLOR_GOLD,unit->def);
	DrawUiNumber(&gBG0MapBuffer[14][13],TEXT_COLOR_GOLD,unit->res);
	DrawUiNumber(&gBG0MapBuffer[16][13],TEXT_COLOR_GOLD,unit->lck);
	
	DrawUiNumber(&gBG0MapBuffer[4][21],TEXT_COLOR_GOLD,charData->growthHP);
	if ( proc->route != Mage )
	{
		DrawUiNumber(&gBG0MapBuffer[6][21],TEXT_COLOR_GOLD,charData->growthPow);
	}
	else
	{
		DrawUiNumber(&gBG0MapBuffer[6][21],TEXT_COLOR_GOLD,MagCharTable[charData->number].growth); // Magic.
	}
	DrawUiNumber(&gBG0MapBuffer[8][21],TEXT_COLOR_GOLD,charData->growthSkl);
	DrawUiNumber(&gBG0MapBuffer[10][21],TEXT_COLOR_GOLD,charData->growthSpd);
	DrawUiNumber(&gBG0MapBuffer[12][21],TEXT_COLOR_GOLD,charData->growthDef);
	DrawUiNumber(&gBG0MapBuffer[14][21],TEXT_COLOR_GOLD,charData->growthRes);
	DrawUiNumber(&gBG0MapBuffer[16][21],TEXT_COLOR_GOLD,charData->growthLck);
	
	int tile = 0;
	TextHandle baseHandle =	{
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 4
	};
	tile += 4;
	Text_Clear(&baseHandle);
	Text_SetColorId(&baseHandle,TEXT_COLOR_GOLD);
	Text_InsertString(&baseHandle,0,TEXT_COLOR_GOLD,"Base");
	Text_Display(&baseHandle,&gBG0MapBuffer[2][13]);
	
	TextHandle growthHandle = {
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 4
	};
	tile += 4;
	Text_Clear(&growthHandle);
	Text_SetColorId(&growthHandle,TEXT_COLOR_GOLD);
	Text_InsertString(&growthHandle,0,TEXT_COLOR_GOLD,"Growth");
	Text_Display(&growthHandle,&gBG0MapBuffer[2][21]);
	
	proc->boonBaneTileLast = tile; // Store the tile we left off at for our switch in routine.
	
	EnableBgSyncByMask(1);
	EnableBgSyncByMask(2);
}

void CreatorBoonBaneSwitchIn(MenuProc* proc, MenuCommandProc* commandProc)
{
	BgMapFillRect(&gBG0MapBuffer[4][14],4,20-4,0);
	BgMapFillRect(&gBG0MapBuffer[4][22],4,20-4,0);
	CreatorProc* creator = (CreatorProc*)ProcFind(&gCreatorProc);
	int tile = creator->boonBaneTileLast;
	char eff[4]; // Effect string we're going to pass in to the drawing routines.
	int color = 0;
	if ( creator->currMenu == BoonMenu ) { eff[0] = '+'; color = TEXT_COLOR_GREEN; } else { eff[0] = '-'; color = TEXT_COLOR_GREY; }
	
	// We want to draw the current bane effect. First let's draw the base effect.
	int base = gCreatorBoonBaneEffects[commandProc->commandDefinitionIndex+1].base;
	FillNumString(&eff[1],base);
	
	TextHandle mainBaseHandle =	{
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 4
	};
	tile += 4;
	Text_Clear(&mainBaseHandle);
	Text_InsertString(&mainBaseHandle,0,color,eff);
	Text_Display(&mainBaseHandle,&gBG0MapBuffer[4+proc->commandIndex*2][15]);
	
	// Now let's draw the growth.
	int growth = gCreatorBoonBaneEffects[commandProc->commandDefinitionIndex+1].growth;
	FillNumString(&eff[1],growth);
	
	TextHandle mainGrowthHandle = {
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 4
	};
	tile += 4;
	Text_Clear(&mainGrowthHandle);
	Text_InsertString(&mainGrowthHandle,0,color,eff);
	Text_Display(&mainGrowthHandle,&gBG0MapBuffer[4+proc->commandIndex*2][23]);
	
	int offset = -1;
	if ( creator->currMenu == BoonMenu )
	{
		if ( creator->bane )
		{
			eff[0] = '-';
			offset = creator->bane-1; // Store our gCreatorBoonBaneEffects offset and use it to check if we're looking the "other" boon/bane.
			color = TEXT_COLOR_GREY;
		}
	}
	else // if ( creator->currMenu == BaneMenu )
	{
		if ( creator->boon )
		{
			eff[0] = '+';
			offset = creator->boon-1;
			color = TEXT_COLOR_GREEN;
		}
	}
	if ( offset != -1 && offset != commandProc->commandDefinitionIndex )
	{
		// If they've selected a bane/boon (and we're not on its index), let's display that too.
		base = gCreatorBoonBaneEffects[offset+1].base;
		growth = gCreatorBoonBaneEffects[offset+1].growth;
		if ( offset+1 >= Mag ) { offset -= 1; } // We're either not displaying strength or magic. Decrement the location we'll draw to to account for that.
		
		FillNumString(&eff[1],base);
		
		TextHandle otherBaseHandle = {
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 4
		};
		tile += 4;
		Text_Clear(&otherBaseHandle);
		Text_InsertString(&otherBaseHandle,0,color,eff);
		Text_Display(&otherBaseHandle,&gBG0MapBuffer[4+offset*2][15]);
		
		FillNumString(&eff[1],growth);
		
		TextHandle otherGrowthHandle = {
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 4
		};
		tile += 4;
		Text_Clear(&otherGrowthHandle);
		Text_InsertString(&otherGrowthHandle,0,color,eff);
		Text_Display(&otherGrowthHandle,&gBG0MapBuffer[4+offset*2][23]);
	}
	
	EnableBgSyncByMask(1);
}



 // Apply the boon and bane stat effects.
static void ApplyBoonBane(CreatorProc* proc)
{
	// Applying the base effect is simple: just edit the unit's current stats.
	int boonBase = gCreatorBoonBaneEffects[proc->boon].base;
	int baneBase = gCreatorBoonBaneEffects[proc->bane].base;
	Unit* unit = proc->mainUnit;
	switch ( proc->boon )
	{
		case HP: unit->maxHP += boonBase; break;
		case Str: unit->pow += boonBase; break;
		case Mag: unit->unk3A += boonBase; break;
		case Skl: unit->skl += boonBase; break;
		case Spd: unit->spd += boonBase; break;
		case Def: unit->def += boonBase; break;
		case Res: unit->res += boonBase; break;
		case Luk: unit->lck += boonBase; break;
	}
	switch ( proc->bane )
	{
		case HP: unit->maxHP = ( unit->maxHP > baneBase ? unit->maxHP - baneBase : 1 ); break;
		case Str: unit->pow = ( unit->pow >= baneBase ? unit->pow - baneBase : 0 ); break;
		case Mag: unit->unk3A = ( unit->unk3A >= baneBase ? unit->unk3A - baneBase : 0 ); break;
		case Skl: unit->skl = ( unit->skl >= baneBase ? unit->skl - baneBase : 0 ); break;
		case Spd: unit->spd = ( unit->spd >= baneBase ? unit->spd - baneBase : 0 ); break;
		case Def: unit->def = ( unit->def >= baneBase ? unit->def - baneBase : 0 ); break;
		case Res: unit->res = ( unit->res >= baneBase ? unit->res - baneBase : 0 ); break;
		case Luk: unit->lck = ( unit->lck >= baneBase ? unit->lck - baneBase : 0 ); break;
	}
	UnitCheckStatCaps(unit); // Ensures no overflow but not underflow!
	
	//gChapterData.boonGrowthID = proc->boon; // Store the boon and bane IDs for later. Clipped off a bit of Tact name for this.
	//gChapterData.baneGrowthID = proc->bane;
}

int CreatorApplyBoonBaneGrowth(CharacterData** character, int growth, int growthID)
{
	// if ( (*character)->number == GetUnit(1)->pCharacterData->number ) // Only apply to the leader (who should ALWAYS be in the first character struct!)
	// {
		// int stat = GrowthIDToBoonBane(growthID);
		// int boon = gChapterData.boonGrowthID;
		// int bane = gChapterData.baneGrowthID;
		// if ( stat == boon ) { return growth + gCreatorBoonBaneEffects[boon].growth; }
		// if ( stat == bane ) { return growth - gCreatorBoonBaneEffects[bane].growth; }
	// }
	return growth;
}

static int GrowthIDToBoonBane(int growthID)
{
	for ( int i = 0 ; gCreatorGrowthIDLookup[i].growthID ; i++ )
	{
		if ( gCreatorGrowthIDLookup[i].growthID == growthID ) { return gCreatorGrowthIDLookup[i].stat; }
	}
	return 0;
}
