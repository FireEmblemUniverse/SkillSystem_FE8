@ Gets the description of the weapon rank. Mimics 0x88B94 partially.
.thumb

push  {r4}
mov   r4, r0


ldr   r0, [r4, #0x2C]               @ RTextstruct
ldrh  r0, [r0, #0x12]               @ TextID, add to WeaponHelpTextID
add   r0, #0x1
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
blt   L2

  @ Couldn't find weapon. Display WeaponHelpText 0. We shouldn't be able to reach this.
  mov   r2, #0x0
  
L2:
ldr   r1, =WeaponHelpTextIDs
lsl   r2, #0x1
ldrh  r1, [r1, r2]
mov   r0, r4
add   r0, #0x4C
strh  r1, [r0]


pop   {r4}
bx    r14
