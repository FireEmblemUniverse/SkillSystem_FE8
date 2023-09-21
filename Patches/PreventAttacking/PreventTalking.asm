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

.global PreventAttTradeRescueEtc_Ver2
.type PreventAttTradeRescueEtc_Ver2, %function 

PreventAttTradeRescueEtc_Ver2:
 
@ vanilla stuff 
add r0, r5, r0 
ldr r0, [r0] 
add r1, r0, r4 
ldrb r0, [r1] @ Target Unit deployment ID 
push {r4-r7, lr}

cmp r0, #0 
beq End

push {r0} 


blh GetUnit @19431 
cmp r0, #0 
beq CannotAttack 
mov r4, r0 

ldr r5, [r4] @ Unit pointer 
cmp r5, #0 
beq CannotAttack 
ldrb r5, [r5, #4] @ Char ID 

 

cmp r5, #0xE0 
blt WeCanAttack 
cmp r5, #0xF0 
bge WeCanAttack 

mov r0, r4 

blh CheckTrainerFlag 
cmp r0, #1 
bne CannotAttack @ We can only talk to them if the flag is ON 
mov r1, #0x2D 
ldrb r0, [r4, r1] @ Battle started etc. 
cmp r0, #50 
bne CannotAttack 


WeCanAttack: 
pop {r0}
@ r0 should be their deployment ID eg. unit ram + 0x0B 
b End 

CannotAttack:
pop {r0}
mov r0, #0 


End:
pop {r4-r7}
pop {r1} 

ldr r1, =0x8024EED @ Return address 
bx r1 




