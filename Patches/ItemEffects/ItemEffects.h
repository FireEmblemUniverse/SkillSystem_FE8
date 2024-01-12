

#define SHORTCALL __attribute__((short_call))
#define CONSTFUNC __attribute__((const))



#include "include/global.h"
#include "include/proc.h"
#include "include/bmunit.h"
#include "include/bmmap.h"
#include "include/bmtrick.h"
#include "include/bmarch.h"
#include "include/bmudisp.h"
#include "include/cp_utility.h"
#include "include/cp_script.h"
#include "include/bmsave.h"
#include "include/constants/classes.h"
#include "include/cp_common.h"
#include "include/uimenu.h" 
#include "include/event.h" 
#include "include/bmcontainer.h" 

#include "include/bmidoten.h"
#include "include/bmitem.h"
#include "include/bmphase.h"
#include "include/bmbattle.h"
#include "include/cp_data.h"
#include "include/constants/items.h"

#include "include/rng.h"
#include "include/constants/terrains.h"
#include "include/cp_utility.h"

extern u8 EscapeRopeChapterTable[]; 
extern u8 CannotTeleportChapterTable[]; 
extern int FlyCommandUsability(void); 
extern int HpBarIsFMUActive(void); 
extern u16 TeleportEvent[];
extern u16 DigEvent[];

extern const struct MenuDef travelSubMenuDef;
extern int WarpCrystal_Link; 
extern int EscapeRope_Link; 
extern int Revive_Link; 
extern int Dig_Link; 
extern int Teleport_Link; 
extern int PsychicType_Link; 
extern u8* TeleportChapter_Link; 
extern u8* DigChapterRam_Link; 

int DoesPartyHaveItem(int id); 
int DepleteItemFromParty(int id);
int DoesPartyKnowMove(int id); 
int IsAnyPartyMemberThisType(int id); 
