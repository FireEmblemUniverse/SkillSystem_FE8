#include "gbafe.h"

struct AvatarClassTable_Struct { 
	u8 classID; 
	u8 smsID; 
};
struct SelectAvatarProc
{
    /* 00 */ PROC_HEADER; // this ends at +29
	/* 29 */ u8 destruct; 
	/* 2a */ u8 countdown;  
	struct MenuProc* menu; 
};

void SelectAvatar_DrawTitle(struct SelectAvatarProc* proc);
void SelectAvatar_StartMenu(struct SelectAvatarProc* proc);
void AvatarIdle(struct SelectAvatarProc* proc);
int SelectAvatarASMC(struct Proc* parent_proc);
int SelectAvatarCommandDraw(struct MenuProc* menu, struct MenuCommandProc* command); 
extern struct AvatarClassTable_Struct AvatarClass_Table[]; 
int SelectAvatarCommandSelect(struct MenuProc* menu, struct MenuCommandProc* command);
extern void PutUnitSpriteForClassId(int layer, int x, int y, u16 oam2, int class);

extern u8* PlayerAvatarClass_Link; 

extern u16 gBG0MapBuffer[32][32]; // 0x02022CA8. Snek: Ew why does FE-CLib-master not do it like this?
extern u16 gBG1MapBuffer[32][32]; // 0x020234A8.
extern u16 gBG2MapBuffer[32][32]; // 0x020234A8.

void ClearBG1(void) { 
	FillBgMap(gBg1MapBuffer,0);
	//FillBgMap(gBg3MapBuffer,0);
	EnableBgSyncByMask(BG1_SYNC_BIT); 
} 

void AvatarIdle(struct SelectAvatarProc* proc) { 
	if (proc->countdown) { 
		proc->countdown--; 
		return; 
	} 
	//gBG1MapBuffer[4][7] = 0; 
	if (proc->destruct) { 
		BreakProcLoop((void*)proc);
	} 

	if (proc->menu) { 
	struct MenuCommandProc* command0 = proc->menu->pCommandProc[0]; 
	struct MenuCommandProc* command1 = proc->menu->pCommandProc[1]; 
	int index0 = command0->commandDefinitionIndex; 
	int index1 = command1->commandDefinitionIndex; 
	//asm("mov r11, r11"); 
	PutUnitSpriteForClassId(0, command0->xDrawTile*8+8, command0->yDrawTile*8, 0xC800, AvatarClass_Table[index0].classID);
	PutUnitSpriteForClassId(0, command1->xDrawTile*8+8, command1->yDrawTile*8, 0xC800, AvatarClass_Table[index1].classID);
	//SMS_SyncDirect(); //SyncUnitSpriteSheet
	SMS_SyncIndirect(); //ForceSyncUnitSpriteSheet();
	//PutUnitSpriteExt(10-i, x, y, (1 << 10), GetUnit(unit_id));
	}
return; 
} 


static const struct ProcInstruction Proc_SelectAvatar[] =
{
    PROC_CALL_ROUTINE(LockGameLogic),
	//PROC_CALL_ROUTINE(LockGameGraphicsLogic),
	//PROC_CALL_ROUTINE(MU_AllDisable), 
	PROC_YIELD,
	

	PROC_CALL_ROUTINE(SelectAvatar_StartMenu),
	//PROC_SLEEP(2),
	PROC_CALL_ROUTINE(SelectAvatar_DrawTitle),

	PROC_LABEL(0),
    PROC_LOOP_ROUTINE(AvatarIdle),

	PROC_LABEL(1),
	//PROC_END_ALL(0x85B64D0), //#define MenuProc 0x5B64D0
	PROC_CALL_ROUTINE(UnlockGameLogic),
	//PROC_CALL_ROUTINE(UnlockGameGraphicsLogic), 
	//PROC_CALL_ROUTINE(MU_AllEnable),
	
    PROC_END,
};


static const struct MenuCommandDefinition MenuCommands_SelectAvatar[] =
{
	    //{
       // .isAvailable = MenuCommandAlwaysUsable,
		//.rawName = "Select an avatar.",
   // },
    {
        .isAvailable = MenuCommandAlwaysUsable,
        .onDraw = (void*)SelectAvatarCommandDraw,
		.onSwitchIn = (void*)ClearBG1,
		.onSwitchOut = (void*)ClearBG1, 
		//.rawName = " ",
        .onEffect = (void*)SelectAvatarCommandSelect,
    },

    {
        .isAvailable = MenuCommandAlwaysUsable,
        .onDraw = (void*)SelectAvatarCommandDraw,
		.onSwitchIn = (void*)ClearBG1,
		.onSwitchOut = (void*)ClearBG1, 
        .onEffect = (void*)SelectAvatarCommandSelect,
    },
	{}, // End 
};

int SelectAvatarMenuEnd(void) { 
	return ME_DISABLE | ME_END | ME_PLAY_BEEP | ME_CLEAR_GFX;
}

static const struct MenuDefinition Menu_SelectAvatar =
{
    .geometry = { 7, 4, 1 }, // x, y, width 
    .commandList = MenuCommands_SelectAvatar,
    .onEnd = (void*) SelectAvatarMenuEnd,
    //.onBPress = (void*) (0x08022860+1), // FIXME
};




int SelectAvatarCommandDraw(struct MenuProc* menu, struct MenuCommandProc* command) {
	
	/*

	*/
	
	//u16 oam2 = SMS_RegisterUsage(AvatarClass_Table[command->commandDefinitionIndex].smsID);
	// 0xC obj pal 
	
	//PutUnitSpriteForClassId(int layer, command->xDrawTile, command->yDrawTile, u16 oam2, int class);
	return 1; 
}


int SelectAvatarASMC(struct Proc* parent)
{
	struct SelectAvatarProc* proc;
	if (parent != NULL)
        proc = (void*) ProcStartBlocking(Proc_SelectAvatar, parent);
    else
        proc = (void*) ProcStart(Proc_SelectAvatar, ROOT_PROC_3);
	
	ResetMapSpriteHoverTimer();
    proc->countdown = 0; 
	//StartFace(0, GetUnitPortraitId(proc->unit), 72, 16, 3);
    return ME_DISABLE | ME_END | ME_PLAY_BEEP | ME_CLEAR_GFX;
}

void SelectAvatar_StartMenu(struct SelectAvatarProc* proc) { 
	StartFadeOutBlackFast();
	SMS_Init(); //ResetUnitSprites();
	proc->destruct = false; 
	proc->menu = StartMenu(&Menu_SelectAvatar);
}
void SelectAvatar_DrawTitle(struct SelectAvatarProc* proc) { 
	ClearBG0BG1(); 
	
	FillBgMap(gBg0MapBuffer,0);
	FillBgMap(gBg1MapBuffer,0);
	FillBgMap(gBg2MapBuffer,0);
	FillBgMap(gBg3MapBuffer,0);
	EnableBgSyncByMask(1|2|4|8); 
	
	u16* const out = gBg0MapBuffer + TILEMAP_INDEX(7, 2);
	TextHandle currHandle;
    Text_InitClear(&currHandle, 15);
	Text_SetColorId(&currHandle, TEXT_COLOR_GREEN);
	
	Text_DrawString(&currHandle," Select an avatar.");
	//Text_InsertString(currHandle,0,TEXT_COLOR_NORMAL," Yes");
    Text_Display(&currHandle, out);
}


extern struct UnitDefinition ProtagUnitGroup2; 
extern struct ClassData NewClassTable; 
int SelectAvatarCommandSelect(struct MenuProc* menu, struct MenuCommandProc* command)
{
	struct SelectAvatarProc* proc = (struct SelectAvatarProc*)ProcFind(Proc_SelectAvatar); 
	proc->destruct = true; 
	//ProcGoto((Proc*)proc, 1); // Destructor label 
	//struct ClassData classTable = &NewClassTable; 
	struct Unit* protagUnit = LoadUnit(&ProtagUnitGroup2);
	//int classID = AvatarClass_Table[menu->commandIndex].classID; 
	//for (int i = 0; i <= classID; i++) { 
		//classTable++; 
	//} 
	//protagUnit->pClassData = classTable; 
	//*PlayerAvatarClass_Link = AvatarClass_Table[menu->commandIndex].classID;
	SMS_UpdateFromGameData();
	return ME_DISABLE | ME_END | ME_PLAY_BEEP | ME_CLEAR_GFX;

    //return ME_PLAY_BEEP;
}
