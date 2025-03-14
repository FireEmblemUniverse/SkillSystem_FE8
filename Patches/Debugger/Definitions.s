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

SET_DATA pPromoJidLut, 0x80cc7d0 
SET_DATA Pal_SpinningArrow, 0x8a1a084 
SET_DATA PrepItemSuppyTexts, 0x2013648
SET_FUNC SetBlendConfig, 0x8001ea1
SET_DATA gProcScr_TerrainDisplay, 0x8a018ac
SET_DATA sTilesetConfig, 0x2030b8c
SET_FUNC __aeabi_idiv,    __divsi3
SET_FUNC Div, __divsi3
SET_FUNC Mod, __modsi3
SET_FUNC GetSoloAnimPreconfType, 0x802ca71
SET_DATA gEfxHpLutOff, 0x203e152
SET_DATA gEkrGaugeDmg, 0x203e1bc
SET_DATA gProcScr_efxHPBar, 0x8052354
SET_DATA gProcScr_efxHPBarResire, 0x8052624
SET_DATA classTablePoin, 0x8017AB8 
SET_DATA gBanimExpGain, 0x203e1c8
