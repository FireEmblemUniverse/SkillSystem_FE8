.thumb
.align

.global ScrollDurabilityGetter
.type ScrollDurabilityGetter, %function

.global ScrollDurabilityGetter_StatScreen
.type ScrollDurabilityGetter_StatScreen, %function

.global ScrollDurabilityGetter_UnitMenu
.type ScrollDurabilityGetter_UnitMenu, %function

.global ScrollDurabilityGetter_DropItem
.type ScrollDurabilityGetter_DropItem, %function


ScrollDurabilityGetter: @hook at 17594


add r0,r0,r1
ldr r0,[r0,#8]
mov r1,#8
and r0,r1
cmp r0,#0
bne RetUnbreakable

mov r0,r2
mov r1,#0xFF
and r0,r1


ldr r3,=DurabilityItemList

DurabilityLoop1Start:
ldrb r1,[r3]
cmp r1,#0
beq RetActualDurability
cmp r0,r1
beq DurabilityLoop1Succeed
add r3,#1
b DurabilityLoop1Start

DurabilityLoop1Succeed:
mov r0,#1
b GoBack

RetActualDurability:
asr r0,r2,#8
b GoBack

.ltorg
.align


RetUnbreakable:
mov r0,#0xFF

GoBack:
pop {r1}
bx r1

.ltorg
.align


@8016A8E

.equ ReturnPoint1,0x8016AA1

ScrollDurabilityGetter_StatScreen: @hook at 16A8C
ldr r0,[r6,#8]
mov r5,#8
and r0,r5
mov r3,r9
asr r2,r3,#8
cmp r0,#0
bne RetUnusable

@r3 = item ID
lsl r3,r3,#24
lsr r3,r3,#24 @clear uses
ldr r2,=DurabilityItemList

DurabilityLoop2Start:
ldrb r0,[r2]
cmp r0,#0
beq RetDurability
cmp r0,r3
beq Exit2Success
add r2,#1
b DurabilityLoop2Start

Exit2Success:
mov r2,#1
b ContinueFunc

RetDurability:
mov r2,r9
lsr r2,r2,#8
b ContinueFunc

RetUnusable:
mov r2,#0xFF

ContinueFunc:

mov r0,r1
mov r1,r4

ldr r3,=ReturnPoint1
bx r3

.ltorg
.align


.equ ReturnPoint2,0x80168B5

ScrollDurabilityGetter_UnitMenu: @hook at 16894
mov r3,r7
add r3,#0x16
mov r5,#1
mov r0,r8
cmp r0,#0
beq SkipOneLine
mov r5,#2

SkipOneLine:
ldr r0,[r4,#8]
mov r1,#8
and r0,r1
asr r2,r6,#8
cmp r0,#0
bne UnBr

mov r2,r6
lsl r2,r2,#24
lsr r2,r2,#24 @just item ID

ldr r1,=DurabilityItemList

DurabilityLoop3Start:
ldrb r0,[r1]
cmp r0,#0
beq Dura
cmp r0,r2
beq ExitLoop3
add r1,#1
b DurabilityLoop3Start

ExitLoop3:
mov r2,#1
b ContFunc

Dura:
asr r2,r6,#8
b ContFunc

UnBr:
mov r2,#0xFF

ContFunc:
mov r0,r3
mov r1,r5

ldr r3,=ReturnPoint2
bx r3

.ltorg
.align



.equ DropItemReturnPoint, 0x8016A01

ScrollDurabilityGetter_DropItem: @r0 hook @ 169F0

@check if unbreakable
ldr r0,[r5,#8]
mov r1,#8
and r0,r1
cmp r0,#0
bne ItemIsUnbreakable4

@check if durability should be fixed to 1
ldr r2,=DurabilityItemList
mov r0,r6
mov r1,#0xFF
and r0,r1

DropLoopStart:
ldrb r1,[r2]
cmp r1,#0
beq DropItemUseNormalDurability
cmp r0,r1
beq DropLoopExit
add r2,#1
b DropLoopStart

DropLoopExit:
mov r2,#1
b DropItem_GoBack

DropItemUseNormalDurability:
lsr r2,r6,#8
b DropItem_GoBack

ItemIsUnbreakable4:
mov r2,#0xFF

DropItem_GoBack:
mov r0,r8
ldr r1,=DropItemReturnPoint
bx r1

.ltorg
.align


