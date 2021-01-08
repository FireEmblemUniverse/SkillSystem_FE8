
#include <stddef.h>
#include "FE-Clib-master/include/gbafe.h"

typedef struct SpellList SpellList;
typedef struct MenuItemPanelProc MenuItemPanelProc;
typedef struct NewBattleHit NewBattleHit;
typedef struct BattleStats BattleStats;
typedef struct RTextProc RTextProc;

enum
{
	BLACK_MAGIC = 1,
	WHITE_MAGIC = 2,
	
	DIRECTION_UP = 0x00, // For RText.
	DIRECTION_RIGHT = 0x10,
	DIRECTION_LEFT = 0x20,
	DIRECTION_DOWN = 0x80
};

struct SpellList
{
	u8 level;
	u8 spell;
};

struct MenuItemPanelProc
{
	PROC_HEADER;
	u8 pad1[3]; // 0x29.
	Unit* unit; // 0x2C.
	u8 x; // 0x30.
	u8 y; // 0x31.
	u8 oam2base, pad2; // 0x32, 0x33.
	TextHandle textHandles[3]; // 0x34, 0x3C 0x44.
};

struct NewBattleHit // Skill System's new 8-byte long rounds data.
{
	unsigned attributes : 19;
    unsigned info       : 5;
    signed   hpChange   : 8;
	u8 pad1;
	s8 damage;
	u8 pad2[2]; // These are things, but I don't know what they are.
};

struct RTextProc
{
	PROC_HEADER;
	char* rTextData; // 0x2C.
	u8 pad1[0x4C - 0x30];
	u16 textID, type, direction; // 0x4C.
};

extern SpellList* SpellListTable[0xFF]; // Entirely different from vanilla Spell Association Table. Just indexed by character ID, points to a ROM spell list.
extern const MenuDefinition SpellSelectMenuDefs;
extern u8 SpellsBuffer[10]; // 0x202B6D0. Undocced RAM. Just a temporary buffer it seems.
extern u8 SelectedSpell; // 0x0203F080.
extern u8 UsingSpellMenu; // 0x0203F082. What type of gaiden magic we're using. 0 if not.
extern u8 DidSelectSpell; // 0x0203F084. Boolean for whether we've selected something from the spell menu.
extern u16 gPopupItem; // 0x030005F4.
extern u16 StatScreenBufferMap[32][32]; // 0x02003C94.
extern u16 gBG0MapBuffer[32][32]; // 0x02022CA8.
extern Unit* gpStatScreenUnit; // 0x02003BC08.

extern u16 gGaidenMagicHPCostText;
extern u16 gGaidenMagicUMErrorText;
extern u16 gGaidenMagicSpellMenuErrorText;
extern u8 GaidenSpellCostTable[];

extern int(*gCan_Attack_Target)(int item, int range, Unit* unit); // These exist in the FE8-Item Range Fix hack.
extern long long(*gGet_Item_Range)(Unit* unit, int item);
extern void(*gAll_Weapons_One_Square)(Unit* unit, int slot);
extern void(*gAll_Staffs_One_Square)(Unit* unit, int slot);
extern void(*gWrite_Range)(int x, int y, long long mask);
extern void(*gGetItemRangeM)(int item);
extern void(*gHealStaff_RangeSetup)(BattleUnit* unit, int empty, int item);

extern void MakeTargetListForWeapon(Unit* unit, int item); // 0x080251B4.
extern void SetFaceBlinkControlById(int faceId, int idk2); // 0x088006458. faceId is a guess.
extern void ForceMenuItemPanel(MenuProc* menu, Unit* unit, int x, int y); // 0x0801E684. idk about the x and y parameters. Just a guess.
extern u32 GetUnitRangeMask(Unit* unit, u8 val); // 0x80171E8.
extern u32 GetWeaponRangeMask(int item); // 0x080170D4.
extern MenuProc* StartMenu_AndDoSomethingCommands(const MenuDefinition*, int xScreen, int xLeft, int xRight); // 0x804F64C.
extern void DrawItemMenuCommand(TextHandle* text, u16 item, int canUse, u16* buffer); // 0x08016848.
extern int AttackUMEffect(MenuProc* proc, MenuCommandProc* commandProc); // 0x08022B30.
extern void UpdateMenuItemPanel(MenuProc* proc); // 0x0801E748.
extern void BattleGenerateUiStats(Unit* unit, int slot); // 0x802A400.
extern void DrawItemRText(int xTile, int yTile, int item); // 0x08088E60.
extern void RTextUp(RTextProc* proc); // 0x08089354.
extern void RTextDown(RTextProc* proc); // 0x08089384.
extern void RTextLeft(RTextProc* proc); // 0x080893B4.
extern void RTextRight(RTextProc* proc); // 0x080893E4.
extern int CanUnitUseItem(Unit* unit, int item); // 0x08028870.
extern void ItemEffect_Call(Unit* unit, int item); // 0x08028E60.

extern MenuDefinition gMenu_UnitMenu; // 0x0859D1F0.
extern TargetSelectionDefinition SpellTargetSelection; // 0x0859D3F8.
extern ProcInstruction gProc_MenuItemPanel; // 0x0859AE88.
extern ProcInstruction gProc_TargetSelection; // 0x085B655C.

int GaidenBlackMagicUMUsability(void);
int GaidenBlackMagicUMEffect(MenuProc* proc, MenuCommandProc* commandProc);
int GaidenWhiteMagicUMUsability(void);
int GaidenWhiteMagicUMEffect(MenuProc* proc, MenuCommandProc* commandProc);
static int GaidenMagicUMUsabilityExt(u8* spellList);
static int GaidenMagicUMEffectExt(u8* spellList, MenuProc* proc, MenuCommandProc* commandProc);
int GaidenBlackMagicUMHover(MenuProc* proc);
int GaidenWhiteMagicUMHover(MenuProc* proc);
int GaidenMagicUMUnhover(MenuProc* proc);

u8* SpellsGetter(Unit* unit, int type);
u8* SpellsGetterForLevel(Unit* unit, int level, int type);
int NewGetUnitEquippedWeapon(Unit* unit);
int NewGetUnitEquippedWeaponSlot(Unit* unit);
u32 NewGetUnitUseFlags(Unit* unit);
void Proc_GaidenMagicHPCost(BattleUnit* attacker, BattleUnit* defender, NewBattleHit* buffer, BattleStats* battleData);
void SetRoundForSpell(BattleUnit* unit, NewBattleHit* buffer);
int InitGaidenSpellLearnPopup(void);
int HasSufficientHP(Unit* unit, int spell);
int CanCastSpellNow(Unit* unit, int spell);
int CanCastSpell(Unit* unit, int spell);
int CanUseAttackSpellsNow(Unit* unit, int type);
int GetNthUsableSpell(Unit* unit, int n, int type);
static int GetVanillaEquipped(Unit* unit);
int DoesUnitKnowSpell(Unit* unit, u8 spell);
int GetSpellType(int spell);
int GetSpellCost(int spell);
int GetFirstAttackSpell(Unit* unit);
void Target_Routine_For_Fortify(BattleUnit* unit);
void GaidenZeroOurSpellVariables(void);

long long Return_Range_Bitfield(Unit* unit, int slot, int(*usability)(Unit* unit, int item));
long long GetUnitRangeMaskForSpells(Unit* unit, int(*usability)(Unit* unit, int item));
static long long IncorporateNewRange(long long existing, long long new);
int RangeUsabilityCheckStaff(Unit* unit, int item);
int RangeUsabilityCheckNotStaff(Unit* unit, int item);
void All_Spells_One_Square(Unit* unit, int(*usability)(Unit* unit, int item));

int SpellUsability(const struct MenuCommandDefinition* menuEntry, int index, int idk);
int SpellDrawingRoutine(MenuProc* menu, MenuCommandProc* menuCommand);
int MagicMenuBPress(void);
int SpellEffectRoutine(MenuProc* proc, MenuCommandProc* menuCommand);
int SpellOnHover(MenuProc* proc);
int SpellOnUnhover(MenuProc* proc);
void NewExitBattleForecast(Proc* proc);

TextHandle* GaidenStatScreen(int x, int y, TextHandle* currHandle);
void GaidenRTextGetter(RTextProc* proc);
void GaidenRTextLooper(RTextProc* proc);

#include "UnitMenu.c"
#include "SpellSystem.c"
#include "RangeDisplay.c"
#include "SpellMenu.c"
#include "StatScreen.c"
