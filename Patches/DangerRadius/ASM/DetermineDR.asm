@ Calls InitializeDR after doing one of four things:
@ if cursor hovers over enemy unit
@   if enemy unit DRbit is set
@     unset DRbit, decrement DRCounter.
@   else
@     set DRbit, increment DRCounter.
@ else
@   if DRCounter > 0
@     unset all DRbits, DRCounter = 0.
@   else if AllDR
@     set all enemy DRbits, DRCounter = # enemies
@   else if NearbyDR
@     set nearby enemy DRbits, DRCounter = # nearby enemies
@   else
@     Return
.thumb
	.equ MemorySlot,0x30004B8
	
push  {r4-r7,r14}
mov   r4, r8
mov   r5, r9
mov   r6, r10
mov   r7, r11
push  {r4-r7}





ldr   r0, =DRUnitByte
lsl   r0, #0x5
lsr   r0, #0x5
mov   r8, r0
ldr   r0, =DRUnitBitMask
lsl   r0, #0x5
lsr   r0, #0x5
mov   r9, r0
ldr   r0, =DRCountByte
lsl   r0, #0x5
lsr   r0, #0x5
mov   r10, r0
ldr   r0, =NonEnemySELECT
lsl   r0, #0x5
lsr   r0, #0x5
mov   r11, r0
ldr   r5, =ChapterData


@ Check for FOW
ldrb  r0, [r5, #0xD]
cmp   r0, #0x0
beq   L1

  @ FOW
  ldr   r4, =DeletePlayerPhaseInterface6Cs
  bl    GOTO_R4
  bl    InitializeDR
  b     L2
L1:


@ Check if unit
ldr   r0, =GameState
mov   r1, #0x16
ldsh  r2, [r0, r1]	              @ gCursorMapPosition Y-coordinate (row)
ldr   r1, =UnitMap
ldr   r1, [r1]
lsl   r2, #0x2
ldr   r1, [r1, r2]
mov   r2, #0x14
ldsh  r0, [r0, r2]	              @ gCursorMapPosition X-coordinate.
ldrb  r0, [r1, r0]                @ Unit's allegiance byte
mov   r5, r0

ldr   r4, =GetUnitStruct
bl    GOTO_R4
cmp   r0, #0x0
beq   L3


  @ Check if enemy
  mov   r1, #0x80
  tst   r1, r5
  beq   L3
  
	VeslyAddedCheck: @ Don't do DR for unit IDs greater or equal to 0xF0
	ldr   r1, [r0] @Unit pointer 
	ldrb  r1, [r1, #4] @Unit ID 
	cmp   r1, #0xF0
	bge   L3
  
    @ Unit is enemy, flip DR bit
    @ and increment/decrement DR counter
    add   r0, r8
    mov   r1, r9
    ldrb  r2, [r0]
    eor   r2, r1
    strb  r2, [r0]
    mov   r0, #0x1
    tst   r2, r1
    bne   L7
      
      @ Clear fog when DR-bit has been unset.
      ldr   r0, =FogMap
      ldr   r0, [r0]
      mov   r1, #0x0
      @ldr   r4, =ClearMapWith @ Is this not blh'd to in InitializeDR ? 
      @bl    GOTO_R4
      mov   r0, #0x1
      neg   r0, r0
      
    L7:
    mov   r1, r10
    ldrb  r2, [r1]
    add   r2, r0
    strb  r2, [r1]
    bl    InitializeDR @ Vesly commented out 
    b     L2

L3:


@ Not hovering over enemy unit.
@ Check DRCountByte
mov   r0, r10
ldrb	r0, [r0]
cmp		r0, #0x0
beq		L4

  @ UnsetAllDR
  bl    UnsetAllDR
  b		  L2
    
L4:

@ Check if NoDR, AllDR or NearbyDR
mov   r0, #0x0
cmp   r0, r11
beq   Return                      @ NoDR

  mov   r0, #0x1
  cmp   r0, r11
  bne   L8

    @ AllDR
    bl    SetAllDR
    b     L2
  
  L8:
  
    @ NearbyDR
    bl    SetNearbyDR
    @b     L2

L2:


@ Sfx
ldr   r1, =ChapterData
mov   r0, #0x41
ldrb  r0, [r1, r0]
mov   r1, #0x40
tst   r0, r1
bne   Return

  mov   r0, #0x68
  ldr   r4, =m4aSongNumStart
  bl    GOTO_R4


Return:
pop   {r4-r7}
mov   r8, r4
mov   r9, r5
mov   r10, r6
mov   r11, r7
pop   {r4-r7}
pop   {r1}
bx    r1
GOTO_R4:
bx    r4
