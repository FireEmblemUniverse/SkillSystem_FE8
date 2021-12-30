
.include "FE-CLib-master/reference/FE8U-20190316.s"

SET_DATA gBG0MapBuffer, 0x02022CA8

SET_DATA gBG1MapBuffer, 0x020234A8

SET_DATA gBG2MapBuffer, 0x02023CA8

SET_DATA gRAMMenuCommands, 0x0203EFB8

SET_DATA gSomeAISStruct, 0x030053A0

SET_DATA gSomeAISRelatedStruct, 0x0201FADC

SET_DATA TileOrigin, 0x02003C94

SET_DATA gSpecialUiCharAllocationTable, 0x02028E78

SET_DATA gSkillGetterCurrUnit, 0x02026BB0


SET_FUNC RefreshEntityMaps, (0x801A1F4+1)

SET_FUNC DrawTileGraphics, (0x8019C3C+1)

SET_FUNC DeleteSomeAISStuff, (0x0805AA28+1)

SET_FUNC DeleteSomeAISProcs, (0x0805AE14+1)

SET_FUNC GetUnitEquippedItem, (0x08016B28+1)

SET_FUNC StartMovingPlatform, (0x080CD408+1)

SET_FUNC SetupMovingPlatform, (0x080CD47C+1)

SET_FUNC DrawMapSprite, (0x08027B60+1)
