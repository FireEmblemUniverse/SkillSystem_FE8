
.macro SET_FUNC name, value
    .global \name
    .type   \name, %function
    .set    \name, \value
.endm

SET_FUNC GenderedTextWidthHack, (0x08008DDC+1)

SET_FUNC GenderedTextStringHack, (0x08007598+1)
