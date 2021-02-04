@Vengeance: Add half damage taken to damage dealt. (Skill % activation)

.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.equ VengeanceID, SkillTester+4
.equ d100Result, 0x802a52c
.equ GetUnit, 0x8019431
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

@check for Vengeance proc
ldr r0, SkillTester
mov lr, r0
mov r0, r4 @attacker data
ldr r1, VengeanceID
.short 0xf800
cmp r0, #0
beq End
@if user has skill, check for proc rate

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

ldrb  r0, VengeanceID
strb  r0, [r6,#4] 

@get HP before battle
ldrb r0,[r4,#0x0B] @deployment byte
ldr r1,=GetUnit
mov r14,r1
.short 0xF800
ldrb r0,[r0,#0x13] @current HP before battle
ldrb r1,[r4,#0x13] @current HP during battle
sub r0,r1 @r0=difference in HP
lsr r0,#1 @r0=difference in HP/2
mov r1,r4
add r1,#0x5A
ldrb r2,[r1]
add r2,r0 @add half damage taken to attack
cmp r2,#0x7f @damage cap of 127
ble NotCap
mov r0, #0x7f
NotCap:
strb r2,[r1] @final damage


End:
pop {r4-r7}
pop {r15}

.align
.ltorg
SkillTester:
@POIN SkillTester
@WORD VengeanceID

