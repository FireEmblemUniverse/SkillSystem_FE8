
.macro SET_FUNC name, value
    .global \name
    .type   \name, %function
    .set    \name, \value
.endm

@SET_FUNC Unnamed, (0x0802B7EC+1)

SET_FUNC UnnamedUnsetr11, (0x0802AF60 + 1)
