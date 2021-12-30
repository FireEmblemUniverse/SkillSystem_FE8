#ifndef GBAFE_POPUP_H
#define GBAFE_POPUP_H

#include <stdint.h>

#include "proc.h"
#include "unit.h"

struct PopupProc {
	/* 00 */ PROC_HEADER;

	/* 2C */ const u32* pDefinition;
	/* 30 */ int clock;

	/* 34 */ s8 xTileParam;
	/* 35 */ s8 yTileParam;

	/* 36 */ u8 winStyle;

	/* 37 */ u8 xTileReal;
	/* 38 */ u8 yTileReal;

	/* 39 */ u8 xTileSize;
	/* 3A */ u8 yTileSize;

	/* 3B */ u8 textColorId;

	/* 3C */ u16 _pad3C;

	/* 3E */ u16 iconId;
	/* 40 */ u16 iconObjTileId;
	/* 42 */ u8  iconPalId;
	/* 43 */ u8  _pad43;
	/* 44 */ u8  iconX;
	/* 45 */ u8  _pad45;

	/* 46 */ u16 xGfxSize;

	/* 48 */ u16 soundId;
};

extern struct Unit* gpPopupUnit;
extern u16 gPopupItem;
extern u32 gPopupNumber;

extern struct Proc* gpBattlePopupProc; //! FE8U = 0x2020140
extern int gBattlePopupEnded; //! FE8U = 0x2020144

void SetPopupUnit(struct Unit* unit); //! FE8U = 0x8011451
void SetPopupItem(u16 item); //! FE8U = 0x801145D
void SetPopupNumber(u32 number); //! FE8U = 0x8011469
void Popup_Create(const u32* def, int time, int winStyle, struct Proc* parent); //! FE8U = 0x8011475
// Popup_CreateExt; //! FE8U = 0x8011491

// ¯\_(ツ)_/¯
#define SetPopupWType SetPopupItem
#define gPopupWType gPopupItem

#endif // GBAFE_POPUP_H
