.thumb
.align 4

.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm


.equ CurrentUnit, 0x3004E50
.equ MemorySlot,0x30004B8
.equ EventEngine, 0x800D07C
.equ CurrentUnitFateData, 0x203A958 

	
.global HoneClawsCommandUsability 
.type HoneClawsCommandUsability, %function 

HoneClawsCommandUsability:
push {lr} 

ldr r0, =CurrentUnit 
ldr r0, [r0] 
ldr r1, =HoneClaws 
lsl r1, #24 
lsr r1, #24 
bl MoveTester 
cmp r0, #0
beq RetFalse  
bl IsPeaceful
cmp r0, #1 
beq RetFalse 
mov r0, #1 
b Exit 
RetFalse: 
mov r0, #3 @ Menu false usability is 3 
Exit: 

pop {r1} 
bx r1 


.global HoneClawsCommandEffect 
.type HoneClawsCommandEffect, %function 

HoneClawsCommandEffect:
push {lr} 

ldr r3, =CurrentUnit 
ldr r0, [r3] 
bl GetUnitDebuffEntry
ldr r1, =HoneClawsBuffs
@r0 @ debuff entry 
@r1 debuff table to use 
@r2 entry ID of the given table 
mov r2, #0 
bl DebuffGivenTableEntry 

bl StartBuffFxUser

ldr r1, =CurrentUnitFateData	@these four lines copied from wait routine
mov r0, #0x1
strb r0, [r1,#0x11]
mov r0, #0x17	@makes the unit wait?? makes the menu disappear after command is selected??

pop {r1} 
bx r1 


.ltorg 
.align 




