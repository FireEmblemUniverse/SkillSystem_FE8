#ifndef GBAFE_WM_H
#define GBAFE_WM_H

struct GMapData
{
	/* 00 */ u8 state;
	/* 01 */ u8 unk01;
	/* 02 */ short xCamera;
	/* 04 */ short yCamera;
	/* 08 */ u32 unk08;
	/* 0C */ u32 unk0C;
	/* 10 */ struct { u8 state, location; u16 unk; } units[4];
	/* 20 */ struct { u8 state, location; u16 unk; } unk20[4];
	/* 30 */ struct { u8 unk; } unk30[0x1D];
};

extern struct GMapData gGMData;

#endif // GBAFE_WM_H
