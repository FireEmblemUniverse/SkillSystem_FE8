#ifndef HEARDEREXT_TSAANIME
#define HEARDEREXT_TSAANIME

#include "include/gbafe.h"

typedef u16 COLOR;
inline COLOR RGB15(u32 red, u32 green, u32 blue)
{   return red | (green<<5) | (blue<<10);   }


typedef struct TsaAnime TsaAnime;
typedef struct TsaAnimeInfo TsaAnimeInfo;
struct TsaAnime{
	u32* Gfx;
	u16* Pal;
	u32* TSA;
};
struct TsaAnimeInfo{
	s16 x;
	s16 y;
	u16 SoundIndex;
};

typedef struct ProcTsaAnime ProcTsaAnime;
struct ProcTsaAnime{
	PROC_FIELDS;
	/* 0x29 */	s8 xPos;
	/* 0x2A */	s8 yPos;
	/* 0x2B */	u8 IsSoundStart;
	/* 0x2C */	TsaAnime* Animes;
	/* 0x30 */	TsaAnimeInfo* AnimeInfo;
	/* 0x34 */	u32 _unk34;
	/* 0x38 */	u32 _unk38;
	/* 0x3C */	u32 _unk3C;
	/* 0x40 */	u16 GfxIndex;
	/* 0x42 */	u16	Timer;	
	/* 0x44 */	u16	Page_Flip;
	/* 0x46 */	u16	_unk46;
	/* 0x48 */	s16	PalFix;		// Maybe related to Pal
	/* 0x4A */	s16	PalIndex;
	/* 0x4C */	s16 Page_Cur;
	
};

void EventStartAnime(Proc* proc);
void StartTsaAnime(Proc* proc, TsaAnime AnimeSet[],TsaAnimeInfo*, s8 x, s8 y);
void pTSA_SetLcd(ProcTsaAnime* proc);
void pTSA_SetPal(ProcTsaAnime* proc);
void pTSA_Idle(ProcTsaAnime* proc);
void pTSA_ResetMap(ProcTsaAnime* proc);
void pTSA_ResetLcd(ProcTsaAnime* proc);

extern const ProcCode gProc_TsaAnime[];
extern TsaAnime TsaAnime_Lightning[];
extern TsaAnimeInfo TsaAnimeInfo_Lightning;

extern const u32 FlipPageGfxOffset[]; // 0x8205884
extern const u8 FlipPagePalOffset[]; // 0x820588C	或许与Pal偏移量有关
#define MaybeSaveSomethingForGfx ( (void(*)(u16*,u8*,u32,u32,u16) )(0x800159C+1))

#endif