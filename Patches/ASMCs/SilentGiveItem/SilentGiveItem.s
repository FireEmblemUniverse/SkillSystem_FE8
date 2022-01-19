.align 4
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.thumb

	.equ MemorySlot, 0x30004B8 
	.equ GetUnitByEventParameter, 0x0800BC51

.global SupplyItem 
.type SupplyItem, function 

SupplyItem: 
	push	{r4,r5,lr}
	ldr r4, =MemorySlot
	b SetSupply

.global SilentGiveItem
.type SilentGiveItem, function

SilentGiveItem:
	push	{r4,r5,lr}
	ldr r4, =MemorySlot
	ldr r0, [r4, #4*0x01] @Unit
	
	blh  GetUnitByEventParameter        
	cmp  r0,#0x00
	beq  Term                
	mov  r5,r0              @ Valid unit 
	
	mov  r3,#0x28
	add  r3,r3,r0
	add  r0,#0x1E
	
ItemLoop:
	cmp  r0,r3
	bge  ItemFull             @アイテムが満杯
	ldrb r1,[r0]
	cmp  r1,#0x00
	beq  StoreItem
	add  r0,#0x02
	b    ItemLoop

ItemFull:
	ldrb  r0,[r5,#0xB]
	cmp   r0,#0x40
	bge   Error               @ only give to convoy for player units 

SetSupply:                    @輸送隊にアイテムを送る
                              @輸送体のアドレスは sendToConvoyASMC (Author:circleseverywhere) の成果を基にする
@	ldr  r3, =0x8031508 @size of convoy	{J}
	ldr  r3, =0x80315bc @size of convoy	{U}
	ldrb r3, [r3] @normally 0x63

@	ldr  r0, =0x8031500 @pointer to convoy	{J}
	ldr  r0, =0x80315b4 @pointer to convoy	{U}
	ldr  r0, [r0]

	lsl  r3, #0x01            @end = size*2 + convoy
	add  r3, r0

SupplyItemLoop:
	cmp  r0,r3
	bgt  Error                @アイテムが満杯なので無理
	ldrb r1,[r0]
	cmp  r1,#0x00
	beq  StoreItem
	add  r0,#0x02
	b    SupplyItemLoop

Error:                        @アイテムが満杯なので、渡せませんでした。 エラー終了
	mov  r0, #0x00
	b    Term

StoreItem:                    @アイテムを書き込む
	mov  r5,r0                @Store Address

	ldr r0, [r4, #4*0x03] @item 

@	blh  0x080162e8           @アイテムIDから耐久度を取得する MakeItemShort RET=ITEMPACK 耐久回数<<8|アイテムID 例:鉄の剣 耐久:46 == 2e01 r0=アイテムID	{J}
	blh  0x08016540           @アイテムIDから耐久度を取得する MakeItemShort RET=ITEMPACK 耐久回数<<8|アイテムID 例:鉄の剣 耐久:46 == 2e01 r0=アイテムID	{U}

	strh r0,[r5]
	mov  r0, #0x01

Term:
	pop {r4,r5}
	pop	{r1}
	bx	r1
