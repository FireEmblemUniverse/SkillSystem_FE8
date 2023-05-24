#pragma once
//#include "gbafe.h"

typedef struct PanelProc PanelProc;
struct PanelProc{
	/* 00 */ PROC_HEADER;
	
	/* 2C */ Unit* unit;
	/* 30 */ u8 xPos;
	/* 31 */ u8 yPos;
	/* 32 */ u8 IconPalIndex;
	/* 33 */ s8 ItemSlotIndex;
	/* 34 */ TextHandle text[6];
	/* 64 */ u8 _unk64;
};



extern const ProcInstruction gProc_MenuItemPanel[]; // FE8U 0x859AE88

void ForceMenuItemPanel(MenuProc* pmu, Unit*, u8 x, u8 y); // 0x801E685
void MenuItemPanel_Idle(PanelProc* proc); // 0x801E684
void UpdateMenuItemPanel(s8 index); // 0x801E749
void EndMenuItemPanel(void); // 0x801EA55


extern const struct ObjData* ObjData_859A530[];
extern const struct ObjData* ObjData_859A53C[];