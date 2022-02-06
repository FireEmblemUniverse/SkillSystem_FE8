.thumb

//fetches the appropriate palette based on unit allegiance and returns to 80885a4

ldr r2,=0x202bcc4
ldrh r0,[r2] @xcoord
ldrh r1,[r2,#2] @ycoord
bl GetUnitFromCoords
cmp r0,#0
bne CheckAlleg
ldr r0,=0x202be44
ldrb r0,[r0]
CheckAlleg:
mov r1,#0xc0
and r1,r0
ldr r0,=0x8088640
ldr r0,[r0]
cmp r1,#0
beq End //if ally, we're done
cmp r1,#0x40
beq NPC
cmp r1,#0x80
beq Enemy
cmp r1,#0xc0
bne End //default to ally (just in case)
add r0,#0x60
b End
NPC:
add r0,#0x40
b End
Enemy:
add r0,#0x20

End:
mov r1, #0xc0
lsl r1,#1
mov r2,#0x80
ldr r3, =0x80885a5
bx r3

GetUnitFromCoords:
@gets deployment number, given r0=x and r1=y
ldr r2,=0x202e4d8 @pointer to unit map
ldr r2,[r2]
lsl r1,#2 @y*4
add r1,r2 @row address
ldr r1,[r1]
ldrb r0,[r1,r0]
bx lr
