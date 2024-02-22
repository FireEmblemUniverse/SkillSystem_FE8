.thumb

push  {r4-r5, r14}

mov   r1, #0x4C
ldrb  r2, [r0, r1]
mov r1, #0xFE 
and r2, r1 @ forced to be even number 
mov r1, #0x4C 
add   r2, #0x2
strb  r2, [r0, r1]

ldr   r4, =FadeInOutByte

cmp   r2, #0xFF
blt   FadeIn 

@Break loop
ldr   r5, =Break6CLoop
bl    GOTO_R5
mov   r2, #0x0

FadeIn:
strb  r2, [r4]
ldr   r5, =EnablePaletteSync
bl    GOTO_R5

pop   {r4-r5}
pop   {r0}
bx    r0
GOTO_R5:
bx    r5
