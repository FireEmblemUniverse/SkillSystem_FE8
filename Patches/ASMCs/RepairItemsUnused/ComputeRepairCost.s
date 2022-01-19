

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
@ldr r2, [r3] 
@cmp  r2,#0x00
@beq  Term   

mov r4, r0 @ Unit ram struct 
mov r5, #0x1C @ 2 less than first inv slot 
mov r6, #0 @ Total cost 

ComputeRepairCost:
add r5, #2 @ 2 bytes per inv slot 
cmp r5, #0x28 @ wexp offset 
bge ExitLoop
ldrb r0, [r4, r5] @ Unit offset by inventory slot 
cmp r0, #0 
mov r7, r0 @ Item ID 
beq ExitLoop @ Nothing in this slot so break 
blh 0x80177b0 @GetItemDataTable
mov r7, r0 @ Item table address 
ldrb r1, [r7, #0x08] @ Ability 1 
mov r3, r1 
mov r2, #1
@ must be equippable 
and r1, r2 @ Equippable/unbreakable bitflag? 
cmp r1, #0 
beq ComputeRepairCost @ Not equippable, so next item 
mov r2, #0x18 @ unbreakable or unsellable 
and r3, r2 @ 
@ must not be unbreakable or unsellable 
cmp r3, #0 
bne ComputeRepairCost

ldrb r0, [r7, #0x6] @ Item id 
blh  0x08016540           @MakeItemShort RET=ITEMPACK 
@mov r11, r11 
lsr r0, #8 @Durability only 
ldrh r1, [r4, r5] @ Durab>>8|Item 
lsr r1, #8 @Current uses left 
sub r0, r1 @ Difference in durability 
ldrb r2, [r7, #0x1A] @ Price per use 
mul r0, r2 @ Cost 
add r6, r0 @ Total cost 

@ Restore to full 
@ldrb r0, [r7, #0x6] @ Item id 
@blh  0x08016540           @MakeItemShort RET=ITEMPACK 
@strh r0, [r4, r5] 

b ComputeRepairCost


ExitLoop:

ldr r3, =MemorySlot
str r6, [r3, #0x4*0x0C] @ Store to rC 




Term:
pop {r4-r7}
pop {r1}
bx r1 
