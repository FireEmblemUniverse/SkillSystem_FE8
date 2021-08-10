.thumb
.align

.global GetShopTextID
.type GetShopTextID, %function

.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.equ ReturnPoint,0x80B417F


GetShopTextID:
mov r5,r1

@so right now, r4 contains some text ID
@based on what this ID is, we want to get a text ID from a table indexed by shop type (byte at [r5,#0x61])

@0x896 - checking from prep screen
@0x898 - leaving shop from prep screen
@0x89A - entering shop
@0x89D - returning to Buy/Sell
@0x8A0 - do you want to buy/sell more? 
@0x8A3 - what'cha buyin? 
@0x8A6 - Anything else?
@0x8A9 - what'cha sellin? 
@0x8AC - nothing to sell
@0x8AF - selling anything else?
@0x8B2 - not enough money
@0x8B5 - worth [G] gold
@0x8B8 - come back soon!
@0x8BB - I can't buy that!
@0x8BE - You're full, Send to storage?
@0x8C1 - You're full (same as above but no send to storage prompt)
@0x8C4 - OK, I'll send it
@0x8C7 - You could take it if you had room
@0x8CA - If only you had a convoy
@0x8CD - Convoy is full

mov r0,r5
add r0,#0x61
ldrb r1,[r0] @r1 = shop type

ldr r0,=#0x896 @checking from prep screen
cmp r0,r4
bne Check2

@Checking from prep screen table
ldr r0,=ShopEnterPrepScreenTextTable
lsl r1,r1,#1
add r0,r1
ldrh r4,[r0]
b GoBack

.ltorg
.align

Check2:
ldr r0,=#0x898 @leaving from prep screen
cmp r0,r4
bne Check3

@Leaving from prep screen table
ldr r0,=ShopLeavePrepScreenTextTable
lsl r1,r1,#1
add r0,r1
ldrh r4,[r0]
b GoBack

.ltorg
.align

Check3:
ldr r0,=#0x89A @entering shop
cmp r0,r4
bne Check4

@ Entering shop table
ldr r0,=ShopEnterTextTable
lsl r1,r1,#1
add r0,r1
ldrh r4,[r0]
b GoBack

.ltorg
.align


Check4:
ldr r0,=#0x89D @returning to Buy/Sell
cmp r0,r4
bne Check5

@Returning to Buy/Sell table
ldr r0,=ShopReturnToBuySellTextTable
lsl r1,r1,#1
add r0,r1
ldrh r4,[r0]
b GoBack

.ltorg
.align


Check5:
ldr r0,=#0x8A0 @do you want to buy more?
cmp r0,r4
bne Check6

@Do you want to buy more? table
ldr r0,=ShopBuyMoreYesNoTextTable
lsl r1,r1,#1
add r0,r1
ldrh r4,[r0]
b GoBack

.ltorg
.align


Check6:
ldr r0,=#0x8A3 @what'cha buyin?
cmp r0,r4
bne Check7

@what'cha buyin? table
ldr r0,=ShopWhatchaBuyinTextTable
lsl r1,r1,#1
add r0,r1
ldrh r4,[r0]
b GoBack

.ltorg
.align


Check7:
ldr r0,=#0x8A6 @anything else?
cmp r0,r4
bne Check8

@anything else? table
ldr r0,=ShopBuyingAnythingElseTextTable
lsl r1,r1,#1
add r0,r1
ldrh r4,[r0]
b GoBack

.ltorg
.align


Check8:
ldr r0,=#0x8A9 @what'cha sellin?
cmp r0,r4
bne Check9

@what'cha sellin? table
ldr r0,=ShopWhatchaSellinTextTable
lsl r1,r1,#1
add r0,r1
ldrh r4,[r0]
b GoBack

.ltorg
.align


Check9:
ldr r0,=#0x8AC @nothing to sell
cmp r0,r4
bne Check10

@nothing to sell table
ldr r0,=ShopNothingToSellTextTable
lsl r1,r1,#1
add r0,r1
ldrh r4,[r0]
b GoBack

.ltorg
.align


Check10:
ldr r0,=#0x8AF @selling anything else?
cmp r0,r4
bne Check11

@selling anything else? table
ldr r0,=ShopSellingAnythingElseTextTable
lsl r1,r1,#1
add r0,r1
ldrh r4,[r0]
b GoBack

.ltorg
.align


Check11:
ldr r0,=#0x8B2 @not enough money
cmp r0,r4
bne Check12

@not enough money table
ldr r0,=ShopNotEnoughMoneyTextTable
lsl r1,r1,#1
add r0,r1
ldrh r4,[r0]
b GoBack

.ltorg
.align


Check12:
ldr r0,=#0x8B5 @worth [G] gold
cmp r0,r4
bne Check13

@worth [G] gold table
ldr r0,=ShopItemPriceTextTable
lsl r1,r1,#1
add r0,r1
ldrh r4,[r0]
b GoBack

.ltorg
.align


Check13:
ldr r0,=#0x8B8 @come back soon!
cmp r0,r4
bne Check14

@come back soon! table
ldr r0,=ShopComeBackSoonTextTable
lsl r1,r1,#1
add r0,r1
ldrh r4,[r0]
b GoBack

.ltorg
.align


Check14: 
ldr r0,=#0x8BB @I can't buy that!
cmp r0,r4
bne Check15

@I can't buy that! table
ldr r0,=ShopCantBuyThatTextTable
lsl r1,r1,#1
add r0,r1
ldrh r4,[r0]
b GoBack

.ltorg
.align


Check15:
ldr r0,=#0x8BE @You're full, send to storage?
cmp r0,r4
bne Check16

@You're full, send to storage? table
ldr r0,=ShopSendToStorageTextTable
lsl r1,r1,#1
add r0,r1
ldrh r4,[r0]
b GoBack

.ltorg
.align


Check16:
ldr r0,=#0x8C1 @You're full
cmp r0,r4
bne Check20

@You're full table
ldr r0,=ShopFullInventoryTextTable
lsl r1,r1,#1
add r0,r1
ldrh r4,[r0]
b GoBack

.ltorg
.align

Check20:
ldr r0,=#0x8C4 @OK, I'll send it
cmp r0,r4
bne Check17

@OK, I'll send it table
ldr r0,=ShopIllSendItTextTable
lsl r1,r1,#1
add r0,r1
ldrh r4,[r0]
b GoBack

.ltorg
.align

Check17:
ldr r0,=#0x8C7 @If only you had room
cmp r0,r4
bne Check18

@If only you had room table
ldr r0,=ShopIfOnlyYouHadRoomTextTable
lsl r1,r1,#1
add r0,r1
ldrh r4,[r0]
b GoBack

.ltorg
.align


Check18:
ldr r0,=#0x8CA @No convoy
cmp r0,r4
bne Check19

@No convoy table
ldr r0,=ShopNoConvoyTextTable
lsl r1,r1,#1
add r0,r1
ldrh r4,[r0]
b GoBack

.ltorg
.align


Check19: @0x8CD as a default case just in case

@ Convoy is full table
ldr r0,=ShopFullConvoyTextTable
lsl r1,r1,#1
add r0,r1
ldrh r4,[r0]
b GoBack

.ltorg
.align



GoBack:
ldr r3,=ReturnPoint
bx r3

.ltorg
.align


