@.include 	"_Definitions.h.s"
.macro SET_FUNC_ name, value
	.global \name
	.type   \name, function
	.set    \name, \value
.endm
.macro SET_DATA_ name, value
	.global \name
	.type   \name, object
	.set    \name, \value
.endm


@=====================================================
@		Global Save Data From 0x2026E30
@=====================================================
SET_DATA_	gCommonCharData,		0x2026E30

SET_DATA_	gpUnitExpSaveLoc,		0x2026E30
		
SET_DATA_	gExpUnitStruct_Blue,	0x2026E40
				@ Start:	$2026E40
				@ End:		$2027A10
				@ Length:	$BD0=0x30*0x3F

SET_DATA_	gExpUnitStruct_Red,		0x2027A10
				@ Start:	$2027A10
				@ End:		$2028370
				@ Length:	$960=0x30*0x32

SET_DATA_	gExpUnitStruct_Green,	0x2028370
				@ Start:	$2028370
				@ End:		$2028730
				@ Length:	$3C0=0x30*0x14

SET_DATA_	gExpUnitStruct_Purp,	0x2028730
				@ Start:	$2028730
				@ End:		$2028820
				@ Length:	$0F0=0x30*0x05
SET_DATA_ gUnitArrayBlue_, 0x202BE4C				@Vanilla
SET_DATA_ gUnitArrayBlueEnd_, 0x202CF74			@Vanilla
SET_DATA_ gUnitArrayRed_, 0x202CFBC				@Vanilla
SET_DATA_ gUnitArrayRedEnd_, 0x202DD84			@Vanilla
SET_DATA_ gUnitArrayGreen_, 0x202DDCC			@Vanilla
SET_DATA_ gUnitArrayGreenEnd_, 0x202E324			@Vanilla
SET_DATA_ gUnitArrayPurple_, 0x202E36C			@Vanilla
SET_DATA_ gUnitArrayPurpleEnd_, 0x202E48C		@Vanilla
			

			
SET_DATA_	gModLvUpRNSpace,	0x2028820
	@ModularLevelUp
				@ Start:	$2028820
				@ End:		$2028920
				@ Length:	$100

SET_DATA_	gFreeMoveFlag,		0x2028920		@Byte				
@SET_DATA_	gFreeMoveUnit,		0x2028924
				@ End:		$2028928
SET_DATA_	CommonFlagSaveSu,	0x2028924
SET_DATA_	iFRAM,	0x2028924
SET_DATA_	wFRAM,	0x2028924
				@ Start:	$2028924
				@ End:		$2028954
				@ Length:	$30
@ AOE的时候拿来保存面板了
@自由移动: iFRAM[0]->bit0=FreeMUFlag / wFRAM[1]=MovingUnit;




@=====================================================
@		Temporary System Flag end at 3003720 
@=====================================================

SET_DATA_	FreeRAM,						0x03003600
SET_DATA_ 	Flag_CombatArt, 				0x03003710
SET_DATA_ 	Offset_CombatArt_Common, 		0x0 		@bits to ror
SET_DATA_ 	Offset_CombatArt_CurvedShot, 	0x1 		@bits to ror

SET_DATA_ 	Flag_Gambit, 					0x030036F0
SET_DATA_ 	GambitForReturnMenu,			0x0			@bits to ror
SET_DATA_ 	GambitForBattle,				0x1			@bits to ror

SET_DATA_ 	Flag_AoeAtk, 					0x030036E0
SET_DATA_ 	Offset_AoeAtk, 					0x0
SET_DATA_ 	Offset_AoeHeal, 				0x1


SET_DATA_	tmpExpUnitStackPool,			0x203AAA4
SET_DATA_	tmpExpUnitStackIt,				0x203AAA8		
SET_DATA_	tmpExpUnitStack,				0x203AAAC
				@ Start:	$203AAAC
				@ End:		$203B67C
				@ Length:	$BD0=0x30*0x3F
SET_DATA_	tmpExpUnitQueueIsSet			0x203AAA4	@byte
SET_DATA_	tmpExpUnitQueueCount			0x203AAA5	@byte
SET_DATA_	tmpExpUnitQueuePool				0x203AAA8
SET_DATA_	tmpExpUnitQueuekIt				0x203AAAC	
SET_DATA_	tmpExpUnitQueue,				0x203AAB0

SET_DATA_	tmpExpUnit_ForSave,				0x203AAA4

SET_DATA_	tmpGambitMapArray,				0x203AAA4

SET_DATA_	tmpGambitMapAnimStruct,			0x203AAA4

SET_DATA_	pGambit_MapAnimExpUnitBlueSize,	0x203AAB0
SET_DATA_	tmpGambit_MapAnim_ExpUnitBlue,	0x203AAB4	@ MaxUnit=25D
SET_DATA_	pGambit_MapAnimExpUnitRedSize,	0x203ACB0
SET_DATA_	tmpGambit_MapAnim_ExpUnitRed,	0x203ACB4	@ MaxUnit=22D



@=====================================================
@				Hack Flag in ROM
@=====================================================






@=====================================================
@					Setup
@=====================================================
@for ExpendedUnitStruct/Save
SET_DATA_	gSizeof_ExpUnitStruct,	0x30
SET_DATA_	gMaxUnit_Blue,			0x2D
SET_DATA_	gMaxUnit_Red,			0x32
SET_DATA_	gMaxUnit_Green,			0x14

SET_DATA_	gSizeof_SuExpUnitBlue,	0x30
SET_DATA_	gSizeof_SuExpUnitRG,	0x1E
SET_DATA_	gSizeof1_SuExpUnitRG,	0xE
SET_DATA_	gloc2_SuExpUnitRG,		0x20
SET_DATA_	gSizeof2_SuExpUnitRG,	0x10

SET_DATA_	gSizeof_SaExpUnitBlue,	0x1E
SET_DATA_	gSizeof_SaExpUnitB_Com,	0x14

SET_DATA_	gSizeof_GambitEffectMap,0x20
SET_DATA_	gSizeof_GambitEffectMap_line,	0x4
SET_DATA_	GambitEffectMap_LinCount,		0x7
SET_DATA_	GambitEffectMap_ColCount,		0x7

@ModularLevelUp
SET_DATA_ 	gModLvUpRN_TestByte, 	0x2028820
SET_DATA_ 	gModLvUpRN_OffsetByte, 	0x2028821
SET_DATA_ 	gModLvUpRN_SpaceStart, 	0x2028822
