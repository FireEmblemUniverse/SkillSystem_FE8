
#include "include/global.h"

#include "include/constants/items.h"
#include "include/constants/classes.h"
#include "include/constants/characters.h"
#include "include/constants/terrains.h"

#include "include/rng.h"
#include "include/bmitem.h"
#include "include/bmunit.h"
#include "include/bmmap.h"
#include "include/bmreliance.h"
#include "include/chapterdata.h"
#include "include/bmtrick.h"
#include "include/m4a.h"
#include "include/soundwrapper.h"
#include "include/hardware.h"
#include "include/proc.h"
#include "include/mu.h"
#include "include/bmarch.h"
#include "include/bmarena.h"
#include "include/bmsave.h"
#include "include/ekrbattle.h"
#include "include/bmbattle.h"
#include "include/mapanim.h"

int CheckEventId(int id); 

extern u8 Class_Level_Cap_Table[]; 

extern int minStatGain_Link; 
extern int Get_Hp_Growth(struct Unit* unit); 
extern int Get_Str_Growth(struct Unit* unit); 
extern int Get_Skl_Growth(struct Unit* unit); 
extern int Get_Spd_Growth(struct Unit* unit); 
extern int Get_Def_Growth(struct Unit* unit); 
extern int Get_Res_Growth(struct Unit* unit); 
extern int Get_Luk_Growth(struct Unit* unit); 
extern int Get_Mag_Growth(struct Unit* unit); 



struct GrowthOptions { 
u8 FIXED_GROWTHS_MODE : 1; 
u8 FIXED_GROWTHS_DONT_BOOST : 1; 
u8 STACKABLE_GROWTH_BOOSTS : 1; 
u8 ENEMY_NPC_FIXED_GROWTHS : 1; 
u8 USE_STAT_COLORS : 1; 
u8 STAT_BRACKETING_EXISTS : 1; 
u8 METIS_TOME_BOOST; 
u16 FIXED_GROWTHS_FLAG_ID; 
};

extern struct GrowthOptions GrowthOptions_Link; 
extern int BRACKETED_GROWTHS_FLAG_ID_Link; 
extern int ForceWhenBelowAverageBy_Link; 
extern int PreventWhenAboveAverageBy_Link; 

