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

@Relevant Ram Offsets
.set MapSize,                          0x202E4D4 		
.set MoveCostMapRows,                  0x202E4E0 		
.set RangeMap,                         0x202E4E4 		
.set ActionStruct,                     0x203A958 		
.set AIActionStruct,                   0x203AA94 		@shortened to AAS
.set ActiveUnit,                       0x3004E50 		
.set turnList,                         0x203AA04 		

@Routines
	@character info routines
	.set RamUnitByID,                       0x08019430
		@ arguments:
			@r0 = unit deployment id
		@returns:
			@r0 = unit pointer
	.set Unit_GetEquippedWeapon,            0x08016B28 
		@ arguments: r0 = Unit Struct pointer;
		@ returns: r0 = Item Short
	.set Unit_GetAid,                       0x080189B8
	.set Unit_GetHalfMag,                   0x08018A1C
	.set Unit_GetCurHP,                     0x08019150
	.set Unit_GetMaxHP,                     0x08019190
	.set Unit_GetStr,                       0x080191B0
	.set Unit_GetMag,                       0x080191B0
	.set Unit_GetSkl,                       0x080191D0
	.set Unit_GetSpd,                       0x08019210
	.set Unit_GetDef,                       0x08019250
	.set Unit_GetRes,                       0x08019270
	.set Unit_GetLuck,                      0x08019298
	.set Unit_CanCrossTerrain,              0x0801949C
		@ arguments: r0 = Unit Struct pointer, r1 = Terrain Index;
		@ returns: r0 = 0 if Unit cannot cross/stand on terrain
	.set Unit_HasUsableStaff,               0x0803C44C
		@arguments: r0 = Unit Struct pointer
	.set AIAllegianceCheck,                 0x0803C818
	.set GetPercentage,                     0x080D167C
		@arguments: r0 = cur hp * 100, r1 = max hp
		@returns: r0 = percentage
	@Trap related routines
	.set FindTrapAt,                        0x0802E1F0
	.set FindTrapType,                      0x0802E24C
	
	@Range and Move Cost Maps Routines
	.set FillMap,                           0x80197E4
	.set AddRange,                          0x801AABC 	@build targeting range in range map

	.set MagicSealCheck,                    0x801B950 	@check where the magic seal is
	.set MovBuild,                          0x803C490 	@build movement range; parameters: r0 = ram character pointer
	.set IsTileReachable,                   0x803BFD0 	@parameters: r0 = x of acting unit, r1 = y of acting unit, r2 = x of target unit/tile, r3 = y of target unit/tile

	@Action related routines
	.set FindNewSpot,                       0x803C284 	@find where unit will move to use staff
	.set ActionWrite,                       0x8039C20	@write info to AAS

	@Other
	.set 	StaffHitRate,                   0x802CCDC 
		@arguments:
			@r0 = unit pointer to acting unit
			@r1 = unit pointer to targeted unit
		@retruns: r0= hit% rate
		
		