@jump to hack with r3 or whatever 
@ 2517C 

.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm



.align 4
.thumb 

	.equ CheckEventId, 0x8083da8 
	.equ CurrentUnit, 0x3004E50
.global PreventAttacking
.type PreventAttacking, %function 


PreventAttacking:

push {r4-r7, lr}



mov r4, r0 @ target 
ldr r0, =0x2033F3C @ gUnitSubject 
ldr r5, [r0] 
ldrb r0, [r5, #0x0B] @ Deployment byte 
mov r1, #0x0B 
ldsb r1, [r4, r1] @ Deployment byte 

blh 0x8024d8c @AreUnitsAllied
lsl r0, #24 
cmp r0, #0 
bne CannotAttack @ Units are allied, so exit 
@ Vesly stuff 

@ Target's class id 
ldr r6, [r4, #4] @ Class pointer 
ldrb r6, [r6, #4] @ Class id

@ Target's unit id 
ldr r5, [r4] @ Unit pointer 
ldrb r5, [r5, #4] @ Char ID 




ldr r7, =PreventAttackingTable
sub r7, #8
PreventAttackingLoop:
add r7, #8 
ldr r0, [r7, #4] 
cmp r0, #0 
beq WeCanAttack @ Finished the loop 

ldrb r0, [r7, #5]
cmp r0, #1 
beq Capturing @ This also breaks the loop lol 

 
@ Check unit id 
ldrb r0, [r7, #0] @ Unit ID lower bound 
cmp r0, #0 
beq UnitIDException
ldrb r1, [r7, #1] @ Unit ID end range 
cmp r5, r0 
blt PreventAttackingLoop 
cmp r5, r1 
bgt PreventAttackingLoop

UnitIDException:
ldrb r0, [r7, #2] @ Class ID 
cmp r0, #0 
beq ClassIDException

ldrb r1, [r7, #3] @ Class ID end range 
cmp r6, r0 
blt PreventAttackingLoop 
cmp r6, r1 
bgt PreventAttackingLoop


ClassIDException:
ldrb r0, [r7, #4] @ Flag ID 
cmp r0, #0 
beq PreventAttackingLoop
cmp r0, #0xFF @ If flag is 0xFF, allow any 
beq FlagIDException
blh CheckEventId
cmp r0, #1 
bne PreventAttackingLoop 

FlagIDException:
b CannotAttack 

Capturing: 

cmp r5, #0xA0 @ Unit ID 
blt WeCanAttack 

ldr r1, =CurrentUnit 
@ldr r1, =0x2033F3C @ gUnitSubject 
ldr r3, [r1] 
ldr r1, [r3, #0x0C] @ Current Unit State 

mov r2, #0x40 
lsl r2, #24 @ Capture bit 
and r2, r1  

cmp r2, #0 
beq WeCanAttack @ If we are not capturing, then we can attack. 

b CannotAttack 

WeCanAttack:
@ back to vanilla stuff now 
@ Add the target now 
mov r0, #0x10 
ldsb r0, [r4, r0] @ XX 
mov r1, #0x11 
ldsb r1, [r4, r1] @ YY 

mov r2, #0xB 
ldsb r2, [r4, r2] 
mov r3, #0 
blh 0x0804F8BC   @AddTarget




CannotAttack:

pop {r4-r7}
pop {r0}
bx r0 



