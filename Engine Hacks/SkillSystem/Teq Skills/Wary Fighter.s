.thumb
.equ origin, 0x2AF90
.equ Get_Weapon_Effect, . + 0x17724 - origin
.equ WaryFighterID, SkillTester+4

@.org 0x2AF90
@r0,r1 are stack pointers that will contain attacker and defender struct
@returns a bool for can double
push  {r4-r7,r14}
mov   r4,r0
mov   r7,r1
ldr   r5,SkillTester
mov   r14,r5
ldr   r6,DefenderStruct
mov   r0,r6
ldr   r1,WaryFighterID
.short  0xF800
cmp   r0,#0x0 @does the defender have wary fighter?
bne   RetFalse
mov   r14,r5
ldr   r5,AttackerStruct
mov   r0,r5
ldr   r1,WaryFighterID
.short  0xF800
cmp   r0,#0x0 @does the attacker?
bne   RetFalse
mov   r3,#0x5E
ldsh  r2,[r6,r3]    @defender's AS
cmp   r2,#0xFA
bgt   RetFalse    @something about snags, possibly. Or just IntSys being IntSys.
ldsh  r3,[r5,r3]    @attacker's AS
sub   r1,r3,r2    @Attacker-defender
cmp   r1,#0x0
ble   DefDoubAtk
cmp   r1,#0x3
ble   RetFalse
str   r5,[r4]
str   r6,[r7]
b   Label1
DefDoubAtk:
sub   r1,r2,r3
cmp   r1,#0x3
ble   RetFalse
str   r6,[r4]
str   r5,[r7]
Label1:
ldr   r0,[r4]
add   r0,#0x4A
ldrh  r0,[r0]
bl    Get_Weapon_Effect
cmp   r0,#0x3
beq   RetFalse      @can't double with Eclipse weapons (unless they're brave, but why would you do that?)
cmp   r0, #0xC
beq   RetFalse      @also can't double if weapon effect is 0xC
ldr   r0,[r4]
add   r0,#0x48
ldrb  r0,[r0]
cmp   r0,#0xB5
beq   RetFalse      @Stone can't double
mov   r0,#0x1
b   GoBack
RetFalse:
mov   r0,#0x0
GoBack:
pop   {r4-r7}
pop   {r1}
bx    r1

.align
DefenderStruct:
.long 0x0203A56C
AttackerStruct:
.long 0x0203A4EC
SkillTester:
@POIN SkillTester
@WORD WaryFighterID
