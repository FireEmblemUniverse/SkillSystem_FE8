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
.type QuicksaveToggleRoutine, %function
.global QuicksaveToggleRoutine

QuicksaveToggleRoutine:
push {r4-r5, lr}
mov r4, r0 
ldr r0, =QuicksaveToggleFlagLink
ldr r5, [r0] 
mov r0, r5 
blh CheckEventId
cmp r0, #0 
beq SetFlagOn
mov r0, r5 
blh UnsetEventId
mov r0, r4 @ Parent Proc? 
blh GameOptionHandler
mov r0, #0
b End 
SetFlagOn:
mov r0, r5 
blh SetEventId 
mov r0, r4 @ Parent Proc? 
blh GameOptionHandler
mov r0, #1 
End:
pop {r4-r5}
pop {r1}
bx r1 

.ltorg 
.align 




