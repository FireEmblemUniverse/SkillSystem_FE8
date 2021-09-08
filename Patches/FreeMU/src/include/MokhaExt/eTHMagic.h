#ifndef HEARDEREXT_THMAGIC
#define HEARDEREXT_THMAGIC

/* For Three House Style Magic System (Mokha Ver) */

struct MagicSystemData {
	/* 00 */ u8 MagicIndex;
	/* 01 */ u8 MagicType;	//Black=1, White=2
};


/**
 * 输入从UnitExp+0x20开始的第几个(0-F)位置，输出对应这个位置的MagicItemID
 * 
 * @param 	r0=Loc
 * @return 	Maigic ID
 */
u8 GetMagicID(u8 iLoc);

/**
 * 根据ID来找到其位于UnitExp+0x20+?的位置。如果不是魔法则返回0x10
 * 
 * @param 	r0=MagicID
 * @return 	Loc
 */
u8 GetMagicloc(u8);

/**
 * 输入从UnitExp+0x20开始的第几个位置，输出对应这个位置的Item-Use
 * 
 * @param 	r0=MagicID, r1=iLoc
 * @return 	Item-Use
 */
u16 GetMagic_ItemUse(struct Unit* ObjectUnit, u8 iLoc);

/**
 * (out dated)
 * now use IsItemMagic & IsItemWeapon
 * 
 * @param 	r0=ItemID
 * @return 	0=False, 1=Magic, 2=Weapon 
 */
u8 TestMagic(u16 item);

/**
 * @param 	r0=Item-Use
 * @return 	1=Magic
 */
u8 IsItemMagic(u16 item);

/**
 * 并不能区别Magic
 * @param 	r0=Item-Use
 * @return 	1=Weapon
 */
u8 IsItemEquapable(u16 item);

/**
 * Set UnitExp.WpnEqp judged by Pow/Mag (Currentlly is UnitExp.Free[6])
 * 
 * @param 	r0=UnitStruct
 * @return 	0=False, 1=Magic, 2=Weapon 
 */
u8 SetupEqpSlotAuto(struct Unit*);

/**
 * @param 	r0=UnitStruct
 * @return 	UnitExp.WpnEqp
 */
u16 GetUnitWpnEqp(struct Unit*);

/**
 * @param 	r0=UnitStruct
 * @return 	1=Equiped, 0=Use=0
 */
u8 SetUnitWpnEqp(struct Unit* ObjectUnit, u16 ItemUse);

/**
 * 将UnitExp.WpnEqp的魔法次数保存回UnitExp.Magic[]
 * @param 	r0=UnitStruct
 * @return 	0=Not Magic
 */
u8 SaveUnitMagFromEqp(struct Unit*);

/**
 * 将根据ItemUse对应的魔法次数保存到UnitExp.Magic[]
 * @param 	r0=UnitStruct, r1=ItemUse
 * @return 	0=Not Magic
 */
u8 SetUnitMagUse(struct Unit*,u16 ItemUse);



extern const struct MagicSystemData MagicSystemTable[];



#endif	// HEARDEREXTMOKHA_THMAGIC