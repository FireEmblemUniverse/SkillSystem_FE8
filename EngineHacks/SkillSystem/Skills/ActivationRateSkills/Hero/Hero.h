#include "bmunit.h"
#include "bmbattle.h"

// externs
extern u8 HeroID_Link;
extern bool SkillTester(struct BattleUnit* unit, u8 skillID);

// function prototypes
int HeroSkill(int activationChance, struct BattleUnit* unit);
