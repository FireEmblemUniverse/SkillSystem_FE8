#ifndef GBAFE_TEXT_H
#define GBAFE_TEXT_H

#include "common.h"

typedef struct FontData FontData;
typedef struct TextHandle TextHandle;
typedef struct TextBatchEntry TextBatchEntry;
typedef struct FontGlyphData FontGlyphData;

typedef enum FontGlyphType FontGlyphType;

struct FontData {
	/* 00 */ void* pVRAMTileRoot;
	/* 04 */ const void* pGlyphData;

	/* 08 */ void (*drawGlyph)(TextHandle*, const FontGlyphData*);
	/* 0C */ void*(*getDrawTarget)(TextHandle*);

	/* 10 */ u16 tileBase;
	/* 12 */ u16 tileNext;
	/* 14 */ u16 palIndex;

	/* 16 */ u8 unk16;
	/* 17 */ u8 unk17;
};

struct TextHandle {
	/* 00 */ u16 tileIndexOffset;

	/* 02 */ u8 xCursor;
	/* 03 */ u8 colorId;
	
	/* 04 */ u8 tileWidth;

	/* 05 */ u8 useDoubleBuffer;
	/* 06 */ u8 currentBufferId;

	/* 07 */ u8 unk07;
};

struct TextBatchEntry {
	/* 00 */ struct TextHandle* textHandle;
	/* 04 */ unsigned tileWidth;
};

struct FontGlyphData {
	/* 00 */ const FontGlyphData* pNextMaybe;
	/* 04 */ u8 wcbyte2;
	/* 05 */ u8 pxLength;
	/* 08 */ u32 lines2bpp[0x10];
};

enum FontGlyphType {
	FONT_GLYPH_UI = 0,
	FONT_GLYPH_DIALOGUE = 1,
};

enum
{
	// TODO: maybe use names that also reflect meaning for dialogue colors (this is ui colors)

	TEXT_COLOR_NORMAL = 0,
	TEXT_COLOR_GRAY   = 1,
	TEXT_COLOR_BLUE   = 2,
	TEXT_COLOR_GOLD   = 3,
	TEXT_COLOR_GREEN  = 4,
	TEXT_COLOR_BLACK  = 5,
};

extern struct FontData gDefaultFontData;
extern struct FontData* gpCurrentFont;

void Text_InitFont(void); //! FE8U = 0x8003C95
void Text_InitFontExt(struct FontData* pData, void* pVRAMTileRoot, u16 tileBase, int palIndex); //! FE8U = 0x8003CB9
void Text_SetFontStandardGlyphSet(int typeId); //! FE8U = 0x8003CF5
void Text_ResetTileAllocation(void); //! FE8U = 0x8003D21
void Text_SetFont(struct FontData*); //! FE8U = 0x8003D39

void Text_InitClear(struct TextHandle*, unsigned tileWidth); //! FE8U = 0x8003D5D
void Text_InitDB(struct TextHandle*, unsigned tileWidth); //! FE8U = 0x8003D85
void InitClearTextBatch(const TextBatchEntry[]); //! FE8U = 0x8003DAD

void Text_Clear(struct TextHandle*); //! FE8U = 0x8003DC9

int Text_GetXCursor(struct TextHandle*); //! FE8U = 0x8003E51
struct TextHandle* Text_SetXCursor(struct TextHandle*, int); //! FE8U = 0x8003E55
struct TextHandle* Text_Advance(struct TextHandle*, int); //! FE8U = 0x8003E59

struct TextHandle* Text_SetColorId(struct TextHandle*, int); //! FE8U = 0x8003E61
int Text_GetColorId(struct TextHandle*); //! FE8U = 0x8003E65

struct TextHandle* Text_SetParameters(struct TextHandle*, int cursor, int color); //! FE8U = 0x8003E69

void Text_Display(struct TextHandle*, u16* bgMap); //! FE8U = 0x8003E71
void Text_DisplayBlank(struct TextHandle*, u16* bgMap); //! FE8U = 0x8003EBD

unsigned Text_GetStringTextWidth(const char*); //! FE8U = 0x8003EDD
const char* GetCharTextWidth(const char* in, unsigned* out); //! FE8U = 0x8003F3D
unsigned Text_GetStringTextCenteredPos(unsigned fullLen, const char* cstring); //! FE8U = 0x8003F91

const char* Text_GetStringNextLine(const char*); //! FE8U = 0x8003FF5

void Text_DrawString(struct TextHandle*, const char*); //! FE8U = 0x8004005
void Text_DrawNumber(struct TextHandle*, int); //! FE8U = 0x8004075
void Text_DrawNumberOr2Dashes(struct TextHandle*, u8); //! FE8U = 0x8004145
void Text_DrawChar(struct TextHandle*, char); //! FE8U = 0x8004181

// TODO: figure more out
// (I only have vague knowledge on what most things past here does)

void* Text_GetDst1dText(struct TextHandle*); //! FE8U = 0x80041E9
const u16* Get2bppTo4bppLookup(int); //! FE8U = 0x8004209
void DrawGlyph1DTile(struct TextHandle*, const struct FontGlyphData*); //! FE8U = 0x8004219
void DrawGlyph1DTileNoClear(struct TextHandle*, const struct FontGlyphData*); //! FE8U = 0x8004269

void Font_LoadForUI(void); //! FE8U = 0x80043A9
void Font_LoadForDialogue(void); //! FE8U = 0x80043E9
void Font_SetDraw1DTileNoClear(void); //! FE8U = 0x8004429

void DrawTextInline(struct TextHandle*, u16* bg, int color, int xStart, int tileWidth, const char* cstring); //! FE8U = 0x800443D
void Text_InsertString(struct TextHandle*, int xPos, int color, const char* str); //! FE8U = 0x8004481
void Text_InsertNumberOr2Dashes(struct TextHandle*, int xPos, int color, u8); //! FE8U = 0x80044A5

void Text_AppendStringAscii(struct TextHandle*, const char*); //! FE8U = 0x80044C9
void Text_AppendCharAscii(struct TextHandle*, char); //! FE8U = 0x8004505

const char* GetCharTextWidthAscii(const char* in, unsigned* out); //! FE8U = 0x8004539
unsigned GetStringTextWidthAscii(const char*); //! FE8U = 0x8004569

void Font_InitForObj(struct FontData*, void* vram, int pal); //! FE8U = 0x800459D
void Text_Init2DLine(struct TextHandle*); //! FE8U = 0x80045D9
void Text_Fill2DLine(struct TextHandle*); //! FE8U = 0x80046B5

void DrawSpecialUiChar(u16* out, int color, int chr);
void DrawUiNumber(u16* out, int color, int number);
void DrawUiNumberOrDoubleDashes(u16* out, int color, int number);

#endif // GBAFE_TEXT_H
