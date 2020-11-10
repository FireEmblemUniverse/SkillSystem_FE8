@at 808c530 r5 = unit data
@if 0, it's a dv.
@do... something
@at 808c51c jumpToHack()

.thumb
.include "header.h"
cmp r5, #0
beq Exit

ldrb r0,[r0]
cmp r0, #0
bne Exit
ldr r1, =0x808c526+1
bx r1
Exit:
ldr r1, =0x808c5ba+1
bx r1
