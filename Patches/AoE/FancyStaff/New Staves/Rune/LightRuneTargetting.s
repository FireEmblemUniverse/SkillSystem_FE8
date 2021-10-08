.equ SetupTargetSelectionForLightRune, 0x80298F0

.macro blh to, reg=r3
	ldr \reg, =\to
	mov lr, \reg
	.short 0xF800
.endm

.thumb

ldr r1, LightRuneStaffRangeSetup
ldr r2, =#0x0000087D @Light Rune / Mine scroll text
mov r0, r5
blh SetupTargetSelectionForLightRune // r0 - ??? r1 - range func r2 - textid
ldr r0, =#0x8029063
bx r0

.ltorg
.align

LightRuneStaffRangeSetup:
@POIN LightRuneStaffRangeSetup
