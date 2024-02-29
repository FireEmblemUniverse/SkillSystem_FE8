
Text* GaidenStatScreen(int x, int y, Text* currHandle) // Called from MSS. Returns the next "blank" text handle.
{
	u8* spells = SpellsGetter(gpStatScreenUnit,-1);
	int tile = (currHandle-1)->chr_position;
	int iconX = x;
	int iconY = y;
	for ( int i = 0 ; spells[i] ; i++ )
	{
		const ItemData* item = GetItemData(spells[i]);
		DrawIcon(&StatScreenBufferMap[iconY][iconX],item->iconId,0x4000);
		
		tile += 6;
		currHandle->chr_position = tile;
		currHandle->x = 0;
		currHandle->colorId = TEXT_COLOR_SYSTEM_WHITE;
		currHandle->tile_width = 6;
		currHandle->db_enabled = 0;
		currHandle->db_id = 0;
		currHandle->is_printing = 0;
		
		ClearText(currHandle);
		Text_SetColor(currHandle,TEXT_COLOR_SYSTEM_WHITE);
		Text_InsertDrawString(currHandle,0,TEXT_COLOR_SYSTEM_WHITE,GetStringFromIndex(item->nameTextId));
		PutText(currHandle,&StatScreenBufferMap[iconY][iconX+2]);
		
		currHandle++;
		if ( iconX == x ) { iconX += 8; }
		else { iconX = x; iconY += 2; }
	}
	return currHandle;
}

void GaidenRTextGetter(RTextProc* proc)
{
	int index = *(proc->rTextData+0x12);
	proc->type = SpellsGetter(gpStatScreenUnit,-1)[index]; // I think if this is positive, it treats this as an item bubble.
	proc->textID = GetItemData(proc->type)->descTextId;
}

void GaidenRTextLooper(RTextProc* proc)
{
	int index = *(proc->rTextData+0x12);
	if ( proc->direction == DIRECTION_RIGHT )
	{
		// If we're coming from the right, go up. We need to call RTextUp until we can use a spell there.
		while ( index >= 0 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index]) )
		{
			RTextUp(proc);
			index -= 2;
		}
	}
	else if ( proc->direction == DIRECTION_DOWN )
	{
		// If we're coming from above, go left.
		if ( !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index]) )
		{
			RTextLeft(proc);
			// We're in the right column, and there isn't a spell in the left column one row below we can't jump to, go left again.
			if ( index % 2 && !DoesUnitKnowSpell(gpStatScreenUnit,SpellsGetter(gpStatScreenUnit,-1)[index-1]) ) { RTextLeft(proc); }
		}
	}
}
