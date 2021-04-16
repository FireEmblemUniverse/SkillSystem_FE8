
static const u8 RTextLabels[] = { 0x00, 0x2C, 0x58 };
static const u8 RTextStats[] = { 0x20, 0x4A, 0x78 };

// Loop through all supports and show valid ones and their levels. We'd also like to have a box at the bottom that gets the total current bonus for all supports in range.
void DrawSupports(void) // Autohook to 0x8087698.
{
	Unit* current = gStatScreen.curr;
	TextHandle* textBase = &TileBufferBase; // This name is bad but this is what MSS uses so eh.
	int y = 3;
	int x;
	// First, let's display each valid support.
	for ( int i = 0 ; i < 5 ; i++ )
	{
		if ( current->supports[i] )
		{
			x = 16; // Doing it like this to keep track of how x is calculated here.
			// First, draw the blue box behind the text.
			BgMap_ApplyTsa(&Bg2_Origin[y-2][2],&SupportStatScreenSmallBox,0x2040);
			
			// Now start drawing the text.
			(textBase+1)->tileIndexOffset = textBase->tileIndexOffset+8;
			textBase->tileWidth = 8;
			DrawTextInline(textBase,&Tile_Origin[y][x],0,4,8,GetStringFromIndex(ToUnit(current->supports[i])->pCharacterData->nameTextId)); // Draw the name of the supporting character.
			textBase++;
			
			x = 24;
			(textBase+1)->tileIndexOffset = textBase->tileIndexOffset+2;
			textBase->tileWidth = 2;
			DrawTextInline(textBase,&Tile_Origin[y][x],2,0,2,SupportLevelNameTable[GetSupportLevel(current,current->supports[i])]); // Draw the support level.
			textBase++;
			y += 2;
		}
	}
	// Next at the bottom, let's create a blue box similar to the one on the items page that shows the current total support bonuses.
	x = 1;
	y = 12;
	BgMap_ApplyTsa(&Bg2_Origin[y][x],&SupportStatScreenBlueBox,0x2040);
	
	x = 14;
	y = 12;
	(textBase+1)->tileIndexOffset = textBase->tileIndexOffset+14;
	textBase->tileWidth = 14;
	DrawTextInline(textBase,&Tile_Origin[y][x],3,3,14,&TotalCurrentSupportBonusesText);
	textBase++;
	
	BonusStruct bonuses;
	MasterSupportCalculation(current,&bonuses);
	x = 14;
	y = 14;
	for ( int i = 0 ; i < 3 ; i++ )
	{
		(textBase+1)->tileIndexOffset = textBase->tileIndexOffset+3;
		textBase->tileWidth = 3;
		DrawTextInline(textBase,&Tile_Origin[y][x],3,0,3,SupportRTextStatNames[i].name);
		textBase++;
		x += 5;
	}
	x = 14;
	y = 16;
	for ( int i = 0 ; i < 3 ; i++ )
	{
		(textBase+1)->tileIndexOffset = textBase->tileIndexOffset+3;
		textBase->tileWidth = 3;
		DrawTextInline(textBase,&Tile_Origin[y][x],3,0,3,SupportRTextStatNames[i+3].name);
		textBase++;
		x += 5;
	}
	x = 17;
	y = 14;
	for ( int i = 0 ; i < 3 ; i++ )
	{
		DrawUiNumberOrDoubleDashes(&Tile_Origin[y][x],2,bonuses.vals[i]);
		x += 5;
	}
	x = 17;
	y = 16;
	for ( int i = 0 ; i < 3 ; i++ )
	{
		DrawUiNumberOrDoubleDashes(&Tile_Origin[y][x],2,bonuses.vals[i+3]);
		x += 5;
	}
}

void SupportReworkPageSwitch(void)
{
	asm("@ Autohook to 0x08088690. r0 should equal the number of stat screen pages to have upon hitting the strb r0, [ r5, #0x01 ].\n\
		@ r5 = StatScreenStruct. Preserve no scratch registers!\n\
		ldr r0, [ r5, #0x0C ] @ r0 = character struct.\n\
		bl CountSupports @ r0 = number of supports.\n\
		mov r1, #0x04 @ 4 pages if there are supports to show.\n\
		cmp r0, #0x00\n\
		bne NoSupportsStatScreen\n\
			mov r1, #0x03 @ 3 pages if there no are supports to show.\n\
			@ We also need to ensure that the stat screen does not try to load page 4 (because the user left from page 4 on the last stat screen).\n\
			ldrb r0, [ r5 ] @ Current stat screen page.\n\
			cmp r0, #0x03\n\
			bne NoSupportsStatScreen\n\
				mov r0, #0x00\n\
				strb r0, [ r5 ] @ Move to page 1 instead of 4.\n\
				str r0, [ r5, #0x14 ] @ null out the pointer to R-text (to prevent glitches there).\n\
		NoSupportsStatScreen:\n\
		mov r0, r1\n\
		strb r0, [ r5, #0x01 ]\n\
		blh Text_InitFont, r1\n\
		blh _ResetIconGraphics, r1\n\
		blh #0x08086DF0, r1\n\
		ldr r0, =#0x080886A1\n\
		bx r0\n\
		.ltorg");
}

// These functions are hacks to get the support bubble working.

void PassSupportDataToRTextHandler(void)
{
	asm("@ jumpToHack at 0x08088F50.\n\
		ldrh r0, [ r7 ]	@ +4E\n\
		ldrh r1, [ r6 ]	@ +4C\n\
		mov r2, r4\n\
		bl CreateNewHelpBubbleProc\n\
		ldr r0, =0x0203E784\n\
		str r5, [ r0 ]\n\
		\n\
		ReturnToFunc:\n\
		ldr r1, =0x08088F5D\n\
		bx r1\n\
		.ltorg");
}

void CreateNewHelpBubbleProc(u32 idk1, u32 idk2, RTextProc* proc) // This function is weird. Makes a new R text bubble proc?
{
	RTextProc* newProc = (RTextProc*)ProcStart(&HelpTextProcCode,(Proc*)3); // idk what's up with the second parameter.
	newProc->idk10 = idk1;
	newProc->idk11 = idk2;
	newProc->char1 = proc->char1;
	newProc->char2 = proc->char2;
	newProc->level = proc->level;
}

void DrawRTextStatLabelsForSupport(void)
{
	asm("@jumpToHack at 0x08089F70.\n\
		mov r1, r0\n\
		cmp r1, #0x1\n\
		beq WeaponBox\n\
			cmp r1, #0x0\n\
			beq NormalType\n\
				cmp r1, #0x2\n\
				beq StaffType\n\
					cmp r1, #0x3\n\
					beq SaveType\n\
						cmp r1, #0x4\n\
						beq SupportBox\n\
							b NotFound\n\
						SupportBox:	@custom\n\
						mov r0, r5	@proc\n\
						bl DrawRTextStatLabels\n\
						mov r1, #0x02			@not sure what this does just yet\n\
						b NormalType\n\
					SaveType:	@0x08089FAC\n\
					ldr r1, =0x08099FAD\n\
					bx r1\n\
				StaffType:	@0x08089FA4\n\
				ldr r1, =0x08089FA5\n\
				bx r1\n\
			NormalType:  @0x08089F8E\n\
			mov r0, r5\n\
			add r0, #0x64\n\
			strh r1, [ r0 ]\n\
			b NotFound\n\
		WeaponBox:  @0x08089F96\n\
		ldr r1, =0x08089F97\n\
		bx r1\n\
		\n\
		NotFound:\n\
		ldr r1, =0x08089FB9\n\
		bx r1\n\
		.ltorg");
}

int DrawRTextStatLabels(RTextProc* proc) // Lol we're not actually gonna use the parameter. We're gonna draw the text on the bubble.
{
	for ( int i = 0 ; i < 3 ; i++ )
	{
		Text_InsertString(&SomeTextHandle,RTextLabels[i],8,SupportRTextStatNames[i].name);
	}
	for ( int i = 0 ; i < 3 ; i++ )
	{
		Text_InsertString(&SomeTextHandle+1,RTextLabels[i],8,SupportRTextStatNames[i+3].name);
	}
	return 2;
}

void DrawRTextStatValuesForSupport(void)
{
	asm("@jumpToHack at 0x08089FD8, just add an extra condition for 0x4\n\
		mov r0, r4\n\
		blh #0x080892D0, r3 @GetRtextItemBoxType\n\
		cmp r0, #0x1\n\
		beq WeaponType\n\
			cmp r0, #0x3\n\
			beq SaveMenuType\n\
				cmp r0, #0x4\n\
					beq SupportType\n\
						b DefaultCase\n\
					SupportType:\n\
					mov r0, r5				@ 29-2b data here\n\
					bl DrawRTextStatValues\n\
					b DefaultCase\n\
				SaveMenuType: @0x08089FF4\n\
				ldr r1, =0x08089FF5\n\
				bx r1\n\
			WeaponType:\n\
			mov r0, r4\n\
			ldr r1, =0x08089FEF\n\
			bx r1\n\
		DefaultCase: @0x08089FF8\n\
		ldr r1, =0x08089FF9\n\
		bx r1\n\
		.ltorg");
}

void DrawRTextStatValues(RTextProc* proc) // Same as above, except we're gonna get the stat numbers.
{
	BonusStruct bonuses;
	for ( int i = 0 ; i < 6 ; i++ ) { bonuses.vals[i] = 0; }
	GetBonusByCharacter(&bonuses,ToUnit(proc->char1),proc->char2);
	for ( int i = 0 ; i < 3 ; i++ )
	{
		Text_InsertNumberOr2Dashes(&SomeTextHandle,RTextStats[i],7,bonuses.vals[i]);
	}
	for ( int i = 0 ; i < 3 ; i++ )
	{
		Text_InsertNumberOr2Dashes(&SomeTextHandle+1,RTextStats[i],7,bonuses.vals[i+3]);
	}
}

void NewBoxType(void) // Creates a new RText box type of 0xFFFD.
{
	asm("ldr r0, =#0xFFFE\n\
		cmp r4, r0\n\
		bne CheckForSupportData\n\
			mov r0, #0x3\n\
			b ExitFunc\n\
		CheckForSupportData:\n\
		ldr r0, =#0xFFFD\n\
		cmp r4, r0\n\
		bne CheckForItemData\n\
			mov r0, #0x4\n\
			ExitFunc:\n\
			ldr r1, =0x0808931B\n\
			bx r1\n\
		CheckForItemData:\n\
		ldr r1, =0x080892E5\n\
		bx r1\n\
		.ltorg");
}

// Next are the RText getter and looper funcions.
void SupportScreenRTextGetter(RTextProc* proc)
{
	Unit* current = gStatScreen.curr;
	int loc = GetNthValidSupport(current,*(proc->rTextData+0x12));
	proc->type = 0xFFFD; // Mark this bubble as a support bubble.
	proc->textID = 0x046B; // Store text ID for RText.
	proc->char1 = ToCharID(current); // Store the characters and support level.
	if ( loc != 0xFF )
	{
		proc->char2 = current->supports[loc]; // This is getting which index this is from the ROM RText data, representing the nth valid support.
	}
	else
	{
		proc->char2 = 0;
	}
	proc->level = GetSupportLevel(current,proc->char2);
}

void SupportScreenRTextLooper(RTextProc* proc)
{
	Unit* current = gStatScreen.curr;
	if ( !CountSupports(current) ) { RTextLeft(proc); }
	else
	{
		// We need to immediately end if there is nothing to show where we're trying to go.
		if ( proc->direction == 0x80 )
		{
			// We're trying to move down.
			if ( GetNthValidSupport(current,*(proc->rTextData+0x12)) == 0xFF ) { RTextDown(proc) ; return; }
		}
		else
		{
			//RTextDown(proc);
			return;
		}
		if ( proc->direction == 0 || proc->direction == 0x10 || proc->direction == 0x40 ) { RTextUp(proc); return; } // There should be supports guranteed to be above the current.
	}
}
