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



.global AoE_ClearBG2
.type AoE_ClearBG2, %function 
AoE_ClearBG2:
push {lr}



ldr r2, =0x2023ca8 @gBg2MapBuffer
ldr r3, =0x20244a8 @gBg3MapBuffer
mov r0, #0 

Loop:
str r0, [r2] 
add r2, #4 
cmp r2, r3 
blt Loop 



ldr r2, =0x02024cb0 @gBg2MapTarget
ldr r2, [r2] 
mov r3, #0x8 
lsl r3, #8 @ 0x800 bytes for this? 
add r3, r2 

Loop2:
str r0, [r2] 
add r2, #4 
cmp r2, r3 
blt Loop2



pop {r0}
bx r0 

	.equ pr6C_New, 0x08002C7C
.global AoE_Setup 
.type AoE_Setup, %function 

AoE_Setup:

push {r4-r7, lr} 

ldr r4, =CurrentUnit
ldr r4, [r4] 

bl AoE_GetTableEntryPointer
mov r5, r0 
ldrb r0, [r5, #19] @ Heal or dmg 
ldr r3, =AoE_FreeSelect @ Proc list 
cmp r0, #1 
bne Start_FreeSelect
ldr r3, =AoE_HealFreeSelect @ For green tiles 

Start_FreeSelect:
@parameters
	@r0 = char pointer
	@r1 = pointer range builder function
	@r3 = pointer list for proc
mov r0, r4 @ CurrentUnit 
ldr r1, =AoE_RangeSetup


bl AoE_FSTargeting

@mov r0, #0x17	@makes the unit wait?? makes the menu disappear after command is selected??
mov r0,#0x94		@play beep sound & end menu on next frame & clear menu graphics

mov r0, #0xb7 

pop {r4-r7}
pop {r0} 
bx r0 

.global AoE_GenericEffect
.type AoE_GenericEffect, %function 
AoE_GenericEffect:
push {r4-r7, lr} 

bl AoE_GetTableEntryPointer
mov r4, r0 

add r0, #28
ldr r0, [r0] @ RangeTemplate for AoE
@ parameters: r0 = RangeMaskPointer 
bl AoE_EffectCreateRangeMap

ldr r0, =AoE_DamageUnitsInRange
blh 0x8024eac @ForEachUnitInRange @ maybe this calls AoE_DamageUnitsInRange for each unit found in the range mask? 


ldr r1, =CurrentUnitFateData	@these four lines copied from wait routine
mov r0, #0x1
strb r0, [r1,#0x11]



pop {r4-r7}
pop {r0} 
bx r0 

.global AoE_GetTableEntryPointer 
.type AoE_GetTableEntryPointer, %function 
AoE_GetTableEntryPointer:
push {lr} 
ldr r0, =AoE_RamAddress @ pointer 
ldr r0, [r0] @ actual address 
ldrb r0, [r0] @ Ram address of previously stored effect index 
ldr r3, =AoE_EntrySize 
ldrb r3, [r3] 
mul r3, r0 
ldr r0, =AoE_Table
add r0, r3 

pop {r1}
bx r1 


	.equ ProcFind, 0x08002E9C

.global AoE_EndTargetSelection
.type AoE_EndTargetSelection, %function 
AoE_EndTargetSelection:
push {lr} 

ldr r0, =0x85b655c @gProc_TargetSelection
blh ProcFind, r1 
cmp r0, #0 
beq ProcStateError 
@ takes Proc_TargetSelection's ram address in r0 
@struct Proc* EndTargetSelection(struct TargetSelectionProc*); //! FE8U = 0x804FAB9
blh 0x804fab8 @EndTargetSelection
ProcStateError:
pop {r0}
bx r0 


.equ ClearBG0BG1, 0x0804E884
.equ SetFont, 0x8003D38
.equ Font_ResetAllocation, 0x8003D20  
.equ EndAllMenus, 0x804EF20 

.global AoE_ClearGraphics
.type AoE_ClearGraphics, %function 
AoE_ClearGraphics:
push {lr} 
bl AoE_ClearRangeMap
blh 0x801dacc @HideMoveRangeGraphics
bl AoE_ClearBG2
blh 0x8019b18 @UpdateGameTileGfx

@blh ClearBG0BG1
@ copied from vanilla item 'use'
@mov r0, #0 
@blh SetFont 
@blh Font_ResetAllocation 
@blh EndAllMenus
@blh 0x801a1f4 @RefreshEntityMaps
@blh  0x08019c3c   @DrawTileGraphics

@blh 0x80271a0 @SMS_UpdateFromGameData

@bl AoE_EndTargetSelection 

pop {r0}
bx r0 


.global AoE_ClearRangeMap
.type AoE_ClearRangeMap, %function 

AoE_ClearRangeMap:
push {lr} 
ldr r0, =0x202E4E4 @ range map pointer 
ldr r0, [r0]
mov r1, #0
blh 0x80197E4 @MapFill


@ldr r0, =0x202E4E0 @ range map pointer 
@ldr r0, [r0]
@mov r1, #1
@neg r1, r1 
@blh 0x80197E4 @MapFill

pop {r0}
bx r0 


.type AoE_EffectCreateRangeMap, %function 
.global AoE_EffectCreateRangeMap
AoE_EffectCreateRangeMap:

push {r4-r7, lr}
@ r0 = RangeMapPointer 

mov r5, r0 
bl AoE_ClearRangeMap

ldr r0, =CurrentUnit
ldr r4, [r0] 

@ given XX and YY via action struct,
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
ldr r5, =AoE_RamAddress @pointer 
ldr r5, [r5] @ actual address 
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
push {r4, lr}
bl AoE_ClearRangeMap
bl AoE_GetTableEntryPointer
mov r4, r0 
ldr r3, =CurrentUnit
ldr r3, [r3] 
ldrb r0, [r3, #0x10] @ XX 
ldrb r1, [r3, #0x11] @ YY 
ldrb r2, [r4, #22] @ Min range 
ldrb r3, [r4, #23] @ Max range 
@ Arguments: r0 = x, r1 = y, r2 = min, r3 = max
blh CreateRangeMapFromRange, r4

pop {r4} 
pop {r3}
bx r3

.ltorg
.align

