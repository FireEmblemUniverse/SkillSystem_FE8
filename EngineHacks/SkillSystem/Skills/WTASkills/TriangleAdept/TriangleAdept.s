.thumb

@@jumped to from 2C830
@@r4=attacker, battle struct r5=defender battle struct

@ Now attack struct is passed in via r0 with the defense struct in r1

@ Edited by Snek to fit the WTACalcLoop

.equ TriangleAdeptID, SkillTester+4
.equ TriangleAdeptPlusID, TriangleAdeptID+4


push       {r4-r6,lr}
mov        r4,r0 @ Attack struct
mov        r5,r1 @ Defense struct

@first we see if we have the better version of the skill
ldr        r6,SkillTester
mov        r0,r4
ldr        r1,TriangleAdeptPlusID
mov        r14,r6
.short    0xF800
cmp        r0,#0
bne        SetTriAdeptPlusBonus

ldr        r6,SkillTester
mov        r0,r4
ldr        r1,TriangleAdeptPlusID
mov        r14,r6
.short    0xF800
cmp        r0,#0
beq        CheckTriAdeptAttacker

SetTriAdeptPlusBonus:
mov        r0,#0x53
ldsb    r1,[r4,r0]
lsl        r1,#1
strb    r1,[r4,r0]
mov        r0,#0x54
ldsb    r1,[r4,r0]
lsl        r1,#1
strb    r1,[r4,r0]

mov        r0,#0x53
ldsb    r1,[r5,r0]
lsl        r1,#1
strb    r1,[r5,r0]
mov        r0,#0x54
ldsb    r1,[r5,r0]
lsl        r1,#1
strb    r1,[r5,r0]

b GoBack

.ltorg
.align

CheckTriAdeptAttacker:
ldr        r6,SkillTester
mov        r0,r4
ldr        r1,TriangleAdeptID
mov        r14,r6
.short    0xF800
cmp        r0,#0
beq        CheckTriAdeptDefender

TriAdeptAttackerApply:
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

TriAdeptDefenderApply:
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
.align

SkillTester:
@
