
// This follows those weird menu usability return values. 1 = usable, 2 = grey, 3 = unsuable.
int SpellUsability(const struct MenuCommandDefinition* menuEntry, int index, int idk)
{
	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,index,UsingSpellMenu)];
	if ( !spell ) { return 3; }
	// This option should be usable if the nth spell exists.
	if ( !CanCastSpellNow(gActiveUnit,spell) ) { return 3; }
	// Now, let's grey out the spell if we don't have the HP to cast it.
	return ( HasSufficientHP(gActiveUnit,spell) ? 1 : 2 );
}

int SpellDrawingRoutine(MenuProc* menu, MenuCommandProc* menuCommand)
{
	// extern void DrawItemMenuCommand(TextHandle* textHandle, u16 item, int canUse, u16* buffer);
	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,menuCommand->commandDefinitionIndex,UsingSpellMenu)];
	// At this point, the spell should be guranteed to exist. Let's check to see if we have the HP to cast the spell (and the weapon rank).
	int canUse = HasSufficientHP(gActiveUnit,spell);
	DrawItemMenuCommand(&menuCommand->text,spell,canUse,&gBg0MapBuffer[menuCommand->yDrawTile * 32 + menuCommand->xDrawTile]);
	EnableBgSyncByMask(1);
	return 0;
}

int MagicMenuBPress(void)
{
	FillBgMap(gBg2MapBuffer,0);
	EnableBgSyncByMask(4);
	Text_ResetTileAllocation();
	// Refer to the Skill System's repointed unit menu.
	StartMenu_AndDoSomethingCommands(&gMenu_UnitMenu,gGameState._unk1C.x - gGameState.cameraRealPos.x,1,16);
	HideMoveRangeGraphics();
	SelectedSpell = 0;
	UsingSpellMenu = 0;
	return 0x3B;
}

int SpellEffectRoutine(MenuProc* proc, MenuCommandProc* commandProc)
{
	if ( commandProc->availability == 2)
	{
		// Option is greyed out. Error R-text!
		MenuCallHelpBox(proc,gGaidenMagicSpellMenuErrorText);
		return 0x08;
	}
	else
	{
		// Actual effect. Call the target selection menu and shit.
		gActionData.itemSlotIndex = 0;
		DidSelectSpell = 1;
		ClearBG0BG1();
		int type = GetItemType(SelectedSpell);
		if ( type != ITYPE_STAFF )
		{
			MakeTargetListForWeapon(gActiveUnit,SelectedSpell|0xFF00);
			StartTargetSelection(&SpellTargetSelection);
		}
		else
		{
			ItemEffect_Call(gActiveUnit,SelectedSpell|0xFF00);
		}
		return 0x27;
	}
}

int SpellOnHover(MenuProc* proc)
{
	int spell = SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,proc->commandIndex,UsingSpellMenu)];
	SelectedSpell = spell;
	
	//UpdateMenuItemPanel(proc); // We're gonna rewrite and inline this instead.
	MenuItemPanelProc* menuItemPanel = (MenuItemPanelProc*)ProcFind(&gProc_MenuItemPanel);
	int x = menuItemPanel->x;
	int y = menuItemPanel->y;
	
	for ( int i = 0 ; i < 3 ; i++ ) { Text_Clear(&menuItemPanel->textHandles[i]); }
	MakeUIWindowTileMap_BG0BG1(x,y,14,8,0);
	
	int spellType = GetItemType(spell);
	if ( spellType != ITYPE_STAFF )
	{
		BattleGenerateUiStats(gActiveUnit,9); // 9 is using a Gaiden spell.
		Text_InsertString(&menuItemPanel->textHandles[0],0x02,0,GetStringFromIndex(0x4F1)); // Affin.
		Text_InsertString(&menuItemPanel->textHandles[0],0x32,0,GetStringFromIndex(gGaidenMagicHPCostText)); // HP Cost.
		Text_InsertString(&menuItemPanel->textHandles[1],0x02,0,GetStringFromIndex(0x4F3)); // Atk.
		Text_InsertString(&menuItemPanel->textHandles[2],0x02,0,GetStringFromIndex(0x4F4)); // Hit.
		Text_InsertString(&menuItemPanel->textHandles[1],0x32,0,GetStringFromIndex(0x501)); // Crit.
		Text_InsertString(&menuItemPanel->textHandles[2],0x32,0,GetStringFromIndex(0x4F5)); // Avoid.
		
		int CostColor = 2;
		if ( !HasSufficientHP(gActiveUnit,spell) ) { CostColor = 1; }
		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[0],0x54,CostColor,GetSpellCost(spell));
		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[1],0x24,2,gBattleActor.battleAttack);
		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[2],0x24,2,gBattleActor.battleHitRate);
		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[1],0x54,2,gBattleActor.battleCritRate);
		Text_InsertNumberOr2Dashes(&menuItemPanel->textHandles[2],0x54,2,gBattleActor.battleAvoidRate);
		
	}
	else
	{
		const char* desc = GetStringFromIndex(GetItemUseDescId(spell));
		int j = 0;
		desc--;
		do // This loop handles writing multiple lines of description text. Why isn't there a function to handle this...? IS moment...
		{
			desc++;
			Text_InsertString(&menuItemPanel->textHandles[j],0,0,desc);
			desc = Text_GetStringNextLine(desc);
			j++;
		} while ( *desc );
		gBattleActor.battleAttack = gBattleTarget.battleAttack; // ??? this is something vanilla does???
		gBattleActor.battleHitRate = gBattleTarget.battleHitRate; // ??? this fixes the green/red arrows from showing on staves???
		gBattleActor.battleCritRate = gBattleTarget.battleCritRate;
		gBattleActor.battleAvoidRate = gBattleTarget.battleAvoidRate;
	}
	for ( int i = 0 ; i < 3 ; i++ ) { Text_Display(&menuItemPanel->textHandles[i],&gBG0MapBuffer[y+1+2*i][x+1]); }
	
	if ( spellType != ITYPE_STAFF ) { DrawIcon(&gBG0MapBuffer[y+1][x+5],spellType+0x70,menuItemPanel->oam2base<<0xC); } // This HAS to happen after the Text_Display calls.
	
	BmMapFill(gMapMovement,-1);
	BmMapFill(gMapRange,0);
	//FillRangeMapByRangeMask(gActiveUnit,GetWeaponRangeMask(spell));
	//FillRangeMapByRangeMask(gActiveUnit,gGet_Item_Range(gActiveUnit,spell));
	gWrite_Range(gActiveUnit->xPos,gActiveUnit->yPos,gGet_Item_Range(gActiveUnit,spell));
	DisplayMoveRangeGraphics(( spellType == ITYPE_STAFF ? 4 : 2 )); // See note in UnitMenu.c.
	return 0;
}

int SpellOnUnhover(MenuProc* proc)
{
	if ( !DidSelectSpell ) // Don't hide the squares if we're going to the target selection menu.
	{
		HideMoveRangeGraphics();
	}
	DidSelectSpell = 0; // Unset this variable.
	return 0;
}

void NewMenuRText(MenuProc* menuProc, MenuCommandProc* commandProc) // Autohook to 0x08024588. Change the RText if we're using the magic menu.
{
	int xTile = commandProc->xDrawTile * 8;
	int yTile = commandProc->yDrawTile * 8;
	if ( UsingSpellMenu )
	{
		// Get RText for the spell menu instead.
		DrawItemRText(xTile,yTile,SpellsGetter(gActiveUnit,UsingSpellMenu)[GetNthUsableSpell(gActiveUnit,commandProc->commandDefinitionIndex,UsingSpellMenu)]);
	}
	else
	{
		// Vanilla behavior.
		if ( commandProc->commandDefinitionIndex <= 4 )
		{
			DrawItemRText(xTile,yTile,gActiveUnit->items[commandProc->commandDefinitionIndex]);
		}
		else
		{
			DrawItemRText(xTile,yTile,*((u16*)&gGameState+0x16)); // Probably related to special cases like ballistae?
		}
	}
}

void NewExitBattleForecast(Proc* proc)
{
	// If they were using the magic menu. Return there.
	// The only thing the UM effect uses the procs for is error R-text which shouldn't be possible if we've exited the forecast.
	if ( UsingSpellMenu == BLACK_MAGIC ) { GaidenBlackMagicUMEffect(NULL,NULL); }
	else if ( UsingSpellMenu == WHITE_MAGIC ) { GaidenWhiteMagicUMEffect(NULL,NULL); }
	else
	{
		// They were not using the magic menu. Return to regular attack.
		AttackUMEffect(NULL,NULL);
	}
	SelectedSpell = 0; // Regardless of use case, ensure that this is 0.
}
