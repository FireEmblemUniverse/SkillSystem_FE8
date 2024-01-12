#ifndef GBAFE_DIALOGUE_H
#define GBAFE_DIALOGUE_H

#include "proc.h"

enum
{
	// Dialogue flags

	DIALOGUE_1 = (1 << 0),
	DIALOGUE_2 = (1 << 1),
	DIALOGUE_NOSKIP = (1 << 2),
	DIALOGUE_NOFAST = (1 << 3),
	DIALOGUE_10 = (1 << 4),
	DIALOGUE_20 = (1 << 5),
	DIALOGUE_40 = (1 << 6),
	DIALOGUE_80 = (1 << 7),
	DIALOGUE_100 = (1 << 8),
};

enum
{
	// Dialogue options identifiers

	DIALOGUE_OPT_BACK,
	DIALOGUE_OPT_FIRST,
	DIALOGUE_OPT_SECOND,
};

// TODO: more

void Dialogue_InitGfx(unsigned tileId, unsigned lineCount, u8 boolUseBubble); //!< FE8U:0800680D
void Dialogue_InitFont(void); //!< FE8U:08006979
void StartDialogue(int xTile, int yTile, const char* cstring, struct Proc* parent); //!< FE8U:0800698D
void SetDialogueFlag(unsigned flag); //!< FE8U:08006AA9
void Dialogue_SetDefaultTextColor(int color); //!< FE8U:08006B11
void Dialogue_SetActiveFacePosition(unsigned dialogueSlot); //!< FE8U:08007839
// void StartDialogueFace(unsigned portrait, int x, int y, unsigned display, unsigned dialogueSlot); //!< FE8U:08007939
// void Dialogue_ClearLines(void); //!< FE8U:08008251
int GetLastDialoguePromptResult(void); //!< FE8U:08008A01

#endif // GBAFE_DIALOGUE_H
