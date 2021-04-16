.thumb
.org 0x0
@jumpToHack here from 3E0B8

@ Calculates TP for damage taken
@ TP += (Enemy can counter ? 0 : 2) + (Ranged attack? 0 : 1)

mov r0, #0

ldr r2, =#0x0203A56C
mov r1 ,r2
add r1, #0x48
ldrh r1, [r1, #0x0]
cmp r1, #0x0
bne CanCounter
    mov r0, #0x1
CanCounter:

neg r0 ,r0
End:

pop   {r1}
bx    r1
