
.include "C://devkitPro/FE-CLib-master/utility/DefinitionMacros.s"

SET_DATA gChapterData, 0x0202BCF0

SET_DATA gActiveUnit, 0x03004E50

SET_DATA gUnitArrayBlue, 0x202BE4C

SET_DATA memcpy, 0x080D1C0C


SET_FUNC HasConvoyAccess, (0x0803161C+1)

SET_FUNC SupplyUsability, (0x08023F64+1)
