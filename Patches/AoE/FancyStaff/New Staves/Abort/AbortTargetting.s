.macro blh to, reg=r3
	ldr \reg, =\to
	mov lr, \reg
	.short 0xF800
.endm

.thumb

mov r0, r5

// blh SetUpAbortTargetSelection
ldr r3, SetUpAbortTargetSelection
mov lr, r3
.short 0xF800

ldr r0,=#0x8029063
bx r0

.ltorg
.align

SetUpAbortTargetSelection:
@POIN SetUpAbortTargetSelection
