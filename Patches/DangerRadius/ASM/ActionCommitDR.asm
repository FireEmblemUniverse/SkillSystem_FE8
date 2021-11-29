@ Recalc DR when committing to an action.
@ Hooked at 0x1D380
.thumb

.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
	.equ EventEngine, 0x800D07C

push  {r4, r14}



ldrb  r1, [r1, #0xF]
ldr   r4, =MoveActiveUnit
bl    GOTO_R4




@ Recalc DR if it's active.
ldr   r0, =DRCountByte
lsl   r0, #0x5
lsr   r0, #0x5
ldrb  r0, [r0]
cmp   r0, #0x0
beq   L1



bl SetNearbyDR
bl RefreshUnitASMC
b     Return

L1:

bl RefreshUnitWithoutFogASMC

ldr   r4, =UpdateGameTilesGraphics
bl    GOTO_R4




Return:

pop   {r4}
pop   {r0}
bx    r0
GOTO_R4:
bx    r4
