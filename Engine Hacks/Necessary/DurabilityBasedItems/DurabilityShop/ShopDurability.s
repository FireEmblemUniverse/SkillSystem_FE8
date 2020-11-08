.thumb
.align

.global NewShopMakeItem
.type NewShopMakeItem, %function

NewShopMakeItem:
push {r4,r14} 
mov r4,r0 @r4 = item halfword 

@is the durability half of this 0?
mov r0,r4
lsr r0,r0,#8
cmp r0,#0
beq GetNormalDurability

@it's not so we can just take the full thing that was passed in and add it
mov r0,r4
b GoBack

.ltorg
.align

GetNormalDurability:
mov r0,r4
mov r1,#0xFF
and r0,r1
mov r1,#36
mul r0,r1
ldr r1,=ItemTable
add r2,r0,r1
ldr r1,[r2,#8]
mov r0,#8
and r1,r0
mov r0,#0xFF
cmp r1,#0
bne IsUnbreakable
ldrb r0,[r2,#0x14]
b AddDurability

IsUnbreakable:
mov r0,#0

AddDurability:
lsl r1,r0,#8
mov r0,r4
mov r2,#0xFF
and r0,r2
orr r0,r1

GoBack:
pop {r4}
pop {r1}
bx r1

.ltorg
.align



.global NewGetItemCost
.type NewGetItemCost, %function


NewGetItemCost:
push {r4-r5,r14}
mov r4,r0 @r4 = item halfword

@return (cost per use * current durability)
@get cost per use first

mov r0,r4
mov r1,#0xFF
and r0,r1
mov r1,#36
mul r0,r1
ldr r1,=ItemTable
add r3,r0,r1
ldrh r0,[r3,#0x1A]
mov r5,r0 @r5 = cost per use

@is the ID of this item on the list of items that ignore durability?
ldr r2,=FixedPriceItemList
mov r0,r4
mov r1,#0xFF
and r0,r1

LoopStart:
ldrb r1,[r2]
cmp r1,#0
beq GetAdjustedPrice
cmp r0,r1
beq LoopExit 

LoopRestart:
add r2,#1
b LoopStart

LoopExit:
@we are on the list, so just return cost per use
mov r0,r5
b Cost_GoBack

.ltorg
.align

GetAdjustedPrice:
@check if unsellable flag is set
ldr r0,[r3,#0x8]
mov r1,#8
and r0,r1
cmp r0,#0
beq DoNormalCostPerUse @equal if flag is not set
mov r0,r5
b Cost_GoBack

.ltorg
.align

@multiply durability & cost per use
DoNormalCostPerUse:
mov r0,r4
lsr r0,r0,#8
mov r1,r5
mul r0,r1

Cost_GoBack:
pop {r4-r5}
pop {r1}
bx r1

.ltorg
.align
