.thumb

push  {r4-r6, r14}
sub   sp, #0x4

@ If necessary, decrement FadeInOutByte & BLDY
ldr   r4, =FadeInOutByte
ldrb  r1, [r4]
lsl   r1, #0x18
asr   r1, #0x18
mov   r2, #0x1F
neg   r2, r2

@ BLDY Check
ldr   r5, =gpDISPCNTbuffer
mov   r6, #0x46
ldrb  r3, [r5, r6]            @ BLDY

cmp   r3, #0x0
ble   FadeInOutByteCheck
sub   r3, #0x1
strb  r3, [r5, r6]
cmp   r1, r2
ble   Return
b     UpdateFade

FadeInOutByteCheck:
cmp   r1, r2
ble   BreakLoop
b     UpdateFade


BreakLoop:
ldr   r5, =Break6CLoop
bl    GOTO_R5

@ Clear Palettes
mov   r0, #0x0
str   r0, [sp]
mov   r0, r13
ldr   r1, =palette_buffer
mov   r2, #0x1
lsl   r2, #0x18
mov   r3, #0x10
lsl   r3, #0x4
orr   r2, r3
ldr   r5, =CpuFastSet
bl    GOTO_R5

mov   r1, #0x1

UpdateFade:
sub   r1, #0x2
strb  r1, [r4]

@ PaletteSync
ldr   r5, =EnablePaletteSync
bl    GOTO_R5

Return:
add   sp, #0x4
pop   {r4-r6}
pop   {r0}
bx    r0
GOTO_R5:
bx    r5
