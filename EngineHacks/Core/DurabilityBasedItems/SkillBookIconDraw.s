.thumb
.align

.global CheckIfSkillBookIcon
.type CheckIfSkillBookIcon, %function

.global CheckIfSkillBookIcon_Prep1
.type CheckIfSkillBookIcon_Prep1, %function

.global CheckIfSkillBookIcon_Prep2
.type CheckIfSkillBookIcon_Prep2, %function

.global CheckIfSkillBookIcon_Sell
.type CheckIfSkillBookIcon_Sell, %function

.global CheckIfSkillBookIcon_Use
.type CheckIfSkillBookIcon_Use, %function

.global CheckIfSkillBookIcon_Generic
.type CheckIfSkillBookIcon_Generic, %function

.global CheckIfSkillBookIcon_DropItem
.type CheckIfSkillBookIcon_DropItem, %function


.equ ReturnPoint,0x8016ADD

CheckIfSkillBookIcon: @hook at 16AD4

@rewriting as to make modular

mov r0,r9
mov r1,#0xFF
and r0,r1

ldr r2,=DurabilityBasedItemIconList

Loop1Start:
ldrb r1,[r2]
cmp r1,#0
beq IsItemIcon
cmp r0,r1
beq Loop1Exit
add r2,#2
b Loop1Start

Loop1Exit:

@get icon based on durability of item; item halfword is in r9

mov r1,r9
lsr r1,r1,#8

ldrb r2,[r2,#1]
lsl r2,r2,#8 		@shifted 8 bits left
orr r1,r2

b SkipForReturn1

IsItemIcon:

ldrb r1,[r6,#0x1D]

SkipForReturn1:
mov r2,#0x80
lsl r2,r2,#7
mov r0,r7

ldr r3,=ReturnPoint
bx r3

.ltorg
.align


.equ ReturnPoint2,0x809A03D

CheckIfSkillBookIcon_Prep1: @hook at 9a034
@r5 = item halfword

mov r3,r0
mov r0,r5
mov r1,#0xFF
and r0,r1

ldr r2,=DurabilityBasedItemIconList

Loop2Start:
ldrb r1,[r2]
cmp r1,#0
beq IsItemIcon_1
cmp r0,r1
beq Loop2Exit
add r2,#2
b Loop2Start

Loop2Exit:

@get icon based on durability of item; item halfword is in r6
mov r1,r5
lsr r1,r1,#8

ldrb r2,[r2,#1]
lsl r2,r2,#8 		@shifted 8 bits left
orr r1,r2
b SkipForReturn2
IsItemIcon_1:
mov r1,r3

SkipForReturn2:
mov r0,r10
mov r2,#0x80
lsl r2,r2,#7

ldr r3,=ReturnPoint2
bx r3

.ltorg
.align


.equ ReturnPoint3,0x809B803

CheckIfSkillBookIcon_Prep2: @hook at 9B7F4
@r6 = item halfword


mov r0,r6
mov r1,#0xFF
and r0,r1

ldr r2,=DurabilityBasedItemIconList

Loop3Start:
ldrb r1,[r2]
cmp r1,#0
beq IsItemIcon_2
cmp r0,r1
beq Loop3Exit
add r2,#2
b Loop3Start

Loop3Exit:

@get icon based on durability of item; item halfword is in r6
mov r1,r6
lsr r1,r1,#8

ldrb r2,[r2,#1]
lsl r2,r2,#8 		@shifted 8 bits left
orr r1,r2
b SkipLine3

IsItemIcon_2:
mov r0,r6
mov r1,#0xFF
and r0,r1
mov r1,#36
mul r0,r1
ldr r1,=ItemTable
add r0,r1
ldrb r1,[r0,#0x1D]

SkipLine3:

mov r0,r8
mov r2,#0x80
lsl r2,r2,#7

ldr r3,=ReturnPoint3
bx r3

.ltorg
.align


.equ ReturnPoint4,0x80168D1

CheckIfSkillBookIcon_Sell: @hook at 168C8
@item halfword in r6

mov r0,r6
mov r1,#0xFF
and r0,r1

ldr r2,=DurabilityBasedItemIconList

Loop4Start:
ldrb r1,[r2]
cmp r1,#0
beq IsItemIcon_3
cmp r0,r1
beq Loop4Exit
add r2,#2
b Loop4Start

Loop4Exit:

@get icon based on durability of item; item halfword is in r6
mov r1,r6
lsr r1,r1,#8

ldrb r2,[r2,#1]
lsl r2,r2,#8 		@shifted 8 bits left
orr r1,r2
b SkipLine4

IsItemIcon_3:
mov r0,r6
mov r1,#0xFF
and r0,r1
mov r1,#36
mul r0,r1
ldr r1,=ItemTable
add r0,r1
ldrb r1,[r0,#0x1D]

SkipLine4:
mov r2,#0x80
lsl r2,r2,#7
mov r0,r7

ldr r3,=ReturnPoint4
bx r3

.ltorg
.align


.equ ReturnPoint5,0x809CD5D

CheckIfSkillBookIcon_Use: @hook at 9CD54

mov r3,r0 @item icon ID

ldr r0,[sp,#0x28] @item
mov r1,#0xFF
and r0,r1

ldr r2,=DurabilityBasedItemIconList

Loop5Start:
ldrb r1,[r2]
cmp r1,#0
beq VanillaIcon_Use
cmp r0,r1
beq Loop5Exit
add r2,#2
b Loop5Start

Loop5Exit:

ldr r0,[sp,#0x28] @item
mov r1,#0xFF
lsl r1,r1,#8
and r0,r1
lsr r0,r0,#8 @r0 = durability

ldrb r2,[r2,#1]
lsl r1,r2,#8 @shifted 8 bits left
orr r0,r1
mov r1,r0
b FinishFunc_Use

VanillaIcon_Use:
mov r1,r3

FinishFunc_Use:
mov r2,#0x80
lsl r2,r2,#7
mov r0,r4

ldr r3,=ReturnPoint5
bx r3

.ltorg
.align




CheckIfSkillBookIcon_Generic:
push {r4,r14}
mov r4,r0 @r4 = item halfword

@is the item on the list?
mov r0,r4
mov r1,#0xFF
and r0,r1

ldr r2,=DurabilityBasedItemIconList

Loop6Start:
ldrb r1,[r2]
cmp r1,#0
beq DoVanillaIconThing
cmp r0,r1
beq Loop6Exit
add r2,#2
b Loop6Start

Loop6Exit:

@get durability
mov r0,r4
lsr r0,r0,#8

ldrb r1,[r2,#1]
lsl r1,r1,#8
orr r0,r1

@r0 = icon ID
b GenericGoBack

.ltorg
.align

DoVanillaIconThing:
@get icon from item table
mov r0,r4
cmp r0,#0
beq RetNegOne
mov r1,#0xFF
and r0,r1
mov r1,#36
mul r0,r1
ldr r1,=ItemTable
add r0,r1
ldrb r0,[r0,#0x1D]
b GenericGoBack

RetNegOne:
sub r0,#1

GenericGoBack:
pop {r4}
pop {r1}
bx r1

.ltorg
.align


.equ DropItemReturnPoint,0x8016A1D

CheckIfSkillBookIcon_DropItem:
mov r0,r6
mov r1,#0xFF
and r0,r1
ldr r2,=DurabilityBasedItemIconList

DropItemLoopStart:
ldrb r1,[r2]
cmp r1,#0
beq DropItemUseItemIcon
cmp r0,r1
beq DropItemLoopExit
add r2,#2
b DropItemLoopStart

DropItemLoopExit:
@icon is durability | r2+1 <<8
@item halfword in r6
mov r0,r6
lsr r0,r0,#8
ldrb r1,[r2,#1]
lsl r1,r1,#8
orr r1,r0
b DropItemGoBack

DropItemUseItemIcon:
ldrb r1,[r5,#0x1D]

DropItemGoBack:
mov r2,#0x80
lsl r2,r2,#7
mov r0,r7
ldr r3,=DropItemReturnPoint
bx r3

.ltorg
.align

