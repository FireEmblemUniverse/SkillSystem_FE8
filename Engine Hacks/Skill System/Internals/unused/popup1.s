.thumb

.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

DisplayLearnedSkill:
push {r4, lr}
mov r4,r0
mov r2, #0x4e
ldrh r2, [r4, r2]
cmp r2, #0
beq NoSkillLearned
  mov r1, #3
  blh 0x8075ca8
  blh 0x8075b58
  mov r0, #0
  strh r0, [r4, #0x2c]
  mov r0, #0x60
  strh r0, [r4, #0x2e]
NoSkillLearned:
mov r0, r4
blh 0x8002e94
pop {r4}
pop {r0}
bx r0
