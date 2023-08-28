#include "gbafe.h"
extern int SkillTester(struct Unit* unit, int SkillID); 
extern int ScaledUpID_Link; 
extern int Intimidate2ID_Link; 

// deal 20% more dmg 
void ScaledUp(struct BattleUnit* bunitA, struct BattleUnit* bunitB) { 
	if (SkillTester(&bunitB->unit, ScaledUpID_Link)) { 
		if (gBattleTarget.battleDefense) { // if def isn't calculated yet, do nothing 
			int dmg = bunitB->battleAttack - bunitA->battleDefense; 
			if (dmg < 0) dmg = 0; 
			int addDmg = (dmg+2)/5; // for rounding 
			bunitB->battleAttack += addDmg; 
		
		} 
	} 
} 


//extern IntimidateDebuffs[]; 
struct weaponDebuffTableStruct { 
	u8 mag;
	u8 str;
	u8 skl;
	u8 spd;
	u8 def;
	u8 res;
	u8 luk;
	u8 mov;
};
extern struct weaponDebuffTableStruct IntimidateDebuffs; 
extern u8 DebuffStatNumberOfBits_Link;
extern u32* GetUnitDebuffEntry(struct Unit*); 
extern int DebuffStatBitOffset_Str; 
extern int UnpackData_Signed(u32* debuffEntryRam, u8 bitOffset, u8 bitCount); 
extern void DebuffGivenTableEntry(u32*, struct weaponDebuffTableStruct*, int); 

// Enemy Str is reduced by 25% when attacking. 
void Intimidate_Prebattle(struct BattleUnit* bunitA, struct BattleUnit* bunitB) { 
	if (gBattleStats.config & (BATTLE_CONFIG_REAL | BATTLE_CONFIG_SIMULATE)) {
		if (!(bunitA->weaponAttributes & IA_MAGIC)) { 
			if (SkillTester(&bunitB->unit, Intimidate2ID_Link)) { 
			
			void* debuffRam = GetUnitDebuffEntry(&bunitA->unit); 
			int str = bunitA->unit.pow; 
			int subStr = (str+2)/4; 
			if (UnpackData_Signed(debuffRam, DebuffStatBitOffset_Str, DebuffStatNumberOfBits_Link) >= 0) { 
				// if enemy is not already debuffed, do stuff 
				bunitA->battleAttack -= subStr; 
				if (bunitA->battleAttack < 1) { bunitA->battleAttack = 1; } 

			} 
			if (gBattleStats.config & BATTLE_CONFIG_REAL) { 
				//asm("mov r11, r11"); 
				struct weaponDebuffTableStruct tempDebuffTable; 
				tempDebuffTable.mag = 0; 
				tempDebuffTable.str = subStr|0x80; //((str+2)/4)|0x80;  
				tempDebuffTable.skl = 0; 
				tempDebuffTable.spd = 0; 
				tempDebuffTable.def = 0; 
				tempDebuffTable.res = 0; 
				tempDebuffTable.luk = 0; 
				tempDebuffTable.mov = 0; 
				//DebuffGivenTableEntry(debuffRam, IntimidateDebuffs, 0); 
				DebuffGivenTableEntry(debuffRam, &tempDebuffTable, 0); 
				// apply some debuff here ? or make it always happen post-battle 
			} 


			} 
		} 
	} 
} 
