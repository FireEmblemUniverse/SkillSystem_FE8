.thumb
.org 0x0
.equ FrenzyID, SkillTester+4
push  {r14}
mov   r0,r4
ldr   r1,SkillTester
mov   r14,r1
ldr   r1, FrenzyID
.short  0xF800
cmp   r0,#0x0
beq   AddStr
ldrb  r0,[r4,#0x12] @attacker max hp
ldrb  r1,[r4,#0x13] @attacker current hp
sub   r0,r1
lsr   r0,#0x2     @missing hp/4
add   r5,r0
AddStr:
add   r4,#0x5A
mov   r0,#0x14
ldsb  r0,[r6,r0]
add   r5,r0
strh  r5,[r4]
pop   {r0}
bx    r0

.align
SkillTester:
@POIN SkillTester
@WORD FrenzyID
