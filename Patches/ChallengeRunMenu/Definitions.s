.include "fe8.s" 

.macro SET_FUNC name, value
	.global \name
	.type   \name, function
	.set    \name, \value
.endm

.macro SET_DATA name, value
	.global \name
	.type   \name, object
	.set    \name, \value
.endm

SET_FUNC Div, 0x80D167D
SET_FUNC DivArm, 0x80D1681
SET_FUNC Mod, 0x80D1685

@ division & other libgcc functions
SET_FUNC __aeabi_idiv,    __divsi3
SET_FUNC __aeabi_idivmod, __modsi3

SET_DATA TacticianName, 0x202bd10
SET_DATA classTablePoin, 0x8017AB8 

