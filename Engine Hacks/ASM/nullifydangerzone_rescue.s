.thumb

Danger_Display:
mov r0,r4
bl Nullify_Check
ldr r2,DangerReturn
cmp r0,#0
bne Danger_Nullified
ldr r0,[r4,#4]
ldrb r1,[r0,#0x12]
ldrb r0,[r4,#0x1d]
add r1,r0
bx r2
Danger_Nullified:
mov r1,#0
bx r2
.align
DangerReturn:
.long 0x801b8a0+1

Nullify_Check:
@r0 has chardata
mov r3, #0x41
ldrb r3, [r0,r3] @AI byte 4
mov r1, #0x30
ldrb r1, [r0,r1]
mov r2, #0xF
and r1,r2     @check status
cmp r3, #0x20 @Guard Tile?
beq True
cmp r1, #0x9  @leg bind?
beq True
ldrb r1, [r0, #0xC]
mov r2, #0x20 @being rescued
and r1, r2
cmp r1, #0
bne True
mov r0,#0
True:
bx lr