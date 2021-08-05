

.align 4
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.thumb

	.equ MemorySlot, 0x30004B8 
	.equ GetUnitByEventParameter, 0x0800BC51

.global RepairItems
.type RepairItems, function 
RepairItems:

push {r4-r7, lr} 
@ Given s1 as memory slot, return cost to repair all items 

@ldr r3, =MemorySlot
@ldr r0, [r3, #4*0x01] @Unit
@blh  GetUnitByEventParameter    

ldr r3, =0x3004E50 @ Current unit pointer 
ldr r0, [r3] @ Ram unit pointer now 
cmp r0, #0 
beq Term 
ldr r2, [r0] 
cmp  r2,#0x00
beq  Term   
mov r4, r0 @ Unit ram struct 

@ Charge gold 
ldr r3, =0x202BCF0
ldr r2, [r3, #8] @ gChapterData -> Gold 
ldr r0, =0x30004B8 @ MemorySlot
ldr r1, [r0, #4*0x01] @ r1 as gold to charge 
@mov r11, r11 

@cmp r1, #0 
@beq Broke @ Costs nothing, so don't repair anything 
cmp r2, r1
blt Broke @ Not enough gold, so don't repair items 
sub r2, r1 @ New gold amount 
str r2, [r3, #8] @ Store it 


mov r5, #0x1C @ 2 less than first inv slot 

@ Repair item 
TryRepairItem:
add r5, #2 @ 2 bytes per inv slot 
cmp r5, #0x28 @ wexp offset 
bge ExitLoop 

ldrb r0, [r4, r5] @ Unit offset by inventory slot 
cmp r0, #0 
beq ExitLoop @ Nothing in this slot so break 

blh 0x80177b0 @GetItemDataTable
mov r7, r0 @ Item table address 
ldrb r1, [r7, #0x08] @ Ability 1 


mov r3, r1 
mov r2, #1
@ must be equippable 
and r1, r2 @ Equippable/unbreakable bitflag? 
cmp r1, #0 
beq TryRepairItem @ Not equippable, so next item 
mov r2, #0x18 @ unbreakable or unsellable 
and r3, r2 @ 
@ must not be unbreakable or unsellable 
@mov r11, r11
cmp r3, #0 
bne TryRepairItem

ldrb r0, [r7, #0x06] @ Item id 


blh  0x08016540           @MakeItemShort RET=ITEMPACK 
strh r0, [r4, r5] 
b TryRepairItem

ExitLoop:
ldr r3, =0x30004B8 @ MemorySlot 
mov r0, #1 @ We probably repaired stuff 
str r0, [r3, #4*0x0C] @ Store true to rC 
b Term 



Broke:
ldr r3, =0x30004B8 @ MemorySlot
mov r0, #0 
str r0, [r3, #4*0x0C] @ Store false to rC 


Term:
pop {r4-r7}
pop {r1}
bx r1 




