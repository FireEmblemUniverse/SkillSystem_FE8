.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm


.equ CurrentUnit, 0x3004E50
.equ MemorySlot, 0x30004B8
.equ EventEngine, 0x800D07C
.equ CurrentUnitFateData, 0x203A958 
.equ CheckEventId, 0x8083da8
.equ gChapterData, 0x202BCF0
.equ CannotEvolveFlag_Link, PromotionLevelTable+4 
push {r4-r6, lr}

mov r6, #3 @ False. Default - Menu false usability is 3 

ldr r0, CannotEvolveFlag_Link
ldr r0, [r0] 
blh CheckEventId 
cmp r0, #0 
bne ReturnValue  


ldr r4, =CurrentUnit 
ldr r4, [r4] 
cmp r4, #0 
beq ReturnValue

ldr r0, [r4, #4] @ Class pointer 
ldrb r0, [r0, #4] @ ClassID 
lsl r0, #1 @ 2 bytes / choices per class 

ldr r2, =0x80CC7D0 @ POIN PromotionTable
ldr r2, [r2] @ PromotionTable (Vanilla: 0x895DFA4)
ldrh r0, [r2, r0] @ Are both choices 0? 
cmp r0, #0 
beq ReturnValue @ If no possible class to promote into, then return false. 

ldr r5, PromotionLevelTable
ldr r0, [r4, #4] @ Class pointer 
ldrb r0, [r0, #4] @ ClassID 
add r5, r0 @ Specific class promotion level 
ldrb r0, [r5] 
cmp r0, #255 
beq ReturnValue
ldrb r1, [r4, #8] @ Level 
cmp r0, r1 
bgt ReturnValue
mov r6, #1 @ True 

ReturnValue:
mov r0, r6  

End: 

pop {r4-r6}
pop {r1}
bx r1 

.ltorg 
.align 4

PromotionLevelTable:

