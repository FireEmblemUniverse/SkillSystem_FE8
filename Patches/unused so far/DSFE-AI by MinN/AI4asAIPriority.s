.thumb
.org 0x0
@jumpToHack here from 3993C

//push {r4,r5,r6,r7,lr}   //GetUnitAiAttackPriority
mov r5 ,r0 // unit
ldrh r4, [r5, #0x1e] // first equipment
cmp r4, #0x0
beq UnarmedReturn

ldrb r1, [r5, #0xa]	// recovery mode
mov r0, #0x1
and r0, r1
cmp r0, #0x0
bne RecoveryModeReturn

mov r0, #0x41  // AI4
ldrb r0, [r5, r0]
mov r1, #0xDF   // 0x20 is boss/stationary AI, ignored
and r0, r1
cmp r0, #0
beq Default
b Return

Default:      // if 0/forgot to set: set to 0x20, everything below go first
mov r0, #0x20
b Return

UnarmedReturn:
mov r0, #0xFF // unarmed go last
b Return

RecoveryModeReturn:
mov r0, #0xFE // 0xFE so almost go last

Return:
pop {r4,r5,r6,r7}
pop {r1}
bx r1
