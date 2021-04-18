@ Lessens mosaic and makes chapter title more visible.
.thumb

push  {r4-r7, r14}

ldr   r1, =gpDISPCNTbuffer
mov   r2, #0x38
ldrb  r3, [r1, r2]                  @ Mosaic
mov   r4, #0x44
ldrb  r5, [r1, r4]                  @ AhlphaBLD EVA
mov   r6, #0x45
ldrb  r7, [r1, r6]                  @ AhlphaBLD EVB

@ Mosaic Check
cmp   r3, #0x0
ble   CheckBLD
sub   r3, #0x10
strb  r3, [r1, r2]
cmp   r7, #0x0
ble   Return
b     UpdateBlend

CheckBLD:
cmp   r7, #0x0
ble   BreakLoop
b     UpdateBlend

BreakLoop:
ldr   r5, =Break6CLoop
bl    GOTO_R5

@ Disable blend
mov   r0, #0x0
mov   r1, #0x0
mov   r2, #0x0
mov   r3, #0x0
ldr   r5, =SetSpecialColourEffectsParam
bl    GOTO_R5

@ Disable Mosaic
mov   r0, #0x40
mvn   r0, r0
ldr   r1, =gpDISPCNTbuffer
ldrb  r2, [r1, #0xC]
and   r2, r0
strb  r2, [r1, #0xC]
b     Return

UpdateBlend:
add   r5, #0x1
strb  r5, [r1, r4]                  @ AhlphaBLD EVA
sub   r7, #0x1
strb  r7, [r1, r6]                  @ AhlphaBLD EVB


Return:
pop   {r4-r7}
pop   {r0}
bx    r0
GOTO_R5:
bx    r5
