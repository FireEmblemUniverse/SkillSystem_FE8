.thumb
.org 0x0
.equ addExtraOption, 0x80AB888
.macro blh to, reg=r3
ldr \reg, =\to
mov lr, \reg
.short 0xF800
.endm
AddCreditOptions:
mov r0, r4
mov r1, #0x20
blh addExtraOption

