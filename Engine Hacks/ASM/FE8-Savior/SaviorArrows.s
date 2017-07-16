.thumb
.equ SkillNumber, SkillTester+4

@r0 has 0xCth word of char struct (includes rescue) and r4,[0xC] has char data. Returns 1 if arrows should be drawn
@SaviorArrows.dmp
push  {r14}
mov   r1,#0x10
and   r0,r1
cmp   r0,#0x0
beq   GoBack
ldr   r0,[r4,#0xC]
@ ldr   r0,[r0,#0x4]
@ ldr   r0,[r0,#0x28]
@ mov   r1,#0x80
@ lsl   r1,r1,#0xF
@ and   r1,r0
ldr r1, SkillTester
mov lr, r1
ldr r1, SkillNumber
.short 0xf800
mov r1, r0

mov   r0,#0x0
cmp   r1,#0x0
bne   GoBack
mov   r0,#0x1
GoBack:
pop   {r1}
bx    r1
.align
.ltorg
SkillTester:
@POIN SkillTester
@WORD SkillNumber
