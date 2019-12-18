.thumb

.macro _blh to, reg=r3
	ldr \reg, =\to
	mov lr, \reg
	.short 0xF800
.endm

.equ StatScreenStruct,             0x02003BFC

.equ ItemRange, OffsetList + 0x0
.equ RangeText, OffsetList + 0x4

@r0 has item id/uses short
push	{r14}
mov 	r1, r0
ldr 	r0, =StatScreenStruct
ldr 	r0, [r0,#0xC]
@ldr 	r3, ItemRange
@bl 	Jumpr3
bl 	GetItemRangeM
@ldr 	r3, RangeText
ldr 	r3, =#MakeRangeText+1
bl 	Jumpr3
pop 	{r3}
Jumpr3:
bx	r3
.align
.ltorg
OffsetList:
