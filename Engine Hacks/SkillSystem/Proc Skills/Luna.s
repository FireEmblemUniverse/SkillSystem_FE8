@pierce check fix
@jumptohack at 2b2a8
.equ SkillTester, PierceID+4
.thumb
push {r2}
mov r0, r2
ldr r1, PierceID
ldr r3, SkillTester
mov lr, r3
.short 0xf800
pop {r2}
cmp r0, #0
beq End
  @unit has the skill
  mov r0, #0x15
  ldrsb r0, [r2,r0]
  mov r1, #0

  @return
  ldr r3, =0x802b2bd
  bx r3


End:
pop {r4-r5}
pop {r0}
bx r0

.ltorg
PierceID:
@WORD PierceID
@POIN SkillTester
