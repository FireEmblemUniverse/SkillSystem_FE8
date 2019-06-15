.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

DisplayLearnedSkill2:
push {r4, lr}
mov r4,r0
mov r0, #0x4e
ldrh r0, [r4, r0]
cmp r0, #0
bne SkillLearned
mov r0, r4
blh 0x8002e94
b EndDLS2
SkillLearned:
  ldrh r0, [r4, #0x2c]
  add r0, #1
  strh r0, [r4, #0x2c]
  lsl r0, #0x10
  asr r0, #0x10
  mov r2, #0x2e
  ldrsh r1, [r4,r2]
  cmp r0, r1
  ble EndDLS2
  ldr r0, [r4, #0x60]
  blh 0x8005004
  blh 0x8055188
  mov r0, r4
  blh 0x8002e94
EndDLS2:
pop {r4}
pop {r0}
bx r0
