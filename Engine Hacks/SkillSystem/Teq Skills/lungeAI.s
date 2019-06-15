@hook at 803a094 with jumptohack

.equ LungeID, SkillTester+4
.thumb

ldr r0, [r6] @r1 = unit data
ldr r1, LungeID
ldr r3, SkillTester
mov lr, r3
.short 0xf800
cmp r0, #0
beq NoLunge

  ldr r0, =0x203f101
  mov r1, #3 @lunge
  strb r1, [r0]

NoLunge:
ldr r1, [r6]
ldrb r0, [r4, #2]
strb r0, [r1, #0x10]
ldr r0, =0x803a09d
bx r0

.ltorg
.align
SkillTester:
@POIN SkillTester
@WORD LungeID
