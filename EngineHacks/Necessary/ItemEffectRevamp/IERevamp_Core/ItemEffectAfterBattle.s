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

.set GetUnit,                      0x08019430
.set GetItemUseEffect,             0x0801773C

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
mov r1, #0x10
@get routine
ldr r3, EffectJumpTable
_blr r3
cmp r0, #0x0
beq skip
@call routine
mov r1,r0
mov r0,r5
_blr r1

skip:
pop {r4-r5}
pop {r0}
bx r0

.align
.ltorg
OffsetList:
