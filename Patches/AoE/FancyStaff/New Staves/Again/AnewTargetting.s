.equ SetupTargetSelectionForGenericStaff, 0x80295a8

.macro blh to, reg=r3
	ldr \reg, =\to
	mov lr, \reg
	.short 0xF800
.endm

.thumb

ldr r1, AnewStaffRangeSetup
ldr r2, =#0x00000870 @Dance scroll text
mov r0, r5
mov r5, r2
mov r2, r4
blh SetupTargetSelectionForGenericStaff
ldr r0,=#0x8029063
bx r0

.ltorg
.align

AnewStaffRangeSetup:
@POIN AnewStaffRangeSetup
