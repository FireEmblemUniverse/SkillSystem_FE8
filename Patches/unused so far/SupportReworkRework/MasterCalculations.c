
#include <stddef.h>
#include "FE-CLib-master/include/gbafe.h"

typedef struct BonusStruct BonusStruct;
typedef struct SupportTableEntry SupportTableEntry;
typedef struct CharacterEvent CharacterEvent;
typedef struct CharacterStackAlloc CharacterStackAlloc;
typedef const struct BaseConvoEntry BaseConvoEntry;
typedef const struct UnitDefinition UnitDefinition;
typedef const struct RTextStatName RTextStatName;
typedef struct RTextProc RTextProc;
typedef struct StatScreen StatScreen;

asm(".macro blh to, reg\n\
		ldr \\reg, =\\to\n\
		mov lr, \\reg\n\
		.short 0xF800\n\
		.endm");

/* Information on how the support data is layed out in the character struct.
	 0x32 contains a short which represents the support levels. Each level is 3 bits.
		There doesn't appear to be an easy way to represent this as an array... so manual bit logic will do.
		For 3 bits per level, this allows for a total of 8 individual levels!
		The user will be able to define what they want each level to represent in the EA installer.
	0x34 - 0x38 inclusive is an array of character IDs.
		Each entryis an individual support (with whom the current character supports)
		0xFF in this field (or any other fields, ROM or RAM) refers to the first character struct.
	Therefore, the following should be changed in FE-CLib-master/include/gbafe/unit.h:
			u8 supports[6];
			u8 unitLeader;
			to
			u16 supportLevels;
			u8 supports[5];
*/

struct BonusStruct
{
	/*u8 atk;
	u8 def;
	u8 hit;
	u8 avd;
	u8 crt;
	u8 dge;*/
	u8 vals[6];
};

struct SupportTableEntry
{
	u8 char1;
	u8 char2;
	BonusStruct bonuses[7]; // Indexed by level. Each entry represents bonuses for a certain level.
};

struct CharacterEvent // This definition is really only relevant to Support Rework.
{
	u16 identifier;
	u16 level;
	union
	{
		const void* event;
		u16 text;
	} eventOrText;
	u8 char1;
	u8 char2;
	u16 pad1;
	int (*usability)(CharacterStackAlloc* alloc);
};

struct CharacterStackAlloc // There's a lot in here I don't understand, but these pieces are really all I need.
{
	CharacterEvent* event; // 0x00.
	int returnThing; // For some reason, I have to store 1 in this upon returning true? // 0x04.
	int pad1, pad2, pad3, pad4; // 0x08, 0x0C, 0x10, 0x14.
	u16 pad6; // 0x18.
	u8 currCharID; // 0x1A.
	u8 otherCharID; // 0x1B. This value isn't particularly useful because it doesn't account for 0xFF = first character struct.
	Unit* otherUnit; // 0x1C.
}; // I'm also unsure of the size of this struct. I didn't look into this too deeply... though the size it irrelevant.

struct BaseConvoEntry  // Copied from Base Convos.
{
	u8 character1; // 0.
	u8 character2; // 1.
	u8 background; // 2. 
	u8 supportLevel; // 3.
	int (*usability)(const BaseConvoEntry* entry); // 4. ASM usability pointer.
	void* event; // 8.
	u16 title; // 12.
	u16 music; // 14.
	char* (*textGetter)(const BaseConvoEntry* entry); // 16. Returns a pointer to the string of text to use.
	u16 textID; // 20.
	u8 item; // 22.
	u8 giveTo; // 23. Give the item to this person.
	UnitDefinition* unit; // 24.
	u16 eventID; // 28.
	u8 importance; // 30.
	u8 exists; // 31.
};

struct RTextStatName
{
	char name[4];
};

struct RTextProc
{
	PROC_HEADER;
	u8 char1; // 0x29.
	u8 char2; // 0x2A.
	u8 level; // 0x2B.
	char* rTextData; // 0x2C.
	u32 idk2, idk3, idk4, idk4a; // 0x30.
	u32 idk5, idk6, idk7; // 0x40.
	u16 textID, type; // 0x4C.
	u16 direction, idk8; // 0x50.
	u32 idk9, idk10, idk11; // 0x54.
};

struct StatScreen
{
	u8 idk1, currentScreen, idk2, idk3; // 0x00.
	u32 idk4, idk5; // 0x04.
	Unit* curr; // 0x0C.
	// idk the rest.
};

extern SupportTableEntry SupportBonusTable[0xFF];
extern u32 gMemorySlot[16]; // 0x030004B8.
extern const u32 SupportPopupDefinitions;
extern char* SupportLevelNameTable[7];
extern char SupportLevelNameForPopup; // 0x0203EFC0. The string for the name of this level of support is stored here
extern Unit* ActiveUnit; // 0x03004E50.
extern Unit* gUnitSubject; // 0x02033F3C.
extern const ProcInstruction Proc_TI; // 0x08A018AC.
extern const void SupportConvoEvents;
extern const void BaseConvoSupportReworkEvent;
extern u8 MaxSupportLevel;
extern RTextStatName SupportRTextStatNames[6];
extern TextHandle SomeTextHandle; // 0x0203E7AC.
extern const ProcInstruction HelpTextProcCode; // 0x08A01650.
extern StatScreen gStatScreen; // 0x02003BFC.
extern TextHandle TileBufferBase; // 0x2003C2C.
extern u16 Tile_Origin[32][32]; // 0x02003C94.
extern u16 Bg2_Origin[32][32]; // 0x0200472C.
extern const void* SupportStatScreenSmallBox;
extern const void* SupportStatScreenBlueBox;
extern const char TotalCurrentSupportBonusesText;

extern const void** GetChapterEvents(int number); // 0x080346B0.
extern void StartMapEventEngine(const void* scene, int runKind); // 0x0800D0B0.
extern char* GetStringFromIndex(int textID); // 0x0800A240.
extern void RTextUp(RTextProc* proc); // 0x08089354.
extern void RTextDown(RTextProc* proc); // 0x08089384.
extern void RTextLeft(RTextProc* proc); // 0x080893B4.
extern void RTextRight(RTextProc* proc); // 0x080893E4.

void MasterSupportCalculation(Unit* unit, BonusStruct* bonuses);
static int GetCharacterDistance(Unit* unit1, Unit* unit2);
static void GetBonusByCharacter(BonusStruct* bonuses, Unit* unit, int supporting);
static BonusStruct* GetSupportTableEntry(int char1, int char2, int level);
void FixCUSA(void);
static int abs(int i);

static int GetSupportLevel(Unit* unit, int supporting);
static int FindSupport(Unit* unit, int supporting);
static int AddSupport(Unit* unit, int supporting); // Return values for functions that would be void are boolean for success.
static int SetSupport(Unit* unit, int supporting, int level);
static int IncreaseSupport(Unit* unit, int supporting);
static int ClearSupport(Unit* unit, int supporting);
static int CountSupports(Unit* unit);
static int CanUnitsSupport(Unit* unit, int otherChar, int level);
static int GetNthValidSupport(Unit* unit, int n);
static Unit* ToUnit(int charID);
static int ToCharID(Unit* unit);

void CallAddSupport(Proc* parent);
void CallSetSupport(Proc* parent);
void CallIncreaseSupport(Proc* parent);
void CallClearSupport(Proc* parent);
void CallGetSupportLevel(Proc* parent);
static void SupportPopup(Proc* parent, int level);
static int CopyString(char* origin, char* dest);

int SupportConvoUsability(void);
int CHARSupportConvoUsability(CharacterStackAlloc* alloc);
void BuildSupportTargetList(Unit* active);
int SupportSelected(Proc* parent);
static CharacterEvent* GetCharacterEvents(void);
static CharacterEvent* FindValidConvo(CharacterEvent* event, Unit* active, int target);

int SupportBaseConvoUsability(BaseConvoEntry* entry);
char* SupportBaseConvoMenuTextGetter(BaseConvoEntry* entry);
void SetUpBaseSupportConvo(Proc* parent);

void DrawSupports(void);
void SupportReworkPageSwitch(void);
void PassSupportDataToRTextHandler(void);
void CreateNewHelpBubbleProc(u32 idk1, u32 idk2, RTextProc* proc); // Helper function for the previous asm hack.
void DrawRTextStatLabelsForSupport(void);
int DrawRTextStatLabels(RTextProc* proc); // Helper function for the previous asm hack.
void DrawRTextStatValuesForSupport(void);
void DrawRTextStatValues(RTextProc* proc); // Helper function for the previous asm hack.
void NewBoxType(void);
void SupportScreenRTextGetter(RTextProc* proc); // Getter and looper defined in the ROM RText structs.
void SupportScreenRTextLooper(RTextProc* proc);

// In this file, we'll do the stat calculations.
#include "MemoryManagement.c" // Internal use functions to manage and get support data.
#include "EventCalls.c" // Functions to be ASMCed via EA macros.
#include "UnitMenu.c" // "Support" usability, CHARASM stuff, target list, and event effect.
#include "StatScreen.c" // Drawing stuff for the stat screen.
#include "Base.c" // Integration with the base conversation system.

void MasterSupportCalculation(Unit* unit, BonusStruct* bonuses) // Called to loop through supports and fill the bonus struct. Autohook to 0x080285B0.
{
	for ( int i = 0 ; i < 6 ; i++ ) { bonuses->vals[i] = 0; } // Clear the bonus struct.
	if ( unit->index >> 6 ) { return; } // For high unit index, i.e. non-blue unit, exit.
	unit = GetUnit(unit->index); // We need to do this because this parameter can also be a BattleUnit* type which doesn't play nicely with my ToCharID function.
	for ( int i = 0 ; i < 5 ; i++ )
	{
		int supportingChar = unit->supports[i];
		if ( supportingChar )
		{
			// If supporting is nonzero.
			Unit* supportingUnit = ToUnit(supportingChar);
			if ( !supportingUnit ) { continue; } // Continue if unit does not exist.
			if ( supportingUnit->state & (US_DEAD|US_NOT_DEPLOYED) ) { continue; } // Continue if dead or not deployed.
			if ( GetCharacterDistance(unit,supportingUnit) <= 3 )
			{
				GetBonusByCharacter(bonuses,unit,supportingChar);
			}
		}
	}
}

void GetBonusByCharacter(BonusStruct* bonuses, Unit* unit, int supporting) // Adds bonuses from a single support to the bonus struct.
{
	int level = GetSupportLevel(unit,supporting);
	if ( level == 0xFF ) { return; } // No support. End.
	BonusStruct* entry = GetSupportTableEntry(ToCharID(unit),supporting,level);
	if ( entry != NULL )
	{
		for ( int i = 0 ; i < 6 ; i++ )
		{
			bonuses->vals[i] += entry->vals[i];
		}
	}
}

static BonusStruct* GetSupportTableEntry(int char1, int char2, int level)
{
	for ( int i = 0 ; SupportBonusTable[i].char1 != 0 && SupportBonusTable[i].char2 != 0 ; i++ )
	{
		if ( ( char1 == SupportBonusTable[i].char1 && char2 == SupportBonusTable[i].char2 )
			|| ( char2 == SupportBonusTable[i].char1 && char1 == SupportBonusTable[i].char2 ) )
		{
			// If these characters match, let's return the pointer to this entry.
			return &SupportBonusTable[i].bonuses[level];
		}
	}
	return NULL; // No entry found.
}

void FixCUSA(void) // This is required to clear a unit's "leader byte" when changing to an ally. Autohook to 0x08018480.
{
	asm("@ r4 = new ally character struct.\n\
		beq VanillaCUSASkip\n\
			ldr r1, =0x0859A5D0\n\
			lsl r0, r0, #0x02\n\
			add r0, r0, r1\n\
			ldr r1, [ r0 ]\n\
			ldrb r0, [ r4, #0x0B ]\n\
			strb r0, [ r1, #0x1B ]\n\
		VanillaCUSASkip: @ Some weird vanilla shit about rescuing. All vanilla above here.\n\
		mov r0, #0x00\n\
		mov r1, #0x38\n\
		strb r0, [ r4, r1 ] @ Set the character leader byte to 0. (Interferes with support data)\n\
		pop { r4 - r6 }\n\
		pop { r0 }\n\
		bx r0\n\
		.ltorg");
}

static int GetCharacterDistance(Unit* unit1, Unit* unit2)
{
	return abs(unit1->xPos - unit2->xPos) + abs(unit1->yPos - unit2->yPos);
}
static int abs(int i)
{
	if ( i < 0 ) { return i*-1; }
	return i;
}
