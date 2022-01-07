
#include "FE-CLib-master/include/gbafe.h"
typedef struct CreatorClassProcStruct CreatorClassProcStruct;
typedef struct Struct_SelectCharacterProc Struct_SelectCharacterProc;
typedef struct SomeAISStruct SomeAISStruct;

extern const MenuDefinition gSelectUnitMenuDefs;

int RestartSelectCharacter_ASMC(struct MenuProc* menu, struct MenuCommandProc* command);
int SelectCharacter_ASMC(struct MenuProc* menu, struct MenuCommandProc* command);
static int LoopUntilMenuExited(struct MenuProc* menu, struct MenuCommandProc* command);
static int SelectCharacter_StartMenu(struct MenuProc* menu, struct MenuCommandProc* command);
static int SelectClass(struct MenuProc* menu, struct MenuCommandProc* command);
static int SelectYes(struct MenuProc* menu, struct MenuCommandProc* command);
static int SelectNo(struct MenuProc* menu, struct MenuCommandProc* command);
void SelectCharacterMenuEnd(void);
static void DrawSelectCharacterCommands(struct MenuProc* menu, struct MenuCommandProc* command, int i);
static void DrawSelect_0(struct MenuProc* menu, struct MenuCommandProc* command);
static void DrawSelect_1(struct MenuProc* menu, struct MenuCommandProc* command);
static void DrawSelect_2(struct MenuProc* menu, struct MenuCommandProc* command);
static void SwitchInCharacter(MenuProc* proc, MenuCommandProc* commandProc);
static void SwitchOutCharacter(MenuProc* proc, MenuCommandProc* commandProc);
static void StartPlatform(CreatorClassProcStruct* proc);
static void CreatorClassEndProc(CreatorClassProcStruct* proc);
static const struct MenuDefinition MenuDef_SelectCharacter1;
static const struct MenuDefinition MenuDef_SelectCharacter2;
static const struct MenuDefinition MenuDef_SelectCharacter3;
static const struct MenuDefinition MenuDef_SelectCharacter4;
static const struct MenuDefinition MenuDef_SelectCharacter5;
void BreakRoutine(void);


typedef struct Tile Tile;
typedef struct TSA TSA;
struct Tile
{
	u16 tileID : 10;
	u16 horizontalFlip : 1;
	u16 verticalFlip : 1;
	u16 paletteID : 4;
};

struct TSA
{
	u8 width, height;
	Tile tiles[];
};
struct CreatorClassProcStruct
{
	PROC_HEADER
	u8 unk1[0x2C-0x29]; // 0x29.
	u16 classes[5]; // 0x2C.
	u8 unk2[0x40 - 0x36]; // 0x36.
	u8 mode; // 0x40.
	u8 menuItem; // 0x41.
	u16 charID; // 0x42.
	u8 unk3[0x50 - 0x44]; // 0x44.
	u8 platformType; // 0x50.
};

struct SomeAISStruct {};

#define DrawSkillIcon(map,id,oam2base) DrawIcon(map,id|0x100,oam2base)

extern u16 gBG2MapBuffer[32][32]; // 0x02023CA8.
extern AnimationInterpreter gSomeAISStruct; // 0x030053A0.
extern SomeAISStruct gSomeAISRelatedStruct; // 0x0201FADC.

extern u8 gCharacterSelectorBattleSpriteHeight, gCharacterSelectorPlatformHeight;

extern TSA gCreatorClassUIBoxTSA;
extern TSA gCostUIBoxTSA;
extern TSA gItemUIBoxTSA;
extern TSA gPortraitUIBoxTSA;
extern TSA gSkillsRanksUIBoxTSA;
extern u16 gBG0MapBuffer[32][32]; // 0x02022CA8. Snek: Ew why does FE-CLib-master not do it like this?
extern u16 gBG1MapBuffer[32][32]; // 0x020234A8.

extern void StartMovingPlatform(int always0x9, int always0x118, int height); // 0x080CD408.
extern void SetupMovingPlatform(int always0x0, int alwaysNeg1, int always0x1F6, int always0x58, int always0x6); // 0x080CD47C.
extern void DeleteSomeAISStuff(AnimationInterpreter* interpreter); // 0x0805AA28.
extern void DeleteSomeAISProcs(struct SomeAISStruct* obj); // 0x0805AE14.
extern void EndEkrAnimeDrvProc(void);


extern void LockGameGraphicsLogic(void); // Hide map sprites? ! FE8U = 0x8030185
extern void UnlockGameGraphicsLogic(void); //! FE8U = 0x80301B9
extern void MU_AllDisable(void);
extern void MU_AllEnable(void); 


extern unsigned gEventSlot[];

extern MenuCommandDefinition gRAMMenuCommands[]; // 0x0203EFB8.

static void DrawStatNames(TextHandle handle, char* string, int x, int y);

extern void CreatorClassSetup();
extern void CreatorClassDisplayLoop();


struct Struct_SelectCharacterProc
{
	PROC_HEADER;
	u8 destructorBool; // 0x29.
	u8 platformType; // 0x2A.
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
	PROC_CALL_ROUTINE(LockGameGraphicsLogic),
	PROC_CALL_ROUTINE(MU_AllDisable), 

    PROC_YIELD,

	PROC_LABEL(0x0),
	PROC_CALL_ROUTINE(SelectCharacter_StartMenu),
	PROC_LOOP_ROUTINE(LoopUntilMenuExited),
	
	PROC_GOTO(0x00),
	PROC_LABEL(0x1), 
	//PROC_CALL_ROUTINE(BreakRoutine),
	//PROC_CALL_ROUTINE(SelectCharacterMenuEnd),
    PROC_CALL_ROUTINE(UnlockGameLogic),
	PROC_CALL_ROUTINE(UnlockGameGraphicsLogic), 
	PROC_CALL_ROUTINE(MU_AllEnable),
	
    PROC_END,
};


void BreakRoutine(void)
{
	asm("mov r11,r11");
}


static const struct ProcInstruction ProcInstruction_CreatorClassProc[] =
{
	PROC_YIELD,
	//PROC_SLEEP(2),
	PROC_CALL_ROUTINE(SwitchInCharacter), 
	PROC_CALL_ROUTINE(StartPlatform),
	PROC_LOOP_ROUTINE(CreatorClassDisplayLoop),
	//PROC_CALL_ROUTINE(CreatorClassEndProc),
	PROC_END, 
}; 

static const struct ProcInstruction ProcInstruction_Confirmation[] =
{
    PROC_YIELD,
	//PROC_LOOP_ROUTINE(LoopUntilMenuExited),
    PROC_END,
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





static const struct MenuDefinition MenuDef_ConfirmCharacter =
{
    //.geometry = { 25, 12, 5 },
    .geometry = { 14, 8, 5 },
    .commandList = MenuCommands_ConfirmationProc, 

    //.onEnd = SelectCharacterMenuEnd,
    .onBPress = (void*) (SelectNo), 
};

int LoopUntilMenuExited(struct MenuProc* menu, struct MenuCommandProc* command)
{
	Struct_SelectCharacterProc* proc = (Struct_SelectCharacterProc*)ProcFind(&ProcInstruction_SelectCharacter);
	//asm("mov r11,r11");
	if (proc->destructorBool) 
	{ 
		ProcGoto(proc, 1); // Terminate proc label 
		return ME_DISABLE | ME_END | ME_PLAY_BEEP | ME_CLEAR_GFX; 
	} 
	else { return ME_NONE; }
}

int RestartSelectCharacter_ASMC(struct MenuProc* menu, struct MenuCommandProc* command)
{
	//SelectCharacterMenuEnd(menu);
	//ProcInstruction_CreatorClassProc* proc = (CreatorClassProcStruct*)ProcFind(&ProcInstruction_CreatorClassProc);
	//SwitchInCharacter(menu, command); 
	// ProcInstruction_CreatorClassProc
	
	
	//SelectCharacter_StartMenu(menu, command); 
	return ME_NONE; 
    //return ME_DISABLE | ME_END | ME_PLAY_BEEP | ME_CLEAR_GFX;
}


// ASMC 
int SelectCharacter_ASMC(struct MenuProc* menu, struct MenuCommandProc* command) // ASMC 
{
		
	//Struct_SelectCharacterProc* proc = (Struct_SelectCharacterProc*)ProcFind(&ProcInstruction_SelectCharacter);
	Struct_SelectCharacterProc* proc = ProcStart(ProcInstruction_SelectCharacter, ROOT_PROC_3);
	
    return ME_DISABLE | ME_END | ME_PLAY_BEEP | ME_CLEAR_GFX;
    //return ME_DISABLE | ME_PLAY_BEEP | ME_CLEAR_GFX;
}

int SelectCharacter_StartMenu(struct MenuProc* menu, struct MenuCommandProc* command)
{
	Struct_SelectCharacterProc* proc = (Struct_SelectCharacterProc*)ProcFind(&ProcInstruction_SelectCharacter);
	
	proc->activeUnit = gActiveUnit;


	for ( int i = 0 ; i < 5 ; i++ ) // Mem slots 1 - 5 as unit groups to load 
	{ 	
		proc->list[i].unitRam = GetUnitByCharId(gEventSlot[i+1]); //Unit* 
	}
	
	
	
	proc->currOptionIndex = 0;
	// Determine menu size based on values in memory slots 1-5 being non-zero. 
    if 		(proc->list[4].unitRam && proc->list[3].unitRam && proc->list[2].unitRam && proc->list[1].unitRam && proc->list[0].unitRam) StartMenuChild(&MenuDef_SelectCharacter5, (void*) proc);
	else if (proc->list[3].unitRam && proc->list[2].unitRam && proc->list[1].unitRam && proc->list[0].unitRam) StartMenuChild(&MenuDef_SelectCharacter4, (void*) proc);
	else if (proc->list[2].unitRam && proc->list[1].unitRam && proc->list[0].unitRam) StartMenuChild(&MenuDef_SelectCharacter3, (void*) proc);
	else if (proc->list[1].unitRam && proc->list[0].unitRam) StartMenuChild(&MenuDef_SelectCharacter2, (void*) proc);
	else if (proc->list[0].unitRam) StartMenuChild(&MenuDef_SelectCharacter1, (void*) proc);
	
	
	
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
static void DrawSelect_3(struct MenuProc* menu, struct MenuCommandProc* command)
{
	int i = 3;
	DrawSelectCharacterCommands(menu, command, i);
}
static void DrawSelect_4(struct MenuProc* menu, struct MenuCommandProc* command)
{
	int i = 4;
	DrawSelectCharacterCommands(menu, command, i);
}



void CharacterSelectDrawUIBox(Struct_SelectCharacterProc* proc)
{
	//BgMap_ApplyTsa(u16* target, const void* source, u16 tileBase)
	// Menu BG 
	BgMap_ApplyTsa(&gBG1MapBuffer[0][0], &gCreatorClassUIBoxTSA, 0);
	// Portrait BG  
	BgMap_ApplyTsa(&gBG1MapBuffer[0][20], &gPortraitUIBoxTSA, 0); //20*8 as X, 0*0 as Y 
	BgMap_ApplyTsa(&gBG1MapBuffer[0][13], &gSkillsRanksUIBoxTSA, 0); //20*8 as X, 0*0 as Y 
	
	int i = proc->currOptionIndex;
	int cost = gEventSlot[i+6]; // Cost in gold to purchase character 
	
	if (cost) BgMap_ApplyTsa(&gBG1MapBuffer[11][20], &gCostUIBoxTSA, 0); //20*8 as X, 0*0 as Y 
	

	Unit* unit = (proc->list[i].unitRam);

	if ( unit->items[0] ) BgMap_ApplyTsa(&gBG1MapBuffer[13][28], &gItemUIBoxTSA, 0); 
	if ( unit->items[1] ) BgMap_ApplyTsa(&gBG1MapBuffer[13][26], &gItemUIBoxTSA, 0); 
	if ( unit->items[2] ) BgMap_ApplyTsa(&gBG1MapBuffer[15][28], &gItemUIBoxTSA, 0); 
	if ( unit->items[3] ) BgMap_ApplyTsa(&gBG1MapBuffer[15][26], &gItemUIBoxTSA, 0); 
	

	EnableBgSyncByMask(2);
}

static void DrawSelectCharacterCommands(struct MenuProc* menu, struct MenuCommandProc* command, int i)
{
	Struct_SelectCharacterProc* proc = (Struct_SelectCharacterProc*)ProcFind(&ProcInstruction_SelectCharacter);
    //struct Struct_SelectCharacterProc* proc = (void*) menu->parent;
	Unit* unit = (proc->list[i].unitRam);
	
   

	
	
	
	
	u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	TextHandle* currHandle = &command->text;
    Text_Clear(currHandle);
	Text_SetColorId(currHandle, TEXT_COLOR_NORMAL);

	
	//u16 textID = unit->pClassData->nameTextId; 
	u16 textID = unit->pCharacterData->nameTextId; 
	
	Text_InsertString(currHandle,2,TEXT_COLOR_NORMAL,GetStringFromIndex(textID));
    Text_Display(currHandle, out);
	
}



void StartPlatform(CreatorClassProcStruct* proc) 
{

	Struct_SelectCharacterProc* parent_proc = (Struct_SelectCharacterProc*)ProcFind(&ProcInstruction_SelectCharacter);
	parent_proc->platformType = 0x3F; // temple ? 
	for ( int i = 0 ; i < 5 ; i++ ) { proc->classes[i] = parent_proc->list[i].unitRam->pClassData->number; }
	proc->menuItem = parent_proc->currOptionIndex;
	proc->charID = parent_proc->list[proc->menuItem].unitRam->pCharacterData->number;
	
	//proc->menuItem = creator->lastClassIndex;
	//proc->charID = creator->tempUnit->pCharacterData->number;
	SetupMovingPlatform(0,-1,0x1F6,0x58,6);
	StartMovingPlatform(proc->platformType,0x118,gCharacterSelectorPlatformHeight);
}

static void DrawStatNames(TextHandle handle, char* string, int x, int y)
{
	Text_Clear(&handle);
	Text_SetColorId(&handle,TEXT_COLOR_GOLD);
	Text_AppendStringAscii(&handle,string);
	Text_Display(&handle,&gBG0MapBuffer[y][x]);
}




static
u8* UnitGetSkillList(struct Unit* unit)
{
    extern u8 gBWLDataStorage[];

    return gBWLDataStorage + 0x10 * (unit->pCharacterData->number - 1) + 1;
}


void SwitchInCharacter(MenuProc* proc, MenuCommandProc* commandProc) // Whenever you scroll or exit / confirm the character menu  
{
	
	u8 i = proc->commandIndex;
	
	
	Struct_SelectCharacterProc* parent_proc = (Struct_SelectCharacterProc*)ProcFind(&ProcInstruction_SelectCharacter);


	//struct Struct_SelectCharacterProc* parent_proc = (void*) proc->parent;
	parent_proc->currOptionIndex = i;
	
	
	
	// clear out stuff 
	// Clear out each 8x8 tile 
	// leave 12x 9y - 17x 19y alone as this contains text 
	BgMapFillRect(&gBG0MapBuffer[0][0],30,8,0); 
	BgMapFillRect(&gBG0MapBuffer[8][0],12,20-8,0); // Clear out each 8x8 tile 
	BgMapFillRect(&gBG0MapBuffer[8][19],30-19,20-8,0); // Clear out each 8x8 tile 
	BgMapFillRect(&gBG1MapBuffer[11][20],30-20,20-11,0); // Clear out each 8x8 tile 


	MU_EndAll();
	ClearIcons();
	
	
	
	
	
	
	
	CharacterSelectDrawUIBox(parent_proc);
	//parent_proc->currOptionIndex = commandProc->commandDefinitionIndex;

	Unit* unit = (parent_proc->list[parent_proc->currOptionIndex].unitRam);
	//asm("mov r11,r11");

// Looks like the battle platform uses the same area in obj VRAM as MMS, so we can't show it. 
// SMS does not seem to be set up to easily display in a UI like MMS is. 
/*
	struct MUProc* muProc = MU_CreateForUI(unit); //! FE8U = (0x080784F4+1)
	MU_SetDisplayPosition(muProc, 1*16, 2*16); //! FE8U = (0x080797E4+1)
	//MU_Show(muProc);
	struct MUConfig* muConfig = muProc->pMUConfig;
	muConfig->objTileIndex = 0;
	//&= ~(3 << 10); // Clear bits 10 and 11 (priority) such that they are 0 (highest priority) and appear above the background 
*/

	// Draw inventory 
	int iconX = 0x1C; 
	int iconY = 0xD; 
	for ( int i = 0 ; i < 4 ; i+=1 )
	{
		if ( unit->items[i] )
		{
			if (iconX > 0x19)
			{
			DrawIcon(&gBG0MapBuffer[iconY][iconX],GetItemIconId((unit->items[i])),TILEREF(0, 0x9));
			//DrawIcon(&gBG0MapBuffer[8][iconX],0x70+i,0x5000); // vanilla uses weapon type icons in item icon IDs starting at 0x70 and indexed by weapon type  
			// what if they have more than 5 weapon types ? 
			iconX -= 2;
			}
			else 
			{ 
				iconX = 0x1C;
				iconY += 2;
				DrawIcon(&gBG0MapBuffer[iconY][iconX],GetItemIconId((unit->items[i])),TILEREF(0, 0x9));
			}
		}
	}
	LoadIconPalettes(0x9);
	
	// Draw usable weapon types 
	iconX = 0xE;
	iconY = 1;
	for ( int i = 0 ; i < 8 ; i++ )
	{
		if ( unit->ranks[i] )
		{
			if (iconX < 0x12)
			{
				DrawIcon(&gBG0MapBuffer[iconY][iconX],0x0+i,TILEREF(0, 9)); // 0x5000 ? - palette bank 
				//DrawIcon(&gBG0MapBuffer[8][iconX],0x70+i,0x5000); // vanilla uses weapon type icons in item icon IDs starting at 0x70 and indexed by weapon type  
				// what if they have more than 5 weapon types ? 
				iconX += 3;
			}
			else 
			{ 
				iconX = 0xE;
				iconY += 2;
				DrawIcon(&gBG0MapBuffer[iconY][iconX],0x0+i,TILEREF(0, 9));
			}
		}
	}
	LoadIconPalettes(9);
	


	
	u8* skillList = UnitGetSkillList(unit); 
	//iconX = 15;
	//iconY = 6; 
	int c = 0;
	while ( skillList[c] )
	{
		if (iconX < 0x12)
			{
				DrawSkillIcon(&gBG0MapBuffer[iconY][iconX],skillList[c],TILEREF(0, 0xD)); // Tile ref is basically 0, PaletteIndex 
				c++;
				iconX += 3;
			}
		else 
			{
				iconX = 0xE;
				iconY += 2;
				if (iconY < 6)
				{
					DrawSkillIcon(&gBG0MapBuffer[iconY][iconX],skillList[c],TILEREF(0, 0xD));
				}
				c++;
			}
	}
	LoadIconPalettes(0xD);
	
	EndFaceById(0);
	
	FaceProc* faceProc = StartFace(0, GetUnitPortraitId(unit), 200, 8, 2);
	faceProc->tileData &= ~(3 << 10); // Clear bits 10 and 11 (priority) such that they are 0 (highest priority) and appear above the background 
	
	

	
	
	// Draw stats / growths 
	DrawUiNumber(&gBG0MapBuffer[5][6],TEXT_COLOR_GOLD,	(unit->maxHP	));
	DrawUiNumber(&gBG0MapBuffer[7][6],TEXT_COLOR_GOLD,	(unit->pow	));
	DrawUiNumber(&gBG0MapBuffer[9][6],TEXT_COLOR_GOLD, (unit->unk3A	)); // Magic.
	DrawUiNumber(&gBG0MapBuffer[11][6],TEXT_COLOR_GOLD,	unit->skl);
	DrawUiNumber(&gBG0MapBuffer[13][6],TEXT_COLOR_GOLD,	(unit->spd	));
	DrawUiNumber(&gBG0MapBuffer[15][6],TEXT_COLOR_GOLD,	(unit->def	));
	DrawUiNumber(&gBG0MapBuffer[17][6],TEXT_COLOR_GOLD,	(unit->res	));
	
	DrawUiNumber(&gBG0MapBuffer[5][10],TEXT_COLOR_GOLD,Get_Hp_Growth2(unit));
	DrawUiNumber(&gBG0MapBuffer[7][10],TEXT_COLOR_GOLD,Get_Str_Growth2(unit));
	DrawUiNumber(&gBG0MapBuffer[9][10],TEXT_COLOR_GOLD,Get_Mag_Growth2(unit));
	DrawUiNumber(&gBG0MapBuffer[11][10],TEXT_COLOR_GOLD,Get_Skl_Growth2(unit));
	DrawUiNumber(&gBG0MapBuffer[13][10],TEXT_COLOR_GOLD,Get_Spd_Growth2(unit));
	DrawUiNumber(&gBG0MapBuffer[15][10],TEXT_COLOR_GOLD,Get_Def_Growth2(unit));
	DrawUiNumber(&gBG0MapBuffer[17][10],TEXT_COLOR_GOLD,Get_Res_Growth2(unit));

	
	int tile = 0;
	int cost = gEventSlot[i+6]; // Cost in gold to purchase character 

	TextHandle GoldCostHandle = {
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 6
	};
	
	tile += 6;
	Text_Clear(&GoldCostHandle);
	if (cost)
	{
		Text_SetColorId(&GoldCostHandle,TEXT_COLOR_GOLD);
		//Text_DrawNumber(&GoldCostHandle, cost);
		DrawUiNumber(&gBG0MapBuffer[11][28], TEXT_COLOR_GREEN, cost); 
		//Text_Display(&GoldCostHandle,&gBG0MapBuffer[11][28]);
	} 


	TextHandle GoldNameHandle = {
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 4
	};
	
	tile += 4;
	Text_Clear(&GoldNameHandle);
	
	if (cost)
	{
		Text_SetColorId(&GoldNameHandle,TEXT_COLOR_GOLD);
		//void DrawTextInline(struct TextHandle*, u16* bg, int color, int xStart, int tileWidth, const char* cstring); //! FE8U = 0x800443D
		DrawTextInline(&GoldNameHandle, gBG0MapBuffer[11][20], TEXT_COLOR_GOLD, 0, 4, "  Cost:");
		Text_Display(&GoldNameHandle,&gBG0MapBuffer[11][20]);
	}

	TextHandle GoldSymbolHandle = {
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 1
	};
	
	tile += 1;
	Text_Clear(&GoldSymbolHandle);
	if (cost)
	{
		Text_SetColorId(&GoldSymbolHandle,TEXT_COLOR_GOLD);
		//void DrawTextInline(struct TextHandle*, u16* bg, int color, int xStart, int tileWidth, const char* cstring); //! FE8U = 0x800443D
		DrawTextInline(&GoldSymbolHandle, gBG0MapBuffer[11][29], TEXT_COLOR_GOLD, 0, 1, "G");
		Text_Display(&GoldSymbolHandle,&gBG0MapBuffer[11][29]);
	}	
	
	
	
	

	
	
	
	
	
	
	TextHandle classNameHandle = {
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 6
	};
	tile += 6;
	Text_Clear(&classNameHandle);
	Text_SetColorId(&classNameHandle,TEXT_COLOR_GOLD);
	Text_InsertString(&classNameHandle,0,TEXT_COLOR_GOLD,GetStringFromIndex(unit->pClassData->nameTextId));
	Text_Display(&classNameHandle,&gBG0MapBuffer[1][5]);
	
	
	TextHandle baseHandle =	{
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 4
	};
	tile += 4;
	Text_Clear(&baseHandle);
	Text_SetColorId(&baseHandle,TEXT_COLOR_GOLD);
	Text_InsertString(&baseHandle,0,TEXT_COLOR_GOLD,"Base");
	Text_Display(&baseHandle,&gBG0MapBuffer[3][4]);
	
	TextHandle growthHandle = {
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 4
	};
	tile += 4;
	Text_Clear(&growthHandle);
	Text_SetColorId(&growthHandle,TEXT_COLOR_GOLD);
	Text_InsertString(&growthHandle,0,TEXT_COLOR_GOLD,"Growth");
	Text_Display(&growthHandle,&gBG0MapBuffer[3][8]);
	
	TextHandle hpHandle = {
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 2
	};
	tile += 2;
	DrawStatNames(hpHandle,"HP",2,5);
	
	TextHandle strHandle = {
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 3
	};
	tile += 3;
	DrawStatNames(strHandle,"Str",2,7);
	
	TextHandle magHandle = {
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 3
	};
	tile += 3;
	DrawStatNames(magHandle,"Mag",2,9);
	
	TextHandle sklHandle = {
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 3
	};
	tile += 3;
	DrawStatNames(sklHandle,"Skl",2,11);
	
	TextHandle spdHandle = {
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 3
	};
	tile += 3;
	DrawStatNames(spdHandle,"Spd",2,13);
	
	TextHandle defHandle = {
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 3
	};
	tile += 3;
	DrawStatNames(defHandle,"Def",2,15);
	
	TextHandle resHandle = {
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 3
	};
	tile += 3;
	DrawStatNames(resHandle,"Res",2,17);
	
	EnableBgSyncByMask(1);
	//BgMapFillRect(&gBG0MapBuffer[1][12],30-12,2,0);
	ClearIcons();
	
	CreatorClassProcStruct* classProc = (CreatorClassProcStruct*)ProcFind(ProcInstruction_CreatorClassProc);
	if ( !classProc ) { ProcStart(ProcInstruction_CreatorClassProc,(Proc*)parent_proc); } // If the creator class proc doesn't exist yet, make one.
	else
	{
		// Otherwise, update relevant fields.
		classProc->mode = 1;
		for ( int i = 0 ; i < 5 ; i++ ) { classProc->classes[i] = parent_proc->list[i].unitRam->pClassData->number; }
		classProc->menuItem = commandProc->commandDefinitionIndex;
		classProc->charID = parent_proc->list[commandProc->commandDefinitionIndex].unitRam->pCharacterData->number;
	}
	
	
}


void SwitchOutCharacter(MenuProc* proc, MenuCommandProc* commandProc) // Whenever you scroll or exit / confirm the character menu  
{


}


static int SelectClass(struct MenuProc* menu, struct MenuCommandProc* command)
{
	Struct_SelectCharacterProc* parent_proc = (Struct_SelectCharacterProc*)ProcFind(&ProcInstruction_SelectCharacter);
	//struct Struct_ConfirmationProc* proc = (void*) ProcStartBlocking(ProcInstruction_Confirmation, parent_proc);
	struct Struct_ConfirmationProc* proc = (void*) ProcStartBlocking(ProcInstruction_Confirmation, menu);

	//Struct_SelectCharacterProc* proc_variables = (void*)(Struct_SelectCharacterProc*)ProcFind(&ProcInstruction_SelectCharacter[0]);
	// useful probably 

	StartMenuChild(&MenuDef_ConfirmCharacter, (void*) proc);
	return ME_NONE ;
	//return ME_DISABLE | ME_PLAY_BEEP;
	//return ME_DISABLE | ME_END | ME_PLAY_BEEP;
	//return ME_DISABLE | ME_END | ME_PLAY_BEEP | ME_CLEAR_GFX;
}


static int SelectYes(struct MenuProc* menu, struct MenuCommandProc* command)
{
	//SelectCharacterMenuEnd(menu);

	SelectCharacterMenuEnd();
	//proc->destructorBool = 1; // Start destruction sequence  
	//ProcGoto(proc, 1); // Destructor label 
	return ME_DISABLE | ME_END | ME_PLAY_BEEP | ME_CLEAR_GFX;
}

static int SelectNo(struct MenuProc* menu, struct MenuCommandProc* command)
{
	//(void*) (SelectCharacter_ASMC);
	Struct_SelectCharacterProc* proc = (Struct_SelectCharacterProc*)ProcFind(&ProcInstruction_SelectCharacter);
	//ProcGoto(proc, 0); // Restart label
	return ME_END | ME_PLAY_BEEP;
	//return ME_DISABLE | ME_END | ME_PLAY_BEEP | ME_CLEAR_GFX;
}


void SelectCharacterMenuEnd(void)
{
	
	Struct_SelectCharacterProc* proc = (Struct_SelectCharacterProc*)ProcFind(&ProcInstruction_SelectCharacter);
	EndProc(proc);
	
    EndFaceById(0);
	
    UnlockGameLogic();
	UnlockGameGraphicsLogic(); 
	MU_AllEnable();
	//BgMapFillRect(&gBG0MapBuffer[0][0],30,8,0); 
	//BgMapFillRect(&gBG0MapBuffer[8][0],11,20-8,0); // Clear out each 8x8 tile 
	//BgMapFillRect(&gBG0MapBuffer[8][18],30-18,20-8,0); // Clear out each 8x8 tile 
	
	BreakRoutine();

	DeleteSomeAISStuff(&gSomeAISStruct);
	DeleteSomeAISProcs(&gSomeAISRelatedStruct);
	EndEkrAnimeDrvProc();
	//UnlockGameGraphicsLogic();
	//RefreshEntityMaps();
	//DrawTileGraphics();
	SMS_UpdateFromGameData();
	MU_EndAll();
	
}


static const struct MenuCommandDefinition MenuCommands_CharacterProc1[] =
{
    {
        .isAvailable = MenuCommandAlwaysUsable,
        .onEffect = SelectClass,
		.onDraw = DrawSelect_0,
		.onSwitchIn = SwitchInCharacter, 
		.onSwitchOut = SwitchOutCharacter, 
    },
    {} // END
};

static const struct MenuCommandDefinition MenuCommands_CharacterProc2[] =
{
    {
        .isAvailable = MenuCommandAlwaysUsable,
        .onEffect = SelectClass,
		.onDraw = DrawSelect_0,
		.onSwitchIn = SwitchInCharacter, 
		.onSwitchOut = SwitchOutCharacter, 
    },

    {
        .isAvailable = MenuCommandAlwaysUsable,
        .onEffect = SelectClass,
		.onDraw = DrawSelect_1,
		.onSwitchIn = SwitchInCharacter, 
		.onSwitchOut = SwitchOutCharacter, 
    },
    {} // END
};
static const struct MenuCommandDefinition MenuCommands_CharacterProc3[] =
{
    {
        .isAvailable = MenuCommandAlwaysUsable,
        .onEffect = SelectClass,
		.onDraw = DrawSelect_0,
		.onSwitchIn = SwitchInCharacter, 
		.onSwitchOut = SwitchOutCharacter, 
    },

    {
        .isAvailable = MenuCommandAlwaysUsable,
        .onEffect = SelectClass,
		.onDraw = DrawSelect_1,
		.onSwitchIn = SwitchInCharacter, 
		.onSwitchOut = SwitchOutCharacter, 
    },
    {
        .isAvailable = MenuCommandAlwaysUsable,
        .onEffect = SelectClass,
		.onDraw = DrawSelect_2,
		.onSwitchIn = SwitchInCharacter, 
		.onSwitchOut = SwitchOutCharacter, 
    },
    {} // END
};
static const struct MenuCommandDefinition MenuCommands_CharacterProc4[] =
{
    {
        .isAvailable = MenuCommandAlwaysUsable,
        .onEffect = SelectClass,
		.onDraw = DrawSelect_0,
		.onSwitchIn = SwitchInCharacter, 
		.onSwitchOut = SwitchOutCharacter, 
    },

    {
        .isAvailable = MenuCommandAlwaysUsable,
        .onEffect = SelectClass,
		.onDraw = DrawSelect_1,
		.onSwitchIn = SwitchInCharacter, 
		.onSwitchOut = SwitchOutCharacter, 
    },
    {
        .isAvailable = MenuCommandAlwaysUsable,
        .onEffect = SelectClass,
		.onDraw = DrawSelect_2,
		.onSwitchIn = SwitchInCharacter, 
		.onSwitchOut = SwitchOutCharacter, 
    },
    {
        .isAvailable = MenuCommandAlwaysUsable,
        .onEffect = SelectClass,
		.onDraw = DrawSelect_3,
		.onSwitchIn = SwitchInCharacter, 
		.onSwitchOut = SwitchOutCharacter, 
    },
    {} // END
};
static const struct MenuCommandDefinition MenuCommands_CharacterProc5[] =
{
    {
        .isAvailable = MenuCommandAlwaysUsable,
        .onEffect = SelectClass,
		.onDraw = DrawSelect_0,
		.onSwitchIn = SwitchInCharacter, 
		.onSwitchOut = SwitchOutCharacter, 
    },

    {
        .isAvailable = MenuCommandAlwaysUsable,
        .onEffect = SelectClass,
		.onDraw = DrawSelect_1,
		.onSwitchIn = SwitchInCharacter, 
		.onSwitchOut = SwitchOutCharacter, 
    },
    {
        .isAvailable = MenuCommandAlwaysUsable,
        .onEffect = SelectClass,
		.onDraw = DrawSelect_2,
		.onSwitchIn = SwitchInCharacter, 
		.onSwitchOut = SwitchOutCharacter, 
    },
    {
        .isAvailable = MenuCommandAlwaysUsable,
        .onEffect = SelectClass,
		.onDraw = DrawSelect_3,
		.onSwitchIn = SwitchInCharacter, 
		.onSwitchOut = SwitchOutCharacter, 
    },
    {
        .isAvailable = MenuCommandAlwaysUsable,
        .onEffect = SelectClass,
		.onDraw = DrawSelect_4,
		.onSwitchIn = SwitchInCharacter, 
		.onSwitchOut = SwitchOutCharacter, 
    },
    {} // END
};


static const struct MenuDefinition MenuDef_SelectCharacter1 =
{
    .geometry = { 12, 8, 8 },
	.style = 0,
    .commandList = MenuCommands_CharacterProc1,
	._u14 = 0,
    //.onEnd = SelectCharacterMenuEnd,
	.onInit = 0,
	.onBPress = SelectCharacterMenuEnd, 
	.onRPress = 0,
	.onHelpBox = 0, 	
};
static const struct MenuDefinition MenuDef_SelectCharacter2 =
{
    .geometry = { 12, 8, 8 },
	.style = 0,
    .commandList = MenuCommands_CharacterProc2,
	._u14 = 0,
    //.onEnd = SelectCharacterMenuEnd,
	.onInit = 0,
	.onBPress = SelectCharacterMenuEnd,
	.onRPress = 0,
	.onHelpBox = 0, 	
};
static const struct MenuDefinition MenuDef_SelectCharacter3 =
{
    .geometry = { 12, 8, 8 },
	.style = 0,
    .commandList = MenuCommands_CharacterProc3,
	._u14 = 0,
    //.onEnd = SelectCharacterMenuEnd,
	.onInit = 0,
	.onBPress = SelectCharacterMenuEnd,
	.onRPress = 0,
	.onHelpBox = 0, 	
};
static const struct MenuDefinition MenuDef_SelectCharacter4 =
{
    .geometry = { 12, 8, 8 },
	.style = 0,
    .commandList = MenuCommands_CharacterProc4,
	._u14 = 0,
    //.onEnd = SelectCharacterMenuEnd,
	.onInit = 0,
	.onBPress = SelectCharacterMenuEnd,
	.onRPress = 0,
	.onHelpBox = 0, 	
};
static const struct MenuDefinition MenuDef_SelectCharacter5 =
{
    .geometry = { 12, 8, 8 },
	.style = 0,
    .commandList = MenuCommands_CharacterProc5,
	._u14 = 0,
    //.onEnd = SelectCharacterMenuEnd,
	.onInit = 0,
	.onBPress = SelectCharacterMenuEnd,
	.onRPress = 0,
	.onHelpBox = 0, 	
};








