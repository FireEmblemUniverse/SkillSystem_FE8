#include "bmunit.h"
#include "bmbattle.h"

// externs
extern u8 RightfulKingID_Link;
extern u8 RightfulGodID_Link;
extern u8 RightfulArchID_Link;
extern bool SkillTester(struct BattleUnit* unit, u8 skillID);

// function prototypes
int RightfulKing(int activationChance, struct BattleUnit* unit);
int RightfulGod(int activationChance, struct BattleUnit* unit);
int RightfulArch(int activationChance, struct BattleUnit* unit);

