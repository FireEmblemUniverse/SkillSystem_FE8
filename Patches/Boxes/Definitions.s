.include "fe8.s" 
.include "C:/devkitPro/FE-CLib/reference/FE8U-20190316.s"

SET_DATA classTablePoin, 0x8017AB8 
SET_DATA unit, 0x2021188
SET_DATA bunit, 0x2021188
SET_DATA NewgSMSGfxIndexLookup, 0x201F148 // sound room buffer 
SET_DATA PCBoxUnitsBuffer, 0x2026E30	// size: 0x2028	- normally used by debug printing //[2026E30..2028E30]!!

SET_FUNC SetFlag,  0x8083d81 
SET_FUNC ClearFlag, 0x8083d95
SET_FUNC CheckFlag, 0x8083da9


SET_FUNC CheckInLinkArena, 0x8042e98+1
SET_FUNC DrawSpecialUiStr, 0x8004d5c+1
SET_FUNC CanUnitBeDeployedLinkArena, 0x8097e74+1
SET_FUNC StartPrepErrorHelpbox, 0x8097da8+1
SET_FUNC gBgConfig_ItemUseScreen, 0x8a181e8+1
SET_FUNC LoadHelpBoxGfx, 0x8089804+1







