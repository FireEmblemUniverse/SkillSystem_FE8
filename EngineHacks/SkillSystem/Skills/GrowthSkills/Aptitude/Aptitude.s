.macro blh to, reg=r2
  ldr \reg, \to
  mov lr, \reg
  .short 0xf800
.endm

.equ AptitudeID, SkillTester+4
@r4=battle struct or char data ptr, r5 = growth so far (from char data), r6=index in stat booster pointer of growth

.thumb
push {r14}

AptitudeCheck:
mov		r0,r4
ldr		r1,AptitudeID
blh     SkillTester
cmp		r0,#1
bne		End

AptitudeEffect:
add		r5,#20 @growth +20%

End:
pop {r2}
bx r2

.align
.ltorg
SkillTester:
@POIN SkillTester
@WORD AptitudeID
