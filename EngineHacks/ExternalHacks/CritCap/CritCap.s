.thumb

@called from 2ACA4
mov     r5, r2
add     r5, #0x6A
mov     r4, #0x0

@Check if crit is greater than 100
cmp r1, #100
blt End
mov     r1, #100 @Make crit 100 if it's greater than 100
End:
strh    r1, [r5]
ldr     r3,=#0x802ACAC|1
bx r3

.align
.ltorg
