.equ IsGeneratedTargetListEmpty, 0x8029068

.macro blh to, reg=r3
	ldr \reg, =\to
	mov lr, \reg
	.short 0xF800
.endm

.thumb

ldr r1, AnewUsabilityFunc
mov r0, r4
mov r2, r5
blh IsGeneratedTargetListEmpty
ldr r1, =#0x8028BFF
bx r1

.ltorg
.align

AnewUsabilityFunc:
@POIN AnewUsabilityFunc
