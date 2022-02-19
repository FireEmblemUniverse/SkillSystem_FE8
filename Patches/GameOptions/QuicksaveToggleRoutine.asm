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
@ vanilla already pushed lr 
ldr r0, =QuicksaveToggleFlagLink
ldr r0, [r0] 
blh CheckEventId
cmp r0, #0 
beq SetFlagOn
ldr r0, =QuicksaveToggleFlagLink
ldr r0, [r0] 
blh UnsetEventId
b End 
SetFlagOn:
ldr r0, =QuicksaveToggleFlagLink
ldr r0, [r0] 
blh SetEventId 
End:
pop {r1}
bx r1 

.ltorg 
.align 

.type QuicksaveJumpTableFunc, %function 
.global QuicksaveJumpTableFunc
QuicksaveJumpTableFunc:
@ don't push lr ?
ldr r0, =QuicksaveToggleFlagLink
ldr r0, [r0] 
blh CheckEventId
Skip: 
pop {r1}
bx r1 

.ltorg 
.align 

