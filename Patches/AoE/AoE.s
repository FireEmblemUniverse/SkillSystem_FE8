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
  .equ CheckEventId,0x8083da8
	.equ CurrentUnitFateData, 0x203A958
	


	
.global AoE_Usability 
.type AoE_Usability, %function 

AoE_Usability:
push {r4-r5, lr} 
@ given r0 = specific AoE table entry we want 
mov r4, r0 

ldrb r0, [r4, #17] @ Stationary bool 
cmp r0, #0 
beq SkipStationaryCheck
ldr r3, =pActionStruct 
ldrb r0, [r3, #0x10] @ squares moved this turn 
cmp r0, #0 
bne ReturnFalse 


SkipStationaryCheck: 
ldr r3, =CurrentUnit 
ldr r5, [r3] @ unit struct ram pointer 


ldr r1, [r4] @ Additional routine ? 
cmp r1, #0 
beq SkipAdditionalUsabilityRoutine 
@r0 is still our specific effect index
mov lr, r1
.short 0xF800

cmp r0, #0 
beq ReturnFalse

SkipAdditionalUsabilityRoutine:


ldrb r0, [r4, #4] @ Unit ID 
cmp r0, #0x00 
beq ValidUnit
ldr r1, [r5] @ Char 
ldrb r1, [r1, #4] @ unit id 
cmp r0, r1 
bne ReturnFalse

ValidUnit:

ldrb r0, [r4, #5] @ class 
cmp r0, #0 
beq ValidClass
ldr r1, [r5, #4] @ class 
ldrb r1, [r1, #4] @ class id 
cmp r0, r1 
bne ReturnFalse

ValidClass:

@ check lvl 
ldrb r0, [r4, #6] 
cmp r0, #0 
beq ValidLevel
ldrb r1, [r5, #8] @ level ? 
cmp r0, r1 
bgt ReturnFalse

ValidLevel:
ldrb r0, [r4, #7]
cmp r0, #0 
beq ValidFlag
blh CheckEventId
cmp r0, #1 
bne ReturnFalse

ValidFlag:
ldrb r0, [r4, #8] @ Req Item 
cmp r0, #0 
beq ValidItem
mov r1, #0x1C 
InventoryLoop: 
add r1, #2 
cmp r1, #0x28 
bge ReturnFalse
ldrb r2, [r5, r1] 
cmp r2, #0 
beq ReturnFalse
cmp r2, r0 
bne InventoryLoop
@ They have said item, so continue
ValidItem:


ReturnTrue: 
mov r0, #1 
b Finish_Usability 


ReturnFalse: 
mov r0, #3 


Finish_Usability: 
pop {r4-r5}
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


@ 801d624 PlayerPhase_DisplayUnitMovement
@ 801d6fc PlayerPhase_ReloadGameGfx
@ 801d9dc Loop6C_MoveLimitView
@0801d89c Load6CRangeDisplaySquareGfx
@0801d92c Setup6CRangeDisplayGfx
@801da98 DisplayMoveRangeGraphics

.global AoE_DisplayDamageArea
.type AoE_DisplayDamageArea, %function 

AoE_DisplayDamageArea:

push {r4-r7, lr} 

@given r0 = xx, r1 = yy, display movement squares in a template around it 
mov r4, r0 
mov r5, r1 




ldr r0, =0x202E4E0
ldr r0, [r0] 
mov r1, #0xFF
blh FillMap

bl AoE_GetTableEntryPointer
ldr r2, [r0, #28]

@ Arguments: r0 = center X, r1 = center Y, r2 = pointer to template
ldr r3, =pActionStruct 
mov r0, r4 @ XX 
mov r1, r5  @ YY 
bl CreateMoveMapFromTemplate


mov r0, #0x20 @ purple ? - only works for range map 
mov r0, #0x40
blh 0x801da98 @DisplayMoveRangeGraphics
@ 801DAC0


pop {r4-r7}
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


pop {r4-r7}
pop {r0} 
bx r0 

.global AoE_GenericEffect
.type AoE_GenericEffect, %function 
AoE_GenericEffect:
push {r4, lr} 

bl AoE_GetTableEntryPointer
mov r4, r0 

add r0, #28
ldr r0, [r0] @ RangeTemplate for AoE
@ parameters: r0 = RangeMaskPointer 
bl AoE_EffectCreateRangeMap

ldrb r0, [r4, #8] 
cmp r0, #0 
beq DoNotDepleteItem
ldrb r0, [r4, #16]
cmp r0, #1 
bne DoNotDepleteItem
mov r0, r4 
bl AoE_DepleteItem
DoNotDepleteItem: 

ldrb r0, [r4, #18] @ Hp Cost 
cmp r0, #0 
beq SkipHpCost 

ldr r3, =CurrentUnit 
ldr r3, [r3] 
ldrb r1, [r3, #0x13] 
cmp r1, r0 
bgt NoCapHpCost
mov r0, r1 
sub r0, #1 @ deal damage equal to current hp - 1 
NoCapHpCost:
sub r1, r0 
strb r1, [r3, #0x13] @ hp 


SkipHpCost: 
ldrb r0, [r4, #19] @ Heal Bool 
cmp r0, #1 
bne DamageUnits
ldr r0, =AoE_HealUnitsInRange

b Start_ForEachUnitInRange
DamageUnits: 
ldr r0, =AoE_DamageUnitsInRange
Start_ForEachUnitInRange:
blh 0x8024eac @ForEachUnitInRange @ maybe this calls AoE_DamageUnitsInRange for each unit found in the range mask? 


ldr r1, =CurrentUnitFateData	@these four lines copied from wait routine
mov r0, #0x1
strb r0, [r1,#0x11]



pop {r4}
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
@ this would probably be better to use if we encounter bugs 
@ 801d6fc PlayerPhase_ReloadGameGfx
@ but it also clears our menu 



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


.type AoE_DepleteItem, %function 
.global AoE_DepleteItem
AoE_DepleteItem:

push {r4-r6, lr}
@ r0 = table entry 

mov r4, r0  


ldr r0, =CurrentUnit
ldr r5, [r0] 

ldrb r0, [r4, #8] @ Req Item 
cmp r0, #0 
beq Done_DepleteItem
mov r1, #0x1C 
InventoryLoop_DepleteItem: 
add r1, #2 
cmp r1, #0x28 
bge Done_DepleteItem
ldrb r2, [r5, r1] 
cmp r2, #0 
beq Done_DepleteItem
cmp r2, r0 
bne InventoryLoop_DepleteItem
ldrh r0, [r5, r1] 
mov r6, r1 
blh 0x8016aec @GetItemAfterUse
strh r0, [r5, r6] 
cmp r0, #0 
bne Done_DepleteItem
mov r0, r5 
blh 0x8017984 @RemoveUnitBlankItems

Done_DepleteItem:

pop {r4-r6}
pop {r0} 
bx r0 


@ hp cost 
@ wexp/item type req ?





@ given a range mask, do stuff to all units in range? 
.global AoE_DamageUnitsInRange
.type AoE_DamageUnitsInRange, %function 
AoE_DamageUnitsInRange:
push {r4-r7, lr} 

@ given r0 unit found in range, damage them 


mov r7, r0 @ target 
ldr r6, =CurrentUnit 
ldr r6, [r6] @ actor 

bl AoE_GetTableEntryPointer
mov r5, r0 @ table effect address 

ldrb r1, [r5, #12] @ Friendly fire bool 
cmp r1, #1 
beq AlwaysDamage @ If friendly fire is on, then we heal regardless of allegiance 
mov r2, #0x0B 
ldsb r0, [r6, r2] 
ldsb r1, [r7, r2] 
blh 0x8024d8c @AreAllegiancesAllied
cmp r0, #1 
beq DoNotDamageTarget

AlwaysDamage: 
ldrb r1, [r5, #13] 
cmp r1, #0 
bne DoFixedDmg


mov r0, r5 @ table effect address 
mov r1, r6 @ attacker 
mov r2, r7 @ target 
@r0 = effect index
@r1 = attacker / current unit ram 
@r2 = current target unit ram
bl AoE_RegularDamage @ Returns damage to deal 
b CleanupDamage 

DoFixedDmg: 
mov r0, r5 
mov r1, r6 
mov r2, r7 
bl AoE_FixedDamage 


CleanupDamage:

ldrb r1, [r7, #0x13] 
sub r0, r1, r0 

cmp r0, #0 
bgt NoCapHP
mov r0, #1 
NoCapHP:
strb r0, [r7, #0x13] 

DoNotDamageTarget:

pop {r4-r7}
pop {r0}
bx r0 


.global AoE_HealUnitsInRange
.type AoE_HealUnitsInRange, %function 
AoE_HealUnitsInRange:
push {r4-r7, lr} 

@ given r0 unit found in range, heal them 


mov r7, r0 @ target 
ldr r6, =CurrentUnit 
ldr r6, [r6] @ actor 

bl AoE_GetTableEntryPointer
mov r5, r0 @ table effect address 
ldrb r1, [r5, #12] @ Friendly fire bool 
cmp r1, #1 
beq AlwaysHeal @ If friendly fire is on, then we heal regardless of allegiance 
mov r2, #0x0B 
ldsb r0, [r6, r2] 
ldsb r1, [r7, r2] 
blh 0x8024d8c @AreAllegiancesAllied
cmp r0, #0 
beq DoNotHealTarget


AlwaysHeal:
mov r0, r5 
mov r1, r6 
mov r2, r7 
@r0 = effect index
@r1 = attacker / current unit ram 
@r2 = current target unit ram
bl AoE_FixedDamage 


CleanupHealing:

ldrb r1, [r7, #0x13] 
add r0, r1, r0 
ldrb r1, [r7, #0x12] @ Max HP 
cmp r0, r1
ble NoCapHP_Healing
mov r0, r1 @ Healed to full 
NoCapHP_Healing:
strb r0, [r7, #0x13] 

DoNotHealTarget:

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

