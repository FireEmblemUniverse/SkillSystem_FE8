.thumb 
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm


.equ CurrentUnit, 0x3004E50
.equ MemorySlot,0x30004B8
.equ EventEngine, 0x800D07C
.equ CurrentUnitFateData, 0x203A958 

push {lr}


ldr r3, =CurrentUnit 
ldr r3, [r3] 
cmp r3, #0 
beq RetFalse 

ldrb r0, [r3, #8] @ Level
ldr r1, RequiredLevel 
cmp r0, r1
blt RetFalse 
ldr r0, [r3, #4] @ Class pointer 
mov r1, #0x29
ldrb r0, [r0, r1] @ IsPromoted? 
mov r1, #1 
tst r0, r1 
bne RetFalse 
mov r0, #1 @ True 
b End 

RetFalse: 
mov r0, #3 @ Menu false usability is 3 

End: 

pop {r1}
bx r1 

.ltorg 
.align 4

RequiredLevel:

