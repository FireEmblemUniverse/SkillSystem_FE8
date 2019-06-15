.thumb
.org 0x0
.equ CantoPlusID, SkillTester+4
.equ GaleforceID, CantoPlusID+4
@r0=current character's ability word, r2=current char ptr, r3=current char data, r5=funky struct
@expect r2=action center struct pointer, r4 = current char pointer
push  {r5,r14}
mov   r4,r2
ldr   r5,ActionStruct
ldr   r2,[r3,#0xC]
ldr   r1,BadWord    @0x10044, or Unknown, Moved this turn, and Dead, respectively
tst   r1,r2
bne   RetFalse
mov   r1,#0x2     @move again ability
tst   r0,r1
bne   Mounted

ldr   r0,SkillTester
mov   r14,r0
mov   r0,r3
ldr   r1, CantoPlusID
.short  0xF800
cmp   r0,#0x0
beq   RetFalse
ldrb  r0,[r5,#0x11] @action taken this turn
cmp   r0,#0x3
bgt   RetTrue
cmp   r0,#0x1
bge   RetFalse    @1=wait, 2=combat, 3=staff?
b   RetTrue

Mounted:
ldrb  r0,[r5,#0x11]
cmp   r0,#0x3
bgt   RetTrue
cmp   r0,#0x0
beq   RetTrue
ldr   r0,SkillTester
mov   r14,r0
mov   r0,r3
ldr   r1, CantoPlusID
.short  0xF800
cmp   r0,#0x0
beq   RetFalse

RetTrue:
mov   r0,#0x1
b   GoBack
RetFalse:
mov   r0,#0x0
GoBack:
mov   r2,r5
pop   {r5}
pop   {r1}
bx    r1

.align
ActionStruct:
.long 0x0203A958
BadWord:
.long 0x00010044
SkillTester:
@POIN SkillTester
@WORD CantoPlusID
