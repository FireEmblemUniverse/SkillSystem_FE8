
.macro SET_FUNC name, value
    .global \name
    .type   \name, %function
    .set    \name, \value
.endm

SET_FUNC CHAR_ASM_Hack, ( 0x0808390C + 1 )
