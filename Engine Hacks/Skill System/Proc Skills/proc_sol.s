.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.equ SolID, SkillTester+4
.equ d100Result, 0x802a52c
@ r0 is attacker, r1 is defender, r2 is current buffer, r3 is battle data
push {r4-r7,lr}
mov r4, r0 @attacker
mov r5, r1 @defender
mov r6, r2 @battle buffer
mov r7, r3 @battle data
ldr     r0,[r2]           @r0 = battle buffer                @ 0802B40A 6800     
lsl     r0,r0,#0xD                @ 0802B40C 0340     
lsr     r0,r0,#0xD        @Without damage data                @ 0802B40E 0B40     
mov r1, #0xC0 @skill flag
lsl r1, #8 @0xC000
add r1, #2 @miss
tst r0, r1
bne End
@if another skill already activated, don't do anything

@check for Sol proc
ldr r0, SkillTester
mov lr, r0
mov r0, r4 @attacker data
ldr r1, SolID
.short 0xf800
cmp r0, #0
beq End
@if user has sure shot, check for proc rate

ldrb r0, [r4, #0x15] @skill stat as activation rate
mov r1, r4 @skill user
blh d100Result
cmp r0, #1
bne End

@if we proc, set the offensive skill flag
ldr     r2,[r6]    
lsl     r1,r2,#0xD                @ 0802B42C 0351     
lsr     r1,r1,#0xD                @ 0802B42E 0B49     
mov     r0, #0x41
lsl     r0, #8           @0x4100, attacker skill activated and hp draining
orr     r1, r0
ldr     r0,=#0xFFF80000                @ 0802B434 4804     
and     r0,r2                @ 0802B436 4010     
orr     r0,r1                @ 0802B438 4308     
str     r0,[r6]                @ 0802B43A 6018  

ldrb  r0, SolID
strb  r0, [r6,#4] 

@and recalculate damage with healing
mov r0, #4
ldrsh r0, [r7, r0]
mov r1, #5
ldsb r1, [r6, r1] @existing hp change
add r0, r1

@cap/floors are handled elsewhere already so ignore this
@@now r0 is total HP change - is this higher than the max HP?
@mov r2, #0x13
@ldrsb r2, [r4,r2] @curr hp
@mov r1, #0x12
@ldrsb r1, [r4,r1] @max hp
@sub r1, r2 @damage taken
@cmp r1, r0
@bge NoCap
@@if hp will cap, set r0 to damage taken
@mov r0, r1
@NoCap:

strb r0, [r6, #5] @write hp change
mov r2, #0x13
ldrsb r2, [r4,r2] @curr hp
add r0, r2 @new hp
strb r0, [r4, #0x13]

End:
pop {r4-r7}
pop {r15}

.align
.ltorg
SkillTester:
@POIN SkillTester
@WORD SolID
