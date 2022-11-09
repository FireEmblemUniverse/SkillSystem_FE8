.align 4
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.thumb

	.equ pBattleUnitInstiagator, 0x0203A4EC 
	.equ pBattleUnitTarget,      0x0203A56C
	
	.equ MemorySlot, 0x30004B8 
	.equ GetUnitByEventParameter, 0x0800BC51
	.equ prUnit_GetStruct,           0x08019430 @ arguments: r0 = Unit Allegience Index; returns: r0 = Unit Struct pointer (0 if not found)
	.equ RemoveUnitBlankItems,0x8017984
	.equ EventEngine, 0x800D07C
	.equ pExtraItemOrSkill, 0x0202BCDE
	.equ ReturnTMRam,			0x30017ba
	.equ pExtraItemOrSkill, 0x0202BCDE

.global CheckLearnNewSpellLevelUp
.type CheckLearnNewSpellLevelUp, function 

CheckLearnNewSpellLevelUp: 
push {r4-r5, lr} 
@ Arguments: r0 = parent proc 
mov r4, r0 


check_acting:
	ldr r0, =pBattleUnitInstiagator
	ldrb r1, [r0, #0x13] @ Current HP
	cmp r1, #0
	beq check_target @ Unit is ded
	mov r1, #0x70 @ Level before battle 
	ldrb r2, [r0, r1] 
	ldrb r1, [r0, #0x08] @ Current level 
	cmp r1, r2 
	beq check_target 
	
	ldrb r0, [r0, #0x0B] @ Unit Index
	mov r1, #0xC0
	tst r0, r1
	beq AlivePlayer @ not NPC nor Enemy

check_target:

	ldr r0, =pBattleUnitTarget
	ldrb r1, [r0, #0x13] @ Current HP
	cmp r1, #0
	beq Exit @ Unit is ded
	
	@ apparently snags want to learn moves too 
	ldr r1, [r0, #4] @ class table pointer 
	ldrb r1, [r1, #4] @ class id 
	ldr r2, =SnagID 
	lsl r2, #24 
	lsr r2, #24 
	cmp r1, r2 
	beq Exit 
	
	
	mov r1, #0x70 @ Level before battle 
	ldrb r2, [r0, r1] 
	ldrb r1, [r0, #0x08] @ Current level 
	cmp r1, r2 
	beq Exit 
	
	ldrb r0, [r0, #0x0B] @ Unit Index
	mov r1, #0xC0
	tst r0, r1
	bne Exit @ NPC or Enemy

AlivePlayer:
	blh prUnit_GetStruct
	mov r5, r0 

	ldr r1, [r5] @ unit pointer 
	ldrb r1, [r1, #4] @ unit ID 
	mov r2, #0x46 
	cmp r1, r2 
	bge Exit @ unit ID is 0x46 or greater, so they cannot learn spells by level up 
	
	
	ldr r3, =ReturnTMRam
	mov r1, #0 
	strb r1, [r3] @ Do not return TM when 'no' is selected 
	
	ldr r1, [r5, #4] @ Class pointer 
	ldrb r1, [r1, #4] @ Class ID 
	lsl r1, #2 @ 4 bytes per entry in table as it's a bunch of POINs
	
	ldr r3, =MoveListTable @ A bunch of POINs
	ldr r3, [r3, r1] @ Class ID entry 
	cmp r3, #0 
	beq Exit @ no poin error, so exit 
	mov r2, #0 @ Counter 
	
	ldrb r0, [r5, #0x08] @ Unit's level 
	MoveToLearnLoop:
	ldrh r1, [r3, r2] 
	cmp r1, #0 @ Learning move '--' at level 0 terminates the list 
	beq Exit 
	ldrb r1, [r3, r2] 
	cmp r1, r0 
	beq LearnMove @ Required level is the same as your current level 
	add r2, #2 @ Level, Move as 2 bytes per entry 
	b MoveToLearnLoop
	
	
	LearnMove:
	add r2, #1 
	ldrb r1, [r3, r2] @ Move to learn 
	@mov r1, #0
	@mov r1, #0x35 @ Ember 
	@ Arguments: r0 = Unit, r1 = Spell Index, r2 = Parent proc
	@ Returns:   r0 = proc (if you really need it)
mov r2, r4 @ Parent proc 
mov r0, r5 
blh prLearnNewSpell



Exit:
	@mov r1, #0
	@ldr r0, =pExtraItemOrSkill
	@strh r1, [r0] @ Set to 0 
	
mov r0, r4 @ Parent proc 
pop {r4-r5}

pop {r1}
bx r1 
.ltorg 
