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
SET_DATA sCGDataTable, 0x80b65F0 
@SET_FUNC DisplayCGfx, 0x80B65F9

SET_FUNC CopyBgImage, 0x800b911 
SET_FUNC CopyBgTiles, 0x800b955 
SET_FUNC CopyBgPalette, 0x800b995 
SET_FUNC BgChangeChr, 0x800b9b9 


