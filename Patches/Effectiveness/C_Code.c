#include "C_Code.h" // headers 

extern int SkillTester(struct Unit* unit, int SkillID); 
extern int TintedLensID_Link; 

s8 IsItemEffectiveAgainst(u16 item, struct Unit* unit) {
	
	// Establish an attacker and defender for use with skills 
	struct BattleUnit* attacker = gBattleActor; 
	struct BattleUnit* defender = gBattleTarget; 
	if (&gBattleActor->unit != unit) { 
		attacker = gBattleTarget; 
		defender = gBattleActor; 
	} 
	
	
	
	
	
    if (unit->pClassData) {
        int classId = unit->pClassData->number;
        const u8* effList = GetItemEffectiveness(item);

        if (!effList)
            return FALSE;

        for (; *effList; ++effList)
            if (*effList == classId)
                // NOTE: maybe there's a better way to make this work (using an inline maybe?)
                goto check_flying_effectiveness_negation;

        return FALSE;

        check_flying_effectiveness_negation: {
            u32 attributes;
            int i;

            if (GetItemEffectiveness(item) != ItemEffectiveness_088ADF2A)
                if (GetItemEffectiveness(item) != ItemEffectiveness_088ADEF1)
                    return TRUE;

            attributes = 0;

            for (i = 0; i < UNIT_ITEM_COUNT; ++i)
                attributes = attributes | GetItemAttributes(unit->items[i]);

            if (!(attributes & IA_NEGATE_FLYING))
                return TRUE;
            else
                return FALSE;
        }
    }

    return FALSE;
}