.thumb
.align

.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.equ ContinueCheckReturnPoint,0x803DA6D
.equ EndCheckReturnPoint, 0x803DAC9
.equ SkillTester,EALiterals+0
.equ ShadePlusID,EALiterals+4


ShadePlusBallista:
@the part the hook overwrites
mov r4,r0
cmp r4,#0
beq RetFalse
ldr r0,[r4]
cmp r0,#0
beq RetFalse

ldr r0,SkillTester
mov r14,r0
mov r0,r4
ldr r1,ShadePlusID
.short 0xF800
cmp r0,#1
beq RetFalse

@no skill or failed condition, continue check
ldr r0,=ContinueCheckReturnPoint
bx r0

RetFalse:
ldr r0,=EndCheckReturnPoint
bx r0

.ltorg
.align

EALiterals:
@POIN SkillTester
@WORD ShadePlusID
