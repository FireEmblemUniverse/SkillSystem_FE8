.thumb
.org 0x0
.equ ProvokeID, SkillTester+4
.equ ShadeID, ProvokeID+4 
@ Hooks function AiBattleGetDamageDealtWeight 0x803DF34
@jumpToHack here from 3DF78

@ vanilla: 
@ if lethal, 50 points 
@ otherwise, (hitrate * dmg / 100) * ai3+0x00 (attacker's expected dmg) 
@ if > 40, set to 40 

@ added: 
@ if lethal, still 50 points 
@ if target has Provoke, expect to deal 2x dmg (max 40 points) 
@ if target has Shade, expect to deal 1/2 dmg (max 40 points) 

@r0=30017D8, r1=(dmg*accuracy)/100
ldr   r0,[r0]
ldrb  r0,[r0]       
mul   r1,r0 @ ai3+00 (attacker's expected dmg) weighting 
mov   r4,r1
ldr   r0,SkillTester
mov   r14,r0
ldr   r0,DefenderStruct
ldr   r1,ProvokeID
.short  0xF800
cmp   r0,#0x0
beq   NoProvoke
lsl r4, #1 @ enemies expect to deal 2x dmg against provoke units 
NoProvoke:
ldr   r0,SkillTester
mov   r14,r0
ldr   r0,DefenderStruct
ldr   r1,ShadeID
.short  0xF800
cmp   r0,#0x0
beq   NoShade
lsr r4, #1 @ enemies expect to deal 1/2 dmg against shade units 
NoShade: 
cmp   r4,#0x28
ble   NoCap
mov   r4,#0x28
NoCap:

mov   r0,r4
pop   {r4}
pop   {r1}
bx    r1
.ltorg 
.align
DefenderStruct:
.long 0x0203A56C
SkillTester:
@ POIN SkillTester
@ WORD ProvokeID
