
void CreatorClassDrawUIBox(CreatorClassProc* proc)
{
	ApplyBGBox(gBG1MapBuffer,&gCreatorClassUIBoxTSA,0,12);
	EnableBgSyncByMask(2);
}

void CreatorClassStartPlatform(CreatorClassProc* proc) // At this point, CreatorActivateClassDisplay has been called.
{
	CreatorProc* creator = (CreatorProc*)ProcFind(&gCreatorProc);
	if ( creator->route == Mercenary ) { proc->platformType = GrassPlatform; }
	else if ( creator->route == Military ) { proc->platformType = RoadPlatform; }
	else if ( creator->route == Mage ) { proc->platformType = SandPlatform; }
	else { proc->platformType = GrassPlatform; }
	proc->mode = 1;
	for ( int i = 0 ; i < 5 ; i++ ) { proc->classes[i] = creator->currSet->list[i].class; }
	proc->menuItem = creator->lastClassIndex;
	proc->charID = creator->tempUnit->pCharacterData->number;
	SetupMovingPlatform(0,-1,0x1F6,0x58,6);
	StartMovingPlatform(proc->platformType,0x118,gCreatorPlatformHeight);
}

void CreatorActivateClassDisplay(MenuProc* proc, MenuCommandProc* commandProc)
{
	CPU_FILL(0,(char*)&gBG0MapBuffer[15][7]-1,&gBG0MapBuffer[32][32]-&gBG0MapBuffer[15][7],32);
	CreatorProc* creator = (CreatorProc*)ProcFind(&gCreatorProc);
	// Let's load the unit that corresponds to the currently selected item.
	
	Unit* unit = LoadCreatorUnit(creator,commandProc->commandDefinitionIndex);
	if ( unit->index != 2 )
	{
		// We've loaded into a different index than we want. Copy this unit into unit slot 2.
		Unit* dest = GetUnit(2);
		CopyUnit(unit,dest);
		ClearUnit(unit);
		unit = dest;
	}
	const CharacterData* charData = unit->pCharacterData;
	creator->tempUnit = unit;
	
	int iconX = 12;
	for ( int i = 0 ; i < 8 ; i++ )
	{
		if ( unit->ranks[i] )
		{
			DrawIcon(&gBG0MapBuffer[1][iconX],0x70+i,0x5000);
			iconX += 2;
		}
	}
	
	gSkillGetterCurrUnit = NULL; // This appears to be for optimization of getting a list of skills for a unit, but here it gets confused since we're so rapidly loading/clearing.
	u8* skillList = SkillGetter(unit);
	iconX = 20;
	int c = 0;
	while ( skillList[c] )
	{
		DrawSkillIcon(&gBG0MapBuffer[1][iconX],skillList[c],0x4000);
		c++;
		iconX += 2;
	}
	// Now I'd like to draw this unit's stats near the bottom of the screen.
	
	DrawUiNumber(&gBG0MapBuffer[15][8],TEXT_COLOR_GOLD,unit->maxHP);
	DrawUiNumber(&gBG0MapBuffer[15][11],TEXT_COLOR_GOLD,unit->pow);
	DrawUiNumber(&gBG0MapBuffer[15][14],TEXT_COLOR_GOLD,unit->unk3A); // Magic.
	DrawUiNumber(&gBG0MapBuffer[15][17],TEXT_COLOR_GOLD,unit->skl);
	DrawUiNumber(&gBG0MapBuffer[15][20],TEXT_COLOR_GOLD,unit->spd);
	DrawUiNumber(&gBG0MapBuffer[15][23],TEXT_COLOR_GOLD,unit->def);
	DrawUiNumber(&gBG0MapBuffer[15][26],TEXT_COLOR_GOLD,unit->res);
	
	DrawUiNumber(&gBG0MapBuffer[17][8],TEXT_COLOR_GOLD,charData->growthHP);
	DrawUiNumber(&gBG0MapBuffer[17][11],TEXT_COLOR_GOLD,charData->growthPow);
	DrawUiNumber(&gBG0MapBuffer[17][14],TEXT_COLOR_GOLD,MagCharTable[charData->number].growth);
	DrawUiNumber(&gBG0MapBuffer[17][17],TEXT_COLOR_GOLD,charData->growthSkl);
	DrawUiNumber(&gBG0MapBuffer[17][20],TEXT_COLOR_GOLD,charData->growthSpd);
	DrawUiNumber(&gBG0MapBuffer[17][23],TEXT_COLOR_GOLD,charData->growthDef);
	DrawUiNumber(&gBG0MapBuffer[17][26],TEXT_COLOR_GOLD,charData->growthRes);
	int tile = 0;
	TextHandle baseHandle =	{
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 4
	};
	tile += 4;
	Text_Clear(&baseHandle);
	Text_SetColorId(&baseHandle,TEXT_COLOR_GOLD);
	Text_InsertString(&baseHandle,0,TEXT_COLOR_GOLD,"Base");
	Text_Display(&baseHandle,&gBG0MapBuffer[15][2]);
	
	TextHandle growthHandle = {
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 4
	};
	tile += 4;
	Text_Clear(&growthHandle);
	Text_SetColorId(&growthHandle,TEXT_COLOR_GOLD);
	Text_InsertString(&growthHandle,0,TEXT_COLOR_GOLD,"Growth");
	Text_Display(&growthHandle,&gBG0MapBuffer[17][2]);
	
	TextHandle hpHandle = {
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 2
	};
	tile += 2;
	DrawStatNames(hpHandle,"HP",7,13);
	
	TextHandle strHandle = {
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 3
	};
	tile += 3;
	DrawStatNames(strHandle,"Str",10,13);
	
	TextHandle magHandle = {
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 3
	};
	tile += 3;
	DrawStatNames(magHandle,"Mag",13,13);
	
	TextHandle sklHandle = {
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 3
	};
	tile += 3;
	DrawStatNames(sklHandle,"Skl",16,13);
	
	TextHandle spdHandle = {
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 3
	};
	tile += 3;
	DrawStatNames(spdHandle,"Spd",19,13);
	
	TextHandle defHandle = {
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 3
	};
	tile += 3;
	DrawStatNames(defHandle,"Def",22,13);
	
	TextHandle resHandle = {
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 3
	};
	tile += 3;
	DrawStatNames(resHandle,"Res",25,13);
	
	EnableBgSyncByMask(1);
	
	CreatorClassProc* classProc = (CreatorClassProc*)ProcFind(&gCreatorClassProc);
	if ( !classProc ) { ProcStart(&gCreatorClassProc,(Proc*)creator); } // If the creator class proc doesn't exist yet, make one.
	else
	{
		// Otherwise, update relevant fields.
		classProc->mode = 1;
		for ( int i = 0 ; i < 5 ; i++ ) { classProc->classes[i] = creator->currSet->list[i].class; }
		classProc->menuItem = commandProc->commandDefinitionIndex;
		classProc->charID = creator->tempUnit->pCharacterData->number;
	}
}

void CreatorRetractClassDisplay(MenuProc* proc, MenuCommandProc* commandProc)
{
	BgMapFillRect(&gBG0MapBuffer[1][12],30-12,2,0);
	ClearIcons();
	CreatorProc* creator = (CreatorProc*)ProcFind(&gCreatorProc);
	if ( creator->tempUnit ) { ClearUnit(creator->tempUnit); creator->tempUnit = NULL; }
	CreatorClassProc* classProc = (CreatorClassProc*)ProcFind(&gCreatorClassProc);
	if ( classProc ) { classProc->mode = 1; }
}

int CreatorWaitForSlideOut(CreatorProc* proc) // This is a PROC_WHILE_ROUTINE - return 1 if we want to yield.
{
	return gAISArray.xPosition != 320;
}

void CreatorClassEndProc(CreatorClassProc* proc)
{
	CPU_FILL(0,(char*)&gBG0MapBuffer[13][0]-1,(32-13)*32*2,32);
	DeleteSomeAISStuff(&gSomeAISStruct);
	DeleteSomeAISProcs(&gSomeAISRelatedStruct);
	EndEkrAnimeDrvProc();
	//UnlockGameGraphicsLogic();
	//RefreshEntityMaps();
	//DrawTileGraphics();
	SMS_UpdateFromGameData();
	MU_EndAll();
}

static ClassMenuSet* GetClassSet(int gender,int route)
{
	for ( int i = 0 ; i < 6 ; i++ )
	{
		if ( gClassMenuOptions[i].gender == gender && gClassMenuOptions[i].route == route )
		{
			return &gClassMenuOptions[i];
		}
	}
	return NULL; // This should never happen, but return null if no entry is found.
}

static Unit* LoadCreatorUnit(CreatorProc* creator, int index)
{
	UnitDefinition definition =
	{
		.charIndex = creator->currSet->list[index].character,
		.classIndex = creator->currSet->list[index].class,
		.autolevel = 1,
		.allegiance = UA_BLUE,
		.level = 5,
		.xPosition = 63,
		.yPosition = 0,
		.items[0] = GetAppropriateItem(creator->currSet->list[index].class),
		.items[1] = gCreatorVulnerary
	};
	// Friendly reminder that we want to keep this unit in unit slot 2!
	Unit* newUnit = LoadUnit(&definition);
	return newUnit;
}

static int GetAppropriateItem(int class) // Return the item ID that this class should use.
{
	const ClassData* data = GetClassData(class);
	int firstRank = 0;
	for ( int i = 0 ; i < 8 ; i++ )
	{
		if ( data->baseRanks[i] ) { firstRank = i; break; }
	}
	// firstRank is the first weapon rank that this class can use at base.
	return gCreatorAppropriateItemArray[firstRank];
}
