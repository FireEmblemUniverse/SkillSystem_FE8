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

@ division & other libgcc functions
SET_FUNC __aeabi_idiv,    __divsi3
SET_FUNC __aeabi_idivmod, __modsi3

SET_DATA classTablePoin, 0x8017AB8 
SET_FUNC PromoHandler_SetInitStat, 0x80cc905 
SET_DATA gBWLDataStorage, 0x203E894
