.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.thumb





.equ GetUnitStruct, 0x8019430 
.equ UnitAddItem, 0x8017948 
.equ gActionData, 0x203A958 

	.equ MemorySlot, 0x30004B8 
	.equ GetUnitByEventParameter, 0x0800BC51
.type StealWithFullInv, %function 
.global StealWithFullInv 
StealWithFullInv: 
push {r4-r6, lr} 
blh GetUnitStruct 
mov r4, r0 @ unit 
@ r6 item 
ldrh r0, [r4, #0x26] 
cmp r0, #0 
bne SupplyItem 
mov r0, r4 
mov r1, r6 @ item 
blh UnitAddItem 
b Error 

SupplyItem: 


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
	strh r6,[r5]
	mov  r0, #0x01

Term:
	pop {r4-r6}
	ldr r5, =gActionData 
	pop	{r1}
	bx	r1
.ltorg 
	
