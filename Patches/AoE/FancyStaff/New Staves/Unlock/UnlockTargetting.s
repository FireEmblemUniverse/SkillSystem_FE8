.equ SetupTargetSelectionForLightRune, 0x80298F0

.macro blh to, reg=r3
	ldr \reg, =\to
	mov lr, \reg
	.short 0xF800
.endm

.thumb

ldr r1,StaffRangeSetup
ldr r2, =#0x0000087A @Unlock scroll text
mov r0, r5
mov r5, r2
mov r2, r4
blh SetupTargetSelectionForLightRune
ldr r0,=#0x8029063
bx r0

.ltorg
.align

StaffRangeSetup:
@POIN StaffRangeSetup
