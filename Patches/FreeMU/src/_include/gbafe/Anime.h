#ifndef HEARDERMOKHA_ANIME
#define HEARDERMOKHA_ANIME

// 0x802CB25 in FE8U
void SetupSubjectBattleUnitForStaff(struct Unit* SubjectUnit, u8 itemSlotIndex);

// 0x802CBC9 in FE8U
void SetupTargetBattleUnitForStaff(struct Unit* TargetUnit);


// 0x802CC55 in FE8U
void BattleApplyItemEffect(struct Proc* ParentProc);

// 0x802CA15
void BeginBattleAnimations(void);

// 0x8056FF9
bool PrepareBattleGraphicsMaybe(void);




#endif	//HEARDERMOKHA_ANIME