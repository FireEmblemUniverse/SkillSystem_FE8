.equ ppRangeMapRows, 0x0202E4E4
.equ pActionStruct, 0x0203A958
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm
	.equ EventEngine, 0x800D07C
	.equ MemorySlot,0x30004B8
.thumb
@A button case

.equ ActionID, 0x01

push 	{r4, r14}
mov 	 r4, r0

@check to make sure tile is selectable
ldr 	r0, =ppRangeMapRows
lsl 	r3, r2, #0x2
ldr 	r0, [r0]
ldr 	r0, [r0, r3]
ldrb	r0, [r0, r1]

cmp 	r0, #0
beq BadTile

push {r0-r2}

mov r0, r1 // r0 - xCoord
mov r1, r2 // r1 - yCoord
    
//blh CheckFunc
ldr r3, CheckFunc
mov lr, r3
.short 0xF800

mov r3, r0
pop {r0-r2}
cmp r3, #0x0
beq BadTile

@store cooridinates in action struct
ldr 	r0, =pActionStruct
mov 	r3, #0x0
strb 	r3, [r0, #0xD]
mov 	r3, #ActionID
strb 	r3, [r0,#0x11]
strb 	r1, [r0, #0x13]
strb 	r2, [r0, #0x14]

bl AoE_Effect
mov 	r0, #0x6
b End

BadTile:
mov 	r0, #0x10

End:
pop 	{r4}
pop 	{r3}
bx	r3

.ltorg
.align

CheckFunc:
@POIN CheckFunc
