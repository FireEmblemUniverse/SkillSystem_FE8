#ifndef GBAFE_MENU_H
#define GBAFE_MENU_H

// bmmenu.c?

#include "proc.h"
#include "text.h"

typedef struct MenuGeometry MenuGeometry;

typedef struct MenuDefinition MenuDefinition;
typedef struct MenuCommandDefinition MenuCommandDefinition;

typedef struct MenuProc MenuProc;
typedef struct MenuCommandProc MenuCommandProc;

struct MenuGeometry {
	u8 x, y, h, w;
};

struct MenuDefinition {
	/* 00 */ struct MenuGeometry geometry;

	/* 04 */ u8 style;

	/* 08 */ const struct MenuCommandDefinition* commandList;

	/* 10 */ void(*onEnd)(MenuProc*);
	/* 0C */ void(*onInit)(MenuProc*);
	/* 14 */ void(*_u14)(MenuProc*);
	/* 18 */ void(*onBPress)(MenuProc*, MenuCommandProc*);
	/* 1C */ void(*onRPress)(MenuProc*);
	/* 20 */ void(*onHelpBox)(MenuProc*, MenuCommandProc*);
};

struct MenuCommandDefinition {
	/* 00 */ const char* rawName;

	/* 04 */ u16 nameId, helpId;
	/* 08 */ u8 colorId, _u09;

	/* 0C */ int(*isAvailable)(const MenuCommandDefinition*, int);

	/* 10 */ void(*onDraw)(MenuProc*, MenuCommandProc*);

	/* 14 */ int(*onEffect)(MenuProc*, MenuCommandProc*);
	/* 18 */ int(*onIdle)(MenuProc*, MenuCommandProc*);

	/* 1C */ void(*onSwitchIn)(MenuProc*, MenuCommandProc*);
	/* 20 */ void(*onSwitchOut)(MenuProc*, MenuCommandProc*);
};

struct MenuProc {
	/* 00 */ PROC_HEADER;

	/* 2C */ struct MenuGeometry geometry;
	/* 30 */ const MenuDefinition* pDefinition;

	/* 34 */ struct MenuCommandProc* pCommandProc[11];

	/* 60 */ u8 commandCount;
	/* 61 */ u8 commandIndex;
	/* 62 */ u8 prevCommandIndex;
	/* 63 */ u8 stateBits;

	/* 64 */ u8 backBgId : 3;
	/* 64 */ u8 frontBgId : 3;

	/* 66 */ u16 tileBase;
	/* 68 */ u16 _u68;
};

struct MenuCommandProc {
	/* 00 */ PROC_HEADER;

	/* 2A */ u16 xDrawTile;
	/* 2C */ u16 yDrawTile;

	/* 30 */ const struct MenuCommandDefinition* pDefinition;

	/* 34 */ struct TextHandle text;

	/* 3C */ u8 commandDefinitionIndex;
	/* 3D */ u8 availability;
};

enum {
	// Menu command availability values

	MCA_USABLE = 1,
	MCA_GRAYED = 2,
	MCA_NONUSABLE = 3,
};

enum MenuEffect {
	//
	ME_NONE = 0,

	ME_DISABLE = (1 << 0),
	ME_END = (1 << 1),
	ME_PLAY_BEEP = (1 << 2),
	ME_PLAY_BOOP = (1 << 3),
	ME_CLEAR_GFX = (1 << 4),
	ME_END_FACE0 = (1 << 5),
	ME_END_AFTER = (1 << 7),
};

// TODO: move to ui.h
void UpdateHandCursor(int x, int y); //! FE8U = (0804E79C+1)

MenuProc* StartMenuAdjusted(const MenuDefinition*, int xScreen, int xLeft, int xRight); //! FE8U = 0x804EB99
MenuProc* StartMenuChild(const MenuDefinition*, Proc* parent); //! FE8U = 0x804EBC9
MenuProc* StartMenu(const MenuDefinition*); //! FE8U = 0x804EBE5
MenuProc* StartMenuExt2(const MenuDefinition*, int backBgId, u16 baseTile, int frontBgId, int idk, Proc* parent); //! FE8U = 0x804EC35
MenuProc* StartMenuAt(const MenuDefinition*, MenuGeometry, Proc* parent); //! FE8U = 0x804EC99
MenuProc* StartMenuExt(const MenuDefinition*, MenuGeometry, int backBgId, u16 baseTile, int frontBgId, int idk, Proc* parent); //! FE8U = 0x804ECB1

Proc* EndMenu(MenuProc*); //! FE8U = 0x804EEA9
void EndAllMenus(MenuProc*); //! FE8U = 0x804EF21

// internal stuff
// Menu_CallDefinedConstructors //! FE8U = 0x804EF39
// Menu_Draw //! FE8U = 0x804EF71
// Menu_DrawHoverThing //! FE8U = 0x804F0E1
// Menu_Idle //! FE8U = 0x804F165
// Menu_HandleDirectionInputs //! FE8U = 0x804F295
// Menu_HandleSelectInputs //! FE8U = 0x804F375
// Menu_GetCursorGfxCurrentPosition //! FE8U = 0x804F401

// default usability
int MenuCommandAlwaysUsable(const MenuCommandDefinition*, int); //! FE8U = 0x804F449
int MenuCommandAlwaysGrayed(const MenuCommandDefinition*, int); //! FE8U = 0x804F44D
int MenuCommandNeverUsable(const MenuCommandDefinition*, int); //! FE8U = 0x804F451

// menu state modifiers
void MenuCallHelpBox(MenuProc*, u16 textId); //! FE8U = 0x804F581

// void MarkSomethingInMenu(void); // Draw Cursor while disabled //! FE8U = 0x804F60D

// MenuProc* StartMenu_AndDoSomethingCommands(const MenuDefinition*, int xScreen, int xLeft, int xRight); //! FE8U = 0x804F64D
// void Menu_UpdateMovingCursorGfxPosition(MenuProc*, int, int*); //! FE8U = 0x804F6A5
void ClearMenuCommandOverride(void); //! FE8U = 0x804F6F9

#endif // GBAFE_MENU_H
