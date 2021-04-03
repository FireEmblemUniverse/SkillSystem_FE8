.thumb
@hook at 802a3f8
@now that the loop is over, rewrite the range map
@r0 = unit, r1 = equipped item
mov r0, r5 @attacker
mov r1, #0x4a
add r1, r0
ldrh r1, [r1] @equipped item and uses before battle
ldr r2, =0x80251b4
mov lr, r2
.short 0xf800

pop {r4-r6}
pop {r0}
bx r0
