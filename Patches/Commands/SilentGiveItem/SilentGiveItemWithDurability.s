.align 4
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.thumb

	.equ MemorySlot, 0x30004B8 
	.equ GetUnitByEventParameter, 0x0800BC51
	.equ RemoveUnitBlankItems,0x8017984
	
.global unitRamSilentGiveItemWithDurability
.type unitRamSilentGiveItemWithDurability, function
unitRamSilentGiveItemWithDurability:
	push	{r4-r7,lr}
	ldr r3, =MemorySlot
	ldr r0, [r3, #4*0x01] @Unit
	ldr r4, [r3, #4*0x03] @ Item ID to combine with 
	ldr r5, [r3, #4*0x04] @ Durability to add 
	b Continue
	

.global SupplyItemWithDurability
.type SupplyItemWithDurability, function 

SupplyItemWithDurability: 
	push	{r4-r7,lr}
	ldr r4, =MemorySlot
	b SetSupply

.global SilentGiveItemWithDurability
.type SilentGiveItemWithDurability, function

SilentGiveItemWithDurability:
	push	{r4-r7,lr}
	ldr r3, =MemorySlot
	ldr r0, [r3, #4*0x01] @Unit
	ldr r4, [r3, #4*0x03] @ Item ID to combine with 
	ldr r5, [r3, #4*0x04] @ Durability to add 
	
	blh  GetUnitByEventParameter    
	Continue:
	cmp  r0,#0x00
	beq  Term                
	mov  r7,r0              @ Valid unit 

	@blh RemoveUnitBlankItems @move everything else up

	mov  r6,#0x28
	add  r6,r6,r7
	add  r7,#0x1C
	

	
ItemLoop:
	add  r7,#0x02
	cmp  r7,r6
	bge  ItemFull             @アイテムが満杯
	ldrb r0,[r7]
	cmp  r0,#0x00
	beq  StoreItem
	
	cmp r0, r4 
	beq TryCombineItemInv
	


	b    ItemLoop

TryCombineItemInv:
blh  0x08016540           @MakeItemShort RET=ITEMPACK 
ldrb r1, [r7, #1] @ Item's durability 
lsr r2, r0, #8 @ max durability
add r1, r5
cmp r1, r2
bgt ItemLoop 
ldr r3, =MemorySlot
str r1, [r3, #4*0x04] @ Combined durability 
b StoreItem



ItemFull:
	ldrb  r0,[r7,#0xB]
	cmp   r0,#0x40
	bge   Error               @ only give to convoy for player units 

SetSupply:                    @輸送隊にアイテムを送る
                              @輸送体のアドレスは sendToConvoyASMC (Author:circleseverywhere) の成果を基にする
@	ldr  r6, =0x8031508 @size of convoy	{J}
	ldr  r6, =0x80315bc @size of convoy	{U}
	ldrb r6, [r6] @normally 0x63

@	ldr  r7, =0x8031500 @pointer to convoy	{J}
	ldr  r7, =0x80315b4 @pointer to convoy	{U} @ [0x203A81C]?!!
	ldr  r7, [r7]

	lsl  r6, #0x01            @end = size*2 + convoy
	add  r6, r7
	
	ldr r4, =MemorySlot
	ldr r5, [r4, #4*0x03] @item 
	ldr r4, [r4, #4*0x04] @ durability 
	
	
	sub r7, #2 
SupplyItemLoop:
	add r7, #2
	cmp  r7,r6
	bgt  Error                @アイテムが満杯なので無理
	ldrb r0,[r7]
	cmp  r0,#0x00
	beq  StoreItem
	
	cmp  r0, r5 
	beq  TryCombineItem

	b    SupplyItemLoop

TryCombineItem:
blh  0x08016540           @MakeItemShort RET=ITEMPACK 
ldrb r1, [r7, #1] @ Item's durability 
lsr r2, r0, #8 @ max durability
add r1, r4 
cmp r1, r2
bgt SupplyItemLoop 

ldr r3, =MemorySlot
str r1, [r3, #4*0x04]

b StoreItem

Error:                        @アイテムが満杯なので、渡せませんでした。 エラー終了
	mov  r0, #0x00
	b    Term

StoreItem:                    @アイテムを書き込む
	ldr r3, =MemorySlot
	ldr r0, [r3, #4*0x03] @item 
	ldr r1, [r3, #4*0x04] @ durability 
	lsl r1, #8 
	add r0, r1 
	strh r0,[r7]
	b Term 

Term:
	pop {r4-r7}
	pop	{r0}
	bx	r0
