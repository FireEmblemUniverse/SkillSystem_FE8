#include "C_Code.h" // headers 

//#define VANILLA_VERSION 

#ifdef VANILLA_VERSION 
	// Speed*2 + luck 
void ComputeBattleUnitAvoidRate(struct BattleUnit* bu) {
    bu->battleAvoidRate = (bu->battleSpeed * 2) + bu->terrainAvoid + (bu->unit.lck);

    if (bu->battleAvoidRate < 0)
        bu->battleAvoidRate = 0;
}

#else 
	// Speed + (1/2 luck) 
void ComputeBattleUnitAvoidRate(struct BattleUnit* bu) {
    bu->battleAvoidRate = (bu->battleSpeed) + bu->terrainAvoid + (bu->unit.lck / 2);

    if (bu->battleAvoidRate < 0)
        bu->battleAvoidRate = 0;
}

#endif 