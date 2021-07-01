.align 4
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.thumb

.equ MemorySlotC, 0x30004E8

	.equ MemorySlot, 0x30004B8 
	.equ GetUnitByEventParameter, 0x0800BC51


.global CombineGiveItemWithDurability
.type CombineGiveItemWithDurability, function

CombineGiveItemWithDurability:

push	{r4-r6,lr}



	ldr r4, =MemorySlot
	ldr r0, [r4, #4*0x01] @Unit
	
	blh  GetUnitByEventParameter        
	cmp  r0,#0x00
	beq  Term   
	
	mov r4, r0 @ Unit Ram pointer 
	mov r1, #0x1E

	mov r0, #0 
	strb r0, [r4, r1]
	add r1, #1 
	strb r0, [r4, r1]




@ Prior to this, we emptied the first inventory slot of the unit 
@ and we executed an event to give the item. 
@ This gives us the max durability and displays the popup we want. 

@ doing it within the asmc doesn't work for the popup unless we mess with procs, I think 

	ldr r3, =MemorySlot
	ldr r0, [r3, #4*0x03] @Item [0x30004C4]!!?

	blh  0x08016540           @MakeItemShort RET=ITEMPACK 
	lsr r0, #8 @ Item durability 
	mov r5, r0 

	ldr r3, =MemorySlot
	ldr r0, [r3, #4*0x03] @Item [0x30004C4]!!?
	
	ldrh r2, [r3, #4*0x06] 
	strh r2, [r4, #0x1E] @ Restore first item back to normal 
	blh SilentGiveItemWithDurability 
	b Term 
	
	
	mov r0, r4 @ Unit RAM pointer 
	ldrb  r4, [r3, #4*0x03] @ Item ID to give 
	mov  r3,#0x28
	add  r3,r3,r0
	add  r0,#0x1C

	
ItemLoop:
	add  r0,#0x02
	cmp  r0,r3
	bge  CannotCombine             
	ldrb r1,[r0]
	cmp  r1,r4
	beq  TryStoreItem
	b    ItemLoop

TryStoreItem:
@ r2, r3 free 
ldr r1, =MemorySlot 
ldrb  r2, [r1, #4*0x04] @ Durability to give 
ldrb r1, [r0, #1] @ Current durability of held item 
add r2, r1 
cmp r2, r5 
bgt ItemLoop
strb r2, [r0, #1] 

b Term 


MaxDurability:
b CannotCombine
@ 
strb r5, [r0, #1]
@ Give remaining durability as new item 

CannotCombine:

@ s1 as unit ID 
@ s3 as item ID to give 
@ s4 as durability to give 

blh SilentGiveItemWithDurability
@ this could be made to combine items in supply, too 


@ silent give item to the char 







Term:
pop {r4-r6}

pop {r0}
bx r0

goto_r3:
bx r3
.ltorg
.align

ExecuteEvent:
	.long 0x800D07D @AF5D
