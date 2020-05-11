.thumb

.org 0x2A120 @in FE8 this is at 0x802C76E
Reaver_Calc:
@r0 is the unit with the reaver/weapon in question
@r1 is the other unit

@We know that at least one of these units has at least one of the reaver/nullify effect.

@Check both for nullify effect first.
push {r4-r6}
mov r6, #0x80
lsl r6, #0x2
ldr     r4,[r0,#0x4C]
ldr     r5,[r1,#0x4C]
and r5, r6 @r5 = defender has double
and r4, r6 @r4 = attacker has double
orr r4, r5 @Do either have double?
lsr r4, #0x9 @shove it into the lo bit

ldr     r2,[r0,#0x4C]
lsr     r6,r6,#0x1
and     r2,r6 @r2 = reaver-ness of first weapon

ldr     r3,[r1,#0x4C] @first weapon was a reaver. Second?(for canceling out)
and     r3,r6 @r3 = reaver-ness of second weapon
mov r5, r2
eor     r2,r3 @2 reavers cancel out.
and r5, r3
cmp r5, #0x0
bne return @they were both reavers

@r3, r5, and r6 are open.
@r2 is whether we should apply reaver effect, r4 is whether we should double WTA

mov     r3,#0x53 @weapon triangle hit
ldsb    r5,[r3,r0]
lsl     r5,r5,r4
cmp r2, #0x0 @do we have a reaver
bne reaver_hit
neg r5, r5
reaver_hit:
strb r5, [r1, r3]
neg     r5,r5
strb    r5,[r3, r0]

add r3, #0x1 @now for might bonuses

ldsb    r5,[r3, r0]
lsl     r5,r5,r4
cmp r2, #0x0 @do we have a reaver
bne reaver_might
neg r5, r5
reaver_might:
strb    r5,[r3, r1]
neg     r5,r5
strb    r5,[r3, r0]

return:
pop {r4-r6}
bx      r14

.org 0x2A1CA @in fe8 this is at 0x802C81C
mov r0, r4
mov r1, r5
bl Reaver_Calc
pop {r4-r6}
pop {r0}
bx r0
