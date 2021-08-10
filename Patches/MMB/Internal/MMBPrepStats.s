
.thumb

.include "../CommonDefinitions.inc"

MMBPrepStats:

	.global	MMBPrepStats
	.type	MMBPrepStats, %function

	@ Inputs:
	@ r0: Pointer to proc state
	@ r1: Pointer to unit in RAM

	cmp		r1, #0x00
	bne		Unit

	bx		lr

Unit:

	@ We only need to do this once

	mov		r2, r0
	add		r2, #BattleStructFlag
	ldrb	r3, [r2]
	cmp		r3, #0x00
	beq		WriteStruct

	bx		lr

WriteStruct:

	mov		r3, #0x01
	strb	r3, [r2]

	push	{r4, lr}

	@ save unit

	mov		r4, r1

	mov		r0, r1
	
	ldr		r1, =GetEquippedWeaponSlot
	mov		lr, r1
	bllr
	
	mov		r1, r0
	mov		r0, r4
	
	ldr		r2, =SetupBattleStructUnitWeapon
	mov		lr, r2
	bllr
	
	
	
	
	VeslyStuff:
	@ edit: I thought I needed to do this, but instead I needed to edit SpellSystemASM.s 
	@ in order to account for equipped wep slot 9 for the stat screen / mmb 
	
@0802a668 CopyUnitToBattleStructRawStats
@0802a6a0 .thumb

@0802a584 InitBattleUnitFromUnit
@0802a6a0 WriteBattleStructTerrainBonuses
@0802a6dc .thumb
@0802a6dc BattleSetupTerrainData
@0802a730 .thumb
@0802a730 SetupBattleWeaponData
@	mov 	r11, r11 
@
@	mov 	r1, r4 
@	ldr 	r0, =0x203A4EC @ BattleActor  
@	ldr 	r2, =0x802a584 @InitBattleUnitFromUnit
@	mov 	lr, r2
@	bllr 
@	
@	@ldr 	r1, =0x202D994 @ 62nd player unit.. ? so hopefully 0s 
@	@ldr 	r0, =0x203A56C @ Battle defender 
@	@ldr 	r2, =0x802a584 @InitBattleUnitFromUnit
@	@mov 	lr, r2
@	@bllr 
@	
@	
@	mov 	r0, r4 
@	ldr 	r1, =GetEquippedWeapon
@	mov 	lr, r1 
@	bllr 
@	
@	@ldr 	r0, =0xFF30
@	
@	ldr 	r2, =0x203A4EC @ BattleActor 
@	mov 	r1, #0x48 
@	strh 	r0, [r2, r1] @ Store in new weapon 
@	mov 	r1, #0x4A 
@	strh 	r0, [r2, r1] @ Store in new weapon 
@	
@	@ I can probably do this manually 
@	@ r0 attacker r1 defender 
@	@ populate defender with 0s 
@	@ then run the calcs 
@	
@	ldr 	r0, =0x203A4EC 
@	ldr 	r1, =0x203A56C @ Battle defender 
@	ldr 	r2, =0x0802a95c @FillPreBattleStats
@	mov 	lr, r2 
@	bllr 
@	
@	
@	ldr 	r0, =0x203A4EC 
@	ldr 	r1, =0x203A56C @ Battle defender 
@	ldr 	r2, =0x0802aabc @BattleLoadAttack
@	mov 	lr, r2 
@	bllr 
@	
	@ [0x203A546]!! @ Actor's attack 
	@ [0x203A534]!! @ Actor's wep
	@ [2026BC0..2026BCF]
	@ [2026BC0..2026BC6]! @ Skills + skill count 
	
	@mov 	r1, #0x5A
	@mov 	r0, #15 
	@strh 	r0, [r2, r1] 
	
	

	pop		{r4}
	pop		{r0}
	bx		r0

.ltorg

EALiterals:
	@ None
