
#include <stddef.h>
#include "FE-CLib-master/include/gbafe.h"

#include "Header.h"

#include "MainMenu.c"
#include "ClassDisplay.c"

void CallCharacterSelector(Proc* proc) // Presumably ASMCed. Block the event engine and start running our character creator.
{
	ProcStartBlocking(&gCreatorProc,proc); // Start our proc and block the event engine.
}



void SetupCreator(CreatorProc* proc)
{
	
	//proc->currMenu = ConfirmationMenu; // Initialize the proc parameters.
	proc->currMenu = ClassMenu; // Initialize the proc parameters.
	proc->gender = 1; 			// 0
	proc->route = 1; 			// 0
	proc->mainUnit = NULL;
	proc->tempUnit = NULL;
	proc->currSet = NULL;
	proc->boon = 0;
	proc->bane = 0;
	proc->leavingClassMenu = 0;
	proc->lastIndex = 0;
	proc->lastClassIndex = 0;
	proc->isPressDisabled = 0;
	LockGameLogic();
}

void CreatorStartMenu(CreatorProc* proc)
{
	Text_InitFont();
	FillBgMap(gBg0MapBuffer,0);
	FillBgMap(gBg1MapBuffer,0);
	FillBgMap(gBg2MapBuffer,0);
	((CreatorSpriteProc*)ProcFind(&gCreatorSpriteProc))->isActive = 0; // Disable our map sprite in case it was set.
	MenuProc* newMenu = NULL;

	//asm("mov r11,r11");
	switch ( proc->currMenu )
	{



		case ClassMenu:
			
			// We need to build our class menu in RAM depending on what gender and route they chose.
			CPU_FILL(0,(char*)gRAMMenuCommands-1,6*9*4,32); // Clear our RAM buffer.
			// We don't do this on the stack because it's sorta kinda a lot, and we have a ROM pointer to the commands.
			ClassMenuSet* set = GetClassSet(proc->gender,proc->route);
			for ( int i = 0 ; set->list[i].character && i < 5 ; i++ )
			{
				// Now to build this MenuCommandDefinition.
				gRAMMenuCommands[i].nameId = GetReplacedText(GetClassData(set->list[i].class)->nameTextId);
				gRAMMenuCommands[i].colorId = 0;
				gRAMMenuCommands[i].isAvailable = CreatorSubmenuUsability;
				gRAMMenuCommands[i].onEffect = CreatorSubmenuEffect;
				gRAMMenuCommands[i].onSwitchIn = CreatorActivateClassDisplay;
				gRAMMenuCommands[i].onSwitchOut = CreatorRetractClassDisplay;
				proc->currSet = set;
			}
			
			proc->isPressDisabled = 0;
			//newMenu = StartMenuChild(&gCreatorClassMenuDefs,(Proc*)proc);
			newMenu = StartMenu(&gCreatorClassMenuDefs);
			newMenu->commandIndex = proc->lastClassIndex;
			//ProcStart(&gCreatorClassProc,(Proc*)proc);

			break;
			
		case ConfirmationMenu:

			newMenu = StartMenu(&gCreatorMainMenuDefs);
			DrawMainMenu(proc);
			newMenu->commandIndex = proc->lastIndex;
			break;

	}
	EnableBgSyncByMask(1|2|4);
}

int CreatorSubmenuUsability(const MenuCommandDefinition* command, int index)
{
	return 1;
}

int CreatorSubmenuEffect(MenuProc* proc, MenuCommandProc* commandProc)
{
	//asm("mov r11,r11");
	CreatorProc* creator = (CreatorProc*)ProcFind(&gCreatorProc);


	creator->leavingClassMenu = 1; // Set this, so we don't clear this on the switch out routine.
	creator->mainUnit = GetUnit(1);
	CopyUnit(creator->tempUnit,creator->mainUnit);
	if ( creator->tempUnit ) { ClearUnit(creator->tempUnit); creator->tempUnit = NULL; }
	ProcGoto((Proc*)creator,3);
	creator->lastClassIndex = commandProc->commandDefinitionIndex;
	creator->currMenu = ConfirmationMenu;
	//asm("mov r11,r11");
	return ME_END|ME_PLAY_BEEP;

}

// This is a menu option that jumps to end the menu.
int CreatorEndMenu(MenuProc* proc, MenuCommandProc* commandProc)
{
	CreatorProc* creator = (CreatorProc*)ProcFind(&gCreatorProc);


	if ( creator->isPressDisabled ) { return 0; }

	// Next, let's see if there's a different inventory we need to set for this character.
	for ( int i = 0 ; gCreatorRealInventoryList[i].characterID ; i++ )
	{
		Unit* unit = creator->mainUnit;
		if ( gCreatorRealInventoryList[i].characterID == unit->pCharacterData->number )
		{
			for ( int j = 0 ; j < 5 ; j++ )
			{
				int itemID = gCreatorRealInventoryList[i].items[j];
				unit->items[j] = ( itemID ? MakeNewItem(itemID) : 0 );
			}
		}
	}
	
	
	
	ProcGoto((Proc*)creator,3); // Jump to end the creator proc.
	
	
	if ( creator->gender == 1 ) { SetEventId(0x6E); } // 0x6E is true if they chose male.
	if ( creator->route == 2 ) { SetEventId(0x68); } // Military mode.
	else
	{
		if ( creator->route == 3 ) { SetEventId(0x67); } // Mage mode.
	}
	
	
	return ME_END|ME_PLAY_BEEP;
}

// This is called right before ending the creator proc.
void CreatorTerminate(CreatorProc* proc)
{
	EndFaceById(0);
	FillBgMap(gBg0MapBuffer,0);
	FillBgMap(gBg1MapBuffer,0);
	FillBgMap(gBg2MapBuffer,0);
	EnableBgSyncByMask(1|2|4);
	UnlockGameLogic();
}

int CreatorRegressMenu(void)
{
	CreatorProc* proc = (CreatorProc*)ProcFind(&gCreatorProc);
	if ( proc->isPressDisabled ) { return 0; }
	if ( proc->currMenu == ClassMenu )
	{
		ProcGoto((Proc*)proc,3); // Previously 1 to wait for the platform to disappear 
		proc->currMenu = ConfirmationMenu; // Return to the main menu.
		return ME_END|ME_PLAY_BEEP;
	}
	else
	{
		proc->currMenu = ConfirmationMenu; // Return to the main menu.
		ProcGoto((Proc*)proc,0);
		return ME_END|ME_PLAY_BEEP|ME_CLEAR_GFX; // Close menu, clear graphics, etc.
	}
}

int CreatorNoBPress(void)
{
	return ME_PLAY_BOOP; // They're on the main menu. Don't allow a B press!
}

void CreatorEnablePresses(CreatorProc* proc)
{
	proc->isPressDisabled = 0;
}

void CreatorIdle(CreatorProc* proc)
{
	asm("mov r11,r11"); 
	// Burn some RNs!
	if ( proc->cycle < 15 ) { proc->cycle++; }
	else { proc->cycle = 0; RandNext(); }
}

// We use these timer functions to burn a random number of RNs for our random text.
void NewTimer(Proc* proc)
{
	ProcStart(&gTimerProc,proc);
}

void TimerSetup(TimerProc* proc)
{
	proc->count = 0;
}

void TimerIncrement(TimerProc* proc)
{
	proc->count++;
}

void EndTimer(void)
{
	BreakProcLoop(ProcFind(&gTimerProc));
}

void BurnRNs(void)
{
	TimerProc* timer = (TimerProc*)ProcFind(&gTimerProc);
	int count = timer->count;
	for ( int i = 0 ; i < count/32 ; i++ ) { RandNext(); }
}

static void DrawStatNames(TextHandle handle, char* string, int x, int y)
{
	Text_Clear(&handle);
	Text_SetColorId(&handle,TEXT_COLOR_GOLD);
	Text_AppendStringAscii(&handle,string);
	Text_Display(&handle,&gBG0MapBuffer[y][x]);
}

static void ApplyBGBox(u16 map[32][32], TSA* tsa, int x, int y)
{
	for ( int i = 0 ; i < tsa->height+1 ; i++ )
	{
		for ( int j = 0 ; j < tsa->width+1 ; j++ )
		{
			map[i+y][j+x] = ((u16*)(tsa->tiles))[i*(tsa->width+1)+j];
		}
	}
}

static int GetNumLines(char* string) // Basically count the number of NL codes.
{
	int sum = 1;
	for ( int i = 0 ; string[i] ; i++ )
	{
		if ( string[i] == NL ) { sum++; }
	}
	return sum;
}

static void DrawMultiline(TextHandle* handles, char* string, int lines) // There's a TextHandle for every line we need to pass in.
{
	// We're going to copy each line of the string to gGenericBuffer then draw the string from there.
	int j = 0;
	for ( int i = 0 ; i < lines ; i++ )
	{
		int k = 0;
		for ( ; string[j] && string[j] != NL ; k++ )
		{
			gGenericBuffer[k] = string[j];
			j++;
		}
		gGenericBuffer[k] = 0;
		Text_InsertString(handles,0,handles->colorId,(char*)gGenericBuffer);
		//Text_DrawString(handles,(char*)gGenericBuffer);
		handles++;
		j++;
	}
}

static int GetReplacedText(int text)
{
	for ( int i = 0 ; gCreatorTextReplacementLookup[i].normal ; i++ )
	{
		if ( gCreatorTextReplacementLookup[i].normal == text ) { return gCreatorTextReplacementLookup[i].replacement; }
	}
	return text;
}
