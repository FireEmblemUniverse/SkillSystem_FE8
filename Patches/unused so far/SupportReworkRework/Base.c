
int SupportBaseConvoUsability(BaseConvoEntry* entry) // Should this conversation be usable based off of can these characters support.
{
	if ( entry->supportLevel != 0xFF )
	{
		return CanUnitsSupport(ToUnit(entry->character1),entry->character2,entry->supportLevel);
	}
	else
	{
		return CanUnitsSupport(ToUnit(entry->character1),entry->character2,0xFF); // Let's say support level of 0xFF in the base convo table means undefined level.
	}
}

char* SupportBaseConvoMenuTextGetter(BaseConvoEntry* entry) // Default text getter for the menu. Return a pointer to text.
{
	// We want to do "`character1` and `character2`". Let's start by getting the text for the first character.
	int name1 = ToUnit(entry->character1)->pCharacterData->nameTextId;
	int name2 = ToUnit(entry->character2)->pCharacterData->nameTextId;
	
	int offset = CopyString(GetStringFromIndex(name1),(char*)gGenericBuffer);
	offset += CopyString(" and ",(char*)gGenericBuffer+offset); // Yes yes yes I'm so happy this appears to work!
	offset += CopyString(GetStringFromIndex(name2),(char*)gGenericBuffer+offset);
	*((char*)gGenericBuffer + offset) = 0;
	return (char*)gGenericBuffer;
}

/* Base convo system put these values into these memory slots already. Let's use an event which ASMCs this function which adds a few things to the generic event.
	0x2 = Background (this is convenient because the background display command uses 0x2).
	0x3 = Text ID to show.
	0x4 = Music ID to play.
	0x5 = Item ID to give.
	0x6 = Give item to this character.
	0x7 = UNIT pointer to load.
	0xC = Pointer to this base convo entry.
	
	Let's add:
	0x8 = character 1.
	0x9 = character 2. If we call IncreaseSupport, we shouldn't need to know the level. That was used in usability.
	If we use this method, the user can stack other stuff like giving items on top of supports.
*/
void SetUpBaseSupportConvo(Proc* parent)
{
	BaseConvoEntry* entry = (BaseConvoEntry*)gMemorySlot[0xC];
	gMemorySlot[8] = entry->character1;
	gMemorySlot[9] = entry->character2;
}
