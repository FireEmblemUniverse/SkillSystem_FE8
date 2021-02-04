.thumb
.org 0x00000000

Dangerzone_Hook: @paste to $801cad8
ldrh r1,[r2,#0x8]
mov r0,#0xC
and r0,r1
cmp r0,#0x0
beq End
ldr r0,Jump_to
b GOTO_R0
End:
ldr r0,End_at
b GOTO_R0

.align
Jump_to:
.long 0x08E90191

.align
End_at:
.long 0x0801CB39

GOTO_R0:
bx r0
