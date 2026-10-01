#include "global.h"

#include "rng.h"
#include "bmitem.h"
#include "bmunit.h"
#include "bmmap.h"
#include "bmmind.h"
#include "bmreliance.h"
#include "chapterdata.h"
#include "bmtrick.h"
#include "m4a.h"
#include "soundwrapper.h"
#include "hardware.h"
#include "proc.h"
#include "mu.h"
#include "bmarch.h"
#include "bmarena.h"
#include "bmsave.h"
#include "ekrbattle.h"
#include "bmbattle.h"
#include "mapanim.h"
#include "worldmap.h"
#include "bmitemuse.h"
#include "uimenu.h"
#include "bmtarget.h"
#include "uiselecttarget.h"

#define UNIT_ACTION_BIGDANCE 0x2C

extern u8 SkillTester(struct Unit* unit, int skillID);


u8 BigDanceMenuEffect(ProcPtr proc, struct SelectTarget* target) {

    gActionData.unitActionType = UNIT_ACTION_BIGDANCE;
    gActionData.targetIndex = target->uid;

    return MENU_ACT_SKIPCURSOR | MENU_ACT_END | MENU_ACT_SND6A | MENU_ACT_CLEAR;
}

void RefreshUnit(struct Unit* unit) {
	unit->state &= ~( US_UNSELECTABLE | US_HAS_MOVED | US_HAS_MOVED_AI );
}

s8 Action_BigDance(ProcPtr proc) {
	
    ForEachAdjacentUnit(gActionData.xMove, gActionData.yMove, RefreshUnit);

    BattleInitItemEffect(GetUnit(gActionData.subjectIndex), -1);
    BattleInitItemEffectTarget(GetUnit(gActionData.subjectIndex));

    gBattleStats.config = BATTLE_CONFIG_REFRESH;

    BattleApplyMiscAction(proc);
	
	//force battle animations off with an inline modified version of BeginBattleAnimations()
	BG_Fill(gBG2TilemapBuffer, 0);
	BG_EnableSyncByMask(1 << 2);
	gPaletteBuffer[PAL_BACKDROP_OFFSET] = 0;
	EnablePaletteSync();
	RenderBmMap();
	MU_EndAll();
	RenderBmMap();
	BeginBattleMapAnims();
	gBattleStats.config |= BATTLE_CONFIG_MAPANIMS;

    return 0;
}

