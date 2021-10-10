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

@mov r0, #0x17	@makes the unit wait?? makes the menu disappear after command is selected??
mov r0,#0x94		@play beep sound & end menu on next frame & clear menu graphics
pop {r4-r7}
pop {r0} 
bx r0 

.global AoE_GenericEffect
.type AoE_GenericEffect, %function 
AoE_GenericEffect:
push {r4-r7, lr} 

ldr r2, =RangeTemplate_Cross
bl AoE_EffectCreateRangeMap

ldr r0, =AoE_DamageUnitsInRange
blh 0x8024eac @ForEachUnitInRange @ maybe this calls AoE_DamageUnitsInRange for each unit found in the range mask? 


bl AoE_ClearRangeMap
blh 0x801dacc @HideMoveRangeGraphics

ldr r1, =CurrentUnitFateData	@these four lines copied from wait routine
mov r0, #0x1
strb r0, [r1,#0x11]

blh  0x08019c3c   @UpdateGameTilesGraphics
blh 0x0804E884   @//ClearBG0BG1


pop {r4-r7}
pop {r0} 
bx r0 

.global AoE_ClearRangeMap
.type AoE_ClearRangeMap, %function 
AoE_ClearRangeMap:
push {lr} 
ldr r0, =0x202E4E4 @ range map pointer 
ldr r0, [r0]
mov r1, #0
_blh FillMap
pop {r0}
bx r0 


.type AoE_EffectCreateRangeMap, %function 
.global AoE_EffectCreateRangeMap
AoE_EffectCreateRangeMap:
@ given XX and YY via action struct, construct a range mask around it? 
push {r4-r7, lr}
@ r2 = RangeMapPointer 

mov r5, r2 
bl AoE_ClearRangeMap

ldr r0, =CurrentUnit
ldr r4, [r0] 

ldr r3, =pActionStruct
ldrb r0, [r3, #0x13]  @@ XX 
ldrb r1, [r3, #0x14] @ YY 
@ Arguments: r0 = center X, r1 = center Y, r2 = pointer to template
mov r2, r5 
bl CreateRangeMapFromTemplate

pop {r4-r7}
pop {r0} 
bx r0 



@ given a range mask, do stuff to all units in range? 
.global AoE_DamageUnitsInRange
.type AoE_DamageUnitsInRange, %function 
AoE_DamageUnitsInRange:
push {r4-r7, lr} 

@ given r0 unit found in range, damage them 


mov r7, r0 @ target 
ldr r6, =CurrentUnit 
ldr r6, [r6] @ actor 
ldr r5, =AoE_RamAddress
ldrb r5, [r5] @ Ram address of previously stored effect index 

mov r0, r5 @ effect index 
mov r1, r6 @ attacker 
mov r2, r7 @ target 
@r0 = effect index
@r1 = attacker / current unit ram 
@r2 = current target unit ram
bl AoE_RegularDamage @ Returns damage to deal 


ldrb r1, [r7, #0x13] 
sub r0, r1, r0 

cmp r0, #0 
bgt NoCapHP
mov r0, #1 
NoCapHP:
strb r0, [r7, #0x13] 


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

