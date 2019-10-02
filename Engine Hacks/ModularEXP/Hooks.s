
.macro SET_FUNC name, value
    .global \name
    .type   \name, %function
    .set    \name, \value
.endm

@SET_FUNC ModularEXP, (0x0802b960+1)

SET_FUNC ModularStaffEXP, (0x0802C688+1)
