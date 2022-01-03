
#include "FE-CLib-master/include/gbafe.h"

typedef struct Struct_SelectCharacterProc Struct_SelectCharacterProc;
//typedef struct UnitDefinition UnitDefinition;

extern const MenuDefinition gSelectUnitMenuDefs;

int SelectCharacter_ASMC(struct MenuProc* menu, struct MenuCommandProc* command);
static int SelectClass(struct MenuProc* menu, struct MenuCommandProc* command);
static int SelectYes(struct MenuProc* menu, struct MenuCommandProc* command);
static int SelectNo(struct MenuProc* menu, struct MenuCommandProc* command);
static void SelectCharacterMenuEnd(struct MenuProc* menu);

extern unsigned gEventSlot[];

extern MenuCommandDefinition gRAMMenuCommands[]; // 0x0203EFB8.

typedef struct MenuDefinition Menu_SelectCharacterCreator;
typedef struct MenuCommandDefinition menus[5];





struct Struct_SelectCharacterProc
{
	PROC_HEADER;
	u8 currMenu; // 0x29.
	u8 currSetIndex; // 0x2A.
	u8 currOptionIndex; // 0x2B. 0 = first option, 1 = 2nd option, etc. 
	Unit* activeUnit; // 0x2C. 
	struct
	{
		const struct UnitDefinition* unitDef; // 0x30, 0x38, 0x40, 0x48, 0x50, 0x58 
		Unit* unitRam; // 0x34, 0x3C, 0x44, 0x4C, 0x54, 0x5C 
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


/*
static const struct MenuCommandDefinition MenuCommands_CreatorProc[] =
{
    {
        .isAvailable = MenuCommandAlwaysUsable,
		.rawName = " ",
        //.onDraw = SkillListCommandDraw,
        //.onIdle = SkillListCommandIdle,
        .onEffect = SelectClass,
    },

    {
        .isAvailable = MenuCommandAlwaysUsable,

        .rawName = " Eirika",
        .onEffect = SelectClass,
    },
    {
        .isAvailable = MenuCommandAlwaysUsable,

        .rawName = " Seth",
        .onEffect = SelectClass,
    },
    {} // END
};
*/

static const struct MenuCommandDefinition MenuCommands_ConfirmationProc[] =
{
    {
        .isAvailable = MenuCommandAlwaysUsable,
		.rawName = " Yes",
        //.onDraw = SkillListCommandDraw,
        //.onIdle = SkillListCommandIdle,
        .onEffect = SelectYes,
    },

    {
        .isAvailable = MenuCommandAlwaysUsable,

        .rawName = " No",
        .onEffect = SelectNo,
    },
    {} // END
};

/*
static const struct MenuDefinition Menu_SelectCharacterCreator =
{
    .geometry = { 23, 12, 7 },
    .commandList = MenuCommands_CreatorProc,

    .onEnd = SelectCharacterMenuEnd,
    //.onBPress = (void*) (0x08022860+1), // FIXME
};
*/

static const struct MenuDefinition Menu_ConfirmCharacter =
{
    .geometry = { 25, 12, 5 },
    .commandList = MenuCommands_ConfirmationProc, 

    .onEnd = SelectCharacterMenuEnd,
    //.onBPress = (void*) (SelectCharacter_ASMC), 
};

static const struct MenuDefinition Menu_SelectCharacterCreator2 =
{
	.geometry = { 23, 8, 7 },
	.style = 0,
	.commandList = MenuCommands_ConfirmationProc, //menus,
	._u14 = 0,
	.onEnd = SelectCharacterMenuEnd, 
	.onInit = 0,
	.onBPress = 0, //(void*) (0x08022860+1), // FIXME
	.onRPress = 0,
	.onHelpBox = 0, 
};


// ASMC 
int SelectCharacter_ASMC(struct MenuProc* menu, struct MenuCommandProc* command) // ASMC 
{
    struct Struct_SelectCharacterProc* proc = (void*) ProcStart(ProcInstruction_SelectCharacter, ROOT_PROC_3);
    proc->activeUnit = gActiveUnit;
	
/*
	MenuCommandDefinition menus[6];
	//CPU_FILL(0,(char*)menus,6*9*4,32); // Clear our RAM buffer.

	for ( int i = 0 ; i < 6 ; i++ ) // set to 0 
	{ 
		menus[i].rawName = " Debug";
		menus[i].nameId = 0; 
		menus[i].helpId = 0; 
		menus[i].colorId = 0;
		menus[i]._u09 = 0;
		menus[i].isAvailable = 0;
		menus[i].onDraw = 0; 
		menus[i].onEffect = 0;
		menus[i].onIdle = 0;
		menus[i].onSwitchIn = 0; 
		menus[i].onSwitchOut = 0; 
	}

	for ( int i = 0 ; i < 5 ; i++ ) // Mem slots 1 - 5
	{ 
		proc->list[i].unitDef = gEventSlot[i+1]; // Memory slot 1 is first unit group to load 	
		if (proc->list[i].unitDef != 0) // Non-zero Character ID in unit group to load and non-zero memory slot 
		{
			proc->list[i].unitRam = LoadUnit(proc->list[i].unitDef); //Unit* 
					// Now to build this MenuCommandDefinition.		
			menus[i].rawName = " Debug";
			menus[i].nameId = (proc->list[i].unitRam)->pCharacterData->nameTextId; 
			menus[i].helpId = (proc->list[i].unitRam)->pCharacterData->nameTextId; 
			menus[i].colorId = 0;
			menus[i]._u09 = 0;
			menus[i].isAvailable = MenuCommandAlwaysUsable;
			menus[i].onDraw = 0; 
			
			menus[i].onEffect = SelectClass;
			menus[i].onIdle = 0;
			
			menus[i].onSwitchIn = 0; //SelectCharacterMenuEnd;
			menus[i].onSwitchOut = 0; //SelectCharacterMenuEnd;
		}

	}
	
*/

	struct MenuDefinition Menu_SelectCharacterCreator =
	{
		.geometry = { 23, 8, 7 },
		.style = 0,
		.commandList = MenuCommands_ConfirmationProc, //menus,
		._u14 = 0,
		.onEnd = SelectCharacterMenuEnd, 
		.onInit = 0,
		.onBPress = 0, //(void*) (0x08022860+1), // FIXME
		.onRPress = 0,
		.onHelpBox = 0, 
	};

	
	
	asm("mov r11,r11");
	
	struct MenuDefinition2 {
		/* 00 */ struct MenuGeometry geometry;

		/* 04 */ u8 style;

		/* 08 */ struct MenuCommandDefinition* commandList; ///* 08 */ const struct MenuCommandDefinition* commandList;

		/* 10 */ void(*onEnd)(MenuProc*);
		/* 0C */ void(*onInit)(MenuProc*);
		/* 14 */ void(*_u14)(MenuProc*);
		/* 18 */ void(*onBPress)(MenuProc*, MenuCommandProc*);
		/* 1C */ void(*onRPress)(MenuProc*);
		/* 20 */ void(*onHelpBox)(MenuProc*, MenuCommandProc*);
	};

	static struct MenuDefinition2 Menu_SelectCharacterCreator3 =
	{
		.geometry = { 23, 8, 7 },
		.style = 0,
		.commandList = MenuCommands_ConfirmationProc, //  menus, //
		._u14 = 0,
		.onEnd = SelectCharacterMenuEnd, 
		.onInit = 0,
		.onBPress = 0, //(void*) (0x08022860+1), // FIXME
		.onRPress = 0,
		.onHelpBox = 0, 
	};

	
	proc->currOptionIndex = 0;
    StartMenuChild(&Menu_SelectCharacterCreator3, (void*) proc);

    return ME_DISABLE | ME_END | ME_PLAY_BEEP | ME_CLEAR_GFX;
}





static int SelectClass(struct MenuProc* menu, struct MenuCommandProc* command)
{
	Proc* parent_proc = (void*)(Struct_SelectCharacterProc*)ProcFind(&ProcInstruction_SelectCharacter[0]);
	//Struct_SelectCharacterProc* proc_variables = (void*)(Struct_SelectCharacterProc*)ProcFind(&ProcInstruction_SelectCharacter[0]);
	// useful probably 
	struct Struct_ConfirmationProc* proc = (void*) ProcStartBlocking(ProcInstruction_Confirmation, parent_proc);



	StartMenuChild(&Menu_ConfirmCharacter, (void*) proc);
	//return ME_NONE;
	return ME_DISABLE | ME_END | ME_PLAY_BEEP | ME_CLEAR_GFX;
}


static int SelectYes(struct MenuProc* menu, struct MenuCommandProc* command)
{
    //struct SkillDebugProc* proc = (void*) ProcStart(Proc_SkillDebug, ROOT_PROC_3);

    //proc->unit = gActiveUnit;
    //proc->skillsUpdated = FALSE;
    //proc->skillSelected = 0;
    //proc->skillReplacement = 1; // assumes skill #1 is valid

    //StartMenuChild(&Menu_SkillDebug, (void*) proc);

    
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
















