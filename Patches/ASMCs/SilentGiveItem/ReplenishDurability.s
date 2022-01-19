

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


.global ReplenishDurability
.type ReplenishDurability, function 
ReplenishDurability:

push {r4-r5, lr} 


ldr r3, =MemorySlot
ldr r0, [r3, #4*0x01] @Unit
blh  GetUnitByEventParameter    
ldr r2, [r0] 
cmp  r2,#0x00
beq  Term   

mov r4, r0 @ Unit ram struct 
mov r5, #0x1C @ 2 less than first inv slot 

TryCombineItem:
add r5, #2 @ 2 bytes per inv slot 
ldrb r0, [r4, r5] @ Unit offset by inventory slot 
cmp r0, #0 
beq Term @ Nothing in this slot so break 
blh  0x08016540           @MakeItemShort RET=ITEMPACK 
strh r0, [r4, r5] 
cmp r5, #0x28 @ wexp offset 
blt TryCombineItem 

Term:

pop {r4-r5}
pop {r1}
bx r1 




