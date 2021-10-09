.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

AoE_SpecificEffect:
push {lr}
ldr r2, =#0x0203F101
ldr r3, AoEID
strb r3, [r2]
blh 0x8022b30 @ Copied from combat arts - take/give menu stuff ? 
pop {r1}
bx r1


.ltorg
.align 4

AoEID:
@WORD ID
