@hack of 8075ca8 to accept r1=3
@hook at 8075d64
.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

str r2, [sp, #0x4] @original
mov r1, #0x10
mov r8, r1
cmp r0, #2
bne LearnSkill
mov r0, #0xD
ldr r1, =0x8075d6d
bx r1

LearnSkill:
ldr r0, TextID
blh 0x800a240
mov r4, r0
blh 0x8003edc
mov r7, r0
add r7, #0x10
add r0, r7, #7
asr r6, r0, #3
ldr r0, =0x20234a8
lsl r1, r6, #0x10
lsr r1, #0x10
blh 0x8075b78
ldr r5, =0x2017660
mov r0, r5
mov r1, r6
blh 0x8003d5c
lsl r0, r6, #3
sub r0, r7
asr r0, #1
str r0, [sp, #8]
mov r1, r0
mov r0, r5
strb r1, [r0, #2]
ldr r0, =0x8803bd0
ldr r1, =0x6002100
swi #0x12
ldr r0, TextID
blh 0x800a240
mov r4, r0
mov r0, r5
mov r1, #0
strb r1, [r0, #3]
mov r0, r5
mov r1, r4
blh 0x8004004
add r1, r6, #2
lsl r1, #3
mov r0, #0xe0
sub r0, r1
asr r4, r0, #1
neg r1, r4
lsl r1, #0x10
lsr r1, #0x10
ldr r2, =0xffd0
mov r0, #1
blh 0x800148c
mov r0, #2
blh 0x8001fac
blh 0x8003578
mov r0, #0 @palette
mov r1, #0x12
blh 0x80035d4
mov r0, r10

mov r1, #0x01 @ STAN EDIT: bit 15 -> bit 9 (0x0100 | Skill Icon Index), to make it work with Icon Rework
lsl r1, #8

orr r0, r1 @ set bit 9 of hw

mov r1, #0x40
ldr r3, =0x8075eb7
bx r3

.ltorg
TextID:
@WORD textid
