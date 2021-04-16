
void CallAddSupport(Proc* parent) // Memory slot 0x1 = character ID 1, 0x2 = character ID 2, 0x3 = level to set to, 0x4 = boolean for adding a popup.
{
	if ( gMemorySlot[4] >= 0 && gMemorySlot[4] <= MaxSupportLevel && FindSupport(ToUnit(gMemorySlot[1]),gMemorySlot[2]) == 0xFF ) // Ensure valid level before trying to add the support.
	{
		if ( AddSupport(ToUnit(gMemorySlot[1]),gMemorySlot[2]) )
		{
			SetSupport(ToUnit(gMemorySlot[1]),gMemorySlot[2],gMemorySlot[3]); // This is guranteed to work because AddSupport was successful, so the support exists, and the level is valid.
			// Adding the support was successful. Check to see if they want a popup to appear.
			if ( gMemorySlot[4] )
			{
				// They want a popup.
				SupportPopup(parent,gMemorySlot[3]);
			}
		}
	}
}

void CallSetSupport(Proc* parent) // Memory slot 0x1 = character ID 1, 0x2 = character ID 2, 0x3 = level to set to, 0x4 = boolean for adding a popup.
{
	if ( SetSupport(ToUnit(gMemorySlot[1]),gMemorySlot[2],gMemorySlot[3]) )
	{
		// Setting the support was successful. Do they want a popup?
		if ( gMemorySlot[4] ) { SupportPopup(parent,gMemorySlot[3]); }
	}
}

void CallIncreaseSupport(Proc* parent) // Memory slot 0x1 = character ID 1, 0x2 = character ID 2, 0x3 = boolean for adding a popup.
{
	if ( IncreaseSupport(ToUnit(gMemorySlot[1]),gMemorySlot[2]) )
	{
		// Setting the support was successful. Do they want a popup?
		if ( gMemorySlot[3] ) { SupportPopup(parent,GetSupportLevel(ToUnit(gMemorySlot[1]),gMemorySlot[2])); }
	}
}

void CallClearSupport(Proc* parent) // Memory slot 0x1 = character ID 1, 0x2 = character ID 2. Why would anyone want a popup here?
{
	ClearSupport(ToUnit(gMemorySlot[1]),gMemorySlot[2]);
}

void CallGetSupportLevel(Proc* parent) // Memory slot 0x1 = character ID 1, 0x2 = character ID 2. Return the level of this support in memory slot 0x1. Returns 0xFF for none.
{
	gMemorySlot[1] = GetSupportLevel(ToUnit(gMemorySlot[1]),gMemorySlot[2]);
}

static void SupportPopup(Proc* parent, int level)
{
	int l = CopyString(SupportLevelNameTable[level],&SupportLevelNameForPopup);
	*(&SupportLevelNameForPopup + l) = 0;
		// The popup uses SupportLevelNameForPopup to know the name of the support. It shows that string after "Support level increased to ".
	Popup_Create(&SupportPopupDefinitions,90,0,parent);
}

static int CopyString(char* origin, char* dest) // Return the length of the copied string.
{
	int l = 0;
	if ( *origin == 0 )
	{
		*dest = 0;
	}
	else
	{
		do
		{
			*(dest+l) = *(origin+l);
			l++;
		} while ( *(origin+l) != 0 );
	}
	return l;
}
