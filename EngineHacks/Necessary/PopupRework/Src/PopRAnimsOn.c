#include "PopupRework.h"

// TODO: add to libgbafe {

extern const u8 gGfx_BattlePopup[];
extern const u16 gPal_BattlePopup[];
extern const u8 gTsa_BattlePopup[];
extern const u8 gGfx_BattlePopupTextBg[];
extern const u32 gAnimScr_PopupIcon[];

extern u8 gSpellFxTsaBuffer[];

//extern struct FontData gSomeFontStruct;

void MakeBattlePopupTileMapFromTSA(u16* bgOut, u16 size) __attribute__((long_call));
void SomeBattlePlaySound_8071990(int id, int volume) __attribute__((long_call));

// }

struct PopupReworkAnimsOnProc {
	struct PopupReworkProc popr;
	struct Anim* iconAis;
};

static void PopR_AnimsOnAddIcon(struct PopupReworkProc* proc, unsigned iconId, unsigned xOffset);
static void PopR_AnimsOnDraw(struct PopupReworkAnimsOnProc* proc);
static void PopR_AnimsOnWait(struct PopupReworkAnimsOnProc* proc);
static void PopR_AnimsOnCleanup(struct PopupReworkAnimsOnProc* proc);

static const struct ProcCmd sProc_PopRAnimsOnPopup[] = {
	PROC_SET_END_CB(PopR_AnimsOnCleanup),

	PROC_SLEEP(0),

	PROC_CALL(PopR_AnimsOnDraw),
	PROC_REPEAT(PopR_AnimsOnWait),

	PROC_END
};

static struct PopupReworkProc* PopR_StartAnimsOnPopup(const u32* definition, unsigned time, struct Proc* parent) {
	struct PopupReworkAnimsOnProc* proc = (struct PopupReworkAnimsOnProc*) Proc_StartBlocking(
		sProc_PopRAnimsOnPopup, parent
	);

	proc->popr.pop.pDefinition = definition;
	proc->popr.pop.iconPalId   = 0x12;

	if (time == 0)
		proc->popr.pop.clock = -1;
	else
		proc->popr.pop.clock = time;

	proc->popr.addIcon = PopR_AnimsOnAddIcon;
	proc->iconAis       = NULL;

	return (struct PopupReworkProc*) (proc);
}

static void PopR_AnimsOnAddIcon(struct PopupReworkProc* proc, unsigned iconId, unsigned xOffset) {
	struct PopupReworkAnimsOnProc* const pproc = (struct PopupReworkAnimsOnProc*) proc;

	if (pproc->iconAis)
		AnimDelete(pproc->iconAis);

	pproc->iconAis = AnimCreate(gAnimScr_PopupIcon, 150);

	pproc->iconAis->oam2Base  = 0x2440;
	pproc->iconAis->xPosition = proc->pop.xTileReal + 0x10 + xOffset;
	pproc->iconAis->yPosition = proc->pop.yTileReal + 0x08;

	LoadIconObjectGraphics(iconId, 0x40);
}

static void PopR_AnimsOnDraw(struct PopupReworkAnimsOnProc* proc) {
	static const unsigned BOX_GFX_TILE  = 0x100;
	static const unsigned TEXT_GFX_TILE = 0x108;
	static const unsigned TEXT_PAL      = 0;
	static const unsigned BOX_PAL       = 1;
	static void* const    BOX_GFX_VRAM  = (void*)(VRAM + BOX_GFX_TILE * 0x20);
	static void* const    TEXT_GFX_VRAM = (void*)(VRAM + TEXT_GFX_TILE * 0x20);

	proc->popr.pop.xGfxSize = PopR_GetLength(&proc->popr);

	unsigned xTileSize    = (proc->popr.pop.xGfxSize + 7) / 8;
	unsigned xStartOffset = (xTileSize*8 - proc->popr.pop.xGfxSize)/2;

	proc->popr.pop.xTileReal = ((240 - (xTileSize+4)*8) / 2);
	proc->popr.pop.yTileReal = 48;

	InitTextFont(&gSomeFontStruct, TEXT_GFX_VRAM, TEXT_GFX_TILE, TEXT_PAL);
	SetTextDrawNoClear();

	struct Text text;
	InitText(&text, xTileSize);

	CopyToPaletteBuffer(gPal_BattlePopup, BOX_PAL * 0x20, 0x20);
	gPaletteBuffer[0x10 * TEXT_PAL + 14] = gPaletteBuffer[0x10 * BOX_PAL + 14];

	Decompress(gGfx_BattlePopup, BOX_GFX_VRAM);
	Decompress(gGfx_BattlePopupTextBg, TEXT_GFX_VRAM);

	Text_SetCursor(&text, xStartOffset);

	PopR_DisplayComponents(&proc->popr, &text);

	Decompress(gTsa_BattlePopup, gSpellFxTsaBuffer);
	MakeBattlePopupTileMapFromTSA(gBG1TilemapBuffer, xTileSize);

	PutText(&text, BG_LOCATED_TILE(gBG1TilemapBuffer, 2, 1));

	BG_SetPosition(1, -proc->popr.pop.xTileReal, -proc->popr.pop.yTileReal);

	BG_EnableSync(1);

	SetDefaultColorEffects();

	SomeBattlePlaySound_8071990(proc->popr.pop.soundId, 0x100);
}

static void PopR_AnimsOnWait(struct PopupReworkAnimsOnProc* proc) {
	if (proc->popr.pop.clock < 0) {
		if (gKeyStatusPtr->heldKeys & A_BUTTON)
			Proc_Break((struct Proc*) (proc));
	} else {
		if (proc->popr.pop.clock == 0)
			Proc_Break((struct Proc*) (proc));
		else
			proc->popr.pop.clock--;
	}
}

static void PopR_AnimsOnCleanup(struct PopupReworkAnimsOnProc* proc) {
	if (proc->iconAis)
		AnimDelete(proc->iconAis);

	BG_Fill(gBG1TilemapBuffer, 0);
	BG_EnableSync(1);
}

struct AnimsOnWrapperProc {
	/* 00 */ PROC_HEADER;

	/* 2C */ const struct BattlePopupType* itPop;
};

static void PopR_AnimsOnWrapperLoop(struct AnimsOnWrapperProc* proc);
static void PopR_AnimsOnWrapperCleanup(struct AnimsOnWrapperProc* proc);

static const struct ProcCmd sProc_PopR_AnimsOnWrapper[] = {
	PROC_SET_END_CB(PopR_AnimsOnWrapperCleanup),
	PROC_SLEEP(10),

PROC_LABEL(0),
	PROC_REPEAT(PopR_AnimsOnWrapperLoop),
	PROC_SLEEP(8),

	PROC_GOTO(0),

PROC_LABEL(1),
	PROC_END
};

void PopR_StartBattlePopups(void) {
	struct AnimsOnWrapperProc* proc = (struct AnimsOnWrapperProc*) Proc_Start(sProc_PopR_AnimsOnWrapper, ROOT_PROC(3));

	gpProcEkrPopup = (struct Proc*) (proc);
	gEkrPopupEnded = FALSE;

	if (gEkrDistanceType == 4)
		// Promoting!
		proc->itPop = gPromotionPopupTable;

	else
		// Not Promoting!
		proc->itPop = gBattlePopupTable;

	Sound_SetSEVolume(0x80);
}

static void PopR_AnimsOnWrapperLoop(struct AnimsOnWrapperProc* proc) {
	const struct BattlePopupType type = *proc->itPop++;

	if (!type.tryInit) {
		Proc_Goto((struct Proc*) (proc), 1);
		return;
	}

	if (!type.tryInit()) {
		Proc_Goto((struct Proc*) (proc), 0);
		return;
	}

	PopR_StartAnimsOnPopup(type.definition, type.time, (struct Proc*) (proc));
	Proc_Break((struct Proc*) (proc));
}

static void PopR_AnimsOnWrapperCleanup(struct AnimsOnWrapperProc* proc) {
	gEkrPopupEnded = TRUE;
	Sound_SetSEVolume(0x100);
}
