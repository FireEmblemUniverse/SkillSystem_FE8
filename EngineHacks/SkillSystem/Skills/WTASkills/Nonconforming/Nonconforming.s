.thumb

@@jumped to from 2C830
@@r4=attacker, battle struct r5=defender battle struct

@ Now attack struct is passed in via r0 with the defense struct in r1

.equ NonconformingID, SkillTester+4

push       {r4-r6,lr}
mov        r4,r0 @ Attack struct
mov        r5,r1 @ Defense struct

@first we see if we have the better version of the skill
ldr        r6,SkillTester
mov        r0,r4
ldr        r1,NonconformingID
mov        r14,r6
.short    0xF800
cmp        r0,#0
bne        SetTriAdeptPlusBonus

ldr        r6,SkillTester
mov        r0,r5
ldr        r1,NonconformingID
mov        r14,r6
.short    0xF800
cmp        r0,#0
beq        GoBack

SetTriAdeptPlusBonus:
mov        r6,#0        @set to 0 as we'll be subtracting bonuses from this to make them negative

mov        r0,#0x53     @get the weapon triangle hit bonus
ldsb       r1,[r4,r0]   @load the value for the attacker
sub        r1,r6,r1     @subtract it from 0 to make it negative
strb       r1,[r4,r0]   @now store it
mov        r0,#0x54     @get the weapon triangle damage bonus
ldsb       r1,[r4,r0]   @load the value
sub        r1,r6,r1     @subtract it from 0 to make it negative
strb       r1,[r4,r0]   @now store it

mov        r0,#0x53     @do the same as above for the defender this time
ldsb       r1,[r5,r0]
sub        r1,r6,r1
strb       r1,[r5,r0]
mov        r0,#0x54
ldsb       r1,[r5,r0]
sub        r1,r6,r1
strb       r1,[r5,r0]

b GoBack

.ltorg
.align

GoBack:
pop        {r4-r6}
pop        {r0}
bx          r0

.ltorg
.align

SkillTester:
@POIN SkillTester
@WORD NonconformingID
