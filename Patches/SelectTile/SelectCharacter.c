
#include "FE-CLib-master/include/gbafe.h"

//static void SkillListCommandDraw(struct MenuProc* menu, struct MenuCommandProc* command);
//static int SkillListCommandIdle(struct MenuProc* menu, struct MenuCommandProc* command);
typedef struct Struct_SelectCharacterProc Struct_SelectCharacterProc;
//typedef struct UnitDefinition UnitDefinition;



int SelectCharacter_ASMC(struct MenuProc* menu, struct MenuCommandProc* command);
static int SelectClass(struct MenuProc* menu, struct MenuCommandProc* command);
static int SelectYes(struct MenuProc* menu, struct MenuCommandProc* command);
static int SelectNo(struct MenuProc* menu, struct MenuCommandProc* command);
static void SelectCharacterMenuEnd(struct MenuProc* menu);


int* MemorySlot1 = (int*) 0x30004BC;
int* MemorySlot2 = (int*) 0x30004C0; 
int* MemorySlot3 = (int*) 0x30004C4; 
	







struct Struct_SelectCharacterProc
{
	PROC_HEADER;
	
	
	u8 currMenu; // 0x29. ID for where we are in the menu progression.
	u8 gender; // 0x2A. 0 = unselected, 1 = male, 2 = female.
	u8 route; // 0x2B. 0 = unselected, 1 = mercenary, 2 = military, 3 = mage.
	Unit* activeUnit; // 0x2C. Unit we're keeping in place. Intended to be kept in unit slot 1.
	const struct UnitDefinition* unitA; // 0x30. 
	const struct UnitDefinition* unitB; // 0x34. 
	const struct UnitDefinition* unitC; // 0x38. 
		

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
		.rawName = " Fomortiis",
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
    .onBPress = (void*) (SelectCharacter_ASMC), 
};

// ASMC 
int SelectCharacter_ASMC(struct MenuProc* menu, struct MenuCommandProc* command) // ASMC 
{
    struct Struct_SelectCharacterProc* proc = (void*) ProcStart(ProcInstruction_SelectCharacter, ROOT_PROC_3);

    proc->activeUnit = gActiveUnit;
	
	
	proc->unitA = *MemorySlot1;
	proc->unitB = *MemorySlot2;  
	proc->unitC = *MemorySlot3;  


	//int* MemorySlot6 = (int*) 0x30004D0; 
	//*MemorySlot6 = 0; // TRUE 
	
	
	
	StartFace(0, GetUnitPortraitId(proc->activeUnit), 32, 16, 3);

    StartMenuChild(&Menu_SelectCharacterCreator, (void*) proc);

    

    return ME_DISABLE | ME_END | ME_PLAY_BEEP | ME_CLEAR_GFX;
}



static int SelectClass(struct MenuProc* menu, struct MenuCommandProc* command)
{
	Proc* parent_proc = (void*)(Struct_SelectCharacterProc*)ProcFind(&ProcInstruction_SelectCharacter[0]);
	Struct_SelectCharacterProc* proc_variables = (void*)(Struct_SelectCharacterProc*)ProcFind(&ProcInstruction_SelectCharacter[0]);
	//struct Struct_SelectCharacterProc* parent_proc = (void*)(Struct_SelectCharacterProc*)ProcFind(&ProcInstruction_SelectCharacter[0]);
	struct Struct_ConfirmationProc* proc = (void*) ProcStartBlocking(ProcInstruction_Confirmation, parent_proc);

	proc_variables->activeUnit = gActiveUnit;
	StartFace(0, GetUnitPortraitId(proc_variables->activeUnit), 72, 16, 3);

	StartMenuChild(&Menu_ConfirmCharacter, (void*) proc);
    //StartFace(0, GetUnitPortraitId(proc->unit), 72, 16, 3);
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



static Unit* LoadCreatorUnit(Struct_SelectCharacterProc* proc_variables, int index)
{
	/*
	UnitDefinition definition =
	{
		.charIndex = proc_variables->currSet->list[index].character,
		.classIndex = proc_variables->currSet->list[index].class,
		.autolevel = 1,
		.allegiance = UA_BLUE,
		.level = 5,
		.xPosition = 63,
		.yPosition = 0,
		.items[0] = 0,
		.items[1] = 0,
	};
	*/
	
	
	Unit* newUnit = LoadUnit(proc_variables->unitA);
	return newUnit;
}













