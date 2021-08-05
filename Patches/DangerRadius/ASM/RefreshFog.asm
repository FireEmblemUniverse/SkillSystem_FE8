@ Replaces RefreshFogAndUnitMaps.
@ Args:
@   r0: bool: If true, refresh fog. If false, don't.
.thumb

push  {r4-r7, r14}
add   r5, r0, #0x1


ldr   r4, =ClearMapWith
ldr   r6, =litpool
mov   r7, #0x0

Loop:
  lsl   r0, r7, #0x2
  ldr   r0, [r6, r0]
  ldr   r0, [r0]
  mov   r1, #0x0
  bl    GOTO_R4
  add   r7, #0x1
  cmp   r7, r5
  ble   Loop

ldr   r4, =UpdateTrapFogVision
bl    GOTO_R4
ldr   r4, =UpdateUnitMapAndVision
bl    GOTO_R4
ldr   r4, =UpdateTrapHiddenStates
bl    GOTO_R4


pop   {r4-r7}
pop   {r0}
bx    r0
GOTO_R4:
bx    r4

.align
litpool:
.word UnitMap
.word HiddenMap
.word FogMap
