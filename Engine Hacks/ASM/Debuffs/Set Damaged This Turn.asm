.thumb

@In installer, set 2B54E to jump here.
mov     r1,#0x4
ldsh    r0,[r4,r1]        @r4 = battle stats data? Damage to be dealt
cmp     r0,#0x0
beq     noDamage
mov     r1,r6
add     r1,#0x7C          @Has dealt damage this turn.
ldrb r2, [r1]
mov     r0,#0x1
orr r2, r0
strb    r2,[r1]
noDamage:
pop     {r3-r5}
mov     r8,r3
mov     r9,r4
mov     r10,r5
pop     {r4-r7}
pop     {r0}
bx      r0
