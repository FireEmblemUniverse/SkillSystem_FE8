.macro blh to, reg
    ldr \reg, =\to
    mov lr, \reg
    .short 0xF800
.endm


push {r14}

mov r4,r0 @r4 = character pointer
mov r5,r1 @r5 = item halfword
mov r6,r2 @r6 = rank

ldr r0,[r4]
ldrb r0,[r0,#4]
blh BloodGetter,r1
cmp r0,#0
beq RetTrue





RetFalse:


RetTrue:
mov r0,#1



.ltorg
.align
BloodGetter:
@POIN BloodGetter
