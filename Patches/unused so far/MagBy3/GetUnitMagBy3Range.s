.thumb

push {r4,lr}
mov r4, r0
// blh GetUnitMag
ldr r3, GetUnitMag
mov lr, r3
.short 0xF800
mov r1, #0x3
//div r0, r1
swi #0x6
cmp r0, #0x4
bgt HigherThanFour
mov r0, #0x05
HigherThanFour:
ldr r1, =#0x8018A51
bx r1

.ltorg
.align

GetUnitMag:
@POIN GetUnitMag
