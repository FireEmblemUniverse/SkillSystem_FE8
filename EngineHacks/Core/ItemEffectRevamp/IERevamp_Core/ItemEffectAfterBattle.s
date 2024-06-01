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

.set gActionData,                  0x0203A958
.set gActiveBattleUnit,            0x0203A4EC @attacker
.set gTargetBattleUnit,            0x0203A56C @defender

.set GetUnit,                      0x08019430
.set GetItemUseEffect,             0x0801773C

@get the status effect from the target unit struct
@and apply it to the actual unit
.set ApplyItemStatustoTargetUnit,  0x0803001C

.set EffectJumpTable, OffsetList + 0x0

ItemEffectAfterAnim:
push {r4-r5,lr}
mov r5, r0
ldr r4, =gActionData
ldrb r0, [r4,#0xC]
_blh GetUnit
@get current item
ldrb r1, [r4,#0x12]
lsl r1,r1,#0x1
add r1, #0x1E
ldrh r0, [r0,r1]
_blh GetItemUseEffect
cmp r0, #0x0
beq targetunitstatus
mov r1, #0x10
@get routine
ldr r3, EffectJumpTable
_blr r3
cmp r0, #0x0
beq targetunitstatus
@call routine
mov r1,r0
mov r0,r5
_blr r1
b skip

targetunitstatus:
ldr r0, =gTargetBattleUnit
add r0, #0x6F
ldrb r0,[r0]
cmp r0, #0xFF
beq skip
cmp r0, #0x0
beq skip
_blh ApplyItemStatustoTargetUnit

skip:
pop {r4-r5}
pop {r0}
bx r0

.align
.ltorg
OffsetList:
