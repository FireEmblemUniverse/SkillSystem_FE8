.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.equ AetherID, SkillTester+4
.equ d100Result, 0x802a52c
.equ recurse_round, 0x802b83c

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
add r1, #2 @miss @@@@OR BRAVE??????
tst r0, r1
bne End
@if another skill already activated, don't do anything

@check if we're already in aether
ldrb r0, [r2, #4] @active skill
@make sure no other skill is active
ldr r1, AetherID
cmp r0, r1
beq SecondHit
cmp r0, #0
bne End

@check for Aether proc
ldr r0, SkillTester
mov lr, r0
mov r0, r4 @attacker data
ldr r1, AetherID
.short 0xf800
cmp r0, #0
beq End
@if user has Aether, check for proc rate

ldrb r0, [r4, #0x15] @skill/2 stat as activation rate
lsr r0, #1
mov r1, r4 @skill user
blh d100Result
cmp r0, #1
bne End

@if we proc, set the brave effect flag for the NEXT hit
ldrb r1, AetherID @first mark Aether active
strb r1, [r6,#4]
@set the offensive skill flag
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

@and recalculate damage with healing
mov r0, #4
ldrsh r0, [r7, r0]
cmp r0, #0
ble End @0 dmg
mov r1, #5
ldsb r1, [r6, r1] @existing hp change
add r0, r1

@now r0 is total HP change - is this higher than the max HP?
mov r2, #0x13
ldrsb r2, [r4,r2] @curr hp
mov r1, #0x12
ldrsb r1, [r4,r1] @max hp
sub r1, r2 @damage taken
cmp r1, r0
bge NoCap
  @if hp will cap, set r0 to damage taken
  mov r0, r1
NoCap:
strb r0, [r6, #5] @write hp change
mov r2, #0x13
ldrsb r2, [r4,r2] @curr hp
add r0, r2 @new hp
strb r0, [r4, #0x13]

@adding the next round
add     r6, #8 @double width battle buffer   
@ mov     r0, #0x40
@ lsl     r0, #8  
@ str     r0,[r6]                @ 0802B43A 6018  
ldrb r0, AetherID
strb r0, [r6,#4] @save the skill ID at byte #4

@now add the number of rounds - 
mov r1, #0x38
mov r2, sp
ldr r0, [r2,r1] @location of number of rounds on the stack... hopefully
add r0, #1
str r0, [r2,r1]
b End

SecondHit:
//this is the Luna hit.
@recalculate damage with def=0
ldrh r0, [r7, #6] @final mt
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
@WORD AetherID
