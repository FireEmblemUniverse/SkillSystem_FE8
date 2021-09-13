#include "FE-CLib\include\gbafe.h"

struct AccessoryLocks;

typedef struct {
	u8 accessoryItemId;
	u8 levelLock; // Promoted is 0x80 | Level
	u8 typeOfLock; // if 0, no lock; if 1 = Mounted Lock; if 2 Foot lock; if 3 Flying lock
	u8 *accessoryClassLocks; // Any additional bans
	int (*userCheckFunction)(u8 item, struct Unit *unit, struct AccessoryLocks *accessoryLocks); // if non 0, will run that function and use the result from that(1 = usable, 0 = unusable)
}AccessoryLocks;


extern u8 Ves_SkillBlockOne_Link;
extern u8 Ves_SkillBlockTwo_Link;
extern u8 Ves_SkillBlockThree_Link; 
extern u8 Ves_SkillBlockFour_Link;

extern u8 AE_NormalShield_Link; 



extern const struct ItemData gItemData[];
extern const AccessoryLocks gAccessoryLocksLookupTable[];
extern u16 CannotEquipAccessoryText;
extern const u32 ExpShareEvent[];
extern u8 AE_ExpShareID;
extern u8 AE_PursuitRingID;
extern u8 AE_ArcanaShieldID;
extern u8 AE_WhetstoneID;
extern u8 AE_AngelRingID;
extern struct ProcInstruction event_proc_bin[];
extern int SkillTester(struct Unit *unit, int skillId);