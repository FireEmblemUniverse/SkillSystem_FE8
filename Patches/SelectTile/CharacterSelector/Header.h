
typedef struct ClassMenuSet ClassMenuSet;
typedef struct CreatorProc CreatorProc;
typedef struct CreatorClassProc CreatorClassProc;
typedef struct CreatorSpriteProc CreatorSpriteProc;
typedef struct TimerProc TimerProc;
typedef struct UnitDefinition UnitDefinition;
typedef struct TSA TSA;
typedef struct Tile Tile;
typedef struct SomeAISStruct SomeAISStruct;

enum
{
RandomEntry = 0,
GenderMenu = 0, // Menu defs.
RouteMenu = 0,
ClassMenu = 0,
BoonMenu = 4,
BaneMenu = 5,
DoneEntry = 1,
MainMenu = 7,

Male = 1, // Gender defs.
Female = 2,

Mercenary = 1, // Route defs.
Military = 2,
Mage = 3,

HP = 1, // Boon/bane defs.
Str = 2,
Mag = 3,
Skl = 4,
Spd = 5,
Def = 6,
Res = 7,
Luk = 8,

HPGrowthID = 10, // "Growth IDs" as seen by MSS growth getters.
StrGrowthID = 11,
MagGrowthID = 255,
SklGrowthID = 12,
SpdGrowthID = 13,
DefGrowthID = 14,
ResGrowthID = 15,
LukGrowthID = 16,

NL = 1, // Text control code for new line.

TextBGLeft = 122|(1<<12), // For generating the UI tiles behind text.
TextBG = 123|(1<<12),
TextBGRight = 124|(1<<12),

GrassPlatform = 0x00, // For drawing platforms.
RoadPlatform = 0x02,
SandPlatform = 0x09
};

struct CreatorProc
{
	PROC_HEADER
	u8 currMenu; // 0x29. ID for where we are in the menu progression.
	u8 gender; // 0x2A. 0 = unselected, 1 = male, 2 = female.
	u8 route; // 0x2B. 0 = unselected, 1 = mercenary, 2 = military, 3 = mage.
	Unit* mainUnit; // 0x2C. Unit we're keeping in place. Intended to be kept in unit slot 1.
	Unit* tempUnit; // 0x30. Temporary unit used for display in the class menu. Intended to be kept in unit slot 2.
	ClassMenuSet* currSet; // 0x34. Used in the class submenu usability/effect.
	u8 lastClassIndex; // 0x35. Last selected index in the class menu.
	u8 boon; // 0x36. Same indicators as bane.
	u8 bane; // 0x37. 0 = unselected, 1 = HP, 2 = str, 3 = mag, 4 = skl,  ..., 8 = luk.
	u8 leavingClassMenu; // 0x38. Boolean for whether we're exiting the class emnu.
	u8 lastIndex; // 0x39. Before going to a submenu, save the index we were at in the main menu.
	u8 boonBaneTileLast; // 0x3A. Used internally for the boon/bane submenu drawing routines.
	u8 isPressDisabled; // 0x3B. Boolean for whether A/B press is disabled. (Used to disable a press during a randomization).
	u8 cycle; // 0x3C. Cycles on each idle for the creator on a menu. Used for randomization. Cycles between 0 and 15 correlating to how many RNs to burn before randomizing.
};

struct CreatorClassProc
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

struct CreatorSpriteProc
{
	PROC_HEADER
	u8 isActive; // 0x29.
	u8 x; // 0x2A.
	u8 y; // 0x2B.
	Unit** unit; // 0x2C.
};

struct TimerProc
{
	PROC_HEADER
	u16 count; // 0x2A.
};

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

struct ClassMenuSet
{
	u8 gender;
	u8 route;
	struct
	{
		u8 character;
		u8 class;
	} list[5];
};

struct SomeAISStruct {};

extern u16 gBG0MapBuffer[32][32]; // 0x02022CA8. Ew why does FE-CLib-master not do it like this?
extern u16 gBG1MapBuffer[32][32]; // 0x020234A8.
extern u16 gBG2MapBuffer[32][32]; // 0x02023CA8.
extern MenuCommandDefinition gRAMMenuCommands[]; // 0x0203EFB8.
extern AnimationInterpreter gSomeAISStruct; // 0x030053A0.
extern SomeAISStruct gSomeAISRelatedStruct; // 0x0201FADC.
extern AIStruct gAISArray; // 0x2028F78.
extern u8 gSpecialUiCharAllocationTable[]; // 02028E78.
extern Unit* gSkillGetterCurrUnit; // 0x02026BB0.

extern void ReloadGameCoreGraphics(void);
extern void DeleteSomeAISStuff(AnimationInterpreter* interpreter); // 0x0805AA28.
extern void DeleteSomeAISProcs(struct SomeAISStruct* obj); // 0x0805AE14.
extern void EndEkrAnimeDrvProc(void);
extern void RefreshEntityMaps(void);
extern void DrawTileGraphics(void);
extern void UnsetEventId(u16 eventID);
extern void SetEventId(u16 eventID);
extern u8*(*SkillGetter)(Unit* unit);
#define DrawSkillIcon(map,id,oam2base) DrawIcon(map,id|0x100,oam2base)
extern void StartMovingPlatform(int always0x9, int always0x118, int height); // 0x080CD408.
extern void SetupMovingPlatform(int always0x0, int alwaysNeg1, int always0x1F6, int always0x58, int always0x6); // 0x080CD47C.
extern void DrawMapSprite(int depth, int x, int y, Unit* unit); // 0x08027B60. Thanks, Kirb.
extern void SMS_SyncIndirect(void); // 0x08026F94.

extern const struct
{
	u8 base;
	u8 growth;
} MagCharTable[];

extern const u8 CreatorShouldRouteBeAvailable[3];

extern const ProcInstruction gCreatorProc, gCreatorClassProc, gCreatorSpriteProc, gTimerProc;

extern u8 gCreatorBattleSpriteHeight, gCreatorPlatformHeight;
extern const MenuDefinition gCreatorMainMenuDefs;
extern TSA gCreatorMainNameUIBoxTSA, gCreatorMainNameSpriteUIBoxTSA;
extern TSA gCreatorMainUIBoxTSA, gCreatorMainPortraitUIBoxTSA, gCreatorMainBoonBaneUIBoxTSA, gCreatorMainNumberHighlightUIBoxTSA;
extern const u16 gMainMenuErrorTexts[];
extern const struct
{
	u8 gender, route;
	u16 mug;
} gAvatarPortraitLookup[];
extern const struct
{
	u16 normal, replacement;
} gCreatorTextReplacementLookup[];

extern const MenuDefinition gCreatorGenderMenuDefs;
extern const u16 gCreatorGenderText;

extern const MenuDefinition gCreatorRouteMenuDefs;
extern TSA gCreatorRouteUIBoxTSA;
extern const u16 gCreatorRouteDisplayTexts[];

extern const MenuDefinition gCreatorClassMenuDefs;
extern ClassMenuSet gClassMenuOptions[];
extern TSA gCreatorClassUIBoxTSA;
extern const u8 gCreatorAppropriateItemArray[8];
extern const struct
{
	u8 characterID;
	u8 items[5];
} gCreatorRealInventoryList[];
extern const u8 gCreatorVulnerary;

extern const MenuDefinition gCreatorBoonBaneMenuDefs;
extern const struct
{
	u8 base, growth;
} gCreatorBoonBaneEffects[];
extern const u16 gBoonMenuItemErrorText;
extern const u16 gBaneMenuItemErrorText;
const struct
{
	u8 growthID, stat;
} gCreatorGrowthIDLookup[] = {
	{ .growthID = HPGrowthID, .stat = HP },
	{ .growthID = MagGrowthID, .stat = Mag },
	{ .growthID = StrGrowthID, .stat = Str },
	{ .growthID = SklGrowthID, .stat = Skl },
	{ .growthID = SpdGrowthID, .stat = Spd },
	{ .growthID = DefGrowthID, .stat = Def },
	{ .growthID = ResGrowthID, .stat = Res },
	{ .growthID = LukGrowthID, .stat = Luk },
	{}
};
#define TEXT_COLOR_GREY TEXT_COLOR_GRAY

// Functions in CharacterCreator.c.
void CallCharacterSelector(Proc* proc);
void SetupCreator(CreatorProc* proc);
void CreatorStartMenu(CreatorProc* proc);
int CreatorSubmenuUsability(const MenuCommandDefinition* command, int index);
int CreatorSubmenuEffect(MenuProc* proc, MenuCommandProc* commandProc);
int CreatorEndMenu(MenuProc* proc, MenuCommandProc* commandProc);
void CreatorTerminate(CreatorProc* proc);
int CreatorRegressMenu(void);
int CreatorNoBPress(void);
void CreatorEnablePresses(CreatorProc* proc);
void CreatorIdle(CreatorProc* proc);
void NewTimer(Proc* proc);
void TimerSetup(TimerProc* proc);
void TimerIncrement(TimerProc* proc);
void EndTimer(void);
void BurnRNs(void);
static void ApplyBGBox(u16 map[32][32], TSA* tsa, int x, int y);
static void DrawStatNames(TextHandle handle, char* string, int x, int y);
static int GetNumLines(char* string);
static void DrawMultiline(TextHandle* handles, char* string, int lines);
static int GetReplacedText(int text);

// Functions in MainMenu.c.
int CreatorMainEntryUsability(const MenuCommandDefinition* command, int index);
int CreatorMainGotoEntry(MenuProc* proc, MenuCommandProc* commandProc);
int CreatorGoToRandomize(MenuProc* proc, MenuCommandProc* commandProc);
void CreatorRandomizeChoices(CreatorProc* creator);
void CreatorSpriteSetup(CreatorSpriteProc* proc);
void CreatorSpriteIdle(CreatorSpriteProc* proc);
static void DrawMainMenu(CreatorProc* proc);
static int GetMainMenuPortrait(int gender, int route);


// Functions in ClassDisplay.c.
void CreatorClassDrawUIBox(CreatorClassProc* proc);
void CreatorClassStartPlatform(CreatorClassProc* proc);
void CreatorActivateClassDisplay(MenuProc* proc, MenuCommandProc* commandProc);
void CreatorRetractClassDisplay(MenuProc* proc, MenuCommandProc* commandProc);
int CreatorWaitForSlideOut(CreatorProc* proc);
void CreatorClassEndProc(CreatorClassProc* proc);
static ClassMenuSet* GetClassSet(int gender,int route);
static Unit* LoadCreatorUnit(CreatorProc* creator, int index);
static int GetAppropriateItem(int class);

// Functions in BoonBane.c.
static void FillNumString(char* string, int num);

