.thumb
.align

.global prGetItemMovBonus
.type prGetItemMovBonus, %function

.equ STAT_MOV, 0x8

prGetItemMovBonus:
push {r14}
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

GoBack:
pop {r1}
bx r1

.ltorg
.align
