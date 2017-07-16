@Rescuing Check
@e90488 to e904b0
.thumb
.org 0
push {lr}
ldr r0,=0x3004e50
ldr r2,[r0]
ldr r1,[r2,#0xc]
mov r0, #0x40 @has not moved...
and r0,r1
cmp r0,#0
bne False

mov r0,#0x10 @and is rescuing
and r1,r0
cmp r1,#0
beq False

@now to check if partner is a tent
ldr r1, =0x8019430
ldrb r0, [r2, #0x1b] @deployment number of partner
mov lr, r1
.short 0xf800 @r0 is partner's ram
ldr r1, [r0, #4] @partner's class
ldrb r2, [r1, #4] @class number
cmp r2, #0x79 @tent
beq False
cmp r2, #0x51 @phantom
beq False

@now to check if partner can stand on the terrain?
mov r2, #56
ldr r2, [r1, r2] @r2 contains movement pointer
@current tile
ldr r3, =0x202e4dc @pointer to terrain map
ldr r3, [r3] @r3 is pointer list of each row location
ldrb r1, [r0, #0x10] @ r1 is partner's x
ldrb r0, [r0, #0x11] @ r0 is partner's y
lsl r0, #2
ldr r3, [r3, r0] @r3 is row
ldrb r3, [r3,r1] @r3 is type of terrain at that tile
ldrb r0, [r2, r3] @cost
cmp r0, #0xFF
beq False

True:
mov r0,#1
b End

False:
mov r0,#3
End:
pop {r1}
bx r1
