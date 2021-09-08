#ifndef HEARDEREXT_UNITEXP
#define HEARDEREXT_UNITEXP

/* For Three Houses Sytle Expanded Unit Struct */

struct UnitExp {
	/* 00 */ u8 CombatArt[5];
	/* 05 */ u8 Skill[5];
	/* 0A */ u8 Emblem[4];
	/* 0E */ u8 ClassRank;
	/* 0F */ u8 Charm;
	/* 10 */ u8 TrainedClassMask;
	/* 11 */ u8 BattalionIndex;
	/* 12 */ u8 BattalionUseHp;
	/* 13 */ u8 JewelryItemID;
	/* 14 */ u8 Passion;
	/* 15 */ u8 Ranks[5];
	/* 1A */ u8 Free[6];
	/* 20 */ u8 Magic[0xC];
	/* 2C */ u16 WpnEqp;
	/* 2E */ u8 Free2[2];
};


struct UnitExp* GetExpUnitStructLoc(Unit*);
struct UnitExp* GetUnitExp(Unit*);

#endif	//HEARDEREXT_UNITEXP