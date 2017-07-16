@switch2
.thumb
.org 0
@hook at 1ca9e (bl e19b4 - c4 f0 89 ff)

push {lr}

ldrb r1,[r0,#0xb] @deployment#
ldr r2,SwapMarker
strb r1,[r2]
ldr r1,=0x801865c
mov lr,r1
.short 0xf800

pop {r1}
bx r1

@at 1d158 it checks who the original was
@hook at 1d158, bl e19c8 (c4 f0 36 fc)

.org 0x14
push {r4-r6,lr}

ldr r0,SwapMarker
ldrb r1,[r0] @originally selected unit
ldrb r0,[r4,#0xc] @current unit
cmp r0,r1
beq Normal

@swap if not equal AND 0x40 bit (canto) is not set AND turn not used (202bced = 0)
ldr r0,=0x3004e50
ldr r0,[r0]
ldr r0,[r0,#0xc]
mov r1,#0x40
and r0,r1
cmp r0,#0
bne Normal

ldr r0,=0x202bced
ldrb r0,[r0]
cmp r0,#0
bne Normal

ldr r4,=0x203a958
ldrb r0,[r4,#0xc] @deployment no of char
ldr r5,=0x8019430
mov lr,r5
.short 0xf800
ldrb r1,[r0,#0x1b] @r1 = deployment no of other char
strb r1,[r4,#0xC] @other char is now in front

@set r0 from 0x10 to 0x20
ldr r2,[r0,#0xC]
mov r3,#0x10
eor r2,r3
mov r3,#0x20
orr r3,r2
str r3,[r0,#0xc]

@swap and set from 0x20 to 0x10
mov r0,r1
mov lr,r5
.short 0xf800
ldr r3, [r0,#0xC]
mov r1, #0x20
eor r3,r1
mov r1, #0x10
orr r3,r1
str r3, [r0,#0xc]
@r0 contains chardata, write it to 3004e50
ldr r5,=0x3004e50
str r0,[r5]

Normal:
ldr r0,=0x202bcb0
add r0,#0x3d
pop {r4-r6}
pop {r1}
bx r1

.align
SwapMarker:
.long 0x203f100
