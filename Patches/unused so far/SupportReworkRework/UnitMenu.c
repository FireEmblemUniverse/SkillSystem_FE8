
static const s8 xAdj[] = { -1, 1, 0, 0 };
static const s8 yAdj[] = { 0, 0, -1, 1 };

int SupportConvoUsability(void) // Return 0x1 for true and 0x3 for false. This is the usability function for the unit menu for "Support". Autohook to 0x08023D14.
{
	int x = ActiveUnit->xPos;
	int y = ActiveUnit->yPos;
	if ( ActiveUnit->state & US_CANTOING ) { return 3; } // Immediately return false if this unit is cantoing.
	for ( int i = 0 ; i < 4 ; i++ )
	{
		int allegianceByte = gMapUnit[y+yAdj[i]][x+xAdj[i]];
		if ( allegianceByte == 0 ) { continue; } // If there isn't a character here, reiterate.
		if ( FindValidConvo(GetCharacterEvents(),GetUnit(allegianceByte),ToCharID(ActiveUnit)) ) { return 1; }
	}
	return 3;
}

// This is a thing so that anything that for scans for talk conversations see this to see if they should display a bubble or whatever.
int CHARSupportConvoUsability(CharacterStackAlloc* alloc) // Because of the CHARASM hack, we can return 0x2 and have it ignore the event ID or any other silly conditions.
{
	if ( ToUnit(alloc->currCharID)->state & US_CANTOING ) { return 0; } // Let's not if this unit is cantoing.
	// In the alloc we have "CharacterEvent* event;", "u8 currCharID;", and "Unit* otherUnit;". Not a WHOLE lot is known about this struct, but we can work with this.
	if ( ProcFind(&Proc_TI) == NULL ) { return 0; } // Has to do with the movement squares.	
	// I need these conversions because I don't think the CHARASM stuff handles 0xFF = first character struct.
	if ( FindValidConvo(alloc->event,ToUnit(alloc->currCharID),ToCharID(alloc->otherUnit)) != NULL )
	{
		alloc->returnThing = 1; // This is a weird thing that I seem to need to do.
		return 2; // Valid convo found!
	}
	else
	{
		return 0; // No valid convo found.
	}
}

void BuildSupportTargetList(Unit* active) // Actually make the target list for the support. Autohook to 0x08025644.
{
	// If we are here, an adjacent eligible unit should exist.
	int x = active->xPos;
	int y = active->yPos;
	InitTargets(x,y);
	for ( int i = 0 ; i < 4 ; i++ )
	{
		int allegianceByte = gMapUnit[y+yAdj[i]][x+xAdj[i]];
		if ( allegianceByte == 0 ) { continue; } // If there isn't a character here, reiterate.
		// Okay, we need to find if there is a character event that does work.
		CharacterEvent* event = FindValidConvo(GetCharacterEvents(),GetUnit(allegianceByte),ToCharID(active));
		if ( event != NULL )
		{
			// Great! We've found a valid target. Add them to the target list.
			AddTarget(x+xAdj[i],y+yAdj[i],GetUnit(allegianceByte)->index & 0x3F,0); // & 0x3F for clearing the allegiance. Why isn't that a bitfield in FE-CLib?
		}
	}
	// I hope at least one AddTarget was called. Gotta love empty target list crash!
}

int SupportSelected(Proc* parent) // Effect routine. Play the applicable event (generic or special). Autohook to 0x080323D4.
{
	// Here we go again. Time to find the correct character event.
	// It's weird how vanilla doesn't store a pointer to the relevant character event. It just does usability calculations... again.
	CharacterEvent* event = FindValidConvo(GetCharacterEvents(),ActiveUnit,ToCharID(GetUnit(gActionData.targetIndex)));
	if ( (u32)event->eventOrText.event & 0xFFFF0000 )
	{
		// They have a special event to play.
		StartMapEventEngine(event->eventOrText.event,0);
	}
	else
	{
		// They want to show the generic event.
		gMemorySlot[2] = event->eventOrText.text;
		gMemorySlot[1] = event->char1;
		gMemorySlot[3] = event->char2;
		StartMapEventEngine(&SupportConvoEvents,0);
	}
	gActionData.unitActionType = 0x0E;
	return 0;
}

static CharacterEvent* GetCharacterEvents(void)
{
	return (CharacterEvent*)GetChapterEvents(gChapterData.chapterIndex)[1];
}

 // checkAdjacent is a boolean for whether we need to check that. checkConvo is a boolean for whether we need to check if this is a support.
static CharacterEvent* FindValidConvo(CharacterEvent* event, Unit* active, int target)
{
	int char1 = ToCharID(active);
	int char2 = target;
	if ( ToUnit(char2)->state & US_RESCUED ) { return NULL; } // No convos with rescued unis!
	for ( ; event->identifier != 0 ; event++ )
	{
		if ( event->usability != CHARSupportConvoUsability ) { continue; } // This isn't a support convo.	
		if ( ( char1 != event->char1 || char2 != event->char2 ) && ( char2 != event->char1 || char1 != event->char2 ) ) { continue; } // The characters don't match this character event.
		if ( CanUnitsSupport(active,target,event->level) )
		{
			return event; // This is a valid event. Return the event pointer we stopped at.
		}
	}
	return NULL; // No more character events. Return null.
}
