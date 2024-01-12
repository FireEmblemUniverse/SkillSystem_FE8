@ Run on phase switch. Clears DR.
@ Executed right before
@ MapMain_SwitchPhases, 0x15410
.thumb

push  {r4-r7, r14}
mov   r4, r8
mov   r5, r9
mov   r6, r10
mov   r7, r11
push  {r4-r7}
mov   r10, r0
mov   r11, r1

ldr r3, =FreeMoveRam
ldr r3, [r3] 
ldrb r0, [r3] 
ldr r1, =FreeMove_Running
ldrb r1, [r1] 
ldr r2, =FreeMove_Silent
ldrb r2, [r2] 
orr r1, r2 
tst r0, r1 
bne Return


@ Check for FOW.
ldr   r0, =ChapterData
ldrb  r0, [r0, #0xD]
cmp   r0, #0x0
bne   Return

  @ Are we on playerphase?
  ldr   r0, =ChapterData
  ldrb  r0, [r0, #0xF]
  cmp   r0, #0x0
  bne   Return
  
    @ Is DR active?
    ldr   r0, =DRCountByte
    lsl   r0, #0x5
    lsr   r0, #0x5
    ldrb  r1, [r0]
    cmp   r1, #0x0
    beq   Return


@ Clear DR
mov   r1, #0x0
strb  r1, [r0]

@ Iterate over all enemy units and unset DR-bit.
ldr   r4, =GetUnitStruct
mov   r6, #0x81
ldr   r0, =DRUnitByte
lsl   r0, #0x5
lsr   r7, r0, #0x5
ldr   r0, =DRUnitBitMask
lsl   r0, #0x5
lsr   r0, #0x5
mov   r8, r0

Loop:
  mov   r0, r6
  ldr   r4, =GetUnitStruct
  bl    GOTO_R4
  cmp   r0, #0x0
  beq   NextIteration

    ldr    r1, [r0]
    cmp    r1, #0x0
    beq    NextIteration

      ldrb  r1, [r0, r7]
      mov   r2, r8
      bic   r1, r2
      strb  r1, [r0, r7]

  NextIteration:
  add    r6, #0x1
  cmp    r6, #0xBF
  ble    Loop

ldr   r0, =FogMap
ldr   r0, [r0]
mov   r1, #0x0
ldr   r4, =ClearMapWith
bl    GOTO_R4
ldr   r4, =UpdateGameTilesGraphics
bl    GOTO_R4


Return:
mov   r0, r10
mov   r1, r11
pop   {r4-r7}
mov   r8, r4
mov   r9, r5
mov   r10, r6
mov   r11, r7
pop   {r4-r7}
ldr   r2, =0x8015413
bx    r2
GOTO_R4:
bx    r4
