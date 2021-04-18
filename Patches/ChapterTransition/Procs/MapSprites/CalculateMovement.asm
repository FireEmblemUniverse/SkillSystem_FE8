@ Calculates unit's movement based on multiple factors
@ Returns: movement
.thumb

@ Calculate movement
mov   r0, r11
lsl   r1, r0, #0x6
lsl   r2, r0, #0x3
add   r1, r2                    @ Multiply index by #0x48
add   r1, #0x4
ldr   r2, =gUnitArray
ldr   r1, [r2, r1]

@ Increase X based on unit's 'type'
ldrb  r2, [r1, #0x7]            @ Movement Speed, indicates unit has armour
mov   r3, #0x28
ldrb  r3, [r1, r3]
lsl   r3, #0x1F
lsr   r3, #0x1F                 @ Mounted Aid Calc, indicates unit has a mount
lsl   r3, #0x1
orr   r2, r3

cmp   r2, #0x2
bne   NextGroup1
mov   r3, #0x3                  @ Mounted, move 3
b     Return

NextGroup1:
cmp   r2, #0x1
bne   NextGroup2
mov   r3, #0x1                  @ Armoured infantry, move 1
b     Return

NextGroup2:
mov   r3, #0x2                  @ Infantry/Armoured + mounted/Anything else, move 2

Return:
mov   r0, r3
bx    r14
