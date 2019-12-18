.thumb
@Staff AI asm macros

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
	.set ChapterDataStruct,            0x0202BCF0 		
	.set CurrentMapSize,               0x0202E4D4 		
	.set UnitMapRows,                  0x0202E4D8 		
	.set MoveCostMapRows,              0x0202E4E0 		
	.set RangeMapRows,                 0x0202E4E4 		
	.set FogMapRows,                   0x0202E4E8
	.set ActionStruct,                 0x0203A958 		
	.set TargeterXY,                   0x0203DDE8 		
	.set TargetList,                   0x0203DDEC
	.set TargetNum,                    0x0203E0EC 		
	.set SelectedUnit,                 0x02033F3C 		
	.set ActiveUnit,                   0x03004E50 		
@----------------------------------------------------------
@List of Relevant Routines

	@Item & Unit Related routines
	.set DecrementItemUses,            0x08016AEC
		@arguments: r0= item/uses short

	.set Unit_GetEquippedWeapon,       0x08016B28 
		@ arguments: r0 = Unit Struct pointer;
		@ returns: r0 = Item Short
	.set Item_GetUsesLeft,             0x08017584
		@arguments: r0 = item/uses short
	.set Unit_ReorderItems,            0x08017984
		@arguments: r0 = ram unit pointer
		@remove spaces in unit's inventory caused 
		@by things like stolen and broken items
	.set Unit_GetItemCount,               0x080179D8
		@arguments: r0= ram unit pointer
	.set GetUnit,                      0x08019430
	.set Unit_GetAid,                  0x080189B8
	.set Unit_GetHalfMag,              0x08018A1C
	.set Unit_GetCurHP,                0x08019150
	.set Unit_GetMaxHP,                0x08019190
	.set Unit_GetStr,                  0x080191B0
	.set Unit_GetMag,                  0x080191B0
	.set Unit_GetSkl,                  0x080191D0
	.set Unit_GetSpd,                  0x08019210
	.set Unit_GetDef,                  0x08019250
	.set Unit_GetRes,                  0x08019270
	.set Unit_GetLuck,                 0x08019298
	.set Unit_CanCrossTerrain,         0x0801949C 
		@ arguments: r0 = Unit Struct pointer, r1 = Terrain Index;
		@ returns: r0 = 0 if Unit cannot cross/stand on terrain
	.set Unit_GetRangeMap,             0x080171E8 
		@ arguments: r0 = Unit Struct pointer, r1 = Item Slot Index (-1 for all);
		@ returns: r0 = range mask
	.set Unit_CanUseItem,              0x08028870 
		@ arguments: r0 = Unit Struct pointer, r1 = Item Short;
		@ returns = 1 if unit can use item, 0 otherwise
	.set StaffHitRate,                 0x0802CCDC 	@

	@Range and Move Cost Maps Routines
	.set FillMap,                      0x080197E4	@
		@r0 = row pointer; r1 = value
	.set AddRange,                     0x0801AABC
		@build targeting range in range map
		@r0 = x; r1 = y; r2 = range; r3 = value
	.set CheckUnitsInRange,            0x08024EAC	@
	.set CheckTilesInRange,            0x08024F18	@
	.set CheckAdjacentUnits,           0x08024F70	@
	.set ShowRangeSquares,             0x0801DA98	@
	.set HideRangeSquares,             0x0801DACC	@
		@arguments: none; returns: nothing
	
	@Target List Related Routines
	.set RefreshTargetList,            0x0804F8A4	@
		@r0 = x; r1 = y;
	.set AddTargetListEntry,           0x0804F8BC 
		@arguments: r0 = x, r1 = y, 
		@r2 = unit allegience byte, r3 = trap type; 
		@returns: nothing
	.set GetTargetListSize,            0x0804FD28	@
	.set GetTargetListEntry,           0x0804FD34	
	@6c stuff; most of these are taken from stan's notes
	.set NewTargetSelection,           0x0804FA3C	
	.set NewTargetSelectv2,            0x0804FAA4	

	.set New6C,                        0x08002C7C @ arguments: r0 = pointer to ROM 6C code, r1 = parent; returns: r0 = new 6C pointer (0 if no space available)
	.set New6CBlocking,                0x08002CE0 @ same
	.set End6C,                        0x08002D6C 
		@ arguments: r0 = pointer to 6C to delete
	.set Break6CLoop,                  0x08002E94 
		@ arguments: r0 = pointer to 6C whose loop to break
	.set Find6C,                       0x08002E9C 
		@ arguments: r0 = pointer to ROM 6C code; returns: r0 = 6C pointer of first match (0 if none found)
	.set Goto6CLabel,                  0x08002F24 
		@ arguments: r0 = pointer to 6C, r1 = label index to go to
	.set Goto6CPointer,                0x08002F5C 
		@ arguments: r0 = pointer to 6C, r1 = pointer to ROM 6C code to go to
	.set ForEach6C,                    0x08002F98 
		@ arguments: r0 = pointer to ROM 6C code, r1 = function<void(6CStruct*)>
	.set BlockEach6CMarked,            0x08002FEC 
		@ arguments: r0 = mark index
	.set UnblockEach6CMarked,          0x08003014 
		@ arguments: r0 = mark index
	.set DeleteEach6CMarked,           0x08003040 
		@ arguments: r0 = mark index
	.set DeleteEach6C,                 0x08003078 
		@ arguments: r0 = pointer to ROM 6C code
	.set BreakEach6CLoop,              0x08003094 
		@ arguments: r0 = pointer to ROM 6C code

	.set LockGameLogic,                0x08015360
	.set UnlockGameLogic,              0x08015370

	.set GetTextBuffer,                0x0800A240	
	.set SetBottomHelpText,            0x08035708	
	
	@Trap Related Routines
	.set FindTrapAt,                   0x0802E1F0
	.set FindTrapTypeAt,               0x0802E24C
	.set CreateTrap,                   0x0802E2B8
	.set CreateLightRune,              0x0802EA58
	.set CreateBallista,               0x08037A04
	.set FindBallistaAt,               0x0803798C 
		@ arguments: r0 = x, r1 = y;
		@ returns: ballista item at (x, y) (0 if none)
	
	@Other
	.set Font_ResetAllocation,     0x08003D20
		@frees space used by text and range squares?
		@arguments: none; returns: nothing
	.set PlaySoundEffect,              0x080D01FC 	
		@arguments: r0= sound id
	.set ConfirmStaffUse,              0x0802951C 
		@writes action 0x3 (using a staff) to ActionStruct
		@also removes range squares and clears BG2
		@arguments: none
	.set CanChestOpen,                 0x080831AC
		@check if chest can be opened
		@arguments: r0 = x, r1 = y
		@returns true(1) or false(0)
	.set FadingChestOpen,              0x080831C8
		@if the tile at the given area is an openable chest,
		@ perform fading tile change
		@arguments: r0 = x, r1 = y
	.set CanDoorOpen,                  0x080831F0
		@check if door can be opened
		@arguments: r0 = x, r1 = y
		@returns true(1) or false(0)
	.set FadingDoorOpen,               0x0808320C
		@if the tile at the given area is an openable door,
		@ perform fading tile change
		@arguments: r0 = x, r1 = y
@	.set FadingTileChange,             0x080840C4
		@perform fading tile change with the tile change that affects the given area?
		@arguments: r0 = x, r1 = y
	
@	.set SetMapCursorPosition,          
@	.set StartCameraMovement,           
