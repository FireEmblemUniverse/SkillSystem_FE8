.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.equ d100Result, 0x802a52c
@ r0 is attacker, r1 is defender, r2 is current buffer, r3 is battle data
push {r4-r7,lr}
mov r4, r0 @attacker
mov r5, r1 @defender
mov r6, r2 @battle buffer
mov r7, r3 @battle data

ldrb r0, [r5, #0xb] @don't activate against players
cmp r0, #0x40
blt End

ldr     r0,[r2]           @r0 = battle buffer                @ 0802B40A 6800     
lsl     r0,r0,#0xD                @ 0802B40C 0340     
lsr     r0,r0,#0xD        @Without damage data                @ 0802B40E 0B40     
mov	r1,#0x82 @miss + devil
and	r0,r1
cmp	r0,#2
beq	End
cmp	r0,#0x80
beq	End

ldrh r0, [r7, #4] @final dmg
lsl r0, #0x10
asr r0, #0x10

ldrb r1, [r5, #0x13] @defender hp
cmp r0, r1
blt End @if it's not gonna kill

@check defender for boss flag
ldr r0, [r5] 
add r0, #0x29
ldrb r0, [r0] @ability 2
mov r1, #0x80 @is boss?
and r0, r1
cmp r0, #0
beq End @not a boss

@if we kill, set the crit flag
ldr     r2,[r6]    
lsl     r1,r2,#0xD                @ 0802B42C 0351     
lsr     r1,r1,#0xD                @ 0802B42E 0B49     

@set crit flag
ldr     r2,[r6]    
lsl     r1,r2,#0xD                @ 0802B42C 0351     
lsr     r1,r1,#0xD                @ 0802B42E 0B49     
mov r0, #1
orr r1, r0
ldr     r0,=#0x7FFFF                @ 0802B516 4815     
and     r1,r0                @ 0802B518 4001
ldr     r0,=#0xFFF80000                @ 0802B434 4804     
and     r0,r2                @ 0802B436 4010     
orr     r0,r1                @ 0802B438 4308     
str     r0,[r6]                @ 0802B43A 6018 

End:
pop {r4-r7}
pop {r15}

.align
.ltorg
SkillTester:
@POIN SkillTester
@WORD ImpaleID
