.align 4
.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

  .equ CheckEventId,0x8083da8
    .equ CurrentUnit, 0x3004E50


AoE_SpecificUsability:
push {r4-r7, lr}
ldr r3, =CurrentUnit 
ldr r5, [r3] @ unit struct ram pointer 

ldr r0, =AoE_SpecificEffectIndex 
ldrb r0, [r0]
ldr r4, =AoE_Table 
ldr r1, =AoE_EntrySize 
ldrb r1, [r1]
mul r1, r0 @ Offset for the entry we want 
add r4, r1 @ Specific entry 

ldr r1, [r4] @ Additional routine ? 
cmp r1, #0 
beq SkipAdditionalUsabilityRoutine 
@r0 is still our specific effect index
mov lr, r1
.short 0xF800

cmp r0, #0 
beq ReturnFalse

SkipAdditionalUsabilityRoutine:


ldrb r0, [r4, #4] @ Unit ID 
cmp r0, #0x00 
beq ValidUnit
ldr r1, [r5] @ Char 
ldrb r1, [r1, #4] @ unit id 
cmp r0, r1 
bne ReturnFalse

ValidUnit:

ldrb r0, [r4, #5] @ class 
cmp r0, #0 
beq ValidClass
ldr r1, [r5, #4] @ class 
ldrb r1, [r1, #4] @ class id 
cmp r0, r1 
bne ReturnFalse

ValidClass:

@ check lvl 
ldrb r0, [r4, #6] 
cmp r0, #0 
beq ValidLevel
ldrb r1, [r5, #8] @ level ? 
cmp r0, r1 
bgt ReturnFalse

ValidLevel:
ldrb r0, [r4, #7]
cmp r0, #0 
beq ValidFlag
blh CheckEventId
cmp r0, #1 
bne ReturnFalse

ValidFlag:
ldrb r0, [r4, #8] @ Req Item 
cmp r0, #0 
beq ValidItem
mov r1, #0x1C 
InventoryLoop: 
add r1, #2 
cmp r1, #0x28 
bge ReturnFalse
ldrb r2, [r5, r1] 
cmp r2, #0 
beq ReturnFalse
cmp r2, r0 
bne InventoryLoop
@ They have said item, so continue
ValidItem:


ReturnTrue: 
mov r0, #1 
b End 


ReturnFalse: 
mov r0, #0
mov r0, #3 

End: 

pop {r4-r7} 
pop {r1} 
bx r1 

.ltorg
.align 4 



AoE_SpecificEffectIndex: 
