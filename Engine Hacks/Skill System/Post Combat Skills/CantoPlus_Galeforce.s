.thumb
.org 0x0
.equ CantoPlusID, SkillTester+4
.equ CantoID, CantoPlusID+4
.equ GaleforceID, CantoID+4
.equ LifetakerID, GaleforceID+4
.equ SavageBlowID, LifetakerID+4
.equ AuraSkillCheck, SavageBlowID+4
@r0=current character's ability word, r2=current char ptr, r3=current char data, r5=funky struct
@expect r2=action center struct pointer, r4 = current char pointer
push  {r5-r7,r14}
mov   r4,r2
mov   r6, r0 @save character/class abilities
mov   r7, r3 @save character data
ldr   r5,ActionStruct
ldr   r2,[r3,#0xC]
ldr   r1,BadWord    @0x10444, or Unknown, Moved this turn, and Dead, respectively
tst   r1,r2
bne   RetFalse

@check for Savage Blow
@check if attacking unit died
mov r2, r7
ldrb r2, [r2, #0x13] @currenthp
cmp r2, #0
beq LifetakerCheck

ldr r0, SkillTester
mov r14, r0
mov r0, r7 @attacker
ldr r1, SavageBlowID
.short 0xF800
cmp r0, #0
beq LifetakerCheck
@Check if there are enemies in 2 spaces
ldr r0, AuraSkillCheck
mov lr, r0
mov r0, r3 @attacker
mov r1, #0
mov r2, #3 @are_enemies
mov r3, #2 @range
.short 0xf800
cmp r0, #0
beq LifetakerCheck
@if not 0 let's go through the buffer in r1
bl SavageBlowDamage

LifetakerCheck:
@check for LifetakerID
ldr r0, SkillTester
mov r14, r0
mov r0, r7 @attacker
ldr r1, LifetakerID
.short 0xF800
cmp r0, #0
beq Continue

@check if attacked this turn
ldrb  r0,[r5,#0x11] @action taken this turn
cmp   r0,#0x2 @attack
bne CheckCantoPlus
@check if killed enemy
ldr r0, =0x203a56c @defender
ldrb r0, [r0, #0x13] @currhp
cmp r0, #0
bne CheckCantoPlus @no galeforce here

@killed enemy, then heal 50%hp
ldrb r1, [r7, #0x12] @r1=maxhp
lsr r2, r1, #1 @r2=maxhp/2
ldrb r0, [r7, #0x13] @r0 = currhp
add r2,r0 @total healing
cmp r2, r1 @is the new hp higher than max?
ble StoreHP
mov r2, r1
StoreHP:
strb r2, [r7, #0x13]

Continue:
@check for galeforce
ldr r0, SkillTester
mov r14, r0
mov r0, r7 @attacker
ldr r1, GaleforceID
.short 0xF800
cmp r0, #0
beq CheckCantoPlus

@check if attacked this turn
ldrb  r0,[r5,#0x11] @action taken this turn
cmp   r0,#0x2 @attack
bne CheckCantoPlus
@check if killed enemy
ldr r0, =0x203a56c @defender
ldrb r0, [r0, #0x13] @currhp
cmp r0, #0
bne CheckCantoPlus

@if killed enemy, unset 0x2, set 0x4, write to status
ldr r0, [r7, #0xC] @status bitfield
mov r1, #2
mvn r1, r1
and r0, r1 @unset bit 0x2
mov r1, #4 @has moved already
lsl r1, #8
orr r0, r1
str r0, [r7, #0xC]
b RetFalse

CheckCantoPlus:
ldr   r0,SkillTester
mov   r14,r0
mov   r0,r7
ldr   r1, CantoPlusID
.short  0xF800
cmp   r0,#0x0
bne HasCantoPlus @with canto+, move after attacking/other actions

ldr   r0,SkillTester
mov   r14,r0
mov   r0,r7
ldr   r1, CantoID
.short  0xF800
cmp   r0,#0x0 @with canto, move after non-attacks
beq   RetFalse
ldrb  r0,[r5,#0x11] @action taken this turn
cmp   r0,#0x3
bgt   RetTrue
cmp   r0,#0x1
bge   RetFalse    @1=wait, 2=combat, 3=staff?
b   RetTrue

HasCantoPlus:
ldrb  r0,[r5,#0x11]
cmp   r0,#0x3
bgt   RetTrue
cmp   r0,#0x0
beq   RetTrue
ldr   r0,SkillTester
mov   r14,r0
mov   r0,r7
ldr   r1, CantoPlusID
.short  0xF800
cmp   r0,#0x0
beq   RetFalse

RetTrue:
mov   r0,#0x1
b   GoBack
RetFalse:
mov   r0,#0x0
GoBack:
mov   r2,r5
pop   {r5-r7}
pop   {r1}
bx    r1

.align
.ltorg

SavageBlowDamage:
push {r4-r7,lr}
mov r4, r0 @number of units
mov r5, r1 @start of buffer
mov r6, #0 @counter

Savage_loop:
ldrb r0, [r5,r6]
ldr r2, =0x8019430
mov lr, r2
.short 0xf800
@r0 is ram data
mov r7, r0
ldrb r0, [r7, #0x12] @max hp
mov r1, #5
swi #0x6    @r0 max hp/5
ldrb r1, [r7, #0x13] @r1 = current hp
sub r1, r0
cmp r1, #0
bgt NextLoop
mov r1, #1 @min of 1 hp
NextLoop:
strb r1, [r7, #0x13]
add r6, #1
cmp r6, r4
blt Savage_loop

pop {r4-r7,pc}

.align
.ltorg
ActionStruct:
.long 0x0203A958
BadWord:
.long 0x00010444
SkillTester:
@POIN SkillTester
@WORD CantoPlusID
@WORD CantoID
@WORD GaleforceID
@WORD LifetakerID
@WORD SavageBlowID
@POIN AuraSkillCheck
