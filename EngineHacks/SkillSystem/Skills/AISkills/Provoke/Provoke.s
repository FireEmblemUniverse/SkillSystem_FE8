.thumb
.org 0x0
.equ ProvokeID, SkillTester+4
@jumpToHack here from 3DF78
@r0=30017D8, r1=accuracy/100
ldr   r0,[r0]
ldrb  r0,[r0]       @number of times to attack?
mul   r1,r0
cmp   r1,#0x28
ble   Label1
mov   r1,#0x28
Label1:
mov   r4,r1
ldr   r0,SkillTester
mov   r14,r0
ldr   r0,DefenderStruct
ldr   r1,ProvokeID
.short  0xF800
cmp   r0,#0x0
beq   Label2
mov   r4,#0xFF      @should be high enough to ensure provokedness without overflowing
Label2:
mov   r0,r4
pop   {r4}
pop   {r1}
bx    r1

.align
DefenderStruct:
.long 0x0203A56C
SkillTester:
@ POIN SkillTester
@ WORD ProvokeID
