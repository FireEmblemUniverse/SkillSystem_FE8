@ Determines whether to display RText, or to move to next item. Mimics 0x88B94 and 0x88C14 partially.
.thumb

push  {r4-r5, r14}
mov   r5, r0


ldr   r0, [r5, #0x2C]               @ RTextstruct
ldrh  r4, [r0, #0x12]               @ TextID, Indicates which weapon rank we are
add   r0, r4, #0x1
ldr   r1, =StatScreenStruct
ldr   r1, [r1, #0xC]                @ Pointer to Unit RAM of current unit
add   r1, #0x28                     @ Weapon ranks
mov   r2, #0x0

Loop:
  ldrb  r3, [r1, r2]
  cmp   r3, #0x0
  beq   L1
    
    @ Unit has rank in weapon
    sub   r0, #0x1
    cmp   r0, #0x0
    ble   Break                     @ Current weapon rank found
  
  L1:
  add   r2, #0x1
  cmp   r2, #0x8
  blt   Loop
  
Break:
cmp   r2, #0x8
blt   Return                        @ Weapon rank exists, display RText

  @ Weapon rank doesn't exist, move to next entry
  mov   r0, r5
  add   r0, #0x50
  ldrh  r0, [r0]                    @ Last pressed key?
  
  @ CheckRight
  mov   r1, #0x10
  tst   r1, r0
  beq   CheckLeft
    ldr   r4, =MoveCursorRight
    b     L2
      CheckLeft:
      mov   r1, #0x20
      tst   r1, r0
      beq   CheckUp
        ldr   r4, =MoveCursorLeft
        b     L2
          CheckUp:
          mov   r1, #0x40
          tst   r1, r0
          beq   Down
            ldr   r4, =MoveCursorUp
            b     L2
              Down:
              ldr   r4, =MoveCursorDown
L2:
mov   r0, r5
bl    GOTO_R4


Return:
pop   {r4-r5}
pop   {r0}
bx    r0
GOTO_R4:
bx    r4
