
#include "FE-CLib-master/include/gbafe.h"

typedef struct Struct_SelectCharacterProc Struct_SelectCharacterProc;
//typedef struct UnitDefinition UnitDefinition;

extern const MenuDefinition gSelectUnitMenuDefs;

int SelectCharacter_ASMC(struct MenuProc* menu, struct MenuCommandProc* command);
static int SelectClass(struct MenuProc* menu, struct MenuCommandProc* command);
static int SelectYes(struct MenuProc* menu, struct MenuCommandProc* command);
static int SelectNo(struct MenuProc* menu, struct MenuCommandProc* command);
static void SelectCharacterMenuEnd(struct MenuProc* menu);
static void DrawSelectCharacterCommands(struct MenuProc* menu, struct MenuCommandProc* command, int i);
static void DrawSelect_0(struct MenuProc* menu, struct MenuCommandProc* command);
static void DrawSelect_1(struct MenuProc* menu, struct MenuCommandProc* command);
static void DrawSelect_2(struct MenuProc* menu, struct MenuCommandProc* command);
static void SwitchInCharacter(MenuProc* proc, MenuCommandProc* commandProc);
static void SwitchOutCharacter(MenuProc* proc, MenuCommandProc* commandProc);

extern u16 gBG0MapBuffer[32][32]; // 0x02022CA8. Ew why does FE-CLib-master not do it like this?
extern unsigned gEventSlot[];

extern MenuCommandDefinition gRAMMenuCommands[]; // 0x0203EFB8.

static void DrawStatNames(TextHandle handle, char* string, int x, int y);




struct Struct_SelectCharacterProc
{
	PROC_HEADER;
	u8 currMenu; // 0x29.
	u8 currSetIndex; // 0x2A.
	u8 currOptionIndex; // 0x2B. 0 = first option, 1 = 2nd option, etc. 
	Unit* activeUnit; // 0x2C. 
	struct
	{
		Unit* unitRam; // 0x30, 0x34, 0x38, 0x3c, 0x40, 0x44 
	} list[5];
};

struct Struct_ConfirmationProc
{
	PROC_HEADER;
};

static const struct ProcInstruction ProcInstruction_SelectCharacter[] =
{
    PROC_CALL_ROUTINE(LockGameLogic),

    PROC_YIELD,

    PROC_CALL_ROUTINE(UnlockGameLogic),
    PROC_END,
};

static const struct ProcInstruction ProcInstruction_Confirmation[] =
{
    PROC_YIELD,
    PROC_END,
};



static const struct MenuCommandDefinition MenuCommands_CharacterProc[] =
{
    {

        .isAvailable = MenuCommandAlwaysUsable,
		.rawName = " ",
        .onEffect = SelectClass,
		.onDraw = DrawSelect_0,
		.onSwitchIn = SwitchInCharacter, 
		.onSwitchOut = SwitchOutCharacter, 
    },

    {
        .isAvailable = MenuCommandAlwaysUsable,

        .rawName = " ",
        .onEffect = SelectClass,
		.onDraw = DrawSelect_1,
		.onSwitchIn = SwitchInCharacter, 
		.onSwitchOut = SwitchOutCharacter, 
    },
    {
        .isAvailable = MenuCommandAlwaysUsable,

        .rawName = " ",
        .onEffect = SelectClass,
		.onDraw = DrawSelect_2,
		.onSwitchIn = SwitchInCharacter, 
		.onSwitchOut = SwitchOutCharacter, 
    },
    {} // END
};


static const struct MenuCommandDefinition MenuCommands_ConfirmationProc[] =
{
    {
        .isAvailable = MenuCommandAlwaysUsable,
		.rawName = " Yes",
        .onEffect = SelectYes,
    },

    {
        .isAvailable = MenuCommandAlwaysUsable,

        .rawName = " No",
        .onEffect = SelectNo,
    },
    {} // END
};


static const struct MenuDefinition MenuDef_SelectCharacter =
{
    .geometry = { 23, 12, 7 },
	.style = 0,
    .commandList = MenuCommands_CharacterProc,
	._u14 = 0,
    .onEnd = SelectCharacterMenuEnd,
	.onInit = 0,
	.onBPress = 0, //(void*) (0x08022860+1), // FIXME
	.onRPress = 0,
	.onHelpBox = 0, 	
};


static const struct MenuDefinition MenuDef_ConfirmCharacter =
{
    .geometry = { 25, 12, 5 },
    .commandList = MenuCommands_ConfirmationProc, 

    .onEnd = SelectCharacterMenuEnd,
    //.onBPress = (void*) (SelectCharacter_ASMC), 
};


// ASMC 
int SelectCharacter_ASMC(struct MenuProc* menu, struct MenuCommandProc* command) // ASMC 
{
    struct Struct_SelectCharacterProc* proc = (void*) ProcStart(ProcInstruction_SelectCharacter, ROOT_PROC_3);
    proc->activeUnit = gActiveUnit;


	for ( int i = 0 ; i < 5 ; i++ ) // Mem slots 1 - 5 as unit groups to load 
	{ 	
		if (gEventSlot[i+1] != 0) // Non-zero Character ID in unit group to load and non-zero memory slot 
		{
			proc->list[i].unitRam = LoadUnit(gEventSlot[i+1]); //Unit* 
		}

	}
	
	
	
	proc->currOptionIndex = 0;
    StartMenuChild(&MenuDef_SelectCharacter, (void*) proc);

    return ME_DISABLE | ME_END | ME_PLAY_BEEP | ME_CLEAR_GFX;
}

// We need to draw the names of each menu item before hovering over them 
static void DrawSelect_0(struct MenuProc* menu, struct MenuCommandProc* command)
{
	int i = 0;
	DrawSelectCharacterCommands(menu, command, i);
}
static void DrawSelect_1(struct MenuProc* menu, struct MenuCommandProc* command)
{
	int i = 1;
	DrawSelectCharacterCommands(menu, command, i);
}
static void DrawSelect_2(struct MenuProc* menu, struct MenuCommandProc* command)
{
	int i = 2;
	DrawSelectCharacterCommands(menu, command, i);
}



static void DrawSelectCharacterCommands(struct MenuProc* menu, struct MenuCommandProc* command, int i)
{
    struct Struct_SelectCharacterProc* proc = (void*) menu->parent;

    u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	TextHandle* currHandle = &command->text;
    Text_Clear(currHandle);


	
	Text_SetColorId(currHandle, TEXT_COLOR_NORMAL);

	Unit* unit = (proc->list[i].unitRam);
	u16 textID = unit->pClassData->nameTextId; 
	//pCharacterData->nameTextId;
	
	//asm("mov r11,r11");

	Text_InsertString(currHandle,0,TEXT_COLOR_NORMAL,GetStringFromIndex(textID));
    Text_Display(currHandle, out);

    /*
	LoadIconPalettes(4);

    for (int i = 0; i < UNIT_SKILL_COUNT; ++i)
    {
        if (IsSkill(skills[i]))
            DrawIcon(out + TILEMAP_INDEX(2*i, 0), SKILL_ICON(skills[i]), TILEREF(0, 4));
    }

    command->onCycle = (void*) SkillListCommandDrawIdle;
	*/
	
}

static void DrawStatNames(TextHandle handle, char* string, int x, int y)
{
	Text_Clear(&handle);
	Text_SetColorId(&handle,TEXT_COLOR_GOLD);
	Text_AppendStringAscii(&handle,string);
	Text_Display(&handle,&gBG0MapBuffer[y][x]);
}

void SwitchInCharacter(MenuProc* proc, MenuCommandProc* commandProc) // Whenever you scroll or exit / confirm the character menu  
{
	classProc->menuItem ;
	
	struct Struct_SelectCharacterProc* parent_proc = (void*) proc->parent;
	parent_proc->currOptionIndex = commandProc->commandDefinitionIndex;
	
	Unit* unit = (parent_proc->list[parent_proc->currOptionIndex].unitRam);
	const CharacterData* charData = unit->pCharacterData;
	
	DrawUiNumber(&gBG0MapBuffer[15][8],TEXT_COLOR_GOLD,unit->maxHP);
	DrawUiNumber(&gBG0MapBuffer[15][11],TEXT_COLOR_GOLD,unit->pow);
	DrawUiNumber(&gBG0MapBuffer[15][14],TEXT_COLOR_GOLD,unit->unk3A); // Magic.
	DrawUiNumber(&gBG0MapBuffer[15][17],TEXT_COLOR_GOLD,unit->skl);
	DrawUiNumber(&gBG0MapBuffer[15][20],TEXT_COLOR_GOLD,unit->spd);
	DrawUiNumber(&gBG0MapBuffer[15][23],TEXT_COLOR_GOLD,unit->def);
	DrawUiNumber(&gBG0MapBuffer[15][26],TEXT_COLOR_GOLD,unit->res);
	
	DrawUiNumber(&gBG0MapBuffer[17][8],TEXT_COLOR_GOLD,charData->growthHP);
	DrawUiNumber(&gBG0MapBuffer[17][11],TEXT_COLOR_GOLD,charData->growthPow);
	//DrawUiNumber(&gBG0MapBuffer[17][14],TEXT_COLOR_GOLD,MagCharTable[charData->number].growth);
	DrawUiNumber(&gBG0MapBuffer[17][17],TEXT_COLOR_GOLD,charData->growthSkl);
	DrawUiNumber(&gBG0MapBuffer[17][20],TEXT_COLOR_GOLD,charData->growthSpd);
	DrawUiNumber(&gBG0MapBuffer[17][23],TEXT_COLOR_GOLD,charData->growthDef);
	DrawUiNumber(&gBG0MapBuffer[17][26],TEXT_COLOR_GOLD,charData->growthRes);
	int tile = 0;
	TextHandle baseHandle =	{
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 4
	};
	tile += 4;
	Text_Clear(&baseHandle);
	Text_SetColorId(&baseHandle,TEXT_COLOR_GOLD);
	Text_InsertString(&baseHandle,0,TEXT_COLOR_GOLD,"Base");
	Text_Display(&baseHandle,&gBG0MapBuffer[15][2]);
	
	TextHandle growthHandle = {
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 4
	};
	tile += 4;
	Text_Clear(&growthHandle);
	Text_SetColorId(&growthHandle,TEXT_COLOR_GOLD);
	Text_InsertString(&growthHandle,0,TEXT_COLOR_GOLD,"Growth");
	Text_Display(&growthHandle,&gBG0MapBuffer[17][2]);
	
	TextHandle hpHandle = {
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 2
	};
	tile += 2;
	DrawStatNames(hpHandle,"HP",7,13);
	
	TextHandle strHandle = {
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 3
	};
	tile += 3;
	DrawStatNames(strHandle,"Str",10,13);
	
	TextHandle magHandle = {
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 3
	};
	tile += 3;
	DrawStatNames(magHandle,"Mag",13,13);
	
	TextHandle sklHandle = {
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 3
	};
	tile += 3;
	DrawStatNames(sklHandle,"Skl",16,13);
	
	TextHandle spdHandle = {
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 3
	};
	tile += 3;
	DrawStatNames(spdHandle,"Spd",19,13);
	
	TextHandle defHandle = {
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 3
	};
	tile += 3;
	DrawStatNames(defHandle,"Def",22,13);
	
	TextHandle resHandle = {
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 3
	};
	tile += 3;
	DrawStatNames(resHandle,"Res",25,13);
	
	EnableBgSyncByMask(1);
	//BgMapFillRect(&gBG0MapBuffer[1][12],30-12,2,0);
	ClearIcons();
}


void SwitchOutCharacter(MenuProc* proc, MenuCommandProc* commandProc) // Whenever you scroll or exit / confirm the character menu  
{
	
	//BgMapFillRect(&gBG0MapBuffer[1][12],30-12,2,0);
	ClearIcons();
}


static int SelectClass(struct MenuProc* menu, struct MenuCommandProc* command)
{
	Proc* parent_proc = (void*)(Struct_SelectCharacterProc*)ProcFind(&ProcInstruction_SelectCharacter[0]);
	//Struct_SelectCharacterProc* proc_variables = (void*)(Struct_SelectCharacterProc*)ProcFind(&ProcInstruction_SelectCharacter[0]);
	// useful probably 
	struct Struct_ConfirmationProc* proc = (void*) ProcStartBlocking(ProcInstruction_Confirmation, parent_proc);



	StartMenuChild(&MenuDef_ConfirmCharacter, (void*) proc);
	//return ME_NONE;
	return ME_DISABLE | ME_END | ME_PLAY_BEEP | ME_CLEAR_GFX;
}


static int SelectYes(struct MenuProc* menu, struct MenuCommandProc* command)
{
	return ME_DISABLE | ME_END | ME_PLAY_BEEP | ME_CLEAR_GFX;
}

static int SelectNo(struct MenuProc* menu, struct MenuCommandProc* command)
{
	//(void*) (SelectCharacter_ASMC);
	return ME_DISABLE | ME_END | ME_PLAY_BEEP | ME_CLEAR_GFX;
}


static void SelectCharacterMenuEnd(struct MenuProc* menu)
{
    //EndFaceById(0);
}
















