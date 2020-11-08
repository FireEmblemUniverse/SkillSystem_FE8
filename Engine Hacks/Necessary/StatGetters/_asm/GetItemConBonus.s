.thumb
.align

.global prGetItemConBonus
.type prGetItemConBonus, %function

.equ STAT_CON, 0x7
.macro blh to, reg=r3
	ldr \reg, =\to
	mov lr, \reg
	.short 0xF800
.endm
.equ GetUnitEquippedItem,0x8016B28

prGetItemConBonus:
push {r4-r7,r14}
mov r4,r1 @unit
mov r5,r0 @stat

ldr r3,=GetUnitEquippedItem
mov r14,r3
mov r0,r4
.short 0xF800

mov r1,r0
cmp r1,#0
beq RetFalse
mov r0,#0xFF
and r0,r1
lsl r1,r0,#3
add r1,r1,r0
lsl r1,r1,#2
ldr r0,=ItemTable
add r1,r1,r0
ldr r0,[r1,#0xC]
cmp r0,#0
bne RetStat

RetFalse:
mov r0,#0
b GoBack

RetStat:
ldrb r0,[r0,#0x8]
add r5,r0

GoBack:
mov r1,r4
mov r0,r5

pop {r4-r7}
pop {r1}
bx r1

.ltorg
.align
