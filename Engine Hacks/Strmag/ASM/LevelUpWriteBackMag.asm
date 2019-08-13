.thumb
.org 0x00
@r4 = Unit
@r5 = Battle Struct

Res:
mov r0, r5
add r0, #0x79 @Res Boost
ldrb r0, [r0]
ldrb r1, [r4, #0x19] @Res
add r0, r1 @Res = Res + Res Boost
strb r0, [r4, #0x19]

Mag:
mov r0, r5
add r0, #0x7A @Mag Boost
ldrb r0, [r0]
mov r3, #0x3A
ldrb r1, [r4, r3]
add r0, r1 @Mag = Mag + Mag Boost
strb r0, [r4, r3]

End:
bx lr

