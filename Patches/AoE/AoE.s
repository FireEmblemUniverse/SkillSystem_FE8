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
	
.global AoE_Usability 
.type AoE_Usability, %function 

AoE_Usability:
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
.global AoE_Setup 
.type AoE_Setup, %function 

AoE_Setup:

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


ldr r1, =CurrentUnitFateData	@these four lines copied from wait routine
mov r0, #0x1
strb r0, [r1,#0x11]
@mov r0, #0x17	@makes the unit wait?? makes the menu disappear after command is selected??
mov r0,#0x94		@play beep sound & end menu on next frame & clear menu graphics
pop {r4-r7}
pop {r0} 
bx r0 

.global AoE_Effect
.type AoE_Effect, %function 
AoE_Effect:
push {r4-r7, lr} 

bl AoE_EffectCreateRangeMap

ldr r0, =AoE_DamageUnitsInRange
blh 0x8024eac @ForEachUnitInRange @ maybe this calls AoE_DamageUnitsInRange for each unit found in the range mask? 

@ldr r3, =MemorySlot 
@mov r0, #0x4*0xB 
@strb r1, [r3, r0] 
@add r0, #2 
@strb r2, [r3, r0] 
@
@ldr r0, =TestEventAsdf
@mov r1, #1 
@blh EventEngine 

blh  0x08019c3c   @UpdateGameTilesGraphics

pop {r4-r7}
pop {r0} 
bx r0 

.type AoE_EffectCreateRangeMap, %function 
.global AoE_EffectCreateRangeMap
AoE_EffectCreateRangeMap:
@ given XX and YY via action struct, construct a range mask around it? 

push {r4-r7, lr}



@ Clear range map 
@ldr r0, =0x202E4E4 @ range map pointer 
@ldr r0, [r0]
@mov r1, #0
@_blh FillMap

	@r0 = targeting condition routine pointer
	@r1 = item id

ldr r0, =0x8026525 
mov r1, #1 @ item id ? 


blh Item_TURange
@blh 0x80170d4 @GetWeaponRangeMask

@blh 0x801b460 @FillRangeMapByRangeMask

ldr r0, =CurrentUnit
ldr r4, [r0] 


ldrb r6, [r4, #0x10] @ XX 
ldrb r7, [r4, #0x11] @ YY 

ldr r3, =pActionStruct
ldrb r0, [r3, #0x13]  @@ XX 
strb r0, [r4, #0x10] 
ldrb r0, [r3, #0x14] @ YY 
strb r0, [r4, #0x11] 

mov r0, r4 

mov r2, #1 
ldr r1, =0x8026525 
	@r0 = char pointer 
	@r1 = targeting condition routine pointer
	@r2 = item id
@ i think r0/r2 are provided by the parent function 
blh Item_TTRange

strb r6, [r4, #0x10] 
strb r7, [r4, #0x11] 

pop {r4-r7}
pop {r0} 
bx r0 



@ given a range mask, do stuff to all units in range? 
.global AoE_DamageUnitsInRange
.type AoE_DamageUnitsInRange, %function 
AoE_DamageUnitsInRange:
push {r4-r7, lr} 

@ given r0 unit found in range, damage them 

mov r4, r0 
ldrb r0, [r4, #0x13] 


sub r0, #20 
cmp r0, #0 
bgt NoCapHP
mov r0, #1 
NoCapHP:
strb r0, [r4, #0x13] 

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
	@r0 = char pointer 
	@r1 = targeting condition routine pointer
	@r2 = item id
@ i think r0/r2 are provided by the parent function 
blh Item_TTRange

pop {r3}
bx r3

.ltorg
.align


