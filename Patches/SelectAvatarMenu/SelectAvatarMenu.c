#include "gbafe.h"

struct AvatarClassTable_Struct { 
	u8 classID; 
	u8 smsID; 
};
struct SelectAvatarProc
{
    /* 00 */ PROC_HEADER; // this ends at +29
	/* 2a */ u8 destruct; 
	struct MenuProc* menu; 
};

void SelectAvatar_StartMenu(struct SelectAvatarProc* proc);
void AvatarIdle(struct SelectAvatarProc* proc);
int SelectAvatarASMC(struct Proc* parent_proc);
int SelectAvatarCommandDraw(struct MenuProc* menu, struct MenuCommandProc* command); 
extern struct AvatarClassTable_Struct AvatarClass_Table[]; 
int SelectAvatarCommandSelect(struct MenuProc* menu, struct MenuCommandProc* command);
extern void PutUnitSpriteForClassId(int layer, int x, int y, u16 oam2, int class);



void AvatarIdle(struct SelectAvatarProc* proc) { 
	if (proc->destruct) { 
		BreakProcLoop((void*)proc);
	} 

	if (proc->menu) { 
	struct MenuCommandProc* command0 = proc->menu->pCommandProc[0]; 
	struct MenuCommandProc* command1 = proc->menu->pCommandProc[1]; 
	PutUnitSpriteForClassId(2, command0->xDrawTile*8+8, command0->yDrawTile*8, (0xC << 12), AvatarClass_Table[command0->commandDefinitionIndex].classID);
	PutUnitSpriteForClassId(2, command1->xDrawTile*8+8, command1->yDrawTile*8, (0xC << 12), AvatarClass_Table[command1->commandDefinitionIndex].classID);
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
    {
        .isAvailable = MenuCommandAlwaysUsable,
        .onDraw = (void*)SelectAvatarCommandDraw,
		//.rawName = " ",
        .onEffect = (void*)SelectAvatarCommandSelect,
    },

    {
        .isAvailable = MenuCommandAlwaysUsable,
        .onDraw = (void*)SelectAvatarCommandDraw,
		//.rawName = " ",
        .onEffect = (void*)SelectAvatarCommandSelect,
    },
	{}, // End 
};

int SelectAvatarMenuEnd(void) { 
	return ME_DISABLE | ME_END | ME_PLAY_BEEP | ME_CLEAR_GFX;
}

static const struct MenuDefinition Menu_SelectAvatar =
{
    .geometry = { 7, 2, 8 }, // x, y, width 
    .commandList = MenuCommands_SelectAvatar,
    .onEnd = (void*) SelectAvatarMenuEnd,
    //.onBPress = (void*) (0x08022860+1), // FIXME
};




int SelectAvatarCommandDraw(struct MenuProc* menu, struct MenuCommandProc* command) {
	
	/*
	u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	TextHandle* currHandle = &command->text;
    Text_Clear(currHandle);
	Text_SetColorId(currHandle, TEXT_COLOR_NORMAL);
	
	Text_DrawString(currHandle," Yes");
	//Text_InsertString(currHandle,0,TEXT_COLOR_NORMAL," Yes");
    Text_Display(currHandle, out);
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
	
    
	//StartFace(0, GetUnitPortraitId(proc->unit), 72, 16, 3);
    return ME_DISABLE | ME_END | ME_PLAY_BEEP | ME_CLEAR_GFX;
}

void SelectAvatar_StartMenu(struct SelectAvatarProc* proc) { 
	proc->destruct = false; 
	proc->menu = StartMenu(&Menu_SelectAvatar);
}

int SelectAvatarCommandSelect(struct MenuProc* menu, struct MenuCommandProc* command)
{
	struct SelectAvatarProc* proc = (struct SelectAvatarProc*)ProcFind(Proc_SelectAvatar); 
	proc->destruct = true; 
	//ProcGoto((Proc*)proc, 1); // Destructor label 
	SMS_UpdateFromGameData();
	return ME_DISABLE | ME_END | ME_PLAY_BEEP | ME_CLEAR_GFX;

    //return ME_PLAY_BEEP;
}
