.thumb
.equ SkillNumber, SkillTester+4
@The savior checker for the stat screen. Paste into free space
.org 0x0
@r0 has check rescue result (0 for no rescuee), r2 has char data pointer. This function returns the stat's value in r1.
@SaviorCheck.dmp
push  {r3,r14}
ldr   r2,[r5,#0xC]  @load char struct in ram
cmp   r0,#0x0
beq   NoRescue
@ ldr   r3,[r2,#0x4]  @load class data
@ ldr   r3,[r3,#0x28] @class abilities
@ mov   r0,#0x80
@ lsl   r0,r0,#0xF
@ and   r0,r3
ldr r0, SkillTester
mov lr, r0
mov r0, r2
ldr r1, SkillNumber
.short 0xf800
cmp   r0,#0x0
bne   NoRescue    @has savior, so no penalties
lsl   r0,r1,#0x18
asr   r1,r0,#0x18
lsr   r0,r0,#0x1F
add   r1,r1,r0
lsr   r1,r1,#0x1
NoRescue:
pop   {r3}
pop   {r0}
bx    r0
.align
.ltorg
SkillTester:
@POIN SkillTester
@WORD SkillNumber
