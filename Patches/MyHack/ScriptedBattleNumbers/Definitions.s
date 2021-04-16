
.macro SET_FUNC name, value
    .global \name
    .type   \name, %function
    .set    \name, \value
.endm

SET_FUNC SetScriptedNumbers, ( 0x080120C0 + 1 )
