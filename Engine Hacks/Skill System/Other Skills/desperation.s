.thumb

@desperation: if attacker under 50%hp, do follow up immediately
@hook at 802af0a with NOP+JumpToHack
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.equ DesperationID, SkillTester+4

@check attacker's hp
ldr r3, [sp]
ldrb r0, [r3,#0x12] @max
ldrb r1, [r3, #0x13] @curr
lsr r0, #1
cmp r1, r0
bgt NoDesperation

@now check if attacker has desperation
ldr r0, SkillTester
mov lr, r0
mov r0, r5 @defender data
ldr r1, DesperationID
.short 0xf800
cmp r0, #0
beq NoDesperation

@finally check if attacker doubles
  @ ldr r2, [sp] @attacker data
  @ ldr r3, [sp, #4] @defender data
  @ mov r1, #0x5e
  @ ldsh r0, [r3,r1] @defender AS
  @ cmp r0, #0xfa @snag??
  @ beq NoDesperation
  @ ldsh r1, [r2,r1] @attacker AS
  @ sub r1, r0 @attacker - defender
  @ cmp r1, #3
  @ ble NoDesperation
ldr r0, =0x802af90 @can_double check
mov lr, r0
mov r0, sp
add r1, sp, #4
.short 0xf800
cmp r0, #0
beq NoDesperation

Desperation:
@attacker doubles
ldr r3, [r6]
ldr r2, [r3]
lsl r1, r2, #0xd
lsr r1, #0xd
mov r0, #8
@ mov r0, #40 @attacker skill activated
@ lsl r0, #8
@ add r0, #8 @end battle flag?
orr r1, r0
ldr r5, =0xfff80000
mov r0, r5
and r0, r2
orr r0, r1
str r0, [r3]
@ ldrb r0, =DesperationID
@ strb r0, [r3, #4] @skill animation ID
ldr r0, [sp] @attacker again
ldr r1, [sp, #4] @defender
blh 0x802b018 @battle_oneround
cmp r0, #0
bne EndBattle

@finally the defender goes
ldr r3, [r6]
ldr r2, [r3]
lsl r1, r2, #0xd
lsr r1, #0xd
mov r0, #8
orr r1, r0
ldr r5, =0xfff80000
mov r0, r5
and r0, r2
orr r0, r1
str r0, [r3]
ldr r0, [sp, #4] @defender
ldr r1, [sp] @attacker
blh 0x802b018 @battle_oneround

EndBattle:
ldr r0, =0x802af51
bx r0

NoDesperation:
ldr r3, [r6]
ldr r2, [r3]
lsl r1, r2, #0xd
lsr r1, #0xd
mov r0, #8
orr r1, r0
ldr r5, =0xfff80000
mov r0, r5
and r0, r2
orr r0, r1
str r0, [r3]
ldr r0, =0x802af21
bx r0

.ltorg
SkillTester:
@poin SkillTester
@word DesperationID
