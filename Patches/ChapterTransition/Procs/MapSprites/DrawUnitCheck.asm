@ Checks whether unit should be drawn or not. Arguments:
@ - r0 = pointer to unit's struct in gUnitArray (which starts at 0x0202BE4C)
@ Returns 1 if unit should be drawn, 0 otherwise.
.thumb

mov   r1, r0
mov   r0, #0x0

@ Check class data pointer
ldr   r2, [r1, #0x4]            @ Class data
cmp   r2, #0x0
beq   Return                    @ If no class data, don't draw

@ Check whether unit is alive
ldr  r2, [r1, #0xC]
mov r3, #0x40
lsl r3, #8
mov r0, #0xC
add r3, r3, r0
mov r0, #1 
lsl r0, #16 
add r3, r0 @ 1400c 
mov r0, #0
@mov   r3, #0x1400C @dead, undeployed, solo animation1, escaped - don't draw
and   r2, r3
cmp   r2, #0x0
bne   Return                    @ Unit is dead, don't draw

mov   r0, #0x1
Return:
bx    r14
