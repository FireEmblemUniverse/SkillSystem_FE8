.thumb
.align


.global Synchronize
.type Synchronize, %function

.equ SetUnitNewStatus,0x80178D8
.equ ReturnPoint,0x802C221
.equ AttackerUnit,0x203a4ec
.equ DefenderUnit,0x203a56c

Synchronize: @r3 hook at 2C214
@status ID in r0, unit in r4, attacker or defender ptr in r5

@if the unit here is the attacker 
@  if the attacker has Synchronize
@    if the attacker has a status to write back
@      if the defender does not have a status to write back
@        set defender status to write back to attacker's status
@  if the defender has Synchronize
@    if the defender has a status to write back
@      if the attacker does not already have a status to write back
@        set attacker status to write back to defender's status

push {r4-r7}
mov r6,r0

ldr r1,=AttackerUnit
cmp r1,r5
bne VanillaStatusApplyCheck

@does the attacker have Synchronize?
ldr r0,=SkillTester
mov r14,r0
mov r0,r4
ldr r1,=SynchronizeIDLink
ldrb r1,[r1]
.short 0xF800
cmp r0,#0
beq CheckDefender

@does attacker have status to write back?
cmp r6,#0
blt CheckDefender

@does defender have status to write back?
ldr r1,=DefenderUnit
add r1,#0x6F
ldrb r0,[r1]
cmp r0,#0
bne CheckDefender

@set defender status to attacker status
strb r6,[r1]
b SynchChecksEnd

CheckDefender:
@does defender have Synchronize?
ldr r0,=SkillTester
mov r14,r0
ldr r0,=DefenderUnit
ldr r1,=SynchronizeIDLink
ldrb r1,[r1]
.short 0xF800
cmp r0,#0
beq SynchChecksEnd

@does defender have status to write back?
ldr r1,=DefenderUnit
add r1,#0x6F
ldrb r0,[r1]
cmp r0,#0
blt SynchChecksEnd

@does attacker have status to write back?
cmp r6,#0
bge SynchChecksEnd

@write defender status to attacker
mov r6,r0

SynchChecksEnd:
mov r0,r6

VanillaStatusApplyCheck:
cmp r0,#0
ble GoBack

mov r1,r0
ldr r0,=SetUnitNewStatus
mov r14,r0
mov r0,r4
.short 0xF800

GoBack:
pop {r4-r7}
ldr r0,=ReturnPoint
bx r0

.ltorg
.align
