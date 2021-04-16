
// Returns a boolean for whether this entry is viewable.
static int IsConvoViewable(BaseConvoEntry* entry)
{
	if ( !entry->exists ) { return 0;}
	if ( CheckEventId(entry->eventID) ) { return 0; }
	if ( !entry->usability ) { return 1; }
	else { return entry->usability(entry); }
}

// Returns the number of conversations viewable this chapter.
static int GetNumViewable(BaseConvoProc* proc) // Pretty much we want to count the number of bits in the usability bitfield.
{
	int sum = 0, usability = proc->usability;
	while ( usability )
	{
		if ( usability & 1 ) { sum++; }
		usability >>= 1;
	}
	return sum;
}	

static void ClearRam(char* offset, int size)
{
	for ( int i = 0 ; i < size ; i++ )
	{
		*(offset + i) = 0;
	}
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

static void HandleText(char* origin, char* dest, BaseConvoEntry* entry) // Handles appending importance to the right end of the title as well as copying the string to RAM.
{
	// We need to write the string to RAM, then append white space and add exclamation marks.
	CopyString(origin,dest);
	if ( entry->importance != 0 )
	{
		for ( int i = GetStringLength(dest) ; GetStringTextWidthAscii(dest) < 0x78 ; i++ )
		{
			*(dest+i) = ' ';
		}
		for ( int i = 0 ; i <= entry->importance ; i++ )
		{
			*(dest+GetStringLength(dest)-i) = '!';
		}
	}
}

static int GetStringLength(char* string)
{
	int l = 0;
	for ( ; *(string+l) ; l++ ) {}
	return l;
}
