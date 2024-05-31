#include "PopupRework.h"

static int PopRIconCommon_GetLength(struct PopupReworkProc* proc, u32 argument) { return 16; }

// ===================
// = SPACE COMPONENT =
// ===================

static int  PopRSpace_GetLength(struct PopupReworkProc* proc, u32 argument);
static void PopRSpace_Display(struct PopupReworkProc* proc, struct TextHandle* text, u32 argument);

const struct PopupComponentType gPopR_SpaceComponent = {
	.getLength = PopRSpace_GetLength,
	.display   = PopRSpace_Display,
};

static int PopRSpace_GetLength(struct PopupReworkProc* proc, u32 argument) {
	return argument;
}

static void PopRSpace_Display(struct PopupReworkProc* proc, struct TextHandle* text, u32 argument) {
	Text_Advance(text, argument);
}

// =======================
// = ITEM NAME COMPONENT =
// =======================

static int  PopRItemName_GetLength(struct PopupReworkProc* proc, u32 argument);
static void PopRItemName_Display(struct PopupReworkProc* proc, struct TextHandle* text, u32 argument);

const struct PopupComponentType gPopR_ItemNameComponent = {
	.getLength = PopRItemName_GetLength,
	.display   = PopRItemName_Display,
};

static int PopRItemName_GetLength(struct PopupReworkProc* proc, u32 argument) {
	return Text_GetStringTextWidth(GetItemName(gPopupItem));
}

static void PopRItemName_Display(struct PopupReworkProc* proc, struct TextHandle* text, u32 argument) {
	Text_DrawString(text, GetItemName(gPopupItem));
}

// ================================================
// = ITEM NAME WITH CAPITALIZED ARTICLE COMPONENT =
// ================================================

static int  PopRCArticleItemName_GetLength(struct PopupReworkProc* proc, u32 argument);
static void PopRCArticleItemName_Display(struct PopupReworkProc* proc, struct TextHandle* text, u32 argument);

const struct PopupComponentType gPopR_CArticleItemNameComponent = {
	.getLength = PopRCArticleItemName_GetLength,
	.display   = PopRCArticleItemName_Display,
};

static int PopRCArticleItemName_GetLength(struct PopupReworkProc* proc, u32 argument) {
	return Text_GetStringTextWidth(GetItemNameWithArticle(gPopupItem, TRUE));
}

static void PopRCArticleItemName_Display(struct PopupReworkProc* proc, struct TextHandle* text, u32 argument) {
	Text_DrawString(text, GetItemNameWithArticle(gPopupItem, TRUE));
}

// ====================================
// = ITEM NAME WITH ARTICLE COMPONENT =
// ====================================

static int  PopRLArticleItemName_GetLength(struct PopupReworkProc* proc, u32 argument);
static void PopRLArticleItemName_Display(struct PopupReworkProc* proc, struct TextHandle* text, u32 argument);

const struct PopupComponentType gPopR_LArticleItemNameComponent = {
	.getLength = PopRLArticleItemName_GetLength,
	.display   = PopRLArticleItemName_Display,
};

static int PopRLArticleItemName_GetLength(struct PopupReworkProc* proc, u32 argument) {
	return Text_GetStringTextWidth(GetItemNameWithArticle(gPopupItem, FALSE));
}

static void PopRLArticleItemName_Display(struct PopupReworkProc* proc, struct TextHandle* text, u32 argument) {
	Text_DrawString(text, GetItemNameWithArticle(gPopupItem, FALSE));
}

// =======================
// = UNIT NAME COMPONENT =
// =======================

static int  PopRUnitName_GetLength(struct PopupReworkProc* proc, u32 argument);
static void PopRUnitName_Display(struct PopupReworkProc* proc, struct TextHandle* text, u32 argument);

const struct PopupComponentType gPopR_UnitNameComponent = {
	.getLength = PopRUnitName_GetLength,
	.display   = PopRUnitName_Display,
};

static int PopRUnitName_GetLength(struct PopupReworkProc* proc, u32 argument) {
	return Text_GetStringTextWidth(GetStringFromIndex(gpPopupUnit->pCharacterData->nameTextId));
}

static void PopRUnitName_Display(struct PopupReworkProc* proc, struct TextHandle* text, u32 argument) {
	Text_DrawString(text, GetStringFromIndex(gpPopupUnit->pCharacterData->nameTextId));
}

// ============================
// = STRING FROM ID COMPONENT =
// ============================

static int  PopRStringId_GetLength(struct PopupReworkProc* proc, u32 argument);
static void PopRStringId_Display(struct PopupReworkProc* proc, struct TextHandle* text, u32 argument);

const struct PopupComponentType gPopR_StringIdComponent = {
	.getLength = PopRStringId_GetLength,
	.display   = PopRStringId_Display,
};

static int PopRStringId_GetLength(struct PopupReworkProc* proc, u32 argument) {
	return Text_GetStringTextWidth(GetStringFromIndex(argument));
}

static void PopRStringId_Display(struct PopupReworkProc* proc, struct TextHandle* text, u32 argument) {
	Text_DrawString(text, GetStringFromIndex(argument));
}

// =================================
// = STRING FROM POINTER COMPONENT =
// =================================

static int  PopRStringRaw_GetLength(struct PopupReworkProc* proc, u32 argument);
static void PopRStringRaw_Display(struct PopupReworkProc* proc, struct TextHandle* text, u32 argument);

const struct PopupComponentType gPopR_StringRawComponent = {
	.getLength = PopRStringRaw_GetLength,
	.display   = PopRStringRaw_Display,
};

static int PopRStringRaw_GetLength(struct PopupReworkProc* proc, u32 argument) {
	const char* cstr = (const char*) (argument);
	return Text_GetStringTextWidth(cstr);
}

static void PopRStringRaw_Display(struct PopupReworkProc* proc, struct TextHandle* text, u32 argument) {
	const char* cstr = (const char*) (argument);
	Text_DrawString(text, cstr);
}

// ===============================
// = MODIFY TEXT COLOR COMPONENT =
// ===============================

static void PopRSetTextColor_Display(struct PopupReworkProc* proc, struct TextHandle* text, u32 argument);

const struct PopupComponentType gPopR_SetTextColorComponent = {
	.getLength = NULL,
	.display   = PopRSetTextColor_Display,
};

static void PopRSetTextColor_Display(struct PopupReworkProc* proc, struct TextHandle* text, u32 argument) {
	Text_SetColorId(text, argument);
}

// =======================
// = ITEM ICON COMPONENT =
// =======================

static void PopRItemIcon_Display(struct PopupReworkProc* proc, struct TextHandle* text, u32 argument);

const struct PopupComponentType gPopR_ItemIconComponent = {
	.getLength = PopRIconCommon_GetLength,
	.display   = PopRItemIcon_Display,
};

static void PopRItemIcon_Display(struct PopupReworkProc* proc, struct TextHandle* text, u32 argument) {
	proc->addIcon(proc, GetItemIconId(gPopupItem), Text_GetXCursor(text));
	Text_Advance(text, 16);

	LoadIconPalette(0, proc->pop.iconPalId);
}

// ==============================
// = WEAPON TYPE ICON COMPONENT =
// ==============================

static void PopRWTypeIcon_Display(struct PopupReworkProc* proc, struct TextHandle* text, u32 argument);

const struct PopupComponentType gPopR_WTypeIconComponent = {
	.getLength = PopRIconCommon_GetLength,
	.display   = PopRWTypeIcon_Display,
};

static void PopRWTypeIcon_Display(struct PopupReworkProc* proc, struct TextHandle* text, u32 argument) {
	proc->addIcon(proc, (0x400 | gPopupWType), Text_GetXCursor(text));
	Text_Advance(text, 16);

	LoadIconPalette(1, proc->pop.iconPalId);
}

// ====================
// = NUMBER COMPONENT =
// ====================

static int  PopRNumber_GetLength(struct PopupReworkProc* proc, u32 argument);
static void PopRNumber_Display(struct PopupReworkProc* proc, struct TextHandle* text, u32 argument);

const struct PopupComponentType gPopR_NumberComponent = {
	.getLength = PopRNumber_GetLength,
	.display   = PopRNumber_Display,
};

static int PopRNumber_GetLength(struct PopupReworkProc* proc, u32 argument) {
	char buf[0x10];

	return 8 * String_FromNumber(gPopupNumber, buf);
}

static void PopRNumber_Display(struct PopupReworkProc* proc, struct TextHandle* text, u32 argument) {
	char buf[0x10];

	String_FromNumber(gPopupNumber, buf);
	Text_DrawString(text, buf);
}

// =======================
// = SET SOUND COMPONENT =
// =======================

static void PopRSound_Display(struct PopupReworkProc* proc, struct TextHandle* text, u32 argument);

const struct PopupComponentType gPopR_SoundComponent = {
	.getLength = NULL,
	.display   = PopRSound_Display,
};

static void PopRSound_Display(struct PopupReworkProc* proc, struct TextHandle* text, u32 argument) {
	proc->pop.soundId = argument;
}
