@Flare: Halve enemy resistance (Skill% activation)
@differs from Luna in that it only negates res

.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.equ CoronaID, SkillTester+4
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

@check for Corona proc
ldr r0, SkillTester
mov lr, r0
mov r0, r4 @attacker data
ldr r1, CoronaID
.short 0xf800
cmp r0, #0
beq End
@if user has sure shot, check for proc rate

@check if we are hitting res with our attack
mov r0,r4
add r0,#0x4C
ldr r2,[r0] @r0 = weapon ability word
@is magic weapon: bit 0x00000002
@is magic sword: bit 0x00000040
@either mean we hit res
mov r0,r2
ldr r1,=#0x00000002
and r0,r1
cmp r0,r1
beq ActivateSkill
ldr r1,=0x00000040
and r0,r1
cmp r0,r1
bne End

ActivateSkill:
ldrb r0, [r4, #0x15] @skill stat as activation rate
mov r1, r4 @skill user
blh d100Result
cmp r0, #1
bne End


@if we proc, set the offensive skill flag
ldr     r2,[r6]    
lsl     r1,r2,#0xD                @ 0802B42C 0351     
lsr     r1,r1,#0xD                @ 0802B42E 0B49     
mov     r0, #0x40
lsl     r0, #8           @0x4000, attacker skill activated
orr     r1, r0
ldr     r0,=#0xFFF80000                @ 0802B434 4804     
and     r0,r2                @ 0802B436 4010     
orr     r0,r1                @ 0802B438 4308     
str     r0,[r6]                @ 0802B43A 6018  

ldrb  r0, CoronaID
strb  r0, [r6,#4] 


NegateDefenses:

@if so, recalculate damage with def/2
ldrh r0, [r7, #6] @final mt
ldrh r1, [r7, #8] @enemy def
lsr r1,#1 @/2
sub r0,r1
ldr r2, [r6]
mov r1, #1
tst r1, r2
beq NoCrit
@if crit, multiply by 3
lsl r1, r0, #1
add r0, r1

NoCrit:

cmp r0, #0x7f @damage cap of 127
ble NotCap
mov r0, #0x7f
NotCap:
strh r0, [r7, #4] @final damage

End:
pop {r4-r7}
pop {r15}

.align
.ltorg
SkillTester:
@POIN SkillTester
@WORD CoronaID

