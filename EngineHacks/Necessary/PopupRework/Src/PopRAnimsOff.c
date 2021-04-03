#include "PopupRework.h"

struct PopRAnimsOffIconUpdater;

struct PopupReworkAnimsOffProc {
	/* 00 */ struct PopupReworkProc popr;
	/* 50 */ struct PopRAnimsOffIconUpdater* pIconUpdater;
};

static void PopR_AnimsOffAddIcon(struct PopupReworkProc* proc, unsigned iconId, unsigned xOffset);

void PopR_AnimsOffDisplay(struct PopupReworkProc* proc) {
	// Set custom proc stuff

	proc->addIcon = PopR_AnimsOffAddIcon;
	((struct PopupReworkAnimsOffProc*)(proc))->pIconUpdater = NULL;

	// Compute various coordinates

	unsigned xTileSize    = (proc->pop.xGfxSize + 7) / 8;
	unsigned xStartOffset = (xTileSize*8 - proc->pop.xGfxSize)/2;

	int xTile = proc->pop.xTileParam;
	int yTile = proc->pop.yTileParam;

	if (xTile < 0)
		xTile = ((30-xTileSize) / 2)-1;

	if (yTile < 0)
		yTile = 8;

	// Store coordinates to proc

	proc->pop.xTileReal = xTile;
	proc->pop.yTileReal = yTile;

	proc->pop.xTileSize = xTileSize+2;
	proc->pop.yTileSize = 3; // ?

	// Make background tilemap

	MakeUIWindowTileMap_BG0BG1(
		xTile,       yTile,
		xTileSize+2, 4,

		proc->pop.winStyle
	);

	// Prepare text

	struct TextHandle text;
	Text_InitClear(&text, xTileSize);

	Text_SetColorId(&text, proc->pop.textColorId);
	Text_SetXCursor(&text, xStartOffset);

	// Draw components

	PopR_DisplayComponents(proc, &text);

	// Display text

	Text_Display(&text, BG_LOCATED_TILE(gBg0MapBuffer, xTile+1, yTile+1));

	// Reset font

	Text_InitFont();

	// Play sound

	PlaySfx(proc->pop.soundId);
}

struct PopRIconEntry {
	short iconId;

	u16 xBase;
	u16 yBase;
	u16 tileBase;
};

struct PopRAnimsOffIconUpdater {
	/* 00 */ PROC_HEADER;

	/* 2C */ struct PopRIconEntry entries[8];
};

static void PopR_AnimsOffIconUpdaterLoop(struct PopRAnimsOffIconUpdater* proc);

static const struct ProcInstruction sProc_PopRAnimsOffIconUpdater[] = {
	PROC_LOOP_ROUTINE(PopR_AnimsOffIconUpdaterLoop),
	PROC_END
};

static void PopR_AnimsOffAddIcon(struct PopupReworkProc* proc, unsigned iconId, unsigned xOffset) {
	struct PopupReworkAnimsOffProc* const pproc = (struct PopupReworkAnimsOffProc*) proc;

	// Make updater proc if it has not already

	if (!pproc->pIconUpdater) {
		pproc->pIconUpdater = (struct PopRAnimsOffIconUpdater*) ProcStart(sProc_PopRAnimsOffIconUpdater, (struct Proc*)(pproc));

		pproc->pIconUpdater->entries[0].iconId = -1;
	}

	struct PopRIconEntry* entry = NULL;

	for (unsigned i = 0; i < 8; ++i) {
		if (pproc->pIconUpdater->entries[i].iconId < 0) {
			entry = pproc->pIconUpdater->entries + i;
			break;
		}
	}

	if (entry) {
		// Setting up icon entry

		entry->iconId = iconId;

		entry->xBase  = (proc->pop.xTileReal+1)*8 + xOffset;
		entry->yBase  = (proc->pop.yTileReal+1)*8;

		unsigned tile = proc->pop.iconObjTileId;
		proc->pop.iconObjTileId += 4;

		entry->tileBase = tile | ((0xF & proc->pop.iconPalId) << 12);

		LoadIconObjectGraphics(iconId, tile);

		// Marking next entry as free

		if ((entry - pproc->pIconUpdater->entries) < 7)
			(entry + 1)->iconId = -1; // only do so if this isn't the last entry
	}
}

static void PopR_AnimsOffIconUpdaterLoop(struct PopRAnimsOffIconUpdater* proc) {
	for (struct PopRIconEntry* entry = proc->entries; entry->iconId >= 0; ++entry)
		PushToHiOAM(entry->xBase, entry->yBase, &gObj_16x16, entry->tileBase);
}

struct AnimsOffWrapperProc {
	/* 00 */ PROC_HEADER;

	/* 2C */ const struct BattlePopupType* itPop;
};

static void PopR_AnimsOffWrapperInit(struct AnimsOffWrapperProc* proc);
static void PopR_AnimsOffWrapperLoop(struct AnimsOffWrapperProc* proc);

const struct ProcInstruction gProc_PopR_AnimsOnWrapper[] = {
	PROC_CALL_ROUTINE(PopR_AnimsOffWrapperInit),

PROC_LABEL(0),
	PROC_LOOP_ROUTINE(PopR_AnimsOffWrapperLoop),
	PROC_SLEEP(8),

	PROC_GOTO(0),

PROC_LABEL(1),
	PROC_END
};

static void PopR_AnimsOffWrapperInit(struct AnimsOffWrapperProc* proc) {
	proc->itPop = gBattlePopupTable;
}

static void PopR_AnimsOffWrapperLoop(struct AnimsOffWrapperProc* proc) {
	const struct BattlePopupType type = *proc->itPop++;

	if (!type.tryInit) {
		ProcGoto((struct Proc*) (proc), 1);
		return;
	}

	if (!type.tryInit()) {
		ProcGoto((struct Proc*) (proc), 0);
		return;
	}

	Popup_Create(type.definition, type.time, 0, (struct Proc*) (proc));
	BreakProcLoop((struct Proc*) (proc));
}
