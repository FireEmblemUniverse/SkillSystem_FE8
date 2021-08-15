
.thumb

.macro blh to, reg
    ldr \reg, =\to
    mov lr, \reg
    .short 0xF800
.endm

.equ InitBattleUnitFromUnit, 0x0802A584
.equ ClearRounds, 0x0802AE90
.equ gpCurrentRound, 0x0203A608
.equ StartEFXHpBar, 0x8052304
.equ StartEFXHpBarLive, 0x08052a0c
.equ StartEFXStatusChange, 0x08055518
.equ LoadFlashBG, 0x08053f10

@ .include "MissRelated.s" @ Somewhat verbose functions associated with HP costs on miss. I could not get these to work. -Snek

.global SetUpBattleWeaponDataHack
.type SetUpBattleWeaponDataHack, %function
SetUpBattleWeaponDataHack: @ Autohook to 0x0802A730. Creates case 9 for the switch (using a Gaiden Spell).
push { r4 - r7, lr }
mov r7, r9
mov r6, r8
push { r6, r7 }
mov r5, r0
mov r3, r1

CheckWeaponSlot:
push {r3} 
@mov r0, r5
blh GetUnitEquippedWeaponSlot, r1
pop {r3} 
cmp r0, #9 
beq OverwriteR3
mov r1, #0x1 	@ 
neg r1, r1  	@ These 4 lines were commented out for some reason by Snek 
cmp r3, r1		@ but they cause an AI bug where they always use their last inv wep 
bne EnemyExists @ so I uncommented them - Vesly 	
OverwriteR3:
mov r3, r0
EnemyExists:

ldr r0, [ r5, #0xC ]
mov r1, #0x80
lsl r1, r1, #0x4
and r0, r0, r1
cmp r0, #0x0
beq NotBallista
	mov r3, #0x8 @ 0x8 sets flag for ballista.
NotBallista:
mov r1, r5
add r1, #0x52
mov r0, #0x1
strb r0, [ r1 ]
mov r9, r1
cmp r3, #0x9
bhi NoWeapon	
	@ We've repointed this switch table to account for the spell menu case.
	lsl r0, r3, #0x02
	ldr r1, =SetUpBattleWeaponDataSwitchRepoint
	add r0, r0, r1
	ldr r0, [ r0 ]
	mov r15, r0
NoWeapon:
	@ This was a jump to FinalCase, but it seems the exact same as vanilla (with the exception of mov r0, #0xFF and mov r0, #0xFE, but that could be a typo?
	@ We're just gonna jump to vanilla.
	ldr r0, =#0x802A831
	bx r0

.ltorg

.global SetUpBattleWeaponDataForSpellMenu
.type SetUpBattleWeaponDataForSpellMenu, %function
SetUpBattleWeaponDataForSpellMenu: @ Called by entry 9 in SetUpBattleWeaponDataSwitchRepoint.
mov r4, r5
add r4, #0x51
mov r0, #0x09
strb r0, [ r4 ]
@ Now we need to think for a bit. If we're attacking, then we can trust SelectedSpell to contain the spell the player chose.
	@ If we're defending, we just need to select the first attack Gaiden Spell.
ldr r0, =gBattleTarget
cmp r0, r5
beq SpellMenuDefending
	ldr r1, =SelectedSpell
	ldrb r0, [ r1 ]
	b WriteSpell
SpellMenuDefending:
	@ r0 is already the defense struct, so...
	bl GetFirstAttackSpell
	cmp r0, #0x00
	beq SkipOrr @ If they don't have a spell to use, don't orr it with 0xFF00!
WriteSpell:
mov r2, #0xFF
lsl r2, r2, #8
orr r0, r0, r2 @ Max uses for this spell: 0xFF00|SelectedSpell.
SkipOrr:
mov r2, r5
add r2, r2, #0x48
mov r1, #0x1
strh r0, [ r2 ]
mov r0, r9
strb r1, [ r0 ] @ Set CanCounter.
mov r8, r4
mov r4, r2
ldr r1, =#0x802A84B
bx r1

.ltorg

.global GaidenActionStaffDoorChestUseItemHack
.type GaidenActionStaffDoorChestUseItemHack, %function
GaidenActionStaffDoorChestUseItemHack: @ Autohook to 0x0802FC48.
push { r4 - r7, lr }
mov r7, r8
push { r7 }
mov r6, r0
ldr r4, =gActionData
@ Now we need to check whether we're using the spell menu.
ldr r0, =UsingSpellMenu
ldrb r0, [ r0 ] @ Nonzero if we're using GaidenMagic.
cmp r0, #0x00
bne ActionFixUsingSpell
	ldr r0, [ r4, #0x0C ]
	blh GetUnit, r1
	ldrb r1, [ r4, #0x12 ]
	lsl r1, r1, #0x01
	add r0, r0, #0x1E
	add r0, r0, r1
	ldrh r0, [ r0 ]
	blh GetItemIndex, r1
	b EndActionFix
ActionFixUsingSpell:
	ldr r0, =SelectedSpell
	ldrb r0, [ r0 ]
EndActionFix:
ldr r1, =#0x0802FC63
bx r1

.ltorg
.global GaidenPreActionHack
.type GaidenPreActionHack, %function
GaidenPreActionHack: @ Autohook to 0x0801D1D0.
ldr r1, =UsingSpellMenu
ldrb r1, [ r1 ]
cmp r1, #0x00
bne PreActionFixUsingSpell
	ldrb r1, [ r4, #0x12 ]
	lsl r1, r1, #0x01
	add r0, r0, #0x1E
	add r0, r0, r1
	ldrh r0, [ r0 ]
	blh GetItemIndex, r1
	mov r2, r0
	b EndPreActionFix
PreActionFixUsingSpell:
	ldr r2, =SelectedSpell
	ldrb r2, [ r2 ]
EndPreActionFix:
ldr r0, =#0x0801D1E1
bx r0

.ltorg
.global GaidenSetupBattleUnitForStaffHack
.type GaidenSetupBattleUnitForStaffHack, %function
GaidenSetupBattleUnitForStaffHack: @ Autohook to 0x0802CB24.
push { r4 - r7, lr } @ r0 = unit, r1 = [gActionData+0x12] = inventory slot.
mov r7, r1
mov r1, r0
ldr r2, =gBattleStats
mov r4, #0x00
mov r0, #0x00
strh r0, [ r2 ]
ldr r5, =gBattleActor
mov r0, r5
blh InitBattleUnitFromUnit, r3 @ This call happens AFTER setting r6 normally, but this should be okay.
blh ClearRounds, r0 @ Clear rounds at the start of this routine instead of at the end.
mov r0, r5
ldr r1, =UsingSpellMenu
ldrb r1, [ r1 ]
cmp r1, #0x00
bne SetupBattleUnitForStaffUsingSpell
	lsl r1, r7, #0x01
	add r0, #0x1E
	add r0, r0, r1
	ldrh r6, [ r0 ]
	cmp r7, #0x00
	bge EndSetupBattleUnitForStaffFix
		mov r6, #0x00
	b EndSetupBattleUnitForStaffFix
SetupBattleUnitForStaffUsingSpell:
	ldr r6, =SelectedSpell
	ldrb r6, [ r6 ]
	mov r0, #0xFF
	lsl r0, r0, #8
	orr r6, r0, r6
	mov r0, #0x48
	strh r6, [ r5, r0 ] @ Store the selected spell halfword.
	@ Now let's try to set the HP cost. Rounds data doesn't work quite the same for staves...
	@ r5 has the battle unit already.
	/*mov r0, r6
	bl GetSpellCost
	@ Thanks Gamma for the logic here.
	ldrb r1, [ r5, #0x13 ] @ Current HP.
	sub r1, r1, r0
	strb r1, [ r5, #0x13 ] @ Store the reduced HP.
	@ HP cost should work for ALL staves now, but we can set HP drain and such in rounds data.
	@ If the staff uses rounds data, then it'll work. If not, no harm done. There's no HP bar animation needed anyway.
	ldr r1, =gpCurrentRound
	ldr r1, [ r1 ]
	mov r2, #0x05
	ldsb r3, [ r1, r2 ] @ Damage.
	sub r3, r3, r0
	strb r3, [ r1, r2 ] @ HP change.
	ldr r2, [ r1 ] @ I think this is an "attributes" bitfield.
	lsl r3, r2, #0x0D
	lsr r3, r3, #0x0D
	mov r0, #0x13
	lsl r0, r0, #0x08
	orr r3, r0, r3
	ldr r0, =#0xFFF80000
	and r0, r0, r2
	orr r0, r0, r3
	str r0, [ r1 ]*/
	mov r0, r5 @ Battle unit.
	ldr r1, =gpCurrentRound
	ldr r1, [ r1 ] @ Current round.
	bl SetRoundForSpell
EndSetupBattleUnitForStaffFix:
ldr r0, =#0x0802CB4B
bx r0

.ltorg

.global GaidenExecStandardHealHack
.type GaidenExecStandardHealHack, %function
GaidenExecStandardHealHack: @ Autohook to 0x0802EBB4.
ldrb r0, [ r4, #0x0C ]
blh GetUnit, r1
mov r5, r0
ldrb r0, [ r4, #0x0C ]
blh GetUnit, r1
ldr r1, =UsingSpellMenu
ldrb r1, [ r1 ]
cmp r1, #0x00
bne ExecStandardHealUsingSpell
	ldrb r1, [ r4, #0x12 ]
	lsl r1, r1, #0x01
	add r0, r0, #0x1E
	add r0, r0, r1
	ldrh r1, [ r0 ]
	b EndExecStandardHeal
ExecStandardHealUsingSpell:
ldr r1, =SelectedSpell
ldrb r1, [ r1 ]
EndExecStandardHeal:
ldr r0, =#0x0802EBCD
bx r0

.ltorg

.global GaidenExecFortifyHack
.type GaidenExecFortifyHack, %function
GaidenExecFortifyHack: @ Autohook to 0x0802F184.
ldrb r0, [ r4, #0x0C ]
blh GetUnit, r1
ldr r1, =UsingSpellMenu
ldrb r1, [ r1 ]
cmp r1, #0x00
bne ExecFortifyUsingSpell
	ldrb r1, [ r4, #0x12 ]
	lsl r1, r1, #0x01
	add r0, r0, #0x1E
	add r0, r0, r1
	ldrh r1, [ r0 ]
	b EndExecFortify
ExecFortifyUsingSpell:
ldr r1, =SelectedSpell
ldrb r1, [ r1 ]
EndExecFortify:
ldr r0, =#0x0802F195
bx r0

.ltorg

.global GaidenStaffInventoryHack
.type GaidenStaffInventoryHack, %function
GaidenStaffInventoryHack: @ Autohook to 0x0802CC80. Prevent staff use updating inventory.
ldr r0, =UsingSpellMenu
ldrb r0, [ r0 ]
cmp r0, #0x00
bne SkipStaffInventory
	@ Vanilla behavior.
	mov r5, r4
	add r5, r5, #0x48
	ldrh r0, [ r5 ]
	blh GetItemAttributes, r1
	mov r1, #0x04
	and r1, r0, r1
	cmp r1, #0x00
	beq StaffInventoryDecItem
		mov r1, r4
		add r1, r1, #0x7D
		mov r0, #0x01
		strb r0, [ r1 ]
		ldrh r0, [ r5 ]
	StaffInventoryDecItem:
	ldr r1, =#0x0802CC9B
	bx r1
SkipStaffInventory:
ldr r0, =#0x0802CCB3
bx r0

.ltorg
.global GaidenTargetSelectionBPressHack
.type GaidenTargetSelectionBPressHack, %function
GaidenTargetSelectionBPressHack: @ Autohook to 0x08022780. Unset spell variables when B pressing on target selection.
ldsb r1, [ r2, r1 ]
ldrb r2, [ r2, #0x11 ]
lsl r2, r2, #0x18
asr r2, r2, #0x18
blh EnsureCameraOntoPosition, r3
bl GaidenZeroOutSpellVariables
mov r0, #0x19
pop { r1 }
bx r1

.ltorg

.global GaidenTargetSelectionCamWaitBPressHack
.type GaidenTargetSelectionCamWaitBPressHack, %function
GaidenTargetSelectionCamWaitBPressHack: @ Autohook to 0x08022844. Same as before but with a different function.
blh Text_ResetTileAllocation, r0
ldr r0, =gProc_GoBackToUnitMenu
mov r1, #0x03
blh ProcStart, r2
bl GaidenZeroOutSpellVariables
mov r0, #0x19
pop { r1 }
bx r1

.ltorg

.global GaidenMenuSpellCostHack
.type GaidenMenuSpellCostHack, %function
GaidenMenuSpellCostHack: @ Autohook to 0x08016884. Same as below but hooked in a different spot to avoid a new hook conflict.
/*ldr r1, =UsingSpellMenu @ Autohook to 0x080168A0. Replace the parameters to DrawUiNumberOrDoubleDashes to show spell cost instead of durability in the spell menu.
ldrb r1, [ r1 ]
cmp r1, #0x00
bne SpellMenuCostUsingSpell
	@ Vanilla behavior.
	ldr r0, [ r4, #0x08 ]
	mov r1, #0x08
	and r0, r0, r1
	asr r2, r6, #0x08
	cmp r0, #0x00
	beq EndSpellMenuCost
		mov r2, #0xFF @ I think this is read to show --.
	b EndSpellMenuCost
SpellMenuCostUsingSpell:
	@ We're using a Gaiden spell. Place the spell cost in r2.
	@ r3 is NOT free here.
	mov r5, r3 @ r5 is free for the moment.
	lsl r0, r6, #0x18 @ The spell halfword is in r6.
	lsr r0, r0, #0x18 @ Clear durability.
	bl GetSpellCost
	mov r2, r0
	mov r3, r5
EndSpellMenuCost:
mov r5, #0x02
ldr r0, =#0x080168B1
bx r0*/
mov r1, r0
mov r0, r5
blh Text_DrawString, r2
add r1, r7, #0x04
mov r0, r5
blh Text_Display, r2
@ Everything above this is unrelated vanilla behavior. Now we need to check if we're using the spell menu.
ldr r0, =UsingSpellMenu
ldrb r0, [ r0 ]
cmp r0, #0x00
beq MenuSpellCostHackJumpRightBack
	@ We ARE using the spell menu. Prepare parameters for the call to DrawUiNumberOrDoubleDashes. r6 has the spell halfword.
	lsl r0, r6, #0x18
	lsr r0, r0, #0x18
	bl GetSpellCost
	mov r2, r0 @ The spell cost needs to be the r2 parameter.
	mov r0, r7
	add r0, r0, #0x16
	mov r5, #0x01
	mov r1, r8
	cmp r1, #0x00
	beq MenuSpellCostHackDontChangeColor
		mov r5, #0x02
	MenuSpellCostHackDontChangeColor:
	mov r1, r5
	ldr r3, =#0x080168B5
	bx r3
MenuSpellCostHackJumpRightBack:
ldr r0, =0x08016895
bx r0

.ltorg
/*
@ Note from Snek: The following two functions are intended to help support HP cost animations in battle with status staves, hammerne, and restore,
@	but neither I nor Gamma could get this to work. :(
.global SleepFix
.type SleepFix, %function
SleepFix: @ jumpToHacked at 0x08062768. Credit Gamma.
blh StartEFXHpBarLive, r3
mov r0, r5
blh StartEFXStatusChange, r3
ldrb r0, [ r4, #0x0 ]
cmp r0, #0x0
bne NotZero

IsZero:
ldr r0, =0x08062773
bx r0

NotZero:
ldr r0, =0x080627A7
bx r0

.ltorg

.global SilenceFix
.type SilenceFix, %function
SilenceFix: @ jumpToHacked at 0x080624D4. Credit Gamma.
blh StartEFXHpBarLive, r3
mov r0, r5
blh StartEFXStatusChange, r3
ldr r0, [ r4, #0x5C ]
mov r1, #0xA
blh LoadFlashBG, r3

ldr r0, =0x080624E1
bx r0
*/
.ltorg
