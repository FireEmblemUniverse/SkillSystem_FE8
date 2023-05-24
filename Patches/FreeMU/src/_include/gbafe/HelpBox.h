#pragma once
#include "gbafe.h"

typedef struct HelpBoxProc HelpBoxProc;
struct HelpBoxProc
{
    /* 00 */ PROC_HEADER;

    /* 2C */ const struct HelpBoxInfo* info;

    /* 30 */ short xBox;
    /* 32 */ short yBox;
    /* 34 */ short wBox;
    /* 36 */ short hBox;
    /* 38 */ short xBoxInit;
    /* 3A */ short yBoxInit;
    /* 3C */ short xBoxFinal;
    /* 3E */ short yBoxFinal;
    /* 40 */ short wBoxInit;
    /* 42 */ short hBoxInit;
    /* 44 */ short wBoxFinal;
    /* 46 */ short hBoxFinal;
    /* 48 */ short timer;
    /* 4A */ short timerMax;

    /* 4C */ u16 mid;
    /* 4E */ u16 item;

    /* 50 */ u16 moveKey; // move ctrl proc only

    /* 52 */ u8 unk52;

    // NOTE: there's likely more, need to decompile more files
};


typedef struct HelpBoxInfo HelpBoxInfo;
struct HelpBoxInfo
{
    /* 00 */ const struct HelpBoxInfo* adjUp;
    /* 04 */ const struct HelpBoxInfo* adjDown;
    /* 08 */ const struct HelpBoxInfo* adjLeft;
    /* 0C */ const struct HelpBoxInfo* adjRight;
    /* 10 */ u8 xDisplay;
    /* 11 */ u8 yDisplay;
    /* 12 */ u16 mid;
    /* 14 */ void(*redirect)(HelpBoxProc* proc);
    /* 18 */ void(*populate)(HelpBoxProc* proc);
};

typedef struct HelpTextRAM HelpTextRAM;
struct HelpTextRAM{
	/* 00 */ u16 unk0;
	/* 02 */ u16 unk2;
	/* 04 */ u8 unk4[0x2C-0x4];
	/* 2C */ const HelpBoxInfo* info;
};

extern const ProcInstruction gProc_HelpTextBubble[]; // 0x8A00AD0
extern struct HelpTextRAM gHelpTextOriginTile; // 0x203E788

void LoadDialogueBoxGfx(void* dest, s8 index); // 0x8089805
void SetHelpBox_ByItem(u16 x, u16 y, u16 item);// 0x8088E61
void SetHelpBox_ByText(u16 x, u16 y, u16 textIndex);// 0x8088DE1
void DrawMenuItem_Wpn_HelpBoxText(u16 item); // 8089CD4