
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


//typedef struct CharacterSet CharacterSet;
//typedef struct unitLoadGroups unitLoadGroups;
typedef struct unitSet unitSet;

struct unitSet
{
	struct
	{
		const struct UnitDefinition* unitDef;
		Unit* unitRam;
	} list[5];
};

/*
struct CharacterSet
{
	Unit* unit;
}; list[5];


struct unitLoadGroups 
{
	const struct UnitDefinition* unit;
}; list[5];
*/

struct Struct_SelectCharacterProc
{
	PROC_HEADER;
	
	
	u8 currMenu; // 0x29. ID for where we are in the menu progression.
	u8 currSetIndex; // 0x2A. 0 = unselected, 1 = male, 2 = female.
	u8 currOptionIndex; // 0x2B. 0 = first option, 1 = 2nd option, etc. 
	Unit* activeUnit; // 0x2C. Unit we're keeping in place. Intended to be kept in unit slot 1.
	//struct unitSet* unitSet; // 0x30 
	struct
	{
		const struct UnitDefinition* unitDef; // 0x30, 0x38, 0x40, 0x48, 0x50, 0x58 
		Unit* unitRam; // 0x34, 0x3C, 
	} list[5];
	//struct unitLoadGroups* unitLoadGroups; // 0x30. 
	//struct CharacterSet* newUnits; // 0x34 

	//u8 lastClassIndex; // 0x35. Last selected index in the class menu.
	//u8 boon; // 0x36. Same indicators as bane.
	//u8 bane; // 0x37. 0 = unselected, 1 = HP, 2 = str, 3 = mag, 4 = skl,  ..., 8 = luk.
	//u8 leavingClassMenu; // 0x38. Boolean for whether we're exiting the class emnu.
	//u8 lastIndex; // 0x39. Before going to a submenu, save the index we were at in the main menu.
	//u8 boonBaneTileLast; // 0x3A. Used internally for the boon/bane submenu drawing routines.
	//u8 isPressDisabled; // 0x3B. Boolean for whether A/B press is disabled. (Used to disable a press during a randomization).
	u8 cycle; // 0x3C. Cycles on each idle for the creator on a menu. Used for randomization. Cycles between 0 and 15 correlating to how many RNs to burn before randomizing.
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


static const struct MenuDefinition Menu_SelectCharacterCreator =
{
    .geometry = { 23, 12, 7 },
    .commandList = MenuCommands_CreatorProc,

    .onEnd = SelectCharacterMenuEnd,
    //.onBPress = (void*) (0x08022860+1), // FIXME
};

static const struct MenuDefinition Menu_ConfirmCharacter =
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
	
	
	CPU_FILL(0,(char*)gRAMMenuCommands-1,3*9*4,32); // Clear our RAM buffer.
	
	//proc->unitSet
	
	for ( int i = 0 ; i < 5 ; i++ ) // Mem slots 1 - 5
	{ 
		proc->list[i].unitDef = gEventSlot[i+1]; // Memory slot 1 is first unit group to load 	
		if (proc->list[i].unitDef != 0) // Non-zero Character ID in unit group to load 
		{
			proc->list[i].unitRam = LoadUnit(proc->list[i].unitDef); //Unit* 
					// Now to build this MenuCommandDefinition.
			
			gRAMMenuCommands[i].nameId = (proc->list[i].unitRam)->pCharacterData->nameTextId; // pClassData Class name 
			gRAMMenuCommands[i].colorId = 0;
			gRAMMenuCommands[i].isAvailable = MenuCommandAlwaysUsable;
			gRAMMenuCommands[i].onEffect = SelectClass;
			gRAMMenuCommands[i].onSwitchIn = SelectCharacterMenuEnd;
			gRAMMenuCommands[i].onSwitchOut = SelectCharacterMenuEnd;

			
			
			
		}

	}



	proc->currOptionIndex = 0;
    StartMenuChild(&gSelectUnitMenuDefs, (void*) proc);

    return ME_DISABLE | ME_END | ME_PLAY_BEEP | ME_CLEAR_GFX;
}



static int SelectClass(struct MenuProc* menu, struct MenuCommandProc* command)
{
	Proc* parent_proc = (void*)(Struct_SelectCharacterProc*)ProcFind(&ProcInstruction_SelectCharacter[0]);
	Struct_SelectCharacterProc* proc_variables = (void*)(Struct_SelectCharacterProc*)ProcFind(&ProcInstruction_SelectCharacter[0]);
	//struct Struct_SelectCharacterProc* parent_proc = (void*)(Struct_SelectCharacterProc*)ProcFind(&ProcInstruction_SelectCharacter[0]);
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
















