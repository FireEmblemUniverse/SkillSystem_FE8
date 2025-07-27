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
SET_DATA DangerBonesBuffer, 0x201c8d0 @ gTmA_Banim 

@ 7743's extend SMS past 0xCF uses ram at 0x201f148, which limits us to 0x2878 bytes, which is about the max anyway  
@ Extend SMS past 0xCF patch using SoundRoom Buffer 0201F148
@ by 7743 


@SET_DATA DangerBonesBuffer, 0x20099c8	@ size: 0x3A18+ gBanimOamr2 - b anims free to 200d3e0 B gSortedUnitsBuf
 @ gUnknown_0200A2D8 @ op movie 
 @ gUnknown_0200A300 @ op movie 
 @ gUnknown_0200AF00 @ world map moving map sprite graphics 
 @ gUnknown_0200CB00 @ op movie 
 
 
 