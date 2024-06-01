.thumb

.macro _blh to, reg=r3
	ldr \reg, =\to
	mov lr, \reg
	.short 0xF800
.endm

.macro _blr reg
	mov lr, \reg
	.short 0xF800
.endm

.set gActionData,                 0x0203A958

.set Roll1RN,                     0x8000CA0
.set SetUnitNewStatus,            0x80178D8
.set SetUnitStatus,               0x80178F4
.set GetUnit,                     0x08019430
.set GetTargetListSize,           0x0804FD28
.set GetTarget,                   0x0804FD34
.set GetStaffAccuracy,            0x0802CCDC

.set NightmareTargetCondition, 0x8025EFC

.equ ItemRangeBuilder, OffsetList + 0x0
.equ GetItemStatus, OffsetList + 0x4

push {r4-r7,lr}
add sp,#-0x4
@get active unit
ldr r4, =gActionData
ldrb r0, [r4,#0xC]
_blh GetUnit
mov r7, r0
ldrb r2, [r4,#0x12]
lsl r2,r2,#0x1
add r2, #0x1E
ldrh r2, [r7,r2]
str r2, [sp]

@call range builder
ldr r1, =NightmareTargetCondition
ldr r3, ItemRangeBuilder
_blr r3

_blh GetTargetListSize
mov r6, r0
mov r5, #0x0
cmp r5, r6
bge NoMoreTargets
TargetLoop:
mov r0, r5
_blh GetTarget
ldrb r0,[r0,#0x2]
_blh GetUnit
mov r4, r0
mov r0, r7
mov r1, r4
_blh GetStaffAccuracy
_blh Roll1RN
cmp r0, #0x1
bne NextTarget
@check if target already has a status effect
mov r0, r4
add r0, #0x30
ldrb r1,[r0]
mov r0, #0xF
and r0, r1
cmp r0, #0x0
bne NextTarget

@apply status effect to target
ldr r0, [sp]
ldr r3, GetItemStatus
_blr r3
mov r1, #0xF
and r1, r0
asr r2, r0, #0x4
mov r0,r4
_blh SetUnitStatus

NextTarget:
add r5, #0x1
cmp r5,r6
blt TargetLoop
NoMoreTargets:
add sp, #0x4
pop {r4-r7}
pop {r0}
bx r0
.align
.ltorg

OffsetList:
