#include "gbafe.h"

#define BG_SYNC_BIT(aBg) (1 << (aBg))
enum { BG0_SYNC_BIT = BG_SYNC_BIT(0) };

extern void ReloadMap(void); 
extern const u16 MyPalette[]; 
extern unsigned gEventSlot[];
extern void MU_AllDisable(void);
extern void MU_AllEnable(void); 
static void FlyCommandDraw(struct MenuProc* menu, struct MenuCommandProc* command);

struct FlyCommandProc
{
    PROC_HEADER;
    /* 2C */ int commandIndex;
};

static int FlyMenuIdle(struct MenuProc* menu, struct MenuCommandProc* command);
static int FlyCommandSelect(struct MenuProc* menu, struct MenuCommandProc* command);
static void SwitchInMap(struct MenuProc* menu);
static void EndFlyMenu(struct MenuProc* menu);
static void SwitchToMap(u16 xx, u16 yy, u8 Chapter);
static int FlyCommandIdle(struct FlyCommandProc* proc);

static int FlyMenuStart(struct FlyCommandProc* proc);

extern u32 gProc_FadeInBlack;
extern u32 gProc_FadeOutBlack;
extern u32 gProc_Menu;
extern int FlyCommandEvent;
extern u32 FlyDestinationEvent;
extern u32 FlyReturnEvent;
extern u32 FlyFadeEvent;
extern u16 SaffronArrivedLabel;
extern u16 CinnabarArrivedLabel;
extern u16 IndigoPlateauArrivedLabel;
extern u16 ShowXXCoord(u16 XX);
extern u16 ShowYYCoord(u16 YY);
extern u8 FlyLocationTable[10];

extern u8 gPaletteSyncFlag;






int SaffronFly(void)
{
	if(CheckEventId_(SaffronArrivedLabel)) return true;
	return 3; 
}

int CinnabarFly(void)
{

	if(CheckEventId_(CinnabarArrivedLabel)) return true;
	return 3; 
}



int IndigoPlateauFly(void)
{
	if(CheckEventId_(IndigoPlateauArrivedLabel)) return true;
	return 3; 
//IndigoPlateauArrived	
}


static const struct MenuCommandDefinition MenuCommands_FlyCommand[] =
{
    {
        .isAvailable = MenuCommandAlwaysUsable,
		.rawName = " Pallet Town",
        //.onDraw = FlyCommandDraw,
        .onIdle = FlyMenuIdle,
        .onEffect = FlyCommandSelect,
		//.onSwitchIn = SwitchInMap, 
    },

    {
        .isAvailable = MenuCommandAlwaysUsable,
		.rawName = " Viridian City",
        .onIdle = FlyMenuIdle,
        .onEffect = FlyCommandSelect,
    },

    {
        .isAvailable = MenuCommandAlwaysUsable,
		.rawName = " Pewter City",
        .onIdle = FlyMenuIdle,
        .onEffect = FlyCommandSelect,
    },

	{
        .isAvailable = MenuCommandAlwaysUsable,
		.rawName = " Cerulean City",
        .onIdle = FlyMenuIdle,
        .onEffect = FlyCommandSelect,
    },
	{
        .isAvailable = MenuCommandAlwaysUsable,
		.rawName = " Vermillion City",
        .onIdle = FlyMenuIdle,
        .onEffect = FlyCommandSelect,
    },
	// no rock tunnel i guess lol 
	{
        .isAvailable = MenuCommandAlwaysUsable,
		.rawName = " Lavender Town",
        .onIdle = FlyMenuIdle,
        .onEffect = FlyCommandSelect,
    },
	{
        .isAvailable = MenuCommandAlwaysUsable,
		.rawName = " Fuschia City",
        .onIdle = FlyMenuIdle,
        .onEffect = FlyCommandSelect,
    },

	{
        .isAvailable = MenuCommandAlwaysUsable,
		.rawName = " Celadon City",
        .onIdle = FlyMenuIdle,
        .onEffect = FlyCommandSelect,
    },
	{
        .isAvailable = SaffronFly,
		.rawName = " Saffron City",
        .onIdle = FlyMenuIdle,
        .onEffect = FlyCommandSelect,
    },
	{
        .isAvailable = CinnabarFly,
		.rawName = " Cinnabar Island",
        .onIdle = FlyMenuIdle,
        .onEffect = FlyCommandSelect,
    },


	{
        .isAvailable = IndigoPlateauFly,
		.rawName = " Indigo League",
        .onIdle = FlyMenuIdle,
        .onEffect = FlyCommandSelect,
    },
	// more than 11 commands crashes the game fsr 
	
    {} // END
};



static const struct MenuDefinition Menu_FlyCommand =
{
    .geometry = { 1, 0, 11 },
    .commandList = MenuCommands_FlyCommand,

    .onEnd = EndFlyMenu,
    //.onBPress = (void*) (0x08022860+1), // FIXME
	.onBPress = (void*) EndFlyMenu,
    //.onBPress = (void*) (0x080152F4+1), // Goes back to main game loop
};

static const struct ProcInstruction Proc_FlyCommand[] =
{
    PROC_CALL_ROUTINE(LockGameLogic),
	PROC_CALL_ROUTINE(LockGameGraphicsLogic),
	PROC_CALL_ROUTINE(MU_AllDisable), 

    PROC_YIELD,
	PROC_CALL_ROUTINE(FlyMenuStart),
	PROC_LABEL(0),

	PROC_WHILE_ROUTINE(FlyCommandIdle),
	PROC_GOTO(0),

	PROC_LABEL(1),
	
	PROC_CALL_ROUTINE(UnlockGameLogic),
	PROC_CALL_ROUTINE(UnlockGameGraphicsLogic), 
	PROC_CALL_ROUTINE(MU_AllEnable),
    PROC_END,
};

int FlyCommandEffect(struct MenuProc* menu, struct MenuCommandProc* command)
{
    struct FlyCommandProc* proc = (void*) ProcStart(Proc_FlyCommand, ROOT_PROC_3);

    proc->commandIndex = 0;
	gEventSlot[0x5] = gChapterData.chapterIndex; // save chapter ID to memory slot 
	gEventSlot[0xB] = gChapterData.yCursorSaved<<16|gChapterData.xCursorSaved; // save cursor position to memory slot 


    //StartFace(0, GetUnitPortraitId(proc->unit), 72, 16, 3);

    return ME_DISABLE | ME_END | ME_PLAY_BEEP | ME_CLEAR_GFX;
}
int FlyMenuStart(struct FlyCommandProc* proc)
{	

	//struct MenuProc* menu = ProcFind(gProc_Menu); // 0x85B64D0
    //StartMenuChild(&Menu_FlyCommand, (void*) proc);
    StartMenu(&Menu_FlyCommand);
//, struct MenuCommandProc* command)
    return ME_DISABLE | ME_END | ME_PLAY_BEEP | ME_CLEAR_GFX;

}
static int FlyMenuIdle(struct MenuProc* menu, struct MenuCommandProc* command)
{
	//struct FlyCommandProc* const proc = (void*) menu->parent;
	struct FlyCommandProc* const proc = ProcFind(Proc_FlyCommand); //Proc_FlyCommand[]
	if(gChapterData.chapterIndex != FlyLocationTable[menu->commandIndex*4])
	{
		//asm("mov r11,r11");
		proc->commandIndex = menu->commandIndex;
		//gChapterData.chapterIndex = FlyLocationTable[menu->commandIndex*4]; // immediately update the chapter 
		


	}
    return ME_NONE;
}


static int FlyCommandIdle(struct FlyCommandProc* proc)
{

    //struct FlyCommandProc* const proc = (void*) menu->parent;
	if(gChapterData.chapterIndex != FlyLocationTable[proc->commandIndex*4])
	{	
		//asm("mov r11,r11");
		u16 xx = FlyLocationTable[proc->commandIndex*4+1];
		u16 yy = FlyLocationTable[proc->commandIndex*4+2];
		u8 Chapter = FlyLocationTable[proc->commandIndex*4];
		
		
		SwitchToMap(xx, yy, Chapter);
		
		/*
		struct MenuProc* menu = ProcFind(gProc_Menu);
		if (menu)
		{
			Font_ResetAllocation(); // 0x08003D20 // probably unnecessary? 
			//Text_SetFont(0);
			//Text_SetFontStandardGlyphSet(0);

			
			Text_Clear(&menu->pCommandProc[0]->text);
			Text_Clear(&menu->pCommandProc[1]->text);
			Text_Clear(&menu->pCommandProc[2]->text);
			Text_Clear(&menu->pCommandProc[3]->text);
			Text_Clear(&menu->pCommandProc[4]->text);
			Text_Clear(&menu->pCommandProc[5]->text);
			Text_Clear(&menu->pCommandProc[6]->text);
			Text_Clear(&menu->pCommandProc[7]->text);
			Text_Clear(&menu->pCommandProc[8]->text);
			Text_Clear(&menu->pCommandProc[9]->text);
			Text_Clear(&menu->pCommandProc[10]->text);
			Menu_Draw(menu);
		}
		*/
		
	}
	
    return ME_NONE;
	//return ME_CLEAR_GFX;
}

static void SwitchToMap(u16 xx, u16 yy, u8 Chapter)
{
	//FillBgMap(gBg3MapBuffer[0], 0); // make black?
	gChapterData.chapterIndex = Chapter;
	gEventSlot[0x2] = Chapter;
	//gEventSlot[0xB] = yy<<16|xx;
	
	// based on LOMA / 0xF17C 
	
	// unlock game logic goes here usually 
	//StartFadeInBlack(99);
	//ClearBG0BG1();

	
	ReloadMap();
	gPaletteSyncFlag = 0;
	//LockGameLogic();
	gGameState.cameraRealPos.x = ShowXXCoord(xx<<4);
	gGameState.cameraRealPos.y = ShowYYCoord(yy<<4);
	RefreshEntityBmMaps();
	ReloadGameCoreGraphics();
	
		// sms update goes here usually 
	RenderBmMap();
	//CallMapEventEngine((void*) ((int)&FlyReturnEvent), 1); // this occurs after Menu_Draw, so no good as it erases the menu gfx after i redraw them 

	// 0x44th entry to event engine proc has a short used here 
	// this is used related to map sprite palettes 
	// maybe it's the option that draws them in a different palette 

	ClearBG0BG1();
	EnableBgSyncByMask(1);
	EnableBgSyncByMask(2); // dunno why vanilla does this 
	LockGameGraphicsLogic();
	//int paletteID = 0; //6*32;
	//int paletteSize = 10*32; 
	//int paletteSize = 16*32; 
	//CopyToPaletteBuffer(MyPalette, paletteID, paletteSize); // source pointer, palette offset, size 
	//gPaletteSyncFlag = 1;
	//CallMapEventEngine((void*) ((int)&FlyFadeEvent), 1); 

} 

extern int EmptyEvent;
static int FlyCommandSelect(struct MenuProc* menu, struct MenuCommandProc* command)
{
    int eventList[12] = {
    0x003C1721, //FADI 60
	0x00020540, //SVAL 2
    FlyLocationTable[menu->commandIndex*4+1],
	0x00050540, //SVAL 5
    FlyLocationTable[menu->commandIndex*4+2],
    0x00000A40, //CALL
    (int)&FlyDestinationEvent,
    0x00020540, //SVAL 2
    FlyLocationTable[menu->commandIndex*4],
    0xFFFD2A22, //MNC2
    0x00070228, //NoFade
    0x00000120  //ENDA
    };


    memcpy((void*)0x202B670, &eventList, 48); //  RAM FEBuilder uses to store temporary event data for chapter jumping

    CallMapEventEngine((void*) (0x202B670), 1);
	struct FlyCommandProc* const proc = ProcFind(Proc_FlyCommand); //Proc_FlyCommand[]
	ProcGoto((Proc*)proc,1); // Destructor sequence 
	//UnlockGameGraphicsLogic();
	//UnlockGameLogic();
    return ME_END;

}



static void EndFlyMenu(struct MenuProc* menu)
{
	asm("mov r11,r11");
	struct FlyCommandProc* const proc = ProcFind(Proc_FlyCommand); //Proc_FlyCommand[]
	ProcGoto((Proc*)proc,1); // Destructor sequence 
    u16 xx = gEventSlot[0xB];
    u16 yy = gEventSlot[0xB]<<16;
	u8 Chapter = gEventSlot[0x5];
	gEventSlot[2] = gEventSlot[0x5];
	//SwitchToMap(xx, yy, Chapter); 
	CallMapEventEngine((void*) ((int)&FlyReturnEvent), 1);
}

