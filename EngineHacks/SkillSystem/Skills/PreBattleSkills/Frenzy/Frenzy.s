.thumb	@ Edited by Snek because of Str/Mag Split conflict. Moved to Pre-Battle Calc Loop.
.org 0x0
.equ FrenzyID, SkillTester+4
push  {r4,r14} @ r0 = battle struct
mov   r0,r4
ldr   r1, FrenzyID
ldr   r2,SkillTester
mov   r14,r2
.short  0xF800
cmp   r0,#0x0
beq   NoAddAtk
ldrb  r0,[r4,#0x12] @attacker max hp
ldrb  r1,[r4,#0x13] @attacker current hp
sub   r0,r1
lsr   r0,#0x2     @missing hp/4
mov   r2,#0x5A
ldrh  r1,[r4,r2]
add   r1,r0,r1
strh  r1,[r4,r2]
NoAddAtk:
pop   {r4}
pop   {r0}
bx    r0

.align
SkillTester:
@POIN SkillTester
@WORD FrenzyID
