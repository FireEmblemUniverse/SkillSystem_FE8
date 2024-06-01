@ Doesn't clear Char & Class name so we avoid left screen blinking.
@ Bit of a patchwork solution.
.thumb
.equ Text_Init, 0x8003D5D
.equ TextParams, 0x2028E70

push  {r14}


ldr   r0, =0x08A006FC       @InitTextBatch1
bl    InitTextBatchA


pop   {r0}
bx    r0
GOTO_R5:
bx    r5


@ Mimics InitTextBatch, 0x08003DAC
InitTextBatchA:
push  {r4-r5,r14}
mov   r4, r0


mov   r5, #0x0
b     L1
Loop:
  ldr   r0, [r4]
  ldrb  r1, [r4, #0x4]
  bl    Text_InitA
  add   r4, #0x8
  L1:
  ldr   r0, [r4]
  cmp   r0, #0x0
  beq   Return
    add   r5, #0x1
    cmp   r5, #0x2
    ble   Loop

ldr   r5, =Text_Init
b     L2
Loop2:
  ldr   r0, [r4]
  ldrb  r1, [r4, #0x4]
  bl    GOTO_R5
  add   r4, #0x8
  L2:
  ldr   r0, [r4]
  cmp   r0, #0x0
  bne   Loop2


Return:
pop   {r4-r5}
pop   {r0}
bx    r0


@ Mimics Text_Init, 0x08003D5C, but doesn't call the TextVRAMClearer.
Text_InitA:
push  {r4}


ldr   r2, =TextParams
ldr   r4, [r2]
ldrh  r3, [r4, #0x12]
mov   r2, #0x0
strh  r3, [r0]
strb  r1, [r0, #0x4]
strb  r2, [r0, #0x6]
strb  r2, [r0, #0x5]
strb  r2, [r0, #0x7]
ldrh  r2, [r4, #0x12]
add   r2, r2, r1
strh  r2, [r4, #0x12]


pop   {r4}
bx    r14
