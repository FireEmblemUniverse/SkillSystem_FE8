.thumb
.align 4

.include "_TargetSelectionDefinitions.s"

.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

	.equ pActionStruct, 0x203A958
	.equ CurrentUnit, 0x3004E50
	.equ MemorySlot,0x30004B8
	.equ EventEngine, 0x800D07C

	.equ CurrentUnitFateData, 0x203A958
	
.global AoEUsability 
.type AoEUsability, %function 

AoEUsability:
push {lr} 

mov r0, #1 
cmp r0, #1 
beq RetTrue 
RetFalse: 
mov r0, #3 @ Menu false usability is 3 

RetTrue: 

pop {r1} 
bx r1 


	.equ pr6C_New, 0x08002C7C
.global AoEEffect 
.type AoEEffect, %function 

AoEEffect:

push {r4-r7, lr} 

ldr r4, =CurrentUnit
ldr r4, [r4] 


@parameters
	@r0 = char pointer
	@r1 = pointer range builder function
	@r2 = item id
	@r3 = pointer list for proc
mov r0, r4 @ CurrentUnit 
ldr r1, =AoE_RangeSetup
mov r2, #2 @ 1-7 range weapon - used for the range mask 
@ later I will try to construct a range mask myself  
ldr r3, =AoE_FreeSelect @ Proc list 

bl AoE_FSTargeting

@store cooridinates in action struct
ldr 	r3, =pActionStruct
ldrb 	r0, [r3, #0x13] @ XX
ldrb 	r1, [r3, #0x14] @ YY 

mov r5, r0 
mov r6, r1 

@ldr r3, =MemorySlot 
@mov r2, #0x4*0xB 
@strb r5, [r3, r2] 
@add r2, #2 
@strb r6, [r3, r2] 
@
@ldr r0, =TestEventAsdf
@mov r1, #1 
@blh EventEngine 


ldr r1, =CurrentUnitFateData	@these four lines copied from wait routine
mov r0, #0x1
strb r0, [r1,#0x11]
mov r0, #0x17	@makes the unit wait?? makes the menu disappear after command is selected??
@mov r0,#0x94		@play beep sound & end menu on next frame & clear menu graphics
pop {r4-r7}
pop {r0} 
bx r0 






@parameters
	@r0 = char pointer
	@r1 = pointer range builder function
	@r2 = item id
	@r3 = pointer list for proc
.global AoE_FSTargeting
.type AoE_FSTargeting, %function 
	
AoE_FSTargeting:
push	{r4,lr}
mov 	r4, r3
mov 	r3, r1
bl		Jump
ldr 	r0, =MoveCostMapRows
ldr 	r0, [r0]
mov 	r1, #0x1
neg 	r1, r1
_blh 	FillMap
mov 	r0, #1
ldr 	r3, =prNewFreeSelect
orr 	r3, r0 
mov 	r0, r4
mov r11, r11 
bl	Jump
pop 	{r4}
pop 	{r3}
Jump:
bx	r3





.ltorg
.align

.global AoE_RangeSetup
.type AoE_RangeSetup, %function 

AoE_RangeSetup:
push {lr}

ldr r1, =0x8026525 
blh Item_TTRange

pop {r3}
bx r3

.ltorg
.align


