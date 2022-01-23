
#include "gbafe.h"

typedef struct CreatorClassProcStruct CreatorClassProcStruct;
typedef struct Struct_SelectCharacterProc Struct_SelectCharacterProc;
typedef struct SomeAISStruct SomeAISStruct;

extern const MenuDefinition gSelectUnitMenuDefs;

int RestartSelectCharacter_ASMC(struct MenuProc* menu, struct MenuCommandProc* command);
void SelectCharacter_ASMC(Proc* proc);
void SelectCharacter_StartMenu(struct Struct_SelectCharacterProc* proc);
static int SelectClass(struct MenuProc* menu, struct MenuCommandProc* command);
static int SelectYes(struct MenuProc* menu, struct MenuCommandProc* command);
static int SelectNo(struct MenuProc* menu, struct MenuCommandProc* command);
void SelectCharacterMenuEnd_ReturnTrue(void); // Exited menu selecting "yes" - write 1 to memory slot C 
void SelectCharacterMenuEnd_ReturnFalse(void); // Exited menu by pressing B - write 0 to memory slot C 
void SelectCharacterMenuEnd(void);
static void DrawSelectCharacterCommands(struct MenuProc* menu, struct MenuCommandProc* command);
static void CallSwitchInCharacter(MenuProc* proc);
static void SwitchInCharacter(void);
static void SwitchOutCharacter(MenuProc* proc, MenuCommandProc* commandProc);
static void StartPlatform(CreatorClassProcStruct* proc);
static void CreatorClassEndProc(CreatorClassProcStruct* proc);
static const struct MenuDefinition MenuDef_SelectCharacter1;
static const struct MenuDefinition MenuDef_SelectCharacter2;
static const struct MenuDefinition MenuDef_SelectCharacter3;
static const struct MenuDefinition MenuDef_SelectCharacter4;
static const struct MenuDefinition MenuDef_SelectCharacter5;
static void DrawYes(struct MenuProc* menu, struct MenuCommandProc* command);
static void DrawNo(struct MenuProc* menu, struct MenuCommandProc* command);

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
	u8 destructorBool;
	u8 unk1[0x2C-0x2a]; // 0x29.
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

extern TSA gTopStatsUIBoxTSA;
extern TSA gBottomStatsUIBoxTSA;
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
extern AIStruct gAISArray; // 0x2028F78.

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

void CreatorIdle(Struct_SelectCharacterProc* proc)
{

}

static const struct ProcInstruction ProcInstruction_SelectCharacter[] =
{
	
    PROC_CALL_ROUTINE(LockGameLogic),
	PROC_CALL_ROUTINE(LockGameGraphicsLogic),
	PROC_CALL_ROUTINE(MU_AllDisable), 
	PROC_YIELD,
	

	PROC_CALL_ROUTINE(SelectCharacter_StartMenu),

	PROC_LABEL(0),
    PROC_LOOP_ROUTINE(CreatorIdle),

	PROC_LABEL(1),
	PROC_END_ALL(0x85B64D1), //#define MenuProc 0x5B64D0
	PROC_CALL_ROUTINE(UnlockGameLogic),
	PROC_CALL_ROUTINE(UnlockGameGraphicsLogic), 
	PROC_CALL_ROUTINE(MU_AllEnable),
	
    PROC_END,
};





static const struct ProcInstruction ProcInstruction_CreatorClassProc[] =
{
	PROC_YIELD,
	PROC_CALL_ROUTINE(SwitchInCharacter), 
	PROC_CALL_ROUTINE(StartPlatform),
	PROC_LOOP_ROUTINE(CreatorClassDisplayLoop),
	PROC_CALL_ROUTINE(CreatorClassEndProc),
	PROC_END, 
}; 

static const struct ProcInstruction ProcInstruction_Confirmation[] =
{
    PROC_YIELD,
    PROC_END,
};






static const struct MenuCommandDefinition MenuCommands_ConfirmationProc[] =
{
    {
        .isAvailable = MenuCommandAlwaysUsable,
		.onDraw = DrawYes,
        .onEffect = SelectYes,
    },

    {
        .isAvailable = MenuCommandAlwaysUsable,

        .onDraw = DrawNo, 
        .onEffect = SelectNo,
    },
    {} // END
};





static const struct MenuDefinition MenuDef_ConfirmCharacter =
{
    .geometry = { 25, 13, 5 },
    .commandList = MenuCommands_ConfirmationProc, 

    //.onEnd = SelectCharacterMenuEnd,
    .onBPress = (SelectNo), 
};



void SelectCharacter_ASMC(Proc* proc) // ASMC 
{
	gEventSlot[0xC] = 0x100; // Default unit id as 0x100 / no unit was selected 
	Struct_SelectCharacterProc* charProc = ProcStartBlocking(ProcInstruction_SelectCharacter, proc);
}

void SelectCharacter_StartMenu(struct Struct_SelectCharacterProc* proc)
{
	//Struct_SelectCharacterProc* proc = (Struct_SelectCharacterProc*)ProcFind(&ProcInstruction_SelectCharacter);
	
	proc->activeUnit = gActiveUnit;


	for ( int i = 0 ; i < 5 ; i++ ) // Mem slots 1 - 5 as unit IDs to display 
	{ 	
		proc->list[i].unitRam = GetUnitByCharId(gEventSlot[i+1]); //Unit* 
	}
	
	proc->currOptionIndex = 0;
	// Determine menu size based on values in memory slots 1-5 being non-zero. 
    if 		(proc->list[4].unitRam && proc->list[3].unitRam && proc->list[2].unitRam && proc->list[1].unitRam && proc->list[0].unitRam) StartMenu(&MenuDef_SelectCharacter5);
	else if (proc->list[3].unitRam && proc->list[2].unitRam && proc->list[1].unitRam && proc->list[0].unitRam) StartMenu(&MenuDef_SelectCharacter4);
	else if (proc->list[2].unitRam && proc->list[1].unitRam && proc->list[0].unitRam) StartMenu(&MenuDef_SelectCharacter3);
	else if (proc->list[1].unitRam && proc->list[0].unitRam) StartMenu(&MenuDef_SelectCharacter2);
	else if (proc->list[0].unitRam) StartMenu(&MenuDef_SelectCharacter1);
	
}


void CharacterSelectDrawUIBox(Struct_SelectCharacterProc* proc)
{
	//BgMap_ApplyTsa(u16* target, const void* source, u16 tileBase)
	// Menu BG 
	BgMap_ApplyTsa(&gBG1MapBuffer[0][19], &gPortraitUIBoxTSA, 0); //20*8 as X, 0*0 as Y 
	
	
	BgMap_ApplyTsa(&gBG1MapBuffer[0][0], &gTopStatsUIBoxTSA, 0);
	BgMap_ApplyTsa(&gBG1MapBuffer[5][0], &gBottomStatsUIBoxTSA, 0);
	// Portrait BG  
	//BgMap_ApplyTsa(&gBG1MapBuffer[0][20], &gPortraitUIBoxTSA, 0); //20*8 as X, 0*0 as Y 

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

static void DrawSelectCharacterCommands(struct MenuProc* menu, struct MenuCommandProc* command)
{
	
	// does nothing but it's necessary to have a .onDraw or .rawName I believe 
}



void StartPlatform(CreatorClassProcStruct* proc) 
{

	Struct_SelectCharacterProc* parent_proc = (Struct_SelectCharacterProc*)ProcFind(&ProcInstruction_SelectCharacter);
	proc->platformType = 0x3F; // Temple ?  
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
	//Text_AppendStringAscii(&handle,string);
	Text_DrawString(&handle,string);
	Text_Display(&handle,&gBG0MapBuffer[y][x]);
}




static
u8* UnitGetSkillList(struct Unit* unit)
{
    extern u8 gBWLDataStorage[];

    return gBWLDataStorage + 0x10 * (unit->pCharacterData->number - 1) + 1;
}

void CallSwitchInCharacter(MenuProc* proc)
{
	u8 i = proc->commandIndex;
	
	
	Struct_SelectCharacterProc* parent_proc = (Struct_SelectCharacterProc*)ProcFind(&ProcInstruction_SelectCharacter);


	//struct Struct_SelectCharacterProc* parent_proc = (void*) proc->parent;
	parent_proc->currOptionIndex = i;
	
	SwitchInCharacter(); 
}

void SwitchInCharacter(void) // Whenever you scroll or exit / confirm the character menu  
{
	Struct_SelectCharacterProc* parent_proc = (Struct_SelectCharacterProc*)ProcFind(&ProcInstruction_SelectCharacter);


	u8 i = parent_proc->currOptionIndex;
	
	
	
	// clear out stuff 
	// Clear out each 8x8 tile 
	// leave 12x 9y - 17x 19y alone as this contains text 
	BgMapFillRect(&gBG0MapBuffer[0][0],30,8,0); 
	BgMapFillRect(&gBG0MapBuffer[8][0],11,20-8,0); // Clear out each 8x8 tile 
	BgMapFillRect(&gBG0MapBuffer[8][19],30-19,20-8,0); // Clear out each 8x8 tile 
	BgMapFillRect(&gBG1MapBuffer[11][20],30-20,20-11,0); // Clear out each 8x8 tile 


	MU_EndAll();
	ClearIcons();
	Font_ResetAllocation(); // 0x08003D20
	

	
	
	
	CharacterSelectDrawUIBox(parent_proc);

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
			DrawIcon(&gBG0MapBuffer[iconY][iconX],GetItemIconId((unit->items[i])),TILEREF(0, 0xC));
			//DrawIcon(&gBG0MapBuffer[8][iconX],0x70+i,0x5000); // vanilla uses weapon type icons in item icon IDs starting at 0x70 and indexed by weapon type  
			// what if they have more than 5 weapon types ? 
			iconX -= 2;
			}
			else 
			{ 
				iconX = 0x1C;
				iconY += 2;
				DrawIcon(&gBG0MapBuffer[iconY][iconX],GetItemIconId((unit->items[i])),TILEREF(0, 0xC));
			}
		}
	}
	LoadIconPalettes(0xC);
	
	// Draw usable weapon types 
	iconX = 0xE;
	iconY = 1;
	for ( int i = 0 ; i < 8 ; i++ )
	{
		if ( unit->ranks[i] )
		{
			if (iconX < 0x12)
			{
				DrawIcon(&gBG0MapBuffer[iconY][iconX],0x70+i,TILEREF(0, 0xE)); // 0x5000 ? - palette bank 
				//DrawIcon(&gBG0MapBuffer[8][iconX],0x70+i,0x5000); // vanilla uses weapon type icons in item icon IDs starting at 0x70 and indexed by weapon type  
				// what if they have more than 5 weapon types ? 
				iconX += 3;
			}
			else 
			{ 
				iconX = 0xE;
				iconY += 2;
				DrawIcon(&gBG0MapBuffer[iconY][iconX],0x0+i,TILEREF(0, 0xE));
			}
		}
	}
	LoadIconPalettes(0xE);
	


	
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
	//FaceProc* faceProc = StartFace(0, GetUnitPortraitId(unit), 200, 8, 2);
	faceProc->tileData &= ~(3 << 10); // Clear bits 10 and 11 (priority) such that they are 0 (highest priority) and appear above the background 
	
	

	
	
	// Draw stats / growths 
	DrawUiNumber(&gBG0MapBuffer[5][6],TEXT_COLOR_GOLD,	(unit->maxHP	));
	DrawUiNumber(&gBG0MapBuffer[7][6],TEXT_COLOR_GOLD,	(unit->pow	));
	DrawUiNumber(&gBG0MapBuffer[9][6],TEXT_COLOR_GOLD, (unit->unk3A	)); // Magic.
	DrawUiNumber(&gBG0MapBuffer[11][6],TEXT_COLOR_GOLD,	unit->skl);
	DrawUiNumber(&gBG0MapBuffer[13][6],TEXT_COLOR_GOLD,	(unit->spd	));
	DrawUiNumber(&gBG0MapBuffer[15][6],TEXT_COLOR_GOLD,	(unit->def	));
	DrawUiNumber(&gBG0MapBuffer[17][6],TEXT_COLOR_GOLD,	(unit->res	));
	
	extern int MakeThumb(int* inte, Unit* unit); 
	extern int Get_Hp_Growth(Unit* unit); 
	extern int Get_Str_Growth(Unit* unit); 
	extern int Get_Mag_Growth(Unit* unit); 
	extern int Get_Skl_Growth(Unit* unit); 
	extern int Get_Spd_Growth(Unit* unit); 
	extern int Get_Def_Growth(Unit* unit); 
	extern int Get_Res_Growth(Unit* unit);  

	//DrawUiNumber(&gBG0MapBuffer[5][10],TEXT_COLOR_GOLD,  Get_Hp_Growth(unit));
	
	DrawUiNumber(&gBG0MapBuffer[5][10],TEXT_COLOR_GOLD,  MakeThumb(Get_Hp_Growth, unit)); 
	DrawUiNumber(&gBG0MapBuffer[7][10],TEXT_COLOR_GOLD, MakeThumb(Get_Str_Growth, unit));
	DrawUiNumber(&gBG0MapBuffer[9][10],TEXT_COLOR_GOLD, MakeThumb(Get_Mag_Growth, unit));
	DrawUiNumber(&gBG0MapBuffer[11][10],TEXT_COLOR_GOLD,MakeThumb(Get_Skl_Growth, unit));
	DrawUiNumber(&gBG0MapBuffer[13][10],TEXT_COLOR_GOLD,MakeThumb(Get_Spd_Growth, unit));
	DrawUiNumber(&gBG0MapBuffer[15][10],TEXT_COLOR_GOLD,MakeThumb(Get_Def_Growth, unit));
	DrawUiNumber(&gBG0MapBuffer[17][10],TEXT_COLOR_GOLD,MakeThumb(Get_Res_Growth, unit));

	// Initialize font. Probably unnecessary vast majority of the time (if not always) 
	Text_SetFont(0);
    Text_SetFontStandardGlyphSet(0);



	
	int tile = 40; // Why ??????????????? 
	int cost = gEventSlot[i+6]; // Cost in gold to purchase character 


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
	
	
	


	TextHandle percentHandle = {
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 1
	};
	tile += 1;
	Text_InitClear(&percentHandle, 1);
	DrawStatNames(percentHandle,"%",11,5);
	DrawStatNames(percentHandle,"%",11,7);
	DrawStatNames(percentHandle,"%",11,9);
	DrawStatNames(percentHandle,"%",11,11);
	DrawStatNames(percentHandle,"%",11,13);
	DrawStatNames(percentHandle,"%",11,15);
	DrawStatNames(percentHandle,"%",11,17);






	TextHandle GoldCostHandle = {
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		//.tileWidth = 6
	};
	
	tile += 6;
	//Text_InitClear(&GoldCostHandle, 6);
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
	Text_InitClear(&GoldNameHandle, 4);
	Text_Clear(&GoldNameHandle);
	
	if (cost)
	{
		Text_SetColorId(&GoldNameHandle,TEXT_COLOR_GOLD);
		//void DrawTextInline(struct TextHandle*, u16* bg, int color, int xStart, int tileWidth, const char* cstring); //! FE8U = 0x800443D
		DrawTextInline(&GoldNameHandle, gBG0MapBuffer[11][20], TEXT_COLOR_GOLD, 4, 4, "Cost:");
		Text_Display(&GoldNameHandle,&gBG0MapBuffer[11][20]);
	}

    //
	//
    //// draw "Success"
    //Text_InitClear(someTextHandleArray, 5);
    //Text_Clear(someTextHandleArray);
    //Text_InsertString(someTextHandleArray, 0, 0, GetStringFromIndex(0x5AA));
	
	
	u8 charName0 = GetStringTextWidthAscii(GetStringFromIndex(parent_proc->list[0].unitRam->pClassData->nameTextId));

	TextHandle char0NameHandle = {
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 6, //charName0,
		.xCursor = 2, 
		//GetCharTextWidthAscii(GetStringFromIndex(parent_proc->list[0].unitRam->pCharacterData->nameTextId), &char0NameHandle.tileWidth)
		//GetStringTextWidthAscii(GetStringFromIndex(parent_proc->list[0].unitRam->pCharacterData->nameTextId))
	};
	tile += 6;
	//Text_InitClear(&char0NameHandle, 5);
	Text_Clear(&char0NameHandle);
	
	Text_SetColorId(&char0NameHandle,TEXT_COLOR_GRAY);
	if (CanWeSelectCharacter(0)==1) Text_SetColorId(&char0NameHandle,TEXT_COLOR_GOLD);
	
	
	struct TextHandle char1NameHandle = {
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 6
//		.xCursor = 2, 
	};
	tile += 6;
	//Text_InitClear(&char1NameHandle,5);
	Text_Clear(&char1NameHandle);
	Text_SetColorId(&char1NameHandle,TEXT_COLOR_GRAY);
	if (CanWeSelectCharacter(1)==1) Text_SetColorId(&char1NameHandle,TEXT_COLOR_GOLD);
	
	struct TextHandle char2NameHandle = {
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 6,
	//	.xCursor = 2, 
	};
	tile += 6;
	//Text_InitClear(&char2NameHandle,5);
	Text_Clear(&char2NameHandle);
	Text_SetColorId(&char2NameHandle,TEXT_COLOR_GRAY);
	if (CanWeSelectCharacter(2)==1) Text_SetColorId(&char2NameHandle,TEXT_COLOR_GOLD);
	
	struct TextHandle char3NameHandle = {
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 6,
		//.xCursor = 2, 
	};
	tile += 6;
	//Text_InitClear(&char3NameHandle,5);
	Text_Clear(&char3NameHandle);
	Text_SetColorId(&char3NameHandle,TEXT_COLOR_GRAY);
	if (CanWeSelectCharacter(3)==1) Text_SetColorId(&char3NameHandle,TEXT_COLOR_GOLD);
	
	struct TextHandle char4NameHandle = {
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 6,
		//.xCursor = 2, 
	};
	tile += 6;
	//Text_InitClear(&char4NameHandle,5);
	Text_Clear(&char4NameHandle);
	Text_SetColorId(&char4NameHandle,TEXT_COLOR_GRAY);
	if (CanWeSelectCharacter(4)==1) Text_SetColorId(&char4NameHandle,TEXT_COLOR_GOLD);
	
	// Display main menu options based on character ID  
	if (parent_proc->list[4].unitRam && parent_proc->list[3].unitRam && parent_proc->list[2].unitRam && parent_proc->list[1].unitRam && parent_proc->list[0].unitRam) 
	{
		Text_DrawString(&char4NameHandle, GetStringFromIndex(parent_proc->list[4].unitRam->pClassData->nameTextId));
		//Text_InsertString(&char4NameHandle,2,TEXT_COLOR_GOLD,GetStringFromIndex(parent_proc->list[4].unitRam->pCharacterData->nameTextId));
		Text_Display(&char4NameHandle,&gBG0MapBuffer[17][13]);		
	}
	if (parent_proc->list[3].unitRam && parent_proc->list[2].unitRam && parent_proc->list[1].unitRam && parent_proc->list[0].unitRam) 
	{
		//Text_InsertString(&char3NameHandle,2,TEXT_COLOR_GOLD,GetStringFromIndex(parent_proc->list[3].unitRam->pCharacterData->nameTextId));
		Text_DrawString(&char3NameHandle, GetStringFromIndex(parent_proc->list[3].unitRam->pClassData->nameTextId));
		Text_Display(&char3NameHandle,&gBG0MapBuffer[15][13]);
	}
	
	if (parent_proc->list[2].unitRam && parent_proc->list[1].unitRam && parent_proc->list[0].unitRam) 
	{
		//Text_InsertString(&char2NameHandle,2,TEXT_COLOR_GOLD,GetStringFromIndex(parent_proc->list[2].unitRam->pCharacterData->nameTextId));
		Text_DrawString(&char2NameHandle, GetStringFromIndex(parent_proc->list[2].unitRam->pClassData->nameTextId));
		Text_Display(&char2NameHandle,&gBG0MapBuffer[13][13]);	
	}

	if (parent_proc->list[1].unitRam && parent_proc->list[0].unitRam) 
	{
		//Text_InsertString(&char1NameHandle,2,TEXT_COLOR_GOLD,GetStringFromIndex(parent_proc->list[1].unitRam->pCharacterData->nameTextId));
		Text_DrawString(&char1NameHandle, GetStringFromIndex(parent_proc->list[1].unitRam->pClassData->nameTextId));
		Text_Display(&char1NameHandle,&gBG0MapBuffer[11][13]);
	}
	if (parent_proc->list[0].unitRam) 
	{
		//Text_InsertString(&char0NameHandle,2,TEXT_COLOR_GOLD,GetStringFromIndex(parent_proc->list[0].unitRam->pCharacterData->nameTextId));
		Text_DrawString(&char0NameHandle, GetStringFromIndex(parent_proc->list[0].unitRam->pClassData->nameTextId));
		Text_Display(&char0NameHandle,&gBG0MapBuffer[9][13]);	
	}
	
	
	TextHandle classNameHandle = {
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 6
	};
	tile += 6;
	//Text_InitClear(&classNameHandle,6);
	Text_Clear(&classNameHandle);
	Text_SetColorId(&classNameHandle,TEXT_COLOR_GOLD);
	Text_DrawString(&classNameHandle, GetStringFromIndex(unit->pClassData->nameTextId));
	//Text_InsertString(&classNameHandle,0,TEXT_COLOR_GOLD,GetStringFromIndex(unit->pClassData->nameTextId));
	Text_Display(&classNameHandle,&gBG0MapBuffer[1][5]);
	

	TextHandle baseHandle =	{
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 3
	};
	tile += 3;
	Text_InitClear(&baseHandle,3);
	Text_Clear(&baseHandle);
	Text_SetColorId(&baseHandle,TEXT_COLOR_GOLD);
	//void DrawTextInline(struct TextHandle*, u16* bg, int color, int xStart, int tileWidth, const char* cstring); //! FE8U = 0x800443D
	DrawTextInline(&baseHandle,&gBG0MapBuffer[3][4], TEXT_COLOR_GOLD, 0, 3,"Base");
	//Text_InsertString(&baseHandle,0,TEXT_COLOR_GOLD,"Base");
	Text_Display(&baseHandle,&gBG0MapBuffer[3][4]);
	
	TextHandle growthHandle = {
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 4
	};
	tile += 4;
	Text_InitClear(&growthHandle,4);
	Text_Clear(&growthHandle);
	Text_SetColorId(&growthHandle,TEXT_COLOR_GOLD);
	//Text_InsertString(&growthHandle,0,TEXT_COLOR_GOLD,"Growth");
	DrawTextInline(&growthHandle,&gBG0MapBuffer[3][8], TEXT_COLOR_GOLD, 0, 4,"Growth");
	Text_Display(&growthHandle,&gBG0MapBuffer[3][8]);
	
	TextHandle hpHandle = {
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 2
	};
	tile += 2;
	DrawStatNames(hpHandle,"HP",2,5);
	
	

	
	
	TextHandle strHandle = {
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 2
	};
	tile += 2;
	//Text_InitClear(&strHandle,2);
	DrawStatNames(strHandle,"Str",2,7);
	
	TextHandle magHandle = {
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 3
	};
	tile += 3;
	Text_InitClear(&magHandle,3);
	DrawStatNames(magHandle,"Mag",2,9);
	
	TextHandle sklHandle = {
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 2
	};
	tile += 2;
	Text_InitClear(&sklHandle,2);
	DrawStatNames(sklHandle,"Skl",2,11);
	
	TextHandle spdHandle = {
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 2
	};
	tile += 2;
	Text_InitClear(&spdHandle,2);
	DrawStatNames(spdHandle,"Spd",2,13);
	
	TextHandle defHandle = {
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 2
	};
	tile += 2;
	Text_InitClear(&defHandle,2);
	DrawStatNames(defHandle,"Def",2,15);
	
	TextHandle resHandle = {
		.tileIndexOffset = gpCurrentFont->tileNext+tile,
		.tileWidth = 2
	};
	tile += 2;
	Text_InitClear(&resHandle,2);
	DrawStatNames(resHandle,"Res",2,17);
	tile += 2;
	
	EnableBgSyncByMask(0);
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
		
		
		classProc->menuItem = parent_proc->currOptionIndex;
		//classProc->menuItem = commandProc->commandDefinitionIndex;
		classProc->charID = parent_proc->list[parent_proc->currOptionIndex].unitRam->pCharacterData->number;
		//classProc->charID = parent_proc->list[commandProc->commandDefinitionIndex].unitRam->pCharacterData->number;
	}
	
	
}

//void CreatorClassEndProc(void)
void CreatorClassEndProc(CreatorClassProcStruct* proc)
{
	proc->destructorBool = 0; // Destruct CreatorClassProcStruct 
	BgMapFillRect(&gBG0MapBuffer[0][0],30,8,0); 
	BgMapFillRect(&gBG0MapBuffer[8][0],11,20-8,0); // Clear out each 8x8 tile 
	BgMapFillRect(&gBG0MapBuffer[8][18],30-18,20-8,0); // Clear out each 8x8 tile 


	DeleteSomeAISStuff(&gSomeAISStruct);
	DeleteSomeAISProcs(&gSomeAISRelatedStruct);
	EndEkrAnimeDrvProc();
	
	
	//CPU_FILL(0,(char*)&gBG0MapBuffer[13][0]-1,(32-13)*32*2,32);
	//UnlockGameGraphicsLogic();
	//RefreshEntityMaps();
	//DrawTileGraphics();
	SMS_UpdateFromGameData();
	MU_EndAll();
}


static int SelectClass(struct MenuProc* menu, struct MenuCommandProc* command)
{
	if (CanWeSelectCharacter(menu->commandIndex)==2) return ME_NONE; // do nothing 
	
	Struct_SelectCharacterProc* parent_proc = (Struct_SelectCharacterProc*)ProcFind(&ProcInstruction_SelectCharacter);
	//struct Struct_ConfirmationProc* proc = (void*) ProcStartBlocking(ProcInstruction_Confirmation, menu);

// Hide inventory to display Yes/No there. 
	BgMapFillRect(&gBG0MapBuffer[13][26],30-26,20-13,0); // Clear out each 8x8 tile 
	BgMapFillRect(&gBG1MapBuffer[13][26],30-26,20-13,0); // Clear out each 8x8 tile 
	

	//Struct_SelectCharacterProc* proc_variables = (void*)(Struct_SelectCharacterProc*)ProcFind(&ProcInstruction_SelectCharacter[0]);
	// useful probably 

	StartMenuChild(&MenuDef_ConfirmCharacter, (void*) menu);
	//StartMenuChild(&MenuDef_ConfirmCharacter, (void*) proc);
	//return ME_NONE ;
	return ME_PLAY_BEEP; 
	//return ME_DISABLE | ME_PLAY_BEEP;
	//return ME_DISABLE | ME_END | ME_PLAY_BEEP;
	//return ME_DISABLE | ME_END | ME_PLAY_BEEP | ME_CLEAR_GFX;
}

static void DrawNo(struct MenuProc* menu, struct MenuCommandProc* command)
{
	u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	TextHandle* currHandle = &command->text;
    Text_Clear(currHandle);
	Text_SetColorId(currHandle, TEXT_COLOR_NORMAL);
	
	Text_DrawString(currHandle," No");
	//Text_InsertString(currHandle,0,TEXT_COLOR_NORMAL," No");
    Text_Display(currHandle, out);
}

static void DrawYes(struct MenuProc* menu, struct MenuCommandProc* command)
{

	
	u16* const out = gBg0MapBuffer + TILEMAP_INDEX(command->xDrawTile, command->yDrawTile);
	TextHandle* currHandle = &command->text;
    Text_Clear(currHandle);
	Text_SetColorId(currHandle, TEXT_COLOR_NORMAL);
	
	Text_DrawString(currHandle," Yes");
	//Text_InsertString(currHandle,0,TEXT_COLOR_NORMAL," Yes");
    Text_Display(currHandle, out);
	
}

extern int gPlayerGold;




static int SelectYes(struct MenuProc* menu, struct MenuCommandProc* command)
{
	SelectCharacterMenuEnd_ReturnTrue();
	//proc->destructorBool = 1; // Start destruction sequence  
	//ProcGoto(proc, 1); // Destructor label 
	
	Struct_SelectCharacterProc* selectCharProc = (Struct_SelectCharacterProc*)ProcFind(&ProcInstruction_SelectCharacter);
	gEventSlot[0xC] = selectCharProc->list[selectCharProc->currOptionIndex].unitRam->pCharacterData->number;

	
	int playerGold = gPlayerGold; 
	int goldCost = gEventSlot[selectCharProc->currOptionIndex+6]; 
	gPlayerGold = playerGold - goldCost; 


	EndAllMenus(menu);

	return ME_END | ME_PLAY_BEEP;
	//return ME_DISABLE | ME_END | ME_PLAY_BEEP | ME_CLEAR_GFX;
}

static int SelectNo(struct MenuProc* menu, struct MenuCommandProc* command)
{
	//(void*) (SelectCharacter_ASMC);
	Struct_SelectCharacterProc* proc = (Struct_SelectCharacterProc*)ProcFind(&ProcInstruction_SelectCharacter);
	
	//Struct_SelectCharacterProc* confirmation_proc = (Struct_SelectCharacterProc*)ProcFind(&ProcInstruction_SelectCharacter);
	//EndProc(confirmation_proc);
	
	SwitchInCharacter();
	
	
	//SwitchInCharacter();
	//ProcGoto(proc, 0); // Restart label
	//EndMenu(menu);
	//return ME_NONE | ME_PLAY_BEEP;
	return ME_END | ME_PLAY_BEEP;
	//return ME_DISABLE | ME_END | ME_PLAY_BEEP | ME_CLEAR_GFX;
}


void SelectCharacterMenuEnd_ReturnTrue(void)
{
	SelectCharacterMenuEnd();
}

void SelectCharacterMenuEnd_ReturnFalse(void)
{
	gEventSlot[0xC] = 0x100;
	SelectCharacterMenuEnd();
}


void SelectCharacterMenuEnd(void)
{
	
	
	CreatorClassProcStruct* creatorClass = (CreatorClassProcStruct*)ProcFind(&ProcInstruction_CreatorClassProc);
	CreatorClassEndProc(creatorClass);
	
	Struct_SelectCharacterProc* proc = (Struct_SelectCharacterProc*)ProcFind(&ProcInstruction_SelectCharacter);
	//EndProc(proc);
	//EndEachProc(&ProcInstruction_CreatorClassProc); //! FE8U = (0x08003078+1)
	//EndEachProc(&ProcInstruction_CreatorClassProc); //! FE8U = (0x08003078+1)
	//BreakEachProcLoop(&ProcInstruction_CreatorClassProc);
	
	//EndEachProc(&ProcInstruction_SelectCharacter); //! FE8U = (0x08003078+1)
	
	//
	//BgMapFillRect(&gBG0MapBuffer[0][0],30,8,0); 
	//BgMapFillRect(&gBG0MapBuffer[8][0],11,20-8,0); // Clear out each 8x8 tile 
	//BgMapFillRect(&gBG0MapBuffer[8][18],30-18,20-8,0); // Clear out each 8x8 tile 


	//CPU_FILL(0,(char*)&gBG0MapBuffer[13][0]-1,(32-13)*32*2,32);
	DeleteSomeAISStuff(&gSomeAISStruct);
	DeleteSomeAISProcs(&gSomeAISRelatedStruct);
	EndEkrAnimeDrvProc();
	//Proc* extraProc = (Proc*)ProcFind(0x8758A30); //gProc_ekrsubAnimeEmulator

	
	//Proc* extraProc = ProcFind(0x8758A30); //gProc_ekrsubAnimeEmulator
	//asm("mov r11,r11");
	//BreakEachProcLoop(0x8758A30);
	//BreakProcLoop(extraProc);
	//EndProc(extraProc);
	//EndEachProc(0x8758A30); //! FE8U = (0x08003078+1)
	

	//Proc* extraProc2 = (Proc*)ProcFind(0x85B9E0C); //gProc_ekrsubAnimeEmulator
	
	
	//asm("mov r11,r11");
	//EndProc(extraProc);


	
	//ProcStartBlocking(0x85B9E0C, proc);
	//BreakProcLoop(extraProc);
	
	//gProc_ekrTogiEndPROC, 0x85B9E0C
	//UnlockGameLogic();
	//UnlockGameGraphicsLogic();
	//MU_AllEnable();
	
	
    EndFaceById(0);
	
	


	//UnlockGameGraphicsLogic();
	//RefreshEntityMaps();
	//DrawTileGraphics();
	SMS_UpdateFromGameData();
	MU_EndAll();
	
	FillBgMap(gBg0MapBuffer,0);
	FillBgMap(gBg1MapBuffer,0);
	FillBgMap(gBg2MapBuffer,0);
	EnableBgSyncByMask(1|2|4);
	ProcGoto((Proc*)proc,1); // Destructor sequence 

}


int CanWeSelectCharacter(int i)
{
	
	int playerGold = gPlayerGold; 
	int goldCost = gEventSlot[i+6]; 
	// cost in gold 
	if (playerGold < goldCost) return 2; // greyed out 
	return 1; // Usable 
}



int CanWeSelectCharacter_0(void)
{
	return CanWeSelectCharacter(0);
}
int CanWeSelectCharacter_1(void)
{
	return CanWeSelectCharacter(1);
}
int CanWeSelectCharacter_2(void)
{
	return CanWeSelectCharacter(2);
}
int CanWeSelectCharacter_3(void)
{
	return CanWeSelectCharacter(3);
}
int CanWeSelectCharacter_4(void)
{
	return CanWeSelectCharacter(4);
}

static const struct MenuCommandDefinition MenuCommands_CharacterProc1[] =
{
    {
        .isAvailable = CanWeSelectCharacter_0,
        .onEffect = SelectClass,
		.onDraw = DrawSelectCharacterCommands,
		.onSwitchIn = CallSwitchInCharacter, 

    },
    {} // END
};

static const struct MenuCommandDefinition MenuCommands_CharacterProc2[] =
{
    {
        .isAvailable = CanWeSelectCharacter_0,
        .onEffect = SelectClass,
		.onDraw = DrawSelectCharacterCommands,
		.onSwitchIn = CallSwitchInCharacter, 

    },

    {
        .isAvailable = CanWeSelectCharacter_1,
        .onEffect = SelectClass,
		.onDraw = DrawSelectCharacterCommands,
		.onSwitchIn = CallSwitchInCharacter, 

    },
    {} // END
};
static const struct MenuCommandDefinition MenuCommands_CharacterProc3[] =
{
    {
        .isAvailable = CanWeSelectCharacter_0,
        .onEffect = SelectClass,
		.onDraw = DrawSelectCharacterCommands,
		.onSwitchIn = CallSwitchInCharacter, 

    },

    {
        .isAvailable = CanWeSelectCharacter_1,
        .onEffect = SelectClass,
		.onDraw = DrawSelectCharacterCommands,
		.onSwitchIn = CallSwitchInCharacter, 

    },
    {
        .isAvailable = CanWeSelectCharacter_2,
        .onEffect = SelectClass,
		.onDraw = DrawSelectCharacterCommands,
		.onSwitchIn = CallSwitchInCharacter, 

    },
    {} // END
};
static const struct MenuCommandDefinition MenuCommands_CharacterProc4[] =
{
    {
        .isAvailable = CanWeSelectCharacter_0,
        .onEffect = SelectClass,
		.onDraw = DrawSelectCharacterCommands,
		.onSwitchIn = CallSwitchInCharacter, 

    },

    {
        .isAvailable = CanWeSelectCharacter_1,
        .onEffect = SelectClass,
		.onDraw = DrawSelectCharacterCommands,
		.onSwitchIn = CallSwitchInCharacter, 

    },
    {
        .isAvailable = CanWeSelectCharacter_2,
        .onEffect = SelectClass,
		.onDraw = DrawSelectCharacterCommands,
		.onSwitchIn = CallSwitchInCharacter, 

    },
    {
        .isAvailable = CanWeSelectCharacter_3,
        .onEffect = SelectClass,
		.onDraw = DrawSelectCharacterCommands,
		.onSwitchIn = CallSwitchInCharacter, 

    },
    {} // END
};
static const struct MenuCommandDefinition MenuCommands_CharacterProc5[] =
{
    {
        .isAvailable = CanWeSelectCharacter_0,
        .onEffect = SelectClass,
		.onDraw = DrawSelectCharacterCommands,
		.onSwitchIn = CallSwitchInCharacter, 

    },

    {
        .isAvailable = CanWeSelectCharacter_1,
        .onEffect = SelectClass,
		.onDraw = DrawSelectCharacterCommands,
		.onSwitchIn = CallSwitchInCharacter, 

    },
    {
        .isAvailable = CanWeSelectCharacter_2,
        .onEffect = SelectClass,
		.onDraw = DrawSelectCharacterCommands,
		.onSwitchIn = CallSwitchInCharacter, 

    },
    {
        .isAvailable = CanWeSelectCharacter_3,
        .onEffect = SelectClass,
		.onDraw = DrawSelectCharacterCommands,
		.onSwitchIn = CallSwitchInCharacter, 

    },
    {
        .isAvailable = CanWeSelectCharacter_4,
        .onEffect = SelectClass,
		.onDraw = DrawSelectCharacterCommands,
		.onSwitchIn = CallSwitchInCharacter, 

    },
    {} // END
};


static const struct MenuDefinition MenuDef_SelectCharacter1 =
{
    .geometry = { 12, 8, 7 },
	.style = 0,
    .commandList = MenuCommands_CharacterProc1,
	._u14 = 0,
    //.onEnd = SelectCharacterMenuEnd_ReturnFalse,
	.onInit = 0,
	.onBPress = SelectCharacterMenuEnd_ReturnFalse, 
	.onRPress = 0,
	.onHelpBox = 0, 	
};
static const struct MenuDefinition MenuDef_SelectCharacter2 =
{
    .geometry = { 12, 8, 7 },
	.style = 0,
    .commandList = MenuCommands_CharacterProc2,
	._u14 = 0,
    //.onEnd = SelectCharacterMenuEnd_ReturnFalse,
	.onInit = 0,
	.onBPress = SelectCharacterMenuEnd_ReturnFalse,
	.onRPress = 0,
	.onHelpBox = 0, 	
};
static const struct MenuDefinition MenuDef_SelectCharacter3 =
{
    .geometry = { 12, 8, 7 },
	.style = 0,
    .commandList = MenuCommands_CharacterProc3,
	._u14 = 0,
    //.onEnd = SelectCharacterMenuEnd_ReturnFalse,
	.onInit = 0,
	.onBPress = SelectCharacterMenuEnd_ReturnFalse,
	.onRPress = 0,
	.onHelpBox = 0, 	
};
static const struct MenuDefinition MenuDef_SelectCharacter4 =
{
    .geometry = { 12, 8, 7 },
	.style = 0,
    .commandList = MenuCommands_CharacterProc4,
	._u14 = 0,
    //.onEnd = SelectCharacterMenuEnd_ReturnFalse,
	.onInit = 0,
	.onBPress = SelectCharacterMenuEnd_ReturnFalse,
	.onRPress = 0,
	.onHelpBox = 0, 	
};
static const struct MenuDefinition MenuDef_SelectCharacter5 =
{
    .geometry = { 12, 8, 7 },
	.style = 0,
    .commandList = MenuCommands_CharacterProc5,
	._u14 = 0,
    //.onEnd = SelectCharacterMenuEnd_ReturnFalse,
	.onInit = 0,
	.onBPress = SelectCharacterMenuEnd_ReturnFalse,
	.onRPress = 0,
	.onHelpBox = 0, 	
};








