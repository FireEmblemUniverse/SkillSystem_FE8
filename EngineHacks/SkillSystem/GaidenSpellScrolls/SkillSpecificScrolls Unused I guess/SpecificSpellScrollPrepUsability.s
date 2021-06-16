.thumb
.align


ldr r0,EALiterals
mov r14,r0
mov r0,r5
.short 0xF800

pop {r4-r5}
pop {r1}
bx r1

.ltorg
.align

EALiterals:
