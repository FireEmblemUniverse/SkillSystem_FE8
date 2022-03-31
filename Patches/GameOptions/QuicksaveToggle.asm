.align 4
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
.thumb

	.equ CheckEventId,0x8083da8
	.equ SetEventId, 0x8083d80 
	.equ UnsetEventId, 0x8083d94
	.equ GameOptionHandler, 0x80B1D14
	


	
.type GenericToggleFunc, %function
.global GenericToggleFunc

GenericToggleFunc:
push {r4, lr}
mov r4, r0 @ ID 
@ vanilla just pushed lr 
mov r0, r4 
blh CheckEventId
cmp r0, #0 
beq SetFlagOn
mov r0, r4
blh UnsetEventId
b End 
SetFlagOn:
mov r0, r4
blh SetEventId 
End:
pop {r4}
pop {r1}
pop {r1}
bx r1 

.ltorg 
.align 

.type GenericCheckOption, %function 
.global GenericCheckOption
@ pop lr twice 
GenericCheckOption:
push {r4, lr}
blh CheckEventId
pop {r4}
pop {r1}
pop {r1}
bx r1 

.ltorg 
.align 

