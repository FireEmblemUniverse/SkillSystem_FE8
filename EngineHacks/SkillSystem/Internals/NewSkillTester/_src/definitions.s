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

@ division & other libgcc functions
SET_FUNC __aeabi_idiv,    __divsi3
SET_FUNC __aeabi_idivmod, __modsi3

SET_FUNC sub_8004B0C, 0x8004B0D

SET_FUNC AreUnitsAllied, 0x08024D8D
SET_FUNC IsSameAllegiance, 0x08024DA5
SET_FUNC GetPidStats, 0x080A4CFD
