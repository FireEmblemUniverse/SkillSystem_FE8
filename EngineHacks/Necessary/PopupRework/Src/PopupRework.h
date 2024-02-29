#ifndef FE8_POPUP_REWORK_H
#define FE8_POPUP_REWORK_H

#include "gbafe.h"

struct PopupReworkCallTable;

struct PopupReworkProc {
	/* 00 */ struct PopupProc pop;

	/* 4C */ void (*addIcon) (struct PopupReworkProc* proc, unsigned iconId, unsigned xOffset);
};

struct PopupComponentType {
	int  (*getLength) (struct PopupReworkProc* proc, u32 argument);
	void (*display)   (struct PopupReworkProc* proc, struct Text* text, u32 argument);
};

struct BattlePopupType {
	int (*tryInit) (void);
	const u32* definition;
	int time;
};

extern struct Unit* gpPopupUnit;
extern u16 gPopupItem;
extern u32 gPopupNumber;

#define PlaySfx(aSongId) do { \
	if (!gPlaySt.config.disableSoundEffects) \
		m4aSongNumStart(aSongId); \
} while (0)

#define SetPopupWType SetPopupItem
#define gPopupWType gPopupItem

#define BG_LOCATED_TILE(aMap, aX, aY) (&(aMap)[(aX) + (aY) * 0x20])

extern const struct PopupComponentType* const gPopupComponentTypes[];

extern const struct BattlePopupType gBattlePopupTable[];
extern const struct BattlePopupType gPromotionPopupTable[];

#pragma long_calls

unsigned PopR_GetLength(struct PopupReworkProc* proc);
void PopR_DisplayComponents(struct PopupReworkProc* proc, struct Text* text);

#pragma long_calls_off

#endif // FE8_POPUP_REWORK_H
