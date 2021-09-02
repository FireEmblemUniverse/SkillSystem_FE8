@ hook with r1 at 8024EE4 


.align 4
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

	.equ GetUnit, 0x8019431
	.equ CurrentUnit, 0x3004E50
	.equ CheckEventId, 0x8083da8 
	

.thumb 
.align 4 

.global PreventAttTradeRescueEtc
.type PreventAttTradeRescueEtc, %function 

PreventAttTradeRescueEtc:
 
@ vanilla stuff 
add r0, r5, r0 
ldr r0, [r0] 
add r1, r0, r4 
push {r4-r7, lr}
ldrb r0, [r1] @ Target Unit deployment ID 



cmp r0, #0 
beq Skip

push {r0} 


blh GetUnit @19431 
cmp r0, #0 
beq CannotAttack 
mov r4, r0 



ldr r5, [r4] @ Unit pointer 
ldrb r5, [r5, #4] @ Char ID 
ldr r6, [r4, #4] @ Class pointer 
ldrb r6, [r6, #4] @ Class id

 

ldr r7, =PreventAttackingTable
sub r7, #4 
PreventAttackingLoop:
add r7, #4 
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
ldr r3, [r1]
ldr r1, [r3, #0x0C] @ Current Unit State 

mov r2, #0x40 
lsl r2, #24 @ Capture bit 
and r2, r1  

cmp r2, #0 
beq WeCanAttack @ If we are not capturing, then we can attack. 

b CannotAttack 
@ If we are capturing, then we cannot attack. 

@ Check that they are adjacent ! 
@ r4 is target unit ram pointer, r3 is current unit ram pointer 
ldrb r1, [r3, #0x10] @ Coords 
ldrb r2, [r4, #0x10] @ Coords 
cmp r2, r1 
beq XWasEqual
ldrb r1, [r3, #0x11] @ Coords 
ldrb r2, [r4, #0x11] @ Coords 
cmp r2, r1 
bne CannotAttack @ Neither X nor Y was equal, so ExitB 
YWasEqual:
ldrb r1, [r3, #0x10] @ Coords 
ldrb r2, [r4, #0x10] @ Coords 
b EitherCase

XWasEqual:
ldrb r1, [r3, #0x11] @ Coords 
ldrb r2, [r4, #0x11] @ Coords 


EitherCase:
sub r1, #1 @ 
cmp r1, r2 
beq WeCanCapture @ If we are adjacent, then we can capture. 
add r1, #2 
cmp r1, r2 
beq WeCanCapture
b CannotAttack @ 

WeCanCapture:
WeCanAttack: 


pop {r0}
@ r0 should be their deployment ID eg. unit ram + 0x0B 

Skip:
pop {r4-r7}
pop {r1} 

ldr r1, =0x8024EED @ Return address 
bx r1 


CannotAttack:
pop {r0}

mov r0, #0 
b Skip 

