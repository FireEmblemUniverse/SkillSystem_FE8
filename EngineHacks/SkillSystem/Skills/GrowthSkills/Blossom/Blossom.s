.macro blh to, reg=r2
  ldr \reg, \to
  mov lr, \reg
  .short 0xf800
.endm

.equ BlossomID, SkillTester+4
@r4=battle struct or char data ptr, r5 = growth so far (from char data), r6=index in stat booster pointer of growth

.thumb
push {r14}

BlossomCheck:
mov		r0,r4
ldr		r1,BlossomID
blh     SkillTester
cmp		r0,#1
bne		End

BlossomEffect:
lsl r5,#1 @growth x2

End:
pop {r2}
bx r2

.align
.ltorg
SkillTester:
@POIN SkillTester
@WORD BlossomID
