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
ldrb r5, [r5, #4] @ Char ID 

 

cmp r5, #0xE0 
blt WeCanAttack 
cmp r5, #0xF0 
bge WeCanAttack 


sub r5, #0xE0 
mov r1, r5 

ldr r3, =0x202BCF0 @ Chapter Data 
ldrb r0, [r3, #0x0E] @ +0x0E	Byte	Chapter ID
lsl r0, #4 @ 16 trainers per area allowed 
add r0, r1 @ which trainer exactly 
ldrb r3, =TrainerDefeatedFlagOffset @0xA0 
lsl r1, r3, #3 @ 8 flags per byte so +0x500 
add r0, r1 @ Full offset 
mov r6, r0 








blh CheckNewFlag 
cmp r0, #1 
bne CannotAttack @ We can only talk to them if the flag is ON 



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




