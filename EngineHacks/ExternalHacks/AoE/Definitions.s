
.thumb 
@ Primary Table structure 
@ Usability Reqs 
.equ UnitByte, 0x00 
.equ ClassByte, 1 
.equ LevelByte, 2 
.equ ItemByte, 3 
.equ FlagShort, 4 @and 5 
.equ SkillByte, 6 
.equ GaidenSpellWexpByte, 7 @ For Pokemblem 
@ Config 
.equ HpCostByte, 8
.equ ConfigByte, 9

.equ PowerLowerBoundByte, 10
.equ PowerUpperBoundByte, 11 
.equ MinRangeByte, 12
.equ MaxRangeByte, 13 
.equ RangeMaskByte, 14 
.equ Animation_IDByte, 15

@ Config Bools 
.equ HealBool, 0x01
.equ FriendlyFireBool, 0x02 
.equ FixedDamageBool, 0x04 
.equ MagBasedBool, 0x08 
.equ HitResBool, 0x10
.equ DepleteItemBool, 0x20
.equ UsableOnlyIfStationaryBool, 0x40 




	.equ CurrentUnit, 0x3004E50
	.equ MemorySlot,0x30004B8
	.equ EventEngine, 0x800D07C
	.equ CheckEventId,0x8083da8
	
	.equ NextRN_100, 0x8000c64 @NextRN_100	
	
	.equ pActionStruct, 0x203A958	
	.equ CurrentUnitFateData, 0x203A958














