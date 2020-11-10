.thumb
.align


.global HealTiles_MapSpriteFunc
.type HealTiles_MapSpriteFunc, %function

.macro blh to, reg=r3
    ldr \reg, =\to
    mov lr, \reg
    .short 0xF800
.endm

.equ CheckEventId,0x8083da8


HealTiles_MapSpriteFunc:
push {r4,r14}
mov r4,r0 @r4 = trap data ptr

ldrb r0,[r4,#0x7]
push {r2}
blh CheckEventId,r1
pop {r2}
cmp r0,#0
bne RetFalse

RetTrue:
mov r0,#1
b GoBack

RetFalse:
mov r0,#0

GoBack:
pop {r4}
pop {r1}
bx r1

.ltorg
.align
