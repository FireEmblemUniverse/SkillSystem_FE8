
.include "FE-CLib-master/reference/FE8U-20190316.s"

@ Functions to be autohooked.
SET_FUNC MasterSupportCalculation, (0x080285B0+1)

SET_FUNC SupportConvoUsability, (0x08023D14+1)

SET_FUNC BuildSupportTargetList, (0x08025644+1)

SET_FUNC SupportSelected, (0x080323D4+1)

SET_FUNC FixCUSA, (0x08018480+1)

SET_FUNC DrawSupports, (0x8087698+1)

SET_FUNC SupportReworkPageSwitch, (0x08088690+1)

@ Functions to define I didn't find in Clib.
SET_FUNC GetChapterEvents, (0x080346B0+1)

SET_FUNC StartMapEventEngine, (0x0800D0B0+1)

SET_FUNC GetStringFromIndex, (0x0800A240+1)

SET_FUNC RTextUp, (0x08089354+1)

SET_FUNC RTextDown, (0x08089384+1)

SET_FUNC RTextLeft, (0x080893B4+1)

SET_FUNC RTextRight, (0x080893E4+1)

@ Data to define I didn't find in Clib.
SET_DATA gMemorySlot, (0x030004B8)

SET_DATA SupportLevelNameForPopup, (0x0203EFC0)

SET_DATA ActiveUnit, (0x03004E50)

SET_DATA gUnitSubject, (0x02033F3C)

SET_DATA Proc_TI, (0x08A018AC)

SET_DATA SomeTextHandle, (0x0203E7AC)

SET_DATA HelpTextProcCode, (0x08A01650)

SET_DATA gStatScreen, (0x02003BFC)

SET_DATA TileBufferBase, (0x2003C2C)

SET_DATA Tile_Origin, (0x02003C94)

SET_FUNC Bg2_Origin, (0x0200472C)


