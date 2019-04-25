.thumb

@jumped to from 2C830
@r4=attacker, battle struct r5=defender battle struct

.equ TriangleAdeptID, SkillTester+4

and        r0,r6
cmp        r0,#0
beq        CheckTriAdeptAttacker
mov        r0,r4
mov        r1,r5
ldr        r3,=#0x802C76C        @applies reaver bonuses
mov        r14,r3
.short    0xF800
CheckTriAdeptAttacker:
ldr        r6,SkillTester
mov        r0,r4
ldr        r1,TriangleAdeptID
mov        r14,r6
.short    0xF800
cmp        r0,#0
beq        CheckTriAdeptDefender
mov        r0,#0x53
ldsb    r1,[r4,r0]
lsl        r1,#1
strb    r1,[r4,r0]
mov        r0,#0x54
ldsb    r1,[r4,r0]
lsl        r1,#1
strb    r1,[r4,r0]
CheckTriAdeptDefender:
mov        r0,r5
ldr        r1,TriangleAdeptID
mov        r14,r6
.short    0xF800
cmp        r0,#0
beq        GoBack
mov        r0,#0x53
ldsb    r1,[r5,r0]
lsl        r1,#1
strb    r1,[r5,r0]
mov        r0,#0x54
ldsb    r1,[r5,r0]
lsl        r1,#1
strb    r1,[r5,r0]
GoBack:
pop        {r4-r6}
pop        {r0}
bx        r0

.ltorg
SkillTester:
@
