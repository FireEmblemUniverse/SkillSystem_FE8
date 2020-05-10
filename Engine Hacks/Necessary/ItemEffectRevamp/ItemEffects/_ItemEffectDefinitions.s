.thumb

.macro _blh to, reg=r3
	ldr \reg, =\to
	mov lr, \reg
	.short 0xF800
.endm

.macro _bldr reg, dest
	ldr \reg, =\dest
	mov lr, \reg
	.short 0xF800
.endm

.macro _blr reg
	mov lr, \reg
	.short 0xF800
.endm

@----------------------------------------------------------
@Relevant Ram Offsets

.set GameDataStruct,                   0x0202BCB0
.set ChapterDataStruct,                0x0202BCF0
.set ActionStruct,                     0x0203A958
.set SelectedUnit,                     0x02033F3C 		
.set ActiveUnit,                       0x03004E50 		
.set BattleActingUnit,                 0x0203A4EC @attacker
.set BattleTargetUnit,                 0x0203A56C @defender

.set TargeterXY,                       0x0203DDE8 		
.set TargetList,                       0x0203DDEC
.set TargetNum,                        0x0203E0EC 		

.set CurrentMapSize,                   0x0202E4D4
.set rsUnitMapRows,                    0x0202E4D8
.set rsTerrainMapRows,                 0x0202E4DC
.set rsMoveMapRows,                    0x0202E4E0
.set rsRangeMapRows,                   0x0202E4E4
.set rsFogMapRows,                     0x0202E4E8
.set rsOtherMoveMapRows,               0x0202E4F0
@----------------------------------------------------------
@List of Relevant Routines

@Item & Unit Related routines
	.set RamUnitByID,                      0x08019430
		@ arguments:
			@r0 = unit deployment id
		@returns:
			@r0 = unit pointer
	.set BActingUnitUpdate,                0x0802CB24
		@ arguments:
			@r0 = unit pointer
			@r1 = selected item slot
	.set BTargetUnitUpdate,                0x0802CBC8
		@arguments:
			@r0 = unit pointer
	.set DecrementItemUses,                0x08016AEC
		@arguments: r0= item/uses short

	.set Unit_GetEquippedWeapon,       0x08016B28 
		@ arguments: r0 = Unit Struct pointer;
		@ returns: r0 = Item Short
	.set Unit_ReorderItems,                0x08017984
		@arguments: r0 = ram unit pointer
		@remove spaces in unit's inventory caused 
		@by things like stolen and broken items
	.set Unit_ItemCount,                   0x080179D8
		@arguments: r0= ram unit pointer
	.set GetUnit,                          0x08019430
	.set Unit_GetAid,                      0x080189B8
	.set Unit_GetHalfMag,                  0x08018A1C
	.set Unit_GetCurHP,                    0x08019150
	.set Unit_GetMaxHP,                    0x08019190
	.set Unit_GetStr,                      0x080191B0
	.set Unit_GetMag,                      0x080191B0
	.set Unit_GetSkl,                      0x080191D0
	.set Unit_GetSpd,                      0x08019210
	.set Unit_GetDef,                      0x08019250
	.set Unit_GetRes,                      0x08019270
	.set Unit_GetLuck,                     0x08019298
	.set Unit_CanCrossTerrain,             0x0801949C 
		@ arguments: r0 = Unit Struct pointer, r1 = Terrain Index;
		@ returns: r0 = 0 if Unit cannot cross/stand on terrain
	.set Unit_GetRangeMap,                 0x080171E8 
		@ arguments: r0 = Unit Struct pointer, r1 = Item Slot Index (-1 for all);
		@ returns: r0 = range mask
	.set Unit_CanUseItem,                  0x08028870 
		@ arguments: r0 = Unit Struct pointer, r1 = Item Short;
		@ returns = 1 if unit can use item, 0 otherwise
	.set StaffHitRate,                     0x0802CCDC 	@
	.set Item_GetMight,                    0x080175DC 
		@ arguments: r0 = Item Short
		@ returns: r0 = Might
	.set Item_GetWeight,                   0x0801760C
		@ arguments: r0 = Item Short
		@ returns: r0 = weight
	
	@Trap Related Routines
	.set FindTrapAt,                       0x0802E1F0
	.set FindTrapTypeAt,                   0x0802E24C
	.set CreateTrap,                       0x0802E2B8
	.set CreateLightRune,                  0x0802EA58
	.set CreateBallista,                   0x08037A04
	.set FindBallistaAt,                   0x0803798C 
		@ arguments: r0 = x, r1 = y;
		@ returns: ballista item at (x, y) (0 if none)

	@6C related routines
	.set New6C,                            0x08002C7C 
		@ arguments: r0 = pointer to ROM 6C code, r1 = parent;
		@ returns: r0 = new 6C pointer (0 if no space available)
	.set New6CBlocking,                    0x08002CE0 
		@ arguments: r0 = pointer to ROM 6C code, r1 = parent;
		@ returns: r0 = new 6C pointer (0 if no space available)
	.set End6C,                            0x08002D6C 
		@ arguments: r0 = pointer to 6C to delete
	.set Break6CLoop,                      0x08002E94 
		@ arguments: r0 = pointer to 6C whose loop to break
	.set Find6C,                           0x08002E9C 
		@ arguments: r0 = pointer to ROM 6C code;
		@ returns: r0 = 6C pointer of first match (0 if none found)
	@Other Routines
	.set PlaySoundEffect,              0x080D01FC 	
		@arguments: r0= sound id
		
	.set ConfirmStaffUse,                     0x0802951C 
		@writes action 0x3 (using a staff) to ActionStruct
		@also removes range squares and clears BG2
		@arguments: none
		