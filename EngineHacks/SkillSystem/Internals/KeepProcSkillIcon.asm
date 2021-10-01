@ This splits the buffer used for the HP bar when it's decrementing
@ into two, both parts missing the last four tiles
@ (0x19C through 0x19F and 0x1BC through 0x1BF), which won't be
@ overwritten anymore. This prevents procced skill icons from clearing.
@   r0: 0x2016E48
.thumb

ldr   r1, =0x6013000
ldr   r2, =0x380
ldr   r5, =RegisterTileGraphics
bl    GOTO_R5

ldr   r0, =0x2017248
ldr   r1, =0x6013400
ldr   r2, =0x380
bl    GOTO_R5


ldr   r5, =0x80518EF
GOTO_R5:
bx    r5
