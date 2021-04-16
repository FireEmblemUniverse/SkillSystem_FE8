
.macro SET_FUNC name, value
    .global \name
    .type   \name, %function
    .set    \name, \value
.endm

SET_FUNC HPBarNormal1, (0x08050F5C+1)

SET_FUNC HPBarNormal2, (0x08050FA0+1)

SET_FUNC HPBarFlash, (0x080545F8+1)

SET_FUNC BeingStruckHPBar, (0x080544A4+1)

SET_FUNC FinishedDepletionHPBar, (0x0805452C+1)

SET_FUNC FixHPFlash, (0x080546B0+1)
