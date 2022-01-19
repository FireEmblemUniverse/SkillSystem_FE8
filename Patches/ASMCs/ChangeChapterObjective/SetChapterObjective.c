#include "include\gbafe.h"

// Change Chapter Objective. Hack by Zeta/Gilgamesh
// Requires FE-CLIB
// Free to use/modify

#define ChapterObjectiveTrapID 0xEF
#define ChapterTurnLimitTrapID 0xEE

extern struct ROMChapterData gChapterDataTable[];

Trap* FindTrapByID(u8 trapID)
{
	for (int x = 0; x < 0x40; x++)
	{
		if (gTrapArray[x].type == trapID)
		{
			return &gTrapArray[x];
		}
	}
	
	// no trap found so
	return NULL;
}

void SetChapterObjective()
{
	Trap* ChapterObjectiveTrap = FindTrapByID(ChapterObjectiveTrapID);
	
	if (ChapterObjectiveTrap == NULL)
		ChapterObjectiveTrap = AddTrap(0xFF, 0xFF, ChapterObjectiveTrapID, 0);
	
	if (ChapterObjectiveTrap != NULL) // might happen if your whole trap list is full??
	{
		unsigned short* TextID1 = ((char*)ChapterObjectiveTrap + 4);
		unsigned short* TextID2 = ((char*)ChapterObjectiveTrap + 6);
		*TextID1 = gEventSlot[0x1];
		*TextID2 = gEventSlot[0x2];
	}
}

unsigned short GetChapterObjective(int isLong)
{
	unsigned short *TextID;
	Trap* ChapterObjectiveTrap = FindTrapByID(ChapterObjectiveTrapID);

	if (ChapterObjectiveTrap == NULL)
	{
		if (isLong)
			TextID = &gChapterDataTable[gChapterData.chapterIndex].statusObjectiveTextId;
		else
			TextID = &gChapterDataTable[gChapterData.chapterIndex].goalWindowTextId;
	}
	else
	{
		if (isLong)
			TextID = ((char*)ChapterObjectiveTrap + 6);
		else
			TextID = ((char*)ChapterObjectiveTrap + 4);
	}
	
	return *TextID;
}

void SetChapterTurnLimit()
{
	Trap* ChapterTurnLimitTrap = FindTrapByID(ChapterTurnLimitTrapID);

	if (ChapterTurnLimitTrap == NULL)
		ChapterTurnLimitTrap = AddTrap(0xFF, 0xFF, ChapterTurnLimitTrapID, 0);

	if (ChapterTurnLimitTrap != NULL) // might happen if your whole trap list is full??
	{
		u8* TurnLimit = ChapterTurnLimitTrap + 4;
		*TurnLimit = gEventSlot[0x1];
	}
}

u8 GetChapterTurnLimit()
{
	u8* TurnLimit;
	Trap* ChapterTurnLimitTrap = FindTrapByID(ChapterTurnLimitTrapID);
	
	if (ChapterTurnLimitTrap == NULL)
		TurnLimit = &gChapterDataTable[gChapterData.chapterIndex].goalWindowEndTurnNumber;
	else
		TurnLimit = ChapterTurnLimitTrap + 4;

	return *TurnLimit;
}

void CheckTurnLimit()
{
	u8 TurnLimit = GetChapterTurnLimit();
	u8 CurrentTurn = gChapterData.turnNumber;

	if (CurrentTurn >= TurnLimit)
		gEventSlot[0xC] = 1;
	else
		gEventSlot[0xC] = 0;
}