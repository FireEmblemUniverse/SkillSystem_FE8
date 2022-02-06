.thumb
@let hp stealing show skill anim
@jumptohack at 80585bc
cmp r1, #0
beq return_nosteal
  ldr r0, [r7]
  mov r1, #0x80
  lsl r1, #7
  and r0, r1
  cmp r0, #0
  beq NoSkillAnim
  
    @ Check which side attacks
    @ Mimics 8058358's if else.
    ldr   r0, [r7]
    lsl   r0, #0x8
    lsr   r0, #0x1B
    mov   r1, #0x8
    and   r0, r1
    lsr   r0, #0x3            @ 1 if Target/Defender is attacking. 0 Otherwise.
    ldr   r1, =0x203E108
    ldrh  r1, [r1]            @ 1 if right side initiated combat.
    cmp   r0, r1
    bne   Right
    @Left:
      mov   r3, r5
      b     L1
    Right:
      mov   r3, r4
    L1:
    
    ldrh r1, [r3]
    mov r0, #0x80
    lsl r0, #4
    orr r0, r1
    strh r0, [r3]

NoSkillAnim:
ldr r0, =0x203e108
mov r3, #0
ldsh r0, [r0, r3]
ldr r5, =0x80585c5
bx r5

return_nosteal:
ldr r3, =0x80586a1
bx r3
