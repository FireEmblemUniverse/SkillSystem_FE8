.thumb
.equ SkillNumber, SkillTester+4
.equ RetEquipped, 0x8016b28
.equ SkillBonus, 0x8016450
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
@SaviorSkl.dmp
@replaceWithHack at 80191D0
push  {r4,r5,r14}
mov   r4,r0
blh    RetEquipped   @given char data, returns equipped item/uses
blh    SkillBonus    @given item, returns skill bonus
mov   r1,#0x15
ldsb  r1,[r4,r1]  @skl stat in r1, skl bonus in r0
ldr   r2,[r4,#0xC]  
mov   r3,#0x10
and   r2,r3
cmp   r2,#0x0   
beq   End1      @not rescuing
@ ldr   r2,[r4,#0x4]
@ ldr   r2,[r2,#0x28] @load class abilities
@ mov   r3,#0x80
@ lsl   r3,r3,#0xF
@ and   r3,r2
push {r0,r1}
mov r0, r4
ldr r1, SkillTester
mov lr, r1
ldr r1, SkillNumber
.short 0xf800
mov r3, r0
pop {r0,r1}
cmp   r3,#0x0
bne   End1
lsr   r2,r1,#0x1F
add   r1,r1,r2
asr   r1,r1,#0x1
End1:
add   r0,r0,r1
pop   {r4,r5} 
pop   {r1}
bx    r1
.align
.ltorg
SkillTester:
@POIN SkillTester
@WORD SkillNumber
