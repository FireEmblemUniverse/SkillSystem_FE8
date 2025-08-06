#include "C_Code.h"
// //JOQUXY
extern ProcPtr StartClassNameIntroLetter(ProcPtr parent, u8 index);
#define brk asm("mov r11, r11");

#define CreditsSpeed 1
#define NumOfStrs 2
struct CreditsStruct
{
    signed char * header;
    signed char * body;
    u8 bg;
    u8 type;
    u8 darkenAmount;
    u8 pad;
};
extern struct CreditsStruct gCreditsData[];

#define LinesOnScreen 11 // 160y / 16 pixels, but sprites can be partially offscreen
#define LinesBuffered 13 // for moduluo
typedef struct
{
    /* 00 */ PROC_HEADER;
    s8 slotIndex[LinesBuffered]; // indexed by stringID & 0xF;
    u8 strLen[LinesBuffered];
    u16 usedRows;         // bitfield of which obj vram lines are taken up or free to use
    u16 textTypeBitfield; // bitfield of which lines are header (unset) or body (set)
    u16 indentBitfield;
    int firstLineIndex;
    int y;
    u32 clock;
    s8 textType; // Header or Body
    u8 bottomHalf;
    s8 strLine;
    u8 slot;
    u8 id;
    u8 bg;
    u8 holding;
    u8 darkenAmount;
    int totalSprites;
} CreditsTextProc;

#define SPRITE_OFFSCREEN_Y -16
//
#define CreditsText_VRAMTile 0 // 0x280
// #define CreditsTextVRAM (OBJ_VRAM0 + (CreditsText_VRAMTile << 5)) // 0x6010000
#define CreditsTextVRAM (VRAM + (CreditsText_VRAMTile << 5)) // 0x6010000
extern const u16 sSprite_08A2EF48[];
extern struct Font * gActiveFont;
// gObject_32x16
u16 const sSprite_08A2EF48_new[] = // see gSprite_UiSpinningArrows_Horizontal and sSprite_08A2EF48
    {
        1,                                                       // number of entries
        OAM0_SHAPE_16x32 | OAM0_DOUBLESIZE | OAM0_AFFINE_ENABLE, //
        OAM1_SIZE_32x32,
        0, // OAM2_CHR(CreditsText_VRAMTile),
    };

u16 const sSprite_08A2EF48_works[] = // see gSprite_UiSpinningArrows_Horizontal and sSprite_08A2EF48
    {
        1,                                                       // number of entries
        OAM0_SHAPE_16x16 | OAM0_DOUBLESIZE | OAM0_AFFINE_ENABLE, //
        OAM1_SIZE_16x16,
        0, // OAM2_CHR(CreditsText_VRAMTile),
    };

u16 const sSprite_08A2EF48_big[] = // see gSprite_UiSpinningArrows_Horizontal and sSprite_08A2EF48
    {
        1,                                                       // number of entries
        OAM0_SHAPE_16x32 | OAM0_DOUBLESIZE | OAM0_AFFINE_ENABLE, //
        OAM1_SIZE_32x32,
        0, // OAM2_CHR(CreditsText_VRAMTile),
    };

#define HeaderType 0
#define BodyType 1

extern int Width_BigChar; // 12ish
extern int DarkenAmount;

#define HEADER_X_OFFSET 0 // there's some offset from affining the letters I think..
#define BODY_X_OFFSET 14
#define INDENT_BODY_X_OFFSET 32
#define MAX_LINE_WIDTH (240 - INDENT_BODY_X_OFFSET) //(240 - 32)
#define CHAR_NEWLINE 0x01
#define CHAR_SPACE 0x20

extern u8 * const gUnknown_08A2F2C0[];

u32 BigFontInit(CreditsTextProc * proc, signed char * str, int rowID)
{
    // u16 offset = (u16)gActiveFont->vramDest & 0xFFFF;

    u16 offset = gActiveFont->chr_counter << 5;
    CpuFastFill(0, (void *)(offset + OBJ_VRAM0), 0x800);
    ApplyPalette(gUnknown_08A37300, 0x10);
    int bufferAdd = 0;

    if (proc->bottomHalf)
    {
        bufferAdd = 0x80;
        proc->textType = BodyType;
    }
    else
    {
        proc->textType = HeaderType;
    }
    proc->bottomHalf ^= 1;
    int len = 0;
    while (*str != 0)
    {
        Decompress((gUnknown_08A2F2C0[*str] != 0) ? gUnknown_08A2F2C0[*str] : gUnknown_08A2F2C0[0x58], gGenericBuffer);
        Copy2dChr(gGenericBuffer + bufferAdd, (void *)(offset + OBJ_VRAM0), 2, 2);
        len++;

        str++;
        offset += 0x40;
        if ((offset & 0x3FF) == 0) // If wrapped past a 0x400 boundary
            offset += 0x400;       // Move to next text page

        if ((int)(offset) >= 0x6018000)
        {
            offset = 0;
        }
    }
    proc->strLen[rowID] = len;

    offset += 0x800; // go to next line
    offset &= 0xF800;
    if ((int)(offset + VRAM) >= 0x6018000)
    {
        offset = 0;
    }
    // gActiveFont->vramDest = (void *)(offset + OBJ_VRAM0);
    gActiveFont->chr_counter = offset >> 5;
    // gActiveFont->tileref = ((uintptr_t)offset & 0x1FFFF) >> 5;
    return offset;
}

static inline const char * Text_DrawCharacterAscii_BL(struct Text * th, const char * str);
void InitCreditsBodyText(CreditsTextProc * proc, signed char * str, int rowID)
{
    signed char * iter;
    int line = 0; // current one
    // I guess it doesn't really matter that they all share a text handle because they are never redrawn, just moved
    // up the screen with PutSprite
    int curX = 0;
    struct Text * th = gStatScreen.text;
    if (str && *str)
    {
        InitSpriteText(&th[line]);

        SpriteText_DrawBackgroundExt(&th[line], 0); // clears the vram obj behind the sprite text
        Text_SetColor(&th[line], 0);
        iter = str;

        int nextWordWidth = 0;
        while (*iter == CHAR_NEWLINE)
        {
            iter++;
        }

        while (*iter > CHAR_NEWLINE)
        {
            curX = Text_GetCursor(&th[line]); // current x position

            if (*iter == ' ')
            {
                signed char * lookahead = iter + 1;
                nextWordWidth = gActiveFont->glyphs[(u8)*iter]->width; // include the space in width

                while (*lookahead > CHAR_NEWLINE && *lookahead != ' ' && *lookahead != CHAR_NEWLINE)
                {
                    struct Glyph * glyph = gActiveFont->glyphs[(u8)*lookahead++];
                    nextWordWidth += glyph->width;
                }

                // If the next word doesn't fit, break before this space
                if (curX + nextWordWidth > MAX_LINE_WIDTH)
                {
                    break; // wrap before the next word
                }
            }
            if (curX > MAX_LINE_WIDTH || *iter == CHAR_NEWLINE)
            {
                break;
            }
            iter = (void *)Text_DrawCharacterAscii_BL(&th[line], (void *)iter); // 160k cycles
            // iter = Text_DrawCharacter(&th[line], iter); // 278k cycles
        }
    }
    proc->strLen[rowID] = curX;
}

void PutSpriteExt(int layer, int xOam1, int yOam0, const u16 * object, int oam2);
void PutBigLetter(
    int layer, u8 charId, int x, int y, u16 xScale, u16 yScale, const u16 * object, int oam2) // based on sub_80B2A14
{
    int palID = 0;
    if (x > 240)
    {
        return;
    }
    if (yScale <= 8)
    {
        return;
    }

    if (xScale < 8)
    {
        xScale = 8;
    }
    int adjustedCharId = ((charId >> 4) * 0x30) + charId; // 16 letters per row

    int matrixId = charId & 0x1F; // affine matrix index (0-31)
    SetObjAffine(
        matrixId, Div(+COS(0) << 4, xScale), Div(-SIN(0) << 4, yScale), Div(+SIN(0) << 4, xScale),
        Div(+COS(0) << 4, yScale)); // unsure what this does, but it is needed

    oam2 += adjustedCharId * 2 + OAM2_LAYER(layer) + OAM2_PAL(palID);
    PutSpriteExt(4, (x & 0x1FF) + (matrixId << 9), y & 0x1FF, object, oam2);
}
// int layer = 1; // sub_80B2A14 uses oam2 layer 1 for first letter and layer 2 after that

unsigned int strlen(const char *);

const static u16 lut[] = {
    0x00, 0x04, 0x08, 0x0C, 0x10, 0x14, 0x18, 0x1C, 0x20,
};

extern void sub_80B2A14(u8 charId, int x, int y, u16 xScale, u16 yScale, u8 offset);
void PrintBigString(int len, int layer, int x, int y, const u16 * object, int oam2)
{
    // if (y > 160 || y < (SPRITE_OFFSCREEN_Y))
    if (y > 160)
    {
        return;
    }
    int i;
    int ix;

    for (i = 0; i < len; i++)
    {
        ix = x + (i * Width_BigChar);
        PutBigLetter(layer, i, ix, y, 0x100, 0x100, object, oam2);
        // sub_80B2A14(i, ix, y, 0x100, 0x100, 0);
    }
}

// PutSprite(2, x, proc->y + (i * 32), gObject_32x16, 0x4240 + lut[index]);
void PutNormalSpriteText(int len, int layer, int x, int y, const u16 * object, int oam2)
{ // see  PutSubtitleHelpText
    if (y > 160 || y < (-16))
    {
        return;
    }

    int i;
    int ix;
    len >>= 4;

    for (i = 0; i < 9; i++)
    {
        ix = x + (i * 32);
        PutSprite(layer, ix, y, object, oam2 + lut[i]);
    }

    return;
}

int TryAdvanceID(CreditsTextProc * proc);
int GetCurrentSlot(CreditsTextProc * proc) // after TryAdvanceID runs
{
    int lineIndex = proc->firstLineIndex + proc->slot;
    return lineIndex % LinesBuffered;
}
int GetSlotAt(CreditsTextProc * proc, int i)
{
    int lineIndex = proc->firstLineIndex + i;
    return lineIndex % LinesBuffered;
}

int ShouldAdvanceFrame(CreditsTextProc * proc);
struct ProcCmd const ProcScr_CreditsText[];
int GetDarkenAmount(void)
{
    CreditsTextProc * proc = Proc_Find(ProcScr_CreditsText);
    int darkenAmount = 0;
    if (proc)
    {
        darkenAmount = proc->darkenAmount;
    }
    if (!darkenAmount)
    {
        darkenAmount = DarkenAmount;
    }
    return darkenAmount;
}
struct ProcCmd const gUnknown_08591E00_FadeBGs[];
void CreditsTextLoop(CreditsTextProc * proc)
{
    if (!Proc_Find(gUnknown_08591E00_FadeBGs))
    {
        int darkenAmount = GetDarkenAmount();
        WriteFadedPaletteFromArchive(darkenAmount, darkenAmount, darkenAmount, 0x0000FFFF);
    }
    // PrepScreenProc_DimMapImmediate_new();
    proc->y -= ShouldAdvanceFrame(proc);

    if (!gCreditsData[proc->id].header && !gCreditsData[proc->id].body)
    { // nothing left to display, so end
        Proc_Break(proc);
        return;
    }
    if (TryAdvanceID(proc))
    {
        // return; // display nothing for a frame when redrawing stuff
    }

    int x = 0;
    int bodySprites = 0;
    int headerSprites = 0;

    for (int line = proc->firstLineIndex; line < proc->firstLineIndex + LinesBuffered; ++line)
    {
        int slot = proc->slotIndex[line % LinesBuffered];
        if (slot < 0)
            continue;
        int isBody = proc->textTypeBitfield & (1 << slot);
        int nextLine = (line + 1) % LinesBuffered;
        int nextSlot = proc->slotIndex[nextLine];
        // int nextLineIsTop = ((line + 1) % LinesBuffered) == 0;
        int nextLineIsTop = nextSlot == 0;

        int nextBody = proc->textTypeBitfield & (1 << nextSlot);
        int nextIndent = !((((proc->indentBitfield >> slot) & 1) ^ ((proc->indentBitfield >> nextSlot) & 1)));

        // both are non-zero, or both are zero

        int ix = x;
        int palID = 0;
        if (proc->indentBitfield & (1 << slot))
        {

            ix += INDENT_BODY_X_OFFSET - BODY_X_OFFSET;
        }

        if (isBody)
        {
            ix += BODY_X_OFFSET;
            palID = 1;
        }
        else
        {
            ix += HEADER_X_OFFSET;
        }

        // int line = proc->firstslotIndex + i;
        int spriteY = proc->y + (line * 16);

        if (spriteY >= SPRITE_OFFSCREEN_Y && spriteY < 160)
        {
            if (isBody)
            {
                if (spriteY < -16)
                {
                    continue;
                }
                if (nextBody && nextIndent && !nextLineIsTop)
                // if (nextBody)
                { // and next has the same indent
                    int len = proc->strLen[slot] > proc->strLen[nextSlot] ? proc->strLen[slot] : proc->strLen[nextSlot];

                    PutNormalSpriteText(len, 2, ix, spriteY, gObject_32x32, OAM2_PAL(palID) + (slot * 0x40));
                    line++;
                }

                else
                {
                    PutNormalSpriteText(
                        proc->strLen[slot], 2, ix, spriteY, gObject_32x16, OAM2_PAL(palID) + (slot * 0x40));
                }
                bodySprites += proc->strLen[slot] >> 4;
            }
            else
            {
                if (nextBody || nextLineIsTop) // next line will be body, so print only half
                {
                    PrintBigString(proc->strLen[slot], 2, ix, spriteY - 8, sSprite_08A2EF48_works, (slot * 0x40));
                }
                else
                {
                    PrintBigString(proc->strLen[slot], 2, ix, spriteY - 16, sSprite_08A2EF48_new, (slot * 0x40));
                    line++;
                }
                headerSprites += proc->strLen[slot];
            }
        }
    }
    if ((headerSprites + bodySprites) != proc->totalSprites)
    {
        proc->totalSprites = (headerSprites + bodySprites);
        if ((headerSprites + bodySprites) > 64)
        {
            // brk;
            // we have exceeded OAM limitations approx
        }
    }
}

int GetFreeRow(CreditsTextProc * proc)
{
    for (int i = 0; i < LinesBuffered; ++i)
    {
        if (!(proc->usedRows & (1 << i)))
        {
            proc->usedRows |= (1 << i);
            return i;
        }
    }
    return -1; // nothing free
}

void FreeRow(CreditsTextProc * proc, int i)
{
    i %= LinesBuffered;
    proc->slotIndex[i] = (-1);
    proc->usedRows &= ~(1 << i); // unset the bit, as it is now free.
    CpuFastFill(0, (void *)(0x800 * i + OBJ_VRAM0), 0x800);
}
int GetCurrentSlot(CreditsTextProc * proc);

void SetIndent(CreditsTextProc * proc, int slot)
{
    proc->indentBitfield |= (1 << (slot % LinesBuffered));
}
void UnsetIndent(CreditsTextProc * proc, int slot)
{
    proc->indentBitfield &= ~(1 << (slot % LinesBuffered));
}

signed char * GetStringAtLine(signed char * str, int targetLine, CreditsTextProc * proc, int slot)
{
    UnsetIndent(proc, slot);
    if (!str || targetLine < 0)
        return NULL;

    int currentLine = 0;

    while (*str)
    {
        if (currentLine == targetLine)
            return str;

        int width = 0;
        signed char * lastSpace = NULL;

        while (*str > 1)
        {
            if (*str == ' ')
                lastSpace = str;

            struct Glyph * glyph = gActiveFont->glyphs[(u8)*str];
            width += glyph->width;
            str++;

            if (width > MAX_LINE_WIDTH)
            {
                if (currentLine + 1 == targetLine)
                {
                    SetIndent(proc, slot);
                }
                if (lastSpace)
                {
                    str = lastSpace + 1; // wrap at space (skip it)
                }
                break;
            }
        }

        if (*str == CHAR_NEWLINE)
            str++;

        currentLine++;
    }

    return NULL;
}

int GetNextLineNum(signed char * str, int num)
{

    if (!str || num < -1)
        return -1;

    int currentLine = 0;

    while (*str)
    {
        if (currentLine == num + 1)
            return currentLine;

        int width = 0;
        signed char * lastSpace = NULL;

        while (*str > 1)
        {
            if (*str == ' ')
                lastSpace = str;

            struct Glyph * glyph = gActiveFont->glyphs[(u8)*str];
            width += glyph->width;
            str++;

            if (width > MAX_LINE_WIDTH)
            {

                if (lastSpace)
                {
                    str = lastSpace + 1; // wrap at last space
                }
                break;
            }
        }

        if (*str == CHAR_NEWLINE)
            str++;

        currentLine++;
    }

    return -1;
}

signed char * GetNextLineOfType(CreditsTextProc * proc, int type, int slot)
{
    int id = proc->id;
    int strLine = proc->strLine; // starts as (-1)
    signed char * str;
    signed char * originalStr;
    if (type == HeaderType)
    {
        str = gCreditsData[id].header;
        originalStr = str;
    }
    else
    {
        str = gCreditsData[id].body;
        originalStr = str;
    }

    strLine = GetNextLineNum(str, strLine); // get current line
    str = GetStringAtLine(str, strLine, proc, slot);
    if (!str || !*str)
    {
        proc->strLine = (-1);
        return NULL;
    }

    int nextLine = GetNextLineNum(originalStr, strLine); // read ahead for next line
    proc->strLine = strLine;

    if (nextLine < 0)
    {
        proc->strLine = nextLine;
    }
    return str;
}
void InitNextBG(CreditsTextProc * proc, int slot);
signed char * GetNextStrLine(CreditsTextProc * proc, int slot)
{
    int id = proc->id;
    signed char * str;
    // handle multiline?
    switch (proc->textType)
    {
        case HeaderType: // current one is header
        {
            str = GetNextLineOfType(proc, HeaderType, slot);
            if (proc->strLine == (-1))
            {
                proc->textType = BodyType; // next one will be body
            }

            return str;
            break;
        }
        case BodyType:
        {

            str = GetNextLineOfType(proc, BodyType, slot);
            if (proc->strLine == (-1))
            {
                proc->textType = HeaderType; // next one will be body
                proc->id++;                  // which gCreditsData[proc->id] entry we're on
                InitNextBG(proc, slot);
            }
            return str;
            break;
        }
    }
    return gCreditsData[id].header; // shouldn't reach
}

void sub_800EEE8_new(struct ConvoBackgroundFadeProc * proc)
{
    int currentFadeLevel = (proc->fadeTimer += proc->fadeSpeed) / 16;
    int darkenAmount = GetDarkenAmount();
    WriteFadedPaletteFromArchive(darkenAmount, darkenAmount, darkenAmount, 0x0000FFFF);

    switch (proc->fadeType)
    {
        case EVSUBCMD_TEXTSTART:
        case EVSUBCMD_REMOVEPORTRAITS:
            SetBlendAlpha(currentFadeLevel, 0x10 - currentFadeLevel);
            break;

        case EVSUBCMD_0x1A22:
            SetBlendAlpha(0x10 - currentFadeLevel, currentFadeLevel);
            break;
    }

    if (currentFadeLevel >= 0x10)
        Proc_Break(proc);
}

extern void sub_800EA84(struct ConvoBackgroundFadeProc * otherProc);
extern void sub_800EBB0(struct ConvoBackgroundFadeProc * otherProc);
extern void sub_800ED50(struct ConvoBackgroundFadeProc * otherProc);
extern void sub_800EEE8(struct ConvoBackgroundFadeProc * otherProc);
extern void sub_800EF48(struct ConvoBackgroundFadeProc * otherProc);

struct ProcCmd const gUnknown_08591E00_FadeBGs[] = {
    PROC_YIELD,

    PROC_CALL(sub_800EA84),
    PROC_YIELD,

    PROC_CALL(sub_800EBB0),
    PROC_YIELD,

    PROC_CALL(sub_800ED50),
    PROC_CALL(ArchiveCurrentPalettes),
    PROC_YIELD,

    PROC_REPEAT(sub_800EEE8_new),
    PROC_CALL(sub_800EF48),

    PROC_END,
};

struct CGDataEnt
{
    u8 ** img; // CG images have 10 parts
    u8 * tsa;
    u16 * pal;
};
// extern struct CGDataEnt  const gCGDataTable[];
extern struct CGDataEnt const * const sCGDataTable; // pointer to gCGDataTable
struct CGDataEnt const * GetCGFix(int id)
{
    return sCGDataTable + id;
}

void ModifySaveLinkArenaStruct2B(void * buf, int val);
//! FE8U = 0x080B65F8
void DisplayCGfx(u16 * tm, int offset, int palId, int palCount, int idx)
{
    int i;

    struct CGDataEnt * cgEnt = (void *)GetCGFix(idx);

    for (i = 0; i < 10; i++)
    {
        Decompress(cgEnt->img[i], (void *)(VRAM + offset + i * 0x800));
    }

    // TODO: Seems like this should use the "TILEREF" macro, but the order doesn't match
    CallARM_FillTileRect(tm, cgEnt->tsa, (u16)((palId << 12) + ((u32)(offset << 0x11) >> 0x16)));

    ApplyPalettes(cgEnt->pal, palId, palCount);

    if (idx < 0x80)
    {
        ModifySaveLinkArenaStruct2B(NULL, idx);
    }
}

void InitNextBG(CreditsTextProc * proc, int slot)
{
    int bg = gCreditsData[proc->id].bg;
    int type = gCreditsData[proc->id].type;
    int darkenAmount = gCreditsData[proc->id].darkenAmount;
    if (!darkenAmount)
    {
        darkenAmount = DarkenAmount;
    }
    if (type != 1 && type != 2)
    {
        return;
    }

    if (bg != 0x37)
    { // random bg
        if (bg == 0xFF || bg == proc->bg)
        {
            return;
        }
    }

    proc->bg = bg;
    proc->darkenAmount = darkenAmount;
    struct ConvoBackgroundFadeProc * otherProc = Proc_Start(gUnknown_08591E00_FadeBGs, (void *)3);
    otherProc->fadeType = 0;   // 0, 1, or 2
    otherProc->unkType = type; // 0 = broken, 1 = bg text, 2 = cg text
    otherProc->bgIndex = bg;
    otherProc->fadeSpeed = 2;
    otherProc->fadeTimer = 0;
    otherProc->pEventEngine = (void *)proc;

    // ReputConvoBg_unused(bg);
}

int InitNextLine(CreditsTextProc * proc, int slot)
{

    int type = proc->textType;

    proc->slot = slot;
    int rowID = GetFreeRow(proc);
    if (rowID < 0)
    {
        return false;
    }
    signed char * str = GetNextStrLine(proc, rowID);

    if (!str || !(*str))
    {
        str = GetNextStrLine(proc, slot);
        if (!str || !(*str))
        {
            return false;
            // no string of either type, so end everything
        }
    }

    proc->slotIndex[slot] = rowID;

    switch (type)
    {
        case HeaderType: // current one is header
        {
            proc->textTypeBitfield &= ~(1 << rowID);
            BigFontInit(proc, str, rowID);
            return true;
            break;
        }
        case BodyType:
        {
            proc->textTypeBitfield |= (1 << rowID);
            InitCreditsBodyText(proc, (void *)str, rowID);
            return true;
            break;
        }
    }
    return false;
}

int TryAdvanceID(CreditsTextProc * proc)
{
    for (int i = 0; i < LinesBuffered; ++i)
    {
        int lineIndex = proc->firstLineIndex + i;
        int spriteY = proc->y + (lineIndex * 16);
        int slot = lineIndex % LinesBuffered;
        if (spriteY < SPRITE_OFFSCREEN_Y && proc->slotIndex[slot] >= 0)
        {
            FreeRow(proc, slot);
            if (!slot)
            {
                gActiveFont->chr_counter = 0;
            }
        }
        if (spriteY >= SPRITE_OFFSCREEN_Y && spriteY < 160)
        {
            if (proc->slotIndex[slot] < 0)
            {
                InitNextLine(proc, slot);
                // InitNextBG(proc, slot);
            }
        }
    }

    return false;
}

void InitCreditsText(CreditsTextProc * proc)
{
    ResetText();
    ResetTextFont();
    InitSpriteTextFont(&gHelpBoxSt.font, OBJ_VRAM0, 0x11);
    SetTextFontGlyphs(1);
    ApplyPalette(gUnknown_0859EF20, 0x11);
    // ApplyPalette(Pal_Text, 0x11);
}

struct ProcCmd const ProcScr_CreditsText[] = {
    PROC_NAME("Vesly's Credits Proc"),
    PROC_SLEEP(0),
    PROC_CALL(LockGame),
    PROC_CALL(BMapDispSuspend),
    PROC_CALL(InitCreditsText),
    PROC_REPEAT(CreditsTextLoop),
    PROC_CALL(StartFastFadeToBlack),
    PROC_REPEAT(WaitForFade),
    PROC_END_EACH(gUnknown_08591E00_FadeBGs),
    PROC_SLEEP(16),

    PROC_CALL(UnlockGame),
    PROC_CALL(BMapDispResume), // why is this needed twice ?
    // PROC_CALL(BMapDispResume),
    // PROC_CALL(RefreshBMapGraphics),
    PROC_CALL(RefreshUnitSprites),

    // PROC_CALL(StartFastFadeFromBlack),
    // PROC_REPEAT(WaitForFade),
    PROC_END,
};

void StartCreditsProc_ASMC(ProcPtr parent)
{
    // RegisterBlankTile(0x400);
    // BG_Fill(gBG3TilemapBuffer, 0);
    // BG_EnableSyncByMask(BG0_SYNC_BIT | BG1_SYNC_BIT | BG3_SYNC_BIT);
    // CreditsTextProc * proc = Proc_Start(ProcScr_CreditsText, (void *)3);
    CreditsTextProc * proc = Proc_StartBlocking(ProcScr_CreditsText, parent);

    for (int i = 0; i < LinesBuffered; ++i)
    {
        proc->slotIndex[i] = (-1); // do not use if -1
        proc->strLen[i] = 0;
    }
    proc->usedRows = 0;
    proc->textTypeBitfield = 0;
    proc->indentBitfield = 0;
    proc->firstLineIndex = 0;
    proc->y = 160;
    proc->clock = GetGameClock();
    proc->textType = 0;
    proc->bottomHalf = 0;
    proc->strLine = (-1);
    proc->slot = 0;
    proc->id = 0;
    proc->totalSprites = 0;
    proc->holding = 0;
    proc->bg = 0xFF;
    proc->darkenAmount = 0;
    InitNextBG(proc, 0);
}

extern int HeldButtonSpeed;
extern int SkipWithStartEnabled;
extern int DefaultSpeed;
extern struct KeyStatusBuffer sKeyStatusBuffer;
int ShouldAdvanceFrame(CreditsTextProc * proc)
{
    u32 clock = GetGameClock();
    u16 keys = sKeyStatusBuffer.newKeys | sKeyStatusBuffer.heldKeys;
    int speed = DefaultSpeed;
    int multiplier = false;
    if (keys & (B_BUTTON | A_BUTTON))
    {
        speed = HeldButtonSpeed;
        multiplier = proc->holding >> 5;

        proc->holding++;
        if (proc->holding > 0x20)
        {
            proc->holding = 0x20;
        }
    }
    else
    {
        proc->holding = 0;
    }
    if (keys & (START_BUTTON))
    {
        if (SkipWithStartEnabled)
        {
            Proc_Break(proc);
        }
    }
    if ((clock - proc->clock) >= speed)
    {
        proc->clock = clock;
        if (proc->y < -(proc->firstLineIndex * 16 + 16))
        {
            proc->firstLineIndex++;
        }

        return 1 * (1 + multiplier);
    }
    else
    {
        return false;
    }
}

inline void * GetSpriteTextDrawDest_BL(struct Text * text)
{
    int r1 = (text->db_id * text->tile_width + text->chr_position + text->x / 8);
    return gActiveFont->vramDest + r1 * 32;
}
inline u16 * GetColorLut_BL(int color)
{
    return s2bppTo4bppLutTable[color];
}

static inline u32 * DrawHalfRow(u32 * dest, u32 * bitmap, u16 * r8, int xoffset)
{
    u64 bmpRow;
    for (int i = 0; i < 8; i++)
    {

        // read one row of 32 bits from the bitmap
        bmpRow = (u64)*bitmap << xoffset * 2;
        bitmap++;
        u32 val0 = bmpRow & 0xFF;
        u32 val1 = (bmpRow >> 8) & 0xFF;
        u32 val2 = (bmpRow >> 16) & 0xFF;
        u32 val3 = (bmpRow >> 24) & 0xFF;
        u32 val4 = (bmpRow >> 32) & 0xFF;
        u32 val5 = (bmpRow >> 40) & 0xFF;

        dest[0] |= r8[val0] | (r8[val1] << 16);
        dest[8] |= r8[val2] | (r8[val3] << 16);
        dest[16] |= r8[val4] | (r8[val5] << 16);

        dest++;
    }
    return bitmap;
}
static inline void DrawSpriteTextGlyph_BL(struct Text * text, struct Glyph * glyph)
{
    u32 * dest = GetSpriteTextDrawDest_BL(text);
    int xoffset = text->x & 7;
    u32 * bitmap = glyph->bitmap;
    u16 * r8 = GetColorLut_BL(text->colorId);

    bitmap = DrawHalfRow(dest, bitmap, r8, xoffset);

    dest = GetSpriteTextDrawDest_BL(text) + 0x400;
    bitmap = DrawHalfRow(dest, bitmap, r8, xoffset);

    text->x += glyph->width;
}

static inline const char * Text_DrawCharacterAscii_BL(struct Text * th, const char * str)
{
    struct Glyph * glyph = gActiveFont->glyphs[(u8)*str++];

    if (glyph == NULL)
        glyph = gActiveFont->glyphs['?'];

    DrawSpriteTextGlyph_BL(th, glyph);
    return str;
}
