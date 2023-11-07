@ Intended to be called as ASMC. Arguments: none.
@ Sets every enemy's Danger Radius.
.thumb

push  {r4-r7,r14}
mov r4, r8 
push {r4} 
ldr r4, =0x1000C @ escaped, undeployed, dead 
mov r8, r4 
ldr   r0, =DRUnitByte
lsl   r0, #0x5
lsr   r5, r0, #0x5
ldr   r0, =DRUnitBitMask
lsl   r0, #0x5
lsr   r6, r0, #0x5


@ Iterate over all enemy units and set DR-bit.
mov   r4, #0x0
mov   r7, #0x81

Loop:
  mov   r0, r7
  ldr   r2, =GetUnitStruct
  bl    GOTO_R2
  cmp   r0, #0x0
  beq   NextIteration

    ldr   r1, [r0]
    cmp   r1, #0x0
    beq   NextIteration

ldrb r1, [r0, #0x13] @ curr hp 
cmp r1, #0 
ble NextIteration 
	
	ldr r1, [r0, #0x0C] 
	mov r2, r8 
	tst r1, r2 
	bne NextIteration 

      @ Set DR-bit and increment DRCounter.
      add   r4, #0x1
      ldrb  r1, [r0, r5]
      orr   r1, r6
      strb  r1, [r0, r5]

  NextIteration:
  add   r7, #0x1
  cmp   r7, #0xBF
  ble   Loop


ldr   r0, =DRCountByte
lsl   r0, #0x5
lsr   r0, #0x5
strb  r4, [r0]            @ Reset DRCountByte.

bl    InitializeDR

pop {r4} 
mov r8, r4 
bl TurnOffBGMFlagIfPeaceful
pop   {r4-r7}
pop   {r0}
bx    r0
GOTO_R2:
bx    r2
