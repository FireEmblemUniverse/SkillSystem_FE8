
.macro SET_FUNC name, value
    .global \name
    .type   \name, %function
    .set    \name, \value
.endm

SET_FUNC PrepScreenTextHandler, ( 0x08095024 + 1 )

SET_FUNC PrepScreenHandler, ( 0x08095524 + 1 )
