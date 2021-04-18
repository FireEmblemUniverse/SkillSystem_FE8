.thumb

@ Increment BG1HOFS
ldr   r0, =gpDISPCNTbuffer                @ DISPCNT
mov   r1, #0x24
ldrb  r2, [r0, r1]                        @ BG2HOFS
add   r2, #0x10
strb  r2, [r0, r1]

bx    r14
